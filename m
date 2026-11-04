Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826943;
	b=p7uS393DzIe+oWEqS+dL2rabLPr5idX/HI8YRNxESaq+v8qCOWbqCJ3ri9FGbNhQgiPt
	 Oef5Wwgzwr6I2GIpIQxYHh+mViP+0zELOSUjFDqHQu+y4/m8ci0QeXKw1ACR45HxSDoid
	 lxTFzNWA3TX7FQp9GTdJp+EYpLQ8OselMK4wi1tJnPZqfDs/LCgpZ4xNsbofjMPK2bSpe
	 4jseJiK81oA8JnnKNq7w8u2p5z7EHy21s9qXhvz3mlb488E+us7Y8EkgU2qc6/kPL62vt
	 FLYOiB5ecvA8JeGwBWf5gv+Dg8ANJi7P/qUKjI3MqVEFOuJ4Y1DAUxLrLkPepinpa1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mp0LaSz7y9QyoevFKuwck9B3osmpUXGN86Pp7gUcSCs=;
	b=rPEvynrqXoF4OkHH+CbapmZGssW8y2PEsA2VoiOYvUxDG+7MGTr7I+kn8mMqOCgjYo2k
	 vOKhpAZ0qA9cXaHyZtpk8Foow/Gkooxle1gz0zVAMalJGvI80F2OO3y5Z67GQeS/7p3t5
	 mB/P+8LIgxasPvSc5Hjxrx/xGQq5JczOuy+3GN6FBc+nm0I2JRiIeSWvo0B1EOZk9t33B
	 ZcKcPMa6b2iBjdmzpkM7kxDXUPT2pCTVLpSEPz2aln4p79qZi9k38lTTZkUB5oF+PycH8
	 bZqB7G4mvR7LnVMKx3DGqojJYb3KdnleJz+JcbY6y7NdRYNkpt9Yg/sEYY3/tZMxiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o7a970to;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212860B5A62
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 21:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5212860B5A62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o7a970to
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53bb57f1310so11599831cf.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826942; x=1794431742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mp0LaSz7y9QyoevFKuwck9B3osmpUXGN86Pp7gUcSCs=;
        b=o7a970toXcGwAOQj8woO34nDO9cMzjcKgUlepcyl22wxokZVo7JM300dDmBMzhG5Vf
         aX8oVtzBCl4gKwGihjZuvkiC/DuLwFpSyIF3oyyJAe7+mhkkfWvs7nj61Gx8mDyABkv9
         SyJi323YXDBn8QvQVeqOURvPU6HAO/fGEI3Xnc2VQqpUvou5peZ3436rXV5H601Cw3Sj
         mBLMGxyH3FCHAMtygRXVoQrXkex4nBSFnmLtx+RM/2ps7RRcfiVZvJ2Lf7R/X3w1/LEJ
         JptBjjaU59zKGByJHce5hHQGhCXd4COplCtAWTV8j2gkfRJB09f6FVj1r0S51KdC7wCD
         kPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826942; x=1794431742;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mp0LaSz7y9QyoevFKuwck9B3osmpUXGN86Pp7gUcSCs=;
        b=t5UvaU2IJVHBgJYphsjI28WcITp+LFiBOkcTiULV17g6we7IrIDsdBVKeAIRR5rzaT
         wQ0ZjCo2YHFI7BVT0peSZUysW+llqvwihJvm3E5e8VRXKikZRa2TFzxIa3D40gbYCTmj
         xuNICBZHjvUMWfvgGjmmyokeJ8Xf5vMsgiJCQ44feCNYHfuj1YbHV3CgRc1sFlE7OZ2L
         61XIRXvTudgw4bPUabKMbCBzBtoZXlqi+VsDaasjRQeebDoifB9qDtobiDJkd/f1iZWP
         oGVLwBlL4166/0xDWlPsJO20PAX1ExkI1Jbwtq+DrdmQOFRlMEPOyc8KPRHVa0YJJcfR
         oxZA==
