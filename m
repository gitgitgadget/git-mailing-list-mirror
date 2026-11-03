Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726042;
	b=XZjbziDlvUDXpHElVBJOX++8lb8YPMqXVwILY5tX3aY/4dKpWGUoPvs8CCKp2ekQ6Gn1
	 QCJdzaZGs1bLoCCyNZ7kybx7ySf+XW9GLmMzz3/PsIBZce2n3E/nuzjyubd43zXhLmc7q
	 hxH69ZAigOAVXg2rFkUitQvVV4KvLoP/dneW+DHhuLOO652Sl0fvuSQ+NOxmpISA4QTzy
	 gfh5csNKhjkfuy1EG2EuV+YSM1AICESiaBGREyytSZy4jEFY9OjhCFx0nP/2kSXoIuAiJ
	 IS8CRt+/QX1ZrGNcbML1vTI7IaYFDOHiiOXXd/p/bkQoRglM8jy8mGbDHcEy7xq+ijQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726042;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bKYarFjQUNgVciFGB0kIlIMWVUzJ1TVa3MNFhGlgUZE=;
	b=5FivOsjcfBme0CjUKHu/PnWxGbkfvSt4IoJQW5oeHUyhpcyJ07r/89GhjetzGulL4GRI
	 8msIIbs975q9BDHhxQD+MOq8ECbnMGI1JlYflnxuuj5k92nwPvHJy7sAjFFvcJTTL2hSy
	 ne7ir+qGFlWM/dOSdnBAcDh6TDFN6KLyz8hEgp9I6BMyUD3+5RseUh4q81AHvyzfPMc2t
	 AHFIDzgPFyacuxPZ7t8oV55G62ZP3CcYxBQpsNlvaLXjUcWQEt6C+D+G75Aoo9LVPGq8s
	 EbtUfktRD7lIIoCZ9hD3j+8xeWpicH+SiMW7jjEQWdlKQptUH8MFeLrlh7Drh6FeWMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="NoTWT/04";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="1A/7QTRA";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C09606A334
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C09606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NoTWT/04;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1A/7QTRA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4297D1400101
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:14:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 12:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793726041; x=1793812441; bh=bKYarFjQUN
	gVciFGB0kIlIMWVUzJ1TVa3MNFhGlgUZE=; b=NoTWT/04kIML1ldMEg451hQMG5
	6g9buYThm5gk7wSFJmPYs1k+T9CVFvC4wyv4AvJa0KR+7eXdR0jTBSWRSnbt4HDw
	bujhmOxWoC+ozuWYxb2ACiIEpy6/YhzS+ozks/3j2xwR6udm2RCcIGqY0XrcOL/Q
	QMKTKvY59h1BRzvgkIbE73KWooVkmv7/NLkkN+qbZnUOIQr8bNaAUzEi81f4iWBw
	NNNakF6xeg4TPUcJoI7EGdPdegphgB/wy6U6rnXo0mHKm+72hmoBmTIeLkI84/OJ
	Lwjs16rZ8TFpyPzA8vuMDDZG0UNLraAohJDhJBOc56Trah24VGo7W1GYIpZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793726041; x=1793812441; bh=bKYarFjQUNgVciFGB0kIlIMWVUzJ1TVa3MN
	FhGlgUZE=; b=1A/7QTRAw3e4jOnaj9cHGvsUc7p15DEbtYlaA/qZkfK89MGWe6H
	ItC7+OO++qCJLO9vniSZeRwGjP7g/iKJGri+Z97l4RvtWYlGFGvC0y4DD3pcc6n7
	ols2izGzO1qQTNHuHpYtKJU7uKxUy2wlmiwImuoUZevIaxL7EkGOH2PbHcCOb1Ip
	yZ7IaXj9quqp9qADDN8ANUugNgONCoiYR2uWfUSuBqN2ZuI0PaF/MBzMwxOQ1Rew
	h4CGFB6yx6sKWnZvPjRCnHCkr0qy/NdgEjVR8oiwGkgYEVdUbc9ZVfsmn5/kBn1O
	tbyA5r4oHRDQHrhCdA4/7Aj1fTmvArsVg8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726041; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UkZ+A9presYBaoil+nhcgMlSJNRgyD2IhLGbWozfaQqN2p7
	E0k0n7W42QPQ8p60uo8b/4+ZVCLYHz+jR+2ZDr6xAvlnKDfr68+KOKEjb36eUTNC
	FymT/N4fyuCDbyXpLEImCn1RoqsLUNhOCIqau8zd0ZQdoL3qj9+yYMZ2sx5UhstQ
	LrHyNQ1QlVudtRe8g2hso/3lZzyU1c/tF06NPKwx7jCG4IjpRfT9Rwr3fVVv+ai5
	GluPjVS3PM8XWwOJvoEt/Yf58gAZSNSQ9XxZBfQNBae/bRLrspzVDWurPIvTVi4P
	YtCeRWFZqZqCG0o/WAu8pUQ8tDFSdWEdzZ6ezcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZQqrH7ry0L3gwsj+NMVfPdKtsRq1uIWkdFvolr77OCM=:5cJLepxvzFVx7tKVJWzR5rjoTiNHq2ziYDnoIhty7/s=;
