Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAEF1F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdCAL10 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:27:26 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33181 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdCAL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:27:17 -0500
Received: by mail-pg0-f66.google.com with SMTP id x17so5566551pgi.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 03:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6qix+EPQunqzSuTI3TuxNF+tPMw/Ln1mv1t5obgL1I=;
        b=RXgMDjAfkNH6tpLVljN2XVzBihje2hmHaJPH1r2eB2kiyAkm7FyK3REqBETXRmHQo+
         v+tZumqs4GXyeAqWjr0lrar8bkTTd2jz7u/i5yiuGBc0RbFlzul89uA7dxPGM5F7I4a6
         sbG19cqTn+gjF9X5YBuPHtw1EMt2xEWn6WNUgz+NpfWQFqT4Xo+HIjDzrGZUv8rFBVqc
         jhmAwmoQCxQjwORcusv3YnCxwMdlQL9BN6Vq0IzhZ+MlU4nu21VhMj+Wq1M8bFdmZzWc
         D2oe1KHzSYSQyoBbFOHYI32RjZNhfo3qw4qIsivNVjmeFb8T4JqnWfnrLUET5WKkBnL4
         3CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6qix+EPQunqzSuTI3TuxNF+tPMw/Ln1mv1t5obgL1I=;
        b=oIVVwq47Uzou/nnx9SvNm2dD78/bm63BdCKOGaDODkJXyW4a8dV+pplp0pR2CFa7sB
         LicsSBkD4zlEJyONVeu2ivfrDqXH1gL2v5srzn6YIjfhCAt0YlIpj9zz+gzBNJj5Ckll
         wudro5OKxoQ/vbb6PpCOXsgXkCGY1QVRbut2bNi9CppVxwd75sYr8zmOvDaMz+JzftmQ
         1W9RuU7qqz04ug8lfRDd1DEAoR88TmqQaJ498zMnO6VIoTxpke4GNIlBlkE1cIRNHqos
         Pz7l8CUo7n+uwwJQtZlbxou2X7n6mcD0EVhztBlO858pa/G+3q9IjuosEsxBv1v6RekV
         A8vQ==
X-Gm-Message-State: AMke39lLW7FjVu66aCdxwxp25HEO1+smf3T//riSKgEWGFxsHOswZBGBoCWmq66GOaDHyQ==
X-Received: by 10.98.193.69 with SMTP id i66mr8091712pfg.35.1488367622765;
        Wed, 01 Mar 2017 03:27:02 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id c2sm10020621pfl.61.2017.03.01.03.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 03:27:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:26:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 3/3] config: add conditional include
Date:   Wed,  1 Mar 2017 18:26:31 +0700
Message-Id: <20170301112631.16497-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170301112631.16497-1-pclouds@gmail.com>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes a set of repositories want to share configuration settings
among themselves that are distinct from other such sets of repositories.
A user may work on two projects, each of which have multiple
repositories, and use one user.email for one project while using another
for the other.

Setting $GIT_DIR/.config works, but if the penalty of forgetting to
update $GIT_DIR/.config is high (especially when you end up cloning
often), it may not be the best way to go. Having the settings in
~/.gitconfig, which would work for just one set of repositories, would
not well in such a situation. Having separate ${HOME}s may add more
problems than it solves.

Extend the include.path mechanism that lets a config file include
another config file, so that the inclusion can be done only when some
conditions hold. Then ~/.gitconfig can say "include config-project-A
only when working on project-A" for each project A the user works on.

In this patch, the only supported grouping is based on $GIT_DIR (in
absolute path), so you would need to group repositories by directory, or
something like that to take advantage of it.

We already have include.path for unconditional includes. This patch goes
with includeIf.<condition>.path to make it clearer that a condition is
required. The new config has the same backward compatibility approach as
include.path: older git versions that don't understand includeIf will
simply ignore them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt  | 64 +++++++++++++++++++++++++++++++++
 config.c                  | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1fad746efd..2a41e84bab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -90,6 +90,59 @@ found at the location of the include directive. If the value of the
 be relative to the configuration file in which the include directive
 was found.  See below for examples.
 
