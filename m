Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42F33121F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701689; cv=none; b=k3VqupxW9dLFGmdPlmhypcKT+pH2zUa3jInP9oXYzlVhOSgOKBHqEX6PepSMZ1ULMupeAu0fkCbYlMNgKiO4aE5ho9yGah0C1AgV8V3X6luHIeQBHAwLt46PMv6OD3Whn9N3Tq7gPJlgAYKLYGS8A9zGfsxQYDBZWEGGQZMJnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701689; c=relaxed/simple;
	bh=y2uzU5vNFVRfM+pafKNQvRwbnLOIisGexNOTXTYbf9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7QpMwWRYQbQ6vkvgdQ2rtJzMlThXjZMGhv/A96lHrrXusAWE0Ub0iO2Zj734FuRoejqV8yMseG76D8NMx8ck9kNSWh4JjVaoka6HL/bHQY9gYoWB4Lfmrl0XjXSKLAx0rXsfhHnHBzwz/AWLgmtTAKWJ7EWYZnVWvTR+BbBxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTNGdvqq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTNGdvqq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47df6a5202bso701258f8f.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701686; x=1784306486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=XTNGdvqqFG9sn+SR/IJN8up/gU6WqzWQpU0/zbqcT04/v4A+Ml4+YJB87PsQGUL94/
         qAJ+SzTZex8/uPcRyYjAI8xF+5mUrNApsa9Q8rwwASE8N3Tzt84yev0nwLQj+pczf3wi
         TlLoE1NwTiqGe7OS5+tRqjietpcXKPbN1QOsrfCSP5QBedORfN1Mu/r0akWkrzQNTi51
         tjfkLWUMmDUOxubOuR586tOHpuplklhKtobqfRomVPWHYTd4veGmeUpgGRbugX2DOsNH
         AoYs/EgtTMRaSKxiDLZ+Vb2wwTBaXduIp8HB33+FuAvJJhWMmtdspz55Sdb+UPSV1qcv
         YRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701686; x=1784306486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=QQ60IFl+eRwWBttL1qV6Emw3R7QYlgrcIm/ax5L3VkFzaW8lrtfLuS9bAuLQeanCjv
         95BpZNuM62kItW4ia2H5tJ93doK36e/8ZQYgd9XZEykei4+nOqz8texvd8Qw2tnHPtKo
         gJbEp/KleY10YUPo3pFt59J6XJbypRTE65xuxBYFELKp1WzMs0CutmBUNAQYIT1CxCyC
         h68qhAGW2AfAN0RI36+hU7qKNfS/KO2zyVGplNhZ5UfyTCgEhRaUjthWprstwOLoql9+
         Ga4TiPZ8UtLLwJi6qVHFeRHSbaH7ft+R0MZTWRjMjqklPUjUUmdnyaVhhePRL0AEi4+P
         NJ4A==
X-Gm-Message-State: AOJu0Yx6e/LAjGPWxlu+h/686/70sicl6SAxPx8bs7EXwxIGfd7fEevB
	sBqeGYe1mJn5i7GxhPWjBmriHUezdW0+q7xc+snXwfstdYdWztzOg49PM51RDvSt
X-Gm-Gg: AfdE7ckVTkS1EfnyZrVuFz/SsEfO4Gkpa0ya051ovhM+xBXo1pIJjgFAWHBFHOpEej7
	b43qmnVJ3NYhugekQWNihfH5KKncVM1DSOG8Buk3ER4WmeW15vMLx/iRAFDDcxuHspCrk7eTvBZ
	XMJZ3aWygs7ytKSMzMYJaC8J5Ab1+ykw1Ph+EDrS5bvrNgl63B0sR0nBkXd372uAKX/QYFG5Djl
	tqAngaHuhrJ1nBBQ6oMVl31Sh8uqFTDzLOxEPt/yVLfMwtiAXlehKBU20MKSCDhwfTC3sZBqmui
	b1rBNqbqr7z9I9ffi/vZ8hAopfW+8g4Ko5vWs8ORSsYoMZfEMm/TvwC1KnkbHkFTiGryy1AxXHj
	XT7FSAuEfNEXkyR3KmDBJKXbN457R4HJsHY1jKrBg8XzNuuB2m/kHbRPs45/BCfopGFI+3HTSEB
	69TdGEVUbGQ0aITQwoWM5fXr4egFaUzlGw/96fn7MWglU/FIRKcwVHaM456Y0pK7UeOohPzrbnC
	1QKuG/nmL4kk4QsQaLIfvznP6yT58L9k8/+rz8RTbt8SjwU6AgQF9/xT7bsdtPnIANokK7qgNOA
	uZ2XjiE6ky6Au8tbu6EyFLiw7AlG8cNbRAkDkIO7C6WtBsbXeL/YA41r8j2WJtPWKoa2ME3lUah
	5OMGIUy13wg==
X-Received: by 2002:a05:6000:2407:b0:475:f100:3604 with SMTP id ffacd0b85a97d-47df081ba52mr14201556f8f.51.1783701685557;
        Fri, 10 Jul 2026 09:41:25 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:25 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v16 03/13] t1006: split test utility functions into new 'lib-cat-file.sh'
Date: Fri, 10 Jul 2026 18:41:09 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-3-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script 't1006-cat-file.sh' into a new 'lib-cat-file.sh' dedicated
library file.

A subsequent commit will need this functions, the goal is to improve
code reuse and readability,enabling future tests to leverage these
utilities without duplicating code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

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
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
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
     object_name="$2"

-- 
2.54.0
