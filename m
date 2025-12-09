Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA3304BA3
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303887; cv=none; b=SPsy40Ml/BGMDkY4TCrWLesl9kdiJU0gY0EjCCKFtVWpj9JStOI0tiOCktw2jIX8sUATNzKY3B3qIp/L3xN9EGZJNwTDk1ZetF0yNTA7l7fewdE03MpHcX1D3oxvDXs8btQd6mUDaiGMtu8+7jEoYQQfmTUoOKl6BDPGlR9c37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303887; c=relaxed/simple;
	bh=+7khl9ECN+ObOKQusMrFZsV0i9e/qu8csy6e64qnIUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=EXNIc44HZypCkdGor3tNnCa0FwlH/jcq10PzmGBJ34sBxldK4RJgX+OFcPZu6otKDGlC4dqR6bzM7quwan2n79v269xu3xSULZzbUM8/qMmgJK8/U02RJuO5uT4TBJfXcLksXuZgfhYxP4Zdis5O6PwPjPlru2JlN+M+VkYrcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRCgpu8H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRCgpu8H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298145fe27eso91088995ad.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765303883; x=1765908683; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amruYsIhmzBngY+7Uce+mDm5oTG45F5pH2NvIM/Zr54=;
        b=MRCgpu8HQAcyKRDQGeqmfrxWkigL93vywdFj5KNTnpjICi8cPZXhQd7kx4uxQ0aiMJ
         QM/Yl1H27eR9X2JIp9V/0dmWjAk/9AozoA/OJpvherdYd5yHWYIq2dnQRW89Hf5L1uTO
         UuDX3OSI1lGQGI53040xbg3X/zazno3uAqLX51/cdGFfVclMQME8Vg70XYPXR9JjKuS/
         9NV8IeNtlKQh1xUyiTqnsB2frTwYunUc7DkIGPn6AEIs/nM172smZ5M/rf/M0NHHu4MW
         NXltpNF9n9SZ/MAAnarJyteO1LeM9twYXYI3sUty6de/1D7r7CIICvSq/WWULZ/Dub2j
         iq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303883; x=1765908683;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amruYsIhmzBngY+7Uce+mDm5oTG45F5pH2NvIM/Zr54=;
        b=T5wD3vgXx7jWk2hJth99EMaWMarzQkIl5mh/77LWUU0NHQUZ/TzeETNmeQJotpS3V8
         a7nPFgKrc7BBEz5nTiA9iaBi9pdZEkCJWN18cspmkIyI9sCmzznrQSQcTRW6Yjbf6ohY
         JZUjE5wAmxLE6SG0anVpWOnY1RLhZoF1/Ixf5de1t4e8B6BT8CXj6aHTw9Rr3n41ZvpE
         /tPprQDB2Rsmw3+4fOksmCOSIsRDNQU2BF/OZPLWr/Rdfn0UmHs+ToWDpQt+E2r6Vhsx
         gd3Nd7r77UPIR903ZRM9nFq1XRuAcPMKuoolRv1Qadlkgn2G/6wjXDa91bb4FIIuMkWu
         GMDQ==
X-Gm-Message-State: AOJu0YxaC8o2pRk3IO0/h/D7phOVNBqeW7iBq5mFPzw60sV7IGuVtRtL
	T40TDCh3nS5C374opS4iQJd6LoM5ueYPSjdCvqjAfrjk8z7mPfFCYu7OVCCoiA==
X-Gm-Gg: ASbGncvCAp6jICEBjbsqt+5Fj4xoX6KYWAYx4mNuQoqonoi+MmTHE2HnkUYJvuO71h0
	nNR5A5nJ6UQoh0eRJCnb86s+FontzHiDMJHUdhLM+gq6QJ2/Ur+1Cu7/tRpGxQvaRygtmm8BZQN
	R2lF/ao+4B92SPNOpEGVczrbSGpCH8OB9KP+HzT2PRf9ZfPXv27yE/icflKVwmEgGTiUrrNL8AI
	QJ5zobahQk5iMtBdNjUZZrzoBg2Lw09613WKiGLqBFLUvAC0vNnzGqos2NhdkQN1Pee+Ive99/8
	mwB5c1umuoS3CmEVDn0DVU8drsVaRZ9S+fwIkBeuFaRJQ18OWFPB3dcNuc4KDpG3sgfSOWepUys
	XvPzA3GPb2ltvj8CsG6bWwODaRNyc23ae1Krdu7rTps+A8KE5kiWTxKxf2L1uSF5sJyMUpwl85s
	TqnKkGHArIUPHT
X-Google-Smtp-Source: AGHT+IGE6201Qo521mKfwZIV1T0h5cqkdNnGv8wV1xx64nxF1qH6InR3PR0swHj0wmhSV9CSG2oryQ==
X-Received: by 2002:a05:7022:2391:b0:119:e56b:c73e with SMTP id a92af1059eb24-11e0314ecf0mr9741209c88.3.1765303883181;
        Tue, 09 Dec 2025 10:11:23 -0800 (PST)
Received: from [127.0.0.1] ([20.168.111.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d46f1sm1488691c88.16.2025.12.09.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:11:22 -0800 (PST)
Message-Id: <277c8616a9fc365b76b2f4ab458cd927834f9e0e.1765303880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Dec 2025 18:11:19 +0000
Subject: [PATCH 1/2] shallow: free local object_array allocations
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
Cc: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

The local object_array 'stack' in get_shallow_commits() function
does not free its dynamic elements before the function returns.
As a result elements remain allocated and their reference forgotten.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..497a25836b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -198,6 +198,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
 
 	return result;
 }
-- 
gitgitgadget

