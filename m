Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB71261B8A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269788; cv=none; b=VMK4llYCxDB6t4Aqou5HAtgSHjVukk7IT03QYxq9LP/s0xMCcsOdl9PaBtPyjypjOZGxMsSNZrZlMTRC03E/WUuzUnPMLbxoMUdu6kBNCH/zWtvBzLFCXWiSr5o7P1tm9GnVnXKp2gTqPWvdybXGWMRejgHTZtbYYys0x5uzxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269788; c=relaxed/simple;
	bh=TzDJSOoBbTOlo1us6vx+BeOSWZ6Dkl1ptAW8jhxDH8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvlYP6R9NV016oOuBZhQ4wWoUvj+Y7mICKAaiEnq0vRARi/xXYgbiwNbLgPnPO3YX0z4KJ2NBkAoV96xWZe0FF9iP21wOqQTv0lVASq3vNyQzgAnm3DTJk0sRrV8zcU/l1L9mcl/JKekyAtaUxGnjZILKDRhxDahmhgmcjgF9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXj19jMw; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXj19jMw"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-45eddb6fdccso199942fac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269785; x=1787874585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5B3pR5XC4lPZFASjWSK7jcRxtpGk1oPQJxXFM0V1l4=;
        b=iXj19jMwCeRpthMSMuxGDMdGIND8r7BnFj0fg+cgucfRgfJW8K2MlgzrN7kqshDyNy
         Z79hNTIMXKOMqlKRM0/6fmjgoEvytgpJ3nMKipZWzI292Zthh540K374WkD1SMIkakoD
         sdCMYk9rH7zYeC3chNbqTgStD3huSUKsMmimpawC1ieZRju8alFNlYkijLFjgrIkUGvF
         3woaib2TGsNDqSINSgNw1tXcyiV03DM+umThOjP1VLq+1pZzEOeYJS5KKdpZbgshwT0J
         w+uZQwdFiYya4/siYGCGnZUCsxYdBZ4EUHiGwf5GEsl6RIYdPjn1xXWEbT6V5MeLjTP8
         sDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269785; x=1787874585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5B3pR5XC4lPZFASjWSK7jcRxtpGk1oPQJxXFM0V1l4=;
        b=e3M/2W0osTYapwuily+vYN35EU74t0IS75NMYL0EKE5P1TyQQrvG8QQNzVRonHTv3B
         9y4SCXn4NWZtLU8ndEUonEizS1yqAzTwQYGLXId333Qqn/YupGLa36Y+j/pG0bK8Qs9b
         /Wz5oKi8NhWlG6HA5o92/KbPoMMqIP5l0I3kMHvOYFtAP/rzPUx9BnDbG+bAT08PNdfL
         CdDo5C9CnLoFnb0enZo0se2yoWgz1kvzCJMDmo7TaPsvpN3ukbrUT5pES6kAp9B4TUsR
         ilN06NzzXg985zTU5uqGsj1szmTxG371+pG93SUV/lGedY7Ca0FOGQX6lpgIFP56F++G
         vjNw==
X-Gm-Message-State: AOJu0YzmCywPSz6VZnjUTutcjT2BM8ZgzosffcFoRLCk5niaDGccSKQ7
	RhE2ZeyKvAWK/s0kfzBhvW4zoAWzj+Y2N9jix6ZqVx88AUpLvY7HOXhs/MZwfg==
X-Gm-Gg: AR+sD10FBhxBJ/q8yXnl0bJrYqifceMJlIYFzW/ROQrIydHdZQEm9rFJyhtFPCvu4lm
	p349NE3toTGS3mAXRh0f8W6+DSui0cGkrYVIoeTjuocn9r3z/Fm8rIp0zdPNac7bIw2y8ut6VN2
	fgkXlgOwT4Dm1DjIBgy5nZYCX/OGF5M2F+ZaBHIjfmlFRceMwdi6b09/9Q0RryGQYP8DC2IwFvf
	qm7ewWCNzpF1PFEQN9U1KkMqmVdkzob/s8yHwvpqiWAQlhrv2044Ij2uIOcwkIW6dpgWL0oK0U7
	7UtHsLwh5L/H4S1ErPLIdf+KCtPM4kvRZTCDAt3omTLKukAZ63GgU6c9o5R02hE1zbfpP1SaS/X
	4aoxX436qQsOk2FcsOiqC45sWGeqiu5CcaaIBjN+UPnlhvwUqlRgI/8aO66z+YulEl2SUfVx1lm
	B/R+VQBcDzpOc2WJ+jvyT79IMqxIWqwq+Q/uvuRL8OSruizo75hsyeftGSPzRYLg3lrS2oFgs1S
	RwwNSE=
X-Received: by 2002:a05:6870:21c8:b0:45e:23bb:7c32 with SMTP id 586e51a60fabf-4635149e7bbmr2105639fac.16.1787269785199;
        Thu, 20 Aug 2026 16:49:45 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:44 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 0/9] builtin/receive-pack: support pluggable packfile writes
Date: Thu, 20 Aug 2026 18:49:31 -0500
Message-ID: <20260820234940.894624-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces to stage incoming objects. While this brought the
command closer to being ODB backend agnostic, the underlying
git-index-pack(1) and git-unpack-objects(1) processes used to actually
write the objects to the transaction are still fundamentally tied to the
"files" backend.

This series aims to address this by introducing a generic
`odb_transaction_write_pack()` transaction interface to handle writing
the incoming packfile to the transaction. The existing logic in
git-receive-pack(1) that spawns the child processes to write the
packfile becomes the "files" backend implementation of this interface.

Changes since V4:
- Added an additional test assertion in the frist patch to ensure keep
  files are also migrated to the main ODB prior to being removed when
  the transaction is finalized.
