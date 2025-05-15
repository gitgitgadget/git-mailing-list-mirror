Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325529AAF1
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314721; cv=none; b=igullnfW1kynAOvC6/T88ym8x6Fro2mrZMNie/QIIyeCI0BslM1sFeu5CMKed23gsL6nSesyk4Yn8l35VEIoEA50KoCSlbhYR6zQ8sQVARlQwg503iLECX846+SX/wEijHC/8Wn/MMIb8yeQD/Q3dlaDYIdmwo8/Ocq0QH9DBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314721; c=relaxed/simple;
	bh=PnvAkheBicMgiH6DQnMpI/FZLKwAVlE9o1WUexWFX/A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E9lDLl0CfYuzC200DcaJ/XoH7Jyc9kVwJxrGg5Eu2QaOk47IhdThOjBtBsPgWBWyK1gBjZa4fv3bM0TGX68xU4NXyAjPEf9K0G9b/DdCrtAIeVwNvFzXrYyRPOJbjHb51AmWwIx2W4Gv1vH2MvcpxuEeydX9+Urq3BRKjmGicqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enWclXb5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enWclXb5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so9983295e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314718; x=1747919518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6GZYqBT7tRjZoOPeu097dxW72p9+zw2Q3PrXT9M4Jw=;
        b=enWclXb5iqs5zCWyS1F/5fN6XFLCzHMw30FG/BmlbFKLr2iQdKlh28d5Z7hcJbVZnR
         evYizrOvg2tMShPh1PxrOtAOz9MxDX27eSX/xJgW2zucUC1nHLIrVHpnusCH1ZtNqO94
         itaKqy6Ayfn96a3qx201y39qrDFV2++s1jxRuXsNqapck4sJbed1YMIWad93DN4zE56u
         zCIt3DTlK/X2V/MeDIKTUy5BlrWXKFCmPsuErhlwKXnTPrS1BGd0Fa2ufhesldypPS3z
         zhaRH+mYnt6Mc6SBrbNY+0qiaUY4PcUoNfdK0jVJBXgKNRQJKaiRPSL2x81XpuYW4VvJ
         QwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314718; x=1747919518;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6GZYqBT7tRjZoOPeu097dxW72p9+zw2Q3PrXT9M4Jw=;
        b=l/PNGvoIslDS9N/do7RL2zOByRQ7wM9ZJi2OPou5KasII4V8GxljlSJDcogdRIWm+B
         1jAJdiVH8jS5YZO8qoRo7+f9Z+oAhldi/NEVB2H+EbAo3bDTGzsUjHbl8lNwaV00Z+3a
         9lSGlChD+wHhc9f7BNLcYfTWED8iUanHM6J2PmrxmGv2lnpwk74segybHrVDg3sJmBjT
         XymUc0eUCaWTa349mSFcx0ETmo7F753mASV3qePSj8JmFL3C4X2oyAm7CObFWldpfCm1
         CAetbLNh8ZuGeuSyeUVLH0A9B8mnWLDDNS9KhJxsf4VELtFbk/N/nm65FvRPY25SZUs1
         QrlQ==
X-Gm-Message-State: AOJu0YyYmFxV7pXYYisLi4ZNVmY4jTLQSG6DkJWPTydbRsL2rzwDEOxS
	eWWhMJrLMmTGgW0B+zPL2zXCI5Wl1wZDiW3ui04oansPSjU7OH9nuAnSOg==
X-Gm-Gg: ASbGncuAgxEiH/OzFxa5/sYhHyAdbIJmKqJ5hNgKv49j05S1GFigVIxTICS9PQYqV7S
	SqIJCedSDvEciUtZr2e6Tt/4XoBa9uRjFaSdpP79TsSbixkjR2rEGxU0f5flUMFE2f/zVe+wB6X
	XUn4HJFQgdMP+EzrFGnexvJ0oUzF29yv9gJk3NfVHkkDyZy7PcbtgehRIx5P5JC2iyuHxfWqV7f
	mGOdRJrVrViBLjxD+qqgZEtQIKxpl6b0DeaT+xBEIPL3HPF/+nait5geRtH0RZfEd5LkFGMNZX6
	PJN+Cl7nNi8W8ckYZK250QsxqixkAImD1p6WFipQ2bA1qKHvmNug
X-Google-Smtp-Source: AGHT+IEOa5a6Pr+lcoQocab8+0cFvBQtGEJHfhkwmvdrcA4r+k/YavMJxsHUMkfV3R0adiKEiQAEBw==
X-Received: by 2002:a05:600c:3b02:b0:442:dc6f:4a07 with SMTP id 5b1f17b1804b1-442f20ba9e3mr75868785e9.4.1747314717578;
        Thu, 15 May 2025 06:11:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db8asm71574605e9.9.2025.05.15.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:57 -0700 (PDT)
Message-Id: <7d92e08b0c06a546ffd937c333b97d2fb6cd9817.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:45 +0000
Subject: [PATCH 07/11] Avoid redundant conditions
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

While `if (i <= 0) ... else if (i > 0) ...` is technically equivalent to
`if (i <= 0) ... else ...`, the latter is vastly easier to read because
it avoids writing out a condition that is unnecessary. Let's drop such
unnecessary conditions.

Pointed out by CodeQL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c             | 2 +-
 transport-helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 6ef90838f128..21b778707a6a 100644
--- a/help.c
+++ b/help.c
@@ -214,7 +214,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 		else if (cmp == 0) {
 			ei++;
 			free(cmds->names[ci++]);
-		} else if (cmp > 0)
+		} else
 			ei++;
 	}
 
diff --git a/transport-helper.c b/transport-helper.c
index 69391ee7d28e..0789e5bca532 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1437,7 +1437,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		transfer_debug("%s EOF (with %i bytes in buffer)",
 			t->src_name, (int)t->bufuse);
 		t->state = SSTATE_FLUSHING;
-	} else if (bytes > 0) {
+	} else {
 		t->bufuse += bytes;
 		transfer_debug("Read %i bytes from %s (buffer now at %i)",
 			(int)bytes, t->src_name, (int)t->bufuse);
-- 
gitgitgadget

