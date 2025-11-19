Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBB358D05
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569668; cv=none; b=uhm4HcMfd0iYsBDyJzOutuvYCjJDheFAkhs8Ofw+0Y3tObuiidJfnQPF7fIeGf4cjZPZNJJ6T/VOV8FETnt0JKGWRikcQN2EEHSV2myYX767fKrS9IiZvtMZiU/Cn2g3sAXCIc9TpbUmb2Ew0odK9/VUi1RelCncvLYjiFON5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569668; c=relaxed/simple;
	bh=/Li64VcZUHrgH3+6HAaSpaY1GvktRYKqn5NynVCQRVs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EKe3Kko4BN7eYeKWFNK50G85YxZKCNslDMLel6b8e3VwpW3Mjkh3iDbBrF36BdZ0m0RoaBAjJRKlp0HSpopOXUaVpXqQUwl/k43INVPWtEAkPj6qxZzov8rRtzcootf83/PC8z9LAEhu8pl/AXC2wgbYK07ka41c4gA86IsE1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=nfos1Au3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZI3s3yRw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nfos1Au3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZI3s3yRw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 35433EC0128;
	Wed, 19 Nov 2025 11:27:45 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 11:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1763569665; x=1763656065; bh=1Ag7REYpExsFBmqMjYpcKqXd/A2zLV7H
	kTQhNPEZKK0=; b=nfos1Au3khdfj0zI6Dio0D/8KG26ljWz0gFPcJHhU9tXFujs
	B7wm3CE/4d2/B0jwBMcbxN+5YyG/yrDFbCTjrzbtObgYZFe5iPiG9f0QLYO65b3o
	NLJypRJDIq4WXYuRy8oLdsekm/ELMvgA/l0MW7frYlQg7aM17BMzG93cQt4PNUbL
	tVtZLA4gyiWPhqKUAr+xwgi5O2EpNvZyNSsdt5iJwgoS83o7uGgrrxW+jrRyRDrj
	nhLYn0pOGb9A/7KRQJ0ssFtr0vOBHE0TuasyMpH/24Q1AhFq66XiPaNmjJwSvfJ0
	OBVCzkFNLfRbBLAaVOVqYGxKvBT1So4/YlDZbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763569665; x=
	1763656065; bh=1Ag7REYpExsFBmqMjYpcKqXd/A2zLV7HkTQhNPEZKK0=; b=Z
	I3s3yRwrG3yb7AZ93kFSxwRonTa0D5IPcqdMjobryGtpTOnDjijqKenX2VKcis2S
	HQdtpGgmCuerWavjyPdgdYZvS9O5lUjm0a0DcynMu1PEoURtbx7XBp3gRWgIGxz4
	axM0hxrYzC65mo9jLSCd8J3okv6RUEouTrbaFDCKofkANoKfHUv0S904EiviScYv
	5XGtQhJ+LxJLgRL3xn+xBe69hoHc+DvJtk3tyZTjH/fTX68M6nYeXILZS5Ihw167
	Gmjas0r/Uqd4gWaXfjNkM7zdSNvtiqBvaXcPbCS/SKdNPNjchiu8/P1jGbk+gHPq
	D1EqHgtVI5tR+bGmMFvPw==
X-ME-Sender: <xms:APAdaSVf6KioWRrCgssUQp4YhKs0EIGF7ObPqxtKYW9toN2NAVfSFfM>
    <xme:APAdaZaUFlinh-z9KAOXx97vAiG4Q1rXZEFe9r_HGTwX8FXn6HnoMaCG1QP6S0EU1
    iUas7tFsCS_0e6B79QmAkNF4pShqdeFNDvRF74Ke7FmPhawghw2gP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteekfeduhefhleefgfeuiedvleelvdejgedu
    jefgheejtddtveelgfelkeeiveevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:APAdaWjMYRJD1Xp13HfanGnRUV7a1wv7FRcVumtL5ft8FvYHFOECaw>
    <xmx:APAdaf_RJVU2jG7Yw2rd3nnL2aVf-skw7qW0aF4xgYU-2ONfPphpmQ>
    <xmx:APAdaZrLEkuiPx8mJvY158znDixUrYB45AZlBjfHC9ZMWidGpOiFFw>
    <xmx:APAdafVNVg-SIttrEaQqjD6PHkluDhaX1G26VqZakTxofTN-rEfbGQ>
    <xmx:AfAdaRvwoU1xxAWHrfBbLtpQTTwvclsjKqbEDJPX6bEyK-Z0Tyh42CBv>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 73C6C1EA0066; Wed, 19 Nov 2025 11:27:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Wed, 19 Nov 2025 17:27:15 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>, "Johannes Sixt" <j6t@kdbg.org>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <da44a9ce-6e04-43c3-be1a-5db640c20e98@app.fastmail.com>
In-Reply-To: <xmqqbjm695p4.fsf@gitster.g>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
 <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
 <8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org> <xmqqbjm695p4.fsf@gitster.g>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 16, 2025, at 18:23, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>>[snip]
>> I do not like the latter. If you do not like the former, I wouldn't mind
>> not adding the sentence. The warning should be sufficient.
>
> But stepping back a bit, if we truly want to discourage the use of
> it, perhaps we should officially deprecate and schedule it for
> removal?  If we are *not* brave enough to back such a move, then
> perhaps we ourselves are not yet convinced that this should be
> discouraged?
>
> My preference is to stop at describing, in WARNING or NOTES, what
> the use case that triggered the addition of this option was and
> declaring that the use case does not make any sense (your "who would
> apply the same series twice on the same base?  just keep the result
> on a branch and reuse" would be fine), but without saying "Do not
> use this option".  In other words, the message is "We'd give a long
> rope that we do not think is very useful, but it is up to you to get
> yourself tangled in it".

I agree with just warning.
