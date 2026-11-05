Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910864;
	b=oOZwM3Ns3UHx0pKdLhp33wH4lLrJZmd0WV+5wstKB8KsvY1QDD+LNspg9yvNrb177dXA
	 m1sc1FI7qPKlNrXNTXFDtnaR+nL4CRg1srxGcigV9z89sSw/t9ECUmFd8zFlTB8rLo1mQ
	 /874bre9EU5oyGZDHtINjtjSu1rZnt9/Tl35SX/hDjBhXNe0r9QOYTrQqlZrS8NPU8puj
	 BZzt5dXOmzNgff3uCQOmgCdkt3m9V89iyA/QHCPWNk96isjdArIycTHuy28KXo3pX5PdJ
	 jFkQjcTjeqTETfIzXA6yyEEE8H3DFSrEQjOiB8f5lGqJqvDP1VIUEECn2Z9Szzp2LPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o95fHruojHjjWCDm48yJreRk+vJ5xvZNtKHnQ2zx0qs=;
	b=2OIgCI2Ug1CH69r2uE7V06bV8teBAE7atIvnhKG0V4v1qRVanEicq92LzHg7nF0rw4kI
	 C6bz8QBv/tKnnRFoVxyJKkI4fnMCZd8nk60l9HYoZYd3Mg5mwWJqYfnD5f2EIwtFzZFzW
	 AGOPHMV4co8+PO6IsJY3ZxQqx6eKtvTEOYdeUezCPbttiN37f0YPsVK0el7rhLXT0NNkS
	 PtH4YsZ+ZNXEB7/PIZOVj7H6sSV3iYNg7vFaDFAfu8Mf2fcBlVT69pDoIS3ES4AnGVHEV
	 k/7NC8AVT2qGjWjp2A/VAY9RcLE2eqw9klrbAjMM1Q2GSWRnKGGd0AAHcy1MPjXoZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwXDiPNL;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45284606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45284606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwXDiPNL
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so128289a12.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910863; x=1794515663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o95fHruojHjjWCDm48yJreRk+vJ5xvZNtKHnQ2zx0qs=;
        b=ZwXDiPNLaSqU43V+J1K4ISXQhynTC2TH2Q6tHHMVdZXnI2PJDqtlUM7VjRmmOfaCoV
         3kc0ekEK5JzgMcsHwba9t3GZ0eKBdbtWZf8tmH7bMnab3FQxVyFVcPkr0tpfRqe/xJQp
         3PijXAb6Eqc9989knRZNqF87cM04HHtQfzRNTLVwfbaqCwyfUikcXj/MW85jeZ4+1qYn
         Be35aVSurYKYxhi0jAa7IhLKGNhmVFNjYVtVDArVaSe91wXw7qX6gPLmmRLUMNrI0bhG
         QasylFGU7IDj2kIr8A7S7aKtCLshyqoiu4q9yDmorvqbi9HKhXOMpCYtZPY2vzTzvu3i
         AFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910863; x=1794515663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o95fHruojHjjWCDm48yJreRk+vJ5xvZNtKHnQ2zx0qs=;
        b=LYgVKHoRUgAQqIeMx73OHVe1nytziKLy9w4xRmvEZNZzeJvrkAiRNK25PS6aN00d0W
         +YRhR7Xcy+C1Ixb6avdQuF+5qZe78rFlKzMsnTN41OBxWB7ix4QAdEHDfyJYsc6SLLSs
         XOQy2VuieSKCK2RaiY+TXWah6rXb3eMYtU7XigVjKgM4td+sjGdgTM5RWUl+pOQbpqQO
         QucwpwJnZx/GiIkSq0S+QnGJWPQX4keWBSOBpkpYxF8lDhl6ko06l6IxAIZSWjfjWXzh
         gs8QZP5PienM3SkEBBqR16vVTmdQVekGs1o3DTGgJvl5DzmLDUpFzxQ1LrpoKR56KUd8
         UUOw==
