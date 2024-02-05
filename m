Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC61DA52
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173302; cv=none; b=DQg6IymWo+n9TXhvDofm9iebJW7J2oBOX86Pu8Z1ILvPCqLQ0gAMr6wor2Ab0Xr2cw9gr4gObKY5q8Lm52ODBjfa+kJE2oY83c/1QAmfCqDbBBPmrUsGIz0HO5rHnFRSfaSxGY5DQuTQZuTsoXDs+6c+Jnvt2KHRq85c+sXQGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173302; c=relaxed/simple;
	bh=PRvY35L5Bdc3fJ62IYbxrCTV047Y/DvMawiQu2+iOEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcQkmeky72zcwC03l5Hiqf+1U+ch27MbReTUBEVahkhsoR7dm+dT8fbdMdNUpLkW7ta8F/hStmGv9cu6TXciX+MLc8NnJJwdBIR9El15RKZ+FmDwGyMm/nKZ1HUC2EqI+/eLqXkK4l2BI9fDoIGlYsgiNdWSfYPzcxR3Lmpx3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zistZeMx; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zistZeMx"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso2651213241.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707173300; x=1707778100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRvY35L5Bdc3fJ62IYbxrCTV047Y/DvMawiQu2+iOEk=;
        b=zistZeMxYJiE4si0Np+OQ5fDuwp0NaNBmR/Bv71yfX7G4/7k3py6/Q3bLjcsTIHNm8
         FVH854w2IZ4cbzrJBcRNefPr4DIOAzjMOOMCFr7XvsEZEKfJAcHQz+se0YwuU8nmnMJY
         mwJToIFZuW5yBxqkeW8tq56cfA1k1+DaE9yEPO3r138zinQYXvZ/0a9lML23U5cfPkC1
         uoP3Z+0CL2cwPVFxrAW8MOW9UQ2gIRfw20eLTMn9UqCODbZo+u6RBhDwUknW/9ZO5sm/
         B0+Sgfy4qwuUkPbPbHXJHqMUzSD7j7yWQducAKKjzaIjsmEiWCaVVfQwwjU0LUCdepW7
         BFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173300; x=1707778100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRvY35L5Bdc3fJ62IYbxrCTV047Y/DvMawiQu2+iOEk=;
        b=sJbm6hOEjkHnOhbgpfgoRCNROqOVW417gWfzIltvUB7d1X3atIlhXLTCJGHbapAzSx
         wyNaSUAnZeT2JwlJ63A8a+zMLWbrJXvqI6QXQYGWqgVy5HfcsEBOoLhdN14qbVA6Gwar
         sSoHEvCYqQd73UaFOP5k+1X3CWi0kxjUQB76uR9pWxq4lRhGezLrWR+pvQ69GB8pK9RD
         KoPvDNdJSg2PHxVcAOQnPDG5gyhe5UKguhjAmXR+dl3g9mANa0CKDjQ2NgoRJINiMXgi
         eufvCMrdAVcMwJ4uqoCj+Gy2SmtiNgH7VcPQ46tRFzoVo31/TvfsgQiLCPwGiOy4HVK8
         FdMg==
X-Gm-Message-State: AOJu0YxcsRcVVvGMDRUOtu4sw87XifnmG67j4YBTxYfufA/qZqaGg8xV
	DhuFM4x/yzkEER6V4ncLtC0ozMDKlJYcaVXav849/KzXtE/DpM6+JIuwhf+EJuA4c1p75KqOe5b
	/yM4=
X-Google-Smtp-Source: AGHT+IG5GWSbj/8nE0TFM2UcZ/N927lW1Wb62vCgxIIvXC3Tztz6oglQzz7btj0DHBzPM003tKiU7A==
X-Received: by 2002:a67:be16:0:b0:46d:3977:9fe9 with SMTP id x22-20020a67be16000000b0046d39779fe9mr419449vsq.30.1707173299997;
        Mon, 05 Feb 2024 14:48:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSY9lr6vUY65h6m0petb/wd9F28Jt0tXSHDH1wX9qL4Jh7fpnfNMwSJrtRuOtxbuduDzygCqVVw7gPekX8vUWPjvF1q/xX+okmGHX3+5Yhkg==
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ow8-20020a0562143f8800b0068caf901c9bsm254028qvb.17.2024.02.05.14.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:48:19 -0800 (PST)
Date: Mon, 5 Feb 2024 17:48:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: enable multi-pack reuse via
 `feature.experimental`
Message-ID: <ZcFlshJhJJIOsXqJ@nand.local>
References: <cover.1705431816.git.me@ttaylorr.com>
 <a2d0af562a5d0a4052c94f87c1d71639ff0b87f2.1705431816.git.me@ttaylorr.com>
 <ZaeCf1KCwAUCeBPy@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaeCf1KCwAUCeBPy@tanuki>

On Wed, Jan 17, 2024 at 08:32:15AM +0100, Patrick Steinhardt wrote:
> I would like to avoid cases like this by laying out a plan for when
> experimental features become the new default. It could be as simple as
> "Let's wait N releases and then mark it stable". But having something
> and documenting such a plan in our code makes it a lot more actionable
> to promote those features to become stable eventually.

Fair point. I think that these have been mostly ad-hoc. Unfortunately,
when folks leave the project or change their attention to working on a
different feature, things that were left in feature.experimental may be
forgotten about.

When this inevitably happens, it would be nice to have a written record
(either in the repository, or here on the mailing list) so that other
folks can take up the mantle and graduate those feature(s) as
appropriate.

> I know that this is not in any way specific to your patch, but I thought
> this was a good opportunity to start this discussion. If we can agree on
> my opinion then it would be great to add a comment to the experimental
> feature to explain such an exit criterion.

I don't have a ton to add here for a graduation plan other than it would
be nice to enable it eventually, likely after a few releases without any
show-stopping bug reports.

> Other than that this patch looks good to me, thanks!

Thanks again for the review!

Thanks,
Taylor
