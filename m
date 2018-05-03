Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB9A200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeECAyY (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35326 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbeECAyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id j5so13240196pfh.2
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITEWbCzpsikQxl9su2M6fWagvcJ45YIoQgUhBbK1qro=;
        b=afBpQgtmNvxsa11YWXVh9arSGLeQa3RSzRa6aRgMrGqD+10NvsSRifKUPqlZEAPSFX
         LKD5AHemuF/0Pf9R76bT7Q9/aLQsU+N3kayE2hYcaZxs/h9L7fXnLoPfckURjmtTA1LF
         YY59llirXxhbbASBiHmAHoLZ103qXaRy38qgcgFayEb4jSMAivhK6oipmVVcvpVwhSAB
         TZNamluYR+a4ulo22KBF5RZndo5U01G0rTLbszTvcxcqzSWynEae0tNE/fE8gjQ2Dy3U
         yOwc9fDvA5Px1AB2B/G2YnWbN8ON5PPH3cE7PLVUxHsUx4lX99nMvDTqieS2KG/DwBhu
         A73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITEWbCzpsikQxl9su2M6fWagvcJ45YIoQgUhBbK1qro=;
        b=rN42n4cQE1aujJE8n3VVzTIGj+beBTm8rSzn0z1MrqP4L3xIynn94spa2eJtN4rnyX
         4QDIsy1zwgRFYEng1cMlRhckZXuAmiZ5O7zuIMZYMQS6MSkhCQmNn6AIEj9wYAB79/R6
         0b9gJiXVr5AcprQarhx2gCIry2q2JxnU4wqqurPVjObbCcwLHdOPKAfs3SrgKBbCPPHx
         URc9d3tvpC038EJqgYkFyy3s+nIe5aKWla8W2nCxJ/DyXBslBxdjFdafzeuNTbwuJtsz
         l6XE0WDJbe/Lp3hJkjyqnpNhHYCkhkBqBpC2nCmQ9BfTowezEl/Fn9I7ipqkYPLDKOx/
         2sxQ==
X-Gm-Message-State: ALQs6tA+Cu28bfJCqxTM1HvXi5ln0KDKlcr7i9Jv/aTI+YMWzPO5NXBz
        okV14T0ux0hPGgPOZfAC32Cpo386Jrg=
X-Google-Smtp-Source: AB8JxZrmCkXVMH2XxE7h7+ywuwBLs3pcph9iPHdKs6lBPgdd0RqcgyNywxMXabwLWbALc7n9c2U7qA==
X-Received: by 2002:a17:902:59ce:: with SMTP id d14-v6mr22449893plj.253.1525308859320;
        Wed, 02 May 2018 17:54:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a23sm22501491pfi.176.2018.05.02.17.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] submodule foreach: document variable '$displaypath'
Date:   Wed,  2 May 2018 17:53:57 -0700
Message-Id: <20180503005358.89082-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

It was observed that the variable '$displaypath' was accessible but
undocumented. Hence, document it.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt |  6 ++++--
 t/t7407-submodule-foreach.sh    | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 408d5a0387f..4372d00c42e 100644
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
 	$toplevel is the absolute path to its direct superproject, such that
 	$toplevel/$sm_path is the absolute path of the submodule.
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 5144cc6926b..77729ac4aa1 100755
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
-toplevel: $pwd/clone2 name: nested1 path: nested1 hash: $nested1sha1
+toplevel: $pwd/clone2 name: nested1 path: nested1 displaypath: ../nested1 hash: $nested1sha1
 Entering '../nested1/nested2'
-toplevel: $pwd/clone2/nested1 name: nested2 path: nested2 hash: $nested2sha1
+toplevel: $pwd/clone2/nested1 name: nested2 path: nested2 displaypath: ../nested1/nested2 hash: $nested2sha1
 Entering '../nested1/nested2/nested3'
-toplevel: $pwd/clone2/nested1/nested2 name: nested3 path: nested3 hash: $nested3sha1
+toplevel: $pwd/clone2/nested1/nested2 name: nested3 path: nested3 displaypath: ../nested1/nested2/nested3 hash: $nested3sha1
 Entering '../nested1/nested2/nested3/submodule'
-toplevel: $pwd/clone2/nested1/nested2/nested3 name: submodule path: submodule hash: $submodulesha1
+toplevel: $pwd/clone2/nested1/nested2/nested3 name: submodule path: submodule displaypath: ../nested1/nested2/nested3/submodule hash: $submodulesha1
 Entering '../sub1'
-toplevel: $pwd/clone2 name: foo1 path: sub1 hash: $sub1sha1
+toplevel: $pwd/clone2 name: foo1 path: sub1 displaypath: ../sub1 hash: $sub1sha1
 Entering '../sub2'
-toplevel: $pwd/clone2 name: foo2 path: sub2 hash: $sub2sha1
+toplevel: $pwd/clone2 name: foo2 path: sub2 displaypath: ../sub2 hash: $sub2sha1
 Entering '../sub3'
-toplevel: $pwd/clone2 name: foo3 path: sub3 hash: $sub3sha1
+toplevel: $pwd/clone2 name: foo3 path: sub3 displaypath: ../sub3 hash: $sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
 	(
 		cd clone2/untracked &&
-		git submodule foreach --recursive "echo toplevel: \$toplevel name: \$name path: \$sm_path hash: \$sha1" >../../actual
+		git submodule foreach --recursive "echo toplevel: \$toplevel name: \$name path: \$sm_path displaypath: \$displaypath hash: \$sha1" >../../actual
 	) &&
 	test_i18ncmp expect actual
 '
-- 
2.17.0.441.gb46fe60e1d-goog

