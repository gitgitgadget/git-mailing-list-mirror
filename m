Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88972018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcF1RlP (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:41:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35257 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcF1RlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:41:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id w130so2500830lfd.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:40:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WH447jlhgdAi5MgnuBQt4C595VBkJztH/SjJGnVVRM=;
        b=B2+MYr1lDNkeC1pJbYUPGsHs08pYA8HCG6gjc1mzXfwP+jT3UwbgUFvz+pQTHCwH37
         iXOYa53YFYzhTcymhdz4Ad4TcC82opYW02W08LWfVEcspAHFyVWQfNHXar7dPS6NMWVp
         ZsHI9/hMnOB4byfuZ74f28X0dadCzhEUkTtMTZ2kD/O/NABn9v/lSgViunwkoooeZ8y7
         eXF5l/senzq5KCvYLth7k2Slk0YkrBb/yA/MUgldDQlOLvrhzQlB0Qpc7lEcZQaVgjI2
         bNdIKref0x3XNwjj/Vq6XXNm5rK/f5WwhzII64RWMwgRjVkpZjEQh0PXjt/QF6TeAgkw
         xbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WH447jlhgdAi5MgnuBQt4C595VBkJztH/SjJGnVVRM=;
        b=NWV1nUV+VoGm45VLbQSPUfQ3pcJULBlV2UYM58L9ngh1UpgyuDXTVVGjwQ4nhhxG8M
         Z8GzPf1tVaL7sotsNAY7/oMvhG8KqD70776xG1bfEKBtBtlPG9mgm5Oc4W+y+dFYJAgA
         mXBukKCF+HyjAsSoi1Ue31zIBsUijdLdojn/tJn9cnVR4Hf2HltUhhSLPjExB7bTyZA4
         SBAUsVmwR6Rv1m6skyfmCmz9aD0eapR9Re5Jzl2AR6rervKIhCg3nUJ/6kjp5iMZw0b+
         gVg1PsfL4BG1qoOs8f7GAyViIr6g+powPX6dPJ6OUJsb5sLEyDiM4Qynx5p3BPqNNAGz
         YKIg==
X-Gm-Message-State: ALyK8tKaB7qpGsrvkaP63Bn8dKMFif2CbTw+rxORmar1HSUH8e8Gi1Do1BVPOjLnAgywWg==
X-Received: by 10.25.86.79 with SMTP id k76mr1411379lfb.135.1467134812238;
        Tue, 28 Jun 2016 10:26:52 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 73sm4409435ljf.8.2016.06.28.10.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 10:26:51 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sschuberth@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] config: add conditional include
Date:	Tue, 28 Jun 2016 19:26:41 +0200
Message-Id: <20160628172641.26381-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160628172641.26381-1-pclouds@gmail.com>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160628172641.26381-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Main description is already in config.txt. Here is a dev-only note
about Windows support.

While prepare_include_condition_pattern() is Windows-friendly (because
it does not hard code '/'). The reality could be uglier because
internally get_git_dir() may return a path with '/' only or worse, a
mix of '/' and '\\'.

At some point, we need to teach wildmatch() that '/' and '\' should be
treated the same way (via a flag) as well. Then we could care less
about '/' vs '\\'. But a Windows dev probably has to do it.

Helped-by: Jeff King <peff@peff.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt  | 40 +++++++++++++++++++++
 config.c                  | 89 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t1305-config-include.sh | 45 ++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58673cf..c8ad0bf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,46 @@ found at the location of the include directive. If the value of the
 relative to the configuration file in which the include directive was
 found.  See below for examples.
 
+Included files can be grouped into subsections where subsectino name
+is the condition when the files are included. The condition starts
+with an condition type string, followed by a colon and a pattern.
+
+Only "gitdir" type is supported, where files are included if
+`$GIT_DIR` matches the specified pattern. For example,
+
+
+	[include "gitdir:/path/to/foo.git"]
+		path = /path/to/foo.inc
+
+would only include "/path/to/foo.inc" if `$GIT_DIR` is
+/path/to/foo.git.
+
+The following pattern is a wildcard pattern with two additional
+wildcards `**/` and `/**`. See linkgit:gitignore[5] for more
+information. For convenience:
+
+ * If the pattern ends with '/', '**' will be automatically added. For
+   example, the pattern 'foo/' becomes 'foo/**'. In other words, it
+   matches "foo" and everything inside, recursively.
+
+ * If the pattern starts with `~/`, `~` will be substitued with the
+   environment variable `HOME`.
+
+ * If the pattern starts with `./`, it is replaced with the directory
+   where the current config file is. For example if the config file
+   that contains the "include" subsection is `$HOME/.gitconfig` then
+   the pattern `./foo` would match the path `$HOME/foo`
+
+A few more notes:
+
+ * Symlinks in `$GIT_DIR` are not resolved before matching.
+
+ * Note that "../" is not special and will match literally, which is
+   unlikely what you want.
+
+ * On case-insensitive file systems, you may need to specify
+   core.ignoreCase before the `include` subsections in order to match
+   case-insensitively if core.ignoreCase is declared in the same file.
 
 Example
 ~~~~~~~
