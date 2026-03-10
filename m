Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EF2E7BD3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153450; cv=pass; b=Fz66+xQjizLgA0nA11hCvsuJt5WZD1ZvN6GuNLqg4aUVBz0iXWLoGOBqfZJLXKu1/2kBMgms9ZgrH6miNF6lr8louXf7Em/f62gKC0XT1K0TSF62HFJro0zjn5QM80aX2SVZ/eQVwf9dYuv+sesyoyEKvRPB/cYjaXuu8/u9k/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153450; c=relaxed/simple;
	bh=N6blcl0kOoekUF9gaknn574aJcREl//8jixdUiA/5tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cROK9o/RLHH30IdO4e5fRZJlxuV56J0dDIx7WAuorfGGivUAQIEB7r8uQeswZj+RSy0EcSD0KiLTk5bUFpbDmpIAWHZWVYw0FOcNk3GHM2kqTIDj4/5N0o9KqY7pdxzNu3YSBCIexi4+m7jrRJQmKRzNr+AB0YwEqh7JJiyZi7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEJmt3GN; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEJmt3GN"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so7735449241.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773153448; cv=none;
        d=google.com; s=arc-20240605;
        b=BGgLSBrkd3JzKtmBqVd8jbhRnUFNjP1YmHbvpbF2bGdaK6EUTs7swSXbDaJvwENmrF
         vHf20m7Yg0KVXyBpzH28Qg3YL+OP3EgBWS5VcgAA0HB99O7zZNbq9UAlXfaoDR5tDISi
         Roa1DnzGTIqH49KYr5aVP5g0JPNnyZPj++z6pxpOeLSfe5Je3/cUebq8brFbtpZfgEuN
         7OwSdljW7zcdpGQ3QKD4zDEg+2XZpaR1R6X0wOOAv9eHc3MgbAqRNNtAQpGTmG0cVJC0
         UP40NT431ntnLHEDewkCtelQf5ytrpXZzDHmyhXyK4LdeRAu7yw30Hm7V6hNwPXgpWMV
         CRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08BE2UbXoHqM7tg6jUWoOvZ8VtIInQOSJrA9Njl9DEE=;
        fh=CBt1/2zuJXk1suZ+v/ozONVBRhU5kM7lwc1GhJqZQCU=;
        b=LIXbHCnSeJxjGvlqkSm/PB4khW6Yu2j4VVvuhrjujLEqaM88eT7dTxekxG27tLkBZp
         dytnzyncpLf0tws0HRECZF9GBxSpkDqamCTMF39N0bMqNARrYw444AvtW0xcVEBHrNY9
         becwWtvwgBN8NAGKfOdJzN5SbsOj94XaKEDSfMgbKFRFLuDlYluESXy7w9fWyyRd+Pg6
         XcK0ASED16Ksnqal5yYBbKJvqe9XiYU6oa7ul66mdZkJ1DZg0rnlZKnRTDYuN5GygTbW
         J4P/xL2hecsjOH7kl2Aa6vbRxUfLWyxsihpoPlavCs54Vd/d02R5JLGdP0wAwzPiLIse
         ACUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153448; x=1773758248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08BE2UbXoHqM7tg6jUWoOvZ8VtIInQOSJrA9Njl9DEE=;
        b=TEJmt3GNQhGH7QPk420JzJYA9XFtf1SKVy6QNh3Y28XtlNEGq5uCDMaAPOeC7AGJth
         JH4BFfA3mz5kO+dVwr35kpAbx6wFHbQZ9ahzoT0TIJrIO9VwD2ztmIaf0zG1rGoQXV2N
         s+7VflTYARkrzqvySqP2TRPWPP19jBV8O6s2kANXOhuKh1e6uHwzmYyAgVrwifE4DPPX
         E7+5NsZ7MhTknTJ13z4HKfOEX12HNdE6PeQKnp3M0yQig6aRfjt89L4LnTGHTj04asOa
         IiZK9mBiqZMbBljkHdc7X29+9B+Oibb0luUT4+Qp0nyMH3g077zEfsbQkwUNeGVEnY43
         oXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153448; x=1773758248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08BE2UbXoHqM7tg6jUWoOvZ8VtIInQOSJrA9Njl9DEE=;
        b=J97362LBya4CEGkJQk+O6/XLbOoGyo3LsBgM5LbHl+EKRt0ybOU3pCtFPVIyB7Iynb
         61CIBhwiU7zyJ0QdxL23BAvrxMEQ+BeA1QIy+ZIBEJ5lcOmK6Xb5K26SFoVGAecEEqjI
         kVvgWnsCp8PARUEJyVdI414AEjvMaAhzJKawmQvyXNX5L6KXgbGcx8AuC2HCaIS92ZLx
         xli18FzpveR0UztKT7OSFU5crVIikpyVMaP73um3/ry0+2jUg8YwPJNpGA5UeQfrYmbm
         1W9j3fXz6fL4necYPEYvPTcMkh9iXES2TN0mttDRBh0H/8zS1l5RXFqgbiZZ1+Wv0VwW
         l92g==
