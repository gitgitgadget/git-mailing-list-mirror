Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905002;
	b=cY/LQvu7RKvlYst9MoMjhpcprr23wAkDC3XkL7unWqc87OhPLsLqD7oHSMD4iDKbD6Hv
	 ca3MIM4brCyaPicZM6RMazAa/xyCWwjQb3zuH74RcyNqW7MK8ZRcZJuAi1aWBhaoxHTa7
	 3IdbYaHtd5NI3Ca+kgkvgF4HPIpCHkfNQOpj43CtHUWP/LOuBDVlVPBdMbNwJmWfQOCs/
	 TWNZo8VyMvM3VXQckHOlueNVmo/k4C+4WNtRGqny8dkkiR9JMFV/WvPHs245nsYajncXy
	 69X/ngbEG3EfTvV4sdJatkpoRkLp6QNlFKN6MG1kfFaXZGjXSZzES259fAHsmJ5QEPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CLOdfMPElHq0eCmP6SlhRlpszwJbLMKXrQQGz29j+1A=;
	b=F2XBywOYXE+ffOo5EDLLpVdYchEFPqzsZxh6HqlYFEaO/DFTgnYnIZgSoAR1N/XGtlFC
	 Yo5Wigv5DiNJC+ss8piDNZU+JB+LZhKc0kGnOBjn6zDyLpFFLujYuJyhzYbo8UT2f8eO6
	 sCla5Jfebj61merWCmf82M8micW+CUvrFTUu9rE+GR04gAfDs1bf25d5Th+Xm42YypkQR
	 l2NLtr7kvh183HncF7Tc3/TIstqNJEmIkVnUoekxxYSwZ6hCaBVNhlhLmnUityT3Fw/PT
	 VyJcom2EseQbrWoA1osvJjsCSdkdc5JfzrEklHVnMkDxgJoAR7AmVZ6QRIu3cENWuOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Ug4cbLJv;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CB606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C1CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Ug4cbLJv
Received: (qmail 31359 invoked by uid 106); 5 Nov 2026 18:56:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6PNMPURRo/3VHzAIqF+Ig3baK6Yn9xTKYVVMNNSHjaw=; b=Ug4cbLJvxldGvoAAKxW+bRivk5xuI/xNVSN52zkL50QlK6PYWOS+GdK0uYeYs0ufhoV16zrIc14QyOMBsfYh+H8US8H4FxHUyRGXfqbQFFj0BlpV4MwTTIOFNEzeGBH1oo4QiOCo7dvxx/35UmmszHhAU9Fb1wkrYwZE/zaFHIwkbCKSgX1qNdNdAm+pZlz8015/g5oTLW42C9q/nzyxU/belnHJhx3oAFVFSE8fBtjV0ggdVYulWhkm7k1OhN8acDJzQGvZCXxkYT6ieaqxg+LFItCjxBtcwwJvhfC9xnVOU63lKX6mT5MgXeJET9l/FGBH5HRzuWZRzl1TnZKaxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2026 18:56:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62053 invoked by uid 111); 5 Nov 2026 18:56:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2026 13:56:33 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Nov 2026 13:56:32 -0500
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <20261105185632.GA2898829@coredump.intra.peff.net>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
 <20261104024806.GA1492379@coredump.intra.peff.net>
 <CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>

On Wed, Nov 04, 2026 at 11:25:38AM +0100, Kristofer Karlsson wrote:

> No, I think you are right.  The quarantine parent only matters when
> the object directory is not under the commondir, which is rare.  Your
> version is essentially my v1 without the "this is a hack" framing
> (and also cleaner).

What we really want is "where are we reading our local refs from" (to
avoid reading them again). So even if you have an object directory not
under the commondir, we would not find our repo again by looking at the
parent of that directory.

But I also won't be surprised if there is some arcane working tree setup
that I'm missing.

Anyway, what's in your v3 looks good to me. Thanks for fixing this!

-Peff
