Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFC1741CF
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015145; cv=none; b=iNfFEwrI2XPUYZ6tYuA6BiBfoKMM376gQPWBIyoQfgMiH9JA/XLQehFYe6IlURy4QUHCJAQuJqi2myOK7+aW6YVgYQzlA3F4Kzctb8uLBcB80z4pdIH6iMLVvo+qVQBfLi2b4o3sTcS7PDYj4y2Q5yHZjArm+BcCBxXVL+DOk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015145; c=relaxed/simple;
	bh=rsrODM2J+BWsKhm3xax6cqZkAC7HLfeiG3WeFmJYGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7x2rk+QW1HVS8TjLc5iKpZTAPKyc7NpYdjLpYfTk8ieiGyEKC1ZQIStuXCy5cfUDruOo4zokOUdJ4wsZZPTsFiC3ZOGzdmMyK/4iyyPZDCPS8y7iwxu2ZaI+XeqSD72Xv4fscmbQ59diO6FNBTE8e4IDVrdHYaKd+k8SQFb2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj5usHn4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj5usHn4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb1c918860so3647925ad.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015142; x=1720619942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtZFlVnAe4qE/y0j2Rt0N7Q1NZXS8OgfPHqwdyraSzA=;
        b=Mj5usHn41u+t+2Q0S4aWrnvLqI+dTw1WfVkFYEQWjV5yMl6GrYhSsqcKUEPG48RoBP
         N8e/OaJaCNF72VieT59Cinme9DbS+AUZLKbpZt2TgCnzGil9JONqs9SNL6/PJAuUWydG
         lqBQ+MRtCdOgiWFXGA9zsSU+lu3UeGBO/z4yMNxk/hM3ur9sF7c48HYNBDIoa/TqoSIu
         7DvIbMze78bXhp8RICyZmN5EC381GjSWel4N5ZnHKUp3pV36G1TcPrTapv33v38Ep7hG
         rPA/f864WSxYE9naXDfpiIqvzeLUDs7jmItFH1RvSix4zEPPl6nzMnyfmRq4opGG07HI
         kWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015142; x=1720619942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtZFlVnAe4qE/y0j2Rt0N7Q1NZXS8OgfPHqwdyraSzA=;
        b=Fq+x+rXs5Euou6on+lrsw+/YUwjbl1tR42ZW2sKDr6wVk1UB5/1o9XeuqZPeZSzlnO
         lmnaexV2IcBnYxdQE9Zh1Iad1cRAo8QrVVkI/7oldlK0uh+TFSkSFpT4S2XXfzu5KzI0
         Wwq40/nUdPsOM6nuDXbkPbHDrQsD9QNPahNnD943IM/QELR75wbhEIiYUGtyw9KHr6R3
         DgZXCIPEO4EQDeSJuDPLm4pyxEeyz19iLyIyoa32qxjIr1yrndeIIDkJR+TxBVPLHMuN
         zYx3MiqJa1ERPhsZlBlG3JWe0AOdUVyJNYD8blaOlw/1ZgKYYH/hXMQuEsWZxbbUYTq1
         4b1w==
X-Gm-Message-State: AOJu0YyvS+NLMBeUHKRwWJZfn8r9rtxF/qxzFRoRETI3zkJmXVyUMegS
	K/95H7FR9I+IGyrWp4Ps9Hi40MUg+R1DGjQse8BHAvpzx4g3FHdHEYYElEgg
X-Google-Smtp-Source: AGHT+IFOXTkvcrhsdfCH1AjM22KxQ4+1M+2YqZ9keYJdFF3dOunzvk0Zflfnv1BKVka2XLk8eVPZiA==
X-Received: by 2002:a17:903:1245:b0:1f8:44f8:a357 with SMTP id d9443c01a7336-1fb1a06ed94mr29366855ad.17.1720015142385;
        Wed, 03 Jul 2024 06:59:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac157b3b7sm103067855ad.242.2024.07.03.06.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:59:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:59:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 8/9] fsck: add ref name check for files backend
Message-ID: <ZoVZJrU-pZZq96L7@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

The git-fsck(1) only implicitly checks the reference, it does not fully
check refs with bad format name such as standalone "@" and name ending
with ".lock".

In order to provide such checks, add a new fsck message id "badRefName"
with default ERROR type. Use existing "check_refname_format" to explicit
check the ref name. And add a new unit test to verify the functionality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/files-backend.c          |  20 +++++++
 t/t0602-reffiles-fsck.sh      | 101 ++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100755 t/t0602-reffiles-fsck.sh

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f643585a34..dab4012246 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefName`::
+	(ERROR) A ref has a bad name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 246055c0f9..90457d1a1f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 84acb58782..69a76048d3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3419,6 +3419,25 @@ typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		ret = fsck_refs_report(o, NULL, sb.buf,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "invalid refname format");
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3470,6 +3489,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
+		files_fsck_refs_name,
 		NULL
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..b2db58d2c6
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='Test reffiles backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success 'ref name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2 &&
+		git tag multi_hierarchy/tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1.lock: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/@: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/@ &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/multi_hierarchy/@ &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'ref name check should be adapted into fsck messages' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		git -c fsck.badRefName=ignore fsck 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_done
-- 
2.45.2

