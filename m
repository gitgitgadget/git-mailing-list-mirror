Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87783932ED
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425180; cv=none; b=oHrnUhwMfuF4ah0sMvNMc7zZjQPup5yB6kRDJjvGfoyni1pn8DEhAevOBbCcob3F3zdmM5E6IBuzHO3oMbED7sWN6Fa30MbK12ZmboryUGY1I1OOsJoXhTMye+USP+MdLIC4oS5cj6HyzoXgzBHrJZO7CrUa8JR79JM2g0PMmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425180; c=relaxed/simple;
	bh=pH/TnnnnNfSlKlH/1W74Uwn0R3lx9dLjf4XqtVU+FVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/6zQg1xCfoZ+z2WK8BmsleNxKAzaqOCqlQvQ2smOXI4adcGRm51DYl3VApcEOXiWuD59touajfLCKcl1/qnRpKffR4o0plXpr+V1U3PyCWzGYIrzPEG5Oi6IGh7tIWXfq+trli3IpwoAQVfrb/0arq8nufhe8vFUxZYwHJ2nU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP7UyvHk; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP7UyvHk"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56adf76631cso2009456e0c.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425172; x=1775029972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQDrJ/i/3m1iN48b83EEktxsCD7BWh79XFbSTyVDwKw=;
        b=SP7UyvHk879XJS8c/A8kviQcdpapGsB3b14b64cKGWKk0hl3fGNzG5RLT43cj3c4Qu
         6GwLiRSQoPSSoPY6AO7jw6BPTPiJNVO/a+6gNVuvGi3qOeBG7z7Rxrj5YHRv8OpWSNUL
         3PQbKxApd6PKWX2a2u9II0jRs6Vkyfzs0hRkHKwQUiQGseVQf2y+eHolsW001W4vAmX2
         MZdYu3sjW/TR94xKVChgOg483jj9UmRzuJ4tUqbMy/u9x+93GF5gbLITG7hgvsQshb8U
         XV2GERnkl6KfErjUd1cEohcUcNhb6CWhnqULeSyH5jJVXzoXOQrnauufhBx2/YLpkD8m
         I1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425172; x=1775029972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQDrJ/i/3m1iN48b83EEktxsCD7BWh79XFbSTyVDwKw=;
        b=TtWrNXxS9u3KHBnRpa0Hr+z3/YN+s8Y5ZOFt6K0a1JAFV4XXfgZ4IEUj9hMPmZOfGS
         DUhsvfIb48Xu/7PUnhDpNnAuRuuXClLf18c7Bmzi93115WHFiHqJGvPBXICfnGiJFJP+
         0ftXjL4jBgY+MQeS23fqyuc+/ZwR5rOti+xOT3mHJZDzoItoWsAG2DqDRQ2dn8RfqUaQ
         p4oif5qKp9KR1yL5BqksXdhSEieFcGMEkTU+CgVsGDgPi0kH/TVbssT0vx3kwikDrQfu
         U67XPBYKpdAZZ7b/zTq5BvZN/Dqn6DrC7x8kpQ9moKBqryYluRXDWWMoKS2ayzOHPARa
         pBiA==
X-Gm-Message-State: AOJu0Yy6mjqkhbGNn7XzMRofpU0h1luhNsfzmPjGCGUBBEpLzItDrDzM
	gECaEmF4jEGcgESbe9cHX549cGdU6uDAMPDj5OfIUEszf1oqUP8tzccMMWxSnf+C
X-Gm-Gg: ATEYQzzSoDYiBZxM4f7Ff8j9Xtcp2Lz0FUx9bxH8GW7p8YAp9kX4Ea7iEsVfYkw/U1Y
	c0DPk0NbPUUWfMXq4zzulHKGaPLXYgQr3ZNJl7I+DqpdvkMuI1JdPE2n2gRETv1Jc4TJNc8Xd7c
	UCN+IOxCh9iXYsOLeLx/TCvr/lumlb+Pryzusi6zxjHAk8WKgTxtc3MArNhcekdrK9fWxAKh04v
	uPhHKDaeegDcKNy0bAKPVPpE4j6XO/VGaszthOOoWXQJbNgC44WUWxDlVvCfKqCOcChKIIkFpFe
	Bu4D5Lm8CMk9Rl0GgiyBnrE9MgytH6oAWVyw6cUVL0mt1aQxzEZG3vgsRVDe4xRNjrGiQdvG8R/
	+AH57nW2x4ynBARIvo82I29w8t8HC2zX8+AFykpV7wfL/njGpMal5cj2BaIhqSI5kXmufN8bES/
	pJppYwcu1kBV/UWJj6wAZ4vL4WhQxBvUl7+fA4Xk1TrY2+ycqVlbvq/a3iYDc=
