Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A8120401
	for <e@80x24.org>; Mon, 19 Jun 2017 02:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbdFSCok (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 22:44:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36159 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdFSCoj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 22:44:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so14602288pfd.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuGp1srLpm37vCSds5Q8H4ewcMAnD2u0ivHf85Ll8V0=;
        b=Knyt62VyyhX6BzwigPKwe4mthkSB56q+ESfTwj0AHSj/gts56gAqts+eTzMmqz61CQ
         W6ruPsdw148w0dSiKGY0IvVDLmQblgnd7Xv4zdLFB2ebEJrTp0oWKMTasMQ0iGYacSbV
         AkFB4JBrNYNUPU+ucol+318EwmyaAPKU5Ldh2GgDh1TOlSFE9FWetMRHZ+/GNh2RNPO0
         KcxiIBtNyLzma44JNb4uV7XTi0G4CSfKV7X0/52sU7xVIhdhvul9KYgXwe+JaWFfB157
         m8NBA+mVfAcBka1L62QorHPw+BI90Wwead239SjyyxT4hoXHaQsqQTC1buXY++2ZV4w6
         cbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuGp1srLpm37vCSds5Q8H4ewcMAnD2u0ivHf85Ll8V0=;
        b=sjOuI361HTd6Ix+qBojrpODcL7uT6s/PObXEcW8DfoZMh0LSkgH+jiAKaz/1CPzEbM
         +hLfgW2Mv+Pjr/tOSpWOgTcx0L30r9BnFEhQHY2ueHB6ga9fVx1hgoGcHkxf/pARONTo
         rwtyQLjfLVBjUs9I3AR7sY6SATGF4cDc35fqq3xMkjKGCE1wDZKVRUfOGP228i2wHBUV
         wN7FcdvD3BJ19aUxSHtwgM5jnL4IJqGlY3I7CPiR6K3dOzr7VhITtS9q5QU6I1QYg3YK
         BfgTI/h4uKv8Vb+20BlxZtEK36qzQBIYjxzOhdD1YrQiCpW6gj/MP0jM1jv1UKZxfqp3
         YyEQ==
X-Gm-Message-State: AKS2vOzg+G1mwbJt74nmF80HsOXFQypnyTDBaqVRBVbH6GgPPzZTfAFT
        gpZNADIzUxh/sg==
X-Received: by 10.84.137.165 with SMTP id 34mr26601399pln.167.1497840279060;
        Sun, 18 Jun 2017 19:44:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:8284:9daf:c00c:2460:a1a2:73fc])
        by smtp.gmail.com with ESMTPSA id t6sm7567821pgs.33.2017.06.18.19.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 19:44:38 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 2/2] Add test for the new status message
Date:   Mon, 19 Jun 2017 08:14:12 +0530
Message-Id: <20170619024412.5861-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
References: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---

Resending as a continuation of previous patch

 t/t7508-status.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fb00e6d9b..e9337c728 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1499,4 +1499,15 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'No commits yet should be noted in status output' '
+       git init initial &&
+       cd initial &&
+       git status >output &&
+       test_i18ngrep "No commits yet" output &&
+       test_commit initial &&
+       git status >output &&
+       test_i18ngrep ! "No commits yet" output &&
+       test_i18ngrep "nothing.*to commit" output
+'
+
 test_done
-- 
2.11.0

