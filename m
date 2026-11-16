Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850323;
	b=Ga2HG+wc122i+tF1V1ImS8CkgJ5hz0jzRTdd/SmwWAiyiSxFABB1uIaYBfVdeL+NOj4o
	 F7NLxGEs7GXNhcFTuhZM1+FXrgfsewJLZlnuErBoCdtC4bdy0nlrmKpoqZv0p0XNWBwIR
	 fiZR2AzILLPzHXxI0CPJ0UJx5juRcHPLuRYQoaXOAsyP+2GNEVrhGyF7RYu8HM08LLuJE
	 sw52akIGtQxZgw3vZahnbKHprjrmzmBOanjeYuSw+QgM488+yJpa54kYoJ1N9EcPcTfd6
	 UMLiMewQW+2QHAtWMfvM5m68O+pI5uh96u/Nm7AuF5qhRO1uMUjUgrR63lklRrVEksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850323;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=x9SD0ksq8Xe1YCPTTP/rcmQ1pdzxP+8kfVQUYux6eG4=;
	b=orNVdKg6zudKdsgwE7ysdWdmu8ysKwb3hZXBloqO86sL3oyk5LICeJ5NXNX+CdfxOHvR
	 Ohd00UBUwMgtlEVrRdg36swf/Kzx1cnjQ4uHXc+aT3Xq+5wK8TA8lg/ivTPMfKH0DQRWf
	 ZumvtZtSLGIXRX+guiWco3I15q5Urvh8fhYPmMW7LE3TfOveihlcBO5nfUFvcSHYzFxlt
	 /1YvWZk4grrJTdc1qYDu9igdVFVDPN6cmdYKEwRk1X2rhtv8tX4SdPAK7dQKXFFkwubvz
	 OTf+qG8THYULq52MJaZvagMZ6PFaJkjDPAH3QidW5EUZgDfUeBPqwEe0kxLohjIppQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hht1hSz7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nl23dYWT;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751E606A333
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2751E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hht1hSz7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nl23dYWT
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 41BC7EC0224
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 12:32:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 12:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794850322; x=1794936722; bh=x9SD0ksq8X
	e1YCPTTP/rcmQ1pdzxP+8kfVQUYux6eG4=; b=hht1hSz7cf4kuLrng3eRBpq5Yc
	mwPU8TIzEHf6m/nctKYMdEnlfTCAcNx+P4DcQx2qzsKQDGOG82qP+T0w6iyvTQdz
	FtgxkH4kn2hUtsOsLBjxABoGfDXLZDza7PErZ77zmGQ/fJ+n8kBWu2ZOXog5pPxm
	EjCOTo8R32Ydq00DGtXrixkQGZB1yysp5XuU9I9PiQg6DPpKKBWt4wLJCaVDkB+L
	DRM8uVPNARt9ukPXRHWvv4nbXGlAlOuLc+WjO5pdKPDtjtzi6fEPT8fRIF0QTAs3
	vBA9lcjigi35ryJGNxpKYzQp38aOoDQJSrawqU3n7ZgCc4EzS+FRCHHoh/Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794850322; x=1794936722; bh=x9SD0ksq8Xe1YCPTTP/rcmQ1pdzxP+8kfVQ
	UYux6eG4=; b=Nl23dYWTsqPDlbL2WtKzhQ3m/dxg5qHquyMESm6WN/wpnKyYxvG
	WTn/T54hgCF18IVPyBcHovxjrHk3c/IF3snRAmhu4oZujdNxlzK3TxqFgMAAnq9c
	xJbxiqNzQ5NeRPwbm2kOgsmoHulfcvlHdca3iLBlIY7Bo6t23+3ZbQRBC1oUSaBa
	Cb0RCNmiIPjl/um4HoMjo9CI1Il0JxtBvcXgNTzaJjuA1cf6b51INJGgWeGKcfKD
	yU4aqrVN7TXJxs+5Eyu7gSNB4DM32CQIPRNBcXWgPe59H4y0ilDDnRrcnnI8fvNG
	dotAN/61c/QLJxBlDQCiky2+91lME+pBdOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794850322; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lsB4MV1OXFUBVdm3JNzV1jA50dGFn7yNnt157kMUjr50CL2
	SJdBJAtCeYKD89NufWSvNdfbu2FPBmxkpWVV/OmvMSRdnGbO/54El6fTCBk4VHBD
	Gjh6+5nJgkPwP68STCnWy2BKcu7c06pt0guDS0tk8ac3iUIekzPZif9JPjCjchMs
	G7+fvT/7/P5BoRSwxK90gjpuEktQQcbUYDzxLPIIY+2FXkckyo9MQjwYV8OOGai9
	Kd0QQWBQyuqO2uoDhiCarMkGnOBtwMJ3sg45QG8G89V+7Xr+uMw3MRapVy7Ce342
	gIaopnl1IzuCVlL7A4lYBAlZbwShWIEvRGPXjaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jN5xfd6FcmD1evG4k+X2j0gvXy44aV+x60swCyYLgR4=:mhLXtPGTQx7xBRzY6s+aNMwPZyb/wMzfPv0SnU3QzSY=;
