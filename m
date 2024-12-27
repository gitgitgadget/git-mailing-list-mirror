Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C751F37B3
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735306910; cv=none; b=qZcviwPCzyHUbgm3zfUzaChhnAGJNR/XPg0EySwsMi8XHLHAUzFE3Ou4iQxb4oiYMLbe1r7qFu/Ct9EJHaed5cvAsTWOSLmHPKdwggC2HY81lnyAgT5L0CbYvc6l71ufqjrEpJKrwdIlruVo/AZU8fvsBMwSuerYat8r4sEsNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735306910; c=relaxed/simple;
	bh=DUrW58Dqn0kLs4USP0Y5quWJ3otU7bG3gBlNJgIXxQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUTZ9mkCymO7ksIwbL/5ln1Zd2Lis41whz1ljVjRB9pRs/uwgQ9SyS6Os9Ca7iWeyvtTYM6GJMXJFottN9cICr1mcy7gEZBJ/7sI2pam+myLapU9pdOmpH/gxZ6mgpW6oSbcV3qS3Dc/Gt1um1P9Ob5D3lan/rH5LjcP3qVVbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuN4c7br; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuN4c7br"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216426b0865so86171495ad.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735306907; x=1735911707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkHb+tV/D4ZcNmDvBeMljPbrqfAp6B/SM+kcXyLeUjE=;
        b=NuN4c7brSf69QOEhFOcfV7eAD76hlw90gQgITPJeKSvB3uqEkMF+arbRVoloAqBR73
         rOmbB1tEB3nxChRBRKTG5J7wUWWC71TiCdsfZ0CqVss3Muu07ab55pceMgrIhA6QuPTm
         PQQ582GVNfIwao9YAcM+uIRmgs7H193arVoeOY1LXcKOdTvXgu/fAr5D9H0/JIozfaR3
         Neqg24KFFEtqWZ3TwOlgshVEC+vvtlea3xuFA8/d4fhUhEhHq31VgFMjLlWBzXY5/Y8m
         m30LerTWZP4k96QDTf4KbUogEi5x4cxSJFO0yo6Xi18gXYaAKqVKPsIc7wau6VjaOF/+
         WhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735306907; x=1735911707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkHb+tV/D4ZcNmDvBeMljPbrqfAp6B/SM+kcXyLeUjE=;
        b=ZbA+s4us4tHsAfZcGjfV6eH5iZz7Wzd7d43Qu3F0qSYuvG2UMSF7rjB9XUALLUM2Gg
         p8EGD0y3WyJn2KW7NLwOo8IWXXghXUkYdFhvg/XbpKNdUHUHmM4emJRAf9kMProT0qXd
         Egl+CVLCUlAsqz/RaELx9gZOLPHt58caJiOlt0QWPukLsUg50xoytn8PLC1maHfOV2Ca
         hzlmDBG8BERUhrE59n/qywI2WgoVW47HICOxdYNujvuHF+SocGCDrvjLflNt0m+6T20a
         4ylg/sPORXjL5YPrj+ZRzhRF53Ck9HWkEvKEjaEjQayZln7XNXwQW7yEtr6aCSM2UUxS
         8BFg==
X-Gm-Message-State: AOJu0YwzIh7qC6Hy2tmfNEzA+2KdspLfwQ4+P1bq9tv0ZQ6sPKVLXKKS
	JaR6MiDH7YEA+P3bUJ9egPQ1JCv+a0NJwq5OS5D+II3pHEumImhQy9621Q==
X-Gm-Gg: ASbGncsUfFnqih2fz/hBAEYpJfN+immXehJdxnINedquXrSyydj72ktw/2HhO2Cy+HU
	RHmwVZ/0fF9JA1zSp3nhCwePNoMZGvHrCTHz1wa8QFTTzK7cQn/8shXWH5K77Uey5i26tB2ghC2
	xrpSwqpApgLwk5Qqy5bgkaugULW7TxHJ4tFwvV59E2WWxVe9DvdPS8I5MDbHXyDedted2HmmBV7
	C8o7MtM1O3I1z0dzdMnDFP7yd4RxEevcn9/KThPPc6CBXwx1aUm
X-Google-Smtp-Source: AGHT+IECIiXM6yX+jU1/dmSImrgdIfoWc9zIQBerAEKHub4iHrJRKxncUcTIo1ubrX/G/3bQBLn7WA==
X-Received: by 2002:a17:90b:4ed0:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2f452e22604mr40741012a91.10.1735306907379;
        Fri, 27 Dec 2024 05:41:47 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c8578sm15689338a91.20.2024.12.27.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:41:46 -0800 (PST)
Date: Fri, 27 Dec 2024 21:42:38 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] ref: add object check for regular ref
Message-ID: <Z26uzrjxXeXgrx2J@ArchLinux>
References: <Z26uXy31q83dyxvD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z26uXy31q83dyxvD@ArchLinux>

Although we use "parse_loose_ref_content" to check whether the object id
is correct, we never parse it into the "struct object" structure thus we
ignore checking whether there is a real object existing in the repo and
whether the object type is correct.

Use "parse_object" to parse the oid for the regular ref content. If the
object does not exist, report the error to the user by reusing the fsck
message "BAD_REF_CONTENT".

