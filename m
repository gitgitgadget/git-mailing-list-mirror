Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0B1F8EE7
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123241; cv=none; b=uvCCAe92DkiDiREhdhgAxndi/vI5meIaQ0cImONN3q2alb4n/kXf+9oJtHcZZYYXpxWUUtqMkJWhr6yFv8Vt/2UARcYO3uZj7NIBurkQcvkRL7rQBg/2lDqDTJzHGBRKVY7v/AWqAhB28YcZiu/t5tyxY2rcum6Ls2jYETjJKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123241; c=relaxed/simple;
	bh=8cYjKY8aCeNzcGHMRHoREo52zbjjd7xXRs7Mkyo0DHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYMfJtbARz7nRWQ19vCRbpJUFILtkIPcYTWU+11du5GdwDnDZ2UkHaJEQ5yAgiTscFmAn0RNZzz0WWnXPB890rP7KtK/rLy+Y1AxcJRC2uJHlWJikhDlz3/gRJsqCSiL063K5v345/KocaQl92kI8DYglj+Shc1nzrNu9CPkjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Baa1/N3N; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Baa1/N3N"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D160114015B;
	Mon,  2 Dec 2024 02:07:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 02:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733123238; x=1733209638; bh=p
	UXnCvj6a4mav08zZnq+4nU7QfNAvo4hAcAXNu80xI0=; b=Baa1/N3NjzCqKj/Eb
	flS/lC+H0BtJZCDzY+YyG32lM66FAeH4gbW1SVn5sFhfHmMI1rPQU++DnHQ4kGt0
	MfSM/LjNv1RnSOANU4Pl5a9bZ6P2cOgDBH0fXzjWIOaR42xyg7yYOQRqMbOMripI
	jP7mYdDmBkm7toh6ObehvfNUN9rIAkBX2Wgt81u504JO+yNDXLBo6mkUxd4gNyxU
	hE6Yj7pgKHND6Oy+Uf3S1CvIzZSV+Yo+GRRycGuC3Yli4cDwho8Th0DpJbPQr3+t
	G9jcejXkeGYWDQbf/yKBmddo5xxqc2ayIYU+5r5ZEZzzQ02AVNuQvQKjpsuJwtAg
	vnctg==
X-ME-Sender: <xms:plxNZ-9DksRMSl8qtO1_UUbax2DNJsHQFH1HMXW222UqFqj6c5I6Bg>
    <xme:plxNZ-vCmUUlNTe2SSzuRfKb_Zjn2Ki5dOZfe7jhBhKQlkJS-fDWfNgqkqWnqyDBQ
    NbVfUPCVLyz6OUOzA>
X-ME-Received: <xmr:plxNZ0B4mzkRxFYMk0J0K07SJ2Cksog1bxXZybvQ0wQnk0l9UvrYC3bCurIl3WEcMNI4WgmTBjd3m7_dp8ssgtBg7Sv4qwnp1Gv3e9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvff
    elhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithesjhhofihilhdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:plxNZ2cfH9XeO_fVdPPqnqCh8Zn-aFtqVuUu2Bp-x7BqZUnqG1qjZQ>
    <xmx:plxNZzOtrjUafAQWapt81QX8hdz7k_-BphkOqsCbJXHQtC3h53zfbw>
    <xmx:plxNZwkt5jDRxFO7Brm79dT6TvUZRytnH9PE-4v8nK8epC4WTV1vQw>
    <xmx:plxNZ1vUYGN66LhWN7duBfezAuXkNZ4CVJrrzmTXcQ9Kw-SatoH5Ww>
    <xmx:plxNZ4pzeH4CxBc3I7qc57dxq-yJZyk4uN0mHL1Diwl9UkC1_OGFfYas>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:07:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/4] refs: move ref name helpers around
Date: Mon,  2 Dec 2024 16:07:11 +0900
Message-ID: <20241202070714.3028549-2-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-514-g9b43e7ecc4
In-Reply-To: <20241202070714.3028549-1-gitster@pobox.com>
References: <20241202070714.3028549-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf_branchname(), strbuf_check_{branch,tag}_ref() are helper
functions to deal with branch and tag names, and the fact that they
happen to use strbuf to hold the name of a branch or a tag is not
essential.  These functions fit better in the refs API than strbuf
API, the latter of which is about string manipulations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/tag.c | 11 -----------
 object-name.c | 36 ------------------------------------
 refs.c        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h        | 29 +++++++++++++++++++++++++++++
 strbuf.h      | 22 ----------------------
 5 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d5915..8279dccbe0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -447,17 +447,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
