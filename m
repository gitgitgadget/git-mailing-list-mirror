Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B365C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiAUTMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiAUTM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51FC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so23402179wmq.2
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LLRddwRlb3+xaGRybKZWXk1WLkIn9q55Y8o8W1Ldyek=;
        b=Kqir6E1anO1eWzEANs/xh/7ZA01yQREbZ4h9IJz+B6TBCyo5/rF5Pl7Y2j216u2u08
         ijGEYgHxeCy0Ig2KhNM1UCcMRO348B2yO6SIvSVTZXEJSm+T5H3CSQW+6QIDUpbNt9Po
         Vva926dzOS7i08LfCZ9EOEqPfQ1K6ewtkQY8JPsyt66PxiGSi/qHSh7QmFqL7h5nO1qB
         BicZh3pEGsiXydbqturyn8mF3JdczsOWgzNcif3Bteobk4qfQsywiV8s7O7i1c5/RRmm
         Fhk05cFosc/I4ZGFaJeaYyGR5xuYa3aMT+im4U+ywTv99uPqZ9uC82YEccIKIoYs4RmP
         AYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LLRddwRlb3+xaGRybKZWXk1WLkIn9q55Y8o8W1Ldyek=;
        b=IhvVCPrC7KCjZEYgLsIbaCos6aYsSKZmxOF8SbWnX6vsgeUXIDuJMmqJr+AHUDlJyG
         /Pboik3KpMvHeagksIul9YDUcRhwJy57Bo3r+uuAu6lProKkseLDJTLuijFd2HXfbyDn
         ldFuikf+jGM0h/1estJrl8h0D1UWaXg2dat5Bpl3O8qfSCHf7nyjbZEALPzUxt6WXT5W
         8SQeNe2Bt/QQriXiiSCUMr4z39nBjbUqbW/LTsAC3uWM202K1KAnA2MD9tYHU5CxaJDG
         c7WiBzpFbPCZv+6aOzd1CxJHdpsgpRM9KmXIHefEY536Qet5xAFBwZoyt6s64KyD7me8
         UCHw==
X-Gm-Message-State: AOAM532M6HN6fcXShVqHZUPZv/hR8YDgkuphrTRCnwcYSvZi3lzRmTTa
        aJ5PIRxN5946pFAhobbwAC8KJMnrK3E=
X-Google-Smtp-Source: ABdhPJxhlr/64aSAoF+qV2npX2rH9uAUoJ1wrFxzRE61bM/mKp2XR6JxlZeK8RMfIaN11VYBdpEd1Q==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr1958672wme.3.1642792344740;
        Fri, 21 Jan 2022 11:12:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm5689064wmj.12.2022.01.21.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:24 -0800 (PST)
Message-Id: <f06de6c1b2fbd5c5a23b6755197a3683c7d18d2f.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:12 +0000
Subject: [PATCH v4 02/10] log: clean unneeded objects during `log
 --remerge-diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The --remerge-diff option will need to create new blobs and trees
representing the "automatic merge" state.  If one is traversing a
long project history, one can easily get hundreds of thousands of
loose objects generated during `log --remerge-diff`.  However, none of
those loose objects are needed after we have completed our diff
operation; they can be summarily deleted.

Add a new helper function to tmp_objdir to discard all the contained
objects, and call it after each merge is handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/log.c | 13 +++++++------
 log-tree.c    |  8 +++++++-
 revision.h    |  3 +++
 tmp-objdir.c  |  5 +++++
 tmp-objdir.h  |  6 ++++++
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 846ba0f995a..ac550e1ae62 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -407,13 +407,12 @@ static int cmd_log_walk(struct rev_info *rev)
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
-	struct tmp_objdir *remerge_objdir = NULL;
 
 	if (rev->remerge_diff) {
-		remerge_objdir = tmp_objdir_create("remerge-diff");
-		if (!remerge_objdir)
+		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!rev->remerge_objdir)
 			die(_("unable to create temporary object directory"));
-		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
+		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
 	}
 
 	if (rev->early_output)
@@ -458,8 +457,10 @@ static int cmd_log_walk(struct rev_info *rev)
 	rev->diffopt.no_free = 0;
 	diff_free(&rev->diffopt);
 
-	if (rev->remerge_diff)
-		tmp_objdir_destroy(remerge_objdir);
+	if (rev->remerge_diff) {
+		tmp_objdir_destroy(rev->remerge_objdir);
+		rev->remerge_objdir = NULL;
+	}
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
diff --git a/log-tree.c b/log-tree.c
index 84ed864fc81..d4655b63d75 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "repository.h"
+#include "tmp-objdir.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
@@ -944,7 +945,12 @@ static int do_remerge_diff(struct rev_info *opt,
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
 	merge_finalize(&o, &res);
-	/* TODO: clean up the temporary object directory */
+
+	/* Clean up the contents of the temporary object directory */
+	if (opt->remerge_objdir)
+		tmp_objdir_discard_objects(opt->remerge_objdir);
+	else
+		BUG("unable to remove temporary object directory");
 
 	return !opt->loginfo;
 }
diff --git a/revision.h b/revision.h
index 13178e6b8f3..44efce3f410 100644
--- a/revision.h
+++ b/revision.h
@@ -318,6 +318,9 @@ struct rev_info {
 
 	/* misc. flags related to '--no-kept-objects' */
 	unsigned keep_pack_cache_flags;
+
+	/* Location where temporary objects for remerge-diff are written. */
+	struct tmp_objdir *remerge_objdir;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3d38eeab66b..adf6033549e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -79,6 +79,11 @@ static void remove_tmp_objdir_on_signal(int signo)
 	raise(signo);
 }
 
+void tmp_objdir_discard_objects(struct tmp_objdir *t)
+{
+	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
+}
+
 /*
  * These env_* functions are for setting up the child environment; the
  * "replace" variant overrides the value of any existing variable with that
diff --git a/tmp-objdir.h b/tmp-objdir.h
index cda5ec76778..76efc7edee5 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -46,6 +46,12 @@ int tmp_objdir_migrate(struct tmp_objdir *);
  */
 int tmp_objdir_destroy(struct tmp_objdir *);
 
+/*
+ * Remove all objects from the temporary object directory, while leaving it
+ * around so more objects can be added.
+ */
+void tmp_objdir_discard_objects(struct tmp_objdir *);
+
 /*
  * Add the temporary object directory as an alternate object store in the
  * current process.
-- 
gitgitgadget

