Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A281F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031769AbeEZN40 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:56:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40248 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbeEZNzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so14022319wmh.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLfJpWeIo0QtUwUFHRfcQPoRp2gWyTRMxrJWbhNoU2o=;
        b=JN1H8uqYQS5sBFt2BaTYYlIp4ZXxTLtwVgTExFgzcW0reN2i5RkfVGwNez7+IoMhSm
         Rb+rAM4IgwGPeDlUhjazqqNQLKY4cvTa973qCS6nPnRP/Q7P4YGmF3UA7B5hm7NfPr4j
         0HXkXeqgRRjXdIhJ1eW7WMCkJXCtt0NKeQnYTOfSMnU7CZGqsNNqXDTBwGc/MhyzgD8/
         Ohwz6wfDaX6QQlNKsgDlrJ+lviFA9ASwHyUEUn1+UGczIHRMCZDneQaA8wiFcL9NQZLw
         n+x287+ioj0k0X/jIEhdjpz/o+cbUg/o/ZPFU9DycDawRQlFjIFuc87+xaoQp3P0KFKd
         94gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLfJpWeIo0QtUwUFHRfcQPoRp2gWyTRMxrJWbhNoU2o=;
        b=UQ8UTgX/DerGUr4QDEerN3MSFZg+KVJkf4ApFYSI21pS/wkZhu6dBoj6yM8m7z95qq
         3JcNbqiHSJx1d7rGDaKB9K/ih9H3JC7/f/1mnWNVPIjh3jKkLriU3U9+sfx76cek32MW
         VpPmaQaCGnCpHAQAlc+5XGgpGsRG35H2yqJ8WkZC+fANqSNe4cV1qRmIRY/yr05dfYTo
         yCc/P9uRF664OkNRadZwbMtvma/ONjMOEiehmLnuvjZUsdaDATEbzJU0NJgubrpszZUR
         B552azCbgzvkLmZrKvD9MQ9+EdzOARpJNX9KYsxDVwlCcZ9dMTQuSCUmdOX8GMqvpCTc
         NwUg==
X-Gm-Message-State: ALKqPweFfPerkJW4O+CNMAmFVSIII8SVuEDVs0hlqWpn3qOzZjCEMlRp
        LUU/V+aK9cAC92TmnT+y9+A=
X-Google-Smtp-Source: AB8JxZpJuuZs9tzHolGrobm+gU1WVdugG1JhuwXsB9mQRS4mPVdaU7XhMWR85uD0Z5heDU+ZvEKq7w==
X-Received: by 2002:a2e:954b:: with SMTP id t11-v6mr4198988ljh.138.1527342944043;
        Sat, 26 May 2018 06:55:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/11] fsck: produce camelCase config key names
Date:   Sat, 26 May 2018 15:55:25 +0200
Message-Id: <20180526135531.4516-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fsck.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index b65ff2d856..ff1547d3c7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -74,14 +74,15 @@ enum fsck_msg_id {
 #undef MSG_ID
 
 #define STR(x) #x
-#define MSG_ID(id, msg_type) { STR(id), NULL, FSCK_##msg_type },
+#define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
 	const char *id_string;
 	const char *downcased;
+	const char *camelcased;
 	int msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
-	{ NULL, NULL, -1 }
+	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
 
@@ -105,6 +106,20 @@ static void prepare_msg_ids(void)
 			else
 				*(q)++ = tolower(*(p)++);
 		*q = '\0';
+
+		p = msg_id_info[i].id_string;
+		q = xmalloc(len);
+		msg_id_info[i].camelcased = q;
+		while (*p) {
+			if (*p == '_') {
+				p++;
+				if (*p)
+					*q++ = *p++;
+			} else {
+				*q++ = tolower(*p++);
+			}
+		}
+		*q = '\0';
 	}
 }
 
@@ -127,9 +142,8 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 
 	prepare_msg_ids();
 
-	/* TODO: we can do better by producing camelCase names */
 	for (i = 0; i < FSCK_MSG_MAX; i++)
-		list_config_item(list, prefix, msg_id_info[i].downcased);
+		list_config_item(list, prefix, msg_id_info[i].camelcased);
 }
 
 static int fsck_msg_type(enum fsck_msg_id msg_id,
-- 
2.17.0.705.g3525833791

