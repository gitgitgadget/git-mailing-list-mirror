Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D5F1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 03:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbdFTDDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 23:03:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32857 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdFTDDj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 23:03:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so13480730pgb.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 20:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9W+m5qe9mRXdBKdmLCr+2RqsDTrwgyGVzqczs772pY=;
        b=Jl6BnnBifNnmZmerQ1Zbh+I1ikjiss/+vj0nIJF/7j7GXUYIERFgVc09AsG6szmvlS
         Wh7avAQmD33qY2Al7yH7AHFJl6hGeqRvFB57EVyVtQzt3qvi+zeKT4MHO0Q2zg9Yogd8
         Fzq2N5YonyAlMPqh93M7SeZui+RkJ6GRUsfXBTRWnw/9e6vZEDjv2H1LttF1MB8cePOa
         QsV8rzOgVv/i57Jskt1NgRswPxeBEON1LNFU4CTCGU77d34TsqmmtGPylSIkQofwiJVL
         L/juCmlKkyz3gw5nT+ic/VZwY5ck0CFpNK6GjrbrDnVRMrGugJ7TYMPV5NWCmFsOO8A/
         brPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9W+m5qe9mRXdBKdmLCr+2RqsDTrwgyGVzqczs772pY=;
        b=UActf9tMrQ8eSF1ONkvTX2u511XSPSmqjbHHOM8sRUeJLTfughI81YHg3HsOtbCcFv
         XcocscJp/79ezMmehek7Eu5eMJDc02jZzsJJ3T8q6tkueB6Btf4RCmp/hIzJnBkRAw4D
         XbNjYXGBgPRLR1cbRp/maAv5wV2fxkQ9Ya2cTWNvCt9HgKNaD2uLmurI/oqKp/7zJrPi
         owoed9TC8SG1Zt5DGf214HE7YODtTeDqvb49A1P5WufgWaxDG1j1GsKQgztxj7ShkV0n
         FPWj2rO/eLZvmGxwYmMfrtVjxEwdnQ3iccwvaMfPNHAk8uaC8ncMsBCnLM7oZ4SgoQut
         1Bdw==
X-Gm-Message-State: AKS2vOy1ZotKOGA3CiMoGz1G8Nr4dykSEHSX/E+Sj8tjKkI3VU8HC7at
        ZYQjmyDGsS1smg==
X-Received: by 10.98.135.200 with SMTP id i191mr28666312pfe.227.1497927819144;
        Mon, 19 Jun 2017 20:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:3652:1086:ad92:af48:f1cf])
        by smtp.gmail.com with ESMTPSA id 186sm22585415pfv.15.2017.06.19.20.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 20:03:38 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 3/3] Add tests for the contextual initial status message
Date:   Tue, 20 Jun 2017 08:32:20 +0530
Message-Id: <20170620030220.7323-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
 <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, fixed minor spacing issue

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/t7508-status.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fb00e6d9b..6cf3af9d9 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1494,9 +1494,39 @@ EOF
 test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
-	 test_i18ngrep ! "^M. sm" output &&
+	test_i18ngrep ! "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success '"No commits yet" should be noted in status output' '
+	git checkout --orphan empty-branch-1 &&
+	git status >output &&
+	test_i18ngrep "No commits yet" output
+'
+
+test_expect_success '"No commits yet" should not be noted in status output' '
+	git checkout --orphan empty-branch-2 &&
+	test_commit test-commit-1 &&
+	git status >output &&
+	test_i18ngrep ! "No commits yet" output
+'
+
+test_expect_success '"Initial commit" should be noted in commit template' '
+	git checkout --orphan empty-branch-3 &&
+	touch to_be_committed_1 &&
+	git add to_be_committed_1 &&
+	git commit --dry-run >output &&
+	test_i18ngrep "Initial commit" output
+'
+
+test_expect_success '"Initial commit" should not be noted in commit template' '
+	git checkout --orphan empty-branch-4 &&
+	test_commit test-commit-2 &&
+	touch to_be_committed_2 &&
+	git add to_be_committed_2 &&
+	git commit --dry-run >output &&
+	test_i18ngrep ! "Initial commit" output
+'
+
 test_done
-- 
2.11.0

