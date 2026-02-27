Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8835A39B
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235765; cv=none; b=cP9lW3gr+tUB/DKzR4eS9i+VnzQ+RK6S0XMXpWnxW+tCuFJ9RjqSMhtzcWyX5bH6khbApkMLIjdw+qyv8DfJ8L52G5cR1hSrM2kzV5UyOchi5FWi5GQCmcXTTWwl6x6wSmsO21CrpXyqDnoDOVE5IgvA1k9+Otg7Kmh5aqG2q7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235765; c=relaxed/simple;
	bh=8QWPAgAytyigcBgC2XBNk0rJTRA5AeKAiGMQyWqnU7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAxfluTjnowCZD1Ej4OBYHswlw9F3U8nm5w/KvLGlduygJfR8Szda2MPl2S5c1PzOpqG1Obu1+4INVLMD48CyVVpcwI+92rAi9qr9uWINQSQeQxl/pSib3Ar1G7noD6eTVpeT30d6WSYC6sloTT12Z3qvdhHmDsiqhrSUZ3qawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m92lbctP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m92lbctP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483770e0b25so22711935e9.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235763; x=1772840563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wed2bIA+iZZ1dvNOWPCZolXkNNt7ZHFMEcQDjuc/Mck=;
        b=m92lbctPIOlIdUgkILjzm/0jhBubtitaJBQs37V1drEK4vjBk+CgZGnmcOfnWzY7pi
         lEFUa1TjHwvr/cs5M/zDYmZbcPBzprT5eSX9acX0rHKazdrIlP/Qa0VfjCvvLlfPSlzK
         w6ZBuoEM9fC+rlET62P9ZCtBrSGTpGEruJFFoE+dHmNYxAxcyEUczoD/PxTUpF3atQeZ
         O7mXbwkVIMZrcbpOhasfSwS7foS1ka8RVFXjtwBge6yuL8shkBpJ4okF4uq8SITeSxk6
         WkxQZuKvx6gAd+U/U9CFmviZEiOoVYIkLivOUji2D00xym0gRUG1zS2V0oVWhUDw11x3
         AV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235763; x=1772840563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wed2bIA+iZZ1dvNOWPCZolXkNNt7ZHFMEcQDjuc/Mck=;
        b=BSfJd/EkwtaDkTAlZI0gBzY1UlU0Q2IP/rCepDbgdtBujQpMVMwc/wUVsLQUbUv7nV
         BR0phoyhv+Skn6cxXa/sblI7QchUl3eZuxamR92ihJyVZo6qTXcn272FKduuxsfVfpJY
         p/5crECcfwT4ypqgqJy9Be/WMnfsRbkb4oRjuDnkehhoD+vnD3muNdCVJyiirqIDbE26
         WA/pBueVuQ9469F+q3Q1wsyVrVOXhZGF8/EQftRxxN0Mw1Xodl4BDOu0FMJHDhbMskHZ
         urjGBvsrv2fiHvHElxOW0VcsJztRSQ3p7LKPToyxiyUbr2fBJ5dik69BxrR1LaAJKx18
         nAnA==
X-Gm-Message-State: AOJu0YzIH3Ptv/Gd9SVaQtuiMirOEpN3wiR9kZ+i25gX/579xBWy15Fo
	DvvdF2QiSCJxQZw1/lY3SXbqQhr4vcNolhdskHqdOUm/R52cPxeLgs93Zi7GMKEA
X-Gm-Gg: ATEYQzyzYgPC3eX6NXCwL7EsJDbmVCV1gp5nfv2QJnhRvCwFEqID3wwp5O4+68k4zPc
	Gg4ZQKFRV1RO+QCaoX00INyykROTHx8bmgWlnyuQjSe2msyMhh4iRRZ6etOEJugomVcuU5GEN5N
	jDytxYEQegL8ZqImEm5VVkDI2E5h8cdhADelZ3vO5L1qgdgb0P8WFrvWFeLDsCu3UbNeTfdj5dy
	oX1OS/X8LOuhNKbfvVhhpFHPZhOLu47L5tQ/gWh2gNAM8CAKmzpNsyrFHW8MelLfLd0S1Noewjo
	EhGgM0mpGmfFbTgicWsErrDmnoc/qdduBcfL06a0xUsTwWbJttgJU6wxsRzl3H3x9Yl5gadS0os
	Rwz/vSpM1FGCbUrzr7h0NCQvkX0hN1KjiMg53djsmnQOTZrx8TPF3gpme3GftqOBgPR0ET9xceu
	RfTQ2hcFi9QEoWKoydPOPqt9sQwlV3Fl6YXnMlchdIjwbYE+rkThks
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr73816985e9.2.1772235762539;
        Fri, 27 Feb 2026 15:42:42 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:42:42 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/5] oidmap: migrate cleanup to oidmap_clear_with_free()
Date: Sat, 28 Feb 2026 00:42:08 +0100
Message-ID: <20260227234213.17633-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series replaces oidmap_clear(map, 1) with
oidmap_clear_with_free() and introduces explicit free callbacks
at the remaining call sites.

The old boolean-based API implicitly assumed plain free(),
which obscures ownership semantics and does not work well
when oidmap_entry is embedded inside larger structures.
The callback-based API makes cleanup explicit and type-safe,
and avoids relying on hidden assumptions about allocation.

This improves readability, maintainability, and correctness,
and makes future refactoring of oidmap users more robust.

This is used in subsequent commits to adequately cleanup all
usage site.

Thanks,
Seyi Kuforiji

Seyi Kufoiji (5):
  oidmap: make entry cleanup explicit in oidmap_clear
  builtin/rev-list: migrate missing_objects cleanup to
    oidmap_clear_with_free()
  list-objects-filter: use oidmap_clear_with_free() for cleanup
  odb: use oidmap_clear_with_free() to release replace_map entries
  sequencer: use oidmap_clear_with_free() for string_entry cleanup

 builtin/rev-list.c      | 13 ++++++++++---
 list-objects-filter.c   |  9 ++++++++-
 odb.c                   | 11 ++++++++++-
 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 sequencer.c             | 10 ++++++++--
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 10 deletions(-)

-- 
2.43.0

