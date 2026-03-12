Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA83624BB
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295655; cv=none; b=ATSNwyon6YLHxT+OOz1LgP6+Gx89Qs2f0XmZvQJQ3ypDD13ckp6Pa4Sl47TMyaM96dFoD3y13WW8jHC5jIOcjrIxKW3VrFOCJoCUTdWHijeq4owMpzXVMTRMjuX0tXCoJWH+arjVlLji9xuA0dPDSqeEAp0tCSN9bXN1o99PoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295655; c=relaxed/simple;
	bh=xd7myCsn1pErb1KyYHKWKa/ZLvaIqu+7kWqLPJmKIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1lQ42hvs4IEbLhjCHrdWdLPWDLKCjEfV88KD/FLDJf97+0afeJNAwVuUDp5uR2tWL7l7RLW6INZlBsb7ocIYdIOTYjwmcL6hetGxWux3t8cNMIqVDXfhpk/hgyJtJDvpsmT79eL/jiBVrkIy8u4Sr7ujCL4kP+bWB7sPluBHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OR68kO6I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2rLyc80a; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OR68kO6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2rLyc80a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FF8F14000BE;
	Thu, 12 Mar 2026 02:07:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 02:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773295653; x=1773382053; bh=6EnS2hCklO
	Xlvoq1Q8In5b9VE57H3rksqWdTpNxTcUw=; b=OR68kO6IdVUvZGXIUXPz6HdCVr
	Mg1Nv8NhN2j07aIWq/MlcnIy++8IEP9tma2bb7wT7DYGSXlKx22FI6dbQw2wXN3d
	1KPaWfr1az7OQ/jewUO6wonndi8EbGcUO3c2V0pIQA72IwRKTw4MKR5RS2uo6M9f
	TVtCdxDtFM5F5fnVLgBxxN6xWET66n1Y34rcyjL+1QYD4/HOp3clVLVj/VvPGW3+
	mAvnzvAwJofT6TGWS9zdM6jmoIYTBzylbaLFFKpl+LUQG6+QJrlxhXmLaJClFVOE
	5Xx4hBo7Pp+4zRvj2ZenFdgI++EOsgf7B70FiNCnj9hgUulaTMRnzM76he2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773295653; x=1773382053; bh=6EnS2hCklOXlvoq1Q8In5b9VE57H3rksqWd
	TpNxTcUw=; b=2rLyc80aBdrIK/5O50UAMmglmXmxxjSxK+9yS80yqpfCAo4ipOa
	9weytmGJcSHNYjnu/yrWgdQ/YOClzQg/nE1nNzNJU4bVEfj92WlLVpGONVHpupAw
	3phBwd0HWUiabxKUo9Iw0P8Ysd7Vefs8RaMOokr26iGMGBHugMAGlHw/NTmIdRWq
	vaM078qFMF8BrNLtX7VJwWw8Kg9qZiojcz2+BdyD3dGsC2x77nD1qreO1x45zeGd
	MUSApNLMerSB6MmUjWvzuGH3WFkfulUZvjZVgwcEyM11dMzivMEi99QgLIrQeywZ
	r4wztk6lty1DXebXS6iilw97c2yh/QfBE5Q==
X-ME-Sender: <xms:JFiyaaX-MMwFx5k6c5asF3l6XvOIkCkzTOc53GsMR15i88LQu8CCaQ>
    <xme:JFiyaeChkn1g5c_4W8BjqsarFWCF3HjbZt84wIwKBhiNy_w06UQa0cL1NnHpq5gRC
    02b9voyntyw9oeXjoBmhIOXq9hOmIc7jegSnW5N8ZeMUjIKTvDmUA>
X-ME-Received: <xmr:JFiyabw03OPoDVB4raoSh6Zxb7jeyUpW9enHk3DMmuOYrZDS67pPwPbdJ5KvocazbdqkS4X0-KQ02DCBoxjdwWYejX-nEPn-upSJ4wxao65AkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeitddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrdhsihguug
    hhrghrthhhrdhshhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JFiyabDfPWq1tDeXTtTY82mCAb0EQRel0PW1c14_TQtWT-LqlVievw>
    <xmx:JFiyaYbZ8RNFdyGPe7eb1CzbRtRjNkgAWzKCuLKcQwETEUV_QJOHlQ>
    <xmx:JFiyaTiDgY0Q6S1nxMd7KU0jKPS444m0qRfQcHmSgGFT6B5GgLgRMQ>
    <xmx:JFiyaa44fJHLdqHlMjPRzHI0rA1cMC18IQOx1DW9R0wvRX-OEP_QyQ>
    <xmx:JViyaSBkyXaN4ArbWOH32WP52pi_D6aeyKOlxGC9y4hM556KGqXL8uV6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:07:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99a09063 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:07:30 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:07:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
Message-ID: <abJYHmKiXqiXjHhN@pks.im>
References: <abFP9vZOVHGI536G@pks.im>
 <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>

On Wed, Mar 11, 2026 at 11:11:20PM +0530, Siddharth Shrimali wrote:
> To support the SHA-256 transition, replace the hardcoded 40-zero string
> in 'git branch --merged' with '$ZERO_OID'. The current 40-character
> string causes the test to fail prematurely in SHA-256 environments
> because Git identifies a "malformed object name" (due to the 40 vs 64
> character mismatch) before it even validates the object type.
> 
> By using '$ZERO_OID', we ensure the hash length is always correct for
> the active algorithm. Additionally, use 'test_grep' to verify the
> "must point to a commit" error message, ensuring the test validates
> the object type logic rather than just string syntax.
> 
> Suggested-by: Patrick Steinhardt <ps@pks.im>

"Suggested-by" is a bit strong, as it indicates that I have suggested
to work on this in the first place. "Helped-by" would have been a bit of
a better fit.

No reason to reroll though, this patch looks good to me. Thanks!

Patrick
