Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521336;
	b=5lNsq3WgfQpqvd38PDq5dVJI2mjBMbfth58j44b3JVRrR/oOnZUCKolKCHCIpHJAqxj3
	 Z/CCtQrSt+uBlKG4OcRNyu/aaMMAg8sErdsTCl7VksSQ3Masntoitcuw4ACamsq4a+dJk
	 PUoCRKdA5YcmlxppuNuAns6mlK5wUGfM0r4GqlqcwhRlWo/g787svYiVsm09bL4Oak6o8
	 qfSzRDa1EzRmgctSO7GXA4A1hprnT2L/StN77lCS1T70W3ztsYBR2YdwQha0MEFBdKrpx
	 pmBBCIrqutAuHen6UCIO2TXcg1MGL3eV3pk11SlZa1G5DsBl9HpYUXidtM+mKtXfwrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
	b=W5n6r9BgY3ocdYD7fL+5UnB5HX800gDZCg9vVBEUF6det22YgiEqMySEhXHHy0XmVpcP
	 znKgi1H0mUdPCE2kUZK0ZAEhdEOLGyOIhZF5Wbl3VOwz2h0JHRoEZDvovYVrl8r8JPJ0t
	 8YxcbUvf0FD2BiCmqrnPZhRugrMZQg3CbFfIJ0lyzV/PWK1zdwYZBcrKcTLsShbJB0INB
	 bnvgRg4B/S9xkgAkXlYaKVUI1mKf9TCzug2OAui9weWWyfwi5cRyhvQJUnnv+hXboDivU
	 75lfGInsjpOSJZ6jja3cxekNyZtJuygCRO+t5cC34vMDfotFO9aAbpbJOJ/4U+5Wc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5jj5n3a;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845C606A339
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A845C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5jj5n3a
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3550c917fd3so2788602eec.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521335; x=1794126135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=f5jj5n3aZjQLzw00W2lkZ2V/Bv3N+DhU/rF/lmVaVWsAd3G9WFHKOCqXP5ehHkm71C
         VqfJ+zZsfaPwZT0Vs/9pVCHERZm9IktUhODtUsO31mj+G5vgm92wvEpHLy7UOnEsbiru
         h+YXN58jY7TnWG3dFSVr+1aXTHJVy6FD6xBqLlkVfNobdE0Jqht9i0pesWtQ+BKFVjlX
         7v/hJTRvG/t09BXQOFNUCAW+MqCLoGjtCu1cf2l3gPWKdB7H1sR9MTXZo7LQ2u3AZiI3
         ZwowmhKPWMpOhJMt0wBlbcPyuGVg0Gm1HvYtRUIGlOTKzO6grG3IFZHKp1UGjlB81OvJ
         XWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521335; x=1794126135;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=yZiLCQhMmlQ/ARWb4a++P3M8chY6ZEh0rb17z1nJVkpV9be6cbW/rCElUJhB2GO0cy
         X8iaL3HN1SB4udPPubt2Ii+4fELgmcTJi92cfUht9sDFBlEhHgGkdSqehkWfWmnZi40f
         Xv2UDrG2ZY/D0n13F3cZXtoysCUgYHC+JjhZ8/iRhk1C/zqsmH01HfSj+jGa79x8rnrj
         46yg7DXslZvhlhjC3NidiN2VQEC9NGEpZdsjvGy4EZQOcfag8Uf5uL3gbz6Il6qvUq94
         eppultDVBol9SvklKPNHalIrTWTUql8M/Ozu1V2Pl7hcrZFFfN1UMJAe/dfGzdWWsroc
         WtEw==
X-Gm-Message-State: APuU4Z98EWKigx/h330c23NMRpLtqSHEhP4k91FY9ygy/TMMxSuFIuhz
	dI5GJhpNnLgS3TqiBX2PH1rGpVAwmmGBtbQgYPB6nOi/sl8ii5L5usqVfINB1crojv4=
X-Gm-Gg: AYBFou1IIqAzg9iBKtcEapXh7pXzPuJJV2kANtljDRer3NLBxA0X3aaRueAwOF/Gxbx
	5RaPowuj8r7vRJ07ppF2Js8u+Rr6kb3G4KN2LNvaw/mhqtou1XJVgahOhNxZjmynXx33lvRXDFR
	0gsE3fsnZk99kcawIXnWMEgUtwjaNA/4RyoUCVT0JBsRwUDQ43EUVMYTG1w04VRYq0uPTXaKbRW
	/NIK/LDzoNo0np5it5kFcuQ6UMUoAhJa27kyvDOklVwf+4XsepeA7gP36LLzIY8jrj3ayrdmz0u
	UFAhTJa8BQftrKe07tTHdkQgtSGSmWlYS4JaC/ZGwanj2pLisR2zS1Q1ueO2fwvA7rpzSNmXRJa
	SokEA+DdlhwnLAk03KSbHX6tMzPkiw8qbt/tTSommt12Ut4EKE+n8VfBpiMkIO2xU3cLDl/cXvN
	GVM7gRHsJqE0iHIEwvWWxFu47PsoljLeJVCuSkAIuElKkH/zWg8lwUOS04xtzwRDatjQoe9GXq3
	loCiDnKYlKuPIV/GW+CDnlZKDdEGMCsjxvWAIJFCntS4UzKYgKqU82qW7VsQN42kOsb+zBh5JNw
	Jd8xvOHrf22hpY4eXu1fzyBh4uCuT6s=
X-Received: by 2002:a05:7300:ce0e:b0:360:c266:cdd8 with SMTP id 5a478bee46e88-36a4247b1b8mr9881623eec.24.1793521334779;
        Sun, 01 Nov 2026 01:22:14 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.197.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm26622188eec.3.2026.11.01.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:14 -0700 (PDT)
Message-Id: <9858c8c81e9c58bcd5d3dc55c65bbc70129a55c4.1793521331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:22:09 +0000
Subject: [PATCH v6 2/4] branch: let delete_branches() name where a branch
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
index 171b13b081..99b0dd45e9 100644
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

