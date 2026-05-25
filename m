Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDF332EC8
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704919; cv=none; b=BM2y31ao44Y0uJHMEweluUq/JeAkVrGAVPd3YL9mZsryKuO3KC+r8q3ggxlfNMNoYmfviuo9E+v+3nCxBE3uwL68xWVhbVT4KcOpcbzaFpMBsGeEiKs414OWBR7N3uwYhFYfCdYJDLqW0YGFoaA/FZU8Yo1IW/m9j47uo1Od1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704919; c=relaxed/simple;
	bh=ZQvjYC/dfO9fo6V9EAOm2hWSs3AjjijL0FIvdRSkVS4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KcoB/wKHoRZ+Dym6vdUOJpnXeGYwEaiVxTBkTt+/aQx7yf4qrkGQve4EH4/k9ySAHbzDEhFMU9KPxUoIb26PEp+FKWYJI6JmWgY5ksCZ/D5fR2HwH4K6qKR6o2ewClFqg5AqZFEks8bOOJ2RnMfph4y29ixltUoJk/xBsTiHJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgnBP1dZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgnBP1dZ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cac189e516so52383436d6.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704917; x=1780309717; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdzZmfAIN3LPbPP0nv+Qm5fhePKQlLgg7whbOXfUIqE=;
        b=NgnBP1dZs+ELqrMR3wK9OsB/o+w9JpkkNN+cYzxhL91IcekxYLP3A9aRri59VADawc
         V6o5Gpn8AkAM02Uq16cTZCvK0RbjZNttosHu4tClKS1lBMvgJtEyFDTaDA5P8I4o8dZF
         OXujzX65QbeFhY6SK854tUlQi1fqqPmZ2nzKoApZZb4qajuy9D+h4cmBwrjmICRhKnTc
         JaJndnQY1w06JRhtsr9xu6td1yRdXcwkpXhXFupZ/nrvHJXi31sRihT2SvjSgCDfUSjH
         bWn9FdDEzAQeP7rmhghXGQKbLzlchs6XCqH5EzyloG3qpu9bcNpOfUK1etejinAQa+la
         quNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704917; x=1780309717;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdzZmfAIN3LPbPP0nv+Qm5fhePKQlLgg7whbOXfUIqE=;
        b=WwEShzKLPR8SStF0mvutinHTj3rstwSh87PFHmOdJ39SjqtbxF8VNl0EatLlI6jgF5
         gPxS/4OH6IllY9K6+CBlUQ6JRVVXPxiNCc+TUE/K/f5utSn7qYpjpYC/iYPu3vtsJKEa
         /325kDEBDhj3vSkol1TS0sGlhn4SqsEfg9Gejo8jjVbaToUj9x4ye1byV+NowfShWTip
         v+bfPlY9Q5c0ajEZanSDVnR8k1kS2eKS7ybilRIUQSvndDZB+pcYkVQARp4jjA/qBxg/
         QBJ16vYPh04HtMB8eEfqiXcBrqQSvoW9/qx14KyDQXqjYHUMPbu+h9KjZAS+iLFtVngM
         kqFw==
X-Gm-Message-State: AOJu0YyEqWhZ8cwm19rSdNahzS5Y4mQEG2YKQ8JV+1pnCF3fM3k5gPvJ
	9ih7FGFbi+O6z9mukc8FZBRZDiBcAvW0Oj7b+FJTAomeA+Balqv1ONBuqtL2bpFD
X-Gm-Gg: Acq92OELK3yKUU/zRKcYgvPCZHSKJC+n/54kJTzAErD9Ca2vLBXhmSiSjCY46mU7aSh
	DhKLqRsJAW9eaXa5SDlIUM7/jkakhMzgW9u4ji43pthORWVR6zxJjqUOPMbG1WeRu2tNUhgco04
	5vvn73Tmo1zem6lzREMMKLZe+RK/pZZ+33raCoowrB3DDUz7slUOZ5wL4q17DSjsTqBD6At+tNL
	RHQFkEIIKEM8hrcGIP9jSQV2RvBMfMNFVtna6Htz70n2iSHES79uLaGVcuKNJo4K1jcilcYWrKS
	L+B6zFRKSuh7+5wq1MkwlbJ20KbBW0pefSP3EbEQoy5bZRFmNVTLfkRyBBuZkWA2iN5LcRvmrk0
	l4uuXRjFsF8gyzsd9uubdcaPHNQvdV1mzVn8+NGh6wiBSOJmjQrKyXcaru2C2oyvZQ4XOyz41Ru
	bDI3c6NAuSOuc2oYLoBtW7psTPOQ==
