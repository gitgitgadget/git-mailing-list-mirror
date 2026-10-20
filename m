Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459676;
	b=BXGyN/1lTrwFG8vqhEaaljdBA5WqNj2J7L9TUA6NulI8NXRUbasuW2aWRjWFNzm0Ttzz
	 A/B41Gz7iaEvRn2PljXZrmPGaltS5HWe11Cu6aFsQGoy8osv1u6rTY/XsQ3s1kOH/wuDR
	 PmgLgkjRtaLPg0fwICHRCiL7f+VpKHmjt2vZ4bIQ9okQN0qHIJZn8Wpr7DtP9x+FUHyzL
	 nBK92TIPuchLqHx5+Jl9x/EANr5uA6RtbSJquN5wxEyqcrtYUzV67/8gdRp+bD1ItKlhe
	 snwVT8jxmKzdd6avfqUwCn08ow/XYrEQdFaeRpprBRkidMZI4P40fuszWLfG07+gHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459676;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=H3XKeI9GGdYT1dcNeReR+GiEGb6KdMatQe7Hr+k2AMg=;
	b=tLOTO8ThhThjBmIRSqNy1uyAXaaVbfxdTMeVYYFcmN3UZvcha9aqVEIbPcV4SnvBuArE
	 288Ad3kFCBtpaeoykaqxdC1jXA7N81u+TU/rUUXPWWUZC1xTct4Pxgs4m0AdrnXZm+MyP
	 rovqj3e+1y02+K5z5kzmNHf4+PZ2ll0SPJG+Y7U2oZcWWCQUTuKyslNkqfjo/5Rb6Bses
	 M28zxTTTG6SHEymAMOyYIsip0CbVtuuzKOR6vZ89Pdrei+WPJgMKD/L8y4eVx9RxQmvts
	 cz0X0VAcK0HedUBDITaVEsx4MEAviwFvybQi5Xq7t3rYziRU0cGPtjD8l0ApZsg6z/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fr01gN5r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="BanJYH/T";
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB7606A324
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0AB7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fr01gN5r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BanJYH/T
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F11EDEC0074
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:27:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 21:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792459674; x=1792546074; bh=H3XKeI9GGd
	YT1dcNeReR+GiEGb6KdMatQe7Hr+k2AMg=; b=fr01gN5rH5zml4dvksb5qZshbw
	KSbl4MyHsY2bIVPiyFGYp8zqVNPRGqZg3PfFA+XRzJ2Bz8DQnNiqXRLHTHw3rJK5
	JyVJRyk1f3MCia/Vo/yt8EpgSvj/aNcRYL1wiUd/UieY5JTI2XRyFFkDhvYzvCgK
	OkWw1NZ42sKElMVo+eQ8A3rkbB7gJSIz3T/71sMmfoG2LLVFJNvE5l/kSU439i/u
	kaOSuoJtkv4eBTpsFYh45L9YIU4O+2oyeX2PhHTt07+iQ2eOCMZ+KdgpWUWuYGkF
	4puaUy8+fAVR2kKH1TFg0SCYMxdbGBVjKY6WCG3rbR9vqcDK0wcGntcqKCow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792459674; x=1792546074; bh=H3XKeI9GGdYT1dcNeReR+GiEGb6KdMatQe7
	Hr+k2AMg=; b=BanJYH/TLG8jLem0pgTue1wwD3HBE6DvoiyOo7JlP7poIIRDHgb
	uD855Og5K4BArA966uKcuV2Jrc4zloyhXqxdasBU9XOv2+LiBmvf8NXvopd16znC
	eHrQoxUSs/Ytt0kvXlVEud1IctDUL49j5RxZIzxUffnEIzz4D9W24Q+SDroyrQ1g
	iGeFp9ccXJud3FzD64DW8e2i8d2cBOCKlNRhAQZfixnCE+8dptv7t85rYHaD9qvW
	CTH6E0TOL62uhUsEhsFsaEQsuiFntN6bLNa/F+K1JbmNjV0FgL7k9ECGuxteMxb5
	4jdIpD15Vf7ja5w8lYGEQIBhPnXxKhYTnGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792459674; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dTcTwswQHasjveSQcEslVwp7vT+6Gsh7v9tBk8Rg7xNeBCl
	9vwpLRmbs2mfx8ZKuRMnLy9/hmRWs2s4BDJD9gUZaVIdYmmjcIG/NzrImy46voLd
	+fFNp4ukCSD2M7DnIHM+OKYa+9ZtyuGDlenxNW5RjWjJohbImTpSq27Jel4boYyR
	56MfexscyoYKxShLa/N++HdV/53Gf6R4y+GjHuMK2TySKIitSeeTLrqlGAHMtsG1
	2geZ91VFGt2USHr+UWts4TYerocFGxR/6xszEqDTZ95Gg0lraKmRS0h6mQULh1LR
	yJ+IeFZ/B8+RW5skflAtbMecclHG6v+Ki/k4lmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ScqRIXsmV/8dgZRsEa+qq8TcLBHqPmvQ4vijBt1xA7I=:EiAtO7DnW5mqtP3Yaol5fouCO8l57fxdvWwSgHHPKDo=;
