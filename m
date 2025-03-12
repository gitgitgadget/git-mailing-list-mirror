Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2721BDCF
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762023; cv=none; b=dGxwdxP5a1aZClYgh77ygrEJlfSZnqWpXo/migfZJe5+2FV2kkjmtmeKmIP+MElI/JV6WWk0GWChmQMRhzxpcAefLh0eIJlk6OLbI5jbeKpetGxQ7sREeAiJt2LB+POmgRl+COEpyIqxMcnANmNmHHk2BUyuiAQFpEZv+QHFlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762023; c=relaxed/simple;
	bh=FFN/p6LHLVMK9silEJ3nVgD8iHAlgIrE4cf/iCYGJY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrRkIpK+8+j84G8oeN4c9++cmr64baMfBqCD1aA0nuUauYx6eBLuLIsMD2kdfzcZRlBKROZrkkmv+FZkX/KrlaAl3YqFHaQy5FQLQAqS3vOysLIV5vUjTornlj8BPtmCfRIYCg0cUJCzVtSy1xXOkZ7VT9CL5gog++41I/TDYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLRDPAEo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLRDPAEo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223a7065ff8so28265955ad.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741762021; x=1742366821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bbOKtCBwWqQxZYFA9CfjgKY3NdaSL5avyY7w1YGOGA=;
        b=KLRDPAEo82kxNwRnJeA/AvGQrfvW6nG7KAFxDOskj/XCOv90R9ej7xyNDaIRSAgW7T
         akkZftxIay+7AJO2nGh0CEbqhbuwJQEfiPKd8WPN6f5XrBQPdJpDObzAz9BzFjUGgvO0
         uZkuQIgwtQcM5hkeqZTSRmt7xicyg2R5KKLqNRH4wMMbX8dZbF+joCPvNDNCCpun7TZA
         VgFErPA49Mze8ylAT6KX9obuXwMCX6xwfXlWexRJKTFwNKwiwaJZC4sLa4QzYiKE/oQW
         ++mzeB/uD/NnpzwCdeESkEaEG8q6wVQySdHgobpHlcnbMZweKeui2dqFNBNcVM/Glpea
         cMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762021; x=1742366821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bbOKtCBwWqQxZYFA9CfjgKY3NdaSL5avyY7w1YGOGA=;
        b=oUnd7UqxKbyHUQ1pZZjCzkBFg2cPZCcwCR1Zn9Ol1b9nAzDJFlJIG3xKOnRQha2Z8j
         0ZkcKK1UwiJPhTv+jt9aRNJBTH6QidrLkzoN0DJRrSzzQM58Szot2cvOym8466FOv6Do
         IqYa5Q5JAH1ilO6IKR1bySGFLGZC05gjI+bnhrV4v/I1AR9kpZs7QPXXRwP5Dx9KDgIx
         M/Ah3CQ4A07FJTdV62He0u6cEKf2N766pL/4lAnJIpq+ukAxWs1aN9fkXhednSZW5K9C
         QszP7rkNJX1uY/rEvpH0GcjYDmPcvXyp7163qHUtroaDvYC/6TJw8V4FUCgD1EAkuAOf
         kjIg==
X-Gm-Message-State: AOJu0YwTPBfvMJQ/ryneg++fkTOIyXjWmpAGa9CrgQATEANSi4U2IVU8
	GtsZL3zhEOkBbgKSzPgPq77Sn+QwX3awx1D1ExqeXq/15wbPsKoCsN24f8wW
X-Gm-Gg: ASbGncv8ezsPxeKfD2Et9vCCYn+wgwB/0BItMgVm1w3U+P3qtwktiUdQXctjSLiI8wD
	C8XXN9v8p/459fLcVnsjl71GZCJbRVifz4ANizqV40P1ldUr08MmB/EAXj4m4Oy/OBBxdqrWeI1
	R616kWCySjJxEa/g5Ifqxs843ZnKag/eBMFE20eslYtiViiAYADZzOilPHXdOxM3eYu+PRjyA+3
	XWIxuLHTW5x1wgEjT9r7NhEK3N1e9FgBiJui35By0Gzx03SbX54f8ugKZgGYN5sOiAxqVs7vnXF
	4zXsgHQIJyBtwG1jhGAQiVcYun0cm9juFZWVu794ypY9kg4fljPx
X-Google-Smtp-Source: AGHT+IFXC4pwMtexTeoGqY+qctzzluqdRvxdWhmBKvvtgjQM/ZVjlaP9KjPoS//LczYaH4thqFbrUw==
X-Received: by 2002:a05:6a00:190a:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-736aaaad27fmr28114151b3a.16.1741762021011;
        Tue, 11 Mar 2025 23:47:01 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736e6262982sm3889822b3a.120.2025.03.11.23.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:47:00 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v3 0/1] Refactor SMTP Auth Error Handling
Date: Wed, 12 Mar 2025 14:46:35 +0800
Message-ID: <20250312064639.668875-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch unifies error capture for both SASL and plain SMTP authentication.
It replaces regex-based error detection with SMTP status code parsing,
differentiating transient (retryable) errors from permanent failures.


Zheng Yuting (1):
  SMTP Auth: Use status codes to differentiate transient vs. permanent
    errors

 git-send-email.perl | 72 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

--
2.49.0.rc0.57.gdb91954e18
