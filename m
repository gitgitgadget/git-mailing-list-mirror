Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2217588
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591443; cv=none; b=BrT5Ckzwv93O6UE49iM5kSKQden5Wu4A5Bi3t8vxP83n9QbrjGbv6eX+9TUseABzpf/ePQHs7mvAHrX02jCgSj/q0fnRgYT4+33LKyXeLr8QNNjWpUU1lyg4a+CIMQxUoSRn2Rjk966wke/Ap6RrOE7eNLNfz50hveyD9O/phqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591443; c=relaxed/simple;
	bh=kt0utdbDsV1MIf8MVxiM9L2wHEW2bdRuzt+TT7kgTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecCGV9NtBVg6IyjTFOQKvYPUAumnykXWwAuTb6uvrUFiIKQRtgKDDKwZPAx9GsFeLSxJQRQgvekIbsCHRV+nnoNPdFAPxJNaaj1bFWnooKwLZXRmM1z/KQot0g6znFF7a4LGJ2GEtzpjF4NchVfLnIFfcDhGqZRjFPyY7iU8gok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JiJVnJl9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JiJVnJl9"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea7c26e195so6965817b3.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731591438; x=1732196238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUNY5JLf9VXt+KMGgT1usz05S+LBtfkAkU5PY727XCA=;
        b=JiJVnJl97372U2R+veYfnoO49/LEx4iuXFMGz5bCANRZrqY6NzuLTIuv13oaDuGnqB
         tf6AyaXDP2R0ZqGRu8J+HHB9H7ngnHLkDXgJMmEpw8eKq+HeOVl43Q8xtqbQjgvAuydY
         AgfwMI2HH66TNDybe0AWy4nxULCYupI9FKI0fdiFqtO3TEor5Pgt8yvRxzTv3Sw+3e30
         SSZkrNUBCntbDH9224XOUkdoizBCjcZ2Fw060uK9sQmH1VrcpMetxI4JZqQtYYLfKZ4E
         9cB9hshTLEIjbNI86OArBRAhXD9yHp9aLCPe4HjcZ9m3k2guecjFUvsecGMvNSx0v4JZ
         kBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591438; x=1732196238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUNY5JLf9VXt+KMGgT1usz05S+LBtfkAkU5PY727XCA=;
        b=GofMU2v9eHV6XGsEoKKy5c7FfgddKN+YwvLcL2KxFf5ZdrBCNcwJ6qSBjydOd9K7W1
         V5FqAf9SkP/e2nwg1T9G8LQ8GuTRq1IE+5B4uVGojakXnGJfr/Kyj/Rvzd8836ixCjnJ
         XHDD0i5rKiuVX4TOHQ6Bb/8PNPzjy+xznbmsSOdE6c/XHHjByLIZ6hsOGsa9P0S54sjl
         ZbjXLFvJYGmD02I4q3TJrYvW+rgMndeBMVobpem/DSfgnV28m/+ZGQhBCgSJra06wdyG
         O38N6y6d305WpDVna4ElJq89PjmaUS8aEbVh/bhypt7alcpYGSjKHHe49M/BeO5y8f9S
         b7MA==
X-Gm-Message-State: AOJu0YxXVYQzbyqj018mt1YMEUOopjah8po4In5arqUe/3uwazQVTPnw
	Q0coC5SOHDtFudTEG0KZ36j3rAmYqsibwDbXDlqrRe7GTiZ3OSCgtpcBeXL4YYI=
X-Google-Smtp-Source: AGHT+IHRmLMKSyqllMzNeMYhGI/Z3VSYzmPlvFBxgDUwQbgNjCaa9uScecdJ/gzTrZtdJuK/yK1/ow==
X-Received: by 2002:a81:f912:0:b0:6e2:413:f19 with SMTP id 00721157ae682-6ecb347fa3emr55481627b3.27.1731591438528;
        Thu, 14 Nov 2024 05:37:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee444951adsm2313937b3.128.2024.11.14.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:37:18 -0800 (PST)
Date: Thu, 14 Nov 2024 08:37:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] t5332-multi-pack-reuse.sh: demonstrate duplicate
 packing failure
Message-ID: <ZzX9BgmxTgi6Pk8z@nand.local>
References: <cover.1731518931.git.me@ttaylorr.com>
 <7a69cf84ae5b92d99e5777d4600270712424c4d7.1731518931.git.me@ttaylorr.com>
 <xmqq8qtm8vps.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qtm8vps.fsf@gitster.g>

On Thu, Nov 14, 2024 at 10:12:15AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +test_expect_failure 'duplicate objects with verbatim reuse' '
> > +	git init duplicate-objects-verbatim &&
> > +	(
> > +		cd duplicate-objects-verbatim &&
> > +
> > +		git config pack.allowPackReuse multi &&
> > +
> > +		test_commit_bulk 64 &&
> > +
> > +		# take the first object from the main pack...
> > +		git show-index <$(ls $packdir/pack-*.idx) >obj.raw &&
> > +		sort -nk1 <obj.raw | head -n1 | cut -d" " -f2 >in &&
> > +
> > +		# ...and create a separate pack containing just that object
> > +		p="$(git pack-objects $packdir/pack <in)" &&
> > +		git show-index <$packdir/pack-$p.idx &&
>
> Is this done so that "git show-index" fails when the .idx file fed
> is malformed?  Or is it a leftover debugging aid, where a human
> developer was helped by eyeballing the contents of the .idx file in
> human readable form?  If the latter, do we perhaps want to "parse"
> the output the same way in this test to validate our expectation?

Oops. This is stray debugging left over that I forgot to take out before
committing. That makes it the latter of the two you mentioned, but I
don't think we need to validate the output of 'git show-index' in this
instance.

We're just relying on pack-objects to generate a pack containing a
single object, which feels like basic functionality not worth explicitly
making an assertion on.

There is a subtle assertion on the line below here:

> > +		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&

that the pack (a) exists, and (b) has at least one object, since both
conditions must be met for a pack to become preferred in a MIDX bitmap.

But beyond that, I don't think we need to validate the output of
show-index here. I'll remove the stray debugging line and send a new
round. Sorry about that, and thanks for spotting!

Thanks,
Taylor
