Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3957A2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcF0S0F (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36209 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcF0S0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:26:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id c82so26942172wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BcntlTPr7texX4XNv/w6Cp1aTe2f6WLKTOAjdx6WeY=;
        b=wL9AHaml0pAYVrZykwMOGCqJKGgrCZWocJGLgS75Oei+x1lSoo13qEW5e5rzEKDPSr
         tMg1hCqQgulpCWiHyVR0UbvoDcYfFXVXPGw07CbNaZLvKlG2WHatYxuPksoTr3ncPcvj
         e/lOvvgK6oLvROs9WElbyJuTZOZANA44nWIBY9R+rd0w3T2ix2OR9BIrV+G8haZdLhvJ
         gmzPNTS01mNk1jiNul79/59xnRkHnyfZLR4c0tS+pk0dwLQU9zGxgt6ec4zMykaKdlwh
         gO6STmaY7ZYdV3UbqxUBypuQ3gL11Hi0S+xOYYKxtjowr9rC4quL4/hFcyKEovh2XEdr
         msZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BcntlTPr7texX4XNv/w6Cp1aTe2f6WLKTOAjdx6WeY=;
        b=CgHN1Kce+ZkC4mJ1mSBcdMaDC/HHjhZcqHfKaUJOQaodJ67lTV5NIeukgSbGpMh8G6
         AggFQ0vYHZYF0+hqDIsH2ShhnmTDTXcRB/pGZDD3HGXtn0/SIttPSo02O0ToCDQs0k2b
         RMbOTlxYjXN0ESooUOpw9IXt4OqZNcumlSNlrHChIXLvQ7NZcqbYTPbLVUimRwQKOWcO
         KMB48C8QN9YyJqKhYY22eVfL/XGZnDG0mY/NQuNpgsg2Vkqf9VPoc9VINOiRdXs73ftS
         Qloe99QjkWnqtOyYudvHRkJi6+q4kJzd/lPh7zqcf4iMYku5MX5k814Wul3aXb4HvvXA
         X2BA==
X-Gm-Message-State: ALyK8tKiPhgH13VMm+to0y/+E5xaUX1LHLmZaICjMIaoeZespmPOK5OHDp1KBpIku4RJTQ==
X-Received: by 10.28.68.67 with SMTP id r64mr11464411wma.57.1467051945854;
        Mon, 27 Jun 2016 11:25:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:44 -0700 (PDT)
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
Subject: [PATCH v8 34/41] apply: add 'be_silent' variable to 'struct apply_state'
Date:	Mon, 27 Jun 2016 20:24:22 +0200
Message-Id: <20160627182429.31550-35-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This variable should prevent anything to be printed on both stderr
and stdout.

Let's not take care of stdout and apply_verbosely for now though,
as that will be taken care of in following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 43 +++++++++++++++++++++++++++++--------------
 apply.h |  1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/apply.c b/apply.c
index 7bf12a7..802fa79 100644
--- a/apply.c
+++ b/apply.c
@@ -1617,8 +1617,9 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	err = whitespace_error_string(result);
-	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		state->patch_input_file, linenr, err, len, line);
+	if (!state->be_silent)
+		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+			state->patch_input_file, linenr, err, len, line);
 	free(err);
 }
 
@@ -1813,7 +1814,7 @@ static int parse_single_patch(struct apply_state *state,
 		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
 		return error(_("deleted file %s still has contents"), patch->old_name);
-	if (!patch->is_delete && !newlines && context)
+	if (!patch->is_delete && !newlines && context && !state->be_silent)
 		fprintf_ln(stderr,
 			   _("** warning: "
 			     "file %s becomes empty but is not deleted"),
@@ -3038,8 +3039,8 @@ static int apply_one_fragment(struct apply_state *state,
 		 * Warn if it was necessary to reduce the number
 		 * of context lines.
 		 */
-		if ((leading != frag->leading) ||
-		    (trailing != frag->trailing))
+		if ((leading != frag->leading ||
+		     trailing != frag->trailing) && !state->be_silent)
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
@@ -3536,7 +3537,8 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
-	fprintf(stderr, "Falling back to three-way merge...\n");
+	if (!state->be_silent)
+		fprintf(stderr, "Falling back to three-way merge...\n");
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3566,7 +3568,9 @@ static int try_threeway(struct apply_state *state,
 	status = three_way_merge(image, patch->new_name,
 				 pre_sha1, our_sha1, post_sha1);
 	if (status < 0) {
-		fprintf(stderr, "Failed to fall back on three-way merge...\n");
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Failed to fall back on three-way merge...\n");
 		return status;
 	}
 
@@ -3578,9 +3582,15 @@ static int try_threeway(struct apply_state *state,
 			hashcpy(patch->threeway_stage[0].hash, pre_sha1);
 		hashcpy(patch->threeway_stage[1].hash, our_sha1);
 		hashcpy(patch->threeway_stage[2].hash, post_sha1);
-		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' with conflicts.\n",
+				patch->new_name);
 	} else {
-		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' cleanly.\n",
+				patch->new_name);
 	}
 	return 0;
 }
@@ -4483,7 +4493,8 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 			    "Applying patch %%s with %d rejects...",
 			    cnt),
 		    cnt);
-	say_patch_name(stderr, sb.buf, patch);
+	if (!state->be_silent)
+		say_patch_name(stderr, sb.buf, patch);
 	strbuf_release(&sb);
 
 	cnt = strlen(patch->new_name);
@@ -4510,10 +4521,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	     frag;
 	     cnt++, frag = frag->next) {
 		if (!frag->rejected) {
-			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
+			if (!state->be_silent)
+				fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
 			continue;
 		}
-		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
+		if (!state->be_silent)
+			fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
 		fprintf(rej, "%.*s", frag->size, frag->patch);
 		if (frag->patch[frag->size-1] != '\n')
 			fputc('\n', rej);
@@ -4562,8 +4575,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		struct string_list_item *item;
 
 		string_list_sort(&cpath);
-		for_each_string_list_item(item, &cpath)
-			fprintf(stderr, "U %s\n", item->string);
+		if (!state->be_silent) {
+			for_each_string_list_item(item, &cpath)
+				fprintf(stderr, "U %s\n", item->string);
+		}
 		string_list_clear(&cpath, 0);
 
 		rerere(0);
diff --git a/apply.h b/apply.h
index df44b51..44bed19 100644
--- a/apply.h
+++ b/apply.h
@@ -52,6 +52,7 @@ struct apply_state {
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
+	int be_silent;
 	int no_add;
 	int threeway;
 	int unidiff_zero;
-- 
2.9.0.172.gfb57a78

