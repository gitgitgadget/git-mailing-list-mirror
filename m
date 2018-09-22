Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0D51F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeIVX7l (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:41 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36707 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVX7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:41 -0400
Received: by mail-lf1-f52.google.com with SMTP id v17-v6so9695219lfe.3
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWKCcA+anug1YFqlI2dK3704O3+1CYsHqkn3C1hIbVQ=;
        b=c8CVIAozeiq5PoQwwbYXPnGDbOKB2iw24CSLcXc6aDF2PFH0aqXR2lYF7s8pvn9j7n
         axhTrKtGuU/kZjIL8iAQNamQOV9NKp85tR8JUdyQ7cOFkeLeXvCTyRXBoQ4pEJHgE0T0
         BL5uL0dGzh91GF0TZc00WtGMdgDlwG4KGPMEznC6le87IWgIC4SrjnaDKleTVd5FctrR
         d3LCxhAamaK3liP8vFm4LBifwP15GZBXcXSC4X+RJEBZShHew+l7RG+hPdBBqbZZd2Rx
         vJAut9GMmh6loeCCRwRv/3KD0kYOOCm8v41aNtTE2jGXWW4nhAAsk8SrszTYruqpZHG7
         O4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWKCcA+anug1YFqlI2dK3704O3+1CYsHqkn3C1hIbVQ=;
        b=SQ2EDvvXUEJk4EZrqiL4r82miP6tAjyoV5RWhf5hsgKsbb1NzF/oCRfRqE6u8dSxol
         GSOfAuOHVWHdqpJPIhhUM2BwUzLNMTFW6w/JBLHxubW2Kxr1oa5F9O2TEZ4yozIao+YN
         KUxu3Y2RgfAXLV2iFS8iVB7BCdox8JeanJdJM47B3Q4dHjLeVJOMtr/dC52RPNTkynDG
         OwtN+4QxIzPqBRN69r3K/BdoYN2KO6MFHcfCfVgjh9NLVqQQPHcczypPHZO/xXHjUQJE
         hheagF7gWtkATyCVTvpliwaQryr/2VzCNJtpb/2HiPVNorBOpb7hgDevp/DXEmPdeS4G
         2sxw==
X-Gm-Message-State: APzg51C+BAdBwocmJbCvYExi2gOWl9sdasSK6KTn0Q1n5g/mWEP1/gDW
        2dt7x63ZDHizcQF8NBWsug1budWZ
X-Google-Smtp-Source: ANB0VdahCvJ5ZYLxnkkK3VB/oZkZdA8E/KcBA4oORVMi+31yv3xyoGeWKF1HN8pbpyYxgFCKtg8U2g==
X-Received: by 2002:a19:c016:: with SMTP id q22-v6mr1834983lff.8.1537639513731;
        Sat, 22 Sep 2018 11:05:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 7/8] fsck: check HEAD and reflog from other worktrees
Date:   Sat, 22 Sep 2018 20:04:59 +0200
Message-Id: <20180922180500.4689-8-pclouds@gmail.com>
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

From: Elijah Newren <newren@gmail.com>

fsck is a repo-wide operation and should check all references no
matter which worktree they are associated to.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c  | 55 ++++++++++++++++++++++++++++++++++---------------
 t/t1450-fsck.sh | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 24f8a09a3c..71492c158d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "run-command.h"
+#include "worktree.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -444,7 +445,11 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 			      int flag, void *cb_data)
 {
-	for_each_reflog_ent(logname, fsck_handle_reflog_ent, (void *)logname);
+	struct strbuf refname = STRBUF_INIT;
+
+	strbuf_worktree_ref(cb_data, &refname, logname);
+	for_each_reflog_ent(refname.buf, fsck_handle_reflog_ent, refname.buf);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -482,20 +487,34 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid);
 
 static void get_default_heads(void)
 {
+	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
-	fsck_head_link(&head_points_at, &head_oid);
-	if (head_points_at && !is_null_oid(&head_oid))
-		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
-	if (include_reflogs)
-		for_each_reflog(fsck_handle_reflog, NULL);
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct strbuf ref = STRBUF_INIT;
+
+		strbuf_worktree_ref(wt, &ref, "HEAD");
+		fsck_head_link(ref.buf, &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid))
+			fsck_handle_ref(ref.buf, &head_oid, 0, NULL);
+		strbuf_release(&ref);
+
+		if (include_reflogs)
+			refs_for_each_reflog(get_worktree_ref_store(wt),
+					     fsck_handle_reflog, wt);
+	}
+	free_worktrees(worktrees);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -584,34 +603,36 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf(stderr, "Checking %s link\n", head_ref_name);
 
-	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	*head_points_at = resolve_ref_unsafe(head_ref_name, 0, head_oid, NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error("Invalid HEAD");
+		return error("Invalid %s", head_ref_name);
 	}
-	if (!strcmp(*head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, head_ref_name))
 		/* detached HEAD */
 		null_is_error = 1;
 	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
-			     *head_points_at);
+		return error("%s points to something strange (%s)",
+			     head_ref_name, *head_points_at);
 	}
 	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error("%s: detached HEAD points at nothing",
+				     head_ref_name);
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			*head_points_at + 11);
+		fprintf(stderr, "notice: %s points to an unborn branch (%s)\n",
+			head_ref_name, *head_points_at + 11);
 	}
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f2dd26f74..444e8c1ad9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -101,6 +101,45 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	grep "HEAD points to something strange" out
 '
 
+test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
+	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	test_when_finished "rm -rf .git/worktrees wt" &&
+	git worktree add wt &&
+	mv .git/HEAD .git/SAVED_HEAD &&
+	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	# avoid corrupt/broken HEAD from interfering with repo discovery
+	test_must_fail git -C wt fsck 2>out &&
+	cat out &&
+	grep "main/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo 0000000000000000000000000000000000000000 >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at missing object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD: invalid sha1 pointer" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny place' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD points to something strange" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
-- 
2.19.0.647.gb9a6049235

