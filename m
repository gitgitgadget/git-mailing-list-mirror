Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE3C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJNIAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNIAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:00:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A82D7E11
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:00:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so4833343wma.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWStFqUhp+hR0494enNmxSOhX4I6TKP5Q6OEAy35xsg=;
        b=FpaWGI/E+ZfwGulP6sjVfVg3pJ2HncHabFnN08Cd8v7lv9xQrk6j1uOiW8J2zVnwFs
         XMw+JIKNKFmDMke2XGjAtw3lqiznA6+BOZdFIv4tgPUo7tiaH/ermDiiIh7nZZk6C86/
         PBnlUEMNNIVs65LDfpCyAPrVsRNAIsNg1WEfKcdXMsXm/MUBCEzl8PPPWB6th8giGD26
         vop1Oo1cuWLBLhgZOOzNbgSP4sbdL5hkyFXodJ6mQipXR2jGPRf9FWeASFB1qEbKpIGH
         /TpbtVS5GAV8U3CB5wtz+laYSa0sv1PEIVMI34+1xzk0SQlh6RFCF3SkOKwtdTItVX35
         nm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWStFqUhp+hR0494enNmxSOhX4I6TKP5Q6OEAy35xsg=;
        b=2d63YLXgHlJIBOQN75Z2Hc5/2pHp1J/l1fn9A5aygJB8kyinvhSBUoth/vCuZLvdJx
         VLzCI3K09ZTf5Ud89QekB3BF0OhFuQyEhMKKEGv+WBjZXzHNS/VBOtO2y4yeFCgLDbf3
         kin6qEZdR/12HVKNVBSjBOosN3jg2sIj2i8Y6iXFdCT16fnoHCYGapHLBEpdKg0IJ+l+
         eKE7qgfE/Aor0dB35kbebgZUvvpE1kiAteIwrmq3wkyoVALnfGdwaFFeEbYaMhtmc9cF
         kfPLaOSxoosoPFEWsc7OEOnY/oQ+n8eZnvzW6SCezdwo2KQQxB+l/5KAes7M2p2P0qy1
         QnPg==
X-Gm-Message-State: ACrzQf2hLf1NL6Tb4+R6gA1KQRdHDxg90VzS3DVLli6nFgcDobMLIlB5
        UCVtO6ttSKN6gNyhRldKTkyOnDYPSG0=
X-Google-Smtp-Source: AMsMyM68CzYfe0keF8gJm/WeW9jrs48ntGg0bUWYfjy/a65fZSfhTIGG9o5HhY40wxiv4HPFoSqUmQ==
X-Received: by 2002:a05:600c:4448:b0:3c6:de4a:d755 with SMTP id v8-20020a05600c444800b003c6de4ad755mr4948869wmn.144.1665734441650;
        Fri, 14 Oct 2022 01:00:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003b3307fb98fsm1453887wmo.24.2022.10.14.01.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:00:41 -0700 (PDT)
Message-Id: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:00:39 +0000
Subject: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
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
    but I'm not sure about one remaining implementation choice:
    
     * In git-mergetool--lib.sh the way I implemented the "auto" special
       value means that if you put an arbitrary value in the config, eg the
       typo "uato", you get an error about it being an invalid boolean
       config value; is that OK? Is there a better way to handle "boolean or
       special value" config validation? Are there any examples?
    
    V2:
    
     * Fix uninitialized variable that caused buggy behavior and lack of
       clarity
     * Fix enum values to better match Junio's expectations
     * Add comment about relationship between C and shell scripts
     * Fix "tr" call to use simple ANSI ranges rather than character classes
     * Fix shell test to use "test" rather than brackets
     * Add better test coverage by using case-inconsistent "Auto" in test
     * Add test to validate command-line override of configured default in
       difftool

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1381%2FTaoK%2Ftao-mergetool-autogui-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1381/TaoK/tao-mergetool-autogui-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1381

