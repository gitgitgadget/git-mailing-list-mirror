Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931C3570CB
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071571; cv=none; b=Zuovn85kuyJ7jPp815YJBjtsfNzIU+EN63uNojgbQ0rpSruhNaGmOkLDU2it5dbQtTAtytJj/uy/C+j2p+u/Eh4MoKSGooH4mMHetA5ygmNXdH6KxFFjM6wNdAHK7hXEHVFhQTlSYdP8vmSInxXPjz0stVySUOn2eu7kyTenbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071571; c=relaxed/simple;
	bh=fq38c43TIZR77A71Du6tjgtFzDo5PVBdHHEjECtnoNM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=X5jfKhkh2ee/rtAGr4QyB416gsxfCR0AisUMQMK/uRGJFaytskvHQaj/mtQDo7E7tDfF/1RCfqzZe6AbFpo0RHXf+8h0t7dmu30lRjiSP/4fOovx4Vy6aoiyUw6WozBFlZFhOhIM4NpBEN5P/rdtp6PPGHPShYJ9/M0puPl1Ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyTJdjdc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyTJdjdc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f121c00dedso1002952b3a.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071567; x=1766676367; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2cVRiq0+eBNhVmCaSAArf1DkiVVVDofu2FHwUZ2Iu4w=;
        b=MyTJdjdcRHep6bmr1MEBxVYwDTkB7TS0OaciBtrKmzTH49Weq/Fz4Uv/qzG2p/oBv4
         AkslNxxvdYLjDPs6T+/gxXQNRm0cCJzw8tRcG3MqxCe8rjblxE0pzKXgoUjSXRf6IFCr
         yiRePn0Rd3RitXH45CpHEfVqK3Jn7NbhlNcQiBwboWY8TzQdTeLGUDgmlr1Djk7axGAP
         djbxeH6gB1lZYvOXbXnDXFmyc3nQ24bpyQC4O1XtoafMPMuj9YwQeCVmPaQOMDbs6k9g
         Fmkulj5ZUN13iqNBj4CYGh7TI3RcUCil2NcwXq36mpf3FSH+wc+oQa0XR+trsO2Jgatt
         6K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071567; x=1766676367;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cVRiq0+eBNhVmCaSAArf1DkiVVVDofu2FHwUZ2Iu4w=;
        b=e6bYmz52kzudk04MLV4tLyeOvX2cPTTxl2vnJ02yLBUwtP55MM7oGmWLFcpvqGn4pe
         Q5zCIGtFQgTPBD7aMLGCQ4LXQoMNxG8PZApSNGrgRvkuPwD6s90VpULn9Tj99EmOq1Pu
         GSXhGCz53ndFAreAvJIeVJ8W+K/dLF9B2QD58/4CliycJ1x8qfKQYi9+muRZsyXO8VbU
         9CuQ3MIhM+idpP14fPfQ4aEOnLzsmW93qu8hadSdQ6nMJWJS+WmxJTsReR6/ZJb3TtAD
         AYt61FxJOYvW0K4OwQxTQLQIbZ5772DyTwHaz5u0VsA9JeK5SFvacp56929utmalb6ky
         dxrA==
X-Gm-Message-State: AOJu0Yw7u4d0QccilOrlCRWI9dWM3tQdbBexxXbjm0tb2CiNYfUJbwiw
	tXdL+RRCrvid0KgPDXE6q7C71WgvBitl3IKErjLE5AByY5ZKw1gpvqmGif4yJQ==
X-Gm-Gg: AY/fxX59zQfJEtEsIjQ7i3Zqv5Z22eVrO4P2qeebBvt0NQAS+VMYwWyTOkPHqBy8vvt
	FJY+npAFlGsigyNLDPJk9zut5NvEApNPgDz9vEme4pBqstfaWy5b4aKc4Wwf2dV4sC3K8P/xIVj
	bXbfPyBYoQg7Ki6kwBnj+sQpbFKkUpHw4ZY0Tr6C7SeeymiTgHXk/tr5gW9K/mY32fOcjCpHmCu
	Ut8wIKYNkblCuAh1BJfhqGM+2hZVmujQLaM8dQiJeWMpXF+E4ZhC626VsM8U0Jy7XT8mJ2G2M9y
	rQJlcfVSYyq0VFrbT8J0JUcyuNkXNlhycvADS1rVZsi8wJLDkVC8fFj4h79RRzNIcyBMTm7QfSu
	m7gsjvPX/f2p0UUdhG8KeLs8TULXI6+K1JLB1A8bUelG/ggKLPMIKaMWfEqRKJJc5MwxByxHeTX
	OEL/+Um9ASC7xC
X-Google-Smtp-Source: AGHT+IE2iAux5lwREGEmCC+G68D4CQAN3U+ZvpMzEl20WMokgZ9fww/INE36NUB4Z/Sp0X2VoXswug==
X-Received: by 2002:a05:6a00:451b:b0:7ef:d070:df1e with SMTP id d2e1a72fcca58-7f667447776mr22033746b3a.3.1766071567282;
        Thu, 18 Dec 2025 07:26:07 -0800 (PST)
Received: from [127.0.0.1] ([52.225.29.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1456c6cfsm2957500b3a.57.2025.12.18.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:26:06 -0800 (PST)
Message-Id: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 15:26:06 +0000
Subject: [PATCH] repository: cache->squash_msg is freed twice
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
Cc: AZero13 <gfunni234@gmail.com>,
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

Thankfully, it is set to NULL, so no security consequences.
However, this is still a mistake that must be rectified.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    repository: cache->squash_msg is freed twice
    
    Thankfully, it is set to NULL, so no security consequences.
    
    However, this is still a mistake that must be rectified.
    
    Signed-off-by: Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2132%2FAZero13%2Ftwice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2132/AZero13/twice-v1
Pull-Request: https://github.com/git/git/pull/2132

 repository.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/repository.c b/repository.c
index 863f24411b..c7e75215ac 100644
--- a/repository.c
+++ b/repository.c
@@ -349,7 +349,6 @@ out:
 
 static void repo_clear_path_cache(struct repo_path_cache *cache)
 {
-	FREE_AND_NULL(cache->squash_msg);
 	FREE_AND_NULL(cache->squash_msg);
 	FREE_AND_NULL(cache->merge_msg);
 	FREE_AND_NULL(cache->merge_rr);

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
