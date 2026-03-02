Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8957249EB
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428562; cv=none; b=QLMH+0HiakyxFmIQuq/nPw+gbTjON2v0p3ZqkLQrOrQEQ/9WiIKpUMQ6oIsLV8JBpCudqTPyF+zJyqUNlAbk9+xxZ95tgjSudPGOta5NzgALGi1IbC8nPPcRRPF4m9WYjKnh1Z1yMk2rGJYLQo34kA+BV6YhhCZm+3TzGiDQXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428562; c=relaxed/simple;
	bh=n8aN9Tczbn+mHy38hf+5QEuHsf7+h0kfEik7d+etKQM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iwG2Cbe/xcwZlQyXyQT+fA5vsov/fIGBC1YxZ7ohdoPJ9TjAN1ZbP+5BMZGDxkVl8b80pE8hUMJQrUX59oi4P4eH8ojYKHX1SGnBd39Tb5qo5PG9xEJqtJQraxFuMucGoBMoKxllakxe/NoMlnRC/80sZGEllf4DQw4767ZtGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWV9dHfB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWV9dHfB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ca01dc7d40so426717385a.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428559; x=1773033359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDVw87JEG3IO5ACxbdn497Y2PzsgfNwpRrmJ+vDlV5c=;
        b=FWV9dHfBti25u+dB8Dda0NGZMIP3Ov+GHMZ1gtN3/1A6RHJuMGwtzKWAJYdHSdGnIt
         4IvCeOcKplf+bGrbi/rokvF96SV7bEzSGQ3q8ev6r1/JhSU2q+/IHvK5Bz3OOIETbOHB
         Hz/6X6TWfQdtSlUeoS1isUb4CfMBWz+Xmp/Blvp6i0eLaNs5JaUXk2vlAXGcOgGiDRIg
         lFZ7h/A/9czD3hzcC1CAYL3/0Asq7HXbuoJOam68UFeE0MJCvQARQaTeaWft7jdBOCF7
         leTGqOwRrKLUobKDHcb1v5l0Abs1XVm7iQvJWie9S1bYVAvZ7VrAgScPnrFt9sLed/Js
         UhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428559; x=1773033359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDVw87JEG3IO5ACxbdn497Y2PzsgfNwpRrmJ+vDlV5c=;
        b=TZuZO8nEAktNun2nwhk7uBcD5WM6i5FPedL/riGsA+Q9bTOhqKt2/UX8YsEr6YTgub
         xlCZL1K+OA999J8RY+hOvOcUcnR/wcy5d+JHZdGhyJMeuYXdyhFGrrC92/9E6vi4sS01
         S/xAivtbD20o/Hl6MB9Gf+lFdcVU7IUsjRrPg9gRDjK5PBTiSqGH7Ij0vCHkYgztmP9H
         ZHVE4b/N32hD3+3M4gCpAAxeWmh0O40ZfIoaG2y7LXgiOL9i7g9HHa1tLYfDcXdWOxlC
         Up+MVryMe+Ja0Usf/kmSpeMu10XVETpPah0ywESMpPhFQoTZgeYDKKt4nKuUWeDUtA73
         kHTw==
X-Gm-Message-State: AOJu0Yx5cnqZuM+J3h1/Tv4swlzDAY/uAraZBdhD/HM7uSQUtBxoMLl8
	3cba4EyrfpxP/TsoQiMw+R/SQtXKbLhTrOjrzlDDaMkT8n130QJsYXzY+ySQpf3Y
X-Gm-Gg: ATEYQzxdUstb+JLPwjF4aPyDmFwqtRFRlnGsEFQYw7DITtRvJ0uRDtsnx77xhstopeL
	P5GSu+j9JKNDSZgQtoOxB8+i5PQgXN1T4qucNWbNNmxRkZrD4lozGqhS08ptV3BPjUMCpPisQAJ
	SHcCmgr0BjD6N6zrrsJ/ZgudiUAY9W5fpMO4IfTPi6CPKkjcWEOApUzNP02JKsfqMx70ymXsOTV
	j9sHp73aVUA1EXVe2cz1Mg+dYdIHeCFE8bdkbFzk5FQgbozZMt05Ajvuu1/3h32hvce2jhskMF2
	8TVzoKGQmvmpuKbfZcI4AnDQuyUuNwrbkUrRW+u2fsuo7yTVs44D3wVxz6uoa6a3+PlWvq4Vwnh
	NcUoX0VGTSpb7A475MCyI5g8a6ZsmovEMpgFAo/sYsgvncxe9MWR5+nxTSwCEM3V4OmM6QXvsk9
	QcIGn8Agb4e1VOHFppkQIpfe6eNw==
X-Received: by 2002:a05:620a:bd3:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8cbc8ef759emr1486001485a.51.1772428559222;
        Sun, 01 Mar 2026 21:15:59 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm1068648085a.14.2026.03.01.21.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:58 -0800 (PST)
Message-Id: <1e52e7bd7f124481910d455da388c75636b5cb38.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:47 +0000
Subject: [PATCH v6 5/6] t1900: cover repo info path keys and path-format
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
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
 t/t1900-repo.sh | 194 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index a9eb07abe8..6605394d1f 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -4,6 +4,40 @@ test_description='test git repo-info'
 
 . ./test-lib.sh
 
+# git-repo-info keys. It must contain the same keys listed in the const
+# repo_info_fields, in lexicographical order.
+REPO_INFO_KEYS='
+	layout.bare
+	layout.shallow
+	object.format
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.objects-directory
+	path.prefix
+	path.superproject-working-tree
+	path.toplevel
+	path.working-tree
+	references.format
+'
+
+REPO_INFO_PATH_KEYS='
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.objects-directory
+	path.prefix
+	path.superproject-working-tree
+	path.toplevel
+	path.working-tree
+'
+
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -80,6 +114,166 @@ test_expect_success 'values returned in order requested' '
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
+test_expect_success 'path.prefix matches rev-parse --show-prefix' '
+	git init path-prefix &&
+	mkdir -p path-prefix/a/b &&
+	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
+	echo "path.prefix=$expected_value" >expect &&
+	git -C path-prefix/a/b repo info path.prefix >actual &&
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
+	test_cmp expect actual
+'
+
+test_expect_success 'path.working-tree matches path.toplevel' '
+	git init path-work-tree &&
+	expected_value=$(git -C path-work-tree rev-parse --show-toplevel) &&
+	echo "path.working-tree=$expected_value" >expect &&
+	git -C path-work-tree repo info path.working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.working-tree is empty in bare repository' '
+	git init --bare bare-path-work-tree &&
+	echo "path.working-tree=" >expect &&
+	git -C bare-path-work-tree repo info path.working-tree >actual &&
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

