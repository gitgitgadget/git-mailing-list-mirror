Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216613D531
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747084; cv=none; b=nYo9xV+Vwo+OWYRttVvGgTb6OtgnE295FOGwqVIj4rNVPKQE6TN+gghJHDMLZwbHjXke5CdkdWmXLr/xIMv8YITmX14Ri+VNfHXlZnfgP/BPSLLsgN+xrNOp6GWTq+sHm2LzcvBzNCI/IuDuSM0cDbUZdYiVWHaa43Kr2KTqqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747084; c=relaxed/simple;
	bh=qMREVVeVUtXJji27kigki3TTkqt7wnBJFxutgsntJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQF9f4b7yui7BYqlPx/zc32jbMNsR8LyRhWDQE4vEcrPmQXqQGPOerN8GrZmLbG1eVRdMfQgZzTVCmCIDslqK9HjUkReiPB/dhz0SS12gzDM+giSlGqS6L1EXzWq+92FiaJAOweil6MVPZMNUVo1igMTVyggNFK83YDxLbypqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IL0wFGU5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IL0wFGU5"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5aecec8f3so902297485a.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744747080; x=1745351880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qMREVVeVUtXJji27kigki3TTkqt7wnBJFxutgsntJK0=;
        b=IL0wFGU5TAAvQ80MDhoswS/LnL1UoLn069AV3W+GalgeTtLPq5glSerms0IUkvc74+
         YRAghQ05QgHZqmt5lkdF9ze+sm6t4x/qTYoCFac8nhPcUXS72ayx83i+ewdsaTfwcP2c
         WxLgryOApXQ63J+WZlpOd4xpvluUKX/BrFzwRtWowRgyKfAS43e+MoWurJXjQVOkSola
         +ODaK3O4QWcYaIuDl/Z5M189EKyEjiSRlQDnaRt09nTJS8oxYGnvF3EI17aaG4evIEsB
         9U3Aq0V4eQF1HobiJabMOPgeujotn8rkTDH+SCgWTPXuiT9xnXfshuYvtiLtW55YOZne
         JlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744747080; x=1745351880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMREVVeVUtXJji27kigki3TTkqt7wnBJFxutgsntJK0=;
        b=VYXFjMrXfu11f5XxSuuCclg2mpfZIau3qtwPK6T2OLNU0mJvRoa+XFG7kM15PbGYoa
         U1pcmEvxl1THBjoC6tdQG38W1/yjaaGYJaX/eVbM/kGllCCLVIA0I570bWau3AdTU6nQ
         +UMPWKnnqbhPtG2EbVJdUcXESerksza0WrH6Q9Pn7p14+vMytdNeHaVoyHbf0Q9I/R+1
         Z2T2lSFFgucbb7BTlsakUdNDLae/i1lsz4sf7o/qCdVGfmPj3+m9DHM52Q45oRGd5g9s
         rzdcIhLRl/H6GcL9WTiUjLRnD2eqiHqUCKX3sJ0fE4txrh8Qg4VMVC5Y690Xsn6tCgjB
         geWg==
X-Gm-Message-State: AOJu0YwdoCm4boa2lqQl65mtxJprBbPNbvfIAmSmri2k25jKqK8ZweR9
	OVeyULP2eSA1DrGpgNxfLteelgolePGTUWpMRIHVCnCt7RLHnFVZv5DhXRPJmuk=
X-Gm-Gg: ASbGncuqvmpJNHanTwBOwhTbdrMCeI9Py5Dryjxu9Ivvjo1d8EhEcu5O0GnNXkJLHg2
	/K8Vc+mRn7YJ8LRNFGPvtJ8TTv+r47m3Mf7uM+VmMtFuLycSD34/mGI5fGBnXDd8jETm4R4pibG
	tYUfzdNDBT7SHZ5s6NwmqtdDYFyJelpoYJxuVA7Y/n69cfz17aibVzt67JeMTH4fpc6b8VkfXyE
	cPgm1B2bTx+CJ64Ns0luS5XxLqcXPgo5liJbM8F6zlxEthQNhvSTxTzemM/eK/oz5S45hxuskTN
	BBVR3ZJQqVigkKNiR3CUcScV8rStfgy60fHdl3YBitoXyd8sd96KwLzFPOjMCfmspBWHTqBNEGz
	Mvzs3TGGIpXoQ
X-Google-Smtp-Source: AGHT+IGDEXmrekA4wVlzDph6dssfcjIIHmEGzf3NNkZ9y565+9f1X+++U7Yt4kFYvzwzKIcchmzBCg==
X-Received: by 2002:a05:620a:4403:b0:7c5:ad99:9e38 with SMTP id af79cd13be357-7c914262f87mr118103085a.43.1744747079750;
        Tue, 15 Apr 2025 12:57:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89f9890sm951762485a.66.2025.04.15.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:57:59 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:57:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <Z/66RtP7eRvxuVmD@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <0bc2183dc39a949d7eef08d282994231543d4c26.1744661167.git.me@ttaylorr.com>
 <CABPp-BG-XeOCtKd-LvUNGsBGyk6rLecm=BYbUDn-6rGwi=ROzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG-XeOCtKd-LvUNGsBGyk6rLecm=BYbUDn-6rGwi=ROzg@mail.gmail.com>

On Mon, Apr 14, 2025 at 08:10:51PM -0700, Elijah Newren wrote:
> On Mon, Apr 14, 2025 at 1:06 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > With '--unpacked', pack-objects adds loose objects (which don't appear
> > in any of the excluded packs from '--stdin-packs') to the output pack
> > without considering them as reachability tips for the name-hash
> > traversal.
> >
> > This was an oversight in the original implementation of '--stdin-packs',
> > since the code which enumerates and adds loose objects to the output
> > pack (`add_unreachable_loose_objects()`) did not have access to the
> > 'rev_info' struct found in `read_packs_list_from_stdin()`.
> >
> > Excluding unpacked objects from that traversal doesn't effect the
>
> s/effect/affect/ ?

Oops, yes.

> Should this patch have some tests demonstrating the difference in
> which objects are included?

No; this patch doesn't actually change the set of objects we include
with '--stdin-packs' in conjunction with '--unpacked', it just alters
their name-hash values in an attempt to produce better deltas.

I don't think we have any tests that check this traversal in the packed
or unpacked case, though we could probably add some. It's not obvious
how we'd test that the traversal actually produced better/different
deltas, but we could at least check that it happened with the trace2
identifier "pack-objects/stdin_packs_hints".

I think it's probably worth doing at some point, though I don't think I
see it as especially urgent, unless you feel strongly otherwise.

Thanks,
Taylor