X-ME-Sender: <xms:ET77alfjShXuiqLRA6dDvm0pbaq4ixoGoT0qNUPiSy5IiqMuMy0kgg>
    <xme:ET77aqHcg3pPVojraUg-DrxXZWOGizHHHzUg2-pNjHBy5UOHBiJuuePxb9BzAxy0M
    Lwr2BXOBv1nrXlocLBOK_TEQyQt581ljvwYWCCqqjXKVF8LNygmEQ>
X-ME-Received: <xmr:ET77am0p3EcOi9_XDXv8PZJE3LtoGXmwaRf1gic208HY5dZspEecDZfk4YkHmNgBUHtkPe13ZGdAJ00dS4w2n3hYmH-9h5_O0sJv>
X-ME-Proxy-Cause: dmFkZTFa/nLbA7k2GqKH3A9lxSP1WPTeLkG3qDM2Gztl7/gj7M2mjgVl1Qfp0BWPVo/GnS
    6tpvrMAHf/LL7HdEOZCQ7djctYr1du7DXICUgch3Ni8LQI9qaftkgmJHYZf2KKDeCt+1/l
    /98DbL/YjKlizsnIMJSJRIqKxQF6y7+7bmax5Yp/q4+1cFb3UeCPlBIC2cIBbm/2FB677D
    OzbQd/s3bzvcTyQte18aDqmA/tEFoVqJHoA39eDH4ePk5ihR06UXuDZEstNWLO+bIMrHcy
    9DFuoHTNN+UrVCuBsZu3bCpwvSSv5a8r1FEM/WwVRnC6K4ZcZldjBuun07idCE50A/LCeG
    mxBadcNWK6jxfw7wAyr5g8DAtf05r3Fg38OtHFl0mXL5a85BQMiFBXQs9dUKUWslj1xsCF
    vhvnEyjqgymxaTByOW4lqLwT38YCrS3gjCkZO3nrcd+b3yyF29UVG1Ag+4XdrQtZfl5vKD
    p6+hg0VYMp6LcrzMVd0gsuTjvjBoh2fxCMRIQTZjzFLkzzjvathewqmZ6m+bwHiN/bWHwQ
    sk38RwAAdJCnD06umSWB8NaEOLjpFFS408EyUu2uYZ1gEOQbmAeX0lLet6Fwlo0seM+dHp
    m209uESLxSFI+vqgiXSiaTHivtldP/CV86hQGw+WOyZenuVH7Ih5UnUi8Y1w
X-ME-Proxy: <xmx:ET77aqm7EqJi1DdSWrrO19X2fxak9wnhRVHQGZA7tqgiSWplMqKytg>
    <xmx:ET77au95dZny7LUHJvf369NO80M9ryCnub8MukF5Jt8lseA_9S-CRA>
    <xmx:ET77anr-4ZBcbYJvxnrRAcNzZB4O4Z2In3U-hzZUm9ZAqN9ql2N5hA>
    <xmx:ET77avk9jHXcYViOx_gsoLIO_AewxIo_Rhck3p7YdhYpwnm_VBLTOQ>
    <xmx:Ej77ajn5PL9PHEcgCwPww6zVu5qsR1ahGsiEQl8GRomMSjOp0YxZBkbx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 12:32:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 0/2] builtin/repo: improve counting of objects
In-Reply-To: <aacc4357-7f8c-4e5f-8cb2-1d2bdec767e4@gmail.com> (Derrick
	Stolee's message of "Mon, 16 Nov 2026 11:02:30 -0500")
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
	<20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
	<aacc4357-7f8c-4e5f-8cb2-1d2bdec767e4@gmail.com>
Date: Mon, 16 Nov 2026 09:32:00 -0800
Message-ID: <xmqqpkw4lm27.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> On 11/16/2026 3:01 AM, Patrick Steinhardt wrote:
>> I was recently using `git repo structure` in a very large repository and
>> was eventually greeted with an OOM. So I had a bit of a look and found a
>> way to improve the memory footprint and speed it up a bit.
>> 
>> The repository still doesn't produce results. As it turns out, walking
>> 33 billion tree entries takes a while, and everything rev-list based
>> that walks trees is kinda broken in there. Oh, well, a problem for
>> another day.
>> 
>> Changes in v2:
>>   - Reword a comment to point out that parsing the commit should in
>>     theory not be required.
>>   - Link to v1: https://patch.msgid.link/20261113-pks-repo-count-objects-speedup-
> Thanks for these changes. I found your v2 patches in my inbox somehow
> disconnected from this cover letter. But I'm happy with v2.

Thanks for writing and reviewing.  Let me mark the topic as ready
for 'next'.
