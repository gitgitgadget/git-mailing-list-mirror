Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F201F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeJTUue (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36486 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUud (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id l1-v6so7359736lfc.3
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KK/IxJ8/yYtcAG1hzYOE+JBsfrIT6Y0O5GI0yhBSCo8=;
        b=FDnPhxbAyIESooc/0BeCcYj0osTzztkW69GrVV4vluTqkkltO1tcADnppsaqESlCpN
         /zBXVfFAdF/1ynIYVTxRV/eaqFA/pGd+mNskzXI8YRTEs0twncvsqBfyNaYH+pq7T0E7
         UJoav9c0dfzJAKgE+ig+yNzBDCFwjqVUgOL1GbFfy8WOlxrKCOpbNqvDmKQ0MO3PniwK
         kSyINQqjIZpazas2V2QSAZLHMN3yRrkDGwXVox5Y0GARz2Gpr0YbREerNS315FW0L4bt
         txxs8sgHCUEHpK/5aZ1VVBgSbkHgpmWZIYmHF0jJUK8QdAtuxluQovQRdlC+6SVxsREp
         vUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KK/IxJ8/yYtcAG1hzYOE+JBsfrIT6Y0O5GI0yhBSCo8=;
        b=tlfquDqUh+jBJh08CwIWxVOKNG5y9JJJTn9YzXwIAckeY/WgsOn/eIFe6rijH7gdTJ
         hZcmQZlx/gHUMAH3g7IQudsFLv9cZy96gqEMLv6KSOFZKTMiG/jg+nVeQ8bclgB/026f
         N/zjwYS6SRtaMQDxHanQ6UzOesCBCcNtn3EEvJ15zFHqJx852YCurAbsIvv4ae7QR8G1
         vZAqyiVQOiVEl6CL/mEhnBci0rLLtV4w4SdfSWW8jHaTEKtFe1p4wQ0hMv4/vp3XCum1
         +dFoUHKzpnQRPc5T4Z/qBqw1R951GCrnFMofsekm6zPTb/T09ZSddQo1f+xw7XXG07mO
         x2Yw==
X-Gm-Message-State: ABuFfoirYE46lrNA+PJnGJy5ylDTajM2gqSNLsNaU1S7qecyHt/bYHKd
        qJWVwzyYfznB1RK96rAEVWEeAMUK
X-Google-Smtp-Source: ACcGV63Le0e9wZ+vhJoGW0wpnmmyGRZpPQAemEX/sWoAYY6BU2b/WZGJr+uRpibUBJpvy6rEXBWwwg==
X-Received: by 2002:a19:11c2:: with SMTP id 63mr5101475lfr.131.1540039211552;
        Sat, 20 Oct 2018 05:40:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 46/59] config.txt: move rerere.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:35 +0200
Message-Id: <20181020123848.2785-47-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 13 +------------
 Documentation/rerere-config.txt | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/rerere-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c3618b00a4..f42b69f3b0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -650,18 +650,7 @@ include::remotes-config.txt[]
 
 include::repack-config.txt[]
 
-rerere.autoUpdate::
-	When set to true, `git-rerere` updates the index with the
-	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolution.  Defaults to false.
-
-rerere.enabled::
-	Activate recording of resolved conflicts, so that identical
-	conflict hunks can be resolved automatically, should they be
-	encountered again.  By default, linkgit:git-rerere[1] is
-	enabled if there is an `rr-cache` directory under the
-	`$GIT_DIR`, e.g. if "rerere" was previously used in the
-	repository.
+include::rerere-config.txt[]
 
 include::sendemail-config.txt[]
 
diff --git a/Documentation/rerere-config.txt b/Documentation/rerere-config.txt
new file mode 100644
index 0000000000..40abdf6a6b
--- /dev/null
+++ b/Documentation/rerere-config.txt
@@ -0,0 +1,12 @@
+rerere.autoUpdate::
+	When set to true, `git-rerere` updates the index with the
+	resulting contents after it cleanly resolves conflicts using
+	previously recorded resolution.  Defaults to false.
+
+rerere.enabled::
+	Activate recording of resolved conflicts, so that identical
+	conflict hunks can be resolved automatically, should they be
+	encountered again.  By default, linkgit:git-rerere[1] is
+	enabled if there is an `rr-cache` directory under the
+	`$GIT_DIR`, e.g. if "rerere" was previously used in the
+	repository.
-- 
2.19.1.647.g708186aaf9

