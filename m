Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92E80043
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215354; cv=none; b=uZVK2nvH3qLY6J51tSQe2bZLpZuMz8POFLLFkqfdWIX7kFkVT1zoFBnfKTjrxbgN6UDotunMUCEaWpvwC/sKPCbRWjPBlWK8pX/jJd/+un2UR9KOWLXR2hMybEBSSX7qJCIot94hZOCy30sCGBclE0Rcu9JOA+27fg0are0+xZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215354; c=relaxed/simple;
	bh=sFkX5hIZzQaSRZ2nsINHDHdglVPe29/mInAFqKSmXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMz56rH84hF5YK5uPJzmsbdYT7drP5iIcfJs9TPim5OmAzbVkMp+zmFZCSch8t4yl0fbl5PDBsEjoiJld9w6lfME0A7vU8Pjcr+diHKe6iCVddnFHoEbHDQ0oSS9wHKd87Vqd8bT+YcvBves+AakL8lFaQ3BaLP6JKGEOsfbkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=p7Jd8btR; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="p7Jd8btR"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e249d8990afso959476276.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727215352; x=1727820152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VHnMyQgZSQK1NWkIXuh9IeZhFQa5iicGilJiTn359Q=;
        b=p7Jd8btR1Q6HVH6ePX7eseNRaFL/6gSpBSTPxc4hx3ZLhJ2akd5jbFub/SbTrthIPL
         gdpTxyC/eYzbqfkdVo22TdMQaVAtpB62llmj7mxI4tf03svuxK0EOBuTJlgKcdJfzYWn
         tlJHhtRIsxpxUQyBKZWAH0B+RPw6nEDAHqFTAnhf7xpF3wrgJtleZgPlfA6kueJaF/Br
         8yoCT0e0BkpkAlS/8YNoJ6RaH5t0xOQGOj8wSimZtXGyuC0D5eTJ+XFtjQGnAU+BRo+f
         /rU5XNEY0zWCbB0MtaRX/xo8UPKOZ5Eid2ofaLgaJ/82pOmfjLiiI1KB6WmGG4yjFTlq
         ksbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215352; x=1727820152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VHnMyQgZSQK1NWkIXuh9IeZhFQa5iicGilJiTn359Q=;
        b=dIUqYpLhsHk7dLoPRFD2dPN17hlRLLGOekVIG6L3EKzbl5e3Wo1fHPt9MvjpP5nVuT
         yVdBXkxwzXJCbMu8Oiq9XvJ5JN5Og7MW2xJ3LNRG9RnpF1SWiJ7FdWMQ3LsSJKnpRMs4
         pEoPGhyLGohBfpzfXF9OBJ4af29oeObuMpmt8KJlRzYzW2gcGPhQoIToCstKMLmUUZKA
         38tQGKxesqz05ZMK4bPWZvy+Xp8tM6ahwcidFJp+zUwj80TyON0ELbq6/YVtC/w9FBUX
         VgR5fdTpTY3eJdZZ0H+Yn9fplYE+MR/4niXdybnvx/hIPIdjkx6xpyZSSNxGS3O7hwRV
         LUmQ==
X-Gm-Message-State: AOJu0YyUIKyYJN/umQedwP/XYGpIAaTgdqCX8uC3Kj9tv/DrX+qtBUDY
	RAs91M+TaN4N1yOsIvlm52YN34VhI+A24uf4ryEAo2HVspqQ0f4J2hYfiMmLWtA=
X-Google-Smtp-Source: AGHT+IGDTDXW0GmVgU4N7NeqiPF5FyvZT7gTMWUzUFhxqZP1WC8uL3esfgMopjp8tpe6uh+Z7kiHnw==
X-Received: by 2002:a05:690c:4246:b0:6db:c7a8:b0c8 with SMTP id 00721157ae682-6e21d81f19cmr7459647b3.15.1727215352079;
        Tue, 24 Sep 2024 15:02:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d04411bsm3952617b3.46.2024.09.24.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:02:31 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:02:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <ZvM29ufCGsIl9cIM@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
 <xmqqzfnwrb4q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfnwrb4q.fsf@gitster.g>

On Tue, Sep 24, 2024 at 02:32:21PM -0700, Junio C Hamano wrote:
> >   - We already use the path of the loose object as its hash value /
> >     object name, so checking for collisions at the content level doesn't
> >     add anything.
>
> "We already ... doesn't add anything" -> "The point of collision
> check is to find an attempt to store different contents that hashes
> down to the same object name, and we continue to use sha1dc to hash
> the content name so such a collision would have already been
> detected".

Exactly.

> >     This is why we do not bother to check the inflated object contents
> >     for collisions either, since either (a) the object contents have the
> >     fingerprint of a SHA-1 collision, in which case the collision
> >     detecting SHA-1 implementation used to hash the contents to give us
> >     a path would have already rejected it, or (b) the contents are part
> >     of a colliding pair which does not bear the same fingerprints of
> >     known collision attacks, in which case we would not have caught it
> >     anyway.
>
> I do not understand (b).  If you compare inflated contents, you
> would find such a pair that sha1dc missed but the "implement
> collision check" patch would have caught as a pair of byte sequences
> that hash to the same value.  Isn't it an opportunity to make it safer
> to implement such a loose object collision check?

All I was saying with (b) was that if you had some new collision attack
that didn't trigger the existing detection mechanisms in the existing
collision-detecting SHA-1 implementation, then you wouldn't notice the
collision anyway.

You could inflate the contents and compare them, but I don't think it
would much matter at that point since you've already let one of them
enter the repository, and it's not clear which is the "correct" one to
keep since they both hash to the same value.

Thanks,
Taylor
