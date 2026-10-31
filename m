Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441206;
	b=L0Tzu/LvFuJPH5ny1rn/cy6g/QOeZA65KD0dQ6dqiEssl3jsr3UQtXv69MKGSunBXIHN
	 mkbHRAbZJQAe8rwprAD0J4TAFdF9Cpb4B5gTHPICQe3u+hyelgXmYtx3NWfV/ibUMzEQi
	 GYaIRZR2IIlQfypeyDTImRWq4dnl0PjlPjGkUl14XX2QtEozH4fhRZc0tAXtMPXJRlLDA
	 SKfwScB/zWk+5qX7X6/hpT+iKxWnydxgf2XFS1CGP8IEB3q/v7lJfcjFhnrrgmMwQcaQm
	 MReKZ21I8JdnSP7/4ceCob44VIFwlN/jYjchUBiPktTgAIz2YwXBsXdvNVDroCCO5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=zh2NQrxX85uxvb6nmWqxaMjGSL6MB1t2kujZPkhME4Y=;
	b=EHVRkCzNzgzWYds1G9vaukwQH9s6VjFUqP91AxG9EGPRXNwdFJ/It96uVcdAk13QM/5p
	 kfwHDJXDdpzSIBPPzDtlLFvDZb20Mj9GZqyzrVdMyekfMc6Osiwhwzh4eDSDq9mQAG8Ct
	 rNVjbbPegxIY2jFz3wT5mOyCkq11fA6veOx2vgvMhQHSbyGQjMrnIhUIOwUUrQBNAVgg6
	 Ykuu5vQkV1iyBBD3Gz4P9QPjfTFHXgm6WX0ts8sy0Kbr3blkctq7LqjB81TFW+G7Hqyuf
	 9wi/1FUD5p5bcBa36pWS5nCl4igkJ06MSviDDHYv6fRA03v6SgSniHNFL37otjkBT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1gOhTA8;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D39606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1gOhTA8
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2566762eec.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441205; x=1794046005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zh2NQrxX85uxvb6nmWqxaMjGSL6MB1t2kujZPkhME4Y=;
        b=C1gOhTA8VZNa5wGLSQzffOGqJqgm6UcbmZEZSOCVhhlFcBV1j3L+Zq3KcAEsz7DIBD
         XWMNdjgIFLjxeDjdBPhR/EIY5cEzArHyq2qpx6MP0CHM3yfMlaMXnxbar73MCuxBIzee
         aHHvMHaesTLgQwQABUldYnsVJoT0C5S7qRU52oKBtmuuvHDsPc/VQIPibQ7mI/1JWxlm
         usiha13ykvUEpqK8Lg2p+CfNWTWO/Q4+8xHnW/lRHcZddRCkBKJRYag1r/k23PDDT6Jx
         2V2NaCmnRvy5utY7W/qS3Nt4ILEBkeMHnl6XrKVQqTt2WxOjoKMqRmNEw9RuShw1SEpx
         6XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441205; x=1794046005;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zh2NQrxX85uxvb6nmWqxaMjGSL6MB1t2kujZPkhME4Y=;
        b=kr98YhVuSXatvA8ZQuRZtA285xpWos9uXTVFxpWzhkZPvXx7lSveqpKkHSOAVwIEjV
         QSWSmaUCMBBOQ+XUlYDdy27N3vfkgt8cs2yHvAo8QZ2jQZt1471aIZ3qkhRLCX2sllod
         pcK4qQ8mfXhGX4ZPFlOohNh6X2udqY77aNgp+FsZTTxFWYe3Ayg33PF2S9PILghKe9jX
         BR59pVqzlRXjO1wEmny7tiJDZjoeJ23Y+mFL+z3Mb0BmVl8rNepwvhdsmnR0QkKe194w
         AmssdE+/WZP3XzS/oB+i40EaWu1MbSKSUCBBoifGaiS8V/jWiatwMfU4dXkS+V7n69nz
         uW7g==
X-Gm-Message-State: AFq9FYLUHZ+0EYPuE22vky9JPv2Yulo/VObhZLiSfqjjQHz3OwOwfU+Z
	MHixImoTBVIIrQFIv4R2lMDqKPZsmE2LBWB5wGxV2jI8frseblL8mdym0RsoEShh
X-Gm-Gg: AYBFou12Vcio80OAy805LHIMQ9sh7O9yA4wWmWyjSyferrh5Qzm5JuSmM83r774KXiu
	KinN+9FA3NEbOjFCB342g2ZJ/8podj8SdPNjsIN8VXSvdEoT+ni0161pTJmzjmfHhI5sbS5pDn7
	z/GgfWS4HNekTC5pA+dxBWlFIuOw1do6k9ZyRfq7mdprqIKajPkTte3pRF0I70Vp3hFqWh9nsnW
	tjAwCi1ZUVMgaIVbIyTKU6nn4zjN1pIK78MUYUbPfwQvjpZh1q7A2coNW7cPYtaJQGl0ctxkwXI
	NOZNi2qdXD0zI01Hy9urQptGyKfAkZkC2/k0FKjIGbaPsL1xHItsmCt3i9N6WC+fMbJUxM2kxxD
	+J8vhpAyN1PxZq/QwUGKKq+WDAOIozhgpIc9Vk6qO8qnw3NhogybpTPD7yQ0KRYwO1JV514CQIE
	crY/L8oZS/+Hbi+kZaVeLtwQVn1AbtjSgBrkn38bhN7q28AwZIM6+qtjnGdd/viweFtPiHgkWy2
	vKH5XrLnH7vZn0rfAFdG0kDqRlVgJn3msezk7m6KqXbBEYsC2093qFP4/yo7Vziy1W5Kn7F+hKc
	r3051hNuuWG3lyKsGjBQFECQL7rlTP3DllRs1TZgkjcwGnUu3K62
