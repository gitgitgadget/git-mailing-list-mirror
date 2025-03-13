Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3A225D6
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887148; cv=none; b=eJyQLNZg6AS0p2ubFynQSfSETj1o5XycVLfeqryThHVzK9R+8jq0JYhjc+A/YcKojM99W9vMwIHdHtp3PNzU+oqRChie0/Mz0S/cPW++2UkCIGLClDbgaV3CWaCkTxODhkW+mIudfRTK/ewopKUR41lo9jF0RJchlxF+wfbVoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887148; c=relaxed/simple;
	bh=4abdAKnYcC2SW7OFWiq5x4wO6X+4vZx2WB1/ZHfol/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEJ5sLgAsUr3Pf8lh7B61cMvAOs898wEbe27ganiRJ4SIrvjdeKWjGuBzZr23kE7mJydIj9g2LPYNzPoPe/vSdNx2Tu7r22TnfyllDumEtmYVXmgIh8cFtIktheGzWbD3V7kpihXgfUwtw4kCACaVEJe/UBh6nC3sWMSJzWlJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TBnQGEVt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TBnQGEVt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c554d7dc2aso184449785a.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741887145; x=1742491945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igtxrGL86lefcfDN/8hIbvOlBxW/raIWLgrjfBhXSy8=;
        b=TBnQGEVthhbwLiHlYHo03hfMwdwqK20wm1h1LGnpHquZy0WAEJBHIlSu0DQ8HWSCGM
         cluBvLIznpDeTxdwXYx7xIXMplSMlMcFM73PL5JeTq9fjnTWF5sLjpg9OwBbaakTWch/
         Q2/G8YVGK4lzc6OWUV8IYgr+r4BzeDkaVJ6rPyXp7Q/X5Llhphjod5v417NkiHPyC6vw
         4lDsb+WJau1EQCrTSVKhavF0hUIUJAOgr6h2eJawKaxsFWT6EAbH7m9qZ0UmGCnhLMwQ
         kPI8/QpzbBETv7kLW+/oIxFBzCWaVHmnRc2NwQRE1BTBPTgCSN6SQ8jHavrqYGXlbTj+
         f+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887145; x=1742491945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igtxrGL86lefcfDN/8hIbvOlBxW/raIWLgrjfBhXSy8=;
        b=t9aUon/QTI6WK3yZrnWG0q82IgM/8hoaINY4zWIORUmzJYrCcPNlVVBXu/j+c8dVsl
         HBn0ayfiP3ODbFKm+bPLBsR1VLTO+oRIJ75RFtpfzx2LCn55CahbFJijeZOdaXVaKDI/
         HSIEBMMdamUwOXlisbtQX+3aPoTKqH/CkIhHaOgxJ76im2dbhvRUWl87P9cmEE96ybar
         JvTAaE+47Qk+cIru09Tb/qhTQBLUWGqfrT9qxFQShlMXu0AhuwZq7lrsja8nhSnDXtbd
         Dn+86ehQISn3QInPTtgWPGPXqL7VfUbI2i4rwHRdFotU/CildeHoJ1DV3wW5n3IOGlYs
         SJOw==
X-Gm-Message-State: AOJu0Yw92TUc0eo8k48PbOP064QUg8IVdz9Z1Xnnbgb0NC0RAYsCt4ep
	tv7JBtz5Lei1yKhsLV2MlB+wIfMyRGqIi0peMokHhvFhfpbV9ISnp96Mn/AdQ80=
X-Gm-Gg: ASbGncuuyKRY1ZGLsTLPs1KX/dexwaOqg/llbakPOtCBRzPhOA0i1aRS/lGBW90ahhA
	4U45S36rk8fe2cIePePWSF60nQhSPOZa4Y878HLkheuRBu2BphCBxc524ZVhAZbtCqu4b2pIGYB
	9guy1hyjmNkNZNrFxhu8qyCuGh7TWtB4Qz75+Bnx3Ni+koD+5YxoNYpZklSm67NrroqStiGqpu5
	JeFItBVZMoDi6ItcHyxQ6EbzaHJ/jBXXdkaEmZoTNjTKTcr8YLXdeGHIJcihxqenkohIXP+jrNI
	CFuI80gmTO9bqdts7Va2mXz2VLHmoSV0WQx1zrxgCDAJuu3LSMq6ZGI3AFCm8uErAH8AwnsK/MO
	K2pbqm8RERd+nYQNY
X-Google-Smtp-Source: AGHT+IE6M5Vbww84MwqKLfrZ2s6C/+QIGIcVO94+5xTwGEHeccqxXLzGnkgvgzZan2kYKms7B7JVug==
X-Received: by 2002:a05:620a:2696:b0:7c5:592c:c26 with SMTP id af79cd13be357-7c579eead02mr79821085a.19.1741887144951;
        Thu, 13 Mar 2025 10:32:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fb8fsm123662685a.72.2025.03.13.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:32:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:32:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/1] builtin/pack-objects.c: freshen objects from
 existing cruft packs
Message-ID: <Z9MWp6+TqwD+LdxE@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741133712.git.me@ttaylorr.com>
 <6e93471f9a8e6a3dde36342088748ba17e4f7f95.1741133712.git.me@ttaylorr.com>
 <Z8l5hxNjEOALl_g-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8l5hxNjEOALl_g-@pks.im>

On Thu, Mar 06, 2025 at 11:31:35AM +0100, Patrick Steinhardt wrote:
> Minor nit: it is a bit unusual that a negative value, which typically
> indicates an error, is used as a boolean value here to indicate that we
> don't want to have the object.

This matches the convention of the other "do we want this object?"
functions, where returning -1 indicates that we don't yet know whether
or not we want the object, and should continue looking elsewhere.

Returning -1 from 'want_cruft_object_mtime()' doesn't mean that we can
necessarily return -1 immediately from its caller in
'want_found_object()' because we might pick it up from further down in
that function or in one of its callers.

So I think the return values of that function are consistent. Because
that function never says "yes, I want this object" and only "no" or
"maybe", we could return 0/1 indicating "no" or "maybe". But that feels
like a bug waiting to happen if someone later on mistakes "1" (which in
this hypothetical would mean "maybe") as "yes".

> > diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> > index 959e6e26488..f427150de5b 100755
> > --- a/t/t7704-repack-cruft.sh
> > +++ b/t/t7704-repack-cruft.sh
> > @@ -304,6 +304,69 @@ test_expect_success '--max-cruft-size with freshened objects (packed)' '
> >  	)
> >  '
> >
> > +test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
> > +	git init max-cruft-size-threshold &&
>
> Let's also delete the repository via `test_when_finished`.

Eh. The point of naming these uniquely is that we don't have to remember
to clean them up afterwords, but I can do so if you want.

Thanks,
Taylor
