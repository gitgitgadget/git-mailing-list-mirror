Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF9D1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfBQKKs (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42261 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so1262961pgl.9
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huBFzSI8Lqky+j9Lh0cZehMN90XohdFUOVmkYqvE0JE=;
        b=IqlOkG9foDwi3o9mkGXxW3Ioqq/wNvVWtNwBxbQlIHj98gJuuZreNZMvX2c9JB4Nnm
         pnYaIqVxbaQSiYZwbERvvkUo4F4KBXWl5TTvTIv58twkIgG+EBLtZzNsEztnJEiaxaaT
         0FcolbG+dMf1+50KPr70c0lgUOXmDmsnNH5Cz+hIUfl0hlGge9F0ZgqW0SUTZBpZh4Wf
         u8wXIhEHtXdd/w22gxxjVxT4s53iAmVV+6u/8Y3vJjENCODjGeYCslNTEFeGEMBNmwVL
         A+gZB8kJRvoN6YGpU+wwckNQzCpL0TN98ZtHEcWOTJrzZVCHQXLDUVBv1+TwWXtL/ZAi
         T0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huBFzSI8Lqky+j9Lh0cZehMN90XohdFUOVmkYqvE0JE=;
        b=ATzDgH4bdoBKgsmB9tLWyJvRVOJ1NODy/Np/U7h2+Jty+Dm7S06UfeuV8X3+Qre7uw
         Cvlj/zC2M89bbxi48DFoPOlXkpSmGQ0M6FLzDXXlmtB9FZUggbIsyYr1ieBFoEnIvzYW
         9e0eD11tUcvqO7WFtc64GLnjedfm5V1YLQ+AF4bJzSbFR1PrwYJ1j1GJCIythuJuW4B1
         hkVdTiKqiUo/ZZuqKVXHsoZOWhX69uaDHPvLf8upL2cbYmkW8TFipA0E/7UccqBVg7fr
         G/54iKQWjunx9HrMOui3PWvQKIy3I44p2lV6CFootFbLd0SIhH/IUaiZnD9q1Swhc4nG
         VQjA==
X-Gm-Message-State: AHQUAuYICVJkDHO/N5vIBNvrdWAcdUseHsIwhvLDiHtznEPpwcAJvJZb
        S32M4OlFQ3PtFJiZjVd5oy1f4gBV
X-Google-Smtp-Source: AHgI3IZNUOry93CuqiIfLRVa/Q6SMYXh2zCImDmBt6IVNkMeC7ZlekMnYlnEV3hQQYEVfbRaWlUfaw==
X-Received: by 2002:a62:560f:: with SMTP id k15mr18407121pfb.231.1550398247055;
        Sun, 17 Feb 2019 02:10:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b197sm10659825pga.89.2019.02.17.02.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/31] sha1-name.c: remove the_repo from get_describe_name()
Date:   Sun, 17 Feb 2019 17:09:02 +0700
Message-Id: <20190217100913.4127-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index fb80306f1a..1cda854f02 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1097,7 +1097,9 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, struct object_id *oid)
+static int get_describe_name(struct repository *r,
+			     const char *name, int len,
+			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
@@ -1111,7 +1113,7 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(the_repository,
+				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
 		}
@@ -1162,7 +1164,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, oid);
+	ret = get_describe_name(the_repository, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.rc0.328.g0e39304f8d

