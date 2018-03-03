Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18B21F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeCCLhq (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38488 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeCCLhq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:46 -0500
Received: by mail-pl0-f67.google.com with SMTP id m22-v6so3677205pls.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GD4kXZ9tACzxp19mM3ZvjTsjhLRGMgqQM5NTrgg7WpI=;
        b=orKUOSy3tMcQXOC2f11YTG8YG34lYk78a0M0/bJ9xo57efOPg719MeSoiR3D02rGyQ
         D7yTPopg8FGQEwwdoktUpk3dJ2QDwsjo/h7eLO4sbpu+Et3RbkM9X4pfykQFSm9+zE6X
         hRntw0pgSzBK3pZUtHNWEQhuBhJSbLQQ7Ey9t3heWiPCJOBpjvjI5DDSkThDST0VuPlG
         BdB8mPXH/95VO4ARR5tXPQoYJ38wiPvo4AJxbu9fGkeQSx8ISlyo3CLlCHfFx8XcUtkA
         2JmXX0+srr31zYV0wM8HXmSWmSPfclvPvLBW7Q/ijufJ6UhusYRKLnGFqEB9JD06TGGu
         YvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GD4kXZ9tACzxp19mM3ZvjTsjhLRGMgqQM5NTrgg7WpI=;
        b=RUyZ3Bf1GeM3pwy1bbZaQRLEsuk3NJ8SF5IMEHIAw4LKcwkt/CMOfdZECdIhw25prb
         0l1kmqISdNdOPaSgVcJLfuIfoX+OMdl+nYygnibrnCmKOuTL8o2HfhZZzMhoHKbemLot
         xX8Tgof0gt1XkAsbErIHCTBZ9XFJWdjFQHA/jkPxFofs2FsFgPxj1NANlD7R2dUSJbou
         vGFl7Pf3nOMA342RKueXGIPa5x71GUAp9GaD8AUeLmeQvcSPNY4WtP0YqIYBWw0GW569
         pEnt66b5C//03FazvAqkWtgCe0R3m+gXjv1ZuUR47bVm9n46NcJS4gxdwYcbtiMf/uwr
         CQuw==
X-Gm-Message-State: APf1xPAIEY8uqnid/W226bC4NjTrbS820+dHOa7/N9hpr5hoKZ65F6Oc
        1/TaOUTwYNA3nn3dA7AEb0XgJA==
X-Google-Smtp-Source: AG47ELtMvIyC6NYv9hufVF1VgN9To4yoBo02GX3qyA7or2lsBSGlfOmNl9bhkPGLHxMpZqtzEoP+9g==
X-Received: by 2002:a17:902:6805:: with SMTP id h5-v6mr7974722plk.46.1520077065418;
        Sat, 03 Mar 2018 03:37:45 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w88sm18682226pfa.50.2018.03.03.03.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/44] pack: move prepare_packed_git_run_once to object store
Date:   Sat,  3 Mar 2018 18:36:05 +0700
Message-Id: <20180303113637.26518-13-pclouds@gmail.com>
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

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h | 6 ++++++
 packfile.c     | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 1f3e66a3b8..b954396615 100644
--- a/object-store.h
+++ b/object-store.h
@@ -92,6 +92,12 @@ struct raw_object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
 
 void raw_object_store_init(struct raw_object_store *o);
diff --git a/packfile.c b/packfile.c
index 1e38334ba2..caeab0f68c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,12 +883,11 @@ static void prepare_packed_git_mru(void)
 		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -896,13 +895,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.16.1.435.g8f24da2e1a

