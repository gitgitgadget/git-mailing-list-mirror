Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8163533D6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665182; cv=none; b=qrq/X7q3QnMQU+KXWcI6pSXCl0Y8hpNd+T/xbrLotmXjm1aVKbcBbqfSilRukyoEwjGqcx/DwHgJEaWuhx0+jywtlkvmEw0i6+vXWfl5Az2CXQaQqYeIZGfo88xkY6ieH3XzXAqW9WXcnwAYMlCJnLx4Eqyg9vQ2FBgBsfzcz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665182; c=relaxed/simple;
	bh=yb/PPkaPZ0qu0aBuuCZVLKFF5TCm6jCEJerUCTs1seM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QelikTJh4SLIfcIJs95drhPd4EO7reTLFrty6u98f6ug9vuSxa2zACnT/XZw4J194WhOdmoS5oLTNvlJBqgqYwwZe+slqTG4WMXTYctX2Oijtihss5y41eUABP3PCz+smVD3FLmaMZNlEFq/ynNQhDBIRm/dAntazVqZiX3+Ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdXkVJeK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdXkVJeK"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46704177543so2972409b6e.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773665180; x=1774269980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azQTWnYhF964gPVKGwLhydWshhWBNIeGV/yjD968d7s=;
        b=MdXkVJeKnTBgGekOeItxKLl77XTdBxzzP/1FH4TzCNweybSs7W0ZQKJCSdgOxs72o2
         EfT9YSEHmtszrmbn7lis/iaYCUY9PglCl9dyy0b/VHeL7YWt7pfBAwRW7nAPD4nXdQmX
         XS8LW6M+5CzpxNK7nDTVGLIE1AvUDt/66doK0slYjpV52QVTZQSRuN6XxH/vGPik/y66
         OjTtCGBv/24B2TLAyRigPOxDNCQPnpSGMw0mWJLiUgGBgJovjJjIOMdu8k3OSfHETMuq
         m2YfUgMYf/0IQE/ugvtgcN++Qm6N7kokEnGVQwTKx45hXHDckgbzQyzHh9kZJqY+IuDQ
         Zqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773665180; x=1774269980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azQTWnYhF964gPVKGwLhydWshhWBNIeGV/yjD968d7s=;
        b=XDOjEG9naOdxowhRHIt5bK/e3U2NqtytkLlf9warq1Jns8TBxUo/5zCMlvO3pDA05v
         9M1Mw77NKuB0t9Xovubsb4Rjz8hmMOs4jSFuKu07WpRwGxgtDCPMTt8XrS69BEeUb23v
         W6yOungN75Bkjw/byPIbZqdDJHKFJfBrDiEk/otEYPBztNiokic7etinKsFm146tJeHw
         QdKJvc+T7vJE0AnGZl+6D5j2WdU0X32qhU/40t6CZ8CYOPAqWGfEKsPOt0IEwTFphYWT
         aolfaCkPnP9yjXU3cLWY+eQoG/YlEhn4Bbj6ifFAJcNK+5tJ4MJ/fV/+GZvbRn1R1fzg
         Q1+g==
X-Gm-Message-State: AOJu0YzxH+XDGRzQe90u+sGU4hEKS/G+uw1dLaNTX15M3epJjXBU964x
	ntAVYgR93RdNS4LBD0TEiYFknXq8b6tgDhW5/rcP8LG1aGT6gG1zmaxF
X-Gm-Gg: ATEYQzz2o0B7K7ZjnPTq3C0ejHb6qNQbTlER6odlS9EHaHc/WCEK5SfHw/vc5pbKymP
	iAOeAus1g7BJqqDU6Ae1GZ7yRW2UhpAWvo5Nv3uvP3H6FmS/JyqynhTYEDhUMSN4wVsR7hkLbIf
	E57fDvD6KqUr3zH1qOR0xHQKXa3jnLGgr1GkdVp0/3fkH18dpQKCt7WGNNw2V2mRUrTen3DRZIM
	a2V0sdFwpkEaQ1YvihWATbBDbgmToXjX6XOw43pEYE/9lfFvkCLyEtogDr69QvtmrRqnpknR+y2
	c5xV8/A81i+rC9dfcTZZUYK+RxPRaO04HT44ygRDnS3oNRXdmus8O6sSQF1RItzLyqK+4PBFCdP
	CW4ckWu4no37mQJBySBYe8G1wFMBuguvUfiJKXk37sAY0kz/E8wLEI88y4q01sXzWrqFs3RzFtm
	8bmavhl9tyN1rfT2AT
X-Received: by 2002:a05:6808:6d84:b0:466:f57b:2ae5 with SMTP id 5614622812f47-4675742c896mr6917976b6e.47.1773665179635;
        Mon, 16 Mar 2026 05:46:19 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm16731632fac.18.2026.03.16.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:46:19 -0700 (PDT)
Date: Mon, 16 Mar 2026 07:46:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [Question] Ascii histograms for repo structure
Message-ID: <abf6l15w1MNXIzo8@denethor>
References: <CA+rGoLd0_gc36EBv_DieVqtjLn1FL39vtT5ib1fEbk-+OvPP6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+rGoLd0_gc36EBv_DieVqtjLn1FL39vtT5ib1fEbk-+OvPP6A@mail.gmail.com>

On 26/03/16 02:56PM, K Jayatheerth wrote:
> Hi Justin,
> 
> I was catching up on the recent patch series
> builtin/repo: include largest object information
> _cc'ing everyone in the discussion_
> 
> The discussion with Patrick and Junio about
> adding object size and entry distributions (histograms)
> to the git repo structure output was interesting to me.
> 
> I noticed you mentioned planning to explore this in a follow-up series.
> I am currently finalizing my GSoC 2026 proposal to improve the git repo command,
> and I wanted to include implementing these streaming buckets
> and ASCII bar charts as one of my core project goals.
> 
> Before I officially commit to it in my proposal,
> I wanted to check in and see if you have already started working on
> this locally,
> or if you would be open to me picking it up as part of my GSoC
> project? I certainly
> don't want to step on your toes or duplicate any effort if you already
> have patches in flight.

I don't have anything started at the moment and would certainly be ok
with someone else picking up the topic. Thanks for taking an interest! :)

Thanks,
-Justin
