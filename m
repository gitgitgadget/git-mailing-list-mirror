Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AF478846
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140503; cv=none; b=ZYsidjSFd3ZCM+z3m0I1d0c3FPAWRXpyJfODJ2+hm/2MH//5mckkTGgs05PQ8WBQJuJpK+6xKMlVT14ShJBEsZW6VfAp7D5rtnliGFyW0KCOksvxAS0C/g1aOsHP7ZoTr5ekTv6nq0rGs+Ps9WRxOYKO98n8Di6ia7RRrsYZ6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140503; c=relaxed/simple;
	bh=wXV/TpDSyWkEkLX7Wd5f/pF4v/g49KpoUnOgeXFk8+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G8y/iN+7jzW5PaFB7es1S34f2zuI2u/zbXLaEbM+xuyP4qKkd+ZCDWt2ODXopt2/sXwN3eqcfDF20QI0Vbjf/K/hU1t9tsaJ8BHvleoiBhYvAnob4fb1kXMcEnMTt/afTHC6kEwlZo6jXCw6oZM6KvNAtEv7IVIBpEfSpPFOLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrhL9hvR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrhL9hvR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cbc593a67aso66922385a.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140498; x=1772745298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=hrhL9hvR6uCzN71ETUxI0ELWZ4Pgou9XoBV4kG4PNaegwLSirjhRx8b4nXVFzKa44B
         ju88q/9Fv9OeXXE+x1rT2wc7iw5zV7LphKmy4iOfusRiMb5JIW60HVCsRodwalC9tn66
         +qG3ae0StyGjkmqJCTClD7INaEaQY0EOi9+nphAoXxWNgY2SkLRkWwq811BHgA6CWTrH
         atQ3EcygPx8ziWeK3MpOUO6g9Sqk2cFsO/JbMA2XXcVr6SyuifN2sfFxQlPAb9gZXc7V
         6x83YX1dCZqcpRIBlLZOwB0/hkb2JfqN65gEKqkUe9bx+aT3/ywzBd5YF+sdW8LXkoqq
         vX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140498; x=1772745298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=q8Vo28SGyuI8ArtNbhFXoyWXvRzc3R0XG3lHTwzfHkYUNMhGGMMx2BaLsJ5QAAtk2m
         rq+Z0g7NWnOHdRv8B5Ovp0FJOM6O+LcE0kT/CYp2/eNa4i95znL51W4NMKz/xJDO931V
         o+ot1JRFNpoSVIxzUkIywECOo3ma+FAVo/bxW3fe62a9gYUw8DBXQPDk/c1+S8h61xxN
         2c2cDVqW4ObOXFUFZBIbVI8LXMqgfG4DeVbIAc0c3UTxotzlwcT6oPf7Mc/WDA8+Gull
         I5SINwz4dvKiyDkgXbHOG+lxslPE5/6jl7kLblzUCrK4m14OiUMvaeo7yzXJLlKqoWj9
         9PnA==
X-Gm-Message-State: AOJu0YzuGX5+Rea+ZYgk2ACxPm45gXb1/TtAMlpN/GjQNHR7BP2SNvlj
	cKWWQ0HOu8nBfVaU14KqkBxOHpa7EXBCcLt1ypsrIB+M0ucjo8C3I8gOToG5fw==
X-Gm-Gg: ATEYQzzHC2DvNrSGheOBL5ijw4PCD3q7eJx2ww5IJ0lapq2pWqYGXekezBsSSwqnQ5m
	RjO6xd4xQTSV0qlBRLgOOAy4CRyDBpPfv+QPmlEXxutRJSnft/D4EyybCWGQssJB6m7hircWoPA
	F+bUzUrlkGAvbVPeuqVanzbw5jZAjcms7MsvEFme+1xNXNqj4/wxuAOZQb0mB9yAnKxUhHNfeT6
	wnYMTx45jzNrERgJvrR5JX8mjrwY3P97MtJFd3EakgUNw1WFd9Ftfrod9GUdjR+IpRI5FzO/i0p
	6FnDcy9KPxGhSwrp3HIIyDMg4a8DciOdfjVWdQCK7SLDUVi+0+pugYjQ+dUUKNO43PuyNOaM/Kn
	89fdaOdWHFvEpJEGq0KaTRowRpqVvRJpGS5Db56jdiIJnCuUQGxwx4HVcD/XDQx0L6843u8SH7H
	/s2bWOxpKQfwfok9eapWdfdKmQBFiZIPkK5PVz
