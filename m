Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4351203C1
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbcHKSrE (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33113 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbcHKSq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:46:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so880788wme.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:46:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t6g3xfDcnDlxQ3nbDIoVjUIbn/lvXjmbr5Os1/nkbw=;
        b=IxjyjZOdKWqorMncLKMdWytlrcUZ/7xQAXvImFx4bTyv/7fBnjZ5i0AIWwgZxAgChI
         BwYeZN6kdV6D7EcdHEDytrYEGctBGsUAUNgrgCKISuUAIgwzd5UtNIGmK5uQlyU1rrSI
         88ynPDdzPZPPw4mMZIXOsZ/EKsg/qKPsINUMO5hg/s8KlN+sYA96BQPTTCXv/UwtKIAe
         ob7N/slT+I86+xMNLU7T2FXXLWjZTNMxhxmzRn3mFjZlVn2r+qyVwtXBk5wk94wCrym9
         T6NEs1jyNI9nrDuqwpp2gBiajCtbhgo7juUCtuFOzPRVVSEe4qHhzYMESg8t3LX4NAZ9
         kiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t6g3xfDcnDlxQ3nbDIoVjUIbn/lvXjmbr5Os1/nkbw=;
        b=Xrvb3kKkKw5zfaAHcIlFVcWjJH0HSv8hTChd/2xEJIa1dMY/KTt0lv5fDKtJHdgghX
         7mxnRTlgDB+2HcHZFtCxCZephaKLVsMUvet1kcbS+S16ITtrVxqhnqb4QuxjIZLYd9r5
         Ox/6MbbTsIzXeiKTFNFgcgrMP53btKKkJaOq1edPn/SMAVgj/k1ZLYR6pSasQ27HB+sq
         amaMKHiOZrnhV9cwPEiW7fKGXtfUfO+CUFgR72U4gfOy0lQqCVISqzXODWHqvNO+SJC4
         oVgBQ9MIlo9Jv5iaTuxi+8KR0qcMPIb0a5aIq+KKOr+q2eN0MOnRnvKj1klheABQWLxW
         pcCQ==
X-Gm-Message-State: AEkoouvSwbYKt4Ep264uxsapgasApWwHqX81jgx4e52e2dbt/gIfh2sDgetRHOiUJgYeBQ==
X-Received: by 10.194.16.162 with SMTP id h2mr11549428wjd.52.1470941215393;
        Thu, 11 Aug 2016 11:46:55 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:46:54 -0700 (PDT)
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
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 06/13] apply: make it possible to silently apply
Date:	Thu, 11 Aug 2016 20:44:54 +0200
Message-Id: <20160811184501.384-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This changes 'int apply_verbosely' into 'enum apply_verbosity', and
changes the possible values of the variable from a bool to
a tristate.

The previous 'false' state is changed into 'verbosity_normal'.
The previous 'true' state is changed into 'verbosity_verbose'.

The new added state is 'verbosity_silent'. It should prevent
anything to be printed on both stderr and stdout.

This is needed because `git am` wants to first call apply
functionality silently, if it can then fall back on 3-way merge
in case of error.

Printing on stdout, and calls to warning() or error() are not
taken care of in this patch, as that will be done in following
patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 62 +++++++++++++++++++++++++++++++++++++--------------------
 apply.h         |  8 +++++++-
 builtin/apply.c |  2 +-
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/apply.c b/apply.c
index 41a33d3..df85cbc 100644
--- a/apply.c
+++ b/apply.c
@@ -125,8 +125,11 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
+	if (state->apply_with_reject) {
+		state->apply = 1;
+		if (state->apply_verbosity == verbosity_normal)
+			state->apply_verbosity = verbosity_verbose;
+	}
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
@@ -1620,8 +1623,9 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	err = whitespace_error_string(result);
-	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		state->patch_input_file, linenr, err, len, line);
+	if (state->apply_verbosity > verbosity_silent)
+		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+			state->patch_input_file, linenr, err, len, line);
 	free(err);
 }
 
