Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590917;
	b=mA2oya0tj2Y9pVCM8kJ6wtklHWQv6nGTcE0TUbWMi+X5OsX08S9elzqmkx8ARKfWi46y
	 M1nCMBVWulC8AHzMiDVu0PaTE3HB4nKmFZDAPkSXkXNQFyWbIZGTol/svFoFJl/eJga42
	 qWAEltxWHv4npQg869CPnbiB1irDiIWxTLOv/3k2mdWuewZ6URxLnVBS7/B59d9zW4FA2
	 JCQ7Eo3kMM2p+5QbZPjzciy8vx9yMkUhTnwITZDr9Gc/Aj9Rv69HucKLT8PIR7On5pWjQ
	 yU0Wr9kAboIjChVyxEH2NKArtyMOf+1Wj+NruORT5+ipZ26ry+jeFEqM/LAtWlMK/8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590917;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=V8qhC5rLvmfh7TTu7UfpVEqZyJ/5NZZQZAwELjzpUlc=;
	b=QMH9BSNYeGCKw3SG2yVJf98a3AJHzvZfLy6Wi9nmtYFVO/jywHQZjw336Ri04HX2DoY5
	 63L1MEZM6xL4N5F3n9F8wqHkcMvcEe0Ye3ezQt+Oh0V8A503SG+0LF6PNn7ln3hfJ36pr
	 hqEA+Cvths1A4oasDBozHLwO1RLjKi/yzy7Xz8aQ7uRyQNkRADpnNk5Kq2BzWvfrCJwlk
	 9o2kRhtFP9aBNpLz0yaY4c4hgz2xuvhOtjA8MIbFoxobKl0EwGDKls3Quk22UZouxJOxz
	 1wAL3git9IfU6Q0E0UJn1DseuhlmvBomss3WN4w5KcZ59nF2YcnbG0VWI4EjUq2fY8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=LR1243Ix;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qyeyn57e;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD1606A322
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DDD1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=LR1243Ix;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qyeyn57e
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F0D5A1D000CC
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:55:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 09:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792590915;
	 x=1792677315; bh=V8qhC5rLvmfh7TTu7UfpVEqZyJ/5NZZQZAwELjzpUlc=; b=
	LR1243IxCB4ih1ttF/7IfyDzrh0Qo0KOXycBGHz1UhFCV3zqsf6wp+uJoXc2lE12
	eoG9CGVLVVWn5KxY1VONF25wdlipBK5GtJa34tgwzvAHNYtcYNZd/d7W4MkLklY9
	15zfiGg8sXyRoqJRsusWJS7f1cEjeFm6R8QT5dGsInHtx/sDKFccv+dUzznAlhvG
	FPRXntAyY9398P6112QHQVUI3L1fY2FD8xa5FX3TMtZsEo3sC1lm10Ob5FdLCJfg
	ynKtMmG++/0P5ew9c6PFos9HVAPFGZKnQKpHdT6XS8kr+5xTgYplG7clMgYXlL+R
	5b1rst71yQ4lVJn5hVJ1ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792590915; x=
	1792677315; bh=V8qhC5rLvmfh7TTu7UfpVEqZyJ/5NZZQZAwELjzpUlc=; b=q
	yeyn57eSr+fzbeTTsHX0jS/4zGaSgmAHONsW7WDZQoBY1MJFr9x1EL5hbXPLRQ2f
	M50yHP1twHlxWMJR9lreeYWGoZnrjRirCoFW4TgWx2w7QSPw4A6dDwmlmJ6A7PWN
	sILWbdBbbo3/gPNZQTGFxIVEO4q+HlPpLAF9GdP3+bVnEP9eaHvnKdiJg6+Am5hA
	eSo0XUKJoDlAgnUZrQsiq7MDDjsvTvUXD5Je+XR+eF7/EnWe5QZQWmGJ4+QOsCJu
	115HVaLo9S7GLLQ4vw3bM4wLLZ4Dd4VJT62K0yYesKr2t+zwvRKvX2BGHAGgTJnL
	jj+cHtVDMcRohpYwL1q5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792590915; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HyhKbFqCOEj+EZdC6efSoJsf5uJKHh6SPEED24xLiulNw4c
	XYwlnrSutHPKK9NWz+Qhx0Sj5Qcy0FGXOaiiZcpz+Fqeei0u2DtDg3qrwF1jFjFs
	VuGnc2Xpaw9pZ7qyUtTQra59jdsyBkZRdpVsPkXUQvWbBzyZzpXIdhLmkXXi5dqo
	FQDEfOFcGQf/npZ6EI0EYzkmN33ZJL1wVfRGozLx/MLmXJcuUHsUE/5T0ltIAqJ3
	dKf4nSHCpkffqx1InRbzZXHxqaHCcwMbPaQfLCQC7R0pKRsXB3gUx92cUt3P0eLy
	JlrEuo04mttwgaz/zbIIFVxNU0S5MrsWhDuF/ug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iVS7VVg1biJZZp5Lzn9UqYx3gF8IdZoWCEETAtA8IME=:WG5V8nkmwkqCxaC5iz7WONmu+6GrnVGC4zs95ECzTgA=;
