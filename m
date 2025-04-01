Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3191494DB
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533732; cv=none; b=o43Mb9aAzQjzgqpz9Hdc2wD1biJL4aN1+eAz/OSZ6/H3h78iA5yxNrzYy3n1C4vWPE5FVeCo56ffkQrg4KtRw0NoC7aa+k1y0DiUR3e6qPbEMYoblxyBSN5Qvj++wIpgZSfIAUrDdol05qnkFa5uZnKJVz7tDDgch77FGa86hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533732; c=relaxed/simple;
	bh=/DqQXbv8O/MLVJ2KMsdD/CTIpO4bOmfTXCOzZjiuJ44=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mc2FeaH+RmboyWxB2JzMlqQqUaX9jX4rV4Y36lvcR1NjwoJnEdEeG+S4jYN7Jrw6ZrMTgxPdaRD3/AgCjcUK48O7WKD6M2p4Ui6JB8hhUaHJpmMBVsK2t9b/sfw7Pu8Prkj3I56s/S6cb0A6a1FPQtkYRVjnyXoqdU+mt6mNsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Sil7oQdE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Sil7oQdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743533723; x=1744138523;
	i=johannes.schindelin@gmx.de;
	bh=RQ3dtu90cus3I47CpDLMtD23mtwjdnomVMT0+kQVC8A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sil7oQdErxvicR6geO4gRv4XIwLV6mewj6hJOr7HiaPoWtyMO4nlq4/EzBT/CYMU
	 M393hprcnmL6bAKaIrwdZv9N+e5FwPU8LxxXdlcVsnLL3C/3habgvvzOJsnKHdDzd
	 S5FdjqeuDjVcar3DgeLwOEWBfGspScoWLijcHQ6zxFW0V4NZDBzNoMQ5k0wQXCYYk
	 xIYkF+qxhE/EmjBjvgJlXA91Hu2r5NI+aDEb6GptXZibl6zPwXAanb1SQCyhb1Lsn
	 oFlsi3naarLcAHBI4ILUoRcGc8FgPeAxgGmp60ccSTmeqdiVZGg3iuvYJAwi92uqo
	 eVB9TKJ40ynbGIqplQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1u1bEr3rxP-000Z6G; Tue, 01
 Apr 2025 20:55:22 +0200
Date: Tue, 1 Apr 2025 20:55:22 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 13/20] t: refactor tests depending on Perl for textconv
 scripts
