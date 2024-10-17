Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D13168BD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198475; cv=none; b=LkepJaJWvNyKertENsm8qPX3Wd9ZNR9C9sR6YSbtss6QxGFgw7tfE1cVi84HvVwRCbn+3hV/LnF8MV4kAiWdw0uMSZQ74sHldAdJgctQBWZxCO6lUKIQkqchWwkzgmIwaulqhG0v2RPHauhrOkXITf/zAb96l5yRmPzFtD93EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198475; c=relaxed/simple;
	bh=lHuWPAILqtVlThQXxDQpw9AkbHYArekHuC3vFp1Uwzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZjCcD0Yp25qFe+nHsR+lmbvL8sHg9PUCiCXaqlBcIqD/j9hav0geYvChUoPMV1A8O772pPD5SAZYYvGfoz3gZle9cBYcuUzAUD643VYdbxuhP5vWHjlwz8En3vTynn0sYlaeelfU9olpKWMgY3IoxPnBhj+24pZCt61Om8r1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fo3gvbQM; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fo3gvbQM"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290d6d286eso1183077276.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729198473; x=1729803273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nybZsdXeK+x6J+cUoOJiiLna74dK3fSSL7Pi7AdAw3s=;
        b=Fo3gvbQM1IpjCQa9BbYjDwetp/vl35/Pr7cu3oJX5WJ92qtgFKhWl9BM3vi5lY78cA
         tabq+GPcCtn3ILrLHOJMDox0gbSL1Fi+EGNIYD0Ca1ekWx2VcCl5nSDzRsQeE1t6k71v
         H0fbkCu69Ze8xqte72+I9LoUaVpnipL3Yw3ZtaIwcwwyzYRQzHC2JzhlUGzBjVCjfkG5
         RXMpBuPQswCznzdzV8GqY9+2iCDd1+FSuyoRy6Mwt5LO0kVN0cAZbxNFDvKkX2eg3271
         fjYaTl+9snZoNRVPaFs81d0FKZ9GOgjKZpF3I7NwzBO5TsfvHDtfFiLjMM2LKIBPdoEg
         36FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198473; x=1729803273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nybZsdXeK+x6J+cUoOJiiLna74dK3fSSL7Pi7AdAw3s=;
        b=f6bf4Vpsdlm8bZlFtriqNGNHMXmhISCQ5UQQ2NT0P0Sw2wwe3P7cEcKQDAl+Un30CQ
         I4Gj15ziqv7NK62uVDBCyX6BB6FNIV7jle48x8cBOBXMCLCnHy0cVLnWmdHes6Hxh8nf
         G7B9chnlAQVc5rx0ge1Jn1N73CiyQmyIDTuaER0uUhnJbpjbSZhhmlCtccMe0yMxuu7o
         kanQYnshBTe5u8TWQf4/AMuq05EETw6YpL32rNZrc0bqce6rpJ3r/A6O7zXlu97bQkrZ
         QxKesm+s8uDpK9CmGrXKPFYcE2nphd79J8cHV5Y/+mZciORDkoIGK2zpHGgKzHIibwsL
         GTJw==
X-Forwarded-Encrypted: i=1; AJvYcCX+muHKpyw40DZilk744k3ANE91yFz/Q8i/pT2sSbB22e64naVSdcR1fGQJKT8UElJR+jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXuXkkeCG0lHqLg/xMN5qAsRwEwjsJK5dT3SzT3v49YxfUqaR
	K5+FT64XbGpSFLMWOELXiz7clTR6ql44NBol0Zu3WeVCRSjDwx+DTIVThs4J4B02c674PURasQ2
	b
X-Google-Smtp-Source: AGHT+IEhslOblQrOcGyAdqO9C1jHRhN0ga+di2z8A4Dzspe5zEcfsn6wisPp2oMXwkydRhEXVeHkkg==
X-Received: by 2002:a05:690c:91:b0:6e3:18a8:ea07 with SMTP id 00721157ae682-6e5bfcf3ff0mr3067887b3.32.1729198472828;
        Thu, 17 Oct 2024 13:54:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c024bb51sm315077b3.117.2024.10.17.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:54:32 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:54:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <ZxF5hk5TpKpBF6Xu@nand.local>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
 <ZxAiAUdtddwk5RS7@nand.local>
 <20241017023319.GA1858436@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017023319.GA1858436@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 10:33:19PM -0400, Jeff King wrote:
> On Wed, Oct 16, 2024 at 04:28:49PM -0400, Taylor Blau wrote:
>
> > > This all seemed eerily familiar. Try this thread:
> > >
> > >   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> > >
> > > It looks like the conclusion was that we should adjust errno handling on
> > > the client side, but nobody ever followed up with an actual patch.
> >
> > Thanks for digging. It would be great if you both and Ramsay could unify
> > on an agreeable path forward here.
>
> I think the patch Ramsay posted elsewhere is the right way forward.
> Hopefully he can fill out a commit message with the summary and then we
> can proceed.

Yeah, that's exactly what I was hoping for ;-).

Thanks,
Taylor