X-Received: by 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-36a42404ab3mr7398384eec.20.1793441205258;
        Sat, 31 Oct 2026 03:06:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.82.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm17546687eec.29.2026.10.31.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:06:44 -0700 (PDT)
Message-Id: <pull.2284.git.1793441202854.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 10:06:42 +0000
Subject: [PATCH] merge-ort: accept rename settings given without a value
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git -c merge.renames merge" fails with "missing value for
'merge.renames'", although git(1) says that "git -c foo.bar" sets
foo.bar to true. The same happens with diff.renames and
merge.directoryRenames, and with a setting written without
"= <value>" in a config file, which git-config(1) also documents as
true. Every command that merges through merge-ort fails this way.

merge-ort reads these settings with repo_config_get_string(), which
rejects a missing value. Read them with repo_config_get_value()
instead. git_config_rename() and git_parse_maybe_bool() already take
a missing value as true.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    merge-ort: accept rename settings given without a value

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2284%2Fthomasbachem%2Fmerge-ort-valueless-renames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2284/thomasbachem/merge-ort-valueless-renames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2284

 merge-ort.c                               | 20 ++++++++------------
 t/t6423-merge-rename-directories.sh       | 17 +++++++++++++++++
 t/t6434-merge-recursive-rename-options.sh | 12 ++++++++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..24ddd97696 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5453,31 +5453,27 @@ void merge_incore_recursive(struct merge_options *opt,
 static void merge_recursive_config(struct merge_options *opt, int ui)
 {
 	char *value = NULL;
+	const char *v;
 	int renormalize = 0;
 	repo_config_get_int(opt->repo, "merge.verbosity", &opt->verbosity);
 	repo_config_get_int(opt->repo, "diff.renamelimit", &opt->rename_limit);
 	repo_config_get_int(opt->repo, "merge.renamelimit", &opt->rename_limit);
 	repo_config_get_bool(opt->repo, "merge.renormalize", &renormalize);
 	opt->renormalize = renormalize;
-	if (!repo_config_get_string(opt->repo, "diff.renames", &value)) {
-		opt->detect_renames = git_config_rename("diff.renames", value);
-		free(value);
-	}
-	if (!repo_config_get_string(opt->repo, "merge.renames", &value)) {
-		opt->detect_renames = git_config_rename("merge.renames", value);
-		free(value);
-	}
-	if (!repo_config_get_string(opt->repo, "merge.directoryrenames", &value)) {
-		int boolval = git_parse_maybe_bool(value);
+	if (!repo_config_get_value(opt->repo, "diff.renames", &v))
+		opt->detect_renames = git_config_rename("diff.renames", v);
+	if (!repo_config_get_value(opt->repo, "merge.renames", &v))
+		opt->detect_renames = git_config_rename("merge.renames", v);
+	if (!repo_config_get_value(opt->repo, "merge.directoryrenames", &v)) {
+		int boolval = git_parse_maybe_bool(v);
 		if (0 <= boolval) {
 			opt->detect_directory_renames = boolval ?
 				MERGE_DIRECTORY_RENAMES_TRUE :
 				MERGE_DIRECTORY_RENAMES_NONE;
-		} else if (!strcasecmp(value, "conflict")) {
+		} else if (!strcasecmp(v, "conflict")) {
 			opt->detect_directory_renames =
 				MERGE_DIRECTORY_RENAMES_CONFLICT;
 		} /* avoid erroring on values from future versions of git */
-		free(value);
 	}
 	if (ui) {
 		if (!repo_config_get_string(opt->repo, "diff.algorithm", &value)) {
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 24d4c5447b..da145c150c 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -97,6 +97,23 @@ test_expect_success '1a: Simple directory rename detection' '
 	)
 '
 
+test_expect_success '1a (valueless): merge.directoryRenames without a value means true' '
+	mkdir valueless &&
+	(
+		cd valueless &&
+		test_setup_1a &&
+		cd 1a &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames merge -s recursive B^0 &&
+
+		git rev-parse >actual HEAD:y/d HEAD:y/e/f &&
+		git rev-parse >expect B:z/d B:z/e/f &&
+		test_cmp expect actual
+	)
+'
+
 # Testcase 1b, Merge a directory with another
 #   Commit O: z/{b,c},   y/d
 #   Commit A: z/{b,c,e}, y/d
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index 5a6f74839c..427de2ba95 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -332,4 +332,16 @@ test_expect_success 'merge.renames overrides diff.renames' '
 	$check_50
 '
 
+test_expect_success 'diff.renames without a value means true' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git -c diff.renames merge-recursive $tail &&
+	$check_50
+'
+
+test_expect_success 'merge.renames without a value means true' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git -c diff.renames=false -c merge.renames merge-recursive $tail &&
+	$check_50
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
