Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2D13AD38
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193169; cv=none; b=jC1hjg6kbt7NRPiQ2ygFWnf8yCua15je9rH2tf7AiUf9+eMf160nnNc0bDjdziFOOxSHE2NxqhZKNqcNodUGx5GHWi/fDrS3MSrG/SpXFFLEAu1mPDPgfYEW+KJPhfmhVtv3UPn6r8I/c06f454es09NOO1+5JIiNbvTISyUZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193169; c=relaxed/simple;
	bh=lrwVM3gsyivVMXZP8LqhCFGLWQwrTrxbXQOEHugNvtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLmDDrgKFg4+aUiq+ENKjtWPrXPb80SP4c8jvBsfn75Tz1oZZpp2mTr2xPg4CcdVeUrSzsa2dDDwLjCVvIGDvW0jlyZb1ZQSpomCktvon1nVwtzVAXh2DABR+ilDrs61O8pk+pCR3qFhhl9Y4bxZ/nsJafEDU837yxb627eA/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ei0zEV5I; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ei0zEV5I"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FCE5114017F;
	Mon,  2 Dec 2024 21:32:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Dec 2024 21:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733193166; x=1733279566; bh=J
	z7CHZHFdlXXu9Mbb0PAclikjm3A2vOIERiFNavGDpU=; b=ei0zEV5IrM6oyhqOR
	NwV0UdOVD4FG7O2BWXpiIvXkrTlqvrEqqyn/RyPDro8MzTDCoAJsPgPUUr2BjGHI
	BI0AuWs88S1Z3M3sHaf27LGWcrxSfmBnB8Qd6fGiNeDiB4Y5nxocxccR4VitYH/9
	wi1YVfMmrHLfKAM4ArbW6A42/oz6He62V0G/FKgZY1ujBcuJZWDU8P/8o9J5os24
	o/5jykQaRHeluOaISag2jIxenqfqrQewqCuZxnoBNiohYn6Sq0zTb4eNcX/vcpxx
	z068w0VYY/E9qvVWQ6PJmnsdThX8kwYGaxm5r+mjbeD8uoD7N31Ku35fJh0dPfDH
	B3FoQ==
X-ME-Sender: <xms:zW1OZ9zvbMdUKI9UUoaTrRK0Vopim6wY3jTM1QtCgBWH0NISdABx4g>
    <xme:zW1OZ9Tkp_ddaaRRBjZBb6yEi1v7H6Wcjqi2sbkrkK6yugoXLrlGW_WQiiob8ABS6
    k7djDA3uD3TPGWOpA>
X-ME-Received: <xmr:zW1OZ3U-4wxuIKZAHU5QiPpizkdyWEJvJA7mmC2b7qBUgagT1wIWiHks5cSqTuRNbQRnGWTuPn_CuVeyPe5tGEq0DpmGQei2S8jruGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedvffelhfeutefgkeettdfhudelffduteelfeei
    ueelhfdvudeiueekhfdtvddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zW1OZ_ghnvVilELOOSlyleViMXAiF8UwyiYe9Ggui1SDSN9D-mUQSg>
    <xmx:zW1OZ_AKvUOuMIFwnjiQwkHxYG1nEMFFxTke3O_eICOr1e2tkp7iZQ>
    <xmx:zW1OZ4Lkd2XZj517hRiEg5YDiTiF3cb48jupNyxa90cRtUXCB6aqPw>
    <xmx:zW1OZ-CozsElVdkuJNcfu-B8d00O7vtoiqZ424pydpzSNtVWIVZf8A>
    <xmx:zm1OZ65xtSY5XEvaNMgc-dmv9BNDFCL46Fk9PPrXGcLzlnjUd292a69U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:32:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 2/4] refs: drop strbuf_ prefix from helpers
