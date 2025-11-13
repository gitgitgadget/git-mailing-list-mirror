Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B8C141
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003367; cv=none; b=SFKco4Oi9HsnOglDioNunwkeJTpiJltzuTgVULFgjBveWH28f29bPwZOY6XYfEKM3tzu4hACaufLgzaNoYzia5Uh58SHlKg2yDzHTyMjJ9U15IQsVCfQtoW4VQG/elkLsbZagkursy4Z6Ubm9ytkZ8JzocQccpoWNHTAh+LAzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003367; c=relaxed/simple;
	bh=CvIC7Hnio6pFnnFC1UkZLF7UYtMSQdXkiflBVIbf8Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts/zuDOYpKU7Eex6z4vvgV8chnoRHMUvKUzbzOnW7Rg0nVk4eyjAkHz2LWMFVxLI7GRYQvIiF843LALJxkKMaCgXk2MiPtB+h+eiEuIWMJpjxu9a7YhUfiYoC3WpUsNmkBN3WtPbXP7OzHv1OriBLHuKggi9or2h4T1x/0BZyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kqcuyInw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kqcuyInw"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787eb2d8663so4978837b3.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1763003364; x=1763608164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62icsTqmIyhH/MgwMRPCIdh+2JT/ICw0128OmMDAP8o=;
        b=kqcuyInwqFtJXNVhUEs6VM6vZ21X+SnxxJx7/mJvvtqVW8M5GnTePfcSPC4+8vlW2n
         MWoacxGP7iCCmXu6dqbFaArcEP6AlaZWWTiWruD0DQPIgMiGFJu3P299bvuKik7GaSNk
         +OCGtiHbPedneJrzpcxg6T3M6q9S7kZSHc9CN23qfLI/+oiPW2md/aItqLdL2YFhkfhj
         etbX3+qHsxsuoVCJn3T2nrxZTxi8mNgBXlCCJqPzTx0hIG7pm4r++DWEsf+YEzKlnlvv
         SOISoIlhSPwx7rOi83IMxzR24LraI+l+Pimn8PIvBzODWLKuf9WXCbBQl6tiIQpLJUTa
         AZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003364; x=1763608164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62icsTqmIyhH/MgwMRPCIdh+2JT/ICw0128OmMDAP8o=;
        b=hanCZUcCUTrXrGwViKNxoyT9Lm/VtuJjw036Wo3YOyvqUZpbt8EAzg5RWr4yWtsHqk
         d+juo9oJ0DNeItWoZcFMYgQysQH4RuSqrBa7y9bd5spq5iaC9LaqigRXazIoPQ5EdSwj
         pPwm8btqj16v0zXywA28CfP7POTEIRzgmTDtOooy/96FlK6FBOnOtm8TtWX/oEth3g5I
         VDJKQDE++jswCGcpSbzKezWhj3mQwYSk4YrFjdgwi1UJU1hCuKPmPLTM0lgPdE3VJI3O
         qb68c32Gxi+MF1Mx1Tkh08pd5wUTGdEt8JWPUowazUhLqLlpJo9k+iOWOwtOeD/Kb33H
         3msQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmpAMf+0XpgGEkjtO3ve+CprKYtl8BZgU+wRL4TRxH3VgPeGBTyhHvErOieBs3cD8MZGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA59gPzuoW5g75U3RkBtpQdZJPfGpSAdxBDit0fdKu6UXENLNr
	EO/I08S2mcPGos6QVsjxEgTYQPaWUsepQiKwbASJJGOyPWui3UFh5j+Gqu+ojg3J26Q=
X-Gm-Gg: ASbGncvWTtcH90b6ukkV4cS74Dhp2zfJX7CmKO7L6DiOab+HFkOS0hdpNbNwFWt+B+v
	cxQv1XdlY01u/XY0NPYq4Ml6Jb0d4iaE1MbqrT3Ylf3BW+oDLwr1HUCC7w9d62uO7fjpH3dP/eB
	H0K0UhwchloNBx7jUjinCGA+4PkoSNtHcOTnk4tYX0meSJlXYI05gcQleKi2rCrEmS/m8q5VHg4
	jwZmpaxA95MTWKVe7LuPuGG9jw0G7dx+sOr9O3V1Ynj5t2K+I0fy5Y0VAEzYMfeypaKyJCFXWeK
	WumMf8rospGeUWcu4eRms7JHl4I05DJqZXMlvlaWwgHydqU3p0kz4JSSgJqmrY0wZuVadeojJMz
	So4Lxu4NQav3JmI8bt5kp6V/jOE7Rtx1hufDQ1rQHLSaVlGPCutELuvxhg6+kky6ZV31kgcHwqx
	e0Uewg7EODSsm5R/rEX8HLlPwBWwX+G2VBsWzV5tG8SIZaH8wrxGbEBw+zEQ==
X-Google-Smtp-Source: AGHT+IFww8O8g84JyNSyHSaHJbGINPY0KpkuBOf6rwj9y5tY0AE7uxUJynVjalTLJF854bX00dUdkw==
X-Received: by 2002:a05:690c:6a86:b0:787:f18e:b308 with SMTP id 00721157ae682-7882061cec7mr14027907b3.21.1763003364363;
        Wed, 12 Nov 2025 19:09:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78822150ec3sm2721607b3.48.2025.11.12.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:09:24 -0800 (PST)
Date: Wed, 12 Nov 2025 22:09:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <aRVL4iptEeLm/+cs@nand.local>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080537.GD979063@coredump.intra.peff.net>
 <aRRuzrmbJBW8q4Dd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRRuzrmbJBW8q4Dd@pks.im>

On Wed, Nov 12, 2025 at 12:26:06PM +0100, Patrick Steinhardt wrote:
> Hm. I'm not a huge fan of not having any error handling at all. It just
> feels way too fragile for my taste:
>
>   - As you mention we don't detect overflows, as we would detect them at
>     a later point in time when trying to access index entries at invalid
>     offsets. But if the input is crafted in a way that the overflow ends
>     up with a reasonable index entry we might just as well _not_ detect
>     that an overflow has happened and end up using the wrong index
>     entry.
>
>   - We don't verify that we even have a number in the first place. We'd
>     simply return "0" in that case and not advance the pointer. This is
>     fine though as we verify that the returned size is non-zero, so we'd
>     detect this case.
>
> I'd much rather prefer to have an interface similar to `git_parse_int()`
> and related functions, which are way easier to use compared to the likes
> of `stroi()`.

Those git_parse_XYZ() functions all end up calling either
git_parse_signed() or git_parse_unsigned() under the hood, which bolts
on our k/m/g suffixes, which we probably don't want here when parsing an
on-disk format.

I don't have a strong opinion here, though I tend to agree with
Patrick's thinking above (with the exception of the suffix thing that I
pointed to earlier).

Thanks,
Taylor
