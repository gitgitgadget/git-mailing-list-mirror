Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695790;
	b=5DWuI5GJe8grpYn7Q7Wd4WsmajwmaXd3Zayf2hMKcPN4O18RBbJYylQHKgqux4bU08f2
	 nZzfxmhR+OxmxCrTPIiByYnbWMwcWQpwZu+nTJ9belRwdrKHxkP+dG8DMRPQSYnBQ3P5C
	 lm4LZ4k1bDoMUd0Fi81OE7b2TqGhyj9TxVSzu5bVfMxrr+SY3nu8B+V2AyKZbDH3Y1AYg
	 nKXuyLfniYqvnbjT3G99xtPDB0Nofn78glUwzt8WSPeSkb0fqqKarmBg3W8ot0/wdEe5Y
	 A3WyA2un/urICeTw2dGlLAANXPiGppP3LYSmCqTklO3RMcrtk1h/0VGN40pT/eesnTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FIuU/iFAK6VrZknQdbQ6wVEQF2JkFhiRVKtHjCw6xsw=;
	b=Ni674DngLlwZ+pJayaSvbs6/MkXu/q1QK12+Mmb85mS8sN4jZEikViAYmwfwB3aaK+sk
	 YUUlv61N6kWGk/q3hlJxbJgfhXHzQdX6iI30ttOtFcCzmZHCaKpPHVAiOwenMidOl3EYb
	 3j1mf8juCuDLRW1b0DHd3PIDhr7lqOsWmLXgLPNz/40Nd/CggiQGjHkqCatoLaT1ikx4E
	 vGPr+XHyOYRhhGvDeljlhsFERpu7WMtapkoln6uFNhqqSxoFT3Ul9iTuPgm0eocOYH3da
	 FtXDHClxC3wydhnOQ5GlDMT8QtS3cgezKG95aswArSZPc1yGhHEVXA0I7wr3ZBavC1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXy5DT23;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF7606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20FF7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXy5DT23
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4550d8ab15so467405266b.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 00:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695788; x=1794300588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIuU/iFAK6VrZknQdbQ6wVEQF2JkFhiRVKtHjCw6xsw=;
        b=NXy5DT23yns5ytvUk/cj6SPu7t2YMAuXIhXTF0pWM36BKxDaDEgpB2D+OlDk38qUUH
         WcHLQYABUx8PjOxwL/rt5znnIpmfc/PyMjOTo9lEJ4MxkKNsJe/5/ZJxB8J9m0szMAxw
         eIvNI79L+ZTQeaP+XYNgEzKcj6EZhPn0ZPeL4lE846pBoJVZ7sd1pzG2c3Z7zZn8N5wf
         6FNAGgD/MqP2Ze9BOQqaN+81buk7ANIoAozE9PSE+Z9NGMgWGcTk57/tNxRXTffx1jaP
         NZU6PSy4JrwHUaNmiGxKSNUGMU5tUwI0joviCIrAZLhpXWZAh5elyhhyYci9lWI97pbu
         Dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695788; x=1794300588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIuU/iFAK6VrZknQdbQ6wVEQF2JkFhiRVKtHjCw6xsw=;
        b=ZqdBVzOheQdbEyynN8/U8T1KGd7x+nwBVDGILN/t8Ep6qUcGjnadcPpY4TotqDEkQN
         e48kCtQjmUtXBev9q2b4Tkzm6qEV/XGR25aHsK7RSUt4GdK5VxOY20MFxzX7/UQZv2fh
         RecyiLj76HeyC2PrrHOPbaaAmCvjCfEzLyZqpuzCBeNrI8UMWMkrrb3oKCHSCkO4sor6
         Q1IqAhyORc1KxtaX7ADGBAGMkeTdipVC/H4RoaqP0OIJSjRhJ8CP23PgWc7kEfV8BvUq
         LIZuLHOFXFP+X4wt5jWESSk5FQuFY3Mtk8hoUaVEFyM09g7+/pgiq7FktgTHx43jVQud
         wTcw==
X-Gm-Message-State: APuU4Z+EpMdkgJbC9FcT6FmBs1S3HQGPJGJmsfntKH6DYHUotgH9rLkT
	oCrL5XKuCwq0tykDTnyyBZIFQYer10dBTiu1VX3sU4GM5GRqcDagq9AouxqtvlLHn+E=
