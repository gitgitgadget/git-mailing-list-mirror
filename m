Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D293081D7
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322773; cv=none; b=kMc6Qzudjba+cS/HtMpR5OnZ7bK8WqBPZrhJGn9PDJ/nTA7E3L3AbXgqfzpHQd88TbeeNbdtQHPdooRQxLGOjTjRNoRJ7mPrvrlRfrfIVNHzVgJt7+Z5rXU3d2d+EzaeYKIcUrya3PQKN0WY2ZiqHnV+yP+oAmGYeTDwA6su2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322773; c=relaxed/simple;
	bh=/6R2opT7DfLBTSAzw8tqYDRICumkqZAOK/RR7b4CaQ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=HlWcEc/5xyoqUDlkTpFgembuqLe/7n+SRoby4zPyluFDX5ua+AZ5bPa84alMTOeHHWZyNFORjV3IhtBzG4SxFVJVwkl3bYov9eaBQgwXPw0ucTc0oe61YdjfBpzGaCAiiHvHHC9EQFvGUG/ZHUIizSOFGMueTlo6W22GTRcDE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B50U1luo; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B50U1luo"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1273349c56bso3407446c88.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775322770; x=1775927570; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1nToj/eEzPaaVrth1AeCO/+sH4d7TFKglYKNdo1bmo=;
        b=B50U1luoBgfUbQvtViu0XfsnzDQwtPKslMNc+uD2QkKGN1itN6oE/KHEc71ox19T78
         TYaMS3PQpSJ3bdXslMYfJT8Jh7SX+6biFjBtsjwQJaJyLUIByQp+Nj3laxAmUCmPdUJX
         u5q5TbzmqoQpkKEAwtx2pm1WeF3rJ6VeGsFad6xeqetcvtb7zqwfAnDGMWKBX4Do0Cwm
         DcmTcueQFZpGh/vQr8UVS1hooBR+CLMcTundH8Qc5cmiYLqO6ab6+B0YWUGflwpPux1s
         k/yQ5oJJInzl44MWF45aSptF/wfCQZ7Z+ryqr4GddP9JsQRSz7s8MlXc9R2MadkHNJs3
         Un6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322770; x=1775927570;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1nToj/eEzPaaVrth1AeCO/+sH4d7TFKglYKNdo1bmo=;
        b=JUn1Sp2yISW+ybK3Q/VxhCeIFoNWFu5mbKkz7T3I2jJ1XVSSNhXDo3WsXQGbNVmeCD
         85Xm36W4MUDdghNwzaatdV/tQF2AolObDqDRvaU9HBJVQ/59094SlqAUyxCJszJsoVhm
         uVMtV9BbSUUuEh9cE57XW37EJA/RiFBnhu7W4f1eF0PttqW0SCTQ4Pve8bwp0W03uw1F
         Zo5xJF3EGxHYGBd36GVthxCJgHzdZERZsgbzeD+rVlIYq6u541f/IiuC0D5yczqk69MK
         GyYWBNW7RP078ERPhugZ7bLQsBIcp+44U8lux1A30eFRLUHm3BVGmvSZDtk+KFNrNFlY
         ovQA==
X-Gm-Message-State: AOJu0YyecdRpVV28m1pvzUYLMTQme1jrwLkRTHtd11f4Dnueo3JfI6k0
	EVnfS89rwTq8grDjKgMtX7ipIZHvS6gzQhyLO5SOO1fnFj/O0TC2wUyEe8svOg==
X-Gm-Gg: AeBDieu6T2KIfeY0eY+NNyovkTmb9N3c4YvCBFXOJi4WqQHKW/A0KQrK5JzhoTJ4PMo
	/WMoRpMBySbUWfIWsVh0TSCPqCAximje6aDo/CJZwNp/TZdH1Mqn4U2nYRIAZ+nxHlFUj9iWSe/
	ODJiL3fkE6rmWu3ENSYI82djYZH/wBMYmjbEQ2Ckgjb4yPAIzzgjNUF/4jbnOQD/QcIaRWO6NBd
	nkQZNRXBNuM9J3godRTV8Fd9N4KjT8kA3e/LE3QNg1beX9Es4RCJL7QOvY3k2ah/ed0s96uGVh4
	L5pUr8GoIPOivW/WqJUyoEk1oLhQ+Hgl2bp+AcaZ5GhkcW76dsemm7lshnbcSHD01dmjVsnEiLR
	SlI3AzI+jB84S7kQhivqvkhcDxU3clgWEFBid1cQ4G0EJjjzWPWIZ0R2LZsorg2BANOAAN6yc/E
	Lg97hRMDGrpGBQiNhbPAZMiwLNxQ==
X-Received: by 2002:a05:7022:f319:b0:12c:8b9:7200 with SMTP id a92af1059eb24-12c08b9733cmr83430c88.17.1775322770369;
        Sat, 04 Apr 2026 10:12:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.111.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd70f18sm7224300c88.6.2026.04.04.10.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:12:49 -0700 (PDT)
Message-Id: <f9d931db328024fa7a437fd80580dce6cea673d8.1775322767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
References: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 17:12:44 +0000
Subject: [PATCH 1/4] doc: convert git-difftool manual page to synopsis style
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

     * convert commands to synopsis style
     * use _<placeholder>_ for arguments
     * fix conditional text to sentence limits

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/difftool.adoc  | 24 ++++-----
 Documentation/config/mergetool.adoc |  8 +--
 Documentation/git-difftool.adoc     | 80 ++++++++++++++---------------
 3 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/config/difftool.adoc b/Documentation/config/difftool.adoc
index 4f7d40ce24..1b8d483813 100644
--- a/Documentation/config/difftool.adoc
+++ b/Documentation/config/difftool.adoc
@@ -1,43 +1,43 @@
-diff.tool::
+`diff.tool`::
 	Controls which diff tool is used by linkgit:git-difftool[1].
 	This variable overrides the value configured in `merge.tool`.
 	The list below shows the valid built-in values.
 	Any other value is treated as a custom diff tool and requires
-	that a corresponding difftool.<tool>.cmd variable is defined.
+	that a corresponding `difftool.<tool>.cmd` variable is defined.
 
-diff.guitool::
+`diff.guitool`::
 	Controls which diff tool is used by linkgit:git-difftool[1] when
-	the -g/--gui flag is specified. This variable overrides the value
+	the `-g`/`--gui` flag is specified. This variable overrides the value
 	configured in `merge.guitool`. The list below shows the valid
 	built-in values. Any other value is treated as a custom diff tool
-	and requires that a corresponding difftool.<guitool>.cmd variable
+	and requires that a corresponding `difftool.<guitool>.cmd` variable
 	is defined.
 
 include::{build_dir}/mergetools-diff.adoc[]
 
-difftool.<tool>.cmd::
+`difftool.<tool>.cmd`::
 	Specify the command to invoke the specified diff tool.
 	The specified command is evaluated in shell with the following
-	variables available:  'LOCAL' is set to the name of the temporary
-	file containing the contents of the diff pre-image and 'REMOTE'
+	variables available: `LOCAL` is set to the name of the temporary
+	file containing the contents of the diff pre-image and `REMOTE`
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
 +
 See the `--tool=<tool>` option in linkgit:git-difftool[1] for more details.
 
-difftool.<tool>.path::
+`difftool.<tool>.path`::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
-difftool.trustExitCode::
+`difftool.trustExitCode`::
 	Exit difftool if the invoked diff tool returns a non-zero exit status.
 +
 See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
-difftool.prompt::
+`difftool.prompt`::
 	Prompt before each invocation of the diff tool.
 
-difftool.guiDefault::
+`difftool.guiDefault`::
 	Set `true` to use the `diff.guitool` by default (equivalent to specifying
 	the `--gui` argument), or `auto` to select `diff.guitool` or `diff.tool`
 	depending on the presence of a `DISPLAY` environment variable value. The
diff --git a/Documentation/config/mergetool.adoc b/Documentation/config/mergetool.adoc
index 7064f5a462..7afdcad92b 100644
--- a/Documentation/config/mergetool.adoc
+++ b/Documentation/config/mergetool.adoc
@@ -52,13 +52,13 @@
 	if `merge.tool` is configured as _<variant>_), Git will consult
 	`mergetool.<variant>.layout` to determine the tool's layout. If the
 	variant-specific configuration is not available, `vimdiff` ' s is used as
-	fallback.  If that too is not available, a default layout with 4 windows
-	will be used.  To configure the layout, see the 'BACKEND SPECIFIC HINTS'
+	fallback. If that too is not available, a default layout with 4 windows
+	will be used.
 ifdef::git-mergetool[]
-	section.
+To configure the layout, see the 'BACKEND SPECIFIC HINTS' section.
 endif::[]
 ifndef::git-mergetool[]
-	section in linkgit:git-mergetool[1].
+To configure the layout, see the 'BACKEND SPECIFIC HINTS' section in linkgit:git-mergetool[1].
 endif::[]
 
 `mergetool.hideResolved`::
diff --git a/Documentation/git-difftool.adoc b/Documentation/git-difftool.adoc
index 064bc68347..dd7cacf95e 100644
--- a/Documentation/git-difftool.adoc
+++ b/Documentation/git-difftool.adoc
@@ -7,64 +7,64 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-[verse]
-'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
+[synopsis]
+git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]
 
 DESCRIPTION
 -----------
