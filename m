Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0292047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdHGVT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34883 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHGVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id l64so1397047pge.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=um4Rl7gpMubJ+H2UBAU22FGtFVdktYtpR9fmhExfjwo=;
        b=PaC7wTHEn8tRjkj8Wxkt97mfidSXSZsiNsgzqBIeM5GAjaiL23kUUgxEnbQOJdOef8
         ablHdlY36Dtok4zd5P5UjPsYmbwWghbjAlKTylb5D4MmZ78dr0lJGhaoXYqtygYLoZpz
         QU5i6F+DOF0qrNKyFF3qI0VYqQHWefbFzMGFc2QQlj4txmxDsocVWiq8GJP/FD2wPIRG
         4nGLh373vnNd8Lt6VhoFgL5K4Wi4Lk1xPiwBltD31+QkYWa1jnHuHyQU0ltZ7iMlkYf3
         YkptiZFIwJlDZJHCEOKWEbB+IilzBNjxnxqr2r0cKYbRcAaoZ0FicQvjjkbRkPwsCE06
         bdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=um4Rl7gpMubJ+H2UBAU22FGtFVdktYtpR9fmhExfjwo=;
        b=abGK8i6366e7LwEFZWqSNVfIpZIPGJV+30aXI8/IPxYnZYCBbTaHHxBfeHCqsVA1kQ
         jgPQbRRUUAkI/9+asEWXNSYVFxtEqDcrizkx8l8tl376X75N/ShtINRU37zHO2EdDI3P
         sK+gFY4NykuqGBsJdx4fw5dtYhmTcRkBteCZj7R2wURvjqUKIOr+A5cT7adKVcsSXH+a
         WBAgPxpqEmoLjMt/cN34VAePeLE68UMltY3CnpQc1Rb3p0XOvCVWW+Q6lsCXTyNXMJK8
         Uh+y6qaL0AeV+0XOJafBjnDln3Zg+KRe+5aKa33YfY47NfcvaBq9R1hq+ew0gSuBpDJB
         dLmg==
X-Gm-Message-State: AHYfb5hpY1S7DC9RNqYoTps1A1J4E8buUwtwMFWRpjBRTAIpnrrK298w
        I3TBdSoPoxRWEhqaaTQ=
X-Received: by 10.98.62.28 with SMTP id l28mr2038739pfa.14.1502140793782;
        Mon, 07 Aug 2017 14:19:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:53 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 12/13] submodule foreach: document variable '$displaypath'
Date:   Tue,  8 Aug 2017 02:48:59 +0530
Message-Id: <20170807211900.15001-13-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
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
2.13.0

