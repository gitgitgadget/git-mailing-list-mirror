Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858912D640D
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467943; cv=none; b=dH4jdWbIf1lj0PefR5udNnWYGyLWB+1OQsYGDvmYFxAl3KhvWWnNGcHBKDzK8qnysGxLrDr9iCvVQftfid7oirSJDdT8yMgsEl4aAI3p/ryj8emdjikHputPKRhHRVJW9GnAfLfhkawcebk1+sA9TRzL9JIi67ZMGqZeZyjolLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467943; c=relaxed/simple;
	bh=sbDbCudXjkJEyu3PRfiPRQcun2YeIDgsheJb2vpOuDE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N7vbXB3gvgK3yDoDpQe2AstjobyD5Txk0NeHrfeF5JgQWfrPgZnZiIi39QdMkCn0qfjAie3W22AskhHD9qHa6I7Gcu52gwDuX8FU9Qbo39hvGKnwm8PvA+wZv1LprdYKW3EDIzAAOv8iYDW8El48rR1dzfIU60D1NW4IqEteKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzwhkFtk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzwhkFtk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c58e29so31868091cf.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467940; x=1757072740; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnVPDucSxogL50V+HHD5/V0wXJFlu0jAPqBudj+Dymg=;
        b=fzwhkFtkjOLwTbqrz1QGwecCgejyixJfBCDF3FB3QyhSTMvsKKWpTwcP3oosjbV9AH
         2N8H7CpgJ8/06Pjf+cw290E1m1aMaGxeQFMrJ96tJ4PNvflCPh5IqKE6/1eb0sbYHp7x
         gM/ZNx7CBVv3XUAyl6HSRjcjiU+XSX1nADPjjL/ZSh3L6ERMzHM/L+T0SPyHAIEuF2TX
         vvW833HolVto6zr3SCXLgokJ8cFBXX9vMJf1CURZ77baVEQH/HDs1anShZp6emL2+cWJ
         EeHBhAEvAtkTLmaoGU4XALoCds9QwlRFHe3m9ujoiyidhWt0BV/t0XXhLfffyp3wUmoA
         s5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467940; x=1757072740;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnVPDucSxogL50V+HHD5/V0wXJFlu0jAPqBudj+Dymg=;
        b=ZO1LgVstc6jJq3dlgAEYcEsfjI/HTrcD1VrGnb13ayLOcDahSBF144+6SFEtS6mt1B
         qZjI3BDKFsH//g8jPxroyKXjQlG0+mRLIrAIhF0qrwjQ23sEsOKxE1rgSzHBywB3ySiJ
         VTUkSXJ8tJ3JeOUAOyyMi4cHYjyOmQLkaRRv1XZULaEaE+yfwoT8OD3hl/yywI0zfybo
         fIIcZEmKc8LVsuZSPYhnlCVbhfeR9dx90JvHzug4uipUit8/BobUvG5w6v3xNY0rF5F9
         /zyHqoQifl31j17xg3FgRuNv7TOhI3wduU4c13xrqu3dUc8FsPUz6g751C0tRqRhg2S0
         8+5g==
X-Gm-Message-State: AOJu0Yzq7jk2DRUaY0y7qwNp13uMDLqwd/6G79KEO/uSDU37UTFAoIeO
	pV4g7l1GcUGwpxR2r3K4sLwu8oqnRXqAu+H28JhNb65wYe4/+lV0qhKQDp97r3Ixp5o=
X-Gm-Gg: ASbGncvpmKpu2d6MeaLMb/ukUk32yt4xKrjPpdi7Ayn1iXFEyP3to+BRa97ySGLo8pU
	DYmQaxy+8fmJ6uzHStDfecff+zlL20UAs1iVvNZJyhHjH0sXXJPiWJXSxjkUHbHJN8P5x2rbmTX
	X1XgqG719qJFjrqMNK3Q4/v2+Egq72gwKwoiQnmD0vByKARjTUzCXmb14e/y93L86hWGTmNhXN9
	xcFbZzozsYv8ztvkKzub1jbzFDUjy7D/d+BMn4WiT4kQ4RPn+rGh7JNAGWDAo2Ix6L7iVIwENbV
	NTaNBKZb+smg4UXcETL9jCdD6P+8J1MVvc1eAY9szuoW5BGb+OK3P+FwxGPu1NM8JzESKLunedm
	vqyZcxH0R3aZ5uBf/QZM0zb4=
X-Google-Smtp-Source: AGHT+IESaXd55prAVlQhxnyjDD67d6myGZ3cy+nUsXXIMBXFhskOxzAYtbnnRUXJrqCTerGABI4peg==
X-Received: by 2002:ac8:59c8:0:b0:4b2:89cd:c1be with SMTP id d75a77b69052e-4b2aaa81ecdmr395219691cf.16.1756467939672;
        Fri, 29 Aug 2025 04:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6abc60sm13716101cf.37.2025.08.29.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:39 -0700 (PDT)
Message-Id: <360051d2a656727ca42d489de81ffec9b23a6386.1756467934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:32 +0000
Subject: [PATCH v2 3/5] doc: git-checkout: don't use "reset"
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Many Git users don't know what the term "reset" means. Resolve this by:

- Expanding it into its definition, in one case
- Giving a simpler but still accurate explanation ("the branch will not
  be created or modified"), in the other case

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 4de3ac6680..e4614674f0 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -54,18 +54,17 @@ to print out the tracking information for the current branch.
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
-is reset. This is the transactional equivalent of
+If `-B` is given, _<new-branch>_ is created if it doesn't exist;
+otherwise `<new-branch>` is forced to point at the commit. This is the
+transactional equivalent of
 +
 ------------
 $ git branch -f <branch> [<start-point>]
 $ git checkout <branch>
 ------------
 +
-that is to say, the branch is not reset/created unless "git checkout" is
-successful (e.g., when the branch is in use in another worktree, not
-just the current branch stays the same, but the branch is not reset to
-the start-point, either).
+that is, the branch will not be created or modified unless
+`git checkout` is successful.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
-- 
gitgitgadget

