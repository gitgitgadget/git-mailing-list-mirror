Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747E1993B7
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460880; cv=none; b=kKSC3DQSftKIwNiDFIwdqL/j6pWc9cur9p/AgJKDa4kplwWpn5E1w+iqijFUBxjlCF88AwzQBsysAUqm/pxXfW5wJLcwUtLnx7Pn1rLoGl6bZNaKuCvCXIfjOy5zvQtluFGifZ+l6M815Q8qF6cxR41UjY7DpWYIy2mxzNHGcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460880; c=relaxed/simple;
	bh=T2/wrx2Wpf3Z6sPXC5PIwBmCIDmlOAmR1LbEAkVTFkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI+drvZIaJpUURDplpPB146sLggGyOZ1tXoestHGJu5Vwrigdn1FjeiwEsPrKXFF3/vMxUwd4xGVbX55MIfyrsEKk9pJ3SaEaEhgn8ukIHqnn+iSsDZoEIb1YFHpvYWO4ZSiZU7KuCdNoy5TKm8QF5IGLViowbxhQC5JWdgVvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lif1M3zn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R59vaRWw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lif1M3zn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R59vaRWw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B5B57A00D0;
	Wed,  6 Aug 2025 02:14:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 02:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754460876; x=1754547276; bh=T2/wrx2Wpf
	3Z6sPXC5PIwBmCIDmlOAmR1LbEAkVTFkU=; b=Lif1M3znGmZvuAGowuqznrNyft
	W5YSDUmTN518tt5WOPD5ZNDi4HOG8s4zgNK2i84RJ5UOvp3lJBAztokzvrRMK/l8
	4pC7xiQxum5SYMVvuEw6SuIYKQ8gaUNzAKNEeAM+n5yhZHjmkHxWxWpBGnMdR9hB
	O2HTNDg9AbwQccfvGrYhu2WPM3aIspoRvqwtITFHFSqTU93ZMqS5TN+ia328cF8g
	xBWMrmdkGYFDIuz5BCq2hXAKhIBsbHnnMslXnXJHZlQWiwb/l1mPDmyKYoc7bE4b
	uVTxaG4uGkOg8zFdXzavxUW2Kzz3Dwl8tFj1vUiQMRcfwUF3HxMfKCBGVN9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754460876; x=1754547276; bh=T2/wrx2Wpf3Z6sPXC5PIwBmCIDmlOAmR1Lb
	EAkVTFkU=; b=R59vaRWwldLns2WvX1OHASOPMLNWC2l+AlnwN/yrvMfAkLE9bGu
	ttTh34W4bd3yuCgwsE3KCN8iPEmjkNko+XroDuT+a56gCQDpyvt7+oFGImOq/1nM
	HtqJGILJmokv1Uacel66sSuqwfLlGICfqn85rdbTPykk5jl5a7ID2+EdAhY621/L
	9TTTRznq1kqyrNcaNliPUSnSV+1mF1IUieia7/aW80B08Vc1KBtl/BCVoLLpLUHm
	oyXPp6R9JzL4qI9fj34GOJN10GuMkWhN229D2z29MxukEDDkdywjKcp0sjr4SCs+
	3Lh3khlVId50VYJUv5Oeu3+eNfwZ5/zY0Dw==
X-ME-Sender: <xms:zPKSaJVKhTShz4YIqxpryC1OItftyNvtddM8uZ3f3-REenLZZ9_38w>
    <xme:zPKSaM2nnEnu-SwQpVvklxvL8xY413pPdZP7JMilF8_Ak6I2H9gD5NXj-dEpi_29e
    Nq894H4_9wBpVxEIA>
X-ME-Received: <xmr:zPKSaO0jPHZ0MGimKbAIR5kymzv-jbqNkszsHTtu0pjV70wJgpQz6UYhF50KHIcdih-OUep--TXj-lGzlbX_d9X8eQgGjqOi9ly2TLR-IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhurdguvg
    hnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:zPKSaH-1v26tWMwl9jW1x_m0CPzl3jGF7rEmEq5y0uSZposCczeSGA>
    <xmx:zPKSaD3iVeKOLcvYk5SqDlm194vZrOuuytz_MDgcDipKb9KbfxQrWA>
    <xmx:zPKSaM8r42sB2lui8lnah6pmVpxX_VvKBsgryAoQtqMKE93gLchv1Q>
    <xmx:zPKSaLthGFEWIE2zt0P8KW5lS-sJFg7e_Om4crDmiy86Us_6lvltmg>
    <xmx:zPKSaJf-1rtEQXR6gamI4XSEKnnKystyyZ9X3bH-ZW2qaAehcXnpGjzK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:14:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86ba4391 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:14:36 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:14:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] t5516: remove surrounding empty lines in test
 bodies
Message-ID: <aJLyyPpvlFjwBCIA@pks.im>
References: <cover.1754375026.git.liu.denton@gmail.com>
 <cover.1754455931.git.liu.denton@gmail.com>
 <82b09af4ca8e610dd06b94be560622837a35d3ff.1754455931.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b09af4ca8e610dd06b94be560622837a35d3ff.1754455931.git.liu.denton@gmail.com>

On Tue, Aug 05, 2025 at 09:53:39PM -0700, Denton Liu wrote:
> This style with the empty lines in test bodies was from when the test
> suite was being developed. Remove the empty lines to match the modern
> test style.

Thanks for going the extra mile. Tacking on while-at-it fixes like this
is what ensures that overall the Git codebase is trending towards our
modern code style.

Patrick
