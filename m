Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E939AF0
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766069; cv=none; b=bVJd7+triXIUP4PL+EbTlTpqefGlsiMFwDiFS+lTIe9gZTKN9i2QOKO4sLr9ljo6vXiroQdp7zu3Q5LNdx+gCUWIFdkEdycTTV31GorGSPV0Z0EtY2KiIPYpm+HE/73lm99JS86RS4c0k+io8crncqMzuEx0GO2d/7gMdwFtmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766069; c=relaxed/simple;
	bh=zBJ1zUtEHegQeel+RyK+eV7+jQVOFf0XNgJ+2nUKp30=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UDG8JewQMlRSEwo4gPZ/Zodls/fkEbjSEffirzrtnZb62M5hz+szoNNapG2COonrBc1lvVpEUzd7Njwn7I9hxUIDMan5xGVOfUTZy/AahcSdblZOGoPnp9QG8yZLcrF8AkLEo2eG+QgRKyu9wOTKBRCO9aibilMp72iMYpXAQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH6lBgdx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH6lBgdx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341808b6217so171220f8f.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710766065; x=1711370865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlgwalGyk2TYHmVYB4Ipx/CZ8UIhfcN9B8A0op3Ix08=;
        b=MH6lBgdxpfLHaTXg0nIMGT9dR74biwqKXUYhOvN8nGZ1QLUv4n1iwXwUiWoSmAQmrN
         PXGSRG83e8UXTMFWo+EnjcMIfrg3JzHv9d1Ce+rI/fnAuv9/3LNWerkL18BDY13rKY9e
         cb2HwhwOsZwuk5SO80z6PbTFrFT5+Tb1GMbBW+t+fczyiqL20Jprh8l0oJ+ur5cE0hCr
         QsgWSsBMssDltz6ZKSl21Ue5dYStgsLGHE9wgwynIzAp5399sn1iJHb9cX7n1FS87EmJ
         nD5bDtUbJav5WQtzbvldssfGNPaqJ8SAIBMA7x6kg/Su9Bv08I8R0dZ1KhpH5TXH5NgH
         zUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766065; x=1711370865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlgwalGyk2TYHmVYB4Ipx/CZ8UIhfcN9B8A0op3Ix08=;
        b=G+caxivpAGuKRyahpMP84kmrBtlyulGrnh6zMsPF/Hu7SkcpRBj8RyNji940pooGMn
         T51VMs15N4RM6XzeVXxMYmFh4ui+J2Cq7bpEjommvPLnUEfGs+qhkvM4yU5xIMoIPZof
         QYdrKRuhCaA/jN4G3WaXq8N/sF6imb8aLssFfEamSlJ6nipUXVdBNSS0VYJ2hcTLQa8n
         +RocaAPl1ElWNev3Mp0Pd8zpQ2TJuLXiC1fI/l8PQIcl+f4i70RkxGuTWTpCZamyVIeQ
         7dXQV6O88Ht6oZRhmsN0P0z0aNbjW6i2sz1cOJvjqo05VEtgCeO1TSGtUU0D30UxgnCG
         ipGw==
X-Gm-Message-State: AOJu0Yycwm3QUYNOwCYEm+pW9zSF8alUE91zCd374dJZ8zOXaMPtNawg
	ySS0GcBJpGvG1BCZd5XoXJV64rP5hSszzE10YImiBpVJu0n+1Q24in9zVjml
X-Google-Smtp-Source: AGHT+IFmJCZS5kF1cJoWb17h8laXOm0vFxm0B39Xr1Ubi9YTFWU51rUFU8bL+JZJWKg6JqEpvbRXoA==
X-Received: by 2002:a05:6000:a90:b0:33e:4238:8615 with SMTP id dh16-20020a0560000a9000b0033e42388615mr7930626wrb.40.1710766065572;
        Mon, 18 Mar 2024 05:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4704000000b0033e7603987dsm9747214wrq.12.2024.03.18.05.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:47:44 -0700 (PDT)
Message-ID: <8a730b6ebba4111aaad4e8fc938c52f6e7e54480.1710766062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
References: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 12:47:42 +0000
Subject: [PATCH 2/2] test-lib: replace repeated code logic with an existing
 helper
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe@proton.me>

From: Mohit Marathe <mohitmarathe@proton.me>

This patch replaces the code, that changes the path separators,
with the already existing function `change_path_separators()`

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 t/unit-tests/test-lib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 66d6980ffbe..b0e26263046 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -52,9 +52,7 @@ static const char *make_relative(const char *location)
 		prefix_len = len - needle_len;
 		if (prefix[prefix_len + 1] == '/') {
 			/* Oh, we're not Windows */
-			for (size_t i = 0; i < needle_len; i++)
-				if (needle[i] == '\\')
-					needle[i] = '/';
+			change_path_separators(&needle[0]);
 			need_bs_to_fs = 0;
 		} else {
 			need_bs_to_fs = 1;
@@ -88,9 +86,8 @@ static const char *make_relative(const char *location)
 
 	/* convert backslashes to forward slashes */
 	strlcpy(buf, location + prefix_len, sizeof(buf));
-	for (p = buf; *p; p++)
-		if (*p == '\\')
-			*p = '/';
+	p = buf;
+	change_path_separators(p);
 	return buf;
 }
 
-- 
gitgitgadget