X-Forwarded-Encrypted: i=1; AJvYcCXJc0UKUtXSlzG4ncq9IQNmLXaSYkg+XRclY/DfLyqhLREFW6yQUY6NVhEKHTJHLUnqFJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoPTCD+84DIxqs4pRSNuSVhYk8iOjQxQiFHnBwtt6fTDL6exO
	lb6lnIqy8+Vmj6CkLRW1rkXK+9z9XZJa3/tEeb0isCHClG+SqMLNQqsaU3YN/nrcSO7Br3IEuUu
	ygfGN0vQjF85RXtCXPkAeCTbXLXVTZSrRTXPZOETy2g==
X-Gm-Gg: ATEYQzzVIJaqszckaHiU8nJsWUbQIyYi6cVDE+fCkHW9nQjbTUrhXIu/yrSVnia0Ij9
	K7ApJZrgg8ZYTQpAe0hL5gUjRGpXVbyeRbg5Fi2cvfYLKkND2ew9euO0rDFXTwPzkex4eYx3C5Q
	sM4OXPZUNa6e8Z2HkugPLrO+JiuE8RHR3wpxEnxAabEdCCPWHQHakHBUUgoETH6jjGQLwfw7R4P
	B2+ZT5pMQXLYDPhD3HA9K4GgoWATIUwmP4VfZBe08e/aOnlCC34dOqYhHHXDc426BQ1kODwqehr
	v5qqrXYIpWnZdtYcwCpExOjDWHKjGWi/ckKYJpMHOnV50dF0WTfCfP7MspuXYYeTHnFFqJlmc2U
	4IsXkWJj1iwgzuHWiFpioiIPArBmq7Q==
X-Received: by 2002:a05:6102:5088:b0:5e1:866c:4f8a with SMTP id
 ada2fe7eead31-5ffe610f0a7mr6516647137.20.1773153448096; Tue, 10 Mar 2026
 07:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com> <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 20:07:16 +0530
X-Gm-Features: AaiRm53K43ieAJvg_dQJDf6pnz9OVpyksaNaWoK2eBH5wXWoURrrBIwI7365EFY
Message-ID: <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
branch switches

Karthik Nayak <karthik.188@gmail.com> writes:

> Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
> So won't this simply be duplicating the same message?

Thank you for the detailed review. You are correct, the existing message
in unpack-trees.c already handles this case and my patch duplicates it.
I also acknowledge the other issues raised:

- The newly introduced function was never called anywhere in the codebase
- No tests were added
- The bullet points in the commit message used '>' instead of '-' or '*'
- The advice message was not formatted with tabs

Rather than duplicating the existing behaviour, I think the better
approach would be to enhance the existing message in unpack-trees.c to
also mention 'git checkout -m' as an option for users who want to carry
their local changes over to the new branch, since the current message
only says "commit or stash" without mentioning that option.

I will rework the patch in that direction and send a v4.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>

