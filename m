Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9E37107E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875823; cv=none; b=QTl9uvEl0E1IBSA2uT5g2GRKGvo9MNkAVIxYZUQPleTs17vL7Ah9fAGIFMPTd8kbBvPIrFWGwMY9dwBMUpdmpW81FhKqGuNTa7jHrn1T3ZY8084Ohw1VPHRQBei5Mq/QppEnf9YtdzvLrS19MDFzrwN881vnWCVmqaS0cbJqEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875823; c=relaxed/simple;
	bh=BXKnxJAYzI5+BQyq4ke6xQZoUjJgWhMNKWdahyYmu6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lS5ceWxcVI2VgK6cnka0+ImATNM7zIuNBYYFFEtRXK6DxenHHSqyAOU3KU6FGo0KEXOubKFrSSKWkvDSu5IhNrr4KvFR7EHEM1Bi2pFCAFPQxJ5nPcZF0rETUvdNB2qwQTarpLApj6f9+9/pYTzGhsaDx+3LuXU/p8hyySi69Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx2Ceuf3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx2Ceuf3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6f21c2d81so457677685a.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875821; x=1772480621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=Yx2Ceuf3rn7uv1gglKIeb528s1dL+keSxJoRcy3yuOFzHdfVt9ajp1QQnTP84ibS27
         3L9i30AopKWKGPeTTuLXnE1J0vrz3d+UWLXGSEctM2i+m6XgwrT7Vo9WrfJMUllqBMjl
         lrn9d18dEFXgiX7FKQHGV684oZq76bBWx2e3Cb379AYss3HvR1wA9yi/04b5JlnSjMKc
         XN/Zqx4KfVyNo8rY4aS701WlBkSwCyuSd4/LLIob8bFkFfyNys8vV8WWgv/Zv1lWoZOn
         rUVZrpWA0rKGP/k4FRpG/KwC4fiUe0xs3nCgEUz8H3cba1x87Z0awjFiS1iJVOJFZFF5
         bFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875821; x=1772480621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=QL7xR9Ys7Kcj3m1lXx1oaHjuyioW62gaNjVk8oPaXOlCgM37iDNmpT3UQDcrPxZOld
         9cnyc2kvAEBDqFtWMxFjTiul08OjqyCTTEYy8Qxqy7cvMrJyUPveYo0iCmaKidKQZtYU
         koB3ppfeN9b8mIMG/JYCKTHJrxq5oCLmmCnJCegB8DLbZwRCijyHPXoAeDp50RYZi7kN
         xggkfMjywe/lJHhAmWSmR69V+zYEOLCG7I9cPU03r1saQJ52+aFlms6cUOU4GxGs6jvd
         YVxXydlIStsFqrfVUVfPQggMQJuQkxqLHuZwCWU9adjSfsbj2E2jmtgxgJE15N+VBDI0
         UFdw==
X-Gm-Message-State: AOJu0YwxDLmyvXkfBnkOr2GiFtNwYjS8Nbh7MkAqMQBu/yhRzLSb19XJ
	1ihRP+LwzHIlq79zOXkc6uJuQ1ONplyCNvW5gKKCwqjX+kuYR/XoJ/d5JZsWGQ==
X-Gm-Gg: AZuq6aIBA7esosFjY7/9WkT2rUbr4umbarP3IUfx6xf+icVJq01VIcQzpRorX/WB3HS
	KRAUyyzS+82j85SHsUBIbhkkS4/zywOJf922NM4x26d0NRG6Mi7ceLuxAHlCHJ8kwX5+EIJ9kux
	76wLUx4AFi8560iuhb/ltWxJh26lV4LmUHrJO7ubce7WyxalNPA9aKd5G5lPpGRPPNOf6IM0Fsb
	lTf7sLagfsG5zakH1ICKa3AYpJ6Poq7dntl7kLoIC7FfFRIuWdoKNK5M6hUgPr19YFxcUPINqWj
	RQbfSNZ7lswu3d3F/ddh0FGMq3XIvoO0VUwoPlEpYt6Rbd6FGZsBC40kcqkHYKvfVwiVzzt5Xxe
	KJx0vjNrrSkA8htwt2xEb5VDGuKrmBTgcMqSDKm3WRcDVwQZgsHVbM6+JQZJFHPYjN0Bkrp40vf
	MxU5IVQ697mWBUQo4FpS+0IhOp/9M=
X-Received: by 2002:a05:620a:489b:b0:892:5b57:ea41 with SMTP id af79cd13be357-8cb8c9d2672mr1214112285a.4.1771875820492;
        Mon, 23 Feb 2026 11:43:40 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm925307685a.8.2026.02.23.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:39 -0800 (PST)
