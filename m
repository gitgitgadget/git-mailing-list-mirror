Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577E14C5BA
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287714; cv=none; b=EXhCCFwxpa7cv+PIRJkm2u6iHSm6LETUfweRnSUxbnuL+UNn2C1RSmW10TC7kkNEIJ1hcMxeT5uy0GwRmEN55nwHbcY8kwSLmhyWr2/jYyONRSiYvxs2LxCAC2ku1RF/mJIxgV/X6hI9PvvDtj+KAeLhJ7Vp4UBU3wPhgWaLQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287714; c=relaxed/simple;
	bh=Cfwr7miogGc8LqYoimHzF71TV+2ZIhXnJhZOsRz73js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVjpRmJl3KBk+pleuVNSf8ubmBW/NiA7wKeB1IzP9dgYIfL6viwcnOCSqEeIAZ3r7A4XwH++okZt/x0x8umKfYL8h/IvHeDLuiDXCqgHkcDwOXntv6YbVhqv7Upzgxdrvg/MWLdxYymnwPyZCWxAnaebUct8F6y7lkowA9WRnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ngAhwq7D; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ngAhwq7D"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e290554afb4so2589304276.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287712; x=1729892512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfwr7miogGc8LqYoimHzF71TV+2ZIhXnJhZOsRz73js=;
        b=ngAhwq7DVcE0xjZrEA8YKJOLKUcspiB0SOluABsXYUCGxAEizHVEIS9Log4bzOxBS3
         ifPIYVlR217+15Bv75yRiSDrk2XdPTeFY4emiwHdZRzKEv//IAeQ9lORcBIIM2RyFJGe
         UikorCDBN9oPk0CboZOo9srN3NN7One5kGmD17SM3MXyJ45TvrJnhwLqEhZ5DfAuMuFA
         neZrL2NRjwgCo9jpCg8JUpsC36w3ANthwMn2m/FhGAHZnSb68FI2H/pPWkUhfxOmtmLz
         Oa4nnjv3QyvJu1+9deVlG8Fv82bSIPbvTl5OsDh3EUASovb9nKHdn94xw3XUJRKpTGpX
         CW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287712; x=1729892512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfwr7miogGc8LqYoimHzF71TV+2ZIhXnJhZOsRz73js=;
        b=wOn4h6ijEkcdPBmRmk88g4ltJMBR86gfBbfeyF77o5/g9acGFcY/Ne87vdvt66RUjy
         x3tvQbwFQ0rGjUT2jrUQxzbyJsUqRfSExExZdtrdTtULuPYKswolUA+OYqHn/I+oALCb
         Q5Q189Bj3BDXl+sFlnPh48JVskhZwRgM2JyMZqk6S01xqvmTHE/lqnm/xXa4fDM2x5uz
         ePQb81tqSVeE699/UmcFhkMS9QBYd+JdhKLUKY2ZNB53wud6lAKqzqodhWSbughxKxew
         agM9jEmszvRx9jg7i7jpGRQM0texAvhiTVnQFboUDeXN9bcZiki3+SgjcCIb002sJU5y
         K+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVFr4hb7tWAR6B5bWLxKuryEcaAwXBHVlpNT0AYN9ZPEzuZXqb89A8LAGE2iPyk522DIgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7W7k6mbercei44iRXH0FzHYkUVlU6qO2SlNiqL8ygBxLhpl+L
	pf5eebDQU1BdK9wgdZuChe0dh4XjcWDMIqZwU84gK+olfwbZBhdECjrqg8TYaVgvJVbZylLBFol
	I
X-Google-Smtp-Source: AGHT+IH3VRiEwYVoecSQqorhdh5yGa4xtDHKxN4YkZGljPLorZSwX3+3yBcHGTGcLk1sjOezRg2Iaw==
X-Received: by 2002:a05:6902:1003:b0:e29:acb:ecb with SMTP id 3f1490d57ef6-e2bb142827dmr3526729276.25.1729287711752;
        Fri, 18 Oct 2024 14:41:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb022c8ecsm462914276.27.2024.10.18.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:41:51 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:41:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v3 00/10] reftable: stop using `struct strbuf`
Message-ID: <ZxLWHOMIqBka5T9e@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
 <ZxF6+ze67duAO8fn@nand.local>
 <CAOLa=ZStxERhENJ_3osJCWR7u6Pr1YeMjCf3UvTxnce9SDReLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZStxERhENJ_3osJCWR7u6Pr1YeMjCf3UvTxnce9SDReLA@mail.gmail.com>

On Fri, Oct 18, 2024 at 12:46:02AM -0700, karthik nayak wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Oct 17, 2024 at 06:53:42AM +0200, Patrick Steinhardt wrote:
> >> Range-diff against v2:
> >
> > The range-diff looks like we're getting close here, or are already
> > there. Do others agree that this is ready to start merging down?
> >
> > Thanks,
> > Taylor
>
> I had already reviewed version 1, having a look at the range-diff now,
> seems like it is ready to be merged!

Thanks, both.

Thanks,
Taylor
