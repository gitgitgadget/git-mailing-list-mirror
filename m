Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADE26E164
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952318; cv=none; b=lw3eyMquklQnWGuB7+yq4vHE8znAhGBzvmXIln5NROSLXFA4LmIUXqjhspdqkmjUNOYrniOWK11w2oZPcuSyBNXAjuEF8db9SLO99Yg876wFMPKGvhloOYLAB9rVQo7pr2AqlBAgxlYUMF6vU3dzckg3KMPN9/Qvchk8GrFpOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952318; c=relaxed/simple;
	bh=xJfWbmARrsl+AoIobNBtYlv665wDlEi0xsh7Aox6T7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX55jGmI17Ai3oahZRW+6XQcx5/7WLapHIE850CAjHjTOssqSplyqdAgDlETVoCQ6KtDCD+b1ROBowu84uSFxyhiFOdXIK5syx7Qa/gn9Yezfhh+dShPgUfWBraBpXDPV/pLyyofiwDdLe3F3Wat6dOgkZ9GUXp+Ymjd9mMwkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPEJr/tS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPEJr/tS"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2da14a6f89aso2762007fac.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747952316; x=1748557116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bwZuzHYiZ/BogGmmyNB2HJttRJUqcgvnF/LXfpg0kU=;
        b=bPEJr/tS57T7Mh+vetM2ktbuIKEAL1SdEHz5NHGXHJIJsQUBH+VzI/34XMtypngSpi
         WVmFtM8QgSmJMLiky82Qq5B7PYL8Nh+Bn9mcNKeSDKXIzKAYcLr1SGX3p8AIGM7Yqzi+
         +QT8jF7FVLcSbI9ctpzFbrhdhzIbQ4U+L5bMOeKvWbHppjjFgjm0LBFFF2doyzugOgMu
         nLQH8sHKvQz8Pcdqvolp5+rvw+lKExN5RX6ZdmrhLm3qVRCxGqHOUIF0FB2WxlIQG/1I
         GOwKU/8SNdA0rbheEfLE63gwffQdNYkJqutNkO+JejJuZ85Bt8fQp+O5s6ufYpAfJfyl
         fjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952316; x=1748557116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bwZuzHYiZ/BogGmmyNB2HJttRJUqcgvnF/LXfpg0kU=;
        b=bO3iB+S2AWIKG8pH8QShHQRO4JD1brlW/SLOxykTEXEIrytHkh7HvG82yL7vdfI9aw
         T/aNxW+8TCmqRVbkrB+kuvjqolZKe0r4X+vnjoLJ7jif4rXUWiqeErKi0jTmHCvaNUis
         HhBWlV8rHunYBnYeiMduNc0SQOqg+xzCfDG+8Myt9q0Oxh/LWYj82DpFaUX6HezRwB6Q
         olkVBHw21n/YGAj4ySom/Hgdwq/cy6OFYzFZnYY8ElWFtAcNVcqcKzS2sMn2oyq5XgCr
         qY6BVQzYLWUMfB4bioOUHDCwbEvs9ZEjSup3TI2BvtQ/OsoWqpOcCsLf9n5CjAYo38HM
         uQjg==
X-Gm-Message-State: AOJu0Yy0vuLI8CtgphuiG6MeMJxnTBoNFyPkFHT5/1Dzj/ZlNjIp+Ngj
	2FLpwCSjqnL9skSXdFo1qtNxei88MSvSV66bfUPJ88CimQX5fGY9P0iH
X-Gm-Gg: ASbGnctg9Xk8YrE4NbGOpXOieW5PDF9cERarFKgzXJZnmrzdq2cJ/b2qoYLGdh8znIm
	5zo87vanDuP+5IxHriZZNSFYEAiTOO7EqaVCc06cWOD8Axd5weC1oKd/b+9uU2JF9+qJmZrYrB5
	PEb+i1NSkeENSFRrhzq7HNXEtxhdeDUk0hsswDdfQk7WgLHDihOrncINjHuwDfMgF3n8ps7H8LZ
	p1NhZVlZ6xrq9h/Vb83TTyQBENjJh9bCOMkC7hKM6vNq4grF1CzsdYyW6V/HOyam69ldo/sPTtt
	IHCEEdTC7js7YJH1S5OoVrHqMytwtpn6BEAYHMGpflmN
X-Google-Smtp-Source: AGHT+IG0akQ4jFOsAnKFqnIuWbVFqbq08C0QDWDwpucacRQKFfiSjNXn9MGbiNx/w1w43zoXr9juUg==
X-Received: by 2002:a05:6870:2484:b0:2d5:a360:7df9 with SMTP id 586e51a60fabf-2e3c1b67803mr17113096fac.5.1747952315975;
        Thu, 22 May 2025 15:18:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c0609a43sm3248799fac.6.2025.05.22.15.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:18:35 -0700 (PDT)
Date: Thu, 22 May 2025 17:13:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>

On 25/05/14 07:12AM, Patrick Steinhardt wrote:
> The `object_directory` structure is used as an access point for a single
> object directory like ".git/objects". While the structure isn't yet
> fully self-contained, the intent is for it to eventually contain all
> information required to access objects in one specific location.
> 
> While the name "object directory" is a good fit for now, this will
> change over time as we continue with the agenda to make pluggable object
> databases a thing. Eventually, objects may not be accessed via any kind
> of directory at all anymore, but they could instead be backed by any
> kind of durable storage mechanism. While it seems quite far-fetched for
> now, it is thinkable that eventually this might even be some form of a
> database, for example.
> 
> As such, the current name of this structure will become worse over time
> as we evolve into the direction of pluggable ODBs. Immediate next steps
> will start to carve out proper self-contained object directories, which
> requires us to pass in these object directories as parameters. Based on
> our modern naming schema this means that those functions should then be
> named after their subsystem, which means that we would start to bake the
> current name into the codebase more and more.
> 
> Let's preempt this by renaming the structure to `odb_alternate` now
> already. This name is agnostic of how exactly objects are stored while
> still specifically pinpointing that this is about an alternate object
> database. Furthermore, it is already used in Git to represent this
> context -- the only stretch is that the primary object directory is now
> the primary alternate.

I know the naming here has been discussed in other threads, but
`odb_alternate` doesn't feel quite right to me. When I think of an
object database alternate, I think of the additional object sources that
may be configured for a repository.

From my understanding, the `odb_alternate` here applies to any object
source, even the main one. Using "alternate" makes me think there is
another object database somewhere which may be confusing in scenarios
where there would only be one.

Ultimately I don't want to bikeshed too much on names, but wanted to
voice my thoughts. As an alternative to "alternate", maybe we could do
`object_source`? :)

> In the future, this change allows us to easily introduce for example a
> `odb_files_alternate` and other format-specific implementations.

I look forward to seeing this. The patch itself looks good.

-Justin
