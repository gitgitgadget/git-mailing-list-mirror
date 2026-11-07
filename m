Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052549;
	b=GSrUQlx+EyAmB1XKZaONLMIxzjSkMW5VI+tSdBN3W0fE4cZXWyHPdNYa6YwFNgq8NE8P
	 RE+iZbv7rommc77Hw8q/DV9UMmjjvTzuNx8omLBfw0RnJS5UZ7DaPvsz2k3zNLpHKjY/P
	 NIFUHvu1pSUu9mCNbh2wTdiyTlJZYNcuS27FdlcOmm88/RZ/lvfdz16hJH4dBXqLI28jf
	 T7B+PET/We53WyhCX7JdXP64JOh4x/QvuIDWL0c3euMm4QSyvbagaN9Tew9jSCKd4MHp4
	 ypxsdUYSGjY9JZsksB4mgKVexQHo5EAzWezBGekRvA8G9Qr6PHu1c8PEChh5WGlxzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=3tZ/uEfjWLwHbNf4/fK9A+bq3Lm7qF8ppHvbBVUDsXw=;
	b=J96Ta+mb3MAqx4+X+qYWdNqfEVvNxtVS6vhJaAYSfRDCBtf3ORD/9hebw+sMSCUU6G3v
	 OzekkHdzsAq0oNA9AUz0AQeuwr4YdNTabbesNJ96z1Ai7PGzq+YXt1XaptvdLkqz0hJgF
	 9p+9mK0I+CIg4PaZZc3buNle1+Y+24J1e8WreTci+6jR6OosGL5+fHsOkHUQGS2SyCCA5
	 HG6DH4QiDicoFBG/QOWbY2btb8gyOTWrLi1mHV+KuF0fHH2NFLkO5+ie7idL7JEwmmG7K
	 amxj9/hZyaRiYa8zmZRHHe8FlY4ZlTkToAYgFZBpqWJvrQiecSVqCq8vRijgINTKJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYqLx61O;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6A606A32D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 11:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A6A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYqLx61O
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-833e671ee9fso1635023a34.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794052547; x=1794657347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3tZ/uEfjWLwHbNf4/fK9A+bq3Lm7qF8ppHvbBVUDsXw=;
        b=eYqLx61OklJFVNqroC76v81/E38lNsA2fU+D69LfjeRKeuuZoURfGUb5sGRrIbBkkM
         3tdrMq9NO8nIk5c92hC9uVorJh2oDHMAVy3U+JiI6ttjU1K+kMcMAat0glZ4sXRrlrC1
         6xDcHc8xRfRcke5NorXNIhxRPfUVgLYuR4TSA0eFd4uXQgp7vXhbzpjdqyYDhFsBe9DW
         rvkCgwCLLTc04aUH6qOCYe0XdE57oOzEJ2i7W0gTBQGdL6q7fa9O5gOBPvlMo4zbBirW
         SvW5yR/fqWYPK52LtgFyDSShu9lYLHQDpe0PyjyeFvcBXr25JENYZL/X9qZkt6/EBlJv
         amIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794052547; x=1794657347;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tZ/uEfjWLwHbNf4/fK9A+bq3Lm7qF8ppHvbBVUDsXw=;
        b=A7EGO8ac5XmItL79tHBCjXs5nM3zQpOtov2fB4LolUze8qAt6feImIKAod/jBvLknB
         34ErvqT7B4eSaErsMZkP0wcPe4DmwDDEzx1WAGdUxmMGf3Q6+XkylTmmnA9qL3mFBmM9
         9HLzab7uyfdCNimySwSUAay0iYlYPh+xMiWBKDyntAVi3NrNulMOeg4YGE7/gJopTVL2
         4OH+u2QtMOpTrklIUEwpyb9yrfOUxiJaoqizOS+GkBKQKCAse/rT7a+8bJKo+G1pnS5V
         twkC8OdGCNMXN93H4h2r7Xqc2qVHrh6at+Wdtcmae9d8TZCwid40CeFRdouX1E9CrKY0
         UBxw==
X-Gm-Message-State: APuU4Z+q3mVyV8Vnju4FTUptr6c/HG2lTXoox/H3MB+KtnpfO+Y04wwF
	l+BVe7mX9X2q102c3GuuFsAhk2PXXnLFr7CsIx5btDBUxGEc1FQu0B3utcmf1Q==
