Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F841CB534
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405100; cv=none; b=nZ38bDsG8H9oY3AGjPiT5eWIBPKHu3m2qVxgoA1vaj0MPP2gIWdU7Git29cvrsiAjJoW8ZEaipJO5NgvOY2DOC8YB/fuPnQqLOHk/aJcWLV4QoK3me6bcuRvcGXnrPmnlkndk/v2UMVrWaLqVrqn4uV+GgDflKf5w7XhRToQ8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405100; c=relaxed/simple;
	bh=1dJxDZhf7ahTTFodaRwDJFZsREEatAfMm6GvXwRrEAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT0V0Y8PNTT6X9KD5L/sUAyI1jWAvA6o2fRhb1k99ZbjFmog6+rg9G/UDlF6YZfrbWDpC8JRdeAdNvZd/pfkx8KEbefL4ZbXpv0CilBNoM8k1AhNNcPFHY9tVRHb7HxdEl33JplkQhPFUFPiXZyOa59rIENI5+r57f6tqLhFEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=G6aHh8ru; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="G6aHh8ru"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290d5f83bcso1337646276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730405093; x=1731009893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dJxDZhf7ahTTFodaRwDJFZsREEatAfMm6GvXwRrEAw=;
        b=G6aHh8rudTw0J89+FYSHLdk8Vn89NXfE6KgmRte8/hoCDUXrKa9W+IBinED7brxoD/
         ccI/ywhfm2zan7IT4nI4d3L8VlAgG3+Gaj2KJ0Pq3kJasug9RduD2n9YWHpoKulQXoD3
         xBn0k3kPm5+crr0NYyQgA4IkDb5iwcmsG5xXYjHuI8bxEfGqIyQsPugb5bvKoC3w0XdF
         h+PuwushxeyDb4FKd88REctQtSXA+wizfUv0+oGQ3VpltVrmGBcnjtYY1OOdpFMf2o9l
         ST3/RUbFGvuZpbLB+6Ma7P/VSrI4sKOhSxueDupNF451pJTQoA3i9xUxsNkNUvD4iLAc
         8Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405093; x=1731009893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dJxDZhf7ahTTFodaRwDJFZsREEatAfMm6GvXwRrEAw=;
        b=Tq3kLzhP1avuotDhvrNwrIzLO0Yv76h/THIy8Ss1lrai7UaaFQvjmwNyE3NDaTqB9V
         upuvk/noPltE5RVwVByBjt2YimGvEu+DgDpJtp5gy++fdXBzEHTcG2gOo38nWY6FcaSr
         nit6X0NQwlYHa18ITf7Jn1vM9MjFetBz8w3Cq7209XmT9e5e0U9yy6/Kaw6Y1N9E1Sdw
         PC5PoJAjeb2mbA3coLjpiscIWGCDaVzRHICGWE443nXPcMhwtf9SsSiYoULUiiLwBftS
         4bvBUnAab0fPivQv0Lcv+D1EWALtSiADZgJy6ZemZDT8/ySCb02ygvsAmT/YX9QoUvSJ
         JNEw==
X-Forwarded-Encrypted: i=1; AJvYcCXtSiszXkQTgA80KYWzib6Z9G0WHgJFW989dDdLZu3xmztQTTNnEKuUBZhMRIhXQQfmDt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUUH0cJRgKt3VM2NJnn7F0jv/WPdRytTxvOj/BFkALLUhuxTE
	IuNFFOQHLmHp6XLL+oI2Ns6V2NewpyInMYYdT5ejih0klTLSMeJttxCBNZHWCrA=
X-Google-Smtp-Source: AGHT+IEQmFGHfyqUaanLRWMoscyaNixK6rhb/kF+WDcQ6ubVnmdtdtRpt2bzQDEOSxl22XXJcqr56w==
X-Received: by 2002:a05:690c:6811:b0:683:37a8:cd77 with SMTP id 00721157ae682-6ea64bdd705mr16157317b3.29.1730405093327;
        Thu, 31 Oct 2024 13:04:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c8845esm3925377b3.108.2024.10.31.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:04:52 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:04:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Michael Orlitzky <michael@orlitzky.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Subject: Re: safe.directory warnings for root-owned repositories
Message-ID: <ZyPi4xdGPwfa9+ez@nand.local>
References: <ZyMGKHTnZDQ5JVuo@mertle>
 <D59QZ1P3KSNB.ZXDHUA5HGC97@pm.me>
 <ZyN03D8os53XJGDo@mertle>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyN03D8os53XJGDo@mertle>

On Thu, Oct 31, 2024 at 08:15:24AM -0400, Michael Orlitzky wrote:
> On 2024-10-31 05:38:00, Caleb White wrote:
> >
> > The dubious ownership check simply reports that the directory is owned by
> > someone other than the user running the command, with no special handling
> > for the root user. While the error might not make the most sense in this
> > context, I'm not sure that it's worth special-casing the root user
> > (really the user with id = 0 as it might not be named `root`) in the
> > implementation.
> >
> > Why would you initialize a repository as `root` in the first place?
>
> To avoid the dubious ownership warning, obviously :)

If you want to avoid the warning entirely, you can set 'safe.directory'
to "*" at the global level, and that will opt-out of the check entirely.

Of course, you should consult that portion of the git-config(1) manual
page to understand the implications of doing so, but it is something
that Git supports doing.

Thanks,
Taylor
