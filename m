Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7C71F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJTUtw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37276 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so27143254lfa.4
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rsQPD/DAphXqmh++OERe5hZ/OI5zPxkPVB59bwTOjM=;
        b=I/dAE+YBINrcGtc7tblb5D+Vlk/dTMODeWDEtu2LTGuCcH2qyLfwXJAagVR3Md11Mp
         vm+JQewXbzkLh2UQAkq0AvGP+LLD8qDzKnZ+dmGAsjogNZvs1b7i/QrBEyk0yUN9pGUM
         EMHBAk0rVX8CBQvsu+1NTO8w7sR7gXMOp9GNEUC5v7rBIII0w7axhgtY97CEAeczs4h8
         r+Hu5sWWtx9ivFVe7mlDq5s0nsBsqDwnXW5q62icYgFs1MMDsT3m+tSijZ6ONRsbBo1M
         /TtYtQeiJn0HBPQ3uGcWU4cF6S9CCTErKRxOZPe5b5fJY8Jc4PeNfRGaI+NuGCtEDQWv
         EGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rsQPD/DAphXqmh++OERe5hZ/OI5zPxkPVB59bwTOjM=;
        b=GcE8CRUW/BSKW4UV23SI4EoJR+5ytT8ZqRPeikxNAX5mPAfz2KgrKNzBsvf1VUz2TY
         GOZaKXNfx+pkzF7TcbKEQJlrjzmVPSsubIlpfVrR4Kr0JZbITDtZrir73Tggmw4gNHuv
         UmkEfHv4RH0JRYmBcvVH791cm6pNuy3b3Dm+8zFdh9W58LbLZHcjieERfWwPQzbvVnM9
         oF9BqDZyrhnw49ARbxPSaYFhQEKcvdGzjF5OpyFY7y3ffPQ63rOCScbvWnK+b6f2mkSg
         B56FJCfgLZbh8qyGJZoiIk3O2geg5ddBovS9f9VYcWrOxcxAQXo6Kzhh++UBf52FOAPh
         C1rA==
X-Gm-Message-State: ABuFfoh46n/ic91ByatpDTiYLcWShJGM4Z8ZrtCw1EMXVHknlgYbsfNm
        ATqF8GnAHchA0KVESbartsD8XFpD
X-Google-Smtp-Source: ACcGV61S/TDnPRMi/GhQ+6+nnGE69ZX4F4IlVcLtMMIjfd/KZSTafufeEBBi5kEIaGEMqFtTbCUe7Q==
X-Received: by 2002:a19:a686:: with SMTP id p128-v6mr5194363lfe.42.1540039169846;
        Sat, 20 Oct 2018 05:39:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/59] config.txt: move gpg.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:13 +0200
Message-Id: <20181020123848.2785-25-pclouds@gmail.com>
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
 Documentation/config.txt     | 21 +--------------------
 Documentation/gpg-config.txt | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/gpg-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3065520a7f..adab71fd94 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -341,26 +341,7 @@ include::gitweb-config.txt[]
 
 include::grep-config.txt[]
 
-gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
-	making or verifying a PGP signature. The program must support the
-	same command-line interface as GPG, namely, to verify a detached
-	signature, "`gpg --verify $file - <$signature`" is run, and the
-	program is expected to signal a good signature by exiting with
-	code 0, and to generate an ASCII-armored detached signature, the
-	standard input of "`gpg -bsau $key`" is fed with the contents to be
-	signed, and the program is expected to send the result to its
-	standard output.
-
-gpg.format::
-	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp" and another possible value is "x509".
-
-gpg.<format>.program::
-	Use this to customize the program used for the signing format you
-	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
-	be used as a legacy synonym for	`gpg.openpgp.program`. The default
-	value for `gpg.x509.program` is "gpgsm".
+include::gpg-config.txt[]
 
 include::gui-config.txt[]
 
diff --git a/Documentation/gpg-config.txt b/Documentation/gpg-config.txt
new file mode 100644
index 0000000000..590fe0d4ba
--- /dev/null
+++ b/Documentation/gpg-config.txt
@@ -0,0 +1,20 @@
+gpg.program::
+	Use this custom program instead of "`gpg`" found on `$PATH` when
+	making or verifying a PGP signature. The program must support the
+	same command-line interface as GPG, namely, to verify a detached
+	signature, "`gpg --verify $file - <$signature`" is run, and the
+	program is expected to signal a good signature by exiting with
+	code 0, and to generate an ASCII-armored detached signature, the
+	standard input of "`gpg -bsau $key`" is fed with the contents to be
+	signed, and the program is expected to send the result to its
+	standard output.
+
+gpg.format::
+	Specifies which key format to use when signing with `--gpg-sign`.
+	Default is "openpgp" and another possible value is "x509".
+
+gpg.<format>.program::
+	Use this to customize the program used for the signing format you
+	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
+	be used as a legacy synonym for	`gpg.openpgp.program`. The default
+	value for `gpg.x509.program` is "gpgsm".
-- 
2.19.1.647.g708186aaf9

