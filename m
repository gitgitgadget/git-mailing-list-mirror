Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9F28727D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856485; cv=none; b=ftqq67ahgq3plhoKs9QE6FgSpMeP+1JtpPEGwEqcNKxNiFQhmbK6yqJVthvXHK77bJtD/IPGwZXNgc8k0oM9yCoRSjebvdpGoJsfHQ2gmuieBDJL1VHiBIurJruuaOF1ZcYAtH3UYaY8Xd/dLJTAPShqm9wgMHxOl86zofH4HA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856485; c=relaxed/simple;
	bh=BXKnxJAYzI5+BQyq4ke6xQZoUjJgWhMNKWdahyYmu6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FJTnJ6qT5R7iGvQG9r9I//HlfTuJ3UtOitdMfoiH8AdPOZb+TG4b0bas9Ps2TWW0/Q3Nt85muSLtuGhtxou3JrZO7c/duJ3F7veVPkrkeXjait56xLD/D4ZkUoCPicSW75Uy3+zmR8cVUKo76nsAnvEoPhtxBpnagovWilWIEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da9w9XhA; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da9w9XhA"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8946e0884afso72023586d6.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856483; x=1772461283; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=Da9w9XhA8qmD3sOLvs4d5XDKEqcgskbmy40Vcjc+xt1alXEOmG2I02CKQGoZCFi+4+
         f/HNmRpU46Dzi8ANH0axQ9HouD3g9Yo1QgZyOrtSgYvMy07vasT366/nXkr1tmXQWysD
         9jp60jYnhtNDfd4TI/GT51rVNVGfz7al9vD4f6bmSAZuVPth29bn+OaXipBC5HpDoUHK
         axH3nVcFmqzaEZxM98pPRJ5crkkxzicaPKvX1RHfGqspI3Zh+t+J2cyekM+B1UBJHvz8
         J4lRxD7sPB7KAVldXd5uaNFmawunRvltg4+Z+Jn9VuCfI4n0McHHTvMmVU4XXsSFmFAH
         ThOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856483; x=1772461283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=XEPT8Jky9z4porYmmYb6wWmvDmw/BLe5mCfmGqXk3v6vyQKiMbvCtQCqNkH2fZUQl/
         neJI+2kYOOYzqNQF2ieHV+65QGXnfuDqaBlkC9m6hoxbbg3TxWA4CyGUyG1bwCQu6RU/
         MyTaVoU3sgIDyPvx1h5eJKj/phvVSUDM4W2RnRlA3YL0ApoqW2wGqeRY1NUU92W+JQGY
         1CPnUAo0bA4DcOLe4fW/MHRoVEWLg9TEEjulGbW+LcalKypRNYoRD6F+4vr1hIGlBKhX
         2MP330ehGMDggByN+CRTScMP/aayCDDGA0f5Q9g47rGFTd0esfexMbwgAaE7USd1Dxzn
         tsNw==
X-Gm-Message-State: AOJu0YxrkWJZqflXOXmhy4TuDBKknb1fWejubI5g6f3l3LjW4d1ixCwy
	OSgXCWvNH8ZoHdFVEczREzUPhP6zJqfswdKI4GApqt/4B0A4ETpv1MqBr2pYjOf0
X-Gm-Gg: ATEYQzwHXDYJC+ofqou4rplbakBSU2gRiGMR99Nph8JPKiDE6JI55hmCduLGLWS/8gT
	gJ5X6v2Ssnmh/Xrg3O7COy8xXkjplJXv8YSaT/PSqmrUQPcIOQlqjERNgpOiEMxsiE6snHEjkKE
	Nr3CrBCnRKNL745Itxf4akzG3SRbg+XTFfr3wOQDZS/uyZiol3uRd1qPcMST/xKbSwaBZ27MbNZ
	OvHk2ny+SdjRfOOqapuGErBV1cpw0l1fe9UOHIhBZSKkeY3fvTVX7UcxC0cw0GNzlwaAj3Jq1Rh
	eRX35YWDeJjvvIWS7rIFlfUFMHfcQg2861FoTp6LyD8QqGKzngonxZ0TjjAgXO9aIu68KeGow72
	398RZTZ91nsJlmsHgzO+UADtPhkkQV3WalQniruVZ1/RNvD+a3B1hqkNc3PnR/ycth6COs5Nas7
	UySbCbXOPJaaIyhP7BxIIHQW8=
X-Received: by 2002:a05:6214:62b:b0:894:71c4:d2c6 with SMTP id 6a1803df08f44-89979cf46cfmr141750456d6.29.1771856482821;
        Mon, 23 Feb 2026 06:21:22 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6911ebsm65919926d6.7.2026.02.23.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:22 -0800 (PST)
Message-Id: <fd18f28db0bac01317c892f14bd9bf16038e07f0.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:07 +0000
Subject: [PATCH v2 7/9] t1900: cover repo info path keys and path-format
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

