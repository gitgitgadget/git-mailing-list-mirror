Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575771;
	b=1DI+Yi1voCup7Bm0TIaIiR1StZA/YLpa2Cqu3z22aMz7K3bfGcwnGoa0UcuOHsOZ9koy
	 K0YisZZ8FunRQPERV+N63ceViNMGzLnEUqP4vqJiErgYcBeOoLcoYANhzVKSY6M8zPJyU
	 jKVEaBl/DGNH6O/oqhdRH46Jpc2Y1pO6KUsmT6inb9TndqyNX0dS4jcnHLxAalnxowg3i
	 z+gTMsBT66LXXf8S1yeq+4Jb5Zjpr5TR4L5nJ+RNvuVSMnBRWQ4roxCGftY/ebUKLK9/n
	 NlEdsXKz2dTMM9XjCJ3EsYjX7Os62fTOgG6bLsQKLg6Q2p8g0vHF9e61VHldv3IeS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=jM6We9XT6mltkx2hy2KWHTcrXFAkPdi84oNCzk+2jTk=;
	b=C7wQLkbuadboSQQQDNMC9kB9LsaXJ50A9/BcVa22/wbn/qS52LTPByfGfpg/pup6YRd2
	 ByYsTLnAlXbplm2MJRtzNIvbaJRY6DpUzlTp4wYojNX7TG5HIJLgzFR+WCAX56YXdawOd
	 1UbdHN7N4ku3wCNCn+uEO3PrbVSnuoGF3AQq4PwHvY7zlNBROm68Jfi+HFYWSf2LAb0Qu
	 dXnTgTNIOE7SIyZ/3oHNRcz0mVH5ueJpBY+icrKOkWowPUFH2lTLzaVxPOOhu0ACKhCdt
	 giilCTP4uzlxrdxzNwHelDqr5nFwRauYp6Mj2m+OJU7iDq3vXjn0kx0GYdg7I7+8qdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcjgvEj8;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCD606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87BCD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcjgvEj8
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a17a332ecso3983630eec.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575770; x=1794180570; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jM6We9XT6mltkx2hy2KWHTcrXFAkPdi84oNCzk+2jTk=;
        b=EcjgvEj8fpeHk+M7d4K+9kqazgp8nBHC/LJ+Upd5LpbTrGN9iFn7re7w5ZJxUhZCRi
         0cTTP9H7PYPiRCRGs2eKXs4KSLO9H6kO9/IaaMclZ4dUwic3VAvDWFN+iPsRorsbxCJQ
         cpp7k/QvjRPsVAKx14NzAkUyINJH80o0mMJbW8O4ImBvzl4dPH1N+kMQ8S+IAVg1/1Oq
         aBwS/G3+ZJZcQwztSeForawsknkThGJqpWbWy9oKZnIw2FfGzne6kK0PactLgqappXdh
         ZWkOC5BT0/uQiwcpl+6qsgYSTONhf5C8/p6CLKY1wxtDlzjHHIED+tNukal9DhAMTtqL
         ewBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575770; x=1794180570;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jM6We9XT6mltkx2hy2KWHTcrXFAkPdi84oNCzk+2jTk=;
        b=RVUlDsSU01kxZzgpmg1eJMQClSgCetwXhUllDFUVxovDTRIfpXxPJPPMTEqlbfxQGa
         tMOlCPNHsZICuuTITU8hWaFBpItDF+q+UNS5qlbJaLoBw0W0vT5FD2meBvJegQN5+BP9
         o18tYB8ACfzBt5bv8sRnI8fKVY9CwlG7SU91yk4Okj1SnDGk9+loq+na9N9qwBD2g08Q
         lbPfFj7h47OeLBplJhbFLDwzgraUEu0eGOio3CeHp9ClvquKwtwbwROb9YKgpZfJCR8r
         npFiNhny1kpSce5Pfkh8Dx/IzAwzLOVYc8iBzqIi2yJKs7+4MrKPkjsKIqRZdVtRQUdQ
         hxfQ==
X-Gm-Message-State: APuU4Z8wIP2RwyPYVUuzCvBHJ9XWRQGPlmlsPQX5U089WNRYp00QrsOF
	HLjRHJj7VlrLPXQ/zWPGRWV0R9gWKD3JSe6VoMXcL8GsXvGfo+5aMptw
