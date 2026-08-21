Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFA28C009
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354164; cv=pass; b=Bl/Bcf/3iVAe8VYXnGmpW7TqXRM6aI2UHVkg6RM6vdanUyZ3xjm5Di0BGwvWJZwt4Z4zUy1EMRrfbzHFwLAa+mioLZ2c8W9//zNfa6QZ5zcQnnqvkHzGnJvoNLfaVJDU7x72I/ah83RpbSjb2Pl8x/ok5KozNZyM0Zh322zaUms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354164; c=relaxed/simple;
	bh=3ZokiN2P5I1/26wzNeH8jktL3ULwMxm+SO87h5SqIO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/DEiWRvjf+eX8BkvH8P/PvfISWlj3E2c2hS9Pmt3SaWZbAFvHO+0vXaXJAoahesmLw9gE+j12bN0ohXEu9HfPaMw1LFOejxVCZQ9PFoDzzIvwDt0FDtDH6tH6dLRxgSBDC83uRIj+UWmsAPY4gSrvSBeVHuVonLkJRwUMDY25A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw1nFrNr; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw1nFrNr"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c04bf4711so13203091cf.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 16:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787354161; cv=none;
        d=google.com; s=arc-20260327;
        b=Mf2B8eEfGE61qchZ3ZrRU9GTrkWXyGex4ejTPq3O5F/9LpbY/DHoMkMlNOhjXkWNKQ
         bqCOxMnWDDwFnM7FGSadXhKVJaZhKCJIwstCOwG4KjPNcnegS5WaFFQ+oFuT6P6J5TTU
         KHkbGGYkUiFmF2eFeGLa7WTckOf/504jLH1SuaR5JVK2g/Yk+GCZrY2AVAExp3puzt/3
         jXpPl2J/QFMxUtRTVAGhzJ8E/FeDFd6h/CjHGbk9N4cupq6Lfwk+l5Hi2wdoaD1NNqLI
         jkO9OL6pKOfyC/9BxTCWeH8pdSs34yIoqQ6tJ1UtNYEfiEmc/yFEBKaow8IsVTAW72+9
         uU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9mn9IGJkk8esQQi7Coocyy+TvgvnOQqSIr271gAwhJI=;
        fh=/Wcda/33dVcwL4uT3LrFLE8+wQJ0TvS/ZQDPBAi88s8=;
        b=KFtHlobyjE9SXItAYGtwjxNvDQ2EwFNuAhmhusRRpSpg/bYkbKIP0vULzXh/eToTOc
         qeUpSetB4yJD/s6at2t8EvvGtvz1ZsFL93xFj2oSxd2f1VDv3aOuYhsodlembixCU9dd
         Iq0qyZSHUMeqxl8qm1Tds78w4tLDHNkcugxCmaX+lvHworeQzibGF90G4PoDVMgmSCHG
         ySoGkj5SKn1gNLDzLHxClA4I7UckBS8Fq5qNZU6LmixA0VWF2C1zbFUVBUm9XxWIbUuc
         IOsxa/J6b9dU2NXmlMwKl0u5JAm9arNSYGCRFkWwa8oq4SdgYdbeCM+EpdfDkFIBpu5c
         hNwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787354161; x=1787958961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9mn9IGJkk8esQQi7Coocyy+TvgvnOQqSIr271gAwhJI=;
        b=Cw1nFrNr24MbKuTWxEtnvAdXu5xN9LF6F2O+t9dhlpa0el1el3RQvR6L+13isFOlm0
         0XyAZIiJ1zhP6AdYgrnui5yMdh5o08NrvkutKcKsT5dOZ/hkuFAXnVMVcAr1hIIK3O2Z
         CE3+hrDzcwLNM8yd0PC3NZ2OeG13FZUARIHWzq/bxnceiH8ZQml+vyYKMKwmtvLTzkAw
         bkx2asvskFh2rGUij5w1sWcIJ0f3i77TEz1O59JeqDGD4Tbx/O2mjt1+GkZU04Epf02o
         ilMOC/kfEU+o2GqSRFsJMuzU3J44P09jPd7ZTJI99rkYfz7YwpqsJEFmqkMIawLnA3O5
         3NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787354161; x=1787958961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mn9IGJkk8esQQi7Coocyy+TvgvnOQqSIr271gAwhJI=;
        b=MLmoqyCrQ1meSHGORELPcuGqQlmYCkB2hNe93Ok2sAaR7pkrq1un97OogDcBMdj1aF
         jlyeDPLviHo08C3+GrzcJ4sj3zKG+L5GVL+5u7dGXakfhKwrlXyb+j55KwFFEBI6NGd3
         2QDxzSo7xY1U0W4NEp6/IVB3ovTtLCZ4eMsBRO8jsJsfnVXwH93bcHAT/R6ShWb1sLcw
         4pvl4XNeJCgWnOpc3MhBEhh2VGNekI8m9y+RChnm0w/L4ebZi4+ayFvNsWhXCJN/7LyC
         cJobnPyPHVmlWBxFmReJb74NYcIAJnfDdSLtVhdzSzIVBW3asu9nbUVFA1Ve34hFO/CO
         1ECg==
