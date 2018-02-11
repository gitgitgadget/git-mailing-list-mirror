Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9FA1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeBKAKe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:46279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbeBKAKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:32 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LlVZv-1fHnuw3bCZ-00bKmv; Sun, 11 Feb 2018 01:10:26 +0100
Date:   Sun, 11 Feb 2018 01:10:25 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 07/12] rebase-helper --make-script: introduce a flag to
 recreate merges
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <b0a2c33ffe316e61780ad89cfdc5d45390a0f939.1518307772.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lbHcAtb0Mn6HeZoXxqdeHQr2mAHj3iOEoZmleh1SboLzEnllz5b
 pgRl9rP6bbQlgH94DMXa1SNXN155bxbA67UpaenPemnWGK5gLyvrXGkPxer+hgmR4mqrKIQ
 1YB7VLr8ssDV2scRLRChjMwNO28E73ij/gvLjQCVUQ3PHgbDzyx8xKgnr2zDtBaJOOFGdS8
 z7BPK4hSL57N+tCc0v2ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SAsQ5Qextog=:pYTnm3X/bYZg10WKNIoeu+
 Cz9Z+vlL0TxJVlEaQmLguheRWNk5upnx2vq3qvzz5wfBsy+gHm3N63eihRgfwIXMWEtnRW62A
 MkK+sMIieNhSRy9qY0h+5J3DtiZiQJes8Q4maY1B4oXSZfG0mN7OAnzB/TjGIUilf3X7H7Wj4
 vw0gJtNJ3SmxrQnW6xm4UBa/VjDbGvJufIAe3qGBOdgwexiRDRXYvVTR64b28s449pD+2vs1/
 IttsVdvrCBa9yFoAwtk/8A39QpH0fZXMxJVh5oyQrxIX3sGWLnkm/XKXgbsnMQq3BHTRqQQA0
 c470C6gcxzr/G9hBvhl/VNzsHvUP594yFRg9WHuaWZrpn8fgpDhsap6mPY2PEIGemGUej7MFm
 agnqTjvzNEs1PJXTwLGYqpAbCwBbPDxJvO8zG2b/NbtXBAeWg5axlJcUtnfEkkVzpNaLr57vk
 I1l2AYEch3kRvFig2YsshOT3PQPBkTjeFf1yPEKdl0RoEFl1Pz6EW/RfeDJSUOu2G2ilg9tDg
 OikeKjeF9GtAWXMg+hoP/1AQcossibuRkf6syuL/7m6ubNuRfTLdy6LT6CsT1qrA3BZfsse/b
 96a3HPkxLhuxf5DiKIVojq1pSM41Zm31SOPxkB9OXG9E8CQvpZzNH3gsuYs+Cdi0F6eUVPAcj
 PmKiPPZgpRSOZtPkGVuSE0Y59j8WXwrcGpXlatOiRj+MqXQ554UQMP4u2L8wcvFBr0X/Cegyb
 pwn7/3mTQMnLDgd2BuTvGhX1yPw7g8rRHBZn3RyCFeALso2fuoQXfh6EVvQwZk/Bi4hArXN7S
 AD55olBS054Ce8zT6O7gUSaBL4daqOEUhgyCkRBjYxCLiO1hS8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer just learned new commands intended to recreate branch
structure (similar in spirit to --preserve-merges, but with a
substantially less-broken design).

Let's allow the rebase--helper to generate todo lists making use of
these commands, triggered by the new --recreate-merges option. For a
commit topology like this (where the HEAD points to C):

	- A - B - C
	    \   /
	      D

the generated todo list would look like this:

	# branch D
	pick 0123 A
	label branch-point
	pick 1234 D
	label D

	reset branch-point
	pick 2345 B
	merge -C 3456 D # C

To keep things simple, we first only implement support for merge commits
with exactly two parents, leaving support for octopus merges to a later
patch in this patch series.

As a special, hard-coded label, all merge-recreating todo lists start with
the command `label onto` so that we can later always refer to the revision
onto which everything is rebased.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c |   4 +-
 sequencer.c              | 349 ++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h              |   1 +
 3 files changed, 351 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7daee544b7b..a34ab5c0655 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,7 +12,7 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0;
+	unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
 	int abbreviate_commands = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
