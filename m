Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664233;
	b=lPqquLPxz+CTwV6xrqYa/FO3/pv6F846z/CeBvNeccLMAcQaNtJLpfRvzPgHeKy+a/IT
	 YcvVotl1sXB8/va7z1YN99LoOaJ93a1Mn0g/k5a5wITX4/3OnlFWdrWFzIDSmzKR+yM7w
	 C2fr9LrJ0w56GU70aCol2nlYgBH0hbos/Xooe0GGk+A9s67oGIS3Q+2n8cDCubQAW1gOd
	 BjvIPZFptU0Dgix4i6x1vXRo3N7cOxi9MTknIF50EGlFV7PAcMs/qbk+8xMgqtu100LtK
	 5EUbLoWxVOO7f5UpzQI/UIieooxJ/BTogWH0yfnuMduTtXbQXO8Z6jHwvppV0LuB8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Fcc:To:
	 Cc;
	bh=8qleeaWKekMxamKIDlM1jdn5vXsj7qpdBMf0R7PMTik=;
	b=WZWDbO9piVl0Iu8TQC6z5bOXlH+eKICM/xTSI0Gd+wsDnx9U12MHiznCreUb2X44hGEI
	 eYSUTz9LvGZ0WzEZtPGzHYifL2wDIkXF42ZKNgZQqVGvpwZzRr6aDQLmleoi/ppgZAgeJ
	 lHuyZ2l+3RWFabT2fI/Nl0oZkw8nsCmabGGOfSIGkdQpM2SLrTbtp/PQfG2Y4ex4gU0Xj
	 Ert6HdK1ygAfdWNqMC70w+pve39KpbeONb3SttOJEOReN4qBN2ue1LJatsxp75R7pRWXZ
	 a8ma4iHKcm1U2yJVHOQJf7WnYlyzjfQLarBWpHSUEnn4BBrzYqABp6gtqvRPLlN/Mxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdVZ+5ST;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D3606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdVZ+5ST
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-18818daa3e7so3776614c88.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664232; x=1796269032; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8qleeaWKekMxamKIDlM1jdn5vXsj7qpdBMf0R7PMTik=;
        b=RdVZ+5STozmSt3szKkDCTJjmrz99uaHaSWi0a0bhMv7O5lY37nT9NgW8AaxGK+5Mpz
         2UznWswo8SQW3BdVpLWfjt0YJ0WpEPIL80DUICTq9q0HzLZUt2554XqUh0emmlGgfQ3i
         8OjkS56lwzMTFAsrZ2KtE1jlR5bG0YaHvIepfQkjqLJZgtxpHf/W7I62o5EW4xG5f3KY
         z2MyEhaqxiqoE2FKYzwJE3bDhNIxD6u5LhFccgJPlGVexUb1UOjPWPOcuU3YHglRJsuc
         HHJOKNQ9y/D+T49qrp1nzsoDUN6C5xeenjALchsJ2eWtckBwnWmTui8qFJ5qg7E07Q7P
         wX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664232; x=1796269032;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8qleeaWKekMxamKIDlM1jdn5vXsj7qpdBMf0R7PMTik=;
        b=LkO7vpwWb+Yw8hMZuxLcp0sJu3VbZw1J7ovF4gHb2flNkVui67J75CaFxpbj7DytQq
         xO0/PuRq84J+Aq1a/pDeJ6EarZqHatv9GWTJYM2TvWfQPhGeWxaDXT0UudcyXpwnkfD9
         TeaZmvAOM+WGKSTkJMW9N8QkCWfi6mnYsAFTYjAaOIuXJRyITbNUa4m1SpNgitqpNl4y
         UAMq8GINqx/EPTGpmlb+TFSb9IVzC9Lms/yMwun2dGOCThuETFQE4qG7nNIYE+UZGJ3N
         /c7fnoddG5DddjxEWy8Qn1LoacBD5YcUQVMFZcq2Kl0M9zT63ka11M08OtaiSG79yD7g
         uWXw==
