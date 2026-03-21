Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEB25CC74
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122449; cv=none; b=JJzVarkBY/oXi4dzkDXnAGOLIjvA3X0+vG12eUIq/u3qxWmNArHjYOqI8jbW8LG9dTC1Xmpq/YTpku9GAaOjuBMMsBaVGIxpLLTLsyAehSr0s2XiBbzZEoIyZDjtaNX3RqS61cBbHExJcn9lVb7RYXa/ETqQWQvIN66UQlbJdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122449; c=relaxed/simple;
	bh=tfNrbTNXjqeg3ixP88apmmvwR5+FExHFY669qpLVzA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4KRPRIBvTlGwqBaLKCoBGKI20MS9Fh4+N7mqwjEKMpJQsYPFgY0PuNjqIuJjCJ0JejnO6Vt3TDEvBOaziBMPTKwlr7ofn+6naWgVFw1f0Ztp8qT1MuGIw5kscVmIgnZELMamzoW2gc62OZ4FZmsgW0i+Neiu0j50oYk3/lonIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS8+jOQm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS8+jOQm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b04fc8851cso31019565ad.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774122448; x=1774727248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9BucYP4IKzTitQpizy4ZHMMF5pj1RgNyfpjkCX58w=;
        b=NS8+jOQmcvvRFm1aDqLadKuZ/IIJLqx97SZV0Dh8sAOTLjZToRjyiNNC0sxhpLTmpV
         qHeWnUS4eCV/DLQWj0LnY6ZNlXk9l8SRDziji3EdMMxKFiORNgQ5MDp9/hhVczia2rgE
         GfE5TUE98Fxqh81YzKak5MfUa48Kq2ikw7XIfImw96y+Jw97jbUTYVMmoMq5t0FB0Rqf
         F2kUWMQlPYTK7LSMNFLYUfkKS8Ai7Idb6AXRY0UKDm/IOe/m6lICG/SfsYKGp6MMWKxg
         KyJMuh4KPrqpzskI2oJxrK7t6S/MYPg5RNWmrhZyksFOSjkvV7mZDt5RGTyPPK5pAKPH
         fhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774122448; x=1774727248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7W9BucYP4IKzTitQpizy4ZHMMF5pj1RgNyfpjkCX58w=;
        b=i4Da/JxYpowQ28mp5t2Iaquo0y4UQD+sWFLDihE7jLyhZkyoNB2xhteJM0ghmFWVRT
         AA7vdqKPVhr/4bkKfsD/rGskaAOItdQHUZkLuroPTr2sfLfo8OdqmlBL7pEdgLfYOabr
         xxpG/AljyP+SeGMVMXXTk+dFYL9uHqESY7JvG6LugLM33NEQkE7ew72RUb/xb4df8NkR
         gW6EvxP+KnodT22AicPFPjhi6vATKwaOhgsLxDryekKZNAIDIKoGJlSzW5SB1NFY5Gxh
         IjO+Gox/XrYEMhizdRPIJ8QauViuNpwxb2Dzg6bijsSayAFSynC5bx/dh3AEaxEU+3jM
         9unw==
X-Gm-Message-State: AOJu0Yz+Ysqf79o+36gWIPVoswZoM35J4L3v35pCWqzUwi4wuSKtTGye
	tp4fIr+j18kWWkPM7r0UnP8nz+y2FL4YGWu188hBZBwcXEav6p31iq7M
X-Gm-Gg: ATEYQzyDJUleZrBz/NZ3FgROdOzyBT/l4MCs8tQ3t+B+py1XS1CD+lmHsXT96lw7EkC
	9qRH+Fvk+dBLVKOnsci/XyHHUgT96RHPvsIi3EJSs4G9/ZFzfYdnw6txRIQ6mxNdYOPmgsFL76a
	8wzRPSeGM4pX2GK8+FV2mLHHKFdkIobo3zLkqRZ8qlHoXScl27fen8Lnt2KMNtamRTnQIv/OvWP
	IWZ5PFIN/HZ/Whlhseh2OfjZuJc12ZAYGrQl6+kqz5uJ3kh0esjP7e9P/CumqlXGJLgzDdPJveD
	EAUjTxisuAU+6gTwtY3ChHRaK8UzUN6/XdROmOzaL6+JM4DYQj4c2LDdekfSuZh9nXfA4IKXYQF
	lS0Bc6g4nDEbktfQghHZxOR5Kq0uStzCoMTgKvPeecl68WO3aKocs/9w9FsrKM0h4aY00BAUwNl
	TNgZpyEE5bOZzz/HPBkTEOK8TVl3tDpK92OMBg/BXkHbJ9Sr5D7KnvkbWsIz8Bg48Hr8EBzbEMI
	ou5zNRF4HqjnOv/0rj2hKrzKrLPqNa2zA==
X-Received: by 2002:a17:903:32c6:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b0826d7421mr72399875ad.10.1774122447790;
        Sat, 21 Mar 2026 12:47:27 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836744a5sm59030625ad.63.2026.03.21.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:47:27 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: joliss42@gmail.com
Cc: git@vger.kernel.org,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
	Jo Liss <joliss@gmail.com>
Subject: [PATCH] remote-curl: set fallback hash algorithm outside repo
Date: Sun, 22 Mar 2026 01:16:53 +0530
Message-ID: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
References: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote helper like git-remote-http is invoked outside of a
repository (for example, by running `git ls-remote -h <url>` in a
non-git directory), setup_git_directory_gently() leaves
the_repository->hash_algo as NULL.

If the user has a global fetch refspec configured, remote-curl
attempts to parse this refspec during initialization. Inside
parse_refspec(), it checks whether the LHS of the refspec is an
exact OID by evaluating `llen == the_hash_algo->hexsz`. Because
the_hash_algo is NULL, this results in a segmentation fault.

Fix this by mirroring the behavior of Git's main built-ins. If
remote-curl is operating outside a repository, initialize a
fallback hash algorithm (SHA-1) so that refspec parsing can
safely check hexadecimal lengths.

Also add a test in t5551 to ensure this regression does not
happen again. The test uses GIT_CEILING_DIRECTORIES to ensure
the command genuinely runs in a nongit environment without
falling back to the test suite's trash directory repository.

Reported-by: Jo Liss <joliss@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
While the fix was tricky to find
I believe it is a small one.
The debug Jo did here helped me find it faster than I would've.
I hope the test I added is in the right file, I had multiple options, but
looking at other test files this seemed a fair option.

 remote-curl.c               |  4 ++++
 t/t5551-http-fetch-smart.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..4c85e6b079 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1547,6 +1547,10 @@ int cmd_main(int argc, const char **argv)
 	int ret = 1;
 
 	setup_git_directory_gently(&nongit);
+
+	if (nongit && !the_repository->hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (argc < 2) {
 		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
 		goto cleanup;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 73cf531580..ed81e6b49b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -782,4 +782,19 @@ test_expect_success 'tag following always works over v0 http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
+	GIT_CEILING_DIRECTORIES=$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir nongit &&
+	(
+		cd nongit &&
+		env GIT_CONFIG_NOSYSTEM=1 \
+			GIT_CONFIG_GLOBAL=/dev/null \
+			GIT_CONFIG_COUNT=1 \
+			GIT_CONFIG_KEY_0=remote.origin.fetch \
+			GIT_CONFIG_VALUE_0="+refs/tags/*:refs/tags/*" \
+			git ls-remote "$HTTPD_URL/smart/repo.git"
+	)
+'
+
 test_done
-- 
2.53.0
