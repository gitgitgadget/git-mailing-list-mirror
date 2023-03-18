Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC8C74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCRP1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCRP1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:27:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D682735
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:27:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so5018727wmq.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679153264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H94k5FWa9ZYpGz0XoP36VrczIYkyPbg8t1RSMiNr2s=;
        b=jmRZWDSRS9ACcI0jKOj7MTdHS1KnLygmSG/iDr24lOKu59DetBYJ3aElZeTIF4CIEG
         43WKrdh/TEJiH/MfS0/Q0CL1HsFfDaRf4g3869WFaajYraCACYO2OGEMBximzssFakNY
         cmKzV7GqySIw0ikLTvFFa7yi6Wu9AQW2BBl4eCj4X/KYASVmeGWil9PlHOaPM71zHD4D
         7D/n93NrgfNBTihYNZjWu7VmI8XN0HQzBV/qecEVeLzxWoWZ9L9WYiykONV3PjyHmj7p
         AU8jQpegzpUBYqsuDbkZRIPgUJA8mck0J9/jPZuL1YMpxZ8IsdCz02Zs2cn9U0gfxtb5
         +kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679153264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H94k5FWa9ZYpGz0XoP36VrczIYkyPbg8t1RSMiNr2s=;
        b=xDfYW2JoWb9qaon9ooCOPdFVmmqv78b6H7JP/qze6X8F9UTVO7ZH1tpHotPsJCOYLR
         KzX/z1xFqMEYSEPS+lDprOeEfjy3M4LAWaExqDESBJ46Z0TVqGLvTbT47PwkKR00l+Qb
         VFBHZekhfcTwg5H9E0iSGPJ6BgRwNTIV4u80cdMuCamzdn0QP5CbOwSgqxmfQrm5j0oh
         +XDexmuW11Pg2H4BQfmkXruDVbNQUQggJ5JIOl5fZCh/7/WdMdG6L6XdUqrvhfk3g79J
         ncZ4g+SRwmQt6BIGQISzmcz6fLuwYKMMHkyZYYEhsIIYn5iChxLU4sMgkx6cWQNn0sX8
         Z2qg==
X-Gm-Message-State: AO0yUKXJ4wNc0uqz3SRvPl5uD77ORU00pb6vzzFkxPVKCrQpa+1Yb9+m
        evFcdnqEmFBKnj0+VCQV4VJVCepNmD4=
X-Google-Smtp-Source: AK7set/GBwXPM5dBXYBbG+bdUqe8YOul+kFjxLAQFpnqzmBpUS9+iRjLJ9MU1l4sD6GNc9X6ml3d5A==
X-Received: by 2002:a1c:7903:0:b0:3ed:b1ee:8a67 with SMTP id l3-20020a1c7903000000b003edb1ee8a67mr1661591wme.27.1679153264413;
        Sat, 18 Mar 2023 08:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b003daffc2ecdesm10947587wms.13.2023.03.18.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:27:44 -0700 (PDT)
Message-Id: <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
References: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Mar 2023 15:27:43 +0000
Subject: [PATCH v4] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

When no merge.tool or diff.tool is configured or manually selected, the
selection of a default tool is sensitive to the DISPLAY variable; in a
GUI session a gui-specific tool will be proposed if found, and
otherwise a terminal-based one. This "GUI-optimizing" behavior is
important because a GUI can make a huge difference to a user's ability
to understand and correctly complete a non-trivial conflicting merge.

Some time ago the merge.guitool and diff.guitool config options were
introduced to enable users to configure both a GUI tool, and a non-GUI
tool (with fallback if no GUI tool configured), in the same environment.

Unfortunately, the --gui argument introduced to support the selection of
the guitool is still explicit. When using configured tools, there is no
equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
environment" behavior.

As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuration
options, difftool.guiDefault and mergetool.guiDefault, supporting a special
value "auto" which causes the corresponding tool or guitool to be selected
depending on the presence of a non-empty DISPLAY value. Also support "true"
to say "default to the guitool (unless --no-gui is passed on the
commandline)", and "false" as the previous default behavior when these new
configuration options are not specified.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
    
    A few months later, first "real" submission - 4th version wrt original
    draft.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1381%2FTaoK%2Ftao-mergetool-autogui-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1381/TaoK/tao-mergetool-autogui-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1381

