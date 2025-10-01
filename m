Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E81313D75
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354184; cv=none; b=VXeJ4diOwwjULpvAbKUvr8w7wcc5PmbPyTyxgWlhHZfd6EwWOcOAXWIfmNzD5B04s0+mnmPSVUlEE4Sb3OBHSGLx681Hp8GBZRPSYNjyCuYqHPxAEaFNKCEhdNue/M4K6N36WJ85XPAyyGl2FiGI5rmnkSHiO0eMRnxSIkZ0h3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354184; c=relaxed/simple;
	bh=X2TVavdQWe9GcsdFtcA+Oe0I2GKwUIlrjpjoCZT//dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUXJK2fY/GoxT2t7u/aa9d60X/+NHaPYa5X8FjhQVtKYv8CihNO1Kn0ipIqcvUJIh9P4bS0ycDCmXcPdG/xQkOJ3r13Q5bJJVPnGUsHC73dD5ZGgb18kSP5XXGCmRmtuqdNT0FZR1hwfyFMxwU5ERc0NzkXUZtOuDifDCuPK12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78f5d692d09so339966d6.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 14:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354181; x=1759958981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1pVTVatWaW8W5KBjNIsVqAvSwpoNR5iqGfODUtg4/8=;
        b=m/cY5aHb+fb4Ickb1pZvmeyecIIi0aZ6xVhS8/0+LKB44B4zYTjodKfhkdLrgDxR66
         I8opz+2L396bkUl3EZsgD0R49hHB17fa+gnVWnRoTLobZNzuDNE13aWRGRvL5ojQu9+a
         XS6mMLj+IMBpZNkCtT4WgYsatIzPQDDtoCB1yVNICDlFl3tPxJ17gvl4hUNKe+YODS1u
         eY51lRK7uJLKTRNQEQW8E+jcwBoaHuDLNoo8PaZlaBenBSFSABuXeku8YV4kl4boaxrq
         sJnmtoNlMldNPjaz+1G6HXPiq2CAUg8wC+GI4tnzDsgFm0mezuXyf4ov3+juAeOnnfU1
         QVOw==
X-Forwarded-Encrypted: i=1; AJvYcCWXuwt4YhIY1prL6ROIyldUqEHzD93U9MTf3OnhGW9SQTUiCOpdHPzkok0+2fzUAzfq5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzNZ7A2Xkky/8w3K3RdxN34GP0qc0mBe+2kCCr0mKQcr86Loo
	SgivV4cOHeegfd3uxM25Knwm1ReK6oSo3FildJ0WcJrxoo5jCT5C4DO55sP1Y/nSk5J9beHy4ri
	7d5stfndrhWxNpjjp7Lh2v26sE2d9DsM=
X-Gm-Gg: ASbGncsvl3yGq3+uZKPh8+NhK6JZpXxmjKkRbLTKjupEA9zrGchQprgVOMEVQtMMHCQ
	Sy/k5784ELIgH120YAQ+sWxAk/O5ovnMbxLn2A7S4GRe69gjweA7CxzONYMw/AQ/MLkq6c/+MRY
	dG/vm2XA9+KS0tFsOxRP+R/FCLQTIJh4TT8Hdw+LbssKOMjJag/9ZgZfD9XiwGhojRL86vYGnqC
	tTTjYYtWEV+S55Zh9vHm+GZkRVG0eenjEiI6cN6sYOOp2mnBaopwoIhXM6zflR6
X-Google-Smtp-Source: AGHT+IE5ego9+hLeivqXKxq4tPD2srOC2piB9Q6CRAr5gvuRi8GFgFTGPMvZqGiNYEh0zU7hsUo4AlIrhso9eKExNlc=
X-Received: by 2002:a05:6214:f6a:b0:795:3dff:55dc with SMTP id
 6a1803df08f44-873ac1c8b0amr44930006d6.8.1759354181105; Wed, 01 Oct 2025
 14:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNuy1aab954D3rJ1@kitsune.suse.cz> <E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
 <xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru> <xmqqa52a1h6x.fsf@gitster.g>
In-Reply-To: <xmqqa52a1h6x.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 1 Oct 2025 17:29:29 -0400
X-Gm-Features: AS18NWAsd7E2OyhT0aUciPtZW4SzAo94H6jh-hZT523QqSUFeBrpzXa9DTdCkfw
Message-ID: <CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
Subject: Re: What is the reason behind not hiding git worktrees from git?
To: Junio C Hamano <gitster@pobox.com>
Cc: Sergey Organov <sorganov@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jason Cho <jason11choca@proton.me>, "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 4:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Sergey Organov <sorganov@gmail.com> writes:
> > Also, I'm almost sure that the first thing almost every worktree novice
> > does (I did), quite naturally, is:
> >
> > $ git wotktree add <branch>
> >
> > that happily succeeds /anywhere/ inside primary worktree without any
> > warning for me. It probably should either have created $top/../<branch>
> > instead, or refuse to proceed without confirmation in the first place.
>
> Yeah, I almost never type 'git worktree add <directory>' without
> "../" at the beginning of the directory, and every time I do so, I
> do wonder if this is a UI pitfall that we should warn the users
> about.  Perhaps we should start from documentation updates and
> possibly a new warning or two?

Every example in the git-worktree documentation which mentions a
literal path (as opposed to generic <path>) already uses the "../"
prefix (and has from inception), including the example in the
introductory paragraphs:

    For instance, `git worktree add ../hotfix` creates new branch hotfix
    and checks it out at path `../hotfix`.

and the "real" Example block toward the end of the man page:

    $ git worktree add -b emergency-fix ../temp master
    $ pushd ../temp
    # ... hack hack hack ...
    $ git commit -a -m 'emergency fix for boss'
    $ popd
    $ git worktree remove ../temp

There are exactly zero examples in the man page lacking the "../" prefix.

It would be possible, of course, to add a "best practices" section to
the introductory paragraphs advising against creating worktrees as
subdirectories of the "main" worktree (assuming people even agree that
a best practice is to place worktrees elsewhere). However, considering
that the existing examples using "../" have been ignored (in a
fashion), one wonders how much a "best practices" discussion would
help (assuming people aren't really reading the documentation anyhow,
and may very well be cargo-culting git-worktree commands from blogs or
external tutorials).

Regarding issuing warnings: I'm not fond of the idea. There are plenty
of people who already locate worktrees as subdirectories of the main
worktree[*] and do so without problem, and for whom it is a preferred
workflow, so I don't see why we would want to penalize them by warning
against doing so, especially since there is no technical reason to
avoid the practice (i.e. Git handles it just fine). The only minor
downside of the practice (if one considers it a downside) is an
aesthetic one: having to update ".gitignore" or ".git/info/exclude",
or to simply consider them "visual noise" in git-status output and
skip over them when scanning the output. Moreover, I think this is the
first time that we have (on the list, at least) heard a complaint
about the "noise", which may suggest that this is a non-issue for most
people, and that a warning telling people to avoid the practice would
be unwelcome.

Aside: It might be valuable to extend the documentation to add a
discussion about hanging worktrees off of a bare repository. People do
use such a workflow, and git-worktree officially supports it, but I
don't think there is any in-project documentation which mentions it.

FOOTNOTES

[*]: There have been numerous emails on the list showing that placing
worktrees as subdirectories of the main worktree is common enough
practice. And, as far as "experienced users" are concerned (not just
novices picking up the practice from blogs or tutorials), I recall an
email discussion in which Dscho has said that he locates worktrees as
subdirectories of the main worktree, as well. I, too, have done so on
occasion.
