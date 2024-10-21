Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D271E4123
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504690; cv=none; b=YvClTriqsxLIJzfEMHWFuvoNHoBnohyxaRKdHayzjJgp6nD+0n1SZXJsCykhWEMErnHnHOoXv74BY/siaU8Im+ju+ocTE28DUX5dV0HlJBeOI5tHg2Scy7UqDA+ZW7HuT7UzIvfpu3dTNXTWWD7hc9LF2uClcToH9SsJr605QVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504690; c=relaxed/simple;
	bh=yhmZK+WIdsG1mClQK8mXT/GmcT2Oxn1dDgMdmrktOZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8+JPdo4mpSoxW9rE2citkdk5O/sk+LOXgH9PHxNRmDdj66MlSlLg59BO2KKplKl7akM3us42kWK1slAsJGabMyWuuRLYH3lfgvdDGgCOu7t6sXJ1T4x1iD0wcIrtKtVWE1/edx/h/dLxnwwfZZyug0KpZyLrviavGMmzP1Oxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3+nGf5K; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3+nGf5K"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4478543e87.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504686; x=1730109486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzXzwpJBk19jDqAifCLBmi9wvC+tqD9tV5AWQwaxdcU=;
        b=A3+nGf5KAp3EEAWiip/HEqrTmR9YTlkipdWyFYmGFed99pL84TkOesS0VeQ4sc7OG8
         7njVBzIbZDY1E5a3+bpU+EE+FoSscBL7C9SWp1fTBzMBfMg3ZHQshfvdcpt4kKU6TLY0
         p5PkfetBaiutwO2CQhUJrHolfxFC+DpgyRNZadLHnLA4RbedX55cDrIIoJLkGMQhCjf0
         ePOmlrBDys7hKEeadJEB4AkKXTVBy/pghjZ8M4r/UIqvxhmQQ0J6NPLLZf7tijIKmmvA
         rPx2gSOlUb/DV/3GP7gKyNT35X4cQqkRPolXg6ZoqIy/MlFnG9B4q3DYYgYqF4rZwrJ+
         cMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504686; x=1730109486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzXzwpJBk19jDqAifCLBmi9wvC+tqD9tV5AWQwaxdcU=;
        b=w98lAIXoCV9Z2aFEgn3u+DfrPK6efuTTLUMNZBI3FPAmvZhIlA3xJcZssV7xk/hSul
         p+pbZbuymnOuCJzxw8MC9sQJt6wpjZFlnjnLjSMdcnSnjsqlEuzRuz2i+C0ViWaFjxur
         2wEAVMCb8bp6iOy13Jf2YHKahXGI7wTteo5OH8NOsJlwNMUO8r7M+7KZJS1k49VhcZJW
         lliXILjQZeE0MCr09xYdMYrKWlu9umcNyGhh+UpF7qAz3Q5wgiNSHHVKiMjyE09GE8uH
         dedpaZsB+kumK7Bo6Bj6a0sgJgI3M1VAaM7SEdOR1Q+yT3wNyfdmfBQQ04grXRJpA5h/
         cfvQ==
X-Gm-Message-State: AOJu0Yzggy9sxpz4mCPySYD+nk7dkx8GC5Stgo8VoZqFQLQYtMkZcApd
	eeJIvHb7rC1LnHGzTd4a5WnV4FLLVBMH3IgQ7Z7uqomS5PBZaDR6oW+Eukp3
X-Google-Smtp-Source: AGHT+IEVSHqth/tdounuMPWkD+XB0CjRfayZwbFHCrZH9LLQYc7KaD/8k/+5Q8mXuWa+/DIMvuJrFA==
X-Received: by 2002:a05:6512:10c9:b0:539:fc86:ce21 with SMTP id 2adb3069b0e04-53a154d8042mr4717385e87.56.1729504686042;
        Mon, 21 Oct 2024 02:58:06 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 00/20] packfile: avoid using the 'the_repository' global variable 
Date: Mon, 21 Oct 2024 11:57:43 +0200
Message-ID: <cover.1729504640.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `packfile.c` file uses the global variable 'the_repository' extensively
throughout the code. Let's remove all usecases of this, by modifying the
required functions to accept a 'struct repository' instead. This is to clean up
usage of global state.

The first 18 patches are mostly passing a `struct repository` to each of the
functions within `packfile.c` from other files. The last two patches move some
global config variables and make them local. I'm not too well versed with this
section of the code, so would be nice to get some eyes here.

Karthik Nayak (20):
  packfile: pass down repository to `odb_pack_name`
  packfile: pass down repository to `unuse_one_window`
  packfile: pass down repository to `close_one_pack`
  packfile: pass down repository to `add_packed_git`
  packfile: pass down repository to `unpack_object_header`
  packfile: pass down repository to `get_delta_base`
  packfile: use provided repository in `packed_object_info`
  packfile: pass down repository to `unpack_compressed_entry`
  packfile: pass down repository to `nth_packed_object_id`
  packfile: pass down repository to `find_pack_entry_one`
  packfile: pass down repository to `fill_pack_entry`
  packfile: pass down repository to `has_object[_kept]_pack`
  packfile: pass down repository to `for_each_packed_object`
  packfile: pass down repository to `is_promisor_object`
  object-store: pass down repository to `each_packed_object_fn`
  packfile: pass down repository to `open_pack_index`
  packfile: stop using 'the_hash_algo'
  packfile: pass down repository to `nth_packed_object_offset`
  config: make `delta_base_cache_limit` a non-global variable
  config: make `packed_git_(limit|window_size)` non-global variables

 builtin/cat-file.c          |  17 +-
 builtin/count-objects.c     |   4 +-
 builtin/fast-import.c       |  18 +-
 builtin/fsck.c              |  30 +--
 builtin/gc.c                |   5 +-
 builtin/index-pack.c        |  22 ++-
 builtin/pack-objects.c      |  67 ++++---
 builtin/pack-redundant.c    |   4 +-
 builtin/repack.c            |   9 +-
 builtin/rev-list.c          |   2 +-
 commit-graph.c              |  15 +-
 config.c                    |  22 ---
 connected.c                 |   7 +-
 diff.c                      |   3 +-
 environment.c               |   3 -
 environment.h               |   1 -
 fsck.c                      |   2 +-
 http-push.c                 |   5 +-
 http-walker.c               |   2 +-
 http.c                      |  15 +-
 list-objects.c              |   7 +-
 midx-write.c                |  16 +-
 midx.c                      |   8 +-
 object-name.c               |  16 +-
 object-store-ll.h           |  10 +-
 pack-bitmap.c               |  23 ++-
 pack-check.c                |  17 +-
 pack-mtimes.c               |   4 +-
 pack-mtimes.h               |   3 +-
 pack-objects.h              |   3 +-
 pack-revindex.c             |   7 +-
 pack-write.c                |   1 +
 pack.h                      |   1 +
 packfile.c                  | 376 +++++++++++++++++++++---------------
 packfile.h                  |  63 +++---
 promisor-remote.c           |   2 +-
 prune-packed.c              |   2 +-
 reachable.c                 |  14 +-
 revision.c                  |  15 +-
 streaming.c                 |   6 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   4 +-
 tag.c                       |   2 +-
 43 files changed, 482 insertions(+), 373 deletions(-)

-- 
2.47.0

