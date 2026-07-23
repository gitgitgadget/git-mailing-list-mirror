Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC283F5BE3
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841578; cv=none; b=dI8PYia/P+oxgIskw2PDTcX0RUFfO0KdHNlk3HH/lP7nHRdqy8aeLFHETQPhyLGH6adia6zdHoafDvL/P6+mvzP1D6onKUv7j5XgTKqlA+AK9+tibjApRE2OKiB+W5tNSkPQHQ2EbjUWoZyCY5wHTjm7ix0NhVMTwZsL5T+F3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841578; c=relaxed/simple;
	bh=52jIgeYBqhUPGQCFJ4m7s/Cp6p1hIV/LBwfrN9RzBE8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jy/CwR3zfxof3TjuJIFpXEgudvso3ibBl3wfnaOnDAsxt+6JwYjpXkJIFyErah12qiylbuidWbUs0bpaCN+DN8Fng3W+rrWlur6SZ1iZJty3nyMQKIxnxlN1YUFfKk+cVbtIMJeeAp2E8zwCaX5N7+cDkEeyUaZbIhjDtW0oYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNTTV5FP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNTTV5FP"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso504639a34.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841575; x=1785446375; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fQjTCejnaetJLhDqt1+sDQ0hrPqRJas8lq1vtNxVpyM=;
        b=YNTTV5FP09ZpE0XS4qcOj88vKiDPBYPtl8X01cpwwvsg0KXbCpTdVzYXCUBbw8f6I6
         m3K/QisSZuipjbrQOyi8KgmEe3bbvM81KCddJC5/o53kP3Lmtk6phVHHM4rer5iIsM8f
         t5axBo0kZw1bJAy05qW0dagrgL7vhFzdJhzWrhkF0F1utv1+YbLQYLOf+WW+gJ349WR0
         JZOLoXDLDJp+JHL4GbZnJxoeQuXxIuOqiMv3e7rDS979bt8SV3RZ31B8nA6QxAIPM4iQ
         TpQKOyC7DZMnC+YaI22Qret5E8yhb6ZAu2q5N4K9TRTeg95xOJIZgHhRKBL7Zk7HnrSJ
         7CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841575; x=1785446375;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQjTCejnaetJLhDqt1+sDQ0hrPqRJas8lq1vtNxVpyM=;
        b=PV/OHwARfcacIZH1pqyQFW5EeVdRy/SJjFD0cXGGffUXLCnIbps3pV1+H5lEOGJYzH
         NjS9JS8VXIpqcsaZAig0LQzmlrBhF3wXqreLF9TuXoM6282s9gCxq5fUadwa+WaXewMo
         vXoc98NSruPxoPnFsXWchXFUG0WZTgIbd5PcXbF31eByOlJUu/Oy02z4O42II/vxGeaI
         oMMiMs8lcGbObvS9Y92xcjxjlzk2vxAxhmI5chzIFHWneKTr4tpIcdBIOHcFtRUngoEX
         3I3CfrdNVcxcfu5QcmjpG9pO+/CTTlvObB+bV7jdZvf/Z0DuA+JXGY71v/M5koX/l6Bs
         pY3A==
X-Gm-Message-State: AOJu0YzIIzK8kebIq49l/Z6z+9/2JUKKS8ZvG9e8kkXWdKBCGLVwXLIG
	D1BDNNG4qqShuhshoGKgXoKZsWb8skK85H3Tbt5QhS2J7yF/iEFJadtZujddHg==