X-Gm-Gg: AYBFou0l3GJ/mtdjnusXiP6iNYLPIsU51UXTdKEFtVhHZsL6z6JLL12T/jjT3hD4QJg
	0vIUFx5YIYz54iE30LirfrueNY8XtZtjhK+dgdNoe9SQ48+CJbb4JSr58lDno0VWK0IJTxAWxx8
	UNdMNJWNs3fZFVTtB6MVZczpgULoXQFvHQjZGnzHygMkUuZCxy/tiOVzK1k6EEZ/McvyybxCMTH
	iV6SuU7ZkLmcwxEDAFoOG+2sQxa2ikLkdIlY7VrMF2w0O7mtD1P3g5UA9qBigZhGR0P1XFj1YKA
	eDBK2kkzB3C1hmik63/NjV0ZAcj/1AgbQb+G3ibEYOPMBIkW9qy6bn5QxB4xeZA/VejFrSG3Yjw
	gh22ok8ClHbCAr0/HxMNQMF4scrqoNo/Dq4EUFO+WJMvdkl9bqrTahstmwHzfEepkeRKsoAGY8S
	SYktm80ZmsZxDdUOzcxTjt+rhKgxmD3AsBnD4lbvPLjCbSVd/7oTZGXmPQANSwHr6TXWbk1U1gq
	FkTUulE3Vp2UH5EBBfOTM9Fb57O8KtZ8ofxOHzmiTP/MTCYa0DhKS3XSuWfX71KWqzB8Hzpr67O
	MTzPHGthiXD2RQOSqn+eP6BKcKA/nm10MZ0o
X-Received: by 2002:a05:7300:881c:b0:369:ec31:8fd5 with SMTP id 5a478bee46e88-36a42225546mr14336906eec.3.1793575770234;
        Sun, 01 Nov 2026 15:29:30 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm30367724eec.28.2026.11.01.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:29:29 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: [PATCH 0/2] credential-cache: fix two races when daemons start at
 once
Date: Sun, 01 Nov 2026 15:29:24 -0800
Message-Id: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCQAyE4VcpORvYlG0Pvop4WNOpjcgq2Spi6
 bu7tccPZv6FCtxQ6Ngs5HhbsUeukENDOqV8BdtQTW1oe5EgPH5ZHQPybOnOmnQCe1Jw7EKsC+2
 jdFTvT8don3/6dN5dXpcbdN56tK4/zBVeQHwAAAA=
X-Change-ID: 20261101-fz-credential-cache-race-4504110c6415
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When no credential-cache daemon is running, two "git credential-cache
store" which run at the same time each try to start a daemon.

The second daemon unlinks the first one's socket and binds its own,
which means any credential stored by the first one is lost.

By products of this race:
  - "git credential-cache get" does not return that credential;
  - "git credential-cache exit" stops only the second daemon, and the
   first keeps the password in memory until it expires;
  - when the first daemon exits, its tempfile handler removes
   the socket of the second daemon, whose credentials are then lost
   too.

This can happen whenever two git commands store a password at the
same moment, for example parallel submodule fetches over HTTPS.

I found this with Rewind [1], a deterministic VM I am building that
replays a program under many thread schedules until one fails. 

Context from some history spelunking with an AI:
  Jeff noted in 2021 that the daemon's socket setup is racy [2], and
  expected the worst case to be a daemon that waits 30 seconds for data
  before it exits. That holds only if the losing daemon gets no
  credential, but its own client stores one right after it starts.

[1] https://rewindvm.dev/
[2] https://lore.kernel.org/git/YCK5K%2FnK4tGnTvou@coredump.intra.peff.net/

---
Farid Zakaria (2):
      credential-cache--daemon: allow a concurrently created socket dir
      credential-cache--daemon: do not take over a running daemon's socket

 builtin/credential-cache--daemon.c | 43 +++++++++++++++++++++++++++++---------
 t/t0301-credential-cache.sh        | 23 ++++++++++++++++++++
 2 files changed, 56 insertions(+), 10 deletions(-)


---
base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
change-id: 20261101-fz-credential-cache-race-4504110c6415

