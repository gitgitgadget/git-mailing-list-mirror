Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9B620966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdCZCor (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33050 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdCZCoo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id p189so4076438pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnUSRPeeq5IL8dxeTmC+exuYWynwpOH5L2w5L6hPd0s=;
        b=gf9AQqIE8bHakezw2BayzAzlcEeh75KP9pskBS5NQYxmk1WiyOh48NtAhC1W9KbcZf
         lc+m+76JxIMRG/svW4yqA/iWPJDK+7oB/E5/bPFi4HQzjTR4AMoskK//3cdH2nC0jStn
         +aFf7sqgTwzymfMjYaRQDG6drFyncZ+Y2wjRtJuZ6HFbZCcfya9oxRCgyauJYJJl17qV
         O/BAgJum8rkT6Xe9U/E0pMxEpSYiKac2Q8CxbBvX/sYAsTzSjZV8LFwscYlC9nZTwwJ0
         RCTZ540MFWbKHoyHf60JaHTYjAHXwAGk2Q+DfeB3Z9YOsCibNHfgtACEGGmP0962YXw3
         Mi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnUSRPeeq5IL8dxeTmC+exuYWynwpOH5L2w5L6hPd0s=;
        b=EhZlp1ccRDMmODvHGAiPr3XeFysN7tpN+o4AN+1ZgfbhXmQi7LALk24uQHzG+0DVi6
         Sn+0yFFnAK9Kg4b/Q0PetS8d5ItWLPL60gkry1OuvNWyHsdsic/sECU+2xdPL31j8sId
         Qv+j/vmEiAkaYO3dal9NrV4MmK6LUQuTztjNaZ7EAXQPyrAlqMzAPdiDcQ+LrQ+0WlB4
         7/sKQDaBSMQg/7Xeeo90XRgaxoYgC+GJ+PkknTdEwcLdo+MlYm0g5LP8q9NlPsupRn9F
         /QMOAKBvGqPTAW93q0mddi2xWKdaDWyboHU4YW2Q4Up/QSdwnvESgI/u4s6L9a7E4jEQ
         xu8g==
X-Gm-Message-State: AFeK/H1kgvkNjnW0hr/TXssFgUtJdMcgLtZQXO6Hzvgs+ap2+rm659aXMzsDAzBURwj9Wg==
X-Received: by 10.99.161.17 with SMTP id b17mr17422731pgf.72.1490496259643;
        Sat, 25 Mar 2017 19:44:19 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id t82sm12789311pgb.13.2017.03.25.19.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 14/28] refs.c: flatten get_ref_store() a bit
Date:   Sun, 26 Mar 2017 09:42:27 +0700
Message-Id: <20170326024241.31984-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
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
index a4a1a4ccfd..66dc84787d 100644
--- a/refs.c
+++ b/refs.c
@@ -1462,22 +1462,25 @@ static struct ref_store *get_main_ref_store(void)
 
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

