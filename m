Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43828312D
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148942; cv=none; b=LTwC4D8/8FD22J2+MpiTStwvvgDGp0QKPBVGsD4IVv2490q0IDTdVXkjfUaDnMqEDRgT+vqE+jpmmWBf1RVz8Mcd3HFkYgvjQIgQyJp7m8lT2bkt8RGlgCzKcqBeuzW8ZpYqtQ6DYWkZzX/RdkudCKVK/4tk1z3gzgkAYKEjm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148942; c=relaxed/simple;
	bh=/xikGllUqvcA6EJgrKr4Gn/UC3ffFhqwxIopMru0hrk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hMjfUaQra62MVOI7oAWQyXkroLIA3oRG2gFnPsRzwu175/3k5mgbctSeElWNZU3x2ooquSCJeOTD78fJa2HRy+Zs5xgkditdb+x9ZQbMC+ATCtH1L18c0eDmje1oI+Vguh5YPKwZ6x17/Uvx2/YjO6OgtH5gI5A570ZKCkROHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW7POK+T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW7POK+T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so25784165e9.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148938; x=1756753738; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhKuAoAa6CRU9v/3jivkyWJGATQRJGuVTThtHVsAEJE=;
        b=nW7POK+TNPFVD9ScloPk7gGtHbW4NJioQ7SgKLXq5ymId0iRJhz6zk7kgX3UbA0klW
         6ohHKpeoxLMyGJMCZ4AV9hJemZL5SQx86VcNkqG+Jcq+2PpkHU1IK8J5Svur12iCdbXq
         e+unAdjUzJYqGc6WXNFBo4o/0IxrAwh0sMk/9G9nyrtNZDwLcVO/bWg+D6nj+Of47Dgg
         klEZX6fADl4Nu4aZfVfO5125DcE5h2+VmxhiyrTce1kCshWhBnYvTkGlsiH/WTDQFr8C
         tqJ16Ze8qvLwEXzwO62hFztt8TztjCHGAp0GfwoCNKSJMIrZ1vK6o5lYE7lp6mCN37He
         6U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148938; x=1756753738;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhKuAoAa6CRU9v/3jivkyWJGATQRJGuVTThtHVsAEJE=;
        b=kgAbrbn+CUAkxfEJfixRWIejJN1IhTtFES58hp8kjPHEurYra2N0qhky74IxCs+7o2
         GZ/9dFFcAaZNz29JpPH35wDi6Y719rDmCy4W22WO1weF5CJQ7qnMrcE17AO4UXL3WNE7
         xoZm351gUsorPYGPtNe3ucc+ETUgukKHYzPEMmdkAGqKX18weqy2R5cPMu9JDdJPFoto
         cpCfzGW5FyBoaqxf4+iyWgCmCA4bCUrVx4dYsJ3xWfpTeXu8tLIcQwOBQfEnsvl8Gn7b
         tdD8MEeTC6xAUr/jskxOAzoYLYFgvaliRE5I+yYfQI8FvEvOSqZI5EjNhEf+frcO+jL8
         b+Wg==
X-Gm-Message-State: AOJu0Yzunn9pS4L4cXmyj8l2S/mVtl8IjVxs1ZFuC07UgcKkNPD9oH9I
	8tf7RFUgeiQvOQAeni60XUHgV8Dr5U9jVKjyBrzCTco7AfLZWRMXr+BdWep2PQ==
X-Gm-Gg: ASbGncszCXUuCIaCuQj80xxJjY1pRcbW/olY5PgsM9qAAUtTP36HfKr5KULM0MMgjgE
	fRB8lVs3ESJ3h9rO9JCVUK4a2RZq1/CZJKV3s1ZwdoUDd0m3Jmqduq6a3leijkuT17j1LouqhPX
	K3fVD0esBe2q+vX4zndaXB7OA0QyeVwWS3xmdI/45VVD804EOITkcpXF+PAio3EP46l/zsZP5zh
	YJRzXrgb5ROmXgH/79EXTTYzHSwC1/mIe+O1q0Q4sZYM33hVq8cQodtSW7/xayFB9535eVkzOhR
	E/qVu2jFscKEmHNDCAmzH7q3esfxYVOy9kdq9Ja5HpWPzWoEdDpq1wg86Dek6Z+pbhhTAaVk8oh
	drKBS2f/sFnRq2ZIEDi83OTCGySM=
X-Google-Smtp-Source: AGHT+IEneP61pLj2nO2C7HuetA0OoPswyOacKiCgUhzpctByQjXBMQR8TX+I2vvdAWC4X0NnfzSshA==
X-Received: by 2002:a05:600c:45c8:b0:45b:627a:60d8 with SMTP id 5b1f17b1804b1-45b627a62f1mr30632745e9.10.1756148938027;
        Mon, 25 Aug 2025 12:08:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4f9sm3062921f8f.15.2025.08.25.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:57 -0700 (PDT)
Message-Id: <2221a6bfb508205b99bfe086b60e64c7218a2606.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:52 +0000
Subject: [PATCH 4/5] doc: git-checkout: deduplicate --detach explanation
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

Right now the explanation of `--detach` repeats a lot of the content in
the description of `git checkout <branch>`: we can communicate the same
thing by saying "This is the same as `git checkout <branch>`, except..."

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index dc9607d9ea39..b343d292b30b 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -73,16 +73,9 @@ that is, the branch will not be created or modified unless
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
 
-	Prepare to work on top of _<commit>_, by detaching `HEAD` at it
-	(see "DETACHED HEAD" section), and updating the index and the
-	files in the working tree.  Local modifications to the files
-	in the working tree are kept, so that the resulting working
-	tree will be the state recorded in the commit plus the local
-	modifications.
-+
-When the _<commit>_ argument is a branch name, the `--detach` option can
-be used to detach `HEAD` at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching `HEAD`).
+	The same as `git checkout <branch>`, except that instead of pointing
+	`HEAD` at the branch, it points `HEAD` at the commit ID.
+	See the "DETACHED HEAD" section below for more.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-- 
gitgitgadget

