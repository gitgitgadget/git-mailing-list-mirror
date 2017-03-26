Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923D020966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdCZCon (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33700 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdCZCol (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:41 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so4696387pgf.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PITrHD8wQ24EgGSjF/uSlt46tq+XTfYKMsuOQnq94d4=;
        b=molO/lqd8drtMY0ZvQbec9LLMTL4Y40VNDfL0bMHU1tZ0X4mOBkOSr4GM6gtp/Mx/W
         YQVuJu6VDcEA+QH/4+ZCvE739fjIeAYxe61acAddkbUFZHejzI0smDB0ThAwost/C5qf
         ZZC7RKRO60aMxQo4OYjuaWI/UWb/7K5t7GSsFrnLf665nYUcZ7F5Oec4VvgECwEkEpzl
         omSgFkGGidzGN53I1EmXCnVSQWQLcuikRWTQe6lfIHWAjA2aDDy2ZqslOPihwaqk6gCh
         RJQo7eh9I3sIKOp27NnUhWk8JN4uuhEi41JtJyFjT0uFbSCp8XrX59ciN2dE6Fbod77R
         B6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PITrHD8wQ24EgGSjF/uSlt46tq+XTfYKMsuOQnq94d4=;
        b=IbCluL5wHaZG9clqcpd0BD/MityJTwUbEu8F624BeORuo/HuGj8bY2w7h7fVMAApfR
         F372QEN8UFlMbC34x8JOOeAQajXiDfXO+XWzp/dK3wh0Iok+vY2+sSkurlnEohZXwrwe
         5Gu83s0nrWI+jBgpXVyyG6/G+JR5DcQSQ8luh3M6Nw9GDhMPdumPR8oWP7LMiLjZynsP
         AXy0V1iNDJl2XOT54Fcs0FVc1nU+W0bCSDuU9JRUmnhBUAcEQFcy325ihFjmTR3jhD1V
         9Dk7MivF0QpXCne/i7zlGBz8015mXVrGhXXyA4kvbyC6nfGMKA4TbjvdTW5REdu4xkvj
         znxg==
X-Gm-Message-State: AFeK/H1S4UCd3wSWdTbJFt0rcK55YJ6Nmolh54lb3NvzhW8SiHNw8svA7nKCJnALQeqv+g==
X-Received: by 10.84.169.36 with SMTP id g33mr20829455plb.36.1490496247123;
        Sat, 25 Mar 2017 19:44:07 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c16sm12841424pfl.7.2017.03.25.19.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:01 +0700
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
Subject: [PATCH v7 12/28] refs.c: introduce get_main_ref_store()
Date:   Sun, 26 Mar 2017 09:42:25 +0700
Message-Id: <20170326024241.31984-13-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index e7606716dd..8aa33af4e8 100644
--- a/refs.c
+++ b/refs.c
@@ -1456,15 +1456,20 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	if (main_ref_store)
+		return main_ref_store;
+
+	return ref_store_init(NULL);
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
-
-		if (!refs)
-			refs = ref_store_init(NULL);
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
-- 
2.11.0.157.gd943d85

