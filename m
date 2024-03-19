Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63C3EA77
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884512; cv=none; b=VAj5/mtmlr//jntdiB6kUla4kmUW0JpQtMNmHhdllC2yuidXbd+hBplk1Q0dYDpagFtYfcUbddCc9+/+b6bz6eopnw1ciwS5eeM0nRkm2tu+2DHGIejRgciJFS3kRYS968wE+a/ZSw2wwmm2TVumK3S8djDARpkBV4wsQgfxvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884512; c=relaxed/simple;
	bh=xP6622wXPpe9ixEwkPgevgwyCH8X0heIFpiM+bqNE9s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ukHXfnjEyuzFZqY3CHM9tzz8sM/HkSpfikzResEjZfHFe122FDRJF/pr7oCogbiwK+R2T0/mZN/o85A1ZT/VmlnA/HATJpluhw6p0Fpi4u1Hy3lyzWZlt12DF1irxDnE8KUF/WALOPeLGE57cjQzZ1/fpKuaR1QUOxeeFMlE4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=JJU+eyKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=km8qk8pO; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JJU+eyKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="km8qk8pO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 9E31A1C000CA;
	Tue, 19 Mar 2024 17:41:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 19 Mar 2024 17:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710884509; x=
	1710970909; bh=/WS6R9mxzWae7hKFbeKvtyrMfM+2j66yMqmRdzs2UCc=; b=J
	JU+eyKstK9cFfyMVovA9ihGJWlc52usTcsPRYqpAYdklyKvqsnYSXwHViyTAc8F1
	pTJuWpu1V/G4Ux8/cU/Ys0Y226ivtMTZQzSIDDtHr4D1+YDxTg6g3rWbuOsfP5Nk
	uPEx3pYg1BTm65LRzeg1W5ts+ntIGCZXWnkptsCFZyx0yRZ2S6XnN0qreP3M8yxE
	i1do+IRxmY7iYmvDrHK4SU5LWx4+gC6f8aDSNuK9T3KDlJlLIpJRLg56nBY2YzEL
	NOQ4veycpI2La1CF7lAboUtegkQ0LczuNQwoMdlanvlosCeyYfQbN/hewRssWZ/r
	2GfgK/i4GC/5HbPFLj99g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710884509; x=1710970909; bh=/WS6R9mxzWae7hKFbeKvtyrMfM+2
	j66yMqmRdzs2UCc=; b=km8qk8pO43tlY3NSQVhBvSfneRjQZzfkZaxr2eNgVhKR
	GdpW1jGKqHipfvX29o2wu4/WKGUX7fbFCEMLx3pdKh19oRUKlBWig1xxX75Xy/Qh
	hqu/d6LpCpZ/RuhAvx2RQkooHHggSNrZwpttRFUCyt6PpFnttLrLkLNRkeudmqwL
	1Xy4gomo9UdSmRSeIKOAn0SP7wVvyBK7YCqWgwOxJ1emzz3pcFnEp7F55XCN4RKf
	9KYnvH0y1wIaLhV5vArxj4NqREQZRHpyDll4wwRwm0C7VLAXqhK0KFdgZNb2tX5S
	FHdKo1MHpkMrjLddXwEoxMXJyH3BN+nSu7Zy5gVjRg==
X-ME-Sender: <xms:nAb6ZY9AhzEsXgjSU3Fc6dilMo3JEnkRnaMLEkNXmWcHMjxdc6gCVr4>
    <xme:nAb6ZQsTYWhP43spyGwq8t_vlSJIaXqokgBJza7YJwyndUrDOL6Q7JL_0FncN_7yZ
    y-XcsbG-tkEjZKZ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:nAb6ZeBV9bcjckHXC6oCqzsg8-OLzvhviYr8LA76jwbzQd9Z1q9eVg>
    <xmx:nAb6ZYc8AG799Ta7mJ5urayMEqntBqvgQ-G-TfY31myXiafewLZoqg>
    <xmx:nAb6ZdPTMidgtN5Zp2WUJA_dYwZn1q6bCiX8EtWhE9KUtjQNgBWn1A>
    <xmx:nAb6ZSlfXhw4gjFKg2yG6t3TID9pnPLIB1fsjivRJYqU-6C7eEbKmg>
    <xmx:nQb6ZWZoZwZ57iWe4Q_s0DVpdLBvCuKQ9jsRHORflK7FigK_lo4aScA8VhY>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D7E7A15A0092; Tue, 19 Mar 2024 17:41:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9cf0dfba-355b-4670-baee-a30d53976832@app.fastmail.com>
In-Reply-To: <20240319212940.GE1159535@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
Date: Tue, 19 Mar 2024 22:41:28 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] revision: add a per-email field to rev-info
Content-Type: text/plain

On Tue, Mar 19, 2024, at 22:29, Jeff King wrote:
> On Tue, Mar 19, 2024 at 07:35:36PM +0100, Kristoffer Haugsbakk wrote:
>
>> Add `pe_header` to `rev_info` to store per-email headers.
>
> It is only just now that I realized that "pe" stands for per-email
> (though to be fair I was not really focused on the intent of the series
> when reading v1). Can we just call it per_email_headers or something?

For sure.

>> The next commit will add an option to `format-patch` which will allow
>> the user to store headers per-email; a complement to options like
>> `--add-header`.
>>
>> To make this possible we need a new field to store these headers. We
>> also need to take ownership of `extra_headers_p` in
>> `log_write_email_headers`; facilitate this by removing constness from
>> the relevant pointers.
>
> There are three pointers at play here:
>
>   - ctx.after_subject has its const removed, since it will now always be
>     allocated by log_write_email_headers(), and then freed by the
>     caller. Makes sense Though it looks like we only free in show_log(),
>     and the free in make_cover_letter() is not added until patch 2?
>
>   - rev_info.extra_headers has its const removed here, but I don't think
>     that is helping anything. We only use it to write into the "headers"
>     strbuf in log_write_email_headers(), which always returns
>     headers.buf (or NULL).
>
>   - rev.pe_headers is introduced as non-const because it is allocated
>     and freed for each email. That makes some sense, though if we
>     followed the pattern of rev.extra_headers, then the pointer is
>     conceptually "const" within the rev_info struct, and it is the
>     caller who keeps track of the allocation (using a to_free variable).
>     Possibly we should do the same here?
>
> I do still think this could be split in a more obvious way, leaving the
> pe_headers bits until they are actually needed. Let me see if I can
> sketch it up.

Nice :)