- Updated a commit message.

Chances since V3:
- In preparation for future `odb_transaction_write_pack()` users, the
  unpack limit takes into consideration odb_transaction_flags to augment
  configutation.
- Added additional test assertion in first patch to ensure keep file is
  generated and placed in quarantine directory.
- Removed an include statement in favor of just forward declaring a
  struct.
- Updated some commit messages.

Changes since V2:
- Added a patch to address a bug causing ".keep" files from not being
  removed.
- Started handling errors at transaction commit and finalize call sites
  instead of ignoring them. We also make sure
  `odb_transaction_finalize()` runs after every successful commit
  callsite to ensure proper cleanup.
- Updated the code handling lazy loading of unpack limit configuration
  to not longer cache the value.
- Added a patch to begin explictly tracking the ODB source used by the
  "files" transaction to avoid relying on the ordering of the ODB source
  list.
- Updated some commit messages to improve clarity.

Changes since V1:
- Changed the "release" interface name to "finalize" and updated it to
  return error codes.
- Marked some function parameters as const.
- Unpack limit configuration is now resolved in the ODB transaction
  backend instead of wiring it through the interface.
- When writing a packfile to the transaction, now only the transaction
  source is prepared.
- Updated some commit messages.
- Updated some code formatting.

Thanks for the review,
-Justin

Justin Tobler (9):
  builtin/receive-pack: properly clean up keep files
  odb/transaction: add transaction finalize interface
  builtin/receive-pack: pass shallow file explicitly
  builtin/receive-pack: read unpack limit config lazily
  builtin/receive-pack: lift global state out of unpack()
  builtin/receive-pack: report unpack errors via strbuf
  builtin/receive-pack: explicitly pass packfile fd
  odb: return temporary ODB source when set
  odb/transaction: add transaction interface to write packfiles

 builtin/add.c              |   4 +-
 builtin/receive-pack.c     | 211 ++++++++-----------------------------
 builtin/unpack-objects.c   |   2 +-
 builtin/update-index.c     |   4 +-
 cache-tree.c               |   2 +-
 fetch-pack.c               |   2 +-
 object-file.c              | 183 +++++++++++++++++++++++++++++++-
 odb.c                      |   9 +-
 odb.h                      |   6 +-
 odb/transaction.c          |  21 ++++
 odb/transaction.h          |  85 +++++++++++++++
 pack-write.c               |   7 +-
 pack.h                     |   4 +-
 read-cache.c               |   2 +-
 t/t5547-push-quarantine.sh |  31 ++++++
 tmp-objdir.c               |   8 +-
 tmp-objdir.h               |   6 +-
 17 files changed, 399 insertions(+), 188 deletions(-)

Range-diff against v4:
 1:  13a57feea7 !  1:  1bae015e8c builtin/receive-pack: properly clean up keep files
    @@ t/t5547-push-quarantine.sh: test_expect_success 'updating a ref from quarantine
     +
     +	git -C keep.git config set receive.unpackLimit 0 &&
     +
    -+	# While incoming objects are still quarantined, validate that the keep
    -+	# lockfile does indeed exist.
    ++	# While incoming objects are still quarantined, validate that the
    ++	# ".keep" lockfile is present in the quarantine directory.
     +	test_hook -C keep.git pre-receive <<-\EOF &&
     +	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
     +	test -f "$keep"
     +	EOF
     +
    ++	# After quarantined objects are migrated, validate that the ".keep"
    ++	# lockfile is migrated and present in the main ODB.
    ++	test_hook -C keep.git reference-transaction <<-\EOF &&
    ++	keep="$(ls objects/pack/pack-*.keep)" &&
    ++	test -f "$keep"
    ++	EOF
    ++
     +	test_commit foo &&
     +	git push keep.git HEAD &&
    ++
    ++	# Once the operation is complete, validate that the ".keep" lockfile has
    ++	# been removed.
     +	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
     +	keep="${pack%.pack}.keep" &&
    -+
     +	test_path_is_file "$pack" &&
     +	test_path_is_missing "$keep"
     +'
 2:  49254af71c !  2:  a2a10966a8 odb/transaction: add transaction finalize interface
    @@ Commit message
         `odb_transaction_finalize()` call site in git-receive-pack(1) is made
         after the reference updates are finished.
     
    -    All other callers commit a transaction and immediately finalize it with
    -    no work in between and cannot meaningfully recover should either fail,
    -    so introduce an `odb_transaction_commit_and_finalize_or_die()` helper
    -    that performs both and dies on error. Call sites are updated
    -    accordingly.
    +    All other callers commit a transaction and immediately finalize it
    +    without any work happening in between those two operations.
    +    Consequently, they cannot meaningfully recover in case either of them
    +    would fail, and spelling out these two separate steps with proper error
    +    handling would be quite repetitive and pointless. Introduce a helper
    +    `odb_transaction_commit_and_finalize_or_die()` for those call sites and
    +    update them accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
 3:  882cf06bc3 =  3:  063b1830a1 builtin/receive-pack: pass shallow file explicitly
 4:  8deec37a09 =  4:  04c42ebefd builtin/receive-pack: read unpack limit config lazily
 5:  92d56134f0 =  5:  f4a633a212 builtin/receive-pack: lift global state out of unpack()
 6:  d614b10715 =  6:  9b89af0bd8 builtin/receive-pack: report unpack errors via strbuf
 7:  bc5839ad8e =  7:  edb54e79f6 builtin/receive-pack: explicitly pass packfile fd
 8:  13540b91b8 =  8:  452affa42f odb: return temporary ODB source when set
 9:  62d46d5c07 =  9:  dae4b96bc3 odb/transaction: add transaction interface to write packfiles

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.424.g13c7afec21

