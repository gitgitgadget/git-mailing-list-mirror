Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9822DF82
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127331; cv=none; b=PRlCxGQhLMwFTwXTnax8UwuTRe6VDovEkPfkMXn5VDPRfcDRcYvrCZ1P2b1qY28GJeYXtJZJMgsqwgRX2CQTGdwizacS/Oz5XPPA47cJbbfw7MFsHDq6R+TGLi9Codn2Tk32QMRZXzxkKq2c8PYCW8ilfL5+W2mXdM7Q9u5YqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127331; c=relaxed/simple;
	bh=9WE9DHCrkxclAtRxyd7r8TgKdnzJmkBcxj45LhpjGFI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f5drj6Gzk7D6OKPG1Gald1roaonXTaIvGF/z8Fv7+m2ZilVMLIpQderYWck1aCstgS5rpYx0ZZaffs+jBHpV6ohi+EOz1yv8F5MmDOODm192SSMEGo4+SgxL3bd1U0lTaANGVGxmIk+F2BTqY6uL2nli3tE2anv15W1TdlA7KME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhLTCKvj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhLTCKvj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso29795155e9.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127328; x=1744732128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=BhLTCKvjvvJkilfBPNTGCWPwRha6D3J4D94BhowAVYLTnVDGY85iua0n6ZmDSagl+M
         SXoa1JBOqeB5AFSIUmlWwhzpx0m2e9kIzM/7cw1anuea9K6/DGa3Pzcmo5+QhzRHhBX6
         zdPOye/xiOHbI5+fn9o/N1D3gEJxIKa0GtXZ6LLqhPQuCYUIpNSwXzHtu2xd5snPgga4
         /PaOHA2cBMcfVZ4ZYzbnRmSmN2nvurS9tyk6IJ6L9U7z8cKIdt/K1c/8WztJWRa02zCR
         KmB63C5S+bM0obSC/psjeQJUrvbtbtOC1QzMlVLV5gqw+YcjWYiSrrCaCjqAvmKxHMs3
         uBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127328; x=1744732128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=ryge5MsSGEWupDPai93laKEhnzCCT1hXDL4sNawKV1kbTn4v3KPV+D/z9gJZVeqD21
         DjSpmYtJCuwDC3bsu6DlXSB7BrX5YAQNAvasaTq/NDeu7mDMTqHtrvVHg4U+0E6EEqO2
         fItQNHEqy1q9xSL6yIRndJgWht60L56eBC3JG7o1vE65GfFrylFXIVuMZ7NomryX5hIv
         IwrW1zlKzW3xZcMaRmFLdI2OMbvdW6BF/tnYoXz6AHo5IUFGBJFdNb9BHlmu6/a96Qv3
         JNKyYZWH2+vEBIYnvujTEOGtq4r3HVieUbRlJ3Q2wa1Hnt+cPB37Q5E5xn7Vaug0FcHL
         ADrA==
X-Gm-Message-State: AOJu0YyWL+KF7CuEm2H2xO/GSUAvSKgPYvmpe0jNXopK2w/zwe3D2ZLQ
	XEM4izVEf3N04N5HpGxCSGhqoaEZ253wZ/mLySbOq4bdG7LMxWQRu/krwA==
X-Gm-Gg: ASbGncv/7yJppe9xCGv/r1blXZIRAwO+mPVNE5QAaM9zC4j01p/bhNPjJkSJ4bOqJEP
	Bbzu8aK8zxTYtgeM7Cg21b6uOEaH/eKGeND/RZhw4Q/tVUXgmWpfIzsmXWLiYWYX+97iTtTwu9g
	l3HNZpItFuPH/+7u6kw5M1k2gOcP+BgQVr3Cc6uK+6mLFTnsAMKOJ5thx9oSahNoqZsbesm9OAR
	gDAV/UD6ontBuutU5FywXLzarUCqCdRFxAt+xmytNnrVLMw57D0KaroKMW996MdvK0dLB0vLXvc
	hZs0pCIFIAlwEyUrfonhEUbEcfJVgO/ngz3U1688zEzVlw==
X-Google-Smtp-Source: AGHT+IEWknh5TqLLGKhgB/aFejswDUsyTlitVhyqtGuL1IUdovWC49Yi4cvqsHBa6+kPdII2F6O+Ww==
X-Received: by 2002:a05:6000:40c7:b0:39c:1257:feb8 with SMTP id ffacd0b85a97d-39cba97fb05mr14143329f8f.56.1744127327847;
        Tue, 08 Apr 2025 08:48:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b7dedsm15435844f8f.52.2025.04.08.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:47 -0700 (PDT)
Message-Id: <cf774437123722d6065139573b49c3e09c6c135a.1744127322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:37 +0000
Subject: [PATCH v3 3/8] merge-ort: enable diff-algorithms other than histogram
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The ort merge strategy has always used the histogram diff algorithm.
The recursive merge strategy, in contrast, defaults to the myers
diff algorithm, while allowing it to be changed.

Change the ort merge strategy to allow different diff algorithms, by
removing the hard coded value in merge_start() and instead just making
it a default in init_merge_options().  Technically, this also changes
the default diff algorithm for the recursive backend too, but we're
going to remove the final callers of the recursive backend in the next
two commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.adoc | 29 +++++++++++++++--------------
 merge-ort.c                         |  3 ---
 merge-recursive.c                   |  1 +
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 59f5ae36ccb..8c87dd70210 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -87,6 +87,20 @@ no-renames;;
 	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
 
+histogram;;
+	Deprecated synonym for `diff-algorithm=histogram`.
+
+patience;;
+	Deprecated synonym for `diff-algorithm=patience`.
+
+diff-algorithm=[histogram|minimal|myers|patience];;
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
+	defaults to `diff-algorithm=histogram`, while regular diffs
+	currently default to the `diff.algorithm` config setting.
+
 subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
@@ -111,20 +125,7 @@ recursive::
 For a path that is a submodule, the same caution as 'ort' applies to this
 strategy.
 +
-The 'recursive' strategy takes the same options as 'ort'.  However,
-there are two additional options that 'ort' ignores (not documented
-above) that are potentially useful with the 'recursive' strategy:
-
-patience;;
-	Deprecated synonym for `diff-algorithm=patience`.
-
-diff-algorithm=[patience|minimal|histogram|myers];;
-	Use a different diff algorithm while merging, which can help
-	avoid mismerges that occur due to unimportant matching lines
-	(such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.  Note that `ort`
-	specifically uses `diff-algorithm=histogram`, while `recursive`
-	defaults to the `diff.algorithm` config setting.
+The 'recursive' strategy takes the same options as 'ort'.
 
 resolve::
 	This can only resolve two heads (i.e. the current branch
diff --git a/merge-ort.c b/merge-ort.c
index 2b7d86aa4ec..14a7ae4a6bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4957,9 +4957,6 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	}
 	trace2_region_leave("merge", "sanity checks", opt->repo);
 
-	/* Default to histogram diff.  Actually, just hardcode it...for now. */
-	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
-
 	/* Handle attr direction stuff for renormalization */
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT);
diff --git a/merge-recursive.c b/merge-recursive.c
index 884ccf99a58..f3df127ad9b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3981,6 +3981,7 @@ static void init_merge_options(struct merge_options *opt,
 	opt->renormalize = 0;
 
 	opt->conflict_style = -1;
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
 	merge_recursive_config(opt, ui);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
-- 
gitgitgadget

