Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544732DE1EC
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162762; cv=none; b=ASOYaQ8WA55wLho+++/lB0oZULToarG5dopLVNokn7/U6W6GnR4jH3iwG5Kw62ULMfSe5ltZXMghLrrd216svwwz1gAHffyTgGku2pRyefpQj9RKl4qYNvewD6dTdBMq5iyYCFb8/F22wl6IiOls6X+RF3y78ig0zo32d8LlCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162762; c=relaxed/simple;
	bh=jZLf5QzjvEwi2Ck1IqsrX2BKttlj9QRl8p8hjlJtOTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZGmJ4n5A+RigiWWM9+S5Vvtr9W63VOpG5PHgFiUBPfU9rtZZll9dv2j8Rz5hYnK0g6lCmi+/B2TpNwqdPJXiV6OPCn3d1IGac1aY2mbcEF8d6xFYQqWWpWjcoGLBi6n2/KOT6G5aBtnLAnM6I0cEjKCGNG4Qpn2t8+sGStqxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtzjS3uj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtzjS3uj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23649faf69fso54844355ad.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162760; x=1750767560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZLf5QzjvEwi2Ck1IqsrX2BKttlj9QRl8p8hjlJtOTA=;
        b=EtzjS3ujLEV3AQsj/O8gQJiCNJFq1yjSF0qRmBXYrey2/JDZDwV0rO+t2mf49pnVmm
         fEXp4xDa4l0mONNpBDmkW6Zswj9qTQbF45AgbzvzoBIr9tDsLKhB4UnEBMUZOv0eivdA
         72XT0Q6dI/EtOj0O/A/x0/TdnZUXaprxULLJTRNzeXasq7oEW3WA1L0H2Mbqq48BXlxW
         XMZmZUubZ9gehvNFKQsOtRVbWj5vZLqDgDTwPv6ae3OPyxrH0LUOl5xFeykee+sbhD8G
         o60lv3euLoXs888cfA4IMB0wwT2M79AXEd5sxv5bzMB9wzA7f+PaKKC//uBZA/0zUHzo
         HdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162760; x=1750767560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZLf5QzjvEwi2Ck1IqsrX2BKttlj9QRl8p8hjlJtOTA=;
        b=fY5ntQRv7jSiINkXnJtbs4tiAWhjoMQHULJbS6XFbJSkWDgvdahrxhHfTm7ISxzeb1
         rdnQPnfMZfywQgXxRtNb2bVZzXAzCItdauJSeJgxYxoTpSl7AeOJhB1p8tS0q/4bNJoQ
         TPrALbJhnAvbcdgaTKQQ+HqNQZDnH6KM/4aKXGGO8v7aXa8ZAPBNOjA28zwpC23oYBhu
         9LnpdTIAfkh8G4pLNiDGV/30jSMlFSlKYl81TWWEZ7mLW4KMZRkO5y83np2qepFic8IU
         Tz2VThyjKlCbIaLTC9gU5eULCpYOfATPlxcUx5YkeWp/vjyISZypPFLAO9r+TCdLIHXF
         RkIg==
X-Gm-Message-State: AOJu0YxhWia5eDJuqM/PAD5r5jXVOlyFb6q0qbwzbP4nZU65rFoLZjFb
	2P5wx3EAoEjJz8jRSYp4ETTgjxp5AhDMb4Ln5YrzYTQb1jHT/RC18vWMIOZC8VxydlyUSLziP/p
	OZ2ewGYvHtu7hbICMaBVT/ux+3QllZ1NY2U1CEWI=
X-Gm-Gg: ASbGncsBt6dlpocBrIMCNrV7tb+gWNbcw5W8DdwK0SXZpwFW+ti1AeCcDUaSAPCgXzW
	SiNseitsBK0ceM1bjYArEQgkyFXqLJfPXgBXKf/ph4gMQL/wW3KYyzbpkglNS/pM4roBa4zeGv4
	0m9IOzmnuu1Tbqj6l0fGgUVtgFgGAZ0pcXqWG+9pbNd3Y2MGduEFm2ZWs=
X-Google-Smtp-Source: AGHT+IEtTVWS+J2qnn1gxANx3K1l03dnbSYHr9lGbAELOoC7TuEhe4V7Qwr3y/M+x/i3ij8czbQMgHwq488MlDvde1w=
X-Received: by 2002:a17:902:e54e:b0:234:a139:11e7 with SMTP id
 d9443c01a7336-2366b14e55amr210069625ad.35.1750162760236; Tue, 17 Jun 2025
 05:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhwyn36MjrW6SsSaDo3S9rrrNGOqURcQrsKFukU-sUwyZwx6g@mail.gmail.com>
In-Reply-To: <CAPhwyn36MjrW6SsSaDo3S9rrrNGOqURcQrsKFukU-sUwyZwx6g@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 17 Jun 2025 17:49:08 +0530
X-Gm-Features: AX0GCFuapr8WxtpeYptEjvghxEY0sJl1WS4eZK1ZhxXu4kGDSWmkNuFToWAemhs
Message-ID: <CAPhwyn3-SLhOF9XAOR7h1FCHaEpp2fphmiv5=u7JpdpVb4si3A@mail.gmail.com>
Subject: Re: [GSoC] Blog: Consolidate ref-related functionality into git-refs
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, shejialuo <shejialuo@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I've published my blog post for GSoC 2025 week 2:
https://inosmeet.github.io/posts/gsoc25/gsoc25_week2/

Thanks,
Meet
