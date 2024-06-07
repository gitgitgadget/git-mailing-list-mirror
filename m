Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD91757D
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792161; cv=none; b=SG/iqJ7lF+ARnjmRzez1NKm3uZrzSWb5c1PMoqmoxmw4cinSwwqAM/4P8xDyjaohfNaA3YPuPcMQaiMMZ25mwOL7EF/CXaDMzLXZ/yBcpxEQF5sjG0hV+JxYlKPpoHkSoRGSnhmMo+jgpcIsSGDXIBp5+4RQKG5T5ngCpb8xCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792161; c=relaxed/simple;
	bh=0Bk27HBXx/nQjRhYQMV7bVnXguKRKGz80b0uDrReFeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6mkfh6/DGz4hQuM6ESZrsnK783YeesAmbi4O+7K4oDJzMy4r6iXggF73iyCfNltnnIPlBR7A+qeLeyYHmzq3RMTDDhLi3Kj3wPb9m6Gd7tTG+QnkK51lhRPiG5KRseJFAuWLfE1k0uoVfMGcvauFFBoEl05KSQcij5MzdKclIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=a9CL5qYg; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="a9CL5qYg"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9b74043b1so1338973b6e.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717792159; x=1718396959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bk27HBXx/nQjRhYQMV7bVnXguKRKGz80b0uDrReFeA=;
        b=a9CL5qYgobhqkSCpk9Fad2PszmbkjoBMpuwDdzujzwxAg0tbpYP0wQkeK7xffiBdrN
         HH5ChOI845OUw5FqT7SkI1ftnJuwYiRKLEeq6fYEuVSnzbAWUR1a2i4RFS3crUOAsKCY
         S9g9KIAVWqlgRia9/Z4E6v9Q17CoO5wby0vt1BzPKwgjrmhEiZFvBT3wsR5gVnRl+I++
         mwfyx5xHtI/DF5uwF+TsCxYSU5Z2ncIR19NsvO1PacNQg2Uw4Xa64F/krIKlDekJj8P4
         W03R/4EawAKb9I2jiWlMly2jh7T1iNQ3E5Ix5JEVLOTzCXOgOlMtgAOwjfTBqMhY+046
         h9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792159; x=1718396959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Bk27HBXx/nQjRhYQMV7bVnXguKRKGz80b0uDrReFeA=;
        b=oyuFiiE0BUZ2Ybg7i8PLkvkZgeIPAF1b6jKoWNwws/8Y4/4iKMwjGO1Bzu4ZLGL+HG
         H36Hd7NUWIv1Znld+JskNUijcyQ5kaYFMAaURhhwc65mCMLr6qqatSJc7WQS3xOgL/Mm
         FTrYslcd3MiS+bliQOaP0LfF9RM4+TzfOPfMX78Xr7M7nkBhKZUr8DWx7AorMWUe7fpf
         n/W7+alSc47PZuX8EqmUACM9+D4xrp58EBWGfFaLl/Sub1ANlDJKUfPnGd6IXFYjXn66
         nIeffXQWtoIoepZ/xDlbIkL3PYM+PG13ybXY8AArBidsiwwb8rizF8JMjhe0y7+z+LyG
         Wt9Q==
X-Gm-Message-State: AOJu0YykfhWfUX1LWAZ2zIjauEKFsjA1MfYm6wZZfrDxEdxg21mRqYBc
	hwLs1kvASe5ZSvSfiING9RkZEvRxDTQAKBU32r3OQBJufiEzTKJSDXwo60BjnwQ=
X-Google-Smtp-Source: AGHT+IHlRbclEYaBFkn72uai6mySaGElEJ70LgkHTURIW93G9jdhnntmSU1+vGSm3GQ6/h1S6xf/fw==
X-Received: by 2002:aca:91a:0:b0:3c9:68f8:815b with SMTP id 5614622812f47-3d210d96626mr3417581b6e.26.1717792158821;
        Fri, 07 Jun 2024 13:29:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b056fd8b14sm15697866d6.132.2024.06.07.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:29:18 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:29:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <ZmNtnap8NWmHM6am@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <ZmJBAjraBh6O/G1d@nand.local>
 <xmqqr0d8d2mu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0d8d2mu.fsf@gitster.g>

On Fri, Jun 07, 2024 at 11:33:13AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I forgot to mention, this series is based off a merge with current
> > master and 'tb/midx-write-cleanup'.
>
> I think I saw "am -3" fall back to three-way at around [17/19] for
> t0410 while applying on that base, but it wasn't anything "am -3"
> couldn't handle.
>
> Queued.

Great, thanks. Sorry again for forgetting to mention it sooner.

Thanks,
Taylor