+Conditional includes
+~~~~~~~~~~~~~~~~~~~~
+
+You can include a config file from another conditionally by setting a
+`includeIf.<condition>.path` variable to the name of the file to be
+included. The variable's value is treated the same way as
+`include.path`. `includeIf.<condition>path` supports multiple key
+values.
+
+The condition starts with a keyword followed by a colon and some data
+whose format and meaning depends on the keyword. Supported keywords
+are:
+
+`gitdir`::
+
+	The data that follows the keyword `gitdir:` is used as a glob
+	pattern. If the location of the .git directory matches the
+	pattern, the include condition is met.
++
+The .git location may be auto-discovered, or come from `$GIT_DIR`
+environment variable. If the repository is auto discovered via a .git
+file (e.g. from submodules, or a linked worktree), the .git location
+would be the final location where the .git directory is, not where the
+.git file is.
++
+The pattern can contain standard globbing wildcards and two additional
+ones, `**/` and `/**`, that can match multiple path components. Please
+refer to linkgit:gitignore[5] for details. For convenience:
+
+ * If the pattern starts with `~/`, `~` will be substituted with the
+   content of the environment variable `HOME`.
+
+ * If the pattern starts with `./`, it is replaced with the directory
+   containing the current config file.
+
+ * If the pattern does not start with either `~/`, `./` or `/`, `**/`
+   will be automatically prepended. For example, the pattern `foo/bar`
+   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
+
+ * If the pattern ends with `/`, `**` will be automatically added. For
+   example, the pattern `foo/` becomes `foo/**`. In other words, it
+   matches "foo" and everything inside, recursively.
+
+`gitdir/i`::
+	This is the same as `gitdir` except that matching is done
+	case-insensitively (e.g. on case-insensitive file sytems)
+
+A few more notes on matching via `gitdir` and `gitdir/i`:
+
+ * Symlinks in `$GIT_DIR` are not resolved before matching.
+
+ * Note that "../" is not special and will match literally, which is
+   unlikely what you want.
 
 Example
 ~~~~~~~
@@ -118,6 +171,17 @@ Example
 		path = foo ; expand "foo" relative to the current file
 		path = ~/foo ; expand "foo" in your `$HOME` directory
 
+	; include if $GIT_DIR is /path/to/foo/.git
+	[includeIf "gitdir:/path/to/foo/.git"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside /path/to/group
+	[includeIf "gitdir:/path/to/group/"]
+		path = /path/to/foo.inc
+
+	; include for all repositories inside $HOME/to/group
+	[includeIf "gitdir:~/to/group/"]
+		path = /path/to/foo.inc
 
 Values
 ~~~~~~
diff --git a/config.c b/config.c
index c6b874a7bf..0dac0f4cb2 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -170,9 +171,94 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	return ret;
 }
 
+static int prepare_include_condition_pattern(struct strbuf *pat)
+{
+	struct strbuf path = STRBUF_INIT;
+	char *expanded;
+	int prefix = 0;
+
+	expanded = expand_user_path(pat->buf);
+	if (expanded) {
+		strbuf_reset(pat);
+		strbuf_addstr(pat, expanded);
+		free(expanded);
+	}
+
+	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
+		const char *slash;
+
+		if (!cf || !cf->path)
+			return error(_("relative config include "
+				       "conditionals must come from files"));
+
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
+static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
+{
+	struct strbuf text = STRBUF_INIT;
+	struct strbuf pattern = STRBUF_INIT;
+	int ret = 0, prefix;
+
+	strbuf_add_absolute_path(&text, get_git_dir());
+	strbuf_add(&pattern, cond, cond_len);
+	prefix = prepare_include_condition_pattern(&pattern);
+
+	if (prefix < 0)
+		goto done;
+
+	if (prefix > 0) {
+		/*
+		 * perform literal matching on the prefix part so that
+		 * any wildcard character in it can't create side effects.
+		 */
+		if (text.len < prefix)
+			goto done;
+		if (!icase && strncmp(pattern.buf, text.buf, prefix))
+			goto done;
+		if (icase && strncasecmp(pattern.buf, text.buf, prefix))
+			goto done;
+	}
+
+	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
+			 icase ? WM_CASEFOLD : 0, NULL);
+
+done:
+	strbuf_release(&pattern);
+	strbuf_release(&text);
+	return ret;
+}
+
+static int include_condition_is_true(const char *cond, size_t cond_len)
+{
+
+	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
+		return include_by_gitdir(cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
+		return include_by_gitdir(cond, cond_len, 1);
+
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
@@ -185,6 +271,12 @@ int git_config_include(const char *var, const char *value, void *data)
 
 	if (!strcmp(var, "include.path"))
 		ret = handle_path_include(value, inc);
+
+	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
+	    (cond && include_condition_is_true(cond, cond_len)) &&
+	    !strcmp(key, "path"))
+		ret = handle_path_include(value, inc);
+
 	return ret;
 }
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 9ba2ba11c3..f0cd2056ba 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -152,6 +152,62 @@ test_expect_success 'relative includes from stdin line fail' '
 	test_must_fail git config --file - test.one
 '
 
+test_expect_success 'conditional include, both unanchored' '
+	git init foo &&
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir:foo/\"]path=bar" >>.git/config &&
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
+		echo "[includeIf \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
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
+		echo "[includeIf \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
+		echo "[test]three=3" >.git/bar3 &&
+		echo 3 >expect &&
+		git config test.three >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, relative path' '
+	echo "[includeIf \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
+	echo "[test]four=4" >bar4 &&
+	(
+		cd foo &&
+		echo 4 >expect &&
+		git config test.four >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional include, both unanchored, icase' '
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir/i:FOO/\"]path=bar5" >>.git/config &&
+		echo "[test]five=5" >.git/bar5 &&
+		echo 5 >expect &&
+		git config test.five >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.11.0.157.gd943d85

