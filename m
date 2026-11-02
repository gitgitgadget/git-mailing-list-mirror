Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646060;
	b=YJmyHhnFWwNDGTb21Z7Etn1zeTGvSBOmhfRVzntYkg4SGLiR40UidKcEdulVMf2b2nZr
	 U/bPRKE0DKi/wxlkgwVwxsCDsK8suVj6ZOkXdXT8klWfKKJtjyFOAoIUVIxe3yDHG9hxe
	 K0dDUgB7Q2OVaPmwTxvB6apE+SQY5pF/7DiBtcz3nEdbA4R9O6eg9+1yHVlZxB0SWG78a
	 C3+8+JYYagRD26kU98gen2P3wYDhjn4wHzT0U+wWp7zpaUdgvI5Pmn886zBdtUF+7SkXP
	 0vbqI7eqiysgd0wlSvm0IIiHtEJ8KwpZ4GVqzsxu4giGPHKL+Xud2eMN5Y+JszHtOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fcvrxzmScB4Q6Y0X2r0TuxkBvLWjmwwTBFImv8yhLI4=;
	b=Er8jN4CsVHpbytIrnSl2zyU3kRPUXp2y3y8sDaRq4JCnv4FSYP51YfwtFVAoJya2LazG
	 s5E0yiOCZc8vWnuEfJwtvFchZSBLJmmJNA0+8WPeGrHPTFFLjrLuoTJcT9iTXOiOHmhgH
	 91Oq5UIKrw0XusfUuCMkkeyMTvTN/6KgsSlY0K/o9jMjrKUC7cODueiSl8eqp7VkU6BoD
	 U8aue9zy+6RiFZDa/S81XxDHMaoVYfG2TWjrdXgIIu7+Jzi/Y7NfzrUu+Br1pAsONS/tI
	 Vl1J/aZfrF7OC7cPoaNRjLN84DkRCKCsL28/oeREowrfaBy+n1yrRmswVbD6QRGHiLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KgQ09GC8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PhRs6g9O;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90C606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB90C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KgQ09GC8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PhRs6g9O
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B7677A0115
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:00:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 14:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793646058; x=1793732458; bh=fcvrxzmScB
	4Q6Y0X2r0TuxkBvLWjmwwTBFImv8yhLI4=; b=KgQ09GC8IhLutqoZop/dbjKnmq
	C2W24ucBdFR5hdQyX9SWgHUlVY8i8g73Fyr/dNRtqAoTr1Wh8vyRom3AGuoIr3G/
	LBnkxMt/yfq0sz//XqreWeYAx83rZ7y9VQSudPuM+F8z9PxlyW+jfyLOkTwOD6Ju
	RpVlTAz8srllJAJ68o6WuFVKuvXFJqhyUg+ug3QlKlxjK/BN6A8OVV+I1O6FdtSF
	cq8zI5GqrtQwYSH8dwSV/efmFjNtbgKPXQJ24NBH/TkM2S/RqsraSsTd3rlWjlE6
	2GFJ0KyJVhyTmwdThHVZvBwMmeRinI12sNMbesJWzjwiJGuAAbR9vyUoE7Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793646058; x=1793732458; bh=fcvrxzmScB4Q6Y0X2r0TuxkBvLWjmwwTBFI
	mv8yhLI4=; b=PhRs6g9O74lQHNPfgXJDIeBRKX1QekZG2dz/go78+/W5GfrF4gP
	ghf7A4dSqFk79Ss4irPZbkBISFNSBGmjoXn+udxT7XNYQ1/jYeAHw4Io57vMHU+e
	3Dkzu6UfR0t1W1OZATxg6K4y59JpuVTLjeiuy7tFW3sQSWG4sKhNfcvWBHc2lFDP
	38b3hzyaNPTR06YaySmyDt1V+lics8WmZ9jqgyddNehkFEoZqMaou+2Be908EKqb
	UzLM3QkFOrXA5Sa7qk/U+ATg24MNaTVXJDX+mIKZ3/jm81HGNzco+9x5MDIToEM/
	uExIGo4G0iSNQuwvtmEz93pNcr39H/e7qgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793646058; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lwa8HLSlsZ6TSk0ZEV6H6LdYu7HR9dRjz4wLeygCceWJx96
	PJQcRbRo+wlYRfJ1+HnTKB3sawxp4lmztlSb1TOKEy/ZZhEl/r71zZYO28AgpG5N
	SyQ4qb3lmh3mb2eS76uGCE7UjR8VT3Vx87hSPja9RWTOxZQO1b/zU/Y/4e8oTrcz
	BmOjpDZOUSN2+PIywLQj6I8RxvrojcGU98UtXFT7Uqaq/jcBYj3yuT3RiGw4fsuX
	W/xQrSPaMqv10xg37Dp4Kr1t6p7aQ0HA1v2jTIM1KN5Ye5vG4HfO7nHAli3Un4kT
	xmhn32FW+DsMXw8CpETy/dNunu81mVYgyEYt6Bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:t9x/6/2SXCHqc1F2O54r+xx3UsG1kS6v2IdTlnB7ri8=:HVpjf6QU46XFhc8s2cgZ3GmwW59Jm8/EIQJso8hnDF8=;
