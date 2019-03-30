Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B8020248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfC3LWo (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33289 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbfC3LWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so342927plo.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=IUDLNowA/JkQg9RtYkmqJ5zqCtXPiFWry1mKhLRN/sfoGd25FBY1xPmcTjMdn9mQkd
         85SuMPs1soWmCO/5Sl63FL2+Ab41/LDHTa7tATv3JQjilj0cgHTSVmbBlswTsE9kIs27
         tbENckJmZBasWLS0kqWRvdej5Wa7mwT0Y/puVMBOng5NBVM+8OysSCLunxrMbvY3TkKj
         xVC/W74y/0wVdxBezbl/BZIpQ7eptXy9va4/lgcCQdqAnawFkZFDVrCumddCDZ6BxjIp
         BjaWEvBB9shLjgPcbd5WMX3s8srm5ZCYlIZoXqwol+xWW+/eNOUd3n1KdtwmAYxuoh5i
         dHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=KU1PhUy3lWOM/Ur/Ag8QxEq8sWS6V24Pnt5cTWRDrORHTtJaASmVjf73SsoCa7t1DT
         qv+vNhp0ZUq//XfzjQOmWl/vpWoSOzp9SE/b5bmc44fpYU5sPHJ0HrCeSPOOFwtv+szp
         lTL5XANnnIJ0n1bcr3cqidmgwJTqJI9aJsnJ9NQEri0Fwg7NAzLKwkb/ON7E9lAjuutB
         OugZ+zCdVCBtEo+8cBHw/CU2G9IWjsa0sz8OywGkXLl3Pjop4kTR936e+pvuaUWQzJUe
         Evmjsjh4slPwf8UogCoYsK8kMU24xVJT6jvagiL1m2LNFQZ/IGiNnd5CX/iSS8/4Wa2E
         Yl6Q==
X-Gm-Message-State: APjAAAVDjsfFBJvRYvkEP8GWgD+JyFKS5Vag8R6fEnBLCRoN1y0YnVKu
        6ucmp3lnQ5Qa3CrYy7MP6p2utlNf
X-Google-Smtp-Source: APXvYqwHE9c932SAYO4WfeS3LFARaDrYT9GdvR4Ch4sl28Wtx1eWekFm/rMsoYUoVi9i+gV5v2DnMg==
X-Received: by 2002:a17:902:9a5:: with SMTP id 34mr54428060pln.287.1553944963390;
        Sat, 30 Mar 2019 04:22:43 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id 13sm5808564pfi.172.2019.03.30.04.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/31] sha1-name.c: add repo_get_oid()
Date:   Sat, 30 Mar 2019 18:19:23 +0700
Message-Id: <20190330111927.18645-28-pclouds@gmail.com>
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
 cache.h     | 3 ++-
 sha1-name.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2149dc4f56..f6e87194d0 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,7 +1380,8 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 64a50d1291..953df0d692 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1573,10 +1573,10 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
  * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_oid(const char *name, struct object_id *oid)
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository, name, 0, oid, &unused);
+	return get_oid_with_context(r, name, 0, oid, &unused);
 }
 
 
-- 
2.21.0.479.g47ac719cd3

