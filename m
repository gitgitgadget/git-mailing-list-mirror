Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4CF2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdGZSRo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:17:44 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35614 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdGZSRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:17:42 -0400
Received: by mail-pf0-f169.google.com with SMTP id h29so38875618pfd.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MoJyGfgpXqU7QyhJRNth/V3hx/aTjCQSf6Y20Vwvq2k=;
        b=fWPJZtoYZdp1WH9ScXNtR4Ia1mOTJfUNdIhwfVmOeiuIJvhGJJuQAq/NKrLnlJfnQL
         qZ1E1kRMPvmlMT+HvvVNL/nZhl8mSnN1YoHhNWRQQC4CrQjeLVGGapwhqAou6RwUQglg
         xIbR4tFOOvoI/xzpol7r1xiiM4BeazIoTlWaByEbbwRJJVliim9xfGDlBAB0M+5PJeHC
         PPrBK1P1aJh9RrAk7NWQBNueV/ijbsQTnQ5lhrU2dAyLWdo/x5hShSD08yDMA02M9Llh
         N0keT1QqOXiohsJqSBSEmxuKcBIMaKGKWmaWF+7jXnnGuz2m5JTM4iqUpawc4CO1upgb
         4Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MoJyGfgpXqU7QyhJRNth/V3hx/aTjCQSf6Y20Vwvq2k=;
        b=cm5+bRLjIqLfqiWnPMlOaLVTI2+11RA3HDTzkmf8YhzZUzHG3IRy3FGB4cfjw1YZWC
         Iwk2QWvw1tiXn7t7+2Kwc/ZK//D8mcfjs7Lei8rvea6Yju4ELrCn2wmxgHodgaQs066z
         prKCikO6Us+cYRYx550H6wq7fm6uNiw2PckqvGLI3TkaDjs/Ejvq6xwotWlzOpRUE6iz
         t/DR4OZwuHgJqiwHQtD/1+unZ6877Ptj532MrGKLgdqgwYe+qgZzEuWm28rmLQWLoDOG
         YPkcpa/t2nOMXr5O6KpevFHUCqd8CSvEqsPEM1Pgb2xqr1QnvbEP2DqqAKX/F81yYoeK
         gUVA==
X-Gm-Message-State: AIVw1101n2/0QRJvLbGVEj7SwRdCHVnKtSJSKHs9qNZH/P4JYgkfPhQu
        e6l/UwtgomPdsCD5QCJiww==
X-Received: by 10.99.167.11 with SMTP id d11mr1749166pgf.182.1501093061291;
        Wed, 26 Jul 2017 11:17:41 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w24sm6637038pfk.183.2017.07.26.11.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 11:17:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: [PATCH for NEXT v3 1/2] Documentation: migrate sub-process docs to header
Date:   Wed, 26 Jul 2017 11:17:28 -0700
Message-Id: <b3700e7b49cbefd99511f31d3e0b2837f48964fb.1501092795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501092795.git.jonathantanmy@google.com>
References: <cover.1501092795.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501092795.git.jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501092795.git.jonathantanmy@google.com>
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
index 8cd07a59a..d37c1499a 100644
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
 			   const void *e1,
 			   const void *e2,
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

