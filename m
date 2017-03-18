Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE4F2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdCRCFm (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33724 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdCRCFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id p189so4798475pfp.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gD07VKfCGYKhbqeq0Pb49oa1m7GqnjshJw8rWCVXd8=;
        b=BJQvTuuqie56rnSqb1pvefOduRaoGLs1Qo0KhwAL3qEWEFRBJLnpiCWHajXMQg3Hw0
         3HQ6F+3+phWjaKEPa+qC7+2SpQSVVOyfoiB1QCrT0Rs4RxZPC4Sq/1FN1KZ+r20BDzuC
         Foa0kbQw7VUVVzVVQK67nK4Dv/soNFUBimjaeRJ8oUX1FYzwavuDOIYN1b0jo+w8dLOq
         ROQvDhdBkpWqp+qd3STwyOuyWKeVQ0tgpG/DttJ4UriXgeMInuAC/Vb0QPH7feOBUS7K
         CSL5htUSohw/HmTB4do7sOR6fHNUd1cuFkImjgV5iiQy5+Zl1oNRivn6nqh2JUABBr5u
         odhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gD07VKfCGYKhbqeq0Pb49oa1m7GqnjshJw8rWCVXd8=;
        b=oO6vJlrGRhrozcTTPGI3GNq5EqpC1pKYBvkvGEKw1f17NtplLUF9HprOZf8JuiVJ6h
         EDCGGJgR0vO31BKJGWWEy93p3N154tyUpDMls2jp38+8yE0q6ZJ21sYPsxGvqg6xIQGg
         UvTk8vGoFPIMIQRq4LVQPHNi2+Gd3cq+RpCt0q45gJ1OROfp0xYlyJY++1BYVq2buRFP
         8PgCOZ+PpEMI+RUKbjSSUNJoYHeDYQlXhwWRhoxkWXA2aKyQs2GDp9BR6hJniPYgJIjY
         0PgSbPXvD4S49Va53IInR3ve8EvL7CjnWoIioOSRJY7Xx7QszS5gfQKkLmBww4jan4SJ
         jJpw==
X-Gm-Message-State: AFeK/H0orycfe5AbKh2epbPVXPwH3zK9NZ/iP3XN/DdarxY2JDDI/E1RO6yXLnkuR2GUew==
X-Received: by 10.84.197.3 with SMTP id m3mr23684868pld.89.1489802724800;
        Fri, 17 Mar 2017 19:05:24 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id e16sm11820339pfb.102.2017.03.17.19.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 13/27] refs.c: flatten get_ref_store() a bit
Date:   Sat, 18 Mar 2017 09:03:23 +0700
Message-Id: <20170318020337.22767-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps the future changes in this code. And because get_ref_store()
is destined to become get_submodule_ref_store(), the "get main store"
code path will be removed eventually. After this the patch to delete
that code will be cleaner.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 818d9f0ce9..f458423301 100644
--- a/refs.c
+++ b/refs.c
@@ -1465,22 +1465,25 @@ static struct ref_store *get_main_ref_store(void)
 
 struct ref_store *get_ref_store(const char *submodule)
 {
+	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	int ret;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
-	} else {
-		refs = lookup_submodule_ref_store(submodule);
+	}
 
-		if (!refs) {
-			struct strbuf submodule_sb = STRBUF_INIT;
+	refs = lookup_submodule_ref_store(submodule);
+	if (refs)
+		return refs;
 
-			strbuf_addstr(&submodule_sb, submodule);
-			if (is_nonbare_repository_dir(&submodule_sb))
-				refs = ref_store_init(submodule);
-			strbuf_release(&submodule_sb);
-		}
-	}
+	strbuf_addstr(&submodule_sb, submodule);
+	ret = is_nonbare_repository_dir(&submodule_sb);
+	strbuf_release(&submodule_sb);
+	if (!ret)
+		return NULL;
+
+	refs = ref_store_init(submodule);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

