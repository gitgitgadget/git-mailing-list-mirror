Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E77DA92
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553434; cv=none; b=qoFt3zqabI8g+sRQLtyl05em9u7Q+sq54ILMyECspJ5/lsxpczuxhCSf3URT5ZIjTl7xSA380Pq44uKr0XID/DrB3ICP++bIFZWwOXAHjoMmwSOtZeY9C6NsMRPDfov4feYPZDmXnfFX8Bl0Ae9UNqOH6WHZrtQGqS+xYrX5y8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553434; c=relaxed/simple;
	bh=e1bCArUmfyMALYMneyudqrfKPRYgW4d2uM4D5BW5uPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdN4kI1NoYnLhA3OcINTt470l9Jw3f5uIN2CglVAcGpnltafs1ugHKPC/36Ix37J8s5Iy2uGZn1BFyVdaqAbNPdqfTiFHi8/sv24q97PJdw2Jsd6Vc/0chF/WhdEsptnLpR2zWTT81wqg5wnXLi3NXJCo8g/GjklIPjFdb7gepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pqOp9IYp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pqOp9IYp"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a966f0a985so56506285a.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725553431; x=1726158231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=944xpONlAfqi/w8yHOQ1eEink3HIpb3KiO4bFA/ny0c=;
        b=pqOp9IYpnXMuWhO0dDVLiP58Dv/loTw9pVozSYrivzI3RnJwZOs+HaS13EB4qoeyA7
         fGUNmz+J5c2VAqD7AFclacXb8H5sWATpdhbwXG7k8WoQpGcD5xyFOh849DuxMtN5o+nv
         6EFowi/dPxPOsUCiaJgfULq2qr3z1+0J6sySfsjDrqRQz+lC3HutV6cb6/EJvfbsI+0H
         hNI03Piabyh/Ci6zhXMFLdoJF25D4mk+TpP7KODR1lo8ps3cDW0cgUs2yVUOgrV0aVD7
         0f7yIEApO2pUOOvnFm+BENY2JUXFqpt5KnnyAVagIqttXc0VZiBreOyQxdrU+BNVcG4n
         SGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725553431; x=1726158231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=944xpONlAfqi/w8yHOQ1eEink3HIpb3KiO4bFA/ny0c=;
        b=Hew6ZlkpUZcjfZQ9T9VH1vyrhhsQjvtzvoBaTebspxr314w3+ENDKNC0jXS7cTULBg
         /uIx1nvGTgxIV9x5HAhLB1DHX8yUeHKQS5fAT7QPNW3wN9Q7QVju6AKDb+LTsw5mLEgt
         bK0AorcX8RUPKWGqVXmkN5w4F41jJWKw402K0f3AERnQw/M8ykhuvdQ7jysY31/OqpZS
         tCERTfASbj0yfxPfQre1QhZ6cGTJRY7LFDAstudtQsObcB2xAWjQ+3BXbdgSYX8CscS0
         fhm544fLCI2ED58h4htIqLddzhWoYIeW/+94W9xA4/P/V9BSMgGVNoHmmT/bq+C5HqJN
         aNAA==
X-Forwarded-Encrypted: i=1; AJvYcCUUo359UiIbdluOaGLetgWkH3k1mVt5y8trwz8I8ZYNF3wwuDYERwsLDCAKrL5uttGasd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgUnOQciUrpqZr/9FPfedyUeEClPROWAZUCFGhnaktmtt3R0z
	CulXDU/VPU/P5qFbnK2fh98u1fbYbAPQGeMynsllZfzyL2QOYR2+SeopMk8jkkU=
X-Google-Smtp-Source: AGHT+IH8jtvSbL8e+8L8vTqBxKiYQGyfDnJgHWfU92oUvRRF7gOkPz1VW0k3kvU4xEiqxBVaBuzYjQ==
X-Received: by 2002:a05:6214:554a:b0:6c3:668b:b0e4 with SMTP id 6a1803df08f44-6c510ce9f5fmr121484956d6.39.1725553431333;
        Thu, 05 Sep 2024 09:23:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efeaffdsm87587485a.83.2024.09.05.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:23:50 -0700 (PDT)
Date: Thu, 5 Sep 2024 12:23:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtnbFXL7W5DvW8UN@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
 <20240905103736.GC2556395@coredump.intra.peff.net>
 <xmqq34me5crn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34me5crn.fsf@gitster.g>

On Thu, Sep 05, 2024 at 08:41:16AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Probably the solution is:
> >
> >   - renaming packfiles into place should use finalize_object_file() to
> >     avoid collisions.  That happens for tmp-objdir migration already,
> >     but we should do it more directly in index-pack (and maybe even
> >     pack-objects). And possibly we should implement an actual
> >     byte-for-byte comparison if we think we saw a collision, rather than
> >     just assuming that the write was effectively a noopi (see the FIXME
> >     in that function). That becomes more important if the checksum gets
> >     more likely to collide accidentally (we essentially ignore the
> >     possibility that sha1 would ever do so).
>
> Yes.  I somehow mistakenly thought that Taylor analized the code
> path when brian raised the "we rename over, overwriting existing
> files" and I included fixing it as one of the steps necessary to
> safely switch the tail sum to weaker and faster hash, but after
> reading the thread again, it seems that I was hallucinating X-<.
> This needs to be corrected.

Just to make sure I understand you here... this is talking about a
prerequisite step for switching index-pack to use a faster hash, right?

If so, I agree, but would note that this series does not yet switch
index-pack to use the non-collision detecting SHA-1 implementation when
available, so that would not be a prerequisite for merging this series.

Thanks,
Taylor
