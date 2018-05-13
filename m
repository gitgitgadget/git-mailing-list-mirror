Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D62B1F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeEMFw1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41370 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMFwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id m17-v6so8218463lfj.8
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrMS+twmbWFlGUrqUk7wAtUcRBE4qJXxwe2Jp7YTUHo=;
        b=bFkyd+uR/vV2nracdEmw2unju2sTvWGv5sVPxhWoUCxURwaU8KMo5Syz1iizrscqx4
         72eDwynX4XMIvpsRZCTYeKptHokOB0ZDEIiQ3Pa+ZLSyrAu9Zk63tGyzxJmacBpJP1Zu
         oDZtHu0ih/OFNTX2RPWULxv23gll3AewcSGsItRfpT+Qj1uNqSPa4Yakkjtw032sd6Yf
         NSlLub0PhCacUHIgknSc25Ihv+0ZfvpVY9KEN02rCj4EDxTXRCMhQV2qMm/5MSErjEss
         1olQfy4reBdUx08kBIKvDLsFpgZsVuCcSwQ0q6R81H+1cs8p6ZKaXaocXqWX3iJBmWPU
         i/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrMS+twmbWFlGUrqUk7wAtUcRBE4qJXxwe2Jp7YTUHo=;
        b=kTyEO/cEAiC6/IFZcaQfm/UUT+qeqBfkHh5gGiXtMzUCuv5D2yUiZ/xhGmsemwIMh1
         0wIfkqyAv4hFjDKFIe1Tr3aLEXehUXhw77QzAXSEukM9f1NkEXF6GsJKDH8uP2TTt2go
         0PKozYe5D/128cdLL63QjKys3IdVSRcPXuq17cjcFsdnQEP1J2DrnkFEk557MgJRT0d0
         j8fOgZZo3Nv3FwerFGSo75C21L85kfBbVuj8Z3bPhxNEejIHb4A1TE0fVxHiR66+myTu
         3GDOoQxKT9lBz0YrT/NRzBEM4J2uVc19ozK9XKtnzc+Z4xfxupHai1DqbJeIU2C05wEO
         r3TQ==
X-Gm-Message-State: ALKqPweIRJoXelCVkXVdcOO3E6iD8EoViQZOYNwtZDfSMOM3OxkU3Pvf
        Pc3gl2Pg0g5Pp3SLExG+orSsPw==
X-Google-Smtp-Source: AB8JxZqQTpxe/ECaw1dV3OHKMaPXwp2Y1NYgBZA9ss0IGOxIdsSbvLBqdWuwFJ37w2t5gAAJlbKi9w==
X-Received: by 2002:a2e:91d5:: with SMTP id u21-v6mr2029667ljg.0.1526190739929;
        Sat, 12 May 2018 22:52:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/14] shallow.c: use commit-slab for commit depth instead of commit->util
Date:   Sun, 13 May 2018 07:51:59 +0200
Message-Id: <20180513055208.17952-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

While at there, plug a leak for keeping track of depth in this code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/shallow.c b/shallow.c
index df4d44ea7a..daf60a9391 100644
--- a/shallow.c
+++ b/shallow.c
@@ -12,6 +12,7 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 static int is_shallow = -1;
 static struct stat_validity shallow_stat;
@@ -74,6 +75,11 @@ int is_repository_shallow(void)
 	return is_shallow;
 }
 
+/*
+ * TODO: use "int" elemtype instead of "int *" when/if commit-slab
+ * supports a "valid" flag.
+ */
+define_commit_slab(commit_depth, int *);
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
@@ -82,25 +88,29 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
 	struct commit_graft *graft;
+	struct commit_depth depths;
 
+	init_commit_depth(&depths);
 	while (commit || i < heads->nr || stack.nr) {
 		struct commit_list *p;
 		if (!commit) {
 			if (i < heads->nr) {
+				int **depth_slot;
 				commit = (struct commit *)
 					deref_tag(heads->objects[i++].item, NULL, 0);
 				if (!commit || commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;
 				}
-				if (!commit->util)
-					commit->util = xmalloc(sizeof(int));
-				*(int *)commit->util = 0;
+				depth_slot = commit_depth_at(&depths, commit);
+				if (!*depth_slot)
+					*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = 0;
 				cur_depth = 0;
 			} else {
 				commit = (struct commit *)
 					object_array_pop(&stack);
-				cur_depth = *(int *)commit->util;
+				cur_depth = **commit_depth_peek(&depths, commit);
 			}
 		}
 		parse_commit_or_die(commit);
@@ -116,25 +126,32 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 		commit->object.flags |= not_shallow_flag;
 		for (p = commit->parents, commit = NULL; p; p = p->next) {
-			if (!p->item->util) {
-				int *pointer = xmalloc(sizeof(int));
-				p->item->util = pointer;
-				*pointer =  cur_depth;
+			int **depth_slot = commit_depth_at(&depths, p->item);
+			if (!*depth_slot) {
+				*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = cur_depth;
 			} else {
-				int *pointer = p->item->util;
-				if (cur_depth >= *pointer)
+				if (cur_depth >= **depth_slot)
 					continue;
-				*pointer = cur_depth;
+				**depth_slot = cur_depth;
 			}
 			if (p->next)
 				add_object_array(&p->item->object,
 						NULL, &stack);
 			else {
 				commit = p->item;
-				cur_depth = *(int *)commit->util;
+				depth_slot = commit_depth_peek(&depths, commit);
+				cur_depth = **depth_slot;
 			}
 		}
 	}
+	for (i = 0; i < depths.slab_count; i++) {
+		int j;
+
+		for (j = 0; j < depths.slab_size; j++)
+			free(depths.slab[i][j]);
+	}
+	clear_commit_depth(&depths);
 
 	return result;
 }
-- 
2.17.0.705.g3525833791

