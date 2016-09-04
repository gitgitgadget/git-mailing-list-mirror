Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4EC20193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbcIDUTe (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35508 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbcIDUTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so10466470wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjSCVYdYG25bNFsUY1jn9F4YskXAMwfp/PbduOvU30I=;
        b=LKFQSDxAzanDDlcmhak2jKr8dJ3M/P7QeN9Og4cT2ALMluD03UVhLfrj4gmiA9MYPk
         sGeZcpfjkek6o2fkfBVbDX1sPyiEqHlIFZfR2PPc+/hehWLxbzj3zEPMMm4HNyQ3La6M
         mj4Cp/gIBcmTHA0zTZV2T1CAPWHz5P42yKaVq8vyZ2oVZbinM4Rns1r4NpQbmPPUWraQ
         u47yqSK5FcLtC6e4EHcGYVI+RIxakMsd7pASJbSiXbecJvhcKtM2QE4qU01U8DxQLY6R
         DZ6O2wCrsy3V0DsdK16iTZNdirlbMlP+nFitxynfTHWDcO7QR6LA45x9gxzG6MIuu1lX
         Hl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjSCVYdYG25bNFsUY1jn9F4YskXAMwfp/PbduOvU30I=;
        b=B2HSFexHV+NfHGLGzNdnE3ojQv5txdKfM1mq/a2dhhUmivm/oYbXT3DnxyZWRNCVDB
         01M12h1wJ+39AeKmzeIQ/Zv9BtnOccagLtYHm/1zCr3xEtiSqTBiZGYhc9zR8hTcsUfR
         BDeRm3D2oV8LrHVLft679Nw2pk1n+nWzbXwcxbxm/wmOEWFli1rR4ZBjinkoJL4xNKpw
         oh2Z/umu4Lq0CVYxMVPagJovzXEaLE7fk94N0qlzVaqJdbmK9vkF0QgsYJnA9tX8JWh/
         jB6H53i55Kic8vhpXY3hZdEvQ5m8M6XPAycH3y7NYKWscuulBAM5OjfvTLrouDyUNccO
         GmdA==
X-Gm-Message-State: AE9vXwPnJDmyOjjUp8wNZOMFgOABLUxTcIBzDwssv025XfnHMiK06VtaZd5p9NWwFOlZyA==
X-Received: by 10.28.8.19 with SMTP id 19mr11658682wmi.81.1473020361827;
        Sun, 04 Sep 2016 13:19:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 24/41] builtin/apply: make write_out_one_result() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:16 +0200
Message-Id: <20160904201833.21676-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", write_out_one_result() should just return what
remove_file() and create_file() are returning instead of calling
exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fdfeab0..003acec 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4287,36 +4287,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
 }
 
 /* phase zero is to remove, phase one is to create */
-static void write_out_one_result(struct apply_state *state,
-				 struct patch *patch,
-				 int phase)
+static int write_out_one_result(struct apply_state *state,
+				struct patch *patch,
+				int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0) {
-			if (remove_file(state, patch, 1))
-				exit(128);
-		}
-		return;
+		if (phase == 0)
+			return remove_file(state, patch, 1);
+		return 0;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1) {
-			if (create_file(state, patch))
-				exit(128);
-		}
-		return;
+		if (phase == 1)
+			return create_file(state, patch);
+		return 0;
 	}
 	/*
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0) {
-		if (remove_file(state, patch, patch->is_rename))
-			exit(128);
-	}
-	if (phase == 1) {
-		if (create_file(state, patch))
-			exit(128);
-	}
+	if (phase == 0)
+		return remove_file(state, patch, patch->is_rename);
+	if (phase == 1)
+		return create_file(state, patch);
+	return 0;
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
@@ -4403,7 +4396,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(state, l, phase);
+				if (write_out_one_result(state, l, phase))
+					exit(128);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
-- 
2.10.0.41.g9df52c3

