Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662680;
	b=o+2I23daXFzmWhCI4KQf8DIcuGFHQUZg09E4JxrynK3KgO2vOSiAVjEFMjJcoNy01lYa
	 XoqwHR1mFkO+Q5v/SbNDeQPsu0tLZgD3+6jZ9qm1qrvmZxivNIYQ32OCYoW5ytJNn9ue0
	 8WIGqzCynou3xv1AAJ7p3jvBU2X6r1t5NjYRoJFV4hlHEN97bhHcvsfwqIJrhojxBUj5J
	 wtgmPvHbk0pM+b7ccWtkQvc6I7WT2V75r6AE8gCBJ1UifklKv2qbKvRhb2yR1RLvo9KJe
	 V5P8VQ9USTJ2qkOol7gg7KenBJQ4hKFmpcPpN44LEW/H60dZcn3Of9uscPikYNB+yCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
	b=fXRa/BfoRRS3sWoiL7PaGB5jQ18/kDuyV3VX4gL1GTKsidYZnj5Vi9jDh5wUbryfykTX
	 vg/JG8EPww4Jcf7IB6xbrzo6F5gnbxAoBDgPgAsCNofeYCmLc3LJkMPl593ZDF6ZABB8P
	 5hb7uyRyAQo20NISzOZZYVXwTZh7YdhZJnpAbDwkrihmtbrDjwrQGo4ahgMR7BVwb51aA
	 uunqSRYgjZN0Hd4PxsBL6+ZAWWXldJTGx7cctQ9QKxRdxRe/oa8idDBmjKV5066iPUk/b
	 GfrZPvIqzvD/yYCTT5+1ZXC093BbvBkqAX7HHJarRX1lv9TfkTejKVMwLRNXSp9jALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xynRFfI+;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1108606A339
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 13:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1108606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xynRFfI+
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-71ac798b8bbso872843eaf.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662679; x=1795267479; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=xynRFfI+SZkJUH+QA2KT28aToGJMU9/nWe8qAlW0J1Mhorz6spFUQ+CWC0yOxuxOy4
         vOU/fKWuP2p8xG5WO5zOIe3JTXchnwela7M+4WiJdYqaHq/oEhOz9TfIYSTd3PsFHONU
         tBDpGHO5ebVUw6rkkSiR9irXRJWePd5qIEDZ3dnJSbfD8L+a4LwZEFXEsFEiqVoP0EAC
         lq6vEj1udRJQ2GTfi2tV05ucNXC7DWdnO/YGlWQe93eUhZm73zHlkz+HJE1a6xkpm81r
         Bm5RquKrMyapF8GEr3VsQi244Jcon/rcE3UgmGfwqhWzsBdUthWL5gijL5s/2hMDlxKh
         3hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662679; x=1795267479;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=knBt5hYu2O76IWXoG4DLnVpUswBOozR1HeU+pIYxw2A0ewjet4B078ZtJJEBCe1eyM
         8VSlY95oKaGXISPo9p3aJYq9/LlYSsaLQ+T92BDsNCYEooFL80Oje1rhDZkDF/T43Pjo
         nCa/YLK2kXMgGTY6otXbCrnGcW30czG3u4AQrLnkaUWrcQitNnKJTpakZLT/HP0M+QRC
         WefOBCp242cq1C8rk7pTNdpyRaXmZq9XMA9zgCgIHJC/5EcArO97u6OKsXLHHKoqYTFP
         7qyTBl2IYgi4hv2Mww1GBRX5duF2kGRZGl1+sDdDrn06TU108/N9EQlQ4t+v5ozqiEO/
         zMPg==
X-Gm-Message-State: APuU4Z+B2M1YjXS+wt93HtH0oHF1HgUO/dC/da6X7Jn4S89u7W034pz6
	YV+iPR2W36kK8piJxOrSQ7V2GxQzrEB6UmjvtVecEcxZOtY8F1Fafv4n3D/Thw==
X-Gm-Gg: AYBFou12wazESU211iMDzwPXBmJYgc/72KZMmkBqLUFDsWZ8YXiGm2Oh0Qu0xAspHIh
	kqXdfWQfpZ7bzEmY0Rv/EHSFP1lyjY6vioBzoXV9W+ZmF1Yzq0oh3oyIuVuKfEEus6BGos4D3W+
	rWy1WyN1x0/daGQcfbQnbmvQUaUFYoeYIVPJ7gg1rDdbOjoZX3zX0KsFwM13i6gm20MH25lzhmZ
	H7ok1YUN2+3nkIwjpR02XrbbBIqqIIB9tsTWe8CzMjEBu8TZ2L4NjPIZU4/4eNc/lITlvx+eLLb
	M5O3aWaB+4wwyOAERw+m2bPRxtTeU94zVIHPe6rqrml6g1Nfpfo0QQeT9E3RYScUKjnn6LlE3vq
	jZgtIl2CYj89ICJN+ipHrFVq82PCX3kbs24oi49TyJXQhipmNdvlj8iUSsW36OsMcGXSODMzS7s
	C2RXSTeRzbzJpfhikspeD8cD5wpLJEV7/CDmWeOK9Y3gs56m39kPow4p9xbt5T9gaxRBul2KTla
	Fn0/kXVTry1hWkoVgOPmUsiPx9nb1mnG8+C7tDErPQh0aPOZ94ZSFklDQIDTact2bBTpOmt1FAh
	spFeKTI7l5d+ilNUPcEreF19aZDr/YxRmbTSI1IV9XJeFWIa71J3UQ==
X-Received: by 2002:a05:6820:55c6:20b0:716:f44b:2dda with SMTP id 006d021491bc7-71ab5086427mr2370007eaf.50.1794662678617;
        Sat, 14 Nov 2026 05:24:38 -0800 (PST)
Received: from [127.0.0.1] ([20.64.107.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab430598csm4255885eaf.10.2026.11.14.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:24:37 -0800 (PST)
Message-Id: <18c3edb6e3a12a1e82891728b0c7e3b189b3457a.1794662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 13:24:28 +0000
Subject: [PATCH v7 2/4] branch: let delete_branches() name where a branch
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
 builtin/branch.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2c1a8b8395..6e6b04b11d 100644
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
@@ -334,6 +334,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -357,15 +359,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
+		const char *landed_abbrev = landed ?
+			repo_find_unique_abbrev(the_repository,
+						&landed->object.oid,
+						DEFAULT_ABBREV) : NULL;
+
 		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
+				       name + branch_name_pos, describe_ref,
+				       landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Would delete remote-tracking branch %s (was %s).\n")
 					: _("Would delete branch %s (was %s).\n"),
 					name + branch_name_pos, describe_ref);
 		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
+				       refname, describe_ref, landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -901,7 +921,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, NULL);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -1141,7 +1161,7 @@ int cmd_branch(int argc,
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

