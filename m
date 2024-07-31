Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B41AD3FE
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433240; cv=none; b=UZmwKJnVmxvWddv8LfqpUwrbhrNr8TnSQUITb8+UrMgs9kzf2JloEV1dW4hlH/VY0ao9PMbL7AmeT4j2pHBLpoR227U6GHCFM2/IYnRqavp93o7YA/sPdMUsF9mENun4tnoYxqmmGATnP6hxRtrURFyxjWXprcChPDAGL0NV6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433240; c=relaxed/simple;
	bh=x8S+qPDU111RK2dqSH0i4snsWW3+00wYostazaHGb4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TclY7IR/Nd5ySD6jjwu6nusJ82baLS5Lr4QplnobKmO5mVyQ8v1q0m2KuVpDljRum304aZEDJ4rhpIDFiKnnA73zQYmVo7YuOHVnS3gGzQVPFC1f0Ze3KFe/Fi9DEbjR2O0U6Iu4Uhbnzhu0TM2yhK7oPFYouALwHgPOWb38XPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7Jf/GRe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Jf/GRe"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6119160a12.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433236; x=1723038036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1oUG7WR26IJxpogLgi2Zhf5V2c+tnYgREa6d3BIRmg=;
        b=d7Jf/GRec4f1vYR0qok/WHm0Gc1JmUQC+A2zWplBXlEzqDEkLz72O3qK/Np/51NRiG
         oCyYpQia7L1WxIDdG1hfDv+atf8FPg6kt73i7OIhQOrCBKbwERjuVH5N74jldfMmNNBM
         EYfkfSaI3i4qu0xEFqAuhgGdPPpvHTMrzM7L0Ft+rbnw5d+PbIiAFh5Kkytfm+EL+Xuy
         ZzmKrvWobRB3zC34fy2nhZ3gQeM0+6OuBWGR2C0CLioqMu/7MAH2X9HgtJSobkesOvI7
         trAjweGM+k4MMmQrLTHnUj6R/EsGg+Yckk+p4zVPxKSPFIvwr6J4vX2kOYC71RgS2JgI
         S51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433236; x=1723038036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1oUG7WR26IJxpogLgi2Zhf5V2c+tnYgREa6d3BIRmg=;
        b=YER0NZg9nrzx1dMNB3QUzNewhLaZfsen98xrv1ZWNlVgNgnX1srCru8L/gcNBL75/d
         NSlVQqR+vCn8yCqU+P3i5JmLq67FjLpr3h28h4FXpawYVf3VPphukVARnD/LiExfvcNt
         ibQ9xIj78gnfhlK8HUTfPqBBD5MMShO8VsscjFKJqMmMN33a31zt8bOMmcsZaygx33VH
         3m4fpS+6Gp9iwLwgrzc5hzzJXCQRXDPl4cl4fRdfvzXLcQwLdFlmQ9Dso8WWhzxXajki
         1USYuQoVxkyEL2x0Q2/MDGHpNZ+L32bl64HzvHkVsSvQmDPVvifjWwhlMv3IHLnUQpVW
         EphQ==
X-Gm-Message-State: AOJu0YzSdF56COCOdcAHUtuCWuYOnRlL1P53tKxRW5E7/f4PfAYlXdJz
	cXuf+4NrUEmGVl5kv0Qx+nsKVFIEAKDhvbM39A+EudPrvjtzTye4hTNJhg==
X-Google-Smtp-Source: AGHT+IFMxdVwAnRVt8sHMo2MBT1ChfR6j7GCYBQmdryEIK87Rj272uvjGXbXx6fF39bNAHg2poTWDA==
X-Received: by 2002:a50:bb6b:0:b0:5a2:eab0:4a with SMTP id 4fb4d7f45d1cf-5b021d2244fmr9756233a12.24.1722433235937;
        Wed, 31 Jul 2024 06:40:35 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8669641a12.56.2024.07.31.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:40:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/4] Introduce a "promisor-remote" capability
Date: Wed, 31 Jul 2024 15:40:10 +0200
Message-ID: <20240731134014.2299361-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.gbcb884ee16
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier this year, I sent 3 versions of a patch series with the goal
of allowing a client C to clone from a server S while using the same
promisor remote X that S already use. See:

https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/

Junio suggested to instead implement that feature using:

"a protocol extension that lets S tell C that S wants C to fetch
missing objects from X (which means that if C knows about X in its
".git/config" then there is no need for end-user interaction at all),
or a protocol extension that C tells S that C is willing to see
objects available from X omitted when S does not have them (again,
this could be done by looking at ".git/config" at C, but there may be
security implications???)"

This patch series implements that protocol extension called
"promisor-remote" (that name is open to change or simplification)
which allows S and C to agree on C using X directly or not.

I have tried to implement it in a quite generic way that could allow S
and C to share more information about promisor remotes and how to use
them.

For now C doesn't use the information it gets from S when cloning.
That information is only used to decide if C is Ok to use the promisor
remotes advertised by S. But this could change which could make it
much simpler for clients than using the current way of passing
information about X with the `-c` option of `git clone` many times on
the command line.

Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
and C have agreed on using S.

Christian Couder (4):
  version: refactor strbuf_sanitize()
  strbuf: refactor strbuf_trim_trailing_ch()
  Add 'promisor-remote' capability to protocol v2
  promisor-remote: check advertised name or URL

 Documentation/config/promisor.txt     |  18 ++
 Documentation/gitprotocol-v2.txt      |  37 +++++
 connect.c                             |   7 +
 promisor-remote.c                     | 228 ++++++++++++++++++++++++++
 promisor-remote.h                     |  26 ++-
 serve.c                               |  21 +++
 strbuf.c                              |  16 ++
 strbuf.h                              |  10 ++
 t/t5555-http-smart-common.sh          |   1 +
 t/t5701-git-serve.sh                  |   1 +
 t/t5710-promisor-remote-capability.sh | 192 ++++++++++++++++++++++
 trace2/tr2_cfg.c                      |  10 +-
 upload-pack.c                         |   3 +
 version.c                             |   9 +-
 14 files changed, 563 insertions(+), 16 deletions(-)
 create mode 100755 t/t5710-promisor-remote-capability.sh

-- 
2.46.0.4.gbcb884ee16

