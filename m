Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6618735C
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039034; cv=none; b=YNHSwJ9IBOeBzEpAO764cuKDO/aT3SNp9tlWgg23OpiC2LrSLGswep0vH+fHyC3CLga/pSpBgzCuxfQYUCRv7XbCbRzILFKH/OLTR9T2wTITskDk3LL62VGhWKYD5aIkbh7Pc8NunUKsD2kmmcDHxunChsQxAKHmj7JIss4O7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039034; c=relaxed/simple;
	bh=+/R0+PtaAxLTYbHv0k50DRfuwNwfNb4qfM1KM3ymLYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGDmpj3Ut0dfqWHGH4HzotG16mwSiYqNc1Vw0w/gZvUOF2fgeMztSen7/mOJFGjB6ov6qJYuwZFYyvfDIixzhc9os+/vJx9jkeFMMjchVqp64ZF87NRaikK2ybJYPXTz4/dje0KeKV1ozwGcLfGYGCFAYaqX5b8JlgqmHHp2Tv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHVzBeLc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHVzBeLc"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2caceda3528so372435a91.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039032; x=1721643832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLRD81HZBqd4BGDDlYf+Sdtwx0TYviSZcHbyFQagVAU=;
        b=RHVzBeLcTHTysT79N5tfzBOkcEKHR3zhiVfjEZwqV59844wcKjfKHEl8xhkX4az/vk
         tT1AfLBSuey5DT4JaWi8WsE9qTMCTotLoUuDAHTfvZY7QEwmZDUn5gCoocjYIzTXEQaO
         VhNoB4aUoOzk4ITgsjr1a8fgoKQns6plKMDEiEHsW/NROmq4GnKGdQYdofK3TAkLlxTE
         tRdY0fS0jikA6ftwrc1z+cfJqoCXvP96ENNkasoJlR0oPVbxK3VCrnyFQma+Nc+ve33Y
         de1Cb4iKKj5O99Tm0v+92+RZXbl1umjA3y25AsLg5wWFxl2rlUMnKtTAlBfOxTigsSrk
         dshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039032; x=1721643832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLRD81HZBqd4BGDDlYf+Sdtwx0TYviSZcHbyFQagVAU=;
        b=R9KTmTSXhZcTL0ZEOsBzlTi3onlTLgUTuwVrPG0zm5L3cCrRW/IrsN/+hI21EdF/5Z
         UNusGKksSyHQH0gNYTxJD3kFHe22y4AaiS1BLXHIi+rPu/SqMX3fO2ItSsw7IvubobE9
         1bmLGF5UMo8LARhINvhQzqgr+XeBeHQoAZmh2WZb/3sX7y3Glj1a8csR/8QG47P88+vx
         rQMcxS9TNmEvrxnU91WpFZb4opzE04nNs3LFaiucXPHHwDsDZ9Ttp60APREtXO7MZr3p
         bHtYDXEpzQoY7Gq7T5No0PltXi5M90ziVfXPd2n/bWDLzNKudfDPOFT57DxkyMBnaZL0
         Actw==
X-Gm-Message-State: AOJu0Yy01pm+LhD5UHwDqtbaDKrQkVPlYwp2PU1121mk7romsJ16rLMY
	EBVwipCUHI04Amc3mnKyV+GKiLxqcb2RryiaeHduB6GGeh+iVejuOCwd72xZ
X-Google-Smtp-Source: AGHT+IFFAVIJNwk5jqX/vrdBXws2XecXYgTS8jdIz8ewjyigdxSQk/GJP/OdhP9xQBKY5Nu9KtZ2jg==
X-Received: by 2002:a17:903:41cc:b0:1f9:b19b:4255 with SMTP id d9443c01a7336-1fbb6f13a60mr195288845ad.4.1721039031968;
        Mon, 15 Jul 2024 03:23:51 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([61.246.51.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc68absm37156935ad.118.2024.07.15.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:23:51 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] show-index: fix uninitialized hash function
Date: Mon, 15 Jul 2024 15:53:43 +0530
Message-ID: <20240715102344.182388-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.827.g557ae147e6
In-Reply-To: <xmqqbk32oc7g.fsf@gitster.g>
References: <xmqqbk32oc7g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in the docs, show-index should use SHA1 as the default hash algorithm
when run outsize of a repository.  However, 'the_hash_algo' is currently left
uninitialized if we are not in a repository and no explicit hash function is
specified, causing a crash.  Fix it by falling back to SHA1 when it is found
uninitialized. Also add test that verifies this behaviour.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c                |  3 +++
 t/t8101-show-index-hash-function.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100755 t/t8101-show-index-hash-function.sh

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 540dc3dad1..bb6d9e3c40 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -35,6 +35,9 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/t/t8101-show-index-hash-function.sh b/t/t8101-show-index-hash-function.sh
new file mode 100755
index 0000000000..2e9308f73c
--- /dev/null
+++ b/t/t8101-show-index-hash-function.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='git show-index'
+
+. ./test-lib.sh
+
+test_expect_success 'show-index: should not fail outside a repository' '
+    git init --object-format=sha1 && (
+        echo "" | git hash-object -w --stdin | git pack-objects test &&
+        rm -rf .git &&
+        cat test-*.idx | git show-index
+    )
+'
+
+test_done
-- 
2.45.2.827.g557ae147e6

