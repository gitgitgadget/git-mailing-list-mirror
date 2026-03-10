Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319872E8897
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153689; cv=pass; b=jIrFrzj7ZROwlpAqqcGOBL+dU8Tyz8byfpSCGj/8lNlPmNx1V2EG3VGTq4veXbM62vkv2HjT0nlDGgMR9HbyAsF/1odTvGXgzrevtobuGLO0xH49gpDfmU8bZEE819i2vAvlEP8aPEr6rd90xuan6pXpOXN8q+8M489m0uFPTuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153689; c=relaxed/simple;
	bh=krgV2YQVq8H/Xngq1e21rJL8rXHgDYypCMUdFGhypDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7RAenNWS1daKwHjrDqHfk71Nwwrkfs8ku+c09IobhlpNlz60/kkDMDT7yKi6NtorPgMEmJ6Y8qgojnJ1C2AhutWCV1QRtpbD5S707num/HCOtXhkvM8kaYaX2++FVMssxCwWYTljCM4099p+z7Qd4CHlQtxOWc+H4jHNQJwBIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COKAFwUw; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COKAFwUw"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a857578a8so4437026e0c.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773153687; cv=none;
        d=google.com; s=arc-20240605;
        b=iw3dv3/549JOdV/jqfXR2hmNO6+ZHuij5/HGeCxknTuoeZO96BMy24RwPL0ob/gZmg
         6/xlybVmwGG408cWNOl+ybKtJ0x80QAiydZhCQjtW8HocVVHLIH06/3Jt06W36FO4uw5
         F4jwpZDZVeZbVNec4FchKv5CTUU2M1OyjI4x2mzKd8pTqfid0kC3UYycDFtvTzpyAixI
         sXwzsppDqBmMXi0uZeIqN5Xq5Vx3sbCIaMkBhKu/ZUfprZ5O4nBZFH0exPF5e1MzSUL+
         3T+yh+p+QgdQ/nHeDzbcQYMeodrZPQ6gtShKhnIPN+cdkroIe6dXCMZUSQBbM8MWEW8a
         MYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MN7c0Ay3WVUPzjGmzYAUPEDEfMZXoE+/Y5O9M4ZKqVc=;
        fh=9Nyj6hr4op66zt9D/8vpU3ygrQhrZlYzCwRJTm/dCPg=;
        b=asslznr0zJMPuUKFIi7vvK63u7BJxEM2KrT7GiuTwV4/DwnXOH+YxzkN+aQrM2RygL
         TOF/eGiNOUkQcQdWA8oYgbQDzMX3cPg+2T9NIMELfVgnZ7zrGq7v/dJApjf9HxQI/Hpn
         xLscLv88uabLK/4opdRZ2VTYf+93EOFnm92GCe1Fb8uIaeBH7kJe/SCcjQdcYH2ZyS7D
         dLieYey/yjiamNzsNdxYHX+XSGgSgjrVH7ewJgw1lv1DQMEWInYAdF7S5a3FejFv5CzV
         sNOUqxpC+9uRFArJpNfEA5nsXATr9Ma3cGxPxw8KNOaGXMxr20Aj0J+ZcQaQepGIXSMC
         2YMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153687; x=1773758487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN7c0Ay3WVUPzjGmzYAUPEDEfMZXoE+/Y5O9M4ZKqVc=;
        b=COKAFwUwJrFD0TlZ4BFb29hwrAf1llAJ5aSatyROvDbAznse4JJmEMnmdKwtNw83Sg
         am3x7MbrGs0tYM7FEeTk5+lBzJsDCatqIWWM/VRhKvunlQ7CkKRK9wYMugNgaLPATzW9
         eAIcnNXtQTIjb8xL5/TLHtA7qkTMlLFYC9uDGl1SQJ0ThoV+piKabfBnrPnYRKfy7JFu
         Fv08WH+C5E2HgGKzN2P3fo9yU4664hb6WE/WG2GJZGyHXInWrMkMTC8LfIXlznrfHi8o
         /5PPLvQguiidEYktUSsn3Y6YfxSkAO6Q/trJkiu5bzRCiCSg31L0Eo8RFyiEnTTrGgEs
         Zqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153687; x=1773758487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MN7c0Ay3WVUPzjGmzYAUPEDEfMZXoE+/Y5O9M4ZKqVc=;
        b=vQoMKvMeDPcreVyLywMU/y1IMOqFBhZvLVdB0PhfU/lNty128guhjqLC+N5Qim5WhU
         jBPDpQalWG6UwcfDNHJzKbQGusaO/kXddA+2LDNH4B79BXVAqJ03m72uLKEz5UrYVdYD
         48N57g6NiscbBXN1x4SlbPzIF4wr7OKfIInHzPmoTa01S0YrWjSqMejpS+RTlqaDSCqG
         NjWHbVCanf4YeKO94g5YuqadtdZSLfjYLN/95pOcWBkYzKutPtlFP9WSRzsJGr9uEAfX
         D6mdUl1R7K0Gj4XPUaDhAMD8UHAHzp2hbEkAJVturwxaJDV+Z2B4NpY2LsKxDxA+Fblq
         ijWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyzKA33XiaIOZHBQm1+ib0HH17bV+aIuk7VSptEqkaThvpU0gHSR62IXszal7chzFvFJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSglfVTz0GDlbdZwZYs+0+bO7xWb8jgI28q4LkhkA5qlSTxdVh
	ubBsonqGBdJpZTipzoISYekhGvDhIyqJPk3k4nt8gk69CXBhFjoUjW9Zp2/jUYb1eB/ekCkXWHU
	nvK8cPVWZfuI373CIJuUK9WjUG2GF0Mk=
