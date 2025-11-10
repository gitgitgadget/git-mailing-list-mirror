Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541F34D38B
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757193; cv=none; b=pJ8/ajBQZHhOZUZ0K2F3Q/lurlPoVULO5riIgVARZZY9d65cuEEyXCJgI5nAyHr2EdWExN1RBeiKFvgtDchcpZEBjSjrtdRGQiP8yD4qLVOewdULkYM3ak5jGUWC5+hzrCPdPrenmqLmd5Tpqwoh2L4jH6yDP6hMGeNA842/Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757193; c=relaxed/simple;
	bh=qjaVzuCCNVcCrANYmlmXYsKSaeXD6NHtjqVfqYqIvVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqixIzgV3wq3EZMOmWhN9Ue1LKrvh/5fqAfdiFr7vzp4/8EZ/BnKLb/KeoKiCfkbsb74AjAJnb2OuTEanQQs7W45ZM7OpoE4loX77Y2awyg+aEH/UZ1tE20U2DCMQjfpycC2O1iB9qRTyfmMrYQkzfBb8tnL7dPSjws5r7a5y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jMs4qP4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHPUvARP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jMs4qP4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHPUvARP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 168EE7A00DA;
	Mon, 10 Nov 2025 01:46:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 01:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762757188; x=1762843588; bh=9JC0p8XHlX
	xPxPL/oFooMXUKdiFVNKzet7S8S/maZWM=; b=jMs4qP4Kam4YKWsDnTz6QxIzNn
	yIIwqKv7BkVi1kzeAFoNrWXO++ihguJ39C9BTbaHtjKInhfJfE01+3IpwOfybhGj
	QXAMrK13UswtqFufa/WHReQOVsOusyI+ib3NYdYSLinYy61b8V6mX4QbrcurYebp
	fJPjquwJ9U8Nc7bgeSRjHAI3IoN9lGYboWDFIq7USMeRc7aPn3A+TwwrGUUJIjGR
	9q1AqKkBWesgjatE5yeisc+9Hb7vS5NjBVsRtlyD7eZuj7Jc5mFCn+8vYKZctPVu
	VBIPMobYM3VJ6x0ELX7/26I4rnlgED7LymiPCuO5WtekOYfoMU4zBaomDY8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762757188; x=1762843588; bh=9JC0p8XHlXxPxPL/oFooMXUKdiFVNKzet7S
	8S/maZWM=; b=tHPUvARPdah+8Gs1gcwFVGZ0ZhBthqkJRF1lP7lw2V13vm9yoma
	O1gev/lBSXulJgcJLhLYjiXIyIZ9T6jrg+FN1HOrE+n7YUnpu3KIiMYyIeWFN69r
	qjMMnuW92/qwupNUptZebRJYnZJjn/JCls0r+fTl8kHJRvR/iq8eYcnymlR5w44U
	eGiwYVsresYGyoTzcV1T7A2Qa86CI7mllJwwC5XDUP0khPf5m40Fh3vhcVQPl82q
	qByNGcOHm9FibzPhq7pxZLHKRM+wizdvnNqXjW6q4jSVVIQDvb7qUSAZmhl9EuPo
	12xpQghAOTUEB0UEDYVAZWWFvapJgEAz66A==
X-ME-Sender: <xms:RIoRaVsKhT63RPk_iAo-G7cquxgfZtOQV3Q7PNeCGWUAV3VVU_o6XA>
    <xme:RIoRaVfrBf-g2Vms20deZR8Ja9L97uKqfITcxJ56TU_4F6omopQhLlj1sp472qlKY
    UKJeNKBpWAOQXFPRcW6f53E75AuhGyt7CqeYp6fpgiuLGIVcKn8Ew>
X-ME-Received: <xmr:RIoRadxrE7vmfe4FgrQShq5l_TYXwkun8qZGE06aqf3cEP2BAHnEns3J40WPUK7PsvdRleAwXHItqdtXB55c2wPrA5HU_tEmpGLVTFEiyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfedutdduhfdtleffieekvdfgheegvdevgedtudefvddvffdtteduvdehfedufedtnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RIoRabGiHCraJYxdKId1NibTbNSZROFTY4anuQILurhVW_mvu75pSw>
    <xmx:RIoRaRyByc55IYRDU12UQq66C81eELL9uV7tKZ5TgctrdwyciMkp7A>
    <xmx:RIoRactuMbIR8Vzbl8zDFyvP38DihwpJN9vSs8PPtMA_EBYlgd1kug>
    <xmx:RIoRae2hpf3yPwlKtcolBxRdJo-QTqPk6-fQM50I_R34xmhqfw1-4Q>
    <xmx:RIoRaRR9ZVp5YfuoOvXG_8C0nrU4EObEuu50jegZUyjScTjMDhGidX8V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 01:46:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55bce077 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 06:46:26 +0000 (UTC)
Date: Mon, 10 Nov 2025 07:46:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 0/5] maintenance: add an 'is-needed' subcommand
Message-ID: <aRGKMH4Wc7PJ6Z5z@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>

On Sat, Nov 08, 2025 at 10:51:52PM +0100, Karthik Nayak wrote:
> Changes in v4:
> - In `update_segment_if_compaction_required()` change the argument name
>   from `use_heuristics` to `use_geometric` since we only have one
>   heuristic currently and this is much clearer to understand.
> - There were a lot of discussion on how to return a bool variable when
>   the function has a return type of int. We discussed both '!!required',
>   and 'required != true'. I'm going to punt this discussion keeping it
>   simple as 'return required' as in my first version, since even Junio
>   expressed his thoughts in favor of it.
> - Add a TODO for improvements to the flow when running `git maintenance
>   is-needed` without the `--auto` flag.
> - Link to v3: https://patch.msgid.link/20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com

I'm happy with this version. Thanks!

Patrick
