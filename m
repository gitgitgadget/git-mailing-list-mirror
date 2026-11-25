Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611184;
	b=Bxaq047rY/C4AhyFPuS0Q5a+mUPHkqnQ50s4+m8szRWQJLdmZSHNUM93qysqJLttBASP
	 orcqMBI0tQqwQeFGvF2cl0gpFB4JvZ8UMkspaUqSiNP3feV5bvdtWNOJ8XbeGqXRMaDsT
	 IjyRoNEXif+d12So9OVk2kE8aJKJjCw7lJaBMJNTE4lpICqYUQ3mSguIQZUUl+mn6itnK
	 Ng5CiCoAukQIOXx6TnvakI0lJ/x/TSaFAhA7edH72Lmg+8jIPECo4nTulPRQnCUZdiia4
	 TweSDGPiDeS1ehBMnUoUApJJnyKSOIJfnBsQ2LzCPLI0Kt8nbbnkMNmFaKuPBsJLdZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
	b=Td5pwvvKbXlINC4nDV38vkrVuobzgJzV8utafsqCbtcTylHP7VqlT3f31OyaABCSbsxq
	 i0nFv1j0FxSSLT//lYRGtCHu13j2ElrZbrV+p9fpL67V2mVMj6yLXL59U2lSh4QDJ2oXw
	 nokh19Mw4eGHsDD6/f6DXSz6qVDznX8DXi196w0DzdCsABzfbwDVYeAQGbxgOS7gFAINo
	 ef8COgZg2CPmjaHljspgKubTewiaChVwC3fylceaEb//3jQGlKVKcB/WWz667ERsYen7B
	 QCDqs8KxQZPqxJFCYz+rdQwAfmOSldAj0oNT1D3XIMXGhZyypj0VLCiEiPUpqfosAqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cf87sovl;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B46606A335
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B46606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cf87sovl
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-843b6f8e2c7so6004686a34.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611183; x=1796215983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
        b=Cf87sovlA4kiX63FBoffDiE7bN9z6v5nI0u8xQKNMAt0d9+QtjmmsgfWsLPac7VeMB
         ZV4VeyaQHalqwGN4kf0pBczb4htfqSCk2rF6BhZMiIYa6A2DMg3HpRVkVFIhLZf3A/4S
         QSmrp1HzqY0CnkOIqK3rO1d+5xI1E3vAZ5GA+0YiGaM8qkzSMLjYMnlYgjMnTI0BPNk0
         WjPSN6mNpPCh/pFaSHKQJy7GRWivUEjdd+nrWfSh8Iq8vZMgdxck+OFQEgeqWoS54H/A
         3FH4VYrQ2MbcOmoiKLfxymFJfbQrVZXJnR3YFaAZGsjQrr5+2JznRqYJ+yT8n/dQiSxo
         eX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611183; x=1796215983;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
        b=zwullro8vfEx7sCFjTgxji9ulztJZAUXwXf74PKRt6Gr7stbdWY/8HtmdvNB5g0wuL
         UjaEfulQvxYtr9jp/opr/sSL6IZ5yI2XFZt6rfpc8honoiLOpzxViAEqpbem2Qcrwbxn
         vvr3G4yjWgQrSP0tBiVAy7hY2G89OezdWAilj/hqwGnx1uozWDi81Pl76gHHFxUwYvBw
         7jRBOpFFilKw6/sVnmGWEP+LtxC1U9OWCofI4XdQ2ZHyZ/DwMEoZAWm1lNnwoHrxrIgo
         IONC2LOjNNaKfUNvcE9I8FU/PDevJ8jFJSC8MKDPQpnILrHFVHXgjSIfM3THK0KCK/59
         NFIw==
X-Gm-Message-State: APuU4Z97VQTlLM+/eMAWGvta2PXont0sZ2NYhPv/lyqbSb8+KuU1IDRu
	apOUHD/jyoWxnSR5U2SdvxzyIA2UU5+YbQ38SZYcJyeYiv6jd1EXBh4pvGSXQFW4
