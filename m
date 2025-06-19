Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E22475CB
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322169; cv=none; b=cwW/DOM/gVpObvwMpV40/5addpbnn/YR2HQlTiCoUlwNG/9hlS7MNm8tD/gvnFMfdJsIkZaQHtKKRABwrrmzJi31PIpbzpA7qgSHslSqLT1SCwSjHumciiGPfEI1NMl3YkVW2PSpt42ElKCe95zqkC7t45mFsn/Efj5c8ry6w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322169; c=relaxed/simple;
	bh=L28FsTHeBvTYUEZvoTlICGjNj9jvCMVgeWxb+P5/QGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evDmEq6lJHnBOCdfyfYF8u3vQTTTrpXkBnaH6GxbG3uXG+m9dtOe1+6aj+316uwDeZBeOQaElw3NFYeKimYO3dsWZ289VRVZEC2R7ckxBUq2HJIEFQENzQ/yULUP1P4vuIwAsSX2fXC0QEc3uKdVD8U0++y9ID9HfCsIapno1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0faBhon; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0faBhon"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e81d37a7so338508b3a.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750322167; x=1750926967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OERjtli84HOE+xeaBrpdNXGjonbsoq88rLrh+vpuL4A=;
        b=f0faBhonlDKKWE0WF1tfNPnL2k5A873B+dYz1D9ewgCcwx3rEALJQG8Xvw7IT+h3Hr
         KDoHBhIZM6IPrZdndjKJAsIDVwJAmSyslJgpYfHRNLsAU5UEjuQcoQehRbUWWI/L7FR0
         Ak02of93x+hLDuZZGLrYkFZKvhiKnx1wHLh7DCS2RNYmgcg4MbbGcduaG9/j++nY7Uxr
         IJiIIlsYn1yzJbKlVsO3av0e/9WlFY3Kf729BkBAUKWnIZNjpnzyhKZmy9mny0L7I+0J
         sDzgngUHEgjCM9xSjg+dGlZfLXyswUz7+DgBOb2z8/OYeyxQkShQrWssIpDBz+qyvzaL
         Ulqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750322167; x=1750926967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OERjtli84HOE+xeaBrpdNXGjonbsoq88rLrh+vpuL4A=;
        b=O419upsj/r6FuBHV7gxUv1RqAruNYeg+jQBTyMjjSKlrtDsT1BxuXOI9dHQ4wiYcsd
         Ju6nZ7yP05FZEUiVewAVt2ljtjeMQ40GdPKSkc4NthH1ESPqIDV3n+54yOVdJkbH9AVo
         5LyuqFOzbzc6XuFbqZ95ieMHem22z7kxru5TfIHUsnu/QmX3z1iUo+VDMmj/zLWHDso2
         VxWIj6H3l+y+mrE583ioMWTVavloNWUjf+2N+FJMSWzzXp3al2BQqMwEqmDkT9Z2457d
         WWSFzi9eK5S4lyCOCYYvoCGFn/sp9gaHwfUatoTmCwtOP+NYjmm6sBp2Yct4PoD+MCvS
         KQ7A==
X-Gm-Message-State: AOJu0YwILrySyzWD6lU8kNLmLQ8Bl34is3XeOWVMVVOqgm5NwaJy6K08
	cU1jLul2wX8XLyHQvSz6qcd3ejlYD2UxjTlGaP1vGbiBQPbmegpqxFZsX/URhw==
X-Gm-Gg: ASbGncvKRX57V3sQhuT2oZBdZxKSy4jN0sygn6qIQlaw69/Sht349qtiv4VGtNg667o
	jsM5VDlUt93ixR046SDuMTJ6EmRZB+KKoAsb8cnErK1JaJySbVE31CaGAwFteoP0kostUuWlxEF
	cHEFvBM4NnlAtreblaNI0T/G2wdWJDl4kHVzaznK5eP0xrlUniX6iUb/BQVhcIk/v1iRn3+cjr1
	s67ZfZeuFy015l7i04LYkHDuZSC8S3TNftgZIFUXLZ+rwIPnDigETExX4luiGQK6F9tC4TmQ16R
	myl00o5jlzg+J25jGqDflhOCMRHdc6sL4hvnSqpaJlKog5oltJ5WCK0Ok6oBiIwKU1qhMeMrmpY
	=
X-Google-Smtp-Source: AGHT+IFPho+U5BndDLSeDzJatjsqg+beqqgqblybrMZr6UVx4+wjBP6E5yccRLgTaApcujhHpOkEcg==
X-Received: by 2002:a05:6a21:648b:b0:21f:53e4:1925 with SMTP id adf61e73a8af0-21fbd523a1dmr27639144637.10.1750322166838;
        Thu, 19 Jun 2025 01:36:06 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b319dc80726sm8336899a12.68.2025.06.19.01.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:36:06 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gbirchmeier@connamara.com
Cc: git@vger.kernel.org
Subject: Re bug report: I was allowed to "git checkout -b" while mid-rebase
Date: Thu, 19 Jun 2025 14:05:56 +0530
Message-ID: <20250619083556.10619-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CAMq4opMBpg4315Q8awm5SQAQa1vms=3KB+SiQkGtCF7thBPjHw@mail.gmail.com>
References: <CAMq4opMBpg4315Q8awm5SQAQa1vms=3KB+SiQkGtCF7thBPjHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oh I had a funny story with rebase too...
Now that I think about it, I think rebase should have some confirmation 
like Y/N type.

I had a similar problem although it was just majorly me being clumsy,
I had rebased and forgot to continue, and formatted patch and then
I didn't see the files it created and sent the email
with *.patch pathspec.

And that made me realise just after hitting enter that I sent a patch 
with a previous commit You can find the thread here.[1]

So I believe there must be a confirmation with a warning something like
Y/N so that people are sure that they are doing stuff like creating a new branch within 
rebase or even sending an email or formatting the patch.

1 - https://lore.kernel.org/git/20250524073055.58092-2-jayatheerthkulkarni2005@gmail.com/