X-ME-Sender: <xms:6t3oastcoYWqM1dMaPwGKSf78mpqAvITVAfzDs4XdGW6uK9fuwoUtg>
    <xme:6t3oag7cCCaJ27U3UCTxjtWgL933ZFpv5s-zjbY048uNkmXcb792LIdwNxfA-h2Pk
    40QDQUjxX2uJndEzhC7L8qhTtO4SaCifeVjLUsTA5dxX77n_aAjGEg>
X-ME-Received: <xmr:6t3oalJO4FzoMWm0UBsgIk3Img__CwCQCTOqMoLvFZgBiu5_n3O6xowSV5me0q024uA5GA5RWkb0dJrpSz_6H3doUC1oLck5KQ3M>
X-ME-Proxy-Cause: dmFkZTGo/rxjqFczGuQ5dxJGT3VNhmqEZrrOsI9NyD9UR4HecmK6AZuef+conBbrsgxVyd
    /DSVFJf05W7xBZN9QseQL1yG5WG0kpxAsmueXkT0DutZWPxrjFfAQHtEe0LEkPRMDEBs5O
    Z4THgwpZ8gzVH7wMS8e+IvQmy2qLClJa1mERfWFZ4OQc0WBLQxLyHX4Jpc5KdlgrnTXz7r
    /Qar8zkfMLOFKHWw4mfJiryL6wG9gLHCK8GOJ0+eN7ncDal/UL9/6oipYGQ7lkGHW/5Ms8
    EdEpnXLM9gAlCkdnTHVmkbF5LfttCpPBUp2G0RTblOd4G7/AwObBiLQXzdA4BuBlhPNZjF
    I8mIt7xIna7qSKpBNDTavzQc6ERpDtleUGX+ZciBY7xx+sZt8FRMlDU33U6w0dGQXHvWhK
    ghS/XiddfbSh+4qzg+Eenhbvrdwml7hy6RHbqg9CrKiLEiwKrV+EPFZugNB3LZ+TaDplo1
    TI5KZTezxaV31filT5f5r9H+58Snz4LiI95yjhF/E+v2B+cI4yQbQ4goyn4zCF0DLpXk1d
    oz71U9HSLzngLb/KAHKmczRNHke1U/G29YonVccg2Yx1FWMIPzl4CYHEL/Bw8DbWwWC96B
    T+h4DpE8W4/SUWh5TFy5uws3/bhF1AkZMHk+TcTV1zMHzevb3xa2hp1ev9YA
X-ME-Proxy: <xmx:6t3oao6IQUpvGDTGUTYPYzWaLD8DQ4VyJ542QIdLBLsClH7nL_6shw>
    <xmx:6t3oagw04O-vdfX8grptwnDFpWd-dA1Ov_n0C97uZjR9Kw9wnbhsFg>
    <xmx:6t3oakZy2v4snOgDgh7ewNrMSk0qFAFN4yznQQ2mvX7BEECXtFn9Ag>
    <xmx:6t3oaqSVCED9IU-hUAtwqhVcAYdQpeQ2CCfRXwpjzLh0SOEWsEbmbw>
    <xmx:6t3oakuq9IdG0f43RQ_qnaK8OZblC9odxufCwhjL86IpitgjIcxz3-Ci>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 14:00:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: hide refresh_cache_entry()
In-Reply-To: <auhbjFvD8CNXYcgQ@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Nov 2026 10:44:44 +0100")
References: <xmqq4ie58syl.fsf@gitster.g> <auRm0Ohkg3OQIbWE@pks.im>
	<xmqqpkwrxkbq.fsf@gitster.g> <auhbjFvD8CNXYcgQ@pks.im>
Date: Mon, 02 Nov 2026 11:00:57 -0800
Message-ID: <xmqqld7bhxcm.fsf@gitster.g>
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

>> > Could we avoid this forward declaration by moving the function around?
>> 
>> As refresh_cache_entry() that has mere one line in its body calls
>> refresh_cache_ent() that is a screenful and defined nearby, both of
>> them need to be moved upward, so it becomes a rather unsightly
>> change, even though nobody would care when they only look at the end
>> result X-<.
>
> Well, people probably know by now that I myself tend to err more on the
> side of fixing up stuff, even if it's a bit more on the painful side of
> things. So I'm not going to surprise you by saying that I think that
> would be worth it.
>
> In any case, I don't feel strongly about it.

FWIW, the version with large code movement will be the final
version, as my philosophy is "once written, unless there is a
compelling reason, do not flip flop" and the last one I wrote was
the one you suggested, so that I can see how bad the result looks.

I think the patch itself may be ugly but the result is easier to
work on going forward.  Thanks for pushing.
