Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974620;
	b=aflRA0b1M0XfYHihJdMGYmpkwLip8czbSA7QuBIOqFVwY+9OYQPwU0Kj7e3a5Ga1LP3q
	 DhLzXWcYlIU4OqcXTDhOWz+3RU96AVLWVDo/GzLRHNrAMGiLwrPxVBrTMa9CBvHJ0D046
	 pa7xk0u7F2glNd3W9LUOJtkHmgweZTC+tNG5FkWBM+jxf3b+PKCDk666ycPwVuW2C1ssw
	 SggmBDDX0iRVFLNEgopie7hygg42bew6+JtZ+7pSEIPQ38UNpSOzek9IZLV8OeRURIxiL
	 vbtr0qFPGKUf8o9ZdN3W0XMTVy8dOfAWeFjM0PJIz2+1PnG7WS9tw/TZyUtOPeGn8UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974620;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vS2rmRGxTDIriD7iM0oV8f5QoEZUfxEtJTAbafw/aLM=;
	b=lv3QnIwtiPkQ5pOUDkF8K3n06jtp0PrkbtcpPV9uPi8uL2qyhcZe+OguI0dhv8qN6YkG
	 MrdAejJSl5vUUoOeHdDGx057TpfYKpPZqslXDUKYKC5Y+0LmBiPnJWQ1wWNy1cB5xvPa8
	 K3feAaLGaQAcfV4IfoxA9zNe7Vngp4gNoMFknVPaObz277UY2oJ8XM8evQXSp2g+Wv3c5
	 3muI8V24z/Z5IwCCTAeEZVPZm8zEQVIhO5N+jul/h01fv5gihjCnfIEgTMjeG2Tp33BW2
	 XXpCtCLyQc52pDC1tcjN+VKGTKgf2JKAjMKoOBX0lS78aW8V0gwLeZ6j57qIGPf+C2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JKzEUtZh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3WhEd7p6;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D3606D804
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8D3606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JKzEUtZh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3WhEd7p6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6DA07A00BA
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:16:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 09:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793974617; x=1794061017; bh=vS2rmRGxTD
	IriD7iM0oV8f5QoEZUfxEtJTAbafw/aLM=; b=JKzEUtZhZc9tpD7Z6Tt3ShuBcx
	9Cyc4y8WvNxO7X2fOduCLnW+4bWvedDW88AdC31Vhaw/5ab/fCZ/luVaH7LgviN9
	Z3LKT4Iax4MNXyedjFab5PqeLUJszWtVQz1t56FtV2tvfq/cWDBFmFGt+N7AjwCT
	j2qI9NwJmH7MPywfJy8b5DRnw3D8HvWqgZ49hL/pn+oe+NW7ieV0Emc9dl13P/zW
	sk/zKYbQ5IIjLBpwtfLi6XAk6rZfyLWWB3jMHltYA64FJFokNCk+IwktHqMc0mFu
	3qO2lABZyOITh/y9DTTk+WHIHEbpMlLWDu5HpAYhy5O0GaDtGH//sPfkk+Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793974617; x=1794061017; bh=vS2rmRGxTDIriD7iM0oV8f5QoEZUfxEtJTA
	bafw/aLM=; b=3WhEd7p6XzC8cjXru0VXvZ5XFApGmV8dhQELIMT1+2oz0EGiPIM
	NT1SLxqgeq3MWwtTxRzODI4KE+ei4E4ljCMrxjl4t119BXS/nWbZzYf304sf6J17
	zoaW9CSA1Ne4wn2d/HpYPsVMSkFUKEVL9SS4TqOk/G3pYQBbkFQWwCtAKBWl3uzQ
	qpwOGij+R3yRs3PFxNGJU8Rl1QfuxuWyN9I6j/Ed08EhVlKDbongJGugra5fryVR
	8+IF8WZJuC7TrIxuOybiwUG5Sy0/htExVXmernkHNKftYwnkcYV+7Iw59NUkEp8G
	e+wTaDEeBqHz4xlXiLf2YqCtEyCl2ldJxng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793974617; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fyGezcZcyw+sD8h8v5CH2Nd+Uwjs75d1FQvLQefuVtPiUHt
	AHUabOf+NXMjN0Mtdp4ayxQMo3j2lPwHmyBm2sGFML3x5YuG/ep6ix9yaIxizFZl
	Ukvf7YNlpL6dIcOLKkvAS3x4FPpMRcDqHJvm2cEu/xxAlN9PysT51TXvYqqstToz
	4Zt9IWf6jmXj4LRCFjDQCGUoTPhov3MIyUOPYPq3bQWeoQf6KFYferwILJadcq8Y
	Tk+Clc+76DlG2Ki5MbECYJB1nTjBb8HJQ155PhcIHiCRaCC65Afatxv5JlfTylek
	JuQt4LWbDzYuwHilepjlARIl9cvw0XgrPGh1PwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WwLbDmCQij5YIEQw1OGVy1KHVXHzK34D3EzatKEmi4Y=:tMZSfwIJ4np+DV3JFdIaQ6vP03E7/NkgLoopg5RMjnI=;
