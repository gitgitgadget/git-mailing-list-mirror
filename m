Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8652192FD
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010019; cv=none; b=vDghfErJC5Tgbrk0Piu1oA0jMfx12oNdxYZgXM7n4vztxtSXABgAFwH/b4emSuh+tiPUDmiWJL7X374zzvWEezzuxvKinnvGvZkaGR2j5nzTLoBYASfD9KWeezendh4PIO50Au9Q5dt3bCR/VTGjmtTc4LlZt8+5OvYV0y6Fd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010019; c=relaxed/simple;
	bh=1Svu1zhm/W5k2rqExzY22clgU2MWV+IArP0HnEYML3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=flErziIa6w73OzNWG5f+gWgxtrKfD47qXqgK/5tt+I43uYyWlqAeQZWnivYEAyT3aQcxBULBrkKjBLPZkzwhKNrYVMmduOuiYzjm2sYwEpUNHttm8SvL+Ok9O6nt4Dp/CX3k1zoS36qx7+bi9LkBGiV6tfYwwwhalb26UBWr68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGwDphsC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGwDphsC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so623645e9.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010016; x=1743614816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il90Cg1/iMh/vs91YAdYq1MYMhQBNO7/bT3rU8QvyX8=;
        b=BGwDphsC8pGEoXP3ZHeNpXXRRZQyOMKUPaZ7qFcxapynJ+VDXHD+7lZ9TiRbltobcf
         cSCZENHnCv6Ip5vxY5nQM4zu/LWcxpHpj92PfDkaLJy2qlye6tcqHPpHBAVy+t6G1DD4
         KSpjrt+ax5EGR6s8jU0wKNGhoa+x0/BXtBgwTvAo1plxcgpQlURWBprnD6NXRvcwSv3S
         vaQn3qfKgY4dEeCQoTf4v5L+R07xHIY8baDMXmyralalQ+OJrkI2BRQhA1uXBHrWE1yX
         lM6afv8suFu/kkNGiHo+Bm3VTn93ZbN/vDd6ST3pMcIPSgRYNveoGDgzvsJrLkVLjd46
         g7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010016; x=1743614816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il90Cg1/iMh/vs91YAdYq1MYMhQBNO7/bT3rU8QvyX8=;
        b=ps48M6+dj/pPNzYQmdh/45kZEkwZElZY16obt4Hb3NYcGnXJ6bRe8s6g9H13ddPebs
         hB/jAAn/+xg8E3UuMBUH2qjxNMShgTvYX6zFQmvWEt3Fi9F6w0xB4X+jXPQcFxGFHZOj
         jLhZdD5Q2a7Hz7jpDkGpIoZQarBsdRaJU+1kqYpWt1IEBCTectGkDJr/mnPPfw6suHte
         z49jWvQYGmfEzNjsE6WJFTH/sy+QD2UyEwfEhKp5p29xVvwX+309dTM67xQzJYrYPdQk
         KC3BpFd6cZ2k2xyUDCzWZ8YSuwJRuhSp4NL+A4SrsbN89+fN70lWnfcclht7dGKoNPvu
         QO9w==
X-Gm-Message-State: AOJu0YxKYfoK9BJrtcL9FPK2iRUNFjWTqY6rx0Ve688DpJUTKBaxA7qS
	azS36629zWSFCOUu+ZHEtEeL7EF+K0I4grKZ5UFB1atbw574lgvxUMP2wQ==
X-Gm-Gg: ASbGncuBdJQWpiNaMKowS9iCneeiozA0cLwX4eFy8BOBCCtE9naXrnciX8EaCdJy+dG
	47a9mEemdl0cGSSIDpHv6t9ebGW1gk/RV6BPXg9mV4rRLIsNgiL2rjMmH+5oOKikGHbJW/NUCQK
	UUWdXbPajzGoCFYWmkgCqYtdUbkFoKnn+6ONu0tj1ptzQNNAVM7ZphrB5yAvQnImeXzi5MSPNyL
	KK0dK6Cqu3GDjaiO1pyNjJ8YDvf0JO2NY8+Y/2Qj6Xye+YdZEG0kyiBFtA7bVP4Nt3G+hfU2tqM
	i0jl19PUCGiQCOX04pi8YM4uPgN1jqycK+Dc9btC6/IIYw==
X-Google-Smtp-Source: AGHT+IFmV/O70tNgcdT3BpVvDJuLU6l8AZgALu41W2FU8ox+7QO6Hhplk5fMcK9Qz2bQQ3o5dlQDNw==
X-Received: by 2002:a05:600c:4f89:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-43d84f5ba55mr4129465e9.4.1743010015304;
        Wed, 26 Mar 2025 10:26:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f1bc29sm8722815e9.27.2025.03.26.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:26:54 -0700 (PDT)
Message-Id: <d4e94a243b0633ab18daa6ce0ae766d5bc33364e.1743010011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Mar 2025 17:26:51 +0000
Subject: [PATCH 2/2] read-cache: check range before dereferencing an array
 element
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

Before accessing an array element at a given index, we should make sure
that the index is within the desired bounds, not afterwards, otherwise
it may not make sense to even access the array element in the first
place.

Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e678c13e8f1..08ae66ad609 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2686,8 +2686,8 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
 		for (common = 0;
-		     (ce->name[common] &&
-		      common < previous_name->len &&
+		     (common < previous_name->len &&
+		      ce->name[common] &&
 		      ce->name[common] == previous_name->buf[common]);
 		     common++)
 			; /* still matching */
-- 
gitgitgadget
