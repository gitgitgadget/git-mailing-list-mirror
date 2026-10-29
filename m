Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284201;
	b=xYOzV1IzVITdR9T2sPvSLFNztQS/+OgMjB6jixMfFFV4jMFnYzRSNvIIU8KspTjzjpsB
	 GpYxgGxd/3S5pGnJgE3Y7DR0mP7PCoLMO8gcYLfWB+V2RFd4fgPOzlC9isP9QVgIlwiia
	 D9bwoSEcwH7vCpS3N7+75GoqfrnKuzDd/fHkyF7ra/9Kp6FN9gPCd+IhIFLhM8hQbN5+O
	 sc4+SxzDNpHdo0j09TNmgXbzGzuSYhNROtPBRD6sbUYmfgFTgv6lS036ts+2jVygCEt5r
	 bfDpgErpulSEP8T7ALtRmlQcG0oj5CvBceJWCX5tXWtUMXtoBDCYUZcwcR+xn9xplIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284201;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ysI7M/I7uU6x7WvfyBagt2H1J6s3Pvy6L8gaLBwX/+s=;
	b=kGX5l3fA5jMj0YH+f2sHI9dyeyfsrwqdooAPcgugufiVU9PD5tgv+FEMCOMBwv3iO83d
	 QDrXit4PGX0avjxiHfxbmgzleMYnSgTESV5ueRtLs03ZBtcYJ9CCfYLu+Ov/R0/HnRKJz
	 fAfGJJmJbs6MxzwJbBtfr9WuNLtj1ldr7qaBrX3CjKrdMuZPJF691IHr+KhsCfaL2YJpE
	 N9DLwL7lrgozXoJxGCBb4WAWlrWHg7zIATOQ654h1JrQp7vjgReT4OTAK4CsA2ZE0xK4m
	 VvPNyhiFq3xSLqIXpD/kDOgMWrrFH9XWMV8JfVvp3pMNeLRmVzpj20udy1EK5ER//4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UyfpivjW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oMdzQaHE;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE38606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UyfpivjW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oMdzQaHE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 108467A014F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:30:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 10:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793284199; x=1793370599; bh=ysI7M/I7uU
	6x7WvfyBagt2H1J6s3Pvy6L8gaLBwX/+s=; b=UyfpivjWnv0+9SWHrwgPLYcCxx
	Ub4PF8gGI3p+63neSl8KuHpV1bTxzBLF4bHzkA8emWL8DpvP142ks97F0qVqKAXg
	QoItqYXAwDodIInxR+fg7PL5Jeu6zMlPHHlUlsVsocLuG9ylJrWPGZuKI7lbGyLC
	4+anPrTchSOzJKgIvIA2F3D3QHsEHMOuNLNQFE0Q52Fa/MmF2Y3LhYPKSpMOPO5s
	919wQYASw4/Q+pUv0nQp+1bbz0+gEixBWSHXRPr8AgURbcUL+Lgoe/YMgjzxCTMG
	+nhUhnPlA0w2G0F2jnGXj7sDdaZDX11O+zLQA6kYfi4uCFhW6NcyEc7Vq8PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793284199; x=1793370599; bh=ysI7M/I7uU6x7WvfyBagt2H1J6s3Pvy6L8g
	aLBwX/+s=; b=oMdzQaHEqIbnY/uMzxAuQTkxWpnIUHPQAczL/Elf3GbooChtDP+
	QZfmSDx0xD2dfJLMKoEdPuNq6w152tQ8PJEQ3aQwFhAkzsiSVr63JU1HPZzDRvU0
	hzdN2izffMlDjoRhO7f8vM1Xza6XEhGLBwx4z5leLMMeIdf7zRJHGW5h5vp3oGNz
	LlWrO+vOBKCiUhmU7QXIS3qxkPNC4Ff4yq/KYXEBPofJN9+hJ2l2VGk4Sf56GgLw
	xnJdxCs4S759IpK4h4LLLMqe9DISX6N0WEILjZFUwHSlh0C/IjtbRrXEfr2oSCXD
	dw0WToGN1RsPB/QP6HujNEbC5wcfBK7DNJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793284199; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aOJyNlZyApHRrDCuY84GB6Ka4AuyidjZB7hLfdFqru1BSq1
	KN8GI5DgomoaQ5nYCu37qgYwuWUn2U0VJHf7fN0jJ2oeE19Obcs4ogpdYf2czN3R
	RjUYAwIa9A7nWIaTPdJ65uv5JozztTt4B7Vi0VkO0w0hfAF3PMRWBrCMgvKvlpp7
	LG8Jnk/hRoFh4sINl/WrHqO1RW36sUFbwRITsAsqZvBhZ5thu0zou5wmH5SrPC6n
	lbUUDtt8owAU/kwQndFAGy4iClh2M0aPoHyCZHixShiCvFDNZP2RlWmoGlZZyGAe
	DPgW0NNbj8OIu7q9VT9L783GO5i5T8cFeY6GQ2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J6dqhHfFXTQPMidkvfQpu/so7+VdqtEhxAiyC0xgD0U=:0gZxtBMFKsRCTUg5VQyU+SmZCvtb13Dkhzeg/JxPWco=;
