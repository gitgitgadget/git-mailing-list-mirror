Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA036A03F
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594142; cv=pass; b=Ys7CsqOhW6ahSvZSk4G0LJrA3rPTtYEZco9NO1rWGWn/8oJ51/usl8/jR/MDQ7W7fKs9w/NboxhpNnzdM5AmqetVbkLgtZIcaHCrONuKp0EoM/7EE3taUKgZScVwwzsFTpwiE1GfLghw5y25hrQRqqwTJtdi1ldHCD/HdvKYtOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594142; c=relaxed/simple;
	bh=myXQGl8lbU7qkcTMey2URBif8P+DeSG3OcId8pHm5to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfIWV0iYVIxgJ5MpYci/NBuDqYMb3XuWG3RdkKo+gHJUq13gH/e+aicO1LyG2sALnO5Lejy4uumUXwKpERb1kUmjxXto9nARKGWWtBVw4SATxXhY853Z7Ai65o0LNpOjHx9HfWnOftj03Brqotkb2t91YdiXjY5cETmgy7A0hiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=izeA5zht; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="izeA5zht"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4865e952fd9so913566b6e.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 17:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784594139; cv=none;
        d=google.com; s=arc-20260327;
        b=Rv3pt9xEjZYhnWIwXCjgZ5hWHcXySDIOr94dsCXvP8x+Wc1F1ddSYTlFW2DWLqcQoo
         FT4jFl5WncsUf4iYgEaj5OcjVrLpemEKR+AImI+34dTGW1fnHEgHO5fKE4kT6L6fWUm7
         tgWIItFj+DuMTVi7DQyKH8cuEVQgBxZk3oC7wUy+ftLLHtfJKZMWmfJxeZ6xvghLeq6V
         jflR1FMJBActSinUhf5eCtpScpC5EjR6bHbPf5KKCtlow4ivnLRjyuaxvJ5lLuzvlTdn
         1AKagJ6ox1j4Z9JUlwumeGHGr81DksBAXf6eRVHTD9R+9FikN/ni7Bq37oPt6WQVkEEa
         BUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwI1pyipoJ5BMBRbPX1H327TwfWxJoWLFA9ppAabhGI=;
        fh=/nbVX6AtGa+uMnwd080xb+07E+PZU2aRqXaxv048ys8=;
        b=O65gE46ZSx3y1e6r/RZqUpmpNqnbIBGJLzEY3zVf4DzqATh/wd7nGaq+itQsi16Oul
         qWh4YzRLEreD+z1JSSvRNpyYoz6s/kK3R91pi5irdnYPBccjX0DKUYZzz8m61L2y4BYi
         f9XKe06uec76Se5WfJnY9cw2jv01a10hdD81MHzKBTjXMUeV4hNcj75tHLvhL9iXAWV+
         z8IHtrj+GES722d62dFQRTv+sTaL+ZSlSDVxLhWZNGE8s7NL3bM+N5OSo2tyudjlXwRe
         CzFJEcuR63SAq7iwAe2NA2ulq35C5Uz1X3DCOv1/eJRzNQtEP/ayBdecwMx/iu4aMx1C
         l/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1784594139; x=1785198939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwI1pyipoJ5BMBRbPX1H327TwfWxJoWLFA9ppAabhGI=;
        b=izeA5zhtE9NOHr3lw/Ai1ZpJEg/Hopa9nLVSBOV+Y1g93Jc83TjEtNqn36U4eazdA7
         hM1ixXeuMIrISV29t5QPpLyVokrCHYyGHUc3VQsguoMR3PfRO1CEytOHP0JDf5BpOAcX
         Gyu85Bn+MvF+ugsQYGNghnObHS8scZn/eAP9AhAvJjd3MUrkyGq4m0nwxT2HjXxT8lxu
         VGRJeHmvahdmk5Y4QCVdHEqIw9xO8iLEdxGhlu9+CVNXT7KjIfx4kqbn8Sw9sm8M5z4R
         cBch9NapXkU6sPoJRRRM1LmiJLL6va+eiEdqa3IRmNp+Gwdw8+EkXZTMyEAttrhYAaEm
         AVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784594139; x=1785198939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwI1pyipoJ5BMBRbPX1H327TwfWxJoWLFA9ppAabhGI=;
        b=h60fG9mXyM3gukAFT0RFji9uBSimgZV/4WpmbulGzi0pf9PT9InMAqvPnzRzDFTMNS
         Lz1YMwxmf4TcJ0tTRteAZSgcUTkrqSWyMvPtFTFrT3mChyyDvZJ4pdifLQCsIarmtAM6
         KPU+4S61Sld+qreS2SPdrFK9vTyaNvnGBs4ewVa0IvxxMmKwr6lpR3A4Mus9FKTqn9eo
         DrWoRbIERq1iKgZJ6wSFPmWwRdzKpb2nd1fUnicUVQNjmzizI261aU8rzc+9tRD0tSnN
         z+RMmM16YasVbXjUJ3i9snyfiNJjUtg5jhhimSTIM1OJ/Zh+G9TtYUMVApHP8a7odTAc
         HASA==
