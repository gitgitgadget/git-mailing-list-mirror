Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D12905
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973184; cv=none; b=VPvZp0eDs6FsSj+/g1gnVW3aoBIN5lStAcngicmVSPzVUXOL+eqO0uLm+nlM6we+hqg40XXWc+hiee1P6fCM5hMgCTvvA2AkzMS/vPFDGKYbKHr7jmNVVO2yL+wfe7KOTCbbceLwkp6lxrGy9hcptSlH8d7Dp0grnF0Ukzdf/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973184; c=relaxed/simple;
	bh=TOj7CzJtB1NQqk23+kl/pR9+6tAI4ITyD5ynWsxT+Xw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=lfI+xTTLv+eE2Sm/9Md1ZztdX3IS/ALPfSyr/2r67cgapfhxmyg7Od7heuLlKyWak++dLPE3ic8puEAahaqgTLrxvT577A30q1kqimg968C3cDezid3/TDxRgjnzrVLFUKj0uI8Gz7FyIx/v85CMnAHnvOoqIzmTErtgVl2MBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNMCc1lm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNMCc1lm"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af90fd52147so186634866b.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753973180; x=1754577980; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AXoMGyZN0J03ZpCRPKooPCIETOwKfcAVhtU8iaDUW8s=;
        b=XNMCc1lmBZT7uezSv2SzrBpnZYDuZWg9sl2tUmCD0Q8FvTSCv7CkUNtCHbtdYlvdFu
         fSotNPFBHKDgmR+ItAY0TiRc/ONzNJJ9LegsRt6Oue2wA6w+AaJ2jpLyHw38LzWPh2ZA
         Cstst8mKZLejl6+Ci4NRxb7bKJvDZfgmmo1ESAoYVx/yJAdAjj/PzVwyzfCPqRP7jE7C
         JRGCOFCidkl0tloHEwxHPj44N+8l0Y+QBMr+ODTn1ZhNpLlZr1DUe0gS1YQ8Hz+uJye1
         fglyo67y1ehfOGVNxbHO+8hUjFb6816WQLBYAx9qDyjSn5PPvSPQXzvAgU6zDpz21qKs
         qqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973180; x=1754577980;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXoMGyZN0J03ZpCRPKooPCIETOwKfcAVhtU8iaDUW8s=;
        b=H+6oBPp+e/hdbWxYtzWxH5zmGDeDtSaP3pXFyHsqB3pYkSodVG9j7h/L6lvFmuwl9B
         h/iciILReiTw4y3yqxvNBqHUUeOY/UMT3zgJ6/vEcTgKxeaeQU9NkHzhSj4pwbCrxKLb
         FGhhK67ujXHn3l1SFz8hRXR6+p8sj3a4IrW2C0IJmuMzg7ulJjTfFhCjeMRAm3KAiDZo
         gtV84ugP2vA4bEVUYzrZGD2FNlkbblqekymk65AGSjZLIdw+fRDulBvbgOqFJObaYJ/l
         AkRSIs9ThgTyjh9X9wotfNA4SptriLjnsjOLZ1LrXgaiqF15SljUlXWySZK+SGyKe8h2
         GgFw==
X-Gm-Message-State: AOJu0YyXe2MFj7XtqMKl3HRgrZ5llJa0opvxoKUN5U+D6tBNys2eVQCd
	PSxynP90c7FiJbMh87u6xNiY4OWx1nH25clEIa56KO99O1N+EpqeNwMqg02ybw==
X-Gm-Gg: ASbGncuVyMw+4ITIM+auhP9W8YGSoFlgoRCY19SHlDy1t1nX9Sgcf/GMxUBxNzGkzAw
	AuTE5tP6mPvhVbKLLqMBP9KwGWo+iD4Zccf3ImGfdeVz0sts7OGzmNpij4++EH/gVnCmCxxqR8I
	okN+QfjSmgpwz3vStnV5qNdjMaHZ2duooiHZ0OZLjqDxLWOImK1vgvB0+DE2XI5yJ9MNd+5AJOs
	yC5E3hRXj2KXfzlLKGqtVvGlNIIWn3u5lSp+94F2EZGkVPCbmWxKfofk65RJc5oaF/d2uxuvtG/
	Xy+oBlEo1u+nYxWN2Q5m7CsrEwlAIwC9hitwpUcZAgh5SUUpRF48HmtzFf286Z0PKoQI8zUNocp
	e32ZP17AQtVghWnnsfvpzWJqsJ9E4w7G3/A==
X-Google-Smtp-Source: AGHT+IHQXDeXFEX0Q44w+MTGTikLrtlCDzj+KdrJIsdqBLDx+y+1mK8PHmWYdOmuoGMC5bcb0jeY5g==
X-Received: by 2002:a17:907:9448:b0:ade:79c5:21dc with SMTP id a640c23a62f3a-af8fd75354fmr984032866b.25.1753973179499;
        Thu, 31 Jul 2025 07:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766e2sm120085966b.27.2025.07.31.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:46:18 -0700 (PDT)
Message-Id: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
From: "Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Jul 2025 14:46:17 +0000
Subject: [PATCH] docs: remove stray bracket from git-clone synopsis
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Knut Harald Ryager <e-k-nut@hotmail.com>,
    E-K-n <e-k-nut@hotmail.com>

From: E-K-n <e-k-nut@hotmail.com>

The git-clone documentation contained an extra ‘]’ after
`--also-filter-submodules]`.

This patch removes the duplicate ‘]’ so that the line reads:

    [--also-filter-submodules] [--] <repository>

instead of:

    [--also-filter-submodules]] [--] <repository>

Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
---
    Remove excess right bracket from git-clone docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2023%2FKnutRyager%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2023/KnutRyager/master-v1
Pull-Request: https://github.com/git/git/pull/2023

 Documentation/git-clone.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 222d558290e..851502552f2 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -16,7 +16,7 @@ git clone [--template=<template-directory>]
 	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter-spec>] [--also-filter-submodules] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
gitgitgadget
