Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F52BD59C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153674; cv=pass; b=pesHRo3mUfhRxfagOz3e7OJdsIXXeeFYfPj/G/T8PMpKDpa228LquERZ42HemQUFrJST3qc7qqPa5Q630YOHPokoeuWqMdsSm5MJGPpPfRd7Rw0Qa4NiQohvGMKMOiOlizQsEHIR72f/NpMzcRVLP9VODV3ikBs0yYAa2NmrN1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153674; c=relaxed/simple;
	bh=o3UOg3qLxd4+rVLLxBXj3FBfQR8FYhFmc/tKD7xjrpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyScoidTssSWkk5gJs+GcK+M8OgEoUAgRo7yGfqsUASkmtjaPKejBx6zIgdYRuq12W4tdXj0mdyC7Lwi0XH1eT0gOkCeI50vFEMABEQMld4AvGpI8SAXuSFqmTv8YFpL8hp9hVOqlim7y/rgGIW1teePS8nBiunstIJr7sZbhJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF6gzOqs; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF6gzOqs"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94dea0e029fso3741869241.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773153671; cv=none;
        d=google.com; s=arc-20240605;
        b=bid0K2Tn67UE06zjYFEfdrOLFVNrbTfnJaNYSMBhGCHu3ZYJCX0BCrYo7tQhVtahC5
         JgiJyBxZU3n4aUc8KSEBUjWeIrBfTZ12ytCI8uzOnCPidwzGkeRbLlWAHZz/aVzQrz9f
         Jv5p74XGBUIkPSkIrHZ33b+1rRm1X69RzspKi5VmQpCbxzYYr5tSVo0M3jGIu2PmafFZ
         w/E/2rtLlArr+UU3uYhRMd4MHJJqFubWAtpNXAqy6s2EAcaYRnYOO20UBshOPMASWpdN
         sj9ZumIMrxsdDruKflw95gGRo7VSTmGpnaGe1VqWsrsDe9dB589Y9ojoa8Gv1E4BWyZP
         gLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d76y9bmHt/0DpHrVCAXHWaY9JsBsLAt/htgrbxq+MbA=;
        fh=B2HXlX+9g/LeacQa/X3cKA0vYAVNShvSei2LA0o6cDY=;
        b=N4CyzfWFksUJOZ2slcxnnJivLQWzhDAu3wXaHSRvelhz+OxPCPL7O56WFwIPvxrUK7
         9iKHW30JH5lAM6JzrmLAp2k7b0OATIZXYRbcrxSPluEV4rhhu3m52hC3Ddl/V2qM3xcE
         MwwGS2MEBcuz+IfMP9gpQi02BHd7L2uKWZHVhXEAQUPHMK03t1hQ5JQyEwsUFp0qPi+d
         0mCcA4UNuKaHDiaoXTylYjz9biO+4mEkbreKnydMQyuQGH/k3gJ7s75FpyW/KzWFU/zg
         QGQps6HpqZA1xRqxDpZyzeBxQaRh0FiReTUuYjJ8Z/uB3NRmVplHypr8FATeJ3aTsD6+
         uMDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153671; x=1773758471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d76y9bmHt/0DpHrVCAXHWaY9JsBsLAt/htgrbxq+MbA=;
        b=ZF6gzOqsZXJJqs3TcweSwfiFKCUFAW9m3r/wv/OOQR+X+eJVy2ruYD8Jw84W6NLzIn
         uksWkzfTU2zsRu637mp4RuvIes6H8j1RMthU4kiFrhiCqYJ/islEhBn3YJukP0PrHrNA
         0Zs5xjENLxinNFaNhMgiBJiYgip9/gzdr/CdnA2OAqd0cPWy+wLFCOHroj9ntdbgFYJo
         n/wiae9VFTGTllKOZOqf63lXPH/A7kFab7WCzZAeciF8rJ4lV+qIuBtR7xT2nH/8P0km
         iW5iwyjaD1tizz1N0JpwqrrUJmAR0R89f5eM8hhZyZa7ZSJT52SQc6HtYoB1ZojpJkud
         W5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153671; x=1773758471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d76y9bmHt/0DpHrVCAXHWaY9JsBsLAt/htgrbxq+MbA=;
        b=JeZ899YXwZ4lgJ/lmw1pnlkzClO31PmVWJUvMZ75EscWPnfcxRRQOMhFPkeQyZcjwQ
         SkcwFMyzySyktZwnVZjNmtOOQUYrHCqaaxxNtfhDGJuVViMlSa7EJPK4weNt2YGSv/KH
         Tc8U2XCDSzweHXlPsUDn+sSRtV4pnkdBw+OB+xsKvMHXfqugnBJSzFbq2lyXFdNlQcfc
         e7JM7XAxMHMiC1JqEoGrAX8PCLAKJx021wD8cmYuphXzn13+FieRECyK8jzbEMM66n3I
         oYcuh9+zQ0tvnlWwFdUdQgkdQKTgIqS7BcEacarr1c/GCjsJ/KKckouUD3ulPCRPifaw
         nHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHylrCzXaNxar1gsrJrl9yxnyFP9MKIrO4vsajeen2dTAB2mzxb/wUlinb+/6nDqkMqHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdfyW2Sfyom93/nowK8M5LrUoYUWRd4HUbhL9tdR48wcqnU4d
	oDwCXw1Ja1VEezF89OT+D0ox5Pia/leZAARk8xeOgCarAD8HQipRUjjGb54UvpeEzXAL7wh7qOt
	5fc3pIVx7tlB82Z5+thn0c5mj0cJC8LGiX7hSRMu4kw==
X-Gm-Gg: ATEYQzyCAiTkARsfVP31X4+HIrNPKJstdQ/PZePfvWY28n42B1PhHDd1T8AVk5kKyOZ
	6sQ+8JfzTrqOJARFXMMtw4CH/Vps9/H9jQe5Zd8SvqOxcJt9/+/2kZSGe3H29S5rSqWMqKcTJin
	ZJzwicX/O5Ihrl6B9w42hbojAqZOFySqQnTjDPbf1Y09SdArY1ZznUT3Vtbf66SYPfCabYvan+3
	+RkP+qCjO7madvEzlC03L97GoJcza7nt68XYrndaUlt79ns/oZ+r1cTErg3VuiLUnWTuUnv/tn2
	JBBsy3j/7rfwNFoyBC+HBnf7fsXRmimaR7h30a0e4AoB97fA7lq1lb00YmZjT4+aYnuRmCKKoGO
	cYQMpGDzWvfIA4a75Co8=
X-Received: by 2002:a05:6102:dce:b0:5f5:4eac:cd2e with SMTP id
 ada2fe7eead31-5ffe61bf0c7mr6144158137.32.1773153671379; Tue, 10 Mar 2026
 07:41:11 -0700 (PDT)
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
Date: Tue, 10 Mar 2026 20:10:57 +0530
X-Gm-Features: AaiRm52bdQzBgJ9CC7WRex3OTJz90g5Ni3ywWft0pHrLBP__Glejqt_Zwu5mBmY
Message-ID: <CAOAgETOcivRUskCi4PCLnXzn1qGs9jx39JzgBA0jE=CirSkZJQ@mail.gmail.com>
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
behaviour. I will rework it in v3 to instead enhance the existing
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
