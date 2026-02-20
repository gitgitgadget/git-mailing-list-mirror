Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F12857EE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567492; cv=none; b=HIUbmCY/XsFTfrJTQNxReYJY15hBYoEbL3xqTzijbYoqUXuibsC4PPC/AiFvAgK9Xdqs7aNefwx1lEhs+vvpgy3xDHErB+gEVDejDW8nylNqAXmwMqTZrX/sGnbSWdA3EEFWX1JrXsbJMALoqSxvseNMf85dxWg/xZO2m5P7sEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567492; c=relaxed/simple;
	bh=NaD0PgMCMCIaVOuD+m7kPXDIAzlkdBwy4UQlIQWKpeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7k76ARgm4EvDGDnG3kxKsBmJRUOsUh4o8f96AjeanUtY41AcAGAU7G88r7CUIl0bg4DJeO2KA8zidqgZBhd9ld649Hj0hBsrHbFV08Yo/tcyjOAwIwq6BfbJ8rgQ12tHcbYV6tncq0V9Yq+vjn0pfVDBs5osv0d59EF4R3ktW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxg7qy+3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxg7qy+3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so10069575e9.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771567489; x=1772172289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+k0HobF1yZ50x8UTsetmXXIl5gun6HWySCj1pPyCws=;
        b=kxg7qy+3m79c1XEg+8qZR3Ngq5gG65pDK7L++wSsUK2moZrPjay4HG62n6VJJ0Zg9L
         /oJzhB71q/Ub3k6oipNyxGGQRGpvzPfTHYwqARDoOovXFWJRlp1G3wjGNup+apNOzHF8
         7hd0WiC1b32fJpZUQUo3EvqvaeoRInWKSVDzHxuVBk76FmuofcRiBUK7NfVHd8Bo3oKz
         kJK2/s6mr6PD0MnSGJ1xiEjjxhtsRWG0OfVsXyxDzdpbIZ+HeZfiSW6BGQN2rgYLBi0n
         gancUgjhOeqBQcAgbsuP49dGlsIdbUnGklIKuptA4I5rm0F6ji0WkGyQxMXEBoxreOuY
         WOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771567489; x=1772172289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+k0HobF1yZ50x8UTsetmXXIl5gun6HWySCj1pPyCws=;
        b=iA4PDQR4JdpjtzzArb6hX77vPYQbK/YP0E3XZP0m5oWeMVlJXNOKNOhFNh0iRbS2yk
         WNnjdxbFvr2Mts1G2WHLs9zRVUMCPhj2/qC3a5G5aHwWOvKXwS9CfAqyE+9pouyqT1Dm
         xKeK+XnLZyhj6kRy0uyhurIyif9a+jmaodq6LX3hqlBqwnZ6ZLAE1nIQQ+6H3xVFNV6a
         PX0wThv5GDAbX5ZRXT8GdyM8EolJjCvO3+C7mn+j4IhJdCQ6HnfDCA2aNFU3JPsdD7st
         ifr4eO7JmezFvDZqdwg8JNFJYeiLpZ6ivAYAHfCoBlEn0AtIki7LNs31f3vWlWcQ40fP
         z5cw==
X-Gm-Message-State: AOJu0YxEBVIGFA+lTQ6szbwRUKFQ6NvhAtqAi9Q5mpb2lppayisYRC+R
	czrayE1d2WZQkUXipa1PSHwyOqY2Dts47bC1VyTxe0bHTZR4G7B56pMUI9ZYew==
X-Gm-Gg: AZuq6aJFr/2xLO2gZdiCLnLd0IIiGg/76vLFhgfcvEMdXuwOmwy5Hl2pBA1XOxt+3YC
	S8YaNpCqN1zg4NGq8nlCEgVWPymwjbMa5yPkdwlXhVculPJRCsSI2x3+wMOFP55hAeVaQi+SgJE
	l5mH+ULoZ9w3Vq/oLopjNCXZiluQ5KkxkhAebtJAyL+b7piUacPJGzOO7silRfp2QDhCFVGBr0Q
	rl+uPPg8bEtTsnpBX8bDbpNUT3Fes+4ABzd9QRfHSys1KWHpEQXWfk6S5znlFriPSVN9xz8gCDu
	Rgz+uZJA8j/f/V6q6iK5LQMHw6MCPaVdAQ2X6HhuIONgxToS+lRfH+uvNRYmqkd/Sdufxu1s1oj
	dBJVxg8GUtv9Xe2iMxiOV1yUGPNoiLe68L3Bzw+0s8CHEES3iVomdsFfe4DLe5gRuauHSxWX92r
	jeQiISuizIHxxyDWoIDyaUomwUwEdha3xjJQ==
X-Received: by 2002:a05:600c:8708:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-48379bd7313mr334363815e9.22.1771567488756;
        Thu, 19 Feb 2026 22:04:48 -0800 (PST)
Received: from fedora.marun.edu.tr ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm43477255e9.5.2026.02.19.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 22:04:48 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH v2 1/2] mailmap: stop using the_repository
Date: Fri, 20 Feb 2026 09:04:41 +0300
Message-ID: <20260220060442.29469-2-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220060442.29469-1-bkkaracay@gmail.com>
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
 <20260220060442.29469-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'read_mailmap' and 'read_mailmap_blob' functions rely on the global
'the_repository' variable. Update both functions to accept a
'struct repository' parameter.

