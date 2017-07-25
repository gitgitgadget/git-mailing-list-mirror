Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4046C2089A
	for <e@80x24.org>; Tue, 25 Jul 2017 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdGYS3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:29:50 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34289 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGYS3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:29:47 -0400
Received: by mail-pg0-f50.google.com with SMTP id 123so73522445pgj.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=a1eA88ae4w/VxabZzqINovSdUiu7sZaNCobUerdIoIE=;
        b=lU3rGHYkEEg0y8gCTptykWhYb97ALV3m4FOWYrftRmpDBog1bkOlMVo4ul5rx6WwPs
         bi6ZyT4APOzF2iwqsnt9MO7tIAklHBW14YMhZiThMJGtoUm2P5+XdhllUMNM/ayKRuss
         SiTQW18BI5rimyc7VcpxkzrptDGjCbTXZ28QQGek1AbQbuiIOCGQDd+xynHFLwiguucA
         7fzWsuSQ8mzcWzOMxHAysifb3qJE2vdw67gW1hbP+69UsxU/SqK+32JekAQTr0Su+YCm
         7FEQ6d3UIZfXY0dW5ifZqOVI5bWUJFdRMKCHkkBo7M9Mb+Em+yvqxJY43zcGmO1WyY+I
         +viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=a1eA88ae4w/VxabZzqINovSdUiu7sZaNCobUerdIoIE=;
        b=dcuUbW745eFMJkPUG2YHtfxIg0vSrAchEZQ/hy/BFQCM5pBcSfscQTbwPmo1lTDc0A
         Jf85XRjwpkz+19n249jQn1pdoY91hjFVvLOSpivm+lhW8yHSTs4abpKGpolpBOYxuZ+y
         hO5visSQU1o/RdyoC4Z2pKjDcwRImT+Ae+Q90yr0BpVFOim6W7sQrWwd0xHignaMmy8o
         rZ2hC+5INfOL6Ll7XIMtWTPwbf3NuimKvQMOFqzFEmsjL3Yo62/qNUkyC7BSYR9cQqbA
         LFmezWHzEtGgjR2wGr9ACkeHK+Ao/IvVxTG3T1wZlz/rwls7myql9fRotAYKyqwpthR9
         GXVQ==
X-Gm-Message-State: AIVw110Z3+f/WdSsHObADag5ENZGAZRrgmggS5nkWp+eROkDayVqUlrQ
        vRG5lvdkOQqF/Sn6uW72/A==
X-Received: by 10.84.231.139 with SMTP id g11mr22180153plk.283.1501007386088;
        Tue, 25 Jul 2017 11:29:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e10sm3354139pgu.16.2017.07.25.11.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:29:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peartben@gmail.com
Subject: [PATCH v2 1/2] Documentation: migrate sub-process docs to header
Date:   Tue, 25 Jul 2017 11:29:37 -0700
Message-Id: <2d97d07a4977048a8147292ac13db48f5202d52f.1501007300.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501007300.git.jonathantanmy@google.com>
References: <cover.1501007300.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501007300.git.jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501007300.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation for the sub-process API from a separate txt file
to its header file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/api-sub-process.txt | 59 -----------------------------
 sub-process.h                               | 25 +++++++++++-
 2 files changed, 23 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/technical/api-sub-process.txt

diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
deleted file mode 100644
index 793508cf3..000000000
--- a/Documentation/technical/api-sub-process.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-sub-process API
-===============
-
-The sub-process API makes it possible to run background sub-processes
-for the entire lifetime of a Git invocation. If Git needs to communicate
-with an external process multiple times, then this can reduces the process
-invocation overhead. Git and the sub-process communicate through stdin and
-stdout.
-
-The sub-processes are kept in a hashmap by command name and looked up
-via the subprocess_find_entry function.  If an existing instance can not
-be found then a new process should be created and started.  When the
-parent git command terminates, all sub-processes are also terminated.
-
-This API is based on the run-command API.
-
-Data structures
----------------
-
-* `struct subprocess_entry`
-
-The sub-process structure.  Members should not be accessed directly.
-
-Types
------
-
-'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
-
-	User-supplied function to initialize the sub-process.  This is
-	typically used to negotiate the interface version and capabilities.
-
-
-Functions
----------
-
-`cmd2process_cmp`::
-
-	Function to test two subprocess hashmap entries for equality.
-
-`subprocess_start`::
-
-	Start a subprocess and add it to the subprocess hashmap.
-
-`subprocess_stop`::
-
-	Kill a subprocess and remove it from the subprocess hashmap.
-
-`subprocess_find_entry`::
-
-	Find a subprocess in the subprocess hashmap.
-
-`subprocess_get_child_process`::
-
-	Get the underlying `struct child_process` from a subprocess.
-
-`subprocess_read_status`::
-
-	Helper function to read packets looking for the last "status=<foo>"
-	key/value pair.
diff --git a/sub-process.h b/sub-process.h
index 96a2cca36..9e6975b5e 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -6,12 +6,23 @@
 #include "run-command.h"
 
 /*
- * Generic implementation of background process infrastructure.
- * See: Documentation/technical/api-sub-process.txt
+ * The sub-process API makes it possible to run background sub-processes
+ * for the entire lifetime of a Git invocation. If Git needs to communicate
+ * with an external process multiple times, then this can reduces the process
+ * invocation overhead. Git and the sub-process communicate through stdin and
+ * stdout.
+ *
+ * The sub-processes are kept in a hashmap by command name and looked up
+ * via the subprocess_find_entry function.  If an existing instance can not
+ * be found then a new process should be created and started.  When the
+ * parent git command terminates, all sub-processes are also terminated.
+ * 
+ * This API is based on the run-command API.
  */
 
  /* data structures */
 
+/* Members should not be accessed directly. */
 struct subprocess_entry {
 	struct hashmap_entry ent; /* must be the first member! */
 	const char *cmd;
@@ -20,21 +31,31 @@ struct subprocess_entry {
 
 /* subprocess functions */
 
+/* Function to test two subprocess hashmap entries for equality. */
 extern int cmd2process_cmp(const void *unused_cmp_data,
 			   const struct subprocess_entry *e1,
 			   const struct subprocess_entry *e2,
 			   const void *unused_keydata);
 
+/*
+ * User-supplied function to initialize the sub-process.  This is
+ * typically used to negotiate the interface version and capabilities.
+ */
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+
+/* Start a subprocess and add it to the subprocess hashmap. */
 int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
 		subprocess_start_fn startfn);
 
+/* Kill a subprocess and remove it from the subprocess hashmap. */
 void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry);
 
+/* Find a subprocess in the subprocess hashmap. */
 struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd);
 
 /* subprocess helper functions */
 
+/* Get the underlying `struct child_process` from a subprocess. */
 static inline struct child_process *subprocess_get_child_process(
 		struct subprocess_entry *entry)
 {
-- 
2.14.0.rc0.400.g1c36432dff-goog