X-Gm-Gg: AYBFou1QilyQhb0O+IJKzLPpWZAt7PvtKx2rMH4qz/TxkHEOM4V1rE/HmZriOh6i2mx
	FzFqDxHu9k2y8B/CVuf9POUwUwBr95/3+LMdp9sxkiJSlKiCkQK8Qsu6eEoDr4P6gaFAuLnLOfY
	VZC0oxnwFYIhXl0BdB9SeVvMhx8E1qIph9my2ppjC0RX/uuyt1ICa6x+uf1SrMHGukF9Uo20N57
	hrHeYEopXlevD/l0UTvqLm5Jjct4wj7JocOS74FC46EHQp/iJ9unnPiMPt4YFDN16kKl8gjAYmS
	D7fJ8aWhUXZ6c4J4W4Oi7NpAQwb1vr3v04Zm9D2OMR2ET+st/fLJ4RjobWntAGpodAuGoU6kapF
	1Xm5BJmhWgUzbiENzABx5DcrVjQGTAHUb1/mt+GsQE70CaQwmLLId23OqJTUfb/4juYzMgAnrpL
	u3B8DJ7BSMtjtQ9e5NiFcCJ6jJf8VdshrWvj5/5I+RgHt5zjgZMUi3qEjBlmwgqwn4aulkbU0jG
	o3YE6mhd1zwoAMJ8X/OUb4z1j+kgXTkGObqyyE4EZaoz1aA6ENIaZZ5kgVjh6y72wJHKaYSexyY
	dwnoiTxP5rvNNLZOyhfzvWqlfWCke6JI
X-Received: by 2002:a05:6808:c3c2:b0:4ea:686e:fe86 with SMTP id 5614622812f47-567e14912f9mr3784243b6e.63.1794052547273;
        Sat, 07 Nov 2026 03:55:47 -0800 (PST)
