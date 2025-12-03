Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA192F25FA
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758936; cv=none; b=bDHzO1y0MW+9tY6wdOj8e15lz3tzjgmyT9o+sBKfP4qH7VczQaiTqiO9MgoreniprwQ7t5DyBuyRzALn3PaL3CLNdVDN+Wyyl+ZsQKWXegIznCJRX1Vij0zO6hTDTUWoQOUfdKKSzWsunWbsHTXGbmqK4xZGT7MZx5zT6qzmYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758936; c=relaxed/simple;
	bh=jo8az/iSqvUI5roD48G1IQA+W8r++zf4M1Olek7wYL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvDGmVJdNotetlO7/GIbzom47YQg9yVMK758YHw6QuU1OsAJ1gsymDDyPIq6WbU3RWOQZ8nJJvDMv8OijLBwRrqABhI+o6rKFGswvp8Xw47kcU9/L5YjEo1Bb2xDRKW5TjToJIhX9PLENjauDBP7y2zQombzZQwmdPZDZnNhWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VLcLUKvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WP04sMT3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VLcLUKvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WP04sMT3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 14534EC03AB;
	Wed,  3 Dec 2025 05:48:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Dec 2025 05:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758933;
	 x=1764845333; bh=7ru/xepUVDjoaZe1AvMdTMyMzUCZ1KPM7U+/w9p6AqY=; b=
	VLcLUKvFSaGQYBeRgqpmFQkcbLfSMJTQaevF9HrAcq54bKR71WHj8hvx7IPGdnLs
	S1+a1G/ixXM/2eGeBFZ9L7hq1I9Qra6OwjoopLJaETOVhzqGzlGAYDPQLPMnQLlh
	VKqyPYx1m7bBPJYcBwG3PZ3WynJG7Y76al0FuSxfQIH1vtaCESwA1tCMJb3v8qvw
	RhD4xnCiF/tp1tOnd/bcFgEJV+V3GCJXg9hKoCoHsC9a3m+g3Cnc0uAlyKN3cfaW
	6tymJtyrwqG32EC4aOwxc+709zJbxRYRNxQ3KioEkygnxKyYahlgHJmlHccTMlop
	3JMfWgTLgzv4idf40K3p4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758933; x=
	1764845333; bh=7ru/xepUVDjoaZe1AvMdTMyMzUCZ1KPM7U+/w9p6AqY=; b=W
	P04sMT3gaSQW1cVTPAK7IbARPCT31qdYe3DusUXu2MOh2W3yrN2S3zL6vW4auwcW
	xBuF2Bapqo5jSF0qw+Nb+rfw92mmSqCpm/XAuP95RuivJFBon2sWKk9SCBifVByZ
	cGxVG6Mb1VSdt9CEtVwiQ3ALxEz2jHn4ctBxEPOtg6xQriw5zcrvD5jNn1rBJhBq
	gipuL+VqA4e6nPagpd5w2M0FufGwMCWvNo6IW+urbrEQzeNzdmJSbN56BlqsZu/U
	FNsk1Mm3Fvw4iiYyIlsuH2QfAveJTUrpCPMsuEZeNeEDeRddHQD8mGhg8wLTLCHJ
	cWgG3ISrnD8MRuA00/z9A==
X-ME-Sender: <xms:lRUwaSeKGNLcSfhBdJslOS56h1Ozpb53WFDl0a5Cd0McLH2BMfocdw>
    <xme:lRUwaey8OeHtfNuD3KJUnOItPzVmKoT7axQt5jQduul0qmj82pgvMnu2ifoC_iS6X
    ms7gPH2P4YnWM2eQ4d0KOEQenu-62TLgxFF6ipTpBU7jgq-kapJAA>
X-ME-Received: <xmr:lRUwaXJN_x3iVVIf1A0Hhy1ePGqV-99oq-bZB22uYsKmpttusTgQILICvuLvwkbrTvYx4_K1lqvY3iUMUvoOU8wQhA703xwNtTGDE1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lRUwaQEb7XM6EmMXpDBUKv-hiJQ8qXxaJfmkdnIXVuV6ONhNCIqT5w>
    <xmx:lRUwaT-Vo6ZS3anjQjz75Oyy-uGFebIG0rq0aRfZiLSXSVRyOllEIw>
    <xmx:lRUwaQLccjUDNhqMLYQ3QgMTp1g5cFuKU5Ta1OODoCsUb1JmkCzmww>
    <xmx:lRUwaRt1cEpl_ueabrcfGJsfSAx9CbRAFac2u0MY8LEYQ31JbKRqug>
    <xmx:lRUwaVpid04nskVk-zALAZKbeERUgOON-gD0xPf4CxUf7gtUlYOBMj4->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6598e821 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:32 +0100