X-Forwarded-Encrypted: i=1; AHgh+Ror+Ap8YjV1Znxm0080Yox2dVS9EN/3xMJPmfJ1nsdZyq0D7qx/226dKGweyIC02WpaqBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ERTNyCb1K+OjZjIs8BEZfNG/0XP0X5IKa94vn6u22rZj5TK0
	2NfuK7EhIgyRRaUU8SkDJCIbfN+gEYFE7GrSBof/VpfsCIbWQ5DDc8QtjxZT3CqwVxyGaq0q8Lc
	2p9FRWlTiibKSp/Q/uVVHqVdXppDzCk21x6ZFydWgjlBokE2MK9pt9TR8EA==
X-Gm-Gg: AfdE7clZMMT/fb8wvWC37vs4AkLKGy0NiJv9mYyIOikX0ABDjCz6D93CX/HSEGOPUHE
	nxelOdf2DrijkQXxjPN3CSExvHos50uPlsdUybgQkeM81fd0lsSy8Nf/7bS9Hh8wgoWWIKjW8nW
	jwuV16jNnKZ1r+Vee5kNs8Jh0nyK3hkLqOjTUC9Ig5HF80aNwOpHuQ9/wsmJrebm7gZKC4gQOHw
	urEEKOj5XVSpGXG/VTJhbOuiqKIg0zAZQ8APOG/X/5hAcSGRm3GFzLBcRhs
X-Received: by 2002:a05:6808:13ca:b0:496:9bf:c837 with SMTP id
 5614622812f47-4a97b9af548mr404985b6e.0.1784594138876; Mon, 20 Jul 2026
 17:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME2PR01MB5490E3CE825C83474D1573CED1F52@ME2PR01MB5490.ausprd01.prod.outlook.com>
 <xmqqbjcnizr1.fsf@gitster.g>
In-Reply-To: <xmqqbjcnizr1.fsf@gitster.g>
From: Jerry Zhang <jerry@skydio.com>
Date: Mon, 20 Jul 2026 17:35:27 -0700
X-Gm-Features: AUfX_mzHPa9mZUR7jYqY1X5IkysDOjrzuFYbfVRVpRvfmPVCEdkqu4pKXW9_iLk
Message-ID: <CAMKO5Cu0i3UKT61th3ZUiiQTkPa+YtxGQAQSXJjNWGWaTs8OGg@mail.gmail.com>
Subject: Re: Bug report - git rev-list --exclude-first-parent-only [SEC=UNOFFICIAL]
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Hore <Michael.Hore@asic.gov.au>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 1:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Michael Hore <Michael.Hore@asic.gov.au> writes:
>
> > I believe I have found a bug -
> >
> > My repo has a commit structure like
> >
> > R2
> > |\
> > | F
> > |/
> > R1
> >
> > i.e.
> >  - there is a merge commit R2 with parents R1 and F
> >  - the parent of F is R1
>
> IOW, R2 is a useless merge that could have been a simple
> fast-forward directly to F.
>
> > I ran "git rev-list --exclude-first-parent-only F ^R2"
> >
> > it gave the expected result: "F"
> >
> > I ran "git rev-list --exclude-first-parent-only F R1 ^R2"
> >
> > I expected the same result, but I got an unexpected result - nothing at=
 all
