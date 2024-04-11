Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D617BC9
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850471; cv=none; b=VdTFHctSkNTcJGL03hwqtSg3AtzHizTynDMYyYbrKRYV1MkPKGDvEYaoJZVivRxw3QEYmEawMC3mG43TFaB0JGyucMeGDYFzSmvit2/TYQNaBQBeC5sQSlU7qgbnRFaJ/pURBGGoI6LY0FLi6F07FDc6t7ud4WAMU/UYgQ8dUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850471; c=relaxed/simple;
	bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=eVXF+26RWTuuUneYpXhsRxei9q2OBvR5NijFO8v3/A+sCrtq59i1lx/+uQs8OkSubyCgbpvBpcNuuK/T0GYFnwwwh8FkNNi/rn8GzK4EOVlreyMrmaCGYGj09yTwMo7zpF/ywGWUQvLntBunp1pfpPSBTILe4R/8ja9YSsneYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNHRW2Os; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNHRW2Os"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so172097166b.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712850468; x=1713455268; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
        b=mNHRW2Os/gk+vfdNTVLkh5P2oFeLVKCfAMRf+/PvRmiXbb1wVcyA9PlCIj/it2jKmb
         tyjhOyF2w5Gk1Yu0J65GEMfajPHtvzRntWsCbqO4bFshBvx/A8VRI+JLKOgZi+BcMbnC
         yTsH4NxEwKXeEm0x8g7hEyWBVfw4p7q0zFcq5kzOk8c1OUp1CBa4clSq7YTrMJdYQOZY
         yRfV4oEofEOKIwFnBE/1A4cQng8nzK3nBmeKupQzugT5KU72sGVecAbeTTJKSR2K+7qq
         8oJ/2anKgnOl3hr3e1i5jdrj9+2FbpAT08LXZlmvQSiptx1xhwt06CdlkrN9BkVc447s
         u3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850468; x=1713455268;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
        b=j54Zr0cWUm+n90F/FhBaGyQq4zOLPbZf7fpVyV/AICR0pBS4Cxf5i8mVTEP32PHlam
         LWtQZnuVA2vQJlhRO34SlXlPTDkiVn2Wdre0IMoPUML31FcCI7x7bteglmERGIQKo9wY
         pla0VVdgclGLupSwPhCI00MZWiehKcN94Xf8HPOhZXFpgAj3xtoPLJqlqwob1aFePt2h
         TmbZisA8PX8NuKpYC5qjpv8QNI6dIB0MGcnt9VhU6ELtY4YA7ajqReKG0l6+EFwOtMF7
         E7CGBUavIGqW2QKaTJ11121Ih6mOJ0L5IZaxed+h8/QSSjtGjIv0Y3F26yc7Iz5Dz9Z8
         ThbQ==
X-Gm-Message-State: AOJu0YyCp0TXHkrSIEmVAAlgpJrIM8wX4HJNmCq02tlzsSTbeLowSlij
	kD2HRU9B+1Z6iYvaXB8anOD+qmvXzVC/eonIGvIccJIeNFjoescQMu6z9A==
X-Google-Smtp-Source: AGHT+IFOkZ5GwrxX5VFGBSCY4ZeVHSy8FRWcvUadvneDxH+kJArIoDkQgATQaZyj4/hTv+0SwUg2EA==
X-Received: by 2002:a17:906:2308:b0:a47:3766:cfec with SMTP id l8-20020a170906230800b00a473766cfecmr2338499eja.9.1712850468457;
        Thu, 11 Apr 2024 08:47:48 -0700 (PDT)
Received: from [185.222.57.70] ([185.222.57.70])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm871226ejc.76.2024.04.11.08.47.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:47:48 -0700 (PDT)
From: Lori Cozzi <abdullahiisheka@gmail.com>
X-Google-Original-From: Lori Cozzi <castillom551@outlook.com>
Message-ID: <afdf7b811a3e8a61df5cb03599cee21a4e27d0113aeb4239649c2997ddec2537@mx.google.com>
Reply-To: loricozzi@outlook.com
To: git@vger.kernel.org
Subject: Gift of Acoustic Instrument
Date: Thu, 11 Apr 2024 17:47:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm giving out my late husband's Yamaha Baby Grand Piano to any passionate instrument lover. Let me know if you are interested or have someone who would like to have the instrument.

Thanks,
Lori Cozzi
