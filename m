Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C8259C9D
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016914; cv=none; b=HW6IMONKbULbZpMJ25A4ajWjsy0OaRCuunorYyYBcyXTEa0MzvbXNgXHMW/oaZ/eTWo8x7IgiRPpKnV8YgfI80mFuQE8ZF5SExs0PlTuGlNVaKMEfmtUY5LPAYPTGzGaUpbjoBcduY4l8ehn35pIJZ9Cz/eKfwL4enKs+nKKVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016914; c=relaxed/simple;
	bh=Q13wEEUDfmzr1pdZM3X2e/zO6OnYhRohrLs6ONNh1vM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VFuMBCJB7OuyoK/7+k6kwDig2KUQjzd1i/QIX/ebIwqc/91AK2mMYFGI2rmicgLCsFMBMCFv7hpPtARGcFBKUiCwUbP9AbnPzOW5UmehsvR/chLUuxbOCEIdEN8bjiHSIXjEtwsLtK4igU6nJZm3F+UyF586Iv6w8vwr+8bu0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGF6fjJ9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGF6fjJ9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso9062145a12.3
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016910; x=1746621710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2iehwJQ+OC6fr3xmpKnPPudnoxNg0LKOjr1kJ2A57E=;
        b=AGF6fjJ9+MPmrkL/CMtDtU/+jWpNUWktXNyZDzmf7o8kWJvPSsZ6RhPh8mTozG0AD7
         26vD2SeU6ss2h4w7o/compbKfnK6in+N8ZMYtyy6LM1yk4+cklLoM6MJU1qRcZ/v9Ymx
         btYtWInVz7F97UkVn5I83pqD+lfVa+FMUg4fhM5pef/iTT1sb81ML15bfkgpBJIQA2MF
         uKHu0mw2YU5CVDp8rfxeSHNYQaNNW54z/5u7jc2yO/nVc1k6TGaCCHxPnhWv5DHoIOmn
         fN18O830eBoI5yjpMa8sLjyHHNzbwT5mr90pdSLfKV+HLNK7dxwizhEdVh/AS1thvYx7
         BebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016910; x=1746621710;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2iehwJQ+OC6fr3xmpKnPPudnoxNg0LKOjr1kJ2A57E=;
        b=RJNVlFCGxi4heqjhhNyZSb0r0tMpDdrHwPOqIvz5NtaX24SjQhzEz8Sq1um7Cr+vaN
         ubrCpqIeYaWFbBL+pfPkKNc8FSsqItQZLKBp4DrfXCm/kWCDgR5jDQAYhHewrfbKaF5f
         DKhpYzZHoygBMGS17T+aiCb2eMgswPwyRhVZAUNpdrGZbdo4SbH3A8vAQKJktUonYBPc
         XCzRvSeBMiZmuaHyXRYB6z0l9hwXeQwJs+wRpHCPBuUBZlHKBRxK00LcZcDGpDn4RaVB
         T48qQbXn5g2p+wqS1P0DAZl+q1TRypgoenLJ/wK0lEZh20V6GFGpPhubTHDJiDX6Ix5c
         sYiA==
X-Gm-Message-State: AOJu0YyDaMOqglXCDVHdSmMDHhi4HRoObIWnJK84sfBaxUE+6ZCG4Dv6
	gjNGKnmamOSnOlVHCcmYCmcg7dBIds8RXbOQPF9ZHKSJ1khsUV+YC5iitoUMk4m6iDFwTkfMjSc
	a/Hg3r5pJjbo+mP0n7Rh7zbkBtrB8EvXJ
X-Gm-Gg: ASbGncuEvIGQEum28Hw/hwPy3GFzBA4XhWnZRkdDJM09aD5szOoYJOzD/YFtWy4Cbxq
	SvB4aTruv4axyDpN16wzMDfdc/OYPOM6MEz1g8Rbw2fyWWGLqSaIGX3D1waAJceH2DnMJryPZ5s
	eWOHUBP+fF3ZFpbH9vm5ftc14Dc3yhUL4tapwX5PSJkGt2qk6A2vpLb+0=
X-Google-Smtp-Source: AGHT+IH8OXhjy0yeUyv/yJSnhVOL9B33Qa+Bj3fbhx2B4sCo3izzsNosDh3TgS7WY9HSG8WQJRIKf432DnwHBbGhaI0=
X-Received: by 2002:a05:6402:430f:b0:5f5:7c7e:4107 with SMTP id
 4fb4d7f45d1cf-5f89c10cd6fmr2054569a12.29.1746016909547; Wed, 30 Apr 2025
 05:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 30 Apr 2025 14:41:37 +0200
X-Gm-Features: ATxdqUHtRTTBQEROixcMsSQRVVYmkqDY3UcDXaITLPSyJksQnvHNmZfPA4aZSr8
Message-ID: <CAP8UFD3b8as+Qk8=TQACdXqCpNXxFtW15m4G76=r-WzsE3QbkQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 122
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daniel Barkalow <barkalow@iabervon.org>, 
	Catalin Marinas <catalin.marinas@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>, 
	Darrin Thompson <darrint@progeny.com>, Patrick Steinhardt <ps@pks.im>, Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-122.md

A big topic is Git's 20th anniversary!

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/767

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Friday
May 2nd, 2025.

Thanks,
Christian.
