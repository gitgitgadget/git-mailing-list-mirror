Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F80B1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfD2GVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33741 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:13 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so9933228itf.0
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+UWlS8YOGSQLTUFyQiPowxNYn0OFT8/ZbdQ+V+myGk=;
        b=H8VKvUbfbnrTanEjBCNbF7OFEv25VGRH9UJD1Tqxy7kCh3s8a7cfy8bvzQ3I0q48Jm
         FLrIBR2O0m2stdK7dKlXgJtCelg9d/xgWOGOzVbuiqLyIna7n2UNTarqFcjYz0FiLAUH
         NMjqPgxN3xpvO2oErJI4SU6OFH2m8vIKRFM7nxgJv3UP6cY0ITGoTI4Mea0szh/HkB14
         G/rF0HxqiOXLd3n25GGMyW3B4eBbvdmJxXD5ah8rKpD0g+2CxhIMZKayyzpuGn8209Is
         QIF3zxdfnP3boYXsKcT3nwV8Z6nOZIjg4GjU/t7XcxKx9U8wx+g5Z2vO6teYf+tKOumJ
         L82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+UWlS8YOGSQLTUFyQiPowxNYn0OFT8/ZbdQ+V+myGk=;
        b=IdbBdllQ7c46xdMIY3u5cbZZnCMcEDktdCDGPG0QLcSJQwjRXr1a8PrpHLqKhcWRz5
         8hcuImS9q+WVb5i4VZFVvWbANwwC+/tkAEPFMszodlsiW1FfzWErEl+s9riwoxvfC2rg
         QeoamzVyVEoZvAEPqZfNHV8o0qHR1BvIXhyt5/q35U6vjxTUC0+xoNQzZdO4pZuVCUrO
         EtqLe+Mj+oaENFvTgl+NcvtJVS4cJTbpC/NJBFqEeKgP+i2Vw9sjX0FpfZjOaSmX/sLW
         9VQ90I6OGJYT1ZaN4e9cy3qve+pR+HNu+unVJOzCUDaDWZWd6RqLpXQFN0G/9oQqOBMy
         MtfA==
X-Gm-Message-State: APjAAAX5gHF6EQ/5oSzmk0Ojw1qWpBYPXPSuCE5mKqkkPvTfkcKiTc8z
        xbQ3iLYsDYfw+hUpXi5RSQMaMhrF
X-Google-Smtp-Source: APXvYqyI1NF4mWoVz4TxlhgDP2s9tyOP0++Tifjs2+Pm78NN+caSHGPWqgSAx4tFAFoQc17X38STAA==
X-Received: by 2002:a24:7a94:: with SMTP id a142mr18685071itc.79.1556518871503;
        Sun, 28 Apr 2019 23:21:11 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id k17sm1163936ioj.3.2019.04.28.23.21.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:10 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:08 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/7] mergetool: use get_merge_tool function
Message-ID: <81dd25d8e2bac8c22c018fd35532aaab36526e74.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-mergetool, the logic for getting which merge tool to use is
duplicated in git-mergetool--lib, except for the fact that it needs to
know whether the tool was guessed or not.

Rewrite `get_merge_tool` to return whether or not the tool was guessed
through the return code and make git-mergetool call this function
instead of duplicating the logic. Note that 1 was chosen to be the
return code of when a tool is guessed because it seems like a slightly
more abnormal condition than getting a tool that's explicitly specified
but this is completely arbitrary.

Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not the
guitool will be selected.

This change is not completely backwards compatible as there may be
external users of git-mergetool--lib. However, only one user,
git-diffall[1], was found from searching GitHub and Google, and this
tool is superseded by `git difftool --dir-diff` anyway. It seems very
unlikely that there exists an external caller that would take into
account the return code of `get_merge_tool` as it would always return 0
before this change so this change probably does not affect any external
users.

[1]: https://github.com/thenigan/git-diffall

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool--lib.txt |  4 +++-
 git-difftool--helper.sh              |  2 +-
 git-mergetool--lib.sh                |  5 ++++-
 git-mergetool.sh                     | 12 ++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 055550b2bc..4da9d24096 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -28,7 +28,9 @@ to define the operation mode for the functions listed below.
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool.
+	returns a merge tool. the return code is 1 if we returned a guessed
+	merge tool, else 0. '$GIT_MERGETOOL_GUI' may be set to 'true' to
+	search for the appropriate guitool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7bfb6737df..46af3e60b7 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -71,7 +71,7 @@ then
 	then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
-		merge_tool="$(get_merge_tool)" || exit
+		merge_tool="$(get_merge_tool)"
 	fi
 fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..b928179a2e 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -403,14 +403,17 @@ get_merge_tool_path () {
 }
 
 get_merge_tool () {
+	is_guessed=false
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
+	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
 		merge_tool=$(guess_merge_tool) || exit
+		is_guessed=true
 	fi
 	echo "$merge_tool"
+	test "$is_guessed" = false
 }
 
 mergetool_find_win32_cmd () {
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 01b9ad59b2..88fa6a914a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -389,7 +389,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	gui_tool=false
+	GIT_MERGETOOL_GUI=false
 	guessed_merge_tool=false
 	orderfile=
 
@@ -416,10 +416,10 @@ main () {
 			esac
 			;;
 		--no-gui)
-			gui_tool=false
+			GIT_MERGETOOL_GUI=false
 			;;
 		-g|--gui)
-			gui_tool=true
+			GIT_MERGETOOL_GUI=true
 			;;
 		-y|--no-prompt)
 			prompt=false
@@ -449,12 +449,8 @@ main () {
 
 	if test -z "$merge_tool"
 	then
-		# Check if a merge tool has been configured
-		merge_tool=$(get_configured_merge_tool $gui_tool)
-		# Try to guess an appropriate merge tool if no tool has been set.
-		if test -z "$merge_tool"
+		if ! merge_tool=$(get_merge_tool)
 		then
-			merge_tool=$(guess_merge_tool) || exit
 			guessed_merge_tool=true
 		fi
 	fi
-- 
2.21.0.1033.g0e8cc1100c

