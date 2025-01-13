Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A10240243
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788423; cv=none; b=NIeK1vTGPLeNNxtVZPoN88SPQlaoE4SG8rXoNTeuhn5W+9qomZssQnFbRlzjt9MDvAvkMUwLgNfuPzmFwEKsxaAMrNbJ4b1dOMrEChvYg+Fde+MUFkkfBvLZvMJr6rvjRCSDUQJONqsE/4/oiVrNjJdTogItYG+B3jW5eaTvpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788423; c=relaxed/simple;
	bh=Nf+y0jysNc7SZiZne1uYZl4QV6UNjercuU+YKv1FONY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qKcZOmwOlMfxWVxgAo69Jeash3hbNtaz4weeAqJIYX0aMp23PyyJK5wG/uizdriH8oxbhjkG4W3BxfF9BL4cXOgihO8/b39rydrRzGThN1GFskZjVxMfDDRdTfIGVI39Pqgucl3VdtyqoytI+6w2iibWIIqHB2wiV3xBhUG2AHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZVd99qg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZVd99qg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38637614567so2220271f8f.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736788420; x=1737393220; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdEik/2t9FXSgFP1+1QHoKJBfUxKQXq2OC/jzIO+Vjg=;
        b=dZVd99qgpxOvB1n3F7zFAR0CK/3IMyrUyHxGArdqXg4HY4y1aRQyeg5shpm5xszf9w
         v6OTzcbK3IZyQmP2ug9EFDmzP1NqZPxiYiuv/qpYn00b80IPCzjGSoMNTxupBkeni0a5
         Ouss8jI5QnXBZfJL4ONQNtr9pMPKMQi5fFRT1ro8E6jBzB9aBdZLgYvPD55ZTIqGvHup
         tN2Uxoxopu/x0p05IXHqJPg0txdzFWZCnIYE7P0BOXOKDJum2CJpjRFjp1SbNffeSIIY
         StU9qNq5BLIO/FHPWf6fU5SUxsa28vhe+PQ5dMrWW3D1bLAvctUXXJeVfEcembwhji2A
         VqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736788420; x=1737393220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdEik/2t9FXSgFP1+1QHoKJBfUxKQXq2OC/jzIO+Vjg=;
        b=pBdkoE6nPoN8XCgkHCkEWyXcNLJCgWGvIsbjWbJieazI5ZeyQhkgTRIPjeJSZZvVv8
         nSoWaaOmdbasUWaRDAStbJZSpmoQVxbE/Q90fbuwaJDu/CG9KAQPqKSNzSKamKs2ByT8
         TZKPn82Fy101I/aIYLf7VLo6onA3ig1e8m3Nnif9a9AonPttyFQd6GmOK7YDwND/iAIl
         zyM+Q5/pPUTHCpFjSQKf4Lv7mdn2EZ62ymFsOEWdmHjv2CD77JDUC2J0tcyWGd1bVCMV
         KOzy29xBFdIW2BHQfWCFviEtvsK/mxHHRYoaNa8y+LNsi4LL2Ys8CtgUgx4m6LQ5915w
         0khg==
X-Gm-Message-State: AOJu0YwWCVIO6bHjtpdabcYcFNzUlND3T+cXAXWuSCE5inV2hYVs/yrT
	fA4WSyRMs8YuQe1yda0oiaIuy2kGwO0wwEJrlOI2KHESpow1Swv1X3q6UQ==
X-Gm-Gg: ASbGncudzWo2jkkyd9AS/tQeG2NszUgYXmVfpU+J1/izWSiZT2Cfc5JuhAQ7dJ+bV5h
	ZG3p+8FlNRwp9cbDEIJtet2Y9cfjfqtoXaAcK+lvAnrnV2fYIzFCfpOA6Yam52Y9o1uZJJpkxqk
	sKGbupUcMplNFIau7Nj5N3FcBGMbgAg189F83oZ48H0BfnQQOjlFeeGDo4uv2xvdr2l+pSC02zo
	3TpZIp58sSZFxgHiDXDGQkC69pxxiq6tSnBuWrvF9QW3ZWuLI7ajCZDrA==
