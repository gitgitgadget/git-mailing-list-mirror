Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24D2FC880
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468508; cv=none; b=KERVNRE3oQpSeVGMY3gER+RMUgWGlbrUgN9uPBYlWsEQPXTrnAjpeq8t5AXqFMDYWuL+1pIEqy5iUj5dCTawmTPGNGUz2J5zVVaR38ioqZDHm8Wwazhrlq8I2CYonESyw82FGLWAMM7S7fFdqO3BpOfs37DUyNRs4WE3Jok6BWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468508; c=relaxed/simple;
	bh=cdMJl08ysK4uzEd9DhlxzYEeDlqzReJr95wpSgeXwDc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IQDfXyZrPM1E4wv/EyvQ38dhOEWCNc0s9Q/fe5ZHVwbs+MS4ThnVIXdLa+kH+O9wBxdCXUwjT09y624z4wnR/8r+jUImbmDleUU++UjIvMSlkp70/DaswJMFAqm60TXv+v+1u2tdSDOzRP5phzpglNuMtpgtazed2sW28LV4X5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwpe15tr; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwpe15tr"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e66c013e4dso10997875ab.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756468505; x=1757073305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoUb2coWtNxBuFNSj0/p4W9zgDjkw3R/JAmP/fDIktM=;
        b=lwpe15tr6qNQ1RnkyxTWQuL5o91Hwgx0ILItrslUS5yObL2Vv0DooJCTujgCsu0h1e
         14rVZxhthsuHh4odeaPm1gaqXDWXOS64bzXigI7utp0Ss7d5s3ZfEGHowmqrWB49cILp
         qGEMz1zf3g68Y8RRaIQktKe0Y6wfd1T/eYiQ8THgJT7d503UeUcVUGhpy10XlzTKCaCZ
         SOdLVu+L3zB9iGcSlLLcshWEXgG21uFz9acIS2x6pmGtDO1Mr04DeOOjmV9kPOSmrPiu
         /MMLMhKrGzkee9eRQzWk4eqwJ7+SSTe4Y5NNOLDZhTT8xTMBXOnRMzh78JapK1nSbrWw
         yFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468505; x=1757073305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoUb2coWtNxBuFNSj0/p4W9zgDjkw3R/JAmP/fDIktM=;
        b=jHPa1LqnL0n+1d5ThYOaGD2GLRnHDxnFY/lQW+N7jFvSUEvIpCkKbWzqDu+dS1E6I/
         v+i6BzDN61QOkLhvakBNsuD1mj9EpStdnLNwbqHQ06dXzHOJYzsYW1Vl6WliRQQzNy/M
         mKRJbYuNp4+FZl6v2QzpzP2dMuoQiRqyAkEH+EWLe30lgnZpDRqRP/l2rV0OgliUrdm1
         udzjrEZNoytDs87fT4WJjedFVdPSkbpIjnl87lB1E8HTigdl3SNz1JRUz8lZoG+Cw2nW
         ZcQNxaFvoOJsWsuCqr0kkUljzIw0nk45AAiJsIJcOIFt9mhV0eSOAYnZz8p6eMGT/Nhb
         PiXA==
X-Gm-Message-State: AOJu0YwZLGBWWce+a8VHqNCzs3XRqrSOOTy7SwBwwLvjHEQgcvMrCCO5
	VqJtj2J2QK3j2Uj0okEmMrq1F+oRjGWYDWXT6l20xMDrq7V6sQUGJv5xsFWNDWvhMrQ=
X-Gm-Gg: ASbGncumcd+8i9zt5zKfNlhlxywUynTV2p5ceREzsWJPYRHvmBYZyWiQv77r25oYCNL
	SyJ2Q5J9rNFdvcgvwCs3Xgi0fG6ewCDaCsZ4kKR5uMJawqhop8Zhv9yukbC/OHhgU5AHsT0/rBY
	2sD1ZnibhTuFhNiwrdIrNitTNrptqV7DsufUNQpGhOBxh2tfqo4pU4D365MWW9i8gbuMcv1bImT
	J25I3Kr51l2/i+AFOlkI4qNXDyms8r4Gdlp8hLR0KGGzuj42tKV206BWdEGFdpSZgQIjh6VFs/m
	Tis59QvD8VB9ixUnBK4UX1Y/xi65Vt0i9anoGWzGr2kr5GgnuSr8dPMFA8tDamqbMmMQJxcbLaO
	AnzGjqLZQBuUzwBytOiIrEGGF/ch15yZ0g9wlpg==
X-Google-Smtp-Source: AGHT+IEYoGugaBU6EJO/AR9dJ1hbPMXPJVlXTyuA+YduWBSrx7DzQ6CDydkdUh6YwVRwoHfDgdZVKQ==
X-Received: by 2002:a05:6e02:188e:b0:3f1:700a:3f78 with SMTP id e9e14a558f8ab-3f1700a4168mr116483415ab.10.1756468505552;
        Fri, 29 Aug 2025 04:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.182])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f29c1f5590sm6777805ab.0.2025.08.29.04.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:55:04 -0700 (PDT)
Message-Id: <57947d5a3effa3cafb7b4e69f5c9e999b0cc5c30.1756468502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
References: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:55:01 +0000
Subject: [PATCH v4 1/2] doc: git-add: clarify intro & add an example
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    rsbecker@nexbridge.com,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Add a basic example of how "git add" is normally used
- It's not technically true that you *must* use the `add` command to
  add changes before running `git commit`, because `git commit -a`
  exists. Instead say that you *can* use the `add` command.
- Mention early on that "index" is another word for "staging area",
  since Git very rarely uses the word "index" in its output
  (`git status`) uses the term "staged", and many Git users are
  unfamiliar with the term "index"
- Remove "It typically adds" (it's not clear what "typically" means),
  and instead mention that `git add -p` can be used to add
  partial contents
- Currently the introduction is somewhat repetitive ("to prepare the
  content staged for the next commit" ... "this snapshot that is taken
  as the contents of the next commit."), replace with a single sentence
  ("The "index" [...] is where Git stores the contents of the next
  commit.")

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index b7a735824d..ffe8fd701a 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -16,18 +16,18 @@ git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [-
 
 DESCRIPTION
 -----------
-This command updates the index using the current content found in
-the working tree, to prepare the content staged for the next commit.
-It typically adds the current content of existing paths as a whole,
-but with some options it can also be used to add content with
-only part of the changes made to the working tree files applied, or
-remove paths that do not exist in the working tree anymore.
-
-The "index" holds a snapshot of the content of the working tree, and it
-is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working tree, and before running
-the commit command, you must use the `add` command to add any new or
-modified files to the index.
+Add contents of new or changed files to the index. The "index" (also
+known as the "staging area") is what you use to prepare the contents of
+the next commit.
+
+When you run `git commit` without any other arguments, it will only
+commit staged changes. For example, if you've edited `file.c` and want
+to commit your changes to that file, you can run:
+
+   git add file.c
+   git commit
+
+You can also add only part of your changes to a file with `git add -p`.
 
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
-- 
gitgitgadget

