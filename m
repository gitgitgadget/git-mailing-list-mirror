Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E711FE44D
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782892; cv=pass; b=U0oE7Vw6ll6E98nno8dPM4y2HzImKn+Tq3k/AmbIg2oYUR4xelFAZRwZVVJRPD4BfL9tAMcq/tHpwaN4JmopgGRk2mOuSNc4auIiOSlMn8+jfg21QC9k+oswrtubV9YHF92VOoht43N3jO/E6J66NVnOAIZQhacJLplSKuJQPuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782892; c=relaxed/simple;
	bh=bv5Di4gSO9L7IOvzFvbM7SVdWz8+hsxQYk8qGIHxM4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqwcoB3RecMe3/nUhIEE0YwytoHTs5btuGUypoD1Q2zo3YrBHi1knrKitZebAq8wJ6JE4XqtekiGFZsP0VRS2E4Me4ye8HxNrXix4HDxg3cvqYoGdC6n0fybrvVBWfAxH/SqS2rv9FGD6SbgPp6gJmL6E0Osff4tTdBxXqzjwWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=uL8OG7QH; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="uL8OG7QH"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4CEF9183A94;
	Fri,  4 Apr 2025 16:08:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.125.203.154])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C3279183F34;
	Fri,  4 Apr 2025 16:08:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743782883; a=rsa-sha256;
	cv=none;
	b=umFCawrPARjam1nUkzyRHaEiFCyC3HC8MoltPBxOC5f37bvA55JzOj+XwIZFj9Sih6toel
	3nswBO22vqvDNAVlhs+f71/UgKZtMrPOo+vuH/8KnNnH9/YWVoPEdDwIzliBsbCwvNmjbn
	XK/PyeSVJ0viM8O5upBM7ZUo1EMYRuTy26eqx2nnOtdMjjx+VGrsbEfJTleqNzIZXhOpw5
	P2Z/cYxPp6hQbj/5SMaeP84uRqNa3DmLd3PKnKt7WjX8UClPk3vyQrvjaYSXrm0GfUS1+p
	c7FpA11HbU/jDhEcgNCivyxapy7ykTIthLlBrUOXonRa1+jdj9xX4BpoZbF0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743782883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3ECTl5s+vZfxkpehr9CmnQQuyg0IENpEEDz1h3tHmlE=;
	b=1SJQOHfHBbRiE0esDy45v8GDmIcyr1yDfuzry/27QSYI5NMRa29x0JvAnumxmjcfi1uSt4
	E43MfEzEpuAMFvqR3yJ6GRcsjF/CpHXIbqc09YpNYREprqRYQ+3qkexlEG9H4HInPYDd0v
	LdKZbeYx5v8hy8D/ZVWaOH+r1MhdLNb2fffju7gSVPGTmlh1A0JsXFEf0GNvoFuhLRRRxL
	p4AdT3j0rRv3lNlTMOpRfVlLfaHDSHk/2wqvhYiyLJ7+eGZKFuGOf+Sd4PIKRH96iQ8GXc
	+4xVsOuQFR9umbwPRQm7jUyQwpoTWAWNPidkPJ2aPclssJrrmQ0ld7bFJXTcjA==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-fqf6v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Print-Cooperative: 6770bd5962cd0572_1743782884086_3612418182
X-MC-Loop-Signature: 1743782884086:3989674027
X-MC-Ingress-Time: 1743782884086
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.203.154 (trex/7.0.3);
	Fri, 04 Apr 2025 16:08:04 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4ZTk6B60gXzDg;
	Fri,  4 Apr 2025 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743782883;
	bh=3ECTl5s+vZfxkpehr9CmnQQuyg0IENpEEDz1h3tHmlE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=uL8OG7QHXTEDkOV0q5KxVI22sqG40xw7cO/eFFVNzD8o61LfNuREn7peSVb9sha0L
	 znZ9kVhQudu5kOu8/Kg67spN0K/jeqov+zJB6K62CfgMLSul9usK3QPLT+9vxe7wG5
	 8yahDF0UkCMnQJ0Qq9YitVqxA60xaicmVTfttKbxs0Y0yR7gccfsgboNvammyabbGR
	 PcGe286liRBnUPa/UclIcPUAhIszDw4Qk4Gyivrgxe2idoxk+wNEgOP9SZ7EO76TOX
	 WaXybywMlwXJhGS0vzAPHu+CKKROMN8NIoGTuf8ZmLCBHlNXke/Nx4L4nUHL1aGlrt
	 cVMFFnOzdgoEQ==
Date: Fri, 4 Apr 2025 11:08:00 -0500
From: Nico Williams <nico@cryptonector.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Elijah Newren <newren@gmail.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/AD4CsUZTPQyKeT@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <D8XC02N85O7W.2LQY7B8Q2Z98G@buenzli.dev>
 <Z+8GoNrdaJlmNpGm@ubby>
 <D8XEYQ9TRB10.L5S89IAC2LZ9@buenzli.dev>
 <Z+9XfLtodUOvqnse@ubby>
 <D8XOO0H2GSK0.JQSNCLB1QUQR@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8XOO0H2GSK0.JQSNCLB1QUQR@buenzli.dev>

On Fri, Apr 04, 2025 at 09:41:24AM +0200, Remo Senekowitsch wrote:
> I'll try to join some of our threads and summarize... please correct me
> if you disagree with that summary (or I've left something out you think
> is important).
>
> [...]

+1.

> When discussing the uniqueness of change-ids or lack thereof, I'd
> like to introduce one more factor: At which point in time during the
> development cycle a change-id is unique. Jujutsu users derive most
> of the benefits of change-ids during active development. The use case
> you find most important - tracking (forward- and) back-ports - happens
> at a different time during development, when a change has been merged
> to a public branch already. So I think there is no conflict at all.
> Change-ids will naturally tend to be unique during active development
> and once they are merged, whether the change-id stays unique or not
> doesn't matter anymore for those active development use cases. We can
> have our cake and eat it too.

I think that's right.  One more benefit of change IDs is that you can
find a commit in a back-/forward-port and track it all the way to its
very initial integration and its code review history, perhaps all the
way to its very first version.
