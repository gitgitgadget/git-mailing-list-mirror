Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F175374C3
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685818; cv=none; b=mzlB8XnDehTqTtV4ylIou55nhosVrx5+OCvkfIcY4o8z5sVJE3NfTzoXSpWR1CEEFDeCeLoM8VZ7Kn+zyBFNMZu3X21r6a2MEYFvfm/C22gNh+AtTx3a9eYqcTp8QINBTo6O6F+zU13JXsp4QcWQJ+ppviYZU66/hNtRE8M/pYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685818; c=relaxed/simple;
	bh=B2MuKFtlifHHU3jsML3vXdKkYVxHgHRL2u+twuhUdJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aIlG8Q21ZczaSS9P/6RTvKUX7AmNVQbu7Tz58h+daWz3k/WonRHoRrRVRTxziXnLuTBxhLoyfirecKK/rgqqJPSPBco8KTETIBXfQYyMGjXoHfzQ9wwYX1YR63WK9zx2n8zFyL1Olr2EwOiuESVExLsQGnVMyjxM0SnXzeKSXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwI0oy1o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwI0oy1o"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4154614b47eso6567325e9.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685812; x=1712290612; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0TMh64KiTj3gNmGSnDHL2FpmVgefE9kRbcYQEsM4to=;
        b=XwI0oy1o4TBGponKLBPQ+9oXSXvi6Hq+4XAWJHkj1zKdVB077p7ZY/KzRlnB6I0CEE
         kjWCOrR27m1b3g3s+SxFtyV+3d9UCKc+dibpQE82xK+5jXeayqiTHWt4tmCc6rCpJ7i6
         Iihssl7g91qUh13XHfOtuFcCqsK6WmIo8YbNIAVfizPdkY0cu7eAm8aIZq51lVPJyUar
         2k06AM1bI/6fj87QjHmxQPsqX2XBp4DoKXb3LMwF9cFNcHLDeGLJAD6YSDYB3Lj0Uvgn
         PQjy1kAP4p18S8xadH/ghsA8aWvw4O8MN8ucH350JVwgavm+1Lwy510UxRRsFoW2qgml
         x8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685812; x=1712290612;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0TMh64KiTj3gNmGSnDHL2FpmVgefE9kRbcYQEsM4to=;
        b=UJbo1GrbYWXOjztXx69Ux25e7KQtDRpryjySStsVIAKAm87ZY/CXmTgimH1W0syzaP
         mzybCiO3MHB0Scq8a3vzz26XMOPkJ8GYfzkwJN5BIlc7/ci/V2NRhxaUgVWmTfoa9/3j
         1SJdi1DK/4XBuJip9JJSWTwN1u0c/rU9FQOTIRKNyZC/mXUTz+X2pabv89XkKvJWj0iB
         agCH6xIq2PFy7v8rjyZCw7vm1WXj7KrSDZHSoT9GjWqnde+H8YNPeGhas6VUvU9K3a68
         Ad8If4LW9omDIzbJh4z0ZIiKReim8zRbqQGXaKgYwgT03HtVgwlrlJYnvS0cIaimjT+2
         aEIg==
X-Gm-Message-State: AOJu0Yyn5lZjr85DYxNBA5kFIGDzvjPHt3Yz5aqplCxey9K1HA7Nx2I0
	oMXR1ZADbaEKqiPwuCZTja/NzuM4G8qrqBmLq26j1IZ9UpXGKBL9iTPVZGl0
X-Google-Smtp-Source: AGHT+IF+wdrDyzFEtzn/AXKlroiiZEBZS+vTxOibSLlhWgOAFSwjFBsmnW9w4mo/2EwrSyvr1JZzTA==
X-Received: by 2002:a05:600c:1907:b0:414:927d:60db with SMTP id j7-20020a05600c190700b00414927d60dbmr3624559wmq.17.1711685811435;
        Thu, 28 Mar 2024 21:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b00414674a1a40sm4137662wmg.45.2024.03.28.21.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:16:51 -0700 (PDT)
Message-Id: <2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 04:16:47 +0000
Subject: [PATCH v3 1/3] reftable/stack: add env to disable autocompaction
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
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

In future tests it will be neccesary to create repositories with a set
number of tables. To make this easier, introduce the
`GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
set, disables autocompaction of reftables.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/stack.c           |  2 +-
 reftable/system.h          |  1 +
 t/t0610-reftable-basics.sh | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1ecf1b9751c..07262beaaf7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -681,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->disable_auto_compact)
+	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))
 		err = reftable_stack_auto_compact(add->stack);
 
 done:
diff --git a/reftable/system.h b/reftable/system.h
index 5d8b6dede50..05b7c8554af 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -17,6 +17,7 @@ license that can be found in the LICENSE file or at
 #include "tempfile.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
+#include "parse.h"
 
 int hash_size(uint32_t id);
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192eb..434044078ed 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -299,6 +299,21 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
+test_expect_success 'ref transaction: environment variable disables auto-compaction' '
+	test_when_finished "rm -rf repo" &&
+
+	git init repo &&
+	test_commit -C repo A &&
+	for i in $(test_seq 20)
+	do
+		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
+	done &&
+	test_line_count = 23 repo/.git/reftable/tables.list &&
+
+	git -C repo update-ref foo HEAD &&
+	test_line_count = 1 repo/.git/reftable/tables.list
+'
+
 check_fsync_events () {
 	local trace="$1" &&
 	shift &&
-- 
gitgitgadget

