Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FC1C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271D920665
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gtMOoLcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKJMPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:15:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:39809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgKJMPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 07:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605010502;
        bh=K6Dyecq7P5xCshoVsNnj0MmGfE/Bv4p/Jvn/oL7bGR0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gtMOoLcvM2eqYurPsFTvSSjMU7ivb8hqDrbJr8jPU/GrRUv9h9Mi/ikYT/2pWmu21
         mkl1IVU1I8YgUp1FzXfNc5B30ZVbMOpfxxuyP6ViMrfFVK/xofMWH8Fg/TAtMAkTMi
         rAwCFqbe3K5wgOzLMypYbwny0vZptpvn8veCT004=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1kL4I049Rp-00rJmN; Tue, 10
 Nov 2020 13:15:02 +0100
Date:   Tue, 10 Nov 2020 13:15:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Daniel_H=C3=B6pfl?= <daniel@hoepfl.de>
cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Suppressing filter-branch warning
In-Reply-To: <20201110112114.GA28702@black.spass-am-geraet.de>
Message-ID: <nycvar.QRO.7.76.6.2011101311170.18437@tvgsbejvaqbjf.bet>
References: <20201106090443.GA20407@black.spass-am-geraet.de> <xmqqo8kafjgt.fsf@gitster.c.googlers.com> <CABPp-BGv9goqrYBwgSkmhPYOmwcXeRCzGT2sQbL+xD2xWeT5gQ@mail.gmail.com> <20201110112114.GA28702@black.spass-am-geraet.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-913261058-1605010502=:18437"
X-Provags-ID: V03:K1:OQrS1chb4Qj6ozTTFBYeslkZct6b5adCvQeDmS+I6k1/Y/Wx/sT
 PL/UziFCdRUzK2bI70HLQNSegczsahCBp87G5+fAWahFXVZTPCElHSU1AzMvUq8HrCv7Kxv
 sRUox2fWhyyBVpezK6AujEmTCCTubKAfIHQe8zoSJ0u5Y8Fjq5+nALkq6kG0rkLpsIJips2
 fe1OQmgT4M+AtySjvwygQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwVxyZNtsbs=:ZFVZzYm5v2pAXNrLpMkbHL
 HS82YZUdkF3wOZJsiOBJNK1UnErHtQDMtR9jhq2Ju2CW7xh+9XXpp4q3n02JpYO/ndSXHksAS
 gIcxZXKJwvmNtQQzUoFNrSczhwb29AGWf0TI/9evqKgU0QuXsQq/YObN4zFWXt6G2PnY6VekI
 mSHRQhNTZWViW7inmYKEHzjqRu9cxeKryfAPeeS+3fkMZGTX1/mqdx+NB0Cj1g8jst3o9a1CY
 tQPiphb3i2E0y0M5j3hzhLhmjwBhboXeRUcCIUotHM8zSGcYDi7jpQHMBkIaqDGVbm6/Lh48o
 efD8lHdGpkTxDewWQI+SMEQ1ri4+NvRij84G+2h1dFU/elM/xKEf2wMzZp0+bIRI/b056S33s
 +r4z4DI/qChvjh1ltKsGeob1k9oVDS4wtsoGH2RSWDTcpm4vMiiohq3+3giX/Scqgqiyg2jPP
 Zzd3yMaJWLYZUQ7e98J/UBjeRNgDQKO4MBmSgqaD5atYY23sHVrNo2eDQZSAbooJW95Q9Plb5
 nNbueMp/wvpRwe7Agx1zhxhRplhbgkP9mZzFoJfyltrUQOGa9TGeLhZ7oNdxbqc+rxF1HimJN
 Bhw7hkRsQ/lJK1TlwB9eYGiD7QEvC5y0zfG0lXh3uVw2ifxuVDoYqUw3ZU01bWx+Ztp3ywCFs
 zFJq2tcghXOLZN42WIlFuIMTFnu/K2o4UjYmtLAIq4rzl9ORftdcqtXVETUSrUEQnXMjBZlcm
 86vDdqpT5uG80ki78/8EHke6VlIVaJl/1CQu7zkBtHKxFrl5IsE+f0AqKVXkVG15R8szC0GZC
 tFo+/hi9ML0WX2SwlZzTPh7JWOpDurCLgGwzk3e1qYadh2ce3WISVRr28G08AnaRM01LvpVf9
 Rg3ufafciQ7O240c2/ulKBzs3y+PKiqjQuE4ds7d4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-913261058-1605010502=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, 10 Nov 2020, Daniel H=C3=B6pfl wrote:

