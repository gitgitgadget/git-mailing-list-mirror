Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31401F461
	for <e@80x24.org>; Mon,  2 Sep 2019 09:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfIBJad (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 05:30:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:37615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbfIBJad (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 05:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567416614;
        bh=E6/Uwy3D/9GjdCe5mpq6+TboJK6Kx6L61TwvkGP1L3A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i1EwHFoMpPsQYo+kNHG3aNQCgfaf3PjgCmFEpqshX/Grz+l0h2WGbtFNOsfWfdrrk
         PzgJ/hl9XLXaCV/AahwqUjVxue28w2iGEsy/nCpk/URbIevpTx3vuRCD3IcpluLnO7
         sM+yZpkA3fHdyQqStcjZjJ8PTITKiOn2NOxMRP/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1i5qjB3jQq-007kfb; Mon, 02
 Sep 2019 11:30:14 +0200
Date:   Mon, 2 Sep 2019 11:29:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it
 elsewhere
In-Reply-To: <CABPp-BHMXAQGPaBYyg2dtVeN5h8fW8G4YdhddCeAjY5r74BAzw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909021111440.46@tvgsbejvaqbjf.bet>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com> <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru> <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com> <87blw93c5n.fsf@osv.gnss.ru>
 <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com> <nycvar.QRO.7.76.6.1908302221210.46@tvgsbejvaqbjf.bet> <CABPp-BHMXAQGPaBYyg2dtVeN5h8fW8G4YdhddCeAjY5r74BAzw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gUsPsyiGGD8bo0mu+lzmyN3YT8zo3fTwHMxJ4MfcEuUkwX4IFUv
 pOik3TWO9AU1j3LukZEDaTSFA8MdkH3FrCyyKq3IoX9n2Daj5gB9mnfu5HjH6hkFPxiuEKx
 nTt73aAoe4fAd2NpUl4oyz6l4znIj9lwJZ128GUk9/+iJjsqiKJoU7pj4SEUJpqHgtPT5ez
 a7d4byqWDmXgIi8VP8yTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jHqF1UZ04X4=:hLQFWmReOsKTVEqVuWSsg8
 leGtzx0qH3duI8+uYdiWFEyunxOCInAtMdi4OCNYUl5cFK9AyIDO7lKb/QPl2Ir3Cj49wXA/B
 vVbCEJi5LO8xeykIMiJ9Ep/JLnf91FlaA6xrIMP103FZOKE8u9dQh5dpMiz7XJhbCU7enJ84x
 ODKNDfIKEgIZRk3HRqedhU4DZhRI2YACDfE0G3btj78agC71ron04s8rqbPiFqYCURBYSX8bN
 jgcew6dz364cpt3SZG0kDFyS+9UJlYPECmujlAPuFojXPLKv6nkUtkX/xu4I91dBcv+PFQCoy
 uVYI2dDrlzm8OT1gyqmfj4oY33mvQpzl2OlBEgy4gwGOO9IzUDkNvLM2pMSFTji89t7UQEHPb
 N+5qzlZ9iKYl+Hr1mcv6qrhv7hvY1sSqqg1eSgR0cAchNYdMnkVCuzRHtlcZhhQPclx1TpUjc
 eejmsxzh9Ahfefa0x8zpSzjyukwJ3vdKG0EPaQwSePjW+MzHHZhVgeUcnyPzCoZHHN/gp3ZiE
 +l+A1/gvo0OVprovzpXboTMHRK4IlkTlWeXSQ0f+ePLxesZyjOdCFZSyiLgWgzmf930YGBQ7P
 r0UAsEpv7TTyfaxmDPICGlsmZ9bpoh1BAo5ujF5ZYT7X6EofIQ6XnVicsepiN3LJp6RxZ3jIp
 bsLk2w04rD7zgOj9A0sqjN8/2TYxCw2wAIS/vZK0wbmM9mOz6ZMn1FyVxmGe9Btfo6FhHfXfs
 6KiA3oeKQFDliJ20MJYcpqSTsqxlG97ru1z2Iv/rdFf6cuXlv9OGiK1fzgqSD50giwTuf4tjT
 QvsoliXwmK9uZ8hcufoEFDrOyh45VFHY8V/p1fkBFSG0+IduaUOkZ6mlADknUo9W1Vs64U97C
 3FGsqLdkAl8cDNiJXPfICuj9xa/MolDBbwyHpqkpJODA6rf2WkfaxpZZCRXBSOq9KWhgSH83M
 hJw1tx7Mn5MidbDt61ajIQgSjUbwWkNXGQvTTWh8gxm/HBe2QA7Y5nh/n/q+I0wB8aAD6/NC0
 GiWHYIpqRgWhjLxk8YprLOaB6MpXOUf1PVpndHrwaZ2k/knf2E87PJOhsDAhhp6LPk426vziN
 +/PFLsyEf2SxscmqI4KOtHWe7xh6PHW+HFB9U0BDaqKftZD0lF7gC7dFmH4scLUEXisFz0Fwt
 JIDGyOCYLj845+T5JfZf/e6nae3hzcT+kvEviGjMTD8/Lha1KHOYf2e29UqeglhoFDR+s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 30 Aug 2019, Elijah Newren wrote:

> On Fri, Aug 30, 2019 at 1:40 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > [...]
> > In my most recent instance of this, I wanted to publish the script I
> > used to use for submitting patch series to the Git mailing list,
> > maintaining tags for iterations and generating cover letters from bran=
ch
> > descriptions and interdiffs (this script eventually became GitGitGadge=
t,
> > https://github.com/gitgitgadget/gitgitgadget/commits?after=3D6fb0ede48=
f86e729292ee1542729bc0f5a30cfa6+0
> > demonstrates this).
> >
> > To do that, I ran a `git filter-branch` in the repository where I trac=
k
> > all the scripts I deem unsuitable for public consumption, to remove al=
l
> > files but `mail-patch-series.sh`, then pushed it to
> > https://github.com/dscho/mail-patch-series
> >
> > Please note that most crucially, I wanted to rewrite a newly-created
> > branch, and only that branch.
> >
> > Could I have done the same using `git fast-export`, filtering the outp=
ut
> > with a Perl script, then passing it to `git fast-import`? Sure, I was
> > really tempted to do that. In the end, it took less of _my_ time to ju=
st
> > let `git filter-branch` do its work with a not-too-complicated index
> > filter.
>
> Why a perl script?  Shouldn't
>     git fast-export [--no-data] HEAD -- $PATH | git fast-import --force =
--quiet
> do the trick?  And it's probably simpler and shorter than the index
> filter you used.

Does that not keep the full `$PATH`? I wanted the resulting branch to
have the file in the top-level directory.

> That said, yeah it'd be nice to get automatic rewriting of commit
> hashes in commit messages and other niceties from filter-repo (e.g.
> future automatic reattaching of notes to the rewritten commits).  Some
> questions:
>
>   * What's the backup strategy in case you specify the wrong filters
> (e.g. you have a typo in the pathnames)?  filter-repo encourages folks
> to make a clone and then filter the fresh clone, because if anything
> goes awry, you can just delete and restart.  (I am heavily opposed to
> the refs/original/ backup mechanism used by filter-branch, for
> multiple reasons.)  Is your safety stance just "If I mess up it's my
> own fault; do the rewrite?"  Or are you okay with cloning before
> filtering?

Please note that the `refs/original/` refs should not have been written
at all anymore, not after reflogs were introduced.

Incidentally, that is my answer to your question: the reflog is my
backup.

>   * If you're okay with cloning before filtering...then is there an
> issue with rewriting all branches, and just pushing the one you need?
> (Is there an issue with "this branch is small, the others are huge,
> and filter-branch is slow -- so rewriting one branch saves me lots of
> time"?  Or are there other issues at play too?)

I am not okay with cloning before filtering.

First of all, it is wasteful.

Second of all, in my case it would have been *particularly* wasteful
because the repository in question also has quite a few quite large
blobs (hysterical raisins, don't ask).

>   * What if the user has auxiliary information for the branch in other
> refs?  For example, git-notes pointing at any of the commits, or tags
> in the history of the branch that might be relevant, or perhaps even
> replace refs in combination with GIT_NO_REPLACE_OBJECTS=3D1?  Is this an
> "I don't care, toss that stuff and just rewrite just this branch?"

In my case: there are no notes. The only time when I make heavy use of
notes is in GitGitGadget. I don't use that feature otherwise.

>   * filter-repo by default creates new replace references so that you
> can refer to new commit IDs using old (unabbreviated) commit IDs.
> Would that be considered helpful for this usecase?  unhelpful?
> irrelevant, since you'll just push the branch you want somewhere and
> nuke the temporary clone?

I definitely did not need that mapping in all of my `git filter-branch`
use cases.

Of course, I can see how it can come in handy in other circumstances,
just not in the ones I experienced so far.

> I'm not by any means ruling out the possibility of documenting --refs
> and adjusting the defaults when it is used so the user can just run
> something like
>    git filter-repo --path $PATH --refs $MYBRANCH
> but I feel like I need to understand answers to questions like the
> above ones so that I can know how to phrase warnings and adjust
> defaults and update the documentation.

In all the scenarios where I used `git filter-branch` (some dozen per
year, so not all *that* many), I needed to rewrite one particular
branch, typically a freshly-created one. I never, ever ever needed to
rewrite all the refs in the repository. Not once ;-)

> > In another instance, a long, long time ago, I needed to restart a
> > repository which had included way too many files for its own good, the=
n
> > rename the old repository and start with a fresh `master` that contain=
ed
> > but a single commit whose tree was identical to the previous `master`'=
s
> > tip commit. I simply grafted that commit, ran `git filter-branch` and
> > had precisely what I needed.
>
> filter-repo supports grafts and replace objects, the same as
> filter-branch.  (Although, technically, I didn't have to do a thing to
> support it; fast-export does the special handling of rewriting based
> on grafts and replace objects.)  So, I'd say this is fully supported.
>
> Side question: the git-replace documents suggest that the graft file
> is deprecated.  Are there any timeframes or plans for phasing out
> beyond the git-replace manpage existing?  Should I avoid documenting
> the graft file support in filter-repo?  Should I include examples
> using not just git-replace but also using the graft file?

I had meant to prepare a patch series to remove `grafts` support that
Junio could carry in `pu` until the time he considers it appropriate to
merge to `master`, but it seems that this task fell under the rag.

The deprecation itself has been introduced in tags/v2.18.0-rc0~54^2~4,
i.e. it is official as of Git v2.18.0, which was released in mid-June
last year.

My personal gut feeling is that we should let it simmer for another year
before removing support for the `grafts` file (and we may want to update
the label "grafted" when `git log` shows a shallow commit before we
remove that support for `grafts`).

So I'll not work on that patch for now.

> > I would be _delighted_ if these kinds of use case (rewriting a branch,
> > or even just a commit range) became more of a first-class citizen with
> > `git filter-repo`.
>
> I've got all the pieces for supporting a single branch or a commit
> range (e.g. 'git filter-repo --path foo --refs ^master~4 ^stable~23
> mybranch'), but the defaults (error out unless in a bare repo, move
> refs/remotes/origin/* to refs/heads/*, disconnect origin remote,
> expire reflogs & repack & prune, create new replace references so
> folks can access new commits using old commit IDs) may be somewhat
> friction-filled for this usecase.  Those defaults other than the new
> replace refs happen to all be turned off with the combination of
> --force and --target, so, assuming turning them off is what you need,
> you could cheat and just specify 'git filter-repo --force --target .
> --refs $MYBRANCH' today and perhaps get what you want, but that's a
> really non-intuitive command line that is way too ugly to recommend.
> And I don't want to tie myself to '--target .' being the magic sauce
> in the future either.

I agree. I would love for my use cases to become more of first-class
citizens. Maybe `--branch <branch>` could serve as the knob?

What I also found really helpful in `git filter-branch` is that it was
possible to pass one-liner shell scripts directly to the command, giving
a lot of freedom about the transformations. I understand that Python
makes it hard to write spaghetti-code one-liners, so you cannot really
pass the snippet in via the command-line, but I hope there is a way to
script things in `git filter-repo`?

Ciao,
Dscho
