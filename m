Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831721F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeK0Gd3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:33:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42768 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0Gd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:33:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so14504614lfh.9
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlEXcvs3UeEI6o+iVLrV0RLABTyahlN1Hbc01ySYVLI=;
        b=R7F57mZJ6bjiYAJXItvMjZLSVJd0ni9XHC8tkENHmJ+8xFdOYZ+1GmQNzi8coa+r1v
         sBR/cYK9SBqPpt++xXZ8XFjp87wu2Ncm22CHh4rTaZHuScVR1E8T1a9/CNsm/U7Y6Pvm
         k0arx5au00W8uv/KuhaUfhvzVUNUt4Er4ijmiD3RhdzRuIHr6donBYHp5V02HQTEKQEF
         Azsg929ciMZzWy6PaKLz2EC9Asucidu4Nvxkbtq7DyUbywbIE4VqVJGHO4t3NqrmbeWx
         Opxff2Ee/CKmNxsMsPW1kMPjXq9Axj/RZjyazRN2OoBBSo4aB3qc8lQLZ+4Hko9GiGX+
         W4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlEXcvs3UeEI6o+iVLrV0RLABTyahlN1Hbc01ySYVLI=;
        b=Nducsf1GMmFdtGRnPOJCV3v2tHewLWt4d1dM23TWmk/Mzddq3SWL0y24q52aXJ905B
         PRPBlxVcFnbWVE45Zcccd71biEZljm8HVAEzWxNwHyjDmj9w8kGBxE9CC8lmIRXK17jM
         n4tlxR55mWUOY3RovnsPynRh5fpnlrKiKmVpaycty0I4dE6rc2CRAH4HNEPKzhTwt1nV
         VH41Xo1yS+8Mzsu7Fuam1zHIhFqgnW4CP9YcoK9HASa8uIdNUvRY65NoF8XVR4lug2Ln
         uFbXAt6Tiznnda6jUXpMUzcU+at83YBiaJZPzM52LCTFSHGG/Z4vjF4WjLtM+8w9g80B
         NVFg==
X-Gm-Message-State: AGRZ1gK0X8zEUoCpu415cYWV+b46KWopPLrmwzDNB227gnyEMsSRILGh
        8GaUWdMAqYGXgcGmyZJU9GE=
X-Google-Smtp-Source: AJdET5ehrjolsYtCnI4viIDmAefhnwFxnkJqhsVnYppncbrooVfBQ0QtrIPMy+btV8HqoRWun6v0rQ==
X-Received: by 2002:a19:641d:: with SMTP id y29mr16692217lfb.14.1543261097743;
        Mon, 26 Nov 2018 11:38:17 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p91sm202564lfg.4.2018.11.26.11.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:38:16 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        drizzd@gmx.net, git@matthieu-moy.fr, hellmuth@ira.uka.de,
        jjensen@workspacewhiz.com, jost@tcs.ifi.lmu.de, kevin@sb.org,
        per.lundberg@hibox.tv, sandals@crustytoothpaste.net,
        eckhard.s.maass@googlemail.com
Subject: [PATCH v2 1/2] Introduce "precious" file concept
Date:   Mon, 26 Nov 2018 20:38:03 +0100
Message-Id: <20181126193804.30741-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181126193804.30741-1-pclouds@gmail.com>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <20181126193804.30741-1-pclouds@gmail.com>
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

So far there are two parts of Git that are made aware of precious
files: "git clean" will leave precious files alone and unpack-trees.c
(i.e. merges and branch switches) will not overwrite
ignored-but-precious files.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-clean.txt     |  3 ++-
 Documentation/gitattributes.txt | 13 +++++++++++++
 Documentation/gitignore.txt     |  4 ++++
 attr.c                          | 12 ++++++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 20 +++++++++++++++++---
 t/t1004-read-tree-m-u-wf.sh     |  6 ++++++
 t/t7300-clean.sh                | 29 +++++++++++++++++++++++++++++
 unpack-trees.c                  |  1 +
 9 files changed, 86 insertions(+), 4 deletions(-)

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
index b8392fc330..b027abea4a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1188,6 +1188,19 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Precious files
+~~~~~~~~~~~~~~
+
+`precious`
+^^^^^^^^^^
+
+This attribute is set on files to indicate that their content is
+valuable. Many commands will behave slightly different on precious
+files. linkgit:git-clean[1] will leave precious files alone. Merging
+and branch switching will not silently overwrite ignored files that
+are marked "precious".
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
index eaece6658d..b07d8cd835 100644
--- a/attr.c
+++ b/attr.c
@@ -1172,3 +1172,15 @@ void attr_start(void)
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
index bbcdeb2d9e..42cd040849 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -17,6 +17,7 @@
 #include "color.h"
 #include "pathspec.h"
 #include "help.h"
+#include "attr.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -30,6 +31,8 @@ static const char *const builtin_clean_usage[] = {
 
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
+static const char *msg_skip_precious = N_("Skipping precious file %s\n");
+static const char *msg_would_skip_precious = N_("Would skip precious file %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
@@ -153,6 +156,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
+	const char *rel_path;
 
 	*dir_gone = 1;
 
@@ -192,9 +196,16 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
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
@@ -1018,7 +1029,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c13578a635..17dc626f62 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -63,6 +63,12 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '
 	fi
 '
 
+test_expect_success 'two-way not clobbering a precious ignored file' '
+	test_when_finished rm -f .git/info/attributes &&
+	echo "file2 precious" >.git/info/attributes &&
+	read_tree_u_must_fail -m -u --exclude-per-directory=.gitignore master side
+'
+
 test_expect_success 'two-way clobbering a ignored file' '
 
 	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore master side
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
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..9a5aadc084 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1895,6 +1895,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
+	    !is_precious_file(o->src_index, name) &&
 	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
-- 
2.19.1.1327.g328c130451.dirty