Range-diff vs v1:

 1:  4e3495343db ! 1:  70d0e0d09fa mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
     +    RFC: mergetool: new config guiDefault supports auto-toggling gui by DISPLAY
      
          When no merge.tool or diff.tool is configured or manually selected, the
          selection of a default tool is sensitive to the DISPLAY variable; in a
     @@ Commit message
          equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
          environment" behavior.
      
     -    Introduce new configuration options, difftool.guiDefault and
     -    mergetool.guiDefault, supporting a special value "auto" which causes the
     -    corresponding tool or guitool to be selected depending on the presence of a
     -    non-empty DISPLAY value. Also support "true" to say "default to the guitool
     -    (unless --no-gui is passed on the commandline)", and "false" as the previous
     -    default behavior when these new configuration options are not specified.
     +    As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuration
     +    options, difftool.guiDefault and mergetool.guiDefault, supporting a special
     +    value "auto" which causes the corresponding tool or guitool to be selected
     +    depending on the presence of a non-empty DISPLAY value. Also support "true"
     +    to say "default to the guitool (unless --no-gui is passed on the
     +    commandline)", and "false" as the previous default behavior when these new
     +    configuration options are not specified.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     @@ builtin/difftool.c: static int run_file_diff(int prompt, const char *prefix,
       }
       
      +enum difftool_gui_mode {
     -+	GUI_DISABLED = -1,
     -+	GUI_BY_CONFIG = 0,
     ++	GUI_BY_CONFIG = -1,
     ++	GUI_DISABLED = 0,
      +	GUI_ENABLED = 1
      +};
      +
     @@ builtin/difftool.c: static int run_file_diff(int prompt, const char *prefix,
      -	    tool_help = 0, no_index = 0;
      +	int dir_diff = 0, prompt = -1, symlinks = 0, tool_help = 0,
      +	    no_index = 0;
     -+	enum difftool_gui_mode gui_mode;
     ++	enum difftool_gui_mode gui_mode = GUI_BY_CONFIG;
       	static char *difftool_cmd = NULL, *extcmd = NULL;
       	struct option builtin_difftool_options[] = {
      -		OPT_BOOL('g', "gui", &use_gui_tool,
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       				  !!extcmd, "--extcmd");
       
      -	if (use_gui_tool)
     ++	/*
     ++	 * Explicitly specified GUI option is forwarded to git-mergetool--lib.sh;
     ++	 * empty or unset means "use the difftool.guiDefault config or default to
     ++	 * false".
     ++	 */
      +	if (gui_mode == GUI_ENABLED)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
      -	else if (difftool_cmd) {
     @@ git-mergetool--lib.sh: merge_mode () {
      +	else
      +		GUI_DEFAULT_KEY="mergetool.guiDefault"
      +	fi
     -+	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr '[:upper:]' '[:lower:]')
     -+	if [ "$GUI_DEFAULT_CONFIG_LCASE" = "auto" ]
     ++	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr 'A-Z' 'a-z')
     ++	if test "$GUI_DEFAULT_CONFIG_LCASE" = "auto"
      +	then
     -+		if [ -n "$DISPLAY" ]
     ++		if test -n "$DISPLAY"
      +		then
      +			GUI_DEFAULT=true
      +		else
     @@ t/t7800-difftool.sh: test_expect_success 'difftool honors --gui' '
      +	difftool_test_setup &&
      +	test_config diff.guitool bogus-tool &&
      +	test_config diff.tool test-tool &&
     -+	test_config difftool.guiDefault auto &&
     ++	test_config difftool.guiDefault Auto &&
      +	DISPLAY= && export DISPLAY &&
      +
      +	echo branch >expect &&
     @@ t/t7800-difftool.sh: test_expect_success 'difftool honors --gui' '
      +	git difftool --no-prompt branch >actual &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'difftool --no-gui trumps config guiDefault' '
     ++	difftool_test_setup &&
     ++	test_config diff.guitool bogus-tool &&
     ++	test_config diff.tool test-tool &&
     ++	test_config difftool.guiDefault true &&
     ++
     ++	echo branch >expect &&
     ++	git difftool --no-prompt --no-gui branch >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_expect_success 'difftool --gui last setting wins' '
       	difftool_test_setup &&


 Documentation/config/difftool.txt  |  7 ++++
 Documentation/config/mergetool.txt |  7 ++++
 Documentation/git-difftool.txt     | 10 +++---
 Documentation/git-mergetool.txt    |  9 +++---
 builtin/difftool.c                 | 45 ++++++++++++++++++++++----
 git-mergetool--lib.sh              | 26 +++++++++++++++
 git-mergetool.sh                   |  2 +-
 t/t7610-mergetool.sh               | 39 ++++++++++++++++++++++
 t/t7800-difftool.sh                | 52 ++++++++++++++++++++++++++++++
 9 files changed, 181 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index a3f82112102..8c2f7460be4 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -34,3 +34,10 @@ See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.guiDefault::
+	Set 'true' to use the diff.guitool by default (equivalent to specifying
+	the "--gui" argument), or "auto" to select diff.guitool or diff.tool
+	depending on the presence of a DISPLAY environment variable value. The
+	default is 'false', where the "--gui" argument must be provided
+	explicitly for the diff.guitool to be used.
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 90b38097002..bc1a85abc95 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -85,3 +85,10 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.guiDefault::
+	Set 'true' to use the merge.guitool by default (equivalent to
+	specifying the "--gui" argument), or "auto" to select merge.guitool
+	or merge.tool depending on the presence of a DISPLAY environment
+	variable value. The default is 'false', where the "--gui" argument
+	must be provided explicitly for the merge.guitool to be used.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 9d14c3c9f09..a09dfb072d5 100644
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
+	autoselected using the configuration variable
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
index 4b10ad1a369..374bb7df34f 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -680,14 +680,37 @@ static int run_file_diff(int prompt, const char *prefix,
 	return run_command(child);
 }
 
+enum difftool_gui_mode {
+	GUI_BY_CONFIG = -1,
+	GUI_DISABLED = 0,
+	GUI_ENABLED = 1
+};
+
+static int difftool_opt_gui(const struct option *opt,
+			      const char *optarg, int unset)
+{
+	enum difftool_gui_mode *mode;
+	mode = opt->value;
+
+	BUG_ON_OPT_ARG(optarg);
+
+	if (unset)
+		*mode = GUI_DISABLED;
+	else
+		*mode = GUI_ENABLED;
+	return 0;
+}
+
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
-	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0, no_index = 0;
+	int dir_diff = 0, prompt = -1, symlinks = 0, tool_help = 0,
+	    no_index = 0;
+	enum difftool_gui_mode gui_mode = GUI_BY_CONFIG;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
-		OPT_BOOL('g', "gui", &use_gui_tool,
-			 N_("use `diff.guitool` instead of `diff.tool`")),
+		OPT_CALLBACK_F('g', "gui", &gui_mode, NULL,
+			       N_("use `diff.guitool` instead of `diff.tool`"),
+			       PARSE_OPT_NOARG, difftool_opt_gui),
 		OPT_BOOL('d', "dir-diff", &dir_diff,
 			 N_("perform a full-directory diff")),
 		OPT_SET_INT_F('y', "no-prompt", &prompt,
@@ -732,13 +755,21 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	die_for_incompatible_opt3(use_gui_tool, "--gui",
+	die_for_incompatible_opt3(gui_mode == GUI_ENABLED, "--gui",
 				  !!difftool_cmd, "--tool",
 				  !!extcmd, "--extcmd");
 
-	if (use_gui_tool)
+	/*
+	 * Explicitly specified GUI option is forwarded to git-mergetool--lib.sh;
+	 * empty or unset means "use the difftool.guiDefault config or default to
+	 * false".
+	 */
+	if (gui_mode == GUI_ENABLED)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
-	else if (difftool_cmd) {
+	else if (gui_mode == GUI_DISABLED)
+		setenv("GIT_MERGETOOL_GUI", "false", 1);
+
+	if (difftool_cmd) {
 		if (*difftool_cmd)
 			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
 		else
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9f99201bcca..ff08eb7ae93 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -97,7 +97,33 @@ merge_mode () {
 	test "$TOOL_MODE" = merge
 }
 
+get_gui_default () {
+	if diff_mode
+	then
+		GUI_DEFAULT_KEY="difftool.guiDefault"
+	else
+		GUI_DEFAULT_KEY="mergetool.guiDefault"
+	fi
+	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr 'A-Z' 'a-z')
+	if test "$GUI_DEFAULT_CONFIG_LCASE" = "auto"
+	then
+		if test -n "$DISPLAY"
+		then
+			GUI_DEFAULT=true
+		else
+			GUI_DEFAULT=false
+		fi
+	else
+		GUI_DEFAULT=$(git config --default false --bool --get $GUI_DEFAULT_KEY)
+	fi
+	echo $GUI_DEFAULT
+}
+
 gui_mode () {
+	if [ -z "$GIT_MERGETOOL_GUI" ]
+	then
+		GIT_MERGETOOL_GUI=$(get_gui_default)
+	fi
 	test "$GIT_MERGETOOL_GUI" = true
 }
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index f751d9cfe20..f510ff9ea70 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -451,7 +451,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	GIT_MERGETOOL_GUI=false
+	GIT_MERGETOOL_GUI=
 	guessed_merge_tool=false
 	orderfile=
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 8cc64729adb..3a807fd681c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -860,4 +860,43 @@ test_expect_success 'mergetool hideResolved' '
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