X-Gm-Message-State: APuU4Z89wQw4smo1RG4bb44hZSD4WtiJrHo5GAPvVYdCXRnXFf5TL8oS
	Cq1C2SksKn+MxzgOlQmIgF+m36XjtXh6kPK1GoVqcoSVLbuZhD8NQp1N8gy2nQ==
X-Gm-Gg: AZFdTZdnjH2GSEdEKaOd5zgc6PLOswcXqq2ZnW+CdVy/uSAGcm2ATVn2e0IO0LYwP6X
	VrIx1ntcuOyZuZh4BB/S676/tStA4pAF9KZwhtircYjsEe33vvWMQwMynNJwyLBQ1YmUABelJMT
	zgihQ4rdm8YUOs+mchMhD87+ZxBH+YYICMOtIO3DWPnaxFF+2ZcxQxxjLtzND50puhK2kplj768
	Wk2jVB2E2IwYxaMB5wjWUqZzuZZprYQjBBpgPXwLGdgXxr/7kj6Ei3XQmY9YuQ3Ynnt/SwsOh0M
	uEzTQ6DJLGixx7paTitwUrdnZXvKZS6rZn3tJumX3oB+5xwzS04XNEINEOqCfwEB1BllE3EAQAx
	/uu1N9S80tt3asyYORf+7ZTxcHaHP+trBBttV5zJh6eg5npsK9GeHd2lADy9hL5fznZMB2JFDZC
	b5WTiM0oQZBQpaeJov5i7PqqnsYmD9ZlGX7dYvh6m9Ju4byv1yOCuQ3s0esROped1cmwg9Vxywy
	5Dr6STuqy+rbmtfQ6BiRuonphOfTfPOQRhkBruFUgWxn8oXpM8euaFIrKOXSuVaiiKWRntwA7+Q
	oBb2VDg0Dyf7zjg4wXf8CPaDUPtK4qiM0rZnFUAYaGnspbGxqiN8
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id a92af1059eb24-1b5524b591cmr18098660c88.13.1795664232036;
        Wed, 25 Nov 2026 19:37:12 -0800 (PST)