X-Gm-Message-State: APuU4Z8BGM3rqVIOwm28vhM/hA3HCMxpLTduE1fj47iyIs8waToCyLge
	xu/7NuHmx5cJXffvCcISzY4mmHTdiPaZ8KLWPg/3gSHnCg7Bqisb+nt2Jx2+bW6A7GPXxg==
X-Gm-Gg: AYBFou0xbFaGV74iRvi01DSfimSHzorVBVVcGn7HHbxAsPbtLFWXdxqJnwUG/miLxVk
	ZsPHM7gqpUr1FZ4hii4SpRisJjUKsnFLTbLEbAe/Jjf515ktu3ZdMABbY6OBWboPHtjCwSkre18
	l3nICJaoOir9Ce+OSvx2rsfgi+70j1uEXhhgcCvIXaVdNm9kAQIye3lYe3k3CiV+JUura+OlEmX
	oB+WtYkM0/JPHBjuQlo7Rfz3WeIgzpcaeQB7ae6oeU9mWGwVGASd6199/K+t0P1qY959N2hKI9o
	Is1TmU2xevjM5CQdxkXTSp8R+VctGKVfkA+fSVhiwNwtnAdivPUpJyg+4a2XTZwYYm8Z44pVnqt
	5iTqi0CiZWXMUKU3/krQBYUGh6LED3RhAgGR7sAghrIlaEx+b+8w/IvkXun/rZPE59+LgmZbwsw
	ph3ZbsR6MG0lGifzhdoYyPWqnT8b1rS2Z8dFIg6griCzKKDCTAXQY5qL+ZYFtNgMP97ytQRAy16
	8pKP8zOYc0JXBLAv8X2iPna4NUK0qyZFkePN8xATqCYRgQ/7HKKdAdGSWjK+bqwQFdPB3qzLR6S
	+S8hOfiTbeSlAuX5w5xCpn3rwPU9UMnwjrAkjSey8yW9zRB00FseHHvGaZSC9RdHSPnSZzmwjmK
	J8r18HF11fLmKmCILuVpkvUvq7GshnPuo8Cjz0TjBLOvdXL3QBKKtCFGQfGQ6y0gvg4nlv2Kner
	06F8w+C3IrzeJ0mOFdfXBn3krlMsW4BckxmERQk2ZT0gFZ+trd4w==
X-Received: by 2002:a05:6402:3811:b0:6b5:8719:6d51 with SMTP id 4fb4d7f45d1cf-6b5977e704fmr270044a12.32.1793910862523;
        Thu, 05 Nov 2026 12:34:22 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:21 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 6/6] notes-utils: use the given repository
Date: Thu,  5 Nov 2026 21:33:44 +0100
Message-ID: <20261105203344.48513-7-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
References: <xmqq1p8zw49g.fsf@gitster.g>
 <20261105203344.48513-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_notes_commit() and commit_notes() take a repository, but
still read and update the notes ref in the_repository.
init_copy_notes_for_rewrite() does not take a repository at all:
it reads config and loads notes trees from the_repository.

Pass the repository through. The config callback keeps it on
struct notes_rewrite_cfg. The sequencer passes its repository;
am and notes pass the_repository for now. notes-utils.c no
longer uses the_repository, so drop USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/am.c    |  2 +-
 builtin/notes.c |  2 +-
 notes-utils.c   | 21 ++++++++++-----------
 notes-utils.h   |  4 +++-
 sequencer.c     |  2 +-
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..daa4b601b6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -536,7 +536,7 @@ static int copy_notes_for_rebase(const struct am_state *state)
 
 	assert(state->rebasing);
 
