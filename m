Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA251189F57
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337605; cv=none; b=n/bYJWGmYpK3blel/eLUj1NaeGFdcELySB817RsReF3lz0niOf5mIe/oBO/cQCqHHNGtE0HMfz2cFUSvp3KsnoT9cHDYXroPUmtmyb5cK+U7JW0eJh7ZjHi4MP3MgAPL+mIBl6Q4dgI/4fTwSfBXqxIq4ryBSecVXqxVakQ5pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337605; c=relaxed/simple;
	bh=Fbi7oEmUGxUMw4jwEU2DqcDua2oESQ4pVn3klMK66to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKszDrY05T3T409MD8avwuMCBQxn67mAAQAkixbvPZ2t8l8YeeegknliqiVspNhHWvIZRxcMv9EZq/fgl7FGIX24DfEBo/z63n+c0Wlf5h+6WI5WYFenSAN8L319FKhi6xpULYfxeey7mwgtlSLLl7GsW2I+AR1BLrEWCeflG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DpFfGLH4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DpFfGLH4"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso33529501cf.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742337602; x=1742942402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3eF1byUKv9QBKHNv36uvUp76d9EU5UMIWjGw4nvpnk=;
        b=DpFfGLH4XIS1+WfFa+Vu/cM8f5xncTXk6ebAM5CAeweWjG3H0I5xyJdfS628QC5w5L
         hoUvSuJzuPWK7693OkfW/WLFkzJrYEENT0oeUpS4MrReUB43hDTRpHqEY94C9DR6HAkq
         ChTJv3Pjj/Ol4L97FjNbeuwqNqn3Ry7sNwB0eQnpfE2UwlSdEGKFQe5Q3Mg75jDbnO45
         AWWXvjr9+j0GkkpMLq7GgMxDrcQZhD0kv8WWKMPX9XLpz0jovE0r7S0ary4OKaSNR4Eh
         uJ2jU1JUFiQgFzNjmmJi0eFw/R/4t4rmcr1uPngRDNPG6SS6+YwdjxcCgjuJ6pdteRJR
         FpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742337602; x=1742942402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3eF1byUKv9QBKHNv36uvUp76d9EU5UMIWjGw4nvpnk=;
        b=cS7a2FaMH7NgBS6YzhnBB1447kZWN6+EdU3Pp+NIBzR7nR0qxRBoQq4jWZthrw1qVW
         CFPeUS5q6324KzhRDbNae+TMLKj6buan6MNVdogcLKxxfw+HCIMu0LzcK7ZNTyHL0zSc
         W6mvoXhVG0G/IHmb5tC49FNxIJKR2gjvECGfN83uln3+SbWbJmqAtEDlTJq/kTP7QKLr
         Xu0eUSoxcXtmcawVXHs3CnoiW7gtlDZDHPSB4JOg4omfUaLt/J+DSU1ryc8EJhCFjrhE
         i9UmVk+TjEzNNcAvLvz2+PdEiXQz4df9BpAUX/tFxD2ZNSckMrY74d0raJxZYr3B92I9
         Qc+g==
X-Gm-Message-State: AOJu0Yz1QQmlSCH7fOs13H0HIdrryvioslyYUo38dnxCqn45AX8ofARs
	pGG4MfmlxgL/NlyXXL6+ac4hlgqwVxUk0CCnhgeG7qeoYT3aRA9CX34MY4UxNCrOPBDAG+Y9VNe
	LGfk=
X-Gm-Gg: ASbGnctCBuqmYYYGqFe+6edHfn/XBS5mf6oWwBXkvDr09FD24Te3eKTA5bybiAGTjnr
	7i/eKrvuq7IXwYziDjp1ziDYPWoYEJomVkfdTfGD/CN1CFdW8uJ6ytmRV5Zx7KilEOZtoQhtECt
	tZBRNNOQfxkuCYfMeVosQqgj1TbUOv4JptMNQr41DBycFOcSLD1pgdIpryxV++sw1N/A2sgQOsC
	BUgIi4Vihb0PWPSS0IHZfdBag0XvTgKJgmWB+BzFYS0koPbQmZV/opDLiAb55vj2Ms/l5La875i
	sjPU9c8vxrnMe8RhXC9TmMl6eRkBkV206frmtr1paVvR8sr6BDrmHYYdN3g2S9Y5qJYAuLjmCnv
	/ljhV5tBjBLx40/oZJXvNh0jSheQ=
X-Google-Smtp-Source: AGHT+IGCn1ovnQB4gb8aJJYONLvmgJ2KRUYB8v/krHeuW0/Mz555I6rRT3VY2mQt4hyFe8ChedtZCQ==
X-Received: by 2002:a05:622a:993:b0:476:8825:99bd with SMTP id d75a77b69052e-477082c4461mr13794841cf.5.1742337602704;
        Tue, 18 Mar 2025 15:40:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47704538509sm6525021cf.69.2025.03.18.15.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:40:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:40:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <Z9n2Qa1KJ5obtvPu@nand.local>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
 <xmqqldt35jdn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldt35jdn.fsf@gitster.g>

On Mon, Mar 17, 2025 at 04:26:28PM -0700, Junio C Hamano wrote:
> >  builtin/fetch.c    |   2 +-
> >  builtin/pull.c     |   3 ++-
> >  git-diff-pairs     | Bin 0 -> 12166200 bytes
> >  refspec.c          |  38 +++++++++++++++++++++++++++-----------
> >  refspec.h          |  18 +++++++-----------
> >  remote.c           |   4 ++--
> >  transport-helper.c |   2 +-
> >  7 files changed, 40 insertions(+), 27 deletions(-)
> >  create mode 100755 git-diff-pairs
>
> Somebody does not proofread their cover letter.  Sheesh ;-)

Ugh, for goodness sake. Sorry about that, I'll send another round.

Thanks,
Taylor