@@ -22,6 +22,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
+		OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge commits")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -55,6 +56,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
+	flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (command == CONTINUE && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 27d582479d1..7cd091a9fd6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,8 @@
 #include "hashmap.h"
 #include "unpack-trees.h"
 #include "worktree.h"
+#include "oidmap.h"
+#include "oidset.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2808,6 +2810,341 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	strbuf_release(&sob);
 }
 
+struct labels_entry {
+	struct hashmap_entry entry;
+	char label[FLEX_ARRAY];
+};
+
+static int labels_cmp(const void *fndata, const struct labels_entry *a,
+		      const struct labels_entry *b, const void *key)
+{
+	return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
+}
+
+struct string_entry {
+	struct oidmap_entry entry;
+	char string[FLEX_ARRAY];
+};
+
+struct label_state {
+	struct oidmap commit2label;
+	struct hashmap labels;
+	struct strbuf buf;
+};
+
+static const char *label_oid(struct object_id *oid, const char *label,
+			     struct label_state *state)
+{
+	struct labels_entry *labels_entry;
+	struct string_entry *string_entry;
+	struct object_id dummy;
+	size_t len;
+	int i;
+
+	string_entry = oidmap_get(&state->commit2label, oid);
+	if (string_entry)
+		return string_entry->string;
+
+	/*
+	 * For "uninteresting" commits, i.e. commits that are not to be
+	 * rebased, and which can therefore not be labeled, we use a unique
+	 * abbreviation of the commit name. This is slightly more complicated
+	 * than calling find_unique_abbrev() because we also need to make
+	 * sure that the abbreviation does not conflict with any other
+	 * label.
+	 *
+	 * We disallow "interesting" commits to be labeled by a string that
+	 * is a valid full-length hash, to ensure that we always can find an
+	 * abbreviation for any uninteresting commit's names that does not
+	 * clash with any other label.
+	 */
+	if (!label) {
+		char *p;
+
+		strbuf_reset(&state->buf);
+		strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
+		label = p = state->buf.buf;
+
+		find_unique_abbrev_r(p, oid->hash, default_abbrev);
+
+		/*
+		 * We may need to extend the abbreviated hash so that there is
+		 * no conflicting label.
+		 */
+		if (hashmap_get_from_hash(&state->labels, strihash(p), p)) {
+			size_t i = strlen(p) + 1;
+
+			oid_to_hex_r(p, oid);
+			for (; i < GIT_SHA1_HEXSZ; i++) {
+				char save = p[i];
+				p[i] = '\0';
+				if (!hashmap_get_from_hash(&state->labels,
+							   strihash(p), p))
+					break;
+				p[i] = save;
+			}
+		}
+	} else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
+		    !get_oid_hex(label, &dummy)) ||
+		   (len == 1 && *label == '#') ||
+		   hashmap_get_from_hash(&state->labels,
+					 strihash(label), label)) {
+		/*
+		 * If the label already exists, or if the label is a valid full
+		 * OID, or the label is a '#' (which we use as a separator
+		 * between merge heads and oneline), we append a dash and a
+		 * number to make it unique.
+		 */
+		struct strbuf *buf = &state->buf;
+
+		strbuf_reset(buf);
+		strbuf_add(buf, label, len);
+
+		for (i = 2; ; i++) {
+			strbuf_setlen(buf, len);
+			strbuf_addf(buf, "-%d", i);
+			if (!hashmap_get_from_hash(&state->labels,
+						   strihash(buf->buf),
+						   buf->buf))
+				break;
+		}
+
+		label = buf->buf;
+	}
+
+	FLEX_ALLOC_STR(labels_entry, label, label);
+	hashmap_entry_init(labels_entry, strihash(label));
+	hashmap_add(&state->labels, labels_entry);
+
+	FLEX_ALLOC_STR(string_entry, string, label);
+	oidcpy(&string_entry->entry.oid, oid);
+	oidmap_put(&state->commit2label, string_entry);
+
+	return string_entry->string;
+}
+
+static int make_script_with_merges(struct pretty_print_context *pp,
+				   struct rev_info *revs, FILE *out,
+				   unsigned flags)
+{
+	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
+	struct strbuf label = STRBUF_INIT;
+	struct commit_list *commits = NULL, **tail = &commits, *iter;
+	struct commit_list *tips = NULL, **tips_tail = &tips;
+	struct commit *commit;
+	struct oidmap commit2todo = OIDMAP_INIT;
+	struct string_entry *entry;
+	struct oidset interesting = OIDSET_INIT, child_seen = OIDSET_INIT,
+		shown = OIDSET_INIT;
+	struct label_state state = { OIDMAP_INIT, { NULL }, STRBUF_INIT };
+
+	int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
+	const char *cmd_pick = abbr ? "p" : "pick",
+		*cmd_label = abbr ? "l" : "label",
+		*cmd_reset = abbr ? "t" : "reset",
+		*cmd_merge = abbr ? "m" : "merge";
+
+	oidmap_init(&commit2todo, 0);
+	oidmap_init(&state.commit2label, 0);
+	hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
+	strbuf_init(&state.buf, 32);
+
+	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
+		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
+		FLEX_ALLOC_STR(entry, string, "onto");
+		oidcpy(&entry->entry.oid, oid);
+		oidmap_put(&state.commit2label, entry);
+	}
+
+	/*
+	 * First phase:
+	 * - get onelines for all commits
+	 * - gather all branch tips (i.e. 2nd or later parents of merges)
+	 * - label all branch tips
+	 */
+	while ((commit = get_revision(revs))) {
+		struct commit_list *to_merge;
+		int is_octopus;
+		const char *p1, *p2;
+		struct object_id *oid;
+
+		tail = &commit_list_insert(commit, tail)->next;
+		oidset_insert(&interesting, &commit->object.oid);
+
+		if ((commit->object.flags & PATCHSAME))
+			continue;
+
+		strbuf_reset(&oneline);
+		pretty_print_commit(pp, commit, &oneline);
+
+		to_merge = commit->parents ? commit->parents->next : NULL;
+		if (!to_merge) {
+			/* non-merge commit: easy case */
+			strbuf_reset(&buf);
+			if (!keep_empty && is_original_commit_empty(commit))
+				strbuf_addf(&buf, "%c ", comment_line_char);
+			strbuf_addf(&buf, "%s %s %s", cmd_pick,
+				    oid_to_hex(&commit->object.oid),
+				    oneline.buf);
+
+			FLEX_ALLOC_STR(entry, string, buf.buf);
+			oidcpy(&entry->entry.oid, &commit->object.oid);
+			oidmap_put(&commit2todo, entry);
+
+			continue;
+		}
+
+		is_octopus = to_merge && to_merge->next;
+
+		if (is_octopus)
+			BUG("Octopus merges not yet supported");
+
+		/* Create a label */
+		strbuf_reset(&label);
+		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
+		    (p1 = strchr(p1, '\'')) &&
+		    (p2 = strchr(++p1, '\'')))
+			strbuf_add(&label, p1, p2 - p1);
+		else if (skip_prefix(oneline.buf, "Merge pull request ",
+				     &p1) &&
+			 (p1 = strstr(p1, " from ")))
+			strbuf_addstr(&label, p1 + strlen(" from "));
+		else
+			strbuf_addbuf(&label, &oneline);
+
+		for (p1 = label.buf; *p1; p1++)
+			if (isspace(*p1))
+				*(char *)p1 = '-';
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s -C %s",
+			    cmd_merge, oid_to_hex(&commit->object.oid));
+
+		/* label the tip of merged branch */
+		oid = &to_merge->item->object.oid;
+		strbuf_addch(&buf, ' ');
+
+		if (!oidset_contains(&interesting, oid))
+			strbuf_addstr(&buf, label_oid(oid, NULL, &state));
+		else {
+			tips_tail = &commit_list_insert(to_merge->item,
+							tips_tail)->next;
+
+			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
+		}
+		strbuf_addf(&buf, " # %s", oneline.buf);
+
+		FLEX_ALLOC_STR(entry, string, buf.buf);
+		oidcpy(&entry->entry.oid, &commit->object.oid);
+		oidmap_put(&commit2todo, entry);
+	}
+
+	/*
+	 * Second phase:
+	 * - label branch points
+	 * - add HEAD to the branch tips
+	 */
+	for (iter = commits; iter; iter = iter->next) {
+		struct commit_list *parent = iter->item->parents;
+		for (; parent; parent = parent->next) {
+			struct object_id *oid = &parent->item->object.oid;
+			if (!oidset_contains(&interesting, oid))
+				continue;
+			if (!oidset_contains(&child_seen, oid))
+				oidset_insert(&child_seen, oid);
+			else
+				label_oid(oid, "branch-point", &state);
+		}
+
+		/* Add HEAD as implict "tip of branch" */
+		if (!iter->next)
+			tips_tail = &commit_list_insert(iter->item,
+							tips_tail)->next;
+	}
+
+	/*
+	 * Third phase: output the todo list. This is a bit tricky, as we
+	 * want to avoid jumping back and forth between revisions. To
+	 * accomplish that goal, we walk backwards from the branch tips,
+	 * gathering commits not yet shown, reversing the list on the fly,
+	 * then outputting that list (labeling revisions as needed).
+	 */
+	fprintf(out, "%s onto\n", cmd_label);
+	for (iter = tips; iter; iter = iter->next) {
+		struct commit_list *list = NULL, *iter2;
+
+		commit = iter->item;
+		if (oidset_contains(&shown, &commit->object.oid))
+			continue;
+		entry = oidmap_get(&state.commit2label, &commit->object.oid);
+
+		if (entry)
+			fprintf(out, "\n# Branch %s\n", entry->string);
+		else
+			fprintf(out, "\n");
+
+		while (oidset_contains(&interesting, &commit->object.oid) &&
+		       !oidset_contains(&shown, &commit->object.oid)) {
+			commit_list_insert(commit, &list);
+			if (!commit->parents) {
+				commit = NULL;
+				break;
+			}
+			commit = commit->parents->item;
+		}
+
+		if (!commit)
+			fprintf(out, "%s onto\n", cmd_reset);
+		else {
+			const char *to = NULL;
+
+			entry = oidmap_get(&state.commit2label,
+					   &commit->object.oid);
+			if (entry)
+				to = entry->string;
+
+			if (!to || !strcmp(to, "onto"))
+				fprintf(out, "%s onto\n", cmd_reset);
+			else {
+				strbuf_reset(&oneline);
+				pretty_print_commit(pp, commit, &oneline);
+				fprintf(out, "%s %s # %s\n",
+					cmd_reset, to, oneline.buf);
+			}
+		}
+
+		for (iter2 = list; iter2; iter2 = iter2->next) {
+			struct object_id *oid = &iter2->item->object.oid;
+			entry = oidmap_get(&commit2todo, oid);
+			/* only show if not already upstream */
+			if (entry)
+				fprintf(out, "%s\n", entry->string);
+			entry = oidmap_get(&state.commit2label, oid);
+			if (entry)
+				fprintf(out, "%s %s\n",
+					cmd_label, entry->string);
+			oidset_insert(&shown, oid);
+		}
+
+		free_commit_list(list);
+	}
+
+	free_commit_list(commits);
+	free_commit_list(tips);
+
+	strbuf_release(&label);
+	strbuf_release(&oneline);
+	strbuf_release(&buf);
+
+	oidmap_free(&commit2todo, 1);
+	oidmap_free(&state.commit2label, 1);
+	hashmap_free(&state.labels, 1);
+	strbuf_release(&state.buf);
+
+	return 0;
+}
+
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags)
 {
@@ -2818,11 +3155,16 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	struct commit *commit;
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
+	int recreate_merges = flags & TODO_LIST_RECREATE_MERGES;
 
 	init_revisions(&revs, NULL);
 	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_pick = 1;
+	if (recreate_merges)
+		revs.cherry_mark = 1;
+	else {
+		revs.max_parents = 1;
+		revs.cherry_pick = 1;
+	}
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
@@ -2846,6 +3188,9 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	if (prepare_revision_walk(&revs) < 0)
 		return error(_("make_script: error preparing revisions"));
 
+	if (recreate_merges)
+		return make_script_with_merges(&pp, &revs, out, flags);
+
 	while ((commit = get_revision(&revs))) {
 		strbuf_reset(&buf);
 		if (!keep_empty && is_original_commit_empty(commit))
diff --git a/sequencer.h b/sequencer.h
index 81f6d7d393f..11d1ac925ef 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
+#define TODO_LIST_RECREATE_MERGES (1U << 3)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
-- 
2.16.1.windows.1


