Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632939;
	b=vkxXU+33hbpIfq8xMyC40+671takrhP4FoCOWrlt689fwk7dcbijusAtA4hcJ/jAObqf
	 tnvwJO1rR0OjEb8TZDsbgIF1Iz/XSzbOBXi0oRT0kJvXfiuVzWkm7wnumdOp1FILli4Vk
	 w2WKeedcSmp8qYAfzDAPsLWJc0m4+9vHe23p7WM4kMuBOZEYZXnJyuZqm3E9uzNRanFTF
	 2f8LI5Y3IOSHd/rFPWv+g0AzlNQZbg7w5zF99i23lzkORAlxG1jCcJ/vYKwbB3BpT+fGz
	 FWrQY+f6+m4nYHjssmWDJMaFUlwR+Jdo9ICUo6qCf4RXTWI8BvKdsEU0TIiuk8eddbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=clRCMFEJE1M2Fcgm61MDGis+fGgIm26B9+FSa91O7tw=;
	b=XXjUeYAE2BQxaxbzis9HmaXqc+LXWJOLzhXve/IIi08cjrL7/WnoEhUyscQ8ppNxb9dR
	 EvVnQdQ/KtVvm6ikZjfSWgr6oanpMbzL5FjVwCiwzvf9YhzsrBOAU9M2wv9CB4whOTjxE
	 z3/hqDhOQXBE2IbAGdMWA9aQ/4+D7UwJQyTfG5uc/YEaJnKaxVd7zblkD0NB7haStFpwE
	 MfUIvB37m8yaO00yuez2eOB6IIEHGG5GqZJ7uXVEf8NOAlmkr1YY/kE50cITWpm/KuBbA
	 ZXGK/vTaSwYZq6aL6tUWj2f7WLyf1xGr/N5kIvFQjMZAypW7PHLD9XxYXowBoNIwjzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v6WUmk0z;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CA606A330
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B24CA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v6WUmk0z
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55d2b4a99d4so56445871cf.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632938; x=1796237738; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=clRCMFEJE1M2Fcgm61MDGis+fGgIm26B9+FSa91O7tw=;
        b=v6WUmk0zVdZl94vH/LdrSUarGQjqZl1Xps5jBlFDMvx2uciqGrv2ekz9Jg19iT4k8t
         xfazXtcXhKV3nYPUXBLzXsKeTn2Ie15whuhX//PMb1gvkA1nHw6SpD0YvZ/A4YQs7ydI
         KKt5ZyY5gHHWbv01PTkQwlx4zDK5KIDJjEZzXBTF8pl2fBLDTZKCpj3oZZo0zVWQz5wf
         mNlK1+itkS00EjjLT4QT3F6wkU2IOoQ/sSVK4ZGvCYMuU0HVhBiXaRMxu4qYQ4UfzBgF
         4FX67ovTjtZt5sVqbFWEuSQnVlk7KqnybPFwTTdvwy3E6ZjpwMMZVzPxtoiGTh3GsTha
         Sv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632938; x=1796237738;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clRCMFEJE1M2Fcgm61MDGis+fGgIm26B9+FSa91O7tw=;
        b=Ya6h7h3w9RUG9f08XmE2Vu8aW4dFzKt2PiS29MwIDWJuCjyZaHo1OyljypbfxX4GlQ
         sxLJV+Gw6zG4kO3pZJOnOZONYTGV++ze5vSQ8AAB9cX3GJwe3SM42iFgM/sHw9xksurd
         O2MMTYD7uRwc97YVUr+deWjfwlrdy2rO5m4h7ca7M4ILK3IA5zWZrfT91jmAZ7pRl3Pz
         /xj7MQld+L5y9rR7QwkuCUi53uVu2pzFAg+uyHm7miOFSJ6vMt00xR4HQdso2sUYCDW3
         676yItvLg4suQ8s9i6Ygq3/Pmn3UFk8khd+GMpjEf6b4z6btvJZA0qzVcCpMATOsisoC
         FdMw==
