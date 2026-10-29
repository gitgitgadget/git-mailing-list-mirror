Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248250;
	b=I5yUzGzXrZEfTnF+lW5vdn2Rrha4WJ1OHhlHVTskUHulAM1DBB98Sd9FWNl7T/jFwe1z
	 qscPbOjyJlTA6kyt/FGzsKBYu3yuRa+YTA2bpdgiNV+gfyrE/lvn9iDrJiSeThzmhn9yV
	 1L9YODp8Q0HNgzcMzFz0IXNclwFBiZusC8kyKtj25Jqo7KTktS6/9Pqk5iE50/56bDsqe
	 zsWlVdSCRoxtnl7VEqhEfVlPjOkyCc92Yvd+3+O9IYdt7cnKAw+LxZ09KplewsVwHSesT
	 DPXkzKOSOpuSQ6Nw5us+dlhyewfGdgtt7pfaGy1CoZlQtNwZNVfw3Ao4HguhLD0qxyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S20zcMDHsFndHHYkWbNxJo/J3DLtn3NUfGSoeYf15fA=;
	b=ftp6u0pxfRTGXM9dQi7fJ2eckDm/MmeGrvhlJ6SR81FUDWAuOxAEF6SVCwL8p5zFjTGp
	 dP3y6iqWcC6t08YTqHezVXXBK0csNW2rnv3dwYkMXG9RRQk7Lg25y7bbizZd6FM0Z2ru+
	 rBZWqQpVhuUtxEJ1ZERqdugWA+9FagqKARVZbeBPc2nAmNc8qX7LT9B64myo8JIGM011T
	 dyeSejS0qf5PBX33FVR4fDvbfo+huB0x9613FIM6Ruszhhb2AE0PMkQ+Qp03SXBI7+9gm
	 oRHt4ocg//mW0kUxxC/hy0H8gQzNR8n2KrUOihNcabZH3l9mjSbF87GttPoTSfYdQ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=TKsyxB8X;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E5606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 638E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=TKsyxB8X
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451a49abd8aso1587182fac.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793248249; x=1793853049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S20zcMDHsFndHHYkWbNxJo/J3DLtn3NUfGSoeYf15fA=;
        b=TKsyxB8X1hOKhwiqIOFhLFSvpFTLkwQPlrcM0piHYsxwFAThDZcrs497F7olUg+XkJ
         GelSA3g22yxmqJbFTlGNitQKNgMrZqQj2inZuo0NRrV0GqmcJDQ8y+aOmcsfAcwzaiXj
         3T+S6FYOZcU745xU7oqEr36ZctK42kHtL9krNuL6N+3K2Ke6JHv2UDOYegX5SiEim9bl
         ZwC1+mSqewlu+JwR86TqJ+18IolKR7d+eSfJQmCn/2bTOK0abYT75yrR+t0WsTPh6/AW
         cKbWvyPkN1XnrZ0J3Y25sxTJEZcuNLgRTOX0fDpA2wlaaYQ3ylD+9eYaVZzcbQsB1D3O
         y8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793248249; x=1793853049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S20zcMDHsFndHHYkWbNxJo/J3DLtn3NUfGSoeYf15fA=;
        b=KhDwsXwQCrqsCeT7NHiJwX1smlnskQrhhn/LGi2d70GdXwdfTom8fT4Ag6NSQLzoPp
         SczniJ+ILQdFWCu8yIGpomGr28d4WLPNGCNWrYI+Bb7VEqxcC5fAT3FqupZLzbNfGKJT
         U7mCMFPvsSlLdJkT/C6bhlCIdIYEFQEFx3ANIKm4Q/A27FV5nPIrppsghJi+0qjRaBOF
         l7fzzBjiWsKK3mhS12s4E5f1TkJ5eMBlhgF5nW+3GeanSCdND58/orHQCLqqGnqNcBm8
         vlN2ijo4KyXbtt4uhuJFNu+ev1Uyrlq75m7Favx+/J3SnpXoT2LU2b7hJAvxi3UNpdps
         IPQQ==
X-Forwarded-Encrypted: i=1; AKwUvByDKx9ikCZ3GmRIcVGXDPMN2XY+TTTW5u5N0O0SDpLxld9Egr/ileSVpwl2OOOLhX0i7p0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn+lfQnD3N8KsGzozrcxzmwt6lDYFkYARp6d34WR0G+IerQH3I
	b80ZBEaBohXuZks9LhqOHmyEJpaXuevZ1g9SaBnbFxOcgIkIyjiwT3ycpnh4V8riSq2Mk67XVHU
	FjKJX4rX/41l1d3iQqtS1JY+mYT9EZQX5tLM4nqKUqa5/gBg2TOjmaMLCy198R85mwqkTsfc0Ts
	GY5Rar/aoXiPC5jTjoFGcgt4Q+I8+A48c=
