Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851450;
	b=L1TmCP2nHo79TnHITVPoUxvHqXMr+AEI5BLlqBPi91AH07lWkaIKTDziSFfI9f9tzQXo
	 6ivPSzP49Q1OVNYN+TgpOWLw9VgJ4aejWFcm98YalNOyl/9X3pL9JS9/VCrP9vJa03Xcu
	 nXtZBf72+0NOvI8YLQP2Ma7g8c0GglnTkchvQ0i2hisKP0zpmxPbq2cPhR8pZfzOb5z/I
	 icxxE47NX/Jx7EQ9/SV3XoUq7EfekjsyhpGCWDB7DOaWbB6L9LFqAH+OaPjmmawAmjy3X
	 Z1/FAJOZIeyBMzrSgleowsiN/mVKVZpRiA1BNLPYDFI9rBFQHlpE/aV5twtkdkqPX3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZNbJnS+K0w6nNB/wYOfVXeXC8fKY5iCMqCS7nF9SRfc=;
	b=CX3Qn0ODOqEasHXRxsPhJO24lICoz3x6qq0gBBbxORUtyDN3oCoTCKOP0Aj74ba8NXHO
	 deLwVHL5lwPoIWsWD4+PIvfqm10cvO3IevkplQWxhNWBm4J9V7Ur/f6DbZn7w1Jhmc/Jv
	 Rb6mDS4fcPLQbRZZBjuo0DrHPi+haJg2/tRlKy1MvQSgqhH227oZ/EK9M2I5SoqAhIIk6
	 ualZnb21knWmr7NpvMndpx3DCIzMaECRWBN1NxjbyVXCBPRi0TEQGFVy1f1B/vOnY95I2
	 oi4SknNTgBxFOihVIqLtQerwwRpx2jIosWKmEXI5qOh8tDnvrZZ1vwHdsTTo/n9TWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I590kMrJ;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387A606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D387A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I590kMrJ
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cded697ba49so398054a12.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795851449; x=1796456249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZNbJnS+K0w6nNB/wYOfVXeXC8fKY5iCMqCS7nF9SRfc=;
        b=I590kMrJyXIN7HZbMhaCv4ayMifrPRXxSpR78VCD1HrB+AUe9+mpP2nbR7bsKEhC99
         tQC5MFjybNRRkFRHn5aUw4wFdqFTprjvDCbOJpt0TSryAlR/LuD5FWb3EMa1x3SuOgpB
         ujtULm/1to/5ZacnFbUwcElrzR2akCeFJuE0ZPAcy3PiFitpcNR7aHYHZG+UD0Df81zq
         3FpByovfsA40676tujqXQRbU0J0v+v48MyuaKpbGu6MU8wfsU00dngVdBvspvWJjIL+7
         adOSw1YaHlI+NPkhrivv/a0lYXrd2f8dB0Fbv3yGS7D6PLoEAZrXOHuCWDNThX6KAkW1
         TKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795851449; x=1796456249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZNbJnS+K0w6nNB/wYOfVXeXC8fKY5iCMqCS7nF9SRfc=;
        b=dEkh/AWS9yGeOfUavxBhFk8ZqMkO2IBNs7OwUDO1jNe7iCZxfD6LBAG0ADH5PVIGeb
         dYHXSHBH3a3W7QDRMaJ4uBnKSnoXV2sG06bgyNgfR9alLDzK58b9/a8LHx+1dXkktjkR
         R3h8bSuv7hPhxp06nNxfejuJVbzoQT3fwnPAtByBwgxR5m1vPZdYNevPZNOeoDfxATkT
         9I35+IuobsSuYGaJBX5niemekgzkxxqsC5kV9YkQx5GpEiIo0zfqDjQz0Et57t650Odi
         pX6VnuOw4UBeQEc1BRs7n8DzOwpz6+sKXeinyEmFEqw3jXiFwTZvt4oRdHQiEJC5OwG1
         UJHg==
X-Gm-Message-State: APuU4Z8K6J/xzHHvUmDT5Qv2rz4AJNBrvaHUHOSvPnGysjcdH+BlpQMf
	mEgpdfNvg7mXN9N4dn4wEG7JWZjRYTyxZK1cMHMoEec7XVJK8FlJoE7y
X-Gm-Gg: AZFdTZcEQbbJcKJ6XK1f5DVX1IwVr8nYwdEizoPRakFwpxymRr4ohEO1vAMcfzeydzM
	dDJFD9UAwACMpaCtiZ7Wbd2vLZjAPt3G2aUnAZWHs2gLaNytpoGDpj5zq5oUkywIj0WOikPXAc8
	J3OkAG38MKhAcYixyMJ2dYCceUlTy/775p9Jc74du+CbdL2Kx9+yRVTsHKvwYzEs3ccDER+QOFR
	LVcx3PLvi63wVtLCV644Ihia1C/5AzN4/HsdSWDjJLDlsxtQq+zvcqGMBhjS59IeK7j5HdhKUUt
	qRwIG+VA/8J1nuQ3iCxxBLZK0P6ESCivWkrrt1WkvXAw/iKhUpLaiFWkk0np+Lrj8JQxqRHj1IP
	a+qAREXHW2I9u5+gp7d2ti2QlPADcHCpcLiZ02lKmVJSy+N8P/XPabI8l5qIP90YyzwbFzCxw/G
	IZHhYutO4mMCtogCotvb/JuVPIWtHBFMnwyT9pV25zZ6BD7dkurkC986tQiUU7/tgxGg8DUqiZW
	F5k7xh15QzVyyIN6ncWWFDbD0vMPlw5HzTzDCDLHw4JjgT7XPpw7eojURCM5a6vWv6NcaKX0+W1
	MdoSqpRVMmRR15RWGlwEcRxHHQrvK7+fM1+wJl0GPT5pQrenT8NLWw/aSQtrEQI2/GARu7/z71P
	DKzrVkM08gEIrSgWPeO87SSu+17EJAw06JOzTG/N+6w==
X-Received: by 2002:a17:90b:4ec5:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3b41c96182bmr26262301a91.59.1795851449113;
        Fri, 27 Nov 2026 23:37:29 -0800 (PST)
Received: from localhost.localdomain ([223.190.82.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm44619657a91.16.2026.11.27.23.37.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:37:28 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Nikita Bobko <nikita@nbobko.com>
Subject: Re: [PATCH v2] history: refuse to rewrite branches used by other worktrees
Date: Sat, 28 Nov 2026 13:07:23 +0530
Message-ID: <20261128073723.75806-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqse0l3jbr.fsf@gitster.g>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com> <20261127173252.7794-1-aniketgupta3001@gmail.com> <xmqqse0l3jbr.fsf@gitster.g>
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

> Spelling that out directly would make the paragraph easier to follow.

Makes sense. v3 should say --update-refs=head leaves the other branches
alone and only refuses if the branch HEAD points to is used by another
worktree.

> As tested in t/t3450-history.sh, when a branch is being rebased in the
> current worktree, this advice is also shown when the current worktree is
> rebasing or bisecting the branch with HEAD detached, not only when it is
> used by another worktree.

Will fix the wording in advice.adoc.

> What new things from log-tree.h are referenced by this patch?
> The file seems to compile without this new inclusion.

Added that by mistake. get_name_decoration() is declared in commit.h,
will drop this.

> Instead of enumerating every worktree with get_worktrees() just to pick
> out '.is_current', we could call get_current_worktree(repo) and
> free_worktree(), as wt-status.c does in wt_status_get_state().  It would
> avoid reading HEAD for all linked worktrees, no?

Thanks for pointing this out. Will use that.
