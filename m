Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8D3D1CD1
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536654; cv=pass; b=hGoNVz/M7foYVYS7ZUan2p8F5jvNcgEOP9/jCKdM2v98ig3Q0yyfysZP3WBzNC30LTdTdaVl9Lb2fa6WTaG6KksUUZOp3JG3/F9kZ7ccV5xk+1BA/NMfwx3B3dnSx81PXEUKhc+N1c+x/iBPh5oEVopRP1FmfJ26RLFPxdVJPdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536654; c=relaxed/simple;
	bh=FNmj1zzj2PHQV6yADJPtMqaI3yemBpDL5/VJGsIbmaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdoeMD1XI9IYko9y4v4Whr1G5y6fXRCIbw2YGZqXU7IFKtaSgDqwXt6s9j9bG7EK33oHAlr20XyCy9ERB9dAvsy2atIVsthAb/W+2SwWmhTxq64mSnhGQT1zbYGgjYO/mS9r6S+zyzC133u9S1DZFvMTxmCzLmcuMENsY8NBa2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVpgF6JK; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVpgF6JK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1685266b3a.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536653; cv=none;
        d=google.com; s=arc-20240605;
        b=M5UHQyDF6Jlq5oTvM9UvGeRn1q2wjO7JUpm9eoIYgair5odrZiRcQGWRc6pDeMbhOg
         CNlhcmX18BKIUOKuteaU1so3qXE26HpydH7oP1oviETtwk9WHlmsKCQvqW/frO2S7q1a
         hF+mu3Jp8p5/te7luagj7iZNG8OWQ7pg96xr5PsBnCplAfZgSa4LJSTBlTes2zR3zldA
         6AhosIhQRpgZQABFQUonrWefvSw34ucMAenaiskX1cp/JX6Gse0Xgmoc+nLYSQEgTWXS
         QxO5hihRAi64DGe+utCqCsaaxkP9ESGNVDXrAolyqIRWUbEgi7M2293viZG6COkTfdX0
         TXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tnaGHGrPMnas8VVPUAn0I34cmBqD6ShZsKLrUJhrnEI=;
        fh=en1VouKqo+qtqgBDqIMvG38vG9V56hlN9Ems/+TZKXQ=;
        b=bvwBSLlJVeURvui2GDcZ+19P/4UpqeGpf2GSYkWfBEa+8+MGo91l+/YNUuehKN8fOn
         xkynGbvfgF20sVcwYjRAyoOHEBP7AAOhJpVYFRZhdkkpG8KUC4Ow8VGqN2/GMW0WCXS1
         9WWuElsRHXOOooFhuEYFSiqxF4zZi1AadtCdd4NmTJlTvk/O+9oL6BlJyhmElXKf1iel
         zR8N9Tki15TBf1H3uxeSY6aUirYutvwNebDASlgBdwM1y/jJpJ4SUbCiw1CUk84Eqngl
         YpZsnpaQAamj+Lv8rzfrKjrTdjUGmoUIJT+NmbPd8ygFsRHtx4wKOuvAkgtocToZVO7a
         sbwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536653; x=1782141453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnaGHGrPMnas8VVPUAn0I34cmBqD6ShZsKLrUJhrnEI=;
        b=aVpgF6JKN4xe5SVORaDlGfJKpxfvep3cKtGFgBY5ndZZuFEkpIkTSXfroBctwvDSL3
         HhVJH1jxnUbNAeiHuz84aXQ7W5mJGweZ+09PMMbYfoBVZ2w1Lc6YwsLqiq4yAXfZ9bea
         dJGSXogQSQmy4ztSFeIYe6SOzkoa974YBXt+matFRpszqd+/DVoqKMvyZazSY6oKtIeH
         BSyJSMczlHzQLjEJp7/K5/VOiwzP8jjQCCoDt2t8Zjsxk4uIi+bsLhGuj8Sb/8IX5XpN
         LM7Tko8SudsqmwbWbWT6yt7r4HpEU+5GaF748wwqSZ2Uu1gJW2dqcMm8b3jxHwByCVJ9
         r0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536653; x=1782141453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnaGHGrPMnas8VVPUAn0I34cmBqD6ShZsKLrUJhrnEI=;
        b=Ya+X6sSj8TradSws0pev5PxK7dRisYC0r/wn3k+/Y6rYpdrzmgKm6eK0ndGJ1RoJXl
         QGfjZC+X+bRj5UxCc4XE7hBgX4Yh/mX3jXutD0ShPO2gBZfwoQO6OFRmLIc30WZqsrf1
         B4DRAkDw07e/OOhHZOl6BOLK5aeXjFuGejHftGsf1Gz6cfeN6JTXlcrEMLl00Z3xRPh+
         cqSrJGOkIfv/uhDyROXufHVdl5dtoEnyKwm/Fx9dXHKtuxz6b60mXMYmh/RfdEZQMyoW
         nV+3mCXSc8gCmDBMZl4fX8gqdmr7PUvib0ZtiiAS6qvU+YDHhrhb1CqJbgNdXSoaJIvt
         cFNA==
