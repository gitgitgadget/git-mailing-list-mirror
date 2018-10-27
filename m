Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBB11F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeJ0PE1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37864 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbeJ0PE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so2480089lfa.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5mRZPfwgjmfbGi4n8u3waq2MmmcAtOISyvpNXWB+yk=;
        b=ESC5hPU7J10hq1tk3o+k8ZZMD20YOq0TdNllqNeSeTgvDF+ILbYcrpRNs/FARyH4oW
         D19Fv0ssPLGuzLr7AAwfV/pz2DO3WkS9qtm/2w0nVnsrV1wFHC9bZ3dDu6xH2sfUGvq5
         QQsjK6Hf3/lhSLdbWOVp8yTZuaKGh8IJwPy/tMZ5Igys/1dsRLACJcTzGV9g28ycr77v
         qnngQhF0HDQwcnkqE6OnLwpx8bFRNc3DgQzTagdbCKacCkD6DdcsFyqLmOpfeU8D3wtP
         B6eaSbn+CoXYqADmS84u7jFgjFOv4TNjeNPOQxtzXIVxhWibFa1s+OvRT/aVvnRj+kkX
         O+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5mRZPfwgjmfbGi4n8u3waq2MmmcAtOISyvpNXWB+yk=;
        b=ezPPI7fDnA0iMppTseCyM7xo30Sxf1QcLKyA+9bYniK4umkxqr21T9FZOSG/kpNfvt
         Qjq+3iwvv2sPOxYx6DXvrlVWZi/UaIrvqny7YgjUtsssuqv61mzzreMsgr9stPZQkVtO
         RWH9P8XpDbuJjlZ0ZN6w8jPL+EnABCWBNQ4qjNVvuFoG1qK0EmtA1W2y1Qivg++Z7Cj+
         H5/uW4rduPnx7U5B3jjwkfpBthOZhezCLvkr1UwgPMFusUeZ4DnPXiofXR0wY7nA0nkp
         WNkAhW7xyTenCnNLpHQgT4AWUYjnD+y062rKz7kgrG2s3U48drAkQuqogzz/vZOKTwz0
         hC/g==
X-Gm-Message-State: AGRZ1gJm0T3aukgPmedyr8O3T7kafHywLvM/aZXoYuhFgxvMSs6t+zKP
        YPNYTNpJBJBPUuUugK0XLlgJiSOj
X-Google-Smtp-Source: AJdET5cwFwo0O7/sU8F8o/QFmHZzDycdjvyas3KqJZU5utjdr1Y/hM2fK0nBjgMB0Oyk9i/io7jDsQ==
X-Received: by 2002:a19:cd8e:: with SMTP id d136mr3692457lfg.3.1540621471514;
        Fri, 26 Oct 2018 23:24:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/78] config.txt: move gpg.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:03 +0200
Message-Id: <20181027062351.30446-31-pclouds@gmail.com>
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
 Documentation/config.txt     | 21 +--------------------
 Documentation/config/gpg.txt | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/config/gpg.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 177fefc83c..f52b89883d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -341,26 +341,7 @@ include::config/gitweb.txt[]
 
 include::config/grep.txt[]
 
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
+include::config/gpg.txt[]
 
 include::gui-config.txt[]
 
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
new file mode 100644
index 0000000000..590fe0d4ba
--- /dev/null
+++ b/Documentation/config/gpg.txt
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