Then, we need to check the type of the object. Unlike "git-fsck(1)"
which only report "not a commit" error when the ref is a branch. We will
check whether tags point to either annotated tag object or commit
object. For other refs, we check that they could only point to commit
object.

Last, update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     | 50 ++++++++++++++++++++++++++++--------
 t/t0602-reffiles-fsck.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cfb8b7ca8..816aced923 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -21,6 +21,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../object-file.h"
+#include "../packfile.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
@@ -3703,18 +3704,47 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	}
 
 	if (!(type & REF_ISSYMREF)) {
-		if (!*trailing) {
-			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_REF_MISSING_NEWLINE,
-					      "misses LF at the end");
-			goto cleanup;
+		struct object *obj = parse_object(the_repository, &oid);
+
+		if (!obj) {
+			if (!is_promisor_object(the_repository, &oid)) {
+				ret |= fsck_report_ref(o, &report,
+						       FSCK_MSG_BAD_REF_CONTENT,
+						       "points to non-existing object %s",
+						       oid_to_hex(&oid));
+			}
+		} else if (obj->type != OBJ_COMMIT) {
+			const char *err_fmt = NULL;
+
+			/*
+			 * Only tag can point to annotated tag object. All other refs
+			 * should point to commit object.
+			 */
+			if (starts_with(target_name, "refs/tags/")) {
+				if (obj->type != OBJ_TAG)
+					err_fmt = "points to neither commit nor tag object %s";
+			} else {
+				err_fmt = "points to non-commit object %s";
+			}
+
+			if (err_fmt) {
+				ret |= fsck_report_ref(o, &report,
+						       FSCK_MSG_BAD_REF_CONTENT,
+						       err_fmt, oid_to_hex(&oid));
+			}
 		}
-		if (*trailing != '\n' || *(trailing + 1)) {
-			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_TRAILING_REF_CONTENT,
-					      "has trailing garbage: '%s'", trailing);
-			goto cleanup;
+
+		if (!*trailing) {
+			ret |= fsck_report_ref(o, &report,
+					       FSCK_MSG_REF_MISSING_NEWLINE,
+					       "misses LF at the end");
+		} else if (*trailing != '\n' || *(trailing + 1)) {
+			ret |= fsck_report_ref(o, &report,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "has trailing garbage: '%s'", trailing);
 		}
+
+		goto cleanup;
 	} else {
 		ret = files_fsck_symref_target(o, &report, &referent, 0);
 		goto cleanup;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index d4a08b823b..ff4ccd250a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -161,8 +161,10 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	test_commit default &&
+	git tag -a annotated-tag -m "annotated tag" &&
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
 	git refs verify 2>err &&
@@ -198,6 +200,47 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	rm $branch_dir_prefix/branch-no-newline &&
 	test_cmp expect err &&
 
+	for non_existing_oid in "$(test_oid 001)" "$(test_oid 002)"
+	do
+		printf "%s\n" $non_existing_oid >$branch_dir_prefix/invalid-commit &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/invalid-commit: badRefContent: points to non-existing object $non_existing_oid
+		EOF
+		rm $branch_dir_prefix/invalid-commit &&
+		test_cmp expect err || return 1
+	done &&
+
+	for tree_oid in "$(git rev-parse main^{tree})"
+	do
+		printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid
+		EOF
+		rm $branch_dir_prefix/branch-tree &&
+		test_cmp expect err &&
+
+		printf "%s\n" $tree_oid >$tag_dir_prefix/tag-tree &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-tree: badRefContent: points to neither commit nor tag object $tree_oid
+		EOF
+		rm $tag_dir_prefix/tag-tree &&
+		test_cmp expect err || return 1
+	done &&
+
+	for tag_object_hash in "$(git rev-parse annotated-tag)"
+	do
+		printf "%s\n" $tag_object_hash >$branch_dir_prefix/branch-annotated-tag &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-annotated-tag: badRefContent: points to non-commit object $tag_object_hash
+		EOF
+		rm $branch_dir_prefix/branch-annotated-tag &&
+		test_cmp expect err || return 1
+	done &&
+
 	for trailing_content in " garbage" "    more garbage"
 	do
 		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
@@ -239,22 +282,34 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	test_commit default &&
+	git tag -a annotated-tag -m "annotated tag" &&
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
 	bad_content_1=$(git rev-parse main)x &&
 	bad_content_2=xfsazqfxcadas &&
 	bad_content_3=Xfsazqfxcadas &&
+	non_existing_oid=$(test_oid 001) &&
+	tree_oid=$(git rev-parse main^{tree}) &&
+	tag_oid=$(git rev-parse annotated-tag) &&
 	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
 	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
 	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
 	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
 	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	printf "%s\n" $non_existing_oid >$branch_dir_prefix/branch-non-existing-oid &&
+	printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
+	printf "%s\n" $tag_oid >$branch_dir_prefix/branch-tag &&
+	printf "%s\n" $tree_oid >$tag_dir_prefix/tag-tree &&
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+	error: refs/heads/branch-non-existing-oid: badRefContent: points to non-existing object $non_existing_oid
+	error: refs/heads/branch-tag: badRefContent: points to non-commit object $tag_oid
+	error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid
 	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
 	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+	error: refs/tags/tag-tree: badRefContent: points to neither commit nor tag object $tree_oid
 	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
 	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
-- 
2.47.1

