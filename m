Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356FC2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B864C206F7
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 20:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UBewJ46e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgDDUI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 16:08:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:51259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgDDUI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 16:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586030936;
        bh=9tkIhAU6MExs7/bTePbfxy0wo6XdLeo/nxDjUr/qbJo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UBewJ46exxoqC6Q2eCFdJNoC5PslxdHikJxUleD5J3wckasm/DwQB5SIiECvblGbZ
         vnGnJo2MYpZgjHcp1L+uaR4iSAnjlFuuNCriPw3VzyETwiKRxRAr3i6sBbltnpxbk/
         rPo9Px1YK5zMykTm663NdT5Ixv109ATDm0UjYdvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MZTmY-1jrBvi2tuQ-00WZFE; Sat, 04 Apr 2020 22:08:56 +0200
Date:   Sat, 4 Apr 2020 22:08:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
In-Reply-To: <20200403084654.GK2224@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com> <20200403084654.GK2224@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-910191576-1586030936=:46"
X-Provags-ID: V03:K1:2BI+N/TTimoLEvI8HaJpUpOskavrYFjfpNYudVdnGqoc9fIZUUY
 BU/IHW9FAocKCW+SI+P41DD+tRHjniahqdcMvn32gXKV01QZ8kAI+YBD7Bedb0CFPP+ujj1
 ZRnbpHao+7sdM8U+dmEhTuucPSpxrGzWKHAoNQap0oUrQY2nL2V0yIjnufrJuE1kZXkcoaL
 S3b6iNsuljdI1zP7/SlAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/6KNTEw7b0=:kmuNliWOmBbHAm19WQYjTZ
 jvAY5W7w3xHozaJuCNblCdKflpNWGK1Tmz3Rr8Es4brBSIIYa2fBkpB0ja2buqbR/+xeFl9Vn
 F03vLFqtxlnHPpiNZzIylAmcuVH3qsr89VJHk1qvHDni0LIOEHsOwFrGUD9bVEBRzlFBXezAW
 pvd4szHRqJsnlv5hGPOxNWuUMbJ+OkWkJeP6TXSnQhLJKM3vyb35gCw2/xNEN+FBQDJW6BsiM
 aFJ3Gqihhbmkg5dAat6x3kOUpj5uKEekehP105Iobq6kYkdzMjDxfvQG3ikHDTOiFhQQ7Fp9C
 eBLCqCRSBUFwsPxzciKVbmVtPXOhQSAus9YfHS3CfvbNT0m4eQCNx12nFN/RgcMUcydHRPYzg
 jjh7vvkNsAwsf4gJZRmxeOjRwyBqYgqUMVxQmM8GTZoVJWKLwyL2C15AGQnSz8WbNQLH3tzvf
 xjoSw9gdtx+NGvhiCJCfF1A4iGH1/V9M1haHbJb+Lp3YL7sjOu2ZMqSDc4uSglm9e1jbTojwg
 +kFHOyiV6J2DF0OpY1KZbEzORbOuYwjvmWhurEoJTQnNRvBkNaxqxHcs5Tkr1r2rpn0edw0MO
 gS4Hx3LbdtF+I+/jJuJVKWaMqqAmgPc2igeedr2lXFdsCNIkbnCb1YkGS4yKPdNmc66W91DgC
 21kluCptfZBxQPGYtoNOy82m7E99xPhIKyKgcdETx+6SCLoyI8CF1bn6ZRLGTQ6ejJQCi1shy
 ACTGX0XaEXCJbng/COBqPTr9qKEuZaw0QvEiVGjRUTYKZkdJK2yCyMccmJh/ugOAebHt7sGxE
 ACbP0g/CQPaQg9/4rvEGT8trT6maJS7yySp+ZdxFq3aRgr5yp0qlkmSB9eZLHnCgUe9Rd+f6P
 Tw2g8j/v0oEfguI8ovCIKJjNYcxVTxbp6sZ25fl6uTp1RecKQ+2phamHrCrawzXD5R3uMHDGo
 j4eM2BziUaBv3/ts8HrKaTHYcq42Khxq2XutM57EQ1osXcKukLtRdM2k2IzBGR8ip2jSEPpj4
 EMn1F+DmoVnyuhn8cKTdfrbpG3ugoDxHBY5diXsC5hVAGAJE3ANKL9b8dcRrOQhMOwiuVEqa3
 agUgJA/KHJj53nulpQ8IIU1vzxl3AOo9GXm4t9jqkRJpgDCqNwbA4TunerEuh1Ja+KGAdmd7N
 En7BeS3Q2ZuhMks3SLI27WLw3JT3vWJbUXXhg+SMqbmXUK04whi2g0sNVTQcgVhrV+VtNC2t1
 UDPGPnRKkz9mV8wNd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-910191576-1586030936=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 3 Apr 2020, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 31, 2020 at 12:48:30PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > For each CI system we support, we need a specific arm in that if/else
> > construct in ci/lib.sh. Let's add one for GitHub Actions.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/lib.sh | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 8d73551a12f..52e350496a3 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -34,7 +34,7 @@ save_good_tree () {
> >  # successfully before (e.g. because the branch got rebased, changing =
only
> >  # the commit messages).
> >  skip_good_tree () {
> > -	if test "$TRAVIS_DEBUG_MODE" =3D true
> > +	if test "$TRAVIS_DEBUG_MODE" =3D true || test true =3D "$GITHUB_ACTI=
ONS"
> >  	then
> >  		return
> >  	fi
> > @@ -136,6 +136,24 @@ then
> >  	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> >  	test windows_nt !=3D "$CI_OS_NAME" ||
> >  	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +elif test true =3D "$GITHUB_ACTIONS"
> > +then
> > +	CI_TYPE=3Dgithub-actions
> > +	CI_BRANCH=3D"$GITHUB_REF"
> > +	CI_COMMIT=3D"$GITHUB_SHA"
> > +	CI_OS_NAME=3D"$(echo "$RUNNER_OS" | tr A-Z a-z)"
> > +	test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>
> Hmm, if "macos" isn't not equal to $CI_OS_NAME, then set
> CI_OS_NAME=3Dosx.  This is head-scratchingly backwards, and I think
>
>   test "$CI_OS_NAME" =3D macos && CI_OS_NAME=3Dosx
>
> would read better.

I can understand where you come from, but your code is not `set -e` safe,
which is the reason why I wrote the code this way (compare to the already
existing code in the previous clause, which was copy-edited here).

Ciao,
Dscho

>
> > +	CI_REPO_SLUG=3D"$GITHUB_REPOSITORY"
> > +	CI_JOB_ID=3D"$GITHUB_RUN_ID"
> > +	CC=3D"${CC:-gcc}"
> > +
> > +	cache_dir=3D"$HOME/none"
> > +
> > +	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
> > +	export GIT_TEST_OPTS=3D"--verbose-log -x"
> > +	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > +	test windows !=3D "$CI_OS_NAME" ||
> > +	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
>
> Likewise.
>
> >  else
> >  	echo "Could not identify CI type" >&2
> >  	env >&2
> > --
> > gitgitgadget
> >
>

--8323328-910191576-1586030936=:46--
