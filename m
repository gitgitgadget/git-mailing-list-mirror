Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7932047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbdG2WZO (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:25:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35787 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdG2WZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:25:13 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so26888685pgc.2
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A7o6Nd2+NIUTlwcOTYOZSqboTMVkSZ9Lfo9ruHo8yBA=;
        b=ivoMzwuhNuoML19AoeoNHJH0wcuNL30ITMSYvrxYgcGbiNxWKnxZ/VfXuE7Q8FJLdW
         LYVAdVq6F8pQXBehA5yyRPBl7fQLuTNU5aL0+n9FTSJ++ZE3EDOkjAbkNdWFbyMBT/Zm
         94cVopT+pRghHYIGwPfMExGLLb39+8c9Ucl3GTD9GOGcoV2e6w96njHacZMcrQ7qQyWI
         CdIphIzCY98FjaHMX9SXPi9nkrpsd06gLfKg3lL6OtceWi/FSRoeAwgFFFATbiU3WZX2
         58tjK35HRjonKtgNzc2D8xZaCSxRxbVVyq/nW65P0ceQsJR3V0IEePWlmRWxLpUKlfVG
         FCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A7o6Nd2+NIUTlwcOTYOZSqboTMVkSZ9Lfo9ruHo8yBA=;
        b=m/cpvp3edhhjkMXOwckaxfazECjA8B8c3kziRYtjgsqBc7G2gf5DMvDWMuOdJVAYb5
         523QjhfyeSWVtwcdG+5xTb/NUANoQ3vMNIG0+JbOxhMRs9LSHcp/lma9AHssiYqsQkHw
         G6x98jxcPWcinayXoMnMGAL7xiDwMTr2gknRRNcexDlSpuLCydZWZUXhbejqGH/h9Uzw
         4dXg2rrPmbI8knw+ZLHL2/9wL54s9iGS4ATDq+2uQ7gPA6/8tMFWAs+wgq2DMsLajYiO
         G/t20RrZ/QoYFCvscoYmZX5xvohXBQrLf/BiPkjEV2+il5Di1aL3aKICTCI4w+AFq8Rp
         rieA==
X-Gm-Message-State: AIVw1110UsadmZC3pEQrFkBHtkxgYS5I7XlErCDVrTrOxpmHies9l2pZ
        8trQpqzUZIvWnhKTUyU=
X-Received: by 10.84.208.236 with SMTP id c41mr12038518plj.152.1501367112753;
        Sat, 29 Jul 2017 15:25:12 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:25:12 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 12/13] submodule foreach: document variable '$displaypath'
Date:   Sun, 30 Jul 2017 03:54:00 +0530
Message-Id: <20170729222401.12381-13-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
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