Subject: [PATCH v7 05/12] builtin/history: implement "reword" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-5-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Implement a new "reword" subcommand for git-history(1). This subcommand
is similar to the user performing an interactive rebase with a single
commit changed to use the "reword" instruction.

The major difference is that we do not check out the commit that is to
be reworded. This has the obvious benefit of being significantly faster
compared to git-rebase(1), but even more importantly it allows the user
to rewrite history even if there are local changes in the working tree
or in the index.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |   7 +-
 builtin/history.c              | 372 ++++++++++++++++++++++++++++++++++++++++-
 t/meson.build                  |   1 +
 t/t3450-history.sh             |   6 +-
 t/t3451-history-reword.sh      | 236 ++++++++++++++++++++++++++
 5 files changed, 613 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 67b8ce2040..160bf5d4d2 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history of the current branch
 SYNOPSIS
 --------
 [synopsis]
-git history [<options>]
+git history reword <commit>
 
 DESCRIPTION
 -----------
@@ -32,6 +32,11 @@ COMMANDS
 
 Several commands are available to rewrite history in different ways:
 
+`reword <commit>`::
+	Rewrite the commit message of the specified commit. All the other
+	details of this commit remain unchanged. This command will spawn an
+	editor with the current message of that commit.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index f6fe32610b..17bb150b95 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,22 +1,384 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "commit-reach.h"
+#include "commit.h"
+#include "config.h"
+#include "editor.h"
+#include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "replay.h"
+#include "reset.h"
+#include "revision.h"
+#include "sequencer.h"
+#include "strvec.h"
+#include "tree.h"
+#include "wt-status.h"
+
+#define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
+
+static int collect_commits(struct repository *repo,
+			   struct commit *old_commit,
+			   struct commit *new_commit,
+			   struct strvec *out)
+{
+	struct setup_revision_opt revision_opts = {
+		.assume_dashdash = 1,
+	};
+	struct strvec revisions = STRVEC_INIT;
+	struct commit *child;
+	struct rev_info rev = { 0 };
+	int ret;
+
+	repo_init_revisions(repo, &rev, NULL);
+	rev.reverse = 1;
+	strvec_push(&revisions, "");
+	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
+	if (old_commit) {
+		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
+		strvec_pushf(&revisions, "--ancestry-path=%s", oid_to_hex(&old_commit->object.oid));
+	}
+
+	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
+	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
+		ret = error(_("revision walk setup failed"));
+		goto out;
+	}
+
+	while ((child = get_revision(&rev))) {
+		if (old_commit && !child->parents)
+			BUG("revision walk did not find child commit");
+		if (child->parents && child->parents->next) {
+			ret = error(_("cannot rearrange commit history with merges"));
+			goto out;
+		}
+
+		strvec_push(out, oid_to_hex(&child->object.oid));
+	}
+
+	ret = 0;
+
+out:
+	strvec_clear(&revisions);
+	release_revisions(&rev);
+	reset_revision_walk();
+	return ret;
+}
+
+static int gather_commits_between_head_and_revision(struct repository *repo,
+						    const char *revision,
+						    struct commit **original_commit,
+						    struct commit **parent_commit,
+						    struct commit **head,
+						    struct strvec *commits)
+{
+	struct commit_list *from_list = NULL;
+	int ret;
+
+	*original_commit = lookup_commit_reference_by_name(revision);
+	if (!*original_commit) {
+		ret = error(_("commit cannot be found: %s"), revision);
+		goto out;
+	}
+
+	*parent_commit = (*original_commit)->parents ? (*original_commit)->parents->item : NULL;
+	if (*parent_commit && repo_parse_commit(repo, *parent_commit)) {
+		ret = error(_("unable to parse commit %s"),
+			    oid_to_hex(&(*parent_commit)->object.oid));
+		goto out;
+	}
+
+	*head = lookup_commit_reference_by_name("HEAD");
+	if (!(*head)) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	commit_list_append(*original_commit, &from_list);
+	if (!repo_is_descendant_of(repo, *head, from_list)) {
+		ret = error(_("commit must be reachable from current HEAD commit"));
+		goto out;
+	}
+
+	/*
+	 * Collect the list of commits that we'll have to reapply now already.
+	 * This ensures that we'll abort early on in case the range of commits
+	 * contains merges, which we do not yet handle.
+	 */
+	ret = collect_commits(repo, *parent_commit, *head, commits);
+	if (ret < 0)
+		goto out;
+
+out:
+	free_commit_list(from_list);
+	return ret;
+}
+
+static void replace_commits(struct strvec *commits,
+			    const struct object_id *commit_to_replace,
+			    const struct object_id *replacements,
+			    size_t replacements_nr)
+{
+	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
+	struct strvec replacement_oids = STRVEC_INIT;
+	bool found = false;
+
+	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
+	for (size_t i = 0; i < replacements_nr; i++)
+		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
+
+	for (size_t i = 0; i < commits->nr; i++) {
+		if (strcmp(commits->v[i], commit_to_replace_oid))
+			continue;
+		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
+		found = true;
+		break;
+	}
+	if (!found)
+		BUG("could not find commit to replace");
+
+	strvec_clear(&replacement_oids);
+}
+
+static int apply_commits(struct repository *repo,
+			 const struct strvec *commits,
+			 struct commit *onto,
+			 struct commit *orig_head,
+			 const char *action)
+{
+	struct reset_head_opts reset_opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	for (size_t i = 0; i < commits->nr; i++) {
+		struct object_id commit_id;
+		struct commit *commit;
+		const char *end;
+
+		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
+					repo->hash_algo)) {
+			ret = error(_("invalid object ID: %s"), commits->v[i]);
+			goto out;
+		}
+
+		commit = lookup_commit(repo, &commit_id);
+		if (!commit || repo_parse_commit(repo, commit)) {
+			ret = error(_("failed to look up commit: %s"), oid_to_hex(&commit_id));
+			goto out;
+		}
+
+		if (!onto) {
+			onto = commit;
+		} else {
+			struct tree *tree = repo_get_commit_tree(repo, commit);
+			onto = replay_create_commit(repo, tree, commit, onto);
+			if (!onto) {
+				ret = -1;
+				goto out;
+			}
+		}
+	}
+
+	reset_opts.oid = &onto->object.oid;
+	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
+	reset_opts.flags = RESET_HEAD_REFS_ONLY | RESET_ORIG_HEAD;
+	reset_opts.orig_head = &orig_head->object.oid;
+	reset_opts.default_reflog_action = action;
+	if (reset_head(repo, &reset_opts) < 0) {
+		ret = error(_("could not switch to %s"), oid_to_hex(reset_opts.oid));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
+static int fill_commit_message(struct repository *repo,
+			       const struct object_id *old_tree,
+			       const struct object_id *new_tree,
+			       const char *default_message,
+			       const char *action,
+			       struct strbuf *out)
+{
+	const char *path = git_path_commit_editmsg();
+	const char *hint =
+		_("Please enter the commit message for the %s changes."
+		  " Lines starting\nwith '%s' will be ignored, and an"
+		  " empty message aborts the commit.\n");
+	struct wt_status s;
+
+	strbuf_addstr(out, default_message);
+	strbuf_addch(out, '\n');
+	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+	write_file_buf(path, out->buf, out->len);
+
+	wt_status_prepare(repo, &s);
+	FREE_AND_NULL(s.branch);
+	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+	s.commit_template = 1;
+	s.colopts = 0;
+	s.display_comment_prefix = 1;
+	s.hints = 0;
+	s.use_color = 0;
+	s.whence = FROM_COMMIT;
+	s.committable = 1;
+
+	s.fp = fopen(git_path_commit_editmsg(), "a");
+	if (!s.fp)
+		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+	wt_status_collect_changes_trees(&s, old_tree, new_tree);
+	wt_status_print(&s);
+	wt_status_collect_free_buffers(&s);
+	string_list_clear_func(&s.change, change_data_free);
+
+	strbuf_reset(out);
+	if (launch_editor(path, out, NULL)) {
+		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));
+		return -1;
+	}
+	strbuf_stripspace(out, comment_line_str);
+
+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
+
+	if (!out->len) {
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int commit_tree_with_edited_message(struct repository *repo,
+					   const char *action,
+					   struct commit *original_commit,
+					   const struct object_id *new_tree_oid,
+					   const struct commit_list *parents,
+					   const struct object_id *parent_tree_oid,
+					   struct object_id *out)
+{
+	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
+	const char *original_message, *original_body, *ptr;
+	struct commit_extra_header *original_extra_headers = NULL;
+	struct strbuf commit_message = STRBUF_INIT;
+	char *original_author = NULL;
+	size_t len;
+	int ret;
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+	find_commit_subject(original_message, &original_body);
+
+	ret = fill_commit_message(repo, parent_tree_oid, new_tree_oid,
+				  original_body, action, &commit_message);
+	if (ret < 0)
+		goto out;
+
+	original_extra_headers = read_commit_extra_headers(original_commit, exclude_gpgsig);
+
+	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree_oid,
+				   parents, out, original_author, NULL, NULL,
+				   original_extra_headers);
+	if (ret < 0)
+		goto out;
+
+out:
+	free_commit_extra_headers(original_extra_headers);
+	strbuf_release(&commit_message);
+	free(original_author);
+	return ret;
+}
+
+static int cmd_history_reword(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_REWORD_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct commit *original_commit, *parent, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct object_id parent_tree_oid, original_commit_tree_oid;
+	struct object_id rewritten_commit;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	ret = gather_commits_between_head_and_revision(repo, argv[0], &original_commit,
+						       &parent, &head, &commits);
+	if (ret < 0)
+		goto out;
+
+	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
+	if (parent)
+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
+	else
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+
+	/* We retain authorship of the original commit. */
+	ret = commit_tree_with_edited_message(repo, "reworded", original_commit,
+					      &original_commit_tree_oid,
+					      original_commit->parents, &parent_tree_oid,
+					      &rewritten_commit);
+	if (ret < 0) {
+		ret = error(_("failed writing reworded commit"));
+		goto out;
+	}
+
+	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
+
+	ret = apply_commits(repo, &commits, parent, head, "reword");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	strvec_clear(&commits);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
-		N_("git history [<options>]"),
+		GIT_HISTORY_REWORD_USAGE,
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc)
-		usagef("unrecognized argument: %s", argv[0]);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/t/meson.build b/t/meson.build
index 62f5dca098..e187aef31e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -387,6 +387,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
+  't3451-history-reword.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 417c343d43..f513463b92 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -5,13 +5,13 @@ test_description='tests for git-history command'
 . ./test-lib.sh
 
 test_expect_success 'does nothing without any arguments' '
