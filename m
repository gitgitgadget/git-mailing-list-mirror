Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E421579F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010017; cv=none; b=a83iN+zBi1V8EBBVnnJgPGtz5nwGzlrdFFquXd/42uLmG0qPlsrt9RhUyEt647l3vyA+jcHxa1+i0QfXGsvUNCH6ts9Hbahw/oQS1ocUiT7ZW9/FAFPOjK/hiULi4LexV6M1sunG/pa4vZz07we2OH94yvajIzn+Jk3ZKN4XFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010017; c=relaxed/simple;
	bh=jNw0i1W/JC4q//EoVbtBXGRl6/IzthbX02ar+x8vJlA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KCVJfh7lQNNJwJ6hlassYPgNfIvyBAl9oTNIPm6AoZGYhLpH+NqejXqGs9NRVNb+Y7CbJpdNdLRgoGmFuiPWpn4K+GZLk9rTGrCiT/B7rGtK0wQeYW4tM0hPqudRdSvsC37srA0gXDRMvMN6Um2e0vG7P9rY4oR4LtrqmK71Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSlI+jJE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSlI+jJE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39143200ddaso16806f8f.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010013; x=1743614813; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QU5YE+GtA8J8rfqHdA7A97AjilxQaf2sBehzoQSpwLk=;
        b=FSlI+jJEDFbRjic3hU012ePYgesP+5FC3RgM78lCpXFrPoGEEnStG0oepXQy0olxiM
         8vPQ2iOTUyfjFs2nFqQ434LH4gWfM5Z/52xRdFLBv0yFBtM/1L4JDgDQLAutUGGp6Pi2
         gVaJCckfKfpKvzRXxcF4lxH+9Csem+FY1Bq47HnHPLEe0XGSURVtDOhQkVNYY4g3dsP6
         3/6U+ZjQZv6o2KS5nBgg6KaF1Oj760LGX2KSPtKb1Rib0mq+/N5A88XlUqnSUiqxGw3t
         Suh1jo4HFE5Ssqsd+Pni350oS1pbxvG9OR+nluCsP/ExK53Auw/jLQ7qG7P8J8i+gtwa
         dV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010013; x=1743614813;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU5YE+GtA8J8rfqHdA7A97AjilxQaf2sBehzoQSpwLk=;
        b=tmbI5I/IIdTVwjBYBNZSAr0CpTqQMwWfYAAoySECVOeDSxT22Ir5P+QianoJrRNnr0
         +9RHN8P34ot3Q+mLgo9MfDmrCfl3IgTCSy0lGdN7DNsUgrkmRGRPrPDbjviJYlx+9tTG
         3RCH3OEKie82n0Fcue1fwoJBOgzxs/3vuSwY45Mj5hmpJ4n6zv16Me3O65yzjeaQKHZl
         wX6+ABClCyLdfwJtjsnS1Lqyw81F0qS6aGBedf9MIWYrL0YLOLmh9IaxCN0JxxgEkHdz
         H8shxeCQhAAT/vcZJakRu3tzjAa02uGM3yb+C0z5ODErRHeYYMnoOP69tUsIeAeaPD43
         IosA==
X-Gm-Message-State: AOJu0YxuYUiSjKHTGoU9pzgrtl9LiABcoMmOicdv+8IQb/tJY/4QO+w5
	VTJRtBcIMjGTTwSov5kyLJz7SQUe7VD5v7YJPxiMxueFvIVFHp52myqzjQ==
X-Gm-Gg: ASbGncsaheqrC5HCElrut52AD/DHK3JMd1LJhcKrAVo+j4AZoT9pArwEI4TC3kv4vSU
	FBoNPF1+Ch43FAH2y/Z+qBeqPi7XWIYuhQ4r9ogINHWJpx2rPsSX29oUD0aJ956CNitFIuyiVEv
	/NSuH0WKdQHgqudxi6VcjzgeDrM5AuVqDQFJqCDD1arV46P/bXdw+tnxjqz5RXWnZD/DOk+OkmO
	psko0p/CbouiuaRN+EPdFaIYDi2IsKKu77F+NGF4h80DbSCMGVbVrNS0wwh1rotJLYZDxF7nGVC
	az7gBP+mTt8dXAWvm80FrWkPo2liROWLURVXtiauZTn0rg==
X-Google-Smtp-Source: AGHT+IGxMI89XtcAy89KEQMp1dzmHMCOe1jaraPwOs6VWm/melAdqMnOS+oenzHxHEZJ1QyzTS8dfA==
X-Received: by 2002:a5d:5f84:0:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39ad1742fddmr315927f8f.9.1743010012978;
        Wed, 26 Mar 2025 10:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6a532sm8974685e9.9.2025.03.26.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:26:52 -0700 (PDT)
Message-Id: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Mar 2025 17:26:49 +0000
Subject: [PATCH 0/2] Range-check array index before access
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

If we want to check the range of an array index, it makes much more sense to
do it before accessing the corresponding array element, not afterwards.

There are two more instances of this in the clar code, fixes for which I
offer in https://github.com/clar-test/clar/pull/115.

Johannes Schindelin (2):
  diff: check range before dereferencing an array element
  read-cache: check range before dereferencing an array element

 diff.c       | 2 +-
 read-cache.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1887%2Fdscho%2Frange-check-array-index-before-access-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1887/dscho/range-check-array-index-before-access-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1887
-- 
gitgitgadget
