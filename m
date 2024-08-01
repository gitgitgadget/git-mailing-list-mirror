Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBB140E5F
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542952; cv=none; b=thMibZA1t9e2VqCPmc7BQKsti+iDeE62Sfbvix7T0Vqae9MlsBnURKQbmO3gMXHHd8QMnCcxQCyj3RwWz1ujHyC2kG0LWJbcdaR6cQKzFzKA0gbKkp9ExZtSVSyOjZg1efMuPdpB4bQs1pdoWGHOgjy2a1dZTjBLJF76WkgG53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542952; c=relaxed/simple;
	bh=/VBsMhkZxhMcCUecQh1v5j+DljeYiaiLg1oJG6O+N2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwDN0S0hw27fD06nsJ8LjFtpiuwkYe9i/yomINcyzTQFPxV5ItR7v417jxAWbNZSRLiGp4WfW5ROftOdxJ1j4s1Q/cflqfURGKUdLTGettCYmp3GMYpbJG+1tgEBFdwObaBzqffkYYnTbyv79EtnQuIaiRtneiG5UNpMJouhYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EzYcOmAU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EzYcOmAU"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f19f19059so449211285a.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722542950; x=1723147750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VBsMhkZxhMcCUecQh1v5j+DljeYiaiLg1oJG6O+N2w=;
        b=EzYcOmAU3X7oFb5RajzutlNbbmpN55dqb6+rBy85IWXsPZqUHdMHYMhEfadN/5LERn
         zymlv5FjI9+nGzSFTf2FvLoE1cgzvC2jsvgWLf9nnhqIJz2d5pw2YkxrKAnLwGckxSPS
         3pEcoKltYJSwNAFcy7T+qt1QHTucFD+pNDAiXd4DH2jTQisGVK4mv0Uehj8DDxjbVQyS
         LFdF2y+q1w/5nSAxMq7fNxVGMXUyBMKlcffgYsBOpY7Ce6e2WCNaiVVUH8c5j1DNKG2J
         TcidLRJiQOeaypvvhnRhKikKTW/Jec6sOzUTuA1qb7u10ECeZeHwfU8Bz6n+nrd2YvI9
         BAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542950; x=1723147750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VBsMhkZxhMcCUecQh1v5j+DljeYiaiLg1oJG6O+N2w=;
        b=n2U+I3QzAzotICLf0XPRWG0iEzm6a4m1/XMo1YBRr6yPGd2MtBYseDnlAnJb8k+Vmy
         72RiVblEU2XHyA0GMhuTPk0EedLOo3f4Xti4uUfNG0MPgA45quNstj+uxQftwkQ8UJHr
         GvbF/3CZJ1Xdlf6DIY+LRLO0MXK6xgo7d3FLBijOqjcpdxz9ku3BRPQZfFv4N+FDx/KT
         LX/j61toximEpzD77cIxnTrGlb68PPK9F23+XLphmdOWzHWEDhWLipRX3bVmIiexvPnq
         HRE0YB5mBNIzy15K1Lh9hO2UegkgcCnPi5a6tDvpcGuXdxT+9EdetRzKfT33/ywY5Zdb
         CHmA==
X-Gm-Message-State: AOJu0YzCMX49xwXLr7eUFifW5/rbzTO/3O1xD+DbaiHsRdJC1l7sRCYx
	g/naCiA7SXJpXKphlRk5KQPkARiEirdLfU73YOKK2QKLINMQpxeLZx3dryyyk3Q=
X-Google-Smtp-Source: AGHT+IFmy7GOfcpset4soorTqX1pXmFrvny24f/o+u8S8UYZ86xWEgKXRbItrNoP8plqo5X4TUYeyg==
X-Received: by 2002:a05:620a:f01:b0:79f:1002:f29b with SMTP id af79cd13be357-7a34f009616mr136706885a.65.1722542950029;
        Thu, 01 Aug 2024 13:09:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6db03fsm24494085a.1.2024.08.01.13.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:09:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:09:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] midx: teach `midx_fanout_add_midx_fanout()`
 about incremental MIDXs
Message-ID: <ZqvrZCGYI0J226kn@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <594386da10bc3f3d6364916201438bf453b70098.1721250704.git.me@ttaylorr.com>
 <20240801102906.GN1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801102906.GN1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:29:06AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:12:38PM -0400, Taylor Blau wrote:
>
> > The function `midx_fanout_add_midx_fanout()` is used to help construct
> > the fanout table when generating a MIDX by reusing data from an existing
> > MIDX.
>
> I'm not sure I understand the original function enough to know if we're
> doing the right thing. But I notice that after your series, we can only
> get into midx_fanout_add_midx_fanout() if !ctx->incremental. So is this
> code even used for an incremental midx?

Originally it was, but after 0c5a62f14b (midx-write.c: do not read
existing MIDX with `packs_to_include`, 2024-06-11) we no longer use this
function in that path. But...

> Or is it used if we are writing a non-incremental midx, but trying to
> reuse data from a chained one?

...we would use it in this one, so I think the patch stands. I added a
note at the end of the commit message to make sure that we don't forget
which paths do and don't reach this function.

Thanks,
Taylor
