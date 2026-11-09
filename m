Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211547;
	b=2WbQqzd/tKwOSlBIjAuQongHz8I5jsTRJ8Nbz3NhszW5Z4q3mvYOLQX1wcy/GTVAQba+
	 7pKhTwcsen44HKA1YjV3Rl9wtMEnCpGcK7XdwtF/1BXXyV7g3Hh0mmIXooCRT0GbZ9vac
	 uOPaSZ78/G206zGkKmboZegg0jUzm10IaxjytkVtiHLc8eL1fPc9U66Dj4wnEDU1y8iVo
	 kMY6DRpvLWZ9Xs34Tot8QSrrJIeL21GXWU+rw1ZUv/CywFwXHLZjiYTPO/POUCzKYr81S
	 FYZeQPnxKXQJXhtlWCKtPd9yXKdsGpEXa4JVhbWNPMBH6oIyBVDW7J4ljVvT+l4pbmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211547;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=cMsAUpzNqnQwjab7VETrnG1GXTpL9hIuS6C73YecI+c=;
	b=1EvY2/prp6pEimE7iKXunx7z8RSQgdXK7V5NDgvXnvcnFBozSv74MVLrvH5D+V0yav7I
	 4Yi0wkXqTRqYIzW3FIay3R50e3oO2QgzIHMear+NwALggCk6CzibIDNVRTzFtqESuIou8
	 mhh8hTVFFbCt1ODNC85xwmtaiIJxmul0W26aVYkqFPCCd8WDLF55WoLV0wMHapC2biTvd
	 k53q+u/ThuW8AEBq/m/yOQfSN2OhTmK8lvvDnlNGyq+Pi6JWn612ZCWeHd1QKrNz3jhjp
	 /rhV5WWiR071IPtoSIljobituyVQzylglpG8n9TTwwryT+Jbo60TLCKsXfggzMEeeYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QZHYt9a3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447C606A338
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A447C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QZHYt9a3
ARC-Seal: i=1; a=rsa-sha256; t=1794211531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VbZY6fWssDPyf8KITTo3w8qZiWe4IaTmk0bWrDx+a1JbRBC+oZt9UjjIbSnjV+K4/F9lXG0SfrHeEpoPORPsyAGf7vnyQItVcuXYedlTdOI2POTziP/xwUy2Fk3rq/BY2T4B5BI3Wc5spHRc43CyU4QTy3Wt/EvHqgqgzVPUJPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211531; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cMsAUpzNqnQwjab7VETrnG1GXTpL9hIuS6C73YecI+c=; 
	b=ZhSXqpcs4gqM6qplySRKWvTKdM0gTRkYY9027mVkjboiTKIylwVm+gl0FBEaR3PgeBrHl19pGWi2uaT5VlqyQjcnSym4mo1MBPQQnyWiS7UWffCm/nYepAbjnkiU8/z2dHSk0MdeWkxSfJ+TWcaw+vuJpn3+E3tgzDjkxSDUHBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=QZHYt9a3RzgOE8LGhJV/p+QKIEG1wuHWUqs2ppfPKC4z89NFhJs2STC+wz6vRS+DJRumuLkn8pOHyLxYvVtSrhSliXFQtuYvrfhExNZQBpw66F42fI+jf5PRBPv437m1HkiLjTCvyIpI71beoaLXK5owS/MSnPHw/3zhJsnuuGY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=cMsAUpzNqnQwjab7VETrnG1GXTpL9hIuS6C73YecI+c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211529994777.8777007882053;
	Mon, 9 Nov 2026 00:05:29 -0800 (PST)
Date: Mon, 9 Nov 2026 09:05:26 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v5 3/5] log: fix -m --follow losing the history of later
 parents
Message-ID: <85b6067fbda4fdf9a99ab81396dd1a2b89066954.1794078554.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1794078554.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
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
index 806ccc24bd..ac9ab85888 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -171,6 +171,22 @@ do
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
2.51.0

