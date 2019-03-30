Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7356C20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfC3LWj (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38312 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfC3LWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so2221912plb.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=XMEI2/idG7Axvn+oSI5oe1zCCVn1O6EWazHbA5Y7f8TJjfw13pg0SbQuSFsjXdpLF1
         RuKWslsFU1f7/TbFgq8Ah3hv4s/oEqza5IHyeDjunwHWIZj8Tz79B3ineH9PmnO2FxuJ
         iThkhlrzvpeeIywwwCNh3HiygvkOrT+DjPpz06Ag/Fs236CWvTNfhcmEzuIaR2LMuv/y
         8FayJouoxb9creT02QUeVX/QhbNbii5xGvIWfYhWLN5XfOEWvMsak5pi8hQPRDoV4Ovp
         P1/IH10aEwvqRso6BdVO2NpqzC2NVlr1NcC2bE9s1FkvoDnqIwpRAT1Ir5ZDn6Hdzcoe
         MT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vod4aOH+wA+JD7yNprXuqsVCLUsUss9P8ReeepwUd1o=;
        b=tBvrAVpRU/CmMth0sfGeJcif5I6m+6OpD1nMK0+1iehNG5KO8xoXaCl/xPvzvRLO64
         s9aJwLI8qOWafRnwqtZn+oINTDWAlUsI4boa/MNwsII3D+2W1Xg9itTSN5cbsD87ennp
         l3FV+qxcn3htyNIjw91cblsoUCKMP+syOhKBK8Fqd6zWbLwAv3pt7tK3gKXaOc+TW4LX
         mOMZl6T60QdTIbF+dkpwlpwDTkqSdvxdJlcxlIm8htcLnwRemQHkIKdvC+gJZ3KaEx3U
         dOETTqg5KZZ87urg00mj87o6wfQnA62ULNnCSFiylOA9g2Xy6WyPev2RxYBq/eT0y0YN
         IA+Q==
X-Gm-Message-State: APjAAAUveYW/KPT2Hn6STdC/x7DZnYryyH/s3MJ2qH7Y3k46GGoTuVnw
        ZzL6Rt07VNcfPJKzx0xljFIpy9b0
X-Google-Smtp-Source: APXvYqyrzMas0r1LJXOQdr+KPym5kCk5pTm7Hv4gStia9ZObq+WVCiuNV1uN11w7LvMraaPC3A81NQ==
X-Received: by 2002:a17:902:e709:: with SMTP id co9mr30801490plb.86.1553944958368;
        Sat, 30 Mar 2019 04:22:38 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id j28sm10627788pgb.46.2019.03.30.04.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/31] sha1-name.c: remove the_repo from get_oid_with_context_1()
Date:   Sat, 30 Mar 2019 18:19:22 +0700
Message-Id: <20190330111927.18645-27-pclouds@gmail.com>
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
 sha1-name.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6b53ea2eeb..64a50d1291 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
 
@@ -1797,7 +1798,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			oc->path = xstrdup(cp);
 
 		if (!repo->index->cache)
-			repo_read_index(the_repository);
+			repo_read_index(repo);
 		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -1842,6 +1843,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
+			/*
+			 * NEEDSWORK: Eventually get_tree_entry*() should
+			 * learn to take struct repository directly and we
+			 * would not need to inject submodule odb to the
+			 * in-core odb.
+			 */
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(&tree_oid,
 					filename, oid, &oc->symlink_path,
-- 
2.21.0.479.g47ac719cd3

