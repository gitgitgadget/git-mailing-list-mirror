Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3106D1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJYAyS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:54:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38184 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:54:18 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so7345947ita.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mXGWzGhErDxZa72gdjGcEc9BiPoCF6kh6D4G35+gCc=;
        b=JrOQIYp0d1WSwp6zRfC0NEg4s/8gNj1osQ8N2xuZhvxB9B+K1gL82VsHxicRbkOrRs
         jJ6H+Hv47O9ZLGrMGaEIReP5Sxaew5VP1F3NnU2rRuOI1fpMh0ZXQisqm3/g/5asOja8
         NRG4vJebjdfHae/FFRwIoIv92rE0xRq+Flk9NUqyyTC+p+GDQXLENMeYeTfOXtjZDjsR
         ireYC4cgVAXzO72jX+D83Lx2nGkXDfXtR9XAd5OcIBn9AI8C3uNG3f8JL9GJ42jg0Kxh
         bYKcuMw8nOL6cb6Tu6Q+xH71/ZVqakB8Qds6UFRZew6gneCq3sEMngjkY52gtAg2J4a3
         hdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mXGWzGhErDxZa72gdjGcEc9BiPoCF6kh6D4G35+gCc=;
        b=WVj0pfq/BOvVNPMIJYrwjGIyuvHgJVy7KdfoIDHPMluic3zsTDorJpLavwARICnSZ9
         W0KiWT0ydDH4Er01jzmYaQ6wDs8c89wY3Y8HIhaI7A28sc8BzO3GsgcdoOMvg5rvJl5N
         myK3PkdZqJA/60UuQhkS78TrQkkCFiYH8FKj6pm1gmWr6EmoUpqjqB4Bjyx6OTTzsUbQ
         kbw5aCcAFr5ATpohlkHAXWvu47FWb64dybX/TpZu1n5E44NzHFYP+7/WcKWQ+XyBKpNe
         dSCQKy9fbc/4MAPJmWqnIbQb1lPjLigtJ7foS97xH2frteYC2Oizr22FzVLexiEUmjZf
         GNAQ==
X-Gm-Message-State: AGRZ1gIHY1e3AU1/e/2ODqoG3ovC2aasBojCAj4tR/9Mbyp+Kn+jkctF
        rBwnmBSEFNLHCLWJNXKpETnazyH7
X-Google-Smtp-Source: AJdET5edXSDsV3OTLxr5c3ilgU3tJo1iiZcTwbM3UjnxZWXIYb1GrXa4Qs/7Lg/u6fAA2gFFLZUlgw==
X-Received: by 2002:a24:4ad5:: with SMTP id k204-v6mr2064582itb.1.1540398333521;
        Wed, 24 Oct 2018 09:25:33 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id m70-v6sm2838831itm.27.2018.10.24.09.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 09:25:33 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:25:31 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 1/3] mergetool: accept -g/--[no-]gui as arguments
Message-ID: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540398076.git.liu.denton@gmail.com>
References: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540360514.git.liu.denton@gmail.com>
 <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
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
Acked-by: David Aguilar <davvid@gmail.com>
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
index 9a8b97a2a..83bf52494 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -350,17 +350,23 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	# Diff mode first tries diff.tool and falls back to merge.tool.
-	# Merge mode only checks merge.tool
+	# If first argument is true, find the guitool instead
+	if test "$1" = true
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
2.19.1.544.ge0b0585a1.dirty

