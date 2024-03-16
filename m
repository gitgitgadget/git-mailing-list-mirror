Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386B12B93
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604841; cv=none; b=h6LdSi/6ysbPM/AYj60P7WqpPcH1uIDJBr/eEmohuoKKZrpBXpaKG0V/9PwOtTeszXlEh5eneanb9gCyINJqY05KnRFZ18+RRL+J4D/5xA995+V+wXOVqArY0cmEH3Ol1uuzNHwwcxO1iVvnYLTy7Nj3ffuH82ziUS607WtZoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604841; c=relaxed/simple;
	bh=RRQlFnzj/P6MBWLLUiGro4lyXop5xmwcL5N5hwnE/i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhITqWYAbIfC7DKwF+ZzOTjZGbWSNMqT54yOvd5crAmbB+AlGMqFIEuLi27gcpJ74N6eDeL+Eyei2nShCCQzaUHhHAMgAQa4aVEnQZanmw3qvZ7hQM057cw+dtvMC94pxdsjAb1Bir8b2dVFBRwvNblfP67L5TQrGtZIFUk2uBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wjWvBP5u; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wjWvBP5u"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7882dd2b1c9so252932985a.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710604838; x=1711209638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1l6Fd08bUzs7lcQOPJ/fGybwYBr6ulnyIZxkjQPf1A=;
        b=wjWvBP5uAq6o1eaqsaBnZc79oO9N/PvxYe3tlDsRJfpPXrx32K3ebxYvYicaHgcTl6
         xXO4Rg7aJtDNb/pJGNEJeUW+Me+I+d/KXAGJuKcYG+fPOxGABZ6GD+Gzy71IKYlezo7J
         ZMiB8bei8pGj0l8V0EALJ4bvrjGtBjOBXIm1hCUNbRuy105KfvzowbHZtFgULjRXFkVF
         HP6h+Rd1xB9hcbj8iTZdh4j3CJ98SdzHRdhbOgZ1aLpyfP0FgsB7jL3CPzp2bQG8A5r3
         srFM7bBFv5sqSTJTdS+mnqhGGj33KVMp/q2TXUDgoSZvuG60bZCZ89N9CJFKzGFQjUVK
         JZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604838; x=1711209638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1l6Fd08bUzs7lcQOPJ/fGybwYBr6ulnyIZxkjQPf1A=;
        b=xCN1fC/D1lJat331jYsubUreEwSf1YXZwraWcS5qX6ea4uOEt8o4z0BUAGelzl7YxY
         Ch2Vz0ZWJNhlpcXOntbNnFzXyDh+wrS6HgunQVHa82Rghk7aMFrrIhvlh+kOWeYYrkj2
         iplx4dgDF1RvdFr9UBS/uPk70Rsw3ulZr4amEli2Uhmh/oL9H6N4fqn3sZKlJlj97ncI
         0a15mWH0BYPygeEZ2okXgHTgwUoXJcYY7zadIyIOswoh5ZIT7ATRSiGvhCjnMxoamE+F
         eO8oJcfdtODJbubFIWdAqwZTIQeYdqrZ2vMK1LvnRJ1K2p+HGMNEj2/bJ44Ed9AnUvs/
         Hi9g==
X-Forwarded-Encrypted: i=1; AJvYcCWKlsBKOG1fQOUL9A9HUKKy8k19vJU3nhLrxROE1mop3WDOTzgCyphN/AI7lyVF7zg1VHl52gt/J/X1SalP73gk4QCA
X-Gm-Message-State: AOJu0YzXJalEdgbABPfV6tXPKILjRaqW0oOu7m1IsozdQuEtIMPDZ/vY
	BuCfffpuhp+z6c1T3fTe2NP2CY2bRLIact0MHBWmXG3kKnVR29CiW5PycK/J5bw=
X-Google-Smtp-Source: AGHT+IGqb2N4vdaLNZkU4HoOihx6vigaB38Dlcd1w5TRKlUkw8oeom7mzRpXOlIg51uzuUhYYyuULQ==
X-Received: by 2002:a05:620a:3720:b0:789:e3eb:ff4b with SMTP id de32-20020a05620a372000b00789e3ebff4bmr8270997qkb.39.1710604838173;
        Sat, 16 Mar 2024 09:00:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020ac87385000000b00430ac228781sm2190629qtp.67.2024.03.16.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 09:00:37 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:00:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Message-ID: <ZfXCJAsACzKLndNm@nand.local>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
 <20240316065737.GA544929@coredump.intra.peff.net>
 <857e512c-d6d8-4bad-9eb5-5ca233a1c884@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <857e512c-d6d8-4bad-9eb5-5ca233a1c884@iencinas.com>

On Sat, Mar 16, 2024 at 12:19:44PM +0100, Ignacio Encinas Rubio wrote:
>
>
> On 16/3/24 7:57, Jeff King wrote:
> > On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:
> >
> >> diff --git a/Documentation/config.txt b/Documentation/config.txt
> >> index e3a74dd1c19d..9a22fd260935 100644
> >> --- a/Documentation/config.txt
> >> +++ b/Documentation/config.txt
> >> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
> >>  a naming scheme that supports more variable-based include conditions,
> >>  but currently Git only supports the exact keyword described above.
> >>
> >> +`hostname`::
> >> +	The data that follows the keyword `hostname:` is taken to be a
> >> +	pattern with standard globbing wildcards. If the current
> >> +	hostname matches the pattern, the include condition is met.
> >
> > Do we need to define "hostname" in more detail here? Specifically, I'm
> > wondering whether the result will be a FQDN or not (i.e., the output of
> > "hostname" vs "hostname -f"). Looking at the code I think it will just
> > be the short name returned. That's probably OK, but it may be worth
> > documenting.
>
> Thanks for pointing it out. I agree that it should be further clarified.
>
> Indeed, I was referring to the short name reported by gethostname(2),
> which should agree with "hostname". What do you think about
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9a22fd260935..268a9fab7be0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -189,7 +189,8 @@ but currently Git only supports the exact keyword described above.
>  `hostname`::
>         The data that follows the keyword `hostname:` is taken to be a
>         pattern with standard globbing wildcards. If the current
> -       hostname matches the pattern, the include condition is met.
> +       hostname (output of gethostname(2)) matches the

Hmm. gethostname(2)'s manual page isn't overly specific on the details
here, either.

I admittedly don't love the idea of documenting this implementation
detail (that is, that we are calling gethostname() and using its output
to compare against). I think it's fine to say instead, "the short
hostname", and leave it at that.

Alternatively, you could say "If the machine's short hostname (as
opposed to a fully-qualified hostname, as returned by `hostname -f`)
matches the pattern [...]".

I think I have a vague preference towards the latter.

Thanks,
Taylor
