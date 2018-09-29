Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BC81F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeI3BkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:25 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33930 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeI3BkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:25 -0400
Received: by mail-lj1-f169.google.com with SMTP id f8-v6so8744898ljk.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peAfcrMCwTzr8JvcGSBo29sgF3aTa4S1yNrHBSWYrUo=;
        b=bNcWp8cSl9/oZvFEofj/Yy74pamAeWAFw5tdbpvyyvnY4aaUTAeBAz2oUE8hiaywCO
         XAfttv/HzC2ZhVtARCuUXVBVGYypvYakuhNHQoA825YcyXQXRqFtAnu6jSeoh5nmftQp
         xMnbe9OP7Vj+iqJ/7NdPZ8Gtrxdar+vci8HFXfUszolAmd/7D3si1AnlkMqXMgvW2bl5
         UBavS7iZJoSJ0u7VGzeQnOhO1rQF4bS9hkSP5oRxNvQMOzeokyKcDZTshzdBGrQbpVDZ
         mx+f9W2XLPY9p1NxbHiTu39x9wbPIAZaXCHnJHcJt0ZemyjtuJypuUpyKvKj9Kk4ZB+f
         OpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peAfcrMCwTzr8JvcGSBo29sgF3aTa4S1yNrHBSWYrUo=;
        b=I2bqtEYOUIcpb/P6dI8Co1ij6VNPmrxhz2MbGodI6K7mzWNRus1xKVQmQjyv9n35zc
         ydvoy6T7le9bTuzGEEAxcOBHGMkR8Kk/eSQmrlQvRYJ6npSIVFqhoq2owuEmHQpkKb8O
         bBd+CX0GQdAsIODDtodIW0ROwLVvJV9NVl0mBr1zRoOQNoP70xGG3nQtqr7KQ9geklm1
         7AIp9MjciGf2lbIZr1Jiy6B2ViOEIVEQPH95VsP0x9u8zfnyou/5IoxPvFzxsNkuJtI2
         QQihOKT/BRf2ga2cO9cFbSY2hPZ8pqgqWI0xBOcnYjE0u4xwtIWK8XMtsKH8xGYH4qmT
         U0SA==
X-Gm-Message-State: ABuFfogh8xHqUCyu1b0PKcQ/hB8vEaga8Kj3h2h3XiV4xAXlMLDRkok8
        YDLQtv/2xbDg/CdYVtLDMPI=
X-Google-Smtp-Source: ACcGV61R8yRSxPrgl6FmxYk9nmpLtz7jJ7HQNgmT+veJ+e8WD1tIUEnqYl1YMn8/yDChy7riyQEGvQ==
X-Received: by 2002:a2e:5317:: with SMTP id h23-v6mr2251869ljb.26.1538248249116;
        Sat, 29 Sep 2018 12:10:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 6/8] fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
Date:   Sat, 29 Sep 2018 21:10:27 +0200
Message-Id: <20180929191029.13994-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will make it easier to check the HEAD of other worktrees from fsck.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 63c8578cc1..24f8a09a3c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -36,8 +36,6 @@ static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
 static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
-static struct object_id head_oid;
-static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -484,8 +482,15 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid);
+
 static void get_default_heads(void)
 {
+	const char *head_points_at;
+	struct object_id head_oid;
+
+	fsck_head_link(&head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
@@ -579,33 +584,34 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(void)
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
-	if (!head_points_at) {
+	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
 	}
-	if (!strcmp(head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (!starts_with(head_points_at, "refs/heads/")) {
+	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
-			     head_points_at);
+			     *head_points_at);
 	}
-	if (is_null_oid(&head_oid)) {
+	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
 		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+			*head_points_at + 11);
 	}
 	return 0;
 }
@@ -720,7 +726,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	git_config(fsck_config, NULL);
 
-	fsck_head_link();
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
-- 
2.19.0.341.g3acb95d729

