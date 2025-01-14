Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F742A83
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820931; cv=none; b=T/u0okGYQNsoXbL644dHcHTnGgzRgiKLI3hG087c3BC1el1Ise+1xy6T2uEjLljBSWfMPnYFAl7LLVU6kl8CZQKJnxyhE8jZ3eS2fEQEf6yvn2EveIgFcjobXB8ElupVikfctqT1/wGcSk6Tb2gCjyrXADoqeBQcLvWqqc9QTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820931; c=relaxed/simple;
	bh=JBseXTGtYYYSUPAkETCJyGn4PTaA4oKacv//sGB4tDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxbSKf6NsSrWoa1iOF8KctUoDXAjW89vFx/DVyqbkl3WGkM2AnhBOjkxGf1iE01nfVZnJ/6trhsN28D4LYTUnTc5VA2iIpoV8axNoOx07eIFjVycGDl4f4vGkNmSlmKc8c0d4Ty/ZVGrayLONtmrsxPWel9xaNs1rLAlL7LPW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnJFPnS8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnJFPnS8"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b955e288so54172251cf.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820929; x=1737425729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy7B8mZFPNWDE+kBcaWGW6IVKEy4mhI681qTRUCjMpA=;
        b=PnJFPnS8Vsekh3l6BBOUJOh13Z/zs4GLhFYYYoeuuOUm98h/wIu0RimvC1oUGVHKqE
         K+/s46NVyd0UBDIJgXgo04ODQ8CIFsiyPx0HOSq4LZtcx8L26iZ4SpDCam5LONWzSRYz
         Zm/jguSlFjMrWlo/I6OpYfXVT4bnmEkBKa0EyPAVTMfBMH6JUDMkX35rDMvnd+tu4iQN
         +y8iviebyFsQrfbcZquBTWny5BO9sg+rqQybBt9fbzwkTD76jq17PIMPlWwuBvanpK4V
         jCYTIiXVPgeJw8iXT/MGvETbRHzD3NgTEF49UDPRQWVG+H2MLx3RF9194vu/IhIBXeqD
         193w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820929; x=1737425729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy7B8mZFPNWDE+kBcaWGW6IVKEy4mhI681qTRUCjMpA=;
        b=F4Z/ex4VSnN8psLAeqA6B5q+Wbh1ZhMAbZ4A21XValOJ2+Y+yJUtJZm/Zt/u4YJ1ox
         mtrFH8a/xqGImZVolXsvSn8YxRDQWYpds/mfzyH+j9eirlmwLleeALwVw4VSBn8GAYeZ
         wGumqfKQpYMQ45yQCQRQMmRU67KPTkCcoSZoNcvs1ZTnOQo08ClonayUApfap8e1jbtY
         pMmskEi7id9JNrvBqQlvcxbpc/puIBngZxGgw4zkkn7EluYNYWZNE/9Ilm0U7KOIkCNQ
         047tFQyUDn3dhAEFmc44+J0mV4PPC0vxKsZ5jlYaR5wubcDuzzMvNeeuL8hbvvrhCWX8
         7fEw==
X-Gm-Message-State: AOJu0YyE8snxmTUcEgnpCeYIFEXp3via3bZ8kMliGV7LBuyb7ZULKNf3
	cLDi6povGG+ucAgIOXBISud9Mm42N1+OqZt1ytSdctB2r1k6Ohqc8oensK+t1xE=
X-Gm-Gg: ASbGnctgR3xvdPg/5uxJ6jxLgBoHPMRnReNvtf3LI1sU+k+drhWpsEiCXqP5jRHY1L0
	kplFPSWj5OeoPI5hDza8aP1hP4V8fZwHtBS1EPjPOuoe9i0UOTR+gjSEPyXRVg54RkOKUbS3YGj
	ZamQXwHud9snz6MU44phsYroKSFoLzDzfdPSxJzUIPfPJR7EHAbOvljxLibKtqu5BZv4UowSV5k
	2iiJldqB939gQfjXU7dBtoCghHymZdjsYGZ64gGIYUbeNeb6OEobZRxBaMPKi3oTMrxiGyuVqd7
	+5c7ryI=
X-Google-Smtp-Source: AGHT+IE+cIyos6J/GbooRDUYX6/t1/H4VNwcKDynnaBOfUWlMdn1wtYwQuoVktiM50spyERHM43sTQ==
X-Received: by 2002:ac8:7c53:0:b0:467:6532:2cb6 with SMTP id d75a77b69052e-46c7109d6e6mr346802711cf.48.1736820928907;
        Mon, 13 Jan 2025 18:15:28 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:28 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 3/8] t1006: split test utility functions into new "lib-cat-file.sh"
Date: Mon, 13 Jan 2025 21:14:55 -0500
Message-ID: <20250114021502.41499-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactor extracts utility functions from the cat-file's test
script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
library file. The goal is to improve code reuse and readability,
enabling future tests to leverage these utilities without duplicating
code.
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-cat-file.sh

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..5c7d581ea2 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -3,6 +3,7 @@
 test_description='git cat-file'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -98,18 +99,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     oid=$2
-- 
2.47.1