X-ME-Sender: <xms:msPWaoJC1Eu9VrkCUGop4SQ4-kNlW35qJjDdqdqGCzkNap25hFYcZA>
    <xme:msPWavLdJ2w9EO8wqwuRv7KJ_qaESDV6fRilYsBLZq_Vk9tKZ0vtz4PURqZdP1umO
    vJPDDNbpXTrMQkqfrSIHNsjQMmHfMBsIoqgee6bBAY72f_Wtmdt4Kw>
X-ME-Received: <xmr:msPWatv5YsPsCPqIEiD8tr-jd3m7StJCOX3DBDPhpPrXq4wpf7em2qCfFnk0HiB9vDfsd9c7dPmDBKBhsUJpVpkSMxLIY3xcociV>
X-ME-Proxy-Cause: dmFkZTFlM3hv+8HyDW5Mi2d+3kRJWN7xK4raiP5IF5bDq2CZHW27Bj23SC6Xnu+6xbKx9O
    O0cHmUgJnOhDNfOVe8loXqx+mTrwhImcL404bYonYhwIJe2WVucrHVs/piFAN/1KdW4qyV
    kJ36zzYl0ibdSgrrr/7iOBYxRgxqrfLtcI2EsY3POS6KoPqVghUroi/20DlFIj1GQ/D7o0
    IsqbB6oC7Ibo8tQUbbnXk3uqZh/Omrm8nnqWZzoP+1VtojkMXbj40zUQ4KxkU0kPvm50Vu
    wG1N2RzA6uqVfocJFK8oKLw2XDEMO03fDixhquoz5EPlBmuJUviZE2OXXocQozJRVVizdz
    nla4nkeDnfqHHYX9zfIw4ysEruNdo7MVvDK+hKYPtIsrPEJEznBsPN2R7nhDW8+3ur/hq9
    itQ0isER4qZU52xlnEFqsGABIIcV8OHvoWJmBUQQMgFtYN12hxGDrEWY6uEUjNIY3cl7hz
    BJ+QHHx2dSLYiTm9VAN3zTPIDkWqOxs6xiRQPk5GAQoxs2JkRn3UVvxI9QTRyJbWokNjgD
    v9fiTLEKZtX+5rfV/xvoLJYPsa3OsmXxxv+GTY6OebY2flG8Isffo+3G/FDl5omVG/DbeP
    ugj/qCzn/CMgVcvtoIkIEdvaurHBey2gmW/ajT7dAOixBXGhtXphs6noRC8Q
X-ME-Proxy: <xmx:msPWakQyozbtHtX-I6xuRSg5MqtqB8iJAXyCDVn-pB5QFpeEGdPv9g>
    <xmx:msPWarO0lt56lIXWqsPukrHuNQNW9CJJ2A_59i48LxP5z_tDSJr-DQ>
    <xmx:msPWahYQHkqbckYG85Ov3-rr84f42s9JCi6w0gH5DX_ifm-2QQQhZw>
    <xmx:msPWatywcwGIdkL7sX1J8DceEDOYpmatQhz-2KIzZZveuCO8ibTZjQ>
    <xmx:msPWatPfEyHaxW7dzH5OVsLCzdF10w_Hc-YQPHgHlgl9dfDFIYe04Crw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 21:27:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/7] setup: introduce object storage extension
In-Reply-To: <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 19 Oct 2026 14:29:20 -0700")
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
	<20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im>
	<CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
Date: Mon, 19 Oct 2026 18:27:53 -0700
Message-ID: <xmqqh5ihyxd2.fsf@gitster.g>
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

Karthik Nayak <karthik.188@gmail.com> writes:

>> diff --git a/odb/source.c b/odb/source.c
>> index b25ef14df8..10abe33a26 100644
>> --- a/odb/source.c
>> +++ b/odb/source.c
>> @@ -1,4 +1,5 @@
>>  #include "git-compat-util.h"
>> +#include "gettext.h"
>>  #include "object-file.h"
>>  #include "odb/source-files.h"
>>  #include "odb/source.h"
>
> Do we need this import? This commit seems to compile without it.

It is better to be explicit, rather than relying on an indirect
inclusion from an unrelated header.  Since odb/source.c is more
or less a library-like part of the system, however, the presence
of translatable messages meant for human users is a bit of a
curiosity.