X-ME-Sender: <xms:WeHtaq3q1bvsN95FUW6QtEk0xe2Mshe_MP1NiNopV2mOpPHYQHAASQ>
    <xme:WeHtavVdNoeUgDkIvES_WVSOr6589IKwzA-OwSAsq0rybUINi0_8lcbo-TGtWxFOq
    urC-IWyV5nAb6uhuYUH8usl-EFQ_Hkmtnd4bon_mDgkANfP5I_tOw>
X-ME-Received: <xmr:WeHtalL7r2kGBQ8aUmY-0Kbz-ubRXd8lq1jiKhjnTjV2JHy3mZ1B4zRm-oP7tVHFMiYFdA>
X-ME-Proxy-Cause: dmFkZTEWeDAhXPIm5SQyvDaF6yjvCGxnW0wCuXUg+AxGuHY+DjxXqxnZnNNmxvR0OSVAoF
    4zhmVgXuzJLN/AVGYnnF+QiuhfLCM6iCMb1u3TLsQy3wstNOOXyFpsveqDOVX7hOgmmTn5
    0+F45gYF3jtf9ZsrDr+FsCNyjPva3HZq47BjYpXPUOGQQvmg+21ObtS7N6hNGMp1gVMr8R
    4wAyM9mTIYAQKtHK4dcCqvotFmnVeUBJ8lu9jb2Iu1SL3ezKeTeSpzZP61TgTiu/bW9Dqu
    rGlp7/My7AXO3igvmoHNCumtlErrRc8Trf5eM++S8VCfABulhdQB/gWnX1c9IlLmIYyPEr
    zY4RGkfgLE4F/W961XwqYFnOpIAQZPssvRZOWz4nSXw+hMpVRq03AtWidK3KPObXYzyFYv
    KUODRzqAWa/qBgjDpSL2HAw7lu1wo4CitCE3nXaDYJSZkf8lIv9lsKDx2A+iOO2s8gBuJk
    /BOctNb86VFBqS/Cc2gcnAk9clxRkzCs8L9g3258V/8fIm88lfnhcRteGUNM/ni47lhjWo
    GCRIhmMnyjVucOEA2jxFUwbgn29s00+u57zIMNZ/qlstOed8dqfTgqZVdoSxdRQSaJXLO4
    U/td8OVlkgREGGvHSC7QKZ86cZZscS/YRFSEZX6Yqno4ga/PVJqxMp8O8jaw
X-ME-Proxy: <xmx:WeHtah0cAXaEmO_Agbt5YkaX58hbIAzFUQmKl-lH9tEB-xsLhX1zUw>
    <xmx:WeHtar7aK5ZO0oF-fI2gtdJXIelOlclgYP53IM368SE9Rj91qNou2Q>
    <xmx:WeHtaq82qBT-bAu8DzLIz1bY_Gq1otdpu9Na9IW49Ftq8PL9PplfJw>
    <xmx:WeHtaiXe7osS5VOneOW45sH3_x-YzMyzK0fSTrTlTN7md60PBUsg_A>
    <xmx:WeHtarJ7yR5ra3pdg5xVoIZzanZJgH5JDY8YfLFXjsBr4v8_nLMoKyvj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:16:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72ec34ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:16:55 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:16:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Joy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	"Kristoffer Haugsbakk@imap.fastmail.com>" <kristofferhaugsbakk@fastmail.com>,
	"Christian Couder>" <christian.couder@gmail.com>,
	"Usman Akinyemi@imap.fastmail.com>" <usmanakinyemi202@gmail.com>,
	Joie Joie <soniqjjj@gmail.com>, Tanga Joris <tangajoris@gmail.com>
Subject: Re: [PATCH] repo: zero-initialize configuration values
Message-ID: <au3hVGPuDyGVwOw8@pks.im>
References: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>

On Fri, Nov 06, 2026 at 11:59:28AM +0000, Joy via GitGitGadget wrote:
> From: Joy Gundu <soniqjjj@gmail.com>
> 
> Use memset() to initialize repository configuration values to
> zero, removing the need for explicit zero and NULL assignments.
> Keep non-zero defaults initialized separately.
> 
> Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> ---
>     [Outreachy] repo: zero-initialize configuration values

So I guess this patch was split out because of our recent push to not
make further changes to `repo_config_values()`? If so, it would have
made sense to point that out explicitly both here, and in the original
thread that you've sent.

In any case, the patch is obviously correct and is a good improvement in
my opinion. So this looks good to me, thanks.

Patrick
