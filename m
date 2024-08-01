Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE7140E5F
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542082; cv=none; b=D04M3iysBMhu8Uaot4JINm8bb6UYFnH1bSN1YUnBMjaidTrgbTXmnvA6SSSx6cNkpHweUsVywfDovSn1L/n6OSRO11mjLFFiTsCsbxLF7tWAFfbIQtiJ6K8Z3q2vu+/Hh6txuAUmr7Dnqmgv3CMpNGNyiPv3hRz6vE5OKTPYKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542082; c=relaxed/simple;
	bh=FV6U4F5YVwQbBKgzm6PHH5AWhe4XkYAQnsyDk3epM3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECnKlaaLDoFYKr6D2PJ+u14Am0h17JG0QTv7RXgbHSoz3hdY12W8b9AA4c+U3VTXfgXacxLoz7ZtC7xkKZtMm8qKo4JKBgtN0Latu8iGtbx6t96jcNeeWg0T1xy52gTJqsKXiEPx4CmAehmikZxbsBXwW88inBxOvNQ8bCAABsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Sg04TKME; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Sg04TKME"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6694b50a937so71509757b3.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722542080; x=1723146880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcnYZ1Z0TOQ/Ml6G0Bx1/NfOe7Y6xGiTzhii0CFPpZY=;
        b=Sg04TKMEdrel/B+CD06brzPekinTW0hz58Tt7/2jOZysIkbGR1rqkGXl31n7fz36Ec
         8puW/8Zo+0MErmyDdNTye3k0+O3jOsFgh8eGOIcVAazyjfaHL2JRvflmn03cmRYVQDnY
         HNqieIqR0VIGaJEUcbUHTjni6Fyn321Jx76eO2Hy83nK6lVq9wirG0GM3+XDb3ITruln
         oKBsYlbVEB292iPS1EOaD9sVXBE/sy+ALLf2PEf/ykgub3hoUHiAMwSYX/9rcqHH+HeN
         PlDRZOjkGYOED2oL2IgMnM2pynlj/Ni+m+uCAKwF9M5LIZj9m6hVMq+g5z1zV3yB1Le6
         IDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542080; x=1723146880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcnYZ1Z0TOQ/Ml6G0Bx1/NfOe7Y6xGiTzhii0CFPpZY=;
        b=nYEEkAZV2Tbx7n4WbPT6NTb9X7l45jIqytAlxu1raEVilc2etSBhNrUyd6vX4laqYS
         ARXXXc3YcgzZwYZxRm8GmOcWmbib2Q6rnmWokj2MVEhA/TJMsailx6JJrfcouqF6eVTj
         ABFGN6mVobDqpVqGKZBp0Z/2F7UNxta/nfT4p+DIg9TGqVBKmaJOLSkMfqfXAVv58Zul
         6g9sQ07e06EsRZBj5B9qLmaSoH29V8A2bPZKYCYFXnJywMJMA5yuM3gwJxZxCRUTwBof
         CpOXiVN45rKBO06IQlXX/ZF3mDm9v5EJ6/sDt/KmwpHAJvL/e1varr85I0q0km8uV2/V
         K+9A==
X-Gm-Message-State: AOJu0Yz7VeahyJjfHwdcVskp+BRVr8XLJTMo7bpcR7ZNvY8FDBrF3CT9
	Tc2m1vCO3sskBFS5ye/l4u1CrPBnCK5KmGmTALH7xO5/V5vtWiaIE3nUs+9mAWI=
X-Google-Smtp-Source: AGHT+IE38fHm3LORJ13dE4GtKju8G9tzqDbkJI+gDgMaEcR26M+3swvIvTRbiQgJ9VR8y2g8QJR1mg==
X-Received: by 2002:a81:8ac7:0:b0:63b:aaf1:b8c1 with SMTP id 00721157ae682-68964392785mr13861747b3.37.1722542079877;
        Thu, 01 Aug 2024 12:54:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b45954c1sm605507b3.135.2024.08.01.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:54:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:54:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/19] midx: introduce `bsearch_one_midx()`
Message-ID: <Zqvn+qGz5hireM5X@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <bfd1dadbf15cf735392ca15b52834f104cbd6538.1721250704.git.me@ttaylorr.com>
 <20240801100635.GG1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801100635.GG1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:06:35AM -0400, Jeff King wrote:
> One thing that confused me, though, is setting "num". From the "-w"
> diff:
>
>   -       num = m->num_objects;
>   +
>   +               num = m->num_objects + m->num_objects_in_base;
>
>                   if (!num)
>   -               return;
>   +                       continue;
>
> Before we only had one midx, so that was our limit. But now we are
> looking at "num" as a limit in the global size of the chained midx.
> Which feels weird, since we're just considering a single layer here. We
> seem to use "num" in two ways:
>
>   - we return if it's 0 (or now continue to the next layer). But
>     wouldn't we want to do that per-layer? I don't think it will produce
>     wrong answers, but we're less likely to kick in this early return
>     (though it's not clear to me when it would ever kick in really; a
>     zero-length midx?).

This is definitely a bug. We should certainly do something like:

    for (; m; m = m->base_midx) {
            uint32_t num;
            if (!m->num_objects)
                    continue;

            num = m->num_objects + m->num_objects_in_base;
            /* ... */
    }

I'll go ahead and fix this one up locally, which is easy enough to do.

>     So I think it's correct, though it feels like bsearch_one_midx()
>     should still return the position within that midx (and then
>     bsearch_midx() could add back m->num_objects_in_base to get a global
>     position). And then I guess likewise there would need to be a
>     midx-local version of nth_midxed_object_oid().

Like many of the other changes in this series, it's really a matter of
where you put the complexity: either it's in the callers or in the
function itself.

I think here I prefer having bsearch_one_midx() return the global
position, since it is directly usable in other top-level functions
within the MIDX API, like being able to pass it directly to
nth_midxed_object_oid() and etc. below.

Thanks,
Taylor
