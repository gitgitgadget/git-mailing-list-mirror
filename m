Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522882;
	b=jHiMZ6SmXi/IoTavPl5hvfhSj9AsstYsU1V9QvGBWCBVjfTgJb+8Kv9E1x65rrXE+Ein
	 WyUXwt6UATFut6JudytB2TX+bXa4PKh/TQquuJ04uPuEN/LWz3OS6UOm0lrEjgh7MX9+7
	 PvzxGWhXYw/FNdJuDCYgu85uZ+kbqoVhrQ1eE9QMon9Hxac8StgoAW7JLRRk5v7gHZeT3
	 UXkSb7HAwFevCmDLMa9FNL0NJOkO8acd+59a/eQhJc95AdSnc1MxvdoZY0BkcMJjLiaDp
	 J1yb8Lqoeytuxj/xQ26KOldHTlRRo8Erhh4B9kuuVYMuhgc0vU+9m2qiu3HaLx8KtOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=poyEBlvkQAERUl42g5zE1CBqv1VcV1l9roXnQsZD6mI=;
	b=qhhI1wH5Rs40asWOQfs8Umh7Z7V25ZgmMuOwMuUMbxBrdFzDBaNFCdIRoFxmhNdg8UZw
	 J61Kvg1zBAzII2Z5tOWme549xvLNEFHFp5x707ABto6KL0mzYg2YETz5838KXeLapBqTp
	 HANc+991FCMwpmC51TQ/YjXbzNk/Rkjbm0RXH/YVQRt+fplY4gu0c/efPUNUlBXCYLnRP
	 qb8tIx2j0o9l1IKYZvDO+In7eSrYwuMkEMspLj2HJ8ThRjJOVTCPIg8uoTCij7qmthbXV
	 Gd9mISgYvNpau3QmKom1w8/tre0bQ6FZe8/wdckJ/8ki57rXkPpVUcwKYmy6Qh2p7Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dqiJpmeE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="d//Mtdbt";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06E606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB06E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dqiJpmeE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d//Mtdbt
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D8E141D0054A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 17:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794522880; x=1794609280; bh=poyEBlvkQA
	ERUl42g5zE1CBqv1VcV1l9roXnQsZD6mI=; b=dqiJpmeEXiAND/wJL9OAaMQ5nE
	oune5YEpIi9UcHhN70F8wT7H5YwJBDqwPbLR8B0x+qvYC3ChcyrrauLv9tzcFTbV
	VAvcIr1us9zHECPDnUol6HVZcRpoxCc7AQ0wq94iVAHIeodKJlOIM0tVg4fQ37hZ
	wK5n+IDEAEURJr9U1X24/6WsNUbXNlFcEmuuJSvR8IbWCoF3mH1+GqMTuwC08KwT
	5F5AOJfM46YXbrr8TCDTP6z7rMPqqEPyLtuyAvG1sZw2qhQulYzg2O5usGsvQpbf
	TS3FbE0Ws+IW0somsxRgezc6nirh4D/UQkD5x1phnoyL7PHDe5nnAd3BhsHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794522880; x=1794609280; bh=poyEBlvkQAERUl42g5zE1CBqv1VcV1l9roX
	nQsZD6mI=; b=d//MtdbtuJ9uChAu+ojbfFrkW+ymTnyPg5o4IPmM1mQ5BjN4IQT
	EeHJ4GAQz2plyoGS8Yuo++AK6B/ebKZ8JwaK3tfNOzg3jK9cVux3nS4WxEPa0H6K
	45Wi4hEFbsJlATLMAnvSqDmfYxpymRVyMZIHqiS6IpzcjAac0ntI0M+B8wXnfucw
	M/76SQ2I+Z3WbFEma54ELdwlAVATWU7Pht6LyJZ5Yev/8ya1e190+5Z5dRngKSBN
	91z4B7X6IIUFiv15bv76f6Ej1x+JtvHc0F8oWeofzWlyMRDhiW8klP+GDy6cE8Pm
	navwdxji5FB3Xt/NuVh+ww2VE6RlMAYYkKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794522880; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QX0VWP3hgaOSmt+X3MTVK1jzvuTryTFjfXoNr4q7bR15TBS
	wIpLww7ZZqXwcI8RQ4lpgUC04XJo2iDrP5ksbe8C9r7z2XcoV6GxXTJfTB+mXwQq
	7BqvKhjYr0KZiJcbgT7Mk6TYWiycvNfVtCywkpsDejV/+dhp0rt5Eu5+iecg4gkR
	LgqPjEkjjyTXl9XyNV9tH8HERpA+OQg5fCuhLF2pQ66sbP8OognKpJ4l6z1Rlwb4
	WL/t1fQI45R5yndTLpS+vgaqXBLU+/zxT3uB7q2zniHCxPAXYYh7dS40xuGYmOlR
	himw2s9alkCVNYJFDs9Xoy8d4exQNsgBEB9jKLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WMssn9x2fnFnehzfMMEUXCeWSAhwbou/WdhcvX6/HVs=:q7VuSZsOnlJMyEnDaLkvc0n6Hr5AyEHIC9MtZliG9fc=;
