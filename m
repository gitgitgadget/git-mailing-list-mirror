Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F8C43217
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJUPOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJUPNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092EE196ED1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y10so2425966wma.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTg1txQOsit9YnJUOpD+dDLtJr9/8lm1SMxzQ9uFOAQ=;
        b=ZvH53AeHfKv9fiXumg3cr47vv1wOGE+nk3XXZcxzgmoW1ZXuF86S9+MKxJ9jFSUcAB
         3B+mhbqJrdj0no0XE4KgSYSh89W3OFVMxpEgYQh6+7YI2/ef9wDj5feDqaWAKkejcunP
         ITDtW0hgKyGpmanDxBAomzTOrJAD7CiSeLbXh/Zw/bSKYiuU4mH0Iw/nStTuNjCepYmr
         0kkmfgjAlabKwfg3IDZmcUtbTibMt2RVADLFHqeDN9vP9KP03Im+6CGOvB+RfSWTZ43r
         fiIOQ1MCtZBAUA7OitHJNvWjoMlMBx3hJA9liUwjJxoyxblYhLaBnh88T8f3HHDQctD3
         7CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTg1txQOsit9YnJUOpD+dDLtJr9/8lm1SMxzQ9uFOAQ=;
        b=CSkBEE0ORrWYvQqL9nK2AsgVZ4VUeiwGgTCAOd9JSx/U7UaGdonOtaVegkVjO2kCIC
         UboM5FzbxctLE4wN6Qo1FowB8QLOKRk9RPjD+7awpJSac0gkreMdZo1ejt35K4IoWcC6
         0jygmyye8DzTUp8L1kG7MjSi+GI/RNj9rxzP6YCqqbXt7vxN2h48GtsJvcQ0EoRRu5WS
         13FBcI2koWTO2yqSAfRCJ7Z/hM1VraQWOUmU/ZKIWbs/3ZOxuaB6tVD+uB9oeAT12R8g
         dW8FCNu6ckHHgoUH7+5x3eSo+N5AhXmD6oFVSvh7HYe9rp5Aym0wXAsT4mCD6gLckHhK
         PwZQ==
X-Gm-Message-State: ACrzQf2yH5Bcqe9GFUs1c9FEvijfopJFIzu60qgGOQMHdjj3p199tKt4
        zyq6wgh93UQd8rerKwl6zTCojKKCioc=
X-Google-Smtp-Source: AMsMyM5Nx8Z9QYK5mjU620bVwvGDNBJ//ePpH0xjfNARnK/x/JHVdEEPmjs0E2oJOpNf28A/IBvODg==
X-Received: by 2002:a05:600c:5011:b0:3c6:cd93:cf24 with SMTP id n17-20020a05600c501100b003c6cd93cf24mr13244102wmr.16.1666365227370;
        Fri, 21 Oct 2022 08:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000108f00b0023647841c5bsm3863678wrw.60.2022.10.21.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:46 -0700 (PDT)
Message-Id: <c890f55f59994231be6114f76f020510eb824453.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:33 +0000
Subject: [PATCH 3/9] subtree: add 'die_incompatible_opt' function to reduce
 duplication
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

9a3e3ca2ba (subtree: be stricter about validating flags, 2021-04-27)
added validation code to check that options given to 'git subtree <cmd>'
made sense with the command being used.

Refactor these checks by adding a 'die_incompatible_opt' function to
reduce code duplication.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 49ef493ef92..f5eab198c80 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -102,6 +102,14 @@ assert () {
 	fi
 }
 
+# Usage: die_incompatible_opt OPTION COMMAND
+die_incompatible_opt () {
+	assert test "$#" = 2
+	opt="$1"
+	arg_command="$2"
+	die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+}
+
 main () {
 	if test $# -eq 0
 	then
@@ -176,16 +184,16 @@ main () {
 			arg_debug=1
 			;;
 		--annotate)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_annotate="$1"
 			shift
 			;;
 		--no-annotate)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_annotate=
 			;;
 		-b)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_branch="$1"
 			shift
 			;;
@@ -194,7 +202,7 @@ main () {
 			shift
 			;;
 		-m)
-			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_message="$1"
 			shift
 			;;
@@ -202,34 +210,34 @@ main () {
 			arg_prefix=
 			;;
 		--onto)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_onto="$1"
 			shift
 			;;
 		--no-onto)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_onto=
 			;;
 		--rejoin)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			;;
 		--no-rejoin)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			;;
 		--ignore-joins)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_ignore_joins=1
 			;;
 		--no-ignore-joins)
-			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_ignore_joins=
 			;;
 		--squash)
-			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=1
 			;;
 		--no-squash)
-			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=
 			;;
 		--)
-- 
gitgitgadget

