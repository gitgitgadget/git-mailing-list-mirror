Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042899;
	b=a0Ue9yFqAyu2CgAa8W0LR3vYH4aFCYadcGLcRC3fvEbB7RYDfPWVEPfqY2QZyPos/EWp
	 QLEiMb1Z89QSFIh9TNqHtT1t3k2a6QQ+QV1AUc/K9U4SCI9KKn/gvu9ZjiImKwaliAan2
	 jbZEBuAazQBRB0/qJs0YpG9sLQWac4304xNGNfs1eeflCb121pr0zUz8PApp6mUVuVWLV
	 YjR10KXIma1cIlGsOi0Plu7v7cBrlAfXiiKsCB7fH1GAsumj/UEBU+1LI25qcu9m7Y+j7
	 OcuTc0Wn3DOdz+CPYCBFtSm6HWNRSFQjM1sZFS32ixykka0GdOjTeOFpQO4BpedlV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
	b=yxgLNqwlJpQVAkXU/VS99dZUVzOnw/HIkTvZjvO29hy8U5uuIj+MJqC6fsEqatym0e9z
	 wTgQZy9kdl8U+TA3BRprLp63aqOq8TV4KpW5GzEh7Wb30s6kpPMC6SuPKQxO0sQ287H+v
	 YUOx6v/YClxqIfDI2Y2tg7AfMQerz7BLwq1kQWtQZQZwvifBv9wyoOkuZ5przoy8fFyc7
	 Wn/TAf1UyeoC7CO7ASihe+uv845rHRLdYH+ZD9iZiB2EL/3j0gemBOR2D14MmFn/aiUjL
	 Take57tc6Nif81mK0jajz0h+aX8feLVS4pW7UE1NbgMjCVca39HwjUJ3flMnEEYmWTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUxXy2Cj;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D02606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D02606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUxXy2Cj
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so2736717f8f.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793042897; x=1793647697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
        b=MUxXy2CjLGapXcT/PIRaASt4xcl2BHMLhVBBq3vv9mzGizqO0uOmE0rVWr+Uj/oi3G
         jjPdNuSxF8zxe4jxN3xqtdbTyqBVR1HBknr2a8EPUJy4f1w59UB63GsWN66yYzj4r0Gy
         t6n+O2qoxOCxyQ1rFUJT828TSpWibibUvslh7f3UvtBRJ0iMZQLUa5hQFfJuglGWcONO
         i69Sa43Mo3I3s8N+LAIPj85faic4wksLAOTz69X1RKpGZJAIAWhlMP1x16sgf6L9XQsU
         TRHr/gYSSr3SEcHW/L/uutY0+4fD94LjWWCh1qL194wuiplUQmZSsH1kuzblmemf0ETU
         wRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042897; x=1793647697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
        b=N3gnEAR6XH9TzOcQrlKEDYv/kYiv4V6l4624oLuFE4fEFqXbc/DmSqQ3TQBy962pcO
         8grU0ATDQ8su+leOg0Aj0cN/n71Vmm7gxNshuakhhOxHCjAtNV+bZRyJteAeXW9hE4Kf
         3tB4m3Z0fasNPBskM/psGKQxfm+ugNjtHKrdVzocA6QQMPILIo4aDO98RlsoklCrMVtR
         w79az4+0Tn8BCV4jb6qJrWHX3RhToM3wRj2NxjOmTHngs3kFAZ0TN9pjnfKfrsrPvOxn
         3U+iw9grNb3RLRMoMDDNqzm8BGrhTXcyPKqXtU2t1oPuImEtZvhxk0TlRmt2adH2Npzn
         iY/A==
X-Forwarded-Encrypted: i=1; AKwUvBxZ3UUk7qWdnE6dX0xl+V6cOVtIuM2pF8TXJofry1Yk2r8PKj8KWULt+9CBMXyqlGqMr6Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHA56HjV24Hqve9T9xosjjnZ5xzH2uPjoRBF7jhjtFNvM+6qZH
	4P+uMj74fimOKKjHADzP/jVRxx/hLPBCYCFfD94NLd8pdL0Y4NXjyTSO
X-Gm-Gg: AYBFou2lxsGNS37kHA1jNip9Pjt4j67nmrWgeDf6vxSgntr6CtG3Zgb4rfDPYq+Cege
	lsUTO+5AHpouSN44PUd3HjVCoigz57VjZ3/qpPMULppzCtc85FSZMIfejOs8wmq/g6u5SvNuXbt
	LcFBz/hzJZQawAxukseX9QtA9iatLSuuDWaT1KV8KbIWFSEIWJS25U0qDCnQ9PTP0Rv25Ui/oeN
	g+jtLI9MvXybEeznD1sjO2ObloPngEPiC95nYl1iIADyh4o+/anlbBXTxsUA4MEvL0N0zITDEgL
	V8aMic3f/2JUdB9qkUCLv8CNYNvAJiTeqK7etWOy2HsuGdSwC/597y41yOOuKtGAmxNWnOsa5ri
	pCUoXj3/Guki7xW0c4uQZPbg+M8Zw2Elb8++wYdOfm+CUPSGzS81K1SNSDP3EKae3L9LTiGoc1N
	Z9GDnwpvR3ffPzQYnF//qQOulZkg7a5bDsBH+/jOfH0b/6cJrqI75/mTklHNJjkrkMaXm9BiNwD
	6qlT1HUVJwCwdpYcTtFJvb0WHZoVwbWaQOMUA5IZo99T4LIIp7do/H0QikR7UZ+9kO4yBbkw6CQ
	jI4a
X-Received: by 2002:a05:6000:27cb:20b0:48a:fcec:2a29 with SMTP id ffacd0b85a97d-48e3eb61590mr9691130f8f.20.1793042897237;
        Mon, 26 Oct 2026 12:28:17 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3c32sm18519047f8f.47.2026.10.26.12.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:28:15 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v7 0/1] archive-zip: refactor 'path too long' error message
Date: Mon, 26 Oct 2026 20:28:02 +0100
Message-ID: <20261026192803.1985-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqotsm8qsdl.fsf@gitster.g>
References: <xmqotsm8qsdl.fsf@gitster.g>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

This v7 addresses the feedback from Junio C Hamano and Phillip Wood regarding
commit structure, missing commit log message, and patch threading.

In previous attempts (like v5), the diff showed 4 deletions and 4 insertions
because it was compared against prior iteration attempts. Since this v7 is
flattened into a single clean commit applied directly on top of master, the
diff naturally shows 2 deletions (-) (removing the original master lines) and
4 insertions (+) (adding the complete Q_() structure with correct tab/space
alignments).

Regarding the mistakes in previous iterations:
- The commit message body was inadvertently omitted, which has now been fully
  restored.
- An incorrect Message-ID was used for threading (replying to an older
  reference instead of the proper discussion thread), which is also corrected.

Summary of changes in v7:
- Rebased as a single clean commit directly on top of master.
- Maintained the exact indentation approved in v5.
- Restored the full commit log message and proper Signed-off-by signature.
- Cleaned up unrelated modifications from the working directory.

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.53.0

