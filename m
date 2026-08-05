Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750437F728
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939907; cv=none; b=r6vMXbdG2f5Y8huVq66rlH4hlUTqbF5HOCmGf8ZYfo4Y0rUfAm0t6VYGPHWzFJqN+6u8Qv2Yji4ImBlo4S/cS36Dj1QvdJZSBylDnmq2SAX43cgvv2WNCAlwjF9blvRcyvBVEMIte3nJrqm3qPSDT5nslhKikHsSvFeQH9qr+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939907; c=relaxed/simple;
	bh=TrNo6oU/eDqM79PpPncgPOFK7QbAItjqVMOnrt/jFBs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YQg4cqz3E1JaFtneBy6i6cVNLwgWkVbkGvoPqz5O7CqF13uLu7+NVWpFB1H6w1WF6WgvNn1uKlKdMjXQeLcWHgq0pfUyrQgIgk0gVJyO/rO6zd7MlA7lC8V8IVnWxm/x62mI5/CCuyjvzlSWJH+u7vJ2xDZQQ4DpBd1geWjhfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZoDhjgX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZoDhjgX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1031734a91.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939884; x=1786544684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sdaSypjsskN157SYYr5oaYvn5KtmMJqBKV0m/Lp7/LY=;
        b=iZoDhjgXNQuDVYrDxxwmw1/72KAgVunwzzM4v1UEBGXnMdkXYHjy0e3Fk6pFbm6BFt
         mcd/iHcOcFtOtAq3rB6kjqlnik13fc97KxWomLiKq/rLNN2IXOFlEr5aFwcvTrokKWyb
         Gfr07ll3DBGNqLBwO6PLaI4B94wgJVhDVkWo9pDtQh931+D7Xr08/qP+qds4OTpc12at
         A0gRa60NVNYSuWKnMZc28WhlxP6Xig+IKRQjWnlw2nf6glrKGdkHa+WyTOchqKSlHYzE
         +yS/SmRT0mGJ0/t/aqLNYOaAM1CwIla8wv477qQRsjhVDYUfPXtcZ/4k5W74PuZ07xc3
         KuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939884; x=1786544684;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdaSypjsskN157SYYr5oaYvn5KtmMJqBKV0m/Lp7/LY=;
        b=e+oiibQeoBm8FCZKpwzhHN4UoTzg21CQv5rm/GobHKvSmRfVEejRan6yaNgUebywIs
         STgHKKVrjKO1l1p2LfBPZ2kZAG78ekEsEMF/awGED2RYwE5tCDagFIQkkjWhAoC7Fln5
         7Fq6NZd+GBwYWmlQIcrEXkbP1952oA0qOcp7Y2/I+7XR8sD48KmMQPcInXbri7YqioNN
         e0iaO8kDNm4gJqeIReiTVhcJPBI0ICIzTiY4VbqkDnDqfltrzzI7Xm0A1odlHd4bGfoH
         ZjPQQTFoAvYodJz+qEAZdlXtdF+a5q7dnyuYqwXJjiYN8KWrzg4r0yLhaadDxK/InBP5
         XbDA==
X-Gm-Message-State: AOJu0Yywf65V1XzhmLk6tHxnynUJzciOBgdALTjw8ceQX0axAAVRuDhK
	EiL3Gewt0ksh4q8br7u9g5v60Eo9XUpzVMz4AsqllNAjj7iBGJ0v4+B4jOk/oA==
X-Gm-Gg: AR+sD11Sl0rCOCWLLL5wDke2j9SImF7ftmD9s8Da0ElnLAUzp9w/RS56qR4U6lQOimJ
	e/B9mGuhH49rZN1ov9KWUhbWRennKhfprUwFK7gS/0KCv9Ke0XmA1VRvGhi5Pq0FutT2xWbS5ZI
	pb4ZH//0GARopRawOInM1Pxog/Fbl+n0zxJ2ZYJaQ4gK3iow63PFvjfvllQcv3ghPgK5RQsWLqd
	/PFrYcXi9xgXCQOO71LYifp/UuNjr7OhsUb130Zqo+LAYofEqSSeE3Vt6YLEsdM985yqipMwoB7
	pJNG0DoCXffjfwlw1QCUJ2nEZuSc2Xxwju/KPG8S8itK5Pi7nKxCtq+V6jgDIYYoeNexJWHTlRM
	TKadIcyv1vO3FEcrewUwJ9tgdVjIGUO8gWkxJindSnG437vRZUCT6WiAhCa0p7EJ8sXqh2Qaqn8
	XIuSoxvyVqZKY9aSqxYhq4PDjGV3Pf7sFTbPR7pU8uN7T7x/uapFFg1teVGQNBZd0khA==
X-Received: by 2002:a17:90a:c107:b0:38e:6f90:eabd with SMTP id 98e67ed59e1d1-3903c53783cmr8586610a91.5.1785939883540;
        Wed, 05 Aug 2026 07:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50acddsm14788149c88.3.2026.08.05.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:42 -0700 (PDT)
Message-Id: <2e80fc37919a6eb33ff8783dbcf2dededb3ed7b0.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:32 +0000
Subject: [PATCH v25 2/7] branch: convert delete_branches() to a flags argument
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

delete_branches() takes separate force and quiet parameters, while
check_branch_commit() takes force. The next commits would grow this
collection further. Replace them with a single unsigned flags argument
and an enum.

Test the FORCE and QUIET bits directly from flags at each use site so
that mutating or forwarding flags cannot leave cached values stale.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1ab4356188..db7cb01190 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,16 +189,22 @@ static int branch_merged(int kind, const char *name,
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
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
-	if (!force && !rev) {
+	if (!(flags & DELETE_BRANCH_FORCE) && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
+	if (!(flags & DELETE_BRANCH_FORCE) &&
+	    !branch_merged(kinds, branchname, rev, head_rev)) {
 		error(_("the branch '%s' is not fully merged"), branchname);
 		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
 				  _("If you are sure you want to delete it, "
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
@@ -241,7 +247,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +258,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!(flags & DELETE_BRANCH_FORCE))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(the_repository, &bname,
 				argv[i], allowed_interpret);
@@ -280,7 +286,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -292,7 +298,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -307,16 +313,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
@@ -331,7 +337,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *name = item->string;
 		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!quiet)
+			if (!(flags & DELETE_BRANCH_QUIET))
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -896,7 +902,9 @@ int cmd_branch(int argc,
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

