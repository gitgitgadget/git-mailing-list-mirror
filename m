Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846995;
	b=Kgp1rTo5oEy5EKw1z1jIk5zh/RyyJWZ7eQu8ZOHULNKOXN9FcB2tnzH6Res0Njr694Al
	 audw17Ku1Tv1QDQc7MSciS1fd6voGWSWtGxggfhe3JMXDwEoBdycFNHzrMJcQNJtNb0AZ
	 UItKyJH4uafEZO0CFCTjI7ckKjUUNNMJYJxsxChbcxenGpFvSU8ZlZw9VmVqlPM6QLKl4
	 YGosOn0TME+O/3KLDccrFCCQmdE+7IFUov1sLNE3bXxsdDyb9d6pG/Xyvc2ab9ilKIv6/
	 6oxuNyUIxBSR4FdtnrPM7FUJYgdcgBUHzbPcXh1M65hXAlCANpJZwOsh0voW2DGEcTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rEhtx469y6DPo5cODQxVAsE9Klh5yJQOoz4V4i4YsnE=;
	b=us1bzFsAcqnXZx3eRx/T1hcBghOzEZzxsKfhgpeZkWmwnvZ8miGssUe6dIAz1JqoN/OX
	 5ZHXoHq8fpaia09hIAMmVOGAhdVBqQI5jK8K3yFdcUFyoMPV88h3Tua7V/QWzYo0P5+bL
	 8FxTPqAh5IqD/haaRVwhkOnuY6f7JWIBxrtygLiHWlxWMQGvpcCTGKYVPH/8jcE4KrT8m
	 e6Iav8Rd7pkyvjmziRbp04QWuVhGlhUkfM76pAgT2njy166wVLQAp+1hT0ZcwQHhC9B69
	 gmtYoYPIF5XcJbYDkgzDruNEsam3EN05bcfeWvcbSINcVVroE3PmF6BPaVpu3zAixKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=PW2LfbeG;
	arc=none smtp.remote-ip=95.215.58.131
Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686F606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D686F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=PW2LfbeG
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O/wNmZB+5n7dA8jcUvKUlK/5+j3HzfBpqNJY5JqLlzs=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792846991; v=1; x=1793451791;
 b=PW2LfbeGjEjdLnrAM7rfdRwOPcxvdc06Kcud/r23QyILLouQpqLjmZaOEuS46toEiQBoVN2S
 6Bk2RU4R1bzFX7pYHVxvInr1nKyiVgkhfJbn3GZCCWIFBfxLwJvzzlCAV8d9iH0dUHXTHK2UHuR
 UT5vAe5m6SkdDXswP+fTI9na9iH2HeB2UeQAtJESIrdMb1ct4+0AGuiOyrKWX0Bp3JKTW8aN9WT
 YAMtaNqL4b+hTZGlGeWhv2tn/4RVCnDWd9N7qs7o0jcft2FY23GAqlc5cl+QsDX/1sR9OfEZY5B
 HgprGw3vVaStJl8F4t7RAT6OotGnuA2MIy+njsYxeSx+g==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d4f2fbd0bfbf50e6;
	Sat, 24 Oct 2026 13:03:11 +0000
X-Mizu-Trace-ID: d4f2fbd0bfbf50e6
X-Migadu-Flow: FLOW_OUT
Date: Sat, 24 Oct 2026 21:03:07 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atysi3EHNTCUpvrT@wyuan.org>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024111856.8s8qu%taahol@utu.fi>

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > [...]
> > I previously mentioned "topic count", but commits are far easier to
> > count.  So instead of requiring two topics in released versions,
> > perhaps requiring five commits would be easier to implement and
> > explain.
> > 
> 
> Quoting the summit notes:
> 
> } * Emily: Have we used a voting process for something like this before?
> } 
> } * Patrick: We need proposals and a vote. Who would be allowed to vote?
> } 
> } * Peff: Active developers with a track record; perhaps a threshold such
> }   as 50 merged patches.
> } 
> 
> So it seems that Peff's proposed threshold was substantially higher
> than what has been put forth in this thread.  Any comments on that?

Although I could selfishly say that I'd like to have a vote, since I
might just meet the threshold in Junio's example, I'm rather afraid that
I'm not qualified enough and don't have the kind of foresight like Junio
and Peff have to justify having an equal say in Git's direction.

Thanks.
