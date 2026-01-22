Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C5352F93
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125493; cv=none; b=Vfn4zhdo2iTSuy4RGKkzeckeymCCW0VWMVbysxubI0w3d5vqtBPkRqB8V5f/zyd4rCebtMYctcuJI9/Ib3h6HRicjFSYozMeronyMK9EJBTPw9XgDMPjjXAicyH7xFnWd8K/065MeNTJWTl1mk9cgDq54t2jhszflMv+40zwk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125493; c=relaxed/simple;
	bh=HvMfijoyAOf5Cd5gQA03tm0qMn/yS+yFGOW1hibPlk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxp/Ad8m1aG+aWpf4rS8u7WzJAtEpcQwoXftzyzY+W195Ngnm0L4GuWk1XA90YPPIs7BmMXyiLoUk638WdavtysnhRpLqiGY262eehWftGg12BESx57GmKgLYjDOPfooEjPh5oPBM1d6zmN3TxNijU/uRUsrdX24I+BGA3aOIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Z4h/DoKi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Z4h/DoKi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6b16bd040so184685985a.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769125487; x=1769730287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFXUIPlckPzZbVs3NtF534mG2UHVwIeQ/tg8rRY3EnY=;
        b=Z4h/DoKiPkSyAJAsvaj0zOfdS6cou0+x/udLiFB4Qvh4YfDkEWezp+TWzY6IaMOkjZ
         pT0FjgvcsozYka8/rrwtICLaAXGW7JoVkcuh0ymzycMXg1icmWSISzDJhsJ0Rpq+OYyS
         LSPA9OUUWgn0UOTqrVO083xfQDZMybY9W/s8Tc8yGUJANiEJY3smB12lyA54u4APf9Gq
         aRlh5aIjIxyyVzTclG49zVhzAoLD5EDaJZQqDAqpxSJVWxKw3pm9BoeCQbD1u/Tx4nmG
         aFqs+upGJlxl/a7gEDnsW3umEJwcZwzp/eWZ+G+ZVIMcstVHWh4wbIBPy0qz1zvBbnGJ
         RnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125487; x=1769730287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFXUIPlckPzZbVs3NtF534mG2UHVwIeQ/tg8rRY3EnY=;
        b=AOAYhBBgLF6l4FHj5zIVEna7SajtgVsnvE4EgLf1HN2X2xyPD5i5w+6qqXHhea/S0f
         pcFQ3HG6QXqIhO5hvWIKn2CrFc/rcLnYbfWZgfCCKoXVwzjhh/c5ltpvKKDfNLxv3jvf
         GkvVsTFQ8+DR+ccxEq7jpEiJf7MiDK+bWP4gtyDSsh/GD+QPmfUximWIyPi888sQScZP
         tnCXgTGdgy05qefJ6v+iKZ8jWcPjapEC5ApjaV37/dDc5D25YsLr0DOCDYRmXyLdWQFL
         poUkHpq+D5wBAI2+Or3n97HIc1y88HceIB1+8PvODp0kUDldfG4sRg8IN0jdLLlQ12/W
         Tvqw==
X-Forwarded-Encrypted: i=1; AJvYcCXty+0F8rAoSf/s0qTGCxXbudNDEMUsijkHSQmna/RcDv8qnetMfRNRW5+JfvL2VKoOVRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOByo4vqWhk990S+PyZFct2uBeNUItZF1GyLF1+w9SfBAaY9P
	+yzuCqeN1kC2XqxozEMHNUgi11EJ2LcTdifCAFDjG3LeOuF7jvIqoad9ZYhqD3K3psA=
X-Gm-Gg: AZuq6aJ1uozFvhx78dfLT4n30mgnf2zoVOoxxdI+24n0PJ5wQz3HFqB1Ise8xW4+PQY
	J7/BuqbxWO8bYV7Wt/6blg85VeQWZe6ElnNmQMdV/tJvK06qvZzGWAnb2tjiQRK/LjyVgFKPrz2
	kHBN3bMBx4jBijvOnpWQOepGf0BsWmHQ01IzGfnhF70Qc++c3aNhj4AKiiIZjGA2cEIQp2BeTXW
	DoNUFJ1+Qnw1h7cKMQ/ct0Au8IbwGiS6bZrQbWTzjsQf70rVoPkQjpy/nJJeEgrwipN90wrtOJ6
	uNlWSlcoMwAVFRFWozSdeCBao1bpsPdyrbHeUIDkAvoudRFmcBVR8y5wX2NVYvTNJZtCiftjRMh
	BR2pyCsW2SbOiIvbOFVkL1XeDcNDF/Vv6Pm5alVxUWrZhmSfxpEXVl9O1raKxWF+ip11mKgjDNC
	UAETeuIcvQXWcAt6f9FN88JVWL+Ht14SD/dtanh+GgRDGULGxIVpABnsKIegzX2APW/TpNTyh7M
	5TQn6hms7Pxl/hpgg==
X-Received: by 2002:a05:620a:454d:b0:8c6:b45b:9e2e with SMTP id af79cd13be357-8c6e2db8dc3mr157163085a.38.1769125487493;
        Thu, 22 Jan 2026 15:44:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e38559besm44967485a.45.2026.01.22.15.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:44:47 -0800 (PST)
Date: Thu, 22 Jan 2026 18:44:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <aXK2awZo/d9bUjPY@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
 <20260121211128.GB723458@coredump.intra.peff.net>
 <aXHI0vNArKiDCL-I@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXHI0vNArKiDCL-I@pks.im>

On Thu, Jan 22, 2026 at 07:50:58AM +0100, Patrick Steinhardt wrote:
> > You can find this pattern in lots of places (try grepping for "enum
> > [a-z_]* flag"). The ones that aren't are typically using flags that are
> > not using enums at all (just #defines).
>
> True, but `unsigned flags` is way more common:
>
>     $ git grep 'unsigned flags' | wc -l
>     219
>
>     $ git grep 'enum [a-z_]* flag' | wc -l
>     56

Sure, though I think the convention can/should evolve where it makes
sense. I tend to agree with Peff earlier in this thread that enum flags
are preferable to unsigned ones for the reasons he laid out. I don't
think we should go and proactively convert the 219 instances of
"unsigned flags", but for new code I think we should prefer enum flags.

Thanks,
Taylor
