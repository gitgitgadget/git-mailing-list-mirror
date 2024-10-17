Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34621168BD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198762; cv=none; b=pY8vAYsaGOGrsx1eA7gTHJbsDnAnxZfqCuVTL5mzATn9bSZUinZNYtaX8u/EiCDw2ndAjsdrshZR43S2ehrNgiSK2tC1VAdOnhvSCq5FBYxLLozoSA6NMVqz9dtT4KBYCSCEXazaVsgXkRzfhgxJkQ+t2+RmSTpU6gxjUlxWVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198762; c=relaxed/simple;
	bh=Da3YlrYjwi9Sp+NUGXfehs+XTERopPAfOCshqeXprW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEK+AWhVQdbHYyjmFwnNKmpvMeC9FV/lvsOBlsxX+UmaXsLwWlrvBNR6oBhD5ACG5FgqF20bNV672ANzk6AtaK++U0pDEK1HNBxXcztL7ljNtAc4vDEZQWS4HpOK2vA/WFFAt+GUkABkRT0uGlckv4EKJ/0WimN60SQPJucpHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CTmk+meE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CTmk+meE"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2e41bd08bso17607117b3.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729198760; x=1729803560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIzcI0ZbSbEIbJcrEjwoNpCB5KyyHtYjpos8g3BG19U=;
        b=CTmk+meEOqcLYxxYWE94fEWrtcqWcyuuJQgl7V3nLHotyWq9MVWszBTYO9/YEPfY2C
         4HJZmnv+CGvKDKfeqxgxxiL+D0Y+IszhG9udjNWYKUOd9WARZP9GfEXViy7cK79d/y+a
         zC378YMksjbjzcu23MVPHNoO0/FpvF/g6mwGz5YdFlnkuuFR890q7ymCPbfPN7hCOiqw
         26/hjHPEgcLzkLNxVA4UbfI8sNu4y2EAtaUZrfwrPGpMha9ixMV135OQ+rWANORgYu8C
         9uMn5Np9RC7MD9epYYfWSQNq3vlS1pMwPLCH023GWRQshvzlTMMr3Uxngd8UbCnDjE/A
         SbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198760; x=1729803560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIzcI0ZbSbEIbJcrEjwoNpCB5KyyHtYjpos8g3BG19U=;
        b=fX/jE7C/zKC4k6/3qY97eNBgwYf874ZnrG6kMTqlVWd+i1njihkEvTE4lvYM6a+KVd
         mFtskohJUNSTuGfm2UDkVYjVacGH3qcV+6t/9QdnvrWWd/nwxD81lfDaWJURxGBNHlTb
         PAKBohEzW7J7Yl98VLZHAbQcxEOqMHQIUVFDtp8QJ8rdUvfWm3v3F5dEsS9L/x1qwmpO
         Cn9xPeOunWB2gACZ8XjaVdGLaf50Nk/Y2KF82zyzfBfRdXWciYRFrm/PYR8DtM9/dwXT
         9DMa6ITvJxAhc4ndfE1CpnLOYneGgcHhBuDtUTbFTS9H6YwjsQ4tuJ71haEGnsl8SpMc
         vIVA==
X-Forwarded-Encrypted: i=1; AJvYcCVR7p8G9MImF2CdrjJ4xnyf8Ew9AQB1CXHGvU3o9GMmc5DCbtIwbjkl3yYNA6TZh9bR0ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67Iz7/6n7lj0zY5i1jESl/9tUIP7+HC4QQxHvZy4BeDxzeFIP
	H4HRiUAgoJ/AsvVZsxzQfQAuv28iB/G7hwc33b0PSrJAFL9/sBtvvvTmACAdk7/D2pkKL9eOn1p
	l
X-Google-Smtp-Source: AGHT+IEGGtLkvQMaflD4c5nrP4IOSmqDKpYo2b3Nv30wEMGryigwNUSBA/CaPmJ+zP72fRiQAla+oA==
X-Received: by 2002:a05:690c:93:b0:6e3:3dbc:ca60 with SMTP id 00721157ae682-6e5bf735420mr3408127b3.8.1729198760122;
        Thu, 17 Oct 2024 13:59:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c011518asm364447b3.71.2024.10.17.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:59:19 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:59:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <ZxF6pQpsnjLmTZ9H@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
 <Zw3xhwLFlznU_JvK@pks.im>
 <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
 <Zw7CIRoXrLr5pd5A@nand.local>
 <Zw98hKZc1pjBGGcU@pks.im>
 <ZxAolGGcndQzApPJ@nand.local>
 <ZxCYk99oZLUaCkrd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxCYk99oZLUaCkrd@pks.im>

On Thu, Oct 17, 2024 at 06:54:51AM +0200, Patrick Steinhardt wrote:
> > I don't feel very strongly about it, but I had suggested it because my
> > initial read of this patch confused me, and I had wondered if others may
> > be similarly confused.
> >
> > For what it's worth, I was thinking something on the order of the
> > following added to the patch message:
> >
> >     Note that the reftable_buf_add() function intentionally takes a "const
> >     void *" instead of a "const char *" (as does its strbuf counterpart,
> >     strbuf_add()) to emphasize that the buffer may contain NUL characters.
> >
> > But, as I said, I don't feel very strongly about it.
>
> You know: let me amend the function documentation itself. That feels way
> less out of place compared to putting this info into the commit message
> and has the benefit that a future reader of the code will know why we
> have types without digging into the commit history.

Good idea, thanks.

Thanks,
Taylor
