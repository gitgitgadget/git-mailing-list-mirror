Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792571317;
	b=Iglwk47qN+h7u7fZVXauCPhLSZIMsLWscVhqaKUeRWTmq173mwSaLytIm4uiRwBDU/NR
	 u8jBULupu+75xvqP3Z2ZjC2CXxxOURECOeDhtr3dNPwZusJc7nEu5IVlD5P7CmGpUYz9A
	 v3A6MYV6GyebEkLwR27EWpQGPP6gpxwpIe/ZF8+AzoDCJqsL6XG0UangCHECz50cwHqyQ
	 /Fug9ujvOCUW48Ab4+e7G+QIY/QkbSEGMc1tN00krranPCjyG69F2xAb8SI7zgzGrmby2
	 +gB90XDg9SdA6Vk44A9+euNDOt86bzyqyP9UwChkUzn67O9qs60NpZAu7uha8NoIZiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kYo98755DNA8mTsmi/p6gegg5hdb0g9exezu9UX6oRY=;
	b=kghwbiMs2IFtC/YdlCv8M8IoKJwbXUhZwHv2tIAwwwAe7eaSyUliW+qW2u6qxDwZJ+ed
	 /YvWxnq8X09p2f5bwltzH8tlSQC5rfJKQVjw24pzuPR0X60EmKFdu6jhnzsB5l73INys6
	 CHw7ekbRs7gJGR2JTBYnyIjMe82YqK3IraYeGt/FBJMEG+Q5KFB57t5/RrPzE4qak/JZq
	 0EQPMwXRfi62B9k2n/VSMHCj6gmvJ1eKdzgAdAlvvFsyTVlUS0sf5pvIilLkTKnk5aLkZ
	 Pz8BBJecRky2biNtzL2kIIqyq7xOfd7xDEtlXMR2El+ZUI9mW867ddIUY+Jv3/yZMuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tafdve6f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F15606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F15606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tafdve6f
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-536605c4d8fso3142071cf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792571316; cv=none;
        d=google.com; s=arc-20260327;
        b=g2NQvTbJFshPHx8/fVwImNBrctSnI2UMATfTKrzTpb7IeDAsrAoWFcn8bUIB0H4pAC
         IOeCap6czra/0coSWs98enNGaj+TAiYwCNcfgyy5NzHQFah7ghYw8UFW3tHqUbMB3JV+
         N57hSpwl1kHieZhc9SSzKAe6x+ssc5XKCibVGN4lP36iYcgo9Jp9Whg2dA9LgAILXsLs
         yhdUTywn6DOrXNY+5bSRTK4pnXSHapNQMQ6TCct2NEKvYqxWXnhl+rkriQOXu8dEb/sM
         yQ6BBBIe53qsUht96JuzGZSyRrAjwq2xGzSxRzcmvTlHdoSa9rbBLwex7IZpXWEP8PqU
         dpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kYo98755DNA8mTsmi/p6gegg5hdb0g9exezu9UX6oRY=;
        fh=JG2YeO1JrFtq0heqU82cygTR+JOgFCyjkbraAzbkMHw=;
        b=YVPVbonUtyho73xXxZdzt5ZDAD6AeiEM2NtQePebZP4uJ+o54UALqxRUHb1uMJRi/O
         OjsT+FWohhBTX7vmjtRxuXOn6fLmxl8jx4CfsZO0BPNE8MZcL+bVH+YtJqBdS4gwS5/g
         bN0yLR4i1nDUO6I1FWO/i1bJT/HhE6TIRveyfzXAQvsoE5SCX4FDA8Y9fUltnGRnTkD/
         2tRaY2JGNziIhmkhpBU3685fV8yUyiSqepBIDt9oxO7VKi71IY7AvOR+H3j/zUK3sEXz
         cAIQuHDwmWDfBqfwxaDN8RhkDIfFKheE3oB8aLzqFyldZIOTEYk9yTR0p0EYlr8BoqcM
         uDUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571316; x=1793176116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kYo98755DNA8mTsmi/p6gegg5hdb0g9exezu9UX6oRY=;
        b=Tafdve6fRztJ+il8G9DMKB6t0cTYH8cmIt2Sp/jpqs64mRRFaHtWI5bOpIqxGPJqW6
         u9sn82RBkqcZ8v6qQCFlzGLFEuAcebScGv4ic+bEaHN8enZffPTY2R/PqtQqGH93amPJ
         CWnsHE2hg9oJwyxALnlwT4PGKqGPS00djyubnlBkMdtaEvd9WWpRvxSB2hEm9cTZrtDG
         X76pTzPyetQ2sfUVUQ8bevIzvw/7GBZHqfVWqfPXW9f6t5P1uXZBgIMNgA77t1g6cbhY
         +VNQarTsokpPp/RpgnktsJ6g36ogk2YGjJhMvz2W79s8VVtoj6uNevB+0XFKhzxfN1pK
         FkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571316; x=1793176116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kYo98755DNA8mTsmi/p6gegg5hdb0g9exezu9UX6oRY=;
        b=YeJHdM24peT38W5tea2wKzRfGLZiCNr3C2qJMzduAAer/ZqQaXplvjuOI3Z48Dm9oC
         yunOJnrZkVbt4aVvw3ruIFAVZ2R/XVofbDzvqqIJI2nTOtdZ/sCwouARqCBOWs64TCYh
         z88c7bRViCGpwHCtYXKSPC4LY8My1NtABWG7WxF5XHgdkCJK77RgjNRVfqZF6B79Lm6o
         Cf2ek5vkxCdn+lcvo1PkNRFB/m0MXViWRRKAsbHSyIbve5N38TCDp1+pNU1iXc5WyFjQ
         Pyk98HRjRkupUVg1z4XJh0U1ngRzYWz8BWpa1Hy9jNQ2t/bNQCMnyuxr0FxmVNa45fhQ
         zuWg==
