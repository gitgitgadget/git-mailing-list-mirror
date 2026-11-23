Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470878;
	b=oOKdD+eeWhz3YRhUiTN0Wlhs50pThJLlCzmbdeXvHp4DZHyfsu4D0/v//Y4FtN2DBBWd
	 woD09MiUWZRwEXBB4u4BYCtvf6Kfb1PCd+QUDCWM6EMTkauqHdgAiN8H7YA79ZDrSWTMz
	 JJFeFl7GrEAkggfSxuMCeXb+abbwZt4d9TJLfBmYmu4ScVB7JfbI1aRvbLEhW/0nk5sXJ
	 gxysDu1AovfW+juG6ISdo4QZLp3PfFbiVRP9iZl/NKHM18yvDS8Hql+wAXFG/XuI8Uz5L
	 3ljY6yoX5ad3vMB0YwgW1C2wis8DnlD5VnDPlENNyHwDgnAFHTDXXma1jqg+kfBZXOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=llCLJn91qFAsJGGGP/RNG9XDaxoAJptgIvqqWVsot3g=;
	b=nNMmMSyUUnXpLum3EUa7ufrpUOj53CQgqFLPRHi4J2AuHZ3sfDO3LBWQb2J/7WLo5voG
	 NfOT/oaBTR4SiSziYY+WFC+nfTmMZPFfK9nzSkT7PMk1YEYoCiUalz9tMCwCswZFlIDDq
	 dIR05slvFztEYqGfwKDVFew3/oj5nc+k1lxUun6UdB4e4Xe+vmLXJ3AfKcYjLnoUpCfb4
	 dezWWu10IAhHzKeMiKhT9f8x5Jy/5Kvw2NUoCtrrvipXly87+f74+VN/Sbp/0lmR2NbIh
	 FFIgHqttzWJ2WjUINm7lWLj/vglqWzKSiZooCRNtQqSslMbzvoKEBx5jE0fLhV5tKZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPVLE1s0;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71F606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F71F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPVLE1s0
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1823051a91.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 13:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795470877; x=1796075677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llCLJn91qFAsJGGGP/RNG9XDaxoAJptgIvqqWVsot3g=;
        b=TPVLE1s0Gc1pG9HTOELfPHRD2RF1lp30nizaIRcgqfFlSVHXUJRwvCkE/YPlAvr9Iw
         uQAuSrX+fC5EYWnij+g5RZYrR+x31c7BYkX0EfyRAH0+nDVW7wFdP40KVerkCLB+suhF
         xK/TnaxEsSTbrZb67cXlvSneXU10V10EM9SfeUpqBqeYmATrg2jj1W/TMjDKM51GOFIh
         99Ee8JjSR5YFKSie+RC2yOTJmirCTBFddCmU1z3x0pUBr9k1rZMAbBeOW/LMC2nxsp4f
         0tknxurMkldjVVObYrRAfwjCVBxqF4mGnK2F8Y8D40MnpB/gci4SdNF5EIXTJPTaZsLT
         i16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470877; x=1796075677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=llCLJn91qFAsJGGGP/RNG9XDaxoAJptgIvqqWVsot3g=;
        b=D7TW4g3xfGpuk+yZ2/rQDleJ03jYagDayKOaIDRqyYkNPszv7zJk8lND1R8pQOOp1L
         efFqu8+TknoOTdBBVFQzVV6Kgl8PljFNnP/Wn42IPtk0nlk0yzg9iZ7QGFsCMcvf/8G0
         FbLdt6UdPIMgdMO7/7sz2s4XTG/hsLIFA9jA9TgWaNYW52T5ijuWqkEkJyvdzk3kUtRP
         dvwciUfVIwm0RMz0/NNFizBPeuInYyvnObvtt6Wf6qG56+DtoWUR7V54tos8oHYoyL1X
         8MVLIPdijNqdN1wlXb9DKcAB1L4BIeG6awdimmVJdhgU2SF9SqftnvMrE/OsZyFkLeeT
         iklQ==
X-Gm-Message-State: APuU4Z95GlK1EyHJSpPs/sxCbbwP/M9mEJdvP1BfMEiMJOnl/bdHip8B
	2zTmNa+BK8BvlSTSfx6P47K7wSCQH7zbRKE/vEVl8P9cq5EZhJCQhb7l
