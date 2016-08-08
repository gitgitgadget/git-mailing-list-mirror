Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4926D20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcHHVF1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35815 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbcHHVEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so17866051wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZagN0LN4VxIewAN5lI+2CSOQDWYztwm+6KZIp54Rvlk=;
        b=T2CXj0jCp7qQ2ucSAc23Yry+4DMMgaA8VWVdm2pqB1u//nNPQ/OjepRp01y6YYvmHF
         tOw8g5SUfqQv6SFK8p3ut6egTGg8LrZlIA4uQJE7gTNHI5X45aRsmMPGKMzL1nGVzGY1
         M6lw6N0r6nv9vyS4Rm8eWypczEsA8JapWEzTs7MZNeHwupSiyMAWLG62zDBP3n8yx+By
         h15wtNTnW9wIqTqWdAXxf/d5DLfXdE804JyeNSil98P6fA9tWBh/GE2q7DpYDojV2pWh
         wdcspcCrDubrdtsDOTtvGiFZDEw+xi/MZr8SKMSN1mygQTvtVWk6ctJAj3ktb8woksnW
         QSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZagN0LN4VxIewAN5lI+2CSOQDWYztwm+6KZIp54Rvlk=;
        b=C/MF/Y3vlU3OUfTIyBNkIhefNtzundHScJDrEZLdHBkk4jytow0sNp+WcjckVDc+Rj
         hjEI39SYPdsgBGELUEi5udxijySoUVOGDDHsTsXVsS7Kapg1fsm6hU66IRucNkWw3/CI
         2z1EOuDDwSuJOwiI9XZQ4gR46Rk1vS+NkhWl3ZAtncgmCONdhEPJAhl9D9EbbS3Z1qYZ
         KjVxSzncZLoLZBb802EH4yHBpAz8uqnoV3GUqQlb9T04PB1OIq89FvvtoQpFz3Wj3qF/
         UFBxdTc5VcSIMorqNgAuiqAieWxJ11jezPSe7HnPLkS/EZSsdRIoy3zLLOTQ3DqMXRX0
         dQ1g==
X-Gm-Message-State: AEkoouvwh5LEReqS2X2bdNKGsYrI3co/SaP7MnKcIV/dUFtaOmTOBsehNiNqF8V5cOZKgA==
X-Received: by 10.194.65.170 with SMTP id y10mr24237734wjs.26.1470690253602;
        Mon, 08 Aug 2016 14:04:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:12 -0700 (PDT)
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
Subject: [PATCH v10 16/40] builtin/apply: make gitdiff_*() return 1 at end of header
Date:	Mon,  8 Aug 2016 23:03:13 +0200
Message-Id: <20160808210337.5038-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index f99498b..eb918e5 100644
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
2.9.2.614.g4980f51

