Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B04087C
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544560; cv=none; b=dtFEuFgeCFOM09qNFs21yFjWcEgO/jfrGXbq7Y8m/5Y0WriRAsr3iDlLUGqhBP8ALwldLwOw4fNuUc/AfortSA8/36OgUjDbSFUIk/3VdEnD5HumOj4XbDvL8FqnfqyNxZQwgTQrfEiovt0bSNgwARAH78SxHmbQ+49hnrkpS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544560; c=relaxed/simple;
	bh=A2Qjws7PFke2WKAOk5ZkuZ27FO6zttNPysp4bs2Pdfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7yVG2f00NglWDIC65+f750x40zt6K3fdxVr6XZs4aDylTbozsQcZqI/267daYbq3hRcLldWqm+SBzG7z3+20vvAW9ffdjVce/pcXG1/2vevRso3/ukva1Osji0sRdKlRKAShEno7Jt3ge8s5tTNA+Zt4FKvCNNRXrBL2RyOaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=akVkhhFT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="akVkhhFT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b797234b09so23504096d6.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722544558; x=1723149358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yff92fXIv5LlljXw469JYALnSQpQtyrrRbnirz/z6CM=;
        b=akVkhhFTSDNv3bso+AfJOPRGQN5hggo5bl01yIuAbXcSxcGcXRm2assAt9yVq1GQ9a
         mwcz0wH8Vi1Cl53MgIcoRs+0fCvwjihqC3KNh/jcRFdK5A9v14sAxNIFPvRh++RzZQ+b
         hc1xgeaZBJSq5Q8uoUEPU8c4WQB/D/1n/+3DvvhKKRrCq2a/P6l8SiF8A0SQorNIVfxu
         Q7QEoHHelCgPe7j/6NwNIqETz7PH0GzscQAaVMzeFQUN8AuluZ9YjcFb1Izm3I4Wxe50
         JLA4KsYwMi6UvtuMc1oE/zoxyo7egR2CrPGwTiSvmICnTcmml5vNFqOVOfdh/P1kp5oF
         PZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544558; x=1723149358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yff92fXIv5LlljXw469JYALnSQpQtyrrRbnirz/z6CM=;
        b=trOkuFxJkCX5HZvFivebxhlRd49cDbRb0hlh2pay6DBs/mgmJYWWHWAMa+NyOwlbx6
         uDGEpQrNHGHT6wYA773ECxr62HZ57F0Ro1BNwU22d4ZMIKQeRbS1J4YlsyhJVmLt+wKS
         vgPTu+T8whSpiGYfN+eknFZANrl/9pWEOP6Jr2pmDh6A1DDqAojdvoL8Ez8HpABt6Ggz
         gqNVEeaFQGJVKdkuxm+jqQVFEZ8OLItHMeIr/cEzX7ZhrDRaS/qhvEGAhmvNjtYtyL9C
         jqco96wLEZTubE0UB/XakaFAOA+/mz4Tg4I+LRGzxa3jGIfN/3JtbLmalwH4/2Ip2Soy
         PTdw==
X-Gm-Message-State: AOJu0YyBnDQ4ffHbbpaIn9Jsdwlek9oGrhjqxOLVX+a3x8dnZhYt2T3Y
	sBJijlASk+JvwQ6HwhsJ3pvRwsBNDrH1WY3n026wVsLiFe9hhLh9kOTBd9VyhSnjsHyZkO3TxZU
	B
X-Google-Smtp-Source: AGHT+IGL7tV9rMx62/Z+Gyvt+Dof/KN8xdydZXVVsau2muWLQpGn6yyVMQ1u0oLeth3wH1ZzFr679w==
X-Received: by 2002:a05:6214:498c:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6bb986e9ea3mr24290756d6.13.1722544558056;
        Thu, 01 Aug 2024 13:35:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b7d04sm364216d6.68.2024.08.01.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:35:57 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:35:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] midx: support reading incremental MIDX chains
Message-ID: <ZqvxrH9x6hMN6hjf@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <dad130799c0d41d14375539bb12978e37849a721.1721250704.git.me@ttaylorr.com>
 <20240801104026.GO1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801104026.GO1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:40:26AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:12:41PM -0400, Taylor Blau wrote:
>
> > Now that the MIDX machinery's internals have been taught to understand
> > incremental MIDXs over the previous handful of commits, the MIDX
> > machinery itself can begin reading incremental MIDXs.
> >
> > (Note that while the on-disk format for incremental MIDXs has been
> > defined, the writing end has not been implemented. This will take place
> > in the commit after next.)
> >
> > The core of this change involves following the order specified in the
> > MIDX chain and opening up MIDXs in the chain one-by-one, adding them to
> > the previous layer's `->base_midx` pointer at each step.
>
> This makes it sound like reading a chain file of:
>
>   multi-pack-index-$H1.midx
>   multi-pack-index-$H2.midx
>   multi-pack-index-$H3.midx
>
> will have H1's base_midx pointing to H2. But the design document from
> the first patch made me think it went the other way (H1 is the oldest
> midx, then H2, then H3). For many things the ordering doesn't matter,
> but I'd think the pseudo-pack order would go from the root of the
> base_midx walk to the tip. That is, the base_midx pointers go in reverse
> chronological order.
>
> Looking at the code, I think it's doing what I expect. Not sure if I'm
> mis-reading what you wrote above, or if it's wrong.

The patch message is just plain wrong here. I switched the sentence
beginning with "The core of this change involves [...]" to add "in
reverse" to clarify what's going on here.

> > [...]
>
> The code itself all looked reasonable. There are a scary number of spots
> where we have to do global/local position conversion. It's hard to know
> if you got them all.

Agreed. If you have ideas to make it less scary, do let me know ;-).

Thanks,
Taylor
