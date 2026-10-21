Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792570022;
	b=zNLW/dWFvAMY9aFNb2C31deU8xKQmfPIz3wEqqpCSjr+/DXRuDZLY+8E1FEt2Pc95wL1
	 Kgjrs91ZMpEcDXnl0tfAk8fg/gWttDPsLbHSOJmAR+7sZ9FFFZJ1MfEJVALh/dWN6BLON
	 TpmouoKUTUTQLM+yZuY1XipAH0jdZBily5VP7mEH1C23Jct+vjWFRH90c3nE0cuIDP/2L
	 R8cJLuJdwURYjxW/FiGddrhCn/ey0iKfdiCQArj373bb5skBR4okA9qG9LZKFOr9OPsyA
	 rpCI4D4YggxIh5QK2sD2U3WgP3y79sOumgUKx0G7qcVhbwBxIJym/FeCiUxkQnnJxHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570022;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EJIE3BOr4wku7wexdxMtba1FSxj3nti1Q4vslJFLan8=;
	b=09d/BTM5gGsI+1SF3tlBDug8J1Hjr5pe9qt2Lwf2OW26YVvTlWu4lbTSngCZMICSG7y4
	 h7FPn0ddmm8GP3Wypb4IevdzVRXnExEozGjfNBlWPF3O7XwWqBqnp0n4lsSN/fxB2xfrE
	 erdJqh9PnO6KWaU+cRDYUq7uMVUy+HuWc8jdK5X4+7bvxILxdPact4C+Ksfv/PtbRqWTH
	 tVh5abZtSJ28WiIKWwO6J6CCCDwc/piUlXH9kdTe6E1WacaVbQYNG+26vxbDFg9tGjHbC
	 HWVF39GcNrJgX3t6w5SxHmw9uzQ1uhGvZkcGCXCe+vWhUxFZFaSIDxkeW90uiHHr8wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B0606A338
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2B0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3667e94418bso40732eec.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792570021; cv=none;
        d=google.com; s=arc-20260327;
        b=dzXpx3GtfKRDGoIH0ssw2WxvLjIrOclr4DLkuMFPCkRpVs76uRJryn5ozz3CTeRGJP
         n6yyXIH5gjiotFjM6SqvQfPQTSKoMdd4pscYLGxnWyi6auUNkfvzEEi7g3STIe9rQ4vu
         SLW2WaRBjRjbZnY3KjgDbsXPQza9giXNrqh3Y4CktE7Fx9r196mkkSeqYW8+z0IHkD1f
         oX7dqTnvzqbK3jo55+9UnfTig2daCEkaPtr8F97cNLr/nhRkcihbPPHctojbRQOrWjPv
         9CGWADp8JCld22PmiwxyjTIPu/N9wytWEObKf9L5AMkS1FguUDdTWttnqNJ6tTsjVB/j
         iMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=EJIE3BOr4wku7wexdxMtba1FSxj3nti1Q4vslJFLan8=;
        fh=DwCley9EIYw05zxru2ia30lc8AiawXZr5w2Vb2ryVDU=;
        b=jDoCdI+vNc8e65K6brf4mQhfuWviyWcLOwp1RePUMutN9JUzlY0eWGt1ZOQJz65U5+
         lulnHqvAmpVRnHMtbgxz/w6Phb71ofhYUFAfibVwUIya/hoBWYQ18650MxrRSXwNJWQm
         TjHrM+MyFIF/KH3Jppx/t/eXounE9qxsepFbn9M+cDZnTEWRRt5iEpjxAD8p1GFoXGB9
         xmtOt63FF24KQ/54WkXKrwCI7JlvAzYCnV4rgDlq7p2Hc74c8qP0G/ekF1Svgj6dltL2
         2xxJG5kTUi10piSPPrbAkHXHkl89+vcNSe31UH77J0eSLgiB1jVNScmrZXSPrkIVMksa
         wrJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792570021; x=1793174821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJIE3BOr4wku7wexdxMtba1FSxj3nti1Q4vslJFLan8=;
        b=az2K4SpqZY4ay4UlURlTM/0IyEK9B1yQ35sTlooazsFeGHQX0ktvWga0EETZ4O+tfS
         pBVgUL8w8+kAiZY+MRqofa2AGtmMbfoemADo0eYhN3SIAwxfCfnAlwDn1B7G/MfnbdnH
         Txrc0XENhoirNs3XCGzIqUG5BtoPlfd94+vvMooZM1isvtsvECHTogtOLRlA3MH03ghx
         neO0mhKCZAhoDD4aZg9OwYr2SFucQNx2B2QxsdTle8KcxvdsFG200n8nJ9P9KBoPW4K7
         VG58Y/mr4mdFl2T9nE/rC549HYmMgpJeH9LEco1fyfaxpZwx5LawOrwl+nayFmF3tTX8
         h23g==