>
> This seems to have come from 9d505b7b49 (git-rev-list: add
> --exclude-first-parent-only flag, 2022-01-11).  I do not know if the
> original author is still around, but it would have been nicer to ask
> for input from them (cc'ed).
>
> A fix could be something along this line, but I've never used this
> feature even once (I instead use Michael Haggerty's exellent "git
> when-merged" thing), so I may very well be breaking _other_ use
> cases this feature was originally intended for without knowing.
fwiw when-merged seems to be asking the question "when was X branch
merged into the
baseline", while exclude-first-parent-only is asking "when did X
branch first split off from
the baseline". of course that property may not be interesting to you
if you're looking for the
former.
>
> The patched part is inside a huge "while (parent)" loop.  The idea
> is to break out before the loop goes on to smudge later parents when
> we are in the "smudge only first parent as uninteresting, without
> contaminating the history leading to other parents" mode.
>
>  revision.c                   | 10 ++++++++--
>  t/t6012-rev-list-simplify.sh | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git c/revision.c w/revision.c
> index e91d7e1f11..1f50d42a7a 100644
> --- c/revision.c
> +++ w/revision.c
> @@ -1151,12 +1151,18 @@ static int process_parents(struct rev_info *revs,=
 struct commit *commit,
>                         if (p)
>                                 p->object.flags |=3D UNINTERESTING |
>                                                    CHILD_VISITED;
> -                       if (repo_parse_commit_gently(revs->repo, p, 1) < =
0)
> +                       if (repo_parse_commit_gently(revs->repo, p, 1) < =
0) {
> +                               if (revs->exclude_first_parent_only)
> +                                       break;
>                                 continue;
> +                       }
>                         if (p->parents)
>                                 mark_parents_uninteresting(revs, p);
> -                       if (p->object.flags & SEEN)
> +                       if (p->object.flags & SEEN) {
> +                               if (revs->exclude_first_parent_only)
> +                                       break;
>                                 continue;
> +                       }
>                         p->object.flags |=3D (SEEN | NOT_USER_GIVEN);
>                         if (queue)
>                                 prio_queue_put(queue, p);
> diff --git c/t/t6012-rev-list-simplify.sh w/t/t6012-rev-list-simplify.sh
> index 4cecb6224c..2284bbba12 100755
> --- c/t/t6012-rev-list-simplify.sh
> +++ w/t/t6012-rev-list-simplify.sh
> @@ -285,4 +285,22 @@ test_expect_success 'log --graph --simplify-merges -=
-show-pulls' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'exclude-first-parent-only with parent already seen'=
 '
> +       git checkout --orphan test-seen &&
> +       git rm -rf . &&
> +       test_commit r1 &&
> +       git checkout -b branch-f &&
> +       test_commit f &&
> +       git checkout test-seen &&
> +       git merge --no-ff --no-edit -m r2 branch-f &&
> +       git tag r2 &&
> +
> +       git rev-list --exclude-first-parent-only f ^r2 >actual &&
> +       git rev-parse f >expect &&
> +       test_cmp expect actual &&
> +
> +       git rev-list --exclude-first-parent-only f r1 ^r2 >actual2 &&
> +       test_cmp expect actual2
> +'
> +
>  test_done
>
Its been a while since i've looked at the code, but the rationale and
test case make sense to me. thanks

Reviewed-by: Jerry Zhang <jerry@skydio.com>
