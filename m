Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6D156248
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683867; cv=none; b=nmj6UsbGaZ7G+LuFf6vSn0PX6SVhMTuYoOUY8R/6PHgM6fFfdAXnHAD/R9JUPZTXv6RacDb013TP/LEndb7OE2HJgMQCtlr1b4wC8TVRrIiH/mHYl/AGFEiD3SIWP9i42uu+feRAiRHStUrR3kzMrNxnMdV+nKNTmrHukACu19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683867; c=relaxed/simple;
	bh=OFowAFFXw34SjGI7EvwswvJaTjG0+159AzLFntMj/uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alY/e822otss2zdC+wJb1W2oIM4V8SNoaHtmhuyQfj6onG8ZewtN9OmkN0KAPhF49qkB4skSIJH+6WLM83AwYm4GCOQ6tk11LTfphyXVK1EMFD7xPqFwCZ2lw1106xCSMT7zhG1ojjtTS4drINJdG3eiSxzSBv8KZM+EJkOBrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOtQwR25; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOtQwR25"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4348110e888so17431cf.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712683865; x=1713288665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFowAFFXw34SjGI7EvwswvJaTjG0+159AzLFntMj/uI=;
        b=OOtQwR25hyq6azoNs84GlHZuDWk1cqqh8vcvP0fCaHWAfrmrAMP8wjfl9EPIG5BtCs
         7yZAPKbEOy/29lpIm84cHnuzAZAMoxkNpRECeAl42tDISO1351rdAIKrYqzFfKnqWdz/
         9GrZIOC2Oo5GI/lYvgfUpxYWlc5kZ5yVuP6q/w4YTHQO3Fldnn2qsIRgazONAHD6kKOI
         t7MoNkWBZum3wamc46ZU+C7ygKyuT3uRkCekXD+JrQIFuaaz5BWp6Tb0Tgkjr0fsQX5E
         6UwEEoQjzzIkgN7AFsXd9VharJYSmdR5cTBKYdG2D0j7N+X+i/F0/gYTBsf1541vk5Cm
         7Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683865; x=1713288665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFowAFFXw34SjGI7EvwswvJaTjG0+159AzLFntMj/uI=;
        b=BCpi+KsxPy2lJf28y5RqXm3Bs1Zsg8Q8xR5Kp1mmdQyquSHWmwj3b0GUufHW0/8Sjf
         64Es9O87MTLmxNeE+9Ndjq3xR4/HYoH6v8QqIvqZG/wE3MQSl2shXEatvQ48wRqFsE7t
         9YB86pxGPIITqTfrnXSc7dwguhLV71JSJiz4Ldsq9xhQivF4NJwAn+jg3GOEsxmPJdsa
         hgQY4KJMM0T2P0enddydDYe8oRy9zu6NgEDPxiDIKCx2gxf4FRsEBue1ReOq4+0h4ag4
         y7NSL5NCBHnLgIbdmyFjCuEQPw5VLmpJVYm0TLtM7Ws25YR1/PTW/3G08MpapMARC0Mc
         qriA==
X-Forwarded-Encrypted: i=1; AJvYcCWajjOiNvVfX3INRej5T49KRJnJRxcCCAMs/djAJjSZwuUbKByww8q2Lsnx8rzaKp/dKJTefUbJAKCFQ3f1iVf2WEKD
X-Gm-Message-State: AOJu0YzZXCBW3O+bkWvFVe4g+TLDjbBYQUQmzfA99RpzbFF8LpPsLe+D
	3imRPd8InmnRGgmI+lnip3M1MJNiMFUnijBFPU1mTgovXBWPNtSffZ1dXTj5UPur1iquFhb5DjP
	sbV5+XNtNEF/c7cFHsli5Rg/IY9moDOkCq2zb
X-Google-Smtp-Source: AGHT+IEZPpgbPRcs+dS1Oh7G9/TAYUWL0PX5JKTNXMP0DTHRDPSi6vaC4K5+yxhTsy90+wDxchmyMLHG2CmtVOX4Pfw=
X-Received: by 2002:a05:622a:4888:b0:430:ed37:bad0 with SMTP id
 fc8-20020a05622a488800b00430ed37bad0mr322865qtb.13.1712683865123; Tue, 09 Apr
 2024 10:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net> <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
 <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net> <xmqqr0ff8rwo.fsf@gitster.g> <5663500c-ea40-45a6-bb7d-c906aee4350c@gmail.com>
In-Reply-To: <5663500c-ea40-45a6-bb7d-c906aee4350c@gmail.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 9 Apr 2024 10:30:54 -0700
Message-ID: <CAFySSZBC6RMC3rqcMVNKUbzM_a6n5sAnKCo2rqpHmwTS4R0=GQ@mail.gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	rsbecker@nexbridge.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:40=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Indeed, the last set of patches allow git to be built with the same
> library that external programs can use which I thought was very welcome.
> This proposal seems to be backing away from that.

One of the questions I was grappling with was, do we want to expose
all functions to external users? While it is debatable whether we
would like that exposure for some of the files in libstdgit, functions
in wrapper.c and usage.c seem like clear candidates for functions that
have no value being exposed externally while also making it more
difficult to maintain such a library in the future.
