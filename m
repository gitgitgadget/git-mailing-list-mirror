Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4371B3939
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204839; cv=none; b=nn3AzzF9Z35SXQfxSWsc83eejY8ZZECVfULFNUY0hIVHwoYvPmV/rQ86Y5j/cfibYBEtRaDj4tyIQZFWGWNIcUiTvHCnGKYenCpmZZp/LPVf2vM3IPIVYHUXeIQu+BNm+GtXObDPqYfZvfftElB1c5mTmjOVIF1Adu/wqmP5fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204839; c=relaxed/simple;
	bh=Ah4aT9TB4oKjp6N6Yu+pIQ9FOAOijUXQgLbECjEMeEo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=GZMex/K9rqkHvHfzlpQisUcP35c5QvYC4BmNs/1Tqbv5wu1hbK1dTe6ia6KTw9i/Q5AdgkyCPg8MKgeRkOe9BCOFaJuRL1k9iB8hL0ZWAaVnMMgNIVY+adchy4nCnq7tuWgxybDaSrCYtjmz0czzQZ+0jKjTyP1V4vsVTLMx+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE3EyxpF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE3EyxpF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso19562405e9.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204835; x=1748809635; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9znZmTTPc52Eo+lII5wO/3O3mEcnXVYwvAyXj7Nwc9c=;
        b=IE3EyxpFqMKnX8kvMYVXEQcQHaNXsjogkLCxAuDfJBUGFhB0GE9w941eIDjlhLDQGx
         7bopsFBAbitQJI03nGXf4NR4nEijFilrR3K2o2/2iAwQz/mRzHUVzYHWa2VIed9hE4Gb
         B+YIECDw1YMZ+Jgzfq4jw1/+ldZlyK4jTnOFPvkX36vrj/hkAYKQ6n9bfeXSYui0Ef1U
         Ipw9FjEgg6TYiHGpwaDVcTGCtNE6wXJEUKwSR9OzBlPrjSeSDV3TwF6IWZnWbAo9wtcA
         L41LB2BvPjkQTPuptEVKwxKf0kysUEY4MpKl+W583GOGX4NM4bbydNdY4XFbvSBgMlAe
         2iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204835; x=1748809635;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9znZmTTPc52Eo+lII5wO/3O3mEcnXVYwvAyXj7Nwc9c=;
        b=jNC9CW/NUmExmzBYdNq+sTTBuoFGYKTs91v/CabNlGdgyqLkWoZ82/Jfpby0AApdeD
         /xFKHKvNTSTVWE4Xe/Tzuq/ds1IK/U/iVCx+DH8Y7fDGotn50j3HhqOOINurbnvpLEAp
         vW9CQRqBwHFuL0LxoGhlconGJj/yVCHWK+wVi2DmZgG2PHro2oShvPGnsGE+yLOKmzA/
         Bymp/hTrYpUaQqRrf9W8EkFJ+/AV7iHhb6DpXFB4vL6ImvBKniJY+UihTs6P3uOQPlV5
         tbABLbIg4/DF6Jf0z4u9WODsmgYLSUnQGXlmLbAlt5oI6GF2diD7QzcYYNuwAqrvppmP
         R5rQ==
X-Gm-Message-State: AOJu0YwqqIbUrf3XAAF2N78UXVX5Ipw+AvYD1L1z9r7LOnx8orVIrlGJ
	B6DszTaTdUNKt3iCF55Sw0vvmk/jV1H/HGgLn/01JzhvvvsyoK+H8wk9EEJYXA==
X-Gm-Gg: ASbGncsN6gQpxnyVCbqJNnRtBTqoi6fgJkmkYlpdzdejz2rqW+tlEbUVi0NvVHoEIZ6
	wWF249S3B5tolEB+Fmie0KFRzJX0RQOBf18dL6Zb/TrSWxoPSTz93It+hcdqVnqCcte2BflUU/b
	mdLGnU3zzeGJ7zYXuxsLxnuFoPHZAG+A08e32fyCsseLrrWUjQXCc65PSOI9Iybh0X/DAT1US+L
	8+hlGdWJDt9ntncZpwFp9SaouOPAQV9K2dwJJHVJ2spVJnBRbs4rfgk47yjvErc2R/KMsV1QUCr
	7LV0m3v/ojGY1bA8dGhfp/yTxoBQnoRv/mHqfnp2+z3NYN+7hKrL
X-Google-Smtp-Source: AGHT+IFvsY3U8fmi4MeH8iqeBjj7nYr57RteLg1cTHXfLrxkdXtsKrxJXpqgqKzTBlXY61tloOUXgg==
X-Received: by 2002:a05:600c:4e45:b0:442:f4d4:546 with SMTP id 5b1f17b1804b1-44c91ad6ab0mr50677625e9.1.1748204834955;
        Sun, 25 May 2025 13:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4b68sm218521895e9.23.2025.05.25.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:14 -0700 (PDT)
Message-Id: <6aa05d92f988004d2d30d852d8c810058d6a9175.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:05 +0000
Subject: [PATCH 5/9] doc: convert merge strategies to synopsis format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/merge-strategies.adoc | 58 ++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 9e034f447e76..2ba43f84e709 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -6,7 +6,7 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-ort::
+`ort`::
 	This is the default merge strategy when pulling or merging one
 	branch.  This strategy can only resolve two heads using a
 	3-way merge algorithm.  When there is more than one common
