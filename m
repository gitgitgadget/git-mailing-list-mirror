Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8A91F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeJ0PFC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeJ0PFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so3085379ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+Rgr5ff/A4w9c0GFILNUvuu7mj9coxjOP3ODUcpIKo=;
        b=vBwWa7irPU5iCbvNO6E/8151L85kl8k0JCFc8hL/raXOFh6o7P9nAjhfqWSxmwQezr
         FeKrmQlFhTiGC9SyMOJEvJ1VlIC4Hth/2b16Nqn+vSDQDgqWei3Do6jGnr9/K1M1jeQS
         CuYf/FHQlEzQ9YsCX5SwYpje5P1eCNgj5hCiiG8U0mAPaqQRA8NLkKuW7mdjjRZR8wSe
         iuwJsxQ19OlW8LYn8Qx/khN45MLbXW4khkAVTKOFJl+vt7ANmDCy33SnuUBLgffwirSW
         DXWFsr/BLDYO10013ZFbMRNKS+tggucDz7nOvJRAXMZwhcbL+OOEKeSfQiKr+YvzFG/p
         yamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+Rgr5ff/A4w9c0GFILNUvuu7mj9coxjOP3ODUcpIKo=;
        b=L7kdHnclnsnR+21+Udhhjf2WW03aDdaIeBAlo3tlBUp3+mICChzYHQoFyo4FjANZXO
         wpMzi+xyEkeLXmt/r0D1ybC2RcDcsxonm/eWVvGF/vjFyWfW6dN8pom0u2KOd4xSdk/Q
         6ErWv2OmV4jxmIlKiFyVLiTkttpiUkcCvnzTy/vj37BtEDyA1HG31k7WIWW102XRQzb3
         IDRZXKfQrFEkCZ9OjJz8H9X2bppYH/NUgYUmyCgQ2YYhlp1QiAbPwRbnvRMaNlzYJtPY
         XIWjUG+U8iCzWHLGiaFDmSfU9IBqGjm+Mu87JtxQ/FaKbuoe/c/HmwytU9CRTshp0mxF
         l8YA==
X-Gm-Message-State: AGRZ1gKYa6KrYQ7QqrJ8qsislfE7Bsdmv/8jahE4KshxuDZWQEku/mHY
        qEPBNQJgbt6UthX+zl+gW2wBoQvz
X-Google-Smtp-Source: AJdET5caeJWUJl9w+UaTtTTnnx4ffap/SbD1upBGPYSvi4k3jsaD4vSHGT7ccTk8ngKk9PeZ6zmGaw==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr1924658lji.29.1540621505584;
        Fri, 26 Oct 2018 23:25:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 60/78] config.txt: move rerere.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:33 +0200
Message-Id: <20181027062351.30446-61-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
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
 Documentation/config/rerere.txt | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/config/rerere.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0ce5081f22..71bab1f3b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -399,18 +399,7 @@ include::config/remotes.txt[]
 
 include::config/repack.txt[]
 
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
+include::config/rerere.txt[]
 
 reset.quiet::
 	When set to true, 'git reset' will default to the '--quiet' option.
diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.txt
new file mode 100644
index 0000000000..40abdf6a6b
--- /dev/null
+++ b/Documentation/config/rerere.txt
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

