Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FD3A544B
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921384; cv=none; b=SH5YaNwwazEDC0Le8fHXsH004Mti8udHNW6b/SRSXWW2/cdQfb75VdnlWFbY6+2SaF4lTEG1hZDQb10OsfeXK7PaMhouDGFg6sTrP3yX4VJuNFWFP1x9IpxkT0iyrMtRUOssK9rdjzV7SAfAAaOhc4Lvf6mLqjjtGD0r0tp3X/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921384; c=relaxed/simple;
	bh=c3ovUYlOQcsrR9xZ9Q+5wzFbLSlLM/ljV8u1POCfUt0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e4bAd2pZCzv6buH8j2upJBhl1rbtIPkwCkjyQPqT12LdUM08vS0Olpi+SIOwwTdLsdlhh/Wbq+c0gPwp7IVy8EbdY/hoVwnGF0d/55Gt6yRzfjXgHEnDElnoJVfOGmnqA0b86fo13Zo4EwoUi5e3iTVpj93W6eppAq3zY6TkQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKNrb+p1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKNrb+p1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so895220a91.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921380; x=1785526180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=gKNrb+p1o+ckRzMnMdcdZ69IQZajivWyid3XobDqmVKzbsw+x697lTLO3qcwRHAotE
         u6dbDs2fFIKMyH3BMzdVJpXt2U179HQLWLPb5q/PAHiudZ7zfYRatr3YoQMhmZHCMQjI
         jZdZ+cCbr0LiiKpJH/L1AkNfpxo9/ZqKkBD0ukPnVlu7dflglbcF3FsiHn/kYf0iFRaM
         L82EPh+GYDpkc/gk0wSHmC5W+QrzsRRRr/78CCBjiIk2qjux1Zu2vJWSIq90Csk48Qg6
         H/uuG+paXTbgtDyHL4XFrn3RAV7SLt2EZgMYRrOxo3v/KN/snnOiTrdfD2TmOsmaDVBQ
         jepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921380; x=1785526180;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=bQG/353kVqFS/To0U3Vy+ImoJZwFChJD/lUyf5vtnwODkOMFhHXrGEMDx+J+aKReor
         RZy16807zGDteJF1DrYDSiImh/Yku0VJJKWYcCancz+H/dgjrGxknpTe1f5s2NRjh72Y
         nKOmSmjFkoccOiOp3acLw4//Er7j4z5sdAFM7Z7cgr5MBOVTpo80Tydv/bfqpmNW1doU
         3udccIQ8/ypw8hYknZdTtKIAUyhyZHNEJCJLFPbjkayP7hBOKz7g8ng6UCeY5X9dLNyl
         4gOcDQqFIYnbN6K30Ws5PLGFXttTrA8v/4uLiNS61UhGrkp2aEU3qL3bHZXiBM9iTakQ
         s0Rg==
X-Gm-Message-State: AOJu0YxTuekoYedeiPla/NHCwDHM8BS/x1vO7hZ6UI8LE6rxF9Ym48T/
	cLxysMrKOf9Bc6Dq7H8mwadPP2tpqRfNbiOLcwZjiR7Bacj9Z6Hsm3leUig3hgL6
X-Gm-Gg: AR+sD10+1bq0eIp+G+I/M4eWEWA4KJBt6V2SodWI+ziH1jYmUo80AuVWsilCe+2HJM+
	38EC7GwDRCknNXS9BGQhrxGvG6kmfSevbVmr8qaoydUSCfkI9z9Lt+Y78Sqq52eKuXZWgciU5nR
	0BJvli4+MBPFwY52lKRA5Hku/1hvLCWN7Au4jkH+qL0syaF5eaIqDrqKjSxNxAFKzUA6fRHoGKr
	4C6ASc8HL9XXunIeMQo1xGE+i7ajclqV+kmxVYUv+DhaUQoEV/n6ZBiU3E41AFwg6fqY2922kgG
	+qa7WNsJ0kYVFWOiKsG8zTjcX10E11oBeBHfBywJ4KSU9LaBpEGtoFTb6nSWjYARF5I1FuYM2cH
	Tf2vXZUiojY1MrxZ/zSda7PWT38DgmW3z1oRcfju4hJnGOgai7yxoaepZeqROGBFh3PJXJGge8Y
	27WB9g2g==
X-Received: by 2002:a17:90b:1850:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38ec657b97amr8991577a91.17.1784921379843;
        Fri, 24 Jul 2026 12:29:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm46011587c88.15.2026.07.24.12.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:39 -0700 (PDT)
Message-Id: <048c002cb4bc4d5fe107406a6da0479807db4b49.1784921375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:30 +0000
Subject: [PATCH v22 2/7] branch: convert delete_branches() to a flags argument
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
index 3ac1272d7e..09631f93f7 100644
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
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +285,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +297,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +312,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
@@ -330,7 +336,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *name = item->string;
 		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!quiet)
+			if (!(flags & DELETE_BRANCH_QUIET))
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -895,7 +901,9 @@ int cmd_branch(int argc,
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

