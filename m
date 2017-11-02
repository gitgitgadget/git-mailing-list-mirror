Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADAC20450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbdKBGyv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:54:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46029 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755193AbdKBGyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:54:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id b192so4270246pga.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Y2lqQRd+AlpVGCjYlZDPUhiTdZdLC5VWOJzqBcNGyc=;
        b=a4LOiEONPyKUuX21orbYW0R/656rjhvtZDyaE4o2PlLiJ1pSE3W66BVtW2aMsXkeak
         QcHd3isIOj6vimDKSX5GagOJ4fgdjwBL6z8r4/2qGBxHYCAd23AMZOsrExmGwTJ73Aon
         n3u3KWXWyivc3/FYdiqJPfV66Pimy84Sy5FOAtM2at+hgeERcZtb4lLHm8BuBc9PRArc
         1Wk9ZvGy4NTtI6mzl6tfkM9xr0i6YsUeiasOQnu9rDF/j8xW/gOpQjgazJQq/FqNSRT+
         p5gHvvQpKDGfl8VFbZVXNqj5x5X7UDf6bozXPFzzxIzg6FOqB5Mw40K//cML6dBxIDkL
         AYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Y2lqQRd+AlpVGCjYlZDPUhiTdZdLC5VWOJzqBcNGyc=;
        b=oBQWLCrpaHpiJi92LOUDCuVRo/fk9EcF0/EvQlLTBkqDWW3DRPyi8olg+HRp20KMd+
         RaHPmhWxWEAe1+yMRTpeQ4Axe3+rw/VzSCNUEpPUT+HFvEx5hz0OHRaAELYuX9hyVKqU
         xALCEj00SJhwUPtn9c5J22iL5VZSHW3NzbpiOQ7goFMia41eFPuVM1xUZe0VFbVUJp2p
         WYsk5SFJPhX3ep6qFgmenx2TdGYnRkMrtmiktJ1VFROcNlHtWF0egbxA6or89+erGn5R
         fti1XLDHJnIzVSHmFjx1DRmdZf4Hyy78O1030NkdI+hrhZ6VOLUSCi5BASPM+HzdDpyd
         iGjA==
X-Gm-Message-State: AMCzsaUKCL7W0Yj+64VTTizOT6KZlfSkrHV681O/M9arZ6yjYIR06nHe
        am0SWzMj6QtkMgQW+xQAXD6kwNsgvns=
X-Google-Smtp-Source: ABhQp+TT0NUGPYOgwnbOfzOib5LOLGz+jDL7/B/gGQBEa9hr3begCmC0fHmNtfWg3m3KytYiBQNTuA==
X-Received: by 10.99.114.29 with SMTP id n29mr2515236pgc.303.1509605658304;
        Wed, 01 Nov 2017 23:54:18 -0700 (PDT)
Received: from localhost.localdomain ([117.243.29.9])
        by smtp.gmail.com with ESMTPSA id q12sm3843567pgn.56.2017.11.01.23.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:54:17 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 1/4] branch: improve documentation and naming of 'create_branch()'
Date:   Thu,  2 Nov 2017 12:24:04 +0530
Message-Id: <20171102065407.25404-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

The documentation for 'create_branch()' was incomplete as it didn't say
what certain parameters were used for. Further a parameter name wasn't
very communicative.

So, add missing documentation for the sake of completeness and easy
reference. Also, rename the concerned parameter to make its name more
communicative.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c | 4 ++--
 branch.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index fe1e1c367..ea6e2b359 100644
--- a/branch.c
+++ b/branch.c
@@ -244,7 +244,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head,
+		   int force, int reflog, int clobber_head_ok,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
@@ -258,7 +258,7 @@ void create_branch(const char *name, const char *start_name,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head)
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
 	    ? validate_branchname(name, &ref)
 	    : validate_new_branchname(name, &ref, force)) {
 		if (!force)
diff --git a/branch.h b/branch.h
index be5e5d130..1512b78d1 100644
--- a/branch.h
+++ b/branch.h
@@ -15,12 +15,17 @@
  *
  *   - reflog creates a reflog for the branch
  *
+ *   - clobber_head_ok allows the currently checked out (hence existing)
+ *     branch to be overwritten; without 'force', it has no effect.
+ *
+ *   - quiet suppresses tracking information
+ *
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  */
 void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
-		   int clobber_head, int quiet, enum branch_track track);
+		   int clobber_head_ok, int quiet, enum branch_track track);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
-- 
2.15.0.461.gf957c703b.dirty