@@ -29,26 +29,26 @@ descendant. Otherwise, Git will treat this case as a conflict, suggesting
 as a resolution a submodule commit that is descendant of the conflicting
 ones, if one exists.
 +
-The 'ort' strategy can take the following options:
+The `ort` strategy can take the following options:
 
-ours;;
+`ours`;;
 	This option forces conflicting hunks to be auto-resolved cleanly by
 	favoring 'our' version.  Changes from the other tree that do not
 	conflict with our side are reflected in the merge result.
 	For a binary file, the entire contents are taken from our side.
 +
-This should not be confused with the 'ours' merge strategy, which does not
+This should not be confused with the `ours` merge strategy, which does not
 even look at what the other tree contains at all.  It discards everything
 the other tree did, declaring 'our' history contains all that happened in it.
 
-theirs;;
-	This is the opposite of 'ours'; note that, unlike 'ours', there is
-	no 'theirs' merge strategy to confuse this merge option with.
+`theirs`;;
+	This is the opposite of `ours`; note that, unlike `ours`, there is
+	no `theirs` merge strategy to confuse this merge option with.
 
-ignore-space-change;;
-ignore-all-space;;
-ignore-space-at-eol;;
-ignore-cr-at-eol;;
+`ignore-space-change`;;
+`ignore-all-space`;;
+`ignore-space-at-eol`;;
+`ignore-cr-at-eol`;;
 	Treats lines with the indicated type of whitespace change as
 	unchanged for the sake of a three-way merge.  Whitespace
 	changes mixed with other changes to a line are not ignored.
@@ -61,7 +61,7 @@ ignore-cr-at-eol;;
   version includes a substantial change, 'their' version is used;
 * Otherwise, the merge proceeds in the usual way.
 
-renormalize;;
+`renormalize`;;
 	This runs a virtual check-out and check-in of all three stages
 	of any file which needs a three-way merge.  This option is
 	meant to be used when merging branches with different clean
@@ -69,31 +69,31 @@ renormalize;;
 	branches with differing checkin/checkout attributes" in
 	linkgit:gitattributes[5] for details.
 
-no-renormalize;;
+`no-renormalize`;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
 
-find-renames[=<n>];;
+`find-renames[=<n>]`;;
 	Turn on rename detection, optionally setting the similarity
 	threshold.  This is the default. This overrides the
-	'merge.renames' configuration variable.
+	`merge.renames` configuration variable.
 	See also linkgit:git-diff[1] `--find-renames`.
 
-rename-threshold=<n>;;
+`rename-threshold=<n>`;;
 	Deprecated synonym for `find-renames=<n>`.
 
-no-renames;;
+`no-renames`;;
 	Turn off rename detection. This overrides the `merge.renames`
 	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
 
-histogram;;
+`histogram`;;
 	Deprecated synonym for `diff-algorithm=histogram`.
 
-patience;;
+`patience`;;
 	Deprecated synonym for `diff-algorithm=patience`.
 
-diff-algorithm=[histogram|minimal|myers|patience];;
+`diff-algorithm=(histogram|minimal|myers|patience)`;;
 	Use a different diff algorithm while merging, which can help
 	avoid mismerges that occur due to unimportant matching lines
 	(such as braces from distinct functions).  See also
@@ -101,49 +101,49 @@ diff-algorithm=[histogram|minimal|myers|patience];;
 	defaults to `diff-algorithm=histogram`, while regular diffs
 	currently default to the `diff.algorithm` config setting.
 
-subtree[=<path>];;
+`subtree[=<path>]`;;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
 	match with each other when merging.  Instead, the specified path
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
-recursive::
+`recursive`::
 	This is now a synonym for `ort`.  It was an alternative
 	implementation until v2.49.0, but was redirected to mean `ort`
 	in v2.50.0.  The previous recursive strategy was the default
 	strategy for resolving two heads from Git v0.99.9k until
 	v2.33.0.
 
-resolve::
+`resolve`::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
 	algorithm.  It tries to carefully detect criss-cross
 	merge ambiguities.  It does not handle renames.
 
-octopus::
+`octopus`::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
 	primarily meant to be used for bundling topic branch
 	heads together.  This is the default merge strategy when
 	pulling or merging more than one branch.
 
-ours::
+`ours`::
 	This resolves any number of heads, but the resulting tree of the
 	merge is always that of the current branch head, effectively
 	ignoring all changes from all other branches.  It is meant to
 	be used to supersede old development history of side
-	branches.  Note that this is different from the -Xours option to
-	the 'ort' merge strategy.
+	branches.  Note that this is different from the `-Xours` option to
+	the `ort` merge strategy.
 
-subtree::
+`subtree`::
 	This is a modified `ort` strategy. When merging trees A and
 	B, if B corresponds to a subtree of A, B is first adjusted to
 	match the tree structure of A, instead of reading the trees at
 	the same level. This adjustment is also done to the common
 	ancestor tree.
 
-With the strategies that use 3-way merge (including the default, 'ort'),
+With the strategies that use 3-way merge (including the default, `ort`),
 if a change is made on both branches, but later reverted on one of the
 branches, that change will be present in the merged result; some people find
 this behavior confusing.  It occurs because only the heads and the merge base
-- 
gitgitgadget

