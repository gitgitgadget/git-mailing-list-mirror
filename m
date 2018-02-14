Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635B01F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162582AbeBNTCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:10 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:35682 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162574AbeBNTCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:03 -0500
Received: by mail-qk0-f202.google.com with SMTP id q185so20050361qke.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xIlshMkPEILCFE+m5bQ4z4FtXIVvtb6cCINrITclyPw=;
        b=qHFzEPvhJvMYu2AjOLNk3u/vxwtM0btq0Q/ya3qI1EX7/S1TH0U1B8r+OxGeCUShkV
         sJi8cIME5gj3ZrARG4OVG2bqZCsv0elmKjwTjatcc05vf9j06I9pSEL6FfNzPivw96S2
         wdcY+X67pgb5DjPNNHiWoUCVKEldBgLJ7WRNMuMDSaLBwcv0wUKGA9CluAkQVbdbs5Fi
         QWVN2ArvG7AAWHgBIm9K3y1MbomvvAO1mOH5+xwW/6nT3Ikxf5mBSiOrE9MhTZ5hKzH3
         ySKo2YAh5KGC5gq90nGSggBnk60hA6YfaftgiWD3gsX4zeMgv4OahGCd+ArcOruKhKNR
         zCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xIlshMkPEILCFE+m5bQ4z4FtXIVvtb6cCINrITclyPw=;
        b=ClDq/6LjCRJeamIX+jUZC9pAssmD3tOGCAiQjmK8Nfga4L4N55vq9bBQQP+GVLtMfZ
         6IGd8bjEZdo2ztRTX5dlv8fpmLvMcBv2FjXmuQa1fQEavqg7hwqW2WyT3eRTfTOVbhQG
         JYkBHtjhBMBYP4PQ+As6bMBJFwyiwUNO4Tb9TemUhu4t4eb2B6RR+jWRxWM9V1RGz8Hk
         7jUxONlckY9L9ki+Ribngor9BPETHKoF1nUY7CEReCXpwibraC4jCwtwwclE/TR8NSmq
         t0PuF8C1HZT7u9a83xxQLr9mRqDe/7Ez2vRq14UB+YLWRhlKGenXBixd3gV8XTLjTVgm
         PGpA==
X-Gm-Message-State: APf1xPCGxwgtDgN/MiK2Ehdyq+TH2UGZuUBQse2W4JQPAvk2w5M4xBSk
        S+NdZO8qIhBoPrVjHjsK3QmyI2KrU4Z2gz0YjEWWZ5dJW9XKUiyiK2b6k3zXw54RqHeanlhfSaI
        7k9RyKSD2Gy3A8PQWzlBakYlR09WHK+EF6zOdzAoiriharsqXSK4zlugwyQ==
X-Google-Smtp-Source: AH8x225ucuKa+Uy0ygIKZ6ZU4Z4guy1F13Xqjjjhc7a3usG/GD2ZvUHXGtkg33XDtVJXjn8Ho550DiP32jk=
MIME-Version: 1.0
X-Received: by 10.200.33.162 with SMTP id 31mr28864qty.27.1518634922971; Wed,
 14 Feb 2018 11:02:02 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:52 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-31-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 30/37] init-db: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.1.291.g4437f3f132-goog

