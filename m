Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806560;
	b=il2to6o/RGouq3RYcU53Ol4okphy+K1CNd2wACL9MzdbIKWKw45pj6DpihhbBe9N6COK
	 de1xc37s+owJzkp+9QsTQeFq2WN/4Fa4rg34rCz/m2IeTBt00Tp27qmycl+PB93iD7HMq
	 0xHfQQ9bJfmsSmL60GlKuCelBQSB4RqEqKiaW3L3USADz/9QpC0C9BiTuTIxUg38Ak79v
	 PA9OlNJXrniPX6NGw/RQA3bWvUaoMq4sJOcFavCbIDSUOpcVUPRkpVVlt/Gvc+gGnLuCK
	 5+3UlqSQIjU66OZI2Rj43+dv6VEO7RA3CfIpZ3oLaWJpLzxbzpC7mlJ9GjSmQOgG15Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806560;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=bA9S3AUU5/1mZ/pa/7LyXqSmBIf/atYMCerJAmtLN+M=;
	b=ejlxO/aRgg6vyv6gZUcQy3A1NJyWfUa/WnBl2ttGGxZ2GKoP75FMNCZzs0oyKj2O//FL
	 Y/8p7i17WF9mVvr4w4CuOWJ+pUEo1vc10DdZZWrtpkENHQhQBOEi58c1bzO4GOMIXoXwe
	 gMsVAwAm6GhYlIRqszWd2mNiSDy0iKq9947aZ5oJyQ6+dnaFaelq59yHatGCdNqTFXP1m
	 vJpFOLEHFzaiZ4mqp4dnunESY0S5QVevRZ6nE75nYyQqBO2N1mj+zL0uv2NrotSYWF9/y
	 gTR/9vPI3lsCgFJcN8gXeN4cigg14o7oUyOKhQ2D80FxACbokM0HK0UYSFRBeuCWZEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w6eBBzXU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rY1SNusq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="yA/QWeqO";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WS2UtRZ3;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA76606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA76606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w6eBBzXU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rY1SNusq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yA/QWeqO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WS2UtRZ3
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36F561F79C;
	Wed,  4 Nov 2026 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793806558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA9S3AUU5/1mZ/pa/7LyXqSmBIf/atYMCerJAmtLN+M=;
	b=w6eBBzXU0Tuske/RpNwt0Hbw/QpOFTzj6cS0H2w9am75e06J8IQSJdqp9dTsCspCth1qyf
	aJ97fQiDWnkdpuWNmZ7sHSNud9jywNLhyh7w3k96cDYGAJu4NqNyuh+cHMROe95vILZ8NT
	FMRmLbaVJpV9R9h+emRcZfCTIKo+/ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793806558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA9S3AUU5/1mZ/pa/7LyXqSmBIf/atYMCerJAmtLN+M=;
	b=rY1SNusqcBdooD+bLpmMzr2b5MjmC32kxB6/fRkt1O5nirzxxx4jAtE9wTMw9W8k6JShVL
	IzEARCCDtIBKDhAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yA/QWeqO";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WS2UtRZ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793806557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA9S3AUU5/1mZ/pa/7LyXqSmBIf/atYMCerJAmtLN+M=;
	b=yA/QWeqOCUvQfH9oqDjPMSkla6mZfBdajJKgX3DXGFWspyUaNznpDCgYCvVfLMkIq3WJtf
	DlHkxZCnmmFOO2O6GLRTPEhSUFpYFA/RbRJlnIJ2w63/Di5h1pz0sI8o5tSYfQQf4pLmzz
	a2vnSFcBxNz4atfH3NuMlmogeilJ0rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793806557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA9S3AUU5/1mZ/pa/7LyXqSmBIf/atYMCerJAmtLN+M=;
	b=WS2UtRZ3hsa8Q3agm5tE3NK5RRsW10yDUyfTch6Cpv2EGOXRb8cubYAW5vEfliXaEzkwdZ
	/rbv1PljBwamm8CQ==
Date: Wed, 4 Nov 2026 16:35:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jeff King <peff@peff.net>
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>, git@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
Message-ID: <autQ3CB9bD9IIpXp@kunlun.suse.cz>
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
 <20261104062423.GA1763458@coredump.intra.peff.net>
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
In-Reply-To: <20261104062423.GA1763458@coredump.intra.peff.net>
X-Rspamd-Queue-Id: 36F561F79C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-7.49 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.18)[-0.878];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[nvidia.com,outlook.com,vger.kernel.org,pobox.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,suse.de:dkim]
X-Spam-Score: -7.49

Hello,

On Wed, Nov 04, 2026 at 01:24:23AM -0500, Jeff King wrote:
> On Wed, Aug 19, 2026 at 08:21:04PM -0700, Aaron Plattner wrote:
> 
> > When cURL follows a redirect, it calls the CURLOPT_HEADERFUNCTION for
> > each header received including ones from a redirect. http_request() sets
> > fwrite_wwwauth() as the header function, which will record the wwwauth[]
> > entries for the last step in the redirection chain.
> > 
> > However, when http_request_recoverable() sees that cURL followed a
> > redirect, it attempts to update the credentials for the request from the
> > new URL using credential_from_url(). The first thing that does is call
> > credential_clear(), which clears everything including wwwauth_headers.
> > 
> > If the new URL should use a credential helper rather than credentials
> > embedded in the URL, this loses the list of authentication methods that
> > the server provided in the redirect.

I think the decscription here is inconsistent.

In the first paragraph it sounds like the wwwauth comes from the
redirected-to URL, while in the last paragraph it sounds like it comes
from the initial URL.

I think it would be good to word this more clearly.

Thanks

Michal
