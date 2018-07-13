Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553331F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGPN1s (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34123 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeGPN1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so7472673pgv.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Er2HCarA9iTYIbJl3hl6Vb1CojGJQtVIRlKosjMPlb8=;
        b=Q8FgzncH61eI2DBLIYd50kMKkJq3EG2LU1ysDdB3w72U412oWWlmuS+yN2CiR3AgdH
         BhKtYBhtrMofGp+WTYjk0hu19qzm7BpkwFLt3yezuQeDYn1epWAaMJNOxbsvkbr5eAi9
         Psrb6A5W8xVgSgXn5JJ2B9UlSTFAj8+8fPnxYxauJvXHMYM4+4FjgsJH/dWz4zEAD2Yp
         QR1gNSg5QI3Rpmsv01FfN/Pw/F1Dlk4dCeKQC8Uh5tLfDuA4LD2BpULvsJwgcAsviIcJ
         fJhNwNDwRX3TD9sAiHrtNzchajcmfNh2Hrnr2Xs/RVlbTXBBu2ninmdTCo5Ma8OQJTWY
         gHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Er2HCarA9iTYIbJl3hl6Vb1CojGJQtVIRlKosjMPlb8=;
        b=Yz96M7965cnQW19L1EjM5AeVKtpqwCGb7YOm/t3Gd072koqORXqqZtwCGRydxlzQ90
         OZZalrQm/kltuT2k3d4DTToZJHyOkapfAhsyDWXvKz1ooSHbHJx5WjpzmZy8JqNICnrk
         ujoQAqySlcVhA3sD+FMlrSjTkViw0naEquQ98YWBTh+1ZaQHpScaBPXfACbzXVbONkmu
         iRxm5dQV+QAwTsiJ8CE9aB6NnsMrqdq+FPZdZJLhYAyy9j5WOdcYdrqxPPa/wGev017X
         7glmM4EzSeXOv+Zev4IasmWRWq1+cW2Bj3TrNd8ACnMgiIJx4gNFNJUNLcGI383WG9qo
         7jtQ==
X-Gm-Message-State: AOUpUlEF38Fhlvda8vzZ+r3YSp8Aat2eYlgjnCYEtkkenfS4yi8yQXKZ
        KaTImHHtd91Y5SNWEkSJZ67zqQ==
X-Google-Smtp-Source: AAOMgpdz3aEALKKZR1OR9UEWudPrvZjd73lW5UFsjPJCg/7C5JhKrEIaGg8hcXfI+/aH12iqtfncLQ==
X-Received: by 2002:a62:1a4a:: with SMTP id a71-v6mr18082762pfa.190.1531746026426;
        Mon, 16 Jul 2018 06:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id r71-v6sm78204954pfg.43.2018.07.16.06.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:25 -0700 (PDT)
Message-Id: <6acc5e804ea7beabc7c813e4c1c067915a16087b.1531746011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 10:06:29 -0400
Subject: [PATCH 08/16] test-reach: create new test tool for ref_newer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we prepare to change the behavior of the algorithms in
commit-reach.c, create a new test-tool subcommand 'reach' to test these
methods on interesting commit-graph shapes.

To use the new test-tool, use 'test-tool reach <method>' and provide
input to stdin that describes the inputs to the method. Currently, we
only implement the ref_newer method, which requires two commits. Use
lines "A:<committish>" and "B:<committish>" for the two inputs. We will
expand this input later to accommodate methods that take lists of
commits.

The test t6600-test-reach.sh creates a repo whose commits form a
two-dimensional grid. This grid makes it easy for us to determine
reachability because commit-A-B can reach commit-X-Y if and only if A is
at least X and B is at least Y. This helps create interesting test cases
for each result of the methods in commit-reach.c.

We test all methods in three different states of the commit-graph file:
Non-existent (no generation numbers), fully computed, and mixed (some
commits have generation numbers and others do not).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile              |  1 +
 t/helper/test-reach.c | 62 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t6600-test-reach.sh | 86 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh

diff --git a/Makefile b/Makefile
index 59781f4bc..d69f9d415 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
new file mode 100644
index 000000000..8cc570f3b
--- /dev/null
+++ b/t/helper/test-reach.c
@@ -0,0 +1,62 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "parse-options.h"
+#include "tag.h"
+
+int cmd__reach(int ac, const char **av)
+{
+	struct object_id oid_A, oid_B;
+	struct strbuf buf = STRBUF_INIT;
+	struct repository *r = the_repository;
+
+	setup_git_directory();
+
+	if (ac < 2)
+		exit(1);
+
+
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		struct object_id oid;
+		struct object *o;
+		struct commit *c;
+		if (buf.len < 3)
+			continue;
+
+		if (get_oid_committish(buf.buf + 2, &oid))
+			die("failed to resolve %s", buf.buf + 2);
+
+		o = parse_object(r, &oid);
+		o = deref_tag_noverify(o);
+
+		if (!o)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		c = object_as_type(r, o, OBJ_COMMIT, 0);
+
+		if (!c)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		switch (buf.buf[0]) {
+			case 'A':
+				oidcpy(&oid_A, &oid);
+				break;
+
+			case 'B':
+				oidcpy(&oid_B, &oid);
+				break;
+
+			default:
+				die("unexpected start of line: %c", buf.buf[0]);
+		}
+	}
+	strbuf_release(&buf);
+
+	if (!strcmp(av[1], "ref_newer"))
+		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
+
+	exit(0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index dafc91c24..582d02adf 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
+	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 80cbcf085..a7e53c420 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
new file mode 100755
index 000000000..4ffe0174d
--- /dev/null
+++ b/t/t6600-test-reach.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='basic commit reachability tests'
+
+. ./test-lib.sh
+
+# Construct a grid-like commit graph with points (x,y)
+# with 1 <= x <= 10, 1 <= y <= 10, where (x,y) has
+# parents (x-1, y) and (x, y-1), keeping in mind that
+# we drop a parent if a coordinate is nonpositive.
+#
+#             (10,10)
+#            /       \
+#         (10,9)    (9,10)
+#        /     \   /      \
+#    (10,8)    (9,9)      (8,10)
+#   /     \    /   \      /    \
+#         ( continued...)
+#   \     /    \   /      \    /
+#    (3,1)     (2,2)      (1,3)
+#        \     /    \     /
+#         (2,1)      (2,1)
+#              \    /
+#              (1,1)
+#
+# We use branch 'comit-x-y' to refer to (x,y).
+# This grid allows interesting reachability and
+# non-reachability queries: (x,y) can reach (x',y')
+# if and only if x' <= x and y' <= y.
+test_expect_success 'setup' '
+	for i in $(test_seq 1 10)
+	do
+		test_commit "1-$i" &&
+		git branch -f commit-1-$i
+	done &&
+	for j in $(test_seq 1 9)
+	do
+		git reset --hard commit-$j-1 &&
+		x=$(($j + 1)) &&
+		test_commit "$x-1" &&
+		git branch -f commit-$x-1 &&
+
+		for i in $(test_seq 2 10)
+		do
+			git merge commit-$j-$i -m "$x-$i" &&
+			git branch -f commit-$x-$i
+		done
+	done &&
+	git commit-graph write --reachable &&
+	mv .git/objects/info/commit-graph commit-graph-full &&
+	git show-ref -s commit-7-7 | git commit-graph write --stdin-commits &&
+	mv .git/objects/info/commit-graph commit-graph-half &&
+	git config core.commitGraph true
+'
+
+test_three_modes () {
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ref_newer:miss' '
+	cat >input <<-\EOF &&
+		A:commit-5-7
+		B:commit-4-9
+	EOF
+	printf "ref_newer:0\n" >expect &&
+	test_three_modes ref_newer
+'
+
+test_expect_success 'ref_newer:hit' '
+	cat >input <<-\EOF &&
+		A:commit-5-7
+		B:commit-2-3
+	EOF
+	printf "ref_newer:1\n" >expect &&
+	test_three_modes ref_newer
+'
+
+test_done
-- 
gitgitgadget