In-Reply-To: <20250327-b4-pks-t-perlless-v3-13-b436de9da1b8@pks.im>
Message-ID: <9f477166-5667-a051-13d3-43d56a7a8ec1@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-13-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1264349400-1743533723=:31313"
X-Provags-ID: V03:K1:lYYIesqHa+g7eeokmD9LLz0GWcKlPWfC1XKohWqGZuG8T/lAn5r
 Lf4Zq6Fcl7URYNSumSv99+WfD2Y6o2F5+n2TS4/LkWVPeU7lLkcV/4Lb8ODDiEVWsYLOEcq
 2m/Jcq2snTMKF6MCuI4qmyhOcaYsOE7u9kDv6wpmVVi4PIM/MznAcB85YBCLHrHJSZkS7Ph
 VrsQ8qHZSZRU++TX65cEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJlacfZO6BQ=;Ib3jy6U32WatCR3FrJNviIeHkm6
 okwPzkCA0lC0aFfGqXNE8nG5dLLo4Cb/dcYeTz6HsANf/7XdXHIh/2mtge2VsXyuPP8Ho75T3
 3gdWU72Ts4UzVKwKVsnKEgS5w++g8tXOeo0RDRaJlOcm1/EbXSEeJyQu8AudzceabuLva3L/N
 /Rt9xzPfouI12BDP3mBqmzfdiAAx+6fwBNwp8BGA7fvwrJSkGhkhZLpcMdmVjYAAal/57Gt2w
 gbcsOrTzxgDRgARBxIjHd+lW+h8yKF4GwYRfeBD71l/Xczr3OUxDM9wqROvGZrpg+AUNHVCfY
 UM4b7cUn0OG7vEBtJbiZhoAdcVraY5wSNVyE9S8WTocDR9qPRQrr6qCX+ZAnLMiWzYuwIfkN/
 bxQiD4uFQ0eGbkfAvIbDgqkDT/c5AzeTcDEovzM8TT99RWeVcjkQGFQ9z8359cf0wN4qROin3
 JccyBZZYnmRr8apnXawdq/jNs+WFiGpX00opRK8Ln7AAYYax6XMZ2Qw/vQE8zJws0JICmzIiC
 BKRGWXnpLMnCh1xRPOqPN+hd+u/eb7O97ubDaZcj7tfWaXESwQDy03iKFDE17rcPdLPQizci8
 CPaVkArk8iuM43mF0Huk9qGlMYhQpZnWHxnIV3r9ceQhbiZypCX9Mp4XdyPVsMI9PU4wHFFjh
 LP/X60AGdoZ0Zdyp020zQY+S0DauEDtcDpXuokLOqDxQ6QBfo7EfvrWQz+aHiV9T3asDEiQB+
 aUPc2cIHJnpEzhf+B6zTVr3ZF+MbZFNTR0yRUCXQuprMPyCfCifbZYQFlkw6oHMjOFOIBjb1N
 pV6E8kmCuSinKkeEbNGz6+gTs3vNJo1ICbmHzsIgWytmMEa2XfE5XVlXlZsYIm/SaUFLRN838
 a/ItMeZUaS4oMw2tM2Gz2L0/knziPrLaWggYaBeWdMdzhzBTY0IIXYapQfHtLhguSjZiWorh+
 OJ2SAhCH3y0KmzzPRkChsl0WJRaVCisQOZa/CibAw0Mo3ByuH/m/q6D9JEDRbz+T1fot7wGpm
 iG2aOjTmP1xXWlDTlFo7NBWgwg2vvtPYxa5JXGgZSgMPtcuqtV1WIDcEp8qjo+v3Afu+LQl9n
 +Dqa9xpXAg4adzNL3PfyV4GBZVcrd5nUs/9c0o+unByg9VO2YaymHGGvvivr1m4Fmg0qzp8Q2
 dnXVZxG5cgJmAIFPu8zXNE8x9IxI9K40UnoQBfXGiY6eulNA/1uZ+936TuFMXTwUx72H6uNvw
 yj2Pa0jnc2bcVj89SSdZ+gwkywFdq6xFmOW03/qEQjp+6LcHAsm0QkqlT+MihP+SJJC/ghXlK
 uE6xoU2UYQhE4aUg9gAsWGLKEyKDU6+mVGsUC8BuKL7nxHGFZfMmSJgQZW6aCwfwYTDrQOf+9
 1xGq/E/ZCF7kcWdlOsxAU1BS0ZPoJl6i+bQlHMbtQLUxssaU9XBYTQD+BJPTHWWa86FxIy8ZI
 LK4o2nl/dCyLW+iGXAeSMegHjAeTmbTK6qD6T9oc4oj1Y35hc

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1264349400-1743533723=:31313
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> We have a couple of tests that depend on Perl for textconv scripts.
> Refactor these tests to instead be implemented via shell utilities so
> that we can drop a couple of PERL_TEST_HELPERS prerequisites.
>
> Note that not all of the conversions are a one-to-one equivalent to the
> previous textconv scripts. But that's not really needed in the first
> place: we only care that the textconv script does something, and that
> can be verified trivially without having a full-blown invocation of
> hexdump. So at times, the implementation of the textconv scripts is
> reduced to their bare minimum and the expectations of those tests are
> adapted accordingly.

Hmm. I am having a harder time with this patch than with the others. See
below.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4030-diff-textconv.sh       | 15 +++------------
>  t/t4031-diff-rewrite-binary.sh | 19 +++++++------------
>  t/t7815-grep-binary.sh         | 15 +++------------
>  3 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index c7d8eb12453..f904fc19f69 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -4,12 +4,6 @@ test_description=3D'diff.*.textconv tests'
>
>  . ./test-lib.sh
>
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all=3D'skipping diff textconv tests; Perl not available'
> -	test_done
> -fi
> -
>  find_diff() {
>  	sed '1,/^index /d' | sed '/^-- $/,$d'
>  }
> @@ -26,13 +20,10 @@ cat >expect.text <<'EOF'
>  +1
>  EOF
>
> -cat >hexdump <<'EOF'
> -#!/bin/sh
> -"$PERL_PATH" -e '$/ =3D undef; $_ =3D <>; s/./ord($&)/ge; print $_' < "=
$1"
> -EOF
> -chmod +x hexdump
> -
>  test_expect_success 'setup binary file with history' '
> +	write_script hexdump <<-\EOF &&
> +	tr "\000\001" "01" <"$1"
> +	EOF

