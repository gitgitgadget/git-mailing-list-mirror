Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4457A1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbeDXFOR (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:14:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41267 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755768AbeDXFOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:14:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id g21-v6so19433759wrb.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXdLdVbfe+DzQv0INsN3Z6CBhMyexYZSdq9J6wY6YDI=;
        b=SziKsKpI8qYV678Ia9qRUE+68o0n1SxAPSYIpIdAT7kBQcERHLwzDER8JhcNoA6GMf
         6oz1OCIEqFnU4HZ1FDYAjMtkw/2+ofNpWGmJ5wO9C1m12L0bXUBu1npc9ppG/PLnvSK9
         wIar6lfoiIXiW0+TihsJBNm0O2lEhgsmuWyDDvkI8VW7eXSWLuzCPY4a5qMqqZiR4CtS
         T5njFWxulkeFOTGru8MBDlqgfHWhEXfq9dfeS4nloPVP/lZRWQyUYJZpMA+iVHdIUfqG
         NHUfUWBS+Y3Y8BZjpMZN57T2OkkuR1aMSWIslo2/Y6aq7iCXc9q3XPLin/BITY0+dgeT
         tv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXdLdVbfe+DzQv0INsN3Z6CBhMyexYZSdq9J6wY6YDI=;
        b=OmJjVQN8qlVPoYGKi/bbZDERndHonuMwtMJqs+jLsGeSh+ZPM4lzrqT0FyqoO/ZVaT
         9fAGnwPLhZql8bpV6sXknhHQwj5Ob7nJOOuDxdu8c0nrmx1h6QCBR10obhSXqA/KGxz0
         FfkFA55uh3bbNGa8WnSeRR9XF6AMBEibo5rAlpGsWdrzMAo+uPvLTlPFSm0iA+mLlJB+
         sLquExp3pkVmwgWa+2voGAigK2m6uyH35uDo6Ec8JGqaI5/mDo65TZIL3Kbm5l97hb1D
         +ILhTBR9/krXZP4e+Kk9m3PyKBkFzImUne9OPxLQaGPW1hxHxwTt8jtJwLT5Cdlk5PO3
         XwNg==
X-Gm-Message-State: ALQs6tCRojAUDFH4+GhaL4y6TcEfjaqfKFlnWkQ9tQYBouvM5ooOtQEb
        BbA8KTIKjk+7Cz2gxwmMkrk=
X-Google-Smtp-Source: AIpwx48W/iC7liEkgVNRMXdjgXyaAMRdBUdQBt4NDlIwmIpu9LPz6UGOWnMhza39e/65B8T49omGOQ==
X-Received: by 2002:adf:c792:: with SMTP id l18-v6mr19064450wrg.224.1524546855187;
        Mon, 23 Apr 2018 22:14:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q138sm13091233wmd.1.2018.04.23.22.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Apr 2018 22:14:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/2] unpack_trees_options: free messages when done
Date:   Tue, 24 Apr 2018 07:13:39 +0200
Message-Id: <5cfb43fad88cfb14e77bb0febdac297b78500dc0.1524545557.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524545557.git.martin.agren@gmail.com>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net> <cover.1524545557.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strings allocated in `setup_unpack_trees_porcelain()` are never
freed. Provide a function `clear_unpack_trees_porcelain()` to do so and
call it in the functions which use `setup_unpack_trees_porcelain()`.

In all current callers, the pointers are about to go out of scope, so we
do not need to set them to NULL. Let's do so anyway so that a future
caller or restructured code doesn't suddenly start accessing dangling
pointers.

Note that we only take responsibility for the memory allocated in
`setup_unpack_trees_porcelain()` and not any other members of the
`struct unpack_trees_options`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 unpack-trees.h     |  5 +++++
 builtin/checkout.c |  1 +
 merge-recursive.c  |  1 +
 merge.c            |  3 +++
 unpack-trees.c     | 11 +++++++++++
 5 files changed, 21 insertions(+)

diff --git a/unpack-trees.h b/unpack-trees.h
index 6c48117b84..8c56cf0150 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -32,6 +32,11 @@ enum unpack_trees_error_types {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
 
+/*
+ * Frees resources allocated by setup_unpack_trees_porcelain().
+ */
+extern void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..5cebe170fc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -526,6 +526,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
+		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624d..8229b91e2f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -301,6 +301,7 @@ static int git_merge_trees(int index_only,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &opts);
+	clear_unpack_trees_porcelain(&opts);
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
diff --git a/merge.c b/merge.c
index f123658e58..b433291d0c 100644
--- a/merge.c
+++ b/merge.c
@@ -130,8 +130,11 @@ int checkout_fast_forward(const struct object_id *head,
 
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
+		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
+	clear_unpack_trees_porcelain(&opts);
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e..4c76a29241 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -179,6 +179,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
+void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
+{
+	char **msgs = (char **)opts->msgs;
+
+	free(msgs[ERROR_WOULD_OVERWRITE]);
+	free(msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED]);
+	free(msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN]);
+
+	memset(opts->msgs, 0, sizeof(opts->msgs));
+}
+
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
-- 
2.17.0

