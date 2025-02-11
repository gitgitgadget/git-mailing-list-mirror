Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272726563F
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307719; cv=none; b=oiRCZQj5VfNAvNAaj2YI+o5ZHruXJN2MkWEKp19wqMUeUv2xNcj5OJaU1RgYDFMzUQX+uSKbCdGj7YkpdKIJgV1fC6s8M/jLtbKLVCDI7BSqaytnairsLAXrBkJNlZS794dujXvme8Mvd21RK4NKIm7XFUijQASxvHMLjnSrjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307719; c=relaxed/simple;
	bh=1t5VtcitBofBlcv7P/tw5vGznwNY+yWQqEbhhnbEPCM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=COb3gfUgfj5ogEMIPjvB2Sn/y2CGnm6mXrEL6NuYZX80XuNIhyaakFLL4VqtwG+eNGVntcdkQak9bnuVPDhmu0YF1YkwRAPKDvXPWN+gkFx/UhqD2T5Jas8DhK6gminZDyBe2UwOTSNMHGfYKPVAz3cxjEqGKo+iAXyJqWfH3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKCR9Taf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKCR9Taf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4395560cc13so10300795e9.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 13:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739307714; x=1739912514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9s/fvN1TqwNV8SuTVjp84xzi8PTMNSfZqzBMI5BnNJ4=;
        b=SKCR9Tafz0jVRq2tZJf4Im2Mf2W/H/cv0/br7leuOSIMjntmLDXbxQqzrMH68ZReXj
         5WQ6x5UqCWNa5kxq7c+zQ6LsXL/L22CuUd5ASmBCeSSeW/lDUDSPv4U9exaT4P03GeMo
         bkvBTnru0FH1SVyde08bd/4kmnchDxzAhSvu7jRh4s/HCYl+yxwDyuScnmY8Eb3J/GQN
         sietrSQUdz1ssG6EXjD05PNRCHTHesp5z4PjSIGWOYxezlHM+jQstH2jf+i0ZL5utWLK
         xGhOh20dcULz7iYc/Dx9vFGpETCr1O3B5eXifLcxRyqHbshyykJ5Em37iY+C/igcdj9S
         hRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307714; x=1739912514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s/fvN1TqwNV8SuTVjp84xzi8PTMNSfZqzBMI5BnNJ4=;
        b=EN2O2n+Ct8nIjL2D14DID2tKlDOTiGD2w1tHapukx+Uvt1QENn6BX0zMTL84257WaS
         NTxbmWOxszYXXVduZG9dYLs7OLJm4TIeBQy8C/eky7VBXhKqBPhftDoonhHeX9LN1oyZ
         U8pyRb7UUtjSnt7wOwAzF8/d31FMIoFD7yOdj3YFpkwhSOkRbaq6+SfLBWJQbd8flsP3
         Nt3irYp2leID3A5a1y2sEkol6OMRgwc/OWmc8r9SGN9vB+urnmwe/Yam4Nd3ybPzWcw1
         rR54vBxSjnuGTH/yzx56k5NHpvSgWKi3lM7pB8CQY9gGtYt3WVMvubppjLPR0C/C/AEq
         E4Pg==
X-Gm-Message-State: AOJu0Yy3pbOPwtsqEreBx28jwgn/HxqM58IS6kcQ2ugWYuSt0UpqosTI
	9RCUF/fxCyX8A/1h3d11oGIDtLKNaDEAHDYEHEUI4P8M7CSFq7IqiH+gYQ==
X-Gm-Gg: ASbGncvMmWQ25b4LVGHsuRCMrF5RcGm0ZFS/0R0ikC2P5tKl36CqTemvlkkQhNMLIGA
	7Om7qdKhXVXXVU5LJLxY86COVDOo2Xd6Gqkx+lyDlD2e1cqkTzcSIyiXZbT2kIoUYI2pdQkzeYg
	H2/yO8btwVxwTLiH0AD4m5I4a0KQzl29H1oqyRIPwXY8vyyniYad0hOPrhXcROhBxWPmm2cypP5
	1VSDBdMVjR7G6a+nSKnAVA/pzwtHCZLaraLOGK9ARVAW4aMot14cJHhVQAE5mEx61Y88RE6SD6w
	3tz6q1mcBovYnqeV
