Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDD21F424
	for <e@80x24.org>; Wed,  9 May 2018 00:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeEIAaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:30:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35596 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEIAaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 20:30:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id j11-v6so21877538pgf.2
        for <git@vger.kernel.org>; Tue, 08 May 2018 17:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AK1/amCPfFdGzNAF8yr/Uu86wVg/SCuPy8Tb2jNgKW4=;
        b=lIUc1K3pSNEicvWsYYjLqZGKIn68Kst2wUPZ9HhvBRvFn1/p4uY+14TkpbhExwbO6p
         b+CzuC3Yy/dskMkGCRHqGY0yk/ScX3PzcnqrYAj7gSUAiH5gKutHmYYJLmZxd1y2Ui5b
         xlLDkKddXL5TWflbPkv+g8tYjbHn6csS+rOuPXtaFTvplYYDI7m0KklB8MeWPMqTAVzr
         davfMqYgg1sKsFxVF3kFvgZhxy/J+q2mfxSoqfB7QE1ed02C0kFa8oSJYaILyKII5x7U
         /91BRHpsYxdEbYfSZYLKHehdo0XT2cCsNS3upkWoKDvam/R/vS4XDY0zoBwJKWd/oxcu
         MtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AK1/amCPfFdGzNAF8yr/Uu86wVg/SCuPy8Tb2jNgKW4=;
        b=M+JLB7IxP947ywaBd7YyJiHfO//fJag2PPCIwKnW7WKTgZjHSTkTihAEYEGTaO0jOO
         puhSOo2nO5NDhhJGpBndw2JO4kGFsK1qhPufcmHudbUjfA6scw1TSw2EOOTOICisXGpc
         RFgC8zYzYPpT7bXVs09aUBkEgYnGDqaqnnVrD0bZWbZxkVIUQurVQjodOfVT5h3d1fBj
         n3K+2uObgtxurYpuub8e3I8zAGaN48bauf6w4WVriobeaL3YVPfu4H4LSNQsYrhdwsmD
         CaFcQKNQYcDWCc5a82+GIbQF72ofiGqWUhZ2pLYemGcnlAWbe8ujyI5i1PbQt425hLAl
         GUlg==
X-Gm-Message-State: ALQs6tAlIVmXjYAJIGtPliyRFc69p0hoVnmheprgV8pvhrZFFQXCU+s1
        93Itvk/MzY+xUy2uz2Gm5XuuAdJ8RRQ=
X-Google-Smtp-Source: AB8JxZqwVeUh77sDjNxGiopgpYBzYxbrpuRli5BCOtRU9bkc+zMePt7g+aRyZqSUoN+de6VLxzwAGQ==
X-Received: by 2002:a65:5088:: with SMTP id r8-v6mr29057073pgp.80.1525825804893;
        Tue, 08 May 2018 17:30:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b6-v6sm43187764pgr.52.2018.05.08.17.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 17:30:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, pc44800@gmail.com
Subject: [PATCH 3/4] submodule foreach: document variable '$displaypath'
Date:   Tue,  8 May 2018 17:29:51 -0700
Message-Id: <20180509002952.172347-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180509002952.172347-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
 <20180509002952.172347-1-sbeller@google.com>
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
 Documentation/git-submodule.txt |  8 +++++---
 t/t7407-submodule-foreach.sh    | 22 +++++++++++-----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 066c7b6c18e..500dfdafd16 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,11 +183,13 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $sm_path, $sha1 and
-	$toplevel:
+	The command has access to the variables $name, $sm_path, $displaypath,
+	$sha1 and $toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the immediate
-	superproject, $sha1 is the commit as recorded in the immediate
+	superproject, $displaypath contains the relative path from the
+	current working directory to the submodules root directory,
+	$sha1 is the commit as recorded in the immediate
 	superproject, and $toplevel is the absolute path to the top-level
 	of the immediate superproject.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
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
2.17.0.255.g8bfb7c0704

