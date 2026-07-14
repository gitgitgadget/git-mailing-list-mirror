Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE04156D2
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053503; cv=none; b=hgpZ31FMdRb9yV5dKLg6FoIH2wYaB6zF1S1JCmkw4Q9JlbGbNkGM6KyoMz75RfUgauiOpUDzxZAGLNAqj+XlouBMsk8GOpuysDwXNuAQXpHBuBenrpdcxTpArM64kur7iY3jrLAgQzUtViErfVanoZ4Z0rep5MyPuNDQNOD+It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053503; c=relaxed/simple;
	bh=Oy4hbNFWRPKlCmJseRI4LfwY0iGpdayjUoA/5Mzw3LI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tq2AEkXFFQXM9M03ZUd5KAwOKi+MadAHTaUOEiKAvrutZbjqMDfR25MnsMr2drw1HHd9RDA6xs9Q33bkxlhFBvdZ3ZzAyBmEYmDt9E2rrHnZ8ruw0AKnUAnoSMzmfBX1N0REXHVg6Yb7ZOnL0huTmY2q4X5Ht0BDAcwsO/Y+bBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvfhff5O; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvfhff5O"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4560511a91.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053499; x=1784658299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FsVIpUsvGZMKQbAgsiUyEgVTSuYQiHypPSU9SmVeCeM=;
        b=cvfhff5OlcWWRU6GtEAfM/JIpxgVMbH2BCe3C9/E9ln0hJKz7Bs6j9zZyEIpLKn5tf
         GXQf49fK4+LE6iLB6V/TNywVzXU2qbXOhYCCURD3ymX4okpLtTXW73bUrCcnd1y6p/BY
         TaI723DHdrfvhqNWMCfwDTJympCjLHt6BUqY8YccVWWkrqJqzEkfcjYaT7b1wo+K1wEB
         pg4aDsicVbdlaoSZti2/Q9Qxv03S+m38RYZT1O1r88DdMznl4eMkkvP82GNbaoVibBkg
         ItNklwhwXI+k7PuFqZaNtLpv/2DlqYgIAGrTIoQlC2J6EwM+qUF6lPXeYXVvziCIRAZ5
         ycYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053499; x=1784658299;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsVIpUsvGZMKQbAgsiUyEgVTSuYQiHypPSU9SmVeCeM=;
        b=TuwZGA5d6Kx97kNLlj+hE/qwBjjdNqtLTvsSeDX77M0mH5GUpNLtWtj7R+p4kAZDgn
         ECTiXWz+h3NnyQMX2WDxs9B8Ulc7Iom2aZWtHBsozkpyBWBqJYw9hNxvD++HvRt4cemR
         HvfjridUEEy95zNAncSR9cGSSYw8lq3psGoJ4IW8+t0S+Exu8EGkidtmXFv8+hqrTm/u
         sqsU/2ha4ZKbAuh4+xCMBqS+rCGFAMgipkX4NNtwEixVID5ni17otaU1hpRSedFqr0Sg
         w9tOllN2nucJn0XRGE+CEp3MJqd+Sh5IRCnfG1CCiLGeoV5l3mW3oZXiKuuctuxkyqtP
         i3sQ==
X-Gm-Message-State: AOJu0YxoVTXEfVtOk3+DdOszT0FtsIMH9wdPzM8XIElevky66skH4PLV
	+GjtyZC3t289G0KG73rkjwYNrNFiwGMsQKSd1Y/7ZLWS5t/6eMju5pJIzWr+4A==
X-Gm-Gg: AfdE7cmV5oGJScA13cicAmMT/2Mmg5z0FwZ8g3dRvDR1VWiAvotaiRhO08fu/gjkda3
	lo6Y26qFU9keKFvYFw1FvH6Oqw/pXJX5hmdLph++EMB6vqniDeG4bqlHLh2q/VfmL2FB4UplvkZ
	jTXTK6NaVLnNDj/REIlCb+nyBCky3Zox2G5VPv4KrhFMMwD0DYI4VXQtcltmClOrF2Y5tewekJF
	q9JsJ61/U/+KwhxEmYcHT2+HYANwZJsbIFNk5EUGYMuxeJZ63Pe/KFajkAEzNFlY5UbrByBJwFG
	ixtXRSpeUwEajEGYbkZcPidKFo+1seiy7dp1KPSGyDPOHcMqSDAlj99obU5XE8chyKfXXHJ2BP8
	f5Qf1Yq2o8hHgDRvlxU1HoiPkRe0RG8VQm9MS+YSOA6dtQEZhpOWB532ABTqL2g0xbNd7dJy1qc
	nK+5LZ3tqp+wsMDK7d
X-Received: by 2002:a17:90b:55cb:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-38e17dbad69mr4311913a91.13.1784053498925;
        Tue, 14 Jul 2026 11:24:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm85284110eec.30.2026.07.14.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:24:58 -0700 (PDT)
Message-Id: <c7ebd9344c620772e5bf5260cc16b356791b7ddc.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:48 +0000
Subject: [PATCH v19 2/7] branch: convert delete_branches() to a flags argument
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
index c159f45b4c..e905a13a95 100644
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
@@ -872,7 +878,9 @@ int cmd_branch(int argc,
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

