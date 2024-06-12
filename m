Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A016DEA6
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182469; cv=none; b=Xoqwx6SwXdHWyB4lymKT3K5a0hBtRxDZ0NyVYKmBiyo/6Ume0axngZ/zFWXncjmyI1/k38AdhkTSLkvuIHJVn1Smza2qKRcipOJSVchhpmO0EJ8gmxS2zvm3OPaliSgg8+RA2wt89DZFgOLP+ErCzPxc+h/yXCAA7x9jjTWNMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182469; c=relaxed/simple;
	bh=DmofjeiPW0s7YisT51qYvlRaRPxbzyjimnZLHdiPRFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvYgHeiLewn5RNaIT62PAET93LxlNA7r2llDHze4Zr00wUiIHRdJhhZ+gDDLrkcl+Mih/u26SoG+8hesdaAxQESaeGLHnBUnLumzlwV/tVZl0ya3KewYEJ4ZNVLMFFOFdFTa2oSWoFdBg5L3vbyK5C9vOouB3yMYHY9MgkJOiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foDmiUTH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foDmiUTH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6cdf9a16229so4954338a12.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182466; x=1718787266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmTZ7GeZwY9bRozRLpbN1magdYRA519EicrofagrIno=;
        b=foDmiUTHbXlhZo+f9VEi6zLy0vvlweI2/Aoh0jbABMQ1JATWxQ6fyuZCDpeQ3P5oNu
         DWdKMyLp5FFk9uUgVtacfefoOm+ous8PNz1l1R26rLCk9A9xVFaooVFeZeLQ1wC0DuEb
         tZfa6Xo3VtyfRlwxpbxGFbnBgpQA3S6Rgs4CDMa2Bo98HuGVcfuOo92O7uYHCyVnfHYW
         eqVQvOrryYV3ELosQPfvlulD8gZTUl/usD/j+oFKY0y5Nok41vfZykXHQACv7T1JJqNe
         VgJ0c42Fkyl1kGWw7NxUOxBegr1bILlVyo8YhqsNeXGSpuR9bOhWVmqFu05alEVxPAZa
         6yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182466; x=1718787266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmTZ7GeZwY9bRozRLpbN1magdYRA519EicrofagrIno=;
        b=AEkm0XWBtWJiPP00xNvmvYlc28+i1A4u3bku270u6GbNuVxA3x7f8uRFm32Ot8DU5x
         VwwJlURY8mS9RHeEFqxotg2IOO+XgACn+Oeh4X2emtP57qEk+ZalK34nvkvHYbG1RoAM
         t7vVSQluqq/m1MXH5Xc0Lqlxy3c448PbzJVTY06aEL1/mjOmphGNNfpsimjiBeQS0Z0A
         LM4NhkCNbaGUpt1bxKrK3ojHjPH5SEettn9zZnZutK5qr/5On0KVrkAeEwvRABijXhrD
         bFpcMRm39m4aQXtuLmSk2T/pt63v/N11y5nbsCLMUwZbXYlrzsoqANj62bf/cQ4mG44w
         EJEA==
X-Gm-Message-State: AOJu0YwyCcmfPU4pRxl2FA+mPhzBgoN3lr5YZ/XIEL4FjicrAgu0U8cI
	Gz2NzytCqTC1AMdPddCoObvvjiCyg9J3htwOwxfNl0FFes4U5Z7y86HzWTj7
X-Google-Smtp-Source: AGHT+IGxlgESVj/L27xPkciJ38e2TEJ5XziaDb00hnkCYhFcnVnJwobzxhD0mBzAyNXUldH38bd79w==
X-Received: by 2002:a05:6a20:432a:b0:1b2:b220:2daf with SMTP id adf61e73a8af0-1b8a9b6c801mr1549606637.6.1718182465961;
        Wed, 12 Jun 2024 01:54:25 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:25 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 6/7] fsck: add ref name check for files backend
Date: Wed, 12 Jun 2024 16:53:48 +0800
Message-ID: <20240612085349.710785-7-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 5edc06c658..cc85c897cc 100644
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
index 7451b1f91b..1423a5e428 100644
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
index b26cfb8ba6..266f1ffe8a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3413,6 +3413,25 @@ typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_refs_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		ret = fsck_refs_report(o, sb.buf,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "invalid refname format");
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_refs_options *o,
 			       const char *refs_check_dir,
@@ -3464,6 +3483,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
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

