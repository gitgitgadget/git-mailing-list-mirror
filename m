Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FC153BF6
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323656; cv=none; b=t61r7RTEP75nXBigbWkps+1o9vo3w5CCzDiK6Rf8WGROWs/VuE93GdfXnXWM5Pw3fYsLZImfKXSNrSeX99yPhMfAHKZBlTWUw5WGpU/6ucw3MO6/xYzn2tx/taKY7vm+ADQ4fKXBLYSwBUnx7a2cDFl2ps2QMdkq5p2U4OZ7GGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323656; c=relaxed/simple;
	bh=ZFSFPXHRsBB98REHPu8L2HiKggzL8QXMfJAJCmcj4UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsBlvEWKlxcg42eA2YlGOE5exlm2MRqkO9lWdGr7D4hlYhO/lFGgkw+9rCZSEOrEhdniT+DvLe/c/EN6wwLHW/tc8le8I1Tnsi5FRrN3AlWfBsiGTT3QTXJH2t7SoItdxo5V5AlWsQUSuTh1y1M/5G0DGLPwaTCshTp5u3+TSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9AS9I2c; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9AS9I2c"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso4827224e87.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731323653; x=1731928453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlB3PXaYLUgA6wLFvML1PLWQNYsIqoS6Rn5Fz7ILOG0=;
        b=D9AS9I2cX4b12TmZ8GDq9Tf+t+OQbZj8z/SKQlMzyTV0T4eIMF0iTNtDVEgVb+0ye6
         GlsQYfwGxkvJ1XWBVQpGAlqkr5oPJz7l/WGf2l2j+XemI0xRN3Si7sZE7+so1zcj20m5
         i9laBhSOdebKuAuLzvNbqh6VNpK8dc+WiUzKIBN3UqoMLGO914/253GVc2TzubMAtLwA
         bnr/xzdF/xinsQNv+VCls21DcdZElyAYU14kayMKFiSYsAzbPMjDRMcL6IhPyXFqRssM
         IkP8RHoqpKQq0LSOKxgI2NFHPOO6N/sebnERB19IXuj2EKKVXDTwlYXdlkg9D+KDV9eD
         C6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323653; x=1731928453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlB3PXaYLUgA6wLFvML1PLWQNYsIqoS6Rn5Fz7ILOG0=;
        b=u4oYYKOj+p9DMpVCtkHclWKJND9V+of7KAQcenBt1HjnUtpFvOqyCLDKCGEYvHnGcE
         CSxOg3kUiOyZGcx24uG5nVvFXDfUkblddI5PfCEVn+/Hyitx8lJhJTFuKJes5SmNHbzp
         F9iCmTxV2Xoc7Krk7JCffvmJOIb9MyByjMGo7bCYqAZzkcmy+HQzFzns1oCOhL/djxcC
         vKXECWXhe8GY1bHazULE5nI1zGm97fAjgK0J57uIS9IOP2J5KQiuoOGQDbh1cHC/lu7Z
         U3v0Jh8I6qSPtANC5jWkv4TK9EpoaWJEyidBzRwszjp7jEyLumbEqdyT8VhxtUt8OwM5
         mo0Q==
X-Gm-Message-State: AOJu0YyX9fUnxvYnJANnFpACef1GBTaEqsQpCDFsG25b7uvRxDBz4sq4
	DlNBUY3ay5cG5Fg/Bbth+cuEPdOJDkE8GthiHLd70oVrtp2gVHM0
X-Google-Smtp-Source: AGHT+IHM/2Fzb5ku1ly+s0JyCl8q9oq0nVGIvEm0Gw5Y54F9wqZhX5x5tVtA6dnLNAe0SmFoK14BIg==
X-Received: by 2002:a05:6512:32c8:b0:539:f763:789d with SMTP id 2adb3069b0e04-53d862be333mr5205507e87.43.1731323652251;
        Mon, 11 Nov 2024 03:14:12 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c625sm5012959a12.82.2024.11.11.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:14:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v7 0/9] packfile: avoid using the 'the_repository' global variable
Date: Mon, 11 Nov 2024 12:14:00 +0100
Message-ID: <cover.1731323350.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
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

The first 3 patches are mostly internal to `packfile.c`, we add the repository
field to the `packed_git` struct and this is used to clear up some useages of
the global variables.

The next 3 patches are more disruptive, they modify the function definition of
`odb_pack_name`, `has_object[_kept]_pack` and `for_each_packed_object` to receive
a repository, helping remove other usages of 'the_repository' variable.

Finally, the last two patches deal with global config values. These values are
localized.

For v5 onwards, I've rebased the series off the new master: 8f8d6eee53 (The
seventh batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize'
was merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

Changes in v7:
- Cleanup stale commit message.
- Add missing space in `if` statement.
- Fix typo s/incase/in case/. 

Changes in v6:
- Lazy load repository settings in packfile.c. This ensures that the settings are
available for sure and we do not rely on callees setting it.
- Use `size_t` for `delta_base_cache_limit`.

Changes in v5:
- Move packed_git* settings to repo_settings to ensure we don't keep reparsing the
settings in `use_pack`.