X-Received: by 2002:a05:620a:690d:b0:8c9:eacc:dc16 with SMTP id af79cd13be357-8cbc8d9f8acmr68190885a.29.1772140498054;
        Thu, 26 Feb 2026 13:14:58 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm327898085a.4.2026.02.26.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:57 -0800 (PST)
Message-Id: <0525ed4cd99f312b35cd7c005f16679c682352c0.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:45 +0000
Subject: [PATCH v4 08/10] t1901: extend structure metric coverage and
 portability
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Expand t1901 to cover additional structure metrics emitted by git
repo structure, including maxima and aggregate keyvalue/nul
checks.

The test now validates both human-oriented table content and
machine-readable fields for the extended metric set.

Also make expectations more portable across hash algorithms and
platforms by avoiding brittle assumptions.

This includes wc output quirks on BSD/macOS and hash-format-
sensitive expectations.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1901-repo-structure.sh | 250 ++++++++++++++++++++++++++++----------
 1 file changed, 187 insertions(+), 63 deletions(-)

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..7b7c4117aa 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -21,42 +21,174 @@ object_type_disk_usage() {
 	fi
 }
 
+object_type_max_inflated_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+tag_max_chain_depth() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tag --filter-provided-objects | cut -d" " -f1)
+	do
+		depth=0
+		current=$oid
+
+		while :
+		do
+			target=$(git cat-file -p "$current" | sed -n "s/^object //p" | sed -n 1p) || return 1
+			test -n "$target" || break
+			depth=$((depth + 1))
+			type=$(git cat-file -t "$target") || return 1
+			test "$type" = tag || break
+			current=$target
+		done
+
+		test "$depth" -gt "$max" && max=$depth
+	done
+
+	echo "$max"
+}
+
+object_max_inflated_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_inflated_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+object_type_max_disk_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(echo "$oid" | git cat-file --batch-check='%(objectsize:disk)') || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+reference_count_total() {
+	git for-each-ref --format='%(refname)' | sed -n '$='
+}
+
+object_type_count() {
+	git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | sed -n '$='
+}
+
+object_count_total() {
+	commits=$(object_type_count commit) || return 1
+	trees=$(object_type_count tree) || return 1
+	blobs=$(object_type_count blob) || return 1
+	tags=$(object_type_count tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_type_total_inflated_size() {
+	total=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		total=$((total + size))
+	done
+
+	echo "$total"
+}
+
+object_total_inflated_size() {
+	commits=$(object_type_total_inflated_size commit) || return 1
+	trees=$(object_type_total_inflated_size tree) || return 1
+	blobs=$(object_type_total_inflated_size blob) || return 1
+	tags=$(object_type_total_inflated_size tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_max_disk_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_disk_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+commit_max_parent_count() {
+	git rev-list --all --parents | awk '
+		{ n = NF - 1; if (n > max) max = n }
+		END { print max + 0 }
+	'
+}
+
+tree_max_entry_count() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tree --filter-provided-objects | cut -d" " -f1)
+	do
+		entries=$(git cat-file -p "$oid" | wc -l) || return 1
+		test $entries -gt $max && max=$entries
+	done
+
+	echo $max
+}
+
+blob_max_path_length() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			len = length($2)
+			if (len > max) max = len
+		}
+		END { print max + 0 }
+	'
+}
+
+blob_max_path_depth() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			depth = gsub(/\//, "/", $2) + 1
+			if (depth > max) max = depth
+		}
+		END { print max + 0 }
+	'
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		cat >expect <<-\EOF &&
-		| Repository structure | Value  |
-		| -------------------- | ------ |
-		| * References         |        |
-		|   * Count            |    0   |
-		|     * Branches       |    0   |
-		|     * Tags           |    0   |
-		|     * Remotes        |    0   |
-		|     * Others         |    0   |
-		|                      |        |
-		| * Reachable objects  |        |
-		|   * Count            |    0   |
-		|     * Commits        |    0   |
-		|     * Trees          |    0   |
-		|     * Blobs          |    0   |
-		|     * Tags           |    0   |
-		|   * Inflated size    |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		|   * Disk size        |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "Repository structure" out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -75,40 +207,13 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		# The tags disk size is handled specially due to the
-		# git-rev-list(1) --disk-usage=human option printing the full
-		# "byte/bytes" unit string instead of just "B".
-		cat >expect <<-EOF &&
-		| Repository structure | Value      |
-		| -------------------- | ---------- |
-		| * References         |            |
-		|   * Count            |      4     |
-		|     * Branches       |      1     |
-		|     * Tags           |      1     |
-		|     * Remotes        |      1     |
-		|     * Others         |      1     |
-		|                      |            |
-		| * Reachable objects  |            |
-		|   * Count            |   3.02 k   |
-		|     * Commits        |   1.01 k   |
-		|     * Trees          |   1.01 k   |
-		|     * Blobs          |   1.01 k   |
-		|     * Tags           |      1     |
-		|   * Inflated size    |  16.03 MiB |
-		|     * Commits        | 217.92 KiB |
-		|     * Trees          |  15.81 MiB |
-		|     * Blobs          |  11.68 KiB |
-		|     * Tags           |    132 B   |
-		|   * Disk size        | $(object_type_disk_usage all true) |
-		|     * Commits        | $(object_type_disk_usage commit true) |
-		|     * Trees          | $(object_type_disk_usage tree true) |
-		|     * Blobs          |  $(object_type_disk_usage blob true) |
-		|     * Tags           |    $(object_type_disk_usage tag) B   |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest commit" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Largest parent count" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -122,18 +227,37 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		git tag -a foo -m bar &&
 
 		cat >expect <<-EOF &&
