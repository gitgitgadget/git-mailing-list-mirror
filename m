Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11B2853F2
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666672; cv=none; b=t10m76phbWZGIluTqrEn+7ohyUCbsWQHWQSwpku6Bw5Hrqga79VqJC3gd6EVPcezTZiq2hl7Uvi4Kw06okMQmYOrybXkFryCr0GuaJlH2ls9NMk+Q7lOXcyXe1mYkLvDiuycYH0qme1METHVKAcCANEZOE4KhbRVFQ4tvL+HFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666672; c=relaxed/simple;
	bh=/8IydCfQesAifb1dCVLouKzMidUgaVqEAEu1/3aNN3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SFNi23+2lGTtcaOHMovLqgrP/cxzzHBAjGQBQuZR5pIl12b+QNUC8r/SJvgb7ETA8odrCyYq/ZxfA+EnG9jwKukG9GedrhDgdmR8xT1L3VG8JGqtxeZbyviMmaM2O8T05eDKq+lOEr5EvAVDvBTK1DuJYW8h0Fyi0fYE4KQPcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKgnICue; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKgnICue"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b783ea5014so1173545f8f.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666667; x=1755271467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdcTKFGW9wM5JM9mTsIFggW1BElFRVxkiqiNsfxaPG0=;
        b=mKgnICueZTmWrAAXU5WQXYf8JMsFppXmVr/IRj8qUCXxlGvv2KbSOS9dhJBxvAfPTp
         58YOD5+UiO9UMMxaWqthiX8lXRONKPl3zCzY9LcHr7wcwbhFMk+5Jn+iYl0kY8EsWG1t
         LsbAygoxzmCmlw3C5Du6KiiQt+K4wULzMx382P3spPS43uBlZBbdb6pEfAz2iH1jT2qR
         Ugwla1qCmeSWn0SRLmYmreP8hGI+xrO8V8wegL8lnE2gWHrQwhoVHndhgORDc4jgDmts
         uN2L4LbQQ3D9HRjmvZNgNLVDNQHh2eDZtOzCNkhAfUixCxKKD6uAAnQkcMPtSQqpGaAz
         BxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666667; x=1755271467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdcTKFGW9wM5JM9mTsIFggW1BElFRVxkiqiNsfxaPG0=;
        b=l0cfmShx9r9rZ2cbQ+5JrsVg8Yt/T8NpAprgA/RGd3xXNOC/5QesMh/AWjuPV/5k6/
         f/nM/kIrU5RW8J6DphWbuWmojCqmEUHB16AQvxR9eACx9sUfLVDj1gx9i0SugNNZzYqO
         LBXB/9+SAhOsZlP8sCobMo8KFvATHj+6Y4BFgL3LAXMZBQARfsgA1aDEFVu1uBmCf/4h
         GmOQTfGsURqRt5gr6ZmrFMVaGUURH9Dl/pGdRg7Irk8Z6IibEcNT2JIECeJO51JS5lHK
         91/M/VM57WTPNmQEjaBKtfnULdlIBNbcRRcS3nw3WP8Jr9aBVfs/Jm8iL0Fe4rsBQJkc
         LfOw==
X-Gm-Message-State: AOJu0YwDlZg6zPs7oXQYFonB5IB6NwJlKK4vw3u/+0KLT0K3uUfFFtzO
	XKgRNaAF6e94nyFM88T6nUD9xeeDzmkwpLg5VCC6qRT/Epm/uffuMLukZH+DMg==
X-Gm-Gg: ASbGncvTacTiHRaMR0ttTOPvWpX4lXrTL//3XvqOfV/wJFZ3nOLQv5wjZ4DTCuOy2QU
	COsvXeah4BrmQGa6yAABdJizivZ66s0UP69o2mBXmlZupjZcju1xNv990DmiXuv6OgctKDygPNc
	Qa/tlnaOm2nWpNHem5ZetZ0yZL0NhYw27xYetq5LHrm7XWDqJ1iz7FM3eyqqmYV+HM8dsgQtmi8
	pc1Ghq59WCMC7NtrpPKbPjLsSITrjbPfjlZ0FB6TjGWQZGUgP/gkZ0Or47/L/q7uHyJhvacPcB2
	SE6zo3dIa7KkbzD6+J1pMUnQa5hvoEIPtCRK0LMm4DZ3rFeeQ9g7F2ZGhWhyXj78f0S//9chZGE
	Sg66xNwPvum+GuwpTAlWmyGU=
X-Google-Smtp-Source: AGHT+IF29mw/UH8JsYdkxTDfUeXCoDY95x0V11P7i5hBfYWxOzxVa+tuBKSqjCkfYsVjOgKZsG3ERA==
X-Received: by 2002:a05:6000:220d:b0:3b8:fb31:a426 with SMTP id ffacd0b85a97d-3b900b6aa3emr2843876f8f.57.1754666666854;
        Fri, 08 Aug 2025 08:24:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e1cb7deesm20483873f8f.2.2025.08.08.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:26 -0700 (PDT)
Message-Id: <ac3a91c04bfa5ab2b0e479c0bfeb2ba275fe1d56.1754666665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:21 +0000
Subject: [PATCH 1/5] doc: git-rebase: start with an example
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Start with an example that mirrors the example in the `git-merge` man
page, to make it easier for folks to understand the difference between a
rebase and a merge.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 46 +++++++++++++++--------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..fee73623990d 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,26 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
+
+For example, assume the following history exists and the current branch is `topic`:
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+Then `git rebase master` will find all of the commits since `topic` diverged
+from `master` and copy the changes in each of those commits on top of the
+`master` branch.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +78,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original `<branch>` and remove the `.git/rebase-apply` working files, use
 the command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
-
-------------
-          A---B---C topic
-         /
-    D---E---F---G master
-------------
-
-From this point, the result of either of the following commands:
-
-
-    git rebase master
-    git rebase master topic
-
-would be:
-
-------------
-                  A'--B'--C' topic
-                 /
-    D---E---F---G master
-------------
-
-*NOTE:* The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`. When rebase exits `topic` will
-remain the checked-out branch.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget

