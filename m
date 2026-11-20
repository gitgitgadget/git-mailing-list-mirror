Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135496;
	b=E/J8nSSYElRRXMKQWsd9GzyMhruNv5hYVjZ3ECL9B+iiKPutym7VTnjTuJ7kp4tPRsCH
	 HADJXNgiyZaOE6xID0nwmO5/1NjmQZELM6zljMCyT3nsjw670k9vfPUbRyRaiAP/W+WJH
	 Q7r0FXiDJ0RZ2j0xuUbczgnzYqk9af4tqT4A4V9DMzPDHKQE71bWp9N5o1zCLwGu6rqoZ
	 7PJ7aiBVN87vgI/SVD7YjEPTwj7xDY4TqDRBsVZ+H5f+R/IXTY6QX5FJRx0b39KrU3bbh
	 eDJ1FrY9NZYMe4rSY8JqMeOsZbw+eBrnaToK4WihyxD7H7WJlGsrTnIMCqpUZS/IeOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135496;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NZjvPCGhE7LBu0j3/Z/kfoaG5IN7wXJ223bbpEUEMvc=;
	b=0kdW922xDx8oRvln8rSTe7vscEV+kv1jWM0/0tBaoNZ60GBGr6GsBr+QjFGVIWi+spre
	 r7tR2hAI1tUm8uZUUlfN0RqwveXRQGfQG10OjncRX3bvbJuvvLB3OFmaRZQfuZYX1K5HZ
	 tz5JNmIkramn+9mrN3sVWb6lnl+ZwwrcLOPSNMNoZtywtcr/cYYC6/C+8hqdCvYBseUVg
	 L+AWkMbFOdK3ZJMei21hiQIjWQcofXlKs0Czc/kZeI1h2CgnU5Rz/CfhcEnqsvj6fBtZS
	 zIkprrutHMatK48jE/yJr56WZI5vCC2lM60WF9lRufCbiNZT+uJAkOhs0AxcElrJy1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Uo5oNwM3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=khUXoyRp;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806E606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 00:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7806E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Uo5oNwM3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=khUXoyRp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 83C59EC0838
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:44:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 19 Nov 2026 19:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795135494; x=1795221894; bh=NZjvPCGhE7
	LBu0j3/Z/kfoaG5IN7wXJ223bbpEUEMvc=; b=Uo5oNwM3P5K22GizgRh/x7G7X0
	FJXEKkVweQClP3Ca2iKBwGvoBIndTDkAwC4/BgTlhhxLsZoIZ4tsyFKID/4bo4zy
	0sbfFIAVAxWw0inEv1QhwusW9D2oeofjcO/LbPjQagBIeKfXohA7zfnSLo5HNjuR
	2Lu1XRBGCGfdJVp73wwJLfoVSvfLPUR/S6WRxa0+6Y1JPbtWOCCqKeuuTivSIcEg
	VVGh3nV7CxJalJXzg8o3xH/G0ablQv4RmtQwrLJ+MvIywn3q2uDoRMJ1j0uA4tcI
	19JyDbpUBS2No7gIUtMWA32zreIH1ITQuUJJAtSD1ZJeEW8Y9MZ81EF3UIpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795135494; x=1795221894; bh=NZjvPCGhE7LBu0j3/Z/kfoaG5IN7wXJ223b
	bpEUEMvc=; b=khUXoyRpknkESVKBj13fQjPH5nkp4CkmC/GXNLNyfSd6tKflRiN
	qHsysp0LmvZ0PeX/M4j8XksriDkU9v22qlIk03XQuHpvMiNgGqRyLIV5/WoeUcO4
	2mTymURTPuAWy7JoGXsOkGFRYJfWPmAkKtX0UyiFxR6D03ExAwbq5u0swRgmUKz1
	/jg/DqJ9FFa/2XWWcjwX10ReR0sv8v8DfDsHZkA8eEVCMYxZbDVycjO40hXVX4c1
	SxcfKuquedLfJfeDKQKLmMUDay5IwKxU10uK4T3JUXeDJgRthZB2YbQ/bZrZWtHw
	YsviFqeeL8Vff9BHeDjX3v7yVBa72he8vkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795135494; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cLu56QKf5uSwaxfl97YlGXev6K9Dk/O/NUCUtlb4POT52d2
	ADPYVCab5nOfOGD+iLn8jyA6+WdZJSJSA+VGJs2r3BYK+E/N3AoNL8csdhi7vpDo
	42KleBhf1/87wGBIKvqgAjbq7LgH79OdwQ3C32ZLENx8//w6W01KA3g7q8zjF7In
	e52r88czVc0CVRMv/WMRCeo2XR75WbS7jv4U+xawAlog3qKRpPOdLsml4fJt4p/d
	Tfor0USP9TvZWHtx0UGDOq2mLvoDHSm+MK1tHjvZjApZR40cFvY4/Wrvqb5D+xBA
	afeIUOY5De26EDJIKl/1qweICHkZZdOLlJ+ekXQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jZwnVUS8APzmuaMrqQv+ws8hxD0y+ZRINxXEiP/wJrI=:EGDxDfMVg5FNv0zOLa+kABhg9bFZYCEX/1le6fJ+oQM=;
