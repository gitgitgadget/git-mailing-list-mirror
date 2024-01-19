Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067357302
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695549; cv=none; b=p9ZbpTRKFqZ/bkKGyuoHLABtdzdDJ75fq+poSghPJAEl3n+3j0MO5993bCUCMogFA7rDyeSZtX3xhRO56MCnJn8CbpSbe6Hib+H67WIIhFKiGoyte3CyP08aM1O1eGhlTEO+aToDTQDu6ktri3WowU3aobBNrj+tJZ/+ZqGV2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695549; c=relaxed/simple;
	bh=PEtimUn1GkX8AtQ4KhIU36esVMi/OOXPr5jpcmr65zY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pPooR8EKtpw11XO5rve1CknoweCwe7FAbFDYc1Cl0nLUKGVtx/RTR/bNGRKaVwPtLbveGyUCsUWP60Lt1FFOs+dgxpWxddJ/8fLPZ7ZUdIJtl1jDUoIq0v3STvnM3HgKjcMSOLIqT9KbpWnnq/+4NEai/3JDahtmMrRKJfQnRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXJMYMgV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXJMYMgV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so13528985e9.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695545; x=1706300345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvAeKPQ8C29opYWma/beMRAr4IQAGUukuoXbFY7UYso=;
        b=QXJMYMgVcUkxB9Rcb7PvSI3tOw15uUrQXF9p3Q0m5vM899jA43us/SOVjd4/1unLrZ
         PXaEbks2BfhE19h+PjmL6tJ8sYy2vZm0KCtDoZ18nc2cAob2lv3tfkTYQ0vdlcjY3+oK
         CGzSbkSu8AQ5IQXhp0Jvcp/vWUEizv1Ji81kVhcVW3S6coT4UB4TeJ2mujdBvgWT7c98
         fnRJdRdyiPwNnTtLoECmzCfkBuJEZetEpaJK/z33W7pmum690rrzsPFUb/b6XRThwCWm
         u9GeYWFhzY0ZF/1BGFd/oCW4GXud0jXYICjNwv28qeqzlJSuJt4vwXd4jWkQP/NGiV2I
         8zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695545; x=1706300345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvAeKPQ8C29opYWma/beMRAr4IQAGUukuoXbFY7UYso=;
        b=q+cu5kuz00daQrG39CTSKFp1tijoR61azaUHtlCoxtdHRaSoMh7PUM4QQu8AZCJ1iG
         ziUQfrJbyp+C21LJvRSJrOHWeNtk6cGENWDm9vBXXbM7OxggUsUCh0xat5jyJqZ9/D1l
         HcxbREY4S/Qno57c1g/jOJ6gg+xrh8ky3isRku3Z1Z9wFLhJd8Cf4ckk509W4LXc/VL/
         MH3iZmTovDJeOuitqURW/Rp53+55xL0V+7nMXXexBRh2SG7CcekRAX8GyPTHmjyqYNql
         2+juYeG4cxKdnhq9hsRWWQVtcJoP4XjsnY/anfGKYNurdFg/dm3nmnhilcOFsIoS1fxx
         F+uw==
X-Gm-Message-State: AOJu0Yw6C2lp3fLLL7ortQeTLRXKTSqXblDWHpSxpp2PV8EJIWUkHhiY
	UPEjkc6Gv+hsgeSCldUea2N5DIvmoDiTE5uhtGiQ7Vf7C/7digm60GyL14bo
X-Google-Smtp-Source: AGHT+IEhKdcLjGMyd/3Q/Us7ibxl4CfZETwIU0i5T7o+8lpDuvcrmOOk8XzTLbd3IrW3al6iEImSYw==
X-Received: by 2002:a05:600c:35d3:b0:40e:4df9:8996 with SMTP id r19-20020a05600c35d300b0040e4df98996mr162381wmq.23.1705695545468;
        Fri, 19 Jan 2024 12:19:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b00337bb0f370dsm7268459wro.40.2024.01.19.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:05 -0800 (PST)
Message-ID: <42dc9948aa5000e94d63701ef61c9d93a6744b51.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:53 +0000
Subject: [PATCH v2 05/12] t1405: move reffiles specific tests to t0601
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

Move this test to t0601 with other reffiles specific pack-refs tests
since it is reffiles specific in that it looks into the loose refs
directory for an assertion.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0601-reffiles-pack-refs.sh | 8 ++++++++
 t/t1405-main-ref-store.sh     | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index f7a3f693901..2e457c4f2df 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -32,6 +32,14 @@ test_expect_success 'prepare a trivial repository' '
 	HEAD=$(git rev-parse --verify HEAD)
 '
 
+test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
+	N=`find .git/refs -type f | wc -l` &&
+	test "$N" != 0 &&
+	test-tool ref-store main pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
+	N=`find .git/refs -type f` &&
+	test -z "$N"
+'
+
 SHA1=
 
 test_expect_success 'see if git show-ref works as expected' '
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 62c1eadb190..976bd71efb5 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -15,14 +15,6 @@ test_expect_success 'setup' '
 	test_commit one
 '
 
-test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	N=`find .git/refs -type f | wc -l` &&
-	test "$N" != 0 &&
-	$RUN pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
-	N=`find .git/refs -type f` &&
-	test -z "$N"
-'
-
 test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	$RUN create-symref FOO refs/heads/main nothing &&
 	echo refs/heads/main >expected &&
-- 
gitgitgadget

