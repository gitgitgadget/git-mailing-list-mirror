Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DFE51F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeKNTRs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:17:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35392 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNTRr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:17:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15-v6so14051155wmt.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYu92jpZM5pA3pHlzML6smM/yb7977g4DKySmxn5DbU=;
        b=Zh8uMVXApeqRM0nsbsJ8NrfySTPUwzBBkHJk+I40yZ9P5SomhS+i9MpHL6Ufi9nVl0
         weM9TUmpw66Zp2OW1L0pg+t/OVm0sYbnUl87I4ISskuRwOMOMR9xxBSSEM7LWbvzVb7k
         QFUH8/+87yVufnhks8Dw8BrRmJjfNWoMqX40IloANiL0ItiWZhFBP5UxRocaJalufabc
         2oxfaE4bmnpme0JcDdgDvbpF+Z03XkDWYeh64gIG8482vR34+AeeaHsgt+OJnOd0wOzs
         Dc5+Xs6xrjnHYz89Fsy01oMGUUx8bKJxRP8+duREYly/n3pC2xQMhfvKJFOQ3J+/4Y8Q
         Cq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYu92jpZM5pA3pHlzML6smM/yb7977g4DKySmxn5DbU=;
        b=gCAM5J9cjqTgTOzMnuOEEJAiMaGPmI/0UWH11b1gNe9/pmLWKsEmUy+3yeHWHdN2Bq
         Z4sB3ujhOAnYWhgNKc/8M8vYTTu89SXyUtUga5z0wADoW3IPpaN6E5hBylsH8/XUxL5C
         m6RzD96ljEpkbk7vLBRc7T+iaP879hL9paTLB3MCpUHqXrMe0r8+pdBfQMKyLUEXt0N2
         YPi3cWWsQbsVkpIMSusooQUojspBssux5UjVlb/p2zlJyK7Mu6zcN+cf8A7cSsynUe4K
         3+ZgXdNkrT9vJfcPSXJ9bQwlQL4ZLv8nzJ77abugmn0milISQRMrwoIzXzLKVUdm20Mg
         bWKA==
X-Gm-Message-State: AGRZ1gI11+nJBK/kq2Bie9De5QoZtuxP+zS8w8qxKXeWg8mi5ShQ5Ob5
        oyxx/l4uk3U4EFStsuryskj5gGLAONU=
X-Google-Smtp-Source: AJdET5d0f0Lsv/axDDccZ3RhVunO2pJPEEe4xGhtrwNFPK8wKpIn5J0cRX1xc6mZz8P9IkRW8xQCZg==
X-Received: by 2002:a7b:cb59:: with SMTP id v25-v6mr1120997wmj.102.1542186921995;
        Wed, 14 Nov 2018 01:15:21 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm16385228wrt.49.2018.11.14.01.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:15:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] tests: add a special setup where rebase.useBuiltin is off
Date:   Wed, 14 Nov 2018 09:15:06 +0000
Message-Id: <20181114091506.1452-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <0181114090144.31412-1-avarab@gmail.com>
References: <0181114090144.31412-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_REBASE_USE_BUILTIN=false test mode which is equivalent
to running with rebase.useBuiltin=false. This is needed to spot that
we're not introducing any regressions in the legacy rebase version
while we're carrying both it and the new builtin version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 5 ++++-
 t/README         | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..68ad8c1149 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -48,7 +48,10 @@ static int use_builtin_rebase(void)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf out = STRBUF_INIT;
-	int ret;
+	int ret, env = git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1);
+
+	if (env != -1)
+		return env;
 
 	argv_array_pushl(&cp.args,
 			 "config", "--bool", "rebase.usebuiltin", NULL);
diff --git a/t/README b/t/README
index 242497455f..3df5d12e46 100644
--- a/t/README
+++ b/t/README
@@ -339,6 +339,10 @@ for the index version specified.  Can be set to any valid version
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
+GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
+builtin version of git-rebase. See 'rebase.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
2.19.1.1182.g4ecb1133ce

