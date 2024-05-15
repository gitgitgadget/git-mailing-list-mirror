Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67E156226
	for <git@vger.kernel.org>; Wed, 15 May 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788700; cv=none; b=dL0QrPCDF0NxhM58279GusrPR2Fib4Zr7vSxUaL0jsELW4/MeTj8CeqQVzEsK7o2kqMlAQZ1jEGAnUSxn7MD7a4oEgTdPqDSjwxx2qVpHFct84MHx5/NyW1l+qpKS0PmiOMq2aBTmJa+uXJ1NgsnvGs3NTPMYKVMe5EdQSnGXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788700; c=relaxed/simple;
	bh=Q8CpnzH3gbjRWNrbgOe49n6YbUFS8zDs1u2q3SP+AjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEZzxZyw61fK3H0ymJlyKtYoXEpHlLwiFe9JLbx2qss/H7BCndjWhANtpvpcseTpTHSA18/yqWwxvTMN9fPBmW5xj7iIyn1W8mCCZaTJPzMCL8DApeaUBLTRpRoZMmGLEc2aqu1pME+hkIxL1Rzor4K7nz0LpnOtwrilNN+alrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Y1Mrr+Z8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Y1Mrr+Z8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792e4c2a002so217252185a.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715788698; x=1716393498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkjkaO3b6rfyPJgtj7wm2cjpC1iG2Tnl7EnGorp8GEU=;
        b=Y1Mrr+Z8gvisLlAyK9MiRDuF06p2EnB5Mx0Se1PxhQ5cUjnFCpup4yK6oJRMW4pche
         8cURwztRK8AzZNG4ZzOZEV7/ZrL22qm8/8xYUeZ1mFdllrFUsJ/dnpO5gR/MsRKJkPk/
         CQikkAAg92SATix2jKCtk0WaME495uBVL0+9xUQ4zDrC2v3nLpw97Cbc5auhkhJBXqWd
         VPIKr/guegyNvhzFZlUmOc1c9GIHE0X34UjgaOr6YwPELC4uzrmowZNLT3HCSRmO+Foc
         vrJb8aMqjHj0xl7GRPcUNAx2OQs/VQgsuxWBF3xUUVuXDyIn3yeyiw5Lybn7wi4OldDH
         t0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715788698; x=1716393498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkjkaO3b6rfyPJgtj7wm2cjpC1iG2Tnl7EnGorp8GEU=;
        b=dmCHdboGQyaqJxOJof72AVEfOB9BQc700iCuYAl5IYs7fDtYgxYVNMJcFIWh2l9vXb
         dDJn9yb0BYEv5TrMMJKA+n7/IBR/Cs/c/P3SA/nE+LnzUPBg7m/0mH3ZgY9k9FnjznsR
         Bdzmf7jvFkG8+64pnXGxz6Gj5iM9dGklH/wxVsE3pI5Lx7JDC43rB5nMAs19bm60j3NQ
         zeOlPLorG0Je5sUXzQ9zABjlbi73l0i6EWg/Ue0yusANQDmkuTFDFPvH0SbUIhq99Sp3
         vPgBtDuluW2ANzIYfUbv+LtuP+R65u/2SpAzYmCuCFP3jZjrWHzJn9JtcrU7VZUX+zjB
         hkhA==
X-Gm-Message-State: AOJu0YxU3AZBUjyN7XPnIHHXkBHK+iOKvMekm3v7in4ac2WVnaSMXbXw
	iXIgP+DvKc2sfQE++i4htY0UFUZM9k8SHMw4GKZvn5DnyFHsPTAvIcvVFLxZJkwHjeW/0PNeG6I
	Y
X-Google-Smtp-Source: AGHT+IE0eeXgs1ohHLEqvSTYFi+cGxAYQNP7BlEqjEAupxo2CKASUNGQtu4bmi1rAX0h1z3bAPxLsA==
X-Received: by 2002:a05:620a:349:b0:792:bc28:5ef4 with SMTP id af79cd13be357-792c757789amr1668002585a.3.1715788697674;
        Wed, 15 May 2024 08:58:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a4279sm690435885a.59.2024.05.15.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:58:17 -0700 (PDT)
Date: Wed, 15 May 2024 11:58:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] pack-bitmap: introduce `bitmap_writer_free()`
Message-ID: <ZkTblLnr53lSKZ8Q@nand.local>
References: <cover.1715716605.git.me@ttaylorr.com>
 <bf65967764f34adc2ca00d4c8195840ad3e4e127.1715716605.git.me@ttaylorr.com>
 <ZkR6zkUfW6Fosqyn@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkR6zkUfW6Fosqyn@tanuki>

On Wed, May 15, 2024 at 11:05:18AM +0200, Patrick Steinhardt wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 10e69fdc8e..26a6d0d791 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1245,7 +1245,6 @@ static void write_pack_file(void)
> >  	uint32_t nr_remaining = nr_result;
> >  	time_t last_mtime = 0;
> >  	struct object_entry **write_order;
> > -	struct bitmap_writer bitmap_writer;
> >
> >  	if (progress > pack_to_stdout)
> >  		progress_state = start_progress(_("Writing objects"), nr_result);
> > @@ -1315,6 +1314,7 @@ static void write_pack_file(void)
> >  		if (!pack_to_stdout) {
> >  			struct stat st;
> >  			struct strbuf tmpname = STRBUF_INIT;
> > +			struct bitmap_writer bitmap_writer;
> >  			char *idx_tmp_name = NULL;
> >
> >  			/*
>
> Nit: we could have avoided moving the struct if it was introduced in
> this spot in the preceding patch.

Ugh, I meant to move the declaration here in the previous patch, but
apparently didn't. I don't think it's worth sending another round just
to fix that minor issue, but happy to do so if you feel strongly.

Thanks,
Taylor
