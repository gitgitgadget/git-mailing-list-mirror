Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81BC433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF704206D5
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Hv7RZNBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgEVNE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 09:04:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:59567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgEVNE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 09:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590152666;
        bh=vZTEr9NXjuqGO3QlNDedMmBJG7I1be2Cq4fHdVBp8BY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hv7RZNBmotN70N4jZ1xoNgBC5xBAPdVVNwY4jYrIusJQq64jGUwNdtMCVdtX+TL6L
         zsJx+ID9n0U9QQgtVcqSOM2DHAIu44rVQXk7eiJHWd4NC0+WKmryCLHvfeKCgez6Vx
         o6BVjeSKl/XohOuV5a/OUwaUxG7YwvAdz0ldJlTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.226]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1iw8gM1AW8-011x4P; Fri, 22
 May 2020 15:04:26 +0200
Date:   Fri, 22 May 2020 15:04:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5608: avoid say and use skip_all for consistency
In-Reply-To: <20200521230510.13077-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005221459190.56@tvgsbejvaqbjf.bet>
References: <20200521230510.13077-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-299427116-1590152665=:56"
X-Provags-ID: V03:K1:/mSfLuNX47cN4/YP6m6uy+8bmqnmPxl/FClhfBF9kHRl/MqhpEp
 6vp4hjSO0dLzNvZHS5++Z73saamHEqjipuQPf1tX06pn+Mj5XmPOYTAeNSt6wkPP5nz9NZW
 u50CpBUznwIcpwnv9W0G25g88/wrg0P4B17U8A02pRfk94FoBf2Y0C2b2wiz0ozo3uobqvo
 Z/61NRsdHotAUtG1Lr9xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vKbY31baNSE=:mDkNt+e/NN9vhVGyy71Nfd
 TKmBAVsfQni4bzbzLqgOenhX9a72ilVVABTi06tUoUtkelNsYE7ORDoS8NAbpd8AxdhM3Y4IN
 kR5TOYx6pDtzdsRpFsSnrWIN5gPflOvfQ+96u/Fewv5wyZ67nAWAjJRQCHCYz2oRnMR8Z0Ps3
 KibkAIiIuXupR8jEepva7hvbnuaJz6d3/ERKMpbZ9EPEMHNKa859oViM2Qxu8qGHzaSMPTsaZ
 UcHL1CilCdu8IJc9esWjpL379dquv7O3WuTBEFLouy0MSrAiDvaj8iuHz+d85FPE0WC3CS/Ee
 K0meklWBU2jS/8QfyqLZrNGhdValJfTWLtKTc3MCvIcLtgMjVUZ9yATC9U6bUNjc8SxLGDlj/
 s6JVtmwGcwogSG3zbtUZ8QmgOJvSnbgLTWMaxs7hSvgh+HiNAFVi6H1MeXPaib3qmMWJ+MlPX
 yBJ4BZyKqX8WqZZIMOrNEd8w7sVGkccvsQU8UajrRVUVnRgtzLWCTlswcPI6kTo1Hb6Yyk665
 Ad2V5qRWfiY5Qs0nZWmPOLkQynSWTKJjAuvND22dZOR3+LuYzSUUJO84u8x0uXz9e/4whyPJj
 xogdmqcEWD5uSvjrnnh1sIR3IA0HjJ0iqeL4Nj5lJnEmB8YsOBzdLOi70tuglBeU3aAzUrzCw
 rafISSxrZFM0rvNvdXwHqByYFkXZM4cpt416ncXPRtYgrT2Yp5SnKrK4ib8COtofjCSPOeGLD
 5jTgJQwdp4y7+El+CDYmgK2Ojm64o7mLyPxJf/hv3L4GdL3/CIDmPfbNn1U8dSGxShDd2mEuE
 ihkkP5c8AZ8pxkRdPRcTRt6+E1zFDipz6hMTypk6jl3yZBqT0MPUSfakTTC7zn5y50FeBvscx
 b0ONP53aDIziDU1p/ODFjvbgu9ro9trpm1/7/0KDz22W7NRZ2IeTvm9t7hs71qOmI9WCXXyEA
 RU8n/URD00B3ENHxow38vRdCueLuAs2U4qcyHyVxceCOVOjWwb32gBYH0fd9JIPFlygU4q3MV
 BEWKLGdVF/5CRmXRC/IK13KrXWpsTvb6eYZMJd8OouIyDXLDi8MrK6rKb5sFuQgngIyFuYI2A
 v4jUi/yDR48hWTOf9QVBLNaKfnWKI2aSNQ91air25vcfTIyaKf38AGYMi8reXea+3CYVjZCVt
 O+BVlGdDNWmJlvZs/uDHbrcYbPVNVycvvRkogmkgbqb9EW6SUAVjl0J3seL+1e2VtBhR3EkO3
 ++I9Cfr+S0uGHPjZ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-299427116-1590152665=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

> Subject : Re: [PATCH] t5608: avoid say and use skip_all for consistency

It might make quite a bit of sense to add a visual indicator to "say" to
make it clear that it is not a verb, but a function name. Otherwise
non-native speakers such as myself (and maybe even native speakers) will
stumble over the grammar of this sentence when trying to parse it.

These would work better for me:

	t5608: avoid `say` and use `skip_all` for consistency

or

	t5608: avoid say() and use skip_all() for consistency

On Thu, 21 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Printing a message directly to stdout could affect TAP processing
> and is not really needed, as there is a standard way to skip all
> tests that could be used instead (including a message).
>
> While at it, update the message to better reflect the use of
> booleans and get rid of the prerequisite.

Makes sense. I would have added a sentence to say that _all_ three test
cases were guarded by the very same prereq, so `skip_all` is just much
faster and idempotent.

Otherwise, the patch looks good to me.

Ciao,
Dscho

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t5608-clone-2gb.sh | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> index eee0842888..4c476d2fa1 100755
> --- a/t/t5608-clone-2gb.sh
> +++ b/t/t5608-clone-2gb.sh
> @@ -5,12 +5,11 @@ test_description=3D'Test cloning a repository larger t=
han 2 gigabyte'
>
>  if ! test_bool_env GIT_TEST_CLONE_2GB false
>  then
> -	say 'Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_=
2GB=3Dt'
> -else
> -	test_set_prereq CLONE_2GB
> +	skip_all=3D'expensive 2GB clone test; enable with GIT_TEST_CLONE_2GB=
=3Dtrue'
> +	test_done
>  fi
>
> -test_expect_success CLONE_2GB 'setup' '
> +test_expect_success 'setup' '
>
>  	git config pack.compression 0 &&
>  	git config pack.depth 0 &&
> @@ -38,13 +37,13 @@ test_expect_success CLONE_2GB 'setup' '
>
>  '
>
> -test_expect_success CLONE_2GB 'clone - bare' '
> +test_expect_success 'clone - bare' '
>
>  	git clone --bare --no-hardlinks . clone-bare
>
>  '
>
> -test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol'=
 '
> +test_expect_success 'clone - with worktree, file:// protocol' '
>
>  	git clone "file://$(pwd)" clone-wt
>
> --
> 2.27.0.rc1.181.g8d5cacc8d1
>
>

--8323328-299427116-1590152665=:56--
