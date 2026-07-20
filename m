Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B130566F
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541142; cv=none; b=nPNIlexq459jP/kgunY1ZnFUhzDuHrmXEg7mho8v5NcSN88ilIgBtM8JyPtnXBKHU0ScCw5hh5kA1D1+Id1CyG+xsSxJ2Wq1tsyUWcbLuMw9xBzqIbiHDqmzWo5BHvnlVtqp3YveFJL2EoOXpqQpdLNWk48jYeoqVxUxnpSUd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541142; c=relaxed/simple;
	bh=w8kpbkUQ9bAz1pVqTJiuu+6c0Ql0O8ApH+ksUBELKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSc5ly+Giu3WatU10K/9IWbc3Gn+J3zyY6E7EubHzJETVnCjsBEU5zbzgyJBFM3I3nvO//s54eRBKH52WcDUS/rcFwdoZjiWHeCyKOCmnonBf86G4ekQU2EbRRXJ61Q++hGznIe1HK1Zwb6d7hr5LMkxT2VdUPGPpqcW4YusHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAkMA8PC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAkMA8PC"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso7327090a12.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784541139; x=1785145939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M2rjuvrTLBGBmrRwQfRUKTn1kAvO203h8TAZ7W9gLVM=;
        b=cAkMA8PC84QcXEgp3psvhUC+Y51l6d6ilPok1krr/zOKF4XDgV1YCxUWMKKCO4pqtf
         bdrel3yJexTnNN2vUL2hn4XuTJA8fIIh46J+wwJL9G4lDROhraRNslF6VNfP2/F6Bs/l
         GsV7fa1JYL3tWZBMbIRHq1aU0jtqMkiEXmj8aPsNyIGRW45QOQB+zZgu9G/V7MPRY4Bl
         5zeUH6RzbSvadt21SeFn1XjOXLf+6/JEdaCzLGQrRJxkzNWUqHFFd6b9nkoAOgb/RNP1
         sqOUPutyYL9pbsl5cgYBEZlANY+8440WZm4C9K2AuVPwlpqTp/TRxtVxyo1vQ4zcAnp0
         lzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541139; x=1785145939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M2rjuvrTLBGBmrRwQfRUKTn1kAvO203h8TAZ7W9gLVM=;
        b=VQdsLRBS5tesWYmZtRt2frzKTAaweAKwp7YQABEBscBzzVgabr6N6c7cveoJZG9ON3
         EYWaGAKxQO/I8YmDUwlZ3AXREKAFacCzkHE0OIKrKUfW2QoPTCcAljxd3Uiwd5fb61Lg
         7/y2RW+N4S9nR93C8OVrLCmKtfJe5MAvw8AiD/so0MeVRsKdhYMgKRyf1U954PiSgbtg
         asbtqVTOcp8ektkN2mE+Q5zR5ThxSnTrXu86BlGLBpqhRd3nVXB3EePfe1yYarAiqzWw
         virYKHLEzndvjq0Y414EN9laR6p+HDGZwY+NFjTNAWm9D2flSWhjqAx7swUQK8sODUJ/
         hWaQ==
X-Gm-Message-State: AOJu0YwaBiyO12gXT3ggITkPG0M+1s1B9jVQAQWFZM4Z977/Cyb07DiT
	kGJPXFBxXOoQGd6Lx9p7lMhdX1x9NtCSHur8X0kv83xKuLQPU9q0UtQhlxCL+g==
X-Gm-Gg: AfdE7cka4VdYWdK/g/y8UrvAFf061+X9eiwzQ7ToK5soIOoA5FgwksaJq6AyQYAemts
	LyUobtMhH3G7muhsa6yN2uWGxCERYKV/2S3nhx53Ge/zbfb192DoJkG9u1YM2PGf+OkQOOrX62/
	7J+eMmEc+VMQjsEMDu9e0RtopTBOepX2p0Ny9TgYkXLys3MNI2U5LX1ubMAkb8i6z314qcHP2/+
	lUB+hJEg09jo2gLaIaJpt1iRf9lS7Hvrik0onS7EhM0Y/+aca6KrNFXDXpeapEB56k881XOmclR
	oaszZoslFYo9ftShAmCEFzeoB7v3g9jMERta0dVVtg1THxP7tUt358QGXQpUH/lIacfLad/J8ZF
	I1pauJWG4eYfka+NVOtsm85Iwrx1ExtjgrByVyZVplmXbibG40AYcNxETnJBEAji1O1KZUH8cYx
	/sO3k6uQXoo92JU6SXHiTZ6i6q6OEU
