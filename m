Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72142DE703
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776395; cv=none; b=OtUTZXPftvB9qQnfuuC7I6aiHV4qnoKAzLek2crT4b4mfcQyvpzqp8+SBTJgkWh1z11OYiOz2X4exAPRWrkbSUVEe1PxHNQD2M3LUoxk/cCkCmDtjSKTUnN+1bACZ1YyxY8kacPov3DYwfGFaugrSuRFL3MMfRkjLGHBo1bYlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776395; c=relaxed/simple;
	bh=WUfAbAI+biRs8Tv5FwQZkMIti37QRJTsHfJCch+qYzY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sJ7PgTAeOPa7FIaRm7VFLyvu2s9IEVNPnxt0GXoFeogBJewso9CMC+GSKlUHhB+0p+Ax67/gpLJw5zUrfhnbIXtStribe4fCTXAsbehfWn3XSkjD5u1AZiRXVcd/4pUTHlu+urfUCIY517XWu0ls4s+zxjHLhR/7eSBUrWrlHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLVO1Hn1; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLVO1Hn1"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430da09aa87so1343525ab.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776392; x=1762381192; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWAwDswQYTFuCc48waYZpP8lnmyOY4FEIShyQccc3b4=;
        b=MLVO1Hn1D4T5COnymQ6X5Vs6HEEt226tOeTolPVNaA8qCLImK096wYolOy9VWtjquK
         V2vvrwxg354Kaqnln6EeIEKMiAbTbSWJjRvhzJ7XIbHTJHaJ6bvwuZ/0CjGjrR2Fh0wu
         TykkOHlwUoWf2tJeo2FKxm0QGSPrJYznYcd5KJJhh9FSKNQP4gXF5pCdSzhfSd75yIlt
         8SLyiS0x13j3janL2PkaY08jwjHGBo5KBlFZBSeH0L4hM8IKt6fHYfZLxj2+OEGHmyZ5
         BjY+3oFss75/nuQnyf756D4lDBie2bp/wCjgkYQPJN74dm+sq8LSoFNmH6NT37e3HZCO
         TUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776392; x=1762381192;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWAwDswQYTFuCc48waYZpP8lnmyOY4FEIShyQccc3b4=;
        b=jZewMFa9/buPVwN2txlRQiMt0DINcAFF7md+LGMgYyfKLoXZT8kAH8tDAoa1OQsu7T
         D/UC4daSiIs/LhBNaIWpyg2Do27cWSoYuquVC3yzMAPmJiG4OKxjsY3Ubx3Gsxd/Hhz8
         Qij8YiwNgX26aiB+/FpEzurCBjNWbga8aLJECsWKC4Mv0pgwoF9IXaPLg/meNg8an+5M
         iuz2TCEuYYT9HWmRfa68T4tn1X2tRGOxVq/31sXE85gk51ZVe+jYmke6cML0oUzVzNGl
         3FT4im3b2btJBZGx+VCnC6t0nmNC7JaWvPlzZEDSM6w6wA/uU7cTWfrBnj+0TvFCTv0c
         Px5g==
X-Gm-Message-State: AOJu0Yyz1ZK/uaXiQVrGe1qPLjcKPlxJrtJRPbWKr0IMLXOlnexOJRFY
	wJC3TMSc4at4LTqFnUUrwC22PRXtojoyrq6eRNqvL5qKJ8b6s6NmAPozR+IUBA==
X-Gm-Gg: ASbGncsg1EM1vewz+ddSTuMnnzipLHvemcETGIdsPwcmVYD0sK0hQJp5DOJuLcs4nQk
	xMBcugCi90SQIbqKcMANVRaSzl3VBYxbCNnNhrp7Kn0FzD/ICYHqwex14vrjFyhjehV+qh4WOX4
	kPOW7Coq4W3H6jOLRr9zX8eq7wjPPqJ00X16OAsVufiQkL7VW/Nm+B8pOrt485xFMFQzIdhq38a
	c6S4CFI2gXzLpi6lLmVrbIB7Qx0kcUkfOsKx9SiKgGUFU/GUNOujN5PCIvZqWBt83aVOqG2YkLA
	M16ORQT7pGFffl/ZXpyTXyzSaa5NKvc4HxJElaKFcdwpEDQsAnYLY9em8VeD9Tk9DBVVDgOGbXg
	2Tukp6iqq34FbZG66fkFrB/wP5rm5ItNKWNP6zeLf0dvciNX3Wc3roMiogB/mUyk1zsjg7GuN/L
	CJRNNwA/PGdnN1
X-Google-Smtp-Source: AGHT+IEB64GY3S+LI2q7RpeOzMjvBJINMvM0UypolHvHpaL5QOd2+VKmKPY8RUSUU4CztemgyDePxA==
X-Received: by 2002:a05:6e02:8e:b0:430:b05a:ecc3 with SMTP id e9e14a558f8ab-432f8fad5b8mr61433035ab.9.1761776392464;
        Wed, 29 Oct 2025 15:19:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946e0b4sm5908537173.31.2025.10.29.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:51 -0700 (PDT)
Message-Id: <9197903add26e5b8af0bb2dd25bf115670e18e8c.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:40 +0000
Subject: [PATCH v2 02/10] xdiff: use ssize_t for dstart/dend, make them last
 in xdfile_t
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

ssize_t is appropriate for dstart and dend because they both describe
positive or negative offsets relative to a pointer.

A future patch will move these fields to a different struct. Moving
them to the end of xdfile_t now, means the field order of xdfile_t will
be disturbed less.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f145abba3e..7c8c057bca 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,10 +47,10 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
-	long dstart, dend;
 	bool *changed;
 	long *rindex;
 	long nreff;
+	ptrdiff_t dstart, dend;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