X-Gm-Gg: AR+sD12u9PvFGCQLr4KeCOE9p6gZcy2bED3SOCHwbcFDE4D2hsPPd7L48E75Ypbkjvw
	rR/zlTFZNy7c/8fZu4IPg5YFjJkH2iDTmzVCdVWYkpk1b09oqTozdaBN6K2FfJBPRykzPhIiKSq
	SyzbrrCXpN3vKtGytUO6snJ7eQEuUn6uNOzykvonLWw8dThpTavPi2qdsw416JiH018wS+FALq5
	dRu7PUF1kQFjZykRJwPykY1GM7lHXU9OnPzb7hdT9j3v6CCI/+H90cz+ufsMTs13FXs9CX2ntHv
	2PuVebdVEEwdVZvr6w6bKoQXaWP1+4bsPf3YKG/BP5UGklfvnx9l/ZD5QZx8dMMtTSg/TGJ9vmb
	Jr36ZHM967JNOpIgf5ucVfjRVYcgXKP68X2ycekvSLJw3M/0RaLuJEEtVY0/q33XaWQv+AgSabl
	dmRneYYg==
X-Received: by 2002:a05:6830:6106:b0:7e9:ea18:d1e3 with SMTP id 46e09a7af769-7ee43fd863bmr2638163a34.29.1784841574650;
        Thu, 23 Jul 2026 14:19:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0b3ee5sm4403324a34.24.2026.07.23.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:19:33 -0700 (PDT)
Message-Id: <3850fb33ffbc585c68d59861c6e943e0dddf9cee.1784841567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:19:24 +0000
Subject: [PATCH v2 2/4] doc: convert git-format-patch synopsis and options to
 new style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Replace [verse] with [synopsis] in the SYNOPSIS block and remove
single-quote formatting from the command name.

Backtick-quote all option terms in the OPTIONS section, convert
standalone placeholders to _<placeholder>_ form, and convert
single-quoted commands and tools in prose to backtick form.

Also update the included files:
- diff-options.adoc: backtick-quote the git-format-patch-specific
  option terms (-p, --no-stat, --max-depth=<depth>)
- format-patch-caveats.adoc: convert patch(1) to `patch`(1)

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.adoc     |   8 +-
 Documentation/git-format-patch.adoc | 289 ++++++++++++++--------------
 2 files changed, 148 insertions(+), 149 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index c8242e2462..e605d28678 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -13,8 +13,8 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-format-patch[]
--p::
---no-stat::
+`-p`::
+`--no-stat`::
 	Generate plain patches without any diffstats.
 endif::git-format-patch[]
 
@@ -893,8 +893,8 @@ endif::git-format-patch[]
 	reverted with `--ita-visible-in-index`. Both options are
 	experimental and could be removed in future.
 
---max-depth=<depth>::
-	For each pathspec given on command line, descend at most `<depth>`
+`--max-depth=<depth>`::
+	For each pathspec given on command line, descend at most _<depth>_
 	levels of directories. A value of `-1` means no limit.
 	Cannot be combined with wildcards in the pathspec.
 	Given a tree containing `foo/bar/baz`, the following list shows the
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index f7905c0f7c..191f64b77d 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -8,8 +8,8 @@ git-format-patch - Prepare patches for e-mail submission
 
 SYNOPSIS
 --------
-[verse]
-'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
+[synopsis]
+git format-patch [-k] [(-o|--output-directory) <dir> | --stdout]
 		   [--no-thread | --thread[=<style>]]
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
@@ -40,20 +40,20 @@ DESCRIPTION
 Prepare each non-merge commit with its "patch" in
 one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
-for use with 'git am'.
+for use with `git am`.
 
 A "message" generated by the command consists of three parts:
 
 * A brief metadata header that begins with `From <commit>`
   with a fixed `Mon Sep 17 00:00:00 2001` datestamp to help programs
-  like "file(1)" to recognize that the file is an output from this
+  like `file`(1) to recognize that the file is an output from this
   command, fields that record the author identity, the author date,
   and the title of the change (taken from the first paragraph of the
   commit log message).
 
 * The second and subsequent paragraphs of the commit log message.
 
