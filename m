Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C9C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 06:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJRGy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJRGyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 02:54:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172D2E9EF
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 23:54:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id iv17so10086345wmb.4
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XBg6I7qQHcop9QejfCLO1Rc7iYGfUKtxWSEv7oLe9U=;
        b=WFNzeX3XiaKHeKJQ9rlTwbYSbS58BnhKLnhB+WDP4KyXrA9QuFOo+MtorP9mgBI/U5
         zLWTPYpvJzJF9eRoiMShpqB24miwaZvQSHdABjGB/MHLO8f4LGei3QHMxhfMYECyed+g
         71qRR2pxL9Wtx0zrXhdW0561nOysSdl9c+VMfzIhBJ9TjETjwlqQC2F/hfYlBX3rCQnf
         Q82DUJiu9oC2+86af0HuDUmhVAl9zx/IjmiYOUOUyejMIMSrWQNaOMbJluUK1VgY6zkp
         xeeliwHlLcy4lYLwAkvWISHJz/wZ/6YDri7HragbNr81Om8HFqLPjp23/OlTXJMeeUiU
         cQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XBg6I7qQHcop9QejfCLO1Rc7iYGfUKtxWSEv7oLe9U=;
        b=2y0oub6IL6fnfkIyZzvVpXw5LLguwx3etHdZBoEsbpJ/LgfRyZ4gdbTA21bnDfKZvp
         OvWdmnlqIbohxDnD0gWyjU9Eaj1+5lOqr+R0mx9ZkJ/AW8/WSeLWRsNYJClOoIfQvdMm
         cBSHG5Hb9T7GxP7mnr3yuJB79PacdMfESZHYLohI+tpIeUvpIH3TiCSHRGggBBl+nvWP
         UeEe/zgBpGRqj3zoelVQSQTX3+7LsAV9152+2wfImfJEZYXiDwK5LQvSI0lkdWX8hw4L
         mTRgJ41K7qPkvdeKz9h1tTVwXbWkhJaG0S+q++cbjfirdX/JzKZadmEezSG+7Z9Rr/2y
         tW7A==
X-Gm-Message-State: ACrzQf0JhLvUd5cL4grJY2xt3oS4NLprAuL2qeY9YOHg6rpjJZXum0RZ
        ZAhv5x9cyDSVAWlBSf51jcFzpk+9ZQU=
X-Google-Smtp-Source: AMsMyM49mcLZo/UoLlgKTsdE9DUE/YLAM7S39p9R0KvYhOV0shOzj6mHMtAEBhNWl3v4pPRuK5Y+PA==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr878251wmb.146.1666076088942;
        Mon, 17 Oct 2022 23:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c481400b003a6125562e1sm11859585wmo.46.2022.10.17.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 23:54:48 -0700 (PDT)
Message-Id: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
References: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 06:54:46 +0000
Subject: [PATCH v3] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
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
    RFC: mergetool: new config guiDefault supports auto-toggling gui by
    DISPLAY
    
    I'm reasonably comfortable that with this patch we do the right thing,
    but I'm not sure about yet another remaining implementation detail:
    
     * After implementing Junio's recommended "fail if defaulting config is
       consulted and is invalid" flow, there now needs to be a distinction
       between subshell exit code 1, which was used before and indicates
       "tool not found or broken; falling back to default" and other
       (higher) exit codes, which newly mean "something went wrong, stop!".
       The resulting code looks awkward, I can't tell whether I'm missing a
       code or even commenting pattern that would make it clearer.
    
    V3:
    
     * Simplify C code to use OPT_BOOL with an int rather than a custom
       option-parsing function with an enum
     * Fix doc to more extensively use backticks for config keys / values /
       args
     * Fix more shell script formatting issues
     * Change error-handling in mergetool and difftool helpers to exit if
       defaulting config is invalid

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1381%2FTaoK%2Ftao-mergetool-autogui-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1381/TaoK/tao-mergetool-autogui-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1381