X-Gm-Gg: ATEYQzxcJrvJV7HpcXfV+L0haFo3S+NaYDYT936sOoiaMIU4ReVE8/+C2Gqrhyw/r+y
	yhw9c0Q2z7Lon+4qBBFnPOjeYCVy0cOeR5bOyHrUiGpGuBpDWf96PrCenhqiCZua+5orP0FdahQ
	d5fZ1sd6PtEobYs529dmY+ol3r3pBhiHIAyMMBe0ZZKnxyInczyYQxPYw+oFgZMbSUsBSI7+cOM
	0xbC3qfoS41X69t8Z9SB85NLOCEyLohjRq13478OxMsCtICb6L7Wq6NSpr1Lir3q58n8UpCod4B
	WhdlxB7rtuDBzyBC3q/6fzM7PEVB4OfOQcPSc7XNxcqIiZsGVy5RhG3lEgB6Pc8gCavkciTibnO
	/FiBINLIHLPrmndNiop8=
X-Received: by 2002:a05:6102:c54:b0:5fd:f14d:4cd6 with SMTP id
 ada2fe7eead31-5ffe61af321mr5230135137.27.1773153687039; Tue, 10 Mar 2026
 07:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com> <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
In-Reply-To: <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 20:11:15 +0530
X-Gm-Features: AaiRm52gMv14C1ZAqVcl8neL9fG2bXNncvixLoAAT4T9T-lODIhCZDF9HoVosSY
Message-ID: <CAOAgETMYM+W1fRG=sJj+WXwYT5FrxjbL9OMU1w4gs3MWuFTqTg@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
branch switches

Patrick Steinhardt <ps@pks.im> writes:

> It is used in "add.c", but not magically so. The function that you have
> introduced is the only site that uses the new advice, but the function
> is never called as far as I can see. So ultimately, the proposed change
> does not have any effect on the user-observable behaviour.

Thank you for the correction and for the bottom-posting reminder.

You are right. The function advise_on_checkout_dirty_files() is defined
but never called anywhere, so the patch has no user-observable effect.
I also looked into the existing behaviour more carefully and found that
unpack-trees.c already handles this case and prints a message telling
the user to commit or stash their changes before switching branches.

So the patch as written is both incomplete and duplicates existing
behaviour. I will rework it in v4 to instead enhance the existing
message in unpack-trees.c to also mention 'git checkout -m' for users
who want to carry their local changes over to the new branch.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>