X-Gm-Message-State: APuU4Z/0urP2LmTxLaDAUhA2grism/s6irFcklPYEgkAlJOoDw9/nT2r
	b8tMW0uHOnbP7fC4//z5ekdsWukQuEo7ZTAFgnZGP/FUOrEjRlFKnHNfppaL4ujMMfx63Q==
X-Gm-Gg: AYBFou1yJuRxaplG8D6HJ6EZgFSG4yyaUGdJ+QesqYvrn2lViDnkZ6MRoYOmvCxHHrI
	vlxUlCPc/6hhoJSbRcPU9xBkzz0gWe8n5c+jjf+T3+Xmwf6FGjCPv2jynM1DeZWK5mkT6LsBgcH
	rtqpre2qUjoPXefVMvHlbOTbJ+4BNCxfJ+JufEjeWgQj0BC2ZUfQUm0/UkHnBFv/gPzGYh7ZYxn
	J6S4nXn5iyHdKfwcu5hIOFr0K8yZq3zGAZ1bhhlklgLySVUfE2HHHriSkH/HeqdCcpDqz+k6xOC
	eBoyGWo4fHgPVOo2qbWmoa8ConU7RoY256YVd97bwyro4rBLA3qO02DaiF1uGXjAn9zgnpxkB3T
	JjNRVHHXT79rl6eIzSRwEfq2bdgxOVlSERE1653REQe6QVxU2u8/Dj/+6V2Z2eG2ZKqdtE0pFDi
	cKgNgqKTuTUIa6uXGGr/ecaep5KGUtdv5UP5SW9HAqH7ZleoA3PmXmbGqOO01OoqefkqUxl3BuB
	1XcIZNWXivU/kJQ78l5HXjFD4j/0R6t63AQ//Zou3+kTHDTAMdqSCTRuljB5DYDLl/XALbOHJPN
	tmvOEj/yrwD+hxzOPZpPGNZC6Jlvj9FDFA==
X-Received: by 2002:a05:622a:8614:20b0:54a:67f7:751 with SMTP id d75a77b69052e-54a67f70cf5mr69088931cf.60.1793826941962;
        Wed, 04 Nov 2026 13:15:41 -0800 (PST)
