Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185202C11CF
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467941; cv=none; b=Ubs1vkE5VrBTR7k+kjsH/O4OLwY1ohtlqFSs4NspHRPO3FVshHPvuYVVSQzv81UlOsUPYRGg02bZps7OkcPkrIV7LBa2qVs3SGL4UNASBfDMoW3+y3L3aedsXMduZkJwbycp3OgtBCxJCg4lfg3CmDlRgqE2qCT1btxi0+wTwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467941; c=relaxed/simple;
	bh=CafkI2UHLTmhU0OsRS8YflI/UPOVcfSyG2eByzqKdyM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tj1b+cwqacIo0b4J+G4iyrs++xJGBgNoU6YpyoR+XuUwiDcBvYBBd9P1vu7ie9V8+QiczLJX14SEMb65u4GjR6fxQIc/yCfyfWsMttyVkJ17qVh2SofCj10GJfaygC95AhNlXwHgos1xiYBPYnf6HNXEBEWGMdFk9XANinnBTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8MhpKur; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8MhpKur"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b307179ea4so10528231cf.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467939; x=1757072739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXEGHqyszOJ/jf+edVSwIK53qbKpq3HsaTlrsdFro2c=;
        b=S8MhpKurFLmr0o/s1sj2rE1kfkU1M78yXL7fiYoLAaQ7NFtlU4pOiRbD0yZA86e2ay
         mopYwyy8UNnCJyJHCSPOVp+Jn90I/mjij1epE0lUUh6jRZfEZFrH/9/WqNYuanEukfGS
         DZqgpjaGDYrUXV0bsvq3yKQZZRjwKZ1hss+8cSNgriEveH4qDBqv6rJgS2d1OdlPfsKv
         /nUCrE+GRBLITjqSL2WgIj84YQ5ggMilMZXVbQ2Ez+SRXicpCdhsOABww2CW+goztwm1
         hhevB7pWiIH1C3QFRMINlY1B+7Mwsqy6bSrI3w/UH/E/+PGIrM9OL/Nl0yLGkMJfazu/
         GQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467939; x=1757072739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXEGHqyszOJ/jf+edVSwIK53qbKpq3HsaTlrsdFro2c=;
        b=KSiod15ONrrKGocxzUprti9lbZJ584XMpvRbdXyF5RLbvlYrU/UM1K9KTrNU9B7Zvm
         rm0uj17gBG/9sxgli4lCDZIda2kAu+OLCHZgxq3FlhAmj8SF2t4m4agW62Yt1etRpHDU
         9BRlpi829ylSVpOk4gexNC8qQRH9rGnJmYEoqIw0c9ovQDF4+dqZBQF5BFB+Yx5EKsKO
         nYv93f71e4z8FoOdFJaKhpzQdRxOgMjnWfSscMSqpzq8VmYUCKEjGLoN+DdTry5mMJ7M
         3epWyioHm3yQ/pjUuoxWQxC6rdE+Uu61K8St2v3t5P+zeN4bk6VKn+NrsVNNvcl8pCJF
         y7Pw==
X-Gm-Message-State: AOJu0YzSGaF0lIfNIAcz0hh0KXrvBA3CurM8cnOQvLyks/mUbMqJbh9y
	UWAGc4HvaxDSsikVzrqrTEIRNbVcg4ksMfKET86jMNAAGmrRBMDnZRpC8GpFXaxuE8w=
X-Gm-Gg: ASbGncsopA0fUpIAvznVNU2CGBJoGAp415s28SuokB7QXrofqLXTiYt6n6pHgWYSXhv
	agePcQXdQEUQiiej2sZ1zG3cvEnYn7dQoF4mD8lta3HIq3l+FAEXfkUY6fQqxyoC6dWYi56336C
	D45D0QdaD2dLxGmjaaPkXejNNYA+x0oQwkwgdHtwnj4VQl7kLKa5sOXKTMoXTSpNIfLzI81++Vd
	nIGRoI31vP1U5mTtx71CVRnGEAOFkgNbeVrmoiLRKNzdUG6pkEQv7zJYdephUkR5kVXWwVzoZRN
	6jJbtdYI02+PwWJkd17CEp5QAYr3fTSH5VJ51GAbB7wLRPbNCPb+cJSQhMtvCXeoryPn1zmnc6U
	E2RARAv/qW2oqAUkTbs4rm+I=
X-Google-Smtp-Source: AGHT+IE/VverfbA8SbWaJAJWfS9eRh/AVCwjSecMmCVPU6honGJcDBL0W015ekemZEm7ibT32Blh9Q==
X-Received: by 2002:a05:622a:15ca:b0:4b1:2df:1e39 with SMTP id d75a77b69052e-4b2aaa81e70mr287013701cf.33.1756467938642;
        Fri, 29 Aug 2025 04:45:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1643ac5esm153025085a.68.2025.08.29.04.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:38 -0700 (PDT)
Message-Id: <23a738981abd2073c70bbb5dd36eea050065e643.1756467934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:31 +0000
Subject: [PATCH v2 2/5] doc: git-checkout: clarify `git checkout <branch>`
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

- "To prepare for working on _<branch>_..." is confusing to some users:
  it makes it sound like these are steps that the user has to do, not
  steps that Git itself will do. Reword it.
- Use "changes" instead of "modifications" (which Git normally does)
- Mention that `git checkout` will fail if there's a merge conflict
- The current explanation of `You could omit <branch>`... is confusing
  to users (what are the "expensive side effects"? what's a better way
  of getting the same info?). Be more direct and mention that `git
  status` is likely a better option.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index c86941ad53..4de3ac6680 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -28,11 +28,11 @@ DESCRIPTION
 See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 
 `git checkout [<branch>]`::
-	To prepare for working on _<branch>_, switch to it by updating
-	the index and the files in the working tree, and by pointing
-	`HEAD` at the branch. Local modifications to the files in the
-	working tree are kept, so that they can be committed to the
-	_<branch>_.
+	Switch to _<branch>_. This sets the current branch to <branch> and
+	updates the files in your working directory. Local changes to
+	the files in the working tree are kept, so that they can be committed
+	to the _<branch>_. If the local changes can't be cleanly merged into
+	the _<branch>_, no changes will be made and the checkout operation will fail.
 +
 If _<branch>_ is not found but there does exist a tracking branch in
 exactly one remote (call it _<remote>_) with a matching name and
@@ -42,10 +42,8 @@ exactly one remote (call it _<remote>_) with a matching name and
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-You could omit _<branch>_, in which case the command degenerates to
-"check out the current branch", which is a glorified no-op with
-rather expensive side-effects to show only the tracking information,
-if it exists, for the current branch.
+Running `git checkout` without specifying a branch has no effect except
+to print out the tracking information for the current branch.
 
 `git checkout (-b|-B) <new-branch> [<start-point>]`::
 
-- 
gitgitgadget

