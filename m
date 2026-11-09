Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254185;
	b=pqTLIf8RH6MkEyIAsRgGQ3vjG/OkIOGnxeqOq09g8/vGYHEBsPUZ+Vb0m8LwDt/z4BD1
	 HKQjBxd+18SeghVgiziMGbXnL8QBANYA3MZwZ1izu39yv0Vi98Uy7YfpeBOF6Si2X1dvM
	 T0CuFyKVMu2xWvdFr9+fmQ9K6QamoMZlWmtzPvzq2tSeP/YC578YqfZVtE6/UzKA3MSgG
	 cxAQbqwXVpcmgTqOBjMX3QH2cwmAu6aG+CRZ4Zh8G7oLSwu+KFo6QfFQhvZMFJAVlPP9r
	 KoRegyXFELWrZJ+iwX7Xn0BFqwcTABxcLW7mmd5h78iS6voxdfAvJ2e22vKaLovhWDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254185;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=U43izUbWkccPNlFlz2zx6coRuFa4SK6WIU8Tbfaxlz4=;
	b=dRB8AgatsONYArICTCBb+GZd/FB6X62M1TYfV8JzpcTAi8+j7YIqVF3lLhF/KNVJ7Dy5
	 /ed/4j9jzEfW43bON+pm/TZWFu6t9urqeoALszCU+NUubHfLW4471GUbvXJv5R4QXBBl0
	 94fhIIqNZunq6uI6EX71G64CumHIe2IhMSMHveWVQ5DT+WQ4wzT5Votbjtj/Hunxfw4Vi
	 3SQ17HmVEYpS2n11RY6bjCt42kTkt5N7JZocLYW3645QduXxsy7T91p7sqBGYjlNdQCmd
	 SF0yrksxHpHxmmPm2GIFlkvSsP+eSQePWUmQxIHLyhsS3mKwJlx4PRZ685wqYfnPi6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LV3fs2VO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SRCJrgHT;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6C606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LV3fs2VO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SRCJrgHT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DF12EC00BB
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:56:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 14:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794254184; x=1794340584; bh=U43izUbWkc
	cPNlFlz2zx6coRuFa4SK6WIU8Tbfaxlz4=; b=LV3fs2VOa9ibO6FSZMwVAsRcs5
	WH0LVVsAaR/q0QLbdUwthmPVs/lH6rzPwAsuOi9trEnUdMuvgEBa1DCmXIk13+n/
	rclDP8yDjgs3y9mRLwK2onpvbrvvCIEKjjwra8RA3x+cDCiiT5KNOrTyapNVElmH
	9h3o9ePoFMog0fD2SuOapQgWusNS9nSyOMUpJdzX/m6TPujtd5GogcCzhyDOx5OJ
	wR0oxds0eix8xwDQvvPliXDpgt59rS5xmnR4K1McVVTnerfvOqvllL/WVGWj3mTW
	zp1D4FTdqWWur+1UkwgnLX2ddrzq7UHZeMLfI9dMLKwZrQ6FqWQgLvDQw7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794254184; x=1794340584; bh=U43izUbWkccPNlFlz2zx6coRuFa4SK6WIU8
	Tbfaxlz4=; b=SRCJrgHTabI/K4fk3QqnB3Eh3N6NVcFrYAlHdww+QpUAPMqHDUK
	NaiiccgauP4TMgGa8AQ5kRK9unkLE0lMFHEXqjqpWZ1jezZHXxGGbqmoeet12Hxy
	FzBiN3QaejCWnOwd6mXEH3FxKWzr2t7OmLSyA1O9ZycgEeOV1NlMzV5KAok8VIMr
	JdVvCroU93hNqNv77lNj+3l99vhN30vxFaOluBDpyBLh5Xr2QwofpIsd1oKX3FNX
	zCdifxcWRJ35EFC+IMxA5reULzTjd9Nh3bmtCntgzOKwtaAxwJAL3xAvOzIgNTXP
	4LyzSLrDIx/x+tQ8CIAt3U2mdpHXAs9T/Pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794254184; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:m4aRjIxsW4ol0ShTCi6yUjVbf8TiHCcKEBOzoi15yhUTyZw
	9qdKQj7d11l03/YS57KIJ7ffIHItassuQbRm0NsmE+xtpKKUOgcVJjhauic/D0R+
	w8Q5CsCLHLH8TGOjjdGNQmrs5kwuwn/c5eu8pLMJT8+0sTSnsnuqFpiEZGOlj/c8
	uiP4ZboSvA/Mm65xvOSEkFzd0BneNDBTkARYzkn8grfrnzqmsi3Q0oBRyTIL5VwK
	UBIe5kbf3seH1+vPRT9ZD+7/g967HMekzxu7gaCHpPvTakx047544Ejm11ddGWjs
	+9ofBzM6m0TFSxNnZ3xyt2vqz2kWRRNuFSLjUTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GrHjbsb12WpIseOsQFFCvs1iBdDrhvOB5662bV/T1eg=:nDyeoqHmaOIbNQ8Wp17owqDN4YPlBykC7P703G3f5AI=;
