Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4372018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbcF0SZ3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35456 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF0SZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so26929666wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/cC0dEaXy/DE7oZXvtdDtuJ/iiitPoATAFcWcsL1uM=;
        b=MoBOj+OGYR95dDivG21r8HOt98ttXxMhnu5vE3NrzezGw/uehDXdrw8vr8CVDeoTuB
         nh1C4BqGs+ngcbX2m+OmpcnIkAd11sSGHDoPbSMAM9Sbjjv99VmZx0StCin/0o59iF6Q
         CuQsmy1t7fUVhnJDcRdBgSqvdxEjChOzLGd7Z5uefqotUJk9HTO1RY3kqq2c49cMDu7r
         Ho/sLYCQp3m3M+9eAi3GDX1tvuRt6PtMrsQZ1Z/rVkWWbKfVmSDmjK3s4ZKYn6SNJoyV
         m0V3fKDux0T2ud88AGSeZn4RwZ/sEt3v/6fGDCYNY3oTE3M4FOWwbB8nKuwshcxkfQau
         PD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/cC0dEaXy/DE7oZXvtdDtuJ/iiitPoATAFcWcsL1uM=;
        b=R9gHhnTbcYOTgTIPlVcqpR13mktijWesNSp9Lp1Ls3gC3gG6XgzCuzJqPvq70tQIyO
         zEgujnLdOTNurZ8qydckg6KpVP536Ux+zQo/g/X0DyjtJ5RNv4bVHCCr7V6apUmJidw5
         w+Zae+qMHu+oO7FCNZPhN24MAPSM+Mt1f+/RR8ZcsATbMEM1gW+3wrbTEffDFGqURQp6
         9EH/uxnSI4lud4lQKOE19kkKXaUoU4IozNjRs4QX0K8FczgurGcIHczWkORfgR797Y+B
         DUnpGuPCabDMBYASMPdis+2Kexkq6m9KF4qLw5kuuGRaYPioJAmBic67dM3umg84Yj+k
         37bg==
X-Gm-Message-State: ALyK8tK9Qxf4R2uFdxdBQqa3JdCcyxkAu5Pg3lIL6szJtTXjcWTUQg/Ni+twLj9G8WJAoA==
X-Received: by 10.194.97.201 with SMTP id ec9mr2083991wjb.117.1467051912216;
        Mon, 27 Jun 2016 11:25:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:11 -0700 (PDT)
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
Subject: [PATCH v8 16/41] builtin/apply: make gitdiff_*() return 1 at end of header
Date:	Mon, 27 Jun 2016 20:24:04 +0200
Message-Id: <20160627182429.31550-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The gitdiff_*() functions that are called as p->fn() in parse_git_header()
should return 1 instead of -1 in case of end of header or unrecognized
input, as these are not real errors. It just instructs the parser to break
out.

This makes it possible for gitdiff_*() functions to return -1 in case of a
real error. This will be done in a following patch.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 174dbf3..0bed352 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -812,7 +812,7 @@ static int gitdiff_hdrend(struct apply_state *state,
 			  const char *line,
 			  struct patch *patch)
 {
-	return -1;
+	return 1;
 }
 
 /*
@@ -1016,7 +1016,7 @@ static int gitdiff_unrecognized(struct apply_state *state,
 				const char *line,
 				struct patch *patch)
 {
-	return -1;
+	return 1;
 }
 
 /*
@@ -1248,9 +1248,13 @@ static int parse_git_header(struct apply_state *state,
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
 			int oplen = strlen(p->str);
+			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(state, line + oplen, patch) < 0)
+			res = p->fn(state, line + oplen, patch);
+			if (res < 0)
+				return -1;
+			if (res > 0)
 				return offset;
 			break;
 		}
@@ -1430,6 +1434,8 @@ static int find_header(struct apply_state *state,
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
 			int git_hdr_len = parse_git_header(state, line, len, size, patch);
+			if (git_hdr_len < 0)
+				return -128;
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
-- 
2.9.0.172.gfb57a78

