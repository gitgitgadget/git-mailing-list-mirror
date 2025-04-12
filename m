Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A81E480
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481741; cv=none; b=qkzMtGXpMWvQy4ft/XSMvYZ+ICPNZdsIK4jUu/EYb6sZUd8mejgpHw9x/ognkQTNUsr78azQ1fN4vsdHLo2mnJii93xBe1IYlOLEfXmfAgDVmUKoa5ujvCJTIHU4qydYPW3GXJeI0scw1lgz47szUdIqZmiDGO3dhPP3zMmrqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481741; c=relaxed/simple;
	bh=Xhf/4Yd1Hr7rW4SJ0uHt7uCkUueGdgHvynERbZbv924=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m0ucECcBvn3yQPeE0ZjgnkAemmK1c0UJwxY8B8JOf7yiE5fy4HGHavdDazoLQBEMpAwUnD6HCept7A8grlbT2n78sqi0v+y5bd41trDVmO9G7mCFJ+wZISBMF6rLQlKAodiQA0m6vH0T/aoewd++ofefNJ/MvCBgFXTXmYTId3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q346l2v2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q346l2v2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc0b5so2272922f8f.3
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481737; x=1745086537; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpYYYu//7ksnbdIvkahK7A2Pv8s2++Rw4BnYXpKHzY0=;
        b=Q346l2v2LvA1ptwcUbMSoG7VcJsx5rh5/ILQ5Y4LAbs5K4+tvvOpBQX4ALMKhcTcSX
         gDbHQpmM39VsSzCIyi700jKAEMW3Y3jL5qwzH74dV7YqL4al9NrhxD8qsshepc6DxXVW
         4uLIBnO2mvFbuyW0wKi40lPSBZX2/6Xv9Lf0l/lLKt8PEgEwVVexHQPQXZAFg1duqlDT
         Cw2wQOWH8BKmEC7ycSBvJLQQRf9oTJxM1wYhQ5p6DoU7vFTcwplrP6XiV2D3KgHQ7PCj
         mgPHwXS/bnbW2gSAevUYF3UK5Ol5C9L99YEdFc4FzThG6RuqzThi38bQOd+eroWyt7F8
         V4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481737; x=1745086537;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpYYYu//7ksnbdIvkahK7A2Pv8s2++Rw4BnYXpKHzY0=;
        b=wbpCnOps857iGmxHdonUVjcB82Ml1DvUAHxa0Ce2lajBgZEu9oBO+ieJ7tDy6Jo1L5
         OT6BD41y+Jkl8d6rxMJa2wsTCsdH1dIs8Wd67kCle5AXbaP2uBQaevRTEncZ6uQfJmp1
         6/rDmOSB4H17TgkM2AvBCOPR15D7TbfqPj7ZsCF0ewaM0NxjzYWYyPQXlozgKhjMKnzX
         6YLdBaGRUxlw0eBdJZbaQpcoZX2PY11CrMGDfHDGAl5MUQ6xJD/OFmJwBZPEriZaPyNT
         g/ctA+uqZNk0ErXQViUjuPPccuwyljQ3m8JP/00fypMF6E+VfWkLcoZTbHP3smfcDBfB
         A9Gg==
X-Gm-Message-State: AOJu0YwRBKB4vJBBQMY2aQpy3QbE5De7b88L5kMOB6iDFEmd9NYQZTrx
	SzeLeEqbe25S6hkO6CVrO/2OggWlPODtaKHbQ6RD1TvwyZ7cygjz+JhEtw==
X-Gm-Gg: ASbGnctkwcDu/qqGyhovNHAw1KZweY5tiu8v8N98BEEJlI6Hn8h+mERKAgwwkpuXbTh
	FQsnJbu0sihfJ+f29ksPEKNDtuTWnXj/5qehxfiLMs/j/OSd9xpfWf97N02lU1594gXk4Xeq5PR
	BPXDCGxaEfVqQx2zTh9WhyDB8iwXMIy4AQd1oXaL6uPKfD+GH1zushqTM7zNTITvOU5007Ci3FS
	/ZDYw7rjqARWJ/DqLIb+xphcn9qAFetnsdP8+oihgdkRnPQt7RbWBtaoo0Sjf2n2pkLVOqIaTbC
	ly5BDYZu3f20isW7cf6RU9CsKIKq73ZPR1vs1q0F1Q==
X-Google-Smtp-Source: AGHT+IF5N1HkdazSC0sX0XNPG7ySZYIhXnmfc4R7J+rUtD7bctxSHCZvvU9yMkthK+l5bwPOlYl4+g==
X-Received: by 2002:adf:b607:0:b0:39c:2678:302e with SMTP id ffacd0b85a97d-39eaaec7648mr4673763f8f.45.1744481737428;
        Sat, 12 Apr 2025 11:15:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979684sm5757465f8f.55.2025.04.12.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:15:37 -0700 (PDT)
Message-Id: <1092c32609f249839453052ca802cb10256cb48f.1744481732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
	<pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 18:15:31 +0000
Subject: [PATCH v2 2/3] p9210: fix 'scalar clone' when running from a detached
 HEAD
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In p9210-scalar-clone.sh, we test using 'scalar clone' to clone
$GIT_PERF_LARGE_REPO (copied locally as 'to-clone'), which defaults to
the git.git checkout we are running the test from.

When --branch is not specified (as in this test), 'scalar clone' tries
to get the default branch of the remote repository by parsing the output
of 'git ls-remote --symref $URL HEAD', as implemented in
scalar.c:remote_default_branch. When the git.git checkout we are running
the test from is in detached HEAD, this fails and we fall back to using
the name of the currently checked out branch in the newly initialized
repository, which in this case is the value returned earlier in
cmd_clone by repo_default_branch_name.

We then invoke 'git checkout -t origin/$branch', with $branch being the
name we got from remote_default_branch. This invocation fails if
'$branch' does not exist as a branch in the current git.git checkout.

Fix this by creating a local branch in 'to-clone' in the setup test
"enable server-side partial clone", making sure to use '-B' in case a
branch named 'test-branch' already exists.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/perf/p9210-scalar.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p9210-scalar.sh b/t/perf/p9210-scalar.sh
index 265f7cd1fe2..56b075e906e 100755
--- a/t/perf/p9210-scalar.sh
+++ b/t/perf/p9210-scalar.sh
@@ -7,7 +7,8 @@ test_perf_large_repo "$TRASH_DIRECTORY/to-clone"
 
 test_expect_success 'enable server-side partial clone' '
 	git -C to-clone config uploadpack.allowFilter true &&
-	git -C to-clone config uploadpack.allowAnySHA1InWant true
+	git -C to-clone config uploadpack.allowAnySHA1InWant true &&
+	git -C to-clone checkout -B test-branch
 '
 
 test_perf 'scalar clone' '
-- 
gitgitgadget

