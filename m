Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437517C22F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696429; cv=none; b=o7iFYRV9jBJhcX3SOKJ1CJ+Tc3MCvixuB8ura6LVqvqZVx8A2rmemlLdCXM9RwC+rNOqZ2wcz2US4Uf7aTO2bD17CMLnb2tHfUBGj04707THVhj6pNKCYZ8SlKPyF7EWV2uaikXS/l7Dn6W9hSOXA1qVjJUWEju+uCkg++ukyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696429; c=relaxed/simple;
	bh=evq309TykckGXqqln2JYer5oRDjj0CYS1ZuNWwn1/zY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dpRohlmkEsxdGjPodcmWJqWxnriprbqFuZos42WEDvVXN3ywJTt1jHpBiY3tiQIlwJPPK7cZGqLq04/bBoWo+vW+w4Du18tlVKlDJjJJXv7erJa48GlnHHJHuVF7vwrFrQx6jyp3oqVGHIYS8VkE73t/EoFY/rnm+/17V6iuFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBCyzAgX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBCyzAgX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso676053466b.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696426; x=1728301226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OGnEuAwKqvWnzglhk0pOtW3U24i/PKw6UMFOfvX9tUw=;
        b=LBCyzAgXdkg0Y4QNKSBB3YwclFg7N7ofMC7wdSn4i5Y/EtWeqjjZ1WVoNIFTS+O9qO
         EvQopte1AxMtFl/HSUkte7BNA5+JkUA81Bu4Tx7CTma94Ciohxe2t12Gp+BpsrJk59ai
         BSFUpq7K5bQrp4qyrhA7FvO9dsZfZq7N4vS4cJ4X/5NhOtnJRDeXuBO0EXYGbuYk1qkj
         IfFW3QuvaMP60lQyTdtS9996t1bXb+PVph1CEDKIOF8rHhkTdGqmswIKQz0dEP3wBSiD
         Mp1oaupjCBZjWSBRoqYtYJ/X0VEYiIYrmdH0R1efo0pTdWHc/pVuLIByf5bE5nnv16HN
         MB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696426; x=1728301226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGnEuAwKqvWnzglhk0pOtW3U24i/PKw6UMFOfvX9tUw=;
        b=TZ+QLa4vsPS+T+p2Q++siyp0McHk8wHMbAOjQTwFAtGMMYhKD2KbgP5Q5AoMAZcaiR
         O7lrf++LNlEm+VLfKbM8ozmKFcLzO1+K9rwoNi8KVOzcZPOPntgPaByIQQ+7a7VRbu5X
         8/vW+2ryIRZD9YhgfP6+SmFzO+mqUBtDbb//I9IPj4HRAj0Vf4XhyzFEgu6wGte7IEep
         rGh9vaKUcfhR202pF0suSJmAIrMtsXAMNZzJsMj/aUzoG7YDwzeDXY2+/mkzwL4n+zPp
         c7WpKivDkwrV9MPAU6wNlwceW2wygqrvqBHiRhteGu+B9K2cDyn+93y9NNPLn+ZSn2Pc
         7E7Q==
X-Gm-Message-State: AOJu0YyMFgYGWTmI8/vi2z2LRtsQKzqipatvCmRl/VUYdbI0j4YFiW1l
	2GiTnwH8ATIl6s6+9CYbE/nA5VeWzx97p3CclB3CWGrHyBLCOvNg1OaAfA==
X-Google-Smtp-Source: AGHT+IF6HOhN6qVX5bPf6JBbTrK1YnOaPa/vDCV5+MrPlyZ+/E6DY92bM8jIDUphch+a6q2RG2xw+Q==
X-Received: by 2002:a17:906:478c:b0:a8a:86a9:d6e2 with SMTP id a640c23a62f3a-a93c497029bmr1301434566b.37.1727696425916;
        Mon, 30 Sep 2024 04:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5b52sm521056766b.53.2024.09.30.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:40:25 -0700 (PDT)
Message-Id: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 11:40:22 +0000
Subject: [PATCH 0/2] read-cache: two small leak fixes
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
Cc: gitster@pobox.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

I found these two small memory leaks while investigating things involving
the index. I thought they were small enough to send independently.

I initially wrote this as two patches because the second patch was more
involved to work around the "cleanup" label, and my branch was based on
2.46.1. This code has changed recently due to d1c53f6703 (read-cache: fix
leaking hashfile when writing index fails, 2024-08-14), so now the second
patch is simpler and these could probably be merged into one.

Thanks, -Stolee

Derrick Stolee (2):
  read-cache: free threaded memory pool
  read-cache: free hash context in do_write_index()

 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 6258f68c3c1092c901337895c864073dcdea9213
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1801%2Fderrickstolee%2Fleaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1801/derrickstolee/leaks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1801
-- 
gitgitgadget