X-ME-Sender: <xms:Z1jjavWTkwsuyVzZprhCoxk1ECkgKcVlPviz5AOphNyd8XPMu2H3cQ>
    <xme:Z1jjaucDzXuBjQF7kpTAeK3c_5a1U5ZQmhtWd2X8L3ERvnP27FsdoNrTVTEuwGuZI
    Kfu__DLd6smIkBHb1RVR4fG6-yny4ZvpVjigkJ3lXcRef2b9xSirzA>
X-ME-Received: <xmr:Z1jjajvG0nUAF_f-4NbFLehE8p4rfC8TSKrklmNPKa2rjRd0YHF9itSISUdFhZt9w0yjVaAflIvLhi2Od9393vQWAz7w2-U0qJka>
X-ME-Proxy-Cause: dmFkZTGHWa8vheIqibr8Qju7J47RsLIDGCu1esqNM7CREYS9v97wQ1GIpzbp7GrGrWXWSd
    e9ew4ypBV1ztHnUcE5se/H6nvFJU8aHzs+7exvllJWSus5+ZbaYyQxnRCXcbIHOF0/cvte
    PL/KiqnXPuLPhnB+N/1nqF4vVYrR2Oo14HHLUlo5X/gkP93Kk/f3k6jFWC0Ny4wiHuB5yH
    JlilO5TgAh5u2AlIbWwnLAwSBwoOxWzwD4xs2+0LRTXZXfJQXNnqQvzKzDmtdKXHRzWjJI
    4ssHz1YwgBa3gYaU0w5nbSRVo/xtzrcJ3Av6IFmw2ZGOYZ7PPCIUD1DXuJQ4Q+pHAy8eiu
    YuRdOL4TOt8FmAoZ3rbB8HNCZu+GMBCqYN65+n3NClJEaZkfQWEBpbP0sWPgIL9YyEtcjD
    a0x/YPu2S3M2QEO5jddJcdX008bW2C2TNKK8/PKguqrzidraDteHCM4iCMyuFswd4B0pcE
    /Hy+zV8fcUGVGGpjWSPXeDIJBq8MK7uaz7mVQwx9OwCzb9xXLq/0bjqFS37V68eJq0DMVp
    TtrtBqpOgqYc1QgwDdaeeedrIX8T7yVSut6IK/Dt0ffak1Jy7b7lRSrFsGT4mfK0YvdhV+
    ruGD4XKV5kVnPFH+W18t55Lx9PbPfiz56VBNFAM/ztKN12CaALjrXSdwyEXA
X-ME-Proxy: <xmx:Z1jjal-T3PYhDesCDQF-cJ9I5MDTaTQh-j2K9SM-pUEeQ0t2PWgOLQ>
    <xmx:Z1jjam3W-7qbtDPPbDjghwlSauTiAfz2fAmFjdjLeF13FMbSwpmdog>
    <xmx:Z1jjaiCUWBYiXdpHlIwlj-kSu3KtJSwSjVnNYtwd66SiobbtCiNWcg>
    <xmx:Z1jjaqcZhbxJFMJSRPhYEWEvq8ctiA9P_1WaO1LDz5QF4QU2t4H6kA>
    <xmx:Z1jjalNCch_B5GiKOxXR8TNsvtG5VfKOrGvrDAuBNKSatq6rc8mhDEhx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:29:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/4] Fix imap-send with reordered message headers
In-Reply-To: <auCEKSc60ZnLKjBE@pks.im> (Patrick Steinhardt's message of "Tue,
	27 Oct 2026 11:59:53 +0100")
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
	<auCEKSc60ZnLKjBE@pks.im>
Date: Thu, 29 Oct 2026 07:29:58 -0700
Message-ID: <xmqqfqxo60m1.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 27, 2026 at 08:31:15AM +0000, Harald Nordgren via GitGitGadget wrote:
>> git imap-send rejected patches sent with git send-email, such as ones
>> fetched from lore with b4, because it expected Date before Subject.
>> 
>> Changes in v4:
>> 
>>  * Store the tunnel as an allocated pointer, so it is only finished when it
>>    was started, and drop the local tunnel variable
>>  * Add a test for lowercase from:, date: and subject: headers
>>  * Explain in the commit message why dropping the From git-send-email
>>    special case is fine for mboxes written by other scripts
>
> Thanks, I'm happy with this version.
>
> Patrick

Thanks.