X-Received: by 2002:a05:6122:8c13:b0:56c:ce0b:fecd with SMTP id 71dfb90a1353d-56d2208bef0mr1334058e0c.12.1774425171637;
        Wed, 25 Mar 2026 00:52:51 -0700 (PDT)
Received: from SQD-WKS-155.. ([2804:2164:80b5:ca00:1848:ce0c:8de3:8ebb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136b4afc7sm14788357241.1.2026.03.25.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:52:51 -0700 (PDT)
From: Luiz Campos <luizedc1@gmail.com>
To: git@vger.kernel.org
Cc: luizedc1@gmail.com,
	peff@peff.net,
	sagotsky@gmail.com,
	Johannes.Schindelin@gmx.de
Subject: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
Date: Wed, 25 Mar 2026 04:50:55 -0300
Message-ID: <20260325075055.354709-2-luizedc1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325075055.354709-1-luizedc1@gmail.com>
References: <20260325075055.354709-1-luizedc1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using `git add -p`, users can stage or skip hunks,
but cannot discard unwanted changes from the working tree.

Introduce a new 'x' action to discard the current hunk by
reverse-applying it.

This idea was suggested in a previous mailing list discussion:
https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0

Feedback is very welcome.

Signed-off-by: Luiz Campos <luizedc1@gmail.com>
---
 Documentation/git-add.adoc |   7 +-
 add-patch.c                | 137 ++++++++++++++++++++++++++++---------
 t/t3701-add-interactive.sh |  58 ++++++++++------
 3 files changed, 149 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 941135dc63..0ab81e5615 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -351,12 +351,15 @@ patch::
        K - go to the previous hunk, roll over at the top
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       x - discard this hunk from the worktree
        p - print the current hunk
        P - print the current hunk using the pager
        ? - print help
 +
-After deciding the fate for all hunks, if there is any hunk
-that was chosen, the index is updated with the selected hunks.
+After deciding the fate for all hunks, any hunks marked for
+discard are removed from the working tree (reverted to the index
+version for those lines).  Then, if there is any hunk chosen for
+staging, the index is updated with those hunks.
 +
 You can omit having to type return here, by setting the configuration
 variable `interactive.singleKey` to `true`.
diff --git a/add-patch.c b/add-patch.c
index 4e28e5c187..ea38ab453e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -259,7 +259,7 @@ struct hunk_header {
 struct hunk {
 	size_t start, end, colored_start, colored_end, splittable_into;
 	ssize_t delta;
-	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
+	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK, DISCARD_HUNK } use;
 	struct hunk_header header;
 };
 
@@ -884,17 +884,35 @@ static void render_diff_header(struct add_p_state *s,
 	}
 }
 
+static bool should_merge_hunk(struct file_diff *file_diff,
+			      size_t hunk_index, int use_all,
+			      int merge_for_discard)
+{
+	if (use_all)
+		return true;
+	return merge_for_discard
+		? file_diff->hunk[hunk_index].use == DISCARD_HUNK
+		: file_diff->hunk[hunk_index].use == USE_HUNK;
+}
+
+enum reassemble_mode {
+	REASSEMBLE_STAGE,
+	REASSEMBLE_DISCARD
+};
+
 /* Coalesce hunks again that were split */
 static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
-		       size_t *hunk_index, int use_all, struct hunk *merged)
+		       size_t *hunk_index, int use_all, struct hunk *merged,
+		       int merge_for_discard)
 {
 	size_t i = *hunk_index, delta;
 	struct hunk *hunk = file_diff->hunk + i;
 	/* `header` corresponds to the merged hunk */
 	struct hunk_header *header = &merged->header, *next;
 
-	if (!use_all && hunk->use != USE_HUNK)
+	if (!should_merge_hunk(file_diff, *hunk_index, use_all, merge_for_discard)) {
 		return 0;
+	}
 
 	*merged = *hunk;
 	/* We simply skip the colored part (if any) when merging hunks */
@@ -907,10 +925,10 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
 		/*
 		 * Stop merging hunks when:
 		 *
-		 * - the hunk is not selected for use, or
+		 * - the hunk is not selected for use (or discard, when merging discards), or
 		 * - the hunk does not overlap with the already-merged hunk(s)
 		 */
-		if ((!use_all && hunk->use != USE_HUNK) ||
+		if (!should_merge_hunk(file_diff, i + 1, use_all, merge_for_discard) ||
 		    header->new_offset >= next->new_offset + merged->delta ||
 		    header->new_offset + header->new_count
 		    < next->new_offset + merged->delta)
@@ -1014,11 +1032,13 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
 
 static void reassemble_patch(struct add_p_state *s,
 			     struct file_diff *file_diff, int use_all,
+			     enum reassemble_mode mode,
 			     struct strbuf *out)
 {
 	struct hunk *hunk;
 	size_t save_len = s->plain.len, i;
 	ssize_t delta = 0;
+	int merge_for_discard = (mode == REASSEMBLE_DISCARD);
 
 	render_diff_header(s, file_diff, 0, out);
 
@@ -1026,25 +1046,26 @@ static void reassemble_patch(struct add_p_state *s,
 		struct hunk merged = { 0 };
 
 		hunk = file_diff->hunk + i;
-		if (!use_all && hunk->use != USE_HUNK)
+		if (!should_merge_hunk(file_diff, i, use_all, merge_for_discard)) {
 			delta += hunk->header.old_count
 				- hunk->header.new_count;
-		else {
-			/* merge overlapping hunks into a temporary hunk */
-			if (merge_hunks(s, file_diff, &i, use_all, &merged))
-				hunk = &merged;
+			continue;
+		}
 
-			render_hunk(s, hunk, delta, 0, out);
+		if (merge_hunks(s, file_diff, &i, use_all, &merged,
+				merge_for_discard))
+			hunk = &merged;
 
-			/*
-			 * In case `merge_hunks()` used `plain` as a scratch
-			 * pad (this happens when an edited hunk had to be
-			 * coalesced with another hunk).
-			 */
-			strbuf_setlen(&s->plain, save_len);
+		render_hunk(s, hunk, delta, 0, out);
 
-			delta += hunk->delta;
-		}
+		/*
+		 * In case `merge_hunks()` used `plain` as a scratch
+		 * pad (this happens when an edited hunk had to be
+		 * coalesced with another hunk).
+		 */
+		strbuf_setlen(&s->plain, save_len);
+
+		delta += hunk->delta;
 	}
 }
 
@@ -1348,7 +1369,7 @@ static int run_apply_check(struct add_p_state *s,
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	strbuf_reset(&s->buf);
-	reassemble_patch(s, file_diff, 1, &s->buf);
+	reassemble_patch(s, file_diff, 1, REASSEMBLE_STAGE, &s->buf);
 
 	setup_child_process(s, &cp,
 			    "apply", "--check", NULL);
@@ -1522,7 +1543,8 @@ static size_t display_hunks(struct add_p_state *s,
 
 		strbuf_reset(&s->buf);
 		strbuf_addf(&s->buf, "%c%2d: ", hunk->use == USE_HUNK ? '+'
-			    : hunk->use == SKIP_HUNK ? '-' : ' ',
+			    : hunk->use == SKIP_HUNK ? '-'
+			    : hunk->use == DISCARD_HUNK ? 'x' : ' ',
 			    (int)start_index);
 		summarize_hunk(s, hunk, &s->buf);
 		fputs(s->buf.buf, stdout);
@@ -1540,6 +1562,7 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "x - discard this hunk from the worktree\n"
    "p - print the current hunk\n"
    "P - print the current hunk using the pager\n"
    "> - go to the next file, roll over at the bottom\n"
@@ -1547,21 +1570,57 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "? - print help\n"
    "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
 
+static int apply_discard_hunks(struct add_p_state *s,
+			       struct file_diff *file_diff)
+{
+	struct child_process check_cp = CHILD_PROCESS_INIT;
+	struct child_process apply_cp = CHILD_PROCESS_INIT;
+
+	strbuf_reset(&s->buf);
+	reassemble_patch(s, file_diff, 0, REASSEMBLE_DISCARD, &s->buf);
+
+	discard_index(s->index);
+
+	setup_child_process(s, &check_cp, "apply", "-R", "--check", NULL);
+	if (pipe_command(&check_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0)) {
+		error(_("'git apply -R --check' failed"));
+		return -1;
+	}
+
+	setup_child_process(s, &apply_cp, "apply", "-R", NULL);
+	if (pipe_command(&apply_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0)) {
+		error(_("'git apply -R' failed"));
+		return -1;
+	}
+
+	return 0;
+}
+
 static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	size_t j;
+	int needs_refresh = 0;
+
+	if (s->mode == &patch_mode_add) {
+		for (j = 0; j < file_diff->hunk_nr; j++) {
+			if (file_diff->hunk[j].use == DISCARD_HUNK)
+				break;
+		}
+		if (j < file_diff->hunk_nr && apply_discard_hunks(s, file_diff))
+			return;
+		if (j < file_diff->hunk_nr)
+			needs_refresh = 1;
+	}
 
-	/* Any hunk to be used? */
 	for (j = 0; j < file_diff->hunk_nr; j++)
 		if (file_diff->hunk[j].use == USE_HUNK)
 			break;
 
 	if (j < file_diff->hunk_nr ||
-		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
-		/* At least one hunk selected: apply */
+	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
 		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, 0, &s->buf);
+		reassemble_patch(s, file_diff, 0, REASSEMBLE_STAGE, &s->buf);
 
 		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
@@ -1574,13 +1633,15 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 					NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
-		    s->index == s->r->index) {
-			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
-						     1, NULL, NULL, NULL);
-		}
+		needs_refresh = 1;
 	}
 
+	if (needs_refresh &&
+	    read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
+	    s->index == s->r->index) {
+		repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
+					     1, NULL, NULL, NULL);
+	}
 }
 
 static size_t dec_mod(size_t a, size_t m)
