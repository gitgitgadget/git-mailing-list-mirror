Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE543F0A92
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590165; cv=none; b=Mlk4Y8If8FxnyjnlCimS+drzJ0I67Eq0qbJEHAdBhdYUQ+c9IJu7KZSYFQ1F1q8keSp+ylK5PxlGocSTRXnMqDGGdAYRt4eTMBzmuIzwluytQaqlv/ADctboa4Df9PzZfZv+o5GDk9gacgWhaCboszXAd1ili5ZOMrOPoDT1RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590165; c=relaxed/simple;
	bh=G3xrOMLIxY/BCPkNPkpMnEY4KvWc6A+7+E1RhUUTHtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a5mJvtN6SCTRN5GjuLNqs/a70BkMhkGsUUHE3Ij6UiRXl+lhWnsvM0K0M5fjHsoBi4/bIYGxI64GNjdl8NyGI/0Cf7BhUNjT7scpAD6OoBOZr88CdpI1xgF7Om//qbyRletJ5QUe/GI4jH6LK3KgF2Xi69oZYz/YOA2sY2D2zSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVICY+L5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVICY+L5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c05dcdf49so15252991cf.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590163; x=1784194963; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ips2cu5ygyvZZho72b2KYFG+qlHrSfTJ6Q6HHJcWssQ=;
        b=MVICY+L5LMOajMhoJY0gtBG/a6w8jKmEnyapnksSEdBrLnRI+wIh1p95usFwCyv2oN
         9+/EmzuH3uOOCEoXc8K1yjv1uYYFinoLLGYaT3y+2x8Ibb5N43UiNkEcVjI6YRwmUWgf
         Y7mcwNOZg/vJCVOknz1UaxU8lHRpxUuUTm7wkD/k79OrzltwCwNQC+cSi+cGHtUym3MX
         FDcORu25rV2cZ5L+77i9vUH5Bt5G67PfshluGyTw/JUVeGaEObQJOmPUmS9TPYkTACf3
         YW/2t7F2DARmY/TfFWKSXosMuFXG2/fFH04CX2M/OX2FmfMj+OEXdxuleLIF5YjgyT1M
         E6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590163; x=1784194963;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ips2cu5ygyvZZho72b2KYFG+qlHrSfTJ6Q6HHJcWssQ=;
        b=C2hoxv9d8rbyQNR1oLqBDPrU3mbMjxrQDPc8MwnRgD/LvnjA3ybh2y8c9VD5BprrLp
         YLgMunpy2PNxUv5H+0sDH9RXZO9+LqACSjMb5kSUglyPPxiEUDqtGGP8kesIRTFsewbK
         PCjGui/iPctAu72zaYZU0tx3bJ6bMdtaKYHe3IlTvFNPiyrzIfyx91HUbg8PgY7sw8PP
         FfMdnp2+JrQVg54y9UswyMLZ84DD9IVeGQsd0gzn/AwhLzywnj+ivF1ZXisrCcPInBTG
         zKqCIgE/3rids08csgOoBmFnRykKVdHAilRf914q3umKNvXb5FkkkeoDRZf7oxJTR/3d
         Jp0g==
X-Gm-Message-State: AOJu0YxOYiwM5wN5eN/0IEA13EdgyAWfBFRYBGvB2BU2CvDdE4Bqjvps
	M0PAOP0V9eXqE4j6CSdXClljPipK7BbVaAmzkZ7lFx/9pPJj8kCXd+kCIuBZ2xWU
X-Gm-Gg: AfdE7cn3kwOudM6R+3ppEify2AJ2Gv81pHDUQQeTb5hrR1xO94WGzdL8/gRid4Flc4c
	PlUNnRaME8U52p03gTQbZOFXk/FSbEj8uNxHpVDqTQEIN3Y0Ea8sNs0AFXI4XI19YF7U3erxjj3
	f+/HSNB/gFm7jOK6ZYTjT3yVHAJurRwuPAa34SkJ6Ich8yrRqqhRNUi3FgJR8+W8iw065InfOaZ
	oxCgTNNcgyJwWciUfMwUOHSIBGWFxzzDP9yEi3kFZbb1TkNTYo3L4+Z/enQJziixuIqwsI7SgjL
	V9a2S7bXdSn8C4o3dSbt7RRdnLzR2+YJyzV7+V0aAnSeay3AEpNOBo4CaI/GFYMMlijCk/dGFcm
	3Zq630lztyPr7xSYYzB/REAAu2FhUffDQ5+5lnk4DCvVj9MF4V8737P8lXgkUuOTk1HGQPlYqa+
	jmGFCVD33VMBdt
X-Received: by 2002:ac8:7fc7:0:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-51c8b2af295mr69044491cf.3.1783590162810;
        Thu, 09 Jul 2026 02:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41e084e8sm152413771cf.28.2026.07.09.02.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:42 -0700 (PDT)
Message-Id: <4fdba0542b3d643affe32ec35f27fdbabccf54d0.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:29 +0000
Subject: [PATCH 02/11] diff: handle NULL return from repo_get_commit_tree()
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `repo_get_commit_tree()` function can return NULL when a commit's
tree object is not available (e.g., the commit was parsed but its
maybe_tree field is unset and the commit is not in the commit-graph). In
cmd_diff(), the return value is immediately dereferenced via ->object
without a NULL check, which would crash if the tree cannot be loaded.

Add an explicit NULL check and die with a descriptive message.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/diff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 4b46e394ce..18b1083e98 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -579,9 +579,13 @@ int cmd_diff(int argc,
 		obj = deref_tag(the_repository, obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
-		if (obj->type == OBJ_COMMIT)
-			obj = &repo_get_commit_tree(the_repository,
-						    ((struct commit *)obj))->object;
+		if (obj->type == OBJ_COMMIT) {
+			struct tree *tree = repo_get_commit_tree(
+				the_repository, (struct commit *)obj);
+			if (!tree)
+				die(_("unable to read tree object for commit '%s'"), name);
+			obj = &tree->object;
+		}
 
 		if (obj->type == OBJ_TREE) {
 			if (sdiff.skip && bitmap_get(sdiff.skip, i))
-- 
gitgitgadget

