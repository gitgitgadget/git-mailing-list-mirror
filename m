Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815763;
	b=sbMEAOg8nBtFK2sM8oJGxTGehw7iYHIN4J+EqiwhrUPni9mnKUbCrytIFqPRQoFehp/m
	 SQIWC5F48xagURaLDQQniXa9PHNnXHmHQlVpbGAgpVuJ/OmSYkFkYcqoDgcRLPFjemVIz
	 IveIZt6N9eQboJJ7G364Tx4191Z6oUVnAM3qbtWT86VGmfDF1qfAubnC85d+UlIMyLUhD
	 o/bdy6PayewjESzbnJPKu88ANIYC2CFezxydi/eLGC+rXrUBScJ5iwasydLfPY0KByQ0s
	 H44ssP4EwM5HeCXKu/T1EwhU7xL8FWFqYcbhp8Ggrpg3M0kg+pPEqys567MqjoUwShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815763;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=F4dXEY0N51+U1KqXsWXdxuW0WrUg6aPhJ37oyfmXeC0=;
	b=hguBoKtl7q+ap/sNkZQzFUZ85iC7lMjaA17AocnyW3GzXVCX4ilAP2A/bs951PBKBVOE
	 wQJBEjsECRmReq/ZdRDCFWEz9yElF35zHxEC6krnrAi4QZ6oaBZBVkAErtXOqcEhoPMRG
	 DF54GppVdLYYX+fOpIUScGgOJhYHfppmPLEU0LOW892PcsbfrM7EIHS9jGyt9wZGKo6Y8
	 g+bUnnT0slGdYOi6oNZ/xpcdc8MVmLuiJQSaW5k6HZ+D0WiCQ5NJJMQJTaE00dtlDffps
	 4sB/VQkrfwyp/x8OlOEkoVQWb4DWHHdn14S7Tk3DSCvNpDA/DcGm+zTskgKjhopXNKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Y28ZVL0A;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bM8smVyK;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F524606A33D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F524606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Y28ZVL0A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bM8smVyK
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46F6E1400165
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:09:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 13:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793815762; x=1793902162; bh=F4dXEY0N51
	+U1KqXsWXdxuW0WrUg6aPhJ37oyfmXeC0=; b=Y28ZVL0ATMCX8ue1BRn80FWbsk
	MPht/c2wDu8t0LuuSUsEZsOhEZiZDDwoXue7VtkPuLCqN94te+BLqNTFl8BiaVA+
	3UR8lOc7AM8DjYVZrQvwyHchLLmoorJQjqK7pLrJXqxitF6H8i+L3e/EqnFWzhDe
	lrYOXF/nHaQ8IQzebhdrO9XX5+YKKvpgXQZt5qpBGLCFcgVo//miSYv1uiuJfG/i
	dfZjNspVl1Cy9cxEFwKn/GeVYSqkmjpnk60AHW9VX6dvHa+ti8PR82vRCK7xfBFa
	ainAeOnhUIZjy7jh3b2F5BOdLYGKiERx1oBcJFAiDiNc9CJcprRdug0zWW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793815762; x=1793902162; bh=F4dXEY0N51+U1KqXsWXdxuW0WrUg6aPhJ37
	oyfmXeC0=; b=bM8smVyKZdw1dk8yOVTe0VSljk8v28ZsaPGeGNsOIXWrlECcGvO
	fwhJMJErhDkPBYi1XFwI65RcBXWxqnqSf6FhFaeuFDY+ZCgP3iAoJSnHyRZbX09h
	KFEybXaRgG3UmgHClkHoHbkZ4vrG3nqixWlDtSUaXQeHOiggk7PCoT96XHxcvIdw
	7IKBb3wRX2BhOcnqh5Fvb6xgeZGmeMG54BKNS0AymZk2h0NevCI7561OgE2elY4/
	8reYzvNUCO3Kwumn6RTXZoak4tEY7bE/sI3aYh/2UyTAgUqi5KV9vBExXHx0uD3w
	ccS0RBmEWaoQQ35TwT66SD/QTt7T9jX4QJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793815762; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lbXQZB5PoxJVaQig4c/7DULcQry6IivXL5xbQdWvH6QBBFD
	zcowX+8oaAMljo0Tw/w5hUrCGImc35Bdm7AL53JQC4iXmtOBUgQiQJWYTh4Umabj
	bii47Byll8bZXxteoUBMT3Wg/di3cCMJG/JBsAbc79Abl/RCWtARplRr5uZSS8Cd
	fD04IeDgaB/C5MwzTGExTzNQDdqsqPqtMr4T5DjhrI22Axs9yPoMdt4d0QzIkyFu
	qE5CGxu2Q05fcCPwK0ZSjh7H3Hwg9gVzBwDLYzkdVoBuBCmnS0JPQHBEsVIY0+Kn
	GIqAKC0lSbdLMpPcGqYW1M8yBQill4coZ4TypKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/cBybhSYX7qt1na5biYqMdPLvNepSmyNOZFOk3SZ1T8=:kPBPBaRWirMhy1Wni1dvnC5a6Z5GNm36Dk61fCjYBok=;
X-ME-Sender: <xms:0nTrarsUMG3eHFyo-kRPnQ8-YbQwaj6bk5-CQ9DRzC8JLzwzewig1Q>
    <xme:0nTraj7NTqg7gpXLEAestU7ioltiCUTTSJnsIsPm_Sd-vVbodRgV68lKK9YoDpV9t
    KaLTmWC6vRr90eoeNzcPbWm5VWwwiW16Zf6tGPXf1sUWcgVZfIJGng>
X-ME-Received: <xmr:0nTrasIfmaNtGEmKxzFkCfZpZcHSDI1rWDQ-Plxu0VbY9lGltgx_JUOia7uutqScBGo1noe-_LYlppR_fnkZj2J9bt9A7GDYYWNf>
X-ME-Proxy-Cause: dmFkZTGBF0S1d08gBcjx+E1pKNQlLVJUNqtYC4FahXXYTbOg7SAgR2n2pxchJ5tisJShNQ
    e3bqVd2K57FGW4fxrqIPeqESs4hNRPRDw3eRLdMHwBxYAaSKWpajee7fX1U5DSbdQoNTYu
    hiCpxS5iUOF0TXX1ILmyUxOP/s5L7BPEG83DGFrunaoLJWYw3oqORUjA5DdEsuFdZHYj7t
    Kf9WfLLCNzMghaZbokBtnQZyoRBl+fRmmsAJeWCzTWROAuzyG6//Ai6X5RYkLA5z9ZGwOe
    17+uhI+k0nooGZTKSmixHY3h8AUwAT1wP/ZVFzAYte8GavMcJ6gWZzKx4JTuK7sZok+gpf
    Be5JzqDcSXjICJxRuImZlKz+inJWQqyTthpJ18C2yy192seOpow+4+FunjxWmsOXXHTTzH
    kLu0CWcUEvAY1nlzdJroKuDIv34v466XmdxvVnc6DUVIfrYGxMkPhnz7FO4L1ysHH0dFzJ
    sQ/5IoQGdKJEzQz8BVsNNX7m9ZNX8Uhduqa0eJEeBRYeLOQvBMexOkxvgN4pl3nIrwL3Fh
    fCDdFVAqTKmGKGCASXV+4RUyQNwm6e/jC17xm7frh51i0doF0p7hNkx9S5T/JnZhAt55q9
    ymKUORSF3hA6n4RTwdbkSOlkj+tloue3TL+ZJMnVdYBQwvoYlOXMKvc59+Mw
X-ME-Proxy: <xmx:0nTraj5VXaZKKsOW6BTKwAta7q9gcV2d0qfbQLefdTaPXrglXSFOLg>
    <xmx:0nTravx63HPcWg7MUb66dZ65o1em7yKTOry7Eis8mDyrp6XeNfJLZQ>
    <xmx:0nTranZGQF5RQVzZrrkD-sVYtwmluSdPxdCAJcUOz50Zy2zSpEytNw>
    <xmx:0nTrahQOR5dvCk-Y659gMcwpXAIHnj-l6iP6KgoPARFNITVeWxpvQw>
    <xmx:0nTrakoO_O_2Jm9IlR7NWVmyRIjBajKc10FYnd2klPmHBCrByDHZNZ3u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:09:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #01)
In-Reply-To: <20261104064115.GD1543013@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Nov 2026 01:41:15 -0500")
References: <xmqqcxsmejd9.fsf@gitster.g>
	<20261104064115.GD1543013@coredump.intra.peff.net>
Date: Wed, 04 Nov 2026 10:09:20 -0800
Message-ID: <xmqqzevo1nan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Nov 02, 2026 at 06:31:14PM -0800, Junio C Hamano wrote:
>
>> * jk/test-env-quoting-fix (2026-10-30) 1 commit
>>  - t5702: be more resilient to env quoting
>> 
>>  Tests in 't5702' that grep the output of 'env' to check for the
>>  'GIT_PROTOCOL' environment variable have been updated to explicitly
>>  echo the variable instead, making them resilient to quoting changes
>>  introduced in newer GNU coreutils.
>> 
>>  Will merge to 'next'?
>>  cf. <xmqqwlqytvg9.fsf@gitster.g>
>>  source: <20261031002550.GA626623@coredump.intra.peff.net>
>
> It sounds from the discussion in the thread that the coreutils behavior
> has changed so that this becomes a non-issue. And I just double-checked
> that the version in debian unstable now works without the patch. That
> said, I think the code after the patch is more robust in general. IMHO
> it's still worth doing.

Yes, I agree that your change to make the test immune to the way how
variables and their values are quoted by "env" is a good thing.
