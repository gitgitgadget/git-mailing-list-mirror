Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710711F462
	for <e@80x24.org>; Thu, 20 Jun 2019 12:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfFTMAG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 08:00:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36600 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfFTMAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 08:00:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so1565306pfl.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FCuVys0qgLTOkIUFxZcdYS1A2pZyTOGbD/f1SFsKnI=;
        b=Ki+lF6vZ3oxQu2nYuaBcIR3Ut2Sdb5GwKvy1qzemau6pUJSbuEjlZblke9w7gCdoN7
         J5Yau0ruFT5uanhlkLnTB4xv9tb2LA6sEzC4CV+mk97GlgqC5ZpIR/GGbMVO4QVdNlND
         9ynmL2xkBGj83GdY6+McdK5jXEVoViym+bpE1OLA1TPdMU5gZSAYIOHlyBLT7iPm2lkB
         EpSY6ZfUAkekoV6vKUtYv8xNx6GJmw6Ct1z/ECkCG6HqGSJ3UeUpPP3hD+U1xTiIKluA
         zTnGAB0ALT2IkT7bK6UJCslQwrOq1E2IC3pmZq8BY83WNLVpengIVWz9YBqa0ehoVfjE
         8rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FCuVys0qgLTOkIUFxZcdYS1A2pZyTOGbD/f1SFsKnI=;
        b=ChPbChKwCWVpCYeZ4+PXuyNMjNMC0Klxrs6n7zuEwSvyq/xyeYpB9UmlWBPz+iqBxL
         fdEbzXI21kwWazlqJKjyTZFap3c2rNZiBmi6DDRaglOUiLanh05czj6alBWEP4MkiReH
         zGcjnYMWj8LV5hwSWLbgfxzXQxEfPpLG31mJSp59GaEf89vg7qWg+Irha5UttCMMPNgR
         33CQ3m85i5h+hQIMDYYbP8irtXxfJQukFoZ/4+Gzw2uCCI07FvfWQLRjkyhe1vfw2hVL
         Kg3VwTq+kRr4hCbQ8k2a68jrnMd9X8tw9edxu6/cgSNLRMHXUXqOm9VB6wqah+v+h5UD
         r80A==
X-Gm-Message-State: APjAAAX3JiWm2sZCEyYNN7BZKVJ9EzcT9AueL0JMKNNa1NU8jppb0+Ld
        +kqYsfdaA5+wiiqL1U4AAbxeW7QU
X-Google-Smtp-Source: APXvYqwigdvrnm/VeydSjhLDP4DpfYGrPs29vg21tJUhZzr2Gk/bwCXc14etkz9geZL51gULw+r1zg==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr12512403pgl.103.1561032005660;
        Thu, 20 Jun 2019 05:00:05 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id j1sm24132737pfe.101.2019.06.20.05.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:00:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 19:00:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] fetch-pack: print server version at the top in -v -v
Date:   Thu, 20 Jun 2019 18:59:51 +0700
Message-Id: <20190620115951.13629-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620115951.13629-1-pclouds@gmail.com>
References: <20190620115951.13629-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before the previous patch, the server version is printed after all the
"Server supports" lines. The previous one puts the version in the middle
of "Server supports" group.

Instead of moving it to the bottom, I move it to the top. Version may
stand out more at the top as we will have even more debug out after
capabilities.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index de935f8776..445a261f14 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -902,6 +902,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
 
+	if ((agent_feature = server_feature_value("agent", &agent_len))) {
+		agent_supported = 1;
+		if (agent_len)
+			print_verbose(args, _("Server version is %.*s"),
+				      agent_len, agent_feature);
+	}
+
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(the_repository))
@@ -961,12 +968,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		warning("filtering not recognized by server, ignoring");
 	}
 
-	if ((agent_feature = server_feature_value("agent", &agent_len))) {
-		agent_supported = 1;
-		if (agent_len)
-			print_verbose(args, _("Server version is %.*s"),
-				      agent_len, agent_feature);
-	}
 	if (server_supports("deepen-since")) {
 		print_verbose(args, _("Server supports %s"), "deepen-since");
 		deepen_since_ok = 1;
-- 
2.22.0.rc0.322.g2b0371e29a