X-Gm-Gg: AYBFou3lzJlVi4jwso41q62kuQcEosLH0LnH17no0DYkbRzgfAPbQy8Ei1SnHtCpkBA
	o5/A9KAqprWBNo4c33Rbl2bv1ngvYirdGrPTuaT3Znbt6U1uFPoUfzqVKAvOlPWOwkVCk9wcgHT
	TsWIs37NfG7PpHVCQmMYA8HZD+m8idWmZZC1/V1EVPl2IayF6+l7xPi2Dw+7xXlomj9zj7i9WbQ
	wwL1XZ03+9Qa8w4u9NfSnZk/cDZHwZbWUOlW2K5xc8XnHrTH/SXgpBHOnZy6FUJjSf4LLsNKF/Y
	n8iTBlTDFEb7Cddn70bJu98/xyEPZ3eG0NJf2UXOYQF6EBKtETMxbqZMYp5hIZRT4LyK2caglNG
	iqrAgJtZg4njBD+FJV9jfhZiodgRnQOvYoG8Ma+AQytDE7p7sD+Kfluye4TZk5bgi2mkYKJj0fF
	vHNPSSTTxr7KagR353hO+xJgNAB6kWusMo6dKJyDz6XwH2sLwl5zRjRgeF9I9lLUsEjOVNz3ABG
	UAme++AOs/er8QiEhWLQpE+YSYqY5WcebxG+0y/wFcwcgGFc6Y7l/7UFcaHz7rRvlE7n1NfLtbr
	W4NdVweOU5IJQCPfiK1Dlzetgg9wXgKnea0knHBT44E/01RWH9CCbtS9ePvEAuRh1ImxLIH1LBq
	YvZQgW8hO6MgNHGvDCQgVSEkTRpBlidh+/9GSIYUlcUHbglBMZkd89ZZJcqFkUOW/S8Wgm8hp4n
	2PNEXK6B/uxu+kj3F3xdQZQ52sY9tOdkkKu/1X/CN0/Gef92dyN7yImu1lEUxf4WHyEJPmJOlUY
	2pBHpbSjf+/+EJsskkaLfzHJGxNekI=
X-Received: by 2002:a05:6870:1695:b0:490:1ff5:92a2 with SMTP id 586e51a60fabf-4a8bb9b9780mr2985162fac.62.1793248249018;
        Wed, 28 Oct 2026 21:30:49 -0700 (PDT)
Received: from remus.wit.private ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b7830d1bsm4142560fac.7.2026.10.28.21.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:30:47 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com
Cc: gitster@pobox.com,
	gitgitgadget@gmail.com,
	git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	phillip.wood123@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v4 0/4] branch: let --delete-merged find squash merged branches
Date: Thu, 29 Oct 2026 00:30:41 -0400
Message-ID: <20261029043041.5994-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
References: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v4:
>
>  * --delete-merged works as it does on master again: it only deletes
>    branches whose tip is reachable from their upstream

Thanks. I ran v4 (19a9630c13) on the same generated repositories as
before, against master (7e34d8174d). t3200 passes.

--delete-merged now gives exactly the same result as master on every
case, including the branch that was never merged but whose change
another author made upstream. That one is kept.

--delete-integrated deletes the squash merges, the GitHub-style
squash, the rebase merge, the rename, the squash that was later
reverted, and a squash that landed after upstream changed another line
of the same file. "landed as" names the correct commit each time. It
keeps a branch whose work only partly landed, a cherry-pick whose
conflict was resolved differently, and the never-merged branches with
an empty or net-zero diff. As the documentation says, it deletes the
branch whose change another author made, which is fine now that the
user has to ask for it.

Three small things:

 * "git branch -h" does not show --delete-integrated in the usage
   lines, although the SYNOPSIS in git-branch.adoc has it.

 * Giving both --delete-merged and --delete-integrated dies with the
   full usage text. A short "cannot be used together" message would be
   clearer.

 * The cover letter still says "--squashed" in the second paragraph,
   and "--delete-irrelevant" in the list of changes.

A branch checked out in a worktree is still skipped with no message,
with both options.

Tested-by: Jasper Mayone <me@jaspermayone.com>

Thanks,
Jasper
