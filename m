Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6221F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJTUth (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35517 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeJTUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so6542058lfi.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYcpCekynwGlnlENHCbdzJJKziBsNILv8kiuOHJXZtQ=;
        b=Q35T1Hkabbh9NiTpjBYQajxfVAUVwpXaDCB1NTQtCqyTRy/0s1geAg1bqrHSy/Ztvr
         wmrHHhDvLMolBUltw3FNIW5lzV9+wlsb6UnC9IiaUP21MYm1EDZ1b386ZJWANU7n0NNM
         KxXkZqf5geKPvNX8GwyDt+t4YtHFbmy/Vi/LSqlqwMEXYF7GbJVRQg4vi6Z/jQx8w5EX
         3etK8NH13G/Gx+JVkE5opcH4v/RwVJdUjHVRGJXi2I6wix7myhcUC7YBPPRLlqKZ78Ie
         X7SIVr7D3SGIjTvdT9CnwPoahikoh2ak1C6DsxAkefRFWBn/74gCGVMrPXkjLcuvZKse
         66ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYcpCekynwGlnlENHCbdzJJKziBsNILv8kiuOHJXZtQ=;
        b=ngINUwuyLQCQIKj9tsnRp8Zv2nWIu0+mEXTZruF4KpyPHAXjoZ29ZjF52mPDIKISSS
         elSDWErpiXSJa0bXlJ+r/LL7HAr4wYDijX7v8mD/P6l9higDdRhlyQUWRECMz47JwNmd
         sM7Zni5C0xv3xPGiSGPTsBUeykm8qJ4DGTbQh4hTIvuLJb4aDqO13OgZl3Pg03jU/2Sh
         INPw4rEkxweECy+OELrE0SSYiFWDkOo4/2gi/FPiVhsr7q64o71GF6iPuUMpOKt1hH22
         5ql9+E+oDDNSVtLiQbv+JE9/8RZuMFqJlzRVjl5OUMVzs8oMzmY7PnmgXYC3YnVpum3E
         ug2w==
X-Gm-Message-State: ABuFfohXXszduas6Snpd8SCvV7Cg4Fhr2T1dGaeDL4h0AD4by/PABKG0
        0eHEbYcDBAHYZDtVOHmNlPCfuxoJ
X-Google-Smtp-Source: ACcGV63niHpM3QV5nMrqnCnbMuHV6iizFan36VInHYn971ou1wchIKCgQUDUHWKGVOumeaKEkhSZqw==
X-Received: by 2002:a19:111b:: with SMTP id g27mr5682869lfi.135.1540039154346;
        Sat, 20 Oct 2018 05:39:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/59] config.txt: move credential.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:04 +0200
Message-Id: <20181020123848.2785-16-pclouds@gmail.com>
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
 Documentation/config.txt            | 27 +--------------------------
 Documentation/credential-config.txt | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/credential-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59cae6a895..36a8d120be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -315,32 +315,7 @@ include::column-config.txt[]
 
 include::commit-config.txt[]
 
-credential.helper::
-	Specify an external helper to be called when a username or
-	password credential is needed; the helper may consult external
-	storage to avoid prompting the user for the credentials. Note
-	that multiple helpers may be defined. See linkgit:gitcredentials[7]
-	for details.
-
-credential.useHttpPath::
-	When acquiring credentials, consider the "path" component of an http
-	or https URL to be important. Defaults to false. See
-	linkgit:gitcredentials[7] for more information.
-
-credential.username::
-	If no username is set for a network authentication, use this username
-	by default. See credential.<context>.* below, and
-	linkgit:gitcredentials[7].
-
-credential.<url>.*::
-	Any of the credential.* options above can be applied selectively to
-	some credentials. For example "credential.https://example.com.username"
-	would set the default username only for https connections to
-	example.com. See linkgit:gitcredentials[7] for details on how URLs are
-	matched.
-
-credentialCache.ignoreSIGHUP::
-	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
+include::credential-config.txt[]
 
 completion.commands::
 	This is only used by git-completion.bash to add or remove
diff --git a/Documentation/credential-config.txt b/Documentation/credential-config.txt
new file mode 100644
index 0000000000..60fb3189e1
--- /dev/null
+++ b/Documentation/credential-config.txt
@@ -0,0 +1,26 @@
+credential.helper::
+	Specify an external helper to be called when a username or
+	password credential is needed; the helper may consult external
+	storage to avoid prompting the user for the credentials. Note
+	that multiple helpers may be defined. See linkgit:gitcredentials[7]
+	for details.
+
+credential.useHttpPath::
+	When acquiring credentials, consider the "path" component of an http
+	or https URL to be important. Defaults to false. See
+	linkgit:gitcredentials[7] for more information.
+
+credential.username::
+	If no username is set for a network authentication, use this username
+	by default. See credential.<context>.* below, and
+	linkgit:gitcredentials[7].
+
+credential.<url>.*::
+	Any of the credential.* options above can be applied selectively to
+	some credentials. For example "credential.https://example.com.username"
+	would set the default username only for https connections to
+	example.com. See linkgit:gitcredentials[7] for details on how URLs are
+	matched.
+
+credentialCache.ignoreSIGHUP::
+	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
-- 
2.19.1.647.g708186aaf9

