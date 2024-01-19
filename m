Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C658213
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695553; cv=none; b=nlQ8hv0rzGBi7982oT3vl8YvBGs+w8K7S9gge9kS512wL5XSu3CMWPmAok1WQpSJIhIPwgIjEuPFU8KtS4TziL82QpBfB36KTu0nIj0qUmuHK/3pG9LKwzoHByvdsc/nIlBUBlx5nBxgFJyG/a9HVJQogfpofITyyOhPSMM9gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695553; c=relaxed/simple;
	bh=db14RPmpryRtGuOqRKi9W8hZ7Q5YVV3ikOI2sxJ5P1s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=avCKdiUfzQYIl9BqAVSU976C6QHhnqNGK0SJaNYt64yZ9GCTGX6KsuXnoX2b4V8cltaF5jNkeIc4RpgPI2XtI6MQC/8TBG81vuXM4dwgtjd5APZ3oCH6/gviAVeQMuPC4etfjEuwQLMbGySF6D4HlHr2pjl0rcFAiP8CoPp7kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQpNsLZA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQpNsLZA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e775695c6so10446525e9.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695550; x=1706300350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLLkxfoybHuOVu+BDFTHH7hE8AuqVm0+o3aCaZiM3q4=;
        b=OQpNsLZA9qPCRleMBA2uKEiW+h4TtYzRpB7VBd8nnkbKoFLSPJtBjWYvCQWUyyQTFy
         t4MqdWuFjkHZZAI4lDLVWpbsPCJOM6tXq7YtZHSc/5p1DJbRk5ACn0A+xuFMwszppPWV
         U4+IiYa9sMU42KS5XiEqgONICWnGzZ+63HtYZylxmbN+C8Skuw8O4IXUSAO1wZtAzd6Z
         zyKhDM68M8385QER1wU7YIGmCc2gLsu8fHdGb44CEaamT59vo2o5q7kcES25nX1Ph9Zt
         YwaqXezEv98i1+nxb+GcWqFxrBhaLOCm0f4TdGHzN5zLYCt8NATN7xC7/2utDBXFxF5v
         v48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695550; x=1706300350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLLkxfoybHuOVu+BDFTHH7hE8AuqVm0+o3aCaZiM3q4=;
        b=Or8Rwr2DTlJ4LNomzqHIe/+lPk9t6nbuQuH/LwnmdEGg4zPmBI1owqem7w60NrkT7A
         8plOkytS7YwDP3PlfnL7eGg/vTxTIc5jej5mHUqeff/SUn9O87OoQJc5gb4O+dUJTcO3
         ySDqax1bWGMvZSbFmKHUPlxV93Xdq7cW17Ievo5YnRu0D7dlZtRIHzXiWU0eNf2Lg7Z7
         n2qhxjwmkTjwH80K1kUDkoyfOYkUJeibBPQ4VzwQJ1nyk0mJ8ZZGLuRYHNiTxWBobJQp
         BbRB59wvJq8L1iM+XhVInqP30FPZKNAGuY34kWXhxwqQZy0Zj+Sf592dezQQ2/ixXFBb
         ebWA==
X-Gm-Message-State: AOJu0Yx5LeErAZe5BCRRvMsscbKbm7EJeZRD8tZ/gwtGStWTGd9ZsXjB
	Uwpp5KDrbtUJp9DLW7A/o0jpXb3N+FqLZLQMeSXRe3fcPhmO0sMXHHjXwAOQ
X-Google-Smtp-Source: AGHT+IFiNFbwjbtz4bjlpOq6ic2SW+k2L/gCe3/K+UhjPSizwntLuvH3WJEPpOqt9ex2krmM5kTTOg==
X-Received: by 2002:a05:600c:1e87:b0:40e:4ac1:865e with SMTP id be7-20020a05600c1e8700b0040e4ac1865emr188527wmb.52.1705695550468;
        Fri, 19 Jan 2024 12:19:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm30317971wms.33.2024.01.19.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:10 -0800 (PST)
Message-ID: <bfd5b40317076caa1f09ee9512ceb0c7e2a164e4.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:58 +0000
Subject: [PATCH v2 10/12] t3903: make drop stash test ref backend agnostic
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

In this test, the calls to cut(1) are only used to verify that the
contents of the reflog entry look as expected. By replacing these with
git-reflog(1) calls, we can make this test ref-backend agnostic.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3903-stash.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 34faeac3f1c..33192405155 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -200,7 +200,7 @@ test_expect_success 'drop stash reflog updates refs/stash' '
 	test_cmp expect actual
 '
 
-test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
+test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
 	git init repo &&
 	(
 		cd repo &&
@@ -213,16 +213,16 @@ test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite'
 	new_oid="$(git -C repo rev-parse stash@{0})" &&
 
 	cat >expect <<-EOF &&
-	$(test_oid zero) $old_oid
-	$old_oid $new_oid
+	$new_oid
+	$old_oid
 	EOF
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	git -C repo reflog show refs/stash --format=%H >actual &&
 	test_cmp expect actual &&
 
 	git -C repo stash drop stash@{1} &&
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	git -C repo reflog show refs/stash --format=%H >actual &&
 	cat >expect <<-EOF &&
-	$(test_oid zero) $new_oid
+	$new_oid
 	EOF
 	test_cmp expect actual
 '
-- 
gitgitgadget