X-Forwarded-Encrypted: i=1; AHgh+RqwSwVjfXrRsiD4i8G08SD4gQexTja+iZadFruYgSfD7gg+KseyZw7g2VeoPaXZpm9ZFR0=@vger.kernel.org
X-Gm-Message-State: AFuF++loLvKXOX4SBD3Lw3NgCtK0jb/LBPRSanhw7+myzXbtYxZc7A39
	I3fwcaV9w85wAMrPPJuB2CbLAPeLWc+XC4m270GZ82eXdrkTlzhzkhxS2pS6wut+qg5jtDcpfc1
	MvPNndaU+00wB/jNgmBb2Yv6HhZLRFZw=
X-Gm-Gg: AR+sD108floVmAyN9igKj67RNmZ5+n0YYY76zcUK24vws+jquPdQHJKnndEa9hQ3Iju
	Cnd3NnYilgYG4XtilXAN2uwWaI6WPjWJMkynUGbDcgLCJPHRjcR9plfrwLDq8j7kRoViKB+y+Fi
	s+oXeZVRwNyEdEJqn/YeHpJDvZaaTUukgVHXVE33AsYtel6rRivz9F24fSQEqD8OHcFGBVzFUoI
	sl6XDR8+zF3NU3dE4xgErCZ/GD92AZTa6/KYrC9LGQdnBPGsBsSpIJGdDBL33eR3t6+iHauEwNJ
	hUcMDW8rU2DDPx2o3aGrhsTzfzgErv/TNxVj2MWVvdhZS9N+Hh7BzG/NaxRB5n2KQK5ZkYiSp4F
	awnwAbwqyLf9ILzhZOZ4lnvFnIaLcYWiO
X-Received: by 2002:a05:622a:153:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-52e09cabf84mr14147921cf.24.1787354160607; Fri, 21 Aug 2026
 16:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com> <dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
 <xmqqa4qgruvj.fsf@gitster.g>
