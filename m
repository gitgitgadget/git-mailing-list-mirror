Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825272;
	b=m7B2EO3DVkvNVCPma5s9LI9ZO0AhP4Htba36VDZPnQteTaYktHO6g4CrVBewYsfPzh/x
	 pAFxLljQ6JotpryfQ9fOhfNzLeEGJaDBcqm+RrBJ6TjaiOFZGj80LAjrehbG+Bjypw0GD
	 YQYNtC1GHaxgZDrGFd1PSf5jU9xdKnMqA2a/VL9DEmvETL5Q4n57NZNttuAYPnEutW1OK
	 +vtjF24WWne1RwriyXPStmP43bAojJsh0bgYIDKxMXLkXiC6eutLMmLzMosZ29Den4aAc
	 988EYjNd4/14pbObIQJkka1UkmujHg8qmRcFcoMvcW4/8/cq10/c79EzZVSDJy0iN0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=A3ukvFWFhNWmFFopbbfaSq/xOdXatkDIf/xF9wLwe2c=;
	b=di+fBJCcIIGXIl+ozeJe9PHVsojTpf1p4oAk0jxvetEMjHEpzl3X+O9CT0itNE9y5tiR
	 06oWROYW+RJXIJ3x8xQf/G2n6o1DGTmX2vd5Wo2pIHVBS1GBnBRTt6piV37VVFS0UTaV1
	 ptIK6ve426xTuM4ExA6xcFrTYaOeSh661P+4TxmXcJb+XJp7+EZgMQYNt3qTdSV5pEJN9
	 0ldjyPt92O8mBGhq2AfJBsPZ1bLa814zPC626BsUwm0p/wleVlDSDOiS91wVG1Iqzn3kh
	 5UY3YApjJoYtA1cClt2rL0iHPukG/GPQ18IHYUET2Tl0AB3R2rR7/rA5RABiEp77rpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0i+pd4t;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AC606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 10:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0i+pd4t
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2b8cf037so372420485a.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825271; x=1795430071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A3ukvFWFhNWmFFopbbfaSq/xOdXatkDIf/xF9wLwe2c=;
        b=o0i+pd4tMmSZCKsbF/bJQh4gEu6tkAx6LifdDkev2QbtMlPzspN7j/qMg/X+mhAAC9
         OqeXGC1GZQ0/dF9uBeacj0PxpWSMJLqMAo/WV62xzPAie01GmKQSKxTW69VmUXrfym8P
         UmB72SqZlIEzRjnlfu9un1czup+EpF9sjRAT3M3OHl2zetvsr85bWtKmatOlL/IH/iYQ
         KndOiSoGXdvMzaZZDO8NkArlrVyxWWtTBbOXQwQSQo8ZyrIQF7RuP6HzvY5fOvAMoHwR
         0JVoj3yg8n21bOOFxvfCndhnMH4UvRZKADe43GfZP4St3qu0B7DSOYVpcaJFfHneA+vu
         Az6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825271; x=1795430071;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A3ukvFWFhNWmFFopbbfaSq/xOdXatkDIf/xF9wLwe2c=;
        b=IS7y5Mbfwl7WWvGGlRmpTya5kz6Owe9GMqIvgn0BUNEOXYdWQDjDv0TLZ6uQbD2r4c
         3Zg9wpmhVuvtloRWvVfiy1XzF5FUr1zshC+HesxITMzaTlxalalaKyADbsZYogObLJXy
         xF/lVkGfvrFEuEKSHVs4AYwTj8Owwnx4tfvzdKDtKE4DIJ55e/tCJEP1MxhrccMmvuuN
         UiQNYJIXGCRRDT7RFq5BESRlCcyUH3vHRiL227+bJPI7MwOfnAAQHdr664GTYLdr0hE+
         sMavWj14hhS5YFn1wSjaQ1iHMv6E2Op2lIiD+idCSEnKwlpe+9A1/wR0KQQTlSV6hvow
         VpVA==
X-Gm-Message-State: APuU4Z8ZcM3jYaPcDfedeGpwPnXO3L0KaCxhVK1xLqiokq5j/V2VGtSf
	Iqiz7nxaPQ2vqr9lZVBVSODxbYYUJkvt+bPMNfeIg22e31v9AIn6bE6druWxgQ==
X-Gm-Gg: AYBFou2Z0v8l6Yy0Eze0zAjDYbyYHyJv8RoCbMX0yPDsXX2jKpaA6ow+Jbs1FecmtLt
	MZo47clTwb4RdwtMEtOWA5FOt0zk1gcrbvMx3WJVpZll3oVjfj9dOlij4R56etY1pTcR8MBpN5q
	JjwR+SA6WQkCZxQ8SXsqJJMCzK18EajY6yRjt8LskQkMeyS0vK1RYcNYuj6uJMEojsEJt5GwdT7
	wToCph7FOuQb5OJUt2fkHko9dyKIwzW6FmewJJXoPncLSo1F3dSmTfQtpwLynX/LrS7w+tGrvwe
	ft1WfZpcMWavQvgF/8cP63sTC3w/9RMj7QqJKqeoZdJVO8JfsmXRacrtEvJBEGY4cPxCvC3TqBY
	c6rue3Xd39n78e4+nE8mw5ze3A/u5TNlT1RmYXjbtr2Ey6ae/kj7T3yDwrsLGANMBX24Pv1urvV
	tRHkaKLmwZa/aALJ8mhEhUhu2lx/YDCUm93asMr/3jdRSTlqZFVnNaPsF7Mt5gg31v1WszTHIlQ
	a77vX47vhLfv3Q/da6bMnTCX43ErKjvzAOM8sENbzxOXDaGOg54JH5qRVma0EfgmFAokuF42rST
	dPgscH0U3y9e8Imq8LjYa37hJlojRT8G
X-Received: by 2002:a05:620a:4503:b0:944:a46:5c1f with SMTP id af79cd13be357-9494bb5316dmr1647384385a.40.1794825270657;
        Mon, 16 Nov 2026 02:34:30 -0800 (PST)
Received: from [127.0.0.1] ([20.102.95.159])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm822042585a.25.2026.11.16.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:34:30 -0800 (PST)
Message-Id: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Nov 2026 10:34:29 +0000
Subject: [PATCH] read-cache: use istate->repo in overlay_tree_on_index()
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Use the repository associated with the index state when
resolving the tree name, parsing the tree, and reading
its entries.

This avoids relying on the global repository when the
function already has access to its associated repository.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    read-cache: use istate->repo in overlay_tree_on_index()

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2315%2Fpoojarysrujith%2Flibification-overlay-tree-repo-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2315/poojarysrujith/libification-overlay-tree-repo-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2315

 read-cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5bbfbfeceb..063ad523d2 100644
--- a/read-cache.c
+++ b/read-cache.c
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