Received: from [127.0.0.1] ([13.86.110.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7ddc155sm3719480b6e.7.2026.11.07.03.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:55:45 -0800 (PST)
Message-Id: <34bb9309088b2ff9252d22456b504c3e20b63bef.1794052536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v5.git.git.1794052536.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v5.git.git.1794052536.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 11:55:36 +0000
Subject: [PATCH v5 2/2] pretty: add %gb to name the branch of each reflog
 entry
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The reflog of HEAD records the work done on every branch, so the
output of "git reflog" mixes them and does not say which entry was
made on which branch. Working that out by hand means looking back for
the branch switch before each entry, and a rebase can move HEAD to
another branch without writing one, as "git rebase <upstream>
<branch>" does.

Add a "%gb" placeholder that names the branch HEAD was on when each
entry was recorded:

    $ git log -g --format='%h %gd: (%gb) %gs'
    9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
    9c8d7e6 HEAD@{1}: (topic) rebase (pick): add tests
    1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
    1a2b3c4 HEAD@{3}: (main) commit: fix typo
    5d6e7f8 HEAD@{4}: (main) checkout: moving from topic to main

The branch is read from the entries created by branch switches,
branch renames and rebases. The entries of a rebase are labeled with
the branch being rebased. When HEAD was detached, the entry shows
"detached at <commit>" with the commit HEAD was detached at, or for a
rebase of a detached HEAD the commit the rebase ended on. These
entries only record what was typed, so when no newer entry says
otherwise, a name counts as a branch if a branch of that name exists.
When nothing older in the reflog says which branch a rebase started
on, the rebase is taken to have started on the branch it rebased. For
the reflog of any other ref, "%gb" is the name of that ref.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/pretty-formats.adoc |   3 +
 pretty.c                          |   4 +
 reflog-walk.c                     | 217 +++++++++++++++++++++++++++-
 reflog-walk.h                     |   2 +
 t/t1414-reflog-walk.sh            | 229 ++++++++++++++++++++++++++++++
 5 files changed, 449 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2ae0eb11a9..a8d00397c4 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -334,6 +334,9 @@ endif::git-rev-list[]
 +%gE+:: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 +%gs+:: reflog subject
++%gb+:: reflog branch, the branch `HEAD` was on when the entry was
+	recorded, e.g., `topic` or `detached at 1a2b3c4`. For the reflog
+	of any other ref, this is the shortened refname.
 ++%(trailers++`[:<option>,...]`++)++::
 display the trailers of the body as interpreted by
 linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
diff --git a/pretty.c b/pretty.c
index d8a9f370f6..1b3f7e2dc3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1637,6 +1637,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_message(sb, c->pretty_ctx->reflog_info);
 			return 2;
+		case 'b':	/* reflog branch */
+			if (c->pretty_ctx->reflog_info)
+				get_reflog_branch(sb, c->pretty_ctx->reflog_info);
+			return 2;
 		case 'n':
 		case 'N':
 		case 'e':
diff --git a/reflog-walk.c b/reflog-walk.c
index 4dbeaa93a7..2372823e9d 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -3,7 +3,10 @@
 #include "git-compat-util.h"
 #include "commit.h"
 #include "refs.h"
+#include "reflog.h"
 #include "diff.h"
+#include "hex.h"
+#include "object-name.h"
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
@@ -18,8 +21,10 @@ struct complete_reflogs {
 		timestamp_t timestamp;
 		int tz;
 		char *message;
+		char *branch;
 	} *items;
 	int nr, alloc;
+	bool branches_marked;
 };
 
 static int read_one_reflog(const char *refname UNUSED,
@@ -38,6 +43,7 @@ static int read_one_reflog(const char *refname UNUSED,
 	item->timestamp = timestamp;
 	item->tz = tz;
 	item->message = xstrdup(message);
+	item->branch = NULL;
 	array->nr++;
 	return 0;
 }
@@ -52,6 +58,7 @@ static void free_complete_reflog(struct complete_reflogs *array)
 	for (i = 0; i < array->nr; i++) {
 		free(array->items[i].email);
 		free(array->items[i].message);
+		free(array->items[i].branch);
 	}
 	free(array->items);
 	free(array->ref);
@@ -65,6 +72,174 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
 	free_complete_reflog(array);
 }
 
+static const char *skip_rebase_step(const char *message, const char *step)
+{
+	const char *p = strstr(message, " (");
+	const char *colon = strstr(message, ": ");
+
+	if (!p || (colon && colon < p) ||
+	    !skip_prefix(p + 2, step, &p) || !skip_prefix(p, "): ", &p))
+		return NULL;
+	return p;
+}
+
+static bool is_commit_subject(const char *text, const struct object_id *oid)
+{
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
+	const char *buffer, *subject;
+	size_t len;
+	bool ret;
+
+	if (!commit)
+		return false;
+	buffer = repo_get_commit_buffer(the_repository, commit, NULL);
+	len = find_commit_subject(buffer, &subject);
+	ret = strcspn(text, "\n") == len && !memcmp(text, subject, len);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
+	return ret;
+}
+
+static const char *skip_rebase_checkout(const struct reflog_info *item)
+{
+	const char *colon = strstr(item->message, ": ");
+	const char *rev;
+
+	if (!colon || !skip_prefix(colon + 2, REFLOG_CHECKOUT, &rev) ||
+	    is_commit_subject(colon + 2, &item->noid))
+		return NULL;
+	return rev;
+}
+
+static const char *existing_branch(const char *name)
+{
+	char *ref = xstrfmt("refs/heads/%.*s", (int)strcspn(name, "\n"), name);
+	bool exists = refs_ref_exists(get_main_ref_store(the_repository), ref);
+
+	free(ref);
+	return exists ? name : NULL;
+}
+
+struct branch_move {
+	const char *from, *to;
+	size_t from_len, to_len;
+	bool from_detached;
+};
+
+static bool parse_branch_move(const struct reflog_info *item,
+			      struct branch_move *move)
+{
+	const char *message = item->message;
+	const char *from, *to, *end;
+	struct object_id oid;
+
+	memset(move, 0, sizeof(*move));
+	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &from)) {
+		to = strstr(from, " to ");
+		if (!to)
+			return false;
+		if (!parse_oid_hex(from, &oid, &end) && end == to) {
+			move->from_detached = true;
+		} else {
+			move->from = from;
+			move->from_len = to - from;
+		}
+		move->to = existing_branch(to + strlen(" to "));
+	} else if (skip_prefix(message, REFLOG_RENAME_PREFIX "refs/heads/",
+			       &from)) {
+		to = strstr(from, " to refs/heads/");
+		if (!to)
+			return false;
+		move->from = from;
+		move->from_len = to - from;
+		move->to = to + strlen(" to refs/heads/");
+	} else if (((to = skip_rebase_step(message, REFLOG_STEP_FINISH)) ||
+		    (to = skip_rebase_step(message, REFLOG_STEP_ABORT))) &&
+		   skip_prefix(to, REFLOG_RETURNING_TO "refs/heads/", &to)) {
+		move->from = move->to = to;
+		move->from_len = strcspn(to, "\n");
+	} else if (skip_rebase_step(message, REFLOG_STEP_START)) {
+		return true;
+	} else if ((to = skip_rebase_checkout(item))) {
+		move->to = existing_branch(to);
+	} else {
+		return false;
+	}
+	if (move->to)
+		move->to_len = strcspn(move->to, "\n");
+	return true;
+}
+
+static char *detached_label(const struct complete_reflogs *array,
+			    int i, int end)
+{
+	const struct reflog_info *item = &array->items[i];
+
+	if (skip_rebase_step(item->message, REFLOG_STEP_START)) {
+		size_t len = strstr(item->message, " (") + 2 - item->message;
+
+		for (int j = end - 1; j > i; j--) {
+			const char *message = array->items[j].message;
+
+			if (!strncmp(message, item->message, len) ||
+			    starts_with(message,
+					"rebase: " REFLOG_FAST_FORWARD)) {
+				item = &array->items[j];
+				break;
+			}
+		}
+	}
+	return xstrfmt("detached at %s",
+		       repo_find_unique_abbrev(the_repository, &item->noid,
+					       DEFAULT_ABBREV));
+}
+
+static void mark_branches(struct complete_reflogs *array)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
+	char *branch = NULL;
+	bool detached = false;
+	int unlabeled = array->nr;
+
+	if (head && skip_prefix(head, "refs/heads/", &head))
+		branch = xstrdup(head);
+	else if (head)
+		detached = true;
+
+	for (int i = array->nr - 1; i >= 0; i--) {
+		struct reflog_info *item = &array->items[i];
+		struct branch_move move;
+
+		if (!parse_branch_move(item, &move)) {
+			item->branch = xstrdup_or_null(branch);
+			continue;
+		}
+
+		if (!branch) {
+			branch = move.to && !detached ?
+				xmemdupz(move.to, move.to_len) :
+				detached_label(array, i, unlabeled);
+			for (int j = i + 1; j < unlabeled; j++)
+				array->items[j].branch = xstrdup(branch);
+		}
+		item->branch = branch;
+		branch = move.from ? xmemdupz(move.from, move.from_len) : NULL;
+		detached = move.from_detached;
+		unlabeled = i;
+	}
+
+	if (!branch) {
+		if (detached)
+			branch = detached_label(array, 0, unlabeled);
+		else if (unlabeled < array->nr)
+			branch = xstrdup(array->items[unlabeled].branch);
+		for (int i = 0; branch && i < unlabeled; i++)
+			array->items[i].branch = xstrdup(branch);
+	}
+	free(branch);
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -234,6 +409,16 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	return 0;
 }
 
