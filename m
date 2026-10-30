Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390914;
	b=H9UlHBb/eIX/gJp43+dTS2gASpD2YGlc8hwT27lrf8dpJisMxWe/M4Ttc+KINkgdCy62
	 Gsf/Sk4ZqseuLKWQgANyKm4AYbuYl8d9hURpID8zhl/y7DTNtgSQNKSaEIrNf4ER9rAeN
	 eKR6JowtmvTS1er6P3f0iHHj8XwnEiQ5wn7cWmB13GOAeuRLq7TrC2SdHm1b2Nfuek5ls
	 cBpM49koI7UnSP1+OoCD9A10oxIuaQTccdyTSU8RKiyN9q5HTLZZV9SEsjsTgZHo3jY7I
	 RiAmvvFKTThgrIE+xrQlTtVrzeFYOjDEKxB4cgsyVNp9os52zlhViA9DHEhNVDUMJCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390914;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=tuz/yJlB0sxMakBqgjyySjE5E0nHNGxcEiNc9MZt8Hk=;
	b=SSx6MmAb9NcjDyQM9xNuQoPvXmwgPGmkbxognM6ZKrSQsFDyxfbMN/rrizoLHRhXGMuY
	 /Iuozhx4jsSCt0u55PBFfOsL5sgmQYXRTV7Z9W+mPQau9tTYOj+9mkC+p/ziWHdAo6XDp
	 z2jrzIMd1rA6etBrcjY5QGURj+a8T00sZYyv0+VEzjU0ivvaDYtEjnAU3f3FBKysRS6Pd
	 1tTDoTR5xZHg2b94z7eWVUCHpCDm8TnnSwp8Ktz1sXMGJGz7FvUj1BgzB0FOvVeiOgP5q
	 DiKs0rXZab+/iW4TH+Q5IC64Zba6PXTKGtCtDXQt0EQA87Fxjydpc4pr2gOKOXLvbZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=F6xQc13E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209D606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8209D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=F6xQc13E
ARC-Seal: i=1; a=rsa-sha256; t=1793390906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TNYIxym6ngExhg6CWhVxL994cC+oB1Ys9j4YgA8sk+bvmPocsAh9joJ41LQaE2iX2vs6ewjbaVlKwCDeyLQDIrxc88JNGn6Srvn7KAyhXmwD7I8ZTj7mwrtqV32q44Xbb4JBJCWS1YZRadCgprexlOUMFEFX9dyJgRcOq0AnUuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793390906; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tuz/yJlB0sxMakBqgjyySjE5E0nHNGxcEiNc9MZt8Hk=; 
	b=nDiruSCxvxT2v1BmyxoNxwLxQJFuPfO/toE6qbASqypu3OZy5lZPYZ5EnNgDB/pr7cVKOxLh0jtSpSuVxU06f47LsqXSA/45YyRql7WZKLC19HdajDwp3r11NcfmU9dUUxzj7JgUZqGQHx4t2Dhk9hjMzfs5/l/HgJv+34Ia1nk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=F6xQc13E/udccx/aiEbWiPumFN7IwDrL2MuKNprgdv0cNgjf8Ds+bUqi4A1Gx3tcfqclCDOqTr8+kj+RkXSgvkvcUZcUe7Lmva/s5nHabLxBPwc3d/1XLI0xYQrNTobQR3AfmWV3WhCU6RaWo1gGXi1IV8cp3IiV2EIyH06pQs8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=tuz/yJlB0sxMakBqgjyySjE5E0nHNGxcEiNc9MZt8Hk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793390903839623.1589949379583;
	Fri, 30 Oct 2026 13:08:23 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:08:19 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 3/6] log: fix -m --follow losing the history of later
 parents
Message-ID: <6586e8f00456a9b80d85b79284a8fb8f9819d1d6.1793298331.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1793298331.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.370.16
X-ZohoMailClient: External

With 'git log -m --follow', a merge is diffed against each of its
parents, with rename following. Take the diamond case of t4219: the two
sides of a fork rename path0 to path1 and to path2, and the merge
renames the file to path. Here 'git log -m --follow path' doesn't show
"A: add path0" and "C: modify path0 on lower".

The problem is that the parent loop in log_tree_diff() doesn't restore
the followed path between parents. When the diff against the first
parent finds a rename, the followed path is updated, and this has two
effects. First, the second parent is diffed with the already renamed
path, not with the path of the merge. Second, the path that
propagate_follow_pathspec_to_parent() records for each parent also
starts from that updated path, so history is lost on the side of the
second parent. Without -m, merges are not diffed, so the followed path
is not updated there.

Fix the problem by saving the path of the merge before the parent loop,
and restoring it before diffing each parent and after the loop. Do this
only for merges: for a commit with a single parent, the renamed path is
what --follow needs to continue with. Add a test for this, which shows
the full history of the diamond case with -m.

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c                  | 13 +++++++++++++
 t/t4219-log-follow-merge.sh | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index b4c97b86f5..befc5c8b22 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1212,6 +1212,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct object_id *oid;
 	int is_merge;
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
+	char *path = NULL;
 
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
@@ -1251,10 +1252,18 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			return 0;
 	}
 
+	if (is_merge && opt->diffopt.flags.follow_renames)
+		path = xstrdup_or_null(
+			pathspec_single_path(&opt->diffopt.pathspec));
+
 	showed_log = 0;
 	for (;;) {
 		struct commit *parent = parents->item;
 
+		/* Diff each parent with the path of the merge */
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
 		parse_commit_or_die(parent);
 		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
@@ -1269,6 +1278,10 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		log->parent = parents->item;
 		opt->loginfo = log;
 	}
+	/* Propagate to parents starting from the path of the merge, too */
+	if (path)
+		set_pathspec_to_single_path(&opt->diffopt.pathspec, path);
+	free(path);
 	return showed_log;
 }
 
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index c109c29f70..36204ae2bf 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -144,6 +144,22 @@ do
 	'
 done
 
+test_expect_success '--follow follows renames through a fork with -m' '
+	git -C diamond log --follow -m --pretty=tformat:%s path >log &&
+	grep "^[A-Z]: " log | sort >actual &&
+	cat >expect <<-\EOF &&
+	A: add path0
+	B: modify path0 on upper
+	C: modify path0 on lower
+	M: merge with rename to path
+	M: merge with rename to path
+	X: rename path0 to path1
+	Y: rename path0 to path2
+	Z: modify path
+	EOF
+	test_cmp expect actual
+'
+
 # Build a merge that takes the renamed path from the second parent, while the
 # first parent only has the old path. $2 decides which side is committed first,
 # which decides the walk order.
-- 
2.56.0