X-Gm-Gg: AZFdTZduOW2zqQRToOI9CcWITljFz3Httm4JNHfCdbzsqAQCh+aBX1oMqO10ecKtLbE
	t/wsRfU6slqAGnahcs6+4+JLvR/Rx5/0oJb10HQqnFKh/2qb2EvNxq45tCUJBSmFDtUWYxAZUZ3
	TmerNwqGo6EkOUj6fZqQB2fZzv9aNeY+gnqxNrlOc08NXvC+i6dLFCmV8CcDtIGR7lnA3Ujq0BM
	vOJvp+OrTNC2weLYtQ4CWnvwo/6TWeRA+bfhIchc479qkDcfswwNHMkFyelu1Tp9v7YVFoQdI/o
	Dp8/j9kW0IhKRHVi14qm543RDU3+HuEJFrV0HgvnqNUz6oaLQvR8FgF7Znb7d8KtdwRDfBdOyDH
	/CweFI5My6Gul06QhHTfNkCBal3LCTC+jxcTYHv2KOpOrr3CKtJ0jL3DnWRO65SrMqYnnuoaRSS
	Bju9GryFZP5Kl7R6GuBF9QF1/FkRu9iIbfEmJR5taHh+3i+W4pbjx9z9n0FtcQRCT1cq7kzFYW4
	hXukgIud7yLwNE06IRh64o4hQ3bmr5x5PAyY55Y0MM3xWyIm42CbgDZNDYEj08oNhIO3yH3lPpn
	sohjXYWEiB1rwKxvWUGX+cDy3omRIveIwnTQJc5OyzGVlm5ThiOYfkE9KZvjFy+Y1bftX4PFo1G
	FuwOXJEWPCg0QDgAZl1UNCQ==
X-Received: by 2002:a17:90b:5887:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3b41c93c24emr7764529a91.26.1795470877412;
        Mon, 23 Nov 2026 13:54:37 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7f4899sm8151911a91.4.2026.11.23.13.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 13:54:37 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Nikita Bobko <nikita@nbobko.com>
Subject: Re: [PATCH] history: refuse to rewrite branches used by other worktrees
Date: Tue, 24 Nov 2026 03:24:31 +0530
Message-ID: <20261123215431.27574-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <a0ebd98f-669e-4ff2-bca2-cfd5da5a7316@gmail.com>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com> <a0ebd98f-669e-4ff2-bca2-cfd5da5a7316@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for taking a look!

> "also" is unnecessary here

Will drop this.

> The staged changes it shows were made by "git history" - they did not
> appear from nowhere. An alternative to refusing to run would be to
> update those worktrees if they are clean, but failing is the simpler
> option to implement.

Fair point, will reword. I stayed with refusing as it is simpler.
Updating clean worktrees could come later if people want it.

> fail to notice it is checked out elsewhere. That's not a problem that
> needs solving here though.

Noted. For the current branch v2 asks each worktree, so it does not
depend on branch_checked_out() there. The other branches still go
through it.

> What happens if a rebase is running in the same worktree as the user
> tries to run "git history"?

It is refused. HEAD is detached then, so the branch being rebased is not
the one this worktree has checked out, and it gets treated like any
other branch in use. There is a test for it, but the commit message does
not contain this. Will fix.

In that case --update-refs=head is not refused: it only rewrites the
detached HEAD, same as before. I tried fixup, reword, drop and squash
that way, and "git rebase --continue" finished fine each time.

> Does --update-refs=head try to update the current branch? If so we
> should check that is not being written somewhere else.

Yes, it updates the branch HEAD points to and nothing checks it today.
I could repro it with "git worktree add --force" on the same
branch: after a fixup in one of them, the other shows a staged change.
Good catch, will add the check.

> we should say what "git history" refuses to do.

Will fix.

> We should also prevent rebase from rewriting a branch that is being
> rewritten by "git history" but that can come later.

Agreed, that can come later.

> This is correct, but it duplicates the revision walk we're already
> doing when looking for merge commits.

Makes sense. I gave it a try and it works. One point: the branch
pointing at the rewritten commit itself is not part of the walk, so I
look at its decorations too. Rewriting a commit that another worktree's
branch points at goes through without it. Will do it like this in v2.
