Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A015B973
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834304; cv=none; b=fFtMZvaIm34e4ra6hqQ705uTeouGp5sc5MKG/W1/L3w+I6J+se75qMn6GtmGW/KASi/okRpVv6rklXUpSyWxz7oriNihfoO2MNKqf/mZJe+dFzbl257afIlh0iPD0axadjv4uoCbe3nnkVyVTc8/2D/xFpXro0NcrAa/uX48pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834304; c=relaxed/simple;
	bh=mgRjPggoTLvIAUq4XUi/VIoWIApwNBSSBMdbT6v3cjE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dJtmIAJ0eND07BkZnQJXIySARlTWo3d8OOB0uc5poxmsE8R1NWqXkPfi0KrXwM08T08BvXX2k2Vq2++Ra47Dg0yFSFsQr2kXhF5fT0yctOMM82PALa32M4yDJXYFQqcNqsx1mzjlS7J58qjx6xFXuhuJnqQY0OfVFSoc5AhNrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBwfEX8Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBwfEX8Q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424720e73e1so2570695e9.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834300; x=1719439100; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fCagbLsgMzJIiLnvm+JEoj6itaBNRjg7hd5rkSN3Es=;
        b=jBwfEX8QGvKb0Q27sL1DNjkUsxDTL/J0e/urhiGRReGiBhgOCP2/5aMTQ4u2CzqEM1
         IohvEiTvfJW0z5T+L7tBhHHOcongjScvKtO8HgdrzEXQenbInnsKqnWgYUaBTAFXu3Mp
         p7AIDgm3D+FA007+LVQVcv54UQi8UGc8x/J+P+DgglFXTb/3/Cze9s/gkVr3HGYKHirT
         8pu5iAB2U6NqS9qupj6hfeZtRu1RWPFJX7t8tXdgynm6QtnyuUZYRRFllMca2LPKF1eD
         sm4FzRCJcnJtDs9rGM+3ayRgBAgtigj2YmKQWx/jEdrdqTMP/2zHKrF/nDfut2IKplmh
         RmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834300; x=1719439100;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fCagbLsgMzJIiLnvm+JEoj6itaBNRjg7hd5rkSN3Es=;
        b=VXIrlGP6qCIna1taLi7JxJV9NgMQMjLWC0I7LWjHeX2Id17lnFznXKJ6rJXd7tK9Ql
         5wlIYuy5fvYYBN13KmeElBhE1NDylak2kJsTa/+d+sHIAAPVwqetbLIQ3Mpz+Ffshdi3
         0eEb3xHwD8T2iZBNUXR9f8NUNmiIKrl68QBEkfVXWGGBvVZb8TdL7CDgRL/EcFu9jzxR
         opLIzBSeT4lyqGwHzaUMy9Jiag9lUPTy1X3YBeFjIg6XfQ4HHtQW+w1dcATENGt0fw4j
         U9Rtp6sBi3tZ2ZP8PccdyWErp1edADuBPmjEWxP1ctV2MCnSnLVseXdbI153htKR1XAz
         uwGQ==
X-Gm-Message-State: AOJu0YxM2C4N6c/uDnTWk1DQXbDrWmiSXj6Xp9MfDy69qtCdKzgp3UQs
	eBh1KwFKKoXe/S+9mNJS+flitp4Fl0Y3bRdznuOV8CvG9DKfUV61Ji5MjA==
X-Google-Smtp-Source: AGHT+IHDRJ64UPec28EWKnyZdKF44X8ub1yrDk2LKYv/p8aBlPlVYO3rsnW4QQ7jV93B8e0YBzkD+Q==
X-Received: by 2002:a05:600c:8a9:b0:422:218e:b8d8 with SMTP id 5b1f17b1804b1-4247529b46bmr22518605e9.34.1718834300050;
        Wed, 19 Jun 2024 14:58:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364c75f1454sm140384f8f.46.2024.06.19.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:19 -0700 (PDT)
Message-Id: <2eb207064f80d48a7db5617feea417a015bb6082.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:58 +0000
Subject: [PATCH v2 10/17] mktree: validate paths more carefully
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Use 'verify_path' to validate the paths provided as tree entries, ensuring
we do not create entries with paths not allowed in trees (e.g., .git). Also,
remove trailing slashes on directories before validating, allowing users to
provide 'folder-name/' as the path for a tree object entry.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c  | 20 +++++++++++++++++---
 t/t1010-mktree.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4ff99d44d79..8f0af24b6b1 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "index-info.h"
 #include "quote.h"
+#include "read-cache-ll.h"
 #include "strbuf.h"
 #include "tree.h"
 #include "parse-options.h"
@@ -52,10 +53,23 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 {
 	struct tree_entry *ent;
 	size_t len = strlen(path);
-	if (!literally && strchr(path, '/'))
-		die("path %s contains slash", path);
 
-	FLEX_ALLOC_MEM(ent, name, path, len);
+	if (literally) {
+		FLEX_ALLOC_MEM(ent, name, path, len);
+	} else {
+		/* Normalize and validate entry path */
+		if (S_ISDIR(mode)) {
+			while(len > 0 && is_dir_sep(path[len - 1]))
+				len--;
+		}
+		FLEX_ALLOC_MEM(ent, name, path, len);
+
+		if (!verify_path(ent->name, mode))
+			die(_("invalid path '%s'"), path);
+		if (strchr(ent->name, '/'))
+			die("path %s contains slash", path);
+	}
+
 	ent->mode = mode;
 	ent->len = len;
 	oidcpy(&ent->oid, oid);
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 961c0c3e55e..7e750530455 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -169,4 +169,37 @@ test_expect_success '--literally can create invalid trees' '
 	test_grep "not properly sorted" err
 '
 
+test_expect_success 'mktree validates path' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse $tree_oid:a/one)" &&
+	head_oid="$(git rev-parse HEAD)" &&
+
+	# Valid: tree with or without trailing slash, blob without trailing slash
+	{
+		printf "040000 tree $tree_oid\tfolder1/\n" &&
+		printf "040000 tree $tree_oid\tfolder2\n" &&
+		printf "100644 blob $blob_oid\tfile.txt\n"
+	} | git mktree >actual &&
+
+	# Invalid: blob with trailing slash
+	printf "100644 blob $blob_oid\ttest/" |
+	test_must_fail git mktree 2>err &&
+	test_grep "invalid path ${SQ}test/${SQ}" err &&
+
+	# Invalid: dotdot
+	printf "040000 tree $tree_oid\t../" |
+	test_must_fail git mktree 2>err &&
+	test_grep "invalid path ${SQ}../${SQ}" err &&
+
+	# Invalid: dot
+	printf "040000 tree $tree_oid\t." |
+	test_must_fail git mktree 2>err &&
+	test_grep "invalid path ${SQ}.${SQ}" err &&
+
+	# Invalid: .git
+	printf "040000 tree $tree_oid\t.git/" |
+	test_must_fail git mktree 2>err &&
+	test_grep "invalid path ${SQ}.git/${SQ}" err
+'
+
 test_done
-- 
gitgitgadget

