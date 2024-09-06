Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA03B1A2
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607437; cv=none; b=HHeUJGInwMFn6lnUK70KLXIUprRadNyei2BmzCnuZu+/nMc8+KbHFkccQpGvAS4rJOl67w0IHsxR5mqSJaZAF5vWo8+YMmdEb6wGCmpuTiXcDn3jTAyw2vY3K0yZXoHr+JaHic+r7a+tsfNsO2K2eS5t1vWkqetnHu1BwuqfCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607437; c=relaxed/simple;
	bh=eoRYizQ7Sd3oMXucfHGtxUMSel6VzeJE+43Csuna4cw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QsTmXZGhaA/eEqcbBBG72FMuAFZqjDTd733nl4jD9csohxRuIlthqwbMa1EX892p/3RNEy9BabSVzzBEqwV2/Pb61QYhm94nO+i9rLQfJC+YC7OPZPc96VEeZ+2sV5tf+g+wENH6aNO3gSHA+/6FMPi37IzythQCmGkk6+TRmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=S++5vOPu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="S++5vOPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725607429; x=1726212229;
	i=johannes.schindelin@gmx.de;
	bh=Gz9VD4vkKQ6PeOByXMbXEdzHHoMCK1LckkxRcMQxj/A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S++5vOPu9BpYEYDgSMH7w8TQQ5ouC2CgumkIR5KNPeX3My3sGoguoMugMXQZZM0m
	 p/xGYxDNFw4Fw5ebsJs8hTh0S4Ja50e8uyPcFQcYI94gz0prTh6Wn0TrOFlW2aHcV
	 XzOA1Z3NZaZR4H1PPOeEvAljIxMNlE8uysCWiIS4CJQz7treIlwpc3EGlxnvI5dpz
	 96Fl6oppguTnKJpUg7S62+1QbF/r9Mu2u5EbwvJaViupWO51B0IeDjq1vnUtqL3iP
	 IJ9rC/dk2W8qCKrdyxy9bkQgjUqgvgUPxKd7yYR1Z5Ha5SV8Iq/ntkJPmNoazaoSI
	 YiUyhBC2ZFRbfMh54Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1so5tf2eZm-006UdD; Fri, 06
 Sep 2024 09:23:49 +0200
Date: Fri, 6 Sep 2024 09:23:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>, 
    Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] scalar: add --no-tags option
In-Reply-To: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
Message-ID: <58ca5257-2e56-830c-c85f-79e4c9e80858@gmx.de>
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V6zWd10NerNo71MDxmpQktgavlxFtkg7YVcrSXIs2YZfcBIY334
 8/9rTPIxtW2tCmuVPC4UzsWeG1Hn+Fk6zH7OiTZw8QHG/vEPuf9F+X+pHus6cAYMleaBIHL
 QS3mB7sTA4Cok3GnpgG+ofU0HGQCUhXotEIu7IvsAckco1oMtGQ3PHpb0lWx2qmnpG0EBss
 DB6wBM1h/Qbg++IbrTs5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W6FVy/5JpVE=;9MkvnD5rlwOP/hAeOjVOOdOqurc
 3DW4g/bFSQkAd8tT0XjNw6cbgUvNUOVuOo82e8qSth8NXZkDRNzNJ7joDCn6PTI+z7MSFRVtM
 VRMblRzQ/x6+vSBsQUhKsm6l0us8pFDF9qOCppq/WN4Pxfob0+7bpWAk3vgDb2lIn8qujvByy
 eCSCXwyI4UqbB+k53AwZv/DPW8H58DUzIlooNg4r4tmVBoAeaONhgVQl3imftPfLjjJ5QpibQ
 ptrptNNYE5+YYj+3DyQCCnhZ5RtSQYPhmAvXumLRMr9nzmmzu7lKvNfWskrEaHCD15FaOJU83
 UZ0/oWx0GvOhjqYrVYwqGOoqPDUWheUIyaiwzPD/h5/upj39lNhzWU5Fj6HNUZsyDMwbgr8wa
 j++uGvKKH3hLLlp+DcxzpsFAAIghdFgtx104FZbQvSSVC3hlJihMno1Zg0RTvzBQOHAUczmeD
 zbeiJI624LJ4k+3QxehNSItccPmSy2uOB5YetQ18FeqC7Xv667e0EsNjO6AasA341fMkWDiAR
 DnkHcpNbD5PtDk41f4x0zChGb18/CS747N+hbn/P3adUgc7pHA68yIF2acAaXxBcobYKsntB2
 95OiDbtHcafxHScduR+WIRapaJd+DC0F0VpIjJgsW7cgikgCK4sgnja2SpRuRYn5HE/Bbd1TB
 74oNUmSoh6t+1ufqc4FNcUTlJNdT8yKnVqbMxS46yJ/OM/qeyC0JWwCxI3nfMVrbhV/jlKGMq
 TI+6AH4ZwCV1rTCHIZwyMj+VWpZEU8c1rzEtJ4sB79/f3aIYVvHhXKeLQRKkcK365WAirsxDn
 KQr6C6GXAY2Hks9l7umAHAdA==
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