-	git history >out 2>&1 &&
-	test_must_be_empty out
+	test_must_fail git history 2>err &&
+	test_grep "need a subcommand" err
 '
 
 test_expect_success 'raises an error with unknown argument' '
 	test_must_fail git history garbage 2>err &&
-	test_grep "unrecognized argument: garbage" err
+	test_grep "unknown subcommand: .garbage." err
 '
 
 test_done
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
new file mode 100755
index 0000000000..2a638d2378
--- /dev/null
+++ b/t/t3451-history-reword.sh
@@ -0,0 +1,236 @@
+#!/bin/sh
+
+test_description='tests for git-history reword subcommand'
+
+. ./test-lib.sh
+
+reword_with_message () {
+	cat >message &&
+	write_script fake-editor.sh <<-\EOF &&
+	cp message "$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh &&
+	git history reword "$@" &&
+	rm fake-editor.sh message
+}
+
+test_expect_success 'refuses to work with merge commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+		test_must_fail git history reword HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err &&
+		test_must_fail git history reword HEAD 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with unrelated commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		test_must_fail git history reword ours 2>err &&
+		test_grep "commit must be reachable from current HEAD commit" err
+	)
+'
+
+test_expect_success 'can reword tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD <<-EOF &&
+		third reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third reworded
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		git reflog >reflog &&
+		test_grep "reword: updating HEAD" reflog
+	)
+'
+
+test_expect_success 'can reword commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can reword root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		reword_with_message HEAD~2 <<-EOF &&
+		first reworded
+		EOF
+
+		cat >expect <<-EOF &&
+		third
+		second
+		first reworded
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'editor shows proper status' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cp "$1" . &&
+		printf "\namend a comment\n" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD &&
+
+		cat >expect <<-EOF &&
+		first
+
+		# Please enter the commit message for the reworded changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+		# Changes to be committed:
+		#	new file:   first.t
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		test_commit_message HEAD <<-\EOF
+		first
+
+		amend a comment
+		EOF
+	)
+'
+
+# For now, git-history(1) does not yet execute any hooks. This is subject to
+# change in the future, and if it does this test here is expected to start
+# failing. In other words, this test is not an endorsement of the current
+# status quo.
+test_expect_success 'hooks are not executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		ORIG_PATH="$(pwd)" &&
+		export ORIG_PATH &&
+		for hook in prepare-commit-msg pre-commit post-commit post-rewrite commit-msg
+		do
+			write_script .git/hooks/$hook <<-\EOF || exit 1
+			touch "$ORIG_PATH/hooks.log
+			EOF
+		done &&
+
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		test_path_is_missing hooks.log
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		! reword_with_message HEAD 2>err </dev/null &&
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'retains changes in the worktree and index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch a b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo foo >a &&
+		echo bar >b &&
+		git add b &&
+		reword_with_message HEAD <<-EOF &&
+		message
+		EOF
+		cat >expect <<-\EOF &&
+		 M a
+		M  b
+		?? actual
+		?? expect
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.52.0.239.gd5f0c6e74e.dirty

