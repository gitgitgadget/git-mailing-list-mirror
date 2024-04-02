Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493FF15AAA1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088296; cv=none; b=D0x1gov6zBKhFM4QDKa0+h3YVTvWKb/+D8t1RWBG7eVwX2WkQSQwU0knj048bqQPs1501r6sZPkThIuWeafsjaNrKInoXUZi08gC7PW6F2c95k0P79N60AGqCLuLX7YKM7yMnHut8Xz/33xyBomr19RY27fVyc51SAux016e6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088296; c=relaxed/simple;
	bh=3cQr1AsEjfccGlRqQqClOxadaSJhh46DD944Yp4Kjqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4tPefe/Qk5QTkzfJCs7Aho9Gf/11wmDSfjvq30mnHGm9CL5/jwNxOmxgx68R5XEmA5YQHWXTD9aUdu7R7RNKZ1AUIJAUWRCcsyHCO/GQwOWOwQalCoPkw6Ky18Tcpj+aDsSqiHNxeRVKL4CeX/GrzL0eR6TPSPzaSDPpimg01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v7Fz2xf+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v7Fz2xf+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a66ba49dcso367705085a.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712088294; x=1712693094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e8laZfApShbfPFw9M2L5TBRk7ERoR3v9y9NWOIO4Sw=;
        b=v7Fz2xf+5GAaRHgfClmT/WWmlTm58Zf7/A/vaCk6AiX/obrUxtPpf3aFSSYzNn7VFy
         iy6t4TXYFmgVx6RTneUPjcSDeueDI0Xcm2izQLUBkVw7DN90+Kw7d8zjTUURTql8CaTC
         xTChXXxcJ+pOknOPfeA/VUusHtoIB+VqbIcE7FAz2X/+jRHeB3yBvgNLnN3ZYcvCIQ5l
         dCJlfza/FJEXkJeWHrA8TxD25Z85EvuVRJUNMx2yS7Sywxc3IUFZDp41xHEyNSne/WP7
         cBOjXzDW9amJYulyRppnLfPrDSpi+rTDvmbIcVgef7RxhnMeCIhehH9atjrawQe1WNa8
         h0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088294; x=1712693094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e8laZfApShbfPFw9M2L5TBRk7ERoR3v9y9NWOIO4Sw=;
        b=ShJmDqceLDJd2yOH7Yz2i3TkwWsNaJ4tTn501d7b2d39YxdSRGgzCYx+d5UJ/IIaRT
         JmaOJGZlKSNF97Ui0UcPDlSP0pwAyAkONrZGa+Fcho8037312NtwAm0NenCFp9klnr0V
         I8uAX4gvvi7ahNwCXIi92GuB4wGE9QeUJ2muoeFpbPLJTKtuXTl4KJNR0KUuqDYeDVcL
         NuAMgjsWa2K7/v5X/m/eYHfkwcvGI1fBWoqERimRGL1DL0W8muLFWFuLzmpsT7HSZaF+
         Ujn7kDY6ZlUlkxI63wG0rcLeOJUMgw6t4JdeGMcEDA9wt+I/nugwo0DIEqU4w5ja5FR3
         vxyw==
X-Gm-Message-State: AOJu0YytdvJFukZYb3QqGB7DB/BFshjQaHAWxosWbM7efgPQPXWOd5Qf
	PlOtC2XgdmhvBg0DysHIMOh/y1H5ME0AFDCvygObLkbjPJGNBjaq7hqGrJTRqEM=
X-Google-Smtp-Source: AGHT+IEZ3C4w+Jc2maZhWWEKe7uJJLo/eIjT4am4CtZ+qlOnLXH7K4qEEfmOrkvqAw+Z4XKVxTgrlw==
X-Received: by 2002:a0c:c792:0:b0:698:d692:9bc7 with SMTP id k18-20020a0cc792000000b00698d6929bc7mr13351295qvj.13.1712088294201;
        Tue, 02 Apr 2024 13:04:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id oj15-20020a056214440f00b00698e65cdfefsm5196232qvb.87.2024.04.02.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:04:53 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:04:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
Message-ID: <Zgxk43ZH6Tz4TnaT@nand.local>
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
 <xmqqr0fn4nmx.fsf@gitster.g>
 <ZgxSSKGdAicfVhGA@nand.local>
 <xmqqh6gj4k04.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6gj4k04.fsf@gitster.g>

On Tue, Apr 02, 2024 at 12:55:39PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I would argue that GIT_TEST_MULTI_PACK_INDEX should be on the list of
> > GIT_TEST_-variables to get rid of as it has served its purpose.
> >
> > Like I said, I'd like to get rid of this (and many other)
> > GIT_TEST-related variables, but that is a larger effort than this single
> > patch.
>
> Yup, that sounds like a good longer-term goals.  While it does not
> smell like it is consistent with that goal to add more instances of
> use of it to the test, it may inevitably be a "few steps backward in
> preparation to jump big forward", perhaps.

Yep, exactly.

Thanks,
Taylor
