Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470872;
	b=UNx30LDOlXsmrP206MUXhgXFyZSHezBzq47996M4EMTAUpFzhZfvRlFKYKVIBwtQJyth
	 Ac7dp8kkTnhRuE5gcvu1kt2UR4I3Qw8h+wtNCPqgPzy1axPn+rjMLpnhp/BG6uV1EWVZd
	 icsbnhYKbWVYf1LcxBMYs4l9WwANUfu3YY1qa+CEl0qNqryTj5DuMxM8rKIMmGEmrT0Bt
	 a+eKu0zdsr3nokrP1bjTOxc0ebYlnchfPleNcmgr8NvI4fZXleEQqOx+oJKpywKMTaJbA
	 xAwdSxN4YwguuCgA40/uUkzkwrvmNRsyDmuQhGTNvWWJi505ZWPCAAxt1nNa/bEEfbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Df6LzVHjtICkQOYg0CyO4fBKg0KYwubLeqHz3IyJzzQ=;
	b=hdy9kEwHYR8mNRG5DRmh93sPolNB1xOo5khF2COMJIp6XUMhBXt3ExP7QFSZTV1DhRij
	 BNf0rcZxxQoT/6BP+EhksI7IQBmO4nxdUKIAu5a113ZMhJx7qBLMAGGWEka7qxUR9Zjhx
	 1qi9/0fT3k7bOprtVHr7fYedytX1yP9beyyCmlZ8q/NX1lUoTlYuEhg5cV6WRHxICscKt
	 QVbZVuDRaAcKSy63M9yEnbf/YHhdUDa/9fndLXziUqIkrSGbB0YHkUGDkBVtZtSxJHxzZ
	 xnsu/64eaNQUTv9XQgp9aA3cSDzQMkh1BTKRZ7WA5zdfnBPjovrCxMGs93Qu/k3KHmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKxj0OTG;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69F606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF69F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKxj0OTG
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b40470fdd8so1819506a91.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795470871; x=1796075671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Df6LzVHjtICkQOYg0CyO4fBKg0KYwubLeqHz3IyJzzQ=;
        b=HKxj0OTGkbvbrtHl51tGzQkH3jWeoYM6gC1qLIpZidRV+nswy2yPpzZBjHeQpoNI8R
         7jwHCjWB6FJoKszfTZOgHqqhztlNw6aMrQlgjF10WHBKafwzQeXlW2ns+GO7WPC1s48B
         ziGMPn1zs4uV1ZHWDyIB6YR44en3JDdisS8gUDA7JsTM0MwggOSfIoOgFOPU4x9SCsD4
         dkxGme24Zr/G/QMBtfbPuR+J/qnVlZighXuCL9kqSGVzNkG/DVd63RVsCaK4RhEBztuh
         j1/rLWgWNFz9R5//q9yF3cRKK+fcgvFVg+9qhshJdfGkA4O906L/2kOxRPLNI4Rdk0F5
         +6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470871; x=1796075671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Df6LzVHjtICkQOYg0CyO4fBKg0KYwubLeqHz3IyJzzQ=;
        b=fraWFvLQ3RXlIbJERfmf2Syd4meNppNT4UUX/tYn2Wct7yd51q5zNIWh8/xwIcYwju
         MjAIhX+8rJboMjN71W7ZvFvJGiS4Pq4tNd4uCLPb4OFEOnWUI7jHFtmc8czQrIpCOwYF
         Vn1gIQTG1JLcrWOThcfrfVPEkJ5eaVVRt/Itf4zQVvaXlJRXw8k7yV7Rd/d+Hj8mzoRS
         MeK5FvybCuh9aGrENJFKw1k0Dt0YkxOp5PC4VxXjRMoRZhwFFSAanp6HzDugID4iGCCA
         FzPTGCt8wEFZmsfYkliXmJ35Ma2K6iBwvhIsby3M/7P3tw7uevk6AuNgDMMlAtChABro
         P85A==
