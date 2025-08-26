Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E738DD8
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193812; cv=none; b=snmaQU9vqJEhRgqv2yvruHaJUFFQ45mMcDUejFyC+xtJgbkoL2NZQ/Ac6+9hbXATxUl+cbOXn75dLbxn0hH57BPg990x1zlvUilYo4FpQof+SaHpnt8er+ZvgFMjuPXEVdccKq89xPcrN1yl+T+me9vvSqgWc8L67Gazgl3FJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193812; c=relaxed/simple;
	bh=MECiJpuawTj+q+u1tGDxFNM+LlmtMRV76CLv4Nqni6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ug2JZtLD5N/EmU+4TSffYM+ApTmN5qIFuAc0lKFn39cvYC4asjE4gDSAFFE5K6mvPvaX+nd+yMTZezLNL2VOhj7kztI1EeIHnbjJ3aE7oQiiXXHXtJ4ppC2+frGKF558X5teTpBDohuvBQTPuEiVWLt+jjr5bXp8sT7O29MCnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqVItlaE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqVItlaE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3252589a4afso3099080a91.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193810; x=1756798610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMaA+pbHd7FB3KtVJdlbMKGi3237GFB3QWaS6xS79Ic=;
        b=UqVItlaE1XihCQ1GiIDOotBvV2Azd+OOCr1z7WGZeN6m/e4vsYHe0T3Z1aa5UcFi5i
         a/kQpROKY/Co69Stm1T2msOF4WFg2aE7yTXlfiPNwfuojpizBrv9vizk6rmVCXyx/4VP
         u8jLNHpUjmpSyuSzvjjDVmmE8Dlvwe5I4S4RjqLafZLrrAjEptSsxGQFpBTRRYKtmFKw
         33FyEGccYInYuVbiifuhPcjMfzn3L6Vm4iKhcCDWZtAP/cQhSf2aM6n60TQXAahzl0OZ
         wD2yHr13CDQ5KzxxmaQx4tY+W/VDk+3qPsUjz6/PtatxJdh7ESwfqfO6m9BK+h/qHy+2
         qbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193810; x=1756798610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMaA+pbHd7FB3KtVJdlbMKGi3237GFB3QWaS6xS79Ic=;
        b=Odqonz/kUhOwW6m1K8sBZPYK2EGp6oIRp4haIZqZjiLVffD5fjVGD9r6nqKzAkVjV/
         0jrNTDIuXErbWzj77a+CnW3yPuatUK3uxMdovdblrimSfsYDJefYmKs4fgrHdHDJrLgp
         osAzyuzPJVWZ6ffDGj1KbEgNifvqaH8fwHsFkeszVAXC8MINiB5N2hbbEPqgnzmla5Wa
         3TNfY3uLvWyPTJDxqi7iOF31p0FTmi0Tkwpe/FdnK0DtUUukYSALYqBBGeT2OxC/DqUC
         SZOzPv8ZYSgRPR/zzX85xOzIM7IFXsFy6iBYvxt7ZJLFWWL4QWQ9cugKCFpmwUZOVbST
         zxPQ==
X-Gm-Message-State: AOJu0YxaaTFnoID1aLycO+D2Qqo26kfBi+K0Ba/dcTqdw0m0issRXVp6
	QaMgsMuLviQL8SQ68zVY6cy6hSZtfBahkpVLnVOIusefabGB69VbKAwmFOwikQ==
X-Gm-Gg: ASbGncvZgMG2+G/czLKr+qsplTUXFPM/60PpInh/lGKblmGiU3mf3uZ+PS+BCynX9Sl
	C91FDn2xWsRaZTY9zSqPVnHH3tW+vd0tNz4fBuNX7SslEZR+n9nAjuuJXjhRlOosw9yKUkzv7Zu
	AbF/tsWbwMbkjppsIbb9N25ihkXW8n/KpLZhASUgzn3Y3L43bGklVY87gHx1Kks2cd8kp0XpS1L
	eqTpxlUryII16vAhTyT/8zekh0kfnv8NxZ64UVIGO6+a/WPFEN+cRi1MDCYGJmOz/74zrEMKbpG
	dQesVagEFjWHLqBFhqHZe4F/hGcL4wY1LPpXQPtWWWXTd8PHvXRux9fwWdjHfI312mCk1KOUuuv
	4jvbMqsbQn/o5odL2Ije0QIi9lhYScQ==
X-Google-Smtp-Source: AGHT+IHv5f6vV19wQ7ofJkIxzrD7ksxW99Sg/0u5tiiUyv0Ur7c8JU6E46Fi6Ed80uu1kvFx3bITDw==
X-Received: by 2002:a17:90b:1d4f:b0:324:eb2d:7537 with SMTP id 98e67ed59e1d1-32515ea1b2dmr19569031a91.20.1756193810276;
        Tue, 26 Aug 2025 00:36:50 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm4046216b3a.27.2025.08.26.00.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:36:49 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 0/5] Add refs optimize subcommand
Date: Tue, 26 Aug 2025 13:06:40 +0530
Message-Id: <20250826073645.1074397-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces `git refs optimize` as a modern replacement for
`git pack-refs`, continuing the effort to consolidate commands
under the `git refs` namespace.

Meet Soni (5):
  builtin/pack-refs: factor out core logic into a helper
  doc: factor out common option
  builtin/refs: add optimize subcommand
  t0601: refactor tests to be shareable
  t: add test for git refs optimize subcommand

 Documentation/git-pack-refs.adoc     |  54 +---
 Documentation/git-refs.adoc          |  10 +
 Documentation/pack-refs-options.adoc |  52 ++++
 builtin/pack-refs.c                  |  31 +-
 builtin/refs.c                       |  16 +
 pack-refs.h                          |  22 ++
 t/meson.build                        |   3 +-
 t/pack-refs-tests.sh                 | 431 +++++++++++++++++++++++++++
 t/t0601-reffiles-pack-refs.sh        | 430 +-------------------------
 t/t1463-refs-optimize.sh             |  17 ++
 10 files changed, 572 insertions(+), 494 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc
 create mode 100644 pack-refs.h
 create mode 100644 t/pack-refs-tests.sh
 create mode 100755 t/t1463-refs-optimize.sh


base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
2.34.1

