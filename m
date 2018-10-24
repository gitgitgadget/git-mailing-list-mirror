Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EADE81F453
	for <e@80x24.org>; Wed, 24 Oct 2018 02:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeJXLRy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:17:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51925 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:17:54 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so4409960itw.1
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ByjuDItGVXxhkW0vuFaMAvuq6aLC/fuxqQ9HjuxV+zc=;
        b=AFswe2RA1apM+Ir4ChVv04/PjqFeDFm2tqFOGSeRrYGqLDQoo186imqpUNozB6WpwG
         zDMsobsOxugxpD3UFM92DSJ3ewDGkFb+z/SGglJGDJt3OUlVcQ1ZIlyiapfGHGLAnFzh
         qHiOrDuM5SwEH2lI5iQLaSdeVZvN0CRIs1UyMqE5c2GLYfGDyprLYZMaZCp5QhLIRUZO
         Ts3va5MRHkSNQFktfSBMTMI2O2jAhi00Bb3dWl8E1i4x7eiXPxy59XTB3iJqiQIufeVO
         375fgYvei5+xSR4YBi2djNqc3EcS/uNqp2wEDnpD/x34XPdPSqybUPbZhwnPtsNTOw+6
         Fy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ByjuDItGVXxhkW0vuFaMAvuq6aLC/fuxqQ9HjuxV+zc=;
        b=EvnejQnaNKvTZ3ipog8oWCqix6GyqRK2VVbjtWvBSqFVk7DglKMvTTdpUV2a1sWwxp
         hr52wyrgq8x7pYv2v1JtGvJajxG9aGawJEr1CElntFr6urWgFdKr59Xq28LIZMeew6TZ
         Kk/Amx5lY26I2spxOEJ3kQl4db9MLkWgO2lkumgqW3GLLVVxlSzB/9Ll2uzqmHcTboru
         Ld9s+nT3wSOarDnTUTs9pUd/TejTCEW2mjggTw1Q9ayKMO5norhxXRJJrkNPXABIJ1Yz
         i+dT8PySQFuNg92xYaIK0LY4EV88wzoWm/15r+gm/BlzkUhnx2UyPiTds0/SZyZmZRZQ
         ltQw==
X-Gm-Message-State: AGRZ1gIjXfXKizGuirX/wn5Ym8Q7ai8MLBf/ayu/QOxmv1ZVjMNj/QAU
        tQRxk78snYsDZe/9VQnfocZMWPP/
X-Google-Smtp-Source: AJdET5ey0z3MdynbeyBkLY3JtRUpI2vyV9iV91xT6tUvhsc1UCMgZDlFUaOfN5EMH4bmBGEAMi1wCw==
X-Received: by 2002:a02:b422:: with SMTP id i31-v6mr575243jaj.40.1540347902999;
        Tue, 23 Oct 2018 19:25:02 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id 64-v6sm1494618itm.29.2018.10.23.19.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:25:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 22:25:00 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com
Subject: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments
Message-ID: <20181024022500.GA29011@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In line with how difftool accepts a -g/--[no-]gui option, make mergetool
accept the same option in order to use the `merge.guitool` variable to
find the default mergetool instead of `merge.tool`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Anmol Mago <anmolmago@gmail.com>
Signed-off-by: Brian Ho <briankyho@gmail.com>
Signed-off-by: David Lu <david.lu97@outlook.com>
Signed-off-by: Ryan Wang <shirui.wang@hotmail.com>
---
 Documentation/git-mergetool.txt | 11 +++++++++++
 git-mergetool--lib.sh           | 16 +++++++++++-----
 git-mergetool.sh                | 11 +++++++++--
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 3622d6648..0c7975a05 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -79,6 +79,17 @@ success of the resolution after the custom tool has exited.
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
+-g::
+--gui::
+	When 'git-mergetool' is invoked with the `-g` or `--gui` option
+	the default merge tool will be read from the configured
+	`merge.guitool` variable instead of `merge.tool`.
+
+--no-gui::
+	This overrides a previous `-g` or `--gui` setting and reads the
+	default merge tool will be read from the configured `merge.tool`
+	variable.
+
 -O<orderfile>::
 	Process files in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9a8b97a2a..e317ae003 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -350,17 +350,23 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	# Diff mode first tries diff.tool and falls back to merge.tool.
-	# Merge mode only checks merge.tool
+	# If first argument is true, find the guitool instead
+	if [ "$1" = true ]
+	then
+		gui_prefix=gui
+	fi
+
+	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
+	# Merge mode only checks merge.(gui)tool
 	if diff_mode
 	then
-		merge_tool=$(git config diff.tool || git config merge.tool)
+		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
 	else
-		merge_tool=$(git config merge.tool)
+		merge_tool=$(git config merge.${gui_prefix}tool)
 	fi
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
 	then
-		echo >&2 "git config option $TOOL_MODE.tool set to unknown tool: $merge_tool"
+		echo >&2 "git config option $TOOL_MODE.${gui_prefix}tool set to unknown tool: $merge_tool"
 		echo >&2 "Resetting to default..."
 		return 1
 	fi
diff --git a/git-mergetool.sh b/git-mergetool.sh
index d07c7f387..01b9ad59b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -9,7 +9,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-g|--gui|--no-gui] [-O<orderfile>] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
@@ -389,6 +389,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
+	gui_tool=false
 	guessed_merge_tool=false
 	orderfile=
 
@@ -414,6 +415,12 @@ main () {
 				shift ;;
 			esac
 			;;
+		--no-gui)
+			gui_tool=false
+			;;
+		-g|--gui)
+			gui_tool=true
+			;;
 		-y|--no-prompt)
 			prompt=false
 			;;
@@ -443,7 +450,7 @@ main () {
 	if test -z "$merge_tool"
 	then
 		# Check if a merge tool has been configured
-		merge_tool=$(get_configured_merge_tool)
+		merge_tool=$(get_configured_merge_tool $gui_tool)
 		# Try to guess an appropriate merge tool if no tool has been set.
 		if test -z "$merge_tool"
 		then
-- 
2.19.1

