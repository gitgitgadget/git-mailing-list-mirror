Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A481F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbeAXJy1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:27 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:41831 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeAXJyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:22 -0500
Received: by mail-io0-f195.google.com with SMTP id f4so4212776ioh.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/9YlM7mNjx1UjcqWRRcIG4KDStioAhO80OLHYpX/dI=;
        b=TwYfgtd7rujCSXoY+dfb4y/nPkOMaembaSegAxGDB/1g9QHWdAuRse4GLYE4odpMRO
         w8aXHanao/VHypPqMY+/AKcctZ3iguGEbZvmEV2SFg3ucy4aXMXoXbaGmS84ZVtYqHg4
         r+lEkDqWqWH/G0FaVIYz/5RETc+VBAndVJ7QZfErVfIWMGD9Y+wM5LTpA7iisttFuGf8
         LsIfVHGl/adelIiPx3qpivb09PjYA68hD9m0R2gaoPINRYCEXZsUEfZ9d2ull7k/yHW/
         IqL3ylNaf9o3hJxqrhqmRQZN8+fnio2orQ88l3p+84FGNACp9wzu7RublKO0f1mcT02k
         5gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/9YlM7mNjx1UjcqWRRcIG4KDStioAhO80OLHYpX/dI=;
        b=L43o6gHZGVh2uZrvLPe6U0dnnkL3/I5tbbanifW60D4S5bsh/l8FRCS3EyUmvBuOS0
         bXtrrmpt1FCdbzORvQ9gYwZa+6zaKTxcGhnxsiYu0BNCSVo9NktB6fpFwoeP2FvQXSUQ
         DGW0jUtPfgnx2L0bacFhi9ef/36d2AE6RmkOw9LTUnwZafp5hDVoXDbI89+iX15PDjUJ
         xbS9bNYJpoIAEfYIghR2bH1/2X6lfDYAnvDlD7bj71MGRnnKS/pfKfW92Hb7wyAIIPoB
         09aMwqR/M796ORCqFgdjUj12//aePCHzlVRLOH6CvfSFQEIS/KMt3/TkAByLaZmHs9CU
         QI8A==
X-Gm-Message-State: AKwxytdElll3YRONX93Mvga6ABO12xdNpGr6E7SIdKCaD/cqML8w1HWL
        VJp6ahLxW0upi7W/1jKY+lBLRQ==
X-Google-Smtp-Source: AH8x224YKZHoU3jZ16yFHtMxO11nuJyV5UbxJHpaQkk1dvkga3HjllUtZ3reMF04VrkYYg6+QgelzQ==
X-Received: by 10.107.6.88 with SMTP id 85mr7894090iog.24.1516787661627;
        Wed, 24 Jan 2018 01:54:21 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id s30sm10685516ioi.74.2018.01.24.01.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/7] worktree.c: add update_worktree_location()
Date:   Wed, 24 Jan 2018 16:53:52 +0700
Message-Id: <20180124095357.19645-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 18 ++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/worktree.c b/worktree.c
index b238d87bf1..98e9f32c7f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -326,6 +326,24 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg)
 	return ret;
 }
 
+void update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	if (is_main_worktree(wt))
+		die("BUG: can't relocate main worktree");
+
+	strbuf_add_absolute_path(&path, path_);
+	if (fspathcmp(wt->path, path.buf)) {
+		write_file(git_common_path("worktrees/%s/gitdir",
+					   wt->id),
+			   "%s/.git", real_path(path.buf));
+		free(wt->path);
+		wt->path = strbuf_detach(&path, NULL);
+	}
+	strbuf_release(&path);
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index cb577de8cd..a913428c3d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -68,6 +68,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
 extern int validate_worktree(const struct worktree *wt,
 			     struct strbuf *errmsg);
 
+/*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern void update_worktree_location(struct worktree *wt,
+				     const char *path_);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.16.0.47.g3d9b0fac3a

