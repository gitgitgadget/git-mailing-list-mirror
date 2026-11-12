Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456493;
	b=wx1UAKUfH9pZY9qP23ll8X4DIY81pqlzT35HmIIMZbabqaO8OeSmad7eKIP+ouZY7mKn
	 HKX+YrDqk7L2QqvpQQiH1Ko+1E6Blva4U5Cv6GL0Xmoc47OEC9hvPxpX7L+fhw7Fy4rW1
	 MIL88Tk7DWTfGoK6nGs8ZKNZ5Pfd1cWuCPG+u1MfTbErZKyU5wNU7a85nim/z4xXnlIgl
	 WpFuqf7T7GS/noilUr5xS9v5+guE1JHBeUBIzAL6KCvE5J4N9+SKKqds8Yawsls/Lp/dC
	 h44sGgp8vq8F+Attrw74A/mb6WVtzcAOShKNh8GJyND/8zLWjX+NuvZRUO73ObRdnbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZduaWWX7tt3CeVt2FgusmwQ7IB+F7ApNxKfJztuTnkU=;
	b=IZIhki+XR1ShKbF3wkr+rCvTczS7TDNIanS+a4zVK2ydajZ/ZNKepdNt+Q5So9hTPCPR
	 DAZlZzFs5Mmx4/Ld5G6miggk31qU6R99ZnOpHydimYlTw8yCbjfTbvkydX3Wq7jKVzNsR
	 6caCjLOZv0bueajC6pXZardiRo5R0Qwwb+jl+lznQbpQAJlN1SOYlQWCELTYFDzlXDVk0
	 u8tCZM8LzPwmsoNxmn357XNT1qSNU2TvVw0fYN2FQda0ySYSOWROPfrm8vmeYP2WIomPp
	 Bb8XdRm/rTyfMaU0Ko6z27Yw/NvhvxG2tqEKCsLqsNNWqJeC3BKC+zhYu2ZBjRn/oJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jWDeiRdC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RDZVVfgj;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA54606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 04:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA54606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jWDeiRdC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RDZVVfgj
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 821DE1D0017A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 23:08:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 23:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794456491; x=1794542891; bh=ZduaWWX7tt
	3CeVt2FgusmwQ7IB+F7ApNxKfJztuTnkU=; b=jWDeiRdCsdyB/BeMjCh9egf4v2
	0amC4gG3Ln505gRqBNSUohmf9vJUmsHh6Q1B++u7Dq2pTL4rwWGNnBGcPOP9rNdy
	eXbF1z5r4OqGsKQYOtQQ3SO2pz5nHs2wfhvmsBvjphA7bKakEkLSJrBtBDk+4QoT
	5CWM8j1SzI1SS7CUuSjoXJnUzjrgtM3GW5fC68w2Ia3t5C7qKc9CeGfssc73IST7
	tak8/M4nnk9Ouo0vm8nqjZMxX8yrdpdBxW1+VutcWwC/EcX/y0R85BPveOUewWcP
	6FMKjtCcyvwtD4fGS9pa4Xo4onrmGfEmsSteoS5RZHzTFhu6VF8fLqT+iwrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794456491; x=1794542891; bh=ZduaWWX7tt3CeVt2FgusmwQ7IB+F7ApNxKf
	JztuTnkU=; b=RDZVVfgjymHpgh5rlM5EnCtQSVmhev3mfHHtOr/ZzJ9iqtLlqN7
	JHCrApFSPFYll4krJND+wi2EnLFTA1i2esormGyXWJ8J6gZ5B7iTA6PQMdGA8CHZ
	nBqLgjiKAYCYtfThuCBZXxJruyGtim+gJCyiOmXWq/io5PgMkMydIdGRNr/EDBST
	nPESZpnarsedG3RrOKbk4+krRFBtTcAVBlQ73M40FOymaFtek0kBD6ftrB4esPdR
	rQDc4mE+kWg9BGFzIxwxVBDky3L8HEUyrv0HKmEU/F6CFqUYU6pM/QiAGN98hAFx
	VgYRrkBb0lksGLj6dC8Jvu0tWt7fR7r5XKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794456491; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dvpgHUbbSu9Djrb6LeHW+Vr+93CKE+gbqfBX3KBa59cskOq
	gkWen4TZD5eUjv2Y1/6CT402v1bmKpCMv3c7tgXr3Cf33S7qE26ZUSsrw87q5TIV
	NnXTSdlKB+pgbX2nrCDpKfiZDFmYGo3FUmsEV5PD5ETTO3+uIA4Hk5i4sk+pnZ7A
	657xbqFX5RuyIlBMUB51dJcI3MSjzVYONwA1qMD0pxzEpLpehqIRbf1d2rySxzJx
	0hMyMoqUxHwrghlbG0r/aw6IL1RAISmITR5gIuH+OyaK25XZQvu8rZ9P9NsDOT6L
	1vKvyQcdw65149PEhCMMZnEJNnBTbsaENS6R4xQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0Yt1625C4ZXvU1r07Yh8gqRwG9USvwbdtatkzgGHI4w=:YH73bUdWB6E3HYMQq/qg9M9cRG6XLs27czjfFwdalYY=;
