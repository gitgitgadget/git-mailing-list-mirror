Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983962018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbcF0SZi (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35675 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF0SZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so26930923wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9babPsFcnumEDYtCW1wk3t+0xqIDE9L5NSAHtLCBbs=;
        b=h+q07Zha9Ps1AayjiwpOfplDrJjN0vlNO3SeUPapQaoOcxQV/EM2K0T1FTHzmEVG+z
         G5oVPcRJG3QWYjjRMlv95ImsFhwweudUUjQyKShVVQqZBXXc24gDcbf+uHeOyKRYlmij
         TkT9OEaGj6kTpfN0YfxU1VvGGM1carTWqUXE2ucHTyZ82JBXBG13i9nyG0lngoZkmzAP
         Sov6CEpUKRFy5FSe/gSpWpZr9wi+UpOUK6Jh9DRUnNu3jBOWHPDsGYGEvLMx6I9B6N8K
         0EToMYi3oPJ20WCo5d5DxYiKMQFf07ghjgRtlWan0GzZAFs7IY8o6CrTtoHiABVT7Oh7
         5k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K9babPsFcnumEDYtCW1wk3t+0xqIDE9L5NSAHtLCBbs=;
        b=j4NegewR7vC3hYa7P9dEyWqHE/iC77PGqekUyRX+5MaoP9iLd7qpJGa1TEPh+QHTSy
         83Ugf7238e+k8mrk45KCdy3bG4QnEgRPLHs1tyfG1hYS8VJCkzzgcXNpYHRpRzSi/YTu
         p7FTd/hm8AxzJeduvASY/UsTcLLPoBPKpNd7hbLLzXQ9rerTQQqy7Me5AbQi9+hwDgMV
         +lfDDbxaARiQo1F2RZoeUTxjvDU94ZB4FSnZnuyCC1sSdMTpcG+pmQqLu/GQQ2bfQUtH
         jm7eecoX4BO5XoENcpqKyHngsVb2bcsUpNfC0CGSpQRQC7HkrNxtV/vzab8b3QLNCOyg
         Y4+A==
X-Gm-Message-State: ALyK8tIC1Pv9oMvlDsGSHEjs4FZK15siIS20CZjOHl6PxLHJKpf/HbLFMQw8q/AOZBHuNg==
X-Received: by 10.194.78.147 with SMTP id b19mr2156262wjx.31.1467051921844;
        Mon, 27 Jun 2016 11:25:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:21 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 23/41] builtin/apply: make create_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:11 +0200
Message-Id: <20160627182429.31550-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_file() should just return what
add_conflicted_stages_file() and add_index_file() are returning
instead of calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index eadff4d..bce3988 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4269,7 +4269,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4280,13 +4280,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway) {
-		if (add_conflicted_stages_file(state, patch))
-			exit(128);
-	} else {
-		if (add_index_file(state, path, mode, buf, size))
-			exit(128);
-	}
+	if (patch->conflicted_threeway)
+		return add_conflicted_stages_file(state, patch);
+	else
+		return add_index_file(state, path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4302,8 +4299,10 @@ static void write_out_one_result(struct apply_state *state,
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1)
-			create_file(state, patch);
+		if (phase == 1) {
+			if (create_file(state, patch))
+				exit(128);
+		}
 		return;
 	}
 	/*
@@ -4314,8 +4313,10 @@ static void write_out_one_result(struct apply_state *state,
 		if (remove_file(state, patch, patch->is_rename))
 			exit(128);
 	}
-	if (phase == 1)
-		create_file(state, patch);
+	if (phase == 1) {
+		if (create_file(state, patch))
+			exit(128);
+	}
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
-- 
2.9.0.172.gfb57a78

