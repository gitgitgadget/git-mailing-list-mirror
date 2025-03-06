Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E217B50B
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303263; cv=none; b=tAUCzYzPMtvNZdoKS2CJYkj04aWobY8yPZsZHYjG/2mkUWaKLtp0+Uq3INOkq9J8qBtZ1Ehft+uurX09PT+XMMmPTsHso1v0NP/fD41KSDfZBpP1XgX9uxxEhMb6NkWtQNbUdzni/d/UEWiyqxGWG+7zvfXQsRj8YKqVIvFYi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303263; c=relaxed/simple;
	bh=oH2NIq1J0kFrODcnG7aZ+b7UwgIyIynnrIZZdf22gxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6LK/dYrrHTkqnm/FJ9GfFqvO3VpYqwRMk+sW6tPhdmxm9AiHPBNDGwQnErISSwWipr/RyKKyCm+BLHckbPqE+sUZt/9jPusY36W/K7VTAbK+l9UwSmf4uo8qlt6EFligRKSE634+ydfNgnxmI77Sw0NzHeMxsIgkTzFx2v05v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm2Fglqf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm2Fglqf"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72a1703027eso124497a34.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303261; x=1741908061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBHc1fmiFiYDKFCz6ALqhmhRzbTiJo6HkesfY0HEUrE=;
        b=lm2FglqfSj9C15NPb/5tcoZni1vdG0uFXXWQyMTz3Pjgz8YVKHJ7prqmmc/eY39KiT
         h/P0czoCG4MO+UANRIjhsRGKGuPnTAWhVsY1yCS7dpa3D+nSTm94oFCeEyCQ4GBkV/Hd
         gdYXOq9ppFdBdpF8tLHITBnmq0n3+1ftpm1P9DhfZIoOhUCOc6yrjwHU0hVs2U/YG4Ey
         KHrpB5ZCXg+PjZ+Ldp7QuSNysP87daB++rWx07BZMIlHTWJOvE9JPUsmn3e2poFVO56w
         XQdSBPTMum98E/PE3msiPvf2vmjGglqFZCebx1sgW3rN1zUUgYJu+yMaJY7i6qYXnv5l
         Kh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303261; x=1741908061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBHc1fmiFiYDKFCz6ALqhmhRzbTiJo6HkesfY0HEUrE=;
        b=gh8+O6eNoK+HGCiJ4d54cPTWEqQe03rA5fgTlBxzJUyGxbSL5RZ/3x2/MJtsHsRaUJ
         gOthrRuLj+/6l3+ULSbviQMe16IaKTYrebEEPI8gat+ju0LeI7NQ1W2XWB4jYztqNEmo
         7bciOjhJUC9gTrrnMDGeZtnBnOhSuUfBvU7Hg8YproVvLskh1UWnfB2YiulX20wBdHwl
         GXuWNASIY7+mJ10hut0DTq1oxss4oSE7ibXjn6K6jCtqszSVrDhkS0/HsZJ/AtC4RSkd
         AzIElhA9uMIw4/6LKo/W8w6esFbKn3qH5ASNA7w+7HFbDsnmHuvLcnEx6kG5Ywhz9C9I
         NU2Q==
X-Gm-Message-State: AOJu0YxbY5VuotiStL0IY6GWyyrszf9d/qYqNhertHyF9RkEhYNaJbKH
	quRs8ASW1KxU0VloElcKFfq3XxwqfVsu/+YADoZ0M/0EEyXSz2zo
X-Gm-Gg: ASbGncui27iBCTLe5fAAP5sMRyluXiypkzeXqnoDcdzJqJV8BVsQC1DsXrkbil07f5t
	6deq3avmjSUV5Q/6/CZk0XqUyJnySjnMmkJ9+2auIgZgW1nYXNJ0UiwKNcCFe4PkrLoqfE3rtNh
	hTCCGIz7KruHM2A3KgcrbeEdW946EuCrHXESumwfMs9i5Aro67R6IdaL4mSBHzT6DJSZjdq2IzJ
	rKI00Py8p2+vaoKuEC5UW/OZxpY86ZhdbSTtTji27YA+WIJq4cE8/QVhYb5vkMNosChqrJKZrbB
	DM+sm9AxNU21uASnFAlt06T9xpQNPk4VVTaFyg==
X-Google-Smtp-Source: AGHT+IH4rGUtdIFWLpKnVVidTHW+990hTIaJR0Jwed74d19/BfOk8hlIm8X5agDEpEu9tiucT68H2w==
X-Received: by 2002:a05:6830:6487:b0:727:42cb:db30 with SMTP id 46e09a7af769-72a37c64b2dmr738032a34.26.1741303260781;
        Thu, 06 Mar 2025 15:21:00 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72a2dbc3887sm445001a34.59.2025.03.06.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:20:59 -0800 (PST)
Date: Thu, 6 Mar 2025 17:17:37 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>, 
	Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/6] builtin/reflog: stop storing per-reflog expiry dates
 globally
Message-ID: <35jnncjitwoy7bb7w5zyk6nhjvab4tmdjhtuqltljypfigk2g7@swpulgkzooxl>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <20250226-pks-maintenance-reflog-expire-v1-3-a1204a814952@pks.im>
 <usf4pzrp322xvfrvsasgy22rnw7d2a6krzuctwpp23ppdgh6ji@ram73wv5dn54>
 <Z8l69bRy8PY3Ep9J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8l69bRy8PY3Ep9J@pks.im>

On 25/03/06 11:37AM, Patrick Steinhardt wrote:
> > Now that all the reflog expiry configuration is contained within
> > reflog_expire_options, I wonder if it really makes sense to also keep
> > the expire_total and expire_unreachable fields.
> > 
> > From my understanding these fields are not really for configuration, but
> > hold the reflog expiry configuration for the current active reference
> > while iterating. This gets set by set_reflog_expiry_param() prior to
> > calling refs_reflog_expire(). It seems like this could be figured out
> > during refs_reflog_expire() now.
> 
> Yes, these fields hold state indeed, namely the value for a given
> refname. These fields thus need to be updated for every refname for
> which you want to check expiration, which is done by calling
> `reflog_expire_options_set_refname()`. This interfaces is extremely
> awkward from my perspective, and it would be very much preferable to
> instead have an interface that, given the options and a refname as
> parameters, tells you whether the reflog contains entries that should be
> pruned.
> 
> In fact, I did have a look at fixing this awkward interface, but it
> always ended up with way more changes than I felt comfortable with. So I
> decided to only go a couple steps into the direction of better
> encapsulation, but to not fix all of the design issues with the current
> interface.

That's fair. This interface certainly feels awkward and exposing it
further doesn't seem ideal. At the same time, maybe its not too big of a
deal that it should be dealt with now.

-Justin