X-Gm-Gg: AZFdTZeL7w6KIBe/R+0mLaXuaBC292LRZByYQruzopfMoqgC/QiBa1LofroCDkXqSRt
	XXECqGZxoZsLulr37rAspf7eIdPOD0MbFaJcWlPbf4WHuClRS3v09xptPXw24CvEqHtLIAsGfwR
	25cBS/NBIQ+Ir4W18+KLDPiUGuxw5KJg9n9MTVGcxGaZYC9/03plLp5PJq00kIA1Uq43i/7swm6
	pViQr5ryVX41Oil0b5aztXh2nzFMMcz0shQi4Mx4UukoclXrUBmLayBACm4bJ63tIvmAEd7YO1X
	uCDUU71qa07SrYcVfZI2N7UQhtIKPWNW6D/rVOBIFYEcPLZv6/bYvyEAAjdfmx00j0HuvNzB+vp
	ArHtzUOMsnfOsS6NBRPNFTOnkYP5WEiG+C8COf9uZRMIvL03inMciNOfTQIm45K7OuyGDR1XVO2
	tT/iXtqVro1iCHUL9PzpclURIsy+iLTptJlpCprYzSpl9xgSfd+vCILZAnKh5yvzzMNX3abugA6
	zIULIw4SmZfyDXDS2qp6f/VNObOy8qKFaf2agzNCb/3bGgsOiPDJz9yBUrVQ920nk3HdK7UAhzW
	bDSZTOfcf6PSZzUkZwqkQCVzczQbEAkZ
X-Received: by 2002:a05:6808:4f4d:b0:576:4f95:5305 with SMTP id 5614622812f47-57a0ac32c49mr23168397b6e.38.1795611182724;
        Wed, 25 Nov 2026 04:53:02 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34250fa1sm12840832b6e.5.2026.11.25.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:01 -0800 (PST)
Message-Id: <15f47875023679137bf35031466706a5df72cea7.1795611175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:52 +0000
Subject: [PATCH v11 2/5] branch: let delete_branches() name where a branch
 landed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit lets "git branch" delete branches whose commits are not
in their upstream but whose changes are, such as after a squash merge.
Their tips are not reachable from the upstream, so the merge check in
delete_branches() would refuse to delete them, and the output should
say where their changes went.

Let delete_branches() take a map from branch names to the upstream
commit where each branch landed. A branch in the map skips the merge
check and is reported as

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

No caller passes a map yet, so there is no change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 58 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7ccb36364a..b7c3554b63 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,7 +236,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int kinds,
-			   unsigned int flags)
+			   unsigned int flags, struct strmap *landed_commits)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -251,6 +251,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
+	static const char *const msg_templates[2][3] = {
+		{
+			N_("Would delete branch %s (was %s, landed as %s).\n"),
+			N_("Would delete remote-tracking branch %s (was %s).\n"),
+			N_("Would delete branch %s (was %s).\n"),
+		},
+		{
+			N_("Deleted branch %s (was %s, landed as %s).\n"),
+			N_("Deleted remote-tracking branch %s (was %s).\n"),
+			N_("Deleted branch %s (was %s).\n"),
+		},
+	};
+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	const char *const *use_msg = msg_templates[!dry_run];
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
@@ -334,6 +348,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -350,28 +366,32 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
+	if (!dry_run &&
 	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				printf(remote_branch
-					? _("Would delete remote-tracking branch %s (was %s).\n")
-					: _("Would delete branch %s (was %s).\n"),
-					name + branch_name_pos, describe_ref);
-		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
-			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
-				printf(remote_branch
-					? _("Deleted remote-tracking branch %s (was %s).\n")
-					: _("Deleted branch %s (was %s).\n"),
-					name + branch_name_pos, describe_ref);
-
-			delete_branch_config(refname);
+		char *refname = name + branch_name_pos;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, refname) : NULL;
+
+		if (dry_run ||
+		    !refs_ref_exists(get_main_ref_store(the_repository), name)) {
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_(use_msg[0]), refname, describe_ref,
+				       repo_find_unique_abbrev(the_repository,
+							       &landed->object.oid,
+							       DEFAULT_ABBREV));
+			else if (remote_branch)
+				printf(_(use_msg[1]), refname, describe_ref);
+			else
+				printf(_(use_msg[2]), refname, describe_ref);
+			if (!dry_run)
+				delete_branch_config(refname);
 		}
 		free(describe_ref);
 	}
@@ -902,7 +922,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, NULL);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -1142,7 +1162,7 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
-- 
gitgitgadget