X-Gm-Gg: AYBFou2Y+8C26hFEJnUINZ9MCRjGwDAY5FL91l1O6mgb7P4ehBOl/Tpy28RfgbW5lVa
	lDqI8TD/LSffvp25Y84jKEXue2/3NEossz9Q5jlZDgx/5TVK1h6X4Udpzbu75K3CmweJ5SCp1jy
	0pg27iBdV8q9qgBXtZXFjMvRoD63pG4/7m0JbCUN0O7CkpjeDupCJOWIK9aqc13ybP7RW6ilRSc
	Jj7Exn/7grE5nYgmLAc1X5QoWsRHRyFJC2V7ln/oSLYjQ4R/cvAndWouI4GgqlovlFloDMhJRoP
	4wpf+PYaQWdbWdFaSlcKsjCK/mMA80oXGkIffw1JeTy3IYvIEImjMP0mIkzePq8mVX352UfQHLs
	5gFpHfJUwF51lor57aXXHuHhe0M42aYJORdnFMRiUfPfwK7Zvi2dauSt8YIiLdDsUFSYgBgaPa+
	RD9TTxJ/DU7kB/CBia5MHfOlsgJlLJJuVEv1Z9rtyFHDiKQ6xMHWm71RiI3Azwovmlt26eftlCw
	PxUN4r2vx7lIkOc0SksMgnKbKT17PxYrl3jdyY1r9TNBC+UmvTBkr6Mg7uv5tAWdam4R8qsXSd9
	AWm4iBx5ubgKJaNpQIEhtK+mCqSHLIXjRmyboBOsVG/ziexa5JGcyvZVpSiRQ8R7iTfmzER8mTo
	eWekRymrTqe2JCfLQxW+1rvcQl18XroQfRBYauuVWOKh4x8Po6FhI8KkBB8CKGdCzx+RvomDmcZ
	tJranoQZCUL9aO5GLph+BYWOXYNqdJ
X-Received: by 2002:a17:907:f20b:b0:c4c:eb17:3da with SMTP id a640c23a62f3a-c4ceb17053emr176724566b.22.1793695788468;
        Tue, 03 Nov 2026 00:49:48 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec15a904sm64611766b.70.2026.11.03.00.49.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:49:47 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2 2/2] notes-utils: pass the repository to init_copy_notes_for_rewrite()
Date: Tue,  3 Nov 2026 09:49:30 +0100
Message-ID: <20261103084930.15532-3-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103084930.15532-1-okhuomonajayi54@gmail.com>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
 <20261103084930.15532-1-okhuomonajayi54@gmail.com>
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

init_copy_notes_for_rewrite() reads the notes.rewrite* config from
the_repository, as it is not given a repository. This is the last
use of the_repository in notes-utils.c.

Add a repository parameter to it. commit_post_rewrite() in sequencer.c
already has one and passes it on. The callers in builtin/am.c and
builtin/notes.c still use the_repository, so pass that for now.

Drop USE_THE_REPOSITORY_VARIABLE, as notes-utils.c no longer uses
the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/am.c    | 2 +-
 builtin/notes.c | 2 +-
 notes-utils.c   | 7 +++----
 notes-utils.h   | 3 ++-
 sequencer.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

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
index 9f1f0ec840..20f7bb8377 100644
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
index d4606bc576..3a3b84f79c 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
@@ -134,7 +132,8 @@ static int notes_rewrite_config(const char *k, const char *v,
 }
 
 
-struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(struct repository *r,
+						      const char *cmd)
 {
 	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
 	const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
@@ -162,7 +161,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		c->refs_from_env = 1;
 		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
 	}
-	repo_config(the_repository, notes_rewrite_config, c);
+	repo_config(r, notes_rewrite_config, c);
 	if (!c->enabled || !c->refs->nr) {
 		string_list_clear(c->refs, 0);
 		free(c->refs);
diff --git a/notes-utils.h b/notes-utils.h
index c54b1fe141..ef3c0f6732 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -45,7 +45,8 @@ struct notes_rewrite_cfg {
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