Update all callers to pass 'the_repository' to retain the current
behavior.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/blame.c         |  2 +-
 builtin/cat-file.c      |  2 +-
 builtin/check-mailmap.c |  4 ++--
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      |  2 +-
 mailmap.c               | 11 ++++++-----
 mailmap.h               |  6 ++++--
 pretty.c                |  2 +-
 ref-filter.c            |  2 +-
 10 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index eac2fe7320..f3a11eff44 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1252,7 +1252,7 @@ int cmd_blame(int argc,
 	sb.xdl_opts = xdl_opts;
 	sb.no_whole_file_rename = no_whole_file_rename;
 
-	read_mailmap(&mailmap);
+	read_mailmap(the_repository, &mailmap);
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df8e87a81f..d298e95797 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1105,7 +1105,7 @@ int cmd_cat_file(int argc,
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
 	if (use_mailmap)
-		read_mailmap(&mailmap);
+		read_mailmap(the_repository, &mailmap);
 
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 9cc5c59830..3f2a39cae0 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -63,9 +63,9 @@ int cmd_check_mailmap(int argc,
 	if (argc == 0 && !use_stdin)
 		die(_("no contacts specified"));
 
-	read_mailmap(&mailmap);
+	read_mailmap(the_repository, &mailmap);
 	if (mailmap_blob)
-		read_mailmap_blob(&mailmap, mailmap_blob);
+		read_mailmap_blob(the_repository, &mailmap, mailmap_blob);
 	if (mailmap_file)
 		read_mailmap_file(&mailmap, mailmap_file, 0);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532..3700f66ba9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1155,7 +1155,7 @@ static const char *find_author_by_nickname(const char *name)
 	setup_revisions(ac, av, &revs, NULL);
 	revs.mailmap = xmalloc(sizeof(struct string_list));
 	string_list_init_nodup(revs.mailmap);
-	read_mailmap(revs.mailmap);
+	read_mailmap(the_repository, revs.mailmap);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/builtin/log.c b/builtin/log.c
index 8ab6d3a943..ff0227e32d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -336,7 +336,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (mailmap) {
 		rev->mailmap = xmalloc(sizeof(struct string_list));
 		string_list_init_nodup(rev->mailmap);
-		read_mailmap(rev->mailmap);
+		read_mailmap(the_repository, rev->mailmap);
 	}
 
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d80bf1a7d0..6b2a0b93b5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -357,7 +357,7 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap);
+	read_mailmap(the_repository, &log->mailmap);
 
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
diff --git a/mailmap.c b/mailmap.c
index 37fd158a51..cf70956675 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -183,7 +183,8 @@ static void read_mailmap_string(struct string_list *map, char *buf)
 	}
 }
 
-int read_mailmap_blob(struct string_list *map, const char *name)
+int read_mailmap_blob(struct repository *repo, struct string_list *map,
+		      const char *name)
 {
 	struct object_id oid;
 	char *buf;
@@ -192,10 +193,10 @@ int read_mailmap_blob(struct string_list *map, const char *name)
 
 	if (!name)
 		return 0;
-	if (repo_get_oid(the_repository, name, &oid) < 0)
+	if (repo_get_oid(repo, name, &oid) < 0)
 		return 0;
 
-	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
+	buf = odb_read_object(repo->objects, &oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB) {
@@ -209,7 +210,7 @@ int read_mailmap_blob(struct string_list *map, const char *name)
 	return 0;
 }
 
-int read_mailmap(struct string_list *map)
+int read_mailmap(struct repository *repo, struct string_list *map)
 {
 	int err = 0;
 
@@ -224,7 +225,7 @@ int read_mailmap(struct string_list *map)
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
 	if (startup_info->have_repository)
-		err |= read_mailmap_blob(map, git_mailmap_blob);
+		err |= read_mailmap_blob(repo, map, git_mailmap_blob);
 	err |= read_mailmap_file(map, git_mailmap_file, 0);
 	return err;
 }
diff --git a/mailmap.h b/mailmap.h
index 908365e1bf..fda329d715 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,6 +1,7 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
+struct repository;
 struct string_list;
 
 extern char *git_mailmap_file;
@@ -11,9 +12,10 @@ extern char *git_mailmap_blob;
 
 int read_mailmap_file(struct string_list *map, const char *filename,
 		      unsigned flags);
-int read_mailmap_blob(struct string_list *map, const char *name);
+int read_mailmap_blob(struct repository *repo, struct string_list *map,
+		      const char *name);
 
-int read_mailmap(struct string_list *map);
+int read_mailmap(struct repository *repo, struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
 int map_user(struct string_list *map,
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..ebf4da4834 100644
--- a/pretty.c
+++ b/pretty.c
@@ -781,7 +781,7 @@ static int mailmap_name(const char **email, size_t *email_len,
 	static struct string_list *mail_map;
 	if (!mail_map) {
 		CALLOC_ARRAY(mail_map, 1);
-		read_mailmap(mail_map);
+		read_mailmap(the_repository, mail_map);
 	}
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
diff --git a/ref-filter.c b/ref-filter.c
index 3917c4ccd9..d7a23a7b61 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1753,7 +1753,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		    (starts_with(name + wholen, "email") &&
 		    (atom->u.email_option.option & EO_MAILMAP))) {
 			if (!mailmap.items)
-				read_mailmap(&mailmap);
+				read_mailmap(the_repository, &mailmap);
 			strbuf_addstr(&mailmap_buf, buf);
 			apply_mailmap_to_header(&mailmap_buf, headers, &mailmap);
 			wholine = find_wholine(who, wholen, mailmap_buf.buf);
-- 
2.52.0

