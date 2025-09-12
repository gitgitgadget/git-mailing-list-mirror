Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E32EC578
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673028; cv=none; b=rvV1UWEGbbpsYM37b4m0zrLjaZOtxxRSgBnq8tm3P1MbTHxXqAWbeQuRkRyZrD2pyb6TLIOS1kW2Whu3oDANRQim2ZoxHMEkfM59oBl4jXvBZ6I5LyUQOmHD/CJ8pP9kfRqQKeps4IZKW53sLj91X5RHgLRvVSTDzCgJXJozzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673028; c=relaxed/simple;
	bh=yzWpEA4+O5ONwCASqPTJwBsz41H+aF0zUvswfBWq8d0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ur+zEEd4+u07BdGlHufZN+RD038YsXsufjMGZKOrM6T/QEnZK5mKPAoQSWfNLX0XWgP9763+v7RnURyl73TsMYNk8zmVxHhMgRIaQ/nCuHUCTYvR2OSl13bCT3H0AWPNgd1HPAoNkMBZrREGmTBz2CsWQcC5HamTTkftQvPfC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvSS/FZx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSS/FZx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32dd532b585so1263865a91.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673026; x=1758277826; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntK11GaLwJ+Mv49FwT6EFeI/n9sSEoaUF7UGoPICa3M=;
        b=dvSS/FZxFGNzT4zBiTqD5twn8BY9Xi69YRhwUK1YAoG72hJNtK0jtMB43nz8H33kaI
         e/IhEjmHBJxCTWmGzBqx1mkXOTBDWJHE6n353HryNwnlQ/kYJNuSxFgkgThkqsrgAS7T
         0Y59eNNTwzT9PxjH2R9WJUK16LrK7C93Gbz9tiQRY2+xQ9a99qXuNoL/utJhKB9Hj4YN
         roYFzJYIpur8UvRYMiAHk6bwaK7bxSFNFpZpCpCebLNXr6r+xv5Q7OHYp3mRtjOzZf5a
         ZF5G1pL2DoYmbw8IIcjvqV5jcWuk3cZrgfYiBUWYIRb+iYLSkcPEGAa2OtyXFTvS1Djf
         bKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673026; x=1758277826;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntK11GaLwJ+Mv49FwT6EFeI/n9sSEoaUF7UGoPICa3M=;
        b=o3TlEnctASSG9XulCEx4sSvvVkoQFiDM73MzNOGF6RV1PDTYnexLw9XMquQXoeXozH
         fLbSb8AJxa5INQsU5gg3Oo3TfuBr/8QAbYLHSgq2euS/NbUdLl3p7BEZnXKs+hwcPAqR
         eQsFrKx+UTOnIA3vXPeNKlV7sWDnL4XxMmTXQ9dQWwPLBKBJoQ76QuV+XbxftwzDSRCc
         oE7ix5HjszrPDXlno2yoFu1s3btnchbBfjBSMJCHidTJgZ/pN3JH+XXXgvJNgRymYsRg
         ZLkExOuIwgThWlAnpJrokP9gj3EQac/c8lHSCBIqL+Lnt9MnWa4EiDh0oI5V6HK2Uavc
         wtrg==
X-Gm-Message-State: AOJu0YxXTAJlSGz7UhmKiUfAPFe/orhafR2xsy8l4OrnvMHgeRdGSXAZ
	vO07wcXlLg3F8hNSaJCUufBE9Xn+YHRBR8DNBKRLSNXF8y5Xw4FhL0o1+zXslw==
X-Gm-Gg: ASbGncv+y9Oj2znmbIojG2h0AvoBh0NnUYEpIjeQeGDks9d8fJnumg5Ca/t2JzlErNZ
	lK9ght1xuWYptJlSuDj0pm9xg3GrCyQUEaJ9MmqDP6ODrMw3+SrBsA0frHZWrm2UjtHucdq9/AS
	41vVfK6G0+s8qePSSP1Wr3Urtu9bjU1pFEFgE9/XZfBGWD2rHN8ZSq+aN1o6q27yh3J/ImQpbSd
	+uds54+TlcM8dRBxM2M/0NsQjRYg7Xpw+gIrLBIZIxgPr8lCEOsm/pMxnfxGc9RAgviN22CY2K4
	z8NaUjTMlqLhi5vyDoa2Dguodc1RyXjPofeH1JfG2I/dJQUd1u+Mji+5IY8T88UNI79wuA+bdcf
	0im/Q3pWTUaX82zBtadAOZWdK2TvBPI1CuBeCrQ==