X-Forwarded-Encrypted: i=1; AFNElJ/kJLNh6SZmAKoSuvgG+tPrWz5VG6ItiLAWRFw3nc5bjy58ZWV4ldwKxiyOI28H2ul02Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFXl3zbgvG7Cj0DsIK2zz4n/YWPr5cjZbGI+1hGZ8gOLQoEcJ
	J+i+ohENms3Pc7A8vXjSVsYPMKMABbk9JvCgfmO6+bLFH9LGSHWcjdoEWE1ToAd9Sk+xZnEWrwI
	TPCGCGP7/1zitHQTMI3cR88DIHA40Ne0=
X-Gm-Gg: Acq92OG7JqOn9p9SyY9KvUh2bqmDo3ot1N1zoMAB4ik1WLnmV5sFw9gA3/KsAo4WB2h
	U4jr0/gfWPLbZyUehpu12jA155FVvDbSYviH5ep5F4kV4BtjubxuPFx1U9yAUka0dedD/qveWkp
	CS15Mo6o3X1pM26lLhRo7gyBxY2YmXkr++9hJkjAqGXu9B3fBesIMr16JbPN6rHPFwPZDeEqEN6
	NKpp+n1Vl5qZJcwom7q5wnMpXV2GBNvE2zq1dIPtr3DzgiEj/Ois44ASFtgryCFI0cjbO3psI6+
	RrWvoEmJZzX9OwogBHWQyJSu6GEhhWVd6AkgRRvao0SdwRgMUU+phVUF1JZ0e7NOuBm6mZiY6Tx
	xxiCu
X-Received: by 2002:a05:6a00:3a16:b0:842:33f3:da68 with SMTP id
 d2e1a72fcca58-8434cd0b4d2mr15760386b3a.8.1781536653135; Mon, 15 Jun 2026
 08:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <xmqqqzm8d0j7.fsf@gitster.g> <CAHwyqnWa55xbTpzq-Nf6cMyvgR1yYgg8fhvgMFkquSEGPUwDmg@mail.gmail.com>
In-Reply-To: <CAHwyqnWa55xbTpzq-Nf6cMyvgR1yYgg8fhvgMFkquSEGPUwDmg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 15 Jun 2026 11:17:21 -0400
X-Gm-Features: AVVi8CccdZ3N5_KchDIqVtFt6PG14QFyCjNJKaMd6ADhl8Rzhs3nrH2aGeMtHqA
Message-ID: <CALnO6CBgHz5d5BT5gCyqyhw_HpV733msWOnrxmu-TJ0QGHE9tA@mail.gmail.com>
Subject: Re: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest commit
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 4:22=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> > > Adds git rebase --autosquash --fixup [<upstream>] to fold a range of =
commits
> > > into its oldest one, reusing that commit's message.
[snip]
> > I also wonder if we can do something like this without adding any
> > new option or command.  E.g., if you have four patch series, where
> > the initial implementation HEAD~3 is followed by "oops it was still
> > wrong" fix-up HEAD~2, HEAD~1 and HEAD, then
> >
> >     git reset --soft HEAD~3 && git commit --amend --no-edit
> >
> > is what the user wants to do, no?
>
> I don't think it's enough. First of all the user has to know the N for
> HEAD~N, and then 'git reset --soft HEAD~N && git commit --amend
> --no-edit' is still quite ugly.

Well, there are a few ways to get this more easily than counting; for examp=
le,

- git rev-list @{u}.. | tail -n1
- the lovely ":/<pattern>" or "@^{/<pattern>}" revision notations
- etc.

---

Stepping back a moment and assuming that the important thing you want
is the "squash" (and not necessarily the "rebase" moving commits onto
a new base), I wonder about

     git history squash <range>

which would squash all commits in the (now arbitrary!) range into the
first. That makes it somewhat more versatile at selecting commits, I
think, at the cost that re-basing is somewhat harder. That is, you
could then do

    git history squash @~3..

and things like

    git history squash @~5..@~2

As a future extension, I think we could support merge commits: merges
could be replayed as a merge into the final squash instead (creating
an octopus merge if there are multiple merges to replay), though I'm
hand-waving what we should do for conflicts. (We _do_ know what the
final tree should look like=E2=80=94the same as the final commit in the
range=E2=80=94so maybe we can actually avoid all conflicts?)

Anyway, I've cc'd Patrick for his opinion about whether this fits in
"git-history".

--=20
D. Ben Knoble
