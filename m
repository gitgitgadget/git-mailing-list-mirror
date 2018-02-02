Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988871F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeBBE6J (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:58:09 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41578 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeBBE6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:58:07 -0500
Received: by mail-pl0-f65.google.com with SMTP id k8so3096597pli.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ASh+58lXn/lPVLUPGwjNsQQCY/GNvPo08A078EXjLp0=;
        b=C2ccKuXT0RdHD5/aGGus6tYvXj5lkp+0ZCTaj0ZmspVtiYaPYu4lL67Zl4CqVa3d5b
         Bp1I7v9uCo3ZUir5i5SiF0t/SYMkHfAnyO921gQZMlJ0SRs73ro9S/EyB62IAPHUe/y1
         XVwcCsZt4UC4Uj4TJR8Fd31yuznVY6QRSbnTAun1+38BcmbTDwIxBynMCFB1444KJ9xv
         MbrI/tOQDtuOCgY7AlpptGY/wZTMgTNPwOssCbYUu0ehi+1sSvsrVSx37hH8RIkQSP/S
         lTrJ9Ns/L7/qmvaGMkuPn9KAqOXlaeu5IXt0xaxegoiyiYjI6LZA0PmIPmUUcIoOLJix
         4STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ASh+58lXn/lPVLUPGwjNsQQCY/GNvPo08A078EXjLp0=;
        b=aKDgiRncSKuNBcguH6SOHZblktkl3uqyxlHQBILuwgm/Pg2bnQ4jUteYgrTDQLaqU1
         WMaEmeJFsjA7JBs29QzAU9jvS1dr/GznpzlkyE4KHSgOYWwCgpbQCGQplhDb7bTWNZqC
         7YuwXDQ7JQt/eV0DC6VmAfImLroQFH8qbcJInqzH+pF9SEoQpmlBQdNom9UMfS5dcRSR
         BykA+OUKUpUvPp79TVAQBgv4Npg3XJhzMtq5FsStWtl8sfSdO8Q4b90n1PpHVXhzOjX6
         On2ooCaBh2NG4opz56P4Qo74Pea756ka80UPI696j0UuOyrJ33rT6oarxIgsKTyZ4Flu
         SDlw==
X-Gm-Message-State: AKwxytejS83TKsmrXKHDfeUNW7DtygHQ/OZH0XLT9STYkhnT4ZzDp/jZ
        uEQyTt8vzJZ0ZtYNAFxUEmktvk+l
X-Google-Smtp-Source: AH8x227NyW+CTf/8c5M1qV+GcXahDp4p0F685Lxu1AlP7qp9ChDYMP08I9VmIgtMDye1sPrvv7O4lg==
X-Received: by 2002:a17:902:5481:: with SMTP id e1-v6mr3724338pli.410.1517547486110;
        Thu, 01 Feb 2018 20:58:06 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:58:05 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 4/5] submodule foreach: document variable '$displaypath'
Date:   Fri,  2 Feb 2018 10:27:44 +0530
Message-Id: <20180202045745.5076-5-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202045745.5076-1-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
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
2.15.1

