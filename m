Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF9D1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdGaU5Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36312 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdGaU5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so32275362pgy.3
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HgNeS2mhwdGn+J4zFyTzYn1sf14xyFST9tFnv60j494=;
        b=SJXiB/R3v/h1JAlQvSzxTJIWfnzaUw2RUF4+EyfvXk+906iuZTeyfh9wdApNMTGvVo
         qDDoXrpxJr3f3s7IrbJWg+PNzwM2+ZGiuVGHA8bykIHuOihljHI7JMESVpXDWwTrebDB
         X/eRv+LD/N9+wtXnPp9e2jUFzRjy7NRAMv1Rvf98nKjg+xKuTRpmucsoQ/HyDYN20N1p
         dDFogNaNoD/6cwyNNaYcJpHhoJUCFFpOVJW1Af1fmuQXQwlaQi0yXryy8HXjLMhpUmbU
         beoPsyaSXuwi2hu3UZzlMvGSN8qCtF62te6/CuNQVjR2TsuuEp4V3xC2KgR901pkAuUn
         WwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HgNeS2mhwdGn+J4zFyTzYn1sf14xyFST9tFnv60j494=;
        b=mYbOqaJsvZOT8RigVJ9+r73K3s+BY9iFI0e6HLSXaj/2kLQHa/bza4uTa5GSmeDupO
         ZVXgIdLN452WZT+vc9R/gFptSMekeKmOPzPf8iCL2hbYjrhx+TkQbsDgS44duiZIYbw/
         RtN97PRxpcvl2G8qUv7xQP/NDzFPzp4+NU0TEr3LAMt+zhcu/n2oKwX/zSBYnAghQwjS
         tt4T2HK4CmcuCKI+5hewQOfu/yv6Bx8xgr0Q/5ocgsm9jMlhLUytH1zf49T48J4ave0X
         rulLUBX/5H2ZKxw3tYumziaebnCZzbuN2T+fdAqTUblRLXBoJIE4jDQ31iR0b44pakjE
         aRkQ==
X-Gm-Message-State: AIVw112i1nQX69P7uaQ83ZBWSm2lSQR216mtJHqcJtFCI0M0TD4pgsI6
        NVzK0YP97XvWPTWZtW3dXQ==
X-Received: by 10.99.45.194 with SMTP id t185mr16302627pgt.388.1501534642670;
        Mon, 31 Jul 2017 13:57:22 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:22 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 12/13] submodule foreach: document variable '$displaypath'
Date:   Tue,  1 Aug 2017 02:26:20 +0530
Message-Id: <20170731205621.24305-13-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was observed that the variable '$displaypath' was accessible but
undocumented. Hence, document it.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
In this new version, the following changes have been made:
* Spelling mistake in the commit message was corrected.

 Documentation/git-submodule.txt |  6 ++++--
 t/t7407-submodule-foreach.sh    | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e7930ebc..0cca702cb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,10 +183,12 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $sm_path, $sha1 and
-	$toplevel:
+	The command has access to the variables $name, $sm_path, $displaypath,
+	$sha1 and $toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
+	$displaypath contains the relative path from the current working
+	directory to the submodules root directory,
 	$sha1 is the commit as recorded in the superproject, and
 	$toplevel is the absolute path to its superproject, such that
 	$toplevel/$sm_path is the absolute path of the submodule.
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 0663622a4..6ad57e061 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -82,16 +82,16 @@ test_expect_success 'test basic "submodule foreach" usage' '
 
 cat >expect <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-sub1-$sub1sha1
+$pwd/clone-foo1-sub1-../sub1-$sub1sha1
 Entering '../sub3'
-$pwd/clone-foo3-sub3-$sub3sha1
+$pwd/clone-foo3-sub3-../sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach" from subdirectory' '
 	mkdir clone/sub &&
 	(
 		cd clone/sub &&
-		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$displaypath-\$sha1" >../../actual
 	) &&
 	test_i18ncmp expect actual
 '
@@ -206,25 +206,25 @@ submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEA
 
 cat >expect <<EOF
 Entering '../nested1'
-$pwd/clone2-nested1-nested1-$nested1sha1
+$pwd/clone2-nested1-nested1-../nested1-$nested1sha1
 Entering '../nested1/nested2'
-$pwd/clone2/nested1-nested2-nested2-$nested2sha1
+$pwd/clone2/nested1-nested2-nested2-../nested1/nested2-$nested2sha1
 Entering '../nested1/nested2/nested3'
-$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
+$pwd/clone2/nested1/nested2-nested3-nested3-../nested1/nested2/nested3-$nested3sha1
 Entering '../nested1/nested2/nested3/submodule'
-$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
+$pwd/clone2/nested1/nested2/nested3-submodule-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
 Entering '../sub1'
-$pwd/clone2-foo1-sub1-$sub1sha1
+$pwd/clone2-foo1-sub1-../sub1-$sub1sha1
 Entering '../sub2'
-$pwd/clone2-foo2-sub2-$sub2sha1
+$pwd/clone2-foo2-sub2-../sub2-$sub2sha1
 Entering '../sub3'
-$pwd/clone2-foo3-sub3-$sub3sha1
+$pwd/clone2-foo3-sub3-../sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
 	(
 		cd clone2/untracked &&
-		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$displaypath-\$sha1" >../../actual
 	) &&
 	test_i18ncmp expect actual
 '
-- 
2.13.0

