Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703519CCF5
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723839; cv=none; b=bzaLxINyf+E6bHqaAflksPDEk7ZZ8r7poTsXKB8UFUTtipMH+ydi2JhA55TJPkwbSw22uus9qptPKD/ztSmdOXP0ZT+qHn5pAfWXud+NE+K32IE6e+TykvdkT1mqt1ggalDJ56+XaQ/a/g3lnZG4uNd8OQiIC7pDicL/EKbSrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723839; c=relaxed/simple;
	bh=+S1zg5XbCyQ7711DWFK4Erle4f9KxWiAuUlp3bpaVVM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rYucKocUMqL+VJqFF4tYx9VFUyHPwBLS/Oour/bR6NUGI20xkOEGRdR86qpX4mqiFdTf07IqiJkQNpz97kD5cAW6imqe2M1F3zTVdCMUMg4KBFP1zNCVz8MleKfqTMAShq3+ve3L+8EN9l+IwP0NSFewk4YLVKWJpIxD0XOEOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIvYVdy0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIvYVdy0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43971025798so5240645e9.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723836; x=1740328636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7FtHLrzUWo+GJfYTEfGjK8nJID5aIuC0/8aOGD2Gy4=;
        b=AIvYVdy07v+zMvTzE3OJknbPyxDIaQxDa4YpZ/hmxYr+htiQFzgdf/sfIjlfieVO4X
         k/t9Gsvw5Rshbz6aJT0jZGVc3pvheA69MR77h+0nDjJ24q0z1SdASWBuA+hmDbrKaqtC
         ev3+rMaFJXhjZKWE+faZU6/Pi02YOA/ShMLZo693mNL+KMuOX8HYrhip77ndQzd4WaFm
         5NA6wL9LNRdlTBFwyvds2cpAWjCbU7578M/BWARNn6KlVYkAY7E+c+zzqBxuuaUgywBT
         TSGNr2FESbq6MXgfK8MPBJ3SU8iYJwC+Y76b+hi7GeKucmcOEZxV/l/QV3LCtAsUdPl6
         iy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723836; x=1740328636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7FtHLrzUWo+GJfYTEfGjK8nJID5aIuC0/8aOGD2Gy4=;
        b=g3yyyqPtnRJxMWMjd5NUStKb+5ozBiNDSsV4YJQaisfYlV5F/Vn0hwjCCc62ZRXJLW
         7zwH7+CvOk8XFWhSgT9GeSRQ2i9LAes63IrusV3YXLP4HOcIR69Xd9jEWzXw2D9wcH4p
         QCwxL6w7Ylow7Q/filSTfMohHXoX8JpTiU9hId8PKoaAKGPgSOBt5VQGwAFvVPrs1Fxl
         cFJpFHjQ1vUVT66b6EsXO1wwpigcTSMmrm202MgxZWY1D1lK04H5CTFg5ZMPApMObs7E
         33Qw4lH6jpMcn8d/Uk0tuvaD8TfyXjPZSnW6mnGctUkK/Tr6pUUulz1HcCAOwJir6wJ1
         IHwQ==
X-Gm-Message-State: AOJu0Ywxs61y9gGFHRS62kxd1/uqc+g/IziW2FsbBS//5YEltpvM4oW5
	krKAZ7AnSLsmOfqYSvEh+1d2sU3j/Z1leqRs0Iy5Uk6GQk2SUhjTpXLCRg==
X-Gm-Gg: ASbGncvWelLb8YKonFoYkM5KhzUPTcuqqnyQFqF4GU0mEu8Bh49nf4Oks/21kAdV7u+
	BDqxjGKgnYuyRy+rFqLZ+K02x5RSVk8AfaMjcLyoW79Oc/GlAkVdnonkqiR0UC45GhIlkHZqlTI
	q7Z8l31korcQfZxzdN8UtXhFPi8SID6MhMRC0L4CCv/mEvZswO6ok2b6FEw28A6m0mx4E5JzqP3
	7WBc82r+Ydr9yla2LghZQ7EELgGpxOVOKjmT9MPsa+Me7GKP3Nu9UgLAKIrEJXBaexEe6XVo9i4
	irQfMJEnhGJAYsy6
X-Google-Smtp-Source: AGHT+IFeavdtdM4q6azxZIdJ5SMJY8LA2wr51ROkRyJs50FjAXVkFzqj1+VFe3jTKqiCQZGzTe+s9A==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr63830295e9.4.1739723835914;
        Sun, 16 Feb 2025 08:37:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d22csm129754885e9.22.2025.02.16.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:15 -0800 (PST)
Message-Id: <89722894c875bc0208945c036700dba74cc0068f.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:09 +0000
Subject: [PATCH 5/5] merge-tree: fix link formatting in html docs
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
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In the html documentation the link to the "OUTPUT" section is surrounded
by square brackets. Fix this by adding explicit link text to the cross
reference.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-merge-tree.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index efb16b4f27d..cf0578f9b5e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -49,7 +49,8 @@ OPTIONS
 	Do not quote filenames in the <Conflicted file info> section,
 	and end each filename with a NUL character rather than
 	newline.  Also begin the messages section with a NUL character
-	instead of a newline.  See <<OUTPUT>> below for more information.
+	instead of a newline.  See <<OUTPUT,OUTPUT>> below for more
+	information.
 
 --name-only::
 	In the Conflicted file info section, instead of writing a list
-- 
gitgitgadget
