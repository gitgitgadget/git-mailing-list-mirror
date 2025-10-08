Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90A26057A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951545; cv=none; b=VQYcwB3dYJaKgj548YiJYZFcdrJNHSD6N2gIJZeIxar80mHcuBOu9gE8XLQbzjE3YYyCU+45mBQSBQUGOHAAPcL0BV5cusSRlumnT3tBRGhfTlkey2/hNWdlntj3V6zuPpkFUoCtaLOIzaI9hA+qF4dye5jIdINZJutA4ot0Cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951545; c=relaxed/simple;
	bh=hdmCf/N0v0vu6shQKPRGTMWJYme5ZE0p6aWdvLy4dN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lID0CILtetGYIjYgFNcgojDyOZ6C1DZof0hTDE0CSZK36EMRRe5yhxOO7tR9BrONb8XfRLLyGrcDr9CVz/msXeM1Iv4zOK6AkUVIm5Zyh7Sm0KddHYe8f52nYY33+HEA36VtFd3+pPuDgBiO5uPMdjEU+Vc6OLZwiYVthxZ5xvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbZG3yLV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbZG3yLV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d93e562so254235a91.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759951543; x=1760556343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDuA9YM9AIPZy/iz1qkjISeUAYYPBUwx3zBmW1q1t44=;
        b=AbZG3yLVZFO/so5z/nesqiedOxBzEx+ck6M+niB1FBfk4G3/rZswHwEtjWrjljt7uC
         nJc1q742u2LqH5MnmKc/9tmEVX4tIY/n/kathFegmVDm17CV+2/JTlIiprVuwz/FjPYm
         bVx+1rFLm/BcfzrZrQzseCTf0/5XVQQ/7Z2VwWLzBwCi8CPUzEG4XUnINcz45REgCFtJ
         MupVYaDxXMBgn4K63aTF/mlCguKYT+/qYzc7P/gO7pw9pIqnxJc1pxPENl6/6uxVUCon
         pJQVmA7wZ4O831zs+kyr63aPlkj9d3rbw5VyfkiAa+ENrizH9hC/y9q8JKZdVJ8p9xPq
         IkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951543; x=1760556343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDuA9YM9AIPZy/iz1qkjISeUAYYPBUwx3zBmW1q1t44=;
        b=TQ1G7sPWqP9r3uOKcmQfw/uYUz8lrMouzaC2FmqAcv9nmzsv8eNL9vR8jr6fHdxX8U
         rMZXZ7dMCwaBlHW8VfXe/GvhPGGm5+9aDRjpCkGP3TiL7EzHuhLuYRDsJo8b8hhTI7kC
         vjeQCZAMBDbouwUFk7wvcVAJ7sedvVVv3QvJxr4BdNHZtsCdihi7wRCISSaDnPP1gpeJ
         IkSef7dDs35FC6LQkXwu3rLIRwbj/Rqu7/Se/1e0SLFMKaV4acgLSda+ATVA3gw0De6o
         NFxZG+5ElHjpUzMKuDq0TczQ3nrqW4QXHTeP17NsPj9vtRjspSC2Ae3sDmsE7JvAx2w5
         7dKw==
X-Gm-Message-State: AOJu0Yz6prKqZTdjfcZh8tGo9sR0pCG7u9sU7thHmE/AWP8dkcjGDK/A
	p/uY/gyQM8O9r2pTfm1M8ZJ+DiD+4hjqSFWTGLpg4sLk3zjBGWmxpY0XFtDnp2iy
X-Gm-Gg: ASbGncuVLpDGWTIkvcgno8rkyvXPDQb5hwb9gbMNi8fJ4daNyx7+38nZn4aL9zq3QfG
	h5FCgYGsVB8ftUtMB6jGnfJTdzQ5Jbeev3RXMYRcygOzH0PmuUauV+rSFfUIcbw9h7BmkdktBTu
	gAZCfN8TFAtV3PcdCq7+g7WEgYczGNc18RmuVzyhCNn7AfP63mcWuUDvQgBYXCiasyDgw16HH7c
	fhL8yhbbCykzA92HMNUB8pMx4Dm9bnOlLw+8j1RfDkXtFWdlU/2UyKx4oTZjzF0WFNomVy7tPSE
	oNSlUS3Q6AeRLyB1jpwHd1qlokdguYsKXYOYieizkrvM/+3yFSs61ZD92PAvssDYXsHTPv1MFaO
	+IhW+XoTrHORDSb76n3TdsdTU8a8LDsZJED9L4Sn0u6YbywzH8fU=
X-Google-Smtp-Source: AGHT+IGZ4t0uT+UXeKlOGQ9hOFnLJBwjqHcFP4nkCLuiuAWL5FQOr27/Ji5I9hVVHFQLl0JtBwBEZQ==
X-Received: by 2002:a17:90b:1651:b0:339:dcc3:82ca with SMTP id 98e67ed59e1d1-33b51148aabmr6201271a91.6.1759951542568;
        Wed, 08 Oct 2025 12:25:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6305e373fasm10166058a12.34.2025.10.08.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:42 -0700 (PDT)
Message-Id: <999dfba15610ce5d6ddc19f4512de64181184920.1759951536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 19:25:36 +0000
Subject: [PATCH v2 4/4] doc: git-pull: clarify how to exit a conflicted merge
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
    Chris Torek <chris.torek@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about why `git reset --merge`
  (why not just `git reset`?). Handle this by mentioning
  `git merge --abort` and `git reset --abort` instead, which have a
  more obvious meaning.
- 2 users want to know what "In older versions of Git" means exactly
  (in versions older than 1.7.0). Handle this by removing the warning
  since it was added 15 years ago (in 3f8fc184c0e2c)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index dc93e5e6d7..8d286425d6 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -35,15 +35,9 @@ There are 4 main options for integrating the remote branch:
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
-In Git 1.7.0 or later, to cancel a conflicting merge, use
-`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
-with uncommitted changes is discouraged: while possible, it leaves you
-in a state that may be hard to back out of in the case of a conflict.
-
-If any of the remote changes overlap with local uncommitted changes,
-the merge will be automatically canceled and the work tree untouched.
-It is generally best to get any local changes in working order before
-pulling or stash them away with linkgit:git-stash[1].
+If there's a merge conflict during the merge or rebase that you don't
+want to handle, you can safely abort it with `git merge --abort` or `git
+--rebase abort`.
 
 OPTIONS
 -------
-- 
gitgitgadget
