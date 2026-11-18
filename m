Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027531;
	b=rwyNyjorGRAxbk20l4aSrbzQUcsyd1p2F7OnGQkKlyqjr15KIxu8U6709J//U2QYaywq
	 +ZOHI5JI8zGwh6ApDGXLA5G89DBe1ruz5MmTQRkMkL6es1VFWzbRPlliJ8SfosVvhGLg+
	 wE62R0QNjhAhRMCS6Q06kBZVQEM1miuASxHwVEr38WUkOJF4+ULkFh0jsaJUpeogO56bU
	 oa0s6jtR4dOI0FEHyARvds/g7FAPv2I5sTcBarWSFY9FfjrLJ/YYR7QFpAM4E3Fejdv9F
	 H5N3YvyooatPFA/h+UMx1hmj9pXfr3MZnK7Ipeg90TsHinbT6vwueq9tmnrJ0Oz04QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Dr2J55vxIx7W5WDdLya7+BPT+6w4aDEt1J4CRsPCFtU=;
	b=4WsTPj4Gpj3jJjj4LjPThi+B8dNbR4sD1tf4x4ni06pAUSP4eKmsgAunhmYHHA4bUMm9
	 ihuGVjMZS/QnPPykJb1ePC+8VIVTTBvETlB5ouz2VBz+5bBatiITZLrGjcTjhOy2liSbG
	 azBv91T1VYaUxudBmKw/gWd7mBJtrQu351f+RZNUvAbFWFHCfctz9OY55MRDOHs5/dJxQ
	 W99q+8pfNK3m2Emafsfif6ZOcJ6sf1MRHZnoEUf5g+AdYGNSWedG+JIe2hg0Sy42ThplD
	 U1C478MUzpWO2lWMFgkXyeO7W59Y4/r4E/B4aJDwSxbQ2scwZalgjuINfsojmBCPF1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k25D6CCy;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854860A2624
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2854860A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k25D6CCy
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso749088a91.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795027524; x=1795632324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dr2J55vxIx7W5WDdLya7+BPT+6w4aDEt1J4CRsPCFtU=;
        b=k25D6CCylKJZ6c/dk3TsEnxXo0blBjAAhreA/9pPWgVHXWgHqvCy9w+bMhIKS1k+g3
         +eux4pkWK0RNvxG6vDL2VXqZpFzlb2lHva7zgIsYLSUjhuYihPab77FPpk9Mjrx0pPnE
         tfukntzFTPSxvP3VnhfZVpFMU+6KLC0TvUTEchlJBa9mjQJU0Zz2xqih8PeTMlsLyY5u
         lQLA367ClezkRy5ETLMsA4c6DLtspUcxxDM9zU9tFLCklnauRGrqTc5PD4LZVk18eymW
         yvYspexWgHdae4vGdhhaEq6P45T3nG8WvkYcCvWyTAit5hVfQqS0YwdQY0xpFnub8jO6
         YTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795027524; x=1795632324;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dr2J55vxIx7W5WDdLya7+BPT+6w4aDEt1J4CRsPCFtU=;
        b=UjJunPEiiIFfQt5iRevvM9AhuYf92EY1KyufABKZkP1OetM2pTRBfqBB5UjzpLHLMj
         TB9X+ocITb6ax+fR7qYd4w43cWdDJhUhnIiHLxomkBcbV3s03yTsIzRvvVjhLjEr6ccl
         C04vzUQsIHg3XageqkJTogURvzesQhaxrQ6vxZFcuifOpm/nYHwIfpqkPBLjntKBLypB
         yxFAHjsVFqipSvVXzDvqSI6+3nq79cRMvv58mZGjr5cELwUbshCNPECmgDSD//jfLwXV
         w931yrjRc0lzEGrzrOrpQL8ED7RSBDcudumtRXNOUYd6pu7HA5jU1fJw2Q0gm12dgosN
         AcbQ==
