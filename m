Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB746DFF2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792384820; cv=none; b=FtzJY+A05zElF1IotTIViTooRIk7Yw6lgFM79o0VkJ0MKn5YBQyUR0yZA8KthhqdICJIWD3bnLiI1s8APvBg5wUX6biX6rdPbmZPRopLYvLpLMkHQvDad+qUxJwpyADcs9qWnAJm2HHUb0Fv89I8Ai3NiHp4bPCSgFkcxycKAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792384820; c=relaxed/simple;
	bh=VvZcwTkr+Y6sc/hvr27Y+2VLOyTKafntOjWTXEaeCF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIaG4ObiOhNGCniug3wyaZuzb/mrVnJqei9rap3GB24pEd2yeqGnUdC4XHSIBGvM3FYxkjZl4rX+AkGZKccvdV9r0DKI9h/92pyNOuBJGD5zc9RlqSQFVghhLFXuA+igqeTgvQdUGXgNRx+94/Adm0ce27BKvXa04SvZyz+g2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com; spf=pass smtp.mailfrom=singlefeather.com; dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.b=GUcpf/cG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.b="GUcpf/cG"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53644b28706so18148731cf.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792384815; x=1792989615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZLm3RYWsTTaRBHutg4OYuj8+yQOlmjcHKfLoPn2YWc=;
        b=GUcpf/cGVgm3rD3hFrd/t49MAjw78G4YlK7mXHq9WjD6uXF8jW6cjR7mKSbpHK+6bv
         JnFMv3qVKr/r2m0pe//niWOwEJQMyyuC7IsTReWsXVITDIU9YSSe4iMU2tFiK2hh2yyJ
         4dNOvQLPV1H1XpmGzVLK/vUa8LjzeMZjcmjc3ehnNx+1zo1+oRjbXsslhv8V7acjOJTv
         OPZY6aJkIM+ch2ZA8/z3GqJg9ny244gmHWQ4hKmByfV4iFGPL6nkuyX5w3BkYElpOfzO
         tAv5eMm5K+YIINSyJZmv6L29qcDHduZE8TKOt2WlsV0azBcxiEYpTEmnVWsiX9pLvRO6
         kmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792384815; x=1792989615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZLm3RYWsTTaRBHutg4OYuj8+yQOlmjcHKfLoPn2YWc=;
        b=baUTZDJ1e8b9dnspubKY8wVPbW7SZL0P/Zld1BSlYmF8UHr1gdWriXjWSp6pmCvoNd
         /rmOP8exDi/lVytZsnnaZqfvCNJOJNUlIgmOJXRAUVoucgggUedEVpcJizX06NTxMUG8
         y1K5wkuP/9wblA0Qy/eEfdDtuN4SC4cAN3O5IJIq/UaFH72iEHqYsdQeoa+Cc6CY/nTa
         xUaDN+GGZQx9thTim9lk5hPHQnDnYDEv1BzuECHF0RAVtc/kF9zth3pfTb2XFyJTHQBO
         /4WqHeCdY4iA3zLkCT7qBaesbBYSCkL6GVVA+idyK5A0Yg0slfWDq1xsD8R5/XKw6eYv
         RcFg==
X-Forwarded-Encrypted: i=1; AKwUvBwVF2vgi4QhqUCJJnZEohLjL4/4Nuu7kzJ7rBZ4XjFBJp21r0exsfPMtRCmHMS16k2KFos=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMbN1zSdKyWqvf64u7rpJJ+OeEAVxdGQ8n8/qKbGYs85ipRT6e
	L1/9JF5ctDGKdtfIJO/OZDa4KggkXk3Ha9i0mEci9bFNEL216xwQFB6AHoCpbuEzM6XS+djVL1Q
	cUXY3CL/LVPvIl90O069plSW5rqY4vIzttu39RHOm0szTZeQk1ra/DEQbU/ADK8AGGs+ZkwXA6c
	dayls6gJRiFOCvAJWMyS+lI3e9n72Yj6A=
