Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EC3769FA
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477491; cv=none; b=HHjzHA/0QDQt/BpWnYQS8gc2krwLiAbvVrxfQPg0BS/bJLTkXfsIIuYdGNf2hVF2EAiF13mLFZqDmrKUoipDqs5UtgQUbUJfgIxH/ia7F2j/eA+OOlhRHi6862ksKSFvgJUqqnPykyKMdOWCDNo/TavtAdhj9ilEDmi6FWpcsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477491; c=relaxed/simple;
	bh=5XQNzxglwNg/APsexodjE0/qw/KFy58zlxQ3CD56hkU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g91dNU7hwBOtq7CZVhliiKhz4HQ4lW2remZzIhef776uUDRMLQQALebKB0UgW1IU7K5PMs7Qmos9qbchT9I5i/WPFe7aYVrIFgQiXaHS76grW3HDDGgFGgiD6a8vydWif0JmfF/z/7SVNfTlGzIpUhsZhOW7xMNfXpkAj42uVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djxyc6+T; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djxyc6+T"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3074adb8fcaso261401eec.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477489; x=1781082289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbJuwcAkepoh7ChPJ5QPQOnNM7qmt7n4Xw4Loe54w0E=;
        b=djxyc6+T1VdWAwUNVJqG7ZrciV4cR1MMVZXyqgx4ktvrib19OLu1ttGJZi1QxFUPXI
         IFljGGfTFG5w7oHswwZpSoIzYI2dWWQLwkAY7xpjeJpIzKvOdtbHEtcxnGIH3k9fv907
         fYcsf0cDPP6cQlTbxuRwGPqAGMxTWzXVDX1M+0VHXoEcf84QR6co/fBW4C3G59+YrHaz
         ebZUb3yETz2jIr1Wcy1n3YPZlt+2/Q5Gv8JZSpPn4OZtSGwiT2h6ZxGi8GwhzPcRFWkO
         KkewvNJnqE7DsX/TYV7wT/nYkEb8XhuDXp7M3/fZtX8Ink/SD9sNZYnK3yuQB38DBJSx
         vbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477489; x=1781082289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbJuwcAkepoh7ChPJ5QPQOnNM7qmt7n4Xw4Loe54w0E=;
        b=lja4ZhNRG4hhN6HqThOpb+Pnz8fOqyHqI8aJEA/9VKSvV45XErQhNx7Dw0c8v0O00P
         GBDe2cYd5E0ldaJtfjS7a3zpJU5D5HuIaYIK80cNQFKxix7HBqZR9lo6O8jV3Q6DLRY2
         YrUe6Kq+Nedf2ujEhHIkMSVaPGlZPXbShLCsrNHrBNUhedP3khs0gwHgITX3vmcbowcZ
         ggVxtpvBYH1nCJJrTGSgDM4vRMcurxHTco9gRAHqkLsaewwbUqxUcf+w67SnS9IMbbfn
         l4ruhB8NCp9Fnr6I2EAOTMwmCdH3wyiHhFQaGMTded/hKDSAcpGSPojAAtyynNJhPTr2
         pH3g==
X-Gm-Message-State: AOJu0Yy9ROzr+rWcHgTZveSTy/Aa+p3DSvYXdcxnlAOc6inO8F0feUFB
	/Ysxnp1whfTeOS/jGUhza6kZMktL2Avu0mbIRKnrvj6v8a44GFS41JXzR0xYCVbY
X-Gm-Gg: Acq92OHgJ3k8MwJsEyrlMDze4724lmrH2T83Iqsq6cVih3QKvKgQlJ8ibXOgtY42Ivu
	a5FFY2Yv4D700WMF8wSoUMSZFM+5q4kwAVYPbatX3PIKyuPcM2QSJ/QEPnGr5kCDHi3m1ZlUMcd
	4pvXfkx/hl82Zgvom/6svVK8QDzAtCXS2X5yj6Xzg1nutqxfe6CybWLHKcLOVy8S41xvvDsgerP
	fle0DFD2cr5Cw4kukBsYP9O+BK9dOoRp2MsUy5JQp0tBEUiU4K5ct49QWOweLA3u1VqBFPKPp4R
	EZ6Fzhy7SOQk/p5Prt2FwV46d5MKyRqo3fBkLmdbHrsiYid65V65X7khQcJAvmTlDWnzruiRLks
	O0f8ycH8yj2pkj5P+31Rnt4uUYhBNKYRLnWTks0ILFbC7IER8q5PyCvvV359RFiCwo4FKFauPQP
	yWcFyhSQqYz5HXXahnVVUTdMjrx6MLO4IC9Jhzuw==
X-Received: by 2002:a05:693c:2c8c:b0:304:bc25:3cfd with SMTP id 5a478bee46e88-3074fc366ddmr1287852eec.31.1780477489043;
        Wed, 03 Jun 2026 02:04:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm1748708eec.10.2026.06.03.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:46 -0700 (PDT)
Message-Id: <004a96f7a447ad8dcbcabeb36502330c2399f829.1780477479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
	<pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:36 +0000
Subject: [PATCH v12 3/6] branch: prepare delete_branches for a bulk caller
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

Add no_head_fallback and dry_run flags to delete_branches() so a
bulk caller (the upcoming --prune-merged) can ask strictly about
merged-into-upstream without a silent fallback to HEAD, and
rehearse deletions with the same "Would delete branch ..." wording
as the live run. Existing callers pass 0 for both and keep current
behavior.

When no_head_fallback is set, head_rev stays NULL through to
branch_merged(), whose "merged to X but not yet merged to HEAD"
reminder otherwise compares against HEAD. For the bulk caller
every candidate is known to have an upstream, so HEAD is
irrelevant. Guard the block on head_rev so the NULL case skips
it instead of treating "NULL != reference_rev" as "diverges from
HEAD" and emitting a spurious warning.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 93d8eae891..09afdd9257 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -169,10 +169,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -225,7 +228,8 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet, int warn_only)
+			   int quiet, int warn_only, int no_head_fallback,
+			   int dry_run)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -259,7 +263,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -330,13 +334,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
@@ -1003,7 +1014,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
-				      quiet, 0);
+				      quiet, 0, 0, 0);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-- 
gitgitgadget