-* The "patch", which is the "diff -p --stat" output (see
+* The "patch", which is the `diff -p --stat` output (see
   linkgit:git-diff[1]) between the commit and its parent.
 
 The log message and the patch are separated by a line with a
@@ -61,18 +61,18 @@ three-dash line.
 
 There are two ways to specify which commits to operate on.
 
-1. A single commit, <since>, specifies that the commits leading
+1. A single commit, _<since>_, specifies that the commits leading
    to the tip of the current branch that are not in the history
-   that leads to the <since> to be output.
+   that leads to the _<since>_ to be output.
 
-2. Generic <revision-range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:gitrevisions[7]) means the
+2. Generic _<revision-range>_ expression (see 'SPECIFYING
+   REVISIONS' section in linkgit:gitrevisions[7]) means the
    commits in the specified range.
 
-The first rule takes precedence in the case of a single <commit>.  To
+The first rule takes precedence in the case of a single _<commit>_.  To
 apply the second rule, i.e., format everything since the beginning of
-history up until <commit>, use the `--root` option: `git format-patch
---root <commit>`.  If you want to format only <commit> itself, you
+history up until _<commit>_, use the `--root` option: `git format-patch
+--root <commit>`.  If you want to format only _<commit>_ itself, you
 can do this with `git format-patch -1 <commit>`.
 
 By default, each output file is numbered sequentially from 1, and uses the
@@ -82,7 +82,7 @@ will only be numbers, without the first line of the commit appended.
 The names of the output files are printed to standard
 output, unless the `--stdout` option is specified.
 
-If `-o` is specified, output files are created in <dir>.  Otherwise
+If `-o` is specified, output files are created in _<dir>_.  Otherwise
 they are created in the current working directory. The default path
 can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
@@ -108,119 +108,119 @@ OPTIONS
 :git-format-patch: 1
 include::diff-options.adoc[]
 
--<n>::
-	Prepare patches from the topmost <n> commits.
+`-<n>`::
+	Prepare patches from the topmost _<n>_ commits.
 
--o <dir>::
---output-directory <dir>::
-	Use <dir> to store the resulting files, instead of the
+`-o <dir>`::
+`--output-directory=<dir>`::
+	Use _<dir>_ to store the resulting files, instead of the
 	current working directory.
 
--n::
---numbered::
+`-n`::
+`--numbered`::
 	Name output in '[PATCH n/m]' format, even with a single patch.
 
--N::
---no-numbered::
+`-N`::
+`--no-numbered`::
 	Name output in '[PATCH]' format.
 
---start-number <n>::
-	Start numbering the patches at <n> instead of 1.
+`--start-number <n>`::
+	Start numbering the patches at _<n>_ instead of 1.
 
---numbered-files::
+`--numbered-files`::
 	Output file names will be a simple number sequence
 	without the default first line of the commit appended.
 
--k::
---keep-subject::
+`-k`::
+`--keep-subject`::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
---stdout::
+`--stdout`::
 	Print all commits to the standard output in mbox format,
 	instead of creating a file for each one.
 
---attach[=<boundary>]::
+`--attach[=<boundary>]`::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
 	second part, with `Content-Disposition: attachment`.
 
---no-attach::
+`--no-attach`::
 	Disable the creation of an attachment, overriding the
 	configuration setting.
 
---inline[=<boundary>]::
+`--inline[=<boundary>]`::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
 	second part, with `Content-Disposition: inline`.
 
---thread[=<style>]::
---no-thread::
-	Controls addition of `In-Reply-To` and `References` headers to
+`--thread[=<style>]`::
+`--no-thread`::
+	Control addition of `In-Reply-To` and `References` headers to
 	make the second and subsequent mails appear as replies to the
 	first.  Also controls generation of the `Message-ID` header to
 	reference.
 +
-The optional <style> argument can be either `shallow` or `deep`.
-'shallow' threading makes every mail a reply to the head of the
+The optional _<style>_ argument can be either `shallow` or `deep`.
+`shallow` threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
-`--in-reply-to`, and the first patch mail, in this order.  'deep'
+`--in-reply-to`, and the first patch mail, in this order.  `deep`
 threading makes every mail a reply to the previous one.
 +
 The default is `--no-thread`, unless the `format.thread` configuration
 is set.  `--thread` without an argument is equivalent to `--thread=shallow`.
 +
-Beware that the default for 'git send-email' is to thread emails
+Beware that the default for `git send-email` is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=<message-id>::
+`--in-reply-to=<message-id>`::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given <message-id>, which avoids breaking threads to
+	reply to the given _<message-id>_, which avoids breaking threads to
 	provide a new patch series.
 
---ignore-if-in-upstream::
+`--ignore-if-in-upstream`::
 	Do not include a patch that matches a commit in
-	<until>..<since>.  This will examine all patches reachable
-	from <since> but not from <until> and compare them with the
+	_<until>_.._<since>_.  This will examine all patches reachable
+	from _<since>_ but not from _<until>_ and compare them with the
 	patches being generated, and any patch that matches is
 	ignored.
 
---always::
+`--always`::
 	Include patches for commits that do not introduce any change,
 	which are omitted by default.
 
---cover-from-description=<mode>::
-	Controls which parts of the cover letter will be automatically
+`--cover-from-description=<mode>`::
+	Control which parts of the cover letter will be automatically
 	populated using the branch's description.
 +
-If `<mode>` is `message` or `default`, the cover letter subject will be
+_<mode>_ can have the following values:
+
+`message`;;
+`default`;; the cover letter subject will be
 populated with placeholder text. The body of the cover letter will be
 populated with the branch's description. This is the default mode when
 no configuration nor command line option is specified.
-+
-If `<mode>` is `subject`, the first paragraph of the branch description will
+`subject`;; the first paragraph of the branch description will
 populate the cover letter subject. The remainder of the description will
 populate the body of the cover letter.
-+
-If `<mode>` is `auto`, if the first paragraph of the branch description
+`auto`;; if the first paragraph of the branch description
 is greater than 100 bytes, then the mode will be `message`, otherwise
 `subject` will be used.
-+
-If `<mode>` is `none`, both the cover letter subject and body will be
+`none`;; both the cover letter subject and body will be
 populated with placeholder text.
 
---description-file=<file>::
-	Use the contents of <file> instead of the branch's description
+`--description-file=<file>`::
+	Use the contents of _<file>_ instead of the branch's description
 	for generating the cover letter.
 
---subject-prefix=<subject-prefix>::
+`--subject-prefix=<subject-prefix>`::
 	Use '[<subject-prefix>]' instead of the standard '[PATCH]'
 	prefix in the subject line. This can be used to name a patch
 	series, and can be combined with the `--numbered` option.
@@ -231,14 +231,14 @@ all patches. This is often useful on mailing lists which receive
 patches for several repositories and can be used to disambiguate
 the patches (with a value of e.g. "PATCH my-project").
 
---filename-max-length=<n>::
+`--filename-max-length=<n>`::
 	Instead of the standard 64 bytes, chomp the generated output
-	filenames at around '<n>' bytes (too short a value will be
+	filenames at around _<n>_ bytes (too short a value will be
 	silently raised to a reasonable length).  Defaults to the
 	value of the `format.filenameMaxLength` configuration
 	variable, or 64 if unconfigured.
 
---rfc[=<rfc>]::
+`--rfc[=<rfc>]`::
 	Prepends the string _<rfc>_ (defaults to "RFC") to
 	the subject prefix.  As the subject prefix defaults to
 	"PATCH", you'll get "RFC PATCH" by default.
@@ -254,38 +254,38 @@ can be prefixed with a dash ("`-`") to signal that the rest of
 the _<rfc>_ string should be appended to the subject prefix instead,
 e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
 
--v <n>::
---reroll-count=<n>::
-	Mark the series as the <n>-th iteration of the topic. The
+`-v <n>`::
+`--reroll-count=<n>`::
+	Mark the series as the _<n>_-th iteration of the topic. The
 	output filenames have `v<n>` prepended to them, and the
 	subject prefix ("PATCH" by default, but configurable via the
-	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
+	`--subject-prefix` option) has `v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
-	`<n>` does not have to be an integer (e.g. "--reroll-count=4.4",
-	or "--reroll-count=4rev2" are allowed), but the downside of
+	_<n>_ does not have to be an integer (e.g. `--reroll-count=4.4`,
+	or `--reroll-count=4rev2` are allowed), but the downside of
 	using such a reroll-count is that the range-diff/interdiff
 	with the previous version does not state exactly which
 	version the new iteration is compared against.
 
---to=<email>::
+`--to=<email>`::
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
---cc=<email>::
+`--cc=<email>`::
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
---from::
---from=<ident>::
-	Use `ident` in the `From:` header of each email. In case of a
+`--from`::
+`--from=<ident>`::
+	Use _<ident>_ in the `From:` header of each email. In case of a
 	commit email, if the author ident of the commit is not textually
-	identical to the provided `ident`, place a `From:` header in the
-	body of the message with the original author. If no `ident` is
+	identical to the provided _<ident>_, place a `From:` header in the
+	body of the message with the original author. If no _<ident>_ is
 	given, or if the option is not passed at all, use the ident of
 	the current committer.
 +
@@ -296,8 +296,8 @@ header). Note also that `git send-email` already handles this
 transformation for you, and this option should not be used if you are
 feeding the result to `git send-email`.
 
---force-in-body-from::
---no-force-in-body-from::
+`--force-in-body-from`::
+`--no-force-in-body-from`::
 	With the e-mail sender specified via the `--from` option, by
 	default, an in-body "From:" to identify the real author of
 	the commit is added at the top of the commit log message if
@@ -308,7 +308,7 @@ feeding the result to `git send-email`.
 	Defaults to the value of the `format.forceInBodyFrom`
 	configuration variable.
 
---add-header=<header>::
+`--add-header=<header>`::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
 	For example, `--add-header="Organization: git-foo"`.
@@ -316,13 +316,13 @@ feeding the result to `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
---cover-letter::
---no-cover-letter::
+`--cover-letter`::
+`--no-cover-letter`::
 	In addition to the patches, generate a cover letter file containing the
 	branch description, commit list and the overall diffstat.  You can fill
 	in a description in the file before sending it out.
 
---commit-list-format=<format-spec>::
+`--commit-list-format=<format-spec>`::
 	Specify the format in which to generate the commit list of the patch
 	series. The accepted values for format-spec are `shortlog`, `modern` or
 	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
@@ -334,28 +334,28 @@ feeding the result to `git send-email`.
 	This option given from the command-line implies the use of
 	`--cover-letter` unless `--no-cover-letter` is given.
 
---encode-email-headers::
---no-encode-email-headers::
+`--encode-email-headers`::
+`--no-encode-email-headers`::
 	Encode email headers that have non-ASCII characters with
 	"Q-encoding" (described in RFC 2047), instead of outputting the
 	headers verbatim. Defaults to the value of the
 	`format.encodeEmailHeaders` configuration variable.
 
---interdiff=<previous>::
+`--interdiff=<previous>`::
 	As a reviewer aid, insert an interdiff into the cover letter,
 	or as commentary of the lone patch of a 1-patch series, showing
 	the differences between the previous version of the patch series and
-	the series currently being formatted. `previous` is a single revision
+	the series currently being formatted. _<previous>_ is a single revision
 	naming the tip of the previous series which shares a common base with
 	the series being formatted (for example `git format-patch
 	--cover-letter --interdiff=feature/v1 -3 feature/v2`).
 
---range-diff=<previous>::
+`--range-diff=<previous>`::
 	As a reviewer aid, insert a range-diff (see linkgit:git-range-diff[1])
 	into the cover letter, or as commentary of the lone patch of a
 	1-patch series, showing the differences between the previous
 	version of the patch series and the series currently being formatted.
-	`previous` can be a single revision naming the tip of the previous
+	_<previous>_ can be a single revision naming the tip of the previous
 	series if it shares a common base with the series being formatted (for
 	example `git format-patch --cover-letter --range-diff=feature/v1 -3
 	feature/v2`), or a revision range if the two versions of the series are
@@ -367,7 +367,7 @@ product of `format-patch` is generated, and they are not passed to
 the underlying `range-diff` machinery used to generate the cover-letter
 material (this may change in the future).
 
---creation-factor=<percent>::
+`--creation-factor=<percent>`::
 	Used with `--range-diff`, tweak the heuristic which matches up commits
 	between the previous and current series of patches by adjusting the
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
@@ -378,8 +378,8 @@ case is to show comparison with an older iteration of the same
 topic and the tool should find more correspondence between the two
 sets of patches.
 
---notes[=<ref>]::
---no-notes::
+`--notes[=<ref>]`::
+`--no-notes`::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
@@ -394,17 +394,17 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 The default is `--no-notes`, unless the `format.notes` configuration is
 set.
 
---signature=<signature>::
---no-signature::
+`--signature=<signature>`::
+`--no-signature`::
 	Add a signature to each message produced. Per RFC 3676 the signature
-	is separated from the body by a line with '-- ' on it. If the
+	is separated from the body by a line with "-- " on it. If the
 	signature option is omitted the signature defaults to the Git version
 	number.
 
---signature-file=<file>::
-	Works just like --signature except the signature is read from a file.
+`--signature-file=<file>`::
+	Works just like `--signature` except the signature is read from a file.
 
---suffix=.<sfx>::
+`--suffix=.<sfx>`::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
 	`--suffix=.txt`.  Leaving this empty will remove the `.patch`
@@ -413,36 +413,36 @@ set.
 Note that the leading character does not have to be a dot; for example,
 you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not print the names of the generated files to standard output.
 
---no-binary::
+`--no-binary`::
 	Do not output contents of changes in binary files, instead
 	display a notice that those files changed.  Patches generated
 	using this option cannot be applied properly, but they are
 	still useful for code review.
 
---zero-commit::
+`--zero-commit`::
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
---no-base::
---base[=<commit>]::
+`--no-base`::
+`--base[=<commit>]`::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
-	below for details. If <commit> is "auto", a base commit is
+	below for details. If _<commit>_ is `auto`, a base commit is
 	automatically chosen. The `--no-base` option overrides a
 	`format.useAutoBase` configuration.
 
---root::
-	Treat the revision argument as a <revision-range>, even if it
+`--root`::
+	Treat the revision argument as a _<revision-range>_, even if it
 	is just a single commit (that would normally be treated as a
-	<since>).  Note that root commits included in the specified
+	_<since>_).  Note that root commits included in the specified
 	range are always formatted as creation patches, independently
 	of this flag.
 
---progress::
+`--progress`::
 	Show progress reports on stderr as patches are generated.
 
 CONFIGURATION
@@ -453,7 +453,7 @@ outputting more than one patch, add "To:" or "Cc:" headers, configure
 attachments, change the patch output directory, and sign off patches
 with configuration variables.
 
-------------
+----
 [format]
 	headers = "Organization: git-foo\n"
 	subjectPrefix = CHANGE
@@ -467,17 +467,16 @@ with configuration variables.
 	coverLetter = auto
 	commitListFormat = shortlog
 	coverFromDescription = auto
-------------
-
+----
 
 DISCUSSION
 ----------
 
-The patch produced by 'git format-patch' is in UNIX mailbox format,
+The patch produced by `git format-patch` is in UNIX mailbox format,
 with a fixed "magic" time stamp to indicate that the file is output
 from format-patch rather than a real mailbox, like so:
 
-------------
+----
 From 8f72bad1baf19a53459661343e21d6491c3908d3 Mon Sep 17 00:00:00 2001
 From: Tony Luck <tony.luck@intel.com>
 Date: Tue, 13 Jul 2010 11:42:54 -0700
@@ -492,7 +491,7 @@ arch/arm config files were slimmed down using a python script
 
 Do the same for ia64 so we can have sleek & trim looking
 ...
-------------
+----
 
 Typically it will be placed in a MUA's drafts folder, edited to add
 timely commentary that should not go in the changelog after the three
@@ -502,12 +501,12 @@ can save interesting patches in a UNIX mailbox and apply them with
 linkgit:git-am[1].
 
 When a patch is part of an ongoing discussion, the patch generated by
-'git format-patch' can be tweaked to take advantage of the 'git am
---scissors' feature.  After your response to the discussion comes a
+`git format-patch` can be tweaked to take advantage of the `git am
+--scissors` feature.  After your response to the discussion comes a
 line that consists solely of "`-- >8 --`" (scissors and perforation),
 followed by the patch with unnecessary header fields removed:
 
-------------
+----
 ...
 > So we should do such-and-such.
 
@@ -518,7 +517,7 @@ Subject: [IA64] Put ia64 config files on the Uwe Kleine-König diet
 
 arch/arm config files were slimmed down using a python script
 ...
-------------
+----
 
 When sending a patch this way, most often you are sending your own
 patch, so in addition to the "`From $SHA1 $magic_timestamp`" marker you
@@ -540,7 +539,7 @@ two common types of corruption:
 One way to test if your MUA is set up correctly is:
 
 * Send the patch to yourself, exactly the way you would, except
-  with To: and Cc: lines that do not contain the list and
+  with `To:` and `Cc:` lines that do not contain the list and
   maintainer address.
 
 * Save that patch to a file in UNIX mailbox format.  Call it a.patch,
@@ -561,12 +560,12 @@ If it does not apply correctly, there can be various reasons.
   this case.
 
 * The MUA corrupted your patch; "am" would complain that
-  the patch does not apply.  Look in the .git/rebase-apply/ subdirectory and
-  see what 'patch' file contains and check for the common
-  corruption patterns mentioned above.
+  the patch does not apply.  Look in the `.git/rebase-apply/` subdirectory and
+   see what `patch` file contains and check for the common
+   corruption patterns mentioned above.
 
-* While at it, check the 'info' and 'final-commit' files as well.
-  If what is in 'final-commit' is not exactly what you would want to
+* While at it, check the `info` and `final-commit` files as well.
+  If what is in `final-commit` is not exactly what you would want to
   see in the commit log message, it is very likely that the
   receiver would end up hand editing the log message when applying
   your patch.  Things like "Hi, this is my first patch.\n" in the
@@ -582,11 +581,11 @@ GMail
 ~~~~~
 GMail does not have any way to turn off line wrapping in the web
 interface, so it will mangle any emails that you send.  You can however
-use "git send-email" and send your patches through the GMail SMTP server, or
+use `git send-email` and send your patches through the GMail SMTP server, or
 use any IMAP email client to connect to the google IMAP server and forward
 the emails through that.
 
-For hints on using 'git send-email' to send your patches through the
+For hints on using `git send-email` to send your patches through the
 GMail SMTP server, see the EXAMPLE section of linkgit:git-send-email[1].
 
 For hints on submission using the IMAP interface, see the EXAMPLE
@@ -595,7 +594,7 @@ section of linkgit:git-imap-send[1].
 Thunderbird
 ~~~~~~~~~~~
 By default, Thunderbird will both wrap emails as well as flag
-them as being 'format=flowed', both of which will make the
+them as being `format=flowed`, both of which will make the
 resulting email unusable by Git.
 
 There are three different approaches: use an add-on to turn off line wraps,
@@ -609,14 +608,14 @@ Install the Toggle Line Wrap add-on that is available from
 https://addons.thunderbird.net/thunderbird/addon/toggle-line-wrap
 It adds a button "Line Wrap" to the composer's toolbar
 that you can tick off. Now you can compose the message as you otherwise do
-(cut + paste, 'git format-patch' | 'git imap-send', etc), but you have to
+(cut + paste, `git format-patch` | `git imap-send`, etc), but you have to
 insert line breaks manually in any text that you type.
 
 As a bonus feature, the add-on can detect patch text in the composer
 and warns when line wrapping has not yet been turned off.
 
 The add-on requires a few tweaks of the advanced configuration
-(about:config). These are listed on the download page.
+(`about:config`). These are listed on the download page.
 
 Approach #2 (configuration)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -643,7 +642,7 @@ Toggle it to make sure it is set to `false`. Also, search for
    Toggle it to make sure it is set to `false`.
 
 After that is done, you should be able to compose email as you
-otherwise would (cut + paste, 'git format-patch' | 'git imap-send', etc),
+otherwise would (cut + paste, `git format-patch` | `git imap-send`, etc),
 and the patches will not be mangled.
 
 Approach #3 (external editor)
@@ -660,14 +659,14 @@ External Editor from https://globs.org/articles.php?lng=en&pg=8
    "Composition & Addressing" panel of the account to be used to
    send the patch.
 
-3. In the main Thunderbird window, 'before' you open the compose
+3. In the main Thunderbird window, _before_ you open the compose
    window for the patch, use Tools->about:config to set the
    following to the indicated values:
 +
-----------
+----
 	mailnews.send_plaintext_flowed  => false
 	mailnews.wraplength             => 0
-----------
+----
 
 4. Open a compose window and click the external editor icon.
 
@@ -677,11 +676,11 @@ External Editor from https://globs.org/articles.php?lng=en&pg=8
 Side note: it may be possible to do step 2 with
 about:config and the following settings but no one's tried yet.
 
-----------
+----
 	mail.html_compose                       => false
 	mail.identity.default.compose_html      => false
 	mail.identity.id?.compose_html          => false
-----------
+----
 
 There is a script in contrib/thunderbird-patch-inline which can help
 you include patches with Thunderbird in an easy way. To use it, do the
@@ -708,15 +707,15 @@ BASE TREE INFORMATION
 
 The base tree information block is used for maintainers or third party
 testers to know the exact state the patch series applies to. It consists
-of the 'base commit', which is a well-known commit that is part of the
+of the "base commit", which is a well-known commit that is part of the
 stable part of the project history everybody else works off of, and zero
-or more 'prerequisite patches', which are well-known patches in flight
-that is not yet part of the 'base commit' that need to be applied on top
-of 'base commit' in topological order before the patches can be applied.
+or more "prerequisite patches", which are well-known patches in flight
+that is not yet part of the "base commit" that need to be applied on top
+of "base commit" in topological order before the patches can be applied.
 
-The 'base commit' is shown as "base-commit: " followed by the 40-hex of
-the commit object name.  A 'prerequisite patch' is shown as
-"prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
+The "base commit" is shown as "`base-commit:` " followed by the 40-hex of
+the commit object name.  A "prerequisite patch" is shown as
+"`prerequisite-patch-id:` " followed by the 40-hex "patch id", which can
 be obtained by passing the patch through the `git patch-id --stable`
 command.
 
@@ -734,12 +733,12 @@ range), the base tree information block is shown at the end of the
 first message the command outputs (either the first patch, or the
 cover letter), like this:
 
