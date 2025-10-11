Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955F85626
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760159881; cv=none; b=OpDWUyuncqKsoSKD1xFCXTzEnHeUN+PpmNOrvUCYwSxIdg0ugTbPvXn7RcXAWSQx3AVahBWAVix1aVX/MksOJPLuL2PFleP+f8so7GX+diKTyv4g8DAHu+lAhdeagBOkWea1UruxJYNLHNMV7zVrcnvMJ54z8ttcA+u7KYvRK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760159881; c=relaxed/simple;
	bh=AbgSFvUymoPrdUekvEsJLC6OtuHbr1EG0kixLwizrRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn/0X64G8lbkjhtyC4ZQX2rHVWUeE0HtNeuCWrGg20Ml/NIqKdv4ZgSdt+KJx004DsF4cBfSe6gA9JYDkHD3gpjhte2RY/LCGfOWSISEaFlxINFofhFab28L+8OxTAobfsw/KrwEkv/prFBAKwHBoWm0ko9FCDj3UhjMUcXNt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-85d0740e6b7so43085185a.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760159879; x=1760764679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgxXEXkoLkB+hDuPfqvRrVugyJ7vcluSypDiXT5eKBg=;
        b=HuuOKG6iKja1c2AcZF0TzWa6MxnZmsN9TQ1fzpoIFABxny4CfMpBw+1gsju2mIi6Aw
         n7oqLimw7pjn6YvgE39CuI+ekOiT13QURnBrJfpKpoNdgKU0sa3cZYIWJWDHmFDfq7Ww
         O5fLY3/tYGNtxkbfkUjTRh3j7blb6yhlj+S2nVkhe2xUIcHq489Du5RgyyCmjPI8tycf
         DCxf00Y1jfLDbuP6gq1416DcZM/zxAdFmbob7u+eEK7p3tfbpMGw8GVKd+JhiCMh+V7T
         3YxXsYDmOvaxZ40xuTpOVUzcFmyKLzLKJiR2JiQjI3KdC625tSqMdGYMnOAcR54VU8Yg
         kMSw==
X-Gm-Message-State: AOJu0Yw/pnSJS5fROXV45E4juC8KXs+mYd3tknE7+rTjzKPxITF2Y4Z9
	kemkNV+POQcymCl7K6a5UK6kpRmYiPg0kKhpeLu2HHyxLDxlv4vWLhW/HKIsJbQHs9TFXTJfSyr
	/usraoo8Zj6j1IFtMi2h8m65kuWZHFU8=
X-Gm-Gg: ASbGnct3Z18+t7Ks0aIjR0ykB1EElmnCzZ9clmSRHDcsS1zQRObKmXorT/XINuf16/3
	gqbS+Jq7RT37TP3VhVvwhQIrRWXd5VWp77z3lNsphdUDv3zwLYNhSlDijMkbr2DlkzEa2ebZ2mH
	IVD2tYUXUHz4t0O7Poi7YWpJeQb2wHa46L0ubDUYRZwiyq2HrcyJyBFP/t7iGZ4Zs3qUQ1Ddwho
	PjRhbnd5VAiDX9sPfduXXJi2fprKB2VE0PPeI9kI/baATB6ydTuu47hXqEnqHr8GSOnxQ==
X-Google-Smtp-Source: AGHT+IGiDGrEwwW8kF8VLqOjKacwmB1z12a7yrz4vAStVf/hovTyL3Cn65lRMxtyp6esqxnH8R3a+f9qDTq1ETkELwc=
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id
 d75a77b69052e-4e6eaf1f297mr136853711cf.2.1760159878508; Fri, 10 Oct 2025
 22:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
In-Reply-To: <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 11 Oct 2025 01:17:47 -0400
X-Gm-Features: AS18NWAvxHmf3mhgVNgsUONetU7DuIW3gmTrxcV7N75F5fjeRUOMzXHY--Mt5xA
Message-ID: <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jason Cho <jason11choca@proton.me>, 
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:05=E2=80=AFPM Michal Suchanek <msuchanek@suse.de>=
 wrote:
> doc: git-worktree: Add side by side branch checkout example

Thanks for taking my suggestion[*] regarding a possible git-worktree
documentation update and turning it into an actual patch. This is a
reasonable beginning, but I think it needs more work.

To begin, the idea was to document that worktrees can be used with
bare repositories, but neither the subject of this patch nor the prose
added to the documentation itself mentions bare worktrees. Instead,
they mention only "side by side branch checkouts", but I'm not even
sure what that means. I certainly wouldn't think of "bare repository"
when given the phrase "side by side branch checkouts", and I'm pretty
sure that phrase is not part of the existing Git lexicon, whereas
"bare repository" is, and is well known and well understood. So, I
think both the commit message and the prose added to the documentation
ought to mention "bare repository" instead.

Next, I think it is quite important that we spell out concretely in
prose that worktrees can be used with a bare repository. It is not
sufficient to merely infer it by giving an example, especially if the
reader is primarily reading the git-worktree.txt introductory material
which explains what worktrees are all about. So, for instance, we
could expand the "The new worktree is called..." introductory
paragraph to instead say something like this:

    This new worktree is called a "linked worktree" as opposed to the
    "main worktree" prepared by git-init(1) or git-clone(1). A
    repository has one main worktree (if it=E2=80=99s not a bare repository=
)
    and zero or more linked worktrees. Linked worktrees can also be
    used with a bare repository, in which case there is no main
    worktree but *only* linked worktrees (see EXAMPLES).

and also move the "When you are done with..." sentence from that
paragraph down to the "If a working tree is deleted..." paragraph,
which would become:

    When you are done with a linked worktree, remove it with `git
    worktree remove`. If a working tree is deleted without using `git
    worktree remove`, then its associated administrative files, which
    reside in the repository (see "DETAILS" below)...

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree=
.adoc
> @@ -526,6 +526,16 @@ $ popd
>  $ git worktree remove ../temp
>  ------------
>
> +Side by side branch checkouts for a repository using multiple worktrees
> +
> +------------
> +mkdir some-repository
> +cd some-repository
> +git clone --bare gitforge@someforge.example.com:some-org/some-repository=
 some-repository.git
> +git --git-dir=3Dsome-repository.git worktree add some-branch
> +git --git-dir=3Dsome-repository.git worktree add another-branch
> +------------

Several comments...

First, as mentioned above, rather than using the phrasing "side by
side branch checkouts", let's talk about this as being an example of
using worktrees with a bare repository.

Second, for consistency, let's follow the lead of the existing example
in git-worktree.txt and show the "$" shell prompt preceding the
commands. For instance:

    $ mkdir ...
    $ git clone ...

Third, the example seems overly complicated, especially with its use
of `--git-dir`, which feels less discoverable (at least to me) than,
say `-C`. What I have in mind is an example more like this:

    $ git clone --bare <repository-url> myproj.git
    $ git -C myproj.git worktree add feature-a
    $ git -C myproj.git worktree add feature-b

That should be more than sufficient to get people up and running with
associating worktrees to a bare repository.

[*] https://lore.kernel.org/git/CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R=
4oO1m2xA@mail.gmail.com/