Range-diff vs v3:

 1:  dbb80499218 ! 1:  765abfe7fc4 RFC: mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    RFC: mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
     +    mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
      
          When no merge.tool or diff.tool is configured or manually selected, the
          selection of a default tool is sensitive to the DISPLAY variable; in a


 Documentation/config/difftool.txt  |  7 ++++
 Documentation/config/mergetool.txt |  7 ++++
 Documentation/git-difftool.txt     | 10 +++---
 Documentation/git-mergetool.txt    |  9 +++---
 builtin/difftool.c                 | 16 ++++++---
 git-difftool--helper.sh            |  5 +++
 git-mergetool--lib.sh              | 40 +++++++++++++++++++++++
 git-mergetool.sh                   |  9 ++++--
 t/t7610-mergetool.sh               | 38 ++++++++++++++++++++++
 t/t7800-difftool.sh                | 52 ++++++++++++++++++++++++++++++
 10 files changed, 179 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index a3f82112102..447c40d85a2 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -34,3 +34,10 @@ See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.guiDefault::
+	Set `true` to use the `diff.guitool` by default (equivalent to specifying
+	the `--gui` argument), or `auto` to select `diff.guitool` or `diff.tool`
+	depending on the presence of a `DISPLAY` environment variable value. The
+	default is `false`, where the `--gui` argument must be provided
+	explicitly for the `diff.guitool` to be used.
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index e779a122d8a..56a7eeeffb4 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -85,3 +85,10 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.guiDefault::
+	Set `true` to use the `merge.guitool` by default (equivalent to
+	specifying the `--gui` argument), or `auto` to select `merge.guitool`
+	or `merge.tool` depending on the presence of a `DISPLAY` environment
+	variable value. The default is `false`, where the `--gui` argument
+	must be provided explicitly for the `merge.guitool` to be used.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 9d14c3c9f09..ac0ac6fa022 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -97,10 +97,12 @@ instead.  `--no-symlinks` is the default on Windows.
 --[no-]gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
