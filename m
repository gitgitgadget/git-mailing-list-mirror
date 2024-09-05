Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815791A0737
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555878; cv=none; b=Bl8XGZ32GacyO0/avgdB4Mo+eXsRlVEW/ZIi035qbQ+miLnJC6AIaSAYwNzlE3VTs652R6Wxagd/LdSfKJy8O4VqrTKQTYWK1lf23Uy62OLo12zB0i2rWkGlbRDDiHJUn/f1860OpxfB2WxheKIVl/tuL5ZLSWgoyK+CfYUcX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555878; c=relaxed/simple;
	bh=adojKdrgpbBwbxf8GtYdltbV7eqjdCAuKEBZ8Pz/Fg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC4J3bIhryntJDXONypf22VEKy9wn72MoOZhzH9aVvr3sNHuSHoXyRb48RRQCQrmNwUGpXXZXpZ8bfKMbj0QVKMlbf95S+ptX04DVPBxVFfPB4qF3iUuBfz3z3QQRxyWoRaC4BQaoUX4j++Gwhy72VEeY9gO3Gsa0vMjv3thP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UowNE/Kv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UowNE/Kv"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e164caa76e4so1177577276.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725555876; x=1726160676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9o4rb4geFB2stinCcQpDOUtBTkTETjrrHODyknqfh9g=;
        b=UowNE/Kv74QV/HF6um6iUkvruMxL8NzlI549xtf3H+BS2Ffhgh9/IQi9OWCTpcsNeH
         uuyDotJ/pUOhOxxNFTt6+HPOO1+E/9N98wopRB9bzFOvcW/GVX1pGdoOwhVThQ7uXh2M
         DRk+zMy3BQtlV7eJz1O++DnXzI0Rvh+ZX9pUjtjevd30IhPnuBtGPgOiZ7KmPZLgX3bS
         81tbyhJQrrS772x4zxSRs0/QdpbU9BlC2ATvkIN0Snzi3o86HzCWgi8T7T4lyV97SnIQ
         QAj8i4UhJtcBimfQpUZzHD+Ui2lW/shgrEV6mKrFsAhgvKdyNbqdpHHUTrIwucRCtsng
         16lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555876; x=1726160676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o4rb4geFB2stinCcQpDOUtBTkTETjrrHODyknqfh9g=;
        b=FcQFLLBt4Uprh3GpVs+PFaJ9aKBdYr7huXfk13cnZUKpv8IuI0Ts3DScpSSmzjuEc3
         gBgwJmLfGeUBimFrzmRRf9D81y94jnViArJJ+duWO/8ZbKhzvuYNvBUa156W583DSh2F
         kqe6q8lMCqKnT5EouH/Fz1hg4Wl2eXXC/mFDg7AGEqNtDiwIoF2LRnoGtAl7byMULAlZ
         T1IglyyJYQ2AYa14Hjx8SOtKEAPeQ+k32XtOjj93xLaarh79JMLXp9s6C6Y7BIzr9X1Q
         daB0h4bqMBVmTG4c/Q5on247hVia/0XjCEznZbH3LYvPY61i32cXR+yhUQSFBo/ENfzV
         jr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+SOEiLbbfX+m/BkULfcWns5709h1DG664p66JlmxbaRfEgW4TQj8Jhtvb4l2nzqtiPW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKZ0Vy/s3VQYk48grocFAaHL812QYU8/YUkEv1Oh2Ws5XC5CM
	ud5AAzv6E8YZaNNStrWlAIHWGHSAjYdRFDwdZoDSLx0bwiVOmazOWYngzMrFxdbMoIW6tuqR6+M
	+Kzo=
X-Google-Smtp-Source: AGHT+IESzMiIvl0x1YTi37BB2LniTXAPEtEVUwaHPV3wyZp2ZR4yLSbgCV+wMzgyCDNupe7pwZDwxg==
X-Received: by 2002:a05:6902:114b:b0:e0b:1191:3cb3 with SMTP id 3f1490d57ef6-e1a7a1aebffmr21004781276.38.1725555876161;
        Thu, 05 Sep 2024 10:04:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d04181167sm1105725276.10.2024.09.05.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:04:35 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:04:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtnkovOqrJNxUtez@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
 <20240905103736.GC2556395@coredump.intra.peff.net>
 <xmqq34me5crn.fsf@gitster.g>
 <ZtnbFXL7W5DvW8UN@nand.local>
 <xmqq34me3uyz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34me3uyz.fsf@gitster.g>

On Thu, Sep 05, 2024 at 09:51:00AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > If so, I agree, but would note that this series does not yet switch
> > index-pack to use the non-collision detecting SHA-1 implementation when
> > available, so that would not be a prerequisite for merging this series.
>
> Hmph, I am confused.  It needs to be corrected in order to address
> collisions of the tail sum Peff raised, as no longer checked the
> tail sum with SHA1DC but with "fast" SHA-1.

Peff's mail supposes that we have already modified index-pack to use the
non-collision detecting SHA-1 implementation. But this series does not
do that, so I don't think we have an issue to address here.

In a hypothetical future series where we do modify index-pack to use the
_FAST SHA-1 implementation, then we would need to address the issue that
Peff raised first as a prerequisite.

Thanks,
Taylor