X-ME-Sender: <xms:Bpj_apKgLblbTIOt-KOCD6qzrDknjSRWFtHNs_ReOND8ygeF5g0poA>
    <xme:Bpj_akOFsQevcEs-a4Nu3mJC71FL3Hgij0pww_VBOelvq33KroX5MQc-8hfkqZAL7
    aALBJ7KitOInfBAFlwV3WEjfJyJlmo11Ik-8FM1-kX0fhFC4TcGaZI>
X-ME-Received: <xmr:Bpj_an6toEtWZvjzSJR7Ymz0AuD2Z3yUfZ2naReIohDPr1GoBsFBrQnPC6p8ipjEI3n3eTwKGe_6nYAnScyrz1qLekqUy0q7MpTm>
X-ME-Proxy-Cause: dmFkZTGtkOoONeU9J+guOXOYjPFkLF5CN7nd8Sang2ExhoXYega9+isSkGweW+MMIG3Pze
    O4QJ1M75VgFkqo3tZdLdsvjQx+7JG+l0NLFUd8ZyBSCEy5hxr/477wyi3z8+TNWkjqGg0p
    BCWD4wpntx0qsogMPobY7cM1NY1C4fFKcX0dHlAKy+Ba3oW9LEccCjw8+NAG+cAVIZn/iY
    xkoeBTrzbSQiYk++DvuCIwLHQzvdJR/AkVLMq6JJu5xlLTkbI0QpMVh8EoRywGHLGaSZDO
    dfrNlVQwIS8QsZ0tIrNtbkLT6bV2s6jlTR04Mke0Quj3h2knu7qBx8TRX80yLdj2T7EcEN
    iJxx5r2GIUXiQUSkM/GG9pthoiBsBm6oNqaAD+AWkgs3c3sbBz0g74UrAmFS8BihCqYVms
    4b1Ii4715XLx/vnPbvOKAoNNawhfBYlawWLwuM+yFk7zhnQufHmbt1DV2GYqw7FKRPjVI8
    y8PqPLBTxXS+cUwINLGai2IVlmxQbFW5Qx6HJ/1wCRi/WB3t9iCTQylE+7UTa96DCKvWti
    rDGbbVS8+jL0zq+T0V5Z+zqJ4+x96hS+7aDHrpXG9QCE+sJOCjkSXXOJtpoc8gJO8Bt6+4
    UV64/Tha4sGQ4vqV0SVlzZZjUDZ7YiScthQcFILr1GisYR5f7nT3pOGBrOMQ
X-ME-Proxy: <xmx:Bpj_am4wWjgsmy0rkKVbkdymONr7EP78L4iV1uko4Amqq7-lOySySQ>
    <xmx:Bpj_alEBkDeLwT7NM8KbRk5w3bzSKaR2C7T6RTnofo2TLWksB-HG8Q>
    <xmx:Bpj_amVT417xnL6oGxgJ_GMsPIno7VYrInLjLRWNfUN_25VkwjjCYQ>
    <xmx:Bpj_apWQlp1z2QdxV6apn-WdJgqyFeJxy_WNgN_F85RgU_yFFiI3pQ>
    <xmx:Bpj_auer4nNg6hA9ABuUSGnsaPoCmDu5EEkL4fUxmHjrh9gNVgiVnswj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 19:44:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  dmnk+artist@google.com
Subject: Re: [PATCH] config: skip continued lines when matching section
In-Reply-To: <20261119192307.2683812-1-dmnk@google.com> (Dominik Maier's
	message of "Thu, 19 Nov 2026 20:23:07 +0100")
References: <20261119192307.2683812-1-dmnk@google.com>
Date: Thu, 19 Nov 2026 16:44:52 -0800
Message-ID: <xmqqbj7ktjp7.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> When a value in the target section spans multiple lines via a trailing
> backslash and a continuation line begins with '[other]', removing or
> renaming the section stops early at '[other]' and leaves the remainder
> of the continued value behind as an unquoted '[other]' section.

If the behaviour was to treat these as continued values from day
one, I would have agreed that it would be a reasonably design, but
offhand I do not know if this is a breaking change in behaviour that
may negatively affect existing configuration files.

> @@ -3434,7 +3525,7 @@ static int repo_config_copy_or_rename_section_in_file(
>  	const char *old_name,
>  	const char *new_name, int copy)
>  {
> -	int ret = 0, remove = 0;
> +	int ret = 0, remove = 0, continued = 0, in_quote = 0;
>  	char *filename_buf = NULL;
>  	struct lock_file lock = LOCK_INIT;
>  	int out_fd;
> @@ -3496,9 +3587,12 @@ static int repo_config_copy_or_rename_section_in_file(
>  			goto out;
>  		}
>  
> +		int was_continued = continued;
> +

This triggers -Wdeclaration-after-statement doesn't it?

(administrivia)

I do not consider myself an area expert for the configuration file
editing code.  Please do not directly Cc: random people unless you
know they are specifically familiar with the area or they are
positively interested in the topic and they will regret if they miss
your message if they fail to notice.

Thanks.