X-ME-Sender: <xms:Q8TYam1VroaUR7-cbiaRvp6YaZDs2RpZDtOMur7n2Kb7-Bd4C1HNww>
    <xme:Q8TYapRDv3NRsr3WEpap_WalZze1AxxZ48sxfr_trB_rBYQ5zch01CkmGkZePkFg1
    jeriqIU-snINHfhwgmKyLM-mfInCrYkEdi4kQxVt0ied8EsefLvR5Dj>
X-ME-Received: <xmr:Q8TYagsHcetYc8Yz0Gda9X13iGlacnijReQw3cziuZY20QxUJdPyfDlQY3wtSkciGrqHNiOKT8WvEgtVgRDJ_Iet48tH>
X-ME-Proxy-Cause: dmFkZTGM1C59zIi2QWVj14ZNKoyFhwxNaSSNy92vJDm/VkApVRI+iV9OK1WybHGULIj4Rp
    rex3KS/WOerkwHLPAI/XrAbY9BZlhrtPZmbws5DIY0Ah+QYm5tr7zAu1zDZtY0W81s2BM9
    2+dok/YqoG4zasTpvgkYBVmYO8BAVWzqGYgAhPwYdx1uk9IqNt7vRWxtukXfVbw8LLXf89
    LLLeT5oye3H8vnDdUAQ9ziyh+uTI1Q2NiyUTB5l+ffVMttfKmA4X/RM17LXkQevoA1Zd26
    pCVQDMh/FxZKeL4cwASkwCc8NeBAL4ykBRlf2MBzoUwNODcNDc+I/4DavmVd0bJq8UENHH
    133GkRXnZVuyqOlTX44RTXWgQ+YLAbGr/pGx0SJQeMFi1nbhgf8v6hA8jYIa5MYaMk2IwS
    lmIseTduZmHTKdgQIn4EZspW8iGdkx4V9BpS1thbPNObsWKvjveupTOHAArV13x8jjkOBA
    k0OFQ8ziZuJx1xMF7B3pa/IMSXAHXG7oFIqJcIOM8zLcs6AxOzkQwn1uFGlPlmSNOL7i2v
    4vKYK+hqOR9FR71FmuyS0HO+xNs/SMyONEtxUguGMCPk4sD7hnRb61M6ixWQ/fRZqUeWmr
    me/OsWyCo0ba9btH2TE24RCmGytsJYeclJ8m6Yp6NHWd7bodXYvmwmqbWZjQ
X-ME-Proxy: <xmx:Q8TYamZfXr2njAoVxh6-fzB9imU1gqpyxFmE1dxYxVoMRluGNd7RnA>
    <xmx:Q8TYatsthG6OWmcb4sTKLwFRA40YoA_S41idmWi3w1VC1RVzsC_Hbw>
    <xmx:Q8TYagH78totEm22P4DyKPitBMq_iUB4KemF51a-K0OcAjveRiKHfg>
    <xmx:Q8TYagy9tXuM3zXQbNbG4cvVdar06Okp63_9eLKxK7Gnii-3mDD8lw>
    <xmx:Q8TYapaLH6LkME276k3-31W_lRD_GwR5PHpKu2Cjv5fSJ39DRRIgtJty>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 09:55:15 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Wed, 21 Oct 2026 09:55:06 -0400