X-Google-Smtp-Source: AGHT+IEReHvQv42crmcc0rzv7nvNb2dHeTi5OSPDIsRYtu/r689ca4orP8Mjwhmv8n1S4hqfwkLWKQ==
X-Received: by 2002:a5d:468e:0:b0:38d:c616:ab0 with SMTP id ffacd0b85a97d-38dea29020amr319283f8f.32.1739307713677;
        Tue, 11 Feb 2025 13:01:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ddaf333c5sm7778913f8f.36.2025.02.11.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:01:53 -0800 (PST)
Message-Id: <pull.1861.git.1739307712372.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Feb 2025 21:01:52 +0000
Subject: [PATCH] doc: clarify the intent of the renormalize option in the
 merge machinery
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

The -X renormalize (or merge.renormalize config) option is intended to
reduce conflicts due to normalization of newer versions of history.  It
does so by renormalizing files that it is about to do a three-way
content merge on.  Some folks thought it would renormalize all files
throughout the tree, and the previous wording wasn't clear enough to
dispell that misconception.  Update the docs to make it clear that the
merge machinery will only apply renormalization to files which need a
three-way content merge.

(Technically, the merge machinery also does renormalization on
modify/delete conflicts, in order to see if the modification was merely
a normalization; if so, it can accept the delete and not report a
conflict.  But it's not clear that this piece needs to be explained to
users, and trying to distinguish it might feel like splitting hairs and
overcomplicating the explanation, so we leave it out.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    doc: clarify the intent of the renormalize option in the merge machinery
    
    cf.
    https://lore.kernel.org/git/CABPp-BGQ0pc=AZ0fdXcqDbhMLbm2xBvi71g0mXAVDagz19NkEg@mail.gmail.com/
    and the thread there

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1861%2Fnewren%2Fclarify-renormalize-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1861/newren/clarify-renormalize-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1861

 Documentation/config/merge.txt     | 3 ++-
 Documentation/gitattributes.txt    | 4 ++--
 Documentation/merge-strategies.txt | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 82554d65a0a..f6e50542baa 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -69,7 +69,8 @@ merge.renormalize::
 	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
 	text files with CRLF line endings, but recent ones use LF line
-	endings).  In such a repository, Git can convert the data
+	endings).  In such a repository, for each file where a
+	three-way content merge is needed, Git can convert the data
 	recorded in commits to a canonical form before performing a
 	merge to reduce unnecessary conflicts.  For more information,
 	see section "Merging branches with differing checkin/checkout
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e6150595af8..9ae81173003 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -701,8 +701,8 @@ where the attribute is not in place would normally cause merge
 conflicts.
 
 To prevent these unnecessary merge conflicts, Git can be told to run a
-virtual check-out and check-in of all three stages of a file when
-resolving a three-way merge by setting the `merge.renormalize`
+virtual check-out and check-in of all three stages of each file that
+needs a three-way content merge, by setting the `merge.renormalize`
 configuration variable.  This prevents changes caused by check-in
 conversion from causing spurious merge conflicts when a converted file
 is merged with an unconverted file.
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 5fc54ec060b..a5dc95a3783 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -56,7 +56,7 @@ ignore-cr-at-eol;;
 
 renormalize;;
 	This runs a virtual check-out and check-in of all three stages
-	of a file when resolving a three-way merge.  This option is
+	of any file which needs a three-way merge.  This option is
 	meant to be used when merging branches with different clean
 	filters or end-of-line normalization rules.  See "Merging
 	branches with differing checkin/checkout attributes" in

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
