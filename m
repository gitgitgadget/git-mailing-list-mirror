Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC633C5845
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683603; cv=none; b=dT29ppDGOOO5gbj2aQtEGqCPfuwou32jH+LtTYoA8+e8A6O+QObfdUfP9SHmVPo3MGh7WXL6wI1FkZRr0QppHs7Qho93HO1u4e2bkSQ1Wxz+t7inlX4uoAn6HRrFJ722Y/o29vh+um/GKMCBzS9KYxHiDzHFI7s8YvAW1kUaY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683603; c=relaxed/simple;
	bh=G3xrOMLIxY/BCPkNPkpMnEY4KvWc6A+7+E1RhUUTHtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mSNYeZJidH/B5np8hUUGqXSh5oalwxEmvwkGovMawkqMy85PrxlsK0tSwoxqlsW3kBJKy00QK07CcnAA635AHD8aodYGWeZ7bbN4ZCGe6VotFgJKUnO4czq12eg5JjljSZvrbbBXFD52cA8IFPt6VCCdGvU9u8TivxRVx8IDsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLQEUitY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLQEUitY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381065a7a03so793096a91.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683583; x=1784288383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ips2cu5ygyvZZho72b2KYFG+qlHrSfTJ6Q6HHJcWssQ=;
        b=mLQEUitYkhTBd/ehX0leN/H82AD5wyRLCxOlOWd4Dls2P5V0HXdRPWswieQrf0waL0
         4GhZ01ou8LMmeFUjQa3U3pshoIHCzkP/biIT6t6Zeswy3tWfBty1QTK62FRjkXI4t9+I
         lSLMP+aG+1Smj4jnK36g5RGzwwvJ2gK5LbBKj6hAFCLgqy56ys43RuBcxUZan0ErkgBY
         jyDU/3Vtdqvo2dWQEekf5b+o29NmbAJTsyyrdCJNFvAzIknXkd225eBHBI6Qp3yNbq2U
         dwZyBoW31EY8poMdOBOMzkEm0qm5iAFhSAWJCKebnDQTKzbxOYhaKccPEBgTV3QZAeIe
         u1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683583; x=1784288383;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ips2cu5ygyvZZho72b2KYFG+qlHrSfTJ6Q6HHJcWssQ=;
        b=ZJsiHVOrYsftKQhaOU+Z6s/HToMjjlCjHZjd34rdJHxNdjPK3RUjQ4F2QWTadvcBdZ
         c8NyJ2nWTWbXGOuB4AJAf/JSVaJcMqiJxhmGoZEOC51OkTndxJVN59R3IxsDo9Ezpi0p
         +P1gFDX5D2u7t1G2fL33EVRgYMSDrGrlMqizxe/peJKy9EGKQpp9LXSNfHgCqp8rHtad
         Cpl+w72XdvlFahqiDj2aE5DzDvAZbPl8u/WAZtd0uKSoqkhJRH7JEHS1UGLqjLBv9EcX
         HB7kncBli/JXfVRiKcjj3rRF4s95tvYZmOrWSxyQRHkkbvdWAjKXyyjkX2PvgZ2G3XEj
         4+iw==
X-Gm-Message-State: AOJu0Yzn91+f1k/tFAomhHwy6zzUaWjw0I9adF6x5r2/1PLVTnDmv/rX
	QtwDdqOPs7TX64P8BywKDImGKqm6AGvYgIl+PZ6e/soM+twhOiFgUshChGNnDLlS
X-Gm-Gg: AfdE7cn8V4LZRdithOsbX5olnytgtwg470wpgXwoAgilTffYoOgac2Zvv2KzuG73DFT
	jg3Qp4Tn26upUcF+Y4d/9OhpEBnpUTi1nF68Ce0L2XbEskNih/2xCKbb3uyjFnnKClu31XYPkvc
	mBT3iRsAjPJKOYxcTDtYpyyLxWUNSfDBPA5d8y2g9RlqIZp2tec4n58b2UREiWikXrqYg7WNgc2
	oKEWhSKNIr+hGeY0zkHmKeyl67kZde08SlRPWMp41tDB6ClUv791ns6IQtdn8Jhjtk7mkntt+UY
	5MzrXoMi1R1WBUBPy1680rzjiRZsgcR3vaD3umIAm6OtBb4PX7uyIEKljPaFutAC0wZo7tacHo5
	vW2F1feCiUY6hh6n5ms1KZwlI2lVvUPfQjgK1yKuTHG1UTmLCsiMuTA5hhkCtJNl35mT1oQiXEQ
	W8Z5z+bYr2q6ME9BMtnih3d0o8hYc=
X-Received: by 2002:a17:90b:1ccd:b0:381:22d6:f7a3 with SMTP id 98e67ed59e1d1-38940732374mr11858402a91.18.1783683582744;
        Fri, 10 Jul 2026 04:39:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc5820sm2517403a91.10.2026.07.10.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:42 -0700 (PDT)
Message-Id: <4fdba0542b3d643affe32ec35f27fdbabccf54d0.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:26 +0000
Subject: [PATCH v2 02/12] diff: handle NULL return from repo_get_commit_tree()
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

