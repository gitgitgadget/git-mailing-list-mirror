Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E33264E8
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564846; cv=none; b=nIqc+mG1YOPfeAKaGe9Nmih7UiKf+/pHdqy/qfqxPcovNRHTLWlzwKZD5Pdkjys7LVXgEhXUb2O68XJAwRO7YJOJArJayJaW7zj8WHFm1kshIsgzRS3jHY93XEn+n5zAXrBMuSmy4+DrIlu6R8ooQ0pp1oDp1K4sX/20sq4ttY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564846; c=relaxed/simple;
	bh=bLr6JltMrosOCvOh7Qp+HN49WglDQ6EkJljQfLJFPfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws8y/DqKRiG71UqJrHcI9lQKLUsyDPKldBLAp0r9I0Fn0SblMbyKS/lrqA04vQWVrLtQEZLoxdk4e+Mnk/H1wYmK+mSmwMVOcjHVSumM8iMGZSuUqIJuu06PZ4qT07GMEVbgaZG9EmI0dcBH+TNgdc+5V9TNH4SFAERBb4K6qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOZccyY6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOZccyY6"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2676923b3a.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772564845; x=1773169645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jn6iWX73rsSMHqHltz24qiKE7phzoU7Z74IEDqNCMA=;
        b=ZOZccyY6j5jdewrv8p1flsxzWuHB7azEklxyPjliZ1UKdj9sGvasja4nRVQ0jjH963
         iW1bf2lgu9HQDbZMa8/OlSStkmOd1x4LM3heE+s88bC9AYxngkyAYlOyCEFQxsGXigls
         XPtkgw/BU4yY1qwFC5Z1OzOyzChfgxn6RNuXS3qUuI/V+fUWcYZyCCXL2QBBA0NO44Aj
         Q/cyug1lhgdJljdGWdZKxs3brZUYyIVmKQkanKm2WyLAB87fVmrgFcsiOEBVAxjm6zCT
         fGe0ttB0L86WdZlEFYmplIWaVcc9ei7Rm2rjTYCXMPLxzmrvjaBtNeEigvxcsP8tiZYV
         o/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564845; x=1773169645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jn6iWX73rsSMHqHltz24qiKE7phzoU7Z74IEDqNCMA=;
        b=ATVBySD4cn2dZr+AdomhanjWz+U43lXvNFssfl+FFb2aiv+IbEZR+inHdzmmJWfvq9
         pxAghRpVvfK4SARf8JWkYRPw3yPP+dOplShP1msLZPR4ihgw8DapSEIPkzRQRkLqExOU
         QshaVGYEghF+q2A6WWcGZCZ9rLyI4bzlJoc6G1NmH4RmoTk+97gosg4H8db+bT31ryF8
         H/fntYOLP0+Ecb+OhqtLpLB9KqyjS3K28gbyBuOVfjOvMsvgUv1a1Zkcisp84vG77ueN
         4BC7jgMfpcqqahgU/oCp8oMWlAMD88iA59JjR1R31AR65mk5luQuwZP0A4/0MH/UMGJe
         fI5Q==
X-Gm-Message-State: AOJu0Yzt4l5uhjO0pmMHJZpeN7PYvCTU1aH03lJwau6fUYLOMhatRmTD
	9QHFzxMXMtYqv7yjcN+S6tm9A3gg+HuKUT3JzNsE/LC0oVQtyHyfrLf597ObKQ==
X-Gm-Gg: ATEYQzwNs63VUdgw3eUFUX9nAm66ohRKpPZiBHVqccA4FILbdmAqO85s4VMseZQ4OZ3
	ecRERyWFls9nY3c/WUdDgWq2zcpEC0mOf7s3fo8ZMBFxaHtkam/5HPK63cUEPztLPiyHgXXv0Pr
	A+sTWH9yCQlGvR0G6RKbQeeg9RzA8RWguNgGJW3QEF9rm6DEPQKaZRaecfgnzOVd11ABHJPV+2U
	1uUoKyW4YrdPM7X4aLSWFN4+yrPKB+0KIS4k0Epv8SSyUxagsB81o05YHxj010DC6sror3yLeHH
	+oJVVx4c9E5KGNyC7YPFHOgA0JLBb5hyZUKItE/ogMY0dgSbZrDXGrcMe+KixIZaXlSWz2OfSE1
	eA6UunPBiZa27pxvnLo+HPeLiKNWuOOSgYUOKkYXodoBSqVMR21LGMZ3rAhBs6PO0jubzYsKJna
	nX78Fgk13BRGep8QSs56qM2X0G35T1nGuwbTDzBA2sdSo=
X-Received: by 2002:a17:90a:f950:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35965c17f28mr13615890a91.7.1772564844409;
        Tue, 03 Mar 2026 11:07:24 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:2249:e435:e637:8c99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599cc26286sm1481397a91.11.2026.03.03.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 11:07:23 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email
Subject: Re: [PATCH v4] send-email: validate charset name in 8bit encoding prompt
Date: Wed,  4 Mar 2026 00:36:58 +0530
Message-ID: <20260303190713.153825-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqo6l643ga.fsf@gitster.g>
References: <xmqqo6l643ga.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Additionally, the wording of the first prompt can confuse the user if not
> > read properly or under any default assumptions for a yes/no prompt. Change
> > the wording to make it explicitly clear to the user that the prompt needs a
> > string input, UTF-8 being the default.
> >
> > The intended flow is,
> >
> >         Declare which 8bit encoding to use [default: UTF-8]? foobar
> >         <foobar> does not appear to be a valid charset name. Use it anyway [y/N]?
> >
> > [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
> >
> > Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> > ---
> > Changes in v4:
> >  - removed the confirm_ask() helper and changes to ask().
> >  - make a new warning/confirmation prompt specific to the 8bit encoding flow.
>
> Looking quite straight-forward.  Will replace.
>
> Shall we declare victory and mark the topic for 'next'?
>
> Thanks.

Yup, it is good to go from my side, presumably from Ben too.

Best,
Shreyansh
