Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6120FA98
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532007; cv=none; b=MDQEyEx8Gpas1wyRjKsAWcRpxj0cCSyHytatV7MbHhugoafoQIToSrcpJ8IqOhk3ZGZ8P6obCN1GU/FiC/Ej4ap94XkKa3bftD1q0NHdoST7t7Wob5p29nkr4OPSqiUMyqbZcWHjgrHzmplEe84T6PH3m0Uf2O1g/vFeUEUiM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532007; c=relaxed/simple;
	bh=mwbT1sCaa11ZLp6f6sRj4WhLPzyMmlbU+NK+YtLqiA4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k9NMO1XtsG/TX+LOuP/htPemkjs1Q14/biqUABi4wo1rfzUz2eHhZqwsK+O0hqwAkAVEobBa4pEZgJdFgVsciX/Kjoej+j0haQniRNJIcvXjMtiKV//I49NbxgK19GYFpKMlEN4FAeWbjpY3rGLJSB/qlZJVeY+azz3v5wnA6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=k8VOVNNV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="k8VOVNNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743531997; x=1744136797;
	i=johannes.schindelin@gmx.de;
	bh=bTGHrDTgs4l592IzlXI5pvqmSAQOxMV2061VaqGWLdw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k8VOVNNVWuTu4qijYB0Gvry2f2717j9kLBIklli+pInipi/a9JVMkbWtVJzEBJLZ
	 vyvTUsJxyaWw0TLS8R6vifEi1FMC/hCYirznYFM4pSDV9wRsfUQt44ku3ysZD6K4H
	 W2/oVrZpn/x/2DnQKfAiSzaWC4xrT07mnI88TjCNXzaN1/IyDFb5Pv6m9wjEHDq4d
	 soJCG8F7BKtdpuTeX3iZN0eR894l4tS5GSaOLNWBoEfX7EY1PUMwm9OzddLjNR8Ah
	 uawn4bw5LspFyyHnPiJ6IJgtK2LhQQV4eAnYGG5F0/LtUfhFBjm2LiWI7dD3sPn1F
	 LNmuF/U3XYsZVf0svg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1tFquy0cGn-00gvFz; Tue, 01
 Apr 2025 20:26:37 +0200
Date: Tue, 1 Apr 2025 20:26:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 06/20] t: introduce PERL_TEST_HELPERS prerequisite
In-Reply-To: <20250327-b4-pks-t-perlless-v3-6-b436de9da1b8@pks.im>
Message-ID: <ee5e082f-6ab5-b996-9a0d-f7e5192c01be@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-6-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <401f706c-202e-42ca-8e5f-08e64480ed57@gitforwindows.org>
X-Provags-ID: V03:K1:kHmmY3OyQxucllcvnMasZXHq19u+8IEWzO4ViDMNj1s1J7PaIKI
 cY6MMXz6k3yyfkbp/Hq5BYmEnwa/71nTIo26rB69OCU4xMaK/+6UQzz18BLnBt5ngycAgCZ
 fnmcEWaatRjKFi6X4Om4rltJHr+F3PjkaGccXcuP5k/spooOzoLjvjk8yg0POdtwt2sDZit
 BKiC5MctxPUbrxQ8ZT1Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mngbG16TpR4=;03AFjJQS5+MzaI36sBwSlWPVkmf
 bYV423fMyn8bRKrHw1QKp3kwGpduaA4JbzG8Q+dNY7JoS2Z4QTcinK5EVQ40Jyjf3ke77Pzv+
 af0hHyYWIuOZaAI2HfXQUYBDZjsMEeqcGWQ/x61fOwI/BMMJfCH8YJerjwCtkNwHILJ4ZVKKz
 ZviYo/cOL+bVjlyTgTk80gR4mFBTBKfEMJpOJR4XEFecF3UgicIaK236vdnAFjpErxFsvzGgJ
 RtlTS70VaxNdy0rAvHbF7ahN4/1Qidg2Iz5yW77xr26r8iY+AabcSrjZCVPqtgMliPShQjxtU
 G4Jm6Cl3l2Gs4JHOp97D+gu1A1eNKpi9A9p9fPk/8lhu1XRGCcg1KsiK4y0TpxT2usvDw2YLf
 hvBtdZO2XbIs/+w6zpwybGLXSu/ivdfOhiKgbZjjFS+Gk6xG+x+vWUZ5uKrNOqZXkeQeuvMxw
 Q7A9UgYGfPlWTyZvqye7yzjP31+gOzGzqryt8gn1ZEN1a9PxLX8Tdn/1YcoYsIex+YdKUP+/A
 FMK0EAlzSDFG+jjhLSBLYRxuLsH3f9kfhpX+tdC/R68a4rqhh12+a64qt6yIOfTJhiyNMHnlM
 Xk7hsVh/zyvf/jsd3kGDvNx7WmGVl9fuIRVajXfpCYW/DrhD9IfQbG4OO8ZgJ21HZyCHlgbbx
 Z4TreJnrtG+s3s310MIPE/6Z+EyZiTrojdgkkIPSE3L5Byd8hPUbghXbnT06frJXtQL9DVA+k
 inOwK/uRuf0+BeLYsPhN3SMtNe2drx4TuXPaNNY20TE8HmUMezMkwkHXXhVUUh88OVb7elh/G
 TZPxCNS0jryqGe58yzoPQDRoNbDVdqMh0XfNMMUN1lhBxyCVSdH3FUMk/sjievHsGQjOIZhLp
 gg2+FgT0HMAJ9cVEb0C8Dhk8hMNfq9lJ7TW2NDka8banY+GmO0GK9DBCAQTsY6jKq828mZ/2L
 JFGrcz+XBVJ9ywIlIsdhpLKVBZcmNdMpRZdSxQ9Xd9fJxEiJOtjlIk/jZSWl/y0rgtGo1//IS
 JHj3uyHPfU5MfuihRh7khmsvI4GBmmzAT5SszjmFu+SLfHfi7iyEWd9Us8Z8+XVK5n5JwBAHD
 Mft4Z/B3auqjeoNJPpsoPMTMs8ms0rNYUvXVGjZyDYa3C6aZ+344GwMM2a81ePynf98p/oqWB
 Pt4kX8rAIqzPQ2PiYxCc1M+B7WnPamqGW4R/tn9/vmJPfQ2SEeTbbGFoslTXWOCRT16yES5Tl
 Hu/aZj3ONeabeMUi0zMLOopmLmbT8Ju91fHd/g2SUylvO08GNBkplAxdDeGsNlPvmz9aOddCU
 rNTpnftMLxm9sYqF+WKofn98WQ5OK2VADzJDzW8Puk4Hy0aZwDCcfGmlHW6L+LjBqYfdIpn5i
 7VS78CsQzKR1BKQgfWp8fjHxpJC1Wj232UY5SUX+U7xl4yEv68MC90ZTGZxZFZ8lZH1eEcNxy
 rK27T3GpAYm1neIUFJPfiHMrqIy9Fe2u1M+bonLsBRxXHXJ84QIzCDmXjRwE2Xx3mRalMSEl1
 06tbjnnBcbZNOcM8BB2f7x8z+KfhAWaB7jnIdi5p
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> In the early days of Git, Perl was used quite prominently throughout the
> project. This has changed significantly as almost all of the executables
> we ship nowadays have eventually been rewritten in C. Only a handful of
> subsystems remain that require Perl:
>
>   - gitweb, a read-only web interface.
>
>   - A couple of scripts that allow importing repositories from GNU Arch,
>     CVS and Subversion.
>
>   - git-send-email(1), which can be used to send mails.