X-Gm-Message-State: APuU4Z8JZby5b/qZ3Ws1hfyODt7f6irLYuZtO1Ja2hm0ixrHG2V8A1Z+
	rqbuC7tD/Gyjw26WTjvYij/TiQNlVlV1tdES28Ft3FIO0JhWigCSmIvArKLP0A==
X-Gm-Gg: AZFdTZdpGRBpE9dJlQy8ftLsyskM+1By33xAH960kX4NskuxIkqGMlov3/Wd83Max/c
	tM4RcZxwn1yctGNL6EE+BDJ+h+67KgEbiP7KNS707rY+aebRr2fnTrlYOKxOAEurHCQ5xyRWfMI
	j08pmGBqKvSWSMf5njSPhJFOaNr1fkyuwxSx89+S9FHqliw5Ic4E73Eb6RKGfb5MD343j8mnmGA
	8g0zOjmVXRbaOPRTKXW3hGW0Eq/wGDPDZqTbXGk1NoDQunQwl2X4cMYjkhYA6q5agWoDh6yh9HM
	VCwCPm2gZvY+Sjxj4Y7dStTkpqqJ36H4qL19L3GFtTMNohjcdzBtZZOsIKgxf1cI7gRnifeyW6t
	L2nGjVADvZdoy/fhQ9rUeaqepoJWmPeaze+BJMRClxbadaqasUAvqJYft6cGSN9wVo3rhNjU1ne
	hB7L3FcrD+gt3WzDQSWkkCtQVao9K08pI/wEEyH6zaX5ezcnD0jG8xm5ZJ5nxigGFX3NlVCfiN5
	dLaIRkGYrUF5PRoRNXv9UbOJZip/qPeLH1rN86GngdyHf1gDGTIV7MuhVM7A8ZB5MTmqPXb+tQg
	uqF5U3SSXKEMtT83Hufj0ioJn4Z0lue/wZ3n0DpLsCxMrxZK2KEqRsmVAuZih1AqOVNC4PjNcAP
	BjoTDF+al
