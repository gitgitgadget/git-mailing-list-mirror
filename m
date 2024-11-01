Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA71A7AF7
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471819; cv=none; b=qFVmcrxEaQwU8JysjZDluCTDtvpyes6ytpMRjYRoNkT2sfDZ0B4QWi7OInIOwJD0vtEmYwXX5TOq/DeIQkbQMJbtjiWMzeSqMMG9cYg2vf7gXNdtZuslCRC0ZFHTpFhVo7LbwPnKt5Bz5MHhZ3PWQRGZKoj7+gtBTKAs5+WguL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471819; c=relaxed/simple;
	bh=c+UydtTTIR1uVqXPPRqrE+vFJpFxthD7MAtOqu7gzoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/xcoPESudEcBCREe24ZhF2fRkCyxOluhEDCg4lxDH68C33tolbbUFRY6fvyhBHpZtvi43X69kKQv9GtN+0VHOz8rrTJ7h7AYsEDuN0HjSTpifrmSS+lz8PdGZ9MVWv3MwmiXfOaJPo3YzUzSOYjBCA02M9TF6Pe3Ha1E9sMG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qIIvWakv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qIIvWakv"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34339d41bso18176127b3.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730471816; x=1731076616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=05KSXYaoUDpWXni7T1Jh/zjIZOUDlAH8j7GEmVvjo8s=;
        b=qIIvWakvjlGcn7FH+IWmDUeb20orLHwWv2eZXX/t+p/OEIGiDlUT4UOEzkwGWlpQ83
         lLzF6cXkvrcGkop7gtLSzGPnNBB++6sQp4Wt3CT8M2Wz3cY40cx2CPI0gnS0sPjw83O2
         rfghEq81R/OncCgSQES0fAR1r2SiQMKvfOK7x5mwsMBxchiQswcuPev4A8OGAW55P8JH
         qSOX2wXi/0tsKwZ7afJ6NuHd8YQVBBs5yE8m7IuFSu6AeJWDTIdoHcSo4S1lWEv0gvF5
         5sQhLaZbeSwA1Cbzn21PB8REyzea9J4isWMPLqwpjr/oskuMDLK84SvKV7HHwR6DxQND
         ymKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471816; x=1731076616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05KSXYaoUDpWXni7T1Jh/zjIZOUDlAH8j7GEmVvjo8s=;
        b=cjuIN9mpPHkP91VEYLYvfAhf3pzNGGradP4LxhDxAU3Jqt+NJ7iw2xwqNsr9YupavS
         G5Dty82SJeqnmcOUBID/ORVDR9wM1AfpEf5+QQHf6kkOqBBNoZaAw/URDTGDD7NYVZVw
         COEyUDZsur/ECrkqgdF1Wt0sHpvY7umR25szGwLMwSRnWXl21WQ6/J1/0Gi/393yUUon
         xHyvN8wdj1aCj2YqJXauiJa1RYigb8pjAku9J3NHeu6MPOGl/3BUK8o48qcBTEZZuX9j
         ccz42FvPtqEUFP0kP+EOBUsHLl8moHEwv/yyyvDBvNdIEpCkVA3jmzIT/BtGqttPqNIZ
         4oHg==
X-Gm-Message-State: AOJu0Yx3MalRcIi9J6G90qjl7u0I3A1rfdDCJDstvVruDRvJAT2VXx3q
	6Ih1QKaOlBc80UYlIBeERiOl1Eojo7DT3tuKVYSt/cNUjxNxfmK/oljCK+XXeaDONdVZheOgcUW
	y/qw=
X-Google-Smtp-Source: AGHT+IEx6CboZYtKI57LYOVzDSVzuNJqoXqL3qxIDD931aSitL/Byxf155b6LdlfypSx8T4qq7HgpA==
X-Received: by 2002:a05:690c:2906:b0:6dd:bba1:b86d with SMTP id 00721157ae682-6e9d8939dbbmr175341227b3.10.1730471816147;
        Fri, 01 Nov 2024 07:36:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c4de6csm6999087b3.77.2024.11.01.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:36:55 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:36:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <ZyTnhrBLuvesK1yB@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1730366765.git.karthik.188@gmail.com>
 <ZyPjJKYZzeFGLxin@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyPjJKYZzeFGLxin@nand.local>

On Thu, Oct 31, 2024 at 04:05:56PM -0400, Taylor Blau wrote:
> Hi Karthik,
>
> On Thu, Oct 31, 2024 at 10:39:43AM +0100, Karthik Nayak wrote:
> > Range-diff against v3:
>
> Skimming the range-diff, this new version looks good to me. It would be
> nice to hear from another reviewer or two before we start merging it
> down, but I think that this is looking good to me.

Hmmph. I spoke too soon, this new version appears to break CI on
Windows, and thus broke the builds of 'jch' (and 'seen', by extension).

    https://github.com/ttaylorr/git/actions/runs/11602969593/job/32309061019

Can you have a look?

In the meantime, I'm going to move this out of 'jch' to let CI run there
again.

Thanks,
Taylor