Subject: [PATCH 2/3] repo: make concern thresholds configurable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-repo-structure-concern-v1-2-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11981;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=WG5V8nkmwkqCxaC5iz7WONmu+6GrnVGC4zs95ECzTgA=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJuHHGw/mmm+vytjMWZiohj2wP/LXFP+6HBtfsA/45ZG
 7j+qh3U6ChlYRDjYpAVU2T5/0+g8RXLAwm/oHefYOawMoEMYeDiFICJyMQz/M+08G0w7H/2dfYb
 gbIdpjujRQsPLIw9J/Foy311Wd/e1XUM/1OTVS6w9/TVysS+dyqyYtSsLCng0/xWpXysWLyTWcW
 fFwA=
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

The concern reporting mechanism so far provides a
measure of concern based on heuristic values estimated
by analyzing a collection of (hopefully) representative
repositories. But for different projects/usecases, the
thresholds at which a value becomes concerning may vary.

Provide a mechanism using git config to allow users to
configure per-repo concern levels for "git repo structure"
concern reporting.
---
 builtin/repo.c            |  44 +++++++------
 sideband.c                |   2 +-
 t/t1901-repo-structure.sh | 155 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 178 insertions(+), 23 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a450497d4e..aa6efdfd25 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "commit.h"
+#include "config.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -386,25 +387,27 @@ enum concern_stat {
 	CONCERN_STAT_TREE_INFLATED_SIZE,
 	CONCERN_STAT_BLOB_INFLATED_SIZE,
 	CONCERN_STAT_TAG_INFLATED_SIZE,
+	CONCERN_STAT_MAXIMUM
 };
 