@@ -1816,7 +1820,7 @@ static int parse_single_patch(struct apply_state *state,
 		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
 		return error(_("deleted file %s still has contents"), patch->old_name);
-	if (!patch->is_delete && !newlines && context)
+	if (!patch->is_delete && !newlines && context && state->apply_verbosity > verbosity_silent)
 		fprintf_ln(stderr,
 			   _("** warning: "
 			     "file %s becomes empty but is not deleted"),
@@ -2911,7 +2915,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* Ignore it, we already handled it */
 			break;
 		default:
-			if (state->apply_verbosely)
+			if (state->apply_verbosity > verbosity_normal)
 				error(_("invalid start of line: '%c'"), first);
 			applied_pos = -1;
 			goto out;
@@ -3026,7 +3030,7 @@ static int apply_one_fragment(struct apply_state *state,
 				state->apply = 0;
 		}
 
-		if (state->apply_verbosely && applied_pos != pos) {
+		if (state->apply_verbosity > verbosity_normal && applied_pos != pos) {
 			int offset = applied_pos - pos;
 			if (state->apply_in_reverse)
 				offset = 0 - offset;
@@ -3041,14 +3045,14 @@ static int apply_one_fragment(struct apply_state *state,
 		 * Warn if it was necessary to reduce the number
 		 * of context lines.
 		 */
-		if ((leading != frag->leading) ||
-		    (trailing != frag->trailing))
+		if ((leading != frag->leading ||
+		     trailing != frag->trailing) && state->apply_verbosity > verbosity_silent)
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
 		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
-		if (state->apply_verbosely)
+		if (state->apply_verbosity > verbosity_normal)
 			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
@@ -3539,7 +3543,8 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
-	fprintf(stderr, "Falling back to three-way merge...\n");
+	if (state->apply_verbosity > verbosity_silent)
+		fprintf(stderr, "Falling back to three-way merge...\n");
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3569,7 +3574,9 @@ static int try_threeway(struct apply_state *state,
 	status = three_way_merge(image, patch->new_name,
 				 pre_sha1, our_sha1, post_sha1);
 	if (status < 0) {
-		fprintf(stderr, "Failed to fall back on three-way merge...\n");
+		if (state->apply_verbosity > verbosity_silent)
+			fprintf(stderr,
+				"Failed to fall back on three-way merge...\n");
 		return status;
 	}
 
@@ -3581,9 +3588,15 @@ static int try_threeway(struct apply_state *state,
 			hashcpy(patch->threeway_stage[0].hash, pre_sha1);
 		hashcpy(patch->threeway_stage[1].hash, our_sha1);
 		hashcpy(patch->threeway_stage[2].hash, post_sha1);
-		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
+		if (state->apply_verbosity > verbosity_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' with conflicts.\n",
+				patch->new_name);
 	} else {
-		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
+		if (state->apply_verbosity > verbosity_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' cleanly.\n",
+				patch->new_name);
 	}
 	return 0;
 }
@@ -3956,7 +3969,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_fn_table(state, patch);
 	while (patch) {
 		int res;
-		if (state->apply_verbosely)
+		if (state->apply_verbosity > verbosity_normal)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
 		res = check_patch(state, patch);
@@ -4472,7 +4485,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	}
 
 	if (!cnt) {
-		if (state->apply_verbosely)
+		if (state->apply_verbosity > verbosity_normal)
 			say_patch_name(stderr,
 				       _("Applied patch %s cleanly."), patch);
 		return 0;
@@ -4489,7 +4502,8 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 			    "Applying patch %%s with %d rejects...",
 			    cnt),
 		    cnt);
-	say_patch_name(stderr, sb.buf, patch);
+	if (state->apply_verbosity > verbosity_silent)
+		say_patch_name(stderr, sb.buf, patch);
 	strbuf_release(&sb);
 
 	cnt = strlen(patch->new_name);
@@ -4516,10 +4530,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	     frag;
 	     cnt++, frag = frag->next) {
 		if (!frag->rejected) {
-			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
+			if (state->apply_verbosity > verbosity_silent)
+				fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
 			continue;
 		}
-		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
+		if (state->apply_verbosity > verbosity_silent)
+			fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
 		fprintf(rej, "%.*s", frag->size, frag->patch);
 		if (frag->patch[frag->size-1] != '\n')
 			fputc('\n', rej);
@@ -4568,8 +4584,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		struct string_list_item *item;
 
 		string_list_sort(&cpath);
-		for_each_string_list_item(item, &cpath)
-			fprintf(stderr, "U %s\n", item->string);
+		if (state->apply_verbosity > verbosity_silent) {
+			for_each_string_list_item(item, &cpath)
+				fprintf(stderr, "U %s\n", item->string);
+		}
 		string_list_clear(&cpath, 0);
 
 		rerere(0);
@@ -4626,7 +4644,7 @@ static int apply_patch(struct apply_state *state,
 			listp = &patch->next;
 		}
 		else {
-			if (state->apply_verbosely)
+			if (state->apply_verbosity > verbosity_normal)
 				say_patch_name(stderr, _("Skipped patch '%s'."), patch);
 			free_patch(patch);
 			skipped_patch++;
diff --git a/apply.h b/apply.h
index df44b51..bd4eb6d 100644
--- a/apply.h
+++ b/apply.h
@@ -13,6 +13,12 @@ enum apply_ws_ignore {
 	ignore_ws_change
 };
 
+enum apply_verbosity {
+	verbosity_silent = -1,
+	verbosity_normal = 0,
+	verbosity_verbose = 1
+};
+
 /*
  * We need to keep track of how symlinks in the preimage are
  * manipulated by the patches.  A patch to add a/b/c where a/b
@@ -51,13 +57,13 @@ struct apply_state {
 	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
-	int apply_verbosely;
 	int no_add;
 	int threeway;
 	int unidiff_zero;
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	enum apply_verbosity apply_verbosity;
 	const char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
diff --git a/builtin/apply.c b/builtin/apply.c
index 9c66474..7338701 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -74,7 +74,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
+		OPT__VERBOSE(&state.apply_verbosity, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.9.2.769.gc0f0333

