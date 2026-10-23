Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792795672;
	b=cztIzzW5p6ZGnkVSMCj5tE2oMZyarW7dqQcabJQLWS0fI0v/RlwDg8+GJR02vrcxWUm0
	 UZTddVpYLVHbm2lmJAzP1arbzLOUbgn87jYda99bhq4gqOp2BOFBVdIaxR82df/4jM3lP
	 f6otX+mJP8dxDqy9Mhpzp3JYFKIqAV4Vc0BdtICwrC0+B/fvmtx1GU/FMleXgq1vvTvjk
	 8ztnRH0RTxVtV3bcxls4SiXOijZfgap4lF5CCwaGiv9MFCyu4qDIpqCt9xwGNE3r66P0n
	 7t3OmkwFp8WXC2F+ZULpM+yEj+/KMyTHJ++prx4gwDpAJ9YKO6+RkL3G444KQT1H/Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rpJZ359AFUNmjeDeA7aWNsPfDDMrinRv+lVipoWoSf0=;
	b=ILQMn2UzCTb8zpQ80I9UxL6b7csf8NT+3fiC0/9GOlHcQbVsq7GnAy2RuAQiWvSBZ7aL
	 bfdblz7NXOmui9h6mypxVWY72jx2Z/7A9BFiEfg+a1Lok49NeFhNrDnTb9yU+i5bC6AV7
	 PDx2x2E/sGckOFA41WOT6qU5ixxENXe4VPqSjaqP+HY/3vf4rI9e9w5yxPj4GEdbcczKy
	 sgg2CluR9dmQSmcWFmWx2unloxJdYX/e1VYT1AAw89iQK4wwP0Szfm3wRmVaP3hvYrEEu
	 RXqyKgQlWG0d3A5z2bVNR5oQGlF+SwtFXgRRAtvG6H8yP6+NOf+H+O1hkflUK5pIv8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egfOnHLB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065BE606A325
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 065BE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egfOnHLB
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so1557739a12.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792795670; cv=none;
        d=google.com; s=arc-20260327;
        b=fjh6Tn4ywj6fjQaCg6+BJ8wzbXX/4sefpqgve+z0h76SMHOdtZKwqOv8trhILOeYCl
         Av+0cK6kLmWIK2+xtm2kZwm9VO13uAPcHiLs586VHUiBrhNKFeU3CqbYosIrqE+CAy1j
         JSAVbWL78BpFPpRpsDNXi1pC/Kq+Cn3BjY0XqIi2mdiVsBgCRj9gtUgmtrVh6VeiJl+G
         yoy8pUuePJr0C8XFvOZ2Rcoar65xEhNGu1AyJD30pR0O6bOC4gTTHcOsAEo+aM/NtqOu
         oF9RjSGODUTQdWCrOl70fimHh+rrqZSaQmxE/3T2tFyTVBGRE/XEfDS3ZdceQWD5uyVV
         qJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rpJZ359AFUNmjeDeA7aWNsPfDDMrinRv+lVipoWoSf0=;
        fh=1ZWZkBoSZ/v0Lt9g3tPj9VSCkLp9XTlO2svTnYZxqDE=;
        b=l+WUcDucq5zaiZh6dmD1Z9j+hkxJ91Y3U8iFBcDBn4tFL9xJhndgkzeyS2gyyP7afW
         l688mPp1KVZfE78NchU3+pVAsKVDcVsZsf6tTdNIEMHOVer3ShvUoUvYHP7xG4ni2Uog
         I6vQj1I0LCuLfple0ciUcxfiHuEtFUjiEakTtMgQNR0KherPAc9lwL3LnkpVmSodl6Q1
         a5M8c9444Meq2rvn1V/h5DpIoMUZcyx+s0d9tfvNBnlWHQPFKm/Is3OLnCRy2wwVa4cL
         4N7Nf76FUkK688XiRyEbzSEmmeleKV8fjL8YhTY+gjGaGgFJ9cVcO8ZnnxlDZC+B8Ipu
         VJ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795670; x=1793400470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rpJZ359AFUNmjeDeA7aWNsPfDDMrinRv+lVipoWoSf0=;
        b=egfOnHLBZylc5sg5reIHCHpIgcjelGIFUJMutuZfBYq+jo2iFeWpiU1ajWbC8aDtjQ
         A9tf+CR8K4PNwCVw4bcDp5SRfvs7DM3P0N72IGDWYn/lKXySaNjUJ8zSReiVrh59+ENT
         A7h7bL0u56L9AklrhRFCtjQ60ZzliTXhEsinSBtOATU9UY/sJpT0LtJHe7L1dDzLzsW9
         S/cqZDJaHtvJoqmjaQM1dURjRQwBo4Fk77UQMeKliaKClCVX86uKphWSf4SYRsJ3d1BJ
         BME/x5rOvkGHLRijW//Zhoswkg1RY6JSD8b1OJvkunfBrH/rPqSwNo0tDqkLZNS9+WXx
         fWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795670; x=1793400470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpJZ359AFUNmjeDeA7aWNsPfDDMrinRv+lVipoWoSf0=;
        b=PsPxvRwQfIJGB/NfjLENmsOEoyCPQ4Azdrr7eQzHYCsj6pPZY3vjg3tCnzN3C/2A2S
         2Z1HcK7b38+kd2JxGyjWGRzthRZNqR9KZYkEJ2U5drhf7v1OocM2xA3HT3iXa4blUEjD
         DzxqwutK/VVuOEfw6/OvSbu5nZdO5QOmJGNP7ZAMGQSc1ujSnZfuWQ4/7jj5i6FHm46+
         19mk/dxAhWium1Q/AQfng335pgDHY8FfPxzums0B+o5MJ/1sHWqxY+CBb5mX7uYToy94
         6mkDYPnk449J9Q0tvq7w6v1+CioxYD4oIgifHjK0xrcfXfYhcPLzKaRGZEgu1CalnitR
         Xh/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvXfAA2pXwZItxXFuzQWn/l3OHrwb8PIs7fYmBEvVOd6HItXuhP2r2GuzsVE3Lcnf3MHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDETxTxt9JyPXIV9ew4OdczzTuny9c/jNW/evCglFWA4UQAhIy
	uFaBQzWgsgfxYQyVFZSZlGEGsgYfzLjruTicEiqHZr4Qc+1FY4azLA7d3P0vTOssisRPMvNLEwS
	CllcakSCxJgGg7kJopkVSejl6rnrNghQ=
X-Gm-Gg: AYBFou0wWQgojMai5nQvWGgH8b5Oak6nuCejy1XhC3HUnlW3eqWtGzR9TDKGtJ3+qBe
	9I4ST+EIYMyiaKfIg0JB7e/qX23Gmf5iYSJpuGsdzjl/ESbcbSH33di7Fy8LpReBd1jkycDvkD8
	ORXY4N5ZoWLVijIgIP8We4VaN5z4L+4YbvdtTmAf8abhlKJGNm9ZYuwFq3NkFLUC/xchIUCrb8d
	6x8jDgi5h9l9EKAQqa0cggL2MuLK9IzsQFIdJxbKXhPrrO0fv8VbprlXuB/NQdAWildgfkg9nK4
	/hdoA7cyWv/cIGsvry+rqtjyhz/DLFmSU2yjBg15EkYDgy2tg3Wl7HYB2bViSmm1YmFYkJ5ZeZd
	ABEbff5VIJVg58Jpl/XIq+HbOV/7hLwrKLmtP
X-Received: by 2002:aa7:ce10:0:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b442fe4f7fmr434354a12.9.1792795670208; Fri, 23 Oct 2026
 15:47:50 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <745929bd805784bebeccc7e3ddee638aaffaeded.1792348037.git.gitgitgadget@gmail.com>
 <xmqqmrs43yj2.fsf@gitster.g>
In-Reply-To: <xmqqmrs43yj2.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 00:47:12 +0200
X-Gm-Features: AclHuK9Wppfgo9HMiYpI8auflAi2RiHhaXUPFDHD9KgBTKtRPMXnHS3hWwyyd9w
Message-ID: <CAHwyqnXN+OM0CMCKY8s=V8On-597xtc7NjPsu0i8L=WrAyy2hQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] reflog: name the strings that mark switches,
 renames and rebase steps
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 11:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Name the strings once in reflog.h and use the names wherever the
> > messages are written or read: the "checkout: moving from " prefix
> > written by "git checkout", the "Branch: renamed " prefix written by
> > "git branch -m", and the "start", "finish" and "abort" steps written
> > by "git rebase".
> >
> > No change in behavior.
>
> Would it make sense to test the behaviour to demonstrate this claim?

We have previous tests for this which I think would break if this was
incorrectly refactored.


Harald

On Fri, Oct 23, 2026 at 11:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Name the strings once in reflog.h and use the names wherever the
> > messages are written or read: the "checkout: moving from " prefix
> > written by "git checkout", the "Branch: renamed " prefix written by
> > "git branch -m", and the "start", "finish" and "abort" steps written
> > by "git rebase".
> >
> > No change in behavior.
>
> Would it make sense to test the behaviour to demonstrate this claim?
>
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > ---
> >  builtin/branch.c   |  3 ++-
> >  builtin/checkout.c |  3 ++-
> >  builtin/rebase.c   | 17 +++++++++--------
> >  object-name.c      |  3 ++-
> >  reflog.h           |  6 ++++++
> >  sequencer.c        | 13 +++++++------
> >  wt-status.c        |  3 ++-
> >  7 files changed, 30 insertions(+), 18 deletions(-)
>
> > diff --git a/reflog.h b/reflog.h
> > index 3bdd1ca8a5..32c3737db4 100644
> > --- a/reflog.h
> > +++ b/reflog.h
> > @@ -2,6 +2,12 @@
> >  #define REFLOG_H
> >  #include "refs.h"
> >
> > +#define REFLOG_SWITCH_PREFIX "checkout: moving from "
> > +#define REFLOG_RENAME_PREFIX "Branch: renamed "
> > +#define REFLOG_STEP_START "start"
> > +#define REFLOG_STEP_FINISH "finish"
> > +#define REFLOG_STEP_ABORT "abort"
>
> I was hoping that we could eventually make reflog messages
> translatable, by splitting each entry in the reflog record into
> two: a human-readable part (shown in the usual output of the
> 'git reflog' command) and a machine-parseable part to be used
> exactly for features like this.  We would hopefully need to update
> only reflog_message() and its dozens of callers to make it happen.
>
> I wonder how far this change will set us back from that future.
> The best case would be that this detour does not make it any
> harder.  The locations this patch touches are where we would
> need to leave clues in the machine-parseable format, and the
> locations touched by later patches in the series are the places
> that need to be updated to look at the machine-parseable part.
>
> The changes in this series looked sensible, though.
