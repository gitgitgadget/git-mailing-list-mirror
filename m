Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2763CF
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764557; cv=none; b=XoBJev/VaPcNeVW042FkJOqIqZB6NGSiud3hrf5UUv46S2345ChTz0b0/ArKhzYvpL+j78wrRrIG/9+CxZOFKNhOEFDuO8f9CI5phhYlCFio2Znioyf4u0T92ZQlpoDIEKAWX4KURcQou6erVlyfIT89NuwCTiKJ8yOn/n56PjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764557; c=relaxed/simple;
	bh=mnLhYQdyMlaPvGyiEwcPuO1VU0POXFZPblnKkmleDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0VZQ5GWWka+12xKcYIZSObTlwGFPx3gO5DfuqANWB71glgxPMYWWJJKnp5O/KcwMq4rFtpmNjbhbnH4P0Ny6qMpWyFdJWsj3GQV/X2EYdriKdKN7rwVrxOUIRG7NIrmiHTIUh4+dwX/lN8zgRpviix/31KDmmi804IX5Gs7SF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VdF96lrz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VdF96lrz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78ecd752a7cso643358885a.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714764555; x=1715369355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnLhYQdyMlaPvGyiEwcPuO1VU0POXFZPblnKkmleDaM=;
        b=VdF96lrzmjiqjdb8LaiVMPGsYh2CRADDbFkEdP8u8J01iHLz4cXkbTKvIE2iuwJ/3s
         OXU0hntlzEZDL+ihPgnoNRhnEJNoCvAt+Jz68Ipr1b5VdrbOlSFlKONE5ACGkKp8JKBZ
         856GCF/t4YScFaLPaiUS/iIY8sWiOmVJzHHz2eopcwYgNrU9TGcpTUHXIJtJq9Me4Jtx
         Z2qXXW0MZqisisnHcBpc2A4fRHa7MOBCZBai2A474HUs5c9x/KqOy93qsbFB0deU5Sgg
         AxsT2dsIYgdTFVYPwNMDw7X/yscIwtytYcp7qUjo3fQ/6eABdwL5mE7X7KgWvTEAWkIe
         QZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764555; x=1715369355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnLhYQdyMlaPvGyiEwcPuO1VU0POXFZPblnKkmleDaM=;
        b=NIrVpzkAcjZPp1HZ/cUHI65+A5CeXfGaVdnBU8+QRcSg8OGn0LUHhXsIE/zkMZc/y9
         INcvZDfxo4NJjuKapQxoeF71gkXcGDEEymSkNAWkS5H200iTe7C/y1SuyT/JO+QFlD3Z
         2tRZjU8WbZuIaOKSdD2EtF2QCD43D5+Vco1Ej/X6US8jkWoE6iLYNm3HCmZVWoIVIzs+
         2xTW1xTdt3/RQ27l7DDGlMJNJhuBKuMdCpM1pGTLImMR0OiNQCmbOHAr8n86vdO6P8tS
         ukm2dgChQux9d8wsLVJQSlxQj5NInDNHYtZBvFgtzHc9Hkq2G8o8Vsi2+y2JTw01LCuu
         yzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqaBG8yPLxd0XcYBgB20iYqzyfiR8TVaXIcnK7n7/Vfv6SbfvQzaI85Xf+5uwg8h50zaMOnQ+9qIxUQzNw3bCVQYb
X-Gm-Message-State: AOJu0YwQVTm4adJdKLmq5OM5O2yk6uVmtxTQ708ZIVcX0HgFECEN3z0C
	PDPuCKj3KovmNp2iaMZW6Gg6st5fJ1R0Ecvrn6yHCET87aXIyTnBYOb61U7En+g=
X-Google-Smtp-Source: AGHT+IEVDfmBIkQwlmXSOFmsk1UFe9Q7DWr+vEAMroN6dCDgRrcouVEN0fnHNbQS7blagdTFwEdjOg==
X-Received: by 2002:a05:620a:8520:b0:790:6d09:a443 with SMTP id pe32-20020a05620a852000b007906d09a443mr3272948qkn.72.1714764555050;
        Fri, 03 May 2024 12:29:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g4-20020a05620a108400b00790676d0fe2sm1477548qkk.121.2024.05.03.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:29:14 -0700 (PDT)
Date: Fri, 3 May 2024 15:29:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	avarab@gmail.com, christian.couder@gmail.com,
	Enrico Mrass <emrass@google.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <ZjU7CWdwb+xKubul@nand.local>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com>
 <xmqqr0f47wp9.fsf@gitster.g>
 <xmqqseyzar96.fsf@gitster.g>
 <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
 <xmqqfruy7oq8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfruy7oq8.fsf@gitster.g>

On Fri, May 03, 2024 at 11:08:15AM -0700, Junio C Hamano wrote:
> > Yes, sorry for silence on this thread. I am working on a V2 but
> > probably won't have it ready today.
>
> Don't be sorry; the message was not addressed to you, but for wider
> community participants---especially the ones with more "clout" (or
> "long timers" or whatever word we would use to describe those whose
> opinions are trusted by others and count more) need to buy in if we
> were to first agree on that it is good to have a set of written
> rules, and to then agree on what rules to adopt.

I have been meaning to respond to this thread since I was mentioned in
it by Emily, but have been unsure of what to say.

On one hand, I think the document basically outlines the status-quo of
decision making for issues that are larger than the scope of a single
patch series (think "should we use Rust?", "what is our platform
support policy?", or "how should we approach libification?" not "is this
particular patch (series) correct?").

So in that sense, I think that the document is a good starting point,
and I think that it reasonably captures the status quo.

But I wish that we didn't have to have such a document in the first
place. In my opinion, I would much rather see decisions like "what is
our platform policy?" made according to discussions on a patch that
defines what that policy is. That way such decisions can be treated in
the same way as ordinary review is today, and we can avoid the need for
a separate process.

(For what it's worth, I thought that the SHA-256 transition was a good
example of this. The RFC was posted, and the discussion was had on the
patch series itself).

Another way of thinking about this is that I would be extremely
reluctant to see a similar document proposed for reviewing at the patch
series level. In my opinion, the system of reviewers and participants
discussing the series and the maintainer solely determining whether or
not consensus has been reached is a good one, and I would be extremely
hesitant to recommend changing it.

And I would advocate for a similar approach to decisions that have
implications beyond a single patch series.

Thanks,
Taylor
