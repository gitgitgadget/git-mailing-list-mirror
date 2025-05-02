Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37B6EB79
	for <git@vger.kernel.org>; Fri,  2 May 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746225936; cv=none; b=mKmOopkayzi7kL2IucNBuLU1GOE/9TYUlNw3pIRcgaHrhixKy7bDCVNSIv4hCXg3Fdk8j/hvHth/4WeV/yK64PdXZCHJIkSBLEFHWHDf02pEz8B1CZQC21FeGbLFOr+2kiub0iELS0bqRrWBXSC/YOzdk8cbMcUW2XSNX34i5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746225936; c=relaxed/simple;
	bh=xzvn7tOpvlBHkYxVG3yxKWyEk66XBv0AM528PEZV29U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Foju2ahkqXjHgCzImYqErHlSzxHXjtSp1+6zaWa9KP5av7c3OWOtl+bcSYmtH6XA0b+X2pB7jo6a1AfW7qxRCI3H22cSrTXdsFN1BFJMWw6C2KndTTUintVHwvR6nNdyTtmhfX74CIYmKikZ3cKbjGWkmHCjAphg/3tjpAO5L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Mk0FQ9gK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Mk0FQ9gK"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4774193fdffso44237161cf.1
        for <git@vger.kernel.org>; Fri, 02 May 2025 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746225933; x=1746830733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idzOGxwqCRLb5PHqyMKFXw/X36PRPQYNMJAQHoVgIZI=;
        b=Mk0FQ9gKOjD/1I/RDz6FzJZOdGyqyHTQCEqHaxpVOCnHeQ4OZg3TY0/LSxZvJFQZL2
         F58vshvRrpyhXe5p4O2vLZObLInLoJTiItqsJqiQG3N4psO8IGTvTOOfBVgMrt4Tc6K5
         TPbQV1UwuCxqOGfqOHAIv5U0xHckYNyDGWpnTEUQpjVo94ipRyp3k6hHzFdVr7Gw/d5+
         mHysoepDnWJebSIDsvel7A9OsAfvCSAp0bWkqLfT/m2OZFuhNY5ausjuLw7AWhYdLUxA
         vgNw5YfCWhrbQacqik39utW/WePu4oetkvOz+5yctr1MIlCe/VMYFqta4M+WCftwbrwZ
         p3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746225933; x=1746830733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idzOGxwqCRLb5PHqyMKFXw/X36PRPQYNMJAQHoVgIZI=;
        b=C+su6ZTgkfuDelgJUZseMCftIDSsjFdRTcwXqRTV2wTo0RV3BPzJy4iqHqm59WA5X6
         6fYZkjWXXYjZc1yDxJpVRLBzSvXugemedvDEi5aGGje5j/piCR7Uh92a4ngIcTDtevDF
         LTI1JSTftC7gg+BHM7bp+4540XZHLKLD9avjzg+qWnRE76M0t/QscovMZ4MwTUxKnCol
         YqqiF7FTxvR9aFu8Gxcpj3wdMOL+4V5VPU0j0ElLn633acLhlm//0f9Sy409ANODAOAK
         Zikmsqz0LKnn/zwTTsOPeKmp2skRcbD6gOin+k8AQ1cckQXkaBw/3ubLuKngLsvlEOcw
         3QLA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJm/k5FyauKotRqpTADVW5+LOeBzXcaxZYHyo6YXrTz0r79HroiPRz+Bh4fCL4DyvXAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGzy/KmwjUWgICIhKzvcj74oJ2GviHpfIdfkHOgKAPuHmwFyb
	Q3+EjCB5Ts8eFc2jxmdHa2vxqljd/WzDQLNluufIC3GuzzSZh9XmOzaKiqlrARE=
X-Gm-Gg: ASbGnctGP9JgSIdV3XhaKPbus4s0HQhB+4P9ftwKAhSyi3VYZoMqZrtDylsQWpd/4Oo
	GBAOpiApIvQXOcdG5kRrnDpqNXFi2zforLI6jImmq2dNVmw4Hd7zAZwKjgv+dqjYCZX98hOQcOa
	lrpBKuBMue1iCIjZCUXujjT9sJ+G5NoZJkm530ode3FUMRmA+LrnQo5dkRNLF+MJbuFEHNVpbXZ
	XqFDxHSShCCQGou5MLQek5angemAp5+Hk8kxsCExzZ/2QVnfNKTmJeHxK04hjxrwDmXmTOrOq5+
	vFE3tMYj5D9EidLLIMgU3rAOQ2m2792qB+pfVte4GonXUH9b05Y3Q9ENw5hQIERinDN7MZvNah7
	g7SiJl8Fz0ejEXh0Ar89tdjs=
X-Google-Smtp-Source: AGHT+IGwiyabKxFtvUL70vM/+pMchMfa00y+lrlmAAPkrXCZXOo+gEtlYbWd3hCF38ptVawn3npLAQ==
X-Received: by 2002:a05:622a:2b4b:b0:477:d00:b43e with SMTP id d75a77b69052e-48c32ac9e96mr86404091cf.38.1746225933404;
        Fri, 02 May 2025 15:45:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b987209f1sm24263251cf.52.2025.05.02.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:45:33 -0700 (PDT)
Date: Fri, 2 May 2025 18:45:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
Message-ID: <aBVLC57bMJKjygyi@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <xmqqbjsau2nl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjsau2nl.fsf@gitster.g>

On Fri, May 02, 2025 at 02:24:30PM -0700, Junio C Hamano wrote:
> > Updates in v2
> > =============
> >
> >  * Re-added a dropped comment when moving code in patch 1.
> >  * Updated documentation to include interaction with --use-bitmap-index.
> >  * An UNUSED parameter is now used, reducing the use of global variables
> >    slightly.
>
> The iteration saw no comments from anybody, so I (naturally) forgot
> about it for quite a long time.  Let me mark it for 'next'.

Sorry, this fell off of my to-do list. I don't want to hold things up
further, but would appreciate a chance to review this before it hits
'next'.

I can take a look now.

Thanks,
Taylor