There is also `git request-pull` which is a _shell_ script that runs
`perl` to parse the output of `ls-remote`, and there is `git
filter-branch` (which was apparently not yet dropped?) that uses Perl if
the `--state-branch` option is in use.

>   - Our Perl bindings for Git.
>
>   - The netrc Git credential helper.
>
> None of these subsystems can really be considered to be part of the
> "core" of Git, and an installation without them is fully functional.
> It is more likely than not that an end user wouldn't even notice that
> any features are missing if those tools weren't installed. But while
> Perl nowadays very much is an optional dependency of Git, there is a
> significant limitation when Perl isn't available: developers cannot run
> our test suite.
>
> Preceding commits have started to lift this restriction by removing the
> strict dependency on Perl in many central parts of the test library. But
> there are still many tests that rely on small Perl helpers to do various
> different things.
>
> Introduce a new PERL_TEST_HELPERS prerequisite that guards all tests
> that require Perl. This prerequisite is explicitly different than the
> preexisting PERL prerequisite:
>
>   - PERL records whether or not features depending on the Perl
>     interpreter are built.
>
>   - PERL_TEST_HELPERS records whether or not a Perl interpreter is
>     available for our tests.
>
> By having these two separate prerequisites we can thus distinguish
> between tests that inherently depend on Perl because the underlying
> feature does, and those tests that depend on Perl because the test
> itself is using Perl.
>
> Adapt all tests to set the PERL_TEST_HELPERS prerequisite as needed.

The patch looks good, in particular when fetching the `b4/pks-t-perlless`
branch from https://gitlab.com/gitlab-org/git and inspecting 8fc639f99d9f
manually, as it is a rather large patch that is pretty much unreviewable
on a mailing list.

Using several write-only `sed` invocations, I identified that there are
only three hunks that are neither adding a stand-alone `PERL_TEST_HELPERS`
prereq nor adding a test preamble of this form:

	if ! test_have_prereq PERL_TEST_HELPERS
	then
		skip_all=3D'skipping <something>; Perl not available'
		test_done
	fi

Skipping to only the affected files, these three instances are:

> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index c91a62b77af..342d0423c92 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -177,7 +177,7 @@ test_expect_success GPGSSH 'ssh signed push sends pu=
sh certificate' '
>  	test_cmp expect dst/push-cert-status
>  '
>
> -test_expect_success GPG 'inconsistent push options in signed push not a=
llowed' '
> +test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in=
 signed push not allowed' '
>  	# First, invoke receive-pack with dummy input to obtain its preamble.
>  	prepare_dst &&
>  	git -C dst config receive.certnonceseed sekrit &&

Here, that prereq is appended.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index d0c18660e33..d743d986c40 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -649,7 +649,7 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a u=
sable pack' '
>  	git -C replay.git index-pack -v --stdin <tmp.pack
>  '
>
> -test_expect_success 'clone on case-insensitive fs' '
> +test_expect_success PERL_TEST_HELPERS 'clone on case-insensitive fs' '
>  	git init icasefs &&
>  	(
>  		cd icasefs &&
> @@ -662,7 +662,7 @@ test_expect_success 'clone on case-insensitive fs' '
>  	)
>  '
>
> -test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
> +test_expect_success PERL_TEST_HELPERS,CASE_INSENSITIVE_FS 'colliding fi=
le detection' '
>  	grep X icasefs/warning &&
>  	grep x icasefs/warning &&
>  	test_grep "the following paths have collided" icasefs/warning

Here, too.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a62699d6c79..59162a3c834 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1706,6 +1706,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE=
2
>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
>  test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
>  test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
> +test -n "$PERL_PATH" && test_set_prereq PERL_TEST_HELPERS
>
>  if test -z "$GIT_TEST_CHECK_CACHE_TREE"
>  then

And this is obviously correct, too.

Thank you,
Johannes

