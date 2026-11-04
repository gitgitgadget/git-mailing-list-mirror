Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818746;
	b=DoeiXCcZceE65lJyL5qQAZP7M8AtyTTkofn/C6GM4xeatnFgQCsRcV3dxWfvn7LPC756
	 iJdHCgPYkp3lrkJ9A9bTR4V3hA8X6nYb5Z3yFSrN6FttDpDadrWU+cjIdbt5QjbVkpNnl
	 v9xRGco9UNll4udtfY8dqIQvs8DCcGOH1mTJvhTLI+T3vzCln+0PuvmlvJy0n2qbcbrib
	 s1wtOsPNXE3ad49rB/57FTWsXTefcUuQTxVPYVXrWf4Lg37hg2PexgriFrB1GiS80o7Um
	 /ipOYlyKKkdgBcYjbib/AWru4cetiKW56tKn3CHhnNYjoGeqgkn5shA5jwBBwbZsKJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818746;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8QGfZRxl3XMwzUzthpm7P+5ehDVE6z77Y+Id7TZ6liE=;
	b=4/jmEF8dVzHFxcbvQzUkado6YwNZ0/850N7pUaUM9cEkI4H2Usnzcm1vJs9MN2QeTvPL
	 cm20LHCoKB4mbFDhwaw8SXwBfkwWWxK8D0xn94VCy6pixLthkWynHa0VyaKRhUAP/Gce3
	 gA0hXZnz4dtUCiBf0qjYMyuZfDWBP8AaFXr5u1NHXct/msiAM0A6MsD904ls8Q/dWlyKi
	 rucsCnkc/E6XwZt4BVXHPg4H8uRZHlG3x80FrfghNFc9ceCWrdw1FPCxgQbSS0clo/xEc
	 jYoOkCCHeUtgK8J40RfeIuHZY1IObgqGbK0iABI3gQog1sytAglEhV68KZrIpK8Hw9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=K0z4wrdC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="TB/U58Nu";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC4606A32E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7BC4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=K0z4wrdC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TB/U58Nu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 39BAAEC24ED
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:59:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 13:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793818745; x=1793905145; bh=8QGfZRxl3X
	MwzUzthpm7P+5ehDVE6z77Y+Id7TZ6liE=; b=K0z4wrdCQSW+96c8Qj9+0SnJx4
	fA6zltMbbdS93tMf3+S/Ky7bYVb1l6SeNpUa6B/Tqh0tdIVnpWJJhmzoCY4Rs56I
	Z//30ox0AJNi7MrruhqkgeHWJKaw/5HJ+3tjN9u5WE5BX/SUkYZO5hG720762MDv
	Gbx3OmrDl+nq4p2XDJj5MNZLWnq+XVCgQbKWG3fuOvmT/MS2k4EmvAB1rcj97HKK
	mLtbINokmPdvaqtOcrOvBWN7iiuS6HEhL8WfYiAc9BDO/qxq0XZZcmyKRT5cmTFU
	Gj0vbgDEqdcmeoi2rq8PZg2QSskpYHN2YH4at2EkUc+2pxQ9iusuThrRnqyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793818745; x=1793905145; bh=8QGfZRxl3XMwzUzthpm7P+5ehDVE6z77Y+I
	d7TZ6liE=; b=TB/U58Nu0sAfWwRiQEdt2onLaq1hwIdku229px3AbC+6q3GW4wl
	sNSI3EzGmr1vpvriZ7pp68NsavQgG0Jrqd2pfiAMdS5WcAYH/2FoCabqwHMFUYRa
	FC1auLtihcALFbu6hwfWkoPyjWWJ4tsQ/lAs6Q8f2nYatsvRHd4RESSA0SKGTV8N
	gUXhREeFsVrW/SCyxXA1dYnO7jK0dXzX+lKxRwXlZmHI9yl34MulkFp1QHwAkih+
	9HwuRFMhk0CDWszcC9QBoJZKyBGj1N5KpY3tvtuj0qdtbJjevmVmrkDEWDNCqk1Q
	Gw4UmangRkMEfiHjxHfKQTFMhWqaNaoXXFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793818745; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MUUfYbfy/uerQt0Z4HmXd1GROZHRII11vI4eXGT+bC3ci5c
	fOYRqo8PQbS2F/EQYh3ToJFRQXkbdR8RWUo6W9Y2Vugl9ZzGyDm0JIgjnw2FtIbi
	GSnnuJ8lCoLqCng76jEVulUxFNKu4ROrEf0f/88Gu8WaPwYSvs3HtJYEE+qErArO
	4paF02MinHvmfbbOR8oTXHDLqJYIxNn7lhy1ZTQQUpND7USCqkRSZXu/I2XlYCvV
	BtunBB/3vzn0ujcWPXyIj+pfM9KoN63DPUUSnfz8Cqvb3TWMkJu6f2KbLhTff6tA
	cdkByBfUAj5v9ahwG3uF/ABsWghc07WJfke8A+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:H6LtPCANFlEgCAxAHlgbc65UvSEZzSxSZlqq+M+E+hQ=:WAQIZpJAWfSuDYZC8IgHglOdAxRzKKeaeCmDHdpiRGU=;