X-Google-Smtp-Source: AGHT+IGAwgfFekHm2UIbzUvmmI9OLcLNuZF8zw3LpeX5LIlYghsq6IOZtrxHuUWO/+YqY3sRXW+b7Q==
X-Received: by 2002:a17:90b:4ad2:b0:32b:92ac:cfc1 with SMTP id 98e67ed59e1d1-32de4ed0a27mr2858231a91.16.1757673025569;
        Fri, 12 Sep 2025 03:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd9915343sm5150040a91.29.2025.09.12.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:24 -0700 (PDT)
Message-Id: <7f6f62bce607fd4d0438f05f9ee76f8547b96caf.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:11 +0000
Subject: [PATCH v3 7/7] t: expand tests around sparse merges and clean
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

With the current implementation of 'git sparse-checkout clean', we
notice that a file that was in a conflicted state does not get cleaned
up because of some internal details around the SKIP_WORKTREE bit.

This test is documenting the current behavior before we update it in the
following change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 56 ++++++++++++++++++------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7b15fa669c..b2da4feaef 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1183,35 +1183,47 @@ test_expect_success 'clean with sparse file states' '
 	test_must_be_empty out
 '
 
-test_expect_success 'clean with merge conflict status' '
-	git clone repo clean-merge &&
+test_expect_success 'sparse-checkout operations with merge conflicts' '
+	git clone repo merge &&
 
-	echo dirty >clean-merge/deep/deeper2/a &&
-	touch clean-merge/folder2/extra &&
+	(
+		cd merge &&
+		mkdir -p folder1/even/more/dirs &&
+		echo base >folder1/even/more/dirs/file &&
+		git add folder1 &&
+		git commit -m "base" &&
 
-	cat >input <<-EOF &&
-	0 $ZERO_OID	folder1/a
-	100644 $(git -C clean-merge rev-parse HEAD:folder1/a) 1	folder1/a
-	EOF
-	git -C clean-merge update-index --index-info <input &&
+		git checkout -b right&&
+		echo right >folder1/even/more/dirs/file &&
+		git commit -a -m "right" &&
 
-	git -C clean-merge sparse-checkout set deep/deeper1 &&
+		git checkout -b left HEAD~1 &&
+		echo left >folder1/even/more/dirs/file &&
+		git commit -a -m "left" &&
 
-	test_must_fail git -C clean-merge sparse-checkout clean -f 2>err &&
-	grep "failed to convert index to a sparse index" err &&
+		git checkout -b merge &&
+		git sparse-checkout set deep/deeper1 &&
 
-	mkdir -p clean-merge/folder1/ &&
-	echo merged >clean-merge/folder1/a &&
-	git -C clean-merge add --sparse folder1/a &&
+		test_must_fail git merge -m "will-conflict" right &&
 
-	# deletes folder2/ but leaves staged change in folder1
-	# and dirty change in deep/deeper2/
-	cat >expect <<-\EOF &&
-	Removing folder2/
-	EOF
+		test_must_fail git sparse-checkout clean -f 2>err &&
+		grep "failed to convert index to a sparse index" err &&
 
-	git -C clean-merge sparse-checkout clean -f >out &&
-	test_cmp expect out
+		echo merged >folder1/even/more/dirs/file &&
+		git add --sparse folder1 &&
+		git merge --continue &&
+
+		test_path_exists folder1/even/more/dirs/file &&
+
+		# clean does not remove the file, because the
+		# SKIP_WORKTREE bit was not cleared by the merge command.
+		git sparse-checkout clean -f >out &&
+		test_line_count = 0 out &&
+		test_path_exists folder1/even/more/dirs/file &&
+
+		git sparse-checkout reapply &&
+		test_path_is_missing folder1
+	)
 '
 
 test_done
-- 
gitgitgadget
