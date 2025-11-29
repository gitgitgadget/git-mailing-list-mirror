Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE73311C32
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440917; cv=none; b=dix/w6Hww9+OAC6LVqbb7FWuU4eNwQ7Rs8dN6KR+mReTpXm02NQoVpuy7On34Z760oK16XJIp9X8zwEuVXLwNvSkS7xNwbcB/dySX+B3//IokNO4dq68BzUNH8bOrFdOii1WMmqpi7A1pT+jb3gxLj4D2iuGSIgWaDDk6PILmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440917; c=relaxed/simple;
	bh=Lf70IrQ3ol3KZG+idnHjNXu81frgqbunrLtDCEJ2OTQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aAw6jv6H/h23Vb1xGE5xkmIBuT6IaOf8G8TNhGCDkIOmCdgeJoK/DYzYFCPzLjSQLV3XHGHkHO5ymOV6BDo12wjeQLs1ateV4gaTt/hVKSWb/yDeIz1+PkQ5Q1UFFOFdGFdJS/EPeLX9mpGrLK08m1W9krj1Fkn3fKkr55hknF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9y0Xbgo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9y0Xbgo"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8804ca2a730so41504046d6.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440914; x=1765045714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JguXv2ajevZ5eRBI/Y5LeUeUHUbQzHIYKPvvwXFn5vI=;
        b=T9y0XbgoQTrO+sDoaqLJwkcDcS+KAEFhPKN5feDYmTOL36ENutPPX9QIYH2A/j66J6
         vifurjEVLz5sFo1tKO+NjTHc1sNAsMnaRucLYMy0PXQg8q+omHyexZSeBiuMnqiaT2hJ
         tYnt0YG+PG9pb/MYEQMgBy3v9w6XB2+TZfQRVep+DFMrdoCs9wU2bEwQzkz+ohB2jTff
         GcXl0pGmAVwlKKkSLg9ILOeSPoxqUSCsZFjEkco/XS2jBlLjeOAQMALMvhmaytgq8o8d
         vraBpjlPNpMeF7LLF8fN7TAplipYRmcXlY8aeCSsFS7XaCsLELwAIGnkHwC8rl9+QMVf
         6V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440914; x=1765045714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JguXv2ajevZ5eRBI/Y5LeUeUHUbQzHIYKPvvwXFn5vI=;
        b=W6LtWenffdFp4WpAiShtw70TG3MQk/VVtUrfjolh1hQddceps3ps4l3V11KwDFyP0R
         i9RkiFCSMdIeXErhTt7ffUWUZ/bIG3qnm7ohbQ6ArGf4XNvpGU9iSwxMJHnUXZoXPvhC
         F8g/C8jipmQYZWP23+/1dq3fSlT4dpiN/Vcyp52N6IA1et/7wzG6XZNPY4rGiFw7fcxC
         5yiJV0XaNBD8T9CE1yXMWXM6nA3gmxQ4utCIKNB2S3u6Kv31hj23AUrQkn6d7oBF8lOX
         aPX0ds5Zm1qJDc2B2DMyepleyemb9kn/XcsYT6P97mjY3KhF3xpXcWoGR8cidBsnmriy
         O7DA==
X-Gm-Message-State: AOJu0YymoEkqK6n6mCjx6dckXBdWOHAvk7nZfaFTZaDB0IQKfq3AQbY/
	kXTKvVIxTpAxZTikl2iYsd3cuaWgN4k3jNQGe8keK7iivPLrLohoeAHE6BckLA==
X-Gm-Gg: ASbGncvFjbe6WiD0wzOseSw0aM1fs5Nbjsjf0Dy2ttSjaPSSAHxAy/KbYbmYqSDnxhZ
	wsWBjfm64B5jP0MJOkk+NPmnO5l9cAUQInk0HxFA3MhGP6UDuLiFJMqFeZParbiszioSxQ8rTu2
	lKUFeP2ubO8lGo7ygUxaDJgYOuDTfEbxSxcsmUW+z2sxDR+RTMQnYJun3dPFmjaYtd5mCKiQ8yh
	XNOXc7eTZfCPRBbKpU4Lh7Rach2pxEDDYVVscxMYGbSm0QpbS74zCfoo8D39+Z7FV4Ufrl7GZEv
	H4O1evz9eOVxcg+b1ITQx5KUzXB88UjUrAaRRSnRdGqHJ+euSKZ3Uruf18aUjkIqVK34ZJ3pDnb
	3CjlSrKEgMX6+DR4QTFQ82C0zozLM/ewe0wMu2GGqC9QWcFyUfU00Z3W2uuYRgICTASX+eFU1u2
	HBpiRIifLpaKtk
X-Google-Smtp-Source: AGHT+IGIKqr+yR7HQw2fnHXztq77pd5fO/dkPJiRhpo7TndV5ukOSSio/MBwTXmUUa67SGnh5aekOw==
X-Received: by 2002:ac8:574a:0:b0:4ee:2420:4f7a with SMTP id d75a77b69052e-4ee58a60fcamr451261971cf.2.1764440914278;
        Sat, 29 Nov 2025 10:28:34 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b6cc1bsm50919506d6.46.2025.11.29.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:33 -0800 (PST)
Message-Id: <3be9594e80c37b2b393f5883a173694ab6793813.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:20 +0000
Subject: [PATCH 04/10] t0001: handle `diff --no-index` gracefully
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The test case 're-init to move gitdir symlink' wants to compare the
contents of `newdir/.git`, which is a symbolic link pointing to a file.
However, `git diff --no-index`, which is used by `test_cmp` on Windows,
does not resolve symlinks; It shows the symlink _target_ instead (with a
file mode of 120000). That is totally unexpected by the test case, which
as a consequence fails, meaning that it's a bug in the test case itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 618da080dc..2f38e09b58 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -425,7 +425,10 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	case "$GIT_TEST_CMP" in
+	*--no-index*) ;; # git diff --no-index does not resolve symlinks
+	*) test_cmp expected newdir/.git;;
+	esac &&
 	test_cmp expected newdir/here &&
 	test_path_is_dir realgitdir/refs
 '
-- 
gitgitgadget

