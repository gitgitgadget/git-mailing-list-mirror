Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0CC820281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbdKBTl6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:41:58 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:48939 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934300AbdKBTl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:41:57 -0400
Received: by mail-io0-f180.google.com with SMTP id d66so1497218ioe.5
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GI46tRg8k4cJPkkmZMKpmLxaJ32G7/Ti2WejW5PFupM=;
        b=W44zZuLKrYSh1cnscntgOWLjsoGp0G/C2iWxG2fL2Hbu0wSoYraizUiF6NtV12J2t7
         iij9oswktqkwY1+Rw3pI2YMAvodrAsnPjdbJy7DE7yUz9Oly/E5ntSvpUtiOPMyUfCb9
         GoHINjij6cFlUgkYaYIYN5Go2NoEaEIlfMj/ehtHf7xlf9wYKArDcfzzL57uOATomGRU
         /0ltAOgS+m9Z1dKkLYJ0civSSdG67XuU2p3Bs5hxiR1KA+hfLOhu/AvqplWMATPTPHC/
         C5yHmTfvcUfNjZE4WNePagMOaSu+xcbvx/i2zDJNHzT1ZsVU5wOd4pn3K+pwW+2A6x/2
         62bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GI46tRg8k4cJPkkmZMKpmLxaJ32G7/Ti2WejW5PFupM=;
        b=lS+du5DyEDNNcMvbnX446+ANBTgkoodS2Uf18PixK1rB2/qRKiCeM6gQkYONr42or9
         pp9eKGKhj11pP77d9ziKi+d9WtysuXtOr/JJgbaFdMTeXnmZanMzOLAz6bpaggdgPHcF
         6/QcI+uzm+U0x3fugGnrw2D6j37LInatjJDiXW0ba1Hnm8XCFZ90IkD+REsFK12xsfN2
         atfQeP0pg6tXvJP+Xqx+HlXfiMJY8bPO9fxjYCAksB6tL06bQjSjW8JQP3U35BDM1qaH
         CAO/K41NkxIj6+PI5B2OLzuhAFWsM392bmAnlYnmM9y3wVPPRQX5UCXCvnDhH7WaI7iq
         uJeQ==
X-Gm-Message-State: AMCzsaX7iMyR5HJLHWmGgi4BXR1FC/LshzdegsD5GLxuW+hSTqA8qcFl
        Oz7+/COCLULLmJwk2RGS/MSDqQ==
X-Google-Smtp-Source: ABhQp+TpD+DJb/8as+obhL9FjgWijlM3cojAXI9+LGFNraiPTaFdbdTtqPvArkvK+Jc82Mj+qH/nXw==
X-Received: by 10.36.225.133 with SMTP id n127mr4155729ith.12.1509651716234;
        Thu, 02 Nov 2017 12:41:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id p84sm207080itc.3.2017.11.02.12.41.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:41:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 0/7] git describe blob
Date:   Thu,  2 Nov 2017 12:41:41 -0700
Message-Id: <20171102194148.2124-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the discussion on v2[1].

Interdiff is below, just fixing minor things.

We'll keep the original algorithm for now, deferring an improvement on 
the algorithm front towards a future developer.

Thanks,
Stefan

[1] https://public-inbox.org/git/20171031211852.13001-1-sbeller@google.com/

Stefan Beller (7):
  t6120: fix typo in test name
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe.c: rename `oid` to avoid variable shadowing
  builtin/describe.c: print debug statements earlier
  builtin/describe.c: factor out describe_commit
  builtin/describe.c: describe a blob

 Documentation/git-describe.txt     |  13 +++-
 Documentation/rev-list-options.txt |   5 ++
 builtin/describe.c                 | 125 ++++++++++++++++++++++++++++---------
 list-objects.c                     |  52 +++++++++------
 revision.c                         |   2 +
 revision.h                         |   3 +-
 t/t6100-rev-list-in-order.sh       |  47 ++++++++++++++
 t/t6120-describe.sh                |  17 ++++-
 8 files changed, 214 insertions(+), 50 deletions(-)
 create mode 100755 t/t6100-rev-list-in-order.sh
diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index 077c3c2193..79ec0be62a 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
-'git describe' [<options>] <blob-ish>
+'git describe' [<options>] <blob>
 
 DESCRIPTION
 -----------
diff --git c/builtin/describe.c w/builtin/describe.c
index 382cbae908..cf08bef344 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -440,6 +440,7 @@ struct process_commit_data {
 	struct object_id current_commit;
 	struct object_id looking_for;
 	struct strbuf *dst;
+	struct rev_info *revs;
 };
 
 static void process_commit(struct commit *commit, void *data)
@@ -456,6 +457,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 		reset_revision_walk();
 		describe_commit(&pcd->current_commit, pcd->dst);
 		strbuf_addf(pcd->dst, ":%s", path);
+		pcd->revs->max_count = 0;
 	}
 }
 
@@ -463,7 +465,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct argv_array args = ARGV_ARRAY_INIT;
-	struct process_commit_data pcd = { null_oid, oid, dst};
+	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
 
 	argv_array_pushl(&args, "internal: The first arg is not parsed",
 		"--all", "--reflog", /* as many starting points as possible */
@@ -497,14 +499,12 @@ static void describe(const char *arg, int last_one)
 		die(_("Not a valid object name %s"), arg);
 	cmit = lookup_commit_reference_gently(&oid, 1);
 
-	if (cmit) {
+	if (cmit)
 		describe_commit(&oid, &sb);
-	} else {
-		if (lookup_blob(&oid))
-			describe_blob(oid, &sb);
-		else
-			die(_("%s is neither a commit nor blob"), arg);
-	}
+	else if (lookup_blob(&oid))
+		describe_blob(oid, &sb);
+	else
+		die(_("%s is neither a commit nor blob"), arg);
 
 	puts(sb.buf);
 
diff --git c/list-objects.c w/list-objects.c
index 03438e5a8b..07a92f35fe 100644
--- c/list-objects.c
+++ w/list-objects.c
@@ -184,13 +184,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 }
 
 static void traverse_trees_and_blobs(struct rev_info *revs,
-				     struct strbuf *base_path,
+				     struct strbuf *base,
 				     show_object_fn show_object,
 				     void *data)
 {
 	int i;
 
-	assert(base_path->len == 0);
+	assert(base->len == 0);
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
@@ -208,12 +208,12 @@ static void traverse_trees_and_blobs(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     base_path, path, data);
+				     base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     base_path, path, data);
+				     base, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
diff --git c/t/t6100-rev-list-in-order.sh w/t/t6100-rev-list-in-order.sh
index 651666979b..d4d539b0da 100755
--- c/t/t6100-rev-list-in-order.sh
+++ w/t/t6100-rev-list-in-order.sh
@@ -1,21 +1,22 @@
 #!/bin/sh
 
-test_description='miscellaneous rev-list tests'
+test_description='rev-list testing in-commit-order'
 
 . ./test-lib.sh
 
-
-test_expect_success 'setup' '
+test_expect_success 'rev-list --in-commit-order' '
 	for x in one two three four
 	do
 		echo $x >$x &&
 		git add $x &&
-		git commit -m "add file $x"
+		git commit -m "add file $x" ||
+		return 1
 	done &&
 	for x in four three
 	do
 		git rm $x &&
-		git commit -m "remove $x"
+		git commit -m "remove $x" ||
+		return 1
 	done &&
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
 	cut -c 1-40 >actual <actual.raw &&
@@ -32,9 +33,9 @@ test_expect_success 'setup' '
 		HEAD~2^{tree}
 		HEAD~2^{tree}:four
 		HEAD~3^{commit}
-		# HEAD~3^{tree} skipped
+		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
 		HEAD~4^{commit}
-		# HEAD~4^{tree} skipped
+		# HEAD~4^{tree} skipped, same as HEAD^{tree}
 		HEAD~5^{commit}
 		HEAD~5^{tree}
 	EOF
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index fd329f173a..aec6ed192d 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -319,7 +319,7 @@ test_expect_success 'describe a blob at a tag' '
 	test_cmp expect actual
 '
 
-test_expect_success 'describe a surviving blob' '
+test_expect_success 'describe a blob with commit-ish' '
 	git commit --allow-empty -m "empty commit" &&
 	git describe HEAD:file >actual &&
 	grep unique-file-1-g actual
