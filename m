Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A85263F44
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553945; cv=none; b=dekNkeBrkQJOc1A9PWcesOr6hC3iPNWXF7FHCWnm7YgAa5OL1DM4r45ePBl3YHBiV0IeciEIoneWQE6lZ7440Xhya/wuUKyQ8aSYYO0G209QR54SD16Q5bkwbyo68ZY0nH0PE6onEW+zlTNFtLQvDc1ml7pg8k61EOR8HwpZoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553945; c=relaxed/simple;
	bh=dTUalgapA/S1VFijCI4WDawDydfEzIQxr/Ww5A73fLY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SwQFR66df30VUiyxjt+LI36QPQqRspRW8/FZZc+Pg2Xz7lKfrV/iDBgQxPfiujfaftlilZFBu1cugcSXNGzO1kRxFTzC3ICVE6ZUkhnz/dyaW9A0cI4GgiPXDkpZEPFXy0xmah7EIM1Zqi8c059XU72H8Pw2kNT+x7tZbzigICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=T52dWrYK; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="T52dWrYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770553942; x=1771158742; i=l.s.r@web.de;
	bh=euYLluUxaZo8Lo0bMnylWSx5jwKGwTG+G0uTm4iFWKM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T52dWrYKk1rY99uasH7AdPKh+IpC4BoXGARzS8ewNI3VG9ZFrp3SkK+TTNH9YpB8
	 8jDPLETRhW9fGGqxdqTOPtRD921jS0igdH8b+RdbuVjBj6A2Mog/BBlQiWLUxTjhK
	 zRIPqpblyTfBAXrOeb6oLh0fP0E9VD8/tuL3sd0Ay99PuF7qzPFrE0rYdobv0a/+y
	 hUNxpLC8oE61GMFWZV4JaIVfwkI4t/rGahoA7W7psswgYj3DibliLvNiGbekbb2qL
	 ACv5vjvkEGDXXZ89NjE4s7TH958pRTMTwrdKxxcVtSwlpDN6v7h7PyijRzP9y99/n
	 KQhvddUAnUIV+2fMHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1w6BuC2bqo-00VGVU for
 <git@vger.kernel.org>; Sun, 08 Feb 2026 13:32:22 +0100
Message-ID: <280325e3-401c-47c7-98cf-c5cc7f719ee4@web.de>
Date: Sun, 8 Feb 2026 13:32:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remove duplicate includes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YARk92MAUbw7+G5zMvlnlNab473XwZ6MLDpUnBkj8XCgM8rBzKZ
 JRPimcnFSBKBYSIAX4xi0NdSw9RHyKEabwHRVxT7PWCt540BJNfzvpSzruImYpRbmKgqmp2
 ZwtX6EP6mPQiFxRdHDZ2hAaFsA9/Ui1cVT6nyR9GAHaNRLvTl9m27FBRcHwOMRlyk6XgPIw
 6hp1kOcQTpBvbyh1rgpkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+JF1L5OkICc=;B5Le8AxJYaPQfKb/01kEUBu8YVV
 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

The following command reports that some header files are included twice:

   $ git grep '#include' '*.c' | sort | uniq -cd

Remove the second #include line in each case, as it has no effect.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review.

 builtin/blame.c        | 1 -
 builtin/log.c          | 1 -
 builtin/pack-objects.c | 1 -
 commit.c               | 1 -
 object-file-convert.c  | 1 -
 protocol-caps.c        | 1 -
 setup.c                | 1 -
 7 files changed, 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6044973462..6588161382 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1,37 +1,36 @@
 /*
  * Blame
  *
  * Copyright (c) 2006, 2014 by its authors
  * See COPYING for licensing conditions
  */
=20
 #define USE_THE_REPOSITORY_VARIABLE
=20
 #include "builtin.h"
 #include "config.h"
 #include "color.h"
-#include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "quote.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "utf8.h"
 #include "userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
 #include "progress.h"
 #include "object-name.h"
 #include "odb.h"
 #include "pager.h"
 #include "blame.h"
 #include "refs.h"
 #include "setup.h"
 #include "tag.h"
 #include "write-or-die.h"
diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..43af5047e3 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -1,52 +1,51 @@
 /*
  * Builtin "git log" and related commands (show, whatchanged)
  *
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
=20
 #define USE_THE_REPOSITORY_VARIABLE
=20
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-name.h"
 #include "odb.h"
 #include "odb/streaming.h"
 #include "pager.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "oid-array.h"
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "path.h"
 #include "shortlog.h"
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
 #include "line-log.h"
 #include "branch.h"
 #include "version.h"
 #include "mailmap.h"
 #include "progress.h"
 #include "commit-slab.h"
=20
 #include "commit-reach.h"
 #include "range-diff.h"
 #include "tmp-objdir.h"
 #include "tree.h"
 #include "write-or-die.h"
=20
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5846b6a293..9768c7bf0b 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,53 +1,52 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
 #include "attr.h"
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
 #include "delta.h"
 #include "pack.h"
 #include "pack-revindex.h"
 #include "csum-file.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
 #include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
 #include "delta-islands.h"
 #include "reachable.h"
 #include "oid-array.h"
 #include "strvec.h"
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
 #include "shallow.h"
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
 #include "blob.h"
 #include "tree.h"
 #include "path-walk.h"
-#include "trace2.h"
=20
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
  * It contains an array (dynamically expanded) of the object data, and a =
map
  * that can resolve SHA1s to their position in the array.
  */
diff --git a/commit.c b/commit.c
index 28bb5ce029..515d77e7d3 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1,37 +1,36 @@
 #define USE_THE_REPOSITORY_VARIABLE
=20
 #include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "object-name.h"
 #include "odb.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
 #include "alloc.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "hash-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
 #include "refs.h"
 #include "commit-reach.h"
 #include "setup.h"
 #include "shallow.h"
 #include "tree.h"
 #include "hook.h"
 #include "parse.h"
 #include "object-file.h"
 #include "object-file-convert.h"
-#include "prio-queue.h"
=20
 static struct commit_extra_header *read_commit_extra_header_lines(const c=
har *buf, size_t len, const char **);
=20
diff --git a/object-file-convert.c b/object-file-convert.c
index 7ab875afe6..7813286596 100644
=2D-- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,14 +1,13 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "hex.h"
 #include "repository.h"
 #include "hash.h"
-#include "hash.h"
 #include "object.h"
 #include "loose.h"
 #include "commit.h"
 #include "gpg-interface.h"
 #include "object-file-convert.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index ecdd0dc58d..35072ed60b 100644
=2D-- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -1,12 +1,11 @@
 #include "git-compat-util.h"
 #include "protocol-caps.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
 #include "hash.h"
-#include "hex.h"
 #include "object.h"
 #include "odb.h"
 #include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/setup.c b/setup.c
index 11fe7f8841..c8336eb20e 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1,31 +1,30 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "copy.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "refs.h"
 #include "replace-object.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "setup.h"
 #include "shallow.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "chdir-notify.h"
 #include "path.h"
 #include "quote.h"
 #include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
-#include "exec-cmd.h"
=20
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
=2D-=20
2.52.0
