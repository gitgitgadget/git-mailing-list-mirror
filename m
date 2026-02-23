Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E126E718
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856410; cv=none; b=JJitMBI88mVOL6h6jedmOhI/bSw+dgHZRr+p2fNQErNlTs5qhl13J5fL2U2uKurqpkzdH83voHVNt5mfuKU1z0py20OFM7+NAS6eyw4Z+QtaD6gOKz5q2USN/Ovlyd7jyNMPDArOLvCyU3qkoVueYZlMidYwwKYCTTZGx7HrZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856410; c=relaxed/simple;
	bh=w7Ii4ES4vpf2Tsf7ns8bHkP+Cdj53LqRgujcFqNk8Eg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rA29+BG8pt/tlcKgV5y9AZta/Q+LeQOB3/gzsrQgVNHVaas8khu/YKCegJ/faZO/UqBuuUlvraHMC8+pi1qXEuPFRfV/XRQMP6tJFGDLJXHRN5bqgSPxBDcsLm1elW06lA0qqvkbwqX2iC/oH0TI0fwB88oXqtnjL+0xEp1bilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETxHMu9B; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETxHMu9B"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-506a7bbe9d0so36244381cf.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856407; x=1772461207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=ETxHMu9B43KwNSZKJynsmJofzGjzO3yJP21esWybOz5Z4XnqzOw2WM0YdHCLSEgPiC
         /QbzIvbay3KyAREuH3QNl4Jdj4XVz5cWYtly64Y9Dsw8kTVFjvFNnKDXMnlGOGbT/04C
         FGJNd9m34/Dl0MLYgIp5n1cVRyIibQOjBCv9Nnhk8rifX75+rEz/WlgalEQVS9BppDwQ
         mteLCPa0KlJK527gBRxDxRppPfDao2/oENXpvskP+m4odQuOaPam7meK1mpUj+FK8c5/
         imMmRW7/QsvwFBc0t0enuqJC6UWv0DXZjR0+XY8VMvM/uXaUuh8jCxRWN0a9lJBPFQ1n
         73Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856407; x=1772461207;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBjwf+bFpWSW+dTEKkQEFvDAIQTlXmKM5FtZ6RDz2XY=;
        b=gGm2fbB2s6S6V2o4HmMVlFbiITLBMlpI+zR8CT/uUqyQ1KSQgLiC5GuxCSsSWMPBAJ
         62BQOjsZUGMd17oaqyUzc0CuldA2fIf0Dz6w5SGpV3R0nkQkO6AQcptOLVY7nc1OH60j
         1h1fRJ01805dywVvkeayZ2JL6Np8xzW0YPMfi6i3oM31qfaR4tZvQQNVUn2DRSczdKv1
         gUkqFfbEnNzi5Kw+BiDx1uxG0zKyfQlvWfgNsnTlrbmQphDP112aBwCua7d0u8fSmFo1
         /lsJZuA2EcGoHyPPEfL3PlRQ42NLUlrkdeOM6MeeAjIqfLphcpCMP9ZI4eVwmxdw+2dC
         k0wg==
X-Gm-Message-State: AOJu0YzDwb0giBge/gCnIFd5F7ti5uwXJE2aM6U6cbdSNHfGC5ZdNsvq
	mMzdx7Lx/jBUubdjGMwZ2SM7w0U+9/3Z8etoQM/S+8nVOOTUSDfHUe03ernqm4PF
X-Gm-Gg: AZuq6aI1MdRvUGN5DscP75MsIXNBlNvbd9Z5crbIoJlXAdyyFP7oSDkGM54y2e7LUsG
	ej1+S3YU3SUB+Wsi85RHEWp4wDBvWMqC0s26UtMMxdO+3e2wreJ6d/652tf7wFksd5AAtTXczgC
	p2f7lfZ9pKcOJe75gWN3Iw3i4OJV5Miiq9B/D94wWVQYQDw6k4c7XfNV+9aPMoBCue6daFmLAgs
	+pD8c1ECILFiqZ7NeEJ3ohdnMDiPDM6hgI5rJcD0SwmM/c/Smyn+VqjRy+C7cbgElD2ddLyOwNL
	RVHoUeHbc8da6EvXQhOo8S3d16wkf/8O/6nE0E/8KQTJ/x89ChKepXom93mIvk8sIhg+MxHnmm2
	Ipsvqvlhp4JtGEoQQ/aieF0vc+Q34J6pwa4oEU+78i16g6uoZap4AUclzHoQ6DswRkTWBCTTG13
	0oVz2TjEXm1sXeKAQQOMY0uP2EPQ==
X-Received: by 2002:a05:622a:15cb:b0:4eb:a6c9:e839 with SMTP id d75a77b69052e-5070bc4de17mr123872611cf.47.1771856407385;
        Mon, 23 Feb 2026 06:20:07 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6e9e81sm70456881cf.32.2026.02.23.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:20:06 -0800 (PST)
Message-Id: <7ec2d6644785827c047a55a99b213468583c6c1a.1771856405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:20:02 +0000
Subject: [PATCH v5 1/4] strbuf: pass correct alloc to strbuf_attach() in
 strbuf_reencode()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

reencode_string_len() allocates len+1 bytes (including the NUL) and
returns the string length in len. strbuf_reencode() was calling
strbuf_attach(sb, out, len, len), so alloc was one byte too small.

strbuf_attach() then calls strbuf_grow(sb, 0). With alloc < len+1,
ALLOC_GROW always reallocates, so we reallocated immediately after
attach even when the strbuf was not extended further. Pass len+1 as
the alloc argument so the existing buffer is reused and the
reallocation is avoided.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 3939863cf3..3e04addc22 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len);
+	strbuf_attach(sb, out, len, len + 1);
 	return 0;
 }
 
-- 
gitgitgadget

