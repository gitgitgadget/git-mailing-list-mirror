Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30831DB13A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301031; cv=none; b=YqsdpOgXDAnEYS5hbrz0f7SadP/3tWbJHMPpBIgfHYRhMBUhQVjC/9wPsa6WncZyIht0rDngntZzJTbCLX7WVyQGflnGZ6P0Cpc/sRD/ls051Jl8013zrK1jT+HaCvp3IXzLwmRx24v12X0jnP1AOQeZVZY/TQoESoMYyn13E+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301031; c=relaxed/simple;
	bh=qLY9on1yvtdWibqCxzrCoeLIb0uTh7MYMMeZwrkxcTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBpgrgiWfiPRfFDvCh7Eb45ywJDnz3bCvZDg0lWdMh/91pOPfqKFvIp1s99fvCr+k+ue1T2FH23VudDiBsQREjne3W9emPmknIJKHEfHt5NRekZ2fhNCMxU1mSm68iB52B5/nuLULtc/ETn7UZywaMuqOnKlEwh+Q+rt30srNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p5gmYvwx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KeFRVnqk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p5gmYvwx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KeFRVnqk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DC490EC01B0;
	Mon,  1 Jun 2026 04:03:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780301028; x=1780387428; bh=KKPJnJcjoO
	xMtm8dJRMyvAvlLQxbnXk7tmXAnY5PcQQ=; b=p5gmYvwxzd4TZcGYondKpyuVLf
	w9ExYzdEo6/D0GPT8Njjj9QlV9MLLICI0EXPw4bcv4J7LN8zf0wpK5McTZSauaFl
	4k3GX2XSS2rYlxFw8VQ+Bu5jYyuj5CNVoSZjl9ymz6CxCnI8eEyUciHkMp7zqS9i
	z0sU2OMGuelgttGhEcTWBE1YxGYve31X6l4vgWR2WipMoXgMhjOUnwo+FPSfzaJG
	VtAjv8F/It2YvWfV6tbv7cTsXwfklqe5t6fxU3yYfQRPWDPAD483lWSeMnOSM7Bn
	2GIeLpYJbO1sGWdmR8Wjw0fdF3dSZIz79E4n3x6WLoeWf2t4gL49/h/CQzbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780301028; x=1780387428; bh=KKPJnJcjoOxMtm8dJRMyvAvlLQxbnXk7tmX
	AnY5PcQQ=; b=KeFRVnqkPPbiw6sI0u0ylgQmqOXCo4KzcVV4vxjT0fF2qfPaKmC
	uG5cDlMXTDfeDXxbGoi2C3xQxNG1d5wh+8HWiGtr2DGmOrbQul/A/lkJbc4VWAbH
	rt9y1lPyUXNaaw43ZgK4Cizuqt1HmdthCol5ogFMO5iNPkpz8bNANS6HVmhmmBPR
	ihNVaOG9ACEYoKwAbb4e1Pw72KrLTO/lDgySPkfPn6AZFqggfM+k9D9/KW4S3ZWj
	3xuF42UzMKtusryt3lxLF0sialBCpnluWYHZqtP05KJIofEX4LKvcX9/B+VU83r5
	BI+ztCsFXgLwebAle4gBf5DV4L/1gPYtotg==
X-ME-Sender: <xms:5Dwdai6G2ZDLtTt7I4AN0EI8u3EcEXNUD4e5xJ3W7FGI3jBqg5-0OQ>
    <xme:5Dwdah4VJ4p_BIdsAkM8V-6z_F5qt7CAICSkzbpWQCg-5BNmO95ECJObW2CUrRyON
    dSC5X2GCn-Ao5GWtdaGzarXFq7Hb8vLtWRbjBfTLdW6vKcWafM>
X-ME-Received: <xmr:5DwdavHnjZ8faoEa5yrB39ASL-Vywvd94i1zmEkJDaqs5YTD8LLSY8hV6mEi73WVLvKzpKfWXTkauHtCFQyPKBHdKuMjF2KZy9aA0vPXxNvh>
X-ME-Proxy-Cause: dmFkZTFHfun8MVJYRrUZgjtcZj0kdy72zGHtAr+criDsPR4yf/7VNRdRfl4V9J3ZSL3s47
    qHfm3QCKwr1qMe9qM/nb5/RfhQwgu4sde29WG9KR0ayEGUtu/WLOENT+8pVlwfSZzwv7mG
    8jOhGH4JujOHlHRyP3vq9q131VqB1qP3oFkDnUMVNrmUtJoHB+7jHIWcEbboj3bwIrbVCc
    694zQpoehfHX0Up49b7uCXcrsk9aS/dPJukhGMUw0xt4/T19NJ5l8dIB2jJ4HTYoSI4QN7
    LxJM208Lwef3iBRUNj78BmlHspGqo3dK284nMLJLc0TztrRD5SswDbkRxKAoKz6NWidJKb
    CA9rBFow3qmdoCXkxS0l+7HKBDq85uBIYKhtR3pGVqL3G78kyMgKX/qH7JLeyB2CGydAAh
    p2AKUNWyuq/nCoYteqxCtdLO04WUW2srYpMhvhXfOPoDIuEWRl7D2vkviJFKBnsz0DIxxz
    gAcj81uydbtor4Mns+tl5oQKnmJ3Sk9jgVlZTjisty9S62m3uti9e/7uyQtsaSqMDZM6b1
    h5SRBAu0CGrTw/582QG8gbZpGTVIMMv7qODnJis/u5EEPfiZEMU9JVCx1cMTV8/e6D1xMQ
    sBI/mJiD0lWtQMog+gsfdZTB68fnt1+teH5NXouYLkJy9peDZyvA2w8t54nw
X-ME-Proxy: <xmx:5DwdaqSQ1GW_PdsYntSvS0I0zbMv4BpLe2R1_OgtvKp32oA1frHThw>
    <xmx:5Dwdaotra87jj4gcq-9-gGwGcHe3FqGZzAr-uESnmmtnrsbPMQoVdw>
    <xmx:5DwdapyXF7IHwxbQfFRs73HBhcgZWk5LQrLAby2bue2hvRQz6r9RMQ>
    <xmx:5Dwdai5opu099UWqcLRV9RH3KdUY_XFVCg3Oxg_IHBi6EUJnt13O_g>
    <xmx:5Dwdagq0GDj8qQ_BISaJ2Ds4xGR-TKkhOBroBhMSEf7d8BplWTCSDjjj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:03:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fba320a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:03:46 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:03:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alix Brunet <alixbrunetcontact@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-history drops signatures
Message-ID: <ah084JeFNiNvxZZL@pks.im>
References: <CAPCeX5a6HxD8pAcE9th8+0zhsa-nabRrJQpjKXJrg02zc6EAOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPCeX5a6HxD8pAcE9th8+0zhsa-nabRrJQpjKXJrg02zc6EAOw@mail.gmail.com>

Hi Alix,

On Sat, May 30, 2026 at 12:44:25PM +0200, Alix Brunet wrote:
> Hey team ;
> 
> I noticed `git history` drops signatures,
> Even though `git rebase` can keep / re-sign commits (`-S`)
> 
> Will this ever be implemented?

right now it does drop signatures indeed, but I agree that this is
something we should eventually implement. I didn't have the intent to
work on this soon though as I still have a couple of other features for
git-history(1) that I'd like to prioritize.

All to say: if anyone cares for this feature and has the capacity, then
please feel free to have a go at it :) Otherwise it'll probably take a
while.

Thanks!

Patrick
