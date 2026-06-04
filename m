Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3E372B5A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568379; cv=pass; b=ILbWNHhoX2NlNlkbXLLr77xpJFEbCDVidUR9AZoKAiDKei4pSP2xrCqvmsBecL3X+SHNfW4cwUvIBun0qMiFzi6ZICrzwd94iwl2rK09IG2k7jbO7myPBOEttIxknj/me6VxFw0BSkfYgoBbAFXOT/d+OdxKdbl1jvF1JjQ2kxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568379; c=relaxed/simple;
	bh=vDsizsc7GG5x3u29/NbTnWagansiBd9Y90NO5mg1Egg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoFsQQkYt85yJMl2NJFr9JyZ612Y1jGWX7OFAFpq8dg0KTLR95EU0vntVGby1ddnmuUY0QcxGk56goviS7iLfwoe1kPdUmB0Q8jt7x4RbQGaustvlccgHthmdEosULhI6qN61DZkLcJ0oYWWju9JNfM7+0La9fZprhHLy9PbYpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkbC7AeT; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkbC7AeT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dca5a81be2so5069767b3.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780568374; cv=none;
        d=google.com; s=arc-20240605;
        b=Nwn7nU7x8r4atzYHnjcqXADz9XprG/XvrRHxafbd7g2Wy/QTL5DMyShFNgwUxRqhXi
         +tj5lbbC9JygKTZnF83sHuaj9UBATh8xyUk9dzpXGDNGyPlWG5vNhb5lZ1NYNOavBWBt
         ltUaJelJEdjZZloBAkwN6/+ai/jluaJhAnsPbK4tiBTOlbc/StrxKsIT2pMU7bJuS2rO
         JS4i8rmoYd7OXzsgrchZVME2QsQ4MB7PB3Gix1xPHfSd376rencfMVlT7mVxBWHrZwWz
         xzwC25LxKV3Bx5CIO/I1K0jOMc7otHQpnQ47JQd1twK9Oq0FkdHiGqOrY0d9O8HnSZB2
         v5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MTU2gEVK5/xf2hdb7u9/VLDUaOp1t/OzXgx63NwYHkw=;
        fh=XTFQAjE4S06Zz7iPh/eli7Q0QXL3PXw7ZSjG99UtJEU=;
        b=SPfDHZjGEN57EVMdcuZ7JeZfGw/7QmbbZScCYw8niYmAyjw/1tCuSA9e8tGl1ffPNA
         PgJDd8/GGDpdnkFY0lkUxX7QwfKBcb7cPNjtFJSAY8zY4/HjGpeNWnVjxlSDF/AXbFJ6
         cyEsEufbWipCyhuVSwe0Lmbaf+N9IkjEEMF0m85p9rZ6KQ97h1HlApBSAhoeDiFgDI+D
         e3MWHLes4McGrV3J7nNm4dXj6FsO1H6tkjSMYo/h9Hnzac55OTrivXVHW3tgu5D/TlR3
         /k+CgyiEw/31wZvIfxEANbzyyxgkWbXggbdP7ofv8360aRf7NcnW24snBS9/3dkoEy2W
         /A0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780568374; x=1781173174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTU2gEVK5/xf2hdb7u9/VLDUaOp1t/OzXgx63NwYHkw=;
        b=jkbC7AeTSMF2a2w5SOR0TAJ6Ol1NtPbDhED2ezrYUIHZec5jrs/So+FsytG/c8R3t6
         im2s5vUs8wd6UpecXVrKe4/iynjzjp4D6majBLYIORxD4Ci99ySURuYAnlyOqwx/NEjQ
         oNfohnTj6vdG5cPFttk2mXG2o8k+BTBBLKGqzPcjVJglsaquyUsn3ROwrtxetrPKQLZV
         yiOFMJ2FVtrIh1XiyMeeG0Qur723vUme7FS0t9JNO1APiHfRE0fBthIh+02VlWhi/1MB
         W+rRizyS31bFEvqrqLqDDyAHHPRK5B1pYq8Ybp+r/VCeBRiBorO/F7ANXxXEU3oOVQyM
         r5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780568374; x=1781173174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTU2gEVK5/xf2hdb7u9/VLDUaOp1t/OzXgx63NwYHkw=;
        b=PXUuG70WRQJxUnWcULZG7hH446hn19mKizAfZmaB5QR2VAHVz2cYUKG+UmV6rYkait
         56m71jt68SfN6l9r0LYIP+d45g7taNIBGrNM7bFi5WoaNhJpbxzxXdEbsBvLKDkFM5MB
         wFVPuLFcVc+Vbdk8H/EhXZb2YCxoNGquHGuGUWVu5p1oUmqqZKHt19nmw661Rla+7QUL
         9KH18AH4WnT/00jzd78cfyrpW4rMNU9twvuYSPXvhbkchbSdmzVLHUtZLSDA9DKAQPpA
         RBZIt+5+oD+Tf+E1eJuH1QJsmxxKRApT5UaheSvtZ/tjpKJCMF24XuA2ouf9WZJ98rnH
         /hNw==
X-Gm-Message-State: AOJu0Yys942mrHFPAuF4ZcFVaSFSh+s9/uTRSEBS+9n0ZMc4c2sX1PH6
	fhboaIb8nAt8mtnNRqwvrZT+hqWik1Y2FsylljJxi23dFLEsywl3rddApXlktgIzFeh8l1ul4HY
	WJs4nA7ewM4Z53SNRbLlTVIoRdYIPo+E=
X-Gm-Gg: Acq92OEFR1B4ohq6DzWOWcsRIyH/AIgjGMStj6i0tlsUSQHk/2Tmdtt/zSGGxPEo8oe
	a3x20XxbSNT4rWmY4i17rkgfYnbHxusgWJuF/0WY1K4CwRFqlcOKZrTTzvtmPulPjY2WR0XHhKe
	UxUVRRC/y9Fhfl0L3vNGsYDfkFDe9/rYlT0b8HfafzV5uqHbK8L0bPwSEicWppeAzaeVXuVh8V/
	D0mOEc6PsSGHBcTtWVxwFI72aoBV8AyVIGDniw0CvcWWDymuhW0kXmWq1pJrGYMxH28pfqXnZao
	5XboCX4Ani8f2OItXdiffVgxahXE
X-Received: by 2002:a05:690c:6001:b0:7bd:73f3:7a8d with SMTP id
 00721157ae682-7ea4c1bb51cmr59504707b3.42.1780568373992; Thu, 04 Jun 2026
 03:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com> <xmqqv7bzp0vc.fsf@gitster.g>
In-Reply-To: <xmqqv7bzp0vc.fsf@gitster.g>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 4 Jun 2026 15:49:21 +0530
X-Gm-Features: AVHnY4IVVckFL1LFU1Ftf0LZvh0p3a5koB0-B0boedPdzJiQTPU9fZ8U68dE5cU
Message-ID: <CALE2CrTF_HexShFLdh-Z0zJHcyeB3jOrTxLieZS++1GVqTesjg@mail.gmail.com>
Subject: Re: [PATCH] transport-helper: fix TSAN race in transfer_debug()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, Jun 4, 2026 at 6:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> Would it be possible that transfer_debug_enabled is still -1 at this
> point?  We would proceed in such a case, which is a bit different from
> what would have happened in the original.
>
> Perhaps
>
>         if (transfer_debug_enabled <=3D 0)
>                 return;
>
> is what you want?  I dunno.

You're right. The original code would never proceed while the value was sti=
ll
negative, whereas my change would.

I'll update it to use <=3D 0 and send a v2.

Thanks,
Pushkar
