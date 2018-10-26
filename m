Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E7B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 06:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeJZOrB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 10:47:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33585 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZOrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 10:47:01 -0400
Received: by mail-it1-f194.google.com with SMTP id h6-v6so3828431ith.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbcRjHfosrFlcL1zECmO1lFiSIimxlWzQBo+568L0Qk=;
        b=S4Wm3XbhXLFK4rwDiyAtyCwB+bgISiG1mdcshnLeJOEwz6y7v5HYUonlJ+1ruMXtIj
         ak3OXyW5KpXGcR1wKwTTanQL+Qy8UMHUw/fGLkaPQmYTO9Jg9m5qa2xXqWmCcByLIA1E
         8Yo9ZaS7csSwSsQptC6M015dYWqjaXSs7kwbdwmJ6ODu8lwp8KtoK9TFJVa5r6Y5neXt
         YlkTl6RJK7TUjsougr5Yw+iX+zZwpl6AvieEW2vJPeXfDu879sDjVIzYfMCvty5cZZ9t
         ZMEtXDeu8V6GijFMl39oth7VaicY09160ZU/7EsYwIWN48FwJi0avyHU0i8luxGlWqOT
         FH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbcRjHfosrFlcL1zECmO1lFiSIimxlWzQBo+568L0Qk=;
        b=eHeK/9ZzNG20hTijgI6RKzrx97kDkUr2gdRS7iTgbslYxKGwI5MMlZKCDHBqnKbA9Q
         8v4Z6jECqUfEx8N2BFK4e5bppn2FT/VDSFpfqmLak5MjsU2WRZg5JCpBJs98b2l9y1+7
         I0RJ3h1lXZ3zkhLkdeE8JtLqk7loqXDVjcgkIQgQy1j9Nn9Lf5eVx9/nXfd+iDjNbp1z
         1O0nXD4zAIrD4l3+RUFM0u6lH39xQ37irmk8usnnm/7GXzok+rwBmKZlcTqc26sfRDxi
         CSxjaasTzBjyJtt23mFqIow/AZjSkFtNteG/A4FLXFZGVNJZC8pPKXN3rMnr5F2nzWOx
         lkwg==
X-Gm-Message-State: AGRZ1gK6pcWwmHy4/MRwqcLfBtoRkj5Tp37XR2T57xu+aV57YqmR6EUN
        jDeuzER06eRtKEpLhlAZS39vA+Ch
X-Google-Smtp-Source: AJdET5cEgMjJYwuNPGU0H6QnSUv3MZyde52kZiZrKTwFWesCYqjZxOt/KiJV9IST9J6TGUNHBxUOBQ==
X-Received: by 2002:a24:728e:: with SMTP id x136-v6mr2569357itc.40.1540534281268;
        Thu, 25 Oct 2018 23:11:21 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id j14-v6sm3383261ioa.37.2018.10.25.23.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:11:20 -0700 (PDT)
Date:   Fri, 26 Oct 2018 02:11:18 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [RESEND PATCH v3 1/3] mergetool: accept -g/--[no-]gui as arguments
Message-ID: <20181026061118.GA7295@archbookpro.localdomain>
References: <cover.1540398076.git.liu.denton@gmail.com>
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
2.19.1

