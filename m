Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEE1CAA9
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442997; cv=none; b=JN3TTpgcycbqgdvF7Mftq5cLHiXmpFfjC6Plq94Gb1fqCV6eIqHnuo0J3LEMpZxvw8V3E9Ri/pKQv7QnVE9IYnbbLRiXBdNazkRHm/XUyrgAS5MCJPtMGNH813qLzpVhdsl0WTT61fvOedTZ9ndcwo/P/aoUentUXMlpQumvhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442997; c=relaxed/simple;
	bh=MbaSPXjrrOMXUd1E5CnUa1gXU1VBgSwTOmZ7L0RZyng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn3a2K628ZSpVFGwH6t6EP0/UbsuhQ8aodgjbDMYXmlbPI7z9u3zYIfXNq5mVOrzFouTWbLA1409jQVg9d47PZzUKNY92LHmdsj1llG0cRHQVLLErOTaLNk/wYPMYVOt/Ay4xeUJfSKel4lUu7HHEC6ytQGccs+d/BDcBrAt8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=J8rEtOm6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="J8rEtOm6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c669a0b5d1so4025664eaf.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722442995; x=1723047795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbaSPXjrrOMXUd1E5CnUa1gXU1VBgSwTOmZ7L0RZyng=;
        b=J8rEtOm6RJ6u659O9mXqRfuASvJCmPnMWOblnCecL6g8gd7nIJg8Vvp9SUrUnpTB7k
         kg791GzM19Pm52nBwM2Lp8Eu8qjPO4vfT5olI+Ge9be6Kd9jp7uLcJHzoDKAsVsbxIN/
         BvTonoJnx9Z5M11T16yzsnbo9ILFwKssJk2YYzo1iz8EwSqbAsggYxcnuTzPjhpafFuu
         7vhJlMUyGFTtwcb2uJR4XVyJtbr2qERpGlQPW6UyLrulU2DbqDPu+UBEvXi/TcxfM6DT
         6VO2kRV1u53QBNBRtdwM2NvBUm9fL6VJSxs6lUWgFILFuhuc09UX5St6Vk2iesLCGduq
         N9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442995; x=1723047795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbaSPXjrrOMXUd1E5CnUa1gXU1VBgSwTOmZ7L0RZyng=;
        b=Lb76I4L5Qqaw1DTBn+FVpJVxkciQldLJHnXQJWQkXIUNLekyR2vUNYJuDbXdP0+CNN
         duCXpM/EmZ1qayURBaVtMCq6O0C+8RfUJLB3xBfxxfwe3DHkuQRciRFdmX6QYyaoS8rv
         EIVZAO8gwiI9+MwvWf3pjB7qFz0j3hIVoujprfJ/ZT8UDArLwoYHdScwNaHLacgVohPV
         obSVYIA++FBYl2w5Z434jv13yub5+u9mmzmrs/rzBQPB8HRNOlNYr+shjcbfeWj56f/S
         suDbAHT1jrq0RblDbcNQnikT+y08Nc9pE34+rJZz3+5EiKpiq2KxQWCq7DFUzuo7IXhK
         HNEw==
X-Forwarded-Encrypted: i=1; AJvYcCWEmnLjf0wQsGZihf6VbhlXZ2QNSP5xWcDu4wwzSUjppwq7xqwoTzoSCjXcrCyhPd1GB4/lFBP1ksY7iHduTgJNDMLV
X-Gm-Message-State: AOJu0YwdC2/rZshmzhWEWTlMm1ojubEjvTBEXvZIVPXZxJZyJK7MlhqI
	RoC6WvsFhIWEOTnGiRZY8lo+Qd/X+eP6NIIABfwjW/kZdwIhghsVw9GYuxz7KywrGBD+h1q7HHJ
	g
X-Google-Smtp-Source: AGHT+IEHn82Qzp4FNWbfJ+rWTC5tkZM8aYQ+Tm9hgbT1fgsQ/fxjkyjX40XzBDrvZS2lHpkGkpxGIg==
X-Received: by 2002:a05:6358:18e:b0:1ac:f3df:3bde with SMTP id e5c5f4694b2df-1addc143ddbmr2052222855d.5.1722442995383;
        Wed, 31 Jul 2024 09:23:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac47f7sm76386296d6.115.2024.07.31.09.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:23:14 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:23:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 02/23] builtin/log: fix leaking branch name when creating
 cover letters
Message-ID: <Zqpk8exl3yzakVQF@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <4daae88877f2355d6a3960883e7b3f15cf738cb5.1721995576.git.ps@pks.im>
 <CAOLa=ZQ1zGe421HFqH4wCSMwc53H5eUr18j18yM0pNgD8DxR5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ1zGe421HFqH4wCSMwc53H5eUr18j18yM0pNgD8DxR5g@mail.gmail.com>

On Tue, Jul 30, 2024 at 02:14:00AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > When calling `make_cover_letter()` without a branch name, then we try to
>
> Nit: s/then//

Good spotting :-).

Thanks,
Taylor
