Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAC23B0
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535885; cv=none; b=eua0VxK3+1mkyVL3HjHA9eo2LY1qTmQVG21syRSemr46eZTz5udREInerJlZGLnrpMOPW+lyT8bs0ZH+8XK7WONssOJLtgAKk7eRtKDdjbzPm8uVfoqORZiM03I9tos1nvBs2KN31DVJr70sSgC2WG+EdyE5OEbSMWZYnOzWgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535885; c=relaxed/simple;
	bh=dAq2b8Wuta1DDcSCSTPucgYxCsmSB5NmVgC6RMcZpx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPdFiihYePsC0MU5t9tv+ofCtKhXanqJoJcxBW7tG1v46T/jojItoBm8BWPAISTKCemyHR2pxItPfBqP+DGHdcQKHjc3DoXewrFg5r0Nh2pcMrrtVBpiAOurQaP1eBitjnlqMPg0AepEw5Z3ljLq1evaUKIk7hz6BnRJr+Cv8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfYaNtFR; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfYaNtFR"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ea0b5e0977so1154239f.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719535883; x=1720140683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUzZStLYMHkZD8V3fLL8EuFd6XQCUSmG9ZI2Sx68zMA=;
        b=FfYaNtFRrgzzoTUKjNCxdo+S5NwUoWdDqF+b+S+qe6aY1a6wbenc4XPmMHd6pQ1jR/
         o3PzE1BlUOOoCyh2DP+xpazb5Bz3Alqp3RnLhvzdO/5zQaliS4yn2fn8azlcR19XgIih
         gWQ4VqiumHppWRkNDEej70Hpe2lv28StTOz+U5lu09eGF++5q+SsLHXKhCWQa2VRu8yH
         7lhz2UL6DnjYjq1JnVi4twaxcgcbirpE84iv6Re7Uc46SCDaI39hSdPrxx+puoVv6wmf
         wl9q6t7RrRZY0EnriM6blGNrVHE8kvJicS/D0sUEuhNZqQy6Z2p3hX32iVFOWGROHbKU
         5FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535883; x=1720140683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUzZStLYMHkZD8V3fLL8EuFd6XQCUSmG9ZI2Sx68zMA=;
        b=RUXlA8izkDhuv5qMQwBuczK4x5hueGS27o7Ur2rePwU3g8UjDxAeiheI2Wwo91u48W
         Yqut9gfOAJckrfmOS3mNkBA72TeHDnuN9gA2YXVquPwvoVgwLrLy2J964D5mDRbf2JET
         wMmn/7tHBUk8Ql7WM0l4+EZdAvXEnnu4Tig62nxyomytfv+xLCmnJQitDUl2sElqIunv
         9ONUhEUhwhGaARzWdiIKa4LtoK2YD/xHhFF0HrX95yo8UfhF6h9KSbZqY2unC21ipJP2
         BT4yBw8yE/DytcNrthyc69VmiEHGZ15X0dgs6e0cnjfTRR4cKeFqaQ98rP6sp/WOHTSL
         QJIg==
X-Forwarded-Encrypted: i=1; AJvYcCU9IFifNB9NNraC/3yxb+H6Pjoio4VijvFFkhXaVNhJvRXfmv+/25y4jiWSXzDE//NX6vCtGhK6lizszTTYqZD2Jsq3
X-Gm-Message-State: AOJu0YxVQ4I75zF7fSpc7rcPCwIO7Rn+vzJgnz5oxtG7ms/3Jhfw+Ro6
	bvrcWNehx/yhsZdXqX6KgfMO4cvDlI7Vf8CDfhDQQ0h2FHxruNgjjIZUKJiQKAIWz/d/yXoq43v
	KYevsyT2qKJE6YUWvusy3zzOVz+M=
X-Google-Smtp-Source: AGHT+IFZpqJaFN78OC3rPCS9Wfl343PjAVMT7rIyHIWvh5QaIHzVZ8f9OIOJe3+3hdBBdq+uesXrSNfpoJCDHgBKpRo=
X-Received: by 2002:a05:6602:154f:b0:7eb:7f2e:5b41 with SMTP id
 ca18e2360f4ac-7f3a74e4cbcmr1973193439f.9.1719535883039; Thu, 27 Jun 2024
 17:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com> <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
 <xmqq7ceat83v.fsf@gitster.g>
In-Reply-To: <xmqq7ceat83v.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Jun 2024 17:51:00 -0700
Message-ID: <CABPp-BExeTYSpg0d-5F5cdwM8UZzU625A+6uaDhpWgBRjVrd7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry logic
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 1:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -void clear_skip_worktree_from_present_files(struct index_state *istate=
)
> > +static int clear_skip_worktree_from_present_files_sparse(struct index_=
state *istate)
> >  {
> >       const char *last_dirname =3D NULL;
> >       size_t dir_len =3D 0;
> >       int dir_found =3D 1;
> >
> > -     int i;
> > -     int path_count[2] =3D {0, 0};
> > -     int restarted =3D 0;
> > +     int path_count =3D 0;
> > +     int to_restart =3D 0;
> >
> > -     if (!core_apply_sparse_checkout ||
> > -         sparse_expect_files_outside_of_patterns)
> > -             return;
> > -
> > -     trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les",
> > +     trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les_sparse",
> >                           istate->repo);
> > -restart:
> > -     for (i =3D 0; i < istate->cache_nr; i++) {
> > +     for (int i =3D 0; i < istate->cache_nr; i++) {
> >               struct cache_entry *ce =3D istate->cache[i];
> >
> >               if (ce_skip_worktree(ce)) {
> > -                     path_count[restarted]++;
> > +                     path_count++;
> >                       if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found)) {
> >                               if (S_ISSPARSEDIR(ce->ce_mode)) {
> > -                                     if (restarted)
> > -                                             BUG("ensure-full-index di=
d not fully flatten?");
> > -                                     ensure_full_index(istate);
> > -                                     restarted =3D 1;
> > -                                     goto restart;
> > +                                     to_restart =3D 1;
> > +                                     break;
> >                               }
> >                               ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
> >                       }
> >               }
> >       }
>
> Both original and the rewritten code shares one trait, which is that
> it goes from the beginning to check all paths that are marked with
> SKIP_WORKTREE bit to clear CE_SKIP_WORKTREE bits from them, until
> they find a S_ISSPARSEDIR entry and lazily call ensure_full_index(),
> but then when retrying after calling ensure_full_index(), it
> restarts from the beginning.  I wonder if it would help, especially
> if the S_ISSPARSEDIR entry comes very late in the index (e.g., by

"the S_ISSPARSEDIR entry"?  Are you assuming there is only one?

> returning "here is where we have already checked during the first
> run, until we realized that we first need to do ensure_full_index()"
> to the caller from here, and then the caller tells the second phase
> to restart from there), to reduce the number of calls to path_found()?

My first assumption about how to "restart from there", was to pass the
current index, i, to the more involved check.  That might fail to be
the correct index when there are multiple S_ISSPARSEDIR entries and
the first one (or more) are actually missing from the working copy as
expected.  However, if "restart from there" is just passing the
name of the relevant directory and we do some kind of binary search to
find where the earliest entry under that directory would exist in the
expanded index, then that seems like a reasonable additional
optimization.
