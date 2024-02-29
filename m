Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E742A8C
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250788; cv=none; b=u82bsS9xQ+4psQODlmoQ2eLCMlbNe6++fP1j9tCZJUBdyZu/OPwJHaAz91MnkgcOsfPPSQ1YUbldB04Pl9zAIOS0O8bcvACkWWwswJcoIuayHMw7xEeJ8PL44kmzs4Uda/XDUNuI9OOelvgtMWLhYtfqVtDDjTu/nKh4AYQTjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250788; c=relaxed/simple;
	bh=syBomYuvU0JzrxMbKK25F99si8Wb7gizKgJ9rBhYBww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L96h7ixjG2xF03G5xHVr3ICMFXuCh4Bq8wMybm/2PQofdxfNdwGfdrFAi2WuOmmKGjG2fbkjcwJRd0vRmWvlOod5n3oWHOsLrc+tgaTfYbU6+OCodxwS9C7w9cHW45vUEYq9u7kMT0qSrSXBlZdve44SS0Imo1T706L/231HY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykswRDRo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykswRDRo"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e57168590aso1348337b3a.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709250786; x=1709855586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hblhF1gFvw3mKYSXoqTXTlpnkxXDZorchexQwuT2tLk=;
        b=ykswRDRo2GwdKGLSLJIyROBeLNMDnnc94UVRO8rgU9fdbA1ntMKX5K4z1mWoNtl39N
         YKkoyHNvN28mYhiuGGBpucNW+QR/wZjJFhHnADq7pFdVRbesddEQD5wcnBC3o8GXGP9o
         Gf3iIEBR+SK9miebLIKOYg086gVKMaVEdG8AoVGYCKO/JeW5JAqqndCRRgz3BwuZ06qT
         5+fcURRoo+5DY6I5zemX5wVwFQ3Y519unS26J2UVbeohGPwLnUtyLk2Rv3K9C5fvHZTt
         F84XNWRIcJylYzBJT3whFAH4K06tZqmZ4VQxEndfPlY/632Z72z9xcSAp47mgSV/wMqJ
         WdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250786; x=1709855586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hblhF1gFvw3mKYSXoqTXTlpnkxXDZorchexQwuT2tLk=;
        b=qHWIFLxYboXZGcGSvMXOC97UvGsvXCz6DLIk8G8AY848pfW5xIABBAtjU95XmYGO5u
         YPtbzhKA9eF36MTi+YlqQUhFOYMKbs1eESPX49z2zzhnLE0tM8x3zAP2JzxeCEFpaoqL
         BX49N9Ls2QsGlA8+jaMbgJlktGbeBHCc1Q5/RuKYbPpu/widQnEQRza5APlBETWv6qnb
         r5WCmAsZjdyoz4nEKVy1eqRsSCkrFLN6yZVTsrebpL5my7yTLEMdG8FDBjjhW4O6l4gN
         VBmC5ncgm5LwLN13OGWucLbVKuAxH2GiOGtX4sNwFZmlxLOfZcE0KEDPjEscAO5G5Ma3
         035g==
X-Forwarded-Encrypted: i=1; AJvYcCWEYHItr6vcwmY24f8xcNt66uOphvmtRprgbQzn8nS/DrglBQx58fCV3a2XS5XTShuEWoNEPw4DEsdLBuSJ/yx4OMjI
X-Gm-Message-State: AOJu0YyLrh3+ZFbH68qbiT4m35q2WoljLCD9p0n4HFgtl54GDd57sAdy
	J9Pw450svvvnM1qITGjS+2Eyajt/YQKhfYZTAM/PToTkj1qpcwTaGsX/cW/QkifA4/KLFxBAtqg
	E1Q==
X-Google-Smtp-Source: AGHT+IHjS44H4ENWd9+dlC6eij6VB4JpKo/76hZou/21mRl0UKAmP+FNAeq/cS5lqtvIwKhiQpzvzXbpr+E=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:aa7:8887:0:b0:6e3:bd7c:7f44 with SMTP id
 z7-20020aa78887000000b006e3bd7c7f44mr7867pfe.5.1709250786206; Thu, 29 Feb
 2024 15:53:06 -0800 (PST)
Date: Thu, 29 Feb 2024 15:53:04 -0800
In-Reply-To: <xmqqedcuc0w3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
 <CAP8UFD1dE2EiSxohose6U9SGn+zeHPyVB=KZ2xdQi-v-a8d1XQ@mail.gmail.com>
 <owlyttlq529h.fsf@fine.c.googlers.com> <xmqqedcuc0w3.fsf@gitster.g>
Message-ID: <owlyle724ylb.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 3/9] trailer: prepare to expose functions as part of API
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> Nit: this patch and the next one will become commits, so perhaps:
>>>
>>> s/In the next patch/In a following commit/
>>
>> TBH I've always wondered whether "patch" or "commit" matters --- I've
>> seen examples of patch series that referred to "commits" instead of
>> "patches", and vice versa. I was hoping to hear an opinion on this, so
>> I'm happy to see (and apply) your suggestion. Thanks.
>
> I think it is just fine to use either; sticking to one you pick
> consistently in the same series would have value.  If you prefer
> commit, then fine.  If you like patch, that's fine too.

Makes sense, thanks.
