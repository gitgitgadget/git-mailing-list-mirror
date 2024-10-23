Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6314B077
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714623; cv=none; b=G13Eyxuv7uC3d/+Z26M8+zhxmdJRVe1pHYrgDbJ4PgzLffSMgvms10gr7G0ZqHYqNYJouTdoza3MQWKzQm9/ZOj5EQ5lcF50B1V5OaQNELExeaqrewOUSmGguQ5NNI+buOfHQUz3rfiyIE/LG+5oVM5+OEXpJgiahzAE6EmQmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714623; c=relaxed/simple;
	bh=1oexfcTHhgG95ZfbY2cChowJegQrKRtYv46EH0WqeGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnHMHWPV8t+wpYsIdH+OtleyfVUYCqXVDQD4v2iXlWUydM9RdRC3+WDIgefGP3vG2gSHa+zxcHkeYzfKBy7c/6J7VznL7dW7SrZZ3h5wRw0XLXmR5F9+fvxfvEZ+xoT9hw86/iLY188HcedzH9pxtf41G0+dXgzzhMOShq2MGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=D+a/6m9o; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="D+a/6m9o"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e35fb3792eso1465337b3.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714620; x=1730319420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf1R1OYuXz/eJXkThT1I3MlwI225+nXn6WROczY7WuI=;
        b=D+a/6m9ozYsgjTeu6S5EnWyezfAvLf1CaP6bvlPoQlKpnhoYzjYcEGetDTJ1vxBITV
         DjDqkRAMy3Q+ah9WLung0920z06/MQATw7GNnL0Zx8jexB498UrXQ7nITC0WyPZoOj9v
         MIhK7mJP8VFOv2MnJYkLByXslPRaxONraOxz6XPmfjg0zK62gLuNUl0hIb5QbnsBdx8U
         D/PUER79uZasgiDNuXPaxGzkejzCfDh3B0EmaFJLOiugbQO++4ugh0ncX+gtWiQ13iHx
         EVbV1wCY7EgaEwiNZUFsYIu11shJL1ddABR8l9hS+ucaJPyw7OItdtcVb7MsS1YhgmYU
         TFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714620; x=1730319420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf1R1OYuXz/eJXkThT1I3MlwI225+nXn6WROczY7WuI=;
        b=l3WTKltntWLcCtxj3jjTe3m7ZkjFunXryVK4pH2H7W5HzhKPCPiHSaoxReVi7z1t3L
         zAtSQZZ37DASPEe6YRwXVODGKM7gN7AfK3Cx161mF4nSyZ6P7jepJX4ibHp1BHmQPhlF
         lpXmRCCy+lSDlaJmedvgR4cs3cZ9FV6tNkkRipThtkrLNzaa/gmIcxnK17FGhIt0w+v/
         M5ETHrLmF3Va5msHccp/d0BiNl8WjZvudMfAcWbKB3rNnPfhdB+71kQz9eJi1azSnyRk
         Tgi7PbBmvCduXhbZXXy7eXaYCnoC82QohKV8LA9zlVv7WDc5B9YDjY1C677SIlZAvhSl
         cpfg==
X-Gm-Message-State: AOJu0Yzs+xgE4wIMm2tS9KN7dZ9f/njQ6tOokpEAHMGanPjY9zdIzRqJ
	RfIPAeeuU1HfuqxrwLmSni5EBiWcDGs/A8/h+9JvApPmDHgrd46B6Lhcj6t5FBoxa+oOkCHhihZ
	3xyw=
X-Google-Smtp-Source: AGHT+IHvhVwsxLZTgySDNb5FPl9UNbTiROhrodAV0Uch5PUNPzqlCjoos+RxXljqZrp41g1j5zSeag==
X-Received: by 2002:a05:690c:fc6:b0:6e7:e76e:5852 with SMTP id 00721157ae682-6e7f0fa4112mr47680797b3.32.1729714620581;
        Wed, 23 Oct 2024 13:17:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f9ebsm16597117b3.144.2024.10.23.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:17:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:16:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Update versions of libcurl and Perl
Message-ID: <ZxlZuxllqjAZfAZm@nand.local>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>

On Wed, Oct 23, 2024 at 12:45:48AM +0000, brian m. carlson wrote:
> brian m. carlson (12):
>   git-curl-compat: remove check for curl 7.21.5
>   git-curl-compat: remove check for curl 7.25.0
>   git-curl-compat: remove check for curl 7.34.0
>   git-curl-compat: remove check for curl 7.39.0
>   git-curl-compat: remove check for curl 7.43.0
>   git-curl-compat: remove check for curl 7.44.0
>   git-curl-compat: remove check for curl 7.52.0
>   git-curl-compat: remove check for curl 7.53.0
>   git-curl-compat: remove check for curl 7.56.0
>   INSTALL: document requirement for libcurl 7.61.0
>   Require Perl 5.26.0
>   gitweb: make use of s///r

Thanks, queued.

Thanks,
Taylor
