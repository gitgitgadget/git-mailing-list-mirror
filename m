Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1E39A10E
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980551; cv=none; b=K/3FlW51V0OgicGgGiDh7Ws3HxvCyE07QHo6rIHOVbX4edeOugEGKMgzS3FHdCJW97aiHIZl2o95TD6OfGy95lRRGAuJW0ldrM7y9uo3z1Diu1mTiiqLErkavXMMwDs7wfeS40RccXQ+siO6sds1x17yRmNTkBjZ4hCA757tIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980551; c=relaxed/simple;
	bh=UHUdc+5HKM2zqCG90j8HvByjSnEu8LykvUly/ZoyZEw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g5vgyiQx4khFIzvlM8+NrLv6P3HDBct6tQu0pMScB7LbJX8nm4Y7nUa6qcWkwfe6QNsJ2w0H786cLOSEA7jlSD6OHK1NUgeQUaf6IzB8ibAM6PBINhDYHnmaSUII+2Ipx5NRiobQHMLuQz75xCyDAESSkdH5Vg3clAzSB9Ilil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJVzEe/r; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJVzEe/r"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8888a444300so44890816d6.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980549; x=1766585349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGRHv40lr0XchsOgcOf/KFWtVkYYKf0VA8Uv/mRJJDs=;
        b=YJVzEe/rvF5yNmVzC8syGd3CXU1c/KZzVyVFDdLJcpT3bXM4mzYeKngxExVDDMl8jr
         afSm/zAAb3pJaNNZ/PW2g6j5zaqhsFr80PgkPmxmTGtvmcNtoB7CyHUR3kzHWRkfN8Sy
         xLogyrjwXQvmzegvFF3/5hRgxQlsryTTrHKJjSEc2w0+g6Qc1w3orpAZbBtvdPe7s3Ud
         OvBxWw5dY0AA2qnAJCWHm5fawKo7V9hRAWlRotngts5E7VGoe2qV7AcBDd4GMwAs/BAY
         MF+M0QBG1GASer2WTiMyDw6YmmUVZA1TGbsw2t8O/oWFEku/h+OrmBmQJ/Fsd4qxCKRh
         Ks/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980549; x=1766585349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGRHv40lr0XchsOgcOf/KFWtVkYYKf0VA8Uv/mRJJDs=;
        b=Jwdj4n9NyIFKfqpTcEWG6OqMvXQICJUbfVPcMDlvXnv9GaCe1E1KJGp7/Fq2yq4gs7
         v/YzHCSTMz8+6zVBLGxwYJpPablMoWDYdE6BJa7XoxwQtHg95rkmUOH69Pwtdv6T0ce+
         eFzIqS2pofpscqqEP7SM78TzC9gS0e6MWV8U8r2Q0p0lx7+2GDvsg0+H7r+DX9jGFUEt
         Tc4y+9F6iLzR2nr+qUg77iWIhhcm5kvWotegsffUDzU7mWEYg6IC3/xJ5c+UXp2S1eAY
         pmxSrMI1OWtPVZH+Ih5lAuX9Sgw+J2DBA9u6JUNCXVIpCqtpDJdKTw8xZBzrg6dXoPSU
         Pcxg==
X-Gm-Message-State: AOJu0YxovRKjA+YiMWlKfqNQBZ62el5mfVHufovaSzy1pWIXA5+S5lQS
	n0oCVFmudqdKhTbW5vmPI6PRXqX69yTOSe+6crNMoc3qr3wwtdhJbJa24ov3Am1y
X-Gm-Gg: AY/fxX6+FKfK0HEgYfrWqbABwA6b0bRI2cAIThKRaU4/d2Fsr/S4EsnSf0c0DUysbiA
	Z/Eo5VhomRDgqmKMp51cF5ZeUNi6jXw6fetaCkzSZJ3vmvmCob/izOr0/alN4sS2R6JM6VfdhnK
	L2Vp4LcArpcs4SnNTwAALd2YpoD+VH2pedYcpg3aosqq8hMdADHvw/uYfNQ6kOQsMvRfggniX1+
	WDqBLmRqZHwjNag/X8Spuo2Oz5RTB7mnOvyto7OooJm2Zwhx8333Qi7N9nlse8ZzyD+T5geAno6
	IirVuMh+ZX8ehay/5NeQa/BXuGiyDL+zMgr5nvH2UfZf+rbCVZPMez5IlmtOEABCK3lI9Pylz5v
	GRGeLhuXq1eiDECmr6q9yYY9Hcp1dSapQ/JCa+/xZK1jy81SP6iiuNJHn4LITyJYSTHgxQyniHk
	uLmtiynXwy1Sg=
X-Google-Smtp-Source: AGHT+IEKDLLyIhhfInj4et7UCf95ClJ68Lljh+cz7K5ENgOaGGN5ts3+l4NXLmSf+cK0THU0qCd8eQ==
X-Received: by 2002:ad4:5ba8:0:b0:888:4938:49e7 with SMTP id 6a1803df08f44-8887e17e188mr261697906d6.71.1765980548798;
        Wed, 17 Dec 2025 06:09:08 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85eaabcsm95723626d6.43.2025.12.17.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:08 -0800 (PST)
Message-Id: <282aba42e8aeed336318614523ff8b36d3131e5f.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:47 +0000
Subject: [PATCH 10/18] mingw: handle symlinks to directories in
 `mingw_unlink()`
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

The `_wunlink()` and `DeleteFileW()` functions refuse to delete symlinks
to directories on Windows; The error code woutl be `ERROR_ACCESS_DENIED`
in that case. Take that error code as an indicator that we need to try
`_wrmdir()` as well. In the best case, it will remove a symlink. In the
worst case, it will fail with the same error code again.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0e8807196f..b1cc30d0f1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -338,9 +338,16 @@ int mingw_unlink(const char *pathname, int handle_in_use_error)
 			return 0;
 		if (!is_file_in_use_error(GetLastError()))
 			break;
+		/*
+		 * _wunlink() / DeleteFileW() for directory symlinks fails with
+		 * ERROR_ACCESS_DENIED (EACCES), so try _wrmdir() as well. This is the
+		 * same error we get if a file is in use (already checked above).
+		 */
+		if (!_wrmdir(wpathname))
+			return 0;
+
 		if (!handle_in_use_error)
 			return -1;
-
 	} while (retry_ask_yes_no(&tries, "Unlink of file '%s' failed. "
 			"Should I try again?", pathname));
 	return -1;
-- 
gitgitgadget