X-Received: by 2002:a05:6214:5a03:b0:8a6:1216:fb78 with SMTP id 6a1803df08f44-8cc7b5eaecamr218911306d6.46.1779704916895;
        Mon, 25 May 2026 03:28:36 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306d70sm104817156d6.35.2026.05.25.03.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:36 -0700 (PDT)
Message-Id: <60a420ea38b852570d55cf059e68b08d773571dd.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:26 +0000
Subject: [PATCH v2 5/6] doc: convert git-apply synopsis and options to new
 style
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

Convert git-apply from [verse]/single-quote style to the modern
synopsis-block style:

- Replace [verse] with [synopsis] in SYNOPSIS block
- Backtick-quote all OPTIONS terms and config keys in config/apply.adoc
- Convert single-quoted inline commands ('git apply', 'diff', etc.)
- Wrap standalone placeholders in underscores (<n>, <root>, <action>)
- Backtick-quote `*.rej` and GNU `patch` tool references

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/apply.adoc |  17 +++--
 Documentation/git-apply.adoc    | 125 ++++++++++++++++----------------
 2 files changed, 74 insertions(+), 68 deletions(-)

diff --git a/Documentation/config/apply.adoc b/Documentation/config/apply.adoc
index f9908e210a..36fcea6291 100644
--- a/Documentation/config/apply.adoc
+++ b/Documentation/config/apply.adoc
@@ -1,11 +1,16 @@
-apply.ignoreWhitespace::
-	When set to 'change', tells 'git apply' to ignore changes in
+`apply.ignoreWhitespace`::
+	When set to `change`, tells `git apply` to ignore changes in
 	whitespace, in the same way as the `--ignore-space-change`
 	option.
-	When set to one of: no, none, never, false, it tells 'git apply' to
+	When set to one of: `no`, `none`, `never`, `false`, it tells `git apply` to
 	respect all whitespace differences.
+ifndef::git-apply[]
 	See linkgit:git-apply[1].
+endif::git-apply[]
 
-apply.whitespace::
-	Tells 'git apply' how to handle whitespace, in the same way
-	as the `--whitespace` option. See linkgit:git-apply[1].
+`apply.whitespace`::
+	Tells `git apply` how to handle whitespace, in the same way
+	as the `--whitespace` option.
+ifndef::git-apply[]
+	See linkgit:git-apply[1].
+endif::git-apply[]
diff --git a/Documentation/git-apply.adoc b/Documentation/git-apply.adoc
index 6c71ee69da..3f22dac1ce 100644
--- a/Documentation/git-apply.adoc
+++ b/Documentation/git-apply.adoc
@@ -8,8 +8,8 @@ git-apply - Apply a patch to files and/or to the index
 
 SYNOPSIS
 --------
-[verse]
-'git apply' [--stat] [--numstat] [--summary] [--check]
+[synopsis]
+git apply [--stat] [--numstat] [--summary] [--check]
 	  [--index | --intent-to-add] [--3way] [--ours | --theirs | --union]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
@@ -35,33 +35,33 @@ linkgit:git-format-patch[1] and/or received by email.
 
 OPTIONS
 -------
-<patch>...::
-	The files to read the patch from.  '-' can be used to read
+`<patch>...`::
+	The files to read the patch from.  `-` can be used to read
 	from the standard input.
 
---stat::
+`--stat`::
 	Instead of applying the patch, output diffstat for the
 	input.  Turns off "apply".
 
---numstat::
+`--numstat`::
 	Similar to `--stat`, but shows the number of added and
 	deleted lines in decimal notation and the pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.  Turns off "apply".
 
---summary::
+`--summary`::
 	Instead of applying the patch, output a condensed
 	summary of information obtained from git diff extended
 	headers, such as creations, renames, and mode changes.
 	Turns off "apply".
 