X-Received: by 2002:a05:6402:3788:b0:69e:2ca5:53bb with SMTP id 4fb4d7f45d1cf-69e64aa1432mr4831005a12.0.1784541138733;
        Mon, 20 Jul 2026 02:52:18 -0700 (PDT)
Received: from localhost (94-21-29-149.pool.digikabel.hu. [94.21.29.149])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fef2640sm4437815a12.8.2026.07.20.02.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:52:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:52:16 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v7 2/4] read-cache: pass 'repo' to 'ce_mode_from_stat()'
Message-ID: <al3v0NVZJYS9SVZF@szeder.dev>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
 <20260717063559.1633567-3-cat@malon.dev>
 <alvNq8rXF/jofqUc@szeder.dev>
 <8b9528b8-198b-489f-8f0e-fbd0c7d07b64@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b9528b8-198b-489f-8f0e-fbd0c7d07b64@malon.dev>

On Mon, Jul 20, 2026 at 05:13:17PM +0800, Tian Yuchen wrote:
> On 7/19/26 03:02, SZEDER Gábor wrote:
> > On Fri, Jul 17, 2026 at 02:35:57PM +0800, Tian Yuchen wrote:
> > > diff --git a/read-cache.h b/read-cache.h
> > > index 043da1f1aa..94b8d3e547 100644
> > > --- a/read-cache.h
> > > +++ b/read-cache.h
> > > @@ -4,15 +4,24 @@
> > >   #include "read-cache-ll.h"
> > >   #include "object.h"
> > >   #include "pathspec.h"
> > > +#include "environment.h"
> > > -static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
> > > +/*
> > > + * Determine the appropriate index mode for a file based on its stat()
> > > + * information and the existing cache entry (if any).
> > > + *
> > > + * This function handles degradation for filesystems that lack
> > > + * symlink support or reliable executable bits.
> > > + */
> > > +static inline unsigned int ce_mode_from_stat(struct repository *repo,
> > 
> > This new parameter is not yet used in this function, which causes
> > compilation errors in all source files which include "read-cache.h"
> > when trying to build this commit using DEVELOPER=1, e.g.:

> > I think the new parameter should be marked as UNUSED in this patch,
> > and then the UNUSED should be dropped in the next, where you start
> > using the parameter.
> > 
> > > +					     const struct cache_entry *ce,
> > >   					     unsigned int mode)
> > >   {
> > >   	extern int trust_executable_bit, has_symlinks;
> > > -	if (!has_symlinks && S_ISREG(mode) &&
> > > +	if (S_ISREG(mode) && !has_symlinks &&
> > >   	    ce && S_ISLNK(ce->ce_mode))
> > >   		return ce->ce_mode;
> > > -	if (!trust_executable_bit && S_ISREG(mode)) {
> > > +	if (S_ISREG(mode) && !trust_executable_bit) {
> > >   		if (ce && S_ISREG(ce->ce_mode))
> > >   			return ce->ce_mode;
> > >   		return create_ce_mode(0666);
> > > -- 
> > > 2.43.0
> > > 
> 
> But 'USUSED' cannot be used here since the corresponding header
> (git-compat-util.h, or more specifically compat/posix.h) is not included.

UNUSED _can_ be used here, because:

  - This is a header file, so it's not supposed to be compiled on its
    own.
  - All C source files including this header file must start with
    including "git-compat-util.h", so by the time they include
    "read-cache.h", the UNUSED macro is already defined.