On Tue, 10 Mar 2026 at 20:01, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Arsh Srivastava <arshsrivastava00@gmail.com>
> >
> > Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
> > when they attempt to switch branches with local modifications that
> > would be overwritten by the operation.
> >
> > This includes:
> >> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> >> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> >> New advise_on_checkout_dirty_files() function that lists the
> >   affected files and suggests using git stash push/pop
> >> Documentation entry in Documentation/config/advice.txt
> >
>
> Nit: Did you mean to add bullet point here? '>' is generally used to
> quote text. Perhaps use '-' or '*'.
>
> [snip]
>
> >
> >  Documentation/config/advice.adoc |  5 +++++
> >  advice.c                         | 27 +++++++++++++++++++++++++++
> >  advice.h                         |  2 ++
> >  3 files changed, 34 insertions(+)
> >
>
> Hmm. Shouldn't there be changes which actually call the newly introduced
> function? Also shouldn't there be tests added?
>
> > diff --git a/Documentation/config/advice.adoc b/Documentation/config/ad=
vice.adoc
> > index 257db58918..8752e05636 100644
> > --- a/Documentation/config/advice.adoc
> > +++ b/Documentation/config/advice.adoc
> > @@ -126,6 +126,11 @@ all advice messages.
> >               Shown when a sparse index is expanded to a full index, wh=
ich is likely
> >               due to an unexpected set of files existing outside of the
> >               sparse-checkout.
> > +     stashBeforeCheckout::
> > +             Shown when the user attempts to switch branches but has
> > +             local modifications that would be overwritten by the
> > +             operation, to suggest using linkgit:git-stash[1] to
> > +             save changes before switching.
>
> Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
>
> In one of my repos:
>
> =E2=9D=AF git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> nothing to commit, working tree clean
>
> =E2=9D=AF echo "aldjf" >> LICENSE
>
> =E2=9D=AF git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         modified:   LICENSE
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> =E2=9D=AF git checkout  0-1-stable
> error: Your local changes to the following files would be overwritten
> by checkout:
>         LICENSE
> Please commit your changes or stash them before you switch branches.
> Aborting
>
> So won't this simply be duplicating the same message?
>
> >       statusAheadBehind::
> >               Shown when linkgit:git-status[1] computes the ahead/behin=
d
> >               counts for a local ref compared to its remote tracking re=
f,
> > diff --git a/advice.c b/advice.c
> > index 0018501b7b..e1264f525c 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -81,6 +81,7 @@ static struct {
> >       [ADVICE_SET_UPSTREAM_FAILURE]                   =3D { "setUpstrea=
mFailure" },
> >       [ADVICE_SKIPPED_CHERRY_PICKS]                   =3D { "skippedChe=
rryPicks" },
> >       [ADVICE_SPARSE_INDEX_EXPANDED]                  =3D { "sparseInde=
xExpanded" },
> > +     [ADVICE_STASH_BEFORE_CHECKOUT] =3D { "stashBeforeCheckout" },
> >       [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            =3D { "statusAhea=
dBehindWarning" },
> >       [ADVICE_STATUS_HINTS]                           =3D { "statusHint=
s" },
> >       [ADVICE_STATUS_U_OPTION]                        =3D { "statusUopt=
ion" },
> > @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_lis=
t *pathspec_list)
> >                           "* Use \"git add --sparse <paths>\" to update=
 the index\n"
> >                           "* Use \"git sparse-checkout reapply\" to app=
ly the sparsity rules"));
> >  }
> > +
> > +void advise_on_checkout_dirty_files(struct string_list *file_list)
> > +{
> > +    struct string_list_item *item;
> > +
> > +    if (!file_list->nr)
> > +     return;
> > +
> > +    fprintf(stderr, _("The following files have local modifications th=
at would\n"
> > +                   "be overwritten by switching branches:\n"));
> > +    for_each_string_list_item(item, file_list)
> > +     fprintf(stderr, "\t%s\n", item->string);
> > +
> > +    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
> > +                   _("You can save your local changes before switching=
 by running:\n"
> > +                     "\n"
> > +                     "\tgit stash push\n"
> > +                     "\n"
> > +                     "Then restore them after switching with:\n"
> > +                     "\n"
> > +                     "\tgit stash pop\n"
> > +                     "\n"
> > +                     "Or to discard your local changes, use:\n"
> > +                     "\n"
> > +                     "\tgit checkout -- <file>"));
> > +}
>
> This doesn't seem to be formatted with tabs.
