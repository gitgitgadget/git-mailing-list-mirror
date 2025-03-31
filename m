Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5F2144A6
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436288; cv=none; b=suPqNcskKS0zYVvGeGcl600j0f6e4gS3C9st5woFEGfP1KONlqdiyj25Ng56KRmi2aMVr22gWesIy3ygwCwGyTxzjkrK/LYmyMbkH9F/7XccGf1mGzfRvVwICddGi79CVdXjPqhllt0OeXcbA5+b7MPnpJ/FwjhVmMsxLnb7hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436288; c=relaxed/simple;
	bh=9WE9DHCrkxclAtRxyd7r8TgKdnzJmkBcxj45LhpjGFI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=myHF5SoR/yU3cmJS4vDAkvASUjIAp8nPhnqylgKlhc3xO5Ucn3fQHx3/RXBqU2DMsz05mQi5g115i58gu61p+kpPEgvrbFulA4zD1Hqlg4zgBl6ynH90bBK3K80fy/zh7PTq7ySfjiUN2KFjdKYyFFYi3Keew0c5MNOfLYdA03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMDZkJga; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMDZkJga"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2622535f8f.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436284; x=1744041084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=jMDZkJgaVZgFqcGQFuJ4zeZkc7OQWmn16xZf0CuYpKKRWi6D76phiYQYRnx84NEqix
         T893YflBCCnOmgc0RZk4xxuRiWHRAhd0iN+XDqKwgvECyOatyX6s8B+cvkywb0CluU14
         Z5WrAznh7O2RfWz4P8az2qRCE2ARispdbVehZniYqmADXIB2pOMfjcwBNvrzzDehhya4
         7L4RTjRDqoL1o7VRLqEWgxI6+J1RH44lAJe+KoRYkjXiS9V2CYkMCb0Vjl4/VUoumRqN
         Jq6p3Zor8PdEQnIt3yi6yX+IUclU1cboNQM+c59dhnqEs9wHfG/PFPSyMuA3j/T7sjRB
         e4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436284; x=1744041084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lojPv5wdaz2eIF2J+eBFJD2HNxvZjKfzpRO9tMry/Mk=;
        b=WRP86UJEOPmrtGMR3npOCgN4vOFvgxXuLZ9ePiqRdbbxVbCqbxjtWDlbpDkHCDboLL
         uOkcnkKBjUnoyqo+mPRykodH+SzftyZxMVm3bcREOhN8CvpyrSdjit/MlBTngLKV1w0U
         hwkd7tcSvNVIMGqNmushOPxO2pQke4VRGEtLUi/9gkBFmDWEwOTxMl2sl9GhM8ZWnPQk
         XUwgSmZhtv7qWuDTIvVGjl+Dlm5RrknFx23CyfoO3iBHgOD/ODPho6jrsiUQIlLOXmXj
         Y99OdA9LCwDBL+Eg9zIIHcUTgakSQgXmsWjuKko2ciOL3WqYn263NEqhdTtou5ic5lR/
         xA8w==
X-Gm-Message-State: AOJu0YzNp2cYD5RjDz4DAAAOp03abpfu+gXkn4gkPvXYbg8YsoLuYO0J
	LFvBbYv8oKcy9mYKdgO/SxfEG/RHSM8RoS9KLMbTReqIoiqKoOVzy+G5lg==
X-Gm-Gg: ASbGncvapRcUQHjGHSQtfRZKikq8Q5Yvt3Mc2oYrledOwCWymmeCdFQ5UR07z4lCxGH
	Mi4b5KCJXqkqmqsHFQ2P6mgJPYv33hFQhKoPbKPW+IAINMlU+UyB+dB2FN92ZdoBs/KZiDSEqC0
	Jy0lk1h4LEhSudrdHtXlxe/1fFFflP8ESHVMJAqL4GH2MDPlzRK5gBX7i19vw9cDrcIwyWe+Uun
	VjRo8SLoZGZJONaSzRJCKv0R+SS2i2OoBsoIpSyjVR0Nij0rZUhDQmNJ6VvYZ2/wFlR3y4G+DbV
	r1HYcCme2vqEE8u3CKPOxcGpKKZ8+ntqDVGno01CmWxZ1Q==
X-Google-Smtp-Source: AGHT+IFuP/6mVQI37PenfeRx4P3V8iQFhmXgd7uWgtIAVlvyoImOwdLc9cdn4BY2F7VfFDOUauuG0g==
X-Received: by 2002:a5d:47c5:0:b0:391:2d8f:dd59 with SMTP id ffacd0b85a97d-39c120e1665mr9130661f8f.24.1743436284398;
        Mon, 31 Mar 2025 08:51:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4482sm11364473f8f.86.2025.03.31.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:23 -0700 (PDT)
Message-Id: <3945c471b0c40b49e9a48feaba6dae2afc96fa6a.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:14 +0000
Subject: [PATCH 3/8] merge-ort: enable diff-algorithms other than histogram
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
Cc: Elijah Newren <newren@gmail.com>,
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

