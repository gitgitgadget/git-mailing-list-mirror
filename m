Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878176;
	b=jwbjY6RxJyeRYIGBHHl8hJ7hbRrHCf83OPg6OkmThZEF6AZbJtuHzPjQNB19/U34Urxs
	 1sTaU6dU6nCjINzgdF1CT/ZDIoK+L3O680i8mnaJGzScQWZZfxqWaHSD8nUvMA2tN2Hjj
	 eeDZoMXBTGLKZ2pd7/w6aH3QmEq4uyNu5vr2L2+SWtJ6FxfkIxpTP9F48F7Ke/dFz3qRi
	 8zuBtGHTVajwWT9xTZGTfDISITWU9eX6lrb+PvDiiWOZkk+F2rIax3PihTpD/nLbqbR53
	 mQLjyCxFDd56LCmyX4W6GlXufJE2GlejJB7HPvEmB49bHj2u34Yx2iGhq3hiKRKjpjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878176;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KGZgr4LFXjB8kfPpz6SAo8S1eXuwOU8t2LhiVlY1zcg=;
	b=1h3IVxvHhF3m1/dRvwc0XzhrwAwXKrWRoWZzOaHOEbde9v1mbSrEJvw2qAHBAFdq+y4x
	 ubdauLnbyAJ43J3dT92HpREIvnU9x0oOpEuaDkAnNqWLBPwR67kwOCSr+9UuCB793pVs6
	 DCIefeuCw9zP8NNdd/L8m2JYig9YH/21f5WTtVugAyV1rLnsMCd60//YR3RXaIyGgLsQf
	 lR24nkgZegnBETQ1qYzxITj8x1b0VvsMc8uzcjmdXpNEaJmLzfwxfUAs2JCLJzmeYB80z
	 Zls/WX5kjHHsjPUfnGETej5gabFK90fpzq2Q6Of6pqasqvMjiHSVT04UO6HDJgrg/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XnRTHOKp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vk6It5P4;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B0606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XnRTHOKp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vk6It5P4
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE8AF7A00A1
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:16:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 16 Nov 2026 20:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794878174; x=1794964574; bh=KGZgr4LFXj
	B8kfPpz6SAo8S1eXuwOU8t2LhiVlY1zcg=; b=XnRTHOKpU16aZHnYeiZioBS0oj
	t3qH3/rdLk6UqR7JaZxCPLZcuvIEHGfR4lBgKQYG1ZV5iHJIQvC6BEQSU7P1ZuL/
	AIuyolXWS6IIF53rlktKebGFLdu/dBZbE+MPzS6iscjLJVT2cc/fk9WtqzghIbHl
	zvkov2p8rgoFDTJhIWNlRiAj+hw5HOCgaZj9nbF3ik4pTbGdgPaTGnhSl6tiT/bG
	PNCr+sdN5PtIuEgLlO+J6sEDYj0hdYee2EPA3FnqM80xMFTov5uWSgblS76ep6GQ
	TPKsfF/nzdlKsfCrh3fgG7Airm7e7J9K6hR9NW16lP9Wo7d0iIvIjeyAe5Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794878174; x=1794964574; bh=KGZgr4LFXjB8kfPpz6SAo8S1eXuwOU8t2Lh
	iVlY1zcg=; b=vk6It5P4In5EC1dZWs0y256kRCqusZ5o/BhrJ4Y1VAzTpwszU9S
	aZPIdMm+5HxgdiTelzpQEL4rTmkQfFgohykGWjrq9NtYXH1PP9GD4k+MJ7dfbRa/
	IoXMKWcCE3iNd9SiDmQghRsWUhjMfm3RAT22lFusZt9iWtrvcAxGA6muMAqerGhl
	zdLFWlBcduNxGkNIzO+ks1BzZmKl07Z9xHIgplCW/MpqEAvRc+n76hvlE1U/558X
	M9UjL96wxT8tTMM5ga3V3VeKr+k7oSJWt88gb0cDzCCfhXuRRqsZjqWd9B2hhj6q
	hRzJz56RBfjg/Vy/U3OxJvdsJDtCDkU5pIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794878174; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xv5MMgWFSteNB8Rt61my/erXnc6Gnk41FSY9Rr+NTRJwhBt
	cxNjxZRAU2ZJunwCcopGIZb7SZ8pFYER8+qTz4zhCBzbGbJmcJwcetmvAzPqbKjr
	61RlaGs+levv4Q+B5b+F7joTR7W75VHRiaWiwW9ctID1RF7j61E+jxOXjmTTDrhS
	DNDWfUZHAn4Hz/PPugxIXFyVh79gITiJw4Lhec+c4LCZDmXd0Nn8WQY0Gp3zDwAz
	ytoSrUKbUX2H3h4y6p2KRksRJXqTMwsvA0uuKrDSKVsTqi6NIxEamgLGGmM7pquH
	eWvyCZV7ceKsoTteoJLrpkc/Wdzfc6RZ7GECAug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HXi8gY9bHOR3DtyyuAlSnUmc173KaZmhlaYZY1YkHyE=:rVRE7ndzivBEZVZQvmcfMlLOkRMfUWXW8YFoZdGU0pc=;
