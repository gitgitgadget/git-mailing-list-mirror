Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D231DF728
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137368; cv=none; b=Og+zm+7TXerXO/Se0GrKJsvpQVBiYIxOD4hrNvJOZeeVGvf2KTEzNldwtD2c5K9McwhT1Tbi2bO/4XmHbGQWY0FouExtH49hYEE2srp6BfjOZ1iPZbJcRHrz/glYftkgdoVMku7Q1+iZlObh7/fTnU6COxB2gihvyRzdcrVuDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137368; c=relaxed/simple;
	bh=iwf/Cnh4kDMb/cRqXM7NDxI0+z5+/OmQ7Lzqt5pecNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul5l+VKB7CDLkjAIgiQi5lpWfwwiDu/7z+sU7OgRyJ+9OR6gfKyab7i727flBvzyXlCkaT4KXSvnvedhieO2zHQZuPfwTmMhFCqqM3c0flqukuij5dOXfrTbhL7f0xLSLBnxZC5sWX72IzBBVaLybWG/ifsptrXzJfl+nuK1M+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sj6pMcOA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sj6pMcOA"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e8063533b5so44441657b3.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730137365; x=1730742165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VxR+UF8oQoTBjXQx3TUbZpiRr/9wRbMGmCdrK5/Prk=;
        b=sj6pMcOA7sEDfoNhpKBLe9KPBJ/aL2MgmeP10PQ3VrBiVxhL4qp9h7eGpQczWAGekc
         EUWpyrmUrZsuUgZ7HGm/2ue5c56jKJ2lTk0AmmqlTVG8CSoUpr9w4jyiUyOzuTxWpwY3
         G3dIHo05cr91jrAv7L135Hohzy+I+Bg52/DxALVZiR9kgQU6tjBpznhvp19YgxSOxofl
         /fkohU485QzliPW1iVOe9y/x5OLxnurdW2w524KyhepzvjFui6aXB7C10rpSw3Y3oVH2
         6U8iMykyZH+JowhFnsivvsHYDhA/iKfgql7DJPFJpl/hyzGjQLB98g9wJfJ1esDMoH4O
         UtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137365; x=1730742165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VxR+UF8oQoTBjXQx3TUbZpiRr/9wRbMGmCdrK5/Prk=;
        b=A9+d5c1vpdonXU4sSc4avPbO/mvsgR3BdDLj0lVad0xzFg32/lxUWxLDJ4WELe+SAW
         o9sUDmcVkKVIk8L0XqdwVR32GEZHd5Bs4J3RDxDkjjPgWonXxh5eEktXZjsHFvvTZsuX
         poBmMd1kW+vNkfPAuLI5RkQ1MVgA+zbtkhG5mvBGHXLHiuay4sc+jvyE+1h/QjZt1Usg
         5HtIrp0rXsTQQrQY/VB5o1tp9dthnZiVBK6wJ2gkhxuNpnaf/Jq0dg63xyJcrQY9FI7M
         cETa8cZPIIqygUxAuYK0zFmGKBPrSFzGgvPUoi9DBlB2GFHHiMPkTaknjQNabHNM4Pww
         /9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMINNtznd8a197328JMi176TQWd7jxdA7TT9NgIvAGr/G1QuYBAqY8Iti1Xank6arw3vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QcP2N0641J2fcKBArk+k3kIL9mH2bC/ENx8aYHaFYg2t8Hks
	LJCm/8Tqu0sk31Cwa6aMFbzcszUyrTzqPwoQknCZZQUKAQMVyg/vW9EwDWUc3w5lJfwbg30DGQM
	axxg=
X-Google-Smtp-Source: AGHT+IEtPyN2rj6SbduKZLNxJd5blM1XyYetSFORBiXPLkJT1cj/kDEFha3UqS0pra1uQdIiA2nq3A==
X-Received: by 2002:a05:690c:2a8e:b0:6e6:1018:64c7 with SMTP id 00721157ae682-6e9d8b8dbadmr69015377b3.41.1730137365644;
        Mon, 28 Oct 2024 10:42:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c97b27sm15386677b3.115.2024.10.28.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:42:45 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:42:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] show-index: fix uninitialized hash function
Message-ID: <Zx/NE/9HFNr9V2H7@nand.local>
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
 <20241026120950.72727-1-abhijeet.nkt@gmail.com>
 <Zx7WaEn6nvtjhs/B@nand.local>
 <Zx8ijtkn7y6eBQ-n@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx8ijtkn7y6eBQ-n@pks.im>

On Mon, Oct 28, 2024 at 06:35:15AM +0100, Patrick Steinhardt wrote:
> > >  test_expect_success !PTHREADS,!FAIL_PREREQS \
> > >  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
> > >  	test_must_fail git index-pack --threads=2 2>err &&
> > > --
> > > 2.47.0.107.g34b6ce9b30
> >
> > These all look reasonable and as-expected to me. Patrick (CC'd) has been
> > reviewing similar changes elsewhere, so I'd like him to chime in as well
> > on whether or not this looks good to go.
>
> Ah, thanks. I've missed this topic somehow.

Not a problem at all. Thanks for a very helpful review.

Abhijeet: I've gone ahead and marked this in my notes as "expecting
another round" to address the feedback from Patrick. I'll keep my eyes
out for the new version of this patch. Thanks!

Thanks,
Taylor
