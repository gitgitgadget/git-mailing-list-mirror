Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E78062D
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145099; cv=none; b=UUwaNw9mJ7xxiqS9bRRzsqoYwQ7a2S3xK+6X36ISYJr994qZqY0LjUugRyAu3BJ9+oKwIEODAdpuc2WaJTp/PaxJAhNF8KRD+BDP3tErDUn2/Gjnbsmh2ebfCXs5pXTpbDLnarBruleg2U1tGYJhZWHko9ANP1eu4PFHa8nZa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145099; c=relaxed/simple;
	bh=oXWUOWn39F6jc9G9pMPWhzbwOzyfZ83oeD33YAM7L24=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HxCkRbROLLxHrlb4ZubwWSW6SaHEF5eaWY4QcJRSEGMu3j6yt/jOfc963sp6b7uJbLNajTUsDficcifzA4PQztsvICIHVscHXcCYid7hS0ooYoU6NKojryyLV/9E561I31bWvixpUbGb0o5D9zRZAlwa2wxIzlq8LaCdPnp33/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=BH5cAlaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6jZdrYk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="BH5cAlaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6jZdrYk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C3ED1380066;
	Fri, 22 Mar 2024 18:04:56 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711145096; x=
	1711231496; bh=1HnM3+synmz/isLWwm5XfXF4NFzUI/AE6pLQYhgu+7E=; b=B
	H5cAlaALvljjoTG/+KoEad4Pn6/E06ASx+4tEvxnm/tFrZyOUVTbKDw3L2TO4byn
	Zn1nGFFs4v+kJ+Bxtl8d8+aXKL98xguasKKSSCyo8KpL0mkGZsbbfNxUL1TOx1Fg
	WAKmweS5qXySxIyFvDIT0tQL9xUZN0hj7JQk0epCTKpPwrhvYldrxyhQM1HF6V3Y
	k4JHSCAGNfnpA+H/z21exVlBdqocDasCDwZzYmsoX65QCVbDKT0uKzQpgNU326KM
	jInDYQHz8/hz0yJS2tBHhjNNkz7wHyG+2s42iBqga7L/RlnIsrRPYQGiJR+bfcxa
	7NBgQqR97mjUOGmSjjO9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711145096; x=1711231496; bh=1HnM3+synmz/isLWwm5XfXF4NFzU
	I/AE6pLQYhgu+7E=; b=n6jZdrYkteKVl4TbOazC1LAlHdF8B4GELPs/M2xQY732
	OCS2BZf0eiD2c6pvucspGwOmxXEBiRTLBksjzeUSGYE0vBsc/yiFaBWp2yUGoZ1x
	8FQx1vsR8xTOhO87oH53heSzWE36nrfVYXDALIadA0k3nnJJGHw+CIdFstm9//Mv
	iEU58mie6HzT+JxhPAreZGunetgt5JZq/n5RwaJ7jiZz+n/mNap3qQAJ54MBBelD
	aXUbCV7Bj+0swiWPdFplLggiB0hA0rmrTTEUoQSzSO2MBcw+e9uYgzjcnIROuwf1
	U0bI43wUvMCOQKBnsYrSpWUt0+Y10oPGcR9753ls0g==
X-ME-Sender: <xms:iAD-ZVZqr0Q-nruj_a7o1Jk_SDTxFacqXWavySIVHk14cwt2bJ2NISM>
    <xme:iAD-Zcamd7thnNnmN9BcviRmJs02GM6DeYCl5kKg0do-2MD4l4eyM1et022CCOxdF
    b9Jd8rXss9iFshh5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:iAD-ZX8-sLvwlaqxjKTrDgSZ2jAx_H-ScXMGnjb6uFlbx2BDUq7U7g>
    <xmx:iAD-ZToiKEbrTQ872lRApGKYu3z6atscwK5BQoOr2T2uH3rEa_mx_g>
    <xmx:iAD-ZQpzkgOYzhTSw4pn-tBsDLtvRX6MlJ4VCRnN4kxsDWmhDW2zYQ>
    <xmx:iAD-ZZST1FJM8IVu8eLM6QYo9a7pWQ4PYfK0H4n5Zx2i5zB9_juX_Q>
    <xmx:iAD-ZX0Xkf4BEt8Gm9I2fXGiY8RYFYZUajcRf4D-3sgnS41YUNS0qA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1DDB615A0093; Fri, 22 Mar 2024 18:04:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad20990e-1328-458a-a142-7d2d93bda170@app.fastmail.com>
In-Reply-To: <20240320003139.GD904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
 <20240320003139.GD904136@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:04:31 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] log: do not set up extra_headers for non-email formats
Content-Type: text/plain

On Wed, Mar 20, 2024, at 01:31, Jeff King wrote:
> The commit pretty-printer code has an "after_subject" parameter which it
> uses to insert extra headers into the email format. In show_log() we set
> this by calling log_write_email_headers() if we are using an email
> format, but otherwise default the variable to the rev_info.extra_headers
> variable.
>
> Since the pretty-printer code will ignore after_subject unless we are
> using an email format, this default is pointless. We can just set
> after_subject directly, eliminating an extra variable.
>
> Signed-off-by: Jeff King <peff@peff.net>

Good. I did feel like the code was kind of daisy-chaining assignments
for no obvious reason.

> ---
> This one is enabled by the previous commits. And after this now both
> callers of log_write_email_headers() directly pass in "after_subject",
> which makes the next steps easy.

Yep, these changes are being done in a nice progression.

-- 
Kristoffer Haugsbakk

