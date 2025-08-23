Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCC157A48
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755940337; cv=none; b=orbWwATsVXo8yTxOftqiogax89Xy43owx76iYZa3mD/g/ORKWaNRF/a8b7yKfFuegxcKFMaR1kAUqUVMrp7DWRmySdzj/mjGUgmk6TJV7eqppWvaDy9P4UtrEmeR2HNWz0g/fg2uu2IDIhDdsrFFDAicxQT0OXu2gjMemKT/JfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755940337; c=relaxed/simple;
	bh=Mn4EcVr0vCQ1OWLC0z8bYRjOcr0uGG2FsLBmr0XFidw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ltTAqYIBNK+UfDqStQRX9c+Pe0NC+2N0TVI6uwXJft9zg0X2qtJoN0tT2QtNTtikXxoFQ9bvpJm1cDby2mxN1FcIJmYCKXjsHhJNzCLdWCszNb9Ql51mOpVbyDc4LnPxrzn0qaaMYzv+4EXmVhkDTy9Fc1wU51a8VY7cOLxW9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfO+RHev; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfO+RHev"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so23199355e9.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755940333; x=1756545133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3nPnaXt7uZ3oWD1GvshwYMdIoqQ42suKPLivKVeNsU=;
        b=FfO+RHevK7Qlb1gSytan+hckCsWwBzG33ANdLZuO7qudKwxqBA+FUlnXxchhJBMO0x
         GpaFleqNWcXImLK5685JmHINUQExtUWjh+QOMlJ09fj+F7jtZre0LRc/0rOSMiznXP4C
         2bh4vYOSW3Oa/2IJ6E2HMpCSOu1RI4QPrVfl6e6Bdsj466i2OmN34Uq1A9hlarkKgzAF
         oPLr5UlQrZpwVKXXm8Z2zu9IPmrQnZOEgzN6T0dOMrrP+0pzyU1gKRrfXSmMRDBCeMPX
         kNf6pJptf7sZp4KA0g5MqfJQIIEbLrPl3Tj7oDLW9NXVBxcuW3YYSy2hj+huM8Q+UjNL
         Tj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755940333; x=1756545133;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3nPnaXt7uZ3oWD1GvshwYMdIoqQ42suKPLivKVeNsU=;
        b=HLecBeCihGOiaBGgHBwExUyjVjkbsTj+x/NAsY/k9olM0FY9LFluE9JHaTllo/+FvM
         jQldU09yYJ1W5fxkOQzTZfRji2KNfa98MR4J7Yh93EU2ywjFtqYb/4rVavtvz6l5ZlRo
         RBe5TLbuUpvFUw2mLjpE4ze+B6q53eGKOr8/s6SNolMz4jjkXtYPJc/TyoFfxZAM5JjG
         T8hf5Hw950XnXQVWMM8arLHN7MoweQLuTswwlthBH9DNmmloAq5bpPyXX5/DXwQZhkun
         SchsLEUkZ+1s9kNLhASNl6i3RD7ZgkuUNnuw4h7Khv7dWUyQn6SpGopfE6c7tSehzBV0
         DngA==
X-Gm-Message-State: AOJu0YyJMVsWx44Fecn7kcKDQYaQWb+0T8B/337LDvtMbUFtbwPfbmrn
	2v3JeYek3I/cQIqckVD4g2AgCGYxIgzQfftjo2c8B54F5XzldFGmF5Ss1x+JCQ==
X-Gm-Gg: ASbGnctok8WV1O5eC4nwZazOTDTEMviLwD30doMWYTcTmuMF17wD11ZLMsyw12U6K0O
	7xgNIoNHFMHLBOBSeGFrsth8/li12k9pBhGz+pzMQPLGsxHwC0W2PBnLZt4z9WUZ4IfOP9WG8ab
	j//88UqPpq0OmfHSb3/2E2Cg21cW5NRBskfje6evrYGTiUm1DBNU+ajegau5g7ZJEMSay/rY8IT
	7+3E/kPMi2o949D9nBMWvgoaKtbkYLG+QM6aQy1YwVgkZq4d0fB4reywfg3AW07l7LJOq4qBH6E
	TMMQPbZBP9koK70s0rW0ULTom0ZL32RPJRChjKD3x3I3dSQZ5MYUw99PVesSzHCdV1mDC8ZPgiJ
	Gg8FbzY9DU5ghTnZpebrPQ9Z7408=
