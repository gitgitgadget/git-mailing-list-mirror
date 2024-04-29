Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFA33C0
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423799; cv=none; b=nbIWz9WKOWt0huX702lgSjOagbOsWyYxDvFnWOsk7OPIZB3oplRhlifLrobUh+AtQ1jyIUQ6M21A8kWa1JnsytRwHfGz8Gm2Sypo6IEMs48ecT3MlptyrmxrZOdYf9sUXozH2eD/VKQl0NY52u2VkIheIAxLobJDAEM5jZvl998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423799; c=relaxed/simple;
	bh=ITwjT2jeuYE+cfiaY8ilh6IfObhSLJ6w0WUzLtDjO6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsT6tiJ9sRMjd0ww9rnYefZ84TY9B7FKjr3ph9kqXX61mrO9iH3CtrQ+00RpY5Gi3Y2kWvKlW3xsdKOQB7YlbiNh6rJi9vdE/ZaHHuofzqwQAEGxwqhcPjeoPemBGuXugpP0EXpvVKJHrvOXs1xGkIjnmsQ4hs1ve3E5AFNU3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=r7arrZsY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="r7arrZsY"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c74fd6fb92so3410980b6e.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423797; x=1715028597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbPU89pc4O+ifi1YSVUfswLT2LtwlDmlkSDV3JmAtPI=;
        b=r7arrZsYQbKI8NO1Lnyx9IUoGNfJ8u0EFMdjE+2QkxS8tiQEGPsOYsOFCucM5/EjNX
         pclGC/mGNe31K+FvOlsVc3UF/Ev2aKouQeDBqowT+hXz2lQSjquARropJAg6QHxlwKSH
         4NpX2tGS1UsNNCuFsQL9wAPJmn9Gh4lic4uAYSfm86/I1FZHRbnKLu26KDXpX9wputJY
         M1e/Q8mF+KCNysUW26TyM9ciu60pUOVli23WOCmUqFT9xMauTB5vH2upn7SSJrNwpFOE
         RkOwl0O99yK/pYXBbqmwxadDsJJduu6jH4wB5zYAhrdxlppILNCRBtgFtoFvnaeF1KPf
         mokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423797; x=1715028597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbPU89pc4O+ifi1YSVUfswLT2LtwlDmlkSDV3JmAtPI=;
        b=IpLY4rqYZKkKzdqTMhqwV+SB37Kd6sLL7q+SvsNgkVANbcASnRbkT67fJ8lkLjlLG9
         DgsJx6tgWUuLyVNbsflzb+W1kV0vO+QdaddeUi4ktatJTK0a5Xtq6+/qyk1dtxINtfDE
         0rTnohqoSR/5b5a7WaPofUqWzyFiafEkGae9ykuaElxcPl/83Azed9MlVIaanRJebMVW
         tzdj70zwAkd474hOrY/MWbrPqMee8v93zScwvppyZWnhHrFyH7wgERMJZ2wnORWpx2Pi
         cg2dzdXZiuuJRxpbcMA2g44j1ACqe0kZfOYlVsGqdB6IaXd8q+AC+3dBwj42m16AP1R2
         Teow==
X-Forwarded-Encrypted: i=1; AJvYcCVZhhDXxp8sze/MI72rJC8Xwd82yl4IWV2mwHerdhXQB/he+HECuofBwG/OhSigiEsAPD35e3evVYNlip0h9LIBsHU0
X-Gm-Message-State: AOJu0Yx9A1XZhm50t9FY5aJU3jkLSrGoVc8rze0/ptHZHexphT2C6Ons
	4fOJZJVw5r6iXxKmBe7/b8W70tfoLXLGftFh42ruFU1Y8f20MH1RdjPP3WZj9ZI5N28lGQqOohY
	fMMs=
X-Google-Smtp-Source: AGHT+IEreR/N/Pe2DmWCbm2EGnD/PbkZgRAt1PqblBEi6OS7u+nxzwx+CEQ0HPXTKK6iGplDqk5zGw==
X-Received: by 2002:a05:6808:3d2:b0:3c7:4547:31bf with SMTP id o18-20020a05680803d200b003c7454731bfmr12529597oie.32.1714423797080;
        Mon, 29 Apr 2024 13:49:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pp7-20020a056214138700b006a0cd146a5fsm1434215qvb.21.2024.04.29.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:49:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:49:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 6/9] upload-pack: disallow object-info capability by
 default
Message-ID: <ZjAH8kW1UkABsDz3@nand.local>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223858.GF1158131@coredump.intra.peff.net>
 <ZeWHlknuWMvRiFtC@tanuki>
 <20240304095907.GB3723539@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304095907.GB3723539@coredump.intra.peff.net>

On Mon, Mar 04, 2024 at 04:59:07AM -0500, Jeff King wrote:
> On Mon, Mar 04, 2024 at 09:34:30AM +0100, Patrick Steinhardt wrote:
>
> > > +test_expect_success 'object-info missing from capabilities when disabled' '
> > > +	test_config transfer.advertiseObjectInfo false &&
> > > +
> > > +	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
> > > +		--advertise-capabilities >out &&
> > > +	test-tool pkt-line unpack <out >actual &&
> > > +
> > > +	! grep object.info actual
> > > +'
> >
> > Is it intentional that you grep for "object.info" instead of
> > "object-info"?
>
> I didn't even notice this. It should be equivalent because of the regex,
> but I don't think there's a particular reason to be more loose (and
> unlike single-quote, which we sometimes match with "." for shell
> readability, it should be fine to say "object-info" here).
>
> +cc Taylor, who wrote the original.

I can't think of any reason why I would have written "object.info"
instead of "object-info". Indeed if the missing character were a "'"
single-quote, then I would have used the "." wildcard to match it for
readability, but that's not the case here.

Thanks,
Taylor
