Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6710EEA8
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744512646; cv=none; b=VZnjeWaDVMNBuMsrHlzXgzg7X/9FrhqDdNuzZccGft7GBpxDmBKuWsFeluvS2kLsWUuzhfCqsVO/LCd30zHsr4m2BBGgQqLafhQCh9HvWVG5W1Y9Wc3NyNNtkUXabMRNx+389zmny2XTL2lVerovxbk2+LW+8hhnisYqsV6DH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744512646; c=relaxed/simple;
	bh=SfBoef491W1n8ob0Q7TS2lcTxswyPvVeU3s2Ex81Jys=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sBatArsIEvuXeIhdlfmcva/UYwuI5UWousL2bQkfDVWRmnFMMqbu03xkWn2/LgXrafAuD7jqaKHoViJtQV9WjGRIGZfNjy+11u//WU5lDoDDzUnBkaOHYQXKpx+fAt5DMXxrIzTKnlwLgRtzs+a5jdBpXjpeFGo1am/UHvuCVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igFqMuum; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igFqMuum"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8fb83e137so24778786d6.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744512640; x=1745117440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiBsUOsrs/Zub3ieXMSIUNfzAZGXfs9pVm7B4XTq/r4=;
        b=igFqMuumIsGuqIC8kQlHHEvoiYECalG29FUTr6X9Ob2GDvbIkNrKU2mSuRdPcDBMAS
         R6b90MDWruvOWHJ4jn+Yz4e9zkReAc+yZ85bK59uA2THQsgLB/0iuy4wkKbj4sjsl+XB
         Okjo9D0a2FHvyET2R2cvCbQg7ydL6xWPCYmSaCUK+GGqC5jz/aKR2Zlzc/PicOS2v8XP
         9daNQ7/he1mvkelE5vpZhqmQShiSo8+nrkcoSIJWG6qSqJdp5hNjZhMh0mas09VGPZ6Q
         XQsYzGsEXpgAsQEtXHt1ZAI/eS4yyqYUXlWZE7H4sPWr1ol8mDpmf0YLS0aGTyMPmrlC
         BJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744512640; x=1745117440;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiBsUOsrs/Zub3ieXMSIUNfzAZGXfs9pVm7B4XTq/r4=;
        b=amse1RLqDCaWHADNUxUg4ZNvnH0Bub9v1H2b+mxyvyFM+Me83D8VIqtQs6/exZbN86
         gw9U67+EnUHBTS5JFtUjRWUwUSJDep6Yp8QDR7/lBOEeOiVJ3k4rWdfmJHOh1Sc4CEHP
         Z/cuLzaWrnsTQB48NqFy/vuCCYwJ6gh+ZtGqLU7xzbQQHx3FH7XiqA4LNm+YlQ0M5kpE
         IpIwZVXFTbMmGVDGOhwUi6oo1CbXg7IMQTYQGx+zLvl6AG2ZOpYtxeALxTFjOgxKtBal
         4TWkoAVqf5Zoljq+YJzLYGef2jYn76Z7qsS66hlcGRGdNDG5Ntc3UZENS3QwNeLreRX7
         C2OA==
X-Forwarded-Encrypted: i=1; AJvYcCXa6VVDwRi8zXsQK8nQqVviTh/y0MjfF8q2d6dkLxuprAIomVCZk/pOfPJxXHI/rawpn48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9ibuo0bu2UBPZtGFZhaM+uYOMx77PtSeZC8R6zmVcklpPsKM
	f7cQMtDVilFO/hbM1wqkDGs41TYt8TT9HwtuRzIQdIjsoK5wszKd
X-Gm-Gg: ASbGnctVczkAtuwJKg2ycrPTMsdq7UsgW2qmaI7I/WDCAM/skr6jbBAxhXk9GCVdkuc
	OiGoG2fut/52Y8tcz3azcyEWJIuJ4DksXRJzBUgn6fkz6ThiBrnabZzOhGDWb+p3JptedjlN87b
	PJOVU+qSd2Ll7Pr83OUV61lysPCqXfxLn55J93+9oyJB9lw6SDa0HBpX8rTDxREq43s15JQctJx
	KDMme6urBdgPeJCPbTynjfBzWro28Px9JWqXl7u4nzmiPLaw3xb6BHaQfBKMrsIrfzPMy9ZYqdH
	HiDbCCkmyDcNvHFT55tHNR2feWOHM9CjiKcE1CfRrblhap914h7U4KYehtQfgAPrTi3mi0aYc4z
	A8xInLY76L90Cz2OPyjR/RJEGYtrEc4j7Ew==
X-Google-Smtp-Source: AGHT+IHABwCjlDzJqON45ygxxPtnJMrFTUJaA2G8HbzJnWJUoqzKRdSeIdUQHfVahs5m1EZCAqLqrA==
X-Received: by 2002:a05:6214:40d:b0:6ea:d033:284c with SMTP id 6a1803df08f44-6f223221e56mr117979986d6.0.1744512635263;
        Sat, 12 Apr 2025 19:50:35 -0700 (PDT)
Received: from [192.168.50.110] (modemcable021.80-201-24.mc.videotron.ca. [24.201.80.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de9730d5sm58973706d6.38.2025.04.12.19.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 19:50:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Two perf test fixes
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>, Neeraj Singh <neerajsi@microsoft.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
 <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <54864a66-c399-ac2e-e223-affd6a493989@gmail.com>
Date: Sat, 12 Apr 2025 22:50:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Sorry, I forgot to mention that this v2 only adds a third commit
with a small comment fix.

Philippe.

Le 2025-04-12 à 14:15, Philippe Blain via GitGitGadget a écrit :
> Here a two fixes for failures I noticed while running the perf tests.
> 
> Philippe Blain (3):
>   p7821: fix test_perf invocation for prereqs
>   p9210: fix 'scalar clone' when running from a detached HEAD
>   p7821: fix instructions for testing with threads
> 
>  t/perf/p7821-grep-engines-fixed.sh | 6 +++---
>  t/perf/p9210-scalar.sh             | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1936%2Fphil-blain%2Fperf-test-fixes-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1936/phil-blain/perf-test-fixes-v2
> Pull-Request: https://github.com/git/git/pull/1936
> 
> Range-diff vs v1:
> 
>  1:  41a093d570a = 1:  41a093d570a p7821: fix test_perf invocation for prereqs
>  2:  1092c32609f = 2:  1092c32609f p9210: fix 'scalar clone' when running from a detached HEAD
>  -:  ----------- > 3:  abd146b7c2a p7821: fix instructions for testing with threads
> 