+static const char *short_ref(struct complete_reflogs *reflogs)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
+	if (!reflogs->short_ref)
+		reflogs->short_ref =
+			refs_shorten_unambiguous_ref(refs, reflogs->ref, 0);
+	return reflogs->short_ref;
+}
+
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
 			 struct date_mode dmode, int force_date,
@@ -247,12 +432,7 @@ void get_reflog_selector(struct strbuf *sb,
 		return;
 
 	if (shorten) {
-		if (!commit_reflog->reflogs->short_ref)
-			commit_reflog->reflogs->short_ref
-				= refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-							       commit_reflog->reflogs->ref,
-							       0);
-		printed_ref = commit_reflog->reflogs->short_ref;
+		printed_ref = short_ref(commit_reflog->reflogs);
 	} else {
 		printed_ref = commit_reflog->reflogs->ref;
 	}
@@ -287,6 +467,31 @@ void get_reflog_message(struct strbuf *sb,
 	strbuf_add(sb, info->message, len);
 }
 
+void get_reflog_branch(struct strbuf *sb,
+		       struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct complete_reflogs *reflogs;
+	const char *branch;
+
+	if (!commit_reflog)
+		return;
+
+	reflogs = commit_reflog->reflogs;
+	if (strcmp(reflogs->ref, "HEAD")) {
+		strbuf_addstr(sb, short_ref(reflogs));
+		return;
+	}
+
+	if (!reflogs->branches_marked) {
+		mark_branches(reflogs);
+		reflogs->branches_marked = true;
+	}
+	branch = reflogs->items[commit_reflog->recno+1].branch;
+	if (branch)
+		strbuf_addstr(sb, branch);
+}
+
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
diff --git a/reflog-walk.h b/reflog-walk.h
index 989583dc55..fc1f344ce6 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -13,6 +13,8 @@ void show_reflog_message(struct reflog_walk_info *info, int,
 			 struct date_mode, int force_date);
 void get_reflog_message(struct strbuf *sb,
 			struct reflog_walk_info *reflog_info);
