Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139C61F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeGBAY5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:24:57 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53935 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeGBAYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:54 -0400
Received: by mail-it0-f42.google.com with SMTP id a195-v6so9882131itd.3
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9C0QC9QY778Fk45h5IJ6LUaAewo1IaB08CujlKdeyg=;
        b=I+U5zl8RQxkhEIYGEjeSFBMOjU3ZFhBKLFDt9aKXuFa5aOKsTL5eaQhcuhBTWe12XB
         zIbP8CRvHvAp/x3g/9k3M6IJ3h31WYcPqRX7YDzLB+U4x2c8JrzsOjuSzdNRZMd8LKeM
         5cE9OFg685hhtZrgu6eiTEvHmDFX5VeRq5bwiBFLXQwoqqud1Ei8RsxaCukOxVnSSlTM
         yICxkCOIV6Hx3uiSCer133v3T0vzICR0fGzbGvyHwX29BhHkMOvX3CMd2AiNqJ27/kUH
         eV9HOJ7SXm8ayq0a68DVWSkXY9YbshH/0/x6kzEbX2L+Yg8R9jvoYWNqBxiHx5DFvTNr
         CXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=d9C0QC9QY778Fk45h5IJ6LUaAewo1IaB08CujlKdeyg=;
        b=k7MSq34bIfFkM49VVLF1Z5mReSpn/9dy5qHA0eA+kf3KYy7qNUkXOhV4SQybe3cpH4
         JMyyUcsyIwJa1S63chJyNQB85rf1Nr3+6UYTnFs5zNyPCdkA4MmIPf46rBc6H/anXUf2
         mZQ2CwDVFP0BfgnvRpT4JqlV+sauxFmmHfBqJiaYxi1YX5POkWYgaGw3AYfuRljNTDR+
         PRQDnLX6fTNCRNVmTPGyR7rrwAHk7PuCAx+1K56zhcRUnLe2FLOdoZIS+IiTqTn0+sb4
         02vOT2j5kwUFedx5USrfdMJsp1DuxEB7CTqlmtSMsHxQFnFBQulL1yjlnzf53tbnf8rd
         2Ozg==
X-Gm-Message-State: APt69E02ObL5CKlLkgMfkb7Xwc8lmKBl+1afK1/1OD+tjJAGXOFMtwbE
        MkG3mOVRoJg6aSC7UU/qddLnXw==
X-Google-Smtp-Source: AAOMgpdlTehBZjM+mT17C6qdC2LAFjMhRPKUpLjUWFtUs5SYQuR9IW1Wm0DVAYUqvk9rdYECG2g/uQ==
X-Received: by 2002:a02:f02:: with SMTP id h2-v6mr19335956jad.24.1530491092835;
        Sun, 01 Jul 2018 17:24:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/25] t: drop unnecessary terminating semicolon in subshell
Date:   Sun,  1 Jul 2018 20:23:44 -0400
Message-Id: <20180702002405.3042-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3102-ls-tree-wildcards.sh    | 2 +-
 t/t4010-diff-pathspec.sh        | 4 ++--
 t/t9400-git-cvsserver-server.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index e804377f1c..1e16c6b8ea 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -23,7 +23,7 @@ test_expect_success 'ls-tree outside prefix' '
 	cat >expect <<-EOF &&
 	100644 blob $EMPTY_BLOB	../a[a]/three
 	EOF
-	( cd aa && git ls-tree -r HEAD "../a[a]"; ) >actual &&
+	( cd aa && git ls-tree -r HEAD "../a[a]" ) >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 35b35a81c8..b7f25071cf 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -111,10 +111,10 @@ test_expect_success 'diff-tree -r with wildcard' '
 test_expect_success 'setup submodules' '
 	test_tick &&
 	git init submod &&
-	( cd submod && test_commit first; ) &&
+	( cd submod && test_commit first ) &&
 	git add submod &&
 	git commit -m first &&
-	( cd submod && test_commit second; ) &&
+	( cd submod && test_commit second ) &&
 	git add submod &&
 	git commit -m second
 '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 06742748e9..6b09da79bf 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -328,7 +328,7 @@ test_expect_success 'cvs update (subdirectories)' \
   '(for dir in A A/B A/B/C A/D E; do
       mkdir $dir &&
       echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
-      git add $dir;
+      git add $dir
    done) &&
    git commit -q -m "deep sub directory structure" &&
    git push gitcvs.git >/dev/null &&
-- 
2.18.0.203.gfac676dfb9