X-Google-Smtp-Source: AGHT+IH93wdAdKDqS52+zoZaSHnSnt9Fj7XMLVArlgezEWKeA/C/338kQPsvcBSvCgCSF7shFATlZA==
X-Received: by 2002:a05:6000:18ac:b0:385:ef39:6cd5 with SMTP id ffacd0b85a97d-38a872f6ed6mr4395614f8f.1.1736788419438;
        Mon, 13 Jan 2025 09:13:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e384f2bsm12583226f8f.41.2025.01.13.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:13:38 -0800 (PST)
Message-Id: <b21b8fc555414789d835f454a0dce3bf685fdb4c.1736788417.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
References: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 17:13:36 +0000
Subject: [PATCH v3 1/2] object-name: fix resolution of object names containing
 curly braces
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Given a branch name of 'foo{bar', commands like

    git cat-file -p foo{bar:README.md

should succeed (assuming that branch had a README.md file, of course).
However, the change in cce91a2caef9 (Change 'master@noon' syntax to
'master@{noon}'., 2006-05-19) presumed that curly braces would always
come after an '@' or '^' and be paired, causing e.g. 'foo{bar:README.md'
to entirely miss the ':' and assume there's no object being referenced.
In short, git would report:

    fatal: Not a valid object name foo{bar:README.md

Change the parsing to only make the assumption of paired curly braces
immediately after either a '@' or '^' character appears.

Add tests for this, as well as for a few other test cases that initial
versions of this patch broke:
  * 'foo@@{...}'
  * 'foo^{/${SEARCH_TEXT_WITH_COLON}}:${PATH}'

Note that we'd prefer duplicating the special logic for "@^" characters
here, because if get_oid_basic() or interpret_nth_prior_checkout() or
get_oid_basic() or similar gain extra methods of using curly braces,
then the logic in get_oid_with_context_1() would need to be updated as
well.  But it's not clear how to refactor all of these to have a simple
common callpoint with the specialized logic.

Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
Helped-by: Michael Haggerty <mhagger@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 object-name.c       |  8 +++++---
 t/t1006-cat-file.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index a563635a8cb..8e80841acd3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -2051,12 +2051,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
-		if (*cp == '{')
+		if (strchr("@^", *cp) && cp[1] == '{') {
+			cp++;
 			bracket_depth++;
-		else if (bracket_depth && *cp == '}')
+		} else if (bracket_depth && *cp == '}') {
 			bracket_depth--;
-		else if (!bracket_depth && *cp == ':')
+		} else if (!bracket_depth && *cp == ':') {
 			break;
+		}
 	}
 	if (*cp == ':') {
 		struct object_id tree_oid;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa2..398865d6ebe 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -240,7 +240,8 @@ test_expect_success "setup" '
 	git config extensions.objectformat $test_hash_algo &&
 	git config extensions.compatobjectformat $test_compat_hash_algo &&
 	echo_without_newline "$hello_content" > hello &&
-	git update-index --add hello
+	git update-index --add hello &&
+	git commit -m "add hello file"
 '
 
 run_blob_tests () {
@@ -602,6 +603,34 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup with curly braches in input' '
+	git branch "foo{bar" HEAD &&
+	git branch "foo@" HEAD
+'
+
+test_expect_success 'object reference with curly brace' '
+	git cat-file -p "foo{bar:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object reference with at-sign' '
+	git cat-file -p "foo@@{0}:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup with commit with colon' '
+	git commit-tree -m "testing: just a bunch of junk" HEAD^{tree} >out &&
+	git branch other $(cat out)
+'
+
+test_expect_success 'object reference via commit text search' '
+	git cat-file -p "other^{/testing:}:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
 	{ cat foo && echo plus; } >foo-plus &&
-- 
gitgitgadget

