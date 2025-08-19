Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D013431FD
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636378; cv=none; b=PGWVGVw+KjLjcnglZtaCgDJrGNbSOeKxZynIBmHw8ghSjdbWjxhZbT+Fxhp91mCzq/5qLubULPwACmfABWgtCc4vQKJGaM+G+pjB0Iq+sdUkpD1YWKIOQdHtTw5/o0Zu49ZRj0f5BJRUOngLHCHVt9xkMrYnSGTERi1+vjf86y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636378; c=relaxed/simple;
	bh=qvBGINFMZO5gKe0DNm7PMuQG5t0gzJbv8LZexxYYKNI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BjsTZnoTufb+Q4ouVyL8Pldlo4AAGzHIt7Jg7lgp2tkaeYr/Yy7F0cDl6ovqeBNVKQ2d/3rek67fZohBNouQE0XcSqIoXn+xB4bRePwf/fO6azOmn0tzRM6kG1KpT87F0bQZXo/fsj1qaxZ040kiFqbUVieTG3YFUQoSmW/2Yz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB6z+O0j; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB6z+O0j"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so1827905e9.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636373; x=1756241173; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vsLKsMjM1HeG65SEAZDReEJn7W8Dj0XsGQmsxX0Kgs=;
        b=aB6z+O0jKNlWoqiVzqtgPRxrRyXsR40l7T3r9pPzNZO7YiauYHDG+M4YxRPrtbJ2My
         V+LcIWwGJTbZGfCua57MF0GfCph6BXpLCLpKx/ZLTC73G0vg2ctjpnpLacYXM4NuKIiV
         gykJmOLG+AwNmODrl5/gdWe/k86OITEAEgw/EEKYfiV2q5bMoT62FsDQ4FJqCC9cP3V5
         Q0j15jWy2KQObfUHhSya8wo//2D2GzW4a9RtL+6A2Tsgh8rwZG1cW0Pa3MSFTYKAJDn0
         TkmFMSbwZQwGpwXY9i0NgtUVcoxGQap9iYJnUvvhkL3Qr+PynK83OfAL0NXpnfXedPlq
         f9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636373; x=1756241173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vsLKsMjM1HeG65SEAZDReEJn7W8Dj0XsGQmsxX0Kgs=;
        b=K1ZrkVT0+NOjGHFs5UQWmKGODfGQZ415iQueVDkB72sQ9bBG3Ozzgm9/8pfpb8hVxH
         cWNKFzHc0BFr80+jpwJAFf+z407MIXJ5IzK61ql/jVrEetNnhTgzF8v+1EgXxGgie+Ul
         UIIfyoYCIiP6JU26wM+FGZ6fZ2FZ7wSS2WLBIrEXLmIe4AZI8oKnLmjxW5K5JpwYL7Rd
         rqIB3DoY7fUR6+F09Y/flpmqoih2x/rpp/vV+XHr6Q/lVh8uPLDYvhhamv26uuviLRYd
         jOO9KGdENPsmFm9mGxxSRIIh1QyMtHIoKzmN1eJLZqzB5BMvD+qad25dHCuqTYZ1tX9G
         DOww==
X-Gm-Message-State: AOJu0YxWasRxNvJ7U8W/QjxjoPSUsHQZDFDG6UOOcg4lAFWwnBV/K2Ri
	x/PMCrtWJKqQpnBCnBE74XBqYSpvzcrakdD1Tu8h6zqwp+OTwEzd5ILumWmZ85R9
X-Gm-Gg: ASbGncvikoluVYnuzW+m/BROQerQcgvlyWlojG/fjVX6QtlgsbARZ1TnYL9l5NthOWY
	P3m4H6vRYBILR+8YN65M7ts/YynOZpW+P/vNemQ06R73tTanrS4jJNLk4Q50PhUccSgouIYKPK9
	nGCDdlG6wMXVuNkyNUkvvpyRZmDY0/VVDh8OabJXmFHaWKDoe6We7efw4i42h6INfRhcls4Kip4
	kh4wrpvWrt11o8EMvQaljHErgjK3bmXm3tppQA2mJUXH6JrVfwfSv5b/67X3/qAR+tnOAm480Bc
	njcl/jIPF0/sqAz+mAHXQx8lcvm+8FuTeJ39PCMv92Lwj3ZgWTUD4ejeeQ8rJ+zTfXLVVZcihnV
	iY69hNUFQ97AVrdrdtkC9FZogk5YfGVZH7Q==
X-Google-Smtp-Source: AGHT+IEYaxoa/+wo68Ta+yyvi6QLW3Mumhg3R9iZBRKvRe6D7s94ioZiq+uWdBF87w/OrbuI9l9J5A==
X-Received: by 2002:a05:600c:3f16:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45b43e972abmr38186825e9.12.1755636373156;
        Tue, 19 Aug 2025 13:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c59224sm1550185e9.18.2025.08.19.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:46:12 -0700 (PDT)
Message-Id: <080720c059910c910161e250cd7eef54208c3fc6.1755636370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 20:46:09 +0000
Subject: [PATCH v3 2/3] doc: git-add: clarify intro & add an example
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
index b7a735824d6c..19f99b0e7f6f 100644
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
+known as "staging area") is where Git stores the contents of the next
+commit.
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

