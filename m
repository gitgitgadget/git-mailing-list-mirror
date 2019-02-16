Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111481F453
	for <e@80x24.org>; Sat, 16 Feb 2019 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfBPLtv (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:49:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44459 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPLtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:49:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so1262191pls.11
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/BU2hl9Py5v/nvd2sBwIve8cXQshmVkdmMk3y5KnYE=;
        b=EyxAWXFMiMNI5BIU77cXm5ztYMT1AlRTJThhI5k+NBgKLgXmCEyoJk6qfpJ96AGykW
         sxpmNTTU8RL+KwJ3r3fc5kLaU/mJ7QhgiMRIUiuXTrLTlrxlsCfEMSbeDGJOEEIttBLn
         KEDheoup0Z4xocrkxdRT4fyX8USueXm/WJ9gt1Pq6VC9+2iKcMsY2MMWlmLybGfzcRzZ
         YSCakDU4azbTpQ5J4p84ILCv/ssAEmhFMbjoJENrY/bk0OzRp3Hn+vxtzRHMUj5ZJwMe
         1eIwZw/N/kmJzfzrubDoMdlUkhrGgB35IbkYdzED5ZoeW8bHpq4whWZz0uGlBi1JeRQG
         V/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/BU2hl9Py5v/nvd2sBwIve8cXQshmVkdmMk3y5KnYE=;
        b=KtQecfDABGQnj2/gg/B9adPU+ZGWA7dUu/8TJR54ZpeprgrXSF8k2PJEcClWWGbz2Y
         3Tc77zzK7ZBj4wPab63y89Otzwi0mzUR5Dk3uuQu3XdVueeQ9GbtHYE7Bz9YVt1nQYiO
         kMiigCQxyPF71RL31z9VoubPrOlOCtvOz6a/GhZN4wt+06tJoVoHL2X/lbaED6CA9DTg
         0vf+hEeRwgMYEm68t4j0NMij+7yL6ddstVQbLQdTSZ9bcYeIBjrak73XQAdFHXIXnGB+
         EWA/+mghmuxtIyUKavASktq1ocVZcHy53YkIoNqzSpB6BK9O8+WPJy9Ttnhh7GHQMUQi
         02aw==
X-Gm-Message-State: AHQUAuYn+3fOfo2B1/iXeJxK12ju5r2ejTK1SYqi/dAh4VUdW+5f7Ui5
        CUrHhjcYO3sERjHahdzqWsTCULNb
X-Google-Smtp-Source: AHgI3IbZjipSpm9kU/j7XtzhsbckVjCN/SpgiSa0KcnXh04HxI7rs86Y1orpRN4oN93oWimLZNX8Kw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr5855163plo.30.1550317790214;
        Sat, 16 Feb 2019 03:49:50 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a15sm12092362pgd.4.2019.02.16.03.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:49:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:49:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/1] Introduce "precious" file concept
Date:   Sat, 16 Feb 2019 18:49:38 +0700
Message-Id: <20190216114938.18843-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216114938.18843-1-pclouds@gmail.com>
References: <20190216114938.18843-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new attribute "precious" is added to indicate that certain files
have valuable content and should not be easily discarded even if they
are ignored or untracked.

So far there are one part of Git that are made aware of precious
files: "git clean" will leave precious files alone.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-clean.txt     |  3 ++-
 Documentation/gitattributes.txt | 11 +++++++++++
 Documentation/gitignore.txt     |  4 ++++
 attr.c                          | 12 ++++++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 20 +++++++++++++++++---
 t/t7300-clean.sh                | 29 +++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..a9beadfb12 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -21,7 +21,8 @@ option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
 If any optional `<path>...` arguments are given, only those paths
-are affected.
+are affected. Ignored or untracked files with `precious` attributes
+are not removed.
 
 OPTIONS
 -------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 9b41f81c06..1f2e830241 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1192,6 +1192,17 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Precious files
+~~~~~~~~~~~~~~
+
+`precious`
+^^^^^^^^^^
+
+This attribute is set on files to indicate that their content is
+valuable. Some commands will behave slightly different on precious
+files. linkgit:git-clean[1] will leave precious files alone.
+
+
 USING MACRO ATTRIBUTES
 ----------------------
 
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 1c94f08ff4..0e9614289e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -141,6 +141,10 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
+Ignored files are generally considered discardable. See `precious`
+attribute in linkgit:gitattributes[5] to change the behavior regarding
+ignored files.
+
 EXAMPLES
 --------
 
diff --git a/attr.c b/attr.c
index fdd110bec5..6349410e14 100644
--- a/attr.c
+++ b/attr.c
@@ -1157,3 +1157,15 @@ void attr_start(void)
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
 	pthread_mutex_init(&check_vector.mutex, NULL);
 }
+
+int is_precious_file(struct index_state *istate, const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("precious", NULL);
+	if (!check)
+		return 0;
+
+	git_check_attr(istate, path, check);
+	return ATTR_TRUE(check->items[0].value);
+}
diff --git a/attr.h b/attr.h
index b0378bfe5f..b9a9751a66 100644
--- a/attr.h
+++ b/attr.h
@@ -82,4 +82,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
+int is_precious_file(struct index_state *istate, const char *path);
+
 #endif /* ATTR_H */
diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..47ec5e58cf 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -18,6 +18,7 @@
 #include "color.h"
 #include "pathspec.h"
 #include "help.h"
+#include "attr.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -31,6 +32,8 @@ static const char *const builtin_clean_usage[] = {
 
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
+static const char *msg_skip_precious = N_("Skipping precious file %s\n");
+static const char *msg_would_skip_precious = N_("Would skip precious file %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
@@ -154,6 +157,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
+	const char *rel_path;
 
 	*dir_gone = 1;
 
@@ -193,9 +197,16 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
+		if (lstat(path->buf, &st)) {
 			; /* fall thru */
-		else if (S_ISDIR(st.st_mode)) {
+		} else if ((!prefix && is_precious_file(&the_index, path->buf)) ||
+			   (prefix && skip_prefix(path->buf, prefix, &rel_path) &&
+			    is_precious_file(&the_index, rel_path))) {
+			quote_path_relative(path->buf, prefix, &quoted);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), quoted.buf);
+			*dir_gone = 0;
+			continue;
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
@@ -1019,7 +1030,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (lstat(abs_path.buf, &st))
 			continue;
 
-		if (S_ISDIR(st.st_mode)) {
+		if (is_precious_file(&the_index, item->string)) {
+			qname = quote_path_relative(item->string, NULL, &buf);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), qname);
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..a478a08a27 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,33 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_success 'git clean -xd leaves precious files alone' '
+	git init precious &&
+	(
+		cd precious &&
+		test_commit one &&
+		cat >.gitignore <<-\EOF &&
+		*.o
+		*.mak
+		EOF
+		cat >.gitattributes <<-\EOF &&
+		*.mak precious
+		.gitattributes precious
+		*.precious precious
+		EOF
+		mkdir sub &&
+		touch one.o sub/two.o one.mak sub/two.mak &&
+		touch one.untracked two.precious sub/also.precious &&
+		git clean -fdx &&
+		test_path_is_missing one.o &&
+		test_path_is_missing sub/two.o &&
+		test_path_is_missing one.untracked &&
+		test_path_is_file .gitattributes &&
+		test_path_is_file one.mak &&
+		test_path_is_file sub/two.mak &&
+		test_path_is_file two.precious &&
+		test_path_is_file sub/also.precious
+	)
+'
+
 test_done
-- 
2.21.0.rc0.328.g0e39304f8d

