Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1249B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeA2Wix (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:53 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:48006 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeA2Wiv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:51 -0500
Received: by mail-yw0-f202.google.com with SMTP id s191so6440403ywg.14
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Lj83lMj3a8uWOHlKCVPXqExgssGSoJS1ML6Ftt8Pyxk=;
        b=S4UJu+gxBgk80eqC5PEkRmBxFoAxZCer5PUK54oP/UdCbNiTz5l0PxU4mLhfOKuy6j
         3ij4ns/XNSGvaTmEQ4Zmev93KPVyJbi0F1pr/bEVwhRYgBsmwZ2QUDic5Yrzh6ZeqF9c
         XtyRx6dAvINpGl1zHKQvaaltZTTfENd9i2eXH/xd7zoOKRF0MXRD6TAssh+12tDMmvg0
         qMkOKhJLhmquX8wes3yvgUKixyUHoKmJFXcpA7jUEzuWYjvpj7MItZb0XgLtMgpJXnQH
         6DyiIMu5idLxNZijr0YtMSE27DaR9QDSH2NMUNdCySaCBMwWdLRk37+a3xSNpEnCdUwe
         u/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Lj83lMj3a8uWOHlKCVPXqExgssGSoJS1ML6Ftt8Pyxk=;
        b=EjA73khOZ0UORnWaZBMUrYPh/0wlOAfJwjlmL0rGgamm+jH5cwb+FqBOm+hGgJnaU9
         AGdrMxK6Csp3+knbkiBWaMRBTCQU21DQLmg+fQY30q0VHFfhOANqswbVceCfwjWwxTxq
         pF89L0PxJBdc7cVUSps6m2rJepvwz3NW6dFemTKF2tilf6XH3fO5JSyDQLwYqXXg40hR
         62RMpoVNJhKlMwwcL9jAwK09o9BR9uDbt6jutkXVBGildwum8i3eYWjIZrE+nsZsUncy
         IdvzKfDoWkvjVx05f8U+MhISo/XaTHcDI35eapgkT9jKH1TKu3qajaANux4Ju5i5fNVB
         89SQ==
X-Gm-Message-State: AKwxytfZGzbqAoPlQpTSC/J/jHW38KrMg5ROJ1Dw3+K5puc9Lf38/43F
        SuFzxdikh+0AVbsnUwdnyTe7g+JqARL9rehj8p7yplL1BHZPE03Hczb75p3xVdl5qH2IxiVtbSz
        3R8Jh+Hr0WRmtWFlMGcum/wol7MYHDHjjxd3seQs7kQF+rTCdP7denwEIsQ==
X-Google-Smtp-Source: AH8x224SQzCE8hANCKGyag72tvzgtKy8ELK8IOEt+bQve+1RMdnx1I2oVV3oVHIlqPM1ALC2p5/wjo5b3l8=
MIME-Version: 1.0
X-Received: by 10.129.89.84 with SMTP id n81mr12077150ywb.19.1517265531022;
 Mon, 29 Jan 2018 14:38:51 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:21 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-31-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 30/37] init-db: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/init-db.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c9b7946ba..68ff4ad75 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,11 +24,11 @@ static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 
-static void copy_templates_1(struct strbuf *path, struct strbuf *template,
+static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			     DIR *dir)
 {
 	size_t path_baselen = path->len;
-	size_t template_baselen = template->len;
+	size_t template_baselen = template_path->len;
 	struct dirent *de;
 
 	/* Note: if ".git/hooks" file exists in the repository being
@@ -44,12 +44,12 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 		int exists = 0;
 
 		strbuf_setlen(path, path_baselen);
-		strbuf_setlen(template, template_baselen);
+		strbuf_setlen(template_path, template_baselen);
 
 		if (de->d_name[0] == '.')
 			continue;
 		strbuf_addstr(path, de->d_name);
-		strbuf_addstr(template, de->d_name);
+		strbuf_addstr(template_path, de->d_name);
 		if (lstat(path->buf, &st_git)) {
 			if (errno != ENOENT)
 				die_errno(_("cannot stat '%s'"), path->buf);
@@ -57,36 +57,36 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 		else
 			exists = 1;
 
-		if (lstat(template->buf, &st_template))
-			die_errno(_("cannot stat template '%s'"), template->buf);
+		if (lstat(template_path->buf, &st_template))
+			die_errno(_("cannot stat template '%s'"), template_path->buf);
 
 		if (S_ISDIR(st_template.st_mode)) {
-			DIR *subdir = opendir(template->buf);
+			DIR *subdir = opendir(template_path->buf);
 			if (!subdir)
-				die_errno(_("cannot opendir '%s'"), template->buf);
+				die_errno(_("cannot opendir '%s'"), template_path->buf);
 			strbuf_addch(path, '/');
-			strbuf_addch(template, '/');
-			copy_templates_1(path, template, subdir);
+			strbuf_addch(template_path, '/');
+			copy_templates_1(path, template_path, subdir);
 			closedir(subdir);
 		}
 		else if (exists)
 			continue;
 		else if (S_ISLNK(st_template.st_mode)) {
 			struct strbuf lnk = STRBUF_INIT;
-			if (strbuf_readlink(&lnk, template->buf, 0) < 0)
-				die_errno(_("cannot readlink '%s'"), template->buf);
+			if (strbuf_readlink(&lnk, template_path->buf, 0) < 0)
+				die_errno(_("cannot readlink '%s'"), template_path->buf);
 			if (symlink(lnk.buf, path->buf))
 				die_errno(_("cannot symlink '%s' '%s'"),
 					  lnk.buf, path->buf);
 			strbuf_release(&lnk);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
-			if (copy_file(path->buf, template->buf, st_template.st_mode))
+			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
 				die_errno(_("cannot copy '%s' to '%s'"),
-					  template->buf, path->buf);
+					  template_path->buf, path->buf);
 		}
 		else
-			error(_("ignoring template %s"), template->buf);
+			error(_("ignoring template %s"), template_path->buf);
 	}
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog

