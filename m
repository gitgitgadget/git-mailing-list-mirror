Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5C1D7E2B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392587; cv=none; b=KUzwJwcEXXnWCnAizfPfW3AHTRnjWZRyuL8nRl7VUoJy7BFRdtDh2GDxFQz7tbkB6pGbwW1maVBjTPpqsZPUW5c+cF16YT+WiAfi3bD0BvjUOGq08XZt3AacA5GiA2HaXUnBZe/Ng0P7ABw6GtWxQuTX1O2j3GwZkCibu7D/v/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392587; c=relaxed/simple;
	bh=b/Evwa8efVbDFlN2fFDuk5HNMOgQlyKDZjnhNUBV45w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDZOLeAQTbAjw3Obi8ew/aRBLUazT9LYVuzYwbtqdB7Of6g90LcZJbuCq1ofZnx64s5lOmicdvsVk0pfNMWTgVl2lwBNTG3YyhOFNO8tl2I5IyvNvazTAJ+P9seR8teCq+5WqRz3UM0kqsknBrNyh5FBwdpFgOFWU1sA7g7yIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=s+ubP81H; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="s+ubP81H"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso6001820276.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725392585; x=1725997385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwoh3AeGzpCOdYPCWVITqSW+KlmmbF4NEp2UZ8liJSI=;
        b=s+ubP81H7mCgVbMgiLpkEv4mHGcGZ5VIhwPJoTMaQ3Q+KvqR15YJuHmSCnkwVaOOi7
         SDeuhGnuEXij/tmoJKDqTdAn9jQiqhjZfHT9/BzWJC5ZWSE/0fUBybMhMXFBOi88isZy
         spru60MdhT9uBfD2uEtXlFf5K19zEcdGKQmqaZvvWz2b+Uq3B3vkhU/Ed9ifLWSp3DUj
         DJTPEMgGSyDWBr2+JVc17EU/8BdHGglWGOrhPnShqlmeH2rvNDn1Q0aTXKTFzo9G5RUn
         ytPlI+fy+lhRqnvdNiNqAqPfDcqarmlIsW2egqsBJt6ENIWb3kxrFp6Z3I2+fQwRcjwl
         M92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392585; x=1725997385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwoh3AeGzpCOdYPCWVITqSW+KlmmbF4NEp2UZ8liJSI=;
        b=jnkuSCfdukN9i8y9TmJ3C6UR82VWy6cuhUUCNwBcocUx8SBJixyoM0V+gnuj1pssO3
         Ax3yUmUw23SlI9XV8dWI6xWVmbnnwnXSPFYeciSo6/D526DqmOjYEmRlyuncJXryGHll
         00kT2loSZyLZfSrVE2EK1i+u/5B4H79CIkDwd4k4JXwcwQZjCYxsc/x+GA2wwIhEgDHI
         Q0cMg5HS+XzVRbP8yEY9Y0mvEv1BEs6O3iXjdzdp/7cd0r//M3er7pdm/7vggxYeAjtj
         yzNQCUku4GGWc5pb2mRw4yR8RaKRUUxwrPqh6lHqA3KRl9BT6/Jc7v61YifWqYjaMo6k
         Ruvw==
X-Gm-Message-State: AOJu0YwW9DO3wCjON9kegKWoP6pMsYulq1n94diRPvNHrg5MzXcLR/cU
	kvJXq3aKEKUIiEVmSEZsY8rTsryxFh6Lwt/FgAcAIzO0zo13vG5CA4vq5XDYT94=
X-Google-Smtp-Source: AGHT+IGxp9XccH1qofvsc4ePZOer2VOVJ4uGJPrSOxlq3rssnHukN2ueMGc80xesnGuPaLMpbWd5cw==
X-Received: by 2002:a05:6902:2601:b0:e1a:b102:47f0 with SMTP id 3f1490d57ef6-e1ab1024a76mr8921787276.41.1725392584792;
        Tue, 03 Sep 2024 12:43:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1cf1ac2a4csm559842276.12.2024.09.03.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:43:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <Ztdmx6UD0XYcv/BP@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <682e4c2cc3581c72262ea6a9b488a246fc6fde28.1725206584.git.me@ttaylorr.com>
 <ZtXAiIwLgtQNkwyH@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXAiIwLgtQNkwyH@tanuki>

On Mon, Sep 02, 2024 at 03:41:28PM +0200, Patrick Steinhardt wrote:
> > +endif
> > +endif
> > +endif
> > +endif
> > +
>
> What a cascade of `endif`s :)

Heh, indeed. These are copy/pasted from the hunk below this one, so
nothing new here.

> Do we also want to wire up support in config.mak.uname such that the
> fast variants are default-enabled? Or is there a good reason to not do
> that?

I thought that I might consider doing that in a separate series, if at
all. I would like have users opt-in to the new behavior rather than
imposing any change on them in this series.

> > diff --git a/hash.h b/hash.h
> > index f255e5c1e8a..450e579b405 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -15,6 +15,31 @@
> >  #include "block-sha1/sha1.h"
> >  #endif
> >
> > +#if defined(SHA1_APPLE_FAST)
> > +#include <CommonCrypto/CommonDigest.h>
> > +#define platform_SHA_CTX_fast CC_SHA1_CTX
> > +#define platform_SHA1_Init_fast CC_SHA1_Init
> > +#define platform_SHA1_Update_fast CC_SHA1_Update
> > +#define platform_SHA1_Final_fast CC_SHA1_Final
> > +#elif defined(SHA1_OPENSSL_FAST)
> > +#  include <openssl/sha.h>
> > +#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
> > +#    define SHA1_NEEDS_CLONE_HELPER_FAST
> > +#    include "sha1/openssl.h"
> > +#  endif
> > +#  define platform_SHA_CTX_fast openssl_SHA1_CTX
> > +#  define platform_SHA1_Init_fast openssl_SHA1_Init
> > +#  define platform_SHA1_Clone_fast openssl_SHA1_Clone
> > +#  define platform_SHA1_Update_fast openssl_SHA1_Update
> > +#  define platform_SHA1_Final_fast openssl_SHA1_Final
> > +#elif defined(SHA1_BLK_FAST)
> > +#include "block-sha1/sha1.h"
> > +#define platform_SHA_CTX_fast blk_SHA_CTX
> > +#define platform_SHA1_Init_fast blk_SHA1_Init
> > +#define platform_SHA1_Update_fast blk_SHA1_Update
> > +#define platform_SHA1_Final_fast blk_SHA1_Final
> > +#endif
> > +
> >  #if defined(SHA256_NETTLE)
> >  #include "sha256/nettle.h"
> >  #elif defined(SHA256_GCRYPT)
>
> Curiously, some of the nested statements here are indented whereas
> others aren't. We should aim to make that consistent.

Sure, this one was also copy/pasted from the block above, but I'll
adjust the new one accordingly.

Thanks,
Taylor
