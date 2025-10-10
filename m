Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F127CB0A
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138042; cv=none; b=iZ2Wiazmu3XbmJXnyNOAnBzNOEgKytbri4EsDDjFVonDns5f9NMeDl9hXJhzzACveQtdCQTCN9Y/UltCjo32S2pug8SVcfcSU9CBpUXJLepeYC5oxsBEfZA6G2EgB2rFPZl8TAy3vEWl0ZWgC0OTmakY8osDFyfH6k4jLzteWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138042; c=relaxed/simple;
	bh=3l4DTHRqugVsuKPSYhLPeLfRbav8jTIPLvfevJAryDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLw3Z1prnx3N3iPUF01Tm4/M9ygqQX7bS7lwh5njxxcxRrT9qY35tz2E52zDBzhEDAqXCoKp8c1hUnyhEwodWFu/uJTLlk+RwPXyncNVf+BTcM4awWleQpxzktAhPQ09X0KmH6mJx9rVcv3nKJ69oRBKs0UX4wLJUYU2nwmKJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Kkwvwet/; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Kkwvwet/"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-635401a8f5aso3051139d50.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760138039; x=1760742839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvCkhSzuxIyxYrBw/bwekjOgJFjTuxe7PMZ6VEQ+AMU=;
        b=Kkwvwet/F4IjmJBRQXVqkariFVJtTmT8MiENIDO1gGD593440v67IhKSw/UhN8DvcE
         CvmqWHneQUB/BCAPodx9z5QsLT97rz8t+vap8zUWYIgq6RFMNby3yGIUaJjeYRky/lZk
         D8qvIJfm2AK2IHc9uW6Kqu8xLNCzSRwhC0z8QAm1D+G9YNAUOsWFRoc3ODIeVIUJqu+B
         TGQf0ThS2qp8ykRxDopGwnDy+jCCouUqvs16vjYkhl1znUxo7EkP4eZu7PzaQ1AJtRJw
         XlbbAxCmNg/DaokTN0ApPe8WqMxhBb+nzshBnyfDZyWgK1LuOUJOPHow3ZI1BJ2NSwj2
         65Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760138039; x=1760742839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvCkhSzuxIyxYrBw/bwekjOgJFjTuxe7PMZ6VEQ+AMU=;
        b=IOD7mt1NUW5Q6TE/vw636BzTFr7sXR3ePxy0DlQujR6+oSalMuhp/7GTz2BoLLu1V1
         160wpDrGKf/vGU4ONISkmxM4v7HBcfhvNDYCP8nLE8l5lk8hM6KQJha2+gKHXpIZQI8a
         zsZdlwmXO3+E+2JuHEUJa4+CFcOjZldYi4N8Sfdvg69rgzikv5UmUSQdLlnE7ziEu5rX
         pROPHC8cNhSWvk/gNSm+HV7L7px3Yi1sur3l5FYX91ntp2pwOgF7Z5Trnx8m4+mk6h+q
         CZ5+o01VPiJ3HCdSJlVkRbUFuqYKZBIBzpHS7c4YS0fMAyOuiQi+9TZBOdAnIu1GRhzb
         Kgww==
X-Gm-Message-State: AOJu0YyU9zG7GyuzvbZgKcvsArnLt24HtlyfoWgrFbhS92q/IMJJJcmn
	Xq3jMJR3hhsOUC0a9tsKXTEIDBNKoPRbl4J0zBLmzN+tPnb9K9j0CGX3mUI+n7mqg2E=
X-Gm-Gg: ASbGncssn6X1ADLMwJwELIf7qt/jxzuDDp0RT6ofNGSayyTxU1Alq6L9bjvKbgJ8rSr
	oR5iCCTscK0PsqI11HiCZFj59laAREjCjKbaJVwfGoW54UkS9jdtBe3UW5K/dAgYcsU1eoFXNvm
	1zoknf0gglHcRyjyDSsZhIhPlVgAr0JnbcN0/f31snlZD7ghdfFD+wfhGzbjS6AYzt8OIKZSRbN
	Zd5GLFyQgmFRgjuOMOTTItEXSPzHh+LILDqVp7q7HVazScyt6yNX5xy2S/JbKennXFdO7y4FxW2
	KaXheavlVxqqlT6U0Wmvq2MsvQYtdbRFa9TeX2V/LYjjB1D1LPIlcqsggWDb+4hMVrDy4E+mKIh
	CUUXjgVHI4fUHCbmq/OnYsAs7B/s6Df7qBW1eJxPXX/Q5pzry4juAAq0lBhUVR1JG3CqrDLMKzs
	B1KGCTmeBtWWVQGi3et0HNQG8E6OxpZV1U69hLVyO/qZP/
X-Google-Smtp-Source: AGHT+IEk077oIsMTGR4N0eNtEKVf4fz0zifjqhM7se9M+Pdd3RUg7R+HemgzuWcd03FDO1bUkRRWAQ==
X-Received: by 2002:a53:bc04:0:b0:63c:e8c4:d8a3 with SMTP id 956f58d0204a3-63ce8c4db51mr5440105d50.23.1760138039085;
        Fri, 10 Oct 2025 16:13:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd9516074sm2041148d50.4.2025.10.10.16.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:13:58 -0700 (PDT)
Date: Fri, 10 Oct 2025 19:13:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 41/49] builtin/repack.c: use `write_pack_opts` within
 `write_cruft_pack()`
Message-ID: <aOmTNbqC6Pz0B8SL@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>
 <aOj79rYGyYWYUGGY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOj79rYGyYWYUGGY@pks.im>

On Fri, Oct 10, 2025 at 02:28:38PM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:09:57PM -0400, Taylor Blau wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 6df7c88085..501359c580 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -221,9 +221,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
> >  	strbuf_release(&buf);
> >  }
> >
> > -static int write_cruft_pack(const struct pack_objects_args *args,
> > -			    const char *destination,
> > -			    const char *pack_prefix,
> > +static int write_cruft_pack(struct write_pack_opts *opts,
> >  			    const char *cruft_expiration,
> >  			    unsigned long combine_cruft_below_size,
> >  			    struct string_list *names,
>
> Same question here regarding the constness. Subsequent patches also
> surface this question.

Yeah, there ended up being a little bit of fallout/churn after marking
it as const earlier, but those are all fixed up in my local version of
these later patches.

Thanks,
Taylor