X-Gm-Message-State: APuU4Z+KcHx2m/m3hLrFPUXVK5KE7vANNJHjIm61FsTCYIgF3POer1TH
	wh/bs25LCJHIUIoo9yocXUq6r47VYZNNNhAn3p0TApjV3djpk+CJNcYKHWKCgrMT
X-Gm-Gg: AZFdTZccbnZeZQL8+w6bPaVx1tMt2Qny0r0ZTO7QQ74DXyfV+o0SUtSfOVK+rrnm3mP
	j18i5aiU5+DyuGlfy1qe237B2tO7SxTHfGkWZfYQWxb5G6D1poGK81wffdj/muibCBpvGCgKY/J
	GaUfs3GtxS6xjLnIZAFOPlF9W10vRBuOTmcxaCMOVXsSONxFqKajFIPLGMyTjJ1nDHmiXNKzFov
	LjE2IPkLGox23a8MgAVG8PUQOXF0VLwM/+LBI+48TFSp8J1rtunCjB3f/t2tbMEgW221plRvUHc
	MKDYsacc366LEHLRIdz2orhECnD1i4Q+tiE9Sp2WEP/PbYyk0YV5PLSK1Wk1kzN6uFTP0TJ4hEo
	zWr8j4KF9IcPHRv0FAwkuri9REC5jAwsoZaH48gPP73eDwmY5/5x3QHXhCMFYkMShy6iWdT/qwM
	YiZX1sj81+UswI5h7taGLhUa+Pu2KflWydCOGJ0JWVhdf2K4uen1POzjWMOvs0QP1WZcQWQtTlU
	220eafPLimQIxmIx/eZE6MW1bN2MHUMZIhyEVMrlJFpaW2R7QtUv9td+mRs/fHRywM+DA6DyxQE
	BY4f20MLcdBpUiMqlvOyw7K8NTgT0Ui8qw4=
X-Received: by 2002:ac8:5707:0:b0:55d:2c25:9c79 with SMTP id d75a77b69052e-55d76a87794mr336810391cf.50.1795632937594;
        Wed, 25 Nov 2026 10:55:37 -0800 (PST)
Received: from [127.0.0.1] ([20.228.220.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a08552sm167949296d6.34.2026.11.25.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:55:37 -0800 (PST)
Message-Id: <5140655d23413ea5e739ecd4f413b931bddfd5f8.1795632934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:55:33 +0000
Subject: [PATCH 2/3] remote: reject invalid branch names in set-branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Giving "git remote set-branches" a name like @{u} wrote a fetch
refspec that could never match anything. Worse, without --add the
existing remote.<name>.fetch entries were thrown away first, so a
single typo left the remote with a broken configuration and no
indication of what went wrong.

Check every branch name before touching the configuration, so a bad
name leaves the existing fetch refspecs as they were.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/remote.c  |  4 ++++
 t/t5505-remote.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 63d2db39fe..b04cbe70b6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1777,6 +1777,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 {
 	struct strbuf key = STRBUF_INIT;
 	struct remote *remote;
+	const char **branch;
 
 	strbuf_addf(&key, "remote.%s.fetch", remotename);
 
@@ -1786,6 +1787,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
 		exit(2);
 	}
 
+	for (branch = branches; *branch; branch++)
+		validate_tracked_branchname(*branch, remote->mirror);
+
 	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
 		strbuf_release(&key);
 		return 1;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 055fa42e27..4bf97db6af 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1454,6 +1454,20 @@ test_expect_success 'remote set-branches with --mirror' '
 	test_cmp expect.replace actual.replace
 '
 
+test_expect_success 'remote set-branches with an invalid branch name' '
+	git clone .git/ setbranches-invalid &&
+	(
+		cd setbranches-invalid &&
+		git config --get-all remote.origin.fetch >expect &&
+		test_must_fail git remote set-branches origin main "@{u}" 2>err &&
+		test_grep "is not a valid branch name" err &&
+		test_must_fail git remote set-branches --add origin "@{u}" 2>err &&
+		test_grep "is not a valid branch name" err &&
+		git config --get-all remote.origin.fetch >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'new remote' '
 	git remote add someremote foo &&
 	echo foo >expect &&
-- 
gitgitgadget