X-Google-Smtp-Source: AGHT+IENGJZIXvcfRs9Sd5Fu94mBp38lt8SitanYZ5Uvsf/19E1pABdqdA8BR106YgN156Z/Oq+yrg==
X-Received: by 2002:a05:600c:3147:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45b517db8e6mr54901455e9.33.1755940332973;
        Sat, 23 Aug 2025 02:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e2ba619sm53015045e9.4.2025.08.23.02.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 02:12:12 -0700 (PDT)
Message-Id: <pull.2034.v2.git.git.1755940331248.gitgitgadget@gmail.com>
In-Reply-To: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 09:12:11 +0000
Subject: [PATCH v2] doc:clarify which remotes can be used when contributing
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
Cc: Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

The docs mostly point to using git/git as one's remote, however, when it
comes to Sending a PR to GitGitGadget section, the reader is told to use
gitgitgadget/git, with no mention of git/git, potentially leading to
some confusion.

Clarify that both gitgitgadget/git and git/git can be used, albeit with
some differences.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    doc:clarify which remotes can be used when contributing
    
    cc: Elijah Newren newren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2034%2FDanieleSassoli%2Fclarify-remote-to-use-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2034/DanieleSassoli/clarify-remote-to-use-v2
Pull-Request: https://github.com/git/git/pull/2034

Range-diff vs v1:

 1:  850097696a4 ! 1:  b34070c03e3 doc:clarify which remotes can be used when contributing
     @@ Documentation/MyFirstContribution.adoc: Now you should be able to go and check o
       
       In order to have your code tested and formatted for review, you need to start by
      -opening a Pull Request against `gitgitgadget/git`. Head to
     -+opening a Pull Request against either `gitgitgadget/git` or `git/git`, depending
     -+on which mirror you initially cloned from. Head to
     - https://github.com/gitgitgadget/git and open a PR either with the "New pull
     - request" button or the convenient "Compare & pull request" button that may
     - appear with the name of your newly pushed branch.
     -+If you're using https://github.com/git/git as your remote, you will need to
     -+open the pull-request from your fork, selecting `git/git` as base.
     +-https://github.com/gitgitgadget/git and open a PR either with the "New pull
     +-request" button or the convenient "Compare & pull request" button that may
     +-appear with the name of your newly pushed branch.
     ++opening a Pull Request against either `gitgitgadget/git` or `git/git`. Head to
     ++https://github.com/gitgitgadget/git or https://github.com/git/git and open a PR
     ++either with the "New pull request" button or the convenient "Compare & pull
     ++request" button that may appear with the name of your newly pushed branch.
      +
      +The differences between using `gitgitgadget/git` and `git/git` as your base can
      +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)


 Documentation/MyFirstContribution.adoc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index aca7212cfe2..bbb7b45bd4a 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -908,10 +908,13 @@ Now you should be able to go and check out your newly created branch on GitHub.
 === Sending a PR to GitGitGadget
 
 In order to have your code tested and formatted for review, you need to start by
-opening a Pull Request against `gitgitgadget/git`. Head to
-https://github.com/gitgitgadget/git and open a PR either with the "New pull
-request" button or the convenient "Compare & pull request" button that may
-appear with the name of your newly pushed branch.
+opening a Pull Request against either `gitgitgadget/git` or `git/git`. Head to
+https://github.com/gitgitgadget/git or https://github.com/git/git and open a PR
+either with the "New pull request" button or the convenient "Compare & pull
+request" button that may appear with the name of your newly pushed branch.
+
+The differences between using `gitgitgadget/git` and `git/git` as your base can
+be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
 
 Review the PR's title and description, as they're used by GitGitGadget
 respectively as the subject and body of the cover letter for your change. Refer

base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
gitgitgadget