Range-diff vs v2:

 1:  70d0e0d09fa ! 1:  dbb80499218 RFC: mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
     @@ Documentation/config/difftool.txt: See the `--trust-exit-code` option in linkgit
       	Prompt before each invocation of the diff tool.
      +
      +difftool.guiDefault::
     -+	Set 'true' to use the diff.guitool by default (equivalent to specifying
     -+	the "--gui" argument), or "auto" to select diff.guitool or diff.tool
     -+	depending on the presence of a DISPLAY environment variable value. The
     -+	default is 'false', where the "--gui" argument must be provided
     -+	explicitly for the diff.guitool to be used.
     ++	Set `true` to use the `diff.guitool` by default (equivalent to specifying
     ++	the `--gui` argument), or `auto` to select `diff.guitool` or `diff.tool`
     ++	depending on the presence of a `DISPLAY` environment variable value. The
     ++	default is `false`, where the `--gui` argument must be provided
     ++	explicitly for the `diff.guitool` to be used.
      
       ## Documentation/config/mergetool.txt ##
      @@ Documentation/config/mergetool.txt: mergetool.writeToTemp::
     @@ Documentation/config/mergetool.txt: mergetool.writeToTemp::
       	Prompt before each invocation of the merge resolution program.
      +
      +mergetool.guiDefault::
     -+	Set 'true' to use the merge.guitool by default (equivalent to
     -+	specifying the "--gui" argument), or "auto" to select merge.guitool
     -+	or merge.tool depending on the presence of a DISPLAY environment
     -+	variable value. The default is 'false', where the "--gui" argument
     -+	must be provided explicitly for the merge.guitool to be used.
     ++	Set `true` to use the `merge.guitool` by default (equivalent to
     ++	specifying the `--gui` argument), or `auto` to select `merge.guitool`
     ++	or `merge.tool` depending on the presence of a `DISPLAY` environment
     ++	variable value. The default is `false`, where the `--gui` argument
     ++	must be provided explicitly for the `merge.guitool` to be used.
      
       ## Documentation/git-difftool.txt ##
      @@ Documentation/git-difftool.txt: instead.  `--no-symlinks` is the default on Windows.
     @@ Documentation/git-difftool.txt: instead.  `--no-symlinks` is the default on Wind
      -	is not set, we will fallback in the order of `merge.guitool`,
      -	`diff.tool`, `merge.tool` until a tool is found.
      +	`diff.guitool` variable instead of `diff.tool`. This may be
     -+	autoselected using the configuration variable
     ++	selected automatically using the configuration variable
      +	`difftool.guiDefault`. The `--no-gui` option can be used to
      +	override these settings. If `diff.guitool` is not set, we will
      +	fallback in the order of `merge.guitool`, `diff.tool`,
     @@ Documentation/git-mergetool.txt: success of the resolution after the custom tool
      
       ## builtin/difftool.c ##
      @@ builtin/difftool.c: static int run_file_diff(int prompt, const char *prefix,
     - 	return run_command(child);
     - }
       
     -+enum difftool_gui_mode {
     -+	GUI_BY_CONFIG = -1,
     -+	GUI_DISABLED = 0,
     -+	GUI_ENABLED = 1
     -+};
     -+
     -+static int difftool_opt_gui(const struct option *opt,
     -+			      const char *optarg, int unset)
     -+{
     -+	enum difftool_gui_mode *mode;
     -+	mode = opt->value;
     -+
     -+	BUG_ON_OPT_ARG(optarg);
     -+
     -+	if (unset)
     -+		*mode = GUI_DISABLED;
     -+	else
     -+		*mode = GUI_ENABLED;
     -+	return 0;
     -+}
     -+
       int cmd_difftool(int argc, const char **argv, const char *prefix)
       {
      -	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
     --	    tool_help = 0, no_index = 0;
     -+	int dir_diff = 0, prompt = -1, symlinks = 0, tool_help = 0,
     -+	    no_index = 0;
     -+	enum difftool_gui_mode gui_mode = GUI_BY_CONFIG;
     ++	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
     + 	    tool_help = 0, no_index = 0;
       	static char *difftool_cmd = NULL, *extcmd = NULL;
       	struct option builtin_difftool_options[] = {
     --		OPT_BOOL('g', "gui", &use_gui_tool,
     --			 N_("use `diff.guitool` instead of `diff.tool`")),
     -+		OPT_CALLBACK_F('g', "gui", &gui_mode, NULL,
     -+			       N_("use `diff.guitool` instead of `diff.tool`"),
     -+			       PARSE_OPT_NOARG, difftool_opt_gui),
     - 		OPT_BOOL('d', "dir-diff", &dir_diff,
     - 			 N_("perform a full-directory diff")),
     - 		OPT_SET_INT_F('y', "no-prompt", &prompt,
      @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
       	} else if (dir_diff)
       		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
       
      -	die_for_incompatible_opt3(use_gui_tool, "--gui",
     -+	die_for_incompatible_opt3(gui_mode == GUI_ENABLED, "--gui",
     ++	die_for_incompatible_opt3(use_gui_tool == 1, "--gui",
       				  !!difftool_cmd, "--tool",
       				  !!extcmd, "--extcmd");
       
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
      +	 * empty or unset means "use the difftool.guiDefault config or default to
      +	 * false".
      +	 */
     -+	if (gui_mode == GUI_ENABLED)
     ++	if (use_gui_tool == 1)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
      -	else if (difftool_cmd) {
     -+	else if (gui_mode == GUI_DISABLED)
     ++	else if (use_gui_tool == 0)
      +		setenv("GIT_MERGETOOL_GUI", "false", 1);
      +
      +	if (difftool_cmd) {
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
       		else
      
     + ## git-difftool--helper.sh ##
     +@@ git-difftool--helper.sh: then
     + 		merge_tool="$GIT_DIFF_TOOL"
     + 	else
     + 		merge_tool="$(get_merge_tool)"
     ++		subshell_exit_status=$?
     ++		if test $subshell_exit_status -gt 1
     ++		then
     ++			exit $subshell_exit_status
     ++		fi
     + 	fi
     + fi
     + 
     +
       ## git-mergetool--lib.sh ##
      @@ git-mergetool--lib.sh: merge_mode () {
       	test "$TOOL_MODE" = merge
     @@ git-mergetool--lib.sh: merge_mode () {
      +	else
      +		GUI_DEFAULT_KEY="mergetool.guiDefault"
      +	fi
     -+	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr 'A-Z' 'a-z')
     ++	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get "$GUI_DEFAULT_KEY" | tr 'A-Z' 'a-z')
      +	if test "$GUI_DEFAULT_CONFIG_LCASE" = "auto"
      +	then
      +		if test -n "$DISPLAY"
     @@ git-mergetool--lib.sh: merge_mode () {
      +			GUI_DEFAULT=false
      +		fi
      +	else
     -+		GUI_DEFAULT=$(git config --default false --bool --get $GUI_DEFAULT_KEY)
     ++		GUI_DEFAULT=$(git config --default false --bool --get "$GUI_DEFAULT_KEY")
     ++		subshell_exit_status=$?
     ++		if test $subshell_exit_status -ne 0
     ++		then
     ++			exit $subshell_exit_status
     ++		fi
      +	fi
      +	echo $GUI_DEFAULT
      +}
      +
       gui_mode () {
     -+	if [ -z "$GIT_MERGETOOL_GUI" ]
     ++	if test -z "$GIT_MERGETOOL_GUI"
      +	then
      +		GIT_MERGETOOL_GUI=$(get_gui_default)
     ++		if test $? -ne 0
     ++		then
     ++			exit 2
     ++		fi
      +	fi
       	test "$GIT_MERGETOOL_GUI" = true
       }
       
     +@@ git-mergetool--lib.sh: get_merge_tool () {
     + 	is_guessed=false
     + 	# Check if a merge tool has been configured
     + 	merge_tool=$(get_configured_merge_tool)
     ++	subshell_exit_status=$?
     ++	if test $subshell_exit_status -gt "1"
     ++	then
     ++		exit $subshell_exit_status
     ++	fi
     + 	# Try to guess an appropriate merge tool if no tool has been set.
     + 	if test -z "$merge_tool"
     + 	then
      
       ## git-mergetool.sh ##
      @@ git-mergetool.sh: print_noop_and_exit () {
     @@ git-mergetool.sh: print_noop_and_exit () {
       	guessed_merge_tool=false
       	orderfile=
       
     +@@ git-mergetool.sh: main () {
     + 
     + 	if test -z "$merge_tool"
     + 	then
     +-		if ! merge_tool=$(get_merge_tool)
     ++		merge_tool=$(get_merge_tool)
     ++		subshell_exit_status=$?
     ++		if test $subshell_exit_status = 1
     + 		then
     + 			guessed_merge_tool=true
     ++		elif test $subshell_exit_status -gt 1
     ++		then
     ++			exit $subshell_exit_status
     + 		fi
     + 	fi
     + 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
      
       ## t/t7610-mergetool.sh ##
      @@ t/t7610-mergetool.sh: test_expect_success 'mergetool hideResolved' '
     @@ t/t7610-mergetool.sh: test_expect_success 'mergetool hideResolved' '
      +	yes "d" | git mergetool file12 &&
      +	yes "l" | git mergetool submod &&
      +
     -+
      +	echo "gui main updated" >expect &&
      +	test_cmp expect file1 &&
      +


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
index 90b38097002..a615bf24187 100644
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
index 4b10ad1a369..2b89c5dc865 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -682,7 +682,7 @@ static int run_file_diff(int prompt, const char *prefix,
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
-	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
+	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
 	    tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
@@ -732,13 +732,21 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
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
index 8cc64729adb..ba0d2ae76de 100755
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
index 096456292c0..1e47d3c05bd 100755
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

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