So here the `hexdump` script is written, basically replacing NUL and SOH
with the digits zero and one, respectively. I wonder why the script does
not call `test-tool hexdump` instead? And I wonder even more why no test
case has to be adapted below this change in the same file. I _guess_ that
the reason is that the file named, creatively, "file" is initialized with
a NUL and a newline, committed, then a line is appended that contains SOH
and a newline, and then the test cases verify the hunk _headers_ only?

If using `test-tool hexdump <"$1"` would work here, too, I'd actually have
preferred that over the `tr` invocation, even if would still not be
recapitulating the functionality of that Perl script (which, contrary to
its name, seemed never to have output hexadecimal values...).

To be clear: I do not suggest to change the patch, I am merely puzzled why
the more obvious `test-tool hexdump <"$1"` was not used here?

>  	test_commit --printf one file "\\0\\n" &&
>  	test_commit --printf --append two file "\\01\\n"
>  '
> diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binar=
y.sh
> index cbe50b15772..15e012ccc7c 100755
> --- a/t/t4031-diff-rewrite-binary.sh
> +++ b/t/t4031-diff-rewrite-binary.sh
> @@ -57,24 +57,19 @@ test_expect_success 'diff --stat counts binary rewri=
te as 0 lines' '
>  	grep " rewrite file" diff
>  '
>
> -{
> -	echo "#!$SHELL_PATH"
> -	cat <<'EOF'
> -"$PERL_PATH" -e '$/ =3D undef; $_ =3D <>; s/./ord($&)/ge; print $_' < "=
$1"
> -EOF
> -} >dump
> -chmod +x dump
> -
>  test_expect_success 'setup textconv' '
> +	write_script dump <<-\EOF &&
> +	test-tool hexdump <"$1"
> +	EOF

So this looks much more like what I would have expected also in t4030,
and...

>  	echo file diff=3Dfoo >.gitattributes &&
>  	git config diff.foo.textconv "\"$(pwd)\""/dump
>  '
>
> -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' =
'
> +test_expect_success 'rewrite diff respects textconv' '
>  	git diff -B >diff &&
> -	grep "dissimilarity index" diff &&
> -	grep "^-61" diff &&
> -	grep "^-0" diff
> +	test_grep "dissimilarity index" diff &&
> +	test_grep "^-3d 0a 00" diff &&
> +	test_grep "^+3d 0a 01" diff
>  '

... the adjustment of the expectations is actually going above and beyond,
the original test was not half as stringent as the new test is.

The rest of the patch looks good to me.

Ciao,
Johannes

>
>  test_done
> diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
> index b2730d200c8..3bd91da9707 100755
> --- a/t/t7815-grep-binary.sh
> +++ b/t/t7815-grep-binary.sh
> @@ -4,12 +4,6 @@ test_description=3D'git grep in binary files'
>
>  . ./test-lib.sh
>
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all=3D'skipping grep binary tests; Perl not available'
> -	test_done
> -fi
> -
>  test_expect_success 'setup' "
>  	echo 'binaryQfileQm[*]cQ*=C3=A6Q=C3=B0' | q_to_nul >a &&
>  	git add a &&
> @@ -120,13 +114,10 @@ test_expect_success 'grep respects not-binary diff=
 attribute' '
>  	test_cmp expect actual
>  '
>
> -cat >nul_to_q_textconv <<'EOF'
> -#!/bin/sh
> -"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
> -EOF
> -chmod +x nul_to_q_textconv
> -
>  test_expect_success 'setup textconv filters' '
> +	write_script nul_to_q_textconv <<-\EOF &&
> +	tr "\000" "Q" <"$1"
> +	EOF
>  	echo a diff=3Dfoo >.gitattributes &&
>  	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
>  '
>
> --
> 2.49.0.472.ge94155a9ec.dirty
>
>

--8323328-1264349400-1743533723=:31313--
