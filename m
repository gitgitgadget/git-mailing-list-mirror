Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747643F08C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419922; cv=none; b=jJ2MTQCavuGGn7EQn/ErfJvHVquQnWsenXkf55oZTgtICNudNwpD7DunX22abHFFPDaMl3sG5APoyUmMoGdR3oWqfZBo/4HqKXnEmTOz7+3HyW+CoNZvC234pUDQKxVfTgB9H4nYg5Nv9bEVxlYFc9OC0dWeVV0EnC5zqu7ngJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419922; c=relaxed/simple;
	bh=TrNo6oU/eDqM79PpPncgPOFK7QbAItjqVMOnrt/jFBs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dIgzX+Etgzc+uRIq+NYDRU7FsMTHDk/TB359JXUqbo0ZJPGbDVHF+yrULhK4KXZsQBEQPp0iavZ7G5+bmvcbjM3Wn0FHmzyVmZkOd32wa99xBv2lZYG0JljbnbEPQwQpG6a1UkYTNQzhVfc9ZkK0jjz17LG2KKuvEDLadXRvsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esxYSL7r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esxYSL7r"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso757594b3a.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419920; x=1786024720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sdaSypjsskN157SYYr5oaYvn5KtmMJqBKV0m/Lp7/LY=;
        b=esxYSL7rEnIyIc8G6+vaHYUxYjNUP0cp4S2FvceYHh7vujzULefHGteMdTLcHumHmP
         1nxITjLszXd6/8JQIMaRanX/V/53qt0UTLAAlLyake7sKT5sCZDjXdB6LtydQ7zH7Fo9
         P0l88hdWVjEjf+OmoVnughYmzGC8WvOt7ZRNtIK7b0mZ0boQss3jX5DI105llZaC7Uz7
         Hnd2BcHe75f3FhyiTwANnCXgISZ+/4jeoSo7smsnEcQTvoQWaWnb5NOEQ58uLsTyzgpK
         Hriq9Hn3PU3DlE00VY5e3iWfvFyjToZytz5uv5lsSCResM9EPE56U0V4mLBcWY3e/vNn
         +4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419920; x=1786024720;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdaSypjsskN157SYYr5oaYvn5KtmMJqBKV0m/Lp7/LY=;
        b=SU2n8fDtswr4Pzifvd+r3ony0/vP0u3Kfro3PBAPQv94aJveyBdSwdYmE7Gv6Ax4bx
         IctY97kWlYsYiuNBbnEaBp1DAcQn/B4LYPcQzMivJndOjkCN7OYXf/YBn6G/iPTr91rI
         xyntQChwiUSjy96aE/L/7GASAf0f/HDfOHT9S17XSyvBxPVETTxOQyeJ1TdaWJBcKSDm
         hxqRwFX4ackht0dGiC/ujRELR7STMAv6Kif7lkKgoSLHDjGvWjYhcTukYzKIDNc90iXN
         t+h/P9OgnhAFalZ0Pe9lg6fM2jNSrQGk25FAcoz5KhXr5r2WLssC2+tm5ZIbb+8dDpyK
         c3Hw==
X-Gm-Message-State: AOJu0YyYFpvKtbTihryNGjAJ5g67WGa0Je9mNw5wt/G8rCi+mdtBLom7
	svuJhgoz2KN/K1mpgQ+KyHTcmyJcxySBP7qXKJqBONhjNHmNWnQDPQSkVuPY1w==
X-Gm-Gg: AR+sD13go3/PMFH1kwjV5NC6Vm8aj2nea+EApA8mZwAzq93+LGJQK/fjkBQGo2PTlpt
	CQNup6e4paiilgFeBedry9A+TcfaePxgOEuPNBJcrXgg7X6jMsO7BkqoRwiU/l/OAGXYsfDZURj
	kyT8nDTPeqnGVXqbJlJjYMYwPkSMbLItLUf/2VMonjvN0nKZr4vkAeTNJloIZ6GSo2dy5WfLKcW
	MIBGWTqLtlU1LpbGmzKzzwRPDs/piD2HgedxuI1VCBwjuo3LT08bCFZDIJp4AeKm0ZIt4Br+R4C
	jGo0F3qch9F+H0c6vDqPPccpB3wVvDg/Trl+AxT6NebB06Y3vGB4gQSPPzWWUdICIgd7qVbuGQZ
	QfTYnwB9WQ6GXlkOxtRp0LlhuEKNgk72jB0g5e1dWK7Xrc+/uos4n5z6rsDKYmvGKOg7cJflrSo
	wbbl1kG/Zrz6hlgbcmYB+8mb/iHMy+x4h930ee9aydH2Gro0rMo6z4p19IxZVNRPe8
X-Received: by 2002:a05:6a00:12e9:b0:848:52bf:4296 with SMTP id d2e1a72fcca58-84ec9c6ac8dmr406414b3a.15.1785419920096;
        Thu, 30 Jul 2026 06:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8461sm3144182b3a.28.2026.07.30.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:39 -0700 (PDT)
Message-Id: <5d310da9aab4c969a21c409ed35d9913fda78f5d.1785419916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:31 +0000
Subject: [PATCH v24 2/7] branch: convert delete_branches() to a flags argument
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