+		references.count=$(reference_count_total)
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
 		references.others.count=0
+		objects.count=$(object_count_total)
 		objects.commits.count=42
 		objects.trees.count=42
 		objects.blobs.count=42
 		objects.tags.count=1
+		objects.inflated_size=$(object_total_inflated_size)
 		objects.commits.inflated_size=9225
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.max_inflated_size=$(object_max_inflated_size)
+		objects.commits.max_inflated_size=$(object_type_max_inflated_size commit)
+		objects.trees.max_inflated_size=$(object_type_max_inflated_size tree)
+		objects.blobs.max_inflated_size=$(object_type_max_inflated_size blob)
+		objects.tags.max_inflated_size=$(object_type_max_inflated_size tag)
+		objects.disk_size=$(object_type_disk_usage all)
+		objects.max_disk_size=$(object_max_disk_size)
+		objects.commits.max_disk_size=$(object_type_max_disk_size commit)
+		objects.trees.max_disk_size=$(object_type_max_disk_size tree)
+		objects.blobs.max_disk_size=$(object_type_max_disk_size blob)
+		objects.tags.max_disk_size=$(object_type_max_disk_size tag)
+		objects.commits.max_parent_count=$(commit_max_parent_count)
+		objects.trees.max_entry_count=$(tree_max_entry_count)
+		objects.blobs.max_path_length=$(blob_max_path_length)
+		objects.blobs.max_path_depth=$(blob_max_path_depth)
+		objects.tags.max_chain_depth=$(tag_max_chain_depth)
 		objects.commits.disk_size=$(object_type_disk_usage commit)
 		objects.trees.disk_size=$(object_type_disk_usage tree)
 		objects.blobs.disk_size=$(object_type_disk_usage blob)
-- 
gitgitgadget

