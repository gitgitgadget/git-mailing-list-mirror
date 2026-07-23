Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922253AE184
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793303; cv=none; b=blal0TZ68218heHg05nZ5Ofl2EsYiSnSjqnFzFwDOcAVuzRiT8T+gQwkTBSEL3dvX+SVK6sqF1mXWV4D5B3HqC5ii2fFeyxYV/0NLvlyPxGH9tjx3LreiEcxlAvyy5pykr3OinbppQsD6Wz/w5q+LtuhQqOOBg9Ec1jtmsa9V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793303; c=relaxed/simple;
	bh=YWkpU4Ku+AhXbJcV9SfM+Kz6eR8MVUMmogWjRjpb9Dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lkmbDtBjevwdCT/zaEkD9S9rbcZzSqag6Gg8S3CUFdmbHbWaqlKuhrUKEdEolixON3wBiJJ2ggJds/RjXFBRPb1CG4HnjTdhn/jopIkFSNpLhzfKiW/9UdE5Zr1Gykp4KTdwhC1qRdW4QoV5mxhKuWBkRxnkkCK+7duwDg+n8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZnuVJXr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZnuVJXr"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e347638adso370116a91.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784793302; x=1785398102; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YWkpU4Ku+AhXbJcV9SfM+Kz6eR8MVUMmogWjRjpb9Dw=;
        b=eZnuVJXrA6sIxR8LB9hC2KyGpXtx1PiMqzxma+TZNDj+M9GfZqk7vBVMR2W1LRDXGc
         fdva25rWwQpiaxYh+8AV6qYupqHa+aQ63CmHdFzjDrBHW+x2RAcHLajh5lXsX0d54Ujc
         7ZST5EfR/M186RNdz8kjOvTjtNdPufH88RrYw4jVRdLQjGWW4f1d9FoxMgxwBlMdK20p
         ESlwEtPzK70aPUiY9HloPvgF6UuEs6XA8CETRnAmLE+RZe2K+0qCGnQNyMV7tEkRo/Co
         gt/SBZTf/uU7SawJ/Fgp8GKim5NVV7jj6mewukyaetoLT6yos8/LluDCn5V8xbJsSyUk
         tePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793302; x=1785398102;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWkpU4Ku+AhXbJcV9SfM+Kz6eR8MVUMmogWjRjpb9Dw=;
        b=CFDcD5tk+Tq+0jg6VT88dkJI3i2/tf/Jp9PYyzkT+NZLwfZ60AV14/vHan3cyRoxgr
         Jxa6OaO77Pv61qO/FemBKIuj+rbL14/UKB7mFmBqYCul7ZcEhymkVWuHiDJBhKIuFS/L
         Q6bBinOCwG1NDmaWct3cQFS6TEv++DpDvCVYANOSSGB0PO8fc0LRuucfBQ6NKeWBPJss
         0uU0W9Ejbt1xwCgwswQ2ujEhjv3SrC+wq/hiXxMu6rh/bkI1W4gJY9/JeF11pDAOdpny
         x/HYnGCEYQY1QdxNcWj4gSO1jS6mQTvj5iBmFFIk8IpoVMnqNy3hHVu58Ffaverx24WG
         j2mg==
X-Gm-Message-State: AOJu0YyLd/MEN4tPyy4rpxB41rcCpMY9M8y82OpRR2KTaWfaq0IAJ6bh
	yihcTKCQ/YhHng6vyCC4VCO5Qb8gvgTIgBZ/YSvOTjQ8Xsnm20iHscIq
X-Gm-Gg: AR+sD11lYtCeBPx4zD8w/0lLw0j7L/50NMYZZrCO+KC/oAcvBpiljDqXR/IFxkToEXe
	4S4XXSiRtOX6AOVyj3kJRnPrycskKsBbM2BclUPw7vuMwDeWu/ljp0ZIlxW8qRMTuy1tJz4Q0hY
	UMMaXV3Eb9uxJOwAFntMkogQESJqgB7IY2+B+t6r6mnRIZ0Icg0uRalsHRID0rcCARwSBSNEwrd
	9zTe5LlGktfMCoI5VJ2tl8LGq5jg8V8JmRUEpwQKBqqaPU8gcvFVT7K89lkIW/DbJRkIVSSlxBs
	eKGpXnyEHYxQ+i2oDJgHKRqkZtaIOYF345ca5VNAPl2jXotXEaPFG1s7bRzOi7TXmq62HeTqV5W
	aXK3aICkYUkktumjQ5xorLZaxxBI7HkpEek3v5OWYExHzuiQCWEB0KSx2Zvj/7J32JP50uuY4Pk
	s=
X-Received: by 2002:a05:6a20:e196:b0:3c3:89cf:f3a with SMTP id adf61e73a8af0-3c44afb1adcmr2148196637.5.1784793301709;
        Thu, 23 Jul 2026 00:55:01 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d1300401fsm18326119c88.3.2026.07.23.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 13:24:52 +0530
Message-Id: <DK5SF3BIERU1.U4Y4PNRU0ARJ@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Extract only the message body from git commit.
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "hardikxk" <hardikxk@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260722083836.744338-1-hardikxk@gmail.com>
 <20260722083836.744338-2-hardikxk@gmail.com> <xmqqtspqn3v1.fsf@gitster.g>
In-Reply-To: <xmqqtspqn3v1.fsf@gitster.g>

Thanks for review. I will take care of the conventions moving forward.
Also if possible could you clarify the fixme (or remove it if it no
longer seems to be valid).
