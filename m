Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F8E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeJ0PEM (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeJ0PEM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so3123337ljj.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6drYUH1/GMSP/wuQcru46Wskz6GpcSWiimUIx8GhQo=;
        b=i1K36HAqZwsJh4Qki0DOHRL5E3AKsHQ6un7PPWfI4/ZDNDRZr6d64Smw3Jw6nH9BJj
         cc3rNGtP815lj17Oc0neSAKTsl5Cjb25VGedGpbIYn5ieSnmWhtTasJKD+7mfuDqSjtX
         K0+nkOg9uwRGsoO1I0uP5/bYaeM8dBKnVotJiQ13np8+u4LTYF7rXperVdJ7MXarLIqs
         2ArynBc3i2YRAjiWSRy5cppXyLq6gwCqGx1N5cM19DycCz8lA0tE9wIFtvLjf5JEgusD
         palGITGlPonfRsxPBO61zJHFWE5hsQ9Jco5NPHLGnEoICdBmk9OMAA7InZDe2+cuVuCn
         DLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6drYUH1/GMSP/wuQcru46Wskz6GpcSWiimUIx8GhQo=;
        b=jtUI/NKOCgJQsMFs8y57Wxr+o+cS8ZQBas7j5WoKV2XHs4Nv21UqssQDL3We6AMulU
         9f7wZXHvD2hezZHbWSILQmVWviUJ9fD4bXAiirT3JMokAX73ZZJ/xYMBlI0l2BMUQC+m
         cuRqq4S1kezVLIaGW/x8xLR9Pd+6ESkVrR+XSSYGpJfTL5oeXojLnPRtenwzBmJaJ3Ls
         F3W8478zT/XocmZ1eQCpsWHzGBPMTU5PqeNpE0t/kAC2MYKZZk9S0q74zXY5ylrbuVVi
         ZYz6WQbrpBV/hDGVylUvFD5KjYui3QlbUDSUYun56k0btRomQjgdN3NDqPkEEi5KTUmo
         P8pg==
X-Gm-Message-State: AGRZ1gJGGY/GRYlTfACoQuHDff9Xg2FF44dFdtHCqib6r7Xl3LQJPX8V
        q31A7mTcfGvMrw1r1Kw4nH53MzIU
X-Google-Smtp-Source: AJdET5dliVesFTcMDhbDx+iWzXQVmXnWAqS9fS41wPzGigPwhOjVTK9umitpa/8g+8tdh0x4nTpzow==
X-Received: by 2002:a2e:529d:: with SMTP id n29-v6mr4110445lje.54.1540621456350;
        Fri, 26 Oct 2018 23:24:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/78] config.txt: move credential.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:49 +0200
Message-Id: <20181027062351.30446-17-pclouds@gmail.com>
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
 Documentation/config.txt            | 27 +--------------------------
 Documentation/config/credential.txt | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/config/credential.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbae7e68bd..2c21a5f366 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -315,32 +315,7 @@ include::config/column.txt[]
 
 include::config/commit.txt[]
 
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
+include::config/credential.txt[]
 
 completion.commands::
 	This is only used by git-completion.bash to add or remove
diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
new file mode 100644
index 0000000000..60fb3189e1
--- /dev/null
+++ b/Documentation/config/credential.txt
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

