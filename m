Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA3D520
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284933; cv=none; b=nIUtEmboenYKxkePA1mUz5mtzDSQYuPhFIz5P+TP6vmhJEFygV3+1bbx/uN3GJGBh4RP/23K+n18R8a2LENZYgKFu3XzcrsXD//1SAFTGLwEqoDodkwdsvO4c1Gjv6qi0Wn01n/axltSHYpjhso2u4kLef0zBtBUImi96qxGrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284933; c=relaxed/simple;
	bh=fqSgyjbgQye9BVrMPeNdXKtx8XQOcq27mAiiv10IJf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5hFbif1ys2zojo4Olq34Qqnp6Hm45R7xYeMmVTcWK5BfVitK2n0cwTHT1dsI8EQe00HVL0ocX7Mr4kiTm3daMbxFYYssvanaMIObftELvku1ZwUbGXQ4VLrijeHBEbsNAe7Gm28957VLCv+js3f+nlfvVfT6alGlFg+kgRebN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nvDJrgV5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nvDJrgV5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ddd138e0d0so1164537b3.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727284930; x=1727889730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HSP4Z2TDzIfM3flTJIxg5/Z5hbzhzyUaDHRQ/MzbB8=;
        b=nvDJrgV59tEPVye0yKOJPCzmd9wFOrDOYyNn0nI890JBpUETX012eL47IsdvFQbqLY
         rZo0EmwA7caFZw/owT0iu31s8w0dc+LeILOgeJGmFKZJJljkd1lF6C/ldV1YtfHoPghW
         qQbEHYZ/p6rq197JTPRUDSEQP+II4m7MvpOOlLqtDwADM0Y0Yav04QJOnf1v17jtgeP7
         ssQyNpKklmkQ54X4oIGahj5EWf2p9uxjyQXjB5jfcENQ328vvr5Q8ZqjEzQygREMZp2n
         RRDNSHlJU5UhFmJe46cTFV7nx/zEXzyuUYiujm1g77XsfW6XcsNEFXETaJhn3dL17orc
         5U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284930; x=1727889730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HSP4Z2TDzIfM3flTJIxg5/Z5hbzhzyUaDHRQ/MzbB8=;
        b=rP38dKRHE6P998yq/ucso5YPSry8+PTq1OxVANn77rWD8M90FfSinGwUKg0/+R/fcJ
         llSBgP2Y/GH0Xn6JT1nb5HPQRW1wK+5t61z2I3laeULHXPHD9csY2M4+xajav6wnFlcW
         LBa3y/M1FLkPitpVInEqnLIkqnup5Si51nrJ1mBs4y5T08lACgxq97Y8mQ/jIDk7APZX
         cqTEWuthA5TZw621tXuQL/s0gmdKY7O2uoD/PhrbLitEvoPHOYYa2nbq1R4ycsb5RdCM
         vc9mU6iCM9jq86WL71Zb8xPSsR0ZnS7iZtYDXLgpyRWDiTkIm/Ue3TLplqw/rRfY7nTs
         38cw==
X-Gm-Message-State: AOJu0YzU0H+8l7h40v98IN613qZ0puaoYaSH5j2IbjYUtVGU/mzaqj4f
	gh1qj2texx6IFN1MS5gPgeLhxlO5Og38/Wc41izCGPrCq/ycEwD1oGCpd46WYZc=
X-Google-Smtp-Source: AGHT+IECcSiRFHPzjQgP2jnU8dql5z7ZbB841tPZYdJiUAB6EtTWGlT1Wdb+/zval+v2uTAKe24CZA==
X-Received: by 2002:a05:690c:6f8c:b0:6e2:2c72:3aad with SMTP id 00721157ae682-6e22c723c93mr15767387b3.39.1727284930294;
        Wed, 25 Sep 2024 10:22:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d03d50bsm6726197b3.33.2024.09.25.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:22:09 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:22:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZvRGtnVVo0if3PH0@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>

On Wed, Sep 25, 2024 at 09:58:47AM -0700, Elijah Newren wrote:
> >          Co-authored-by: Jeff King <peff@peff.net>
> >          Signed-off-by: Jeff King <peff@peff.net>
>
> I don't even get a Helped-by for finding the cause of the pile-up of
> temporary object files and the suggested tweak to this patch?  ;-)

Oops, that is definitely an oversight. I'll add your Helped-by to the
next version (though it really should probably be a
My-bacon-was-saved-by trailer ;-)).

> >  9:  4018261366f !  8:  4b83dd05e9f csum-file.c: use fast SHA-1 implementation when available
> >     @@ Metadata
> >      Author: Taylor Blau <me@ttaylorr.com>
> >
> >       ## Commit message ##
> >     -    csum-file.c: use fast SHA-1 implementation when available
> >     +    csum-file.c: use unsafe SHA-1 implementation when available
> >
> >     -    Update hashwrite() and friends to use the fast_-variants of hashing
> >     -    functions, calling for e.g., "the_hash_algo->fast_update_fn()" instead
> >     +    Update hashwrite() and friends to use the unsafe_-variants of hashing
> >     +    functions, calling for e.g., "the_hash_algo->unsafe_update_fn()" instead
> >          of "the_hash_algo->update_fn()".
> >
> >          These callers only use the_hash_algo to produce a checksum, which we
> >          depend on for data integrity, but not for cryptographic purposes, so
> >     -    these callers are safe to use the fast (and potentially non-collision
> >     +    these callers are safe to use the unsafe (and potentially non-collision
> >          detecting) SHA-1 implementation.
>
> Is the "and potentially non-collision detecting" parenthetical comment
> still needed now that it's referred to as unsafe?  Even if we keep
> most of it, maybe we should drop the "and"?

Yeah, I think that's a good idea. Without specifying any of the new
build knobs, the "unsafe" function pointers are identical to the safe
ones, which is why I wrote "potentially" here. But I think that's a
semantic argument that is confusing at best and misleading at worst, so
I like your suggestion to make the parenthetical just read
"(non-collision detecting)".

> >     @@ Commit message
> >          , and the resulting "clone" takes 19.219 seconds of wall clock time,
> >          18.94 seconds of user time and 0.28 seconds of system time.
> >
> >     -    Compiling with OPENSSL_SHA1_FAST=1, we spend ~60% fewer instructions in
> >     -    hashwrite():
> >     +    Compiling with OPENSSL_SHA1_UNSAFE=1, we spend ~60% fewer instructions
> >     +    in hashwrite():
> >
> >              $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
> >               59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
> >
> >     -    , and generate the resulting "clone" much faster, in only 11.597 seconds
> >     +    , and generate the resulting "clone" much unsafeer, in only 11.597 seconds
>
> This fast->unsafe translation isn't so good; this one should be undone.

Oops. Great catch, thanks.

Thanks,
Taylor
