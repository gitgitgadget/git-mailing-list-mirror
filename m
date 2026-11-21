Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279155;
	b=H/xeWxMKi7kO9qw2I7hWQtIWmbGC5RKHw9lJ2q59U1zssaVuC+v3EbYXsUFuXB5CsdS2
	 YIHHAAJzdipeEzCRr6iCXyt181yhaUx4RoOkw4vhnTEIDjKhYLMyTcC6fnBH+6bAl24Up
	 EfDFkfB/+Dz/YUrqGbPQD5qCtLv1FW6cxC8c6VeVvY3Brpp6w8lgLtwoVMtQXLZez/wLe
	 PlYV4dXQyE8DZBYstvkaTsHJac5ZR1ytGkfPTqXD+60EcJvCbE2kLIzz90+/dpIibq2Yp
	 sEdBXorzv7r7dJsvHUQrtsmJ2PrRo/Uf5VDxvzRkrEUbpivnh+Ccnu/HuU4Uy8Lhf3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=eOZLHT4i5d/bZtO5yc0tUnRi4iqdLRpDzwMhbf4KUt4=;
	b=FyFq3BhzGtR1wv95twvbAUtw0pZY9dzdnXYTedGCzpF0ufgwIK/vnMmcehgOQbAMPPZn
	 lNFF3zbjvJKobf9w35yulC8iLf+7qIxagpxnk7Le/W/WMMRsdxip0uergr4ER23PnSMpk
	 OXQacEvE8oMUm/LmijGH6DQYKWUdX0BgGKbN8x7E4uTqC9MALo4oIbRWDF7yfYnmOnn9r
	 grxnxciDGaUJJP7qe450ZwlIBv8XTS6BoHUdOKFOl2YVG99YFj/FkloA2bgUAmsoUSgBV
	 hmApq/9BVyrUw/BBien87WDxMbmBND7FJKIQfHxb9lBdwtIYjFYL3bKvBLZ6YLNkNiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2+U7DYb;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FB606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230FB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2+U7DYb
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-86298f9267fso1146739a34.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 08:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795279154; x=1795883954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eOZLHT4i5d/bZtO5yc0tUnRi4iqdLRpDzwMhbf4KUt4=;
        b=G2+U7DYbWN8adkHNDoLtFs26LtMvM+z1TGsz7gF5ellL7+4EWOe4p0oxomgZPzoyyw
         yKFNeMiU9pWXzvJZ14NaciyzBIkjLlscE6CIBnsA+XFfZRt3b2oli6Jq/jjuIh9zreDE
         3Mf/oSA5LkTFUJmYnOmbGGbmutiX+tTs0EA2+/yAAJIi3wHg8HV3Tu4sq8jtZkM3SnuE
         3MhFcOg17+ANvazMPoK8uk6gBtEb0dVJL17L6Tv2FpEEBUOo+OCNn2t0LGIN3zWkLmVT
         OfkKgOFTgfyDK/CfucVMS8aG0HtlYh6Sb2IZxdPExL895LeU3fCv933T2oBPxQcPH1vE
         t3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795279154; x=1795883954;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eOZLHT4i5d/bZtO5yc0tUnRi4iqdLRpDzwMhbf4KUt4=;
        b=P4zDzW02yKwL630gdDo4C3SgnUb89E9nQAemhA8NW6NgNDyGyPyr6dgCf+MhTwKteh
         173Gis0VW/wv5Zp8ZhcatLCzl5FtJOzsgvcTLwmZHcYTFffteLdOpxiDywz6313KgnHf
         Wyxet2nGI9sKQlW4Q3IOdoh4Bl6A1RlnFzo10JcO0RQmV3mxHEtXEyq+VjcXVOVLVqwA
         uTtBMaEUr1Ga+SNUkLUcJxP/sf5aPJ7PSU6lKSM6S+8EYmrgn8wtCCbucGCamnXJshjc
         lQgkLFVczGeK8yOEyVPwUfcJTvYhhzkEYZx7UZEA2HTlqN9W5hKyqxLSscfRH2B5KSCp
         WSkQ==
X-Gm-Message-State: APuU4Z+I/ClDrBibRUQ5DfvA4EBIWLu0brtFLgyTVje94heuY6c6IsE5
	kvWUYGPQkBYBQTGMv8gF1RBsf8tchQDGdhuncSzA1JgHD/jwk8Je73Y/yr7CkEIs
X-Gm-Gg: AZFdTZfnvsjJA8ZdFGALyUMBkLPk2aSdZ3GuUONCh7CfIuWyPApXtcTfxntBXoVreWj
	ur8Lx6eXnRETZhLkTmTCI35k2G1Po524O/XQ+3+AE31kUpuaOKQumn4rZOqPi0LwKeUkILv8vkV
	mPJRKi3FRJQouLnIPUNJ4s4ljhH5nq9CYIeGW8elx06r59ZQCmA6f57981s78q02CSO2EyYCAHc
	8CrHQiWBVPd2HrAZEq6BvZQKLf9XfIfitKiB9wZ39abz6wZ+ux1cwXjtfVKaREdDs096ApmuK8S
	lb3dT+rVXnfwLashMrdTsKMloO+87gApRm60cQfh5fDBUDebkrFLn1yB6R+trBFiyM8CttebWKH
	wuJh3pV0R7lup6NhXC5C/AQ1tZTLvts19zwUN5omhJ9nnmZMsbu7/fMdxwM1UpkRcD67G3puQci
	OS2VpMONO10eyGcpLfXAkleC+YneBqq+WnukYFPzls79Lskmw/HhTE7hJAtz/+SSyFBulnr48oo
	nPbNR3X7Sza4Fcfd/14rrzS/dr1VmAQo1g2Payskl9APVQx3hYq6Xs05QfVWDi338ueZtdHnvdJ
	FkkRioGJyPtXVxFkX8z1hZR4dhbYDmPAXxM=
X-Received: by 2002:a05:6830:2b20:b0:822:27d6:c28a with SMTP id 46e09a7af769-863152cd69fmr7938376a34.4.1795279154053;
        Sat, 21 Nov 2026 08:39:14 -0800 (PST)
Received: from [127.0.0.1] ([130.131.110.171])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631670c44dsm4563106a34.0.2026.11.21.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:39:12 -0800 (PST)
Message-Id: <pull.2499.git.git.1795279151447.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 16:39:11 +0000
Subject: [PATCH] github: fix typo in main workflow file
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
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix a typo in line 10 of .github/workflows/main.yml:

Older runs are canceled when a new revision is pushed.

The typo is 'canceled' instead of 'cancelled'.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    github: fix typo in main workflow file

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2499%2FOphirBleicher%2Fgh-workflows-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2499/OphirBleicher/gh-workflows-typo-v1
Pull-Request: https://github.com/git/git/pull/2499

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2702ba982d..b2dd019b48 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -6,7 +6,7 @@ env:
   DEVELOPER: 1
 
 # For pull requests, only the latest workflow run is allowed to proceed.
-# Older runs are canceled when a new revision is pushed.
+# Older runs are cancelled when a new revision is pushed.
 #
 # For pushes, if more than one workflow run is triggered for the very same
 # commit hash (which happens when multiple branches point to the same commit),

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
