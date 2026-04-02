Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAA303A07
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113598; cv=none; b=FTS/EryQcm677USw8plLEiFFUpijM6EzFjavhIjicRN9px9op23wW0/6DPT2pwa2/D/sNhuguUh0ecGODyY4HPVYfXurjNiLVu7RlExw9qlW5UiNl9g4WqCyDqpG479fUQ2EPVL91m7WrOrie/rY51LlvmXln/Iq8qqRkw/XEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113598; c=relaxed/simple;
	bh=HeA9evc2nhYjPuWnt9pQoUSyFH9yOZCjmFgJyHfwBPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipvjVglPzXAwaWO+pJ6P0t6T7HSuoACRO4YGtOHJioOUy2QW/eRZ/RmMvrQuAJF5r4nTRX25CD5x5G89PhIKsDvpEHyfe4JnoJESqWKX5SuXT7KUivDe8XJ3Nrjh/J20HqbDVURLlXSvKefOB2DtoGBQRh+8ESB8Sf/ENkOg3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKy8w6uc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKy8w6uc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso4106795e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113595; x=1775718395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fi6XDUeaClXH17xvL5NS8opHsN7w4yCSpN6Yhblr0Q=;
        b=cKy8w6ucLjuPOuSw/YQxj4dyPDCHVClZN4pF4jCBOjP+DBYoCPUq8lIlPeuv1S6TQR
         ecpa776qFNR9IRpfudqVT5tg9kpYNiAeFEfxmguvzcKQFKVMv6G4cKp5E1NXYoTsDd/2
         PH+5TxweL2s+d3xJFmDy84cNfg3c3iIXbHgdR38yyrvbnF7x/nzT6qnlr1zAWKoCT3kR
         /IoDx23XGGuQCUYY/g2AV1ijLlWj3yIf8dVV4Pt3Ph4OaDb13yzI2nsp3pvMOHBdxobP
         ++E8O2SCMxJ6TS7G4x5+U/XJCVlLbCTx0f8OIzymVbIkPOOc+L6rCkRoxQulawHi8mYe
         sbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113595; x=1775718395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fi6XDUeaClXH17xvL5NS8opHsN7w4yCSpN6Yhblr0Q=;
        b=ne4KuKhj7hdpKgP1aYTBjRkL23W6LCq6QkPeTZJRSm8DyHIIf63JeTu9aMY8ttcdGB
         5NzDmW5hvSB80bRQQMJpe4WDncU4vHJPu8m/sJs7McjGYlaDrfD29/k8gLhBvkKePB8d
         XKbQuowzJk0rPDhcDGQtZ/8/6bxLMbW6loICcsQtFkq3USa3HaIXWkOboEQog3bgXWVv
         mv8RmYqYs7ThJpDAiwyinPz8M5+2IN11woegmgq/+w7bMho3M3K++65cDfSrTEqmxB99
         2h+1a8FgdiTHkcgViIgaW/9mGH/Unv70iccgcJsdt3utUOZdkMnHj1BQvw7Ukk4Mbizq
         4dRQ==
X-Gm-Message-State: AOJu0YwFPdXPC98fN053CC72cLn4iTsMWo42lLaTKkQcn+4K7ZPZd6/s
	vf5U6/am7nnjfQd3Az9mXP70wO59UnJRuN3hmADZDGObQcgZ7srXA3AlzbCTCA==
X-Gm-Gg: ATEYQzzaAad3dqBxf5KkbwZisrY67JcEvivX0OokwF8iAEb2J0bcAWKtPnW7eQqnLLk
	WnUGlPSB6ff2ZWlLXi9ZR6pbIhlgYwSHydUfm08FMr4wAf45D8g6tyQYTcgeWdhXA7HLaC3s4oc
	3UUtCFFJPgMgr+UTXXuPnyBfBcGJwmddwSYbvE3RH/k9dMxsicmvm1nn4i0Ye8Z6b5vDlYNblGH
	5grUqwi70Dr+owmTdizbC6Uq8JlwAPNblYyexhXaCe5KF1aUY/GC3E9m3DVrIPs2sjDfOcwl3k2
	7JJgHz+2quQ/VnrcsLrZiVAfXR13dCjvMJ1GGfXtoVfekzxsKZ5qdqVXudkoma4X2OSq7UzQE4j
	I/u2iLNoVhrTVbiB1s+DlK1dgCrRgxkrYsB0+jltJdUf0x6ekS9h+mzmq6KrmqIC8MIJUDyFHbo
	scKXB6+Pgpp75jBdhntLHkJwSAmpigFnSGPfNhq28NEkDGe/Uh6TqZ1wnPctsw6P7CXlOvuqn/i
	pP+FYHMMv4FBisgEIOt/Z9BMeQW9+3p00mAf0s=
X-Received: by 2002:a05:600c:4451:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-48883302c73mr107629235e9.0.1775113594925;
        Thu, 02 Apr 2026 00:06:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 00/10] Prepare for advertised remotes auto-configure via URL allowlist
Date: Thu,  2 Apr 2026 09:06:03 +0200
Message-ID: <20260402070613.85934-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I sent a 16 patch long series that makes it possible for
promisor remotes advertised through the "promisor-remote" protocol
capability to be auto-configured on the client side via a URL
allowlist configured using a new `promisor.acceptFromServerUrl`
configuration variable:

https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.com/

I got the suggestion to split the 16 patches series into two smaller
series, starting with a preparatory series. So here is this
preparatory series. It's a mix of mostly small fixes, refactorings and
cleanups.

High level description of the patches
=====================================

 - Patches 1-4/10 are fixes:

   - Patch 1/10 is the most significant. The others are relatively
     small.
     
   - Patch 4/10 is the only new in this series (while all the others
     were in the previous series). It prepares for Patch 5/10.

 - Patches 5-10/10 are refactorings and cleanups:

   - Patches 5-7/10 are relatively small independents cleanups or
     refactorings.

   - Patches 8-9/10 are related refactorings simplifying the data
     structures used in filter_promisor_remote() and
     promisor_remote_reply().

   - Patch 10/10 is cleaning up the 'file://' URIs with absolute paths
     in the test script.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/23848484597

Range-diff
==========

Sorry, no range-diff as I don't think it would be quite useful because
the number and order of commits has changed a lot.

Christian Couder (10):
  promisor-remote: try accepted remotes before others in get_direct()
  promisor-remote: pass config entry to all_fields_match() directly
  promisor-remote: clarify that a remote is ignored
  promisor-remote: reject empty name or URL in advertised remote
  promisor-remote: refactor should_accept_remote() control flow
  promisor-remote: refactor has_control_char()
  promisor-remote: refactor accept_from_server()
  promisor-remote: keep accepted promisor_info structs alive
  promisor-remote: remove the 'accepted' strvec
  t5710: use proper file:// URIs for absolute paths

 Documentation/gitprotocol-v2.adoc     |   4 +
 promisor-remote.c                     | 207 +++++++++++++++-----------
 t/t5710-promisor-remote-capability.sh | 122 ++++++++++++---
 3 files changed, 223 insertions(+), 110 deletions(-)

-- 
2.53.0.765.g57b94de1f0.dirty