-	c = init_copy_notes_for_rewrite("rebase");
+	c = init_copy_notes_for_rewrite(the_repository, "rebase");
 	if (!c)
 		return 0;
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 7e7dff6672..a32af68928 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -366,7 +366,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	const char *msg = "Notes added by 'git notes copy'";
 
 	if (rewrite_cmd) {
-		c = init_copy_notes_for_rewrite(rewrite_cmd);
+		c = init_copy_notes_for_rewrite(the_repository, rewrite_cmd);
 		if (!c)
 			return 0;
 	} else {
diff --git a/notes-utils.c b/notes-utils.c
index 70c619269e..7e9262411d 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
@@ -26,7 +24,8 @@ void create_notes_commit(struct repository *r,
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
-		if (!refs_read_ref(get_main_ref_store(the_repository), t->ref, &parent_oid)) {
+		if (!refs_read_ref(get_main_ref_store(r), t->ref,
+				   &parent_oid)) {
 			struct commit *parent = lookup_commit(r, &parent_oid);
 			if (repo_parse_commit(r, parent))
 				die("Failed to find/parse commit %s", t->ref);
@@ -61,7 +60,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 
 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
-	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
+	refs_update_ref(get_main_ref_store(r), buf.buf,
 			t->update_ref, &commit_oid, NULL, 0,
 			UPDATE_REFS_DIE_ON_ERR);
 
@@ -123,8 +122,7 @@ static int notes_rewrite_config(const char *k, const char *v,
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
 		if (starts_with(v, "refs/notes/"))
-			string_list_add_refs_by_glob(the_repository,
-						     c->refs, v);
+			string_list_add_refs_by_glob(c->repo, c->refs, v);
 		else
 			warning(_("Refusing to rewrite notes in %s"
 				" (outside of refs/notes/)"), v);
@@ -135,11 +133,13 @@ static int notes_rewrite_config(const char *k, const char *v,
 }
 
 
-struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(struct repository *r,
+						      const char *cmd)
 {
 	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
 	const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
 	const char *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT);
+	c->repo = r;
 	c->cmd = cmd;
 	c->enabled = 1;
 	c->combine = combine_notes_concatenate;
@@ -161,18 +161,17 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 	}
 	if (rewrite_refs_env) {
 		c->refs_from_env = 1;
-		string_list_add_refs_from_colon_sep(the_repository, c->refs,
+		string_list_add_refs_from_colon_sep(r, c->refs,
 						    rewrite_refs_env);
 	}
-	repo_config(the_repository, notes_rewrite_config, c);
+	repo_config(r, notes_rewrite_config, c);
 	if (!c->enabled || !c->refs->nr) {
 		string_list_clear(c->refs, 0);
 		free(c->refs);
 		free(c);
 		return NULL;
 	}
-	c->trees = load_notes_trees(the_repository, c->refs,
-				    NOTES_INIT_WRITABLE);
+	c->trees = load_notes_trees(r, c->refs, NOTES_INIT_WRITABLE);
 	string_list_clear(c->refs, 0);
 	free(c->refs);
 	return c;
diff --git a/notes-utils.h b/notes-utils.h
index c54b1fe141..14dd16f0ea 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -35,6 +35,7 @@ enum notes_merge_strategy {
 };
 
 struct notes_rewrite_cfg {
+	struct repository *repo;
 	struct notes_tree **trees;
 	const char *cmd;
 	int enabled;
@@ -45,7 +46,8 @@ struct notes_rewrite_cfg {
 };
 
 int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
-struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(struct repository *r,
+						      const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const struct object_id *from_obj, const struct object_id *to_obj);
 void finish_copy_notes_for_rewrite(struct repository *r,
diff --git a/sequencer.c b/sequencer.c
index 508ec71792..a40243c56b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1366,7 +1366,7 @@ void commit_post_rewrite(struct repository *r,
 {
 	struct notes_rewrite_cfg *cfg;
 
-	cfg = init_copy_notes_for_rewrite("amend");
+	cfg = init_copy_notes_for_rewrite(r, "amend");
 	if (cfg) {
 		/* we are amending, so old_head is not NULL */
 		copy_note_for_rewrite(cfg, &old_head->object.oid, new_head);
-- 
2.56.0

