Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05B41F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeELIAu (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38989 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeELIAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id j193-v6so11056086lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LW+pyqt5UBSwBWv83POmKw/oi13+BvJaAIl/301Z5s4=;
        b=hoch4IKn6po63XW/BFFn2lSAj2TfOUmIYaW06kaRGZVuP1WAOB9oA/qpthJFKXgMAn
         /fTpN7oqsXk9IpVMkeWC3WqMUCOZtPIWZaT6MpAQNGNPj9QCFgwNnI35vFqd2/54lsKa
         JAoTEDwlwEUZ9rruxeeXBVFYzUbjg/Uv4MDfw0glohwrpMA21PJ3pOPllo1wsNpC9QbH
         6o9LNG9jikMCXL1zw2KlshRO+ckGMuNtytu8Jbi0CTNgh7V3u9z3Jd27Mzrx3ub/TjWV
         F5LEC6BQ2PBTNgcnnj1YoOoO0gayXWMCVFQj7Lk8sApMKx+OyCDErxr9yK6i0dS7SItu
         eOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LW+pyqt5UBSwBWv83POmKw/oi13+BvJaAIl/301Z5s4=;
        b=ggPV5Y/1JGbE+qTk32cmabdkreU5fjuoEW3Lo9QuDqC3CVZWfbhXXKbgU6uoJHnF0z
         a33Jq3sEDNdNyKNxNEyYWDzwGqVq3TDzDr0eJuG6xeeaitCjgOzyEz1ayXs4XK9NURpr
         plbGJEksjZTAf11mPHKLS6YdelxLBj+nZoV8dUvuOOTRwzv8/boHgBrnoywIuwVbXSq8
         /7fpr64RteriIiXOWO46ivMqMCSeuV/g+TFgE+zTqrdkAPxQooteXs6fiGz0sqIkMsM3
         wfYb15XB7vfRyPrqEv6xRcJ+EnhYRgySqlr+vCdqvdpMGeMeilKGlKje4dgiA4+WV+U3
         MqwA==
X-Gm-Message-State: ALKqPwf+xqn2YO57nciwCDjlP5XhWgvYq6q6aZpj2i8nQ4Z/ViVANDaX
        xTai6Fo7CouvXjjaGkdFF2f4rA==
X-Google-Smtp-Source: AB8JxZpfQRCoYuz/620VuX9uYUIHgzDWHZ4gH29CUG+sDHfBZwK93+IKPIwmstOKfDHU41W5qEbWCg==
X-Received: by 2002:a19:9bd2:: with SMTP id d201-v6mr3340970lfe.52.1526112042271;
        Sat, 12 May 2018 01:00:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/12] log: use commit-slab in prepare_bases() instead of commit->util
Date:   Sat, 12 May 2018 10:00:26 +0200
Message-Id: <20180512080028.29611-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0d199ebd5d..b771d27164 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -28,6 +28,7 @@
 #include "mailmap.h"
 #include "gpg-interface.h"
 #include "progress.h"
+#include "commit-slab.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -1340,6 +1341,8 @@ static struct commit *get_base_commit(const char *base_commit,
 	return base;
 }
 
+define_commit_slab(commit_base, int);
+
 static void prepare_bases(struct base_tree_info *bases,
 			  struct commit *base,
 			  struct commit **list,
@@ -1348,11 +1351,13 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct commit *commit;
 	struct rev_info revs;
 	struct diff_options diffopt;
+	struct commit_base commit_base;
 	int i;
 
 	if (!base)
 		return;
 
+	init_commit_base(&commit_base);
 	diff_setup(&diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
@@ -1365,7 +1370,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	for (i = 0; i < total; i++) {
 		list[i]->object.flags &= ~UNINTERESTING;
 		add_pending_object(&revs, &list[i]->object, "rev_list");
-		list[i]->util = (void *)1;
+		*commit_base_at(&commit_base, list[i]) = 1;
 	}
 	base->object.flags |= UNINTERESTING;
 	add_pending_object(&revs, &base->object, "base");
@@ -1379,7 +1384,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object_id oid;
 		struct object_id *patch_id;
-		if (commit->util)
+		if (*commit_base_at(&commit_base, commit))
 			continue;
 		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
@@ -1388,6 +1393,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		oidcpy(patch_id, &oid);
 		bases->nr_patch_id++;
 	}
+	clear_commit_base(&commit_base);
 }
 
 static void print_bases(struct base_tree_info *bases, FILE *file)
-- 
2.17.0.705.g3525833791

