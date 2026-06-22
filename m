Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78A36D512
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113397; cv=none; b=V4BVHLGwP+jLuk2pCn8XNuwPOpgf88TG0t7gH6/r7HPdHCVarbyDlX5E3x7bmSYtytcRuo04Rz7tPueZkvnOoJjTHdI/XL9qRjhs4Awx6MtKto2GkL4BrVUneeh9nJnEO9Y6RAewkhwzh7b3QxQPBwg+2ALIKb7x3Xs9XMwC2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113397; c=relaxed/simple;
	bh=KjiGtruBVnrVqEUprHuzjMyaiiabZgh7TFUkoeQ4xis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AIZvBpMq+OD3Iw4Ymj5OGHS2WVoZXMqvf0t6WGbca77PoqDdkzwc+11+DuVaa8Gh6LnJ43P0JxkKgQwnVF+FoNNdDXyUyfte678B+Jywe0lwNUGtNsTFceGBJclPqK0KnmFqxyXaZp6t/I2avEe4yb4UZLZyqYKna0q5CGhsI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fueJl+DJ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fueJl+DJ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139a71baa35so5759455c88.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113393; x=1782718193; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=fueJl+DJNoXGeSLUtP7PUPQ3ZqM1FOi+Z0gSpPpkdiyrp70t70VYP2ni7xi9S1492l
         h0UFnIuH7E/qPFrqNgZOxA3guiYR/Z9qcR10IYtLPBV78pqrmi8yxRRg7SXHUBNEYr6J
         oycw3wPQ4tSbdAsOTkni0+gEct5NqBuEfDBhtH72j+afvlo7ttPbkgGEJ1DLluOav6W0
         CMMhU1zqx4ed1LxlXLd4F9WzH+AKfLoB7ywn9sVrSOiSKIFfACofg1y/IDB43DqCP/c9
         wb0YXkTAb4hO31f4+3LoWLxgtLCmGfSa4CJq3T+WcOtVzzn0YW6YydOybYVAe83NRlgN
         NYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113393; x=1782718193;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=mXoI3aEhxO0qLZl72Otz6mULy3fKnXLyHzZrEl0tzbXTJqHt/C1EqMgkLfvYAwoYTV
         7mCq/CR0JWBDYo5zP9ZV0FiZEh5CDrh6WKtwMWHd3uWpOZrE5g8sMTs62d1vht2twea2
         h8XGWhrX3ZA8qgfauhhC8hRBqsEpBAoRcYb1S7cD88/JD/Xp231Ac8DZQorZwiaLlbSJ
         Y7Z33wBuCnIbbSMQH2fkl5LR3prVKgr2JhfWX9rQaJMRQD//eVMAXU5cdXRNNgpvhpeP
         8p3Z+qKuUB2wnlxnr38ee+HkH57qH8cvsCMYmnj9csDNg0aMADFYkYxmlvo5bBpC+mUQ
         GLtw==
X-Gm-Message-State: AOJu0YwVQs0HArieBcJ43PEHKgnX6KHAzmyBepUaRI276pXZkSuooqfg
	ueeG5fCFdS4CKYmFFqK+BUvM7Va+3RqHuEEkuuYtUMl74AOlGaZ2ta5/Latwqw==
X-Gm-Gg: AfdE7cmDVmFzkDXPvdn5ZzE19bERAAm9J2X+sZyp30S/lBOjM9Yy2KsKGCwgWWpsGVQ
	NsyAc6LilGY8vPitY+zLrF7OHFkagWiB4Qdgcloz0QvCCFWcuBNZxaluxbGBbg4jxnHNxn6qZId
	uSu0toYnHpgKqnGrEl8gJma4JBSeSEh7hNWSvs+k/aAkiWjOSn39YvemEt4cjb1C3VrD58qbMaS
	8wZyIVhWOkWy5sTF8zhbIlhKysw/CUmlJYQ4mZsbRO0C2KrO50bVSWTtQbod2SK+7mc4Cn5HSLh
	NcEqKK32J2gl7F5OZ/I7lXcUSdo27XN2id6Yb+iVFKu0zp0Qd0IDt1GmwiWaXeTY1jg6xytU5oo
	ddjB43SFMg79dNC5xsH6e4DhLFpNF22RK761bLhuJrsIVYTSeTBDJ+1CeJV1gM84cq377wcxtlp
	CwP0P5VI2FQgdqIkyo0Q==
X-Received: by 2002:a05:7022:628a:b0:137:699d:7b95 with SMTP id a92af1059eb24-139a367408emr7674965c88.19.1782113393379;
        Mon, 22 Jun 2026 00:29:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm7059157c88.12.2026.06.22.00.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:52 -0700 (PDT)
Message-Id: <d14b0403f08bbb066905cebab4471bc480f73dbb.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:43 +0000
Subject: [PATCH v17 2/7] branch: convert delete_branches() to a flags argument
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

delete_branches() and check_branch_commit() take a pair of int
booleans (force and quiet) that the next commits would grow further.
Replace them with a single "unsigned int flags" argument and an
enum, splitting the bits back into named bool locals so the body
keeps reading the same named values.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c159f45b4c..a9be980aef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,10 +189,16 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+enum delete_branch_flags {
+	DELETE_BRANCH_FORCE = (1 << 0),
+	DELETE_BRANCH_QUIET = (1 << 1),
+};
+
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, unsigned int flags)
 {
+	bool force = flags & DELETE_BRANCH_FORCE;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
@@ -217,8 +223,8 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+static int delete_branches(int argc, const char **argv, int kinds,
+			   unsigned int flags)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -227,6 +233,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
+	bool force;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -241,7 +249,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +260,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
+	force = flags & DELETE_BRANCH_FORCE;
+
 	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +289,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +301,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +316,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
+					flags)) {
 			ret = 1;
 			goto next;
 		}
 
 		item = string_list_append(&refs_to_delete, name);
-		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
-				    : (flags & REF_ISSYMREF) ? target
+		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
+				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
 
 	next:
@@ -872,7 +882,9 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, filter.kind,
+				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
+				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-- 
gitgitgadget

