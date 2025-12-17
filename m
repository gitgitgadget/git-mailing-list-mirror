Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF8355810
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981137; cv=none; b=dqdPxGrtnCRAuO0ukd3gOEujEbOYEEgS6YWaaWZWjVb3zNOiD3dARhX4ZXUIjYpouvoyHUUTLYJXqLpqxowmrmthSU+03qLmNi1kBJXMcvyWNAn9go40ZB3z4HseA7mT+tOAIqYHxy7VW0zTdmcpTVSQxq0pHH45VO9AJUVSG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981137; c=relaxed/simple;
	bh=NJLyjStT8CtJY7u3JKMc79pbawme/rAuvso2pNsfeAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vo7fqbBSJN/uFf6QVYIjdChvLF7OTH5nrFTIY/+5QVJ7akqehivE8KTanpN8M1UQqhsrTZIeEd6jAeoV6s0vpdFa4cfrCN3mCH8ncx0GI808iEgz2Bsdiug1y1oGPq02gRQOnMuoVhKBX/7SfpdIib+V7lH/al0VCgCXRichTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfuTtyor; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfuTtyor"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so4207114fac.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981133; x=1766585933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=TfuTtyoreQOysnhYN/WwdLGP7pjgQ1URe9lA8J2igumSNbvUvFjwvEfdNTsdsLP8eO
         T+WWRU+awMEYL2nKjD6mbUgt4YG/PhjEOj+zbqIWv4qED14V7Asc3mMB6fOfpp4sIKTG
         0XMp7/skYwU7PA3PQT6+P1fw/W9jWdrteKsuGM5ITUrDU47UNyjtkhBmF9pvJVM58tue
         PViG36fNb7FevB+LO5Pzc2SniGEzKT3C4cnRKE8UbWAwUIxIXtnzBz9eOB8mecEGsKim
         YeWgHSk8mA0Y7q2Xt6FgiCXHVK5VUBncVqZgiXvfpXVrwRWnZkd/GKa1OMs1aqHJA9ni
         w/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981133; x=1766585933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=nZvt8d6DshFvm+h79coKqlpv+xrAkwVKFQpLiNHBto+AtZFVwu+ecAq+6pN78966zu
         WABhh3+blCl8iANUMmoqYqNikUCacv3d3UJzX1N+K1hpaMJwVJBvIEQyGFX623st561f
         n9meU/44406bd+riztUKQmC5nhfmLup9xBihPJWWiPXZJ7D9qczhPmKCBiJ4k5ktYnQq
         C1gopNZvKlPgCEe0l5CLin0YmCVw773rFnDP9jxH3vgLjEsoZo+Rlhh9GIf3gw2W9eRV
         +/iFqgJ44eAA7ZkQGP6ydplUBQgQYyT5fND5/vxlnwyPxlyvrtluU7ovJ5y6BbEzjyug
         4rPA==
X-Gm-Message-State: AOJu0Yzcge0Cn+omc9uih0X1lwy46Ibo9/XDBCBKjiUqTOrO3CclOMls
	uITcQlk28pdUQ47OGX9grraQD6qx19mtXIG/7LMc/XC1SvXLDyd/XA+dXGYngR5XHnXrmw==
X-Gm-Gg: AY/fxX5qkZ7wlw6ioSDsvWxUaDAIq/hGUy1a1oinkKDmIs4T5NBlHdzp+Nz2Wk92u+l
	euwdUj9svleXw7jDSLi8xRqQDL2Vw/vnZo2RnQNL1H+8vsU1kgPdmeFjCsdqy9Jn7hxCUA9oJvj
	Ho7A40tB6zq3Gha6hTWTYhOXv1OIs/DXgULtnhfxrDEOTx1KYg5K9U10/ix/peMj31pQDzmFz6M
	OFUAz8/5dw8cnrBhFGMHItNjd28/mbDGF4QOHh+8T9jtoXnjGFEtAAI2Lhn7+ZK3b3XWN5hZk90
	lIiToAfn9WOyReugbSkZMhhHncRoxcwiw92Ykz9jioCReJDkqyLu9ST3FGw7j0coWGzWaz91fOK
	wzuHQitkbgu1utP7kjREHtqQjMFGAoygoeuCX29lUite43bhHKG5b5NOotyzK4ny6DoR4Qi7V8C
	Hs9ap8GKy7PydE
X-Google-Smtp-Source: AGHT+IEtRBpwE3nW/Q0AinzCFQ7EpVLJSXOi4VJJo+TZe7B0PUoibF5kurqTZCRvcBW1Ixu2MsPeUA==
X-Received: by 2002:a05:6820:2296:b0:659:9a49:8fa5 with SMTP id 006d021491bc7-65b451b8092mr7018674eaf.30.1765981133124;
        Wed, 17 Dec 2025 06:18:53 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f2a9bdsm11654982eaf.2.2025.12.17.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:52 -0800 (PST)
Message-Id: <70237394c64101b3d70a1d31bd4a763997474cb1.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:40 +0000
Subject: [PATCH v4 04/10] t0001: handle `diff --no-index` gracefully
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
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The test case 're-init to move gitdir symlink' wants to compare the
contents of `newdir/.git`, which is a symbolic link pointing to a file.
However, `git diff --no-index`, which is used by `test_cmp` on Windows,
does not resolve symlinks; It shows the symlink _target_ instead (with a
file mode of 120000). That is totally unexpected by the test case, which
as a consequence fails, meaning that it's a bug in the test case itself.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 618da080dc..e4d32bb4d2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -425,7 +425,11 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	case "$GIT_TEST_CMP" in
+	# `git diff --no-index` does not resolve symlinks
+	*--no-index*) cmp expected newdir/.git;;
+	*) test_cmp expected newdir/.git;;
+	esac &&
 	test_cmp expected newdir/here &&
 	test_path_is_dir realgitdir/refs
 '
-- 
gitgitgadget

