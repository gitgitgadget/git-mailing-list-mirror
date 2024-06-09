Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A61C68F
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717965030; cv=none; b=K1vh4tIxvT/tae30WzWzAFDMEVrQ77s1MCE42qsgv32ETSAsGRm5MIxFnl4nfFSi0euEzkLQIs4yNU/kYM8/klkiS5GyOowaOTn+GzZ71TwWNWtjtNwCm2dPn8JwBXa/Wo5ux9TOh+DPGbQ6igDcSvafa3bZN8FgDu5ESSaZ5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717965030; c=relaxed/simple;
	bh=4C7EtVxz0buQ8ka1U6lSbfIn0i+aKXA+eOaCslIcmaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwDSCwpEp50+el95PZYnNArcl11yNQmUyOOBs7lcp3hwVGqNcfX0SivRQgUYJSd02RwjKdr7PDeKDPkuZuMfjxKO1zBI3nYnmvGq3Vd3PlhPzFiVJY22La6QhIoLLgMjr/Wlcl4VjDOIvmKb3D8QA9rL2Qtw8NsBeDU73cB+Hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hAesiaWj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hAesiaWj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7954dcf3158so118816985a.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717965028; x=1718569828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4zyIuhgnxxoF8zaCUwvCnhUR2bAVcV1+MFXAzFvDUo=;
        b=hAesiaWjCaj8samfWSjTJR3t7BVVE7En8k8Z3KB6lfTD++7SqC8SegCXi6fmX5S+Z6
         +UjoZPEW9Wu4DAROR5iyyF5p9BGxW0E7Hl4XzYyD9PyEFkfK3qjd1y/CcBQqEMVViyBv
         /rJdoaGzv6onkDn3VwwTBC4hUf+auIUk+ooRADLXZPdwX+E98yE2COKxSEgfh1OV1jCk
         x+LtENaz48jfa4Eu/ER9UB9ANK0OcDHrGSymaxEoiOVk7D4go+gtUyZAX9mFezDFfRdv
         TZPZX1hpSLGF1DD3b5360UhGtE9TVuWWOIzzIwhuoWj/TEWO5G6JBiGXN+9f4T6MlUSr
         sgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717965028; x=1718569828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4zyIuhgnxxoF8zaCUwvCnhUR2bAVcV1+MFXAzFvDUo=;
        b=BqGx4Yox5C6OUjhjKMTE+xFgm51HvP8mUB4g4//E2EQzPMqji7Z/OCcykOi3OX0zZf
         PUjPIqJPey8VfkWcCXutfO6y6Ah1ZaTgiQ2TCtCNJlZHBRZlFwx0kf2zIvEuXwQY11A1
         2/NZEmZd2e17SwTMAWpipBPM3TIeTm/0bbB8hvn/3ZkPAUU0/xguD4oxNCulpHZMZ+rz
         Z5Ewv+8+hvCiE2H56RSbdrWBK6rA2weflZA8F+Uc9dPAfgdgrH7PQs/yjcL1dOQJDRrY
         VJJ7kwa9PxENt4PlLGxSL9F23shoAc3AKsPUoXzoqcpXH1eESOIbrikKUft/TfGYS9O7
         iYeA==
X-Forwarded-Encrypted: i=1; AJvYcCV30+P7FBmJk8FnQcjEiVYo9hHVhwhhUQJ4C84OL5Z/YPas/YxkGX16/pm1h5s7x3QurB5qeG6l/ZNqp4ubaEmM25YL
X-Gm-Message-State: AOJu0Yz5VtJ1IlaqCxYVomWhqDnbIoeQ9lJTPh+F3BbIoxavCqfeBux6
	zud4CjVC0JbHXEcBMuUBULQ21fvXzQbMLeO7OADBH3TyHf/OHF9VJAkBrCDXO5c=
X-Google-Smtp-Source: AGHT+IFXpNORx58yEHZcDingieSmufXTUSTPHpkkVL9qjCSLVm20Y637veB+dFI9DYJzij3EMAuQiw==
X-Received: by 2002:a05:620a:4155:b0:795:813b:fa5b with SMTP id af79cd13be357-795813bfdb9mr235397785a.30.1717965027874;
        Sun, 09 Jun 2024 13:30:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7977e0eb111sm3509885a.89.2024.06.09.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:30:27 -0700 (PDT)
Date: Sun, 9 Jun 2024 16:30:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <ZmYQ4f+qmQIxf+5g@nand.local>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
 <ZmXKzJ9CpbYTmTwC@nand.local>
 <xmqqmsnuaqus.fsf@gitster.g>
 <ZmYJ+d3+j1E08Ms/@nand.local>
 <xmqqh6e1c1bf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6e1c1bf.fsf@gitster.g>

On Sun, Jun 09, 2024 at 01:23:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I don't think the issue here is a corrupt on-disk bitmap or MIDX. The
> > regression that Kyle reported was a logic issue reading a
> > ordinary/non-corrupt MIDX file, not a result of some on-disk corruption.
> > ...
> > But I do not think that repository corruption is a likely outcome here,
>
> Yes, exactly.  What I was asking was how on-disk corruption that
> would result from the logic issue of reading a correct MIDX file.

OK, I think I misunderstood your original email.

> ... there is no reasonable work around here, is there?  We do not
> even know exactly what kind of breakage this will cause (which is
> expected, as we would be "reading" a garbage value and basing future
> actions on it)?

I think the end-result would be that packs sent between client and
server during fetches or pushes would be broken, resulting in index-pack
failing to index them, thus causing one side or the other to (correctly)
throw away the received pack.

The only thing I can think of to avoid this would be to enable
multi-pack reuse, which is only possible if your MIDX has a BTMP chunk.
The other work around would be to disable pack-reuse altogether, which
is very unfortunate.

Thanks,
Taylor