+void get_reflog_branch(struct strbuf *sb,
+		       struct reflog_walk_info *reflog_info);
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
 void get_reflog_selector(struct strbuf *sb,
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index be6c3f472c..456c84d98d 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -131,6 +131,235 @@ test_expect_success 'walk prefers reflog to ref tip' '
 	test_cmp expect actual
 '
 
+test_expect_success '%gb names the branch HEAD was on' '
+	git init branches &&
+	(
+		cd branches &&
+		test_commit base &&
+		git switch -c topic &&
+		test_commit A &&
+		test_commit B &&
+		git switch main &&
+		test_commit upstream &&
+		git switch topic &&
+		git rebase main &&
+
+		cat >expect <<-\EOF &&
+		(topic) rebase (finish): returning to refs/heads/topic
+		(topic) rebase (pick): B
+		(topic) rebase (pick): A
+		(topic) rebase (start): checkout main
+		(topic) checkout: moving from main to topic
+		(main) commit: upstream
+		(main) checkout: moving from topic to main
+		(topic) commit: B
+		(topic) commit: A
+		(topic) checkout: moving from main to topic
+		(main) commit (initial): base
+		EOF
+		git log -g --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb names the ref of other reflogs' '
+	(
+		cd branches &&
+		echo main >expect &&
+		git log -g -1 --format=%gb main >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb follows "git rebase <upstream> <branch>"' '
+	(
+		cd branches &&
+		git switch main &&
+		test_commit main-change &&
+		git rebase main topic &&
+		git switch main &&
+		git rebase main topic &&
+
+		cat >expect <<-\EOF &&
+		(topic) rebase: checkout topic
+		(main) checkout: moving from topic to main
+		(topic) rebase (finish): returning to refs/heads/topic
+		(topic) rebase (pick): B
+		(topic) rebase (pick): A
+		(topic) rebase (start): checkout main
+		(main) commit: main-change
+		(main) checkout: moving from topic to main
+		EOF
+		git log -g -8 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb follows "git rebase <upstream> <branch>" with GIT_REFLOG_ACTION' '
+	(
+		cd branches &&
+		git switch main &&
+		GIT_REFLOG_ACTION="sync switch" git rebase main topic &&
+
+		cat >expect <<-\EOF &&
+		(topic) sync switch: checkout topic
+		(main) checkout: moving from topic to main
+		EOF
+		git log -g -2 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb names a detached HEAD by the commit it was detached at' '
+	(
+		cd branches &&
+		git switch --detach topic~1 &&
+		detached_at=$(git rev-parse --short HEAD) &&
+		test_commit detached &&
+		git rebase topic &&
+		rebased=$(git rev-parse HEAD) &&
+		git switch topic &&
+
+		rebased_at=$(git rev-parse --short $rebased) &&
+		cat >expect <<-EOF &&
+		(topic) checkout: moving from $rebased to topic
+		(detached at $rebased_at) rebase (pick): detached
+		(detached at $rebased_at) rebase (start): checkout topic
+		(detached at $detached_at) commit: detached
+		(detached at $detached_at) checkout: moving from topic to topic~1
+		EOF
+		git log -g -5 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb names a detached rebase by the commit it ended on' '
+	write_script add-exec <<-\EOF &&
+	{ echo "exec true" && cat "$1"; } >"$1.new" &&
+	mv "$1.new" "$1"
+	EOF
+	(
+		cd branches &&
+		git switch --detach topic^0 &&
+		test_set_sequence_editor "$TRASH_DIRECTORY/add-exec" &&
+		git rebase -i @^ &&
+		ended_at=$(git rev-parse --short HEAD) &&
+		test_commit after-fast-forward &&
+
+		cat >expect <<-EOF &&
+		(detached at $ended_at) commit: after-fast-forward
+		(detached at $ended_at) rebase: fast-forward
+		(detached at $ended_at) rebase (start): checkout @^
+		EOF
+		git log -g -3 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb names an aborted rebase of a detached HEAD' '
+	(
+		cd branches &&
+		git switch --detach topic^0 &&
+		test_must_fail git rebase -f -x false @^ &&
+		git rebase --abort &&
+		returned_to=$(git rev-parse HEAD) &&
+		short=$(git rev-parse --short HEAD) &&
+
+		cat >expect <<-EOF &&
+		(detached at $short) rebase (abort): returning to $returned_to
+		(detached at $short) rebase (pick): B
+		(detached at $short) rebase (start): checkout @^
+		EOF
+		git log -g -3 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb follows a renamed branch' '
+	(
+		cd branches &&
+		git switch topic &&
+		test_commit before-rename &&
+		git branch -m topic renamed &&
+		test_commit after-rename &&
+
+		cat >expect <<-\EOF &&
+		(renamed) commit: after-rename
+		(renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
+		(topic) commit: before-rename
+		EOF
+		git log -g -3 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb labels branches and detached HEADs' '
+	test_create_repo origin &&
+	(
+		cd origin &&
+		test_commit O1 &&
+		test_commit O2
+	) &&
+	git clone origin downstream &&
+	(
+		cd origin &&
+		test_commit O3
+	) &&
+	(
+		cd downstream &&
+		test_commit L1 &&
+		git branch side &&
+		test_commit L2 &&
+		git pull -r "file://$TRASH_DIRECTORY/origin" &&
+		test_commit L3 &&
+		GIT_REFLOG_ACTION="sync switch" git rebase -i FETCH_HEAD side^0 &&
+		H1=$(git rev-parse --short HEAD) &&
+		test_commit "checkout main" L4.t L4 L4 &&
+		git rebase FETCH_HEAD side &&
+		test_commit L5 &&
+		git rebase origin/main origin/main &&
+		H2=$(git rev-parse --short HEAD) &&
+		test_commit L6 &&
+		git rebase main refs/heads/main &&
+		H3=$(git rev-parse --short HEAD) &&
+		test_commit L7 &&
+		git switch side &&
+		test_commit L8 &&
+		git checkout origin/main &&
+		H4=$(git rev-parse --short HEAD) &&
+		test_commit L9 &&
+
+		cat >expect <<-EOF &&
+		commit: L9 (detached at $H4)
+		checkout: moving from side to origin/main (detached at $H4)
+		commit: L8 (side)
+		checkout: moving from $(git rev-parse L7) to side (side)
+		commit: L7 (detached at $H3)
+		rebase: checkout refs/heads/main (detached at $H3)
+		commit: L6 (detached at $H2)
+		rebase: checkout origin/main (detached at $H2)
+		commit: L5 (side)
+		rebase (finish): returning to refs/heads/side (side)
+		rebase (pick): L1 (side)
+		rebase (start): checkout FETCH_HEAD (side)
+		commit: checkout main (detached at $H1)
+		sync switch (pick): L1 (detached at $H1)
+		sync switch (start): checkout FETCH_HEAD (detached at $H1)
+		commit: L3 (main)
+		pull -r file://$TRASH_DIRECTORY/origin (finish): returning to refs/heads/main (main)
+		pull -r file://$TRASH_DIRECTORY/origin (pick): L2 (main)
+		pull -r file://$TRASH_DIRECTORY/origin (pick): L1 (main)
+		pull -r file://$TRASH_DIRECTORY/origin (start): checkout $(git rev-parse FETCH_HEAD) (main)
+		commit: L2 (main)
+		commit: L1 (main)
+		clone: from $(cd ../origin && pwd) (main)
+		EOF
+
+		git log -g --format="%gs (%gb)" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'rev-list -g complains when there are no reflogs' '
 	test_must_fail git rev-list -g
 '
-- 
gitgitgadget