-------------
+----
 base-commit: P
 prerequisite-patch-id: X
 prerequisite-patch-id: Y
 prerequisite-patch-id: Z
-------------
+----
 
 For non-linear topology, such as
 
@@ -763,7 +762,7 @@ EXAMPLES
 --------
 
 * Extract commits between revisions R1 and R2, and apply them on top of
-  the current branch using 'git am' to cherry-pick them:
+  the current branch using `git am` to cherry-pick them:
 +
 ------------
 $ git format-patch -k --stdout R1..R2 | git am -3 -k
@@ -778,7 +777,7 @@ $ git format-patch origin
 +
 For each commit a separate file is created in the current directory.
 
-* Extract all commits that lead to 'origin' since the inception of the
+* Extract all commits that lead to `origin` since the inception of the
   project:
 +
 ------------
@@ -794,7 +793,7 @@ $ git format-patch -M -B origin
 Additionally, it detects and handles renames and complete rewrites
 intelligently to produce a renaming patch.  A renaming patch reduces
 the amount of text output, and generally makes it easier to review.
-Note that non-Git "patch" programs won't understand renaming patches, so
+Note that non-Git `patch` programs won't understand renaming patches, so
 use it only when you know the recipient uses Git to apply your patch.
 
 * Extract three topmost commits from the current branch and format them
-- 
gitgitgadget

