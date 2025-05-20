Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFB1D8E1A
	for <git@vger.kernel.org>; Tue, 20 May 2025 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706046; cv=none; b=onVzQUY91IMp1TF5UkaaJ1a7FIlFfIN4t2PNI9FDz4YpUNqX7QLqHM7NKuzlRRaw4gYH0quhnnVlHDdQ8xdQMbM9xu/FrzfJbo4iJd5KRmZBUI5yeV7FQ/Kyi1cvwcimq5lNMenQjSm6Tfp9dLW3mZkDAjd4SAh6ec1CXFEZFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706046; c=relaxed/simple;
	bh=2VIH8cIuf1nYzsvmhiM8G01GYwVuPy/Cgelg/xRBa68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZgk5ToR3losn2RIuTfMfx8scsYWkAJWGSbNNXvSM9hZdEE7/C3SRzPSJQU3WvEHOl/vbPCKXPmU5NdfCxoOqwhRdsDjBDyzhdK1RGdI3oY567Y/ZiG16t9QW3LlZpRRLT9fcSAoHUVJ5/3ZZ8/EFX2vhi0Pz9ptkovNa8rjoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSMBYFpw; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSMBYFpw"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c14138668so1660948a34.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747706044; x=1748310844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJdoIDuU398L0TlWHG16A8lORA2pH4Du37cxrEJIhag=;
        b=SSMBYFpwifH6eZzjMlwXpActlBt8GDlQ41o49L52V5Aq36cdyLhkrVbaxNOPQU/gGS
         wzdkphcwt/fI/Bll57LKW0UQXxlJwdQqNiS212WiqmYzNTJzKaLslfZeWyA3X9r2Eqlo
         MfD5ooZcdXs6DWl3f6OA2ovZxJKR33538aRUV+yYYB+aLPrNwNBlrzkgpkm/cROheeeR
         zxVKBgUTOJzDq4srHMnX4Qt/TO9SKYX51KcxlEehM3EgSxLKcG2fgBj5W4Y9g+M7hb1Q
         MJt9J2/2wD+7l9rb9NHV/ugW1fsJs0TYweK5lOBebsuqD4briRLd2A4hzCQatSy+T14u
         LAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747706044; x=1748310844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJdoIDuU398L0TlWHG16A8lORA2pH4Du37cxrEJIhag=;
        b=wFy8+XHaooHJH5iupGPYZMLFXAiJggJ4kZ7lk/kMc0k4IuR4m8pdUxZPnqUMfsQp8P
         Ez5ykrNWZ/HM5e+9XggA8dGCx1hUMiddOS+qjg1YrPrBhL7JR6tvfbNutqh9TN+jQxk6
         qxix3FGzO8EhyQbYqjmFaOESgMFBgzRWqpGXVSJcnhAw5BYDY9cVom4x/YDuQJF4TVzb
         J5IMJhAcX2J6KUS+boiyGlFLk5Pd1CVQwxke7CJHLUPqMUfyOYaQSbQ3Hp/vKmeTRoh5
         /U98AzREYhdqaYhRUSSVpLa4vjDAVDNYNI3QHny/ANhHb476xDFJDzoc9Gx6WFjoVj4Y
         EQIg==
X-Gm-Message-State: AOJu0YwBJcZHfsMkyXHMCoKWuqRb/8f79l61PqANInYoVJpbrX56AVNz
	jrFnufcBeuuaauFB/4KpN1Et/Xpj5eOC7R6pBSjmaZF7LZh0T6j77adJaJNlinCt
X-Gm-Gg: ASbGnctff0kNGdI8rDjcA/2XHaY9Qc5KBs0M4WIQIDb8UCRjli0Za1qFjzetalHKMT7
	eabhH4h9CYqk49nUMNy7/cqRh6UdkMasKWVTLVGFUvb6mcj9ag4ZUqsa3ACQapWvI8RUAU6H8Ok
	YqRmJ8XRzpGPZxueEcrMsDinwXMNvjkCWMNc+Iuy4k1CiBWGtLoc/AXj0iLLIJnIPZq05/O82aP
	UYoZqXEZC22pO1waCAArRtGOVo4GgclQ0VPSjjSyLPR2+Yh3ocEnp84mWQAimJHNa2KvI1cZS/J
	vclnOiMd6J0DCX+OQ4dsGSeDRWOyB23WH0rCp3lxs2QvPJL3TIAPzyKmNSQJOYaxaUlmxw==
X-Google-Smtp-Source: AGHT+IGg0c9sGd/gqq1Khu9/LsgwnbGWL3RdcwkuUM/DQ6RwSyGVSSJKphtyZLor1rcOkRw9w9+SIQ==
X-Received: by 2002:a05:6871:5e11:b0:2d4:dc79:b8f with SMTP id 586e51a60fabf-2e3c81725c5mr8167235fac.2.1747706043681;
        Mon, 19 May 2025 18:54:03 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b21fe5sm2006368fac.45.2025.05.19.18.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 18:54:02 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] t5410: test receive-pack connectivity check
Date: Mon, 19 May 2025 20:49:19 -0500
Message-ID: <20250520014920.201736-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250520014920.201736-1-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250520014920.201736-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of git-recieve-pack(1), the connectivity of objects is checked.
Add a test validating that git-receive-pack(1) fails due to an incoming
packfile that would leave the repository with missing objects. Instead
of creating a new test file, "t5410" is generalized for receive-pack
testing.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/meson.build                                 |  2 +-
 ...ck-alternates.sh => t5410-receive-pack.sh} | 23 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)
 rename t/{t5410-receive-pack-alternates.sh => t5410-receive-pack.sh} (57%)

diff --git a/t/meson.build b/t/meson.build
index 43c9750b88..6b7c0b167b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -628,7 +628,7 @@ integration_tests = [
   't5407-post-rewrite-hook.sh',
   't5408-send-pack-stdin.sh',
   't5409-colorize-remote-messages.sh',
-  't5410-receive-pack-alternates.sh',
+  't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack.sh
similarity index 57%
rename from t/t5410-receive-pack-alternates.sh
rename to t/t5410-receive-pack.sh
index 4e82fd102e..9afea54a26 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git receive-pack with alternate ref filtering'
+test_description='git receive-pack'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -41,4 +41,25 @@ test_expect_success 'with core.alternateRefsPrefixes' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'receive-pack missing objects fails connectivity check' '
+	test_when_finished rm -rf repo remote.git setup.git &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m 1 &&
+	git clone --bare repo setup.git &&
+	git -C repo commit --allow-empty -m 2 &&
+
+	# Capture git-send-pack(1) output sent to git-receive-pack(1).
+	git -C repo send-pack ../setup.git --all \
+		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+
+	# Replay captured git-send-pack(1) output on new empty repository.
+	git init --bare remote.git &&
+	git receive-pack remote.git <out >actual 2>err &&
+
+	test_grep "missing necessary objects" actual &&
+	test_grep "fatal: Failed to traverse parents" err &&
+	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+'
+
 test_done
-- 
2.49.0.111.g5b97a56fa0