X-ME-Sender: <xms:eYDrasS8ZBn6qDEbchuRb-UwhaKiiCTmrM1yfo8WFYCrQ0IkXzjn9g>
    <xme:eYDrahNv_v9nk0hyvvRoJsNaWsY_-hLm6AimW6LpOA3hHSc-WjDOYMTmoMZQe6vyz
    2mCK6ZpnDbYejXBx7BqMkPMakUbSkU3orMGnQVr1KK7BSY4MR_nPR4>
X-ME-Received: <xmr:eYDranNlIque-KNQz3jHO0NacC0IXEh9I8mv0j6hHJa_9KtMKmZeXWOYF984nMXzpan1nDyGeaLHIkWq0vZZtYdD1MfyXeFScICA>
X-ME-Proxy-Cause: dmFkZTGj9bd/ZtLCFyDxP56eRHkAgVhItwGr+2qksOObrOySb2d37bMdqwOgcdTvwa8T0I
    xC3wJwW8vAp4xWa70COpayO0Lbkrzzu4Vuc4MdYVoIr74LriQ2M2v5Ti9zRvcMY5MreTjP
    UOSKbz2JiJzGu0YXmUVxv+zukvhcfAMw7P7a/0CjREm2xkmG2PAZ78FY9wyj8Wc/EeYIX5
    dYki6UYn4pis3OiAC1WzR9EchYBikLmGc3WAwvmTiO3p1KrflBShXE8blcMsA84gtp4sK3
    oG1wRhxRsnwfmgnV29nq1crMXC6hkM8DyhXo35EZKEd/sNGydlX/MVsNraB/rzeV+ps7GH
    tWMfKSBmnz+MX/+QBRvX3dIOD2roDYw3RPNG+zCytehqDpf37CqTujECIZJvndWlM5aQjh
    OQ5EynJkcu2sCtUWPx0L00y+Uq3fUtMOufjZvbQZuGGRFuYBproFUW7FI/92kAfdNE9aR8
    E0FJcqbKZ4N0btPwhx+6xvQ1ruw8stp7jKiFZvm4BPE7jleglmrXZt8pF0FCYp6+av2zsG
    5UIpCRA4tfOJQo0QCKdx9CW6EFcDGEs63a2Ed24w8+QKZGw8WosyuIvz6L7k3YfLWkXR4Y
    Z9nFKnrVSgwFs5RwtIdM2p6B9lbfVVlr4VSFbqgNmhQYTb7quCYbvHVGfNIg
X-ME-Proxy: <xmx:eYDrapsHme1EPiyEtREtimdtLpsQXx0EXrHNaSojmOwyh8upMh-DFw>
    <xmx:eYDrapX6Qn5bZ_GyyfVft4gdmgl16fp_q9lpfaKf8glIJZ6lt6oXTw>
    <xmx:eYDrapsQlDFBzE61pt4nauuE8c8Hdvh2_3BW9iixUoQ7sm3v9JlScg>
    <xmx:eYDratVdrUm1JS_Sg2MmM_dCQHO5MhO5eDz6oRLGBxDR5d7c1kChSg>
    <xmx:eYDraraXxs1c3ZfMN_YlCCL8PHLtnJXVTzn6l_fT3SQBTIMrAwJbRROt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:59:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
In-Reply-To: <xmqq5wyfohv9.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	01 Nov 2026 22:41:14 -0800")
References: <20261101185846.24208-1-taahol@utu.fi>
	<xmqq5wyfohv9.fsf@gitster.g>
Date: Wed, 04 Nov 2026 10:59:03 -0800
Message-ID: <xmqqecd01kzs.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Tuomas Ahola <taahol@utu.fi> writes:
>
>> 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
>> requirement.  Update CodingGuidelines accordingly.
>>
>> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
>> ---
>>  Documentation/CodingGuidelines | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Makes sense.  Thanks.

Oh, no, not so fast.

I'll mark the topic as "Waiting for response".

https://lore.kernel.org/git/xmqqjymvooyn.fsf@gitster.g/

