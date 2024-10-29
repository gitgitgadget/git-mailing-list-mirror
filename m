Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEB17B402
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240194; cv=none; b=gvd0DRr7121NeDICJTsYBfhtkefRdLIunpBa00AqHW0vgpkBn/GGH9NwOVv7m/R50nbu22E8Cs/0RNGkof8IowWg1weYn3Vk7whHOZLlMceC1TyL1nu3mEsebOoEBDeQDM6M/FemBzUDgv83dRZ3M557qjq1ohxsoQaMCBYzJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240194; c=relaxed/simple;
	bh=D6q5B8bWuhgjC+JamD+23eS2nBHaPr68asmDGWlgmrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVSGrgaN763AgmGIwijXuAuBlypIY4ZTSP09YfLOTIiV5xHFepsPOFOfx51jr69wPc0Xt6SVoCBbpWN0HyaSpe3R+iUTZuVis+CBPrnSWBWkNP3sIvwTzk1yxPSid7KQCzN/NAgJkUU3Wl5A5jmvvF+vCIR/eS3qVeiCvboevZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yJHM85AB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yJHM85AB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1539faa0bso419471685a.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730240191; x=1730844991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6q5B8bWuhgjC+JamD+23eS2nBHaPr68asmDGWlgmrQ=;
        b=yJHM85AB7kZbq+Mwv4mOr7CaVZ0vxECTXC3dVeumQipl22tYVEchPmJww5Y2Fp6/Ji
         lzEhuXWFFcYh4VRRkJc1vMVOp9dzDrS8Q9OtYLLy7LYqnAyFFN5e/J8swoiHUw+RD+kT
         UYh8MqKEZfmbzaA3f1fkARdd//KSRipzTUhsFRR2l3CkewEV4S3DTFyQC3xil0FBVaVm
         NsqgXCAnozTDRto5LOAjEahOmNDkco/T9WlLUiciwAeUEsnZKedcHcdf831Pj/WFDmXL
         2uRpHz4ZbbQ0bvARMqXvBNd8GN5NnpLm6G5upXr4UY5llwDKic3O/6Qlnu7af3W0qN1I
         RhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240191; x=1730844991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6q5B8bWuhgjC+JamD+23eS2nBHaPr68asmDGWlgmrQ=;
        b=fUdYaIX+UNOXsagZ4MwuDrqs/TPKyoPBZSBDbX5Fgv54j+o9d+qQdJfY7Xm5XSY9Xd
         X7lnLwquhbpL7+Y5K0ogmCBkl7yu5BClJ2fZBRmCFuh06QoD0ku0zzXd4w7iU1R0+u+R
         6kfDgQS/EQh8DKFsFfl6jtr3eaPFowJ34VWQMbLbJxqY3FxNGp/2fdnaOjJzZLaS/RYf
         Vgy4UA7nu1CeHGjhI2t1cJJUD8GhHod+fv/0+LrtoCkAsmckHBkKIn5qGhgBw1O/WPQn
         EG8dx0LCxjSkIEGJqNmpEmOJHTvg5eVlhBC4VUZ+YIEpCkAjaNX2VJ0YHDC0LhX2TRmV
         xs1g==
X-Forwarded-Encrypted: i=1; AJvYcCVJc13VIRpclT89RLsVog1f/5c2GIDux6Q7tk30vke4D/OdSXjT0AUyRnYW2lozNwDWhsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKS/H/omJo7FcocyfJ/hHeOWvAEx8fFYCpuJQePk4xpAa1Rdv
	fGfVrzwqmejr6UQxnk3ZEtYGgoOsJmbwtd+ksunuEoDT49x+AyvIyyqFiQkCCCk=
X-Google-Smtp-Source: AGHT+IFyccoWDt1fvCfnsTysrqVSSIC1BT1TUTLi/XK9093Qt1IVY7kGDRyhHFL4zaTgjR44xWotKA==
X-Received: by 2002:a05:620a:45a4:b0:7a7:dd3a:a699 with SMTP id af79cd13be357-7b193ed72d8mr1785902985a.11.1730240190998;
        Tue, 29 Oct 2024 15:16:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27a462sm458679085a.2.2024.10.29.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:16:30 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:16:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
Message-ID: <ZyFet+Gamc8g7Hg6@nand.local>
References: <ZyEkWyB/C/lGb36b@nand.local>
 <20241029213657.1303762-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029213657.1303762-1-jonathantanmy@google.com>

On Tue, Oct 29, 2024 at 02:36:57PM -0700, Jonathan Tan wrote:
> By incompatibility, do you mean the incompatibility between bitmaps
> and the overall --path-walk feature as implemented collectively by the
> patches in Stolee's patch set? If so, I suspect that we will need a
> parallel code path that takes in the "want" and "uninteresting" commits
> and emits the list of objects (possibly before sorting the objects by
> path hash), much like in builtin/pack-objects.c, so I think there will
> be some effort involved in making the two work together.

I am not sure yet, in all honesty, because I haven't had enough time to
spend yet reviewing these patches to have anything intelligent to say.

Thanks,
Taylor
