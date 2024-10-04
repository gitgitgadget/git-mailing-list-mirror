Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA513A416
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082036; cv=none; b=Hzy2M6pxxxDXP9ws+yyGIU9LAmCOp91SMj7LlttOmrqEqrNGb8jnj4dB9+jCBeJlmDBzQlG+nM4XxJ+rAlMljo01+0NogS1BbDu3wkbdS8bSQqerDj2BtlQLiXVdi9fgeKRbIZ5+j0PI5VeNn6iJn6xYqxuHepGh0eGpuryerdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082036; c=relaxed/simple;
	bh=c+2LOuo/wpei/dVK1+PkdrRmlVnB32CyrteQ5AJRQxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0ikv1juifv67+Ee+LKr1dkI2EWaFxgoX56YxTKTkdfv4n6CIYX/yCcDOYX8OAFGuz3rgpkPZiOVQTbQXloYkBpU5W3i0RhJdEfitjjfdEj8zONj5Nrt92W3/gcKS6UpQKZbW7I30YdisZzO2B77EH7IQgW5XS9EcqO1gg7gtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Bt2LWUAN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Bt2LWUAN"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6d6891012d5so22945877b3.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728082034; x=1728686834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrJxCXU6f3bKw8jhT7fgBGn8qqYPYXprIWi4F7CspRE=;
        b=Bt2LWUAN4YXlq/ngKi5ildXdTgFHiYy18lXRoeXjqDImF55tyTllLS6yCOOcNYvKtn
         40IBDqSCmyfU5XvbWyq5DyJ9ZKuH49uU3eGV/gRLe9JYBW4w4t1Q67JJ9Sr7/oCx4Qnj
         eudf7dP8eHg5im3eKgdGaPlbxmVGxzRKu5ALhftEIMzVd197TG1IjKpo/Du8KsqnBDEK
         pqXZyF2WewslJ8CdDyxVX4klpk3DCfCMG/9X8d5J+B0wRopi7vWZ9L2ve20dXYbOFAFL
         GHDWDvlQJjp1UOJb1f1c8TamBjcr5k/Snuzmw5HDz5EjME+TVn5P4OCJeMN9bgSUvt7U
         kG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728082034; x=1728686834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrJxCXU6f3bKw8jhT7fgBGn8qqYPYXprIWi4F7CspRE=;
        b=eajl1pAZG0nVRps6wSGG5/hYB3oneQukAOwiG/RwGYTa6NBz8VfFpyBYgsGq537opz
         EzzsAhp93USBZXNZFTg1v8cDh+lBQy92R8A7pjNWXE/jwL3Smh3yBvVpC9T9dmvVkzDS
         ZUQRm3qA7GvNmDaSLSIq8Xei9YqPoEKiiugQJgpZQ+UUqzunQ+gJy4EBjCo2yNpADvTS
         vntNdFsmb65N2X34dhqRp7yfDa6JoxLSlhqbD8F787xVod2hTrClqqEu9R7hvPdeWk5m
         k3JXmvVclM8AKeF6EpQup/1BGf6ds82k1ENYT6iUQuS+Ai/YLCJPg/6dwDKYNar8hB+T
         6DMw==
X-Forwarded-Encrypted: i=1; AJvYcCVOwcb5Jwq0YWsVE5ZtsjGJJ86DrvM/drQRu/5z2y/M1SaHvBXYNVpl3x33wty12SHuRWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZC+SC2N9zlEPVKH7dDklqjwmXRJ7y/8tF0pgPvVvg0qqdZPR
	XRQf3yffbNVJErQtPRCfvoPZse9v7MOorrjtrl51Haeo0Wb47DVsKc7YETiQMSw=
X-Google-Smtp-Source: AGHT+IFvG0bONhRsUxwwS4j5HDISTS4hfKaY0ogHA4YNXIKOVjOFYCjdgiCrySgOlqYqAXpWV5jOsQ==
X-Received: by 2002:a05:690c:4281:b0:65f:cd49:48e0 with SMTP id 00721157ae682-6e2c7296936mr35315407b3.31.1728082034412;
        Fri, 04 Oct 2024 15:47:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e5ee4sm1175687b3.126.2024.10.04.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:47:14 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:47:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwBwcOK2/sazF17B@nand.local>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwAIM6GO3VtoG3ZM@pks.im>

On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
> There are two maintainership models I can think of: either a single
> individual or a group of people would take over.
>
>   - A single individual needs funding. The ideal situation would be if
>     that funding came independent of any of the large forges. Or
>     alternatively, the big players in this context come together to all
>     pay into the same pot to fund that person. In theory, the role could
>     be elected and serve for a limited amount of time so that overall,
>     the community is in control.
>
>   - A group of individuals could take over, sharing the responsibility.
>     There would be a ton of different questions in this context: how to
>     form the group, how to balance its interests, how to distribute the
>     work across its members, how to resolve disputes, etc.

I do think there is a need to have a single individual who is ultimately
responsible for ensuring that the patches are reviewed and merged in a
timely fashion, that releases are cut on time and are high-quality, etc.

But I also think that the project benefits from having trusted
individuals who are knowledgeable about specific areas of the codebase.
The maintainer can lean and rely on those individuals to get a sanity
check of whether or not some patches are good or not. For instance, I
would imagine that Junio relies on you to help review patches in the
reftable implementation.

I think that's more or less the status-quo, and IMHO it works well from
a contributor's perspective. I would be curious if the maintainer feels
the same or not ;-).

I know that we have discussed in the past a more formalized version of
the above where individual sub-systems maintainers are listed in a
MAINTAINERS file with specific roles and responsibilities. I don't think
the project is large enough or has enough active participants to warrant
that formal of a process, but perhaps I am in the minority here.

Thanks,
Taylor
