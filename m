Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC418CBF2
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111931; cv=none; b=RsVf/TENaDGS4Mv3qsuc53tWdexuz+ai4jo8y/2e0AG5bMQrkBsovRIShNWlS1bwNTNMJeaKtrcfs2sHdcny7hS6WYXPxX6BmfDQUMF3EIqEWt10XbRQ1pR7j53XiwB+QQQZ1pg02YJTjEX+SLb4jz+camakF2ea2RotG78YLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111931; c=relaxed/simple;
	bh=A305IoZHForkVjRVk2jRrPOL9Oft+mzyb5jCLFoJtzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki1Fq5KoqROnggsWSxvvYCWYCA3KlEH7OdevKcsUrMZs9Iv4l4Rw9mggGyh5hMGuRaOcJmip3iFIDcgVk5cbIXwKSzslMqoN5gjudBAt5uN0ArtOd8S9DItxoapyJvFVVkMNYdV8B43m2toUBIfjXqjcqeY8xQfVDJwo3K1g7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=s4pZqz5t; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="s4pZqz5t"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e314136467so2658167b3.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729111929; x=1729716729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A305IoZHForkVjRVk2jRrPOL9Oft+mzyb5jCLFoJtzM=;
        b=s4pZqz5tsPv/IANWVgfqGOAAAEYLSXlLDieEIw5HNVBCSu77LiUnizUi/7M6lLgLFp
         TUnd8NBMgm086nhnABbwZcHgz7M5lDUbC3iZU7hVR8GUZx+KjgE9QKzKwfCOeSv+eC2C
         EU0hib6dWPQ06pWctYeUpnAMLcgG64JSvxpKk91o1CChzxi0Xeb/yIF7lu2CaGk8RV+G
         pnfcS0u8wGF19e7o1KRnqOXs+vihj8Em11ST9WX2xh6+7kt5ab57Xqbk3vmHoRYPt0Vb
         vU0UG4RZcRRuPxxC2UgvtHdsKfZak4NKsta1x8kitNyN/Q5EIwaKv7TEjp3yJWlDhSQW
         rx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111929; x=1729716729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A305IoZHForkVjRVk2jRrPOL9Oft+mzyb5jCLFoJtzM=;
        b=wl5kQ6yoWOTIHhluWFFQsVYNnyVza+KCDLR+QNEAgHCw20ct9whConecBGK084Cq3i
         PQFahjKauPPdeyhB/h8BleifCCn8Zr0NOgybJMqKbtk+3oWhIE6/8u/bkQSPhbBHD3d4
         2ycGaB88qpXCV3q/WXD7JKh+sDgSqAHqbKQzoogI048UMPPNxt7VEnl8aakTIlXs+U8r
         c4vUlVd9LbIevlf0WyNUXLoDS5MEXN45nqIwDWH7PsEX8g/Djfv7Gfkk69FBB/rBGR4C
         6PNzxs6VIjwMePYteW0RdCLt40XVSVlWueUufR0ZptcPOmHxOR58ntsE+qsgkVVakIpD
         4rqg==
X-Gm-Message-State: AOJu0YzZ8vXDjj3JRwkJzBmVN0isrmoQ4PY4uo/pzEUEniagtyRG6PjI
	fPbDmrtWQ+8/rScn4o9hksqKHUDQYdkyqVzx+1Z0bEtE1wAXUA+wodfxY4bxE+8=
X-Google-Smtp-Source: AGHT+IEG44/57SdhTod8+7EIE12zXWd5B1avxQkOGKB1NjdcDsXSzt+nXpHfs74mqxISnf/ihju5aw==
X-Received: by 2002:a05:690c:4911:b0:6e3:1d8c:1224 with SMTP id 00721157ae682-6e5a3f05fd3mr8830017b3.20.1729111929404;
        Wed, 16 Oct 2024 13:52:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d1f5b4sm8487167b3.112.2024.10.16.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:52:09 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:52:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 5/6] doc: update-ref: discuss symbolic links
Message-ID: <ZxAndtRZ7oOHndU6@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <3575fb48c932f50b2a3f6fb0e582b3c2a9b087af.1729017728.git.code@khaugsbakk.name>
 <8e644cf2-f903-4089-960c-2fe7eff30834@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e644cf2-f903-4089-960c-2fe7eff30834@app.fastmail.com>

On Tue, Oct 15, 2024 at 09:08:29PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Oct 15, 2024, at 21:03, kristofferhaugsbakk@fastmail.com wrote:
> > From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Tsk. Subject should have been “discuss symbolic refs”.

Agreed.

Thanks,
Taylor