Received: from [127.0.0.1] ([48.217.227.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e75b24asm29125136d6.39.2026.11.04.13.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:15:41 -0800 (PST)
Message-Id: <99a104770226c4cb1a05846c21e52484f701bb2b.1793826938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 21:15:38 +0000
Subject: [PATCH v4 2/2] pretty: add %gb to name the branch of each reflog
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
"detached at <commit>" with the commit HEAD was at when it moved on.
When nothing older in the reflog says which branch a rebase started
on, the rebase is taken to have started on the branch it rebased. For
the reflog of any other ref, "%gb" is the name of that ref.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/pretty-formats.adoc |   3 +
 pretty.c                          |   4 +
 reflog-walk.c                     | 167 ++++++++++++++++++++++++++++--
 reflog-walk.h                     |   2 +
 t/t1414-reflog-walk.sh            | 137 ++++++++++++++++++++++++
 5 files changed, 307 insertions(+), 6 deletions(-)

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
index 4dbeaa93a7..9246ab3208 100644
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
@@ -65,6 +72,124 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
 	free_complete_reflog(array);
 }
 
+static char *branch_label(const char *name, size_t len,
+			  const struct object_id *oid)
+{
+	if (name) {
+		struct object_id hex_oid;
+		char *branch;
+
+		if (skip_prefix(name, "refs/heads/", &name))
+			len -= strlen("refs/heads/");
+		branch = xmemdupz(name, len);
+		if (strcmp(branch, "HEAD") && get_oid_hex(branch, &hex_oid) &&
+		    !check_refname_format(branch, REFNAME_ALLOW_ONELEVEL))
+			return branch;
+		free(branch);
+	}
+	return xstrfmt("detached at %s",
+		       repo_find_unique_abbrev(the_repository, oid,
+					       DEFAULT_ABBREV));
+}
+
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
+static const char *skip_rebase_checkout(const char *message)
+{
+	const char *p = strstr(message, " (");
+	const char *colon = strstr(message, ": ");
+
+	if (!colon || (p && p < colon) ||
+	    !skip_prefix(colon + 2, REFLOG_CHECKOUT, &p))
+		return NULL;
+	return p;
+}
+
+struct branch_move {
+	const char *from, *to;
+	size_t from_len, to_len;
+};
+
+static bool parse_branch_move(const char *message, struct branch_move *move)
+{
+	const char *to;
+
+	move->from = move->to = NULL;
+	move->from_len = move->to_len = 0;
+	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) ||
+	    skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from)) {
+		to = strstr(move->from, " to ");
+		if (!to)
+			return false;
+		move->from_len = to - move->from;
+		move->to = to + strlen(" to ");
+	} else if (((to = skip_rebase_step(message, REFLOG_STEP_FINISH)) ||
+		    (to = skip_rebase_step(message, REFLOG_STEP_ABORT))) &&
+		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
+		move->from = move->to = to;
+		move->from_len = strcspn(to, "\n");
+	} else if ((to = skip_rebase_checkout(message))) {
+		move->to = to;
+	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
+		return false;
+	}
+	if (move->to)
+		move->to_len = strcspn(move->to, "\n");
+	return true;
+}
+
+static void mark_branches(struct complete_reflogs *array)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct object_id oid;
+	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, &oid, NULL);
+	char *branch = NULL;
+	int unknown = array->nr;
+
+	if (head)
+		branch = branch_label(head, strlen(head), &oid);
+
+	for (int i = array->nr - 1; i >= 0; i--) {
+		struct reflog_info *item = &array->items[i];
+		struct branch_move move;
+
+		if (!parse_branch_move(item->message, &move)) {
+			item->branch = xstrdup_or_null(branch);
+			continue;
+		}
+
+		if (!branch) {
+			branch = branch_label(move.to, move.to_len,
+					      &array->items[unknown - 1].noid);
+			for (int j = i + 1; j < unknown; j++)
+				array->items[j].branch = xstrdup(branch);
+		}
+		item->branch = branch;
+		if (move.from) {
+			branch = branch_label(move.from, move.from_len,
+					      &item->ooid);
+		} else {
+			branch = NULL;
+			unknown = i;
+		}
+	}
+
+	if (!branch && unknown < array->nr)
+		for (int i = 0; i < unknown; i++)
+			array->items[i].branch =
+				xstrdup(array->items[unknown].branch);
+	free(branch);
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -234,6 +359,16 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
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
@@ -247,12 +382,7 @@ void get_reflog_selector(struct strbuf *sb,
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
@@ -287,6 +417,31 @@ void get_reflog_message(struct strbuf *sb,
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
index be6c3f472c..21b0ae3856 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -131,6 +131,143 @@ test_expect_success 'walk prefers reflog to ref tip' '
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
+test_expect_success '%gb names a detached HEAD by the commit it was left at' '
+	(
+		cd branches &&
+		git switch --detach topic~1 &&
+		test_commit detached &&
+		git rebase topic &&
+		rebased=$(git rev-parse HEAD) &&
+		git switch topic &&
+
+		left_before=$(git rev-parse --short detached) &&
+		left_after=$(git rev-parse --short $rebased) &&
+		cat >expect <<-EOF &&
+		(topic) checkout: moving from $rebased to topic
+		(detached at $left_after) rebase (pick): detached
+		(detached at $left_after) rebase (start): checkout topic
+		(detached at $left_before) commit: detached
+		(detached at $left_before) checkout: moving from topic to topic~1
+		EOF
+		git log -g -5 --format="(%gb) %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb names the branch of a "git pull --rebase" in a fresh clone' '
+	git clone branches downstream &&
+	(
+		cd branches &&
+		test_commit upstream-change
+	) &&
+	(
+		cd downstream &&
+		test_commit local-change &&
+		git pull --rebase &&
+
+		echo "(topic)" >expect &&
+		git log -g --format="(%gb)" >out &&
+		sort -u out >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '%gb follows a renamed branch' '
+	(
+		cd branches &&
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
 test_expect_success 'rev-list -g complains when there are no reflogs' '
 	test_must_fail git rev-list -g
 '
-- 
gitgitgadget
