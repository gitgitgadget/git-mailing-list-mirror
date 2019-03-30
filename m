Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFD020248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfC3LVy (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfC3LVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so2222031plb.6
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=STuaPe9zGu6FgyrtUpwO/2UeYBAJsDkGU4qLHGDdMOpSqYYZS0OFJfodiW7Lx40Zma
         sRe9tqjMVww402X5AoeEriaFoqLFrtrkmE5k29Ykdh42t+u0dLB5Jhs/wic5h/Abwd/5
         u1o4Ah0Q3v2TmQ1DIW2POdBXF4uLscGXmno+Yl8G6ssq36XKuPvV04Q6k2A6McGjDplx
         rSxlsXuw7DFiLMoCddQQ9AztsQGYWpHhglQytD3j9oRRWO4kQ/YsbUOKjVIcuGnaUxFJ
         gg08Q1DdIjEG0aUsjitzHDZggvSCJaX47WxnCKqYSN3vED8g9NUZj19kBURqnypt0oKv
         i3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=jjXPsqZ8362Ui8ZUJFCGfY+jZtH6FebV79xu8qpneFKa1umvm8TuZ2+RWqpD1eUBLp
         EIELhQpRG0LIXUoVU6ZW6HNn+TggCKqhjsMMvtcLLOeOglWQ4WlNWBNmb6HEWQBklB9t
         /W8uYJPakeCNuNuODC7UuEMWc6DlRrpr0i17g14Zb251JDS8VkqzeG/7nWXnhxg5V4v9
         qveRMoyO9VmKw+2oEsxhEIMGGXvTdqcrNJfwVawWlhIzEOgUqpgryj4vGr6SYqvnNuhc
         d/BAzdBrUgXlUrrqIgF7qK4YgiSrlbLpCKTPvYIFrIHxbeMYZwEouNF6ZyIqOCQpwnrl
         rSSg==
X-Gm-Message-State: APjAAAUPFBPvwuUCWGm3FleGZ4W6xayTtFxRUnvtHQtSyX+FnD+rWJpL
        KZlcsuxhP/UfiUalHepgfhXGvjUb
X-Google-Smtp-Source: APXvYqwA+cRvwz5VieJi7j5VbNoVChy+9k2XLjZfTJ2AnLOUMews27M19bi+ZajoHIvvE8cc4mUqWw==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr53989540plp.137.1553944912961;
        Sat, 30 Mar 2019 04:21:52 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id e2sm7460948pfa.64.2019.03.30.04.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/31] sha1-name.c: remove the_repo from interpret_branch_mark()
Date:   Sat, 30 Mar 2019 18:19:13 +0700
Message-Id: <20190330111927.18645-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index af8bf5b351..7d9512ac44 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1412,9 +1412,9 @@ static int reinterpret(const char *name, int namelen, int len,
 	return ret - used + len;
 }
 
-static void set_shortened_ref(struct strbuf *buf, const char *ref)
+static void set_shortened_ref(struct repository *r, struct strbuf *buf, const char *ref)
 {
-	char *s = shorten_unambiguous_ref(ref, 0);
+	char *s = refs_shorten_unambiguous_ref(get_main_ref_store(r), ref, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, s);
 	free(s);
@@ -1435,7 +1435,8 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
-static int interpret_branch_mark(const char *name, int namelen,
+static int interpret_branch_mark(struct repository *r,
+				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
@@ -1468,7 +1469,7 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!branch_interpret_allowed(value, allowed))
 		return -1;
 
-	set_shortened_ref(buf, value);
+	set_shortened_ref(r, buf, value);
 	return len + at;
 }
 
@@ -1509,13 +1510,13 @@ int repo_interpret_branch_name(struct repository *r,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.479.g47ac719cd3

