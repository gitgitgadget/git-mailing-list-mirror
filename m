Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F90849C
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084957; cv=none; b=JpJ0dVMa82XS6YpURvb+wcw+ZRKe8hA3zirplwBhOEnZ4uzxQsCfCNZUcrFcqVcFWgKYGJmA8ocAbd73AWM3oBAPnk8JXfHf9+HACKS+wdOJRhpl7wYGoK+9/G1Zv74pGjeSpir5TVKMbgsf0OmKp5nVgVJ5UkO7O7d6xDR2aDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084957; c=relaxed/simple;
	bh=WAWnmXpVNRml7p2qjdvfC6Ocv2EN15hGeSPwmqahlQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja5kP74cMGtB84MonZX/orqzBXyczCov3iZDiYv/INopyWnl3EtitZLPVmFYSuzR8V13v2WgpFCS+xwFzwEZAzylt+QD+m8Z7kFfYH0mt+FtiCjfNVmVX91erYLbLj5WdkgtuuRHbFeyjfBK+rZFLnb1J6OIZz1+1TS6BmoAMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdcxdozM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdcxdozM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso14281425a91.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084954; x=1736689754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+fVAmzLQ4Om50kyTFGW++t5pk9Lgq8uMnlI+JyO7Hg=;
        b=MdcxdozMMOAg2spWQ7SwViwQFPHrl7d0wfoAvwR6P+5BDyGfKR/ytLPTPseAIhtXi2
         lkzIZOjJt7XTf/LSqaTRCJ9vchcdRcz2YyzdsRYp1yQG+I0Op1sjupY8pht5SYRcwrdL
         XJtxhvEphocI8t16b4kvoKcoMFlSrslbrWUyXlLv/OPIr/Xq3tWwa78dgjqRwd0i2389
         kBOGKiwWSTz436glSBLLZ7pAD9Mn9eSOxGYggOYm6ZaF3kYPnNj38oJVi7Ws/nzLCXRN
         t12kThO1SOVJbHZqi6WqM0crFE5u3cdmxHCLFZInsjZt9RZKdQELSa9o8mxn1kmqtGWR
         h10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084954; x=1736689754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+fVAmzLQ4Om50kyTFGW++t5pk9Lgq8uMnlI+JyO7Hg=;
        b=Dh9An5RtG/yBGdqcR9K+VbnBk+qVv88YnKwJUExTLpHVTbLzAPBGA7s107L/bk43QY
         oFVVLRVocz5ZhhsayFpJPAojcMbfx8gJTcsToRiKbbtuFtzyc48dZysmhn+kNFqyxn/l
         WyOqpt/6E9AO7afzMTiMu7xz3SsIRoKIoqbcakEXh0DJCcj+mXCq6d/WIkT7AttvXX/t
         Kd25WgpMNsrLxgn83jD/NZh3eyP4b5oUeBsaE8DNoJIvbonJi6P97eDd5zjJATNyiUvQ
         5Z9sY2ZWhTmat2PzPhJPSqNMRamsQO8hwkQXjhm5Nxeq8Ey6oa3spdrZdMSxPZrhON2b
         GOng==
X-Gm-Message-State: AOJu0Yz8F/6JU8fxev8D3aszsuPs0uszfmPBx3qe15htKWkbNW9b8WxU
	swVgtfAvwuazhJ3+5mlzNeNwvgwRGzi+JUA6WDAIFx3gCISockqYx4LhNA==
X-Gm-Gg: ASbGncsl/JBLdXLE4/M0RZ0BX5sjyJQfPuhCRhKSj1Era8e11h5L5IaU9En9Ci3bp/Q
	q8Qeao1VJCKjluodoR3+nC/jnFIZLTgL7Nh12ISK9424tXkcUw8T+KJxyjTylHslPlauoHbUxSu
	iOZ23mb2AMU/IEMxDjSesoCwIwxoQmlcZ59EmAxUE9eDRzl91fgYBXnPRI2NEdcmRoLIBjECfFp
	iIirnsxXn4QyyidDUyQLxDCspoYDgkBZCU=