Message-Id: <6ea263fee9fcf670ca2f9f26fa86a76ce0701c9e.1771875812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
	<pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:31 +0000
Subject: [PATCH v3 4/5] t1900: cover repo info path keys and path-format
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Extend t1900 to validate category-key expansion, path.* key
behavior, and --path-format handling for git repo info.

The tests compare repo info output to equivalent rev-parse values.

This ensures behavior remains aligned with existing plumbing
semantics.

Also keep mixed key/category ordering coverage so callers can rely
on deterministic output order when combining explicit keys with
category requests.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1900-repo.sh | 196 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..dcacf84cc3 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -10,9 +10,40 @@ REPO_INFO_KEYS='
 	layout.bare
 	layout.shallow
 	object.format
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
 	references.format
 '
 
+REPO_INFO_PATH_KEYS='
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
+'
+
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -89,6 +120,171 @@ test_expect_success 'values returned in order requested' '
 	test_cmp expect actual
 '
 
+test_expect_success 'category key returns all matching keys' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init category-layout &&
+	git -C category-layout repo info layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mixed key/category requests preserve request order' '
+	cat >expect <<-EOF &&
+	object.format=$(test_oid algo)
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init mixed-order &&
+	git -C mixed-order repo info object.format layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-dir matches rev-parse --absolute-git-dir' '
+	git init path-git-dir &&
+	expected_value=$(git -C path-git-dir rev-parse --absolute-git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-git-dir repo info path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.common-dir matches rev-parse --git-common-dir' '
+	git init path-common-dir &&
+	expected_value=$(git -C path-common-dir rev-parse --path-format=absolute --git-common-dir) &&
+	echo "path.common-dir=$expected_value" >expect &&
+	git -C path-common-dir repo info path.common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel matches rev-parse --show-toplevel' '
+	git init path-toplevel &&
+	expected_value=$(git -C path-toplevel rev-parse --show-toplevel) &&
+	echo "path.toplevel=$expected_value" >expect &&
+	git -C path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel is empty in bare repository' '
+	git init --bare bare-path-toplevel &&
+	echo "path.toplevel=" >expect &&
+	git -C bare-path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
+	git init path-prefix &&
+	mkdir -p path-prefix/a/b &&
+	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
+	echo "path.git-prefix=$expected_value" >expect &&
+	git -C path-prefix/a/b repo info path.git-prefix >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path style keys match rev-parse --git-path' '
+	git init path-git-path &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path info/grafts) &&
+	echo "path.grafts-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.grafts-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path index) &&
+	echo "path.index-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.index-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path objects) &&
+	echo "path.objects-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.objects-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path hooks) &&
+	echo "path.hooks-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.hooks-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path config) &&
+	echo "path.config-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.config-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
+	echo "path.logs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.logs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
+	echo "path.packed-refs-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.packed-refs-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
+	echo "path.refs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.refs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
+	echo "path.shallow-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.shallow-file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
+	git init path-superproject &&
+	echo "path.superproject-working-tree=" >expect &&
+	git -C path-superproject repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree matches rev-parse in submodule' '
+	git init path-superproject-origin &&
+	echo x >path-superproject-origin/x &&
+	git -C path-superproject-origin add x &&
+	git -C path-superproject-origin commit -m x &&
+
+	git init path-superproject-parent &&
+	git -C path-superproject-parent -c protocol.file.allow=always submodule add ../path-superproject-origin sm &&
+
+	expected_value=$(git -C path-superproject-parent/sm rev-parse --show-superproject-working-tree) &&
+	echo "path.superproject-working-tree=$expected_value" >expect &&
+	git -C path-superproject-parent/sm repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path category returns all path keys' '
+	git init path-category &&
+	>expect &&
+	for key in $REPO_INFO_PATH_KEYS
+	do
+		git -C path-category repo info "$key" >>expect || return 1
+	done &&
+	git -C path-category repo info path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path-format=relative matches rev-parse for git-dir' '
+	git init path-format-relative &&
+	expected_value=$(git -C path-format-relative rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-relative repo info --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info uses the last requested path format' '
+	git init path-format-last &&
+	expected_value=$(git -C path-format-last rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-last repo info --path-format=absolute --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-repo-info aborts when requesting an invalid path format' '
+	echo "fatal: invalid path format ${SQ}foo${SQ}" >expect &&
+	test_must_fail git repo info --path-format=foo path.git-dir 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
 	test_must_fail git repo info foo 2>actual &&
-- 
gitgitgadget