X-Forwarded-Encrypted: i=1; AKwUvBzm9yZRuOQ7vJrWHPloO7pMJK09GZ6bJRBgRAGvySTNnUmH3ZQgX2yUR3VQxluQLiDml3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ098i23m+AQm+dLvncS9s5YyvGOPOXcPTaN9cw46/VwQHzJ5cs
	VY/YOQA5FieQxV4eztI5Hzequjl/dUec8o+S2NY3pQpCwLlzSJcH1Vm814XMjsPoSOpTuomfIVW
	tYDUZXpPjYscFuv3g6oahTAnZqosuRB4=
X-Gm-Gg: AYBFou0lAkBcPHPOXWoeWAKq8gqFSJ0kzexHdp8SfWV0M2ivXJH0OYDnVGdAYqSNwno
	1TvhYXMvdiVLvHU1E98zmBqbmVgdLsAK3TPi8nn6lb/zgXYuh5yTM/7rqXEoP29wIonlU9SHWiy
	FsWv+LKCiacoMzKCBCjX3NTzirPHn4Yxn2CtX3g3Ce0wcRqI/S4KibP7Y+d12H/bqdpwVZQXfNY
	hflyvOYz86eBtcdro1U5vf22rzjGm/VHNW77cayZmIpxoVNir+o/zhLPbt9IOfZhGu6s4ZKaGVb
	+o3evN9lELUj36/4hUk/vXgxCu7aaUSlScUI/nWrbRN0g1YarSx3Jiwap3NjlWuG+7zQMTI4T4a
	Op6Jg4h4MbG7W5i6RkKG20tlhG4HqyYXFQ6IoTnwg4/mQvoas+4j4Uq4ldIFYa2A6c3iHr9cKDw
	b3QwerYod2zvVy
X-Received: by 2002:ac8:5d04:0:b0:533:3d48:37f0 with SMTP id
 d75a77b69052e-5369b8ef8b4mr19134011cf.47.1792571315529; Wed, 21 Oct 2026
 01:28:35 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com> <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
 <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
 <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com> <CAPig+cRCaSmEULP1JpW3fjiJDR0Lee78puq+KRaXiD9ciX3fvg@mail.gmail.com>
