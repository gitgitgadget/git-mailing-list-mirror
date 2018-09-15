Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990A31F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIOViX (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeIOViX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so10258213lfc.8
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=lEihDrVa2ey3oZxR7XVB9CDQiZQQ1BhZgXKZMHFs5p6J94IJL2c3Hq+MgicGUYrcc6
         mOvv+7JPpVKO95YVJ52yYkRCB1qWfvsqCm+wsm79q+MFmeRk5B54IUO8nUCoxUsBLwSN
         piSZNUR8CvCqw/mKRl5Z6qW5e+P0wX6pSWiNTlx8MUxXVkrCyyGNmaq9waeU7igkvwsT
         XJ2sWasMc/is89KQ9x0CAThFFUFdw2SRHN/sI2qXtvaGl0dRhohhwWeVEsoHmxbUhZCi
         XdRd4buwUpC7uGDpVqJrjk9eAZ4sOEX6zosUL7betsaXQD0l5ACNhmGPMObb/A1onUpY
         NJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=l3Zh36SCWB4jc6RxQZJ3akLhqAxBAbnWx0MuOLOmJifFjrDfjTQPWlee3KOlcZsMhO
         VuAMlQ2P6gLfsWeekiLJrVDqTdFlqIWw1VNze6/0LL7JBuNPYHZV6ewnuIjomlhwVyAB
         CoyU/1mnNNjaQP8L2COQx40m8Ot79cYWRinlrZFhwr9DajTX4QTl8qaRnmjv1FkmsnBi
         xdTVja/qStbVJs549oXExBRYR4kbgHZuqLVMkmFrDW5jFYWqBH5uBdAroLadwqdEzdxV
         lvqlAKnhirGdSpm7fk2/OFvsXTYy3FW7LI3Wt32TksRSaPBsbDxumyBrwB7hxQEu/9br
         43lw==
X-Gm-Message-State: APzg51DhLXTJg6SJhZajClvtU133MtcFlD/BAk1b/DTZj5Nb4/obonlY
        XJLeyqaQz2zMxesVDpA3fG5j2HK3
X-Google-Smtp-Source: ANB0VdaJVtWeif8ELgDlORCYNBrWLLPUKxzdDJzFP2mzlK12Pj+FgpcE3m1949H9U2pfvErRYgxZaw==
X-Received: by 2002:a19:5e12:: with SMTP id s18-v6mr11201829lfb.5.1537028331396;
        Sat, 15 Sep 2018 09:18:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 12/23] merge-blobs.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:48 +0200
Message-Id: <20180915161759.8272-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge-tree.c |  2 +-
 merge-blobs.c        | 15 +++++++++++----
 merge-blobs.h        |  7 +++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f8023bae1e..f32941fdab 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -76,7 +76,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_blobs(path, base, our, their, size);
+	return merge_blobs(&the_index, path, base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/merge-blobs.c b/merge-blobs.c
index 668fb2e05d..ee0a0e90c9 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -29,7 +29,12 @@ static void free_mmfile(mmfile_t *f)
 	free(f->ptr);
 }
 
-static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+static void *three_way_filemerge(struct index_state *istate,
+				 const char *path,
+				 mmfile_t *base,
+				 mmfile_t *our,
+				 mmfile_t *their,
+				 unsigned long *size)
 {
 	int merge_status;
 	mmbuffer_t res;
@@ -42,7 +47,7 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	 */
 	merge_status = ll_merge(&res, path, base, NULL,
 				our, ".our", their, ".their",
-				&the_index, NULL);
+				istate, NULL);
 	if (merge_status < 0)
 		return NULL;
 
@@ -50,7 +55,9 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	return res.ptr;
 }
 
-void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+void *merge_blobs(struct index_state *istate, const char *path,
+		  struct blob *base, struct blob *our,
+		  struct blob *their, unsigned long *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
@@ -83,7 +90,7 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 		common.ptr = xstrdup("");
 		common.size = 0;
 	}
-	res = three_way_filemerge(path, &common, &f1, &f2, size);
+	res = three_way_filemerge(istate, path, &common, &f1, &f2, size);
 	free_mmfile(&common);
 out_free_f2_f1:
 	free_mmfile(&f2);
diff --git a/merge-blobs.h b/merge-blobs.h
index 62b569e472..cc31038b80 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -1,8 +1,11 @@
 #ifndef MERGE_BLOBS_H
 #define MERGE_BLOBS_H
 
-#include "blob.h"
+struct blob;
+struct index_state;
 
-extern void *merge_blobs(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
+extern void *merge_blobs(struct index_state *, const char *,
+			 struct blob *, struct blob *,
+			 struct blob *, unsigned long *);
 
 #endif /* MERGE_BLOBS_H */
-- 
2.19.0.rc0.337.ge906d732e7

