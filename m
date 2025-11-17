Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60015314A6E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411988; cv=none; b=CZ6U+P7K3BflhcqgwW8aS0GksMfqmFFkb+WgF59oGAEPpdRQYEbgOnH7kk4qnV9aS2hyzsb1I/9butl/03Z9Q8xfw4d9el45V5VlE9otYGIfGvyLVE1Kq7SEKueN9sV3YHNQ7S0ezegHpNjwCuoehbAiwGlcwbq3YmU0D4YK/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411988; c=relaxed/simple;
	bh=I2w+f3gyk9nQTaerNLIpAAvH3IRVzRP5k83SeTm6bxU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=l3pwPF+P9Y/8vypVBn3DSpr4uZLlLUzqGiZSIXl6ljbP/BMbda+l7lQdLmH9CJZ52r3YBhbX7Hlty9W0v07cZ0N3c+WzVWzTOLegDXPXoe4l2bTov3+p//TbE4RPiqdK7P8npFvEFh10d3NIqvIGLrdelrxwqbS2WXH5OH8f4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELmg60Aa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELmg60Aa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso19188421cf.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 12:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763411986; x=1764016786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=joXTCSDJNeleS53imDVnbgj+oJ1hXPSntL8EnodZGXs=;
        b=ELmg60AaXIezLOTzehazCxlbWhdwpFnBCLaGbkP9ucGPl2yDnXlmLNmKkxl6iZX6eK
         VOSdqarhh6NfG+sUPlVD5nVv9eXqFGMXKai2sshNU9pSFRVDqAG2pp+F65HrKwX6PGVk
         Lu4b3a0G6DtbZdmPPvFqHmokQTwKk1KFMcBUYvYb/cJFkb07qtl5UugQkGySdacwKRa4
         KEk/DGS5dvZfzGTKrgp1aX5Cu13dM5+cbrXQtHPMqfLXr4Ixj/8vmy89W1NqVpfgGUrN
         JGLM8D5uF5pnQoaHAiW1+rD3uPqgzmjt3PN4LT8RxbtSgMeq+m2kp+SgljYfbYdugSrY
         3lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411986; x=1764016786;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joXTCSDJNeleS53imDVnbgj+oJ1hXPSntL8EnodZGXs=;
        b=ksZ4uNfaPov2lQKJxXrE7qiPeSfnzaym1WiLuE775gUzRKo7S1B1wUZZ436VXQyQSo
         qogkzVOsmecTWLy7yjoTLiyCchrIO0QQLxHI3uNg/CAkFmfbIfV2m4rLJHzJ4wAqw3St
         9mInLmGQTm41bc3LP3D1R9wRx3AoXCEeXkpzvGou/JtLND8WAsoeo7oaTBWHEi56k7rR
         y20lV/+naWz5AabCt2SA+Rm4aSzry/EBeByWn/geERQg6ldjxMDxRubXlRyHzKEhPtKN
         d+u0su53Uyb0rlCicWX5voJk3lJ9cbFgQ0/N9sbZpae7JJV5SIKOXllKX5IeOT0Loa7v
         bkaA==
X-Gm-Message-State: AOJu0YwTY2T3dM7DQki2esnT0vjHeAco0xW92tcJQAdobG2QqkNX5EAm
	yJumvbp5TaHagxvS06P0VBBbJ17psZxUJRDdzK8h76fG6gT+zrQGJ5gvVC8lyNYw
X-Gm-Gg: ASbGnct1fjPgcNye0/Fou2Ci/JuAc5aMhORemzCrq32RizhlL5Jbg+kWgdF6tIasXJN
	y2hu3Jnbu5nmxgFrIrMXLSvgY1qSsScqyTfjELfy7UbCITq6x99v4+KvKW4RDnp+dzXoGMFEgIh
	A1/qqT35jwpr062VPhaybORWga3sIxVzMaAeBo0xuGdw+Urm0pKOgbDiYMet148PUbnYRFvjCSu
	2J7xy0TITffE/HMDRy5ztHvHv4kbf3loceZ2BXHRGgen1YXGJMzB1gWWjNG5nIKfYrnhn2qlbG9
	1xbJ+Dp0FUlPAfqzLlnvZAVZho/kL9mBAfrE5Cvlc0AHc5lD/M6N7/+nNxUAeyJzvSbpB9RWbzr
	TGDOIfeeuPxb5X2v1peQ0lv1xmVvj+LZE25cRtwicArjK+6ZCCS1hvGUjJLUY8s0SbGMQMR+sAx
	H9ZQ==
X-Google-Smtp-Source: AGHT+IFHccprCSRYQ525GrFlCObGumcpDVIO9wg6rbFfbpmCipCKe2hPT3c2Q9Bw6CY6M48guwy65g==
X-Received: by 2002:a05:622a:1ba0:b0:4ee:197a:e809 with SMTP id d75a77b69052e-4ee197aeaf1mr83395171cf.75.1763411985753;
        Mon, 17 Nov 2025 12:39:45 -0800 (PST)
Received: from [127.0.0.1] ([40.76.181.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b38besm91014851cf.8.2025.11.17.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:39:45 -0800 (PST)
Message-Id: <pull.2005.git.1763411984773.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 20:39:44 +0000
Subject: [PATCH] wincred: avoid memory corruption
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    David Macek <david.macek.0@gmail.com>

From: David Macek <david.macek.0@gmail.com>

`wcsncpy_s()` wants to write the terminating null character so we need
to allocate one more space for it in the target memory block.

This should fix crashes when trying to read passwords.  When this
happened, the password/token wouldn't print out and Git would therefore
ask for a new password every time.

Signed-off-by: David Macek <david.macek.0@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    wincred: Avoid memory corruption
    
    This patch wants to be upstreamed...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2005%2Fdscho%2Fwincred-Avoid-memory-corruption-5856--v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2005/dscho/wincred-Avoid-memory-corruption-5856--v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2005

 contrib/credential/wincred/git-credential-wincred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 5683846b4b..73c2b9b72a 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -165,7 +165,7 @@ static void get_credential(void)
 			write_item("username", creds[i]->UserName,
 				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
 			if (creds[i]->CredentialBlobSize > 0) {
-				secret = xmalloc(creds[i]->CredentialBlobSize);
+				secret = xmalloc(creds[i]->CredentialBlobSize + sizeof(WCHAR));
 				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
 				line = wcstok_s(secret, L"\r\n", &remaining_lines);
 				write_item("password", line, line ? wcslen(line) : 0);

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
