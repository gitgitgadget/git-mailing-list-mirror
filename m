Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9143C06F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832265; cv=none; b=TGKa8DWDSJeNUPQ4/3hX5VIhi9o+NQbttzu2n3EHznjvo+sbYdmw431/jb/l3pDuHGiWtVsriM+qttHREHCLXvAuiVIhfr3U/ing38K2L3xQFDrvMux0RnuSeGUPFmLQSZOBbjwOK8hvVLRhd6gPjXTvg0hAXNPGHTAghwf5q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832265; c=relaxed/simple;
	bh=IXIRT/E56272a0PhkXhgWBcbtdKm1OMX2AzZCm3zADs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NFIr91ksCRW7Ir1OYN7Uz8mpfOOszgoI5qOkMVQqFVuktFO+/on/x07TQMLK1t1upRDCFHeRVmKqib5zRUYQA6iNOo+ErWUXC2F8PoweJ2Vr3XWVDXP3PkkQwBu1wHxSm1YYOR0jgF2RHwbni1vKjVSh4iOjlaeo+i7QGTSk958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsuQbxcc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsuQbxcc"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e6f0b4610so47758967b3.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832261; x=1786437061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ps0g6UdyFB0QR8EhsPd4VroavIiZ34HrSNoRSya7gZ0=;
        b=qsuQbxccKAf05cAreQdQiFsWxMCnM6n8+z4jcWe/1G7Hu0o3SME3r5I/Dbc+fEVuge
         GfrfYoxGwvGGQht+hOuDCvr0QAlsZw1bjJ602vIuutRdKC75PgDa35DwaV9XhWgMgywm
         yWJO1xWPmOp7wtSRKoPWiY/MUCQU+A16kunUosRqPJASav+ndnhW1QcgizWW79T2+A+H
         jLbxoYLg4O+7m62HImhilZgSCcSdq9yhPPkOMuSODj4w1FYvq6KlJdxZIxkn9yXcghbs
         oB8x8wVdD94zyiIGvNwmIDEYayHZ1uv4n1/aO9cdikiiqDJEwbbSdcIdv5nlhpLjYcVy
         XelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832261; x=1786437061;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ps0g6UdyFB0QR8EhsPd4VroavIiZ34HrSNoRSya7gZ0=;
        b=aoWsErQfkgIOaeg+R0q0s7kuNEEzgjgdxEIGyZzk+qmCjXDt65/gp+vTzdbOme75Tt
         q8Ul3nM8KdwdWo8/u2vxzsBKm4+R26v4nttXo3xHlfEOVvCaZWT8o1f8tLSNIbGSwhS5
         A8K5AZqc0giU4mEKLJHytStEEh2FfMBSIEpCMdoDQIMYWTx3p7JwnqR0i8+JYRBIL+I0
         rZAZIMVJ21ylYyGzVrSRIXcL+5je/n/9bDXPpKngAuyBCgZ/+BW7WFY6WLYTRx333zXi
         7jQPytCCvIhy84adZCPIZT5hrnOrdgogxygXGC/3J/mRVXKvHe9maujx+AC2F1x1bSgr
         p4Dg==
X-Gm-Message-State: AOJu0YyMe8QMOpkcB67iD6cIps5Mk2dFUMEnTJxZZfyjPCrOCRHef9yH
	jGyas+A7CMzJmdMERIFYowX6HrG49EO6w4rj1GPiI8ks/OXT5AW3bLXRXGOGWQ==
X-Gm-Gg: AR+sD10Qzm0A+VHgPJPwSnyIK8IxvF+z1ZWbXPi3ofxNbfQV3O0Q5NUOp8VnilRIbsx
	pJQpg9bmFM21DVTUH37TkTwf60GG+Isd2oapjoZ/SIb1MURl9gf+WiklInPalbfIOjrdsuS6ZQJ
	T2ovJJ/5RG9fRRzDcoiWuuxgSyAp4H8POTkT52QGfVtR2P0ueTgF2dLmgAWUdZTxN6hpYHRe+Pi
	ijRIirNE19nT/7GMZNh4DKu2ake3F6pP8YRX1fso3l+yDpYJ9/TpJM+KR5c5s6WvdyfN1KJ5e4h
	RBslCfBruZKWV5LO90ARbgH39BveaD2KyuLV9lIboybx9TRxbEsSmSY61GQ4buYJD7TQ/0uIcP5
	Vvh46CfVyFo55CI5gN/UZLhrjESvL2R8webNr7AIn+A4HTaM2TvQ9yAhCejZGQm77A1IGoxXu4R
	3+PfuhIvJpG7ikps6zUi7auab+muWUQuc99UTGvw5TBT5s3wbLSbkXLkLaNxOfJH8=
X-Received: by 2002:a05:690c:6c08:b0:7d0:79f:339f with SMTP id 00721157ae682-81fd4c09889mr158599387b3.34.1785832259793;
        Tue, 04 Aug 2026 01:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201341ddedsm1523847b3.23.2026.08.04.01.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:59 -0700 (PDT)
Message-Id: <33d3eca6dbbc556b096ca6ea0ff6c1720aa08916.1785832251.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
References: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
	<pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 08:30:51 +0000
Subject: [PATCH v12 4/4] history: add squash subcommand to fold a range
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Folding a series of commits into one required either an interactive
rebase where each commit after the first was hand-edited to "fixup", or
a "git reset --soft" to the merge base followed by "git commit --amend".

Add "git history squash <revision-range>" to do this directly. It folds
every selected commit into one, preserving the authorship and parents of
the oldest commit and taking the tree of the tip, then replays commits
above the range. By default an editor opens with every folded message in
the same template used by "git rebase -i --autosquash". With --no-edit,
the selected message is used without opening an editor.

Resolve fixup!, squash! and amend! subjects directly while walking the
selected commits. A marker is rejected unless its fixed target is also
selected, except that a range made up entirely of related markers can be
consolidated. Without editing, refuse any squash! or amend! whose message
would be discarded.