X-ME-Sender: <xms:AD_2aqOsedBUox7V0qdq5F3JU4uOlaLJBWsbHXwtGdEwdKNGqKU7Zw>
    <xme:AD_2av3ZWbDem06qhwfZBNCnYFjLx8umgn9-Lpd25tT9Kvq3PdbDEMeG0JwqtmLsn
    QO4_HRSvmum0bi8PReqKDZ1wWFY5PHeZ7PAezpWNoKf_C8r-gOKbw>
X-ME-Received: <xmr:AD_2apmxac4W-E7-xbYhOQYVpEn-rA_GYDutaWFos3Imldg6L57xF_g6bavn0B75A6x5KZKiNre4l7SWBsdkMN8XAcEU4g4IeJ0k>
X-ME-Proxy-Cause: dmFkZTEH5c+DFy22WaAS6K178nqtOqFJh+RyWSMPxIbGWDlTXezYZ+B3v+7s7AVZBgioyM
    /kSvQBjiCLE54fjM8L8xk0WBrstQwyRLt2TwH4/+SAhl9FJ6g6UK5n+vrNa+FYDEiHYWnu
    Zcn1aFNK77bVIwSKfkyqpPx5Jkb5JQxZi2WNxhPT8YMXBG2kHgCnInWwG6kFj0I/K3ZI91
    zHrc30sGAfAiSvM0WBhcO/5UE1M89vEBlruwRjHFx3jyVVj8Zxw0oPIjR0VIZmi7jKswEX
    DwYd90Vd1Cn7hEUDPw909t1CRkfnGhQiHozlzQ+ce02KS+CIH2rLBnhDX63FfcnHKoM7st
    1X5XPOO8VKcHLx1JNtRQrqlqpkl28L/KixoyCTa5HreTJc+nAQkrCEqyfJhWxA/UOIR9fr
    rQcjeEs0LriNb7hGkdoesIL3CPxIw911HZjPU0Ag7/UUcDZ13keU3qQeCMz+9lw5CRLelj
    IJH+FQ0q+IySArj7pheoSmOARsYdbe7UYK1rkYrspo9ru2YlfSEC5nOHQlYnMnMBxgoSsj
    XhjRANb2U8vXl2mP7/eHkBfP6wuzdrBGjO9/fxQpjAXAl+8I5kFsfPBUKmQTo/mlLIG1EO
    ELRg6uKAVtBFXHwH6CXJmZCXn81Hp8cIHfG8S3Gc7ljYyBSKZWyQ6CmUdecw
X-ME-Proxy: <xmx:AD_2amU-PcWGsSmylRpIR3quY9Kl19Kg5cwnTmZurcZ_Scf9NJeJfQ>
    <xmx:AD_2avsLVFHyg6SKLdS4plg1bVzFgXQC5AWfXNJizouqdxuNVWCzhA>
    <xmx:AD_2apb17NzpfQB42_E9WLZGqlpE058Ntb2-GHK21rM7f_IT7D3h6Q>
    <xmx:AD_2auWcCsZEGPvGIB6_NMZxpvG1oV3pHAjgWVn6B0zsXXF-2FoohQ>
    <xmx:AD_2aoSQS2FE2eVhsYo2DbU0LzK81ADW05kpoolqDtluGwXqG6Mt5Df3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 17:34:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Matt Cote
 <mcote@nvidia.com>
Subject: Re: [PATCH 1/3] connect: let write_command_and_capabilities() send
 a promisor-remote reply
In-Reply-To: <xmqq8q2xhexs.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	12 Nov 2026 14:18:07 -0800")
References: <20261112195858.53788-5-christian.couder@gmail.com>
	<20261112195858.53788-6-christian.couder@gmail.com>
	<xmqq8q2xhexs.fsf@gitster.g>
Date: Thu, 12 Nov 2026 14:34:38 -0800
Message-ID: <xmqq4idlhe69.fsf@gitster.g>
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

> Christian Couder <christian.couder@gmail.com> writes:
>
>>  void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
>> -				    const struct string_list *server_options)
>> +				    const struct string_list *server_options,
>> +				    const char *promisor_remote_reply)
>>  {
>>  	const char *hash_name;
>>  	int advertise_sid = 0;
>> @@ -754,6 +755,9 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
>>  		die(_("the server does not support algorithm '%s'"),
>>  		    the_hash_algo->name);
>>  	}
>> +	if (promisor_remote_reply)
>> +		packet_buf_write(req_buf, "promisor-remote=%s",
>> +				 promisor_remote_reply);
>>  	packet_buf_delim(req_buf);
>>  }
>
> This function was designed to have a fairly generic "here we send a
> command and then capability exchange based on the settings stored in
> the string list" interface for extensibility.  It is highly annoying
> that we are now adding a specific option here to be sent outside the
> framework.
>
> Isn't the misdesign being corrected that the "promisor-remote=..."
> string was not sent as part of these server options list of strings?
> Can we fix it without contaminating the API like this patch does, or
> is it too late?

By this I do not mean that promisor-remote=... has to be sent as one
of the server options (i.e., making the string sent to something
silly like "server-option=promisor-remote=...").  Rather, I am
wondering if the existing server_options string list should be made
into a more generalized form so that the string list can contain
elements whose keys other than "server-option" can also be
contained (like "promisor-remote").  IOW, the caller can decide to
put "promisor-remote=...promisor remote reply..." in the list,
instead of sending it as a totally separate parameter, whose
semantics is hardcoded (i.e. the fourth parameter to this function
will be sent as a value to "promistor-remote=...").


