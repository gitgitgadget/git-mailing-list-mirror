Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E06B1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeBLJuq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:46 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40164 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932929AbeBLJuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:44 -0500
Received: by mail-ot0-f194.google.com with SMTP id s4so13455974oth.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps6ysJufNPul5faOWnq4xns1vzmUnSJ/DunixWXV/dw=;
        b=t7RZpbIu8USJCk1MnhYMGhjCgkf0tfny8QwhFaqqMrIxWRrT0fn9Q8he+rNpmI/zSG
         8dMTJV0j7RRiS882F7F18/jKXHKQFb4meu154vO81IQhKRA3SK8CPY6zC4zz4tNiI9Ue
         bcFTkzeZf9bBGZ4wtD9eOZ2Z8mc/322tvjc0WZJ2QncCQHrwOVr35pkku1NiCoFU+VFj
         5jtrrHKtX4y+LJCM4O+vJKLhTZ5TnDCEWEiNo07Z0egKtBD6n3mdn0zrm7vba/pEdLM+
         DMjBXq+vFUqx1qscIko781d/y9vSEvsvyZWECSRkWhsim1y1+2CCOupn9JWcEDUIzV1e
         4jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps6ysJufNPul5faOWnq4xns1vzmUnSJ/DunixWXV/dw=;
        b=FIifv8/26OieW7VOEhQTh9UFYMOdlcdLEdi3xwIsY3eRgiNhYK6v2cVNER28RbKjTX
         cQRAv0/9ONj5WE/LnLLRCit5fU/70Ct3Q8dH5pWmu/929aMrcWsG52r62aaCT7mgjrdm
         QWIf1nAWvzpq08o1mqVF4xk6LdWYFwW5sM7XtYW1DX42s00/5insOY+4PlaIzCSUmGTP
         QEH+Whrotb229bTlvuz/al1aPTO+xfh+eJxtqNUjpFMrkcg/6bpFyGrajzxNzo6N4SOL
         2UXANg+RVkd0ixJHMf9pEqM2cqS8UEvDGql/ix0skZbK+SzfPGiGBRHGwaYrOGTaebWZ
         iDJQ==
X-Gm-Message-State: APf1xPCSIrp+uP8n4d3OpPanAsi0BcKgUVfJlw8MtBjRjSGVea283pGb
        bWW0/YcdhONWJVCCbhRtATryQg==
X-Google-Smtp-Source: AH8x2242NiOYNZ/z0THJRKqJ4CHte5tHwRrPjZ16cUecPhThIw4v188+RHO4up8Oq/uMs4MpaqffcA==
X-Received: by 10.157.42.16 with SMTP id t16mr9199771ota.75.1518429043848;
        Mon, 12 Feb 2018 01:50:43 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w19sm2493027otw.60.2018.02.12.01.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 7/7] worktree remove: allow it when $GIT_WORK_TREE is already gone
Date:   Mon, 12 Feb 2018 16:49:40 +0700
Message-Id: <20180212094940.23834-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180212094940.23834-1-pclouds@gmail.com>
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
 t/t2028-worktree-move.sh | 17 +++++++++++++++++
 worktree.c               |  9 ++++++++-
 worktree.h               |  5 ++++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 990e47b315..f77ef994c4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -674,7 +674,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 			    reason);
 		die(_("cannot move a locked working tree"));
 	}
-	if (validate_worktree(wt, &errmsg))
+	if (validate_worktree(wt, &errmsg, 0))
 		die(_("validation failed, cannot move working tree: %s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
@@ -799,15 +799,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 			    reason);
 		die(_("cannot remove a locked working tree"));
 	}
-	if (validate_worktree(wt, &errmsg))
+	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
 		die(_("validation failed, cannot remove working tree: %s"),
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
index 4718c4552f..082368d8c6 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -126,4 +126,21 @@ test_expect_success 'force remove worktree with untracked file' '
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
+test_expect_success 'NOT remove missing-but-locked worktree' '
+	git worktree add gone-but-locked &&
+	git worktree lock gone-but-locked &&
+	test -d .git/worktrees/gone-but-locked &&
+	mv gone-but-locked really-gone-now &&
+	test_must_fail git worktree remove gone-but-locked &&
+	test_path_is_dir .git/worktrees/gone-but-locked
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 0373faf0dc..28989cf06e 100644
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
2.16.1.399.g632f88eed1

