Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449341F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeFZHbJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33802 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeFZHbF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:05 -0400
Received: by mail-io0-f195.google.com with SMTP id e15-v6so15028007iog.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ltma7sN23cIYTIAiYUNs2sS4/B3lhpwscnFpzu6yMNU=;
        b=ne/4IwqVcXoarq1WReNNoTmD/hTZ090VFKwC3pD8F7MKOULZ9zrnPJpAaD0aDKjoEg
         bji6Jh+nd52uBFTtb7KhzVYONfWPSPyqGaYr5n0p9LNdYbVsuce7b8qXnu8SN0upt8KR
         kfNrufu/IfeKMzlbXY7969cV1TNadHBfNEqhOtuthfPF+8MhHGP6ryFUqKYMtiEs2xYp
         pHuPWn4DqPja9hV+9ZyM3gQ/jeL5j4RN7uYpzwaSnKVadlmKHoQ+NXi2Cb9XPqW9dUgv
         Yy5y5iqCJ5PvWxXMDa/3e2yWf3EqmWw5IH6InAa6fyNANyk+HMD099i63RKPTkB040JD
         HI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ltma7sN23cIYTIAiYUNs2sS4/B3lhpwscnFpzu6yMNU=;
        b=hC0pjQbmWzm6nzIvtgKQEDq7/M6nLQ8yGo1wOiWpo9nkr1ZW3Ccm8ewziuxui9SBi0
         93+2pBa3bfL1HgVr3AODPrxLdlKRAAO//uETGtHe5t/nwCy/jWkC1ECWxAxinswiUh6O
         ofJeOjND+8zCk05m47+kP+kiTH7EhaU9PdGsNcTTvCvQ7Avjjk0O7Gte1jb+0vDvtiL/
         hYTn52jTR3pHS+V1mK+rsw4X5/xulusIjV6fHIZTwNwuZ8fMyQ0Pap9zm/Q3Zu8AYiBr
         3sHXoZwGjlHFHX19TpVqPGIeDT75ATWNUocBHeyTp7s79VA9yB2JnWEXIlBve+vIM97C
         fThw==
X-Gm-Message-State: APt69E2HJ6SrwpPt/INDlbw+QOaeI3UsVpfPNVq3U0/n3W1uPFLprsdB
        CptJ0Z8soqfdIl23XeQtzzyJaw==
X-Google-Smtp-Source: AAOMgpegcOBZlTVzCQfeJUprr6P5NVv7bb/tKQIk63MzGsLfL34PYAk2doedTTZyV1Lm+FvBmUIntw==
X-Received: by 2002:a6b:a694:: with SMTP id p142-v6mr295411ioe.15.1529998264699;
        Tue, 26 Jun 2018 00:31:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/29] t: drop unnecessary terminating semicolons in subshell
Date:   Tue, 26 Jun 2018 03:29:47 -0400
Message-Id: <20180626073001.6555-16-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An upcoming change will teach --chain-lint to check the &&-chain inside
subshells. The semicolons after the final commands in these subshells
will trip up --chain-lint since they break the &&-chain. Since those
semicolons are unnecessary, just drop them.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3102-ls-tree-wildcards.sh | 2 +-
 t/t4010-diff-pathspec.sh     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.18.0.419.gfe4b301394

