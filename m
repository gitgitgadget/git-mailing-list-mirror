Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9128F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeJ0PD4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:03:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41750 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeJ0PD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so3099551lja.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xNi1wu5/NCI+Jcdkmn060YzovaziHykZYaqFItuBcM=;
        b=NeFcsm3WaACjQBXu+zsaRqxwgfOY3tnXddoIGlk/wR6KR2wev+/OK65Mfh8wkJAdzi
         QyhMHCOPLD24frMhemLesw+VpbTX7Bn5rrKj+bXm2upAJvU8fybEFouy/bNQIYF7PoEA
         vU+LoTu9py22PAOyC4093gDTWVccsQAvKMeZBzORBqmHpjcKFK1pcXv8JG+D5V1DITFm
         /v4iD+zk4w90UEgDJdLUUvRmUuQ8gJKwYbl+7jRNaPlS2Z3+LlTdeZHoIFgY1+2twGh+
         9KYb2+ELuoWayZBVlM49FTiUrz+VUyjEc0Z4inE3tFiOSoTwy95Hej7uv2bIoDFcy/qR
         i02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xNi1wu5/NCI+Jcdkmn060YzovaziHykZYaqFItuBcM=;
        b=JNkzoakEbaWi3SIR++cfhhJoSJb9UfPaOtpTzPnqBO+CYzZN+tD+Z5wNcYP2+5AMcU
         XEyrbJBRQYIOqcxWlO1Adr/Zri9jMWnMvNUpJVHYuy/CLpKk1H2kueMREOXH9ToS33pX
         n3UNTXMtUze2OAx+aNmBafLlHQLKLTaaJcllyRYKYvPX+fm8OIMu9ivq8KcvLrhQYNde
         tL7xwdK466i9z1MiHjesgoRev6ObKoeX1j9v1MNnaIu3WsPWN4wSmW1LbA35S55VAYQu
         0TzYewxXFlBHANQG28Cy7F1JSHLY85ElXpHhxgjT1Ed9A4vFo5DXVXDT34ptjT9rJOtY
         fxbw==
X-Gm-Message-State: AGRZ1gLrd+8F9CdTF2cOxlTDeq8JjI5Vr8pj1JzZhaAM9oCPfVn1dTND
        Tfhjc1DHvRz4Z6DTBy6entlFM5Xc
X-Google-Smtp-Source: AJdET5exk7ypSjIJCsHEVN+7CYoPOtuKFVdZ/x7LTfUBi+f4FdnLmX1+9Jp6QuCAKa/xEBqTFX+FNg==
X-Received: by 2002:a2e:2b46:: with SMTP id q67-v6mr4088440lje.126.1540621440767;
        Fri, 26 Oct 2018 23:24:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/78] config.txt: move add.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:37 +0200
Message-Id: <20181027062351.30446-5-pclouds@gmail.com>
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
 Documentation/config.txt     | 8 +-------
 Documentation/config/add.txt | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/config/add.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2ba70144c7..77e45e5219 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -291,13 +291,7 @@ include::config/advice.txt[]
 
 include::config/core.txt[]
 
-add.ignoreErrors::
-add.ignore-errors (deprecated)::
-	Tells 'git add' to continue adding files when some files cannot be
-	added due to indexing errors. Equivalent to the `--ignore-errors`
-	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
-	as it does not follow the usual naming convention for configuration
-	variables.
+include::config/add.txt[]
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
new file mode 100644
index 0000000000..4d753f006e
--- /dev/null
+++ b/Documentation/config/add.txt
@@ -0,0 +1,7 @@
+add.ignoreErrors::
+add.ignore-errors (deprecated)::
+	Tells 'git add' to continue adding files when some files cannot be
+	added due to indexing errors. Equivalent to the `--ignore-errors`
+	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
+	as it does not follow the usual naming convention for configuration
+	variables.
-- 
2.19.1.647.g708186aaf9