Received: from [127.0.0.1] ([20.163.93.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm54052619c88.7.2026.11.25.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:37:11 -0800 (PST)
Message-Id: <pull.2330.git.1795664230820.gitgitgadget@gmail.com>
From: "Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 03:37:10 +0000
Subject: [PATCH] blame: free the suspects slab at scoreboard teardown
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>,
    =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

From: =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

setup_scoreboard() initializes the file-static suspects slab each
time it runs, but cleanup_scoreboard() doesn't free the slab. A
second setup overwrites the pointer to the previous slab and leaks
its allocations.

Clear the slab during cleanup. Each final blame entry holds a
reference to its origin, so release those references first:
blame_origin_decref() uses the slab to unlink an origin when its
reference count reaches zero.

Add a regression test that sets up and cleans up two scoreboards
in one process. Without the fix, LeakSanitizer reports a leaked
slab; with the fix the test passes for both files and reftable.

Signed-off-by: Onur Gündüz <ogunduz@gmail.com>
---
    blame: free the suspects slab at scoreboard teardown

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2330%2Ftetsuo%2Fsubmit%2Fblame-lifetime-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2330/tetsuo/submit/blame-lifetime-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2330

 blame.c                     |  1 +
 blame.h                     |  1 +
 builtin/blame.c             |  1 +
 t/helper/test-repository.c  | 34 +++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t8016-blame-scoreboard.sh | 12 ++++++++++++
 6 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100755 t/t8016-blame-scoreboard.sh

diff --git a/blame.c b/blame.c
index 126e232416..61e1a45650 100644
--- a/blame.c
+++ b/blame.c
@@ -2935,6 +2935,7 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb)
 
 void cleanup_scoreboard(struct blame_scoreboard *sb)
 {
+	clear_blame_suspects(&blame_suspects);
 	free(sb->lineno);
 	free(sb->final_buf);
 	clear_prio_queue(&sb->commits);
diff --git a/blame.h b/blame.h
index 3b34be0e5c..75a910bb67 100644
--- a/blame.h
+++ b/blame.h
@@ -180,6 +180,7 @@ void init_scoreboard(struct blame_scoreboard *sb);
 void setup_scoreboard(struct blame_scoreboard *sb,
 		      struct blame_origin **orig);
 void setup_blame_bloom_data(struct blame_scoreboard *sb);
+/* Release all entry and caller references to origins before clearing the slab. */
 void cleanup_scoreboard(struct blame_scoreboard *sb);
 
 struct blame_entry *blame_entry_prepend(struct blame_entry *head,
diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..332795d18f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1323,6 +1323,7 @@ parse_done:
 cleanup:
 	for (ent = sb.ent; ent; ) {
 		struct blame_entry *e = ent->next;
+		blame_origin_decref(ent->suspect);
 		free(ent);
 		ent = e;
 	}
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 9ba94cdffa..245253efbd 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -1,12 +1,14 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
+#include "blame.h"
 #include "commit-graph.h"
 #include "commit.h"
 #include "environment.h"
 #include "hex.h"
 #include "object.h"
 #include "repository.h"
+#include "revision.h"
 #include "setup.h"
 #include "tree.h"
 
@@ -65,11 +67,41 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	repo_clear(&r);
 }
 
+static void test_blame_scoreboard(const char *path)
+{
+	struct repository *repo = the_repository;
+
+	setup_git_directory(repo);
+	/* A second setup exposes leaks left by the first scoreboard. */
+	for (int i = 0; i < 2; i++) {
+		const char *args[] = { "blame", "HEAD", NULL };
+		struct blame_scoreboard sb;
+		struct blame_origin *origin;
+		struct rev_info revs;
+
+		repo_init_revisions(repo, &revs, NULL);
+		setup_revisions(ARRAY_SIZE(args) - 1, args, &revs, NULL);
+		init_scoreboard(&sb);
+		sb.repo = repo;
+		sb.revs = &revs;
+		sb.path = path;
+		setup_scoreboard(&sb, &origin);
+		blame_origin_decref(origin);
+		cleanup_scoreboard(&sb);
+		release_revisions(&revs);
+	}
+	repo_clear(repo);
+}
+
 int cmd__repository(int argc, const char **argv)
 {
 	if (argc < 2)
 		die("must have at least 2 arguments");
-	if (!strcmp(argv[1], "parse_commit_in_graph")) {
+	if (!strcmp(argv[1], "blame-scoreboard")) {
+		if (argc != 3)
+			die("usage: test-tool repository blame-scoreboard <path>");
+		test_blame_scoreboard(argv[2]);
+	} else if (!strcmp(argv[1], "parse_commit_in_graph")) {
 		struct object_id oid;
 		if (argc < 5)
 			die("not enough arguments");
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..6188a0c4bc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -993,6 +993,7 @@ integration_tests = [
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
   't8015-blame-diff-algorithm.sh',
+  't8016-blame-scoreboard.sh',
   't8020-last-modified.sh',
   't9001-send-email.sh',
   't9002-column.sh',
diff --git a/t/t8016-blame-scoreboard.sh b/t/t8016-blame-scoreboard.sh
new file mode 100755
index 0000000000..bc7f85c468
--- /dev/null
+++ b/t/t8016-blame-scoreboard.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='blame scoreboard teardown'
+
+. ./test-lib.sh
+
+test_expect_success 'set up and tear down two scoreboards in one process' '
+	test_commit one file &&
+	test-tool repository blame-scoreboard file
+'
+
+test_done

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
gitgitgadget
