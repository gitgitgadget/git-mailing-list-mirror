Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D2154BEE
	for <git@vger.kernel.org>; Sat,  1 Jun 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717274706; cv=none; b=diXUEXHOUHxts+kvxY8ENCRdWYZhVXVuc7MpnVGUXW+KaAic1xXuX3+pzwXGHYCrcVppIwIugZMFnDgZmOtI7ALC4iX1rzCoAZzP7wpFEDirzmZ2mFyi1ivVyCJZL0yV0ny2z7vfHjRNtinHN5tuFXH4OGlVato5eR9+q5kROEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717274706; c=relaxed/simple;
	bh=mXSYYnLmgVJ6zKdkvIwT4skubHheKHh3po98A4pL1eM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rnGM5dfcwvnxjsaOEUJe1OoGrY0gguKSdBEYCdK9u1LOdMKgS2yj+QTwnjHZ46vUZoy+ZI208nf57OrYfKQKYnZoyVXocE2JZPULNGw1QkTNuCEEkXVbe75agRQV2dlRrt8KcMmQgGl2MO8mAS7HnrBA6oMnYBDksR4rL355ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh4NzNXd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh4NzNXd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so3558190a12.2
        for <git@vger.kernel.org>; Sat, 01 Jun 2024 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717274703; x=1717879503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XE758RoRHdOAMnFrviup6lW3DHVpvc6+RNn7wUSasbo=;
        b=jh4NzNXd9U+QUSoZNYUlGg9/YDUlZOuqEw5ZVNeNcSma5EGUukiyiUvRdGgZmbqe9t
         EZivSJwX6hfHsd4wvLQuX+bXWIu9+zZB4wsXJG3U+rS5eSnm4gscrIpRJAb1VOnPzHV6
         NPOcQytaF7x4y8r3tAN3XRdTQRO3QAOOXLZjhFfjRcsRGhiyUxskLi1ohtV3gDwzQNLk
         2NXaNPsUr5JThLJS691w5VxArbVpIvM2v0zj9NIlRCX7CcOzmN3DtzPILOpleFpxJMFx
         SVuV3/xJc1/dzaVeRx/ztTJlVG74RxhfOsVM4iKv6+pswBtn9J1Oz0RTM8g+OzEVUkeq
         yN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717274703; x=1717879503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XE758RoRHdOAMnFrviup6lW3DHVpvc6+RNn7wUSasbo=;
        b=xG9Vt7tv5XY4uIY5sAxBnOLEpWWU+Ux8C0YmpI8g6oxhYkENZufDSiOw+9kBSHFXfl
         L9YoAVrM1HOYZH67YNxsILHH0Ue/IwwKLJ3i74Yy0V/wzjevTl99e4yuMv1fgJn3W+Gj
         /PpoJE7YJZfPQGskJycAO1GkANay4Y4BnkVQpJAH0bmqUt5XlBwb8rZnnwq/ek3qUz5/
         u+eiVuQWmJPw6ZN+xApXKChRK/xbRQ6reRwq3GKbp3H9pZFvtEiTC788SA190fQSsPdE
         xgIVbsq8Ve8SGy7oObpF9slddBqNzI/6R8mwzAXn3Bidgc0ZmRqdOLAnCazlLKzarg5s
         mg6A==
X-Gm-Message-State: AOJu0YwTAjLooWTen4luLFGEpsh0BTr7xESl7fNDegneHtdi79qBWpkd
	tbskXnxiqlRuYAJOp0VF/jw9c2Gj6CPuqFebbYN8wkSu/nvz/9PDjM+LPjFinbYOx7AhPYyaoyS
	BbCoipmjMUVJuevN0WDTmzKAjSn4ZBPi+
X-Google-Smtp-Source: AGHT+IFPPNEooGQuZi/ybv5pVG/BuPOmTuqN9qKSeI/pzVg0wjZyTWIRlJZuDZRyDizhRx8xPK9BFsONEAuWE7/L0go=
X-Received: by 2002:a50:8756:0:b0:57a:143b:72f6 with SMTP id
 4fb4d7f45d1cf-57a363a63acmr2996441a12.19.1717274703008; Sat, 01 Jun 2024
 13:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Jun 2024 22:44:50 +0200
Message-ID: <CAP8UFD2Xq+3JXagjxfbdpzCi2eZtx77Mt-L62dSqtfNuhfEuKw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 111
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.net>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Jialuo She <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 111th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/05/31/edition-111/

Thanks a lot to Beat Bolli, Sven Strickroth, David Aguilar,
Bruno Brito and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/714
