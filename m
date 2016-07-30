Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737D91F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbcG3R06 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:26:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34218 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so20052362wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0yZX0dI0KypSPuJ7TYpVDXIJvI0GaFx/3klcxDdoK4=;
        b=hMy3DRK5Z9pf6FSXdBXm2yrEYjq4V1BSKtmCAUjgEXG/LafSar7uMqlVsEH1hRGpqe
         Z551rO9xR2FhwT5f+wxbPWLP7y5JXaXOe1N1c3MumxRix4Pwn+thbyjIs7tnxLLZqaaw
         bHdB4w0pJG6w2TdCT54m7S2vL3mvgwfcV0Z7XaKByYCROu3N76SONZbuUAYldQ0Kqj2U
         FODZEPQGSJsVTM7BzYwW/U+C8IkgTp9XIaokJiVSP1Ir7XKtq+1foUQ81y2LrPX8l5TP
         RBg11jhRSn1T8lpEjZEASzhCfrxTxPNYWfJmIEFkWy1LYwqZeYIXHWzZZ4p23WEt5Mvw
         zeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0yZX0dI0KypSPuJ7TYpVDXIJvI0GaFx/3klcxDdoK4=;
        b=GPKr7eRWLRLrKHjSO6PvcrDYLGJZU1Sk9/8qrcpG66UVoHjEh9iQE7hZLEvzZre1Kv
         zMn2hhH3PLoGgKBWzYU5Ru42x4y2RDGgxTulioiNKsvbrdBIPBNGfYaW+/sL1CqenDYY
         Y3gHOyoeRPg6ozcXar7L3fddGwmdGPJp7RLiPDFQmnfb/a2yVRyc0pDcU44ZB5mviN8Q
         aezZRLWWmMCvCR5okCc0vuujsOLOjNEKo2jNgCKhCyxHq9tVb/cC9oXmf9Pca1WviwHH
         gQdLJbJII/kRLOSEc+yov/dnslI5N7CGPcL1qNhXFRYbNh8vMna/VPYACq4aEqFTCj7n
         Li3Q==
X-Gm-Message-State: AEkoouvw4G57mK8o4i6+2pc4Y5fvWmWfq/EMj4Inxqis2aXUWhWhRK+L66gwijX0DU1afw==
X-Received: by 10.194.61.205 with SMTP id s13mr42674630wjr.86.1469899555541;
        Sat, 30 Jul 2016 10:25:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:54 -0700 (PDT)
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
Subject: [PATCH v9 18/41] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date:	Sat, 30 Jul 2016 19:24:46 +0200
Message-Id: <20160730172509.22939-19-chriscool@tuxfamily.org>
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
in "builtin/apply.c", die_on_unsafe_path() should return a negative
integer instead of calling die(), so while doing that let's change
its name to check_unsafe_path().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6a0818b..55f6e48 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3704,7 +3704,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3716,9 +3716,10 @@ static void die_on_unsafe_path(struct patch *patch)
 		new_name = patch->new_name;
 
 	if (old_name && !verify_path(old_name))
-		die(_("invalid path '%s'"), old_name);
+		return error(_("invalid path '%s'"), old_name);
 	if (new_name && !verify_path(new_name))
-		die(_("invalid path '%s'"), new_name);
+		return error(_("invalid path '%s'"), new_name);
+	return 0;
 }
 
 /*
@@ -3808,8 +3809,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -128;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
@@ -3837,10 +3838,14 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
+		int res;
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(state, patch);
+		res = check_patch(state, patch);
+		if (res == -128)
+			return -128;
+		err |= res;
 		patch = patch->next;
 	}
 	return err;
@@ -4472,11 +4477,16 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if ((state->check || state->apply) &&
-	    check_patch_list(state, list) < 0 &&
-	    !state->apply_with_reject) {
-		res = -1;
-		goto end;
+	if (state->check || state->apply) {
+		int r = check_patch_list(state, list);
+		if (r == -128) {
+			res = -128;
+			goto end;
+		}
+		if (r < 0 && !state->apply_with_reject) {
+			res = -1;
+			goto end;
+		}
 	}
 
 	if (state->apply && write_out_results(state, list)) {
-- 
2.9.2.558.gf53e569

