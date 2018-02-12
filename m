Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB19F1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933375AbeBLJuN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:13 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:39079 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbeBLJuM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:12 -0500
Received: by mail-io0-f195.google.com with SMTP id b198so16630424iof.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrhBi/xlfv5+TDZ2Pf0/pItbFXrhF4Bw7SHcTJ8S8AA=;
        b=nWZ5+/h7rEvdzwYw9/ZrQlNDUYXK4pyzR2OafyrYLbrSmGt7cZfd6QmBH9h1EfmaK3
         /GvtybGFlNP48GtreDhEB7DXyFkYdtBh2LDHnCPPl5uAzCJMe0Ixj8gYoCMinKwBpP5U
         LWKjDb38BPZAjEQPQ1Ty2lF9Jgs8JrA97ZXSd+gTP0cRhITZ9n6YATnr+tlyhX09w0+E
         A2e6f7oQ0gXJfKH0yoVckbL07SePpY0NAFN3wifONVIKbfF8VqGzCkx3P2+Pz34eMjx6
         1RRzKB4kZ0qxVnJ11wJzfRxhvRHbq3ztOlfcNBvjJfycStcxXVfoewLba3aaDuGITTsn
         t66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrhBi/xlfv5+TDZ2Pf0/pItbFXrhF4Bw7SHcTJ8S8AA=;
        b=qASLp3hqIiaFk1d7d/VewT6/jQMchRCACuObCtA6EsgnIMCYcfT/BJNzGXeB8Lx5rd
         zoZ1yoyKZrPvWyZFk5nwx7k4iK/MQRAAqQXubtIutT95vWJzAqskHXnav2oVmp+KZ3u3
         NsAIAqXMNGTImJ9IPVdAa+zsAvO2rI9jpz7xgbZZHpQCW+uIUFNbepj3AnyMQvamhsMd
         /Ui1reL7Vyt0zu5xKbcPpAPys8ogKquDAhJ7NfrpkdN5VgXIq63n4gBHH76RsSs8kaf8
         WU5csIp8BpIBUMTdmSb1QfpObVuM+Y3QLUFdr3Nx2gpx2yzDjnKgMs54Ywmt0YrPsOBw
         X1Cg==
X-Gm-Message-State: APf1xPCDmdiSmiPtzLBvY/xHPIY+bQO/otZGW/mIqZl/8KKRc6CiHKtf
        X2kZY+1idknPVMGlcc8/CtHlcg==
X-Google-Smtp-Source: AH8x225KWEMiz8Zwy1ez+GD9yposqjrbYyI2vcXrqI/eNbF61vdPT7pUrNEM8orPzspX5rdsoyrLyA==
X-Received: by 10.107.37.19 with SMTP id l19mr13279812iol.193.1518429010733;
        Mon, 12 Feb 2018 01:50:10 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id h3sm7868814itd.39.2018.02.12.01.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/7] worktree.c: add validate_worktree()
Date:   Mon, 12 Feb 2018 16:49:34 +0700
Message-Id: <20180212094940.23834-2-pclouds@gmail.com>
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

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  9 +++++++
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
2.16.1.399.g632f88eed1