---check::
+`--check`::
 	Instead of applying the patch, see if the patch is
 	applicable to the current working tree and/or the index
 	file and detects errors.  Turns off "apply".
 
---index::
+`--index`::
 	Apply the patch to both the index and the working tree (or
 	merely check that it would apply cleanly to both if `--check` is
 	in effect). Note that `--index` expects index entries and
@@ -70,13 +70,13 @@ OPTIONS
 	raise an error if they are not, even if the patch would apply
 	cleanly to both the index and the working tree in isolation.
 
---cached::
+`--cached`::
 	Apply the patch to just the index, without touching the working
 	tree. If `--check` is in effect, merely check that it would
 	apply cleanly to the index entry.
 
--N::
---intent-to-add::
+`-N`::
+`--intent-to-add`::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
 	option in linkgit:git-add[1]). This option is ignored if
@@ -84,8 +84,8 @@ OPTIONS
 	repository. Note that `--index` could be implied by other options
 	such as `--3way`.
 
--3::
---3way::
+`-3`::
+`--3way`::
 	Attempt 3-way merge if the patch records the identity of blobs it is supposed
 	to apply to and we have those blobs available locally, possibly leaving the
 	conflict markers in the files in the working tree for the user to
@@ -94,14 +94,14 @@ OPTIONS
 	When used with the `--cached` option, any conflicts are left at higher stages
 	in the cache.
 
---ours::
---theirs::
---union::
+`--ours`::
+`--theirs`::
+`--union`::
 	Instead of leaving conflicts in the file, resolve conflicts favouring
-	our (or their or both) side of the lines. Requires --3way.
+	our (or their or both) side of the lines. Requires `--3way`.
 
---build-fake-ancestor=<file>::
-	Newer 'git diff' output has embedded 'index information'
+`--build-fake-ancestor=<file>`::
+	Newer `git diff` output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
 	the original versions of the blobs are available locally,
@@ -110,18 +110,18 @@ OPTIONS
 When a pure mode change is encountered (which has no index information),
 the information is read from the current index instead.
 
--R::
---reverse::
+`-R`::
+`--reverse`::
 	Apply the patch in reverse.
 
---reject::
-	For atomicity, 'git apply' by default fails the whole patch and
+`--reject`::
+	For atomicity, `git apply` by default fails the whole patch and
 	does not touch the working tree when some of the hunks
 	do not apply.  This option makes it apply
 	the parts of the patch that are applicable, and leave the
-	rejected hunks in corresponding *.rej files.
+	rejected hunks in corresponding `*.rej` files.
 
--z::
+`-z`::
 	When `--numstat` has been given, do not munge pathnames,
 	but use a NUL-terminated machine-readable format.
 +
@@ -129,20 +129,20 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
--p<n>::
-	Remove <n> leading path components (separated by slashes) from
+`-p<n>`::
+	Remove _<n>_ leading path components (separated by slashes) from
 	traditional diff paths. E.g., with `-p2`, a patch against
 	`a/dir/file` will be applied directly to `file`. The default is
 	1.
 
--C<n>::
-	Ensure at least <n> lines of surrounding context match before
+`-C<n>`::
+	Ensure at least _<n>_ lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
 
---unidiff-zero::
-	By default, 'git apply' expects that the patch being
+`--unidiff-zero`::
+	By default, `git apply` expects that the patch being
 	applied is a unified diff with at least one line of context.
 	This provides good safety measures, but breaks down when
 	applying a diff generated with `--unified=0`. To bypass these
@@ -151,34 +151,34 @@ linkgit:git-config[1]).
 Note, for the reasons stated above, the usage of context-free patches is
 discouraged.
 
---apply::
+`--apply`::
 	If you use any of the options marked "Turns off
-	'apply'" above, 'git apply' reads and outputs the
+	'apply'" above, `git apply` reads and outputs the
 	requested information without actually applying the
 	patch.  Give this flag after those flags to also apply
 	the patch.
 
---no-add::
+`--no-add`::
 	When applying a patch, ignore additions made by the
 	patch.  This can be used to extract the common part between
