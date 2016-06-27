Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654292018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbcF0S0b (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34157 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbcF0SZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so26963358wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOAhdEer0YfoT/kBJwIaUDjmFloSURrcMY9ceN5DNHM=;
        b=Xc0oNfvz80LSuf0AHMhY6HGnHSy/Nx1yA8uWyTv1+VAoHRSJbf34TQUEH/fcIWzGn2
         OPpy2VE16eHIpJKBip8GCuHP5K1GRpFP3Xo0ihRPk5mFQsI7BZ8yVtR2HK79FAbtd1Q9
         fitgO3Y8FLCskTVRAVocQQa8W+3LE6MUokiGwCjaMIKlUf/Y2eIkuRwC6eEWhRgZwEMG
         7Bm2hBNOvoJnbx3gSNK7xoErgvFKzAOXZAuLW4uIbRoFSj5fsPUeyIg+nskVeMdWWQ8v
         2/Nn4ykZJfgA7gnn5ZoEKGjb25D19OqxSGejxXh9EBk2WaNmrk+GsxvfA+WegOGTshUL
         HPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOAhdEer0YfoT/kBJwIaUDjmFloSURrcMY9ceN5DNHM=;
        b=kK7RPaKQ78d/nVkRhQi9GvZkHUYKjsNlyk9YdnJDn15Ql86pIVN93Slw8TScCF91Jh
         /qNn+c+lY41UbfsTmWko/jBNmNsAsJ3NPkQgVl/dlBOVWWCI5Bj4WmdCVB7Kq9n2/ZY2
         2JGz/yshQdd36tMd9NwpvsOvaNsjUVIpFlbCl94uoPfAgGKFw6ixHsQ9yXgvNN+1MJsE
         8oNUKM1+vJfoNNdXUc5jono2OfsRK7JzPwBo5N0NARxukAIPTKFbOE23aEXSsYyVmxgf
         mOHGb+AgEy14TYmTLShpyECvCkCn0HETT+tT1lHFz4nLVm0TtcIY6YxyrsBUScxi23Rg
         82pw==
X-Gm-Message-State: ALyK8tKG1Ow3Z7a52Zsw5gfcZJRJm4/PwQVN4oP2tDEu2d/USX1h/CFYESvhjhM+5Ef2oQ==
X-Received: by 10.28.189.215 with SMTP id n206mr12308012wmf.76.1467051924473;
        Mon, 27 Jun 2016 11:25:24 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:23 -0700 (PDT)
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
Subject: [PATCH v8 25/41] builtin/apply: make write_out_results() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:13 +0200
Message-Id: <20160627182429.31550-26-chriscool@tuxfamily.org>
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
in "builtin/apply.c", write_out_results() should return -1 instead of
calling exit().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6ec87e6..f54b8c5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4383,6 +4383,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	return -1;
 }
 
+/*
+ * Returns:
+ *  -1 if an error happened
+ *   0 if the patch applied cleanly
+ *   1 if the patch did not apply cleanly
+ */
 static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
@@ -4396,8 +4402,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				if (write_out_one_result(state, l, phase))
-					exit(128);
+				if (write_out_one_result(state, l, phase)) {
+					string_list_clear(&cpath, 0);
+					return -1;
+				}
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4517,10 +4525,17 @@ static int apply_patch(struct apply_state *state,
 		}
 	}
 
-	if (state->apply && write_out_results(state, list)) {
-		/* with --3way, we still need to write the index out */
-		res = state->apply_with_reject ? -1 : 1;
-		goto end;
+	if (state->apply) {
+		int write_res = write_out_results(state, list);
+		if (write_res < 0) {
+			res = -128;
+			goto end;
+		}
+		if (write_res > 0) {
+			/* with --3way, we still need to write the index out */
+			res = state->apply_with_reject ? -1 : 1;
+			goto end;
+		}
 	}
 
 	if (state->fake_ancestor &&
-- 
2.9.0.172.gfb57a78