Read the range like arguments to "git rev-list" and accept multiple
revisions and rev-list options. Restore the walk settings required by the
fold after setup_revisions(), warning when an option changed them. The
range must name a bottom commit, must not reach a root, and must have one
tip. Every parent after the oldest commit must be selected or also be a
parent of the oldest commit. This permits internal merges and preserves
all parents when the oldest commit is itself a merge.

By default, refuse when a local branch descends from the selected commits
but cannot remain a descendant of the result. Tags and remote-tracking
refs are left unchanged. Use --update-refs=head to leave such local
branches unchanged as well.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  59 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 611 +++++++++++++++++++++
 object.h                         |   1 +
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 884 +++++++++++++++++++++++++++++++
 8 files changed, 1560 insertions(+), 2 deletions(-)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..e2a3487778 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -59,6 +59,10 @@ all advice messages.
 	forceDeleteBranch::
 		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
+	historyUpdateRefs::
+		Shown when `git history squash` refuses because a ref points
+		into the range being folded, to tell the user about
+		`--update-refs=head`.
 	ignoredHook::
 		Shown when a hook is ignored because the hook is not
 		set as executable.
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 28b477cd37..2e2e31f521 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
 
 DESCRIPTION
 -----------
@@ -43,8 +44,11 @@ at once.
 LIMITATIONS
 -----------
 
-This command does not (yet) work with histories that contain merges. You
-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
+This command does not (yet) replay merge commits onto the rewritten
+history: if a commit that would be replayed is a merge, the operation is
+rejected, and you should use linkgit:git-rebase[1] with the
+`--rebase-merges` flag instead. The `squash` subcommand can still fold merges
+that lie inside the selected range, subject to the restrictions below.
 
 Furthermore, the command does not support operations that can result in merge
 conflicts. This limitation is by design as history rewrites are not intended to
@@ -113,6 +117,51 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
+`squash <revision-range>`::
+	Fold all commits in _<revision-range>_ into the oldest commit of that
+	range. The resulting commit keeps the oldest commit's authorship and
+	takes the tree of the range's newest commit, so the whole range
+	collapses into a single commit. Commits above the range are replayed
+	on top of the result.
++
+The range is given in the usual `<base>..<tip>` form, where _<base>_ is
+the commit just below the oldest commit to squash. For example, `git
+history squash HEAD~3..HEAD` folds the three most recent commits into
+one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
+while leaving the two newest commits in place. Several revisions may be
+given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
+already on `topic`. Rev-list options may also be given, but any that would
+change how the range is walked are overridden with a warning.
++
+An editor opens pre-filled with the messages of all the folded commits so you
+can combine them. With `--no-edit`, the oldest commit's message is preserved
+instead, except that an `amend!` commit targeting it replaces its message.
++
+The selected commits must form a connected graph with a single tip and must
+not include a root commit. Every parent of a commit after the oldest one must
+either be selected or also be a parent of the oldest commit. When the oldest
+commit is a merge, all of its parents are preserved in the squashed commit.
++
+A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
+targets is also in the range, so the fold does not silently absorb a
+marker meant for a commit outside it. As an exception, a range made up entirely
+of markers for one target is combined into a single commit. With `--no-edit`,
+the last `amend!` message is used if there is one; a `squash!` or `amend!` is
+otherwise refused if folding it would discard its message.
++
+The editor template mirrors `git rebase -i --autosquash`: each `fixup!`,
+`squash!`, or `amend!` is grouped under the commit it targets rather than
+shown in commit order. A `fixup!` message is dropped (commented out in full),
+a `squash!` keeps its body with only the marker subject commented, and an
+`amend!` replaces its target's message, unless a `squash!` folded into that
+target first, in which case it keeps its body like a `squash!`.
++
+A local branch descended from a selected commit but not from the range tip
+cannot be rewritten as a descendant of the result, so with the default
+`--update-refs=branches` the command refuses. Rerun with `--update-refs=head`
+to rewrite only the current branch and leave such branches unchanged. Tags
+and remote-tracking refs are always left unchanged.
+
 OPTIONS
 -------
 
