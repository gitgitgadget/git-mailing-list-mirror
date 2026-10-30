Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390863;
	b=SK3golTgz1I951G1wuwinm0tivaJ3kmU38raBkTktt4OEp5HyDXdDhMdEB2TilZLBmkO
	 T1+sGAFI8yEpzi34FogIiNd6vOCCwljGj4nOCndIesyvO+aqzO/Dm4QfraObTb6u0FeFN
	 1ZxreKFNPYEWaN8N+kvPbczAwZLYsKE3zQ557+QeKKM9pyxb8DgFkreqW6uZJ6Vs4EJqY
	 b2PjVCNCnE3PMxifspnbx5x6zsvpb3XpF6i2m4hxiM811kLbZwi6i5agD6MFB0CZ7b94e
	 DialNIL0L5lWWj1A2wllLgYZdM6eQr3tSUUoqGk2AuHUSlRZf4/En7qibrK9YboGseg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390863;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=5lr26VjVhmrjFyAgcCXOtkoLaWZzl2aaN0ybDpdJq2w=;
	b=Xb+UCo2L7IXUleHsDoQ3/3RJ6DRl1Y5U5K9zsh2Lmwq5MCBa2ZIAZjhaymTMb41PY5c3
	 NH18J70YB3gngRFjJtK2Enb+CX6P6UBzyuaCNbHh8xvnGiaVWdy/kOveWrii3BW5UhIbC
	 AOWE82GEJjsIHgxAEoyHa49HnzJOIy6FcL6V4X9EaQLk51NF1Ppmz/GDoJwB5i9M1bU8i
	 CxWIy14wcQlM1k6ZkjSv831Ya9k2RXtzvtOLKlFux1mUbaj8X72lx9U/YVuVSQ7QlZQyr
	 bdQo87xZVW90rSZwZpFaGsbm+QteMZSc5YYIYVFVn0D5Kvs6d1IpCW8/6q8/25PT/Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ky9fXk6c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A7606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ky9fXk6c
ARC-Seal: i=1; a=rsa-sha256; t=1793390856; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Woz+UqgdabuIhjP7eonbLezM8WmZnKqyJ4YogspfFiq8dRq3lguDF7Qw3qrB87JS2xQJi5aDVmzRhy1Z7gkaE5AB/bKyQtdEE79hYCq5cJM3yPMWeA/lfl3DozI+pGRO4P+NwN/R5gksrGvAzxoYYq7cxv9Fv1h7Urpg2FzZKfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793390856; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5lr26VjVhmrjFyAgcCXOtkoLaWZzl2aaN0ybDpdJq2w=; 
	b=igbYPbqvtXSIn2XDYF5ds4AMID2nlbCyN6fqtoJ6adbu9hrPv/p3BGTrBvvpjltQX8Ua66hbgGdiivbkuivQAI8tID3WoDV7XTRgSVbvfrrGCQ2HntTk48bdALGWhsOaHDOd4v11AdruffWhJ0acVutAGUDrIpPDDdiZRyqa/ak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Ky9fXk6cNBYtkgedYF+v21pmNQe+jHSTHDKkjKkUF1/G/g312yR6ZjZe5mVDBZNMzZKmJfX2iz6VsbfPJk1zuEhDK8tVAJkv361gzlRzLS6+miWzsbeg7jt+hl15JLhZTOsQg6ugRVJdRQkp+BPrHe+1c2PQDlzBdg4wlLt3umk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=5lr26VjVhmrjFyAgcCXOtkoLaWZzl2aaN0ybDpdJq2w=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793390853306351.3340134902227;
	Fri, 30 Oct 2026 13:07:33 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:07:28 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 1/6] t4219: test more --follow cases across merges
Message-ID: <aabf5652c91f2a38ab3cb8b18c7c368ec7269201.1793298331.git.vmiklos@collabora.com>
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

A later commit in this series will speed up 'git log --follow' for
merge commits. Add tests for cases which already work, but had no
test coverage, so it's easy to break them while optimizing:

- --follow through a fork with renames on both sides, with -c, --cc
  and --remerge-diff
- a --no-ff merge taking a rename from the second parent, in both commit
  orders, since the result could depend on the walk order
- a merge keeping the path, while the other side renamed it
- --diff-merges=first-parent, which diffs merges only against their
  first parent, but still walks all parents

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 t/t4219-log-follow-merge.sh | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index e370f82955..c109c29f70 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -126,4 +126,128 @@ test_expect_success '--follow follows renames through a fork in a single history
 	test_cmp expect actual.sorted
 '
 
+for opt in -c --cc --remerge-diff
+do
+	test_expect_success "--follow follows renames through a fork with $opt" '
+		git -C diamond log --follow $opt --pretty=tformat:%s path >log &&
+		grep "^[A-Z]: " log | sort >actual &&
+		cat >expect <<-\EOF &&
+		A: add path0
+		B: modify path0 on upper
+		C: modify path0 on lower
+		M: merge with rename to path
+		X: rename path0 to path1
+		Y: rename path0 to path2
+		Z: modify path
+		EOF
+		test_cmp expect actual
+	'
+done
+
+# Build a merge that takes the renamed path from the second parent, while the
+# first parent only has the old path. $2 decides which side is committed first,
+# which decides the walk order.
+setup_rename_on_second_parent () {
+	git init $1 &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >$1/old &&
+	git -C $1 add old &&
+	test_tick &&
+	git -C $1 commit -m "A: add old" &&
+	printf "line 1\nline 2\nline 3 modified\nline 4\nline 5\n" >$1/old &&
+	test_tick &&
+	git -C $1 commit -am "B: modify old" &&
+	git -C $1 branch topic &&
+
+	if test "$2" = topic-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	echo other >$1/other &&
+	git -C $1 add other &&
+	test_tick &&
+	git -C $1 commit -m "M: unrelated change on master" &&
+
+	if test "$2" = master-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	test_tick &&
+	git -C $1 merge --no-ff -m "merge topic" topic
+}
+
+test_expect_success 'setup merge taking a rename from the second parent' '
+	setup_rename_on_second_parent rename-master-first master-first &&
+	setup_rename_on_second_parent rename-topic-first topic-first
+'
+
+for order in master-first topic-first
+do
+	test_expect_success "--follow follows a rename from the second parent ($order)" '
+		git -C rename-$order log --follow --pretty=tformat:%s new >actual &&
+		cat >expect <<-\EOF &&
+		R: rename old to new
+		B: modify old
+		A: add old
+		EOF
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'setup merge keeping the path, other side renamed it' '
+	git init keep &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep/F &&
+	git -C keep add F &&
+	test_tick &&
+	git -C keep commit -m "O: add F" &&
+	git -C keep branch B &&
+	printf "line 1\nline 2\nline 3 A\nline 4\nline 5\n" >keep/F &&
+	test_tick &&
+	git -C keep commit -am "A1: update F in place" &&
+
+	git -C keep checkout B &&
+	git -C keep mv F G &&
+	test_tick &&
+	git -C keep commit -m "B1: rename F to G" &&
+	printf "line 1\nline 2\nline 3\nline 4 B\nline 5\n" >keep/G &&
+	test_tick &&
+	git -C keep commit -am "B2: update G" &&
+
+	git -C keep checkout master &&
+	test_tick &&
+	git -C keep merge -s ours -m "M: merge B, keep F, drop G" B
+'
+
+test_expect_success '--follow follows a rename on the side the merge did not take' '
+	git -C keep log --follow --pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--follow with --diff-merges=first-parent follows all parents' '
+	git -C keep log --follow --diff-merges=first-parent --no-patch \
+		--pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