-	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
-	option can be used to override this setting. If `diff.guitool`
-	is not set, we will fallback in the order of `merge.guitool`,
-	`diff.tool`, `merge.tool` until a tool is found.
+	`diff.guitool` variable instead of `diff.tool`. This may be
+	selected automatically using the configuration variable
+	`difftool.guiDefault`. The `--no-gui` option can be used to
+	override these settings. If `diff.guitool` is not set, we will
+	fallback in the order of `merge.guitool`, `diff.tool`,
+	`merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index c44e205629b..07535f6576e 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -85,12 +85,13 @@ success of the resolution after the custom tool has exited.
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
-	configured under `merge.tool`.
+	configured under `merge.tool`. This may be autoselected using
+	the configuration variable `mergetool.guiDefault`.
 
 --no-gui::
-	This overrides a previous `-g` or `--gui` setting and reads the
-	default merge tool will be read from the configured `merge.tool`
-	variable.
+	This overrides a previous `-g` or `--gui` setting or
+	`mergetool.guiDefault` configuration and reads the default merge
+	tool from the configured `merge.tool` variable.
 
 -O<orderfile>::
 	Process files in the order specified in the
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dbbfb19f192..88a00abfbdb 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -684,7 +684,7 @@ static int run_file_diff(int prompt, const char *prefix,
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
-	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
+	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
 	    tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
@@ -734,13 +734,21 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	die_for_incompatible_opt3(use_gui_tool, "--gui",
+	die_for_incompatible_opt3(use_gui_tool == 1, "--gui",
 				  !!difftool_cmd, "--tool",
 				  !!extcmd, "--extcmd");
 
-	if (use_gui_tool)
+	/*
+	 * Explicitly specified GUI option is forwarded to git-mergetool--lib.sh;
+	 * empty or unset means "use the difftool.guiDefault config or default to
+	 * false".
+	 */
+	if (use_gui_tool == 1)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
-	else if (difftool_cmd) {
+	else if (use_gui_tool == 0)
+		setenv("GIT_MERGETOOL_GUI", "false", 1);
+
+	if (difftool_cmd) {
 		if (*difftool_cmd)
 			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
 		else
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 992124cc67c..e4e820e6809 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -75,6 +75,11 @@ then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
 		merge_tool="$(get_merge_tool)"
+		subshell_exit_status=$?
+		if test $subshell_exit_status -gt 1
+		then
+			exit $subshell_exit_status
+		fi
 	fi
 fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9f99201bcca..1ff26170ffc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -97,7 +97,42 @@ merge_mode () {
 	test "$TOOL_MODE" = merge
 }
 
+get_gui_default () {
+	if diff_mode
+	then
+		GUI_DEFAULT_KEY="difftool.guiDefault"
+	else
+		GUI_DEFAULT_KEY="mergetool.guiDefault"
+	fi
+	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get "$GUI_DEFAULT_KEY" | tr 'A-Z' 'a-z')
+	if test "$GUI_DEFAULT_CONFIG_LCASE" = "auto"
+	then
+		if test -n "$DISPLAY"
+		then
+			GUI_DEFAULT=true
+		else
+			GUI_DEFAULT=false
+		fi
+	else
+		GUI_DEFAULT=$(git config --default false --bool --get "$GUI_DEFAULT_KEY")
+		subshell_exit_status=$?
+		if test $subshell_exit_status -ne 0
+		then
+			exit $subshell_exit_status
+		fi
+	fi
+	echo $GUI_DEFAULT
+}
+
 gui_mode () {
+	if test -z "$GIT_MERGETOOL_GUI"
+	then
+		GIT_MERGETOOL_GUI=$(get_gui_default)
+		if test $? -ne 0
+		then
+			exit 2
+		fi
+	fi
 	test "$GIT_MERGETOOL_GUI" = true
 }
 
@@ -467,6 +502,11 @@ get_merge_tool () {
 	is_guessed=false
 	# Check if a merge tool has been configured
 	merge_tool=$(get_configured_merge_tool)
+	subshell_exit_status=$?
+	if test $subshell_exit_status -gt "1"
+	then
+		exit $subshell_exit_status
+	fi
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
diff --git a/git-mergetool.sh b/git-mergetool.sh
index f751d9cfe20..8a922893f75 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -451,7 +451,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	GIT_MERGETOOL_GUI=false
+	GIT_MERGETOOL_GUI=
 	guessed_merge_tool=false
 	orderfile=
 
@@ -511,9 +511,14 @@ main () {
 
 	if test -z "$merge_tool"
 	then
-		if ! merge_tool=$(get_merge_tool)
+		merge_tool=$(get_merge_tool)
+		subshell_exit_status=$?
+		if test $subshell_exit_status = 1
 		then
 			guessed_merge_tool=true
+		elif test $subshell_exit_status -gt 1
+		then
+			exit $subshell_exit_status
 		fi
 	fi
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 7b957022f1a..22b3a85b3e9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -860,4 +860,42 @@ test_expect_success 'mergetool hideResolved' '
 	git commit -m "test resolved with mergetool"
 '
 
+test_expect_success 'mergetool with guiDefault' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge main &&
+
+	test_config mergetool.guiDefault auto &&
+	DISPLAY=SOMETHING && export DISPLAY &&
+	yes "" | git mergetool both &&
+	yes "" | git mergetool file1 file1 &&
+
+	DISPLAY= && export DISPLAY &&
+	yes "" | git mergetool file2 "spaced name" &&
+
+	test_config mergetool.guiDefault true &&
+	yes "" | git mergetool subdir/file3 &&
+
+	yes "d" | git mergetool file11 &&
+	yes "d" | git mergetool file12 &&
+	yes "l" | git mergetool submod &&
+
+	echo "gui main updated" >expect &&
+	test_cmp expect file1 &&
+
+	echo "main new" >expect &&
+	test_cmp expect file2 &&
+
+	echo "gui main new sub" >expect &&
+	test_cmp expect subdir/file3 &&
+
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_done
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 24297e26ca0..59d3847bf87 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -155,6 +155,58 @@ test_expect_success 'difftool honors --gui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'difftool with guiDefault auto selects gui tool when there is DISPLAY' '
+	difftool_test_setup &&
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	test_config difftool.guiDefault auto &&
+	DISPLAY=SOMETHING && export DISPLAY &&
+
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'difftool with guiDefault auto selects regular tool when no DISPLAY' '
+	difftool_test_setup &&
+	test_config diff.guitool bogus-tool &&
+	test_config diff.tool test-tool &&
+	test_config difftool.guiDefault Auto &&
+	DISPLAY= && export DISPLAY &&
+
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'difftool with guiDefault true selects gui tool' '
+	difftool_test_setup &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	test_config difftool.guiDefault true &&
+
+	DISPLAY= && export DISPLAY &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
+
+	DISPLAY=Something && export DISPLAY &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'difftool --no-gui trumps config guiDefault' '
+	difftool_test_setup &&
+	test_config diff.guitool bogus-tool &&
+	test_config diff.tool test-tool &&
+	test_config difftool.guiDefault true &&
+
+	echo branch >expect &&
+	git difftool --no-prompt --no-gui branch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'difftool --gui last setting wins' '
 	difftool_test_setup &&
 	: >expect &&

base-commit: d15644fe0226af7ffc874572d968598564a230dd
-- 
gitgitgadget
