Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7321DC9B1
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467940; cv=none; b=bksj0p4l7TMPmiAKM7GcUCv3m/SORY1/kaRE199gObhBdoO3O/418JXdnsolGHOIoM+bGL5Vq6SfHvu8pnzYr0zDvvexH1sDB7XZw3ZUWebUbb7/7ggTjN/gwXbaLZ4co8yfqOLBwST6z69KNb4YburM5uusj4KA0QGrhrGQMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467940; c=relaxed/simple;
	bh=yOpgHgGqHi5+31ebHGJvvDxtWO+GGaIZbNH1494Ymz8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o6C/SmkKb/iYtmWkhfIbaKlTDSnvYNM+6rFdhpeaUtMzxK/UqKivS1n+9mkZkTIRLmPZ7n+Fe22MkJdmMqx0Hp3tuAAjkeBwt6VWWAQU3GzRjvGQYOYDewlwohc9e9F0tv7X9ubvjwZZzYZU15ns5KUpeCvbXlPq6W7p9SzfMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK2vNCie; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK2vNCie"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109914034so24147481cf.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467937; x=1757072737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwpTfjKX/XQAOUiAXzdOm3y1q4IEQYWBOttgoYBtU5Q=;
        b=hK2vNCieC3hfEXQmTJneybSqRpRDIeP5RgausRg0ce41gY3xUzub3XWys/9RZ/SR54
         TJIPTaLNjS68mHpVQgSoSZM4PzopVomszje0tiLd61JGA5Rslfstp9wonNLELSA2IeUG
         0qw9NFXuKHUlzj134RFN9y0GSIBPwkrGuWLCW/AJrPYknl6H2V87nzZ1/tPXxpbBQbLx
         wIiCmkZ+Ri71TiB6d/QyXxN/pGz5uyscrvK3X2GToN0eqvr9Ut+RgoxjOfBpK80lykmi
         Iz8pZSSEfG+kOnjwDyysNuI53H03rU0aPrkgrp8LWpc41A7J2+6t5MUiTujHDRsPTy1H
         cYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467937; x=1757072737;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwpTfjKX/XQAOUiAXzdOm3y1q4IEQYWBOttgoYBtU5Q=;
        b=a/u7kw4ASO+wtCD1GjIpvrTLsEI8wgQrPJZOQ9vsilRHs+4Ibdejc3psEHwrVCRfUT
         ZgbZQs0hsG6TCrt3Vt7Ir8KlKzKOAaddrN9Pdi+Z5nDMDjROIba/tC6m3X3mh5XCWN9c
         yeDEGzGuC17q12Q7fDRCP6kspElS+/E747cLy1HrR6ZsLaQaOcpxZbulqDouD2YyV9Bl
         jOTPNNYHrCQauufYtszsWSjxdWhJHNHXPbRpL1TBSRUjmbXEuUe7sC/S9GLAlh+uytpB
         IX/Rc7ebhvC09wkNoJOZYt/XYAAfN9Vr6T1vpwwEJNn7+F25e3SWgXIJjHzoCwV7/qaM
         3fqg==
X-Gm-Message-State: AOJu0YwWuRQYUJYf+Hbs8R0USu651kuVGaYSM5QWR3mxm40NlFPiuEWm
	T7e/SyG+jy6i+c6vkbqvv7A5qU1SfNWHk/9x6W9rueug7JCwyzDFhsps8M983DZB
X-Gm-Gg: ASbGncsA+sruDVl7NrA2Z63tPZ10sZxOqhQohXFxYDSoUxIkHqNZ91QOQJiqErJ7/Ud
	WMCJjm+KbEdV3pd3b3rfJ4JkNh37JXz6BQ2ayXcG9R3jltT8zcJrPrQ2mFXlry9upcojqUg/ZbV
	qEmtiJOqy9c90yzOW63/NMVIq2GcI4xxQkGg3fiPGrsSRZVbwKMysyuN8iKWBvyL1thVd8SoM8E
	3qKOStBxCkPJ8jCHsqvAzGjjWf2HcyDlkm3R1SL4t9sUExvIos9PPVYpfCmApi3cGVpxGFQaVty
	tG/qqDuDGBShEWAJjQ6gD2MEd6QttmL9m680JGWKZln9F+aFmeLpmqSrOBcIfdsOhEIeCUJY+sQ
	nb9CUvgmTLCcnRunf8X1ak3UIigzXXNVZpg==
X-Google-Smtp-Source: AGHT+IEEawAEuG/TlyDwZqKVXTvIAFoqWyK9+7LCMH5GKTy0hD8SYH9CbfOKaLFgxvSbjp/kfz+OLQ==
X-Received: by 2002:ac8:7e8f:0:b0:4b2:9beb:1986 with SMTP id d75a77b69052e-4b2aab76ac3mr310951271cf.82.1756467937541;
        Fri, 29 Aug 2025 04:45:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc14849559sm155463785a.41.2025.08.29.04.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:36 -0700 (PDT)
Message-Id: <48e7f230294e131007032ef8850456a5c0493ef9.1756467934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:30 +0000
Subject: [PATCH v2 1/5] doc: git-checkout: clarify intro
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

- Many users do not understand the terms "index" or "pathspec". Clarify
  in the intro by using an example, so that users can understand the
  basic idea without learning the full definition of "pathspec".
- Use the terminology "Switch" and "Restore" to mirror `git switch`
  and `git restore`
- Reference (and clarify) the ARGUMENT DISAMBIGUATION section

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 40e02cfd65..c86941ad53 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -20,10 +20,12 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, `git checkout` will
-also update `HEAD` to set the specified branch as the current
-branch.
+`git checkout` has two main modes: it can
+**switch branches**, for example with `git checkout <branch>`, and
+**restore files from a different version**, for example with
+`git checkout <commit> <filename>` or `git checkout <filename>`
+
+See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 
 `git checkout [<branch>]`::
 	To prepare for working on _<branch>_, switch to it by updating
@@ -511,14 +513,17 @@ $ git log -g -2 HEAD
 ARGUMENT DISAMBIGUATION
 -----------------------
 
-When there is only one argument given and it is not `--` (e.g. `git
-checkout abc`), and when the argument is both a valid _<tree-ish>_
-(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
-or a directory whose name is "abc" exists), Git would usually ask
-you to disambiguate.  Because checking out a branch is so common an
-operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
-in such a situation.  Use `git checkout -- <pathspec>` if you want
-to checkout these paths out of the index.
+When you run `git checkout <something>`, Git tries to guess whether
+`<something>` is intended to be a branch, a commit, or a set of file(s),
+and then switches branches, switches commits, or restores the files.
+
+If there's any ambiguity, Git will treat `<something>` as a branch or
+commit, but you can use the double dash `--` to force Git to treat the
+parameter as a list of files and/or directories, like this:
+
+----------
+git checkout -- file.txt
+----------
 
 EXAMPLES
 --------
-- 
gitgitgadget