In-Reply-To: <CAPig+cRCaSmEULP1JpW3fjiJDR0Lee78puq+KRaXiD9ciX3fvg@mail.gmail.com>
From: Jason Newton <nevion@gmail.com>
Date: Wed, 21 Oct 2026 01:28:09 -0700
X-Gm-Features: AclHuK9dON4zJze5Xtqw3fiQZtt81fIIvAK8I-HApnQzz6KlyWXKgOwXNfE9ox8
Message-ID: <CAGou9MirKucUdx8eM-BfqO9sZrDrckwpp9sYDnDVfiqkdZ8wdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please focus on reviewing, I use mixed but you shouldn't assume which
parts are and are not llms.

What you don't realize by working in a silo for a long time is your
communication skills to external parties gets reduced with jargon and
nitpicking ; I have the llms both assume you're wrong and right while
seeing the undesirable behaviors your stances have to the one that I
know is correct.  You seem overly sensitive to the usage so far. I
have no tollerance left to give - so stay on point. You should
consider several harnesses chose not to even go through PRs and work
around the functionality like grok build did, patching it in
externally which is kind of nuts - and replicated.  I think it's
something you should think about the nature of quite a bit.

As I mentioned, detached IOWs sucks and you shouldn't have bothered
mentioning it because it fails hard, though it was noted and evaluated
in earnest for a bad idea - want to go back to the long but more
neutral form?

-Jason


On Wed, Oct 21, 2026 at 1:07=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Wed, Oct 21, 2026 at 3:40=E2=80=AFAM Jason Newton <nevion@gmail.com> w=
rote:>
> > --detach and an ephemeral branch differ while the worktree exists.
> >
> > --detach leaves HEAD with no branch, so status, push, rename,
> > upstream, and symbolic-ref have nothing to name. An ephemeral
> > branch is a normal refs/heads/ ref for the life of the worktree.
> > Commits go on it, and another ref can point at them before
> > "worktree remove" deletes that branch.
> >
> > Deleting the branch that "worktree add <path>" creates today
> > would change the default, so this has to be opt-in. That opt-in
> > is not --detach: the worktree stays on a branch until removal.
> >
> > These worktrees might be minutes or they might go on for months;
> > either way they should be easy to use and not require flags to assist
> >  in the majority of common case behaviors, moreover detached feels
> > ike a degraded halfway state, frequently allowing a gotcha to strike or
> >  a loss of a safety like a gc based reap.
> >
> > "git worktree remove" does not delete whatever branch a worktree
> > has checked out. It deletes a branch only when this "git worktree
> > add" created it by DWIM (the final component of <path>) and recorded
> > that in worktrees/<id>/owned-branch.
> >
> > A branch named with -b/-B, a branch that already existed, and a
> > detached HEAD are not owned and are not removed. A worktree created
> > by an older Git has no marker, so removing it still leaves its
> > branch in place.
> >
> > "Unconditional" in the commit means that this one owned branch is
> > deleted even if it has unmerged commits. --keep-branch turns that
> > off. "git branch <name> <tip>" before removal keeps the commits on
> > an ordinary branch; only the owned ref is deleted.
> >
> > The call that changes is "git worktree add <path>" with no branch,
> > followed by "git worktree remove". A caller who wants that branch
> > to outlive the worktree already has a spelling this series does not
> > touch: "git worktree add -b <name> <path>", or "git worktree add
> > <path> <existing>". --detach still creates no branch, so it is not
> > the same state while the worktree exists.
> >
> > Ownership is written only when the worktree is created, so I'll confirm
> > an older worktree still has no marker after an upgrade.  The branch sta=
ys.
> > Upgrading does not mark a worktree you already have so no upgrade
> > headaches are expected.
>
> Feeding a reviewer's comments into an agent and pasting its
> LLM-generated response into an email is not a good way to convince
> project stakeholders that the submission has value. If you can't
> explain its value in concrete terms in your own words, then you're
> going to have a hard time eliciting any responses or additional
> reviewer feedback.
