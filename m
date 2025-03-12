Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D791E2614
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815909; cv=none; b=uSRM7c7Ptq6k+LXVcIUidRhctLsIE4hvLTI53XKMT4ln1fhRJD0zINzh53Bn6ah1nvlvvlzczh9CKUzcNO/PfSV8pQb5zEchB3k0YlMNf5UXQZIKeDNg8h9cw+x//iOXKWMLGCuDTJiFvcwhoGnQQhGc2QId6Gtf/b2NBh4150Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815909; c=relaxed/simple;
	bh=00QAksC8F03WxwbG/xdM7Tunzk80+IZxc4SvdrvCEas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmFGMvY/si4kyrDABFQcCf/AVox8yp6dOq4Si3+BY/Xcdvx+SiCvcOYz0HqxTQy/Hr5t3VVNDvZ8aAe8TeGlZ2x35y65GzXSC2gFEAn+v7pmrLDRLUJwwbAwSAgvHGcUuphvKvb09DA0eq5VHn/tSxsRRhVR4Q2eprfBthbdC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1gZuE6w8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1gZuE6w8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6feaa0319d8so2328647b3.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741815907; x=1742420707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmcYlYQcJWzOnkcNNhiletwT3FQQye6hBLHAB4X07fc=;
        b=1gZuE6w8JoaJFQt2Gp/3iklAsSZttRDp3ZOHXY4qFuVA8EzCxAnZ9nwwKDtuRpsTAS
         /YwBgioTk+zzQIanoCrPi3/8NmFF+LrzlYRj5wxMS3P1hIiCRlElsZ/n6MADu1ykN/FZ
         KHO4G2WbWL7KVdcHoyf2Ul+An4VX1za8VCEWPx/JExZebmwj9W6CsFKE0vGhKZjyxHje
         8Z+RZopNGqjnUnikAfwxtFydbYyiGStOqK4pk57GjIiERFnkLj7iVoWNuOp9S7syxVqp
         Rl06waSvloxRo+JxC6m9fp2MSgrqkhKdYyGb6My47oHUxiWCHG+aohtIguzgkDKopC+Z
         SfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815907; x=1742420707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmcYlYQcJWzOnkcNNhiletwT3FQQye6hBLHAB4X07fc=;
        b=HvvDD3UTlBzTZyD1DRzbM2hKeKKZYm9ArxV2/QBVo2bPG7psMtSHQQGocZEhxMFIWZ
         A90YK789u9PaWFavfrLGzY9GyebKvhWjaGXt9EaMI65l5OShxwhYhJZ+dp7mt/dJ2Atw
         rguve0bsj2tHKrOSOiQsS1eKPG7nKe8G036tQLrEX/jgKOsQ9MYIERuUTl/cre4PI+ZK
         uw54uXFvltMvTcGNWAJAmj/Gp74NV8bNrt3tJBYMjtAkfkhUVNev8GMggAyZKANrrvoG
         eotnDsWr1yVfMTaQNYOM5UeM0TaYl1urvSfQuyPl4WxlqhSNrs/dqs/CSSMl6bB8l/8t
         VcZg==
X-Gm-Message-State: AOJu0YwvAL9eRJDhgQUD6jkk80mx+DSQOkU2tqC1twONmxsWaV1XqXXk
	ZIECI+YeshJ9p4BiFufNGML+T8jx+yt6H3yE5+W3Wc930dCUd5zAvq/1S+d5Ic8=
X-Gm-Gg: ASbGncstGmXIZ26F/RlH6p5gYTsOySwpbYhfHMT9BtNT8VSH2hRFTPodYS0JxUC3Kmn
	ZaeIzn94Z8aGnz03c13Ik6GY12dH5MX4dmnhAmCdxPYF4tXzkQ/QcoUpfW3bDa4WGzUd5Ngs8EG
	JC8iDhZ7I1jVWrJ/xbp6efSnalYH+RLD/9Wua+x+z+5r3pO+4CN/IBtCmIIb7/ynenI/9x0N8Ox
	8kqjpRAixfsuXmGk0GwfKBjmRjTzJ+lHxDf3Ipbnq+9W1FfNdVGcyay2iwRevIdpJoFye54fQKK
	hZqFp1oCsbICJ2dOxKakzJwJl2XzFxmTHh1T7q5rUUNLp/87JvZcOhOTGl3y+5AAMR+QuEa+hJT
	OYoNFTQp/98qekjiz
X-Google-Smtp-Source: AGHT+IHKA6PvD00uSzr96dfRHlikzPk3R9RpXJ1VhwXhjcuq2xxnH/37PogTIjVUrtb3XQqesmw+kQ==
X-Received: by 2002:a05:690c:6813:b0:6f9:af1f:53a4 with SMTP id 00721157ae682-6febf3ae047mr341983637b3.32.1741815907109;
        Wed, 12 Mar 2025 14:45:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a51821sm33468497b3.39.2025.03.12.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:45:06 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:45:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 7/9] fetch: stop protecting additions to ref-prefix list
Message-ID: <Z9IAYRKJHgf9XIb5@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309031039.GG2334191@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309031039.GG2334191@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:10:39PM -0500, Jeff King wrote:
> ---
>  builtin/fetch.c        | 10 ++++------
>  t/t5702-protocol-v2.sh | 14 ++++++++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)

No comments from me here, since this is very clearly explained and setup
within the context of the rest of the series. The end result is very,
very nice indeed.

Thanks,
Taylor
