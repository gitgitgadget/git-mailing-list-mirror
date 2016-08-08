Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2093320193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbcHHVEa (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36235 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbcHHVEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so317909wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLQZSBuiuzq38xG4S2jjWxH8yudvu4nfZgy1VOJE7U4=;
        b=kX7Xr/daz3cx0Zirdss89Vkcb7qxo/02SCGVpVAUOu2oRz+2YXkAkaiBthn4/HS2/P
         O2PkMQrM4TGTJQ+ab5Z8jpSCVa3a64w/vChtm7mmvfFntL9FiWDxc4I9vI2UGAYkpWpr
         FZgFEOzMEP2bFdED2Fq+evOgVpbCL8vpWaIiUFc19ZVYwyrKy7wjK+RycJDhorh8nuSx
         utScczsza0YU4o6huP5F3hfi2qn2iUiqJJEHxHCjn+beSv0QDzmdSULNhbl20pefEozK
         e+UmMw1lNO0vzGFmF7uK+DNZmGYv8zuMpKw2QBluaLViN67HxlwSc4Ib35ko7YhRwtPo
         vqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LLQZSBuiuzq38xG4S2jjWxH8yudvu4nfZgy1VOJE7U4=;
        b=GsA/9Ep69I54dXb2x+YZnd/prWDraQpbCm1iHTJDxgGzdjnt1QYp/uJEz4KD9uA6P1
         Q1m2A62q2ATkvgvxoDq323cGM9hGN2fVE/jwELvalYvbWcgaMgZsDkNiZ+oOAXu4r27Y
         msrknGcDFfxVnffQDlFCv35pK+YVlf8MUtsmGgGAeGCekmXSjL2hcynwkOEHbahwqpiR
         lgWdA1C+wRfoqB+t/7xHF/Vz7fb0Jjg++r3jk0Gs/uGulvAAI2olz9LqZYaDI8LPDjhh
         VtF6Cuwr7vvBMMO3w2lzPkiteLmHCO81+ZQkuhwGpsgz1HbxM88210zVSo7/WL7QdLcS
         mUEg==
X-Gm-Message-State: AEkoouukjmTLAe4izYVh8cWB5hfLiLzM3osV7eWeuiNzAZXRk4fAxP59HbxGQ5cFjQ/lnA==
X-Received: by 10.28.227.11 with SMTP id a11mr18500853wmh.29.1470690263992;
        Mon, 08 Aug 2016 14:04:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:21 -0700 (PDT)
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
Subject: [PATCH v10 23/40] builtin/apply: make create_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:20 +0200
Message-Id: <20160808210337.5038-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index a646900..fdfeab0 100644
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
2.9.2.614.g4980f51

