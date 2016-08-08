Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20F32018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbcHHVEY (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33054 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcHHVEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17871887wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtE6hIaA9dGNFgt3Xmu0pcoYOQZdZCXoXxHQ/Itf7Ko=;
        b=Arw7a/lBvK9fQpmSj769xwX4nTW4hsTpY9wnwcRtWF960hwjWMdfc/2oKxeLYzpNbz
         eclKiD+PV4w2WHB5s9UgQsGrFdSiUemqQCM6tBbBwtwyTPSzA8EhxAC8T0QGzB80Y3rg
         aoVSTFgvbtTlGmCugrgEMe9+Q6GpE8HtXXaatxbTHUMQWQmxte9AND2idwr2BEbYAj+E
         fK/SBCH3L6uUkWkgqym7v3mY3svCkfaU0GH9DZP/nynNHwSIPeQFzG47rEJgBpAPjGeV
         gTaD70hc7IgpMCbrrVJA9harvSHrabp/pIYuplvWE2e8ewheOpitS+yBCm05wehxz9qo
         ASxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtE6hIaA9dGNFgt3Xmu0pcoYOQZdZCXoXxHQ/Itf7Ko=;
        b=O79F/HyfuS5I76dfw0w7plbUpSMLkh8jMIPKUtbfmbchZrOnFXNsopsFw/Xh0lL2w5
         tJEO+jsubotoF+9L+PyGgBPGujeBE0A/KiRA2Ipwlv1hzuX0Mo8zeJKdrleRxf0NFwA8
         KYzSPRlhVmcb/LkBxPjQwM4iKeISZjMLld/nQ4FMEeFKL/YgdlvuAQ4rPqvJsr2qDi0e
         tcSHcUs34ZAKcWBljeS6H4qDlXr61uruUxc8gEApdQw8YSNCznFwCBjruljny3ZZ8eKg
         j4esoGVKF9qSJPAhhbsSevCe1gJ8Q0PzHbnL4Sv4on6B15u+dXNy1xkDLL6RANe/rMDv
         lBew==
X-Gm-Message-State: AEkoousz5GS0QDtlCd+HZWUKg8KPYhSUShqHuY/zqGHROYMV6BWQTGYGPvA+51QKMfSvNw==
X-Received: by 10.194.70.165 with SMTP id n5mr85868222wju.135.1470690260086;
        Mon, 08 Aug 2016 14:04:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:19 -0700 (PDT)
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
Subject: [PATCH v10 21/40] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:18 +0200
Message-Id: <20160808210337.5038-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 27fb6e2..ad0b875 100644
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
2.9.2.614.g4980f51

