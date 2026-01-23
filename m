Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23847276046
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126485; cv=none; b=rnU+m7NnhgFGXrF9bk4QhSDMlcjo9hkcUw+yJfn7KMOKTCiiQqlELb8sufwzta0fwAsBae5A8XQPzX3T978u5u5ApxLGB7XNyHBRIZbHwygUjHzMpF8joAujVSIzznESNxS95jrU/YswXmot3IQUdFgN7+Jg0ORz9ht3aWKoSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126485; c=relaxed/simple;
	bh=fLPyP87H6AbAponEJ2lIcDT4U8eHL/G4R1nBFYZ85Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7cdajRbvWd/i1PHfMYy72JK6ub8DMADFLFEhYasGjMnXNN0/66GZ/3BlHkturx80yKgos3IuVsyi3C6qjFDzMzmsylzZShR8nThoLhL822LX3HmKlsUJele7QSrw6r1m3vwun1FCDGNjBCz/oFWpBH+Ye8aIQkb7jv3NLEdAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VKDMBGSL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VKDMBGSL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c53198a65fso170620385a.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769126477; x=1769731277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKm+aegjxEY6dP0iCLx7uRerIBXo6aopppU/zmrB+Sw=;
        b=VKDMBGSLfupCWtU+bOFGMkF889jKxJBpWMdDoZNxtsuXW4XLupvWhX47wra+kR4Q4Q
         TYryi76zvYMaozrurH6wK7yRjwUb6XA7q0nn2XNfL8nzL1dXmVbnc3sy8HV+/Qt0mEqT
         NP52nFwOvW/KRrzkAaKYodOiv6BUTLmuCEOLoKOIvhlFGX8YYSzvg3e/74H0e8C7Y5D3
         1wUa6xnXRxwL5leAFPJQ2Ht4//EpgiNVUKhuDMvcWXW4Fcl8tGEkXprZPBWPo/ofx93h
         RodE+xR6ZmnDrs/b2LRmI2tlesdDzQrPz09cWPEkmi8UxWS36F11pz8rCtnkPZYTPrnH
         Ph1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769126477; x=1769731277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKm+aegjxEY6dP0iCLx7uRerIBXo6aopppU/zmrB+Sw=;
        b=JYxf/GhRVZfAxKdzZk78o6t+9WytAu17uWaSiMGBn75Hd1t3Cftun1OWZPT/ekL0vX
         +fAQ6L4DahE41zo0FzsFXGBkI5DgwUdQyNq7IuYvHXXAX5LSYB535pjYPP64h8hfOEqA
         jAFXHb89Igz/W/Gb0En0NhEnaYM7uPdsQpL4jClnWy1IFHSMjj04nu+eO/H7MwUxVSTu
         8XsIfSQ6nZ8u0TtKU6HwTEhocoERCrKnkZLfLYje1L5sc30MNN6DZdnHLdGU68H1dl/b
         9drOV9w8kCZTXZ7bLUzNCe4sGtPo0u1ipxFsQWcCLg4jR6y/dzhvm3Z6qXmw2mylQRee
         BQUQ==
X-Gm-Message-State: AOJu0YxAk3EtG3n/sPaOqPQzRN4GkRDVoJ45hxkUmGwSdC/wCzC+gEEG
	zZqMVodqFwBgWWp4R5ttIGxARHlr7dXoJvNKuiH92//b4SJw0FZasX+CQqRiXiTVCl8=
X-Gm-Gg: AZuq6aILFfW81XHbF1Q1o9JTqpJaAKlUdSJlYRn2w5YBjKAMoGTTXDzmpbFu3PZd7ym
	lW44REXAJP99N5cjXKIPIpylwRXf3Lg/3u/iFjcXDKiJaVJ/yjB5/uQRoUv7vcfb3Hx7FuqCqGj
	cgFUVARfL9lZWFZtiPB+9dmQ3cH0J7aYpiNYThbmlk6gnCjnt6fWgb7EKcvj4xUgUcIJ37UTthz
	GQfwANSgEzIj0ybM6k9eiyPycsY4D5rGzrDVtyL7eisb5/5t81kX4olOPvvwtdgqJ3azSuYZdwP
	Z1RmQO0alIploCl4TTI9M7MlcUr7INUq7NsUPY3cS9DOva59eoxhhtvHNIj5PMu2PlnFyEDthTm
	59OWEH8XJ1hGsnOueKQePRam7mnIXHVFMXZv/QSgL6gse/jtMy5wo1MMdliJgldFgGsZMxI7jEE
	G83AY9yL1/Rb/5vJpPsAdDaaUxTus7QWbRmgw2RAuY4q/nT2BAQ2N2gRGuVnzxS38BFj2BHtUBU
	eBeGwdKb4Eb9YWa+w==
X-Received: by 2002:a05:620a:25ca:b0:8b3:16c:1a79 with SMTP id af79cd13be357-8c6e2e2e59dmr163041585a.53.1769126477165;
        Thu, 22 Jan 2026 16:01:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854e2fsm47645385a.36.2026.01.22.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:01:16 -0800 (PST)
Date: Thu, 22 Jan 2026 19:01:15 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/14] object-file: introduce function to iterate
 through objects
Message-ID: <aXK6S82kY8gwoEfQ@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-4-12c4dfd24227@pks.im>
 <aXFsFAV/1J9DLQRY@nand.local>
 <aXHJEBY1FnbGRtzK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXHJEBY1FnbGRtzK@pks.im>

On Thu, Jan 22, 2026 at 07:52:00AM +0100, Patrick Steinhardt wrote:
> > I think if there were multiple ways to iterate over loose objects, it
> > makes a lot of sense to prefix them such that they are grouped to avoid
> > mixing interfaces or using one API when you meant to call another. But
> > my understanding is that the intent here is to consolidate all of the
> > different ways to iterate over objects which live in different
> > odb_source implementations opaque to the caller. As a result, what other
> > way exists to iterate over loose objects?
>
> There will be more to come: iterating over objects with a prefix, for
> example. In general, this series is taking a layered approach:
>
>   - `odb_for_each_object()` is the high-level function that users should
>     use if possible. It is part of the ODB layer and abstracts away
>     details about the ODB sources.
>
>   - `odb_source_for_each_object()` will be introduced in the next patch
>     series. It allows the user to take an ODB source and iterate over
>     its contained objects, regardless of what the backend is.
>
>   - `odb_source_loose_for_each_object()` is the low-level implementation
>     for one specific backend. We also have equivalent functions for the
>     other backends, like for example for packed objects.
>
> The longer the function name, the more specific the logic becomes. Sure,
> eventually it becomes a mouthful, but ideally users wouldn't have to
> ever interact with the low-level details at all.

Thanks for the extra information, this is definitely what I was missing.
If there are many ways to iterate over objects, then the naming scheme
above makes sense.

The point that I was trying to get across was that I think that the
convention of naming a function that does "foo" to a struct "S" as
"S_foo()" is great, but that we shouldn't apply that convention when
there is only one way to do "foo" in general.

For this particular case, I think I would have pushed back if you said
that `odb_for_each_object()` was the only function that we'd end up with
(i.e., there is no non-ODB way to do this, so for_each_object() is just
as descriptive IMO). But that's not the case, so I think the naming
scheme you have here makes sense.

Thanks,
Taylor
