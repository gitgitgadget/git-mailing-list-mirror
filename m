Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF21E5B91
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983032; cv=none; b=A2eJ962W4NOOayS3+TkiJbKQF1rC28k9rrV8ZQt3hlbqBDwCkmt9VY0uIqF9GKQCzPxdYlrxXtICZXRK3V0utrE3LzsXXH3O6OBKFy5ZOJXCHA3fpj45nKdkQ75OBz5p7O9c3Bg1k+XDSL9gnuGzbGGZi47SmsXSgyhrUURZ3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983032; c=relaxed/simple;
	bh=QSUYjXdTURscnvVrUb1Ebwq7jbpZDb9k8r8YQ4e9nu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbd0lgQFcKts4iow/HpeStqwmrpisB5YjN7eNNpf6IeD/2Mtwkjfk2ZcCXGitJGz84jjPin/42Mr6Xwm1OHC/54wK1n81fQdmNhDFRkpTrBSPWmiJ9zqR9meWF88PYTD9M5VMHaVLwVgkK9yT4bzH2tv57kGG/GWHKFSXTfZTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnKViEFi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnKViEFi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so23097865e9.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983029; x=1752587829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGvxgS1wTROLGPvHYi0bMMdX7hZr5yXdnIXV0o5GN1Q=;
        b=KnKViEFinbZM5sjIubjK7GLGpJtE3UOz03V9vjyIDeNdwpSDFs7NVn5CZKD87R8CJE
         j9C1KW0kLVjBN9CaS+a4I4QxI44BE1/zBo5KL5xrCCrwzZE7X3Axv7UCREAlX1ISpLBH
         c0fv/JVjr5Y+Wz+5J55PDDcdrBuZqYTHX8XybVrb3AaTc6eUogM6y2a1r2cwy3gYlbnZ
         xduSW7vB5/NcDFOiU/X0yXC4ozrZ9N4HoI4ym3JJCVxcmam7w1usv3zeZCgsKZQ5uvvo
         n3hBNCsisZIAGBNsy7tIoLFWarAciLmYiP4p1Pg/sbGi47x0109HY2+QUZj5QxkBy7ht
         0T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983029; x=1752587829;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGvxgS1wTROLGPvHYi0bMMdX7hZr5yXdnIXV0o5GN1Q=;
        b=M7TMVAVIO63w2I5Ck9UPlBd5ErCvjnlSTKvujuDshQgUtMQo437hWV1coQ8O/QYzLP
         PeNa9qO8gKwkRsMq/FTWMgVnPpMJo5q6Ox+7BynRe/wJMMVBNBzKRmDh5Qa7mo1n85on
         ZtziJVYQVWDuCYAvHAhl7uKr2V5xKPhwqzjqv0pX5GjFFJWU6bb1WYDA3MeSK03IZ/le
         DAFtT7HyZP7vCYOJwIomDllQG8WaERjCEmDYtip9JTiyyW14U1Km/9NCUe8StDjjf+fa
         ROiEExOCcYz/21wc2BaGdzr9j3dj/QiEJAeGWHayI7dLsOHyNBmk4P6PNF8YVj2hz0PS
         34ng==
X-Gm-Message-State: AOJu0Yy89rzm+ujRHonIaFf0Fe0pul9zl9CcZlNDeJlQgqPYvng8ztOY
	fmgPyqeAs9sH4yuTLrickd8VdTrPBpv+SmVPEAETtQOR/nM3D+/3ffmgnQro7w==