-{
-	if (name[0] == '-')
-		return -1;
-
-	strbuf_reset(sb);
-	strbuf_addf(sb, "refs/tags/%s", name);
-
-	return check_refname_format(sb->buf, 0);
-}
-
 int cmd_tag(int argc,
 	    const char **argv,
 	    const char *prefix,
diff --git a/object-name.c b/object-name.c
index c892fbe80a..9f2ae164e4 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1734,42 +1734,6 @@ int repo_interpret_branch_name(struct repository *r,
 	return -1;
 }
 
-void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
-{
-	int len = strlen(name);
-	struct interpret_branch_name_options options = {
-		.allowed = allowed
-	};
-	int used = repo_interpret_branch_name(the_repository, name, len, sb,
-					      &options);
-
-	if (used < 0)
-		used = 0;
-	strbuf_add(sb, name + used, len - used);
-}
-
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
-{
-	if (startup_info->have_repository)
-		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	else
-		strbuf_addstr(sb, name);
-
-	/*
-	 * This splice must be done even if we end up rejecting the
-	 * name; builtin/branch.c::copy_or_rename_branch() still wants
-	 * to see what the name expanded to so that "branch -m" can be
-	 * used as a tool to correct earlier mistakes.
-	 */
-	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-
-	if (*name == '-' ||
-	    !strcmp(sb->buf, "refs/heads/HEAD"))
-		return -1;
-
-	return check_refname_format(sb->buf, 0);
-}
-
 void object_context_release(struct object_context *ctx)
 {
 	free(ctx->path);
diff --git a/refs.c b/refs.c
index 5f729ed412..59a9223d4c 100644
--- a/refs.c
+++ b/refs.c
@@ -697,6 +697,53 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
+void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
+{
+	int len = strlen(name);
+	struct interpret_branch_name_options options = {
+		.allowed = allowed
+	};
+	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+					      &options);
+
+	if (used < 0)
+		used = 0;
+	strbuf_add(sb, name + used, len - used);
+}
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	if (startup_info->have_repository)
+		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	else
+		strbuf_addstr(sb, name);
+
+	/*
+	 * This splice must be done even if we end up rejecting the
+	 * name; builtin/branch.c::copy_or_rename_branch() still wants
+	 * to see what the name expanded to so that "branch -m" can be
+	 * used as a tool to correct earlier mistakes.
+	 */
+	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+
+	if (*name == '-' ||
+	    !strcmp(sb->buf, "refs/heads/HEAD"))
+		return -1;
+
+	return check_refname_format(sb->buf, 0);
+}
+
+int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
+{
+	if (name[0] == '-')
+		return -1;
+
+	strbuf_reset(sb);
+	strbuf_addf(sb, "refs/tags/%s", name);
+
+	return check_refname_format(sb->buf, 0);
+}
+
 int repo_dwim_ref(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **ref, int nonfatal_dangling_mark)
 {
diff --git a/refs.h b/refs.h
index 108dfc93b3..f19b0ad92f 100644
--- a/refs.h
+++ b/refs.h
@@ -180,6 +180,35 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
  */
 char *repo_default_branch_name(struct repository *r, int quiet);
 
+/*
+ * Copy "name" to "sb", expanding any special @-marks as handled by
+ * repo_interpret_branch_name(). The result is a non-qualified branch name
+ * (so "foo" or "origin/master" instead of "refs/heads/foo" or
+ * "refs/remotes/origin/master").
+ *
+ * Note that the resulting name may not be a syntactically valid refname.
+ *
+ * If "allowed" is non-zero, restrict the set of allowed expansions. See
+ * repo_interpret_branch_name() for details.
+ */
+void strbuf_branchname(struct strbuf *sb, const char *name,
+		       unsigned allowed);
+
+/*
+ * Like strbuf_branchname() above, but confirm that the result is
+ * syntactically valid to be used as a local branch name in refs/heads/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
+
+/*
+ * Similar for a tag name in refs/tags/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
+int strbuf_check_tag_ref(struct strbuf *sb, const char *name);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/strbuf.h b/strbuf.h
index 003f880ff7..4dc05b4ba7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -637,28 +637,6 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
-/*
- * Copy "name" to "sb", expanding any special @-marks as handled by
- * repo_interpret_branch_name(). The result is a non-qualified branch name
- * (so "foo" or "origin/master" instead of "refs/heads/foo" or
- * "refs/remotes/origin/master").
- *
- * Note that the resulting name may not be a syntactically valid refname.
- *
- * If "allowed" is non-zero, restrict the set of allowed expansions. See
- * repo_interpret_branch_name() for details.
- */
-void strbuf_branchname(struct strbuf *sb, const char *name,
-		       unsigned allowed);
-
-/*
- * Like strbuf_branchname() above, but confirm that the result is
- * syntactically valid to be used as a local branch name in refs/heads/.
- *
- * The return value is "0" if the result is valid, and "-1" otherwise.
- */
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
-
 typedef int (*char_predicate)(char ch);
 
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
-- 
2.47.1-514-g9b43e7ecc4

