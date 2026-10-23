Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757062;
	b=bMDAaPDGn0jakLOEbqUjlu95NrW84Msg86QIZ4j9Ho4d7G7NwpXWp+yfbF8ZWn7MS01A
	 nnZinkNYjUE0Pjzz01FkoVpMbBlZpYrbigQ+eJyQwmt7TmSysmm4Q7lxRubwwY+CQCZQ1
	 ZVhTiSyfLS22DABGj/+aGaEOH6P6l87RehQDDYbnqhfK/wC5eAT6z9510QnuDEx7comDi
	 hki9BU7egkAnJQwA6KER+Lb+DpSq1FUKo/hp8R9fZNZGkhf/vRTHA/xOeTyeMHdIfJQ1g
	 mlsB+bKK1HmB+OwgBX1ZhdU3wbJlqREb4WEYzI5TJAZVuVPo/A3meiirLEFn/eiSW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z0/FQsozRUnhuMXH9UXxB+ZjqygfPVr/IQfIOQ7ckfo=;
	b=nzAMmtXQEwlB4Pm2QAilp2fgEqOcVCj+tf577x2nDJWz6Atvo9ywz3C6/C9d2LC4x8Nk
	 iVgxwxxWIFP6sSTo22rq959IH26C6s+94zlQ+fPTNLUcd4JePKAIGvP77rsZSplNspw/p
	 fkzqDO1c8qwFE1uwTBaRU4NH5Z/sCZkavxbynwj7ZxAVOYIEALfdo9FfujmayMcKwRr4d
	 QSdEoBH/tflpoGCZQGwIokZGdoXccwZcqR6NYxCTuTCjQvB6OJ8ZfFtbRqlEtmQP4hpIQ
	 miM7yQggWyNrtyz87agmg88CiG/YVHqJ5wvUIvwbLI5jIXYP31erSVT0RWgY7a3hlBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQj+rVo9;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71D606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C71D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQj+rVo9
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso864876f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757060; x=1793361860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0/FQsozRUnhuMXH9UXxB+ZjqygfPVr/IQfIOQ7ckfo=;
        b=GQj+rVo9oSBJJtbML1fC5ut8iuJ3e9XBhP9wspJtBSYdwdyVK3ni0XqeN+8J0cO5e7
         4VhD5k5Hb/2ryUAi95TUdl7imiL9GnEPpaFvR00Nsca47USwTtmXmpb/EGB4PVzpve2R
         hT0IdwNbLZhuZ70U811cr81VqBukAVzbjW83UrFIHPgACnIQua+ODoLGAnUTJ1Neo0SR
         OxwMIGO7cqLdXURSdVpN03cAnYUunJd4eDHrZheVOp+TwgwUAsf+D5NBzp6upvrC6vPs
         pkKCdeJyDjR7lRCaCB/hlzkZmOOoOjjbngqKpBRAcMZvUNe0u83TcGn+BGejKjam13h6
         2jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757060; x=1793361860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0/FQsozRUnhuMXH9UXxB+ZjqygfPVr/IQfIOQ7ckfo=;
        b=N5DpOtwxe4UWYhN4qe8mJUXvtL1yXtrM5oIaWjmD55DzN4CzKFVcd6KdgjX9M9UsmG
         2W8mU+qIgbLyxismr5+V6sGPaJOBZYGITqbHkRBeu9oiN4uMdbr9DLWeTqaKg702vqAt
         z9Wby44x/n1ciK7tv+EGuenJ+ZJM37YZV250H5JSiTEeUsOQp+nGW1eSYDkKjLob3UC4
         Jc/lvD3piZ5Nddb5O4wvuPqLaXFNA2BOYiIgZz/NUl2/77mqujmB9G5fp3XbU/d+Nek/
         xTSjRKcS6RXyFxfNEq+ar3N/MB78pbDA9BAdpTwOR5fceiiCVMnWTqft66kdvd+hWfRR
         z9jA==
X-Forwarded-Encrypted: i=1; AKwUvBxpKtT/SoPJjUQWzKjrDKJ0DblLJafKRNO50KgY2kIpA6Rb3QS3ITwPi3ecYhp4RLIld/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLL4cIkWHT0FsaZdAACNaPrIvF/u3r1vLEZremDY6CZwIjX+nry
	VCV6FWF9DceON3eJiUsWsd8Sw6KLR76qEMswONfvGxxuBYPl05KrB1SK
X-Gm-Gg: AYBFou2n+/QF5CB3xRj2pP3alQdsIqH3yvmR3BeXG04J9rr10Z7edCtqcMHa1EmabbK
	iRJ4pl65oKa8cQKLW39/phxToxtyGLHWJlUi/swgCl495mhcpoPseemK58ekoUov+iael02kR/X
	AvmnHNOVNZc7VV3LLBiJYmqJWBy0srKWTGNopd1MraUnIqLKtBtsVVO948S38FAjn35nQwWDudO
	KmrHrwn7HnV85RVV9LIWTuyeCajdBiX9bVTwwcAbCNOW1C7pElggAeMliQMXf8wxditlBB/+IW7
	xUip6Chw2skr5mEIvQtz9puYchqLXFHAkZnmWb9PHtMGDzGVh830bUmhOAlk+k3MKVUq1mZLCmC
	A+zm/mfRmHJal++kU2dHFYWGJ1U4xT7V8R6PLy6axACmV0vs2cJqi8trP0FqVO7xB6hlVV83kei
	ZYWetddmolCXPQxw7q8eIplj6DNN9Ks3eiB8LZKHBGKRoN2+22fPAVvihLs0tjKa9kxIMTVFWVo
	WJ94cAn9R338e6gcf339KgiY/i/K7EfyHlm4rMZmPuyiZ8VPftO8laLC6Tnjhvb7F8aq88v1Y6t
	Y0du57D3KVdGsp4pwX8CYooaJA==
X-Received: by 2002:a05:600c:4445:b0:4a2:5db:1f35 with SMTP id 5b1f17b1804b1-4a211c9dfe4mr35497665e9.11.1792757060382;
        Fri, 23 Oct 2026 05:04:20 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edce44sm4855570f8f.3.2026.10.23.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:04:19 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v5 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Fri, 23 Oct 2026 13:03:58 +0100
Message-ID: <20261023120358.8061-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023120358.8061-1-kerylefondji7@gmail.com>
References: <xmqq1p9hhbue.fsf@gitster.g>
 <20261023120358.8061-1-kerylefondji7@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

Replace _() with Q_() in the 'path too long' error message. Although
pathlen is always greater than 0xffff when this error is hit, Q_() is
required to support correct translation for languages that require
different plural forms depending on the count.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 5ab3ba786f..160efd878f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,10 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-	 return error(Q_("path too long (%d char, SHA1: %s): %s",
-	  "path too long (%d chars, SHA1: %s): %s",
-	 pathlen),
-		(int)pathlen, oid_to_hex(oid), path);
+		return error(Q_("path too long (%d char, SHA1: %s): %s",
+				"path too long (%d chars, SHA1: %s): %s",
+				pathlen),
+			     (int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