X-Forwarded-Encrypted: i=1; AKwUvBxw23leQIIdQQo6I9GUEBrejiAFIda8PwzH7+NLHquDNQm+CaqqH7c6vG2GoBwLK/8htTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTbnEj0axklXxCflSXHUfmdDgcoR1hSRbenRQMFP0cedEZTBBh
	jSU8xxDs2PvFYoi0sYGpMSuxZtO00fQhGyOlPUbhmkfMeeiUPaomUA3XYWw8Qoq5kT168LfMwdX
	CsZTXasrIMNFK7Uf4nSFabi2ISxWwc8Wj2g==
X-Gm-Gg: AYBFou32h6FnR9ce/sR50borgfKjeo+kilZ2Car/ZHDoekjy9eSgBaCiq9gzpu2Vur5
	MrDzELGCBRyZJn+Nx4GmyErs6ucF351EQugsQFpsfm6I4tdbVjWyHVg+ckNfkbmynR8onefVGT3
	3fwg/gjA43lWCrorZst9BOo5lbmwsrK040EOKQTry7WsZDLyko6dGs/FPBuzYcldsVx9nPLknS8
	mDahcHQ+eH7SwVpNyQEFZN2ZpPUGilD6VMSUFMM3iBc/4qvZlxV41FdKEofAsojbeG7cMTY6LuZ
	Y84KxBt5AVPzfPWE9rMx8gUI882B3adphys6jPdbNkmJKkNoQzmbcPvnA+b8Wr69VphLaHyWGOZ
	oAhhLuX9qccaz+PwBGtbXuWpslv/EWxXGrTgQajjS5hrC8JCx64kz9Qm72UvNXIMoF25OpJU=
X-Received: by 2002:a05:7301:6196:10b0:367:2bed:e7a5 with SMTP id
 5a478bee46e88-3674d54de76mr3612064eec.2.1792570020681; Wed, 21 Oct 2026
 01:07:00 -0700 (PDT)
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
 <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com> <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com>
In-Reply-To: <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Oct 2026 04:06:48 -0400
X-Gm-Features: AclHuK9--7cVbYT5SC2uGwFVaSFr4xOBCsZzTm0taHvEPTXYduyvKxRnW-DJqw4
Message-ID: <CAPig+cRCaSmEULP1JpW3fjiJDR0Lee78puq+KRaXiD9ciX3fvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: Jason Newton <nevion@gmail.com>
Cc: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 3:40=E2=80=AFAM Jason Newton <nevion@gmail.com> wro=
te:>
> --detach and an ephemeral branch differ while the worktree exists.
>
> --detach leaves HEAD with no branch, so status, push, rename,
> upstream, and symbolic-ref have nothing to name. An ephemeral
> branch is a normal refs/heads/ ref for the life of the worktree.
> Commits go on it, and another ref can point at them before
> "worktree remove" deletes that branch.
>
> Deleting the branch that "worktree add <path>" creates today
> would change the default, so this has to be opt-in. That opt-in
> is not --detach: the worktree stays on a branch until removal.
>
> These worktrees might be minutes or they might go on for months;
> either way they should be easy to use and not require flags to assist
>  in the majority of common case behaviors, moreover detached feels
> ike a degraded halfway state, frequently allowing a gotcha to strike or
>  a loss of a safety like a gc based reap.
>
> "git worktree remove" does not delete whatever branch a worktree
> has checked out. It deletes a branch only when this "git worktree
> add" created it by DWIM (the final component of <path>) and recorded
> that in worktrees/<id>/owned-branch.
>
> A branch named with -b/-B, a branch that already existed, and a
> detached HEAD are not owned and are not removed. A worktree created
> by an older Git has no marker, so removing it still leaves its
> branch in place.
>
> "Unconditional" in the commit means that this one owned branch is
> deleted even if it has unmerged commits. --keep-branch turns that
> off. "git branch <name> <tip>" before removal keeps the commits on
> an ordinary branch; only the owned ref is deleted.
>
> The call that changes is "git worktree add <path>" with no branch,
> followed by "git worktree remove". A caller who wants that branch
> to outlive the worktree already has a spelling this series does not
> touch: "git worktree add -b <name> <path>", or "git worktree add
> <path> <existing>". --detach still creates no branch, so it is not
> the same state while the worktree exists.
>
> Ownership is written only when the worktree is created, so I'll confirm
> an older worktree still has no marker after an upgrade.  The branch stays=
.
> Upgrading does not mark a worktree you already have so no upgrade
> headaches are expected.

Feeding a reviewer's comments into an agent and pasting its
LLM-generated response into an email is not a good way to convince
project stakeholders that the submission has value. If you can't
explain its value in concrete terms in your own words, then you're
going to have a hard time eliciting any responses or additional
reviewer feedback.
