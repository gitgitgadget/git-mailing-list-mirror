Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9F148838
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751097921; cv=none; b=Txbdwkt8Jr6BH37IGBbG8EO/YfKVq2eTg8Np4KFHaVkUPnVaozVAQ2F19aNS5uBRyTLZR8BNkPDYF15KEwFhZ7bTFPvh9KRTdfw8O/++RcG589QjC4W2ivjmskjUtni3Dy7lYk0z/bupSHl4X53pyjgydOfAucMl5EANg+wWYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751097921; c=relaxed/simple;
	bh=1NQ44m6HGFUjZ8UTZuum2MteJZa20AOssk64JkWhcp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPupGGcXNBdUEIxaIIIu/tgxP1NTi+ZRXeC3OfMDQuMK8cC/GAZrp1+B8vwtKfEi5U5ojpA6tAp5X3E98WQk66buzuTcHU2tAm+6yp+dTn/ocMicKU0pM8rhFlLcAFzZAgc4cIqfzYS0PYkDJxZIq0jQnbx6p4mzuwwdfaHwPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCcgBo/V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCcgBo/V"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so2600729a91.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751097919; x=1751702719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hJXOiFHcK4lJ8KS83VmJbOxVa5u2EJu+BIkKFWiNvE=;
        b=iCcgBo/VjEkGkagR9buTFz2LaIvMqarWwT6LBmWybbWA539BrqFjFP8LkEXwUu0pvp
         ogUdzUapVypEnJiaDf72WY5+QkduW98Rl9sAVrf3QwtSNHVYGJAEKW3e7SVm0YGngzyp
         JZ9NBCrpEMVrYxf9FcH9DyGVVqce+zzTUK1Iw7rGcRhjlliuAsapcvjzbeE6vzxgHsO1
         KSMIvaSQMn+MxRI56qSDlrDIo8xfsERrDJdr0qUNmOcifXLkgczkXO3taaxJJ1rICxMh
         s1N8v+A4VsK9AZsKb48eAvgALIjD5bwkG7/tQ/fTxRowHcQO2AnSZH1XTcuXjCe808ID
         WiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751097919; x=1751702719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hJXOiFHcK4lJ8KS83VmJbOxVa5u2EJu+BIkKFWiNvE=;
        b=Gu7Wdkf9hJ2J55WiEcQreCpwd2RtBjpHikgnHdoylXG5xz2+BJVbqL37PivTZUOzun
         RiaphIIqHMCFTgCiMIKC18Q71LSygmNyT1lAv8ZNwSNGma7dY8YZQw6gied0HyUF3soZ
         WdcltoPlAsB+TENw6riUnpe7xYtnrq48lJNhNnomxRCNYZ63uIu71I4yqBIQ9IOCCinE
         UYfHAWxnXKUI+Eqrrx19Vkquo+DPqTdPkLXwtB6EvznQHd3HsKr7LNAjAvd2HXLa9MVd
         WCoUYB16rgCVOnT1QsnJr1/zEFFwLW662p2GxsfBcziRtYljy3GQVhXYRznd16qEevaJ
         FJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6jV5zpw85EkpKv6+d1goE5P1g+/EoUTSys7oEQNzBn0MEXGLtTXMaYEzp57VXmQweUdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNWXk5xKqmJdg+tfaZxndHPtapTUjh1OZhcAFAAzhHbY0JjjN
	Xri++CBZ3Kdb8URvQMeRr+1pI/OhiXrdLRvLEQO9uvPEM1iOTrT/c+MH
X-Gm-Gg: ASbGncsSyOvIJt1XUvJDa1ojxT2SsbSNo//05Wz270hijmQbOgllE2HXMUiG1kuaWBz
	4ASPt9iRRNbmQ6+/b4XvPBgleNQSK+wXBeNtP5wSezWp2QrMQJrD7ZG353o1wwkTQWJilYICSpA
	jUGD5vyjLJVWHsQIsLWpIg9a084jHNc+vHU4cgJAamliGvXo62DQWASgeSsdgIEsBRmdY+QkUFK
	rUw68d1j5xOJcJpXwInpDum6A5ScUnvU8hqpLIgnjkOzc+dpT6DzCuSbT9GnFOM6LfSl7fDAg98
	tILwPsJWD20wzHbDZ651SPvMzfaHFeb/34uQMMpA3nucVVuNEfEKV26Sww==
X-Google-Smtp-Source: AGHT+IEeWVEIQHmV+g9T1U4aPaA8zhro48swRvn3Xp0HBd1uZgiseDyW5KvsmLyXn6zZvM0RqA08lw==
X-Received: by 2002:a17:90b:4ad0:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-318c9322912mr8362477a91.30.1751097919062;
        Sat, 28 Jun 2025 01:05:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f539e69fsm8895140a91.11.2025.06.28.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 01:05:18 -0700 (PDT)
Date: Sat, 28 Jun 2025 16:05:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
	karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
Message-ID: <aF-iSSOmcplFjKQt@ArchLinux>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <xmqqh60183ku.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh60183ku.fsf@gitster.g>

On Fri, Jun 27, 2025 at 11:03:13AM -0700, Junio C Hamano wrote:
> Meet Soni <meetsoni3017@gmail.com> writes:
> 
> >   - Remove legacy or obscure options that are no longer needed.
> 
> Such as?
> 
> >   - Add improvements that wouldn't make sense to bolt onto legacy
> >     commands.
> 
> Such as?
> 
> While I agree that there may be cases that the above goals in
> general would bring us improvements, I think neither of these two
> applies to for-each-ref.  People are using for-each-ref to iterate
> over and enumerate refs already, and if you are to add some new
> features to "git refs list", they certainly will demand these new
> goodies to be added to for-each-ref as well.
> 

If so, we would make "git refs list" to place "git for-each-ref" at
all. However, in the current implementation, we indeed introduce
duplicate code path if we decide to do above.

Thanks,
Jialuo