-	two files by first running 'diff' on them and applying
+	two files by first running `diff` on them and applying
 	the result with this option, which would apply the
 	deletion part but not the addition part.
 
---allow-binary-replacement::
---binary::
+`--allow-binary-replacement`::
+`--binary`::
 	Historically we did not allow binary patch application
 	without an explicit permission from the user, and this
 	flag was the way to do so.  Currently, we always allow binary
 	patch application, so this is a no-op.
 
---exclude=<path-pattern>::
-	Don't apply changes to files matching the given path pattern. This can
+`--exclude=<path-pattern>`::
+	Don't apply changes to files matching _<path-pattern>_. This can
 	be useful when importing patchsets, where you want to exclude certain
 	files or directories.
 
---include=<path-pattern>::
-	Apply changes to files matching the given path pattern. This can
+`--include=<path-pattern>`::
+	Apply changes to files matching the _<path-pattern>_. This can
 	be useful when importing patchsets, where you want to include certain
 	files or directories.
 +
@@ -188,15 +188,15 @@ patch to each path is used.  A patch to a path that does not match any
 include/exclude pattern is used by default if there is no include pattern
 on the command line, and ignored if there is any include pattern.
 
---ignore-space-change::
---ignore-whitespace::
+`--ignore-space-change`::
+`--ignore-whitespace`::
 	When applying a patch, ignore changes in whitespace in context
 	lines if necessary.
 	Context lines will preserve their whitespace, and they will not
 	undergo whitespace fixing regardless of the value of the
 	`--whitespace` option. New lines will still be fixed, though.
 
---whitespace=<action>::
+`--whitespace=<action>`::
 	When applying a patch, detect a new or modified line that has
 	whitespace errors.  What are considered whitespace errors is
 	controlled by `core.whitespace` configuration.  By default,
@@ -209,7 +209,7 @@ By default, the command outputs warning messages but applies the patch.
 When `git-apply` is used for statistics and not applying a
 patch, it defaults to `nowarn`.
 +
-You can use different `<action>` values to control this
+You can use different _<action>_ values to control this
 behavior:
 +
 * `nowarn` turns off the trailing whitespace warning.
@@ -223,48 +223,48 @@ behavior:
   to apply the patch.
 * `error-all` is similar to `error` but shows all errors.
 
---inaccurate-eof::
-	Under certain circumstances, some versions of 'diff' do not correctly
+`--inaccurate-eof`::
+	Under certain circumstances, some versions of `diff` do not correctly
 	detect a missing new-line at the end of the file. As a result, patches
-	created by such 'diff' programs do not record incomplete lines
+	created by such `diff` programs do not record incomplete lines
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Suppress stderr output. Messages about patch status and progress
 	will not be printed.
 
---recount::
+`--recount`::
 	Do not trust the line counts in the hunk headers, but infer them
 	by inspecting the patch (e.g. after editing the patch without
 	adjusting the hunk headers appropriately).
 
---directory=<root>::
-	Prepend <root> to all filenames.  If a "-p" argument was also passed,
+`--directory=<root>`::
+	Prepend _<root>_ to all filenames.  If a `-p` argument was also passed,
 	it is applied before prepending the new root.
 +
 For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
---unsafe-paths::
+`--unsafe-paths`::
 	By default, a patch that affects outside the working area
 	(either a Git controlled working tree, or the current working
-	directory when "git apply" is used as a replacement of GNU
-	patch) is rejected as a mistake (or a mischief).
+	directory when `git apply` is used as a replacement of GNU
+	`patch`) is rejected as a mistake (or a mischief).
 +
-When `git apply` is used as a "better GNU patch", the user can pass
+When `git apply` is used as a "better GNU `patch`", the user can pass
 the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
---allow-empty::
+`--allow-empty`::
 	Don't return an error for patches containing no diff. This includes
 	empty patches and patches with commit text only.
 
@@ -273,11 +273,12 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.adoc[]
 
+:git-apply: 1
 include::config/apply.adoc[]
 
 SUBMODULES
 ----------
-If the patch contains any changes to submodules then 'git apply'
+If the patch contains any changes to submodules then `git apply`
 treats these changes as follows.
 
 If `--index` is specified (explicitly or implicitly), then the submodule
-- 
gitgitgadget