X-Gm-Gg: AYBFou26YPqRY1qTiKVEKCHTIueKZOhtuHqo67ScFDdARZIHOAcn1zWlqu4SLDge6gd
	/Pz20mV/bT0zhpIhxC37UsrkxABtPDJn51w2TAXTEsuBQK8oHSL6cEY+b2i/3rab5NQO7mDP4DL
	pHgor4xsxLUw6qeePz8RPMNUY282UateD9jHyVByzLM/3qyQpMkMy0FrSn6hQKOdmivzNAwu8L7
	IMM+m/y2VlPSqQdrS/CTjz26K9LK7c3f8U0qCJgGcAMZu+0XInBcegnb+U2tI6FRb5zGdirkgmJ
	AdF0pwe2GInpGr/cSKkYO8DGStED+pO6ebsEC0oEaFEMbUbZk/gD4TyBcbpmZROh/B+J6OEG8S4
	u0nj0KmMvVP26HoY3z+nAXUSOX+AEoRTgwZTtvEqEWxUxvGfPf2wCcC5bIL6dW0MHiBxoj0Wo1u
	zIJ+lvEzrrDlY2WgH9H3MCRiF7os8Y6tPFaUgWrXEWB5XaUE0SzGEeIZj8PZiy17ekvI4aaPlKF
	oHzSkyTN9cRfPnNSVrnuW2INrqRal0eR0IvmHuN7933uHDyK/NhA6Xet8vp2j5MgSk9D8HgZlBz
	0Lv6M8PINgMo4eb34bB6+SfMCnq2q99HNcNmWkzprm9LC+mXdFeHbyZeA8RT8GCwi7V/sPrNuwi
	YeIxPzPG4yXoiUozmIsDUOViU/lER5S5eaH0qyQCUA/GAQ+danOA8MbKljw==
X-Received: by 2002:a05:620a:2690:b0:93f:dea:3b7e with SMTP id af79cd13be357-93f29d0ea3cmr1049547685a.24.1792384815420;
        Sun, 18 Oct 2026 21:40:15 -0700 (PDT)
Received: from remus ([69.43.65.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a192378sm862280885a.25.2026.10.18.21.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:40:14 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
Date: Mon, 19 Oct 2026 00:40:05 -0400
Message-ID: <20261019044005.99247-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqy0c21gq1.fsf@gitster.g>
References: <xmqqy0c21gq1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Stepping back a bit, perhaps "--delete-merged" should not be
> modified to touch anything that was rebased, cherry-picked, or
> squash merged.  It is good to have one stable and strict "if my
> commits were merged and safely saved there, delete them from here",
> regardless of how much looser definition of "the same patch" is used
> for "--delete-irrelevant".

I am in the group of users this series is for. Most repositories I
work in land pull requests with GitHub's "Squash and merge". I built
v2 (ec88bde252) and tested it on generated repositories. The results
support keeping the strict meaning as the default.

v2 did what it says for squash merges, GitHub-style squashes with a
new message and committer, rebase merges, renames, and squashes that
were later reverted. "landed as" named the correct commit every
time. It kept a branch whose work only partly landed.

But it also deleted a branch that was never merged. Another author
had made the same change upstream in an unrelated commit, and v2
reported the branch as "landed as" that commit. That is the
"irrelevant" case from your message, and today v2 handles it the same
way as a squash merge of my own work.

So I agree that the strict meaning should stay the default. I also
want to turn the looser check on once per repository and then forget
about it. Something close to what Ben suggested earlier would do
that:

    git branch --delete-merged origin/main --landed=squash

plus a config variable for the default. A third kind of integration
then becomes one more value, not one more --no-<kind> option.

On speed: with 3056 commits and 80 branches, v2 took 0.078s against
0.030s for 2.56.0, and --no-squashed brought it back to 0.030s. In a
blobless clone the first run took 0.42s and fetched 13 blobs.
--no-squashed fetched none.

One more point. A branch checked out in a worktree is skipped with no
message, but a branch with deleteMerged=false prints "Skipping". I
keep one worktree per pull request, so most of my merged branches
are skipped silently. A "Skipping 'topic' (checked out in <path>)"
line would help. I plan to send a separate RFC for
"git worktree list --merged", so it would also help if the "has this
branch landed?" check were a helper that worktree code can call.

Tested-by: Jasper Mayone <me@jaspermayone.com>

Thanks,
Jasper