X-Gm-Gg: ASbGnctlD6feNESgVlCU+imqECmUbKcyLD2pvsFZzJQXKv5nQvX3exGoRHaU1mq5NBq
	eWl561Jn5tEOYT4t4nbzCmxLhzqAa6wAyEl9SUOpnl93K2IuV59Ppt+VMtQ75tjQWDHyyJZKsah
	Z3rjSzI711MpqDntsIqi9ZLKllpISIzgUxJvgLPSvEOCgNoDqkWlp0KQndwKe4RMl2MOvIVE0Dh
	9DjSg7g/Fhlk6o5OZxuh9wzl+uCWru4ExjYy8fVo1f3RPvRbEDyVAEe6ZQjZsq7rXOVvpyh1on6
	+8ZkT+vbEJ9d69VzOYNxISYO/9XEIh7pJFPkZZoGJqWlf7k2MKmsntHMwE2PsrNAv7S9W5jA9vA
	nUmtnaR87is8Gd3K6IQ==
X-Google-Smtp-Source: AGHT+IH37zYW3vb4BblVGBIZStrecg2rD3+7LRRR58HfcYKfhHxc/nPXTnydZN8T0a4dCCRvZbGRQQ==
X-Received: by 2002:a05:6000:290a:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b5dde95755mr2629900f8f.13.1751983028652;
        Tue, 08 Jul 2025 06:57:08 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470f871casm13089252f8f.45.2025.07.08.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:57:08 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] breaking-changes: deprecate support for core.commentString=auto
Date: Tue,  8 Jul 2025 14:56:51 +0100
Message-ID: <3747a1f77f03bf2572e195673d021dcf827ae59b.1751983009.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "core.commentString" is set to "auto" then "git commit"
will automatically select the comment character ensuring that it
does not the first character on any of the lines in the commit
message. This was introduced by commit 84c9dc2c5a2 (commit: allow
core.commentChar=auto for character auto selection, 2014-05-17) The
motivation seems to be to avoid commenting out lines from the existing
message when amending a commit that was created with a message from
a file.

Unfortunately this feature does not work with:

 * commit message templates that contain comments.

 * prepare-commit-msg hooks that introduce comments.

 * "git commit --cleanup=strip --edit -F <file>" which means that it
   is incompatible with

   - the "fixup" and "squash" commands of "git rebase -i" as the
     comments added by those commands are then treated as part of the
     commit message.

   - the conflict comments added to the commit message by "git
     cherry-pick", "git rebase" etc. as these comments are then treated
     as part of the commit message.

It is also ignored by "git notes" when amending a note.

The issues with comments coming from a template, hook or file are a
consequence of the design of this feature and are therefore hard to
fix.

As the costs of this feature outweigh the benefits deprecate it and
remove it in Git 3.0. If someone comes up with some patches that fix all
the issues in a maintainable way then I'd be happy to see this change
reverted.

The next commit will add some advice for users on how they can update
their config settings.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/BreakingChanges.adoc |  4 ++++
 Documentation/config/core.adoc     | 20 ++++++++++++++++++--
 builtin/commit.c                   |  4 ++++
 config.c                           |  4 ++++
 environment.c                      |  2 ++
 environment.h                      |  2 ++
 t/t3404-rebase-interactive.sh      |  2 +-
 t/t7502-commit-porcelain.sh        |  4 ++--
 8 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 61bdd586b9e..f38ba1de6e4 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -183,6 +183,10 @@ These features will be removed.
   timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
   removes the support for "--stdin" altogether.
 
+* Support for `core.commentString=auto` has been deprecated and will
+  be removed in Git 3.0.
++
+cf. <xmqqa59i45wc.fsf@gitster.g>
 
 == Superseded features that will not be deprecated
 
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 9fde1ab63a7..7133f00c38b 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -531,9 +531,25 @@ core.commentString::
 	commented, and removes them after the editor returns
 	(default '#').
 +
-If set to "auto", `git-commit` would select a character that is not
+ifndef::with-breaking-changes[]
+If set to "auto", `git-commit` will select a character that is not
 the beginning character of any line in existing commit messages.
