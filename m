Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90951F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031727AbeEZNzr (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:47 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33468 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754312AbeEZNzm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:42 -0400
Received: by mail-wr0-f177.google.com with SMTP id a15-v6so13555037wrm.0
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/0yfhjbB3+uGQmqYxEPKWIkNWlUj/RJNiFOOPr30aE=;
        b=CqWbns6gfOnNp5a2RUb9VsrjGw99ug0TtdVWSCoacVVQfGiVAPV5D58D18oaRMF6NL
         trN+Czt6qhvwFRrOPyd1VOBgHIrWi8pHBs9AQb7x+7gdXYK4MjmyocGayTux7eRYZ/xj
         dV29MHPNM4VsXl5QGs0Qel8pMEIUtohuRoy2rDDGFR2NSPzA2Vhk4f3w2ATKu6Gqizxf
         Mv8lp1l3c1PE0aIx+PDPnIhGNek21J0cHeIgI4uMObSVpmPZS3SGZUBwvnKI7gkutUTJ
         Gv8aZAsnghKh3tVYqlYg/9MTGVLAkX2Wh1slT5H99/v4/Y7vsbvFI1UWrSm/VCvdbHuu
         lPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/0yfhjbB3+uGQmqYxEPKWIkNWlUj/RJNiFOOPr30aE=;
        b=FZW1EK81r9H/HfsNZ1pELKkiPOxW4HddDuxK3sk7XUbKcWBdoPK7RFF2Tt8X3vpysJ
         aMzcMQuiMVVgmA0s4FEFdJOrRQkuVn5MCgIa8PGs1PaaOKKhi7JVNA5FIaCpMkcZwaKr
         0a8GLETW/g1alhlLMZwd6oFbuNcJI9NQaDj8aQTOHZS6LmpIY9FUnPLLDxgwSSwdBwWH
         GuEQVRzEFP2SGZByaxQSTDA6V3r2oMjH3rtieZ/KU5L+UhKKpTzkPy//dT58wTf+gOVi
         697yaz7dAHx697D2lIwV8LgoAPTUKNTz49nXJorEfFrVqudgAo0U3wmsnZqPNHigp+RB
         u7pw==
X-Gm-Message-State: ALKqPwfpaYD/trlxulmUZ3RgXWQMKpd/XbsQT4CnB8gjoV4FuKeTDYP8
        qcAd4ea+l43Pxn8ezF8z+4K5XQ==
X-Google-Smtp-Source: ADUXVKJm3NKaowelnuE3JCpNBGtnW3FFBt3BAsmoP3LEWrfzblo1DCfiwLMIpLqIRG0KDVMmn0VXZQ==
X-Received: by 2002:a19:15da:: with SMTP id 87-v6mr3671161lfv.136.1527342941567;
        Sat, 26 May 2018 06:55:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/11] fsck: factor out msg_id_info[] lazy initialization code
Date:   Sat, 26 May 2018 15:55:23 +0200
Message-Id: <20180526135531.4516-4-pclouds@gmail.com>
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

This array will be used by some other function than parse_msg_id() in
the following commit. Factor out this prep code so it could be called
from that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fsck.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1722f6cab0..e2a6f33891 100644
--- a/fsck.c
+++ b/fsck.c
@@ -84,26 +84,34 @@ static struct {
 };
 #undef MSG_ID
 
-static int parse_msg_id(const char *text)
+static void prepare_msg_ids(void)
 {
 	int i;
 
-	if (!msg_id_info[0].downcased) {
-		/* convert id_string to lower case, without underscores. */
-		for (i = 0; i < FSCK_MSG_MAX; i++) {
-			const char *p = msg_id_info[i].id_string;
-			int len = strlen(p);
-			char *q = xmalloc(len);
-
-			msg_id_info[i].downcased = q;
-			while (*p)
-				if (*p == '_')
-					p++;
-				else
-					*(q)++ = tolower(*(p)++);
-			*q = '\0';
-		}
+	if (msg_id_info[0].downcased)
+		return;
+
+	/* convert id_string to lower case, without underscores. */
+	for (i = 0; i < FSCK_MSG_MAX; i++) {
+		const char *p = msg_id_info[i].id_string;
+		int len = strlen(p);
+		char *q = xmalloc(len);
+
+		msg_id_info[i].downcased = q;
+		while (*p)
+			if (*p == '_')
+				p++;
+			else
+				*(q)++ = tolower(*(p)++);
+		*q = '\0';
 	}
+}
+
+static int parse_msg_id(const char *text)
+{
+	int i;
+
+	prepare_msg_ids();
 
 	for (i = 0; i < FSCK_MSG_MAX; i++)
 		if (!strcmp(text, msg_id_info[i].downcased))
-- 
2.17.0.705.g3525833791

