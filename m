Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6ECB665
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771780772; cv=none; b=c+UKHTMTkpvc+cfL+l0KGx3fQFjWhKOX1+QDxxnleDZHGWLItW80qV81qYXLMKOA1/CfF1ft6j7Su4skCq6pFl1NeCGXb2xqjpyYTWJ08F9uGP3WjhjvGNyRSyY1hm01j7Y2Vyh/WUeTyfqpuo12HseFdPyhCc2rxbSxvnr6O7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771780772; c=relaxed/simple;
	bh=woXQP9fNMkmQOt1hRhdVoORg/xsl3I5RPyl8+UjMyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKgB8RU81keJJj/0ZXHhXwEB4g4HP6Qc9+X2bOlMfHbDldzU4XCWQjmN1vmsZVJd7G3ZOSfqURoEudtIAW7ubmya9nPft7ilfUGZGPBKmxS4pBUqm867tJ8ZSxBH9vCMEn7517CMcjNQ6fj3UYhYYHbyHBGIXGbrAEHEbJO01m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqZr/a9e; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqZr/a9e"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso1339728a34.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771780770; x=1772385570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ckEovyKYu9LVIqfOdj5Pg83nmdTeQZauolWpBnTT/U=;
        b=jqZr/a9e5R9L/IIMzcoBawamQn1vlOODejaR5JqJ6XrJmrNDBAJtDqPLwdIkNoR0YY
         yuUMUxbHdzi4bET/veB1X55vXxFfrLfpe3/C3/wsLrOCmj1z+W4shkwwXBJbXo2ae4Nj
         PX1fzwFUn23HyV2b4MuVeg6/T04r93tsJ1AwRhz1OQKAlo6aFpRO4Xd5AsHgvdd0OhHK
         Ixv8aQFkudJLG0eVPsH4OmFgCsRK4fd3ypRDvaB+cYYsAC/fOv+9zQS+p0tcXgsgKy1x
         FIo5VF3gXBIR/swzf7fqhwqn5FofEjmSodacswacvLBGj6W0gB409M6aVb3eu+oM9dFJ
         6xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771780770; x=1772385570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ckEovyKYu9LVIqfOdj5Pg83nmdTeQZauolWpBnTT/U=;
        b=GKgYIRWhh+79CuaZF1Flm+9ip6aLAuJPTtyh8C6A8GQHMkCVAAoybRF24f1nyHoGW+
         YLTXO9GuOSDr8KQhZ3fyX4gzL15XurJUJ6vFYpXHJwnrDBEHgu4QOCNZig4A1A0f0GG7
         blSG4GF2U5cuTuIUzMfK7qYWyZyB560l6IcumWlH1OQrZ6voLADyBovrM6x+bmQgctN0
         PpQWPv6bud9d6FEyBwRyUxWqrVMhlpSpexi4dVnSqaXYrN5xsGOelQTooWYxp7zREfUS
         DV7qNAafNpcnLWsMaRIfWcy9G0d+vZ/fDfLNSNjr3PrlbmIBKc0+I6yPqi7KUXhAtGxs
         cBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSLX6F7Efu7jyeIf1IrGazkKEdmUaJ7z93rCWosb0IjJJUX+Gwp4MY//7cDaTOngBeajQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNLkuN0ME8fxW7GmpclW2+M5lTa2XO0TGW8hjP0SHtnrAZTpg
	adcEuw3WdrDfVbh7wQvQa7NCQCMMUu8jodk6jXMEueIz2GIpFJidZY7RCXgK8w==
X-Gm-Gg: AZuq6aIDjgwcjuFvpVs155k0LgRkJ+famMzhh+791KulH5npn04IkEoPtFsjPimlIQY
	tUthdOvIDnDjWkfrHltlVXPkPimacxE01pFIquDU/z8DOMmrufmeOyhkxNJpo+vayyh4kSvYhAz
	IBtRj8AP2IIetFeeWLWWFdZYRyH2r4+oI7VJKUBDq3Vr9Kr4DRleQ0Ebg/USJuHi0SzY9IbaYRL
	NA/co0c/yg2Q8MqHQH20oksKf2kw7QmJavdwX2F2YkXeZtIOY9MmKGBvsCFYexcLhK9FV8d1/G3
	nYjCHgfIbmS0P7IkdTAgShaClF/biBcd5TXikaMhzNubfQIY8z5hIUWigW8ZolUxxqkbLAE6N7N
	wzbPKCdWnHtzhNiVE/pG7WljS/dTWi9BK8CIAMrfENOFAKWSCQWg8FIAi4DrQC5+2bpSm2CcX3C
	VpEmZ2u8FrY7mXD3IX
X-Received: by 2002:a05:6830:6610:b0:7d1:9da9:c6e with SMTP id 46e09a7af769-7d52bf6bb20mr3097991a34.25.1771780770068;
        Sun, 22 Feb 2026 09:19:30 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf9f663sm4923516a34.11.2026.02.22.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 09:19:29 -0800 (PST)
Date: Sun, 22 Feb 2026 11:19:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
Message-ID: <aZs6OvvBB4WPNx8j@denethor>
References: <20260218210120.1146078-1-jltobler@gmail.com>
 <xmqqms11qmsj.fsf@gitster.g>
 <20260222094158.GA1319383@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222094158.GA1319383@coredump.intra.peff.net>

On 26/02/22 04:41AM, Jeff King wrote:
> On Sat, Feb 21, 2026 at 11:07:08PM -0800, Junio C Hamano wrote:
> 
> > Perhaps a fix-up patch on top of the topic branch like this?
> > 
> > ----- >8 -----
> > Subject: [PATCH] object-file.c: avoid container_of() of a NULL container
> > [...]
> >  static void prepare_loose_object_transaction(struct odb_transaction *base)
> >  {
> > -	struct odb_transaction_files *transaction =
> > -		container_of(base, struct odb_transaction_files, base);
> > +	struct odb_transaction_files *transaction = NULL;
> > +
> > +	if (base)
> > +		transaction =
> > +			container_of(base, struct odb_transaction_files, base);
> 
> That works, but you can also use container_of_or_null() in the
> initializer. IMHO the result is easier to read.

I agree that container_of_or_null() looks a bit better here. Happy to
know about this now.

Thanks,
-Justin