@@ -122,6 +171,12 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
+`--edit`::
+`--no-edit`::
+	For `squash`, open an editor to combine the messages of the folded commits.
+	This is the default; use `--no-edit` to keep the selected message without
+	opening an editor.
+
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..401d047391 100644
--- a/advice.c
+++ b/advice.c
@@ -58,6 +58,7 @@ static struct {
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
+	[ADVICE_HISTORY_UPDATE_REFS]			= { "historyUpdateRefs" },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
 	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..3f0b4f0485 100644
--- a/advice.h
+++ b/advice.h
@@ -25,6 +25,7 @@ enum advice_type {
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
+	ADVICE_HISTORY_UPDATE_REFS,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
 	ADVICE_MERGE_CONFLICT,
diff --git a/builtin/history.c b/builtin/history.c
index a60e8dbcd0..4c1f089d9f 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "advice.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -16,6 +17,7 @@
 #include "path.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "ref-filter.h"
 #include "replay.h"
 #include "reset.h"
 #include "revision.h"
@@ -34,6 +36,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1004,6 +1008,611 @@ out:
 	return ret;
 }
 
+/*Remember to update object flag allocation in object.h */
+#define SQUASH_SEEN (1u << 11)
+#define SQUASH_TIP (1u << 12)
+#define SQUASH_AMEND_TARGET (1u << 13)
+
+static bool is_autosquash_subject(const char *s)
+{
+	return starts_with(s, "amend!") || starts_with(s, "fixup!") ||
+		starts_with(s, "squash!");
+}
+
+static bool skip_one_autosquash_prefix(const char *s, const char **out)
+{
+	if (skip_prefix(s, "amend!", out) || skip_prefix(s, "fixup!", out) ||
+	    skip_prefix(s, "squash!", out)) {
+		while (**out == ' ')
+			(*out)++;
+		return true;
+	}
+	return false;
+}
+
+static void truncate_message_to_subject(struct strbuf *msg)
+{
+	const char *eos = strstr(msg->buf, "\n\n");
+
+	if (eos)
+		strbuf_setlen(msg, eos - msg->buf + 1);
+}
+
+struct subject_data {
+	struct strintmap subjects;
+	struct strbuf subject;
+	struct strbuf squash_message;
+	const char *message;
+	bool edit_message;
+};
+
+#define SUBJECT_DATA_INIT {		\
+	.subjects = STRINTMAP_INIT,	\
+	.subject = STRBUF_INIT,		\
+	.squash_message = STRBUF_INIT,	\
+}
+
+static void subject_data_clear(struct subject_data *data)
+{
+	strintmap_clear(&data->subjects);
+	strbuf_release(&data->subject);
+	strbuf_release(&data->squash_message);
+}
+
+static int squash_amend_message(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data,
+				unsigned flags)
+{
+	const char *body = data->message + data->subject.len;
+
+	while (isspace(*body))
+		body++;
+
+	if (!*body) {
+		warning(_("ignoring %s (%s): message body is empty"),
+			repo_find_unique_abbrev(repo, &commit->object.oid,
+						DEFAULT_ABBREV),
+			data->subject.buf);
+		return 0;
+	}
+
+	if (data->edit_message) {
+		return 0;
+	} else if (flags & SQUASH_AMEND_TARGET) {
+		if (starts_with(data->squash_message.buf, "squash!"))
+			return error(_("squashing %s (%s) would overwrite "
+				       "'squash!' message, please combine them "
+				       "using '--edit'"),
+				     repo_find_unique_abbrev(repo,
+							     &commit->object.oid,
+							     DEFAULT_ABBREV),
+				     data->subject.buf);
+		if (starts_with(data->squash_message.buf, "fixup!"))
+			strbuf_splice(&data->squash_message, 0, 5, "amend!", 5);
+		if (starts_with(data->squash_message.buf, "amend!")) {
+			truncate_message_to_subject(&data->squash_message);
+			strbuf_addch(&data->squash_message, '\n');
+		} else {
+			strbuf_reset(&data->squash_message);
+		}
+		strbuf_addstr(&data->squash_message, body);
+		strbuf_complete_line(&data->squash_message);
+	} else {
+		return error(_("cannot squash %s (%s) that does not target "
+			       "base commit without '--edit'"),
+			     repo_find_unique_abbrev(repo, &commit->object.oid,
+						     DEFAULT_ABBREV),
+			     data->subject.buf);
+	}
+	return 0;
+}
+
+static int squash_squash_message(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data,
+				unsigned flags)
+{
+	const char *body = data->message + data->subject.len;
+
+	while (isspace(*body))
+		body++;
+
+	if (data->edit_message) {
+		return 0;
+	} else if (flags & SQUASH_AMEND_TARGET) {
+		if (starts_with(data->squash_message.buf, "fixup!")) {
+			truncate_message_to_subject(&data->squash_message);
+			strbuf_splice(&data->squash_message, 0, 5, "squash", 6);
+		}
+		if (starts_with(data->squash_message.buf, "squash!")) {
+			strbuf_addch(&data->squash_message, '\n');
+			strbuf_addstr(&data->squash_message, body);
+			strbuf_complete_line(&data->squash_message);
+		} else {
+			return error(_("squashing %s (%s) would discard its "
+				       "message, please combine them using "
+				       "'--edit'"),
+				     repo_find_unique_abbrev(repo,
+							     &commit->object.oid,
+							     DEFAULT_ABBREV),
+				     data->subject.buf);
+		}
+	} else {
+		return error(_("cannot squash %s (%s) that does not target "
+			       "base commit without '--edit'"),
+			      repo_find_unique_abbrev(repo, &commit->object.oid,
+						      DEFAULT_ABBREV),
+			      data->subject.buf);
+	}
+	return 0;
+}
+
+static int squash_check_can_autosquash(struct repository *repo,
+				       struct commit *commit,
+				       struct subject_data *data,
+				       unsigned flags)
+{
+	commit->object.flags |= flags & SQUASH_AMEND_TARGET;
+	if (starts_with(data->subject.buf, "amend!"))
+		return squash_amend_message(repo, commit, data, flags);
+	else if (starts_with(data->subject.buf, "squash!"))
+		return squash_squash_message(repo, commit, data, flags);
+
+	return 0;
+}
+
+static int squash_check_autosquash_subject(struct repository *repo,
+					   struct commit *commit,
+					   struct subject_data *data)
+{
+	const char* s = data->subject.buf;
+	struct commit *target;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	/* Try skipping autosquash prefixes one at a time to allow
+	 * squashing
+	 *     a commit
+	 *     fixup! fixup! a commit
+	 *
+	 * where we may have started with
+	 *     a commit
+	 *     fixup! a commit
+	 *     fixup! fixup! a commit
+	 *
+	 * and squashed the first fixup separately from the second
+	 */
+	while (skip_one_autosquash_prefix(s, &s)) {
+		unsigned flags = strintmap_get(&data->subjects, s);
+		if (flags)
+			return squash_check_can_autosquash(repo, commit, data, flags);
+	}
+	/*
+	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
+	 * "fixup! main". If the target is not being squshed check the subject
+	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
+	 * squashed together.
+	 */
+	target = lookup_commit_reference_by_name(s);
+	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
+		unsigned flags =
+			target->object.flags & (SQUASH_SEEN | SQUASH_AMEND_TARGET);
+		if (!flags) {
+			const char *subject_start;
+			const char *buffer = repo_logmsg_reencode(repo, target,
+								  NULL, NULL);
+			size_t subject_len = find_commit_subject(buffer,
+								 &subject_start);
+			char *subject = xmemdupz(subject_start, subject_len);
+
+			flags = strintmap_get(&data->subjects, subject);
+			free(subject);
+			repo_unuse_commit_buffer(repo, target, buffer);
+		}
+		if (flags)
+			return squash_check_can_autosquash(repo, commit,
+							   data, flags);
+	}
+	/* Try subject prefix matches */
+	strintmap_for_each_entry(&data->subjects, &iter, entry) {
+		s = data->subject.buf;
+		while(skip_one_autosquash_prefix(s, &s)) {
+			if (starts_with(entry->key, s)) {
+				unsigned value = (intptr_t)entry->value;
+
+				return squash_check_can_autosquash(repo, commit,
+								   data, value);
+			}
+		}
+	}
+	return error(_("cannot squash %s (%s): its target is not being "
+		       "squashed"),
+		       repo_find_unique_abbrev(repo, &commit->object.oid,
+					       DEFAULT_ABBREV),
+		       data->subject.buf);
+}
+
+static int squash_check_subject(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data)
+{
+	int ret = 0;
+	const char *buf = repo_logmsg_reencode(repo, commit, NULL, NULL);
+	size_t subject_len = find_commit_subject(buf, &data->message);
+
+	strbuf_reset(&data->subject);
+	strbuf_add(&data->subject, data->message, subject_len);
+
+	if (!strintmap_get_size(&data->subjects)) {
+		const char *s;
+
+		strbuf_addstr(&data->squash_message, data->message);
+		strbuf_complete_line(&data->squash_message);
+		/*
+		 * Strip a single autosquash prefix to allow squashing
+		 *     fixup! base
+		 *     amend! base
+		 */
+		s = data->subject.buf;
+		skip_one_autosquash_prefix(s, &s);
+		strintmap_set(&data->subjects, s, SQUASH_AMEND_TARGET | SQUASH_SEEN);
+		commit->object.flags |= SQUASH_AMEND_TARGET;
+	} else if (is_autosquash_subject(data->subject.buf)) {
+		ret = squash_check_autosquash_subject(repo, commit, data);
+	} else {
+		strintmap_set(&data->subjects, data->subject.buf, SQUASH_SEEN);
+	}
+	repo_unuse_commit_buffer(repo, commit, buf);
+	return ret;
+}
+
+static int build_squash_message(struct repository *repo,
+				const struct strbuf *todo_buf,
+				struct strbuf *out);
+
+/*
+ * Resolve a "<base>..<tip>" revision range into the base commit just outside
+ * the range (which becomes the parent of the squashed commit), the oldest
+ * commit contained in the range (whose message the squash reuses), and the
+ * range tip (whose tree becomes the result). A merge inside the range is fine,
+ * but the range must have a single base and must not reach a root commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				bool update_branches,
+				bool edit_message,
+				int argc, const char **argv,
+				struct commit **oldest_out,
+				struct commit **tip_out,
+				char **message_out)
+{
+	struct rev_info revs;
+	struct subject_data subject_data = SUBJECT_DATA_INIT;
+	struct commit *commit, *oldest = NULL, *tip = NULL;
+	struct strbuf todo_buf = STRBUF_INIT;
+	size_t i;
+	int ret, tip_count = 0;
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array refs = { 0 };
+
+	repo_init_revisions(repo, &revs, NULL);
+	subject_data.edit_message = edit_message;
+	revs.reverse = 1;
+	revs.topo_order = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.simplify_history = 0;
+	revs.ancestry_path = 1;
+	revs.limited = 1;
+	revs.ancestry_path_implicit_bottoms = 1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
+		goto out;
+	}
+
+	if (revs.reverse != 1 || revs.topo_order != 1 ||
+	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
+	    revs.simplify_history != 0 || revs.boundary == 1 ||
+	    revs.ancestry_path != 1 || revs.limited != 1 ||
+	    revs.ancestry_path_implicit_bottoms != 1) {
+		warning(_("ignoring rev-list options that would change how the "
+			  "range is walked"));
+		revs.reverse = 1;
+		revs.topo_order = 1;
+		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+		revs.simplify_history = 0;
+		revs.boundary = 0;
+		revs.ancestry_path = 1;
+		revs.limited = 1;
+		revs.ancestry_path_implicit_bottoms = 1;
+	}
+
+	/*
+	 * A squash needs a base to reparent onto, so the range has to exclude
+	 * something, as in "<base>..<tip>". A revision range with no such
+	 * bottom commit cannot be squashed.
+	 */
+	for (i = 0; i < revs.cmdline.nr; i++)
+		if (revs.cmdline.rev[i].flags & BOTTOM)
+			break;
+	if (i == revs.cmdline.nr) {
+		ret = error(_("not a '<base>..<tip>' revision range"));
+		goto out;
+	}
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *p;
+
+		if (edit_message)
+			strbuf_addf(&todo_buf, "pick %s\n",
+				    oid_to_hex(&commit->object.oid));
+
+		if (!commit->parents) {
+			ret = error(_("cannot squash down to root commit"));
+			goto out;
+		}
+		for (p = commit->parents; oldest && p; p = p->next) {
+			struct commit_list *q;
+			struct object *o;
+			bool seen;
+
+			if (repo_parse_commit(repo, p->item)) {
+				ret = error(_("cannot parse commit"));
+				goto out;
+			}
+			o = &p->item->object;
+			seen = o->flags & SQUASH_SEEN;
+			/*
+			 * Allow parents that match the parents of the
+			 * squashed commit.
+			 */
+			for (q = oldest->parents; !seen && q; q = q->next) {
+				if (p->item == q->item) {
+					seen = true;
+					commit_list_insert(commit, &filter.with_commit);
+				}
+			}
+			if (!seen) {
+				ret = error(_("parent %s of commit %s is "
+					      "outside the revision range"),
+					    repo_find_unique_abbrev(repo, &o->oid,
+								    DEFAULT_ABBREV),
+					    repo_find_unique_abbrev(repo, &commit->object.oid,
+								    DEFAULT_ABBREV));
+				goto out;
+			}
+			if (o->flags & SQUASH_TIP) {
+				tip_count--;
+				o->flags &= ~SQUASH_TIP;
+			}
+		}
+		if (!oldest) {
+			commit_list_insert(commit, &filter.with_commit);
+			oldest = commit;
+		}
+		if (squash_check_subject(repo, commit, &subject_data)) {
+			ret = -1;
+			goto out;
+		}
+		tip = commit;
+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
+		tip_count++;
+	}
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP | SQUASH_AMEND_TARGET);
+	reset_revision_walk();
+	if (!tip_count) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	} else if (tip_count != 1) {
+		  ret = error(_("the revision range contains more than one tip "
+				"commit"));
+		  goto out;
+	  } else if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	} else if (!oldest->parents) {
+		BUG("an in-range commit must have a parent");
+	}
+	commit_list_insert(tip, &filter.no_commit);
+	filter.kind = FILTER_REFS_BRANCHES;
+	if (update_branches &&
+	    filter_refs(&refs, &filter, filter.kind)) {
+		ret = error(_("could not filter refs"));
+		goto out;
+	}
+	if (refs.nr) {
+		/*
+		 * TODO: list the branches and also check HEADS from other worktrees
+		 */
+		ret = error(_("a branch points to a commit that is being squashed"));
+		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+				  _("Use --update-refs=head to rewrite only "
+				    "the current branch and leave such refs "
+				    "untouched."));
+		goto out;
+	}
+	if (edit_message) {
+		strbuf_reset(&subject_data.squash_message);
+		ret = build_squash_message(repo, &todo_buf,
+					   &subject_data.squash_message);
+		if (ret < 0)
+			goto out;
+	}
+	*oldest_out = oldest;
+	*tip_out = tip;
+	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
+	ret = 0;
+
+out:
+	strbuf_release(&todo_buf);
+	subject_data_clear(&subject_data);
+	release_revisions(&revs);
+	ref_filter_clear(&filter);
+	ref_array_clear(&refs);
+	return ret;
+}
+
+static bool amend_replaces_target(struct todo_list *todo, int target)
+{
+	int i;
+
+	for (i = target + 1; i < todo->nr &&
+			     todo->items[i].command != TODO_PICK; i++) {
+		if (todo->items[i].command == TODO_SQUASH)
+			return false;
+		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
+			return true;
+	}
+	return false;
+}
+
+static int build_squash_message(struct repository *repo,
+				const struct strbuf *todo_buf,
+				struct strbuf *out)
+{
+	struct todo_list todo = TODO_LIST_INIT;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int i, nr_commits, ret;
+
+	if (todo_list_parse_insn_buffer(repo, &opts, todo_buf->buf, &todo) < 0 ||
+	    todo_list_rearrange_squash(&todo) < 0) {
+		ret = error(_("could not prepare the squash message"));
+		goto out;
+	}
+
+	nr_commits = todo.nr;
+	for (i = 0; i < nr_commits; i++) {
+		struct todo_item *item = &todo.items[i];
+		const char *message, *body;
+		size_t commented_len;
+		bool skip, squashing;
+
+		squashing = item->command == TODO_SQUASH ||
+			    (item->flags & TODO_REPLACE_FIXUP_MSG);
+		if (item->command == TODO_PICK)
+			skip = amend_replaces_target(&todo, i);
+		else
+			skip = !squashing;
+
+		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
+		find_commit_subject(message, &body);
+
+		if (skip)
+			commented_len = strlen(body);
+		else if (squashing)
+			commented_len = squash_subject_comment_len(body, 1);
+		else
+			commented_len = 0;
+
+		if (!i)
+			add_squash_combination_header(out, nr_commits);
+		strbuf_addch(out, '\n');
+		add_squash_message_header(out, i + 1, skip);
+		strbuf_addstr(out, "\n\n");
+		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
+		strbuf_addstr(out, body + commented_len);
+		strbuf_complete_line(out);
+
+		repo_unuse_commit_buffer(repo, item->commit, message);
+	}
+
+	ret = 0;
+
+out:
+	todo_list_release(&todo);
+	replay_opts_release(&opts);
+	return ret;
+}
+
+static int cmd_history_squash(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SQUASH_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	int edit = 1;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BOOL('e', "edit", &edit,
+			 N_("edit the commit message")),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *oldest, *tip, *rewritten;
+	const struct object_id *base_tree_oid, *tip_tree_oid;
+	char *message_template = NULL;
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+	if (argc < 2) {
+		ret = error(_("command expects a revision range"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	strbuf_addstr(&reflog_msg, "squash: updating ");
+	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
+
+	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
+				   edit,
+				   argc, argv, &oldest, &tip,
+				   &message_template);
+	if (ret < 0)
+		goto out;
+
+	ret = setup_revwalk(repo, action, tip, &revs);
+	if (ret < 0)
+		goto out;
+
+	base_tree_oid = &repo_get_commit_tree(repo,
+					oldest->parents->item)->object.oid;
+	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
+
+	ret = commit_tree_ext(repo, "squash", oldest, message_template,
+			      oldest->parents, base_tree_oid, tip_tree_oid,
+			      &rewritten,
+			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
+	if (ret < 0) {
+		ret = error(_("failed writing squashed commit"));
+		goto out;
+	}
+
+	ret = handle_reference_updates(&revs, action, tip, rewritten,
+				       reflog_msg.buf, dry_run,
+				       REPLAY_EMPTY_COMMIT_ABORT);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
+	free(message_template);
+	return ret;
+}
+
 static int update_worktree(struct repository *repo,
 			   const struct commit *old_head,
 			   const struct commit *new_head,
@@ -1192,6 +1801,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1200,6 +1810,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/object.h b/object.h
index 8fb03ff90a..46cade33fb 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
+ * builtin/history.c:                    11---13
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..78b8ea54ad 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -406,6 +406,7 @@ integration_tests = [
   't3452-history-split.sh',
   't3453-history-fixup.sh',
   't3454-history-drop.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..8638d56dd6
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,884 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+stage_file () {
+	printf "%s\n" "$1" >file &&
+	git add file
+}
+
+commit_with_message () {
+	printf "%b" "$1" >msg &&
+	git commit --allow-empty -qF msg
+}
+
+check_commit_count () {
+	git rev-list --count "$1" >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+check_log_subjects () {
+	git log --format="%s" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+check_log_messages () {
+	git log --format="%B" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+# Checks that the author data of two commits matches
+# Usage: check_commit_author <rev1> <rev2>
+check_commit_author () {
+	git show -s --format="%an <%ae> %ad" "$1" >expect &&
+	git show -s --format="%an <%ae> %ad" "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup linear history touching two files' '
+	test_commit base file a start &&
+	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
+		test_commit one other x &&
+	GIT_AUTHOR_NAME=Two GIT_AUTHOR_EMAIL=two@example.com \
+		test_commit two file c &&
+	GIT_AUTHOR_NAME=Three GIT_AUTHOR_EMAIL=three@example.com \
+		test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "expects a revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the revision range is empty" err
+'
+
+test_expect_success 'errors on a single revision that is not a range' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "not a .*range" err &&
+	test_must_fail git history squash HEAD~1 2>err &&
+	test_grep "not a .*range" err
+'
+
+test_expect_success 'errors on a range holding a single commit' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "HEAD^!" 2>err &&
+	test_grep "single commit; nothing to squash" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'rejects root commit' '
+	# create a disconnected root commit
+	oid=$(git commit-tree -m root three^{tree}) &&
+	# because we pass --ancestry-path when calling setup_revs() it the
+	# revision walk will only include commits decended from $oid so
+	# we need to give it another --ancestry-path commit to actually walk
+	# any commits.
+	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
+	echo "error: cannot squash down to root commit" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'rejects multiple tips' '
+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
+	test_must_fail git history squash ^start $oid three~1 2>err &&
+	echo "error: the revision range contains more than one tip commit" >expect &&
+	test_cmp expect err &&
+
+	git reset --hard three &&
+	git history squash --no-edit ^start three~1 three &&
+	test_cmp_rev HEAD~1 start^0 &&
+	test_cmp_rev HEAD^{tree} three^{tree}
+'
+
+test_expect_success 'accepts multiple revision arguments with an exclusion' '
+	git reset --hard three &&
+	git branch -f keep HEAD~2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start..HEAD ^keep &&
+
+	git reflog -1 --format=%gs >actual &&
+	echo "squash: updating start..HEAD ^keep" >expect &&
+	test_cmp expect actual &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	two
+	one
+	EOF
+	test_cmp_rev keep HEAD~1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git branch -D keep
+'
+
+test_expect_success 'squashes a branch the current branch is not on' '
+	git reset --hard three &&
+	main=$(git symbolic-ref --short HEAD) &&
+	head_before=$(git rev-parse HEAD) &&
+	git checkout -b off-history start &&
+	test_commit --no-tag off-one off a &&
+	test_commit --no-tag off-two off b &&
+	git checkout "$main" &&
+
+	git history squash --no-edit start..off-history &&
+
+	check_commit_count start..off-history 1 &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D off-history
+'
+
+test_expect_success 'squashes a range into a single commit without changing the tree' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit --dry-run start.. >out &&
+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash --no-edit start.. &&
+
+	test "$predicted" = "$(git rev-parse HEAD)" &&
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	check_log_subjects -1 <<-\EOF &&
+	one
+	EOF
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'sanitizes rev-list walk options, before and after --' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit --date-order start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git reset --hard three &&
+	git history squash --no-edit -- --reverse start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start..@~1 &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	three
+	one
+	EOF
+
+	test_cmp_rev start HEAD~2 &&
+	test "$final_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes when the base is the root commit' '
+	git reset --hard three &&
+	root=$(git rev-list --max-parents=0 HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit "$root.." &&
+
+	check_commit_count "$root..HEAD" 1 &&
+	test_cmp_rev "$root" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashing a mix of fixups' '
+	git reset --hard three &&
+	echo fix >file &&
+	git commit --fixup=two -a &&
+	echo really fix >file &&
+	git commit --fixup=one -a &&
+	echo really really fix >file &&
+	git commit --fixup=HEAD~1 -a && # fixup! two
+	echo really really really fix >file &&
+	git commit --fixup=HEAD~1 -a && # fixup! one
+
+	# squashing fixup! with a target that is not being squashed fails
+	test_must_fail git history squash one.. 2>err &&
+	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
+
+	# squashing fixup! into fixup! with a different target fails
+	test_must_fail git history squash HEAD~4.. 2>err && # HEAD~4 is fixup! two
+	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
+
+	# squashing a sequence of fixup! commits into their targets
+	git history squash --no-edit start..HEAD~1 &&
+	test_cmp_rev start HEAD~2 &&
+	check_commit_author one HEAD~1 &&
+	test_commit_message HEAD~1 -m one &&
+
+	# squashing "fixup! fixup! <target>" into "<target>"
+	git history squash --no-edit start.. &&
+	test_cmp_rev start HEAD~1 &&
+	check_commit_author one HEAD &&
+	test_commit_message HEAD -m one
+'
+
+test_expect_success 'squashing "squash!" messages' '
+	git reset --hard two &&
+	echo fix >file &&
+	git commit --fixup=HEAD -a &&
+	oldest=$(git rev-parse HEAD) &&
+	echo better fix >file &&
+	git commit -a -F - <<-EOF &&
+	squash! $(git rev-parse two)
+
+	Append this
+	EOF
+
+	echo an even better fix >file &&
+	git commit -a -F - <<-EOF &&
+	squash! squash! two
+
+	Append this as well
+	EOF
+
+	# must edit when squashing "squash!" into its target
+	test_must_fail git history squash --no-edit two^.. 2>err &&
+	test_grep "^error: squashing .* (squash! [a-f0-9]*) would discard its message" err &&
+
+	# squashing "squash!" into "fixup!" appends messages and changes
+	# subject prefix
+	git history squash --no-edit two.. &&
+	test_cmp_rev HEAD^ two &&
+	test_commit_message HEAD <<-\EOF &&
+	squash! two
+
+	Append this
+
+	Append this as well
+	EOF
+	check_commit_author "$oldest" HEAD &&
+
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! two
+
+	A new message
+	EOF
+
+	# "amend!" does not replace "squash!"
+	test_must_fail git history squash --no-edit HEAD~2.. 2>err &&
+	test_grep "^error: squashing .* (amend! two) would overwrite .squash!. message" err
+'
+
+test_expect_success '--no-edit uses last "amend!" message without an editor' '
+	git reset --hard three &&
+	write_script editor <<-\EOF &&
+	exit 1
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	echo fix >file &&
+	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
+	git commit --allow-empty -F - <<-EOF &&
+	amend! $(git rev-parse --short HEAD)
+
+	The first reword
+
+	More detail
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! three
+
+	The second reword
+
+	Extra detail
+	EOF
+
+	test_commit WIP &&
+
+	cat >msg <<-EOF &&
+	amend! $(git rev-parse HEAD^ | tr a-f A-F)
+
+	The third reword
+
+	Excruciating detail
+	EOF
+
+	git commit --author="Someone Else <s.else@example.com>" --allow-empty \
+		-F msg &&
+
+	# squashing amend! updates the commit message
+	git history squash --no-edit three^.. &&
+	sed -e 1,2d msg | test_commit_message HEAD &&
+	check_commit_author three HEAD &&
+	test_cmp_rev HEAD^ three^ &&
+
+	# squashing amend! into fixup! updates subject prefix
+	git reset --hard HEAD@{1} &&
+	git history squash --no-edit three.. &&
+	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
+	check_commit_author HEAD@{1}~4 HEAD &&
+	test_cmp_rev HEAD^ three &&
+
+	# squashing amend! into amend! keeps original subject line
+	git reset --hard HEAD@{1} &&
+	git history squash --no-edit HEAD~3.. &&
+	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
+	test_cmp_rev HEAD~3 three &&
+
+	# all amend! messages must target the first commit
+	git reset --hard HEAD@{1} &&
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! WIP
+
+	The real message
+	EOF
+
+	test_must_fail git history squash --no-edit HEAD~4.. 2>err &&
+	test_grep "^error: cannot squash .* that does not target" err &&
+
+	# amend! message that targets commit that is not in range is rejected
+	test_must_fail git history squash --no-edit HEAD~3.. 2>err &&
+	test_grep "^error: cannot squash .* target is not being squashed" err &&
+	test_set_editor :
+'
+
+test_expect_success 'squashing fixups into a merge' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f start &&
+	test_commit F1 &&
+	git checkout -b feature start &&
+	test_commit F2 &&
+	git merge F1 &&
+	echo fixed >F1.t &&
+	cat >msg <<-EOF &&
+	amend! $(git rev-parse HEAD)
+
+	merge F1 and F2
+
+	reworded
+	EOF
+
+	git commit -a -F msg &&
+	git history squash --no-edit HEAD^^! HEAD &&
+	test_cmp_rev HEAD^1 F2 &&
+	test_cmp_rev HEAD^2 F1 &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	sed 1,2d msg | test_commit_message HEAD
+'
+
+test_expect_success 'edits every message and aborts on an empty result' '
+	git reset --hard start &&
+	stage_file b &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script empty-editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/empty-editor" &&
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "Aborting commit due to empty commit message" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# This is the 1st commit message:
+
+	re-one subject
+
+	re-one body line
+
+	# This is the commit message #2:
+
+	re-two
+
+	# This is the commit message #3:
+
+	re-three
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_subjects -1 <<-\EOF
+	combined
+	EOF
+'
+
+test_expect_success 'handles fixup!, squash! and amend! like rebase' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+	stage_file e &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	mark-base
+
+	# The commit message #2 will be skipped:
+
+	# fixup! mark-base
+	#
+	# fixup body
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# This is the commit message #4:
+
+	# amend! mark-base
+
+	amended message
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	mark-base
+
+	squash remark
+
+	amended message
+
+	EOF
+'
+
+test_expect_success 'groups fixups under their targets in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag alpha file a1 &&
+	test_commit --no-tag beta file b1 &&
+	stage_file a2 &&
+	commit_with_message "fixup! alpha\n" &&
+	stage_file b2 &&
+	commit_with_message "fixup! beta\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	alpha
+
+	# The commit message #2 will be skipped:
+
+	# fixup! alpha
+
+	# This is the commit message #3:
+
+	beta
+
+	# The commit message #4 will be skipped:
+
+	# fixup! beta
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited
+'
+
+test_expect_success 'lets amend! replace its target message in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# The 1st commit message will be skipped:
+
+	# mark-base
+
+	# This is the commit message #2:
+
+	# amend! mark-base
+
+	amended message
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	amended message
+
+	squash remark
+
+	EOF
+'
+
+test_expect_success '--update-refs=head only moves HEAD' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	other_before=$(git rev-parse other) &&
+
+	git history squash --no-edit --update-refs=head start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev "$other_before" other
+'
+
+test_expect_success 'refuses to fold a range a branch points into' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f -b feature start &&
+	test_commit C1 &&
+	test_commit C2 &&
+	git checkout -b topic-1 start &&
+	test_commit C3 &&
+	test_commit C4 &&
+	git checkout C3 &&
+	test_commit C5 &&
+	git checkout feature &&
+	git merge C5 &&
+	test_commit C6 &&
+	git checkout -b topic-2 C2 &&
+	test_commit C7 &&
+	git checkout feature &&
+
+	test_must_fail git history squash start.. 2>err &&
+	# TODO: check the branch names when we print them (topic-1 & topic-2)
+	test_grep "^error: a branch points to" err &&
+	test_grep "^hint: .* --update-refs=head" err &&
+	test_cmp_rev C6 HEAD &&
+
+	# squash succeeds with --update-refs=head
+	git history squash --no-edit --update-refs=head start.. &&
+	test_cmp_rev start HEAD^ &&
+	test_cmp_rev C6^{tree} HEAD^{tree} &&
+	test_cmp_rev C6 HEAD@{1}
+'
+
+test_expect_success 'advice.historyUpdateRefs silences the hint' '
+	git reset --hard three &&
+	git branch -f mid HEAD~1 &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git -c advice.historyUpdateRefs=false \
+		history squash start.. 2>err &&
+	test_grep "^error: a branch points to" err &&
+	test_grep ! "hint:" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D mid
+'
+
+test_expect_success 'leaves tags and remote-tracking refs unchanged' '
+	git reset --hard three &&
+	git tag -f mark HEAD~1 &&
+	git update-ref refs/remotes/origin/mark HEAD~1 &&
+	mark_before=$(git rev-parse mark) &&
+
+	git history squash --no-edit start.. &&
+
+	test_cmp_rev "$mark_before" mark &&
+	test_cmp_rev "$mark_before" refs/remotes/origin/mark &&
+
+	git tag -d mark &&
+	git update-ref -d refs/remotes/origin/mark
+'
+
+test_expect_success 'squashes a range whose internal merge has a single base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag before-side file b &&
+	git checkout -b inner-side &&
+	test_commit --no-tag on-inner-side inner x &&
+	git checkout "$main" &&
+	test_commit --no-tag after-side file c &&
+	git merge --no-ff -m merge inner-side &&
+	git branch -D inner-side &&
+	test_commit --no-tag after-merge file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF &&
+	before-side
+	EOF
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a merge of a branch that forked at the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b base-fork-side &&
+	test_commit --no-tag base-fork-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag base-fork-main file b &&
+	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
+	git branch -D base-fork-side &&
+	test_commit --no-tag base-fork-tail file c &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'refuses a merge whose other parent is outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+	merged=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'folds a range whose tip is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag tipmerge-base file b &&
+	git checkout -b tipmerge-side &&
+	test_commit --no-tag tipmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag tipmerge-main file c &&
+	git merge --no-ff -m "merge tipmerge-side" tipmerge-side &&
+	git branch -D tipmerge-side &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'folds a range whose base is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b basemerge-side &&
+	test_commit --no-tag basemerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag basemerge-main file b &&
+	git merge --no-ff -m "merge basemerge-side" basemerge-side &&
+	git branch -D basemerge-side &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag basemerge-one file c &&
+	test_commit --no-tag basemerge-two file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit "$base.." &&
+
+	check_commit_count "$base..HEAD" 1 &&
+	test_cmp_rev "$base" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'folds a range with two interior merges' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag two-merge-a file a1 &&
+	git checkout -b two-merge-s1 &&
+	test_commit --no-tag two-merge-s1 s1 x &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s1" two-merge-s1 &&
+	test_commit --no-tag two-merge-b file b1 &&
+	git checkout -b two-merge-s2 &&
+	test_commit --no-tag two-merge-s2 s2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s2" two-merge-s2 &&
+	git branch -D two-merge-s1 two-merge-s2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file s1 &&
+	test_path_is_file s2
+'
+
+test_expect_success 'folds a range with a nested merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b nested-outer &&
+	test_commit --no-tag nested-outer outer x &&
+	git checkout -b nested-inner &&
+	test_commit --no-tag nested-inner inner y &&
+	git checkout nested-outer &&
+	git merge --no-ff -m "merge inner" nested-inner &&
+	git checkout "$main" &&
+	test_commit --no-tag nested-main file b1 &&
+	git merge --no-ff -m "merge outer" nested-outer &&
+	git branch -D nested-outer nested-inner &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file outer &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a range with an octopus merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag octo-base file a1 &&
+	git checkout -b octo-1 &&
+	test_commit --no-tag octo-1 o1 x &&
+	git checkout "$main" &&
+	git checkout -b octo-2 &&
+	test_commit --no-tag octo-2 o2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-1 octo-2 &&
+	git branch -D octo-1 octo-2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file o1 &&
+	test_path_is_file o2
+'
+
+test_expect_success 'refuses an octopus merge with an arm forked before the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b octo-pre &&
+	test_commit octo-pre-side pside x &&
+	git checkout "$main" &&
+	test_commit octo-pre-main file b1 &&
+	octo_base=$(git rev-parse HEAD) &&
+	git checkout -b octo-within &&
+	test_commit --no-tag octo-within wside y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-pre octo-within &&
+	merged=$(git rev-parse HEAD) &&
+	git branch -D octo-pre octo-within &&
+
+	test_must_fail git history squash "$octo_base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'refuses when a descendant above the range is a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag desc-one file b &&
+	test_commit --no-tag desc-two file c &&
+	git tag desc-tip &&
+	git checkout -b desc-above &&
+	test_commit --no-tag desc-above above x &&
+	git checkout "$main" &&
+	test_commit --no-tag desc-main file d &&
+	git merge --no-ff -m "merge desc-above" desc-above &&
+	git branch -D desc-above &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash --no-edit start..desc-tip 2>err &&
+	test_grep "merge commits is not supported" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'refuses to fold a range a ref points into at a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag refmerge-base file b &&
+	git checkout -b refmerge-side &&
+	test_commit --no-tag refmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag refmerge-main file c &&
+	git merge --no-ff -m "interior merge" refmerge-side &&
+	git branch -D refmerge-side &&
+	git branch at-merge HEAD &&
+	test_commit --no-tag refmerge-tail file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	# TODO: test for branch nome "at-merge"
+	test_grep "a branch points to a commit" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D at-merge
+'
+
+test_done
-- 
gitgitgadget
