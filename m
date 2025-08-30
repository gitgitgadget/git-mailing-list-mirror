Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D781258EF6
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553500; cv=none; b=FPaNeqwmWUUs/eVyolQ7KpxYRmuOy1rFPajALgrb4Ny3RnISEvgC3TcAhVYZ2pZXDI3ccKg1QvZ5ZHEEGVxn/cXoX036pxKF5AIoghqnB33bmOaqAwqFoVKQQOTlIzsRrOm3um7pfFsf+yzR6tqzOKUg4YBSWASJPZiqdy/Di8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553500; c=relaxed/simple;
	bh=/Vi9KpqWFO2teVk3ZHtWK+rsCFtp7SwdjtAFUAqU2b4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=m6laFjGzU8d3PE3Injm75FuI5RKiuPlBxIFXApbO4vwc39jeJrUGG3C3jc9k4fQRDeUSeKVJztV5XMwvtryLva81p2mGMHXw2BYWmekDZoiKnBhPtF3NsN2KRUOCS9A+0Pip5BRW6HnVe06HTCKeBtm/9bdFYNc8r22oK0Qwm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpu3Z1Th; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpu3Z1Th"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f861f89313so269563285a.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756553497; x=1757158297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u9K8RTaYrgTMFZzQ23BU14/4fXbrwesK9ztURcf/3wQ=;
        b=jpu3Z1ThAJbV92CiuVicoc22c6hx8gXXlzFKTK+sIzkN8klRISRVTOFXlUGNCm9ZXY
         3mNufohYIY9NTKVIPXsfBNOE5nDg10RIa9R2htPdn78OgWztM9lEdaTzUnS9CuNIaDQk
         pU5nkXiPKnumgOgUhoytVB8SlP0XQIEj7cytegQugiE6FP3d+sQjqHthSo/deWQyBru7
         O0MvlZLbcWKMKxamPWlqOE8rRf9Z3IzPi2kQd9yQg7jRa0FbtEu9KuHO0uZ+7faF+uyb
         1XkwOluR01mjr9ylVU7JN/uqd3/zBOnN0BkgXKGWnWYrqNGaiwufQ7dwnbVJlg4rcO25
         lujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756553497; x=1757158297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9K8RTaYrgTMFZzQ23BU14/4fXbrwesK9ztURcf/3wQ=;
        b=NY37Q9H2HYIdPHuqNEkDGJkunCkCsWckdPlyRnp5V1r7hW1oqwsFz/Ycfs7XgJvnCd
         H45sSNP0mPs8G6NFtFj/7cXLXXP1fQCNUH33usUcE3ouFCjVoExpRp/mv4Kp2m55ZfID
         Lrxcqx/wDGrWfV6ccnXTgZO+VAvlWijuIJxso0MIW3WYFYitpk3dPrwLPJv6pwlFojhe
         bIrZW4GvBseGCOvMcel5ouMDA2cPn1afagNs/6hFfkGgmODKU0CbgqkeRR7ZpjknN4Gg
         Coinl+X7Wxf5rFQl3JXGPBLU8ZZszbJcXbJhivpKz64mK4SL4NGEaHybhVm117x3q15O
         60Cw==
X-Gm-Message-State: AOJu0YzSt7HwWDGJki77Pf6kmZXeOcvR4NtKnYiRJip1ZK1V/bFV0OSY
	ZsRoiXir9jn8AGFEgWawJUe0PAckMjZIYKOp1A2ML+6KOvHVqA76RLrD7oDAwQ==
X-Gm-Gg: ASbGncsOU+ftan3ymTbl1TUB+2uA4loxw38nIsP+zEARsZvHWfcEl/SRsZqjAaZ5Fwt
	b4iZD1rjS8ZKph/YPQBz1kEwL1NVYtFUg7oXNIg6+FVy2ndsRsfJREPxo27z2eTYhlPtezzVqjf
	SkPWELvaHSd5Oc9xw0e55r5GzErZdwaI377XD+nLRBb/YfD/TYJySBauxAbIIrWJaNFMRK3Ut3X
	oqzd8HJJfX6NyVVAoI9hjK56Y8A93x9Zoeu//A45uTIoJI22DXN4BOmFL+xfUb4rM2VoaBBAFK5
	Ke5+h13wBNcQV+ngG9PfA36kvFYVhMxIkmkHotdUazInKwd1tUyyO3qnXn/oYGpGoetik/C8rQW
	i1AZZU77jw8DPdEI2nJodePixYc5YdrLxWw==
X-Google-Smtp-Source: AGHT+IGLw+7+4kViqt9mDXAEcQFPa41vw5XVkh/GujFMp4xeyh9v0LiYsDrV9btAB1wCz3FoAjDzuA==
X-Received: by 2002:a05:620a:1a99:b0:7fa:a4fd:6f45 with SMTP id af79cd13be357-7ff2aa22387mr196688085a.45.1756553496635;
        Sat, 30 Aug 2025 04:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.151.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc14849559sm340498985a.41.2025.08.30.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:31:36 -0700 (PDT)
Message-Id: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>
From: "Seonghyeon Cho =?UTF-8?Q?=28=EC=A1=B0=EC=84=B1=ED=98=84=29?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 11:31:35 +0000
Subject: [PATCH] add-interactive: reject malformed numerical input
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
Cc: Seonghyeon Cho =?UTF-8?Q?=28=EC=A1=B0=EC=84=B1=ED=98=84=29?= <seonghyeoncho96@gmail.com>,
    Seonghyeon Cho <seonghyeoncho96@gmail.com>

From: Seonghyeon Cho <seonghyeoncho96@gmail.com>

The list-and-choose interface accepts malformed input such as "2m3" and
interprets it as "2-", silently selecting a range to the end. This is
misleading and makes it easy to select unintended items.

Reject such input by treating it as invalid.

Signed-off-by: Seonghyeon Cho <seonghyeoncho96@gmail.com>
---
    add-interactive: reject malformed numerical input

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2044%2Fsh-cho%2Freject-malformed-input-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2044/sh-cho/reject-malformed-input-v1
Pull-Request: https://github.com/git/git/pull/2044

 add-interactive.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 3e692b47ec..86ff632288 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -396,6 +396,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
 					if (endp != p + sep)
 						from = -1;
 				}
+				else
+					from = -1;
 			}
 
 			if (p[sep])

base-commit: 6ad802182101d622e6a4132f48292ddfa79e2024
-- 
gitgitgadget