X-ME-Sender: <xms:WRbqarxiZM91-blah_ooEGEnSVaRiSHCDnNbElunChMXtfMAInMqGA>
    <xme:WRbqaqSy8e5_sw5hsJpObCrOGByQ9tDYGXvL7pXsfsIwy2ieBH_g88pJQxHvfzcyq
    rf3GqLMppjseL56NZDk_kymoU-WBwhQrxYDi3JWVaVlGMJAw4VG4qc>
X-ME-Received: <xmr:WRbqaqV1gjjlk2VHX1_yU4rGm6MbYJ5UgKE3Wb0OJhAq8DKq5ZCPcECsf-FylLHFNq-K9OEy3DL9kc7llDkVlaa4hdC3lTnNG3b0>
X-ME-Proxy-Cause: dmFkZTFmLVPSnMWK4cMalj+jXfD/4DErAPOwOP9+dHKn1JSk++G9Jf3X3N5kP3vFx3ca8J
    13keTnJiwIJfvHneBatMibnyBQ5mozl2tc8e/qGlKoYADgh5+X+jlwybYsxQR76oIU7so9
    KtNCqqZnRsbnaxiObTMdbRik3qzM4VwFOWphdOhMYDlxDsqI5CFbWcfwCh1bBaPDF3a6gI
    ro0Y/MZ8+aEbUuwPahGhrLXjKc/btRUMkMBDth7LWnoPfh7oLROzEn5Kku4hsyx7LvhGis
    4gitVncrNDUCkU2kKnwLOWPPqhQVuxIOLY0b8JXby+jKt2j5VuY9S7PmPDBuFd38RVd3nH
    Fr5W5LWCAZAS6bc7LzQvZgLBBmL5ZByJH6Ot6ikshg3Ck+z+Lj5z5AJpGk24eA8qDMBRZN
    9JochZKW3EBzSbaUf9XM4nmNEXr1kVrIFCS4q+04WeC8LJjeCaKKolI6Q3bsJtVz10PsC6
    /5ost0QBBbiSbR8PKkS0NmAo7iY8VyMHp/zvbM4b0tFynNwLtloBPTy1/sYmM8sglIlXvm
    sOf86V8X9mPNn47VjN7nDwozm5zkngPUrX4/QJy6gDmx4f+Qfsgd05Sf61mFHRffHt2jOS
    JVyOUcG1cvEwg+ylR5+rJ6Y71vwmJSdGGYisXLLG4tN22mVqvHrcbFO8uaqQ
X-ME-Proxy: <xmx:WRbqakZjeqjH0LmSAhzSX5WKKNRhZ40ystncYflgtPcNAgzIf09ptA>
    <xmx:WRbqao1eFpda4YADebCyLlGM8TgealkBLalXwXmE4D-gIfomA9gekQ>
    <xmx:WRbqaug9Cywzi3iRovOpF69NiD-6dXxUfqFZqo7qYpbXuHqM-w_5lg>
    <xmx:WRbqakbfMqQXLaxK2--HGKZgXdimUQs6aF_TAWXv6cPg95Fd2xy2aQ>
    <xmx:WRbqahFIKtgYkLI1tq47oCvNsvx7pJ5kyAnfdx01DFdLsP9Z8mjG1Qk->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:14:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Q: .gitignore and asterisk "*"
In-Reply-To: <20261103073317.DATcL%taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 3 Nov 2026 09:33:17 +0200")
References: <07b3498d83424cac87221724b371839a@ukr.de>
	<xmqq5wyjxgyn.fsf@gitster.g> <20261103073317.DATcL%taahol@utu.fi>
Date: Tue, 03 Nov 2026 09:13:59 -0800
Message-ID: <xmqqzevpald4.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> "Windl, Ulrich" <u.windl@ukr.de> writes:

Please trim the lines that do not have any relevance to what you are
going to comment on from your quoted material.

>> - - An asterisk "`*`" matches anything except a slash.
>> -   The character "`?`" matches any one character except "`/`".
>> -   The range notation, e.g. `[a-zA-Z]`, can be used to match
>> -   one of the characters in a range. See fnmatch(3) and the
>> -   FNM_PATHNAME flag for a more detailed description.
>> + - An asterisk "`*`" matches string of any length, and a question mark
>
> It's not unreasonable at all to call the empty string "a string of no length",
> so it is still a bit ambiguous whether it qualifies as a string of any length.
> I would suggest s/of any length/of length of zero or more/.

A string of no length falls within the set of strings of any length,
so I do not see any ambiguity there.

"A string of length of zero or more" is a roundabout way to say "any
string" as by definition there is no string of negative length.
Perhaps that is good enough?

