Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CF38B13C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144453; cv=none; b=pypUvoz6jvSU0SL2zFiIBVyx/SXab9pBSj0dyRriDbn38kvsJZqhjstq2aFc3GFDoGCqVNdV40z20vtre7voLY+Xa8dpgOJquCJ5ln0LZAAW2nC1xHcO3zWI/ERK+/I4LqzXUhK/Q4fDE0mOXbXNchU5RFIr5d8Uy5NKdzQBAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144453; c=relaxed/simple;
	bh=Zx3br35JDlG1qSs36gWyvnEFjAipKW1J2VuzSz8iPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duWzTabQWif/sijttR06QmiEee5/Hc/nt60gEWNyTTmA5hSMWONWeFe9Kj4gGVs6RYpX43PRtJEx+wMFEYyCIOa2K4VOs9rXeouEmm/tzhZqzovfbh7f1cW1SV4/jpp/Om24z9tds9aKCYoT4CETP75P1SSCW0T2W2pQ8rCAxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUwTpXAP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUwTpXAP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79902e1fb71so20499697b3.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144451; x=1773749251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK7JIPAPQqMg/TyRZAz2BdbcjM1N9OFUJ+NVmQ5f75M=;
        b=kUwTpXAPWSopt+lUtWDZ0k9vJsVcD2TdhM0tEaExX71qLg64u5iNk4pvCnu2800yuj
         FLQb3WQutdEh4VhdZIAGpzS7yfQ1MNnx3FAbqwqbrKb2oV2CTDl6ir6BBALVHXWflbUo
         79UXN6M/Bv1EK23GeQjAyZ/yLaogBhEblaNGS3Z26XeLwz41YV3ZOIKp4L9Vr/8tb4zH
         97PnPf8WUF798Kwkbbb/ST3KK7qpce60yDalBUZy3Ahvs0MQFJIiWrTE1BmJn2AdNUgx
         zYbxTunklDZ9o34vyprqz6MObvstCLe9zkNXShr46ohqffGRutYafAbOcq/CNDlit8Pq
         Lw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144451; x=1773749251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK7JIPAPQqMg/TyRZAz2BdbcjM1N9OFUJ+NVmQ5f75M=;
        b=TERLS6cThHFUwXdfP7Hki39+bnG1MkFWuqmEBZ5AKWy/aNm1qbJsPFcGRtIFPxZ393
         fKN6oKBx0FBxTevmiq59rcusY0LGuNz+wCmhxuOfHnHCdclRFIoAm4kcIIb9vwPx28gL
         eH3CXHieu2SqACqo3G1W/JwmFYJCoTFHu0vz/U6G+xbKI5SeKGi6Ow/lyk2fB0TPlLo/
         BiFHyLcuQd0zIkcPZJK7i0vgjxZg1+XGP6yrlLb3xKYj+F5Smx+JAing/xfwPoRSOj/o
         HP3go9Ml3UoOQ1EUWa5BtbukSsCAT4ZcRYOs+oRA+j1vVbcdH+bg74ZQWcxhVo0CIPQS
         ow8g==
X-Gm-Message-State: AOJu0Yw6d0WbOjgN8fZZnn/e5EOCQwy0G+s1g58aVDh9Xr2vucMFSUHT
	gwNFsmHCYqxe/w7XNrXSy23wyc0brAM/I6Rq3eBPvTlt6L/bZYdawbJJreluvu+kPxY=
X-Gm-Gg: ATEYQzzZGAKfOq5MViW/7lsrr4AVwCiqjeDXnxXmXRkbA8tvhM/l0Bg1IL98mcYnhWd
	1W+JFdfARP9VXK4wUkl7exNeXSEj1xPgP8cAdeo4jbfA/QIazNIOuMm39FVueyge6j/pzvJq26R
	SNV9vmNix+w0e+m/HgJoKF7gRGKoncdYq9mn+SAfboAokP1WK0dyoosRl25dEUl70BMHi8wIpM/
	wmrbhSE5LZENYlt99jIb/OaqugMlXvZ7BIU88fEJXxQAegU9MumO9SD++Tziez/sbqgUKmESCzD
	99mVlWUJF+ZrZr6YzgCVgfK/U/oY4ZHFS5ePrfqu+T8d9M7DPOuJ38Av+Dre5/J/XAnsI8EOp5n
	pl08PtrBAqPRWGpny63JIj3YaimWTd5cY6VVj/SM5zkXZWv/bDrNFg84ifmOhpOLHzzPSQ/n/KT
	+tvBoW+H2CuP/CNFW4RIcJTbV6Js0=
X-Received: by 2002:a05:690c:6c0f:b0:796:360f:e1a9 with SMTP id 00721157ae682-798dd691e5fmr125880437b3.29.1773144451230;
        Tue, 10 Mar 2026 05:07:31 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:30 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 0/8] repo_config_values: migrate more globals
Date: Tue, 10 Mar 2026 13:06:21 +0100
Message-ID: <cover.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base series
===========
This series builds on top of the merged series:
  [PATCH v7 0/3] Move repo-specific globals into repo_config_values

available at:
  https://lore.kernel.org/git/<cover.1771258573.git.belkid98@gmail.com>

It should be applied on top of that series.

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
 builtin/pack-objects.c    | 15 ++++++++++-----
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
 20 files changed, 122 insertions(+), 83 deletions(-)

-- 
2.53.0.155.g9f36b15afa

