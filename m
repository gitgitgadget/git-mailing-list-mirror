Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222B0203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbdGXUgH (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:36:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33665 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXUgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:36:04 -0400
Received: by mail-pg0-f68.google.com with SMTP id 123so2050889pgj.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQwD9A3kkWFsA2HuBoDRsZJGAsuKtbWrIZMtFAq0CP4=;
        b=vgz3cXSIIaEe12qkklQokOMzq0WrZKDgMVcvf2H0iXMivs6wdG7vGMGDMqz9mT1e+X
         ZUSMwcIlV2Z7FvAQaCrFKs7KqabZGpcL1lomsMTORPukrYcH6o4e29mXWGw7TbvlXtCu
         Ge8V6gt/TBQEOj+kYyX2shONdVd2l2Wnzqd4nXqNLg7Snv5slr9AQxGuY8ruR8AnBbUk
         5ecRjIAihj8EGYP584vCMynyjFOzSBCw7q0Mp76tzrRFqcmAp4sPi52rJl52RorecjX5
         IUpJSCz/AbGpAeKgxtzHRwiNagPgGsfA+pC9AbYOC98DCmR2XNKX6UQCU+s7eKTgOHEg
         wBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQwD9A3kkWFsA2HuBoDRsZJGAsuKtbWrIZMtFAq0CP4=;
        b=GdsBPo9NLwPNCcIRVV3ZqNA9hjL1nbwsIFkPKRRF404VZeIAYJ8sZsdLhB5T6vWSjw
         cbNqmMIiYOrAbaAnBD52TkHjJfASuLRuhj2YuIujs0YVQ2JTZ/czuNr2dkjxZiM4jCUp
         T4pcbR7MvjgcXio2c1FiE8dm2LTdidxpdcDLvhvkO1nS7e/p/W3RF4Jmj7aozTAfapZU
         CsjEWdHSC6o+3qkS15oN4KN2h5Fj8uarPYCz6rg0FCTzxGOex9PDTb3Hb8qUv2tGraz/
         iwffpLNW7ws1fnZN3/MFbvcZq//gS5BniqOFFzA/PDf3BqD8QG5Sdb9VrSuASrINDR0s
         h8qw==
X-Gm-Message-State: AIVw110GljbV/DQMg/dSQpC3azVIXPZWrkL9RW5U2wa2hRgVYotDhLwc
        UIDwvgmeLqA4NV06HuY=
X-Received: by 10.84.194.129 with SMTP id h1mr17871364pld.237.1500928564167;
        Mon, 24 Jul 2017 13:36:04 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:36:03 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 12/13] submodule foreach: document variable '$displaypath'
Date:   Tue, 25 Jul 2017 02:04:53 +0530
Message-Id: <20170724203454.13947-13-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was observer that the variable '$displaypath' was accessible but
undocumented. Hence, document it.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
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