diff --git a/config.c b/config.c
index f51c56b..97c450e 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -140,9 +141,89 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int prepare_include_condition_pattern(struct strbuf *pat)
+{
+	struct strbuf path = STRBUF_INIT;
+	int prefix = 0;
+
+	/* TODO: maybe support ~user/ too */
+	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
+		const char *home = getenv("HOME");
+
+		if (!home)
+			return error(_("$HOME is not defined"));
+
+		strbuf_add_absolute_path(&path, home);
+		strbuf_splice(pat, 0, 1, path.buf, path.len);
+		prefix = path.len + 1 /*slash*/;
+	} else if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
+		const char *slash;
+
+		if (!cf || !cf->path)
+			return error(_("relative config include "
+				       "conditionals must come from files"));
+
+		/* TODO: escape wildcards */
+		strbuf_add_absolute_path(&path, cf->path);
+		slash = find_last_dir_sep(path.buf);
+		if (!slash)
+			die("BUG: how is this possible?");
+		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
+		prefix = slash - path.buf + 1 /* slash */;
+	} else if (!is_absolute_path(pat->buf))
+		strbuf_insert(pat, 0, "**/", 3);
+
+	if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
+		strbuf_addstr(pat, "**");
+
+	strbuf_release(&path);
+	return prefix;
+}
+
+static int include_condition_is_true(const char *cond, int cond_len)
+{
+	const char *value;
+	size_t value_len;
+
+	/* no condition (i.e., "include.path") is always true */
+	if (!cond)
+		return 1;
+
+	if (skip_prefix_mem(cond, cond_len, "gitdir:", &value, &value_len)) {
+		struct strbuf text = STRBUF_INIT;
+		struct strbuf pattern = STRBUF_INIT;
+		int ret, prefix;
+
+		strbuf_add_absolute_path(&text, get_git_dir());
+		strbuf_add(&pattern, value, value_len);
+		prefix = prepare_include_condition_pattern(&pattern);
+
+		if (prefix < 0)
+			return 0;
+
+		if (prefix > 0 &&
+		    (text.len < prefix ||
+		     fspathncmp(pattern.buf, text.buf, prefix)))
+			return 0;
+
+		ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
+				 ignore_case ? WM_CASEFOLD : 0,
+				 NULL);
+		strbuf_release(&pattern);
+		strbuf_release(&text);
+		return ret;
+	}
+
+	error(_("unrecognized include condition: %.*s"), cond_len, cond);
+	/* unknown conditionals are always false */
+	return 0;
+}
+
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	const char *cond, *key;
+	int cond_len;
 	int ret;
 
 	/*
@@ -153,8 +234,12 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
+	    include_condition_is_true(cond, cond_len)) {
+		if (!strcmp(key, "path"))
+			ret = handle_path_include(value, inc);
+		/* else we do not know about this type of include; ignore */
+	}
 	return ret;
 }
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 9ba2ba1..30351f2 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -152,6 +152,51 @@ test_expect_success 'relative includes from stdin line fail' '
 	test_must_fail git config --file - test.one
 '
 
+test_expect_success 'conditional include, both unanchored' '
+	git init foo &&
+	(
+		cd foo &&
+		echo "[include \"gitdir:foo/\"]path=bar" >>.git/config &&
+		echo "[test]one=1" >.git/bar &&
+		echo 1 >expect &&
+		git config test.one >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, $HOME expansion' '
+	(
+		cd foo &&
+		echo "[include \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
+		echo "[test]two=2" >.git/bar2 &&
+		echo 2 >expect &&
+		git config test.two >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, full pattern' '
+	(
+		cd foo &&
+		echo "[include \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
+		echo "[test]three=3" >.git/bar3 &&
+		echo 3 >expect &&
+		git config test.three >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, relative path' '
+	echo "[include \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
+	echo "[test]four=4" >bar4 &&
+	(
+		cd foo &&
+		echo 4 >expect &&
+		git config test.four >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.8.2.531.gd073806