X-ME-Sender: <xms:qzv1al83lw5uOywuuqlLiF_nRZfd8MiObBLJdxUjDdFWas7keaq_hg>
    <xme:qzv1atYuJ3dFX03vAdEByr_YeYr5d5PmGba5mHEFXbd5d5DYRzejbc1fQbvnl-YoH
    kZ3zG8Gaa5R1wMULUdHZ_QxUrFxLwh7Jy-vHHwZqc6GywFdX6Nc9k8>
X-ME-Received: <xmr:qzv1as2PzvmMJVhAeb0irNvGZksqUAQESf_79djFXYqVsL7Pa4B6GdGtowSn8najaTnBX01vXHDeJxZUGOW_bxC1S1nusKIIa1hs>
X-ME-Proxy-Cause: dmFkZTFc1RP9YOLE9SS0EUdUhegvGydddiS48j3RgTdgR8BZMzj7AQcxFkQfJ76ZbLJlAN
    oqoLzqhptEuiIkiwXJktHn3Z2iM7BFN1VE03TR3RgpbgnX/B82iggCTKpDvlCUv9neKkeu
    mRrldCq557bwzRPHK9yuJ4H4a7u6C8/uo4hCnxmJxQnek+7Wb39ffbceqFgABdjLSpYnw7
    7ge+PvVAgsXbFlkbm/+sqFy//4Alvv8elrEiNl5oc3PFbl0ILpkCY7eU/1ZVo0vymOF86q
    aUC7XWpH0QG0/g2Pb3Lp2VYRQpIq+r+uLj1sx0oDNzqhb9rc57xu+wV1rzb5xntNMdhskT
    vDybim1UnMxxDcHkYNWwqNC4Dx5FjLEf8zyXDbCmgcz0RT1V/+bdbbKqOhoSsxpjcJGkaJ
    k0VuFkWwY45gRyMCfJQsMyNmNTj2ftuJGCmyUhCub0O6IvKDEKqE2oiD6G2/U/dXxD924h
    2o3wPfRvG8Z9yn5o186KKhKK+9cyYRitZ4Cfejx7l5mOkvOfrQpQz6NTTtaHLtEdpx9QiE
    DqY4sIz+F3tHy9vwiA22CscFJXmxzzHgB+6GuqG8pbA7vDFeQurt7XyKUXJA1pO2zvjjYX
    kVrygkdc5dWFrHiWn6F0DTaPiIpZxl1j9SRlaTAN2FPgddDFsIzY73IeHhwA
X-ME-Proxy: <xmx:qzv1agbYDi3VWWEOfe-WvFX9A18iaXepjBWdbmgZFKhJYy9G9WgoUA>
    <xmx:qzv1asItZUXa7vnps9ajeAZViqIwEAUraX8olYp5puEJws5XjyUGRA>
    <xmx:qzv1anHmOG3JNp08GrtKPMXIryUx172Dmd5DhzcHRowu-LvTiav6WA>
    <xmx:qzv1arsaeBye8jE5gTo1yhx2kR-PP60dk1EZLXsOtIa-KojZpVGZxQ>
    <xmx:qzv1amjYRrBAOu3YpyUkH1Vg_aOYAKnui_P8GMQ_TuVR8FSZmjUgnHFu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 23:08:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <xmqqqzgrklkh.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	11 Nov 2026 15:14:22 -0800")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v5.git.1794432869488.gitgitgadget@gmail.com>
	<xmqqqzgrklkh.fsf@gitster.g>
Date: Wed, 11 Nov 2026 20:08:09 -0800
Message-ID: <xmqqmrrelmja.fsf@gitster.g>
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

>
>> diff --git a/advice.c b/advice.c
>> index 401d047391..8d2c1ff1ee 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>>  	"\n"
>>  	"  git switch -\n"
>>  	"\n"
>> +	"Run `git help detached-head` to learn more.\n"
>
> Shouldn't we be using a normal single quote instead of backtick?
>
> Existing references to command in this file has the command without
> quotes, on its own line "\tgit merge --no-ff\n", or uses a normal
> single quote as in "... use 'git add/rm <file>'".
>
> People's terminals do not grok markdown anyway ;-)

One more thing.

This change needs to update t/t2020-checkout-detach.sh because the
new output is not expected there (yet).

