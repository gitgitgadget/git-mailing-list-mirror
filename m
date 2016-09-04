Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB43920193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbcIDUT0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35450 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932248AbcIDUTP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so10465980wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BU5T1SeqDUDaf030UFzPi0XdO//uP2Y9REgjH2t6fGY=;
        b=WcaXkiix1bUMtjxDnN4pwSBeS275ocPu3C35hwIP1uOT8Mm3KqU/BSl9L+fLLhR4c6
         wHB0wuHBAuCpRhRilxsqFPIgQDZKVzz/wt6xMJ25gkIbrp2AYWDCegg/RIhggfWtzXhU
         6Tq4AvWvmkWnu5/USVM5+0gHLGkdI/CuMksVZ0FEPDkKrtmLs1TIRuYvSlaqiMzBcnm+
         Fj+Q+qTuSWEEF8+WDgG0YWc3buQbC9woaKnVPHRuL36+Nt3jhjtY+xMdoUGcvtVlyXX4
         jpD/cHmWuczplpMGolzRlf6AvBSjoZ3TcDKTqeMlKYiz8qNQop5KimeRMA0cDKJt/CSG
         1lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BU5T1SeqDUDaf030UFzPi0XdO//uP2Y9REgjH2t6fGY=;
        b=ibbL3EVSx2O+drmr1bP0REfmi+wVb4+Ljd4zjeJgklvvhivTC3f0Yg2PMnYtl4hqoZ
         +jfD9e6SQ8LvRjde02F6ZrtrR8szGhfiGQofEUZD8QydRbKlJKmnUZH9bXTde621PobP
         gS9Rr+LoIx3oxH6mAgkXiW6MOOAZaALYBsjK+R5wvVU2aM1wsKEsHKRaZHc4O6YLWl2R
         G4b29EGx82FG5JRmSFaPoAMwYVIL6RozQVJfuY1X9JNiGrnc6w7/O+a+pSML3K7WscpE
         882XLHYmu8kYvaveTjIl6qgeDI5Bqk3shGVGLmtzHT9NKwuMPw5w4dQwQDa0ehAxtxik
         UtXg==
X-Gm-Message-State: AE9vXwOvgE7qOexTmHfxsHFCH1Pko0r5zkDO0L679hHYFmV3wYp4IS/GHxSQkWW76l1k0A==
X-Received: by 10.28.22.70 with SMTP id 67mr12437512wmw.52.1473020349215;
        Sun, 04 Sep 2016 13:19:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:08 -0700 (PDT)
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
Subject: [PATCH v14 16/41] builtin/apply: make gitdiff_*() return 1 at end of header
Date:   Sun,  4 Sep 2016 22:18:08 +0200
Message-Id: <20160904201833.21676-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.10.0.41.g9df52c3

