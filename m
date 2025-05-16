Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F22E628
	for <git@vger.kernel.org>; Fri, 16 May 2025 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357348; cv=none; b=e3zQwBol0DLM+Y5TIvKeEEkvmRndKAujd13qfyJW6JPfwC4+Kay17+knbPq6Q8hoYlXB7/pWcsMCnUsinLgXjm5T6W2Aqv0nKrGmjvQwcgTT05eETY8/j+bp14H8qJayw/6BX1GkNk1qTTuEA0BCEERlZh+OjTpeiuehMj5irKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357348; c=relaxed/simple;
	bh=JWTiXw802QAAdNDalNizwgRyywhiW7mxXyPkhcqCKaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEQKkF8hb1kGwuWY+Z2JciRopnzMvbyQCU9YYxUbwzS2nZP7UeBchsdEpZ/jYpY1OBd4j4mX9hvYizzHjn56CdmwgxKol/39LOiMj6q00Qchokji+AnLyDmM1usNTsJLOcnFvYFanBhCNCQaNVbYpkdP5F4oVJrOojczpBGLBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9BPtvza; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9BPtvza"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7424c24f88bso2091775b3a.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 18:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747357346; x=1747962146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoaOodORmlMgtYEAj3gEJo3Yc4GILgcUFtanE9AZbng=;
        b=X9BPtvzagy4IztemmlabIbhI7VdXmEb4S96MGAgfPPnyARlVJv+ICnlj8HmUspPO41
         vUGyRQ8ZOlYgx9IIwtQ6yEJN3OxWhzvuOwngzXNJMxLTKchZfYwLw1A+qT8V9sKVqIDL
         r/c/rX4nlYkonE3mMKX+VMwYYGbwx1SncV5jWY+3BNLXXTQeDfNeXgkKEOMzUgUH+RsM
         XA7TxH23X0bBKq/nCi7ztOxFyJ9Mnjgq2BjbI7YjxtFiWdLqST8G1UojVxYplG5H6YZq
         8mO/FhaXbwMcb2oIzJAdMrxqLnm5pJe8pJuJnlZfl155lg5VEb2mGmAV+fCWqslNiRcO
         nVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747357346; x=1747962146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoaOodORmlMgtYEAj3gEJo3Yc4GILgcUFtanE9AZbng=;
        b=TOPY3F2npiK9vIe2gkmhMqGUMzLNdOYYc+O8L3c0PLikQFlzL//vs2xSZPIrhoLqWB
         YpPDWMFQiKczqw1S6sxKqxMIz5/Y9tokFoUEjBX05kPzuKLDgqoE6+hw2A0OvWpi1LD1
         4RouywWUTklCNmRYu8BViQ9XMCdLHie3OMDkBLVgVmEZfaIIoXwBLh9l25zT67Pi9X5u
         UfNY/vRXAD3XiP8lQsaP+Ti04lPIgaLx5prHlUG0NI2eYO5jxNVhhkcaABdT3Vfp0+tE
         SwT6/EAoCGWNCFTAoo5NHwu7+01r7Hfw5+DsEUs0GtnNsczNNBss9io2JsCVLDIWVTLI
         TjFQ==
X-Gm-Message-State: AOJu0YzcBJO1Q7cEBz8RppR3SpWNKXcLLnviXM3Q/4kiNs6MKA6Jh9y/
	2zkZdXvEU1ef6TkKD33qe1Dl7o9+GoW687fCRNrI1K7O3MlfcPV9XXezeDQOIw==
X-Gm-Gg: ASbGncupCIfPd4dW5ZHyvuITyEtdxkVajHKv35E4nTMCDy/Czz07M2zL3KWXJFa8NM/
	VDwugiKekwHwOIKLvtFPEzrI0csljncaKuees02fFs3Qb+reUSSWVfZNkplljf+EyWQPjodFvHO
	vnUXjNt6j1s6RVWKpS3UP9DAY6lzqRTw/oIQ35D4L/cZQ/q+GcOdtds4O+ae8UUgUKYnLtwVLrY
	pQDg2U4TueZ9Pgneg379IL4M795oXVWD0j6rKN1MtYuBU23JxnMgplXkBL103e0/k25zbBOolpb
	zy7YQ+Kl4bGZMAJXwJ5rCzaa1iWv6+3xpq4IsV4HMRQy8w4InYWxqZ3mzgv25hsG0SroscwQL9F
	KVFL2HKGkRMMLPps=
X-Google-Smtp-Source: AGHT+IEh5s4JuIQ2DQtL4S8IrDuiaRlX3h0/f2O86+LUmTbEWVheIiaEOvJqXgXMFilbqbCBpMlpvQ==
X-Received: by 2002:a05:6a00:94a7:b0:740:91eb:c66 with SMTP id d2e1a72fcca58-742acc906b0mr777846b3a.3.1747357346209;
        Thu, 15 May 2025 18:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:86ae:c830:7026:45db:9f87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9738f13sm437329b3a.74.2025.05.15.18.02.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 May 2025 18:02:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 0/2] json-writer: describe the jw_* functions
Date: Thu, 15 May 2025 22:01:57 -0300
Message-Id: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, again!

In this v3 I did some minor adjustments based on the review of v2
(https://lore.kernel.org/git/20250512020935.73140-1-lucasseikioshiro@gmail.com/).

Lucas Seiki Oshiro (2):
  json-writer: add docstrings to jw_* functions
  json-writer: describe the usage of jw_* functions

 json-writer.c |   4 --
 json-writer.h | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

