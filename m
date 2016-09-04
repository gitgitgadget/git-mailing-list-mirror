Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AF91F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbcIDUTc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36224 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbcIDUTO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id l65so2666240wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CAtV096UZjhIpjRm76fEc3l6RY6/lTt6IhChYXWyZE=;
        b=GoQNSSOgznHhjVArcMJns8X8lfGARlwWKIqMBuxav0KIwJMq9+DOW8phB9/CQgctPd
         bjhVWC9wC7MOu4HulhrburOwpQSwH6ds9M8WMz9dntKHXRH676sFdiQk+tCpO/fX/YkJ
         A57TKsWvrDOxGg4q+dWf68bt3/x9vmzvWvSGDzr/3eKwkuCXKNfLN7kIq7pLrUSBOhCe
         qZ75Gwv8KBhUUMRDqx1mlj8kJQo6sRWLdioH527JWYZopngHlzJtZ3Nnh9K8/dQFffiI
         UacljmF6XIHRP9zFF/kp5NN3XTc77GDG0ehoRmT1vc5pXwoAo5fvFfBN6/NnQP6O5n0O
         Ks7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CAtV096UZjhIpjRm76fEc3l6RY6/lTt6IhChYXWyZE=;
        b=XswSWWm4QhgKfHIm1P81pmBTq8AdQ7PRmZd/3ctesf7I65D2GyYZKY+yTNHf1aN8Ox
         S/y7TEN85Fy5NjEHy55Q6SeQq2ZEPdumza99PdiV/aDLBDi3HugTT3fCwONWPewJasyW
         m2bzHKkojrDi9CGALKiL2eca+Vfsj18XDSzJ81NAyeDcChCEjWl1Gej1fQHxvLdgjZqW
         AT5XA+guYkhHEya+F1R8WS87BGKfm+zJNE/Vq6F418nfzfq+Xyy2vmhKeHlL3LJin1XP
         XfAA0OIuLxz+X1ejfoZRp7nyu9xkjYyKkxtiNszn2d4WQsm5sKF49kyOvuKAKyFN9yww
         Ib8g==
X-Gm-Message-State: AE9vXwN+2e9U1jEWW/ZWheisdqOIZekjcCuVy0muJlgNNZJ/NcPQo8Wbqr9wMDhvZ8clrA==
X-Received: by 10.28.152.21 with SMTP id a21mr6041603wme.66.1473020352688;
        Sun, 04 Sep 2016 13:19:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:12 -0700 (PDT)
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
Subject: [PATCH v14 18/41] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date:   Sun,  4 Sep 2016 22:18:10 +0200
Message-Id: <20160904201833.21676-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 6b16173..166e94d 100644
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
2.10.0.41.g9df52c3

