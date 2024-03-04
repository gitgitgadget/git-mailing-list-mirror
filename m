Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4971A28C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542461; cv=none; b=b5JMpTCuh62Lvmst8CTs5aLKirtZKVCVrds+7NCeqUoLVqrWOHLYkM/NTuSQbGtw/ytRaX03vUIQyg9kX4Cm0gG5cATaiS27AYSQL56zCNdQs+qaoPgP2DHeBc142GSaJEcBzCZMvPc5hlbXzgUpJsAFb5ayv9y47yimdzrhikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542461; c=relaxed/simple;
	bh=bRRAG5Wj9FAb2cJwqTYybYdWiFI6qBAvMJDU18Qds/A=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UnmvdUZjMWgQj0Xl98BqGVYBsfDkzc7nlaqoJ81Bby7B590x/fWDtjXIQVZTXwiNv4zy2Hbe+W0gZfZLLrJtU0t1UffAHKVJbsTJmUK+Piz3ZnVs7N0UGcOYM/WUS2F1gdMXr0Y+j/AA8Ba0sOA80ktIVh/f42vlYGyUL2psngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgQMmL6p; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgQMmL6p"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d204e102a9so42102771fa.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709542457; x=1710147257; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmLcMFKRaJjcKTdleKDVMhgGJuxJSPd5MBgFnyLUUUQ=;
        b=JgQMmL6pyhRrGl+JWMWexvaVSXbqO6QcVczr0ewnDzA5HBOrYNXKRLLo61bls8Zx9A
         4FjuVeygdxbZfAIJZhUtpUMzVt9KH/eiMrRXLf0fWTIbsrTdGltnxhtqCmNfUKzMCYhv
         6AA0o34H1vDzxLMuzh4Re9QUXAD5kv2Os8YG7bjk49Oo1K14aCd0P217s2LuxTuzoL3a
         YJjRxi8by+N1qXqkZAa+m5xVNa/Pcs9TJG85/13jktl86cGviBrx8pzzFofogEEuJYEo
         mWXx8amt6LEzkSgDlj99ZF7ZVRnuODrU+8udCFqYuSCeWzaAf6b31aoMKAwJ0f7hPhPM
         rsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542457; x=1710147257;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmLcMFKRaJjcKTdleKDVMhgGJuxJSPd5MBgFnyLUUUQ=;
        b=Rdqro2F6SGHFd7NgmhFA469VFK3QVs+gDKVYikgorYSGpcvukNjUUKmKlxsEcxeKEw
         X3UgDMOO10GuGW2SdYJQb7e51wmnkiDtNCk1xZb7Qle381+qABdQ7VEZA6oBVnzE2Q2K
         75FXnjYbnxwg+aJF10IAxMadgwZBJUOI5shBHK885HJoRkh6osIUtksC1uCzACFm6QVJ
         LtJFLs+o9d0r2225lkSG2priIfgjYBfr20IGrk9m/0KQnZUYlZ5/ENtXgQ5kJ1iycVE8
         1q0b0Mxl1x9C6onrsN3rhLG4o21CY2DNMpmgoj9tUjPAqxXpneFnRK23bDKuyvuNFhcZ
         IWcw==
X-Gm-Message-State: AOJu0YxzrB8pLIi+UMHn5yMyqogNYJaZqaox51mgcdkJduehcpLKQe9C
	ASCnKo04EVbbXjzQH274QjERiCuZym3+cxRRwbSv2jE6DLlFx4vbiO7vvlS1
X-Google-Smtp-Source: AGHT+IG2x4Ahda653hSn6R5oJNVUQrB0Oq5UFDaM51pq8dq8/nMMROIVsFJLlxhLAVfF4WwYq5bquw==
X-Received: by 2002:a2e:9b42:0:b0:2d2:44df:b112 with SMTP id o2-20020a2e9b42000000b002d244dfb112mr6396975ljj.41.1709542456728;
        Mon, 04 Mar 2024 00:54:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00412e8370a93sm210256wms.27.2024.03.04.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:54:16 -0800 (PST)
Message-ID: <pull.1683.git.git.1709542455728.gitgitgadget@gmail.com>
From: "W Sero via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 08:54:15 +0000
Subject: [PATCH] Fix  git-p4 decode() missing an assignment
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
Cc: W Sero <sane0r@outlook.com>,
    SaNeOr <sane0r@outlook.com>

From: SaNeOr <sane0r@outlook.com>

bugfix: When using git-p4 in the python2 environment,
some places decode() missing an assignment.

Signed-off-by: W Sero <sane0r@outlook.com>
---
    Fix git-p4 decode_path() missing an assignment
    
    When using git-p4 in the python2 environment, some places decode( )
    missing an assignment.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1683%2FSaNeOr%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1683/SaNeOr/master-v1
Pull-Request: https://github.com/git/git/pull/1683

 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 28ab12c72b6..9fa4b9b104e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -307,7 +307,7 @@ def decode_path(path):
         return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
     else:
         try:
-            path.decode('ascii')
+            path = path.decode('ascii')
         except:
             path = path.decode(encoding, errors='replace')
             if verbose:
@@ -3114,7 +3114,7 @@ def writeToGitStream(self, gitMode, relPath, contents):
 
     def encodeWithUTF8(self, path):
         try:
-            path.decode('ascii')
+            path = path.decode('ascii')
         except:
             encoding = 'utf8'
             if gitConfig('git-p4.pathEncoding'):

base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
gitgitgadget