the patch makes sense to me. The commit message is delightfully thorough.
I'll just offer minor suggestions below:

On Thu, 5 Sep 2024, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
>
> Some large repositories use tags to track a huge list of release
> versions. While this is choice is costly on the ref advertisement, it is

	s/is \(choice is\)/\1/

> further wasteful for clients who do not need those tags. Allow clients
> to optionally skip the tag advertisement.
>
> [...]
> diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
> index 361f51a6473..507ed2ae669 100644
> --- a/Documentation/scalar.txt
> +++ b/Documentation/scalar.txt
> @@ -86,6 +86,12 @@ cloning. If the HEAD at the remote did not point at a=
ny branch when
>  	`<entlistment>/src` directory. Use `--no-src` to place the cloned
>  	repository directly in the `<enlistment>` directory.
>
> +--[no-]tags::
> +	By default, `scalar clone` will fetch the tag objects advertised by
> +	the remote and future `git fetch` commands will do the same. Use

It might be helpful to mention that `git fetch --tags` can be used to
override this when the need arises.

> +	`--no-tags` to avoid fetching tags in `scalar clone` and to configure
> +	the repository to avoid fetching tags in the future.
> +
>  --[no-]full-clone::
>  	A sparse-checkout is initialized by default. This behavior can be
>  	turned off via `--full-clone`.
> diff --git a/scalar.c b/scalar.c
> index 6166a8dd4c8..c6dd746b5b2 100644
> --- a/scalar.c
> +++ b/scalar.c
> [...]
> @@ -513,7 +520,9 @@ static int cmd_clone(int argc, const char **argv)
>
>  	if ((res =3D run_git("fetch", "--quiet",
>  				show_progress ? "--progress" : "--no-progress",
> -				"origin", NULL))) {
> +				"origin",
> +				(!tags ? "--no-tags" : NULL),

I find double negatives challenging, and would prefer this instead:

				tags ? NULL : "--no-tags",

> +				NULL))) {
>  		warning(_("partial clone failed; attempting full clone"));
>
>  		if (set_config("remote.origin.promisor") ||
> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index a41b4fcc085..e8613990e13 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -169,6 +169,24 @@ test_expect_success 'scalar clone' '
>  	)
>  '
>
> +test_expect_success 'scalar clone --no-... opts' '
> +	# Note: redirect stderr always to avoid having a verbose test
> +	# run result in a difference in the --[no-]progress option.
> +	GIT_TRACE2_EVENT=3D"$(pwd)/no-opt-trace" scalar clone \
> +		--no-tags --no-src \
> +		"file://$(pwd)" no-opts --single-branch 2>/dev/null &&
> +
> +	test_subcommand git fetch --quiet --no-progress \
> +			origin --no-tags <no-opt-trace &&
> +	(
> +		cd no-opts &&
> +
> +		test_cmp_config --no-tags remote.origin.tagopt &&
> +		git for-each-ref --format=3D"%(refname)" refs/tags/ >tags &&
> +		test_line_count =3D 0 tags
> +	)

For readability (and to avoid an unnecessary subshell), this could be
written as:

	test_cmp_config -C no-opts --no-tags remote.origin.tagopt &&
	git -C no-opts for-each-ref --format=3D"%(refname)" refs/tags/ >tags &&
	test_line_count =3D 0 tags

> +'
> +
>  test_expect_success 'scalar reconfigure' '
>  	git init one/src &&
>  	scalar register one &&

None of these suggestions, in isolation or in conjunction, seem big enough
to me to warrant a new iteration; I just offer them here in case you want
to iterate on the patch. If you want to keep the patch as-is, I am totally
on board with that.

Ciao,
Johannes
