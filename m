Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4511F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJTUtW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33752 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeJTUtW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so33116305ljz.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ja8PnU4Om1g8Sx87JWGnV/62NoNyi17LQFMlVabGW0=;
        b=R1UWitg+EJUHjfNeipmPLw4fq4CEap3MXI4X4NobIi6mWCGBMX2vyaO0hHpusR/Rl7
         e8griYTvzsONTRB0UfUD34k7PlOa+PyH1AQKEmGfTmn/3pAmm/5wTxfmnbggQ9weDZDf
         YuhlHVMNDKeBuab0mxb9MmvvM91VNcuRrShM/pucRIfrx2Tvxb1jgdJNzS8yy380hX8C
         iNqngXtYliTR+ZesNEM57SDAKPV1vJNXsFi1vb2kdpq8Nu1W1XSphs2fMiuT14GRRq1b
         Na2qXduzNxVVB4jqtvuDygUXgDTcm+P2/MQ9zP6Lz7Hsa4cuC9tNRET41h+jBft1B/Zh
         8fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ja8PnU4Om1g8Sx87JWGnV/62NoNyi17LQFMlVabGW0=;
        b=XkDF9Zq5g/Z1/Xam6KoPqe5UBcTeWiwmWWgXsY+eX7Qq6Ymrj8JN1ddiOoJnHPe2a2
         9ydrCkign0NkFYZG5wPGWmaMZQ/NP2iVC90q3GfhDDq+9tHMrsqZmG+Yb7E52zVfWQHM
         3WweUoj5sBm9lmWVvk4CZgXOLjoStrkpbpeUa4jncaNxzs8oaPgK7Y3hhil2WW+sKR25
         1CxSBb7S6+z1mt5xUl4zOhDlR4lyR04OAEIWoENtFr802Q0/5s41JaCC1ptCMII29JLX
         0N/CHVx8itXUHdEHPUxqxlLitwTF/jJrGK2J//iTEmUTra1TX5931o/LCdm+Dj2s6SDW
         lN4w==
X-Gm-Message-State: ABuFfogrVSK+5BvlHtmNAKYXlCykFGgfYNAXnZ+nnj+oFlr9EBDsnEnq
        s9Ll1i0d9hg/5uPeiKnzBVSRgHWP
X-Google-Smtp-Source: ACcGV63LRVZX3tzJD/hl5GvUVFELYRc/oaicTIbecRRShkVvfegqvYyeHLpPy4BFNtfkb+lv0sCWoA==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr13589311ljh.65.1540039139923;
        Sat, 20 Oct 2018 05:38:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:38:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/59] config.txt: move add.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:52 +0200
Message-Id: <20181020123848.2785-4-pclouds@gmail.com>
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
 Documentation/add-config.txt | 7 +++++++
 Documentation/config.txt     | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/add-config.txt

diff --git a/Documentation/add-config.txt b/Documentation/add-config.txt
new file mode 100644
index 0000000000..4d753f006e
--- /dev/null
+++ b/Documentation/add-config.txt
@@ -0,0 +1,7 @@
+add.ignoreErrors::
+add.ignore-errors (deprecated)::
+	Tells 'git add' to continue adding files when some files cannot be
+	added due to indexing errors. Equivalent to the `--ignore-errors`
+	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
+	as it does not follow the usual naming convention for configuration
+	variables.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27c2a211c0..a52e0b3592 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -291,13 +291,7 @@ include::advice-config.txt[]
 
 include::core-config.txt[]
 
-add.ignoreErrors::
-add.ignore-errors (deprecated)::
-	Tells 'git add' to continue adding files when some files cannot be
-	added due to indexing errors. Equivalent to the `--ignore-errors`
-	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
-	as it does not follow the usual naming convention for configuration
-	variables.
+include::add-config.txt[]
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
-- 
2.19.1.647.g708186aaf9

