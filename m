Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DC314B9A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355948; cv=none; b=oOLz2UMcP579dT+ZXlXM5IucddKvjDR1jB8qsGuZk4vv0GgmqG/xYDBGKu0N+NwpUBqOAifZJ2BzZxJDP6SYbnxqrTLCKZj6pwjGUnY3MNTiiygfoEPFgF0pjM4D0tzxWH+o62TXrzaTfoJ8gq9Qq+BXCipdES8iqIIwHyCK/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355948; c=relaxed/simple;
	bh=UrKn18/1uK/qZEBNmZEGhkTgw0269h8PIhTuxllmQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeuvB/J9ay8JeacuN2JRSKkBYB5K/AGLOUF9fAts1RsF0CRaXeNxIi3QivY/NTGIWZc/I38VSG9/uwwCpIfkRnWfkHxNiEqxWG0/Uc+10KPjkcS5OMcwgR6QeACMK2tg4RG/ddO1C0dtDwrAZC6Ek3EDUlwfGPfAPpMUlfK6pqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXfoijBD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXfoijBD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so36634295e9.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355945; x=1774960745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czhRBD2O0Qxwwgd2la6E8umy5gHjNa2btOt6A7Uy5q4=;
        b=lXfoijBDopYKOJPYVXaQ1BPuHFkde2Ds23z5NU94C6f7gkmbPq+rQP6PsebWFMygOX
         EZ0gkgCukXPaPhrYRgZZug4Ut2GfRXXgaGmZm2GzxMKJj6gaFaH5356vl8a8y+KXh0X8
         EPWM0WZAT0Mxmo3dnm0NDwiIJCkMvFPhjN9KOczC95qjdLYYo9u6hsyEOWDBUAwmXzz6
         NL7IsdBLPWFykQHiDag+wUiD6eHa1COyh8lNzICwyotqjStzXq5X5MsjLFSd/6XCYiLy
         LWUDNv4L0fkE0OmjXtHWVpScVD64c0aNzOsaB7xWgeZREqlS3FiZi7XHXhLjvynPVvX0
         VWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355945; x=1774960745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czhRBD2O0Qxwwgd2la6E8umy5gHjNa2btOt6A7Uy5q4=;
        b=StHCGT/jq8lCsqMGFrnhuTvk7RRYH1ZMYRrRRTBaVBeexkx+H3P3ZeE2Cb7DrrnsFC
         bxGf48iLfbLDNtjHmcZD9EcHdSRUs311IygyduIAuK5pbfDVr+bemyCRDjoQFrN//vyM
         2KUePmyV2NmWGKy95sBBvMsLDOuffdd5T7XNbuJu6hbN0+FQqs+bSa2NDHYvZm+n/Zrg
         ZFUJu1IIT0oI5sl88P1U+6odGF9cOnBLpGbd1Zbq8xhtZUJoDFJL/v7LmN/dcJ6LUIEV
         ADWkn7iZVMfeI0CUPPZGfXdxdqCEdUqX+tVHmpZxurxghnVoRiUGTdQfJLjdTSE5zXU3
         VoBw==
X-Gm-Message-State: AOJu0YyK3l+ld3cWwJUTcIkKwtDyR8uN5LjOrAH3rScL8HaW24a1rPqg
	g/GPKewJV3lFut7z/vp/9jJO20HJG7iduPFF1+7LoozMxPCwxPwApRikrongKR20qUQ=
X-Gm-Gg: ATEYQzxGiOGd4kIYuRmBr3KonVgn3+SIjW80DnWDzmHn+troJaf4gUDnHDMNDgslwBL
	x4NA8o6BFq+mRiOoiwEwM/+J3PPU4j2vJUl9AX8t3WhQTz21G/Dn6i3MLIJs+v3aH8fXOBLqG16
	IR2JGlxZk/hUmBYYSsRTmjLlAiaLnHF5SJ6/7X3h4F0qPOZi/iEBT0CxtqpO3WqySqeg/kbYSE3
	tYK0CXWzY+/yxclx2M/8521MpzBulohp5tR+ay3+UjSKNN155/OhjSsiAcykEfGgrg7ydERk4ls
	GAecxIK0zsomW99Pp3K3+Ns1wgxAEEG1RD30rXCUMc+811alBKCpM+Pm3ajPcFkzyjUnDt2TbGk
	7E9E3SL7emGBESgBJgf3TPbaLntkZk0oODcuTSZ6+xhLG0I/fojMcC8rSSxcRuoyWJCGI1iCNKX
	7gkWMra01FbkhvYqgMmTbsgZ7PlwrMSUXqZs0/uwJz1fzxmI/imCDeayE+eLFKUUgq
X-Received: by 2002:a05:600c:a4a:b0:485:5c6e:8a38 with SMTP id 5b1f17b1804b1-486fee0fbabmr212211895e9.17.1774355945107;
        Tue, 24 Mar 2026 05:39:05 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:04 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 0/8] repo_config_values: migrate more globals
Date: Tue, 24 Mar 2026 13:37:42 +0100
Message-ID: <20260324123750.157143-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========
This series continues the effort to migrate repository-specific global
variables into struct repo_config_values, further reducing global
state and improving repository isolation.

The previous series introduced the infrastructure for storing
repository-dependent configuration in repo_config_values. This series
extends that work by moving additional environment-related globals into
that struct and updating their call sites accordingly.

This helps avoid cross-repository interference when multiple
repositories are used within the same process, and continues preparing
Git for improved library usage and better encapsulation of repository
state.

Changes since v1:
- Dropped "Base series" section as the dependency has been merged.
- Fixed handling of pack_compression_level: removed use of a local copy and
  updated code to operate directly on cfg->pack_compression_level to avoid
  inconsistencies with option parsing.

Olamide Caleb Bello (8):
  environment: move "trust_ctime" into `struct repo_config_values`
  environment: move "check_stat" into `struct repo_config_values`
  environment: move `zlib_compression_level` into repo_config_values
  environment: move "pack_compression_level" into `struct
    repo_config_values`
  environment: move "precomposed_unicode" into `struct
    repo_config_values`
  env: move "core_sparse_checkout_cone" into `struct repo_config_values`
  env: put "sparse_expect_files_outside_of_patterns" in
    `repo_config_values`
  env: move "warn_on_object_refname_ambiguity" into `repo_config_values`

 builtin/cat-file.c        |  7 ++++---
 builtin/fast-import.c     |  8 +++++---
 builtin/index-pack.c      |  3 ++-
 builtin/mv.c              |  2 +-
 builtin/pack-objects.c    | 24 +++++++++++++----------
 builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
 compat/precompose_utf8.c  | 20 +++++++++++++-------
 diff.c                    |  3 ++-
 dir.c                     |  3 ++-
 entry.c                   |  3 ++-
 environment.c             | 40 +++++++++++++++++++++------------------
 environment.h             | 19 ++++++++++---------
 http-push.c               |  3 ++-
 object-file.c             |  6 ++++--
 object-name.c             |  3 ++-
 revision.c                |  7 ++++---
 sparse-index.c            |  4 ++--
 statinfo.c                | 12 +++++++-----
 submodule.c               |  7 ++++---
 upload-pack.c             |  3 ++-
 20 files changed, 126 insertions(+), 88 deletions(-)

-- 
2.53.0.155.g9f36b15afa

