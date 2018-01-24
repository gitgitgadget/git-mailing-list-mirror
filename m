Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAA41F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbeAXJyv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37795 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeAXJyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:49 -0500
Received: by mail-pg0-f65.google.com with SMTP id z17so2335962pgc.4
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oseg2x8wDUehm6BGOLwOPph7tqGA/twQgKXJMcCKLu0=;
        b=LyZIZ21KZ2ZRclv1YnR3L5LtjdJ8Ov0CmP2fV69clQcGpWIlE9asfQCEq1ifQ/LfXU
         faXXchn6i1ERMdUU9bSKTv3RdRdzqQLyAueXuNDyCEExT3TXEQGpCtiQWT1sXaTK5P41
         gnNO+2L7m4qB9faOwhIS35/0iMfUNoXFLvvkKNuWOX5gW5nHf5hd+p9m7zNQLMA6U2Fy
         TSzZxEIGLTzLCIwe+qFbvvZ2x9HR6ZMoeEtEeyOG2fO17MsH59M325Z2LIOOzgBYOhZb
         1tmffiWTexEhnPOATPG4V0Eo3ONnXjj385xTFYUFnJtkIhl4oEBPbMbYniO6bDajWBt8
         UgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oseg2x8wDUehm6BGOLwOPph7tqGA/twQgKXJMcCKLu0=;
        b=fZY4ZapOdVQQXPyxTjyBSVfv5VAvGggxj+H4QyEZ3DOCII6eoboVMFlRfnsYz3MqHa
         qJfcyDNEXGlRmM1qDBuCYYR+T200yR7gvcWr3iPjfueNGWqcS4s9AyLbxU6T5r6SDGbz
         kcLEv7FGAeoXDI4d9qQjj9qiWLK3B4ts6WDnKf4jW03Zk9/IjNADYMQJF8dEHbtGQK0t
         blz3KV4Q97bUblrhh+3EsomSWYTJW5Ie6dJQs6c9GM2e5HipB9IEnbMMjr1mt9YJcr33
         rTykBDUTJp4Js+e7hRyv9mzex6Wd7YbsA1j03ETHNtVp7/767O2KyYvIbjc2VP7X2CYI
         ca5Q==
X-Gm-Message-State: AKwxytc64v4DfmE0JrteYdXTGXoUWZC4G6+jGqBxxtPEJzvRIZOvweBu
        gznvfKsgcLx4JKOZBdeKHy/3PA==
X-Google-Smtp-Source: AH8x224N2VgppzZAUdF2kRGM+jFlM8r2ijCvhlxp0v3A7o/QSVkeDabG/0zVtq6DzstCSw1RTlRZ0g==
X-Received: by 10.101.70.201 with SMTP id n9mr5610868pgr.74.1516787688736;
        Wed, 24 Jan 2018 01:54:48 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id q14sm30212155pgt.53.2018.01.24.01.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 7/7] worktree remove: allow it when $GIT_WORK_TREE is already gone
Date:   Wed, 24 Jan 2018 16:53:57 +0700
Message-Id: <20180124095357.19645-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree remove" basically consists of two things

- delete $GIT_WORK_TREE
- delete $GIT_DIR (which is $SUPER_GIT_DIR/worktrees/something)

If $GIT_WORK_TREE is already gone for some reason, we should be able
to finish the job by deleting $GIT_DIR.

Two notes:

- $GIT_WORK_TREE _can_ be missing if the worktree is locked. In that
  case we must not delete $GIT_DIR because the real $GIT_WORK_TREE may
  be in a usb stick somewhere. This is already handled because we
  check for lock first.

- validate_worktree() is still called because it may do more checks in
  future (and it already does something else, like checking main
  worktree, but that's irrelevant in this case)

Noticed-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c       | 12 +++++++-----
 t/t2028-worktree-move.sh |  8 ++++++++
 worktree.c               |  9 ++++++++-
 worktree.h               |  5 ++++-
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8b027375d7..8ce86aef0e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -676,7 +676,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 			    reason);
 		die(_("cannot move a locked working tree"));
 	}
-	if (validate_worktree(wt, &errmsg))
+	if (validate_worktree(wt, &errmsg, 0))
 		die(_("validation failed, cannot move working tree:\n%s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
@@ -796,15 +796,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 			    reason);
 		die(_("cannot remove a locked working tree"));
 	}
-	if (validate_worktree(wt, &errmsg))
+	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
 		die(_("validation failed, cannot remove working tree:\n%s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 
-	if (!force)
-		check_clean_worktree(wt, av[0]);
+	if (file_exists(wt->path)) {
+		if (!force)
+			check_clean_worktree(wt, av[0]);
 
-	ret |= delete_git_work_tree(wt);
+		ret |= delete_git_work_tree(wt);
+	}
 	/*
 	 * continue on even if ret is non-zero, there's no going back
 	 * from here.
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index b3105eaaed..459f676683 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -116,4 +116,12 @@ test_expect_success 'force remove worktree with untracked file' '
 	test_path_is_missing destination
 '
 
+test_expect_success 'remove missing worktree' '
+	git worktree add to-be-gone &&
+	test -d .git/worktrees/to-be-gone &&
+	mv to-be-gone gone &&
+	git worktree remove to-be-gone &&
+	test_path_is_missing .git/worktrees/to-be-gone
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 98e9f32c7f..542196f0ad 100644
--- a/worktree.c
+++ b/worktree.c
@@ -267,7 +267,8 @@ static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
 	va_end(params);
 }
 
-int validate_worktree(const struct worktree *wt, struct strbuf *errmsg)
+int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
+		      unsigned flags)
 {
 	struct strbuf wt_path = STRBUF_INIT;
 	char *path = NULL;
@@ -303,6 +304,12 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg)
 		goto done;
 	}
 
+	if (flags & WT_VALIDATE_WORKTREE_MISSING_OK &&
+	    !file_exists(wt->path)) {
+		ret = 0;
+		goto done;
+	}
+
 	if (!file_exists(wt_path.buf)) {
 		strbuf_addf_gently(errmsg, _("'%s' does not exist"), wt_path.buf);
 		goto done;
diff --git a/worktree.h b/worktree.h
index a913428c3d..fe38ce10c3 100644
--- a/worktree.h
+++ b/worktree.h
@@ -61,12 +61,15 @@ extern int is_main_worktree(const struct worktree *wt);
  */
 extern const char *is_worktree_locked(struct worktree *wt);
 
+#define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
+
 /*
  * Return zero if the worktree is in good condition. Error message is
  * returned if "errmsg" is not NULL.
  */
 extern int validate_worktree(const struct worktree *wt,
-			     struct strbuf *errmsg);
+			     struct strbuf *errmsg,
+			     unsigned flags);
 
 /*
  * Update worktrees/xxx/gitdir with the new path.
-- 
2.16.0.47.g3d9b0fac3a