Date: Tue,  3 Dec 2024 11:32:38 +0900
Message-ID: <20241203023240.3852850-3-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-515-g5132b7d2ef
In-Reply-To: <20241203023240.3852850-1-gitster@pobox.com>
References: <20241203023240.3852850-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper functions (strbuf_branchname, strbuf_check_branch_ref,
and strbuf_check_tag_ref) are about handling branch and tag names,
and it is a non-essential fact that these functions use strbuf to
hold these names.  Rename them to make it clarify that these are
more about "ref".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c                   |  2 +-
 builtin/branch.c           | 10 +++++-----
 builtin/check-ref-format.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/merge.c            |  2 +-
 builtin/tag.c              |  2 +-
 builtin/worktree.c         |  8 ++++----
 gitweb/gitweb.perl         |  2 +-
 refs.c                     |  8 ++++----
 refs.h                     |  8 ++++----
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 08fa4094d2..58b61831af 100644
--- a/branch.c
+++ b/branch.c
@@ -372,7 +372,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  */
 int validate_branchname(const char *name, struct strbuf *ref)
 {
-	if (strbuf_check_branch_ref(ref, name)) {
+	if (check_branch_ref(ref, name)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
 				  _("See `man git check-ref-format`"));
diff --git a/builtin/branch.c b/builtin/branch.c
index fd1611ebf5..17acf598d2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -257,7 +257,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		strbuf_branchname(&bname, argv[i], allowed_interpret);
+		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
@@ -579,7 +579,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees();
 
-	if (strbuf_check_branch_ref(&oldref, oldname)) {
+	if (check_branch_ref(&oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
@@ -894,7 +894,7 @@ int cmd_branch(int argc,
 				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
-			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch_name = buf.buf;
 		} else {
 			die(_("cannot edit description of more than one branch"));
@@ -933,7 +933,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to set new upstream"));
@@ -963,7 +963,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to unset upstream"));
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index e86d8ef980..cef1ffe3ce 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -42,7 +42,7 @@ static int check_ref_format_branch(const char *arg)
 	int nongit;
 
 	setup_git_directory_gently(&nongit);
-	if (strbuf_check_branch_ref(&sb, arg) ||
+	if (check_branch_ref(&sb, arg) ||
 	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c449558e66..5e5afa0f26 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -742,7 +742,7 @@ static void setup_branch_path(struct branch_info *branch)
 			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
-	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
+	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
 	if (strcmp(buf.buf, branch->name)) {
 		free(branch->name);
 		branch->name = xstrdup(buf.buf);
diff --git a/builtin/merge.c b/builtin/merge.c
index 84d0f3604b..d0c31d7714 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -498,7 +498,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	char *found_ref = NULL;
 	int len, early;
 
-	strbuf_branchname(&bname, remote, 0);
+	copy_branchname(&bname, remote, 0);
 	remote = bname.buf;
 
 	oidclr(&branch_head, the_repository->hash_algo);
diff --git a/builtin/tag.c b/builtin/tag.c
index 8279dccbe0..670e564178 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -639,7 +639,7 @@ int cmd_tag(int argc,
 	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	if (strbuf_check_tag_ref(&ref, tag))
+	if (check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
 
 	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fc31d072a6..c68f601358 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -432,7 +432,7 @@ static int add_worktree(const char *path, const char *refname,
 	worktrees = NULL;
 
 	/* is 'refname' a branch or commit? */
-	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
+	if (!opts->detach && !check_branch_ref(&symref, refname) &&
 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
@@ -604,7 +604,7 @@ static void print_preparing_worktree_line(int detach,
 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s = STRBUF_INIT;
-		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
+		if (!detach && !check_branch_ref(&s, branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
@@ -745,7 +745,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
-	branch_exists = !strbuf_check_branch_ref(&ref, branchname) &&
+	branch_exists = !check_branch_ref(&ref, branchname) &&
 			refs_ref_exists(get_main_ref_store(the_repository),
 					ref.buf);
 	strbuf_release(&ref);
@@ -838,7 +838,7 @@ static int add(int ac, const char **av, const char *prefix)
 		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !strbuf_check_branch_ref(&symref, new_branch) &&
+		    !check_branch_ref(&symref, new_branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b09a8d0523..8cdb0d9b9f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2094,7 +2094,7 @@ sub format_log_line_html {
         (
             # The output of "git describe", e.g. v2.10.0-297-gf6727b0
             # or hadoop-20160921-113441-20-g094fb7d
-            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
+            (?<!-) # see check_tag_ref(). Tags can't start with -
             [A-Za-z0-9.-]+
             (?!\.) # refs can't end with ".", see check_refname_format()
             -g$regex
diff --git a/refs.c b/refs.c
index 59a9223d4c..a24bfe3845 100644
--- a/refs.c
+++ b/refs.c
@@ -697,7 +697,7 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
+void copy_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
@@ -711,10 +711,10 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 	strbuf_add(sb, name + used, len - used);
 }
 
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+int check_branch_ref(struct strbuf *sb, const char *name)
 {
 	if (startup_info->have_repository)
-		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
 	else
 		strbuf_addstr(sb, name);
 
@@ -733,7 +733,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
+int check_tag_ref(struct strbuf *sb, const char *name)
 {
 	if (name[0] == '-')
 		return -1;
diff --git a/refs.h b/refs.h
index f19b0ad92f..c5280477f0 100644
--- a/refs.h
+++ b/refs.h
@@ -191,23 +191,23 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  * If "allowed" is non-zero, restrict the set of allowed expansions. See
  * repo_interpret_branch_name() for details.
  */
-void strbuf_branchname(struct strbuf *sb, const char *name,
+void copy_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
 
 /*
- * Like strbuf_branchname() above, but confirm that the result is
+ * Like copy_branchname() above, but confirm that the result is
  * syntactically valid to be used as a local branch name in refs/heads/.
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
+int check_branch_ref(struct strbuf *sb, const char *name);
 
 /*
  * Similar for a tag name in refs/tags/.
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-int strbuf_check_tag_ref(struct strbuf *sb, const char *name);
+int check_tag_ref(struct strbuf *sb, const char *name);
 
 /*
  * A ref_transaction represents a collection of reference updates that
-- 
2.47.1-515-g5132b7d2ef

