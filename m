Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEAC20281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969147AbdEXFRn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33583 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965978AbdEXFQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id h4so31066224oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K8mNlJ/YJIUBchKdYfG83Xk0QH/7EOSX5NgeKafMlco=;
        b=iOZeBX+4s46+4Jm7BkGQBykvC5z1nl/XXk+zpXisuWpwAtmylBzNRIKOmmmb+dqqz2
         iQTaCmuFMpBrJaprWQybY1oaI06aRt8qvVWw0dv7U8pinSAKe3Tcg1t1eq03JjaM8dK2
         cQTdmEuX4NHhftSIdfaxq4697u0d5qHD/xAr67OalB1xIsPH3V1v/uGtKPg0BdhIoh/a
         k7viheFgT+Xc/4drn5l59kppH+gA+Yecmj9xeGP5aIlhrLASitaBTyQLXGZ18kIg72xO
         t78tnkb+dlK8gGFjYKWJ+loplGjbYpo9aV41UKV3rTwt6TS2wAWqAA2NlmwnkNldCgOP
         Seow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K8mNlJ/YJIUBchKdYfG83Xk0QH/7EOSX5NgeKafMlco=;
        b=TFrvQylEdvQeHuPTOYgppLlBRzEECwa9QKz/7JjK6slVwoTWsIcANtRzAcQ4Z/t/F0
         TnCIr6TDXiDEIPcMvVYnbmktIWnaijp4neyNv2TiTFhOJKlQitjN5lnmI3JBKXpghdPA
         fOXzWsPnpvOk2jlCVAyAq9QaRh6/Ti0p/hRfxSI/IBporlv5wVw7mLgVDOKUO+MmcO3h
         4Yh5q/KnQ9zV5njKu8WXPBkiMh9CDKVx2y2tjuA/BcMFA+TpgiCuuqCEGTZHCL04xIau
         ClK6bUKwh9U1QiliF46tw2R2N353XLAu/rhJflmX1Akp8Y7Qnd21BUdiVSbvY/XcX4HC
         T2Jw==
X-Gm-Message-State: AODbwcATY8h5ladMAl86yLXd+yXjKTTtrlrlK0ZWeIHn6uwzMUgXkDMS
        WRH18BCBZ/LbQQ==
X-Received: by 10.157.34.228 with SMTP id y91mr3990800ota.121.1495602986991;
        Tue, 23 May 2017 22:16:26 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:25 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 08/29] blame: rename ent_score function
Date:   Wed, 24 May 2017 00:15:16 -0500
Message-Id: <20170524051537.29978-9-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions that will be publicly exposed should have names that better
reflect what they are a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7c493d2..129ef28 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -959,7 +959,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
  *
  * Compute how trivial the lines in the blame_entry are.
  */
-static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
+static unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e)
 {
 	unsigned score;
 	const char *cp, *ep;
@@ -995,7 +995,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 	if (!this[1].suspect)
 		return;
 	if (best_so_far[1].suspect) {
-		if (ent_score(sb, &this[1]) < ent_score(sb, &best_so_far[1]))
+		if (blame_entry_score(sb, &this[1]) < blame_entry_score(sb, &best_so_far[1]))
 			return;
 	}
 
@@ -1107,7 +1107,7 @@ static struct blame_entry **filter_small(struct blame_scoreboard *sb,
 	struct blame_entry *p = *source;
 	struct blame_entry *oldsmall = *small;
 	while (p) {
-		if (ent_score(sb, p) <= score_min) {
+		if (blame_entry_score(sb, p) <= score_min) {
 			*small = p;
 			small = &p->next;
 			p = *small;
@@ -1156,7 +1156,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 			next = e->next;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
-			    blame_move_score < ent_score(sb, &split[1])) {
+			    blame_move_score < blame_entry_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split, e);
 			} else {
 				e->next = leftover;
@@ -1286,7 +1286,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < ent_score(sb, &split[1])) {
+			    blame_copy_score < blame_entry_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split,
 					    blame_list[j].ent);
 			} else {
@@ -2104,8 +2104,8 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		num = e->lno + e->num_lines;
 		if (longest_dst_lines < num)
 			longest_dst_lines = num;
-		if (largest_score < ent_score(sb, e))
-			largest_score = ent_score(sb, e);
+		if (largest_score < blame_entry_score(sb, e))
+			largest_score = blame_entry_score(sb, e);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
-- 
2.9.3