Changes in v4:
- Renamed the repository field within `packed_git` and `multi_pack_index` from
`r` to `repo`, while keeping function parameters to be `r`.
- Fixed bad braces. 

Changes in v3:
- Improved commit messages. In the first commit to talk about how packed_git
struct could also be part of the alternates of a repository. In the 7th commit
to talk about the motive behind removing the global variable.
- Changed 'packed_git->repo' to 'packed_git->r' to keep it consistent with the
rest of the code base.
- Replaced 'the_repository' with locally available access to the repository
struct in multiple regions.
- Removed unecessary inclusion of the 'repository.h' header file by forward
declaring the 'repository' struct.
- Replace memcpy with hashcpy.
- Change the logic in the 7th patch to use if else statements.
- Added an extra commit to cleanup `pack-bitmap.c`. 

Karthik Nayak (9):
  packfile: add repository to struct `packed_git`
  packfile: use `repository` from `packed_git` directly
  packfile: pass `repository` to static function in the file
  packfile: pass down repository to `odb_pack_name`
  packfile: pass down repository to `has_object[_kept]_pack`
  packfile: pass down repository to `for_each_packed_object`
  config: make `delta_base_cache_limit` a non-global variable
  config: make `packed_git_(limit|window_size)` non-global variables
  midx: add repository to `multi_pack_index` struct

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++---
 builtin/gc.c             |   8 ++-
 builtin/index-pack.c     |  20 ++++--
 builtin/pack-objects.c   |  11 +--
 builtin/pack-redundant.c |   2 +-
 builtin/repack.c         |   2 +-
 builtin/rev-list.c       |   2 +-
 commit-graph.c           |   4 +-
 config.c                 |  22 ------
 connected.c              |   3 +-
 diff.c                   |   3 +-
 environment.c            |   3 -
 environment.h            |   1 -
 fsck.c                   |   2 +-
 http.c                   |   4 +-
 list-objects.c           |   7 +-
 midx-write.c             |   2 +-
 midx.c                   |   3 +-
 midx.h                   |   3 +
 object-store-ll.h        |   9 ++-
 pack-bitmap.c            |  90 +++++++++++++++---------
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   1 +
 packfile.c               | 148 +++++++++++++++++++++++----------------
 packfile.h               |  18 +++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 repo-settings.c          |  14 ++++
 repo-settings.h          |   5 ++
 revision.c               |  13 ++--
 tag.c                    |   2 +-
 36 files changed, 268 insertions(+), 190 deletions(-)

Range-diff against v6:
 -:  ---------- >  1:  6c00e25c86 packfile: add repository to struct `packed_git`
 -:  ---------- >  2:  70fc8a79af packfile: use `repository` from `packed_git` directly
 -:  ---------- >  3:  167a1f3a11 packfile: pass `repository` to static function in the file
 -:  ---------- >  4:  b7cfe78217 packfile: pass down repository to `odb_pack_name`
 -:  ---------- >  5:  5566f5554c packfile: pass down repository to `has_object[_kept]_pack`
 -:  ---------- >  6:  1b26e45a9b packfile: pass down repository to `for_each_packed_object`
 1:  89313cfed4 !  7:  1bdc34f4d8 config: make `delta_base_cache_limit` a non-global variable
    @@ builtin/gc.c: static void gc_config(struct gc_config *cfg)
      {
      	const char *value;
      	char *owned = NULL;
    -+	unsigned long longval;
    ++	unsigned long ulongval;
      
      	if (!git_config_get_value("gc.packrefs", &value)) {
      		if (value && !strcmp(value, "notbare"))
    @@ builtin/gc.c: static void gc_config(struct gc_config *cfg)
      	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
      	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
      
    -+	if(!git_config_get_ulong("core.deltabasecachelimit", &longval))
    -+		cfg->delta_base_cache_limit = longval;
    ++	if (!git_config_get_ulong("core.deltabasecachelimit", &ulongval))
    ++		cfg->delta_base_cache_limit = ulongval;
     +
      	if (!git_config_get_string("gc.repackfilter", &owned)) {
      		free(cfg->repack_filter);
 2:  3a8e3b88df !  8:  7b6baa89ac config: make `packed_git_(limit|window_size)` non-global variables
    @@ Commit message
         this file, let's change it from being a global config variable to a
         local variable for the subsystem.
     
    -    We do this by introducing a new local `packfile_config` struct in
    -    `packfile.c` and also adding the required function to parse the said
    -    config. We then use this within `packfile.c` to obtain the variables.
    -
         With this, we rid `packfile.c` from all global variable usage and this
         means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
         the file.
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      			off_t len;
     +			struct repo_settings *settings;
     +
    -+			/* lazy load the settings incase it hasn't been setup */
    ++			/* lazy load the settings in case it hasn't been setup */
     +			prepare_repo_settings(p->repo);
     +			settings = &p->repo->settings;
     +
 3:  2f9a146978 =  9:  a3667d87ec midx: add repository to `multi_pack_index` struct
-- 
2.47.0