-'git difftool' is a Git command that allows you to compare and edit files
-between revisions using common diff tools.  'git difftool' is a frontend
-to 'git diff' and accepts the same options and arguments. See
+`git difftool` is a Git command that allows you to compare and edit files
+between revisions using common diff tools. `git difftool` is a frontend
+to `git diff` and accepts the same options and arguments. See
 linkgit:git-diff[1].
 
 OPTIONS
 -------
--d::
---dir-diff::
+`-d`::
+`--dir-diff`::
 	Copy the modified files to a temporary location and perform
 	a directory diff on them. This mode never prompts before
 	launching the diff tool.
 
--y::
---no-prompt::
+`-y`::
+`--no-prompt`::
 	Do not prompt before launching a diff tool.
 
---prompt::
+`--prompt`::
 	Prompt before each invocation of the diff tool.
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
---rotate-to=<file>::
-	Start showing the diff for the given path,
+`--rotate-to=<file>`::
+	Start showing the diff for _<file>_,
 	the paths before it will move to the end and output.
 
---skip-to=<file>::
-	Start showing the diff for the given path, skipping all
+`--skip-to=<file>`::
+	Start showing the diff for _<file>_, skipping all
 	the paths before it.
 
--t <tool>::
---tool=<tool>::
-	Use the diff tool specified by <tool>.  Valid values include
+`-t <tool>`::
+`--tool=<tool>`::
+	Use the diff tool specified by _<tool>_. Valid values include
 	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
-	for the list of valid <tool> settings.
+	for the list of valid _<tool>_ settings.
 +
-If a diff tool is not specified, 'git difftool'
+If a diff tool is not specified, `git difftool`
 will use the configuration variable `diff.tool`.  If the
-configuration variable `diff.tool` is not set, 'git difftool'
+configuration variable `diff.tool` is not set, `git difftool`
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
 configuration variable `difftool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`difftool.kdiff3.path`. Otherwise, 'git difftool' assumes the
+`difftool.kdiff3.path`. Otherwise, `git difftool` assumes the
 tool is available in PATH.
 +
 Instead of running one of the known diff tools,
-'git difftool' can be customized to run an alternative program
+`git difftool` can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `difftool.<tool>.cmd`.
 +
-When 'git difftool' is invoked with this tool (either through the
+When `git difftool` is invoked with this tool (either through the
 `-t` or `--tool` option or the `diff.tool` configuration variable)
 the configured command line will be invoked with the following
 variables available: `$LOCAL` is set to the name of the temporary
@@ -74,30 +74,30 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
---tool-help::
+`--tool-help`::
 	Print a list of diff tools that may be used with `--tool`.
 
---symlinks::
---no-symlinks::
-	'git difftool''s default behavior is to create symlinks to the
+`--symlinks`::
+`--no-symlinks`::
+	`git difftool`'s default behavior is to create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
 	the working tree.
 +
-Specifying `--no-symlinks` instructs 'git difftool' to create copies
+Specifying `--no-symlinks` instructs `git difftool` to create copies
 instead.  `--no-symlinks` is the default on Windows.
 
--x <command>::
---extcmd=<command>::
+`-x <command>`::
+`--extcmd=<command>`::
 	Specify a custom command for viewing diffs.
-	'git-difftool' ignores the configured defaults and runs
+	`git-difftool` ignores the configured defaults and runs
 	`<command> $LOCAL $REMOTE` when this option is specified.
 	Additionally, `$BASE` is set in the environment.
 
--g::
---gui::
---no-gui::
-	When 'git-difftool' is invoked with the `-g` or `--gui` option
+`-g`::
+`--gui`::
+`--no-gui`::
+	When `git-difftool` is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`. This may be
 	selected automatically using the configuration variable
@@ -106,20 +106,20 @@ instead.  `--no-symlinks` is the default on Windows.
 	fallback in the order of `merge.guitool`, `diff.tool`,
 	`merge.tool` until a tool is found.
 
---trust-exit-code::
---no-trust-exit-code::
+`--trust-exit-code`::
+`--no-trust-exit-code`::
 	Errors reported by the diff tool are ignored by default.
-	Use `--trust-exit-code` to make 'git-difftool' exit when an
+	Use `--trust-exit-code` to make `git-difftool` exit when an
 	invoked diff tool returns a non-zero exit code.
 +
-'git-difftool' will forward the exit code of the invoked tool when
+`git-difftool` will forward the exit code of the invoked tool when
 `--trust-exit-code` is used.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIGURATION
 -------------
-'git difftool' falls back to 'git mergetool' config variables when the
+`git difftool` falls back to `git mergetool` config variables when the
 difftool equivalents have not been defined.
 
 include::includes/cmd-config-section-rest.adoc[]
-- 
gitgitgadget