X-ME-Sender: <xms:3qr7auU1F4INwvNXtuNViSTaVTJc8cR5KZLwKCbEFOInDGPdSCniMw>
    <xme:3qr7aheXlp7juIsBGGkG23Cdopz0dqOffMNsS8FvFgUuNit7PeyTuyBIseTfMKB2K
    LxlBbFUasPmTm3S1c8X4JmEfpOTnll51v_H4Yhz18r9pl3CagyNqB8>
X-ME-Received: <xmr:3qr7aquRI7BgnD1WVFW7CPBlho8ETqGjaAohKAvzIvnMOqdn3d-ZUI2kraHKbz0KVKLfta4Q8WHjOJ6-sBOnWiOodQ5h0pEM_yk1>
X-ME-Proxy-Cause: dmFkZTEZKfpDVTQ08yj19ylOsgWKd9J2Af7z/eY6YyPQF3Kxw2fybO3PMaRDsfLh2GAfgc
    umd2GYNqkznxtRK8/ABysqJIo28toRz37DlkmrYnIdqNmL6My9aJFX+l9QYFMCQyKx6c2W
    NKj6MwkaLufQtQQGkUugPSO6N3EjSlBEzacAAxpmLQ63ODayqHzkktQGZod/fXTofb+lwd
    p/LeWJEBUjsekVT5BkqR4CYhyoGXHNeSXDNU1huUOE57Tnf9QG0zaqj60r7Tyl0rzNErfh
    9O0Q8+/TEvf43m/l8ufPRDuF0xaNyqSG0zy3weooiF6utIC2LI0aNm8VhZ15689ZNbOBJh
    EVREAw9zfynTP7C+EbEE6X5tGgsSglXplElvAxX9rwTa6dHpmybrBNfpCShZQLOHLhYcg6
    aV2N/187+eMRKBYZi7PZ76YLkahpMAJAbbXzzMbZVbOPNT103LChwBIomq6cCfbGnATz8c
    LzosmgBxDtzFTPulYPa465ziqZVjER6YkvVk29KHSQgAjfKglBQBWeGpFwr5WWQKZHzBJl
    3ySw6H8kWTqsRHRsXoyV1Qf6TfKaviOMIxXtYtDkzAVtT/41vYebQdthTXKLkXvMQ1n+Sb
    KUY/cRhmDH4ARgrCSu3YNzvdJ75B/L2hWZVSX/xAuooLZ9GBpU5c4SVPkJkw
X-ME-Proxy: <xmx:3qr7ag_SSQ0e2PnDeV_ZJGEY0EWdDuqOUnBTTGX82KXMAUEXecpFzQ>
    <xmx:3qr7al2nEdjVlSND_oS9mA847TI9kOXDi8Ees5vXYNZu2VMZ5USGsg>
    <xmx:3qr7alAqms-8mekWEcX0cmmB8qFt6oaXapP7dzGDs6JSon-xAvRdcw>
    <xmx:3qr7ahcsoZ4nRT16YXEgsIvP7Z3023ihu9Q3vtu3tQ4ljPbmCFE6hg>
    <xmx:3qr7agO9rr6DJEaNDCPi7DkpSWDYkh59yLyvg93lyWqmriWzSnt9MEip>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:16:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <xmqqik1wn5mu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	16 Nov 2026 07:43:53 -0800")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<xmqq7bifponx.fsf@gitster.g> <avq3YHb_J8Ww6Kq7@pks.im>
	<xmqqik1wn5mu.fsf@gitster.g>
Date: Mon, 16 Nov 2026 17:16:12 -0800
Message-ID: <xmqqbj7oi7fn.fsf@gitster.g>
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

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> $ rungit seen rerere --skip-locked gc
>>> error: unknown option `skip-locked'
>>> usage: git rerere [--[no-]rerere-autoupdate]
>>> 
>>>     --[no-]rerere-autoupdate
>>>                           register clean resolutions in index
>>> $ rungit seen rerere gc --skip-locked
>>
>> Yes, as documented in "builtin/rerere: use `OPT_SUBCOMMAND()`.
>>
>>   Unfortunately this means that we have a backwards-incompatible change
>>   because we no longer accept the "--[no-]rerere-autoupdate" flag for all
>>   subcommands. But this was arguably broken and misleading as we ignore
>>   this flag for any other subcommand aynway. So we cheat a bit and simply
>>   call it a bug that those flags were accepted in the first place.
>
> Ah, I missed that part.
>
>> But yes, the same is true for "--skip-locked". I was expecting more
>> review feedback on that specific part, and was a bit surprised to get
>> none.
>
> OK.  Let's break it and have the users fix their scripts.

Having said that

    $ rungit seen rerere unknown
    usage: too many arguments
    $ rungit master rerere unknown
    usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]

the above might be a regression that is more easily spotted by
folks.
