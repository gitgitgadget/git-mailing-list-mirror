Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B741F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIVX7m (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43441 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeIVX7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so13555259lfe.10
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d59So+eBWTcbAONxe5018uXEyh1PvvkEpfrgUYei2Vw=;
        b=HnvubHpf3sb/3QlIuODEKP4o6i+Aj3S08pCt3f3dBirMdzl8GrMqWA0efD8OhoTUES
         QVAnEJBf2xY+m5VzgmKfhqYNLvXrgA4CTAIq+VRL87oqmyFILrjrUZBj7YLwNP5PpYTb
         4G9wHbCYOsh7qYYhXeIJHcjQ+ScOBCGzLZ8ywfTEKhRBMCnq4qViblTDxgshsj77Cygx
         Uj9JsxogLVirXyQz8v9eHCD1yj+2Jcj95M7O9Zet6huJHtDzCYM12nMcaunhhlWLBL63
         lEcre9iAR1K60vzB9Ain7DROfJWyzxraaITX7k22Cq2GyfUXw2GCY7a8A3z3L50rCtyp
         bd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d59So+eBWTcbAONxe5018uXEyh1PvvkEpfrgUYei2Vw=;
        b=IALM1P5Z/bn8gFZeePNAdaD3bOdUNnvP+8gvJIa54DVzCw2K8sPdPMv0D0y9CVlAL3
         tAZYS35y0xTfKoN2P3ONgRkYSiM11tlf+BTK0SdJG1QnmMg0ezFwmEzAs63fcGUvVXDq
         sGNoLMln5DJSYhmkMtSnbSzFxplSwL6HU3SOsOLrLJF1Ti5jfhb3LtlNk7Y/q4Kv+yjk
         cBU6pD2/orxc/T+X7rVMhtdqOI3TcPQR+sQj+hoQZ1300ag1mPo+3SKNefMmfCCFpLoc
         wZLZ7s3+7lHKsEvbx/ea8qupwyP64N5+WQl1W1g1nXB5pjETKblvmjXQbZDiyq8aZnfZ
         6gew==
X-Gm-Message-State: APzg51DAtXkZwXtfpD66D4iqQeZ/671wOzCbvIjferrhbu82pr1eF9GK
        4okU4D1/C31NXgLn55F4wbe6Awfz
X-Google-Smtp-Source: ANB0VdaDFlY8Q8YVq9lTA0I/K2UpbHzMDCgYun6+CI8gq9ZMH4P6JwI9ly3m7bLBMjQQi9GVUX41ig==
X-Received: by 2002:a19:14d4:: with SMTP id 81-v6mr1905946lfu.26.1537639514677;
        Sat, 22 Sep 2018 11:05:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 8/8] reflog expire: cover reflog from all worktrees
Date:   Sat, 22 Sep 2018 20:05:00 +0200
Message-Id: <20180922180500.4689-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-reflog.txt |  7 ++++++-
 builtin/reflog.c             | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 472a6808cd..ff487ff77d 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -20,7 +20,7 @@ depending on the subcommand:
 'git reflog' ['show'] [log-options] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
-	[--dry-run | -n] [--verbose] [--all | <refs>...]
+	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] ref@\{specifier\}...
 'git reflog exists' <ref>
@@ -72,6 +72,11 @@ Options for `expire`
 --all::
 	Process the reflogs of all references.
 
+--single-worktree::
+	By default when `--all` is specified, reflogs from all working
+	trees are processed. This option limits the processing to reflogs
+	from the current working tree only.
+
 --expire=<time>::
 	Prune entries older than the specified time. If this option is
 	not specified, the expiration time is taken from the
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acef5a0ab..eed956851e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -10,6 +10,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "worktree.h"
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
@@ -52,6 +53,7 @@ struct collect_reflog_cb {
 	struct collected_reflog **e;
 	int alloc;
 	int nr;
+	struct worktree *wt;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -388,8 +390,12 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
+	struct strbuf newref = STRBUF_INIT;
+
+	strbuf_worktree_ref(cb->wt, &newref, ref);
+	FLEX_ALLOC_STR(e, reflog, newref.buf);
+	strbuf_release(&newref);
 
-	FLEX_ALLOC_STR(e, reflog, ref);
 	oidcpy(&e->oid, oid);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
@@ -512,7 +518,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
 	timestamp_t now = time(NULL);
-	int i, status, do_all;
+	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
 
@@ -549,6 +555,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
+		else if (!strcmp(arg, "--single-worktree"))
+			all_worktrees = 0;
 		else if (!strcmp(arg, "--verbose"))
 			flags |= EXPIRE_REFLOGS_VERBOSE;
 		else if (!strcmp(arg, "--")) {
@@ -577,10 +585,18 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	if (do_all) {
 		struct collect_reflog_cb collected;
+		struct worktree **worktrees, **p;
 		int i;
 
 		memset(&collected, 0, sizeof(collected));
-		for_each_reflog(collect_reflog, &collected);
+		worktrees = get_worktrees(0);
+		for (p = worktrees; *p; p++) {
+			if (!all_worktrees && !(*p)->is_current)
+				continue;
+			collected.wt = *p;
+			for_each_reflog(collect_reflog, &collected);
+		}
+		free_worktrees(worktrees);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-- 
2.19.0.647.gb9a6049235