X-Received: by 2002:a17:90b:58ef:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3b3d07d4632mr3359814a91.44.1795027524339;
        Wed, 18 Nov 2026 10:45:24 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-126.us-west-2.compute.amazonaws.com. [3.42.157.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3f7067012sm434035a91.12.2026.11.18.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:45:23 -0800 (PST)
Message-Id: <pull.2315.v2.git.1795027523258.gitgitgadget@gmail.com>
In-Reply-To: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
References: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Nov 2026 18:45:23 +0000
Subject: [PATCH v2] read-cache: use istate->repo in index operations
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Use the repository associated with the index state in
add_to_index(), refresh_index(), and overlay_tree_on_index.

These functions already receive an index state, so use its
repository instead of relying on the global repository for
repository-specific configuration, progress reporting, and
tree operations.

This removes unnecessary dependencies on the global repository
from these code paths.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    read-cache: use istate->repo in index operations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2315%2Fpoojarysrujith%2Flibification-overlay-tree-repo-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2315/poojarysrujith/libification-overlay-tree-repo-clean-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2315

Range-diff vs v1:

 1:  6eabf019e9 ! 1:  19ab253b22 read-cache: use istate->repo in overlay_tree_on_index()
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    read-cache: use istate->repo in overlay_tree_on_index()
     +    read-cache: use istate->repo in index operations
      
     -    Use the repository associated with the index state when
     -    resolving the tree name, parsing the tree, and reading
     -    its entries.
     +    Use the repository associated with the index state in
     +    add_to_index(), refresh_index(), and overlay_tree_on_index.
      
     -    This avoids relying on the global repository when the
     -    function already has access to its associated repository.
     +    These functions already receive an index state, so use its
     +    repository instead of relying on the global repository for
     +    repository-specific configuration, progress reporting, and
     +    tree operations.
     +
     +    This removes unnecessary dependencies on the global repository
     +    from these code paths.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## read-cache.c ##
     +@@ read-cache.c: int add_to_index(struct index_state *istate, const char *path, struct stat *st,
     + 	 * case of the file being added to the repository matches (is folded into) the existing
     + 	 * entry's directory case.
     + 	 */
     +-	if (repo_ignore_case(the_repository)) {
     ++	if (repo_ignore_case(istate->repo)) {
     + 		adjust_dirname_case(istate, ce->name);
     + 	}
     + 	if (!(flags & ADD_CACHE_RENORMALIZE)) {
     + 		alias = index_file_exists(istate, ce->name,
     +-					  ce_namelen(ce), repo_ignore_case(the_repository));
     ++					  ce_namelen(ce), repo_ignore_case(istate->repo));
     + 		if (alias &&
     + 		    !ce_stage(alias) &&
     + 		    !ie_match_stat(istate, alias, st, ce_option)) {
     +@@ read-cache.c: int add_to_index(struct index_state *istate, const char *path, struct stat *st,
     + 	} else
     + 		set_object_name_for_intent_to_add_entry(ce);
     + 
     +-	if (repo_ignore_case(the_repository) && alias && different_name(ce, alias))
     ++	if (repo_ignore_case(istate->repo) && alias && different_name(ce, alias))
     + 		ce = create_alias_ce(istate, ce, alias);
     + 	ce->ce_flags |= CE_ADDED;
     + 
     +@@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
     + 	int t2_sum_scan = 0;
     + 
     + 	if (flags & REFRESH_PROGRESS && isatty(2))
     +-		progress = start_delayed_progress(the_repository,
     ++		progress = start_delayed_progress(istate->repo,
     + 						  _("Refresh index"),
     + 						  istate->cache_nr);
     + 
      @@ read-cache.c: static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
       void overlay_tree_on_index(struct index_state *istate,
       			   const char *tree_name, const char *prefix)


 read-cache.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5bbfbfeceb..5ca2561e7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -908,12 +908,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	 * case of the file being added to the repository matches (is folded into) the existing
 	 * entry's directory case.
 	 */
-	if (repo_ignore_case(the_repository)) {
+	if (repo_ignore_case(istate->repo)) {
 		adjust_dirname_case(istate, ce->name);
 	}
 	if (!(flags & ADD_CACHE_RENORMALIZE)) {
 		alias = index_file_exists(istate, ce->name,
-					  ce_namelen(ce), repo_ignore_case(the_repository));
+					  ce_namelen(ce), repo_ignore_case(istate->repo));
 		if (alias &&
 		    !ce_stage(alias) &&
 		    !ie_match_stat(istate, alias, st, ce_option)) {
@@ -934,7 +934,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
 
-	if (repo_ignore_case(the_repository) && alias && different_name(ce, alias))
+	if (repo_ignore_case(istate->repo) && alias && different_name(ce, alias))
 		ce = create_alias_ce(istate, ce, alias);
 	ce->ce_flags |= CE_ADDED;
 
@@ -1537,7 +1537,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_scan = 0;
 
 	if (flags & REFRESH_PROGRESS && isatty(2))
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(istate->repo,
 						  _("Refresh index"),
 						  istate->cache_nr);
 
@@ -3874,6 +3874,7 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix)
 {
+	struct repository *repo = istate->repo;
 	struct tree *tree;
 	struct object_id oid;
 	struct pathspec pathspec;
@@ -3882,9 +3883,9 @@ void overlay_tree_on_index(struct index_state *istate,
 	read_tree_fn_t fn = NULL;
 	int err;
 
-	if (repo_get_oid(the_repository, tree_name, &oid))
+	if (repo_get_oid(repo, tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
-	tree = repo_parse_tree_indirect(the_repository, &oid);
+	tree = repo_parse_tree_indirect(repo, &oid);
 	if (!tree)
 		die("bad tree-ish %s", tree_name);
 
@@ -3919,7 +3920,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree(the_repository, tree, &pathspec, fn, istate);
+	err = read_tree(repo, tree, &pathspec, fn, istate);
 	clear_pathspec(&pathspec);
 	if (err)
 		die("unable to read tree entries %s", tree_name);

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
