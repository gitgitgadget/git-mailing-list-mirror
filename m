Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29F21F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfKOJx7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:53:59 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39986 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKOJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:57 -0500
Received: by mail-wm1-f41.google.com with SMTP id f3so9648515wmc.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eaxNcLZkc1xRmA03IP/qM005OiNcCoEXuCQFwEvdCY8=;
        b=fi7ahu3Dei4d3jLUBsactsZJPZRe7oCyMAphT7I2GCJQiksw+imhxx/7Keb8IB4wWZ
         zbsnkxc7f0WYoeN9KcBZ9i+9tvvFTJQ3g0mOTbc9HT2az77Unl40jC2oGsjZWPEbJqfU
         g3uNPAyzkCxMCuN0kcMW9wqYxAYSbOKiZetAzevYumkq/pMjn0Vz1zMNAEMlgOi/GnIC
         L3uu7A9FjC/B6OrNBcsSoAf2BfKKeKoauMRfhmihpldzlVeuEQLDWkc7WxUO5dRaOMBb
         z390M6C/XO10fVGHU7tekJhvjpl4rmTsL+9elcTpnF0kjWTtuyvfw3XoL7RCe6U0bEtt
         Zp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eaxNcLZkc1xRmA03IP/qM005OiNcCoEXuCQFwEvdCY8=;
        b=oLp5w7ag1EwzgNJfsOciyAfFm+PJ23D0Q08nAviX2C1mXZByg+3lrmOwFX5jF2tJtj
         8PlutqSLFlc/1ydjUCcndyMPx7jtgbdQWnLN6dkepuEpRNr6Gg/UrENBzp8+3ph8SAKW
         ZihoaQ5UzsVU+xbIYVGPRaVMsmKool5dyTPJCDKD6QcvzacIF+yVKtinRPzjfnJFevCi
         9kkrlxMqoNaBBdGV8hqZnYy9bK6XszGiIoI/GCbLte+2uZJH4pyH17B9b3rwT/fVwj4d
         QhF9JlLpL59gGfV2/x/jUF6vRC1MFMgVK0USfZz3eiPi7Ynsz8FhqhInlpvk4f9sNuDz
         84gw==
X-Gm-Message-State: APjAAAUWQFmnv6r7wBpXKa/ZDhHo0NgNNDEBadZzC5qbYg4dKOUcpPIl
        YzkFu5iLIiYzh+sqlYEGKISVHNU+
X-Google-Smtp-Source: APXvYqxE9ewa/hV0xDekKb0vEvXI7RsECq4ICahHKlD69bxUmuZUBLX8pfqiK8WEJlMdcqkFz+peuQ==
X-Received: by 2002:a1c:a743:: with SMTP id q64mr13256807wme.44.1573811635510;
        Fri, 15 Nov 2019 01:53:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm10371313wrq.96.2019.11.15.01.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:55 -0800 (PST)
Message-Id: <88553030f5f55a4c7c9ab06aac82ca4ed1a7392b.1573811626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:34 +0000
Subject: [PATCH v4 09/21] revision: move doc to revision.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-revision-walking.txt
to revision.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-revision-walking.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt           |  2 +-
 .../technical/api-revision-walking.txt        | 72 -------------------
 revision.h                                    | 59 +++++++++++++++
 3 files changed, 60 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/technical/api-revision-walking.txt

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 4d24daeb9f..321c0ba6a4 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -17,7 +17,7 @@ revision walk is used for operations like `git log`.
 
 - `Documentation/user-manual.txt` under "Hacking Git" contains some coverage of
   the revision walker in its various incarnations.
-- `Documentation/technical/api-revision-walking.txt`
+- `revision.h`
 - https://eagain.net/articles/git-for-computer-scientists/[Git for Computer Scientists]
   gives a good overview of the types of objects in Git and what your object
   walk is really describing.
diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
deleted file mode 100644
index 03f9ea6ac4..0000000000
--- a/Documentation/technical/api-revision-walking.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-revision walking API
-====================
-
-The revision walking API offers functions to build a list of revisions
-and then iterate over that list.
-
-Calling sequence
-----------------
-
-The walking API has a given calling sequence: first you need to
-initialize a rev_info structure, then add revisions to control what kind
-of revision list do you want to get, finally you can iterate over the
-revision list.
-
-Functions
----------
-
-`repo_init_revisions`::
-
-	Initialize a rev_info structure with default values. The third
-	parameter may be NULL or can be prefix path, and then the `.prefix`
-	variable will be set to it. This is typically the first function you
-	want to call when you want to deal with a revision list. After calling
-	this function, you are free to customize options, like set
-	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
-	`revision.h` for a complete list of available options.
-
-`add_pending_object`::
-
-	This function can be used if you want to add commit objects as revision
-	information. You can use the `UNINTERESTING` object flag to indicate if
-	you want to include or exclude the given commit (and commits reachable
-	from the given commit) from the revision list.
-+
-NOTE: If you have the commits as a string list then you probably want to
-use setup_revisions(), instead of parsing each string and using this
-function.
-
-`setup_revisions`::
-
-	Parse revision information, filling in the `rev_info` structure, and
-	removing the used arguments from the argument list. Returns the number
-	of arguments left that weren't recognized, which are also moved to the
-	head of the argument list. The last parameter is used in case no
-	parameter given by the first two arguments.
-
-`prepare_revision_walk`::
-
-	Prepares the rev_info structure for a walk. You should check if it
-	returns any error (non-zero return code) and if it does not, you can
-	start using get_revision() to do the iteration.
-
-`get_revision`::
-
-	Takes a pointer to a `rev_info` structure and iterates over it,
-	returning a `struct commit *` each time you call it. The end of the
-	revision list is indicated by returning a NULL pointer.
-
-`reset_revision_walk`::
-
-	Reset the flags used by the revision walking api. You can use
-	this to do multiple sequential revision walks.
-
-Data structures
----------------
-
-Talk about <revision.h>, things like:
-
-* two diff_options, one for path limiting, another for output;
-* remaining functions;
-
-(Linus, JC, Dscho)
diff --git a/revision.h b/revision.h
index 4134dc6029..983ffc0f12 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,19 @@
 #include "diff.h"
 #include "commit-slab-decl.h"
 
+/**
+ * The revision walking API offers functions to build a list of revisions
+ * and then iterate over that list.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The walking API has a given calling sequence: first you need to initialize
+ * a rev_info structure, then add revisions to control what kind of revision
+ * list do you want to get, finally you can iterate over the revision list.
+ *
+ */
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -306,11 +319,29 @@ struct setup_revision_opt {
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
 #endif
+
+/**
+ * Initialize a rev_info structure with default values. The third parameter may
+ * be NULL or can be prefix path, and then the `.prefix` variable will be set
+ * to it. This is typically the first function you want to call when you want
+ * to deal with a revision list. After calling this function, you are free to
+ * customize options, like set `.ignore_merges` to 0 if you don't want to
+ * ignore merges, and so on.
+ */
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
+
+/**
+ * Parse revision information, filling in the `rev_info` structure, and
+ * removing the used arguments from the argument list. Returns the number
+ * of arguments left that weren't recognized, which are also moved to the
+ * head of the argument list. The last parameter is used in case no
+ * parameter given by the first two arguments.
+ */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
+
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[]);
@@ -319,9 +350,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags, unsigned revarg_opt);
 
+/**
+ * Reset the flags used by the revision walking api. You can use this to do
+ * multiple sequential revision walks.
+ */
 void reset_revision_walk(void);
+
+/**
+ * Prepares the rev_info structure for a walk. You should check if it returns
+ * any error (non-zero return code) and if it does not, you can start using
+ * get_revision() to do the iteration.
+ */
 int prepare_revision_walk(struct rev_info *revs);
+
+/**
+ * Takes a pointer to a `rev_info` structure and iterates over it, returning a
+ * `struct commit *` each time you call it. The end of the revision list is
+ * indicated by returning a NULL pointer.
+ */
 struct commit *get_revision(struct rev_info *revs);
+
 char *get_revision_mark(const struct rev_info *revs,
 			const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
@@ -333,8 +381,19 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
+/**
+ * This function can be used if you want to add commit objects as revision
+ * information. You can use the `UNINTERESTING` object flag to indicate if
+ * you want to include or exclude the given commit (and commits reachable
+ * from the given commit) from the revision list.
+ *
+ * NOTE: If you have the commits as a string list then you probably want to
+ * use setup_revisions(), instead of parsing each string and using this
+ * function.
+ */
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
+
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
 		     unsigned int flags);
-- 
gitgitgadget

