Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF271F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbcG3R05 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:26:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36765 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so20018318wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDBehkgZytnHdVLSWzQZpoEckWHNkKTrHS1sL+QCoZo=;
        b=dLc59TX6uLhX/wFYRYJIb9g+sNMw1vI294YMmQkj0jozgRHzcZUc11HC1j+9jfVsgH
         98jtdjvhulUImqH+LLOtuuk7sxA1gztq6I2N9F3139wLkIf/uU0eX0uGIun9SKgmBzCd
         VOPUfkaakt5CSvOIwaWIY8lQQMANVFGDQs/oZTKMIiMNg3r21dbjaKxgfApG9nwfaXp8
         pjgi4KCnQTKs6bDB6jkwNSGf2dsoIBZ5YyZOcZ2i9zwdOPT2bjUFOoa6WIjBuA8sE6X+
         gB1pLoujtwemBOtnIoJt3mCdUYbthquxsrkkMvFbR5zoGqqp4OSAZ/Gv60FoebTDyXlL
         sa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDBehkgZytnHdVLSWzQZpoEckWHNkKTrHS1sL+QCoZo=;
        b=Tv0Ljdrn9Xo1eNEm1jzqUX+NqHnlYuE2SMFmrVm0F5oCAxDWqxPQqeaftnhom6v0zf
         iVwPtrC5pnOd0wCveIamlVuxA2HedvKmCK4L1+gFNlhV4z/NFsLg5ZDFIp01Zlc42qCC
         l6tqghiV6ZxIy1j2zfw1dp16JQS/5xXSeiOpKoMvhwP6Fm84FQD5iVw/XwCI5f7G3SPZ
         TrQ6lCN8mFTMmdDJWWlg4X1iTM3vaAvf+XB3b0eXji42v/51kDcF5W2HFcDiqgy7ecko
         1P/Jk3E3VFVj2BwQoCRi+kwSKmV0WPCAVBbjrhqq7et/QQc5GuLg8GoR/g08XJu6b/Es
         pmlA==
X-Gm-Message-State: AEkoouulmwRLMASooJ35W1qKnAEgjLa4INmhIMgd7pVj8go3ZagG5qhoySfnfPEg3YZDLA==
X-Received: by 10.194.169.39 with SMTP id ab7mr49278605wjc.0.1469899552916;
        Sat, 30 Jul 2016 10:25:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:52 -0700 (PDT)
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
Subject: [PATCH v9 16/41] builtin/apply: make gitdiff_*() return 1 at end of header
Date:	Sat, 30 Jul 2016 19:24:44 +0200
Message-Id: <20160730172509.22939-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 0148c2e..877610c 100644
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
2.9.2.558.gf53e569

