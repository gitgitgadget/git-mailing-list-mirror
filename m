Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D8131E23
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958697; cv=none; b=UqBWzQNz4KMGQ56TNufIGP0AuqB8keS1n346HvmabGO/ZUw6uN6Cs8ZL234SO2Lr+5VSM+JAWGDXW8Objn+piF+nyll6APCGN25pOWQc/uZIk2RXQUmgpGOnpLBgClnMD6tqMg0s9mK3NtrdLKvSov2pFK/i+hhIUOQUHE3TH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958697; c=relaxed/simple;
	bh=cigvC6pfgcoPIsrTJ7NbmWdd90NmpkF65U0dK68E6/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLNI2JY3J+8Nlub77RjWk5LGfXXmlCCmprrT1KQfQ8pIhgnWhU5UwwvdokdF3y2Lw7lhhJTKvhqVgS/OjMyo4RsMivHnCKzNvp8873RL+yM0LjGwnkXfHEzBLnzKzJ9VSgCkDir42kidFlkTSQxI8qFrkJL/wCrsDsdp7UEvwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TuAQVRC7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TuAQVRC7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-787b5c68253so221347885a.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1708958694; x=1709563494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brzYdzVN4L/TpNcqJdCy0dkJou2Bgo0B7riPmzO3vTI=;
        b=TuAQVRC7Es8p4COk4hd9t1G0kLLk+GEeh3DQwDg88X9E0uyBmLGcdEZMCftSxxpeo9
         Ir0dF4I6QkzZO6/dkDk15kh4dGfgBu+SSi69HPinbi+vInxfHF2ViQesBwILaHmdbbXH
         LJu7xUMf/3t6qVOpLSbtqni/cx/sIyBnc0qe8GKHob02np/WDMM+A5Obut6IgDE4gtv7
         KXdenzjgcVcFkWe60ZfLaaEJPpqU8CvtO0OnZypXc1SkvIJD4Bt1W7CJmh84tzLnWBHv
         z/0CmnS0IK4gDuy/J5MjLHOIVCT/n6QNCSNr7JsOjEweVC0nW8XBxVVxSY6/A0/pFo56
         p0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958694; x=1709563494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brzYdzVN4L/TpNcqJdCy0dkJou2Bgo0B7riPmzO3vTI=;
        b=k2cxL4ee/EnyWyNxqTRSVcAERCtcg2vw8kdTwLFaNfTF1jrCKxXu1sSbf286/apNZv
         XG3fM7AzgipPRSg7pIY+4WtkwFw6odI3mj+oknRe6WVEb7hR9sAjZri4vest+6x0pAw3
         ux6Y8EwKGcTqIi++NHUh04Bi33RHVWjVdp1R8f1dHES+XwgE42XDb2ahVjSqnjR/eA1U
         ZvaCOnpZ1nbmwdJr7UbbVLReUnVWDtd6W0H22N2pxWNIe0jDs6kyrbNr3CJtW0yWTK5b
         uYol09FQ6blUZ0vRxDI4yowN+NRqOTKleq7vqqH5boCSYuYgT2fYxNFrdrR+MKPqjTC0
         eYKw==
X-Forwarded-Encrypted: i=1; AJvYcCUh3pjPyEZzakHeltMvubgH1UFMO6AM2L0npZZ1Etq+PgPGD0AlOf8QYniV2HuogrNbn1Mf6pYIoCBl36VKbGoc9wGf
X-Gm-Message-State: AOJu0Yx/vlmXtBClwTHvn5qBHx+AYFZxDn5v96jTnY0KlT2zLmdgGDk4
	avj82Yhoc5snBhI0m3L0chbdaFv41yzAZU7B36AFBJrUN3xAJRL4Nc7nKRLRMT6nJDSFux6harX
	XPjE=
X-Google-Smtp-Source: AGHT+IEjn+UrVUHH4RhU2aPDTjfkYlv7f6CHMZAp8OhQt787Og4Ru9QvxGhkWLEZ75WvrJdTixs6+A==
X-Received: by 2002:ae9:e408:0:b0:785:812a:aed3 with SMTP id q8-20020ae9e408000000b00785812aaed3mr7151758qkc.78.1708958694394;
        Mon, 26 Feb 2024 06:44:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00787db370253sm391651qkb.92.2024.02.26.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:44:53 -0800 (PST)
Date: Mon, 26 Feb 2024 09:44:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <Zdyj5RsW59b5kC7m@nand.local>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <ZaMJU6MJ5wZxyLeM@nand.local>
 <20240113234134.GE3000857@szeder.dev>
 <ZabpBHBB1TXIXJLr@nand.local>
 <20240225225918.GB1940392@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225225918.GB1940392@szeder.dev>

Hi SZEDER,

On Sun, Feb 25, 2024 at 11:59:18PM +0100, SZEDER Gábor wrote:
> It's great that we finally have test cases for different Bloom filter
> settings in different commit-graph layers, including a test case that
> merges those layers, but that test case doesn't check that the
> resulting merged commit-graph file contains the right settings.  And
> there is still no test case that merges layers with different Bloom
> filter versions.

Thanks for reviewing.

I'm happy to produce another round of this series that would address
what you've added here.

Are there any other specific things you'd like to see addressed in a
subsequent round? I want to make sure that I'm addressing all of your
concerns, and avoid the need for yet another round of this series that
addresses things that I could have done in the first place.

> I think adding these would be the bare minimum...  and would need more
> for due diligence.

As I said above, I'm happy to add these things in, but please do let me
know if there are others.

Thanks,
Taylor
