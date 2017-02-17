Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8A020136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbdBQOF6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:58 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36004 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934040AbdBQOF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:57 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so2264697pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35m45/pBT2vmF9x2+c7JiVQtpuPxXA45S9uz0OCV0lw=;
        b=u7KFR6Q/AJgQXmiXn3XbKY8b9DQgoBA2D4bl54OcFj1Yx3WNoya7E5SWXthZFDDifO
         a/ZBhzZ/Ftmu9OuEVcWl382xAk8bw7C0X33uBpt2wa9fISngqKFyr6W24/H06tn7qtb0
         5QBbOPNeVf7a+OOyN19nIJXvgWrmgg7pNuHXvX0f2Cg4ylg9IN/Xkrbm3HdTFEqrh/6O
         yh5Fjo/SZAu5K5nI+YrcG5nuyNtualK0+s8THx2uFbMiHYT1gGlfmRVqfhqulGLGp+iv
         PeEMvY6Brova5mvZomSQYeXmV49eGZpu0sTDHqYydATLpc3sUMyX4yFHoPeosy3Xv/AM
         jQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35m45/pBT2vmF9x2+c7JiVQtpuPxXA45S9uz0OCV0lw=;
        b=QrtPGn4v6WYc2G0tFdL2z761KchdaEqwO7eW1gv1/mKSJlpUYAPerx8DdE8H0g+c76
         4isrz9tUX46erJnqY6e+YLoB09o06vIqY2a+EfX/kFNgYzCUmcXKPVX90AqYMDM4cH3a
         Qf4HfaRFPzx4rtrW9DcYv7yHtn68sswj4Rt5sU6lZwHpd4F0rvOfHFj40j/uGKsBfTIj
         rI3KtI6FDs+Is0I7Lquuv98CVmCsftdRaSzAMMrGHb4JTVGuwkxH30vFBTsuttfjpHw+
         5ZGclgKP/mWKrl9sIz9UPWAn4KeoHlAlj2rdy4TTuFqrvwsiY1tOs5eOW8SBbqZa38zC
         /ECw==
X-Gm-Message-State: AMke39kvErqqBOoIWWIShusZrRcp7VSnr7nWkB+1rZn0lSrWI8kUUUpcGuszOpC0zcrBWg==
X-Received: by 10.84.233.206 with SMTP id m14mr11538509pln.153.1487340351453;
        Fri, 17 Feb 2017 06:05:51 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s21sm4450878pfs.87.2017.02.17.06.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:45 +0700
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
Subject: [PATCH v3 08/16] refs.c: introduce get_main_ref_store()
Date:   Fri, 17 Feb 2017 21:04:28 +0700
Message-Id: <20170217140436.17336-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7a474198e..10994d992 100644
--- a/refs.c
+++ b/refs.c
@@ -1445,15 +1445,23 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	struct ref_store *refs;
+
+	if (main_ref_store)
+		return main_ref_store;
+
+	refs = ref_store_init(NULL);
+	return refs;
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

