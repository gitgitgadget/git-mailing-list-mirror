Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868D1DDC16
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123033; cv=none; b=rx1Fow1AkJJEBvX4rQQtLhkDMMVxcEpmGaC69552s+yAdrymF57m10+ZZmV7HUodvi+04MCeDR3B7CmFYIxtI7wTXwYNWJdC86pT0YVHwRg3lCsGjSlmP189M4yzBX2pAI32lIyBfCtU+vh6kmwO7krL0LyU3SU+evC2CI9BQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123033; c=relaxed/simple;
	bh=EZlqjordyJMWFCLtylSbie/qhIS+6cnV8IbAtJEdHzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkRNPU0tjFDmOohQIgw1ksLxkh7UhVXilCW4ca0yMmcjQu5/rbQURs0fS1ZEjoeMlzgGOfslbMQM7YHrFoptWP9DUVn8z1b5rmKrkbTYyewqSX3esI49DaPFRY5pb4tlC0ZXELF3DGKzGlgGSwjLb4BuVC2XUmJOMkZAUx9uyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX9MmEcm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX9MmEcm"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso5945226a12.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123029; x=1730727829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qN6oIqeWSxOSveUFJj4IblQBvBfD588QhEH9L89n+k=;
        b=lX9MmEcm0WHzyp08FXn4E/zyWfztRpINieWpoBXn7bXS4VUfcVQIgO5RgrZb6zoggz
         l9iejh6fDAcNPKNdYl9m6GbmtVLHxqEpSR0sXiGK5KSMtfE15H9e4wVf/POgjvK5zoLY
         gcsTS5q/MqsFpOdEL7H7nBL4uqZIQs6V4geP8P7L1NBymbCd/mn+Y3l23SGlRd6eiG1u
         2KpQKRDag81g5rQGrZOhrY9vc3x/6N2yMJyDPqv/Q31syf7GEndTNjtA6Xv8cUTIiPPV
         HgexZQEAfXHN8S4qoIEvw0yGTLVNJ8dBTJ2QtUGK01A4uRSuZXhKNz/30uuUxtd/mlS7
         VgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123029; x=1730727829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qN6oIqeWSxOSveUFJj4IblQBvBfD588QhEH9L89n+k=;
        b=cMdnqqP2bFLlVOJCOX82Z4ult4KdAE7JtyT2LLzqLlMYW2NfiSteXRyglmPY2lXcqy
         CBHbFFrQ33aIqeeVzkkuc1eaYYqlv/bqJPLrMUzXaFlWIjW/04TZ0raMC9fIswy8t7Jt
         LVT7jCZeu6FXLGehZkazUbP++OxbegNUWQKAwaHh7YCTkbo7FnoI0ydAPFtd+Iwvk92C
         TOG1iyIh6XfyOrLoqkhzvKfH97IoEnDdvRQ9/AFUDpuc5iMcEpmLJh6PioVNO2tnL7mh
         Sh4jU+CKksUhBQ1ol7805yviXDuC6JJ5WvK3kCFqMk70Xba+E051qzUmydbqjbN+8GAv
         gtTQ==
X-Gm-Message-State: AOJu0Yxl1+dV04cpA80oPGzxavWE7nAgufQhah8ylUtRifNVuaha42v1
	iqR8htNEJ7OrbF1TZJ55Z++Pj88jelSSPKarWWhjjpHVHrriG7lg
X-Google-Smtp-Source: AGHT+IFSFfMAi2ny1i0/ESsPNQ0KL0kDGnrteWP90+gqYjBj7S/AXHWaYgIDATO8XsFy38CItm3NXA==
X-Received: by 2002:a17:906:478c:b0:a9a:76d:e86c with SMTP id a640c23a62f3a-a9de615acf4mr832412166b.49.1730123029121;
        Mon, 28 Oct 2024 06:43:49 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 0/8] packfile: avoid using the 'the_repository' global variable
Date: Mon, 28 Oct 2024 14:43:38 +0100
Message-ID: <cover.1730122499.git.karthik.188@gmail.com>
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

This series is based off on master: 6a11438f43 (The fifth batch, 2024-10-25),
with 'jk/dumb-http-finalize' merged in. I found no issues merging this with seen,
but since these patches cover a lot of files, there might be some conflicts.

Since this tackles the topic in a new way compared to v1, I've avoided adding a
range-diff with the previous version.

Changes in v2:
- This version reduces the blast radius by not passing around the repository
struct to each function and instead pass it through the packed_git struct. Thanks
to Patrick for the tip.

Karthik Nayak (8):
  packfile: add repository to struct `packed_git`
  packfile: use `repository` from `packed_git` directly
  packfile: pass `repository` to static function in the file
  packfile: pass down repository to `odb_pack_name`
  packfile: pass down repository to `has_object[_kept]_pack`
  packfile: pass down repository to `for_each_packed_object`
  config: make `delta_base_cache_limit` a non-global variable
  config: make `packed_git_(limit|window_size)` non-global variables

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++--
 builtin/gc.c             |   5 +-
 builtin/index-pack.c     |  20 +++--
 builtin/pack-objects.c   |  11 ++-
 builtin/pack-redundant.c |   4 +-
 builtin/repack.c         |   2 +-
 builtin/rev-list.c       |   2 +-
 commit-graph.c           |   4 +-
 config.c                 |  22 -----
 connected.c              |   3 +-
 diff.c                   |   3 +-
 environment.c            |   3 -
 environment.h            |   1 -
 fsck.c                   |   2 +-
 http.c                   |   4 +-
 list-objects.c           |   7 +-
 midx-write.c             |   2 +-
 midx.c                   |   2 +-
 object-store-ll.h        |   9 +-
 pack-bitmap.c            |   2 +-
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   1 +
 packfile.c               | 185 ++++++++++++++++++++++++++-------------
 packfile.h               |  18 ++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 revision.c               |  13 +--
 tag.c                    |   2 +-
 33 files changed, 226 insertions(+), 157 deletions(-)

-- 
2.47.0