> Hallo Elijah,
>
> On Fri, Nov 06, 2020 at 12:12:55PM -0800, Elijah Newren wrote:
> >On Fri, Nov 6, 2020 at 10:06 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > Daniel H=C3=B6pfl <daniel@hoepfl.de> writes:
> > >
> > > > Hello there,
> > > >
> > > > What did you do before the bug happened? (Steps to reproduce your =
issue)
> > > > git filter-branch -f --env-filter '' --tag-name-filter cat -- HEAD
> > > >
> > > > What did you expect to happen? (Expected behavior)
> > > > See below (difference).
> > > >
> > > > What happened instead? (Actual behavior)
> > > > When using git filter-branch, the following message is shown:
> > > >
> > > > ----------8<-----------------------------------------------------
> > > > WARNING: git-filter-branch has a glut of gotchas generating mangle=
d
> > > > history
> > > >         rewrites.  Hit Ctrl-C before proceeding to abort, then use=
 an
> > > >         alternative filtering tool such as 'git filter-repo'
> > > >         (https://github.com/newren/git-filter-repo/) instead.  See=
 the
> > > >         filter-branch manual page for more details; to squelch thi=
s
> > > >         warning,
> > > >         set FILTER_BRANCH_SQUELCH_WARNING=3D1.
> > > > ----------8<-----------------------------------------------------
> > > >
> > > > You can suppress this by setting the environment variable shown.
> > > >
> > > > What's different between what you expected and what actually happe=
ned?
> > > >
> > > > Normally, when git introduces this kind of change, there is a
> > > > git config variable that one can set to suppress it.
> > > > That way one has fine grade control when to suppress it (one repo
> > > > only...globally).
> > >
> > > I think this comes from 9df53c5d (Recommend git-filter-repo instead
> > > of git-filter-branch, 2019-09-04).
> > >
> > > FWIW, I personally do not think an environment is a worse choice
> > > over configuration variable in this particular case.  The large
> > > scale rewriting of the entire history in the repository by its
> > > nature is an one-off operation that ought to happen only rarely,
> > > so a one-shot
> > >
> > >         $ FILTER_BRANCH_SQUELCH_WARNING=3D1 git filter-branch ...
> > >
> > > that reminds the user every time would be more appropriate than a
> > > configuration variable that has a more permanent squelching effect.
> > >
> > > If it were a new command line option may have been even better, as
> > > an environment variable can be defined in .*rc and forgotten, but a
> > > command line option needs to be typed every time and would serve as
> > > a better reminder (yes, I know it can also be aliased away, so it
> > > may not make much practical difference either way).
> > >
> > > But I'll let the author of the feature to comment.
> > >
> > > Thanks.
> >
> >I agree with Junio that filter-branch's one-off nature means that not
> >providing a configuration variable seems reasonable in this case.  If
> >someone else were to go to the effort of implementing some
> >configuration option here, I wouldn't be that strongly against it,
> >though I'd rather just let filter-branch lie dormant and stable.
> >
> >A new command line option might have been better, but it didn't occur
> >to me at the time this change was made and I hesitate to needlessly
> >force people to adapt again.
>
> I implemented the change and sent a pull request on github (#912) but fa=
iled
> at GitGitGadget. Anyways, here=E2=80=99s the patch:
>
> ---
> git-filter-branch.sh | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index fea7964617..fb55afcc86 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -83,15 +83,21 @@ set_ident () {
>        finish_ident COMMITTER
> }
>
> -if test -z
> "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
> +if test -z
> "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" &=
& \
> +   test "$(git config --bool filter-branch.squelchWarning)" !=3D true
> then
>        cat <<EOF
> WARNING: git-filter-branch has a glut of gotchas generating mangled hist=
ory
> -        rewrites.  Hit Ctrl-C before proceeding to abort, then use an
> +        rewrites. Hit Ctrl-C before proceeding to abort, then use an
>         alternative filtering tool such as 'git filter-repo'
> -        (https://github.com/newren/git-filter-repo/) instead.  See the
> +        (https://github.com/newren/git-filter-repo/) instead. See the
>         filter-branch manual page for more details; to squelch this warn=
ing,
> -        set FILTER_BRANCH_SQUELCH_WARNING=3D1.
> +         set FILTER_BRANCH_SQUELCH_WARNING=3D1 or run the following com=
mand:
> +
> +           git config filter-branch.squelchWarning true
> +
> +         You can replace "git config" with "git config --global" to dis=
able
> +         the warning for all repositories.
> EOF
>        sleep 10
>        printf "Proceeding with filter-branch...\n\n"
> --
> 2.29.0

The first obstacle was that somebody had to `/allow` you (you probably
missed it; https://github.com/git/git/pull/912/#issuecomment-724637575 is
a bit of a verbose welcome message, but it _does_ mention it in the
"Contributing the patches" section).

The GitGitGadget Pull Request still has the following issues:

- the commit is not signed off
- the commit message is not in a good shape (it consists of a single,
  too-long line)

I also left a couple more comments about the patch itself here:
https://github.com/git/git/pull/912/#pullrequestreview-527112997

Ciao,
Johannes

--8323328-913261058-1605010502=:18437--
