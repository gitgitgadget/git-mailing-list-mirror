Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725A51F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeAXJyS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:18 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33461 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeAXJyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:16 -0500
Received: by mail-pg0-f66.google.com with SMTP id u1so2340221pgr.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ER9FjFWksUbdfkFl3zB4scpyIYX3PvfxwMIF6JnhIo=;
        b=A2Jayj9orzxatmvAWQh2tgvfTUtHNE4i6W0E61K9TkcsI9BEOIdIMpUtOSvEPj49JU
         Rm+XI4f89ZvBEj48rL8nEMk1u8+V0nzr8ur3nsaZR/GIoZjH8CM9Sqf37OQkdMBwwHN+
         78/hwliXItUCNR96PGmcQ0qb2xhNeP9oK5I+22qXEDWZRo6BFvhY+7DqBr8Vexdp0QyQ
         f0xmDPzFhirNb+ThMwRahAOY1PngOR8MY/oaATgnqrYXu/SAhIVQn+r+7p3OX4z0XCuj
         YSNZVSThwe7GvnU4Wn0BX1JuXVVN0MrTvkQc5t4xzYNRW3SaRKg1EqQratqL3fM+OWrW
         2lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ER9FjFWksUbdfkFl3zB4scpyIYX3PvfxwMIF6JnhIo=;
        b=pN05o31OlL4901Oeblt9Ts+lu4qV+ttFpJLRszUAACIA0GedSORvagywkukm5G0TU2
         13gfl0cHORKz1u401UIJw8AS47Ikj6aX8ettu+rW1+7yc4MV24xWwHpDXWL1OENuR266
         I0rzT0KFi1rKY0vNB1mPKCSCt3T7dYwwThpFBr6/oCsAsObIky9U8J/aCYC1gUTe3hKk
         vyDmP2FWwEqUqUiqhVLt2EBh3apIRLrYb9P5nciwpPhqAlzFFwLUx0HhXt9P2hFYQgOV
         mlSEpMPDb099pYm2Ql7XiEVVN9k+0fq0a7T2tAh/j8xa6cre7ye9Ltr+3xQkezykdNr2
         mbHA==
X-Gm-Message-State: AKwxytduFAgIeCb+EOPRYgX+7UOFMkUNO7H5W8J4F5ILkyjCfjRQPrNM
        /fvqVqZXjO2Cuv+vs7XcWKqzGg==
X-Google-Smtp-Source: AH8x225bwgZPxwst9kVRkNeu3UffxIZXALdufrBTDVzsDeLhGudzAi/DrMSRgSBu8WbB8niCgmniZw==
X-Received: by 10.98.170.24 with SMTP id e24mr12472925pff.177.1516787655672;
        Wed, 24 Jan 2018 01:54:15 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id q2sm23320424pgf.10.2018.01.24.01.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/7] worktree.c: add validate_worktree()
Date:   Wed, 24 Jan 2018 16:53:51 +0700
Message-Id: <20180124095357.19645-2-pclouds@gmail.com>
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

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  9 ++++++++
 2 files changed, 81 insertions(+)

diff --git a/worktree.c b/worktree.c
index f5da7d286d..b238d87bf1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -254,6 +254,78 @@ const char *is_worktree_locked(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+/* convenient wrapper to deal with NULL strbuf */
+static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
+{
+	va_list params;
+
+	if (!buf)
+		return;
+
+	va_start(params, fmt);
+	strbuf_vaddf(buf, fmt, params);
+	va_end(params);
+}
+
+int validate_worktree(const struct worktree *wt, struct strbuf *errmsg)
+{
+	struct strbuf wt_path = STRBUF_INIT;
+	char *path = NULL;
+	int err, ret = -1;
+
+	strbuf_addf(&wt_path, "%s/.git", wt->path);
+
+	if (is_main_worktree(wt)) {
+		if (is_directory(wt_path.buf)) {
+			ret = 0;
+			goto done;
+		}
+		/*
+		 * Main worktree using .git file to point to the
+		 * repository would make it impossible to know where
+		 * the actual worktree is if this function is executed
+		 * from another worktree. No .git file support for now.
+		 */
+		strbuf_addf_gently(errmsg,
+				   _("'%s' at main working tree is not the repository directory"),
+				   wt_path.buf);
+		goto done;
+	}
+
+	/*
+	 * Make sure "gitdir" file points to a real .git file and that
+	 * file points back here.
+	 */
+	if (!is_absolute_path(wt->path)) {
+		strbuf_addf_gently(errmsg,
+				   _("'%s' file does not contain absolute path to the working tree location"),
+				   git_common_path("worktrees/%s/gitdir", wt->id));
+		goto done;
+	}
+
+	if (!file_exists(wt_path.buf)) {
+		strbuf_addf_gently(errmsg, _("'%s' does not exist"), wt_path.buf);
+		goto done;
+	}
+
+	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));
+	if (!path) {
+		strbuf_addf_gently(errmsg, _("'%s' is not a .git file, error code %d"),
+				   wt_path.buf, err);
+		goto done;
+	}
+
+	ret = fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id)));
+
+	if (ret)
+		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
+				   wt->path, git_common_path("worktrees/%s", wt->id));
+done:
+	free(path);
+	strbuf_release(&wt_path);
+	return ret;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index c28a880e18..cb577de8cd 100644
--- a/worktree.h
+++ b/worktree.h
@@ -3,6 +3,8 @@
 
 #include "refs.h"
 
+struct strbuf;
+
 struct worktree {
 	char *path;
 	char *id;
@@ -59,6 +61,13 @@ extern int is_main_worktree(const struct worktree *wt);
  */
 extern const char *is_worktree_locked(struct worktree *wt);
 
+/*
+ * Return zero if the worktree is in good condition. Error message is
+ * returned if "errmsg" is not NULL.
+ */
+extern int validate_worktree(const struct worktree *wt,
+			     struct strbuf *errmsg);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.16.0.47.g3d9b0fac3a

