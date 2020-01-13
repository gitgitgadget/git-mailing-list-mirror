Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D987CC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625AE207E0
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AWVmfpXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAMONl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:13:41 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:10654 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAMONj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 09:13:39 -0500
Date:   Mon, 13 Jan 2020 14:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578924817;
        bh=8El/PsBMqCyJH/r4Y9wGCkcG5vWZ2jemvVZ4VBMlVI4=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=AWVmfpXVUQRhk2toe22+oWd71agFdGIyFbnVsDdtR+WKnjqSZrVxYUSswmrQTm61P
         oqJlqmLWPxcPq0BBrI0Ifx06eSHF6XwkfQ1CIEN3oebYsUW34YT2CmsTRx+cGStazj
         pjUfVMaJ2YMusPnAc8YGNwVNYcid3YtUci8wYIG8=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   1234dev <1234dev@protonmail.com>
Reply-To: 1234dev <1234dev@protonmail.com>
Subject: Re: [Feature request] An easier way of rebasing if you just want to "force send" a file back to a previous commit
Message-ID: <0Dqok-9TKEiBBNX9nxLHb5JpKGVBSbtanPqn_LsLttvk1KIrdc6TEffERFUJ-TApxkB1CHZ7vmexHGYG9KMe6gC9nhTJXOJM7egKDQ8y6HU=@protonmail.com>
In-Reply-To: <20200112204511.GA4400@syl.local>
References: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
 <20200112195646.GQ6570@camp.crustytoothpaste.net>
 <20200112204511.GA4400@syl.local>
Feedback-ID: jm_lYfXrrNlRjeoYk2ubMr1Ofg3d6jxZVz74GfYfMumLfq3Q9_Z5n8vqkvDBYWSlKkQ9TIGL2Vvi-4DSzBFTyQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sunday, January 12, 2020 8:45 PM, Taylor Blau <me@ttaylorr.com> wrote:
>
> I couldn't quite tell one way or the other, but I think that the
> original poster was asking about the case in which one wants to move
> some hunks out of one commit and into an earlier one.
>
> I usually go about this with something like:
>
> h=3D"$(git rev-parse HEAD)"
> git reset HEAD^
> git add <file[s]> # re-stage the files that you want to move "up"
> git commit --fixup <hash>
> git add --all .
> git commit -C "$h" # "re-apply" the commit that you were moving out of
> GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash

I was just looking for a simpler way to either move the entire file back to=
 a certain commit, other than the standard way of rebasing. Your suggestion=
 looks even more complicated than the method I currently use which kinda de=
feats the purpose.

I appreciate the help though!

All the best,
Jonathan


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, January 12, 2020 8:45 PM, Taylor Blau <me@ttaylorr.com> wrote:

> On Sun, Jan 12, 2020 at 07:56:46PM +0000, brian m. carlson wrote:
>
> > On 2020-01-12 at 19:42:46, 1234dev wrote:
> >
> > > Hello!
> > > I'm pretty new to all of this, but I was wondering. Is there an easie=
r way of rebasing if you just want to force send a file back to a previous =
commit? Rebasing can get quite tiresome in the long run. It's like 7 steps,=
 and that's without the merge conflicts someone with my luck is guaranteed =
to run into.
> > > For instance, say I've made changes to a file. Those changes are too =
tiny and insignificant to make a new commit out of - they actually ought to=
 be part of a commit I made last night.
> > > If there just was a way to cheat :) I'm aware it would rewrite my ent=
ire history but that's okay, I haven't shared my repo with anybody yet. May=
be something along the lines of "git rebase --off-she-goes <file> <hash>"?
> > > As opposed to "git stash && git rebase --interactive '<hash>^' && <ch=
ange pick =3D> edit> && <apply changes manually> && git add <file> && git c=
ommit --amend && git rebase --continue && git stash pop && <merge conflict =
that requires manual intervention> && git rebase --continue && git stash po=
p && <still a conflict> && rm <file> && git checkout <file> && <repeat the =
whole process> && <still a conflict> && <go to IRC and ask for help>
> >
> > The way I usually handle this is something like the following, although
> > I have some helper aliases that wrap this:
> > git add <file>
> > git commit --fixup <hash>
> > git stash # if necessary
> > GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
> > That does use the interactive machinery to apply the fixup commit, but
> > it also avoids prompting you to edit the interactive TODO list. It
> > doesn't avoid the merge conflicts which can occur, but it is (IMO) the
> > easiest way to go about it.
>
> I couldn't quite tell one way or the other, but I think that the
> original poster was asking about the case in which one wants to move
> some hunks out of one commit and into an earlier one.
>
> I usually go about this with something like:
>
> h=3D"$(git rev-parse HEAD)"
> git reset HEAD^
> git add <file[s]> # re-stage the files that you want to move "up"
> git commit --fixup <hash>
> git add --all .
> git commit -C "$h" # "re-apply" the commit that you were moving out of
> GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
>
> > If I'd like to edit the message, I use "git commit --squash" to add the
> > comments I'd like to add and I'm only prompted to squash together those
> > messages.
>
> My preference is usually to allow 'git rebase -i' to open my "$EDITOR"
> and change the todo list to "reword" for any commit(s) for which I want
> to change the message.
>
> > --
> > brian m. carlson: Houston, Texas, US
> > OpenPGP: https://keybase.io/bk2204
>
> Thanks,
> Taylor