@@ -1636,7 +1697,8 @@ static size_t patch_update_file(struct add_p_state *s,
 			ALLOW_SPLIT = 1 << 5,
 			ALLOW_EDIT = 1 << 6,
 			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
-			ALLOW_GOTO_NEXT_FILE = 1 << 8
+			ALLOW_GOTO_NEXT_FILE = 1 << 8,
+			ALLOW_DISCARD = 1 << 9
 		} permitted = 0;
 
 		if (hunk_index >= file_diff->hunk_nr)
@@ -1722,6 +1784,10 @@ static size_t patch_update_file(struct add_p_state *s,
 			    !file_diff->deleted) {
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
+				if (s->mode == &patch_mode_add) {
+					permitted |= ALLOW_DISCARD;
+					strbuf_addstr(&s->buf, ",x");
+				}
 			}
 			if (!s->cfg.auto_advance && s->file_diff_nr > 1) {
 				permitted |= ALLOW_GOTO_NEXT_FILE;
@@ -1750,6 +1816,8 @@ static size_t patch_update_file(struct add_p_state *s,
 		if (hunk->use != UNDECIDED_HUNK) {
 			if (hunk->use == USE_HUNK)
 				hunk_use_decision = _(" (was: y)");
+			else if (hunk->use == DISCARD_HUNK)
+				hunk_use_decision = _(" (was: x)");
 			else
 				hunk_use_decision = _(" (was: n)");
 		}
@@ -1780,6 +1848,13 @@ static size_t patch_update_file(struct add_p_state *s,
 		} else if (ch == 'n') {
 			hunk->use = SKIP_HUNK;
 			goto soft_increment;
+		} else if (ch == 'x') {
+			if (!(permitted & ALLOW_DISCARD))
+				err(s, _("Sorry, cannot discard this hunk"));
+			else {
+				hunk->use = DISCARD_HUNK;
+				goto soft_increment;
+			}
 		} else if (ch == 'a') {
 			if (file_diff->hunk_nr) {
 				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..0eb813f74c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -48,8 +48,8 @@ test_expect_success 'unknown command' '
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
-	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]?$SP
+	(1/1) Stage addition [y,n,q,a,d,e,x,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,x,p,P,?]?$SP
 	EOF
 	git add -p -- command <command >actual 2>&1 &&
 	test_cmp expect actual
@@ -334,7 +334,7 @@ test_expect_success 'different prompts for mode change/deleted' '
 	cat >expect <<-\EOF &&
 	(1/1) Stage deletion [y,n,q,a,d,p,P,?]?
 	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,P,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -447,6 +447,24 @@ test_expect_success 'add first line works' '
 	test_cmp expected-output output
 '
 
+test_expect_success 'add -p discard removes worktree change' '
+	test_when_finished "rm -rf discard-testrepo" &&
+	mkdir discard-testrepo &&
+	(
+		cd discard-testrepo &&
+		git init -b main &&
+		echo clean >discard-me &&
+		git add discard-me &&
+		git commit -m base &&
+		echo extra >>discard-me &&
+		test_write_lines x | git add -p discard-me &&
+		printf "clean\n" >expect &&
+		test_cmp expect discard-me &&
+		git diff --cached >tmp &&
+		test_must_be_empty tmp
+	)
+'
+
 test_expect_success 'setup expected' '
 	cat >expected <<-\EOF
 	diff --git a/non-empty b/non-empty
@@ -521,13 +539,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,3          +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? + 1:  -1,2 +1,3          +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +558,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -550,11 +568,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +585,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +597,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -595,11 +613,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -796,21 +814,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,x,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
@@ -1424,9 +1442,9 @@ test_expect_success 'invalid option s is rejected' '
 	test_write_lines j s q | git add -p >out &&
 	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
 	cat >expect <<-EOF &&
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, cannot split this hunk
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,x,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? Sorry, cannot split this hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?
 	EOF
 	test_cmp expect actual
 '
-- 
2.43.0