-+
+Support for this value is deprecated and will be removed in Git 3.0
+due to the following limitations:
++
+--
+* It is incompatible with adding comments in a commit message
+  template. This includes the conflicts comments added to
+  the commit message by `cherry-pick`, `merge`, `rebase` and
+  `revert`.
+* It is incompatible with adding comments to the commit message
+  in the `prepare-commit-msg` hook.
+* It is incompatible with the `fixup` and `squash` commands when
+  rebasing,
+* It is not respected by `git notes`
+--
++
+endif::with-breaking-changes[]
 Note that these two variables are aliases of each other, and in modern
 versions of Git you are free to use a string (e.g., `//` or `⁑⁕⁑`) with
 `commentChar`. Versions of Git prior to v2.45.0 will ignore
diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64a..8794b24572b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -683,6 +683,7 @@ static int author_date_is_interesting(void)
 	return author_message || force_date;
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] = "#;@!$%^&|:";
@@ -716,6 +717,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	free(comment_line_str_to_free);
 	comment_line_str = comment_line_str_to_free = xstrfmt("%c", *p);
 }
+#endif /* WITH_BREAKING_CHANGES */
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 				struct pretty_print_context *ctx)
@@ -912,8 +914,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
 
+#ifndef WITH_BREAKING_CHANGES
 	if (auto_comment_line_char)
 		adjust_comment_line_char(&sb);
+#endif /* WITH_BREAKING_CHANGES */
 	strbuf_release(&sb);
 
 	/* This checks if committer ident is explicitly given */
diff --git a/config.c b/config.c
index eb60c293ab3..f99496b16c0 100644
--- a/config.c
+++ b/config.c
@@ -1537,14 +1537,18 @@ static int git_default_core_config(const char *var, const char *value,
 	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
+#ifndef WITH_BREAKING_CHANGES
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
+#endif /* WITH_BREAKING_CHANGES */
 		else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
 			comment_line_str = value;
 			FREE_AND_NULL(comment_line_str_to_free);
+#ifndef WITH_BREAKING_CHANGES
 			auto_comment_line_char = 0;
+#endif /* WITH_BREAKING_CHANGES */
 		} else
 			return error(_("%s must have at least one character"), var);
 		return 0;
diff --git a/environment.c b/environment.c
index 7bf0390a335..6804380889f 100644
--- a/environment.c
+++ b/environment.c
@@ -111,7 +111,9 @@ int protect_ntfs = PROTECT_NTFS_DEFAULT;
  */
 const char *comment_line_str = "#";
 char *comment_line_str_to_free;
+#ifndef WITH_BREAKING_CHANGES
 int auto_comment_line_char;
+#endif /* WITH_BREAKING_CHANGES */
 
 /* This is set by setup_git_directory_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/environment.h b/environment.h
index 9a3d05d414a..871596afcef 100644
--- a/environment.h
+++ b/environment.h
@@ -207,7 +207,9 @@ extern char *excludes_file;
  */
 extern const char *comment_line_str;
 extern char *comment_line_str_to_free;
+#ifndef WITH_BREAKING_CHANGES
 extern int auto_comment_line_char;
+#endif /* WITH_BREAKING_CHANGES */
 
 # endif /* USE_THE_REPOSITORY_VARIABLE */
 #endif /* ENVIRONMENT_H */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6bac217ed35..ce0aebb9a7e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1176,7 +1176,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_success 'rebase -i respects core.commentchar=auto' '
+test_expect_success !WITH_BREAKING_CHANGES 'rebase -i respects core.commentchar=auto' '
 	test_config core.commentchar auto &&
 	write_script copy-edit-script.sh <<-\EOF &&
 	cp "$1" edit-script
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b37e2018a74..65b4519a715 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -956,13 +956,13 @@ test_expect_success 'commit --status with custom comment character' '
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'switch core.commentchar' '
+test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
 	test_commit "#foo" foo &&
 	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend &&
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'switch core.commentchar but out of options' '
+test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar but out of options' '
 	cat >text <<\EOF &&
 # 1
 ; 2
-- 
2.49.0.897.gfad3eb7d210

