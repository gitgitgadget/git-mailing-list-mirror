Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1917C1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCCLjd (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46082 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeCCLjb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id z10so5129768pfh.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wl9b013LR4fvGwfVvILpKfM1HrrAuBTCNpqgTHQlDNQ=;
        b=LoLzUv/PObztvBzEY4ni35Usj16nmch7ePRuwbgtWqgteaNEdmVy84RjS1an4VBHHN
         aOtT28tx9NssRjq0MR6lNfNdhtR8g1MQzK0FDlwnG9LmYJ3cEiqVlDaDgukux/NQ7Y4/
         DukTnsSFBMGCc9swtsR8o0rzFiNB3fIx+vONpusA3vz09h8Ke7gc/vX4skxAgRgReblF
         SAaY7lXzXy4/vUSfxzb00uMzEvk4sSbyC7suTy7Y3kjdPSH7M2pbyt0j1o2xnvPQ2Tc+
         bvH3LJins3RjUtHjq/XOYZGzw/rNxInOndb+rI5Fuaz+7i8iAGXJQ+LSpK5GcsGPu1FK
         tooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wl9b013LR4fvGwfVvILpKfM1HrrAuBTCNpqgTHQlDNQ=;
        b=hqxbjz7VO5wFgF977bFkOkOOgvZ5t7vXfqAsVFlkAvJJoS3mguSxgeu2ueWNRExrxS
         qPEbBtKqfT9Q4bdgc5NlDoSyOpZr4NGMC372VgUQeQZNfahF4LNeQmwJutX8EVekyEzR
         7/f6uaIZFsdi8BDmXO4F1juxx1xpzroecpWFpRbwmHlz7Mhn5MRFZdipNDvIYfAdFoPK
         KgAlirGdHOZauiactBLH5tOSleeqdSoQl1/veaDLAEI9dM5q7RvGaEmrMKMjJWRd/GiC
         woa9r5vK6V6ARtd7uVaO9PdnY6zt0l4ueFCNfYhZWf0Gk4ALa54Y53oIB5rinKDh0rXb
         uGZw==
X-Gm-Message-State: APf1xPCFc3AhZqlq1ySbDzYizu/iixtgLR1FAhsyHyfnbHzXW7DAh9Kg
        kk2NDBB3q9zPV4AZ0d/+EMKSGg==
X-Google-Smtp-Source: AG47ELteGiRUY63WloQwq53nghHcCwIyf55EQxEHwQwhPlXgccWWIqAZI4u/aLm9I66NQRFALpbVIQ==
X-Received: by 10.101.65.131 with SMTP id a3mr6934883pgq.270.1520077170540;
        Sat, 03 Mar 2018 03:39:30 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q15sm1712806pff.65.2018.03.03.03.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 33/44] packfile: allow prepare_packed_git_mru to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:26 +0700
Message-Id: <20180303113637.26518-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as all lines are converted and it has only one caller

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index a0842521e5..0eaf5ee100 100644
--- a/packfile.c
+++ b/packfile.c
@@ -872,14 +872,14 @@ static void rearrange_packed_git(void)
 		set_next_packed_git, sort_pack);
 }
 
-static void prepare_packed_git_mru(void)
+static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&the_repository->objects.packed_git_mru);
+	INIT_LIST_HEAD(&r->objects.packed_git_mru);
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
+	for (p = r->objects.packed_git; p; p = p->next)
+		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
 void prepare_packed_git(void)
@@ -893,7 +893,7 @@ void prepare_packed_git(void)
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
-	prepare_packed_git_mru();
+	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-- 
2.16.1.435.g8f24da2e1a