X-Gm-Message-State: APuU4Z/aNDOprgxqWGtCubs0wqatiTmka9Cnc/MpY+xfOhvpIayIlpFG
	z36e06FJ+hs8bw0B4F/R8l6eT6Ks5e29NNxQnISzMWTmJJHNfiNXTNFpgCz+V/xN
X-Gm-Gg: AZFdTZcLKM8LaUIcMiaWbUU/FqqkE5zxjn8igQdTtWWVPGTAW2eFZJWbOn0HwG/C7Hj
	bg6/zhJsbK2wQ6//wFjyd7iRVczwL90AnFLN5kxl9hvegw2AZh/4L4qyhQVCiwus6AHNNNXmyyF
	CcV1cctxWFpldEeYpVjE+2c0Ys5nPCrYB/tUVBYQ5mmpYfhPOaYyhEws0j6C7s9oza6aDKitWmE
	EjAjOzdMCIpkodKuGU0byDeVNuQwoi3adJd6jqkKIQ/LPkKKoN25RCWnwMndHd4CH+tPj4OY51b
	jnz/4XexXtlcpSMckGvPCByIFZetBm3X6tNvwfnCtaH2JFkXhtAYnKp92sqhnkqr9hDPTPh3L80
	i/o+DURzS25KBXn68nuqxUM5AQvXTUqHVrdNyDA69IaSyixFziwSHsqIkzVAzaRAmMAPWngp4Ny
	61na93Y6rRAZ8OuLSxDSia8/aycoIIk3K6dZuwW7etg+gvEO10dTIkqSWsfryuEk2gV7K6cqCOs
	CF9RzBRwCnybmxec2U3dAhqYCIt/wIRc4wBQGUQE7N3DWIem2tqxNbXN4vVQr3KVdVlyJfeFeUg
	Xsyet4F9efWFgbqMI8u3qGxj0WT06zdeZQditIJhw8GRddJFldBBM3CIafWfJWAajlw2adG8Tkd
	dxqDuwPDzNm5FnsoK+ynOfcfHXBu2pCW14Zo3sFOBTr4=
X-Received: by 2002:a17:90b:224e:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3b41c7d6084mr10881246a91.8.1795470871078;
        Mon, 23 Nov 2026 13:54:31 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8c2fcesm6720472a91.4.2026.11.23.13.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 13:54:30 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Nikita Bobko <nikita@nbobko.com>
Subject: Re: [PATCH] history: refuse to rewrite branches used by other worktrees
Date: Tue, 24 Nov 2026 03:24:24 +0530
Message-ID: <20261123215424.27553-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqa4mz5mr8.fsf@gitster.g>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com> <xmqqa4mz5mr8.fsf@gitster.g>
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

> And is_bare_repository() is true.  We skip update_worktree() and
> update the 'main' branch via its HEAD, making the index and the
> worktree of the worktree at ../wt out of sync, no?

True. I am able to repro this. In a bare repo nobody has the branch that
HEAD points to checked out, but the check skips it as if the current
worktree did. So "git history drop" moves "main" and ../wt shows the
changes of the dropped commit as staged.

> Perhaps head_target should be initialized to NULL and assigned the
> resolution result of HEAD only in a non-bare repository, or something?

I think that would fix it. In v2 I'd like to go a bit further though:
ask the other worktrees if they use the current branch instead of
skipping it by name. That also covers a bare repo and a branch that two
worktrees have checked out with "git worktree add --force". Will add
tests for both.

> I didn't trace all other callers, so there may be other glitches I
> did not notice.

Went through them. fixup, reword, split, squash, drop all call
setup_revwalk() before they open an editor, create a commit or update a
ref so they refuse early. Will add a test that runs each of them.

> It probably is also worth noting in
> the log message that 'drop' updates the worktree while 'reword',
> 'split', and 'squash' preserve the tip tree and 'fixup' incorporates
> staged changes from the index.

Point taken. Will fix the log message and add that.