On Tue, 10 Mar 2026 at 20:07, Arsh Srivastava
<arshsrivastava00@gmail.com> wrote:
>
> Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
> branch switches
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
> > So won't this simply be duplicating the same message?
>
> Thank you for the detailed review. You are correct, the existing message
> in unpack-trees.c already handles this case and my patch duplicates it.
> I also acknowledge the other issues raised:
>
> - The newly introduced function was never called anywhere in the codebase
> - No tests were added
> - The bullet points in the commit message used '>' instead of '-' or '*'
> - The advice message was not formatted with tabs
>
> Rather than duplicating the existing behaviour, I think the better
> approach would be to enhance the existing message in unpack-trees.c to
> also mention 'git checkout -m' as an option for users who want to carry
> their local changes over to the new branch, since the current message
> only says "commit or stash" without mentioning that option.
>
> I will rework the patch in that direction and send a v4.
>
> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> On Tue, 10 Mar 2026 at 20:01, Karthik Nayak <karthik.188@gmail.com> wrote=
:
> >
> > "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Arsh Srivastava <arshsrivastava00@gmail.com>
> > >
> > > Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
> > > when they attempt to switch branches with local modifications that
> > > would be overwritten by the operation.
> > >
> > > This includes:
> > >> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> > >> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> > >> New advise_on_checkout_dirty_files() function that lists the
> > >   affected files and suggests using git stash push/pop
> > >> Documentation entry in Documentation/config/advice.txt
> > >
> >
> > Nit: Did you mean to add bullet point here? '>' is generally used to
> > quote text. Perhaps use '-' or '*'.
> >
> > [snip]
> >
> > >
> > >  Documentation/config/advice.adoc |  5 +++++
> > >  advice.c                         | 27 +++++++++++++++++++++++++++
> > >  advice.h                         |  2 ++
> > >  3 files changed, 34 insertions(+)
> > >
> >
> > Hmm. Shouldn't there be changes which actually call the newly introduce=
d
> > function? Also shouldn't there be tests added?
> >
> > > diff --git a/Documentation/config/advice.adoc b/Documentation/config/=
advice.adoc
> > > index 257db58918..8752e05636 100644
> > > --- a/Documentation/config/advice.adoc
> > > +++ b/Documentation/config/advice.adoc
> > > @@ -126,6 +126,11 @@ all advice messages.
> > >               Shown when a sparse index is expanded to a full index, =
which is likely
> > >               due to an unexpected set of files existing outside of t=
he
> > >               sparse-checkout.
> > > +     stashBeforeCheckout::
> > > +             Shown when the user attempts to switch branches but has
> > > +             local modifications that would be overwritten by the
> > > +             operation, to suggest using linkgit:git-stash[1] to
> > > +             save changes before switching.
> >
> > Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
> >
> > In one of my repos:
> >
> > =E2=9D=AF git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > nothing to commit, working tree clean
> >
> > =E2=9D=AF echo "aldjf" >> LICENSE
> >
> > =E2=9D=AF git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > Changes not staged for commit:
> >   (use "git add <file>..." to update what will be committed)
> >   (use "git restore <file>..." to discard changes in working directory)
> >         modified:   LICENSE
> >
> > no changes added to commit (use "git add" and/or "git commit -a")
> >
> > =E2=9D=AF git checkout  0-1-stable
> > error: Your local changes to the following files would be overwritten
> > by checkout:
> >         LICENSE
> > Please commit your changes or stash them before you switch branches.
> > Aborting
> >
> > So won't this simply be duplicating the same message?
> >
> > >       statusAheadBehind::
> > >               Shown when linkgit:git-status[1] computes the ahead/beh=
ind
> > >               counts for a local ref compared to its remote tracking =
ref,
> > > diff --git a/advice.c b/advice.c
> > > index 0018501b7b..e1264f525c 100644
> > > --- a/advice.c
> > > +++ b/advice.c
> > > @@ -81,6 +81,7 @@ static struct {
> > >       [ADVICE_SET_UPSTREAM_FAILURE]                   =3D { "setUpstr=
eamFailure" },
> > >       [ADVICE_SKIPPED_CHERRY_PICKS]                   =3D { "skippedC=
herryPicks" },
> > >       [ADVICE_SPARSE_INDEX_EXPANDED]                  =3D { "sparseIn=
dexExpanded" },
> > > +     [ADVICE_STASH_BEFORE_CHECKOUT] =3D { "stashBeforeCheckout" },
> > >       [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            =3D { "statusAh=
eadBehindWarning" },
> > >       [ADVICE_STATUS_HINTS]                           =3D { "statusHi=
nts" },
> > >       [ADVICE_STATUS_U_OPTION]                        =3D { "statusUo=
ption" },
> > > @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_l=
ist *pathspec_list)
> > >                           "* Use \"git add --sparse <paths>\" to upda=
te the index\n"
> > >                           "* Use \"git sparse-checkout reapply\" to a=
pply the sparsity rules"));
> > >  }
> > > +
> > > +void advise_on_checkout_dirty_files(struct string_list *file_list)
> > > +{
> > > +    struct string_list_item *item;
> > > +
> > > +    if (!file_list->nr)
> > > +     return;
> > > +
> > > +    fprintf(stderr, _("The following files have local modifications =
that would\n"
> > > +                   "be overwritten by switching branches:\n"));
> > > +    for_each_string_list_item(item, file_list)
> > > +     fprintf(stderr, "\t%s\n", item->string);
> > > +
> > > +    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
> > > +                   _("You can save your local changes before switchi=
ng by running:\n"
> > > +                     "\n"
> > > +                     "\tgit stash push\n"
> > > +                     "\n"
> > > +                     "Then restore them after switching with:\n"
> > > +                     "\n"
> > > +                     "\tgit stash pop\n"
> > > +                     "\n"
> > > +                     "Or to discard your local changes, use:\n"
> > > +                     "\n"
> > > +                     "\tgit checkout -- <file>"));
> > > +}
> >
> > This doesn't seem to be formatted with tabs.
