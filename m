Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677DA1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeBWXkf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45805 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeBWXkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:18 -0500
Received: by mail-wr0-f193.google.com with SMTP id p104so15661450wrc.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpW4RzFl3e1Zy5+J1KRM96cZR4YpMaV8ePmdJ3Wx/Hk=;
        b=H7piZvmcwMxYkwvgBPdC7bU0xaHjxeQi1PtkLfdUc3/hEimt+NyU+AFFiWWed7YOAf
         YpQAWuR2AXtIxqKUstNKXt+CnGkF6ikiU99074qkFNDitE2fsPZn+Fzeco+RUnTsAlDS
         Ux3pMr4RkdHCMXajMb1SOitpzkrkvvdgRoiLvocaRJMLblWdaavxipTiOvuqo3do/Ndq
         xaiAQmkvsnDzosaWpDXyO4zz5A1QWl7e8yyNsL17G4uoCrfRtY98KfG95rX0UBah9t2d
         g8pm6uo9UQS6jkJQpU2j9YxBU8JW9Am2N8rwohq0Fn+wmrK+ZAmuzNMpaYedu0UKli3f
         DBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpW4RzFl3e1Zy5+J1KRM96cZR4YpMaV8ePmdJ3Wx/Hk=;
        b=n3MhTakH4lEEJLRbBL+a19MLTtEY27B0wRGTOzJ3u2LuM56qFeIb61mqehJz7umb50
         ZxQLmjLv2VAaOxDO2fHHifC23DJqdxn4xLUhEV+HN03IOQCs08b1vQOG/vUbT2dFyQzk
         ekwAuyQfKr8ZGL1rqemCZzt21m/Bv9RN8L959g4u+zDJ5Fj3BebINPDLfFiUBnyyZ3eg
         4QAqpnti5g4ZbLVhcGCnudIZ/KiNzSNvuV2aGb2VL7mzty0pYMaXvKbLVk058ld34RQT
         /xqaLqqXlKtO9ZWnsRJ2p7qFoJjwAwYWd8f0CEFjsdftvDfftjh2t9xabE4T0dC1iN3W
         CfJQ==
X-Gm-Message-State: APf1xPDmu0mYssGFvOrssuctgofDLDsrJvN4sWIAfnbvomtaW2aAY7+a
        aNVsv/EK9DiJLlJuEzDa8YMr8g==
X-Google-Smtp-Source: AH8x226MMoh/U0R76gZnydV8pOKwIoVmadeP+oDgs1+XH4vcTtaOmMcXJzyjdv5v0RxYwR4IXdrxHg==
X-Received: by 10.223.172.167 with SMTP id o36mr3343870wrc.34.1519429216958;
        Fri, 23 Feb 2018 15:40:16 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/11] t1510-repo-setup: mark as untraceable with '-x'
Date:   Sat, 24 Feb 2018 00:39:49 +0100
Message-Id: <20180223233951.11154-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't1510-repo-setup.sh' checks the stderr of nested function calls way
too many times, resulting in several failures when using '-x' tracing,
unless it's executed with a Bash version supporting BASH_XTRACEFD.

Maybe someday we will clear up this test script, but until then mark
it as 'test_untraceable'.

After this change

  make GIT_TEST_OPTS='-x --verbose-log' test

finally fully passes without setting TEST_SHELL_PATH to Bash.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1510-repo-setup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 13ae12dfa7..e6854b828e 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -39,6 +39,10 @@ A few rules for repo setup:
 11. When user's cwd is outside worktree, cwd remains unchanged,
     prefix is NULL.
 "
+
+# This test heavily relies on the standard error of nested function calls.
+test_untraceable=UnfortunatelyYes
+
 . ./test-lib.sh
 
 here=$(pwd)
-- 
2.16.2.400.g911b7cc0da