X-ME-Sender: <xms:aCXyalfmCRC4hvBEQ1npoTaECzSDl3ffNA_2UdyAhasEkQFYYmu11A>
    <xme:aCXyalwdEbZtVShhhGKMGWCkyDFOhbvyin-5pfC9FOBcbfumkIP9doxM_9kXuHtzx
    CygYQFxuGbf25a8M67Ge2YlONRuI7h5jnzruI44zf8Ze0PyjkuMPWQ>
X-ME-Received: <xmr:aCXyaiL9l0WeowlhrDMubKCvoCOvTvi17mbQ4hYZaWWfMKBnmqpQzQumUyjfiTbkR8R-W2TmmJNHtAubHUFsXKonF479ypZ_mvDI>
X-ME-Proxy-Cause: dmFkZTGP/BXGmX1b8DsgECM6GL8TnuvdHlWxYdjt2jkI1FfvNudC3W9EFy49PXuk8SdCoG
    uZOQF3jOQ0V3+qUwzWSBIyeiXEUFLNhyUmCzIMVexAQlk0JzIUnBSYXUysIH1TW7uYu7zs
    mInYCTiVClpZLmHXOReUiF21Ikbt9UQMzjqYigJCNp/R89KCfdHkOzSEipWE60xIwpylgf
    3dcCzdsBNQ5tBssnUg0RRDeVFYmBzmhmJOEerP5yxgLSAyHXQjkC2xc/kls1RLEaz+2T7y
    b8wXeX5FUrg1zlZH9JP6IJ1Y4l4w6KVzKaxg/FA8TUnwUvkauo6RH52DMKbCvz21Di7uNC
    1V8Cc/nMv+KMA1Bk4kgt6OGm2AmsBddUaRnWtST+7rlE4WnWeqbp5+O2SVWK5lxV9Kziav
    gtCMN8cn3HPjtGsCdmJvfwDLOL3snTJ4Dn5YygvHB4FQ80WACuMaw71ZQymSMTr0DRqI9h
    DW5kqIcvcFoc8vWKGgqgP8SXVTRqUvYLhLNahVW/suQ/B5cs9yqk+ovQBamCHMaVtWKAHG
    CtWx1YJ8S2VEKXkr9OsmB4NZWIoqKT9qDkUizC8zJTGas+EZqVoo/Ti6ophwSQG3WXF53j
    iMZhJyoHe5y9EnoFCexZuQHqO/nVSJuWOXnecHoflX3E1Ke33uYPaWNKgzrg
X-ME-Proxy: <xmx:aCXyavEICBQ_bOKFQqf21VBlw0tqBGKpfVYS4b9Ybd40sgwZX7qgCA>
    <xmx:aCXyam-EIH1f7ConTmK4fWWHpZKxlqmuavRV94eW9iSe8luZPOiS8A>
    <xmx:aCXyanLTyedxYWqOjXOxfIiVIEM76RYn-iaXmelM08kFYxnEPFUE7Q>
    <xmx:aCXyastvBpexSgPUf8d81EzoFP8floD1uRjKIrqIEj3ieoaa262wSA>
    <xmx:aCXyag45D1eNSplLaz9S4BuZMIl5pFr3cCM9cXK4rNEM4G14v2XO1rhb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:56:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Tanga Joris <tangajoris@gmail.com>,  git@vger.kernel.org,
  jackrawlings2011@gmail.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
In-Reply-To: <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com> (Phillip Wood's
	message of "Mon, 9 Nov 2026 10:52:28 +0000")
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
	<20261107195429.96842-1-tangajoris@gmail.com>
	<7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
Date: Mon, 09 Nov 2026 11:56:22 -0800
Message-ID: <xmqq1p8tzsm1.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	cat >empty_section.diff <<-\EOF &&
>> +	diff --git a/f b/f
>> +	diff --git a/g b/g
>> +	index d00491f..0cfbf08 100644
>> +	--- a/g
>> +	+++ b/g
>> +	@@ -1 +1 @@
>> +	-1
>> +	+2
>> +	EOF
>
> This is the only one that I think it is reasonable to accept - we have 
> an empty patch for "f" followed by a valid patch for "g"

We shouldn't accept anything that "git format-patch" (or "git diff")
would not produce, I would have to say.

Thanks.
