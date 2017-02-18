Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0F3201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbdBRNe1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33277 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so7375152pgj.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOCVXCmCL6yod7WxYISNL8vYHxTcFyJChGhKC9ld2d4=;
        b=hgz6NgtBEOJNqZUDpBjgSIyV/jOqTnn5HEURnkLXHXI0i2o2yCojuzgzLv69jFfv/v
         M4+dju1KmawdS8bRdrp3RGEOFhBHzA8oTMlUgwe5ZCYGSBwbw9nZYYZzaphF0xzc3t/R
         cfcEYZCzxf4MUC3v/uh0M1LYfvWnX58v4D38yvieyf2u3C5ojigQ55te6v39Ar1psiph
         //4YBd3HZnHEHhMqZVD/vx1eDJC5w1aC9n9U+qizjrTiqbOxpZHbVKF/QbzVkPspXF1b
         XAMZFbJxLj3xWdZGzLgfJb1mj1dTuh4pi1VYkKPiyG9BUSUUpxFLyjnWt2RpaAcyzm4v
         RtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOCVXCmCL6yod7WxYISNL8vYHxTcFyJChGhKC9ld2d4=;
        b=iznLfPix1Zj5VNRTqmLF5sYV6zxrzaHDhdb+qyF6V6DAmI1Si1+rvfDVgoqOkJi24A
         GsPqG0zUEiAYuxm1g6d83JqeWnwuOtEzG22McC2RaW/aTAdORIFzEpzuxXfBSy25HIF/
         vsR58X8xgEnMKxRStMIoMtejMHjxN3YEYsPeglpGrlTiAe4olUpYaT72SA4w8gwEJKsa
         cfmoaddf+4Qi46AjKruZE9V5P++innziQ1+6Xf2Lq+f80USa6Zx8VM3JfYKAeLWh0F7t
         m8VJab4FJ7dVOrVG4zaDtVQr+nENkckON+uhwwnxkWrnKRRY/jeXPjclCeI3POvybOzm
         n5Bw==
X-Gm-Message-State: AMke39nJ6755VKjKQGsWzR97e2qss195PFwlLsgzESy73XfnNtOsfAbYk7p0K3NN6TvB2A==
X-Received: by 10.84.214.9 with SMTP id h9mr18021868pli.65.1487424866056;
        Sat, 18 Feb 2017 05:34:26 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 67sm25419335pfd.120.2017.02.18.05.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:19 +0700
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
Subject: [PATCH v4 09/15] refs.c: flatten get_ref_store() a bit
Date:   Sat, 18 Feb 2017 20:32:57 +0700
Message-Id: <20170218133303.3682-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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
 refs.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 6aab5e4ac..549eeccb4 100644
--- a/refs.c
+++ b/refs.c
@@ -1459,22 +1459,21 @@ static struct ref_store *get_main_ref_store(void)
 
 struct ref_store *get_ref_store(const char *submodule)
 {
+	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
 
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
+	if (is_nonbare_repository_dir(&submodule_sb))
+		refs = ref_store_init(submodule);
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

