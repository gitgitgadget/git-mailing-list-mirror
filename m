Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F425F998
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636376; cv=none; b=Z8C3RfegBx1i76QlNJR8OWAA+CWiKIaDDYsaBbbTyA0HuKGKmSfigB4St/pTVejZtAD7SHVfYToHodcFNvzq1lvRuEb1PXiWVFX1KIXhmGwaDx22RXM55OvdvOQiRqvkYdHalHv7vRi9HOgJFTMOsPw5NcNQfyUC+omxu4EKq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636376; c=relaxed/simple;
	bh=0Vwdb5R5PoOjOTtbVIm/vNJun7SGA/p/HC3AINokoOA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gRsXDaORuyEJtjvvKTnUe2heZw+26QQ3O8Ge0paXEV6DsXzFixkSAA+Vq5kbJ94WhZ8ROdoufYTNqNpA3HrWO35+McWt79vxVtbRiKy25ww1AT9OnSf19Q5Wdcj6lPHFyFkqZoKVbZig9mCAocx09idJOLbU61cKAk2LrvWKTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4a73CBK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4a73CBK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso191831f8f.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636372; x=1756241172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4YG7AWuq11sK/tV5HLQUAP8goVp6LJLTJMyoFH8uUA=;
        b=M4a73CBKQPSNoNABmNoEXGK+9jTMkrz3h+D0i9MCr96RaSmel+zTZYXOKKkvxk5Fq/
         SrcIVxyFiohvW6ihCvFzG3+MJ21NYnJuIiS2Hs+Jzqo/0yf7s7r3cVP1hQwH5zW34Y4G
         l49Km3rmr8vlDhsLJajRsjojmL4EmxkDfe42sD9eRZREWbxBHS29rJPDGZCLCX7Z4Lb1
         0KFeetODSRvsWtBfXXsC+2eB0n8nwRf0CQSjuSXPoVHm+kmWH+axBDTa3P4ySbF/jS/B
         vFsIBNPoPvILzmrqYZre4urK0C2JUN+FdVLhp31FZdAsGSluuQ+Q2JDfe+K8wYgba5Xc
         x1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636372; x=1756241172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4YG7AWuq11sK/tV5HLQUAP8goVp6LJLTJMyoFH8uUA=;
        b=P+U0XU86hdgDDhHAcuhv0+ZcFeNXcbjegWQpnnqOysJ48P29fKNnLhFGE8vy5xx8QI
         zS4ZuEHG9E1v0AaAoomlc4hjPne00vHNZzkgtuppYKbbGpaFaUFkxKDNKZKlCMBaGlDn
         rsPdbzCMQfY/qceqixtnXWN32F/k6KkawJOfCR936nIJCS1Mle3NX9Xj8MElqI5u8dvE
         kwMQQ58HopadsiZkfxp9GO9nm4SIC41Z1b7ecayAi5tziXHD4xwkWNMZ4T0Lm3U8FzjM
         XfFxzbK+YMB0R2EPYxwK3Je4jWuB0L7krQrjzW7vsu+V19/rKlWBqwBatAlRvR6T5bsL
         Q7Vg==
X-Gm-Message-State: AOJu0YzOoeCsZNyKxaAbljOVygZQpwSwYALdzjRFcVkfww/wyUN8sU34
	tZOVjDxoT8vcoE94v2snpGDfaHUs4moffBwPPERYPAeTJmP+inNC2UsLM5uOlZdv
X-Gm-Gg: ASbGnctBybqwfWGWdQ5W27Xz9JPTdvck9OizhN0jalHujjR7E6rR/YQ1s6L7DbwL+hB
	NUKBl0wzHN5MJhnGe0oRZ0pnnsyYSEKkZ8CGJAu87BaVAVpIAExzquOtnDkVgikfeNP0GtD5UP3
	2sJK8DobsOBEOYL0z8NPCqXv6/L/zKpCTpDRWzMcAN6bSs+ISJASI1qCv57c1QmoZejLTp5W9lr
	SpnUiPHLY16WM9xIEn/CU9gnYrj5n4O+rpghfWBJ2FRHxW6SJk7wX0eKn0qqjpvo0amJ1INpxYC
	SJI7u+tHJdUqMCkLxwLaWBbmJY5sgf3FqoFH/2NU/B6XWlXL/BWzgOgxdD1Nu2VXDCPyp1FCzlJ
	z+hNvy7SLf/rH0iPF25aKaAk=
X-Google-Smtp-Source: AGHT+IGRVY2QQxDbM8aqyE0DwIuEoHufeRRIZpd+aoHiFa3cyZ3KeFySOf4TY6NsWJ6QkMnx+TOb7w==
X-Received: by 2002:a05:6000:2010:b0:3b8:d337:cc2d with SMTP id ffacd0b85a97d-3c1333b5d10mr2772596f8f.18.1755636372309;
        Tue, 19 Aug 2025 13:46:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c6b14csm1330875e9.25.2025.08.19.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:46:12 -0700 (PDT)
Message-Id: <c44beea485f0f2feaf460e2ac87fdd5608d63cf0.1755636370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
From: "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 20:46:08 +0000
Subject: [PATCH v3 1/3] Git 2.51
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Junio C Hamano <gitster@pobox.com>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index be801415bddc..64cbc5833536 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-DEF_VER=v2.51.0-rc2
+DEF_VER=v2.51.0
 
 LF='
 '
-- 
gitgitgadget

