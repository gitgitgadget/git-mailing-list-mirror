Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8D2405EB
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339949; cv=none; b=ponUAtxlAklk042yYAntrTY+ndtdT2Wl+2nsNd1+or+9ZYc4zNb+Y4cqmaStJqBPtAy+N74G0/t1yliqUCJknQ12A70rKvged9HLhNZRmKhJBI2f0LjCkfmTDYVGz3CPBghpZs3d7WtpfBzGpq9pVW8DXcbp2Hq+ZyRc1VyIoHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339949; c=relaxed/simple;
	bh=0B6eMooH21Lcq0LSSMVnbczI8m8XC+mGNkfwkIeabkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W/zoMLLK4eahOg5KRU3qXbZ6pscTcX8VTon2dd+xdWX6U5uCXZo1MsOSx8pfz4ZpPlBm+adtUm6/By7IWxymq/h0FCOFBlvivvLJ7SM/YBdKmGjCbsXnzs4PgclV6VTBUtMwcCqI8C0vhFJbXIKHzA1gIGeVwT4t0fbe5bx4noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhXhDHZJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhXhDHZJ"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-948e1ec34afso86758639f.3
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764339946; x=1764944746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFYHyP/JyykNtXeGkf7uh4etMJ7ZCBmmq5YYTuZyz6k=;
        b=lhXhDHZJJjCG1Qn237vm4nuJE8fk1cld3My8EhwJdJQnnsC68yH9eNEmw2F2LFIto+
         AGZm9PMKImIwJhxqclt9T/0G8g00qdfi+zFtDV3YUIzqReFTiWP6Iv99waIZzkLKqJJk
         HziZqp4MB303irlXPwoW1jq7eZThQICLUReBBu2rMW3hRIqpZqDAh+aM+gaXousNj9Gz
         Jvolzhy4S11MZ23jH8ynx9Jpd6Lts1FBn5jSCUF33MC8Ckl3DlEOmtf65zLwJOCuQFHv
         fGH3QZnhfdkXdr/f20EFoQxDx22jvvFgQjBEdpET1n17R1EjpytdoPv8zNx3ihG9muVo
         viqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339946; x=1764944746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFYHyP/JyykNtXeGkf7uh4etMJ7ZCBmmq5YYTuZyz6k=;
        b=qMWjWXn9/0pAjMHfeaLvatem1E+O3b1DJJ84+F29B8m0b3MRyMXUc5E3/vB9gkaQjw
         QTbJ9I9oC7Rmpm9cXNA1wrq7Tq47+Cqk4JBAgMJD+xB0Vw99yOrR5LYmT3Wa2mQrZYP/
         PCnR34YZCyGT6tOQJFcgSkbtS+v04ZYkYlhe2AQ+JmebW4e91iCWijJNiPcoTtTSEKXl
         tIja4UadT1Yelzr2l6YbF36XTd4AhPoU7pgfh8QUgXUj/6L+C+be6pEtV/sRTcLNWyLm
         083LSrmxa1Eek8tEBApCzfc2roV2bne4go5jmyuyu8wL/C2kOb1oljiUSwgkGmG42LIM
         N5/w==
X-Gm-Message-State: AOJu0YwvH4TZ5gt0CVJqiQxHcnDQsDQcmedWS5dRCVr1+qMUh06lAwJD
	PBtfHkSmrykFm7gi6+xMfiy2Dcz22THPhN0FPrRZw0BaJ3Dkpl0CkGQhk37EQg==
X-Gm-Gg: ASbGncsEcauUWjkWwBMYsKxVLZInlf62o+blzZBFpZ6thQw8xZSssGSMgJAvUNVvzh/
	vdxX/KmH0z4wQnqiPRAGTapGJcjl/22eSZlWXcAoopfd+qv4H3Xvh4xpwwjmFA/ALiqWcCzVfO0
	lJDh+Rx0n1CIcvMjkOkNxWY8dWyov65+XGKoSfCTozTh/iXGiGJdbNr4fsEVlelem9qmkfQ3a+h
	XjUlAU2LxBX5UmrUhwsQvGVkh8FrtpQ9UNwGLlRtG/t4w49RfxvuBWrQJ/hvghbeQqW8rNmOB9H
	YIs0yNHIFlVp8jQq6lhbCtGOOK/cvYKB9uAq4XluwrRwe9L07000drHCPq18TOdGj/i7W6BEnPu
	wZFqs9BDuGNDCLl0uBI9E2NchF/VQtizPYxMtO6D6rm4zkDNvyCDiqjo2buDu4ssMzp0aUYn+JX
	5DySFY8ycUMXOgXLE=
X-Google-Smtp-Source: AGHT+IFV9M4HrApTDz8niJxFGPScmicDpQwD0CCz0cHWEsw6QgmRUF1nJvDDB4ubC1yLpJ3QhRIPsg==
X-Received: by 2002:a05:6638:1391:b0:5b7:1ebd:4d15 with SMTP id 8926c6da1cb9f-5b999556b04mr12299458173.3.1764339946383;
        Fri, 28 Nov 2025 06:25:46 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.241])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc30f9fdsm2244159173.10.2025.11.28.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:25:45 -0800 (PST)
Message-Id: <pull.2111.v2.git.git.1764339945182.gitgitgadget@gmail.com>
In-Reply-To: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
References: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
From: "Stefan Rieche via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Nov 2025 14:25:45 +0000
Subject: [PATCH v2] doc: git-pull: fix typo in command
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
Cc: Stefan Rieche <stefanrieche@gmail.com>,
    snowdroppe <stefanrieche@gmail.com>

From: snowdroppe <stefanrieche@gmail.com>

Fix typo in git-pull doc from "git --rebase abort"
to "git rebase --abort"

Signed-off-by: snowdroppe <stefanrieche@gmail.com>
---
    doc: git-pull: fix typo in command
    
    Changes since v1:
    
     * Updated commit message as suggested by Kristoffer Haugsbakk cc:
       "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2111%2Fsnowdroppe%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2111/snowdroppe/master-v2
Pull-Request: https://github.com/git/git/pull/2111

Range-diff vs v1:

 1:  5a37a725df ! 1:  a4a2c58461 docs(git-pull.adoc): fix man page typo
     @@ Metadata
      Author: snowdroppe <stefanrieche@gmail.com>
      
       ## Commit message ##
     -    docs(git-pull.adoc): fix man page typo
     +    doc: git-pull: fix typo in command
      
     -    Fix typo in man page from "git --rebase abort"
     +    Fix typo in git-pull doc from "git --rebase abort"
          to "git rebase --abort"
      
     -    Signed-off-by: Stefan Rieche <stefanrieche@gmail.com>
     +    Signed-off-by: snowdroppe <stefanrieche@gmail.com>
      
       ## Documentation/git-pull.adoc ##
      @@ Documentation/git-pull.adoc: or `pull.ff` with your preferred behaviour.


 Documentation/git-pull.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index cd3bbc90e3..d3006359ed 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,7 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or `git
---rebase abort`.
+rebase --abort`.
 
 OPTIONS
 -------

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
