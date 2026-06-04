Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D063C09EC
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555864; cv=none; b=a6ycv/xDFJrR+LIkrsAIKAtXyb/E2mYjqyp9pb+G1cOo5UQVgcCslFgLLfxoWkamcucm1YwxKGsmYSB2G9CZ+fzp9Rwc4UfsUzp9IdpP6h3LlKrbhj7MNoEl3IeFvzB61ZcUFB64AUjMCwf1ywZf+PagRzDb1G7HeTu2BSDztRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555864; c=relaxed/simple;
	bh=nlum+0mCkS0iUEkwKu+bIjcsHFXriDROZnxkkIixPm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1r6HtDLtTvxGoShxA2krtO9fO0KYJNPF2CKYjhcO/ghGek5ktrsEXTGtOe9RgCWJpYaa51FMCFneDDjzUyXnBv/38x42Igc0GFWpry3Kox0f7GZ6UjUO+JhAqEEK8U2v2GNmHczA9qBRVPPAaxv2X85mki0rKYQ9icWI+3kAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6RBi6P8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CakqVe9j; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6RBi6P8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CakqVe9j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97C2D140004E;
	Thu,  4 Jun 2026 02:51:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 02:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780555862; x=1780642262; bh=vN5UZXVtLu
	ORKwY5D18zi0erz7+fKgDvCIxJOdoZZhc=; b=X6RBi6P8VqLxHym8792v4X+mEe
	ylAoulkSLm29bb6iVYC584qR1eg5xLdVhCuwE6zD1nCuYiYaKHCM4pdPGpePEZv8
	tyU943rM98oqxqvkL2EEEbNBSTTtvhvkY/L/8XoebSVHzhePKNBh/6meBKh/X2AF
	BmhEfPibpajkzSw1VmUr+LxR6OLelGstemTOeQjTSEvKJVJeOAx+MlCbUAsZvzKf
	VOdrJgsc5VPSXxmdKmTSh1s9SupaUmgWGaNU/1lMeoSmuI+GJFGVbwshgxk4umCX
	nDgNqWPZ1G9QXZcBTycj6krFF3xB6cP8LE5EMOUv66OMHd7UKtfn1KznDdMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780555862; x=1780642262; bh=vN5UZXVtLuORKwY5D18zi0erz7+fKgDvCIx
	JOdoZZhc=; b=CakqVe9jnWfsQDmdLuaHR1QgcsdKWwrnpdw+GzDyeuh4VOVnava
	N/F6qD9NOyzcecDkB7GARlyf2U0pzbcvoL4/hNoYB66xp2jV+TJJSVU2YhipgL85
	pf5IgbCCCAZQFy2hSm0EycYonnuuEfvz5f4eyVZFsG5/0kxgFhYqp9A3mlwUfv4w
	x42/SUWFyLpZ21aMLfgv0PIl/akPoXdMQ2brIsK05/YA9RJ1HH0wDNMU+wOaldxH
	NkthMRvIekVJlTiaPk7LDgt8m5ucGmre1mV1k3gAPv34JySO9iomz0BlDdmCz8AM
	uY6V0JAPczxi8umjllbVwASyf1JNgn8ZbEg==
X-ME-Sender: <xms:ViAhatCL89mEe3If0RQp_Z6Az3vfCyo_taZyM28ndcEEDRLJdPmRCA>
    <xme:ViAhai9f4ZHbhr_BWZnFfMEz97PzYxSA15FTNyqW-DPLqp4adn1DImM4l5vcZmiRN
    o1ZmM_jF8B-WRRc5JHSFgtAFG9FjLAh0CkxAAJrzPZPVd30pHs>
X-ME-Received: <xmr:ViAhal_JS06qcKjaMQhLb7GafkzbCzgZvf7PXf2JWoQyqw8JF37274-6JBJvagFIzx-cHM7JXQJ26UOnxJYsvw8fr0AoPclGW400qS_nHVo>
X-ME-Proxy-Cause: dmFkZTFO69LNkuDjQfGQX7uvGlKKdJXcDv27sCEbsTGpL6E5rZHmv4SoUqeIeN3gEbS3eN
    l14kcC7u2fuBlk68zEdYGjogRpnWpTiYNFeZU/IruRxM2lgl63Ko8gMVttoP9u+jBk/j8p
    UqjtUAx07K05vlUD2OeBp4L3E/Py24UL7/LhWaEd6XcCdqtv3iwjLo84L/Z7TmjjhVrhAK
    F9Wu03xaJVzUq01gjxU+8BfbVd4uMvOCMhwhvwej21kIlwtQVWvlCnPOLzrobnhXRSR+DE
    7pxtV/jugoFTNHKMq2aoPJc/LJguebP2iXrrYuGFooG3rU98Vu1Ml4ElOrM9tvCXzkVHVJ
    gMZH9pHRejlgDAAotMWm4bWUtPVm9e5uIKz3Ya9luSoi9b9ZTxsqkZlodanJQTIsqgSoMV
    i1ZxQrvKaJqS9CI3C54A4SAe8bEkQPiZBGfuJoCLwqzLVXI9vR+eHzxcrkV0JLBp1Db+Fi
    LQz6w51WbQyQPbUIjnnTtRCcRLep6RbwkJayyz+jO16rpmY95XimeTQvM6bMzCtT89RMVs
    2FxWH0zAbI094TrVzqNuS7g7NMdcwtAHUc95fUfiwTxAQ8pPpYlL/RzSAjR/mNnrqm2MmK
    KejWNUen3BkA4zUYiN88EApyhiah0qILsGdbudMwzOTay5c31FXTSz0sLHAw
X-ME-Proxy: <xmx:ViAhahebjlvZHVMkxchp9VddK5Fds2cewoFzvfGzeOn8EYFgVirA3w>
    <xmx:ViAhamEupHCGDem1m2E43eefoHyHXU3-5xQJKcuLMDCtfPq8RNyswQ>
    <xmx:ViAhandmkGFQdQbdrtRqzDSFLDWgDlc-qdxWo8EYI9WJTIV5dnVjdA>
    <xmx:ViAhaoGUEVwC-d9-oFJFrhF1lDs1HycPIy2hxYoazj1bxLy6DJOb3w>
    <xmx:ViAhai86PS3S--dZR9pwSqpGEU_Tn9eiTcoAzSTnB41gaFH0RiIsJH9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:51:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d17664d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:51:00 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:50:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Small updates to SubmittingPatches
Message-ID: <aiEgUdnL8dkszKFn@pks.im>
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602144304.3341000-1-gitster@pobox.com>
 <c54f3571-ff7b-4caa-b75d-a739ed87ec9d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54f3571-ff7b-4caa-b75d-a739ed87ec9d@gmail.com>

On Tue, Jun 02, 2026 at 11:24:48AM -0400, Derrick Stolee wrote:
> On 6/2/2026 10:43 AM, Junio C Hamano wrote:
> > Recently I gave some advice on how a cover letter should
> > try to sell the idea to widest possible audience, and then
> > I realized that we do not seem to teach how in our guides.
> > 
> > Here is a small series to do so.
> > 
> > In this round, a few typos have been corrected, and improvements are
> > made thanks to help from Christian, Stolee, and Patrick.
> This version LGTM.

Agreed, I'm happy with this version.

Patrick
