Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F6B1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJYEfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 00:35:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJYEfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 00:35:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id q7-v6so6900430wrr.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2tFoXXIVHXrvSg6iB+8o/304iqdNZyjl15441EBxEk=;
        b=M+pWSDzjvkoWkrExqH858yY4Hb7iNbyPCCZUPvpBg7UW6QHQvXQp8hKP98qmXljIKH
         iTWZS5w/EtRu0dHngqB12c5J9miNjOF+Atpp/H7NMo75Mf6mMCvTjOa7nm8J2fC7rIV0
         6p0kUdozAXpLxlzyhusnMh4XHTswaP/3f6KfeexyXXmejR7xyLsro5vGxAhQyHdc1kKu
         ElpZ4SkZAzDO/ywx27QhYlSWY6u06qm4hEfKuFz/QiciD8H4NtVtuscwZndAmeSDLBmv
         GScCckr2iA3LTzY52K2OrkfwwLA7A+VU9A0xTcSjO4LUXbyWSxopcHEnqB3M1dMrozt3
         TbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2tFoXXIVHXrvSg6iB+8o/304iqdNZyjl15441EBxEk=;
        b=OBg8+XHzyIhNohWLBgr9L79z1SlHijmFTG3S92olmWeQtuolRIrM1t7vjJI6eFalcc
         Kgnn8jsOls7JkDuDdlaBdLzX7CQxd0i7WruxEeVYamKb2TWHfJG6GcsWvcimVW3LLIf1
         IyeJ/o2SiQaGfOKX6r9yN8vGUehgCL5J6khIRNGPFs+7jTxotBCXT6SU7rYvryL5QHv3
         FrynPRztOFDLH7QN3A9CovwFa0TPODkj7LnCqq0CmAmusaP5DO8l635Aac2bBFpxdqm1
         T0FYJaDTHXda3f/jTneqb2nnItmludAYWOFgISXN4wm4BsyjPodD6N4E7wkOHrUQSvHQ
         RWuA==
X-Gm-Message-State: AGRZ1gKts12awIwPsn4TobUkS5I6uS60/kRu+l/RWqnz47yzJmxP7lll
        +giRJm+Qtl/wUTMFAnk5cRw=
X-Google-Smtp-Source: AJdET5fY76qJingxG285ZINMGPRm1hKrFYHiYRDWEoX4Le4s27UVGDqOE7KGbklcJOHRpYU+zBNrpA==
X-Received: by 2002:a5d:5207:: with SMTP id j7-v6mr1235302wrv.192.1540411563467;
        Wed, 24 Oct 2018 13:06:03 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.197])
        by smtp.gmail.com with ESMTPSA id l67-v6sm9010512wma.20.2018.10.24.13.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:06:02 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: [PATCH v2 1/3] [Outreachy] t3903-stash: test without configured user name
Date:   Wed, 24 Oct 2018 22:05:12 +0200
Message-Id: <a055296c2034a44f02c253ce3194018b21eb4e1f.1540410925.git.slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <cover.1540410925.git.slawica92@hotmail.com>
References: <cover.1540410925.git.slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica <slawica92@hotmail.com>

This is part of enhancement request that ask for 'git stash' to work
even if 'user.name' and 'user.email' are not configured.
Due to an implementation detail, git-stash undesirably requires
'user.name' and 'user.email' to be set, but shouldn't.
The issue is discussed here:
https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3903-stash.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9e06494ba0..048998d5ce 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1156,4 +1156,17 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_failure 'stash works when user.name and user.email are not set' '
+    test_commit 1 &&
+    test_config user.useconfigonly true &&
+    test_config stash.usebuiltin true &&
+    sane_unset GIT_AUTHOR_NAME &&
+    sane_unset GIT_AUTHOR_EMAIL &&
+    sane_unset GIT_COMMITTER_NAME &&
+    sane_unset GIT_COMMITTER_EMAIL &&
+    test_must_fail git config user.email &&
+    echo changed >1.t &&
+    git stash
+'
+
 test_done
-- 
2.19.1.windows.1

