Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1722D0618
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531674; cv=none; b=NPEa70vD81X2uUsKjvnATXAoIEMlK4QHfyy4o8Sjafe0OJ/RIcu+doxLIRxu2bpbNbRFyQvk3/opttq3N7BqY3S1b39FbtnwjzBHLShAug7sO1y5MS5hr7Iq/aUckQ+VyD9uiKawJahIn2wHxgOwsLsk87qK91205tEgvM8sWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531674; c=relaxed/simple;
	bh=szs8tOKSNYr85Ad8iNWoXP5ZSWkgRHGfKmZ+i8PcF0Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gQBetizvNTIhOt52qLUvTp6uVX8yZJojgp9AQc7HOqjEWewesAPe4wuFj9aO+ONvV7c0CjOgYn1P2CCbEHjgWaykbk80vh2ocFZqBk2sZxH0pFGrueeSARpFFhzYq2yaygyOt2zTSSgS2C5+B8xoJOIYqrI8hHSZoftLNLBYqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiaTWb/6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiaTWb/6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2de2e427so50998495ad.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531672; x=1758136472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKGnVHQh0rRs5T7H4nD1zEmpkMmkQaQynXE4kP1U1AM=;
        b=eiaTWb/6G+9vzmhcoX7lETJGUlN36yYAH5ASHNiFcTsILMBTS+W9i3+KZuAZ2plw+7
         BHG545ci+l4C2vhWx2z9B3aqKSBL6Vl0HKJRGVESfOgYG1/Khn/GzCegT4uL11qzhXsL
         N+FXh2AKBCYLOFzedEQEPcSz7iAdaouijaWhOkhWzxoE+hgJg+QoV7pURqh09hKS5lJZ
         OvXy46mlo6NWg9aHBuwfAmjxYrVzaPH6Kz5PC1A6T/x7xaoRV7fCgvU0jZGmPdBeBDyF
         yfgdZoNSjHFkqCQbyNoMWvPKnThWc/hVMwWyCcwKjgE2UD9kW1Y8aLERce7U0tixghlh
         QsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531672; x=1758136472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKGnVHQh0rRs5T7H4nD1zEmpkMmkQaQynXE4kP1U1AM=;
        b=vw0EgVIuz/KiRLqFgqZ0hdFln96yPd/RlTkHQgZRDTWN8tv9LkXrcfzdYeftmBUI23
         WRchxWI5fLF+ET1vYfh1YJtHP32iy69GJ1X6ipiGHs2dvdy9HmdtAIZMjFRP2xtFjtrR
         HITOwa/6szrIWpe68oyL3XWTRJ/NSwnPWk5ygM3uppBzKnpwyirCjoZH0pP3AlQYfU7Y
         9x8ho2J3oWUFwhsYOvMnq6JikJxMqzsP3cVl9yURAQgOVpbTp3ir4tFmMG0VliXxuUt2
         RKKdkKj4ZX0vhY1CR8MsXr8WAyUk4UxyENt+n+0Y4knq+QrBViWuFB0hwno2FvR3AQxU
         sQ+A==
X-Gm-Message-State: AOJu0YwpunBz0ctwTvgsb8i820voa/oQ8CaHHqplvSwLRLJ+F0VhBqoS
	y5mrjMqdZI3wN1Ur7jaPQ1vq+a4pXlYRregc0Uo1C2sxHIYNcJ2VlIgSy2JG7Q==
X-Gm-Gg: ASbGncuT5jxm+4/8HqmWtY4UllNk9KMUFanvZLUtlr9L25iERK4gyv/4IW0qwZ0NhNQ
	XdHv6Se4af0Yy7JdivO2oDr1mcWxCYeduSq4Aqnk9JP55wlVqAcU0hJ6zNt2OYfwwpzQNpWKNqf
	4KCgY5SsyyWw9+xXy/VvqRLOniArEf435OPEy2TN2YGU1panMRI3i3s57fel1P2Mn2CFBbvYecN
	lqu6ee2PfznNb24tpyL2U/PSoR/r+pol/hfJPrclwt0sT2JpqNDXDGBsRlGEaILgXIosFLB6JJ4
	Aa74GfpsgwyOAHCGFp6Q4mF4cfRGBALTqvPBwagT90x+5mO7XZrGOPZrdmykB2ovYgYoth1BtIM
	uwCcwPrAZvk21WZFncaShwyXLbswqcAOHIZi3Tw==
X-Google-Smtp-Source: AGHT+IEyuwHIyFJrUKzkaHushUc0dWf/psBulG05gVNz+pIXkW7x0nxFnCKS9JNEHCQkGemcTPZAMA==
X-Received: by 2002:a17:903:1a67:b0:24c:786a:d7ac with SMTP id d9443c01a7336-25172b4992dmr222625475ad.47.1757531672330;
        Wed, 10 Sep 2025 12:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2b0e2acbsm34501875ad.145.2025.09.10.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:31 -0700 (PDT)
Message-Id: <4b52ffd4970d8a33065cc8dcd915623acf716b5a.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:23 +0000
Subject: [PATCH v4 1/7] doc: git-checkout: clarify intro sentence
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

From user feedback: in the first paragraph, 5 users reported not
understanding the terms "pathspec" and 1 user reported not understanding
the term "HEAD". Of the users who said they didn't know what "pathspec"
means, 3 said they couldn't understand what the paragraph was trying to
communicate as a result.

One user also commented that "If no pathspec was given..." makes
`git checkout <branch>` sounds like a special edge case, instead of
being one of the most common ways to use this core Git command.

It looks like the goal of this paragraph is to communicate that `git
checkout` has two different modes: one where you switch branches and one
where you just update your working directory files/index. So say that
directly, and use more familiar language (including examples) to say it.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 40e02cfd65..9733c73450 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -20,10 +20,12 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, `git checkout` will
-also update `HEAD` to set the specified branch as the current
-branch.
+
+`git checkout` has two main modes:
+
+1. **Switch branches**, with `git checkout <branch>`
+2. **Restore a different version of a file**, for example with
+   `git checkout <commit> <filename>` or `git checkout <filename>`
 
 `git checkout [<branch>]`::
 	To prepare for working on _<branch>_, switch to it by updating
-- 
gitgitgadget