In-Reply-To: <xmqqa4qgruvj.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Sat, 22 Aug 2026 08:15:49 +0900
X-Gm-Features: AcwNN1XyX_qW3z5eOn6GrRas8i3D0Ae6hwC0AJvSzkicHrREG-905HC8ZK7u18Y
Message-ID: <CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 22c8e5e131..8286c283e0 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **=
new_branch)
> >       return NULL;
> >  }
> >
> > +static void advise_disambiguating_remotes(const char *path, const char=
 *branch,
> > +                                       const struct string_list *match=
ed_remote_names)
> > +{
> > +     struct string_list_item *item;
> > +
> > +     advise(_("Branches with the same name appears in multiple remotes=
:"));
>
> The subject "Branches" calls for plural verb "appear" (not
> "appears").  The same issue appears in [PATCH 2/3].

I overlooked that. Thank you.
Rather than simply matching the verb to the subject, I want to clarify
what (as specified by the user) exists on multiple remotes:
    advise(_("Branch name '%s' appears in multiple remotes:"), branch);

> >               if (!commit) {
> > -                     remote =3D unique_tracking_name(branch, &oid, NUL=
L, NULL);
> > +                     char *remote;
> > +                     int num_matches =3D 0;
> > +                     struct string_list matched_remote_names =3D STRIN=
G_LIST_INIT_DUP;
> > +
> > +                     remote =3D unique_tracking_name(branch, &oid, &nu=
m_matches,
> > +                                                   &matched_remote_nam=
es);
> >                       if (remote) {
> >                               new_branch =3D branch;
> >                               branch =3D new_branch_to_free =3D remote;
> > +                     } else if (num_matches > 1) {
> > +                             if (!opts.quiet &&
> > +                                 advice_enabled(ADVICE_CHECKOUT_AMBIGU=
OUS_REMOTE_BRANCH_NAME))
> > +                                     advise_disambiguating_remotes(pat=
h, branch,
> > +                                                                   &ma=
tched_remote_names);
> > +                             die(_("'%s' matched multiple (%d) remote =
tracking branches"),
> > +                                 branch, num_matches);
> >                       }
> > +                     string_list_clear(&matched_remote_names, 0);
> >               }
>
> This appears inside "} else if (ac =3D=3D 2) {" to catch an invocation
> like
>
>         git worktree add ../over-there topic-branch
>
> where the origin of topic-branch is ambiguous (in other words,
> appears in multiple remotes).  But don't we have the same issue for
> 1 argument case that appears just above this (ac =3D=3D 2) case that
> handles
>
>         git worktree add ../topic-branch
>
> invocation?  The code reads like:
>
>         } else if (ac < 2) {
>                 /* DWIM: Guess branch name from path. */
>                 char *s =3D dwim_branch(path, &new_branch_to_free);
>                 if (s)
>                         branch =3D branch_to_free =3D s;
>                 new_branch =3D new_branch_to_free;
>
>                 /* DWIM: Infer --orphan when repo has no refs. */
>                 opts.orphan =3D (!s) && dwim_orphan(&opts, !!opt_track, 1=
);
>         } else if (ac =3D=3D 2) {
>
> where the branch name "topic-branch" is guessed from the path by
> calling dwim_branch(), and we would get NULL in s.  branch is left
> as-is, so it becomes "HEAD" that was assigned much earlier in the
> same function.
>
>         branch =3D ac < 2 ? "HEAD" : av[1];
>
> We would create a new directory in ../topic-branch next door, and
> then which branch would we check out?  Would dwim_orphan() kick in?
>
> Perhaps we want to update that code path to disambiguate the same way?

In the case of
         git worktree add ../topic-branch
invocation, multiple match can occur in dwim_branch() if there is a
'worktree.guessremote=3Dtrue' config or one specifies '--guess-remote'
option.Then it creates a branch named 'topic-branch' from HEAD, and
the command exits with success.

My initial patch included a warning and advice here,
but now I don't think they are necessary.

Even if multiple remotes match here, the command completes
successfully. This could well be the intended behavior
(just as when there is no match). In that case, a warning
or advice might be superfluous.

From the perspective of offering advice that actually
helps the user, since the branch and worktree have already
been created, the appropriate guidance would be to suggest
deleting them and starting over. That, however, would
likely make the message even longer.

If there were an option (which currently doesn't exist)
to make the command fail when remote inference fails,
then I think it would be appropriate to issue the same
advice and error message as in "ac =3D=3D 2" case.

Thanks,
--
Yoichi NAKAYAMA