X-Google-Smtp-Source: AGHT+IEH+5/WWJQHDU801v1xcBBkFboutv0epXrh1ekCR1zYNXv9pHq+MGIRet3WjXiznkfyc/gMKw==
X-Received: by 2002:a17:90a:da8e:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2f452ec2919mr72851492a91.23.1736084954134;
        Sun, 05 Jan 2025 05:49:14 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e91sm275612925ad.274.2025.01.05.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:49:13 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/10] files-backend: add object check for regular ref
Message-ID: <Z3qN1T3lJoj82ckl@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

Although we use "parse_loose_ref_content" to check whether the object id
is correct, we never parse it into the "struct object" structure thus we
ignore checking whether there is a real object existing in the repo and
whether the object type is correct.

Use "parse_object" to parse the oid for the regular ref content. If the
object does not exist, report the error to the user by reusing the fsck
message "BAD_REF_CONTENT".

Then, we need to check the type of the object. Just like "git-fsck(1)",
we only report "not a commit" error when the ref is a branch. Last,
update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     | 50 ++++++++++++++++++++++++++++++++--------
 t/t0602-reffiles-fsck.sh | 30 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 64f51f0da9..0a4912c009 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -20,6 +20,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../object-file.h"
+#include "../packfile.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
@@ -3589,6 +3590,34 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	return ret;
 }
 
+static int files_fsck_refs_oid(struct fsck_options *o,
+			       struct ref_store *ref_store,
+			       struct fsck_ref_report report,
+			       const char *target_name,
+			       struct object_id *oid)
+{
+	struct object *obj;
+	int ret = 0;
+
+	if (is_promisor_object(ref_store->repo, oid))
+		return 0;
+
+	obj = parse_object(ref_store->repo, oid);
+	if (!obj) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_REF_CONTENT,
+				       "points to non-existing object %s",
+				       oid_to_hex(oid));
+	} else if (obj->type != OBJ_COMMIT && is_branch(target_name)) {
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_REF_CONTENT,
+				       "points to non-commit object %s",
+				       oid_to_hex(oid));
+	}
+
+	return ret;
+}
+
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *target_name,
@@ -3654,18 +3683,19 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	}
 
 	if (!(type & REF_ISSYMREF)) {
+		ret |= files_fsck_refs_oid(o, ref_store, report, target_name, &oid);
+
 		if (!*trailing) {
-			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_REF_MISSING_NEWLINE,
-					      "misses LF at the end");
-			goto cleanup;
-		}
-		if (*trailing != '\n' || *(trailing + 1)) {
-			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_TRAILING_REF_CONTENT,
-					      "has trailing garbage: '%s'", trailing);
-			goto cleanup;
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
index d4a08b823b..75f234a94a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -161,8 +161,10 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	test_commit default &&
+	git branch branch-1 &&
 	mkdir -p "$branch_dir_prefix/a/b" &&
 
 	git refs verify 2>err &&
@@ -198,6 +200,28 @@ test_expect_success 'regular ref content should be checked (individual)' '
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
+	for tree_oid in "$(git rev-parse main^{tree})" "$(git rev-parse branch-1^{tree})"
+	do
+		printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid
+		EOF
+		rm $branch_dir_prefix/branch-tree &&
+		test_cmp expect err || return 1
+	done &&
+
 	for trailing_content in " garbage" "    more garbage"
 	do
 		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
@@ -244,15 +268,21 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	bad_content_1=$(git rev-parse main)x &&
 	bad_content_2=xfsazqfxcadas &&
 	bad_content_3=Xfsazqfxcadas &&
+	non_existing_oid=$(test_oid 001) &&
+	tree_oid=$(git rev-parse main^{tree}) &&
 	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
 	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
 	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
 	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
 	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	printf "%s\n" $non_existing_oid >$branch_dir_prefix/branch-non-existing-oid &&
+	printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+	error: refs/heads/branch-non-existing-oid: badRefContent: points to non-existing object $non_existing_oid
+	error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid
 	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
 	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
 	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
-- 
2.47.1

