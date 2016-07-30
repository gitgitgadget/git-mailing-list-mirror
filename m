Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8819C1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbcG3R1L (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34235 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20052503wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jp9/cZa+c6oXHAUF/uNZli4hzOErHGjhWI+yXy6JF2Y=;
        b=EwwYwSiqe2nH1miCgowP/vG7B5lZAxE41PTKYk2Jqa2gNQYeKPCLyEcjFnL9PCCmk+
         wku4bruzPrlOOO/8LKXwjcHOrzMuD6QEmRAvRbSgio9IAVOwCapZrPtZ4WtAI2SO+Uoy
         hG4S3Fb4SfAkZUAnbpt+8/VXWGibdk8UBQ3LuZMF+ezy0abWMGnLdnKrjJM1Wl3ytKQv
         4U+JWvGiTebWNjRCON3swSDHvuxh5eBGuYZ94nPphHFabU5Bei7utRZ9svw98H/8R/13
         EeopLSRO+8pcB0GFR2s7ii1qICSNr+Unj2ZBA3prWS+BXZHSH3AoNutcSh2RDLOjRD7o
         dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jp9/cZa+c6oXHAUF/uNZli4hzOErHGjhWI+yXy6JF2Y=;
        b=lg0o2x41IKs6REB2tDdT5Fa/iyXezplVGIeKtKct9Dji9cxxZWqc1NgOZzJwnZVgFM
         AWpaZF8nVxbhGppyKZEXWPVPFRNAcmo5/92NIQP+19x57oIrroXxGdplAuVskjhT7x3B
         uDkgHLDhZeDGb5xy+ozpNsaMXRiDUKsDVUinYRw3MRcL1wRDmio+kBuVESgf69R0M4q9
         IYkkl6yQ9u5FgF7G2mvc1bzmum2BCZ4staFbCBZf3XQT2wnYRqNJtX44NI1EdVDdUzZa
         6r1G4Ppdxdcw/udx7VoIhxHrISqvV7N/vTyI3RT4qMEu5t091o79slOKSdS0JIsWwD39
         vjOw==
X-Gm-Message-State: AEkoout7rZJDN4zIgmN4ls3DLrdW+UwdKY28ochHhR8bBhGg3qqD1IpGYCI9GSdlenr7zg==
X-Received: by 10.194.63.39 with SMTP id d7mr43451307wjs.13.1469899559601;
        Sat, 30 Jul 2016 10:25:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:58 -0700 (PDT)
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
Subject: [PATCH v9 21/41] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:49 +0200
Message-Id: <20160730172509.22939-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6ffd4c0..1f405b4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4224,7 +4224,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4232,7 +4232,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4247,9 +4247,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4263,9 +4268,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(128);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.9.2.558.gf53e569