-struct concern_stat_threshold repo_structure_concern_thresholds[] = {
-	{ .name = "commit_count", .threshold = 19 },
-	{.name = "tree_count", .threshold = 21 },
-	{ .name = "blob_count", .threshold = 22 },
-	{ .name = "tag_count", .threshold = 15 },
-	{ .name = "commit_size", .threshold = 28 },
-	{ .name = "tree_size", .threshold = 27 },
-	{ .name = "blob_size", .threshold = 36 },
-	{ .name = "tags_size", .threshold = 18 },
-	{ .name = "commit_largest", .threshold = 18  },
-	{ .name = "tree_largest", .threshold = 18 },
-	{ .name = "blob_largest", .threshold = 26 },
-	{ .name = "tag_largest", .threshold =  15 },
-	{ .name = "commit_inflated_size", .threshold = 28 },
-	{ .name = "tree_inflated_size", .threshold = 32 },
-	{ .name = "blob_inflated_size", .threshold = 34 },
-	{ .name = "tag_inflated_size", .threshold = 25}
+struct concern_stat_threshold concern_stat_thresholds[] = {
+	{ .name = "commit-count", .threshold = 19 },
+	{.name = "tree-count", .threshold = 21 },
+	{ .name = "blob-count", .threshold = 22 },
+	{ .name = "tag-count", .threshold = 15 },
+	{ .name = "commit-size", .threshold = 28 },
+	{ .name = "tree-size", .threshold = 27 },
+	{ .name = "blob-size", .threshold = 36 },
+	{ .name = "tag-size", .threshold = 18 },
+	{ .name = "commit-largest", .threshold = 18  },
+	{ .name = "tree-largest", .threshold = 18 },
+	{ .name = "blob-largest", .threshold = 26 },
+	{ .name = "tag-largest", .threshold =  15 },
+	{ .name = "commit-inflated-size", .threshold = 28 },
+	{ .name = "tree-inflated-size", .threshold = 32 },
+	{ .name = "blob-inflated-size", .threshold = 34 },
+	{ .name = "tag-inflated-size", .threshold = 25},
+	{ 0 }
 };
 
 /*
@@ -450,7 +453,7 @@ static size_t approx_log2(long value) {
 static size_t repo_structure_concern_level(enum concern_stat stat_id,
 					   size_t value) {
 	size_t log_value;
-	if (stat_id >= ARRAY_SIZE(concern_stat_thresholds))
+	if (stat_id >= CONCERN_STAT_MAXIMUM)
 		BUG("unexpected repository stat type");
 	log_value = approx_log2(value);
 	if (log_value > concern_stat_thresholds[stat_id].threshold)
@@ -977,7 +980,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
 	if (show_concern)
-		print_keyvalue("objects.blobs.blob_size.concern_level", key_delim,
+		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
 			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
 							    stats->objects.disk_sizes.blobs),
 			      value_delim);
@@ -1243,7 +1246,8 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
-
+	if (show_concern)
+		repo_config(repo, &config_concern_thresholds, NULL);
 	repo_init_revisions(repo, &revs, prefix);
 
 	if (show_progress < 0)
diff --git a/sideband.c b/sideband.c
index 0e75ab2317..374187402e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,4 @@
-define USE_THE_REPOSITORY_VARIABLE
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index f1e3fd2a75..49ecc081ad 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -67,13 +67,164 @@ test_expect_success 'empty repository' '
 		EOF
 
 		git repo structure >out 2>err &&
-		cp out /tmp/test1-out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
 	)
 '
 
+test_expect_success SHA1 'repository with references and objects' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      4     |
+		|     * Branches            |      1     |
+		|     * Tags                |      1     |
+		|     * Remotes             |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.02 k   |
+		|     * Commits             |   1.01 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.03 MiB |
+		|     * Commits             | 217.92 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
+		|   * Blobs                 |            |
+		|     * Maximum size    [5] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [6] |    132 B   |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+
+		git repo structure >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success SHA1 'concern flagging' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# configure thresholds to get concern indications
+		git config repo.structure.concern.commit-count 7 &&
+		git config repo.structure.concern.commit-size 14 &&
+		git config repo.structure.concern.tree-size 10 &&
+		git config repo.structure.concern.blob-size 8 &&
+		git config repo.structure.concern.blob-inflated-size 10 &&
+		git config repo.structure.concern.tag-size 2 &&
+		git config repo.structure.concern.commit-largest 4 &&
+		git config repo.structure.concern.blob-largest 2 &&
+		touch configured &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      | Concern  |
+		| ------------------------- | ---------- | -------- |
+		| * References              |            |          |
+		|   * Count                 |      4     |          |
+		|     * Branches            |      1     |          |
+		|     * Tags                |      1     |          |
+		|     * Remotes             |      1     |          |
+		|     * Others              |      1     |          |
+		|                           |            |          |
+		| * Reachable objects       |            |          |
+		|   * Count                 |   3.02 k   |          |
+		|     * Commits             |   1.01 k   | **       |
+		|     * Trees               |   1.01 k   |          |
+		|     * Blobs               |   1.01 k   |          |
+		|     * Tags                |      1     |          |
+		|   * Inflated size         |  16.03 MiB |          |
+		|     * Commits             | 217.92 KiB |          |
+		|     * Trees               |  15.81 MiB |          |
+		|     * Blobs               |  11.68 KiB | ***      |
+		|     * Tags                |    132 B   |          |
+		|   * Disk size             | $(object_type_disk_usage all true) |          |
+		|     * Commits             | $(object_type_disk_usage commit true) | ***      |
+		|     * Trees               | $(object_type_disk_usage tree true) | ******** |
+		|     * Blobs               |  $(object_type_disk_usage blob true) | ******   |
+		|     * Tags                |    $(object_type_disk_usage tag) B   | ****     |
+		|                           |            |          |
+		| * Largest objects         |            |          |
+		|   * Commits               |            |          |
+		|     * Maximum size    [1] |    223 B   | ***      |
+		|     * Maximum parents [2] |      1     |          |
+		|   * Trees                 |            |          |
+		|     * Maximum size    [3] |  32.29 KiB |          |
+		|     * Maximum entries [4] |   1.01 k   |          |
+		|   * Blobs                 |            |          |
+		|     * Maximum size    [5] |     13 B   | *        |
+		|   * Tags                  |            |          |
+		|     * Maximum size    [6] |    132 B   |          |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+
+		git repo structure --concern >actual 2>err &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -172,7 +323,7 @@ test_expect_success SHA1 'lines format with concerns' '
 		objects.tags.inflated_size.concern_level=0
 		objects.commits.disk_size.concern_level=3
 		objects.trees.disk_size.concern_level=8
-		objects.blobs.blob_size.concern_level=6
+		objects.blobs.disk_size.concern_level=6
 		objects.tags.disk_size.concern_level=4
 		objects.commits.max_size.concern_level=3
 		objects.trees.max_size.concern_level=0

-- 
2.53.0

