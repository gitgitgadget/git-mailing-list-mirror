Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262293;
	b=LtwxhrbNIIqEXLsD6uRdEuGgarUs4qMIE3uMLRokN/h4ptpq2ap2o8XtWjdH6CTgZKen
	 W78xZgoZ/PGVnPoNvf7EmXCy6SQlKQ8Xh5IqjZlzTh50/qQv5G/Yxg5VALWeJ1xYvy/rC
	 oMFt2RaWJ0gE9nZCRdwnEI4hvmfol3m2fj91Q5gkIXAYir5xLOEyFeUKGbw1rPhnub9Dk
	 +wXGvijqkLF4v7iYQ5GTp5FX3vUnuigJ6DcODWsoWbpAtxH6qLCb+FcclziH+mgmdFJ7x
	 SEWhf1rNyPZomYFq9n27BMU0ShbeTUsTW5+rDNWYmIK2mNskcN167edPoL/t26u5Q5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262293;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bedrW7nSbW/XmU7HYc8LvpcrlJ02Ch266BgOyNWtEmM=;
	b=lJQ1Si3YLhY0ynRyk9nmnUDW3MhzBqwi1AsjBFNQ5n4UIojU0BGrG3ZgU6jvKOEM6cxY
	 Nafy6vPKu+I/h/Cuz3SsfO/3cUSbo9dWVOpctrm3Py3hAZKERNaGWHEoti4JrCFStIkbO
	 TMVf+DsFHANX7abSJFPyAu2CrXgLB5K7+D1pGuOoMLz97W2M7MFU79pstVAfgAHx039PZ
	 GXfQXU9n4WzW9lc62t4EvRT7R/0VGWZPHfRbJ3p132wFhSWxmLKXEc0rgwPa3xeeSJEb+
	 /hg2s9Cz0xorkhxreg64wMY61drMJ0B3jyPh9ea5mdqUiDutXCvtrcpktkkwfv/5nAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bSMcidjQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="o0tLJW/F";
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D04606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bSMcidjQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o0tLJW/F
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29F4014001C8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:11:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 17:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794262292; x=1794348692; bh=bedrW7nSbW
	/XmU7HYc8LvpcrlJ02Ch266BgOyNWtEmM=; b=bSMcidjQkYS7t4xT8y4FchabKY
	LLJ8fYG78Cwhj8TtA/Kdz2EjdNphHR+lZt/xJOGaDMZJMXefVyygpZXYCXKX4k65
	92ZG4nur3h9/SkuufXFj0vCKD4Z/IdU3GyK+EvVwczoEriEoARrmUpykMoE56ohm
	qoD9b+20WNRUNoYmeTBChD6ld8zekG7PvhPTQq2LQjFvAn/7myY0XcSta2YBRqCc
	HPl7TnX7gDINv4KvsWkinNZhQSdFjPZ6EE/vQ0ja17sqhua0bo+6DFqiqwwZA+lh
	xhsWnJbIDLGVvakgX0tTF8k/Wwv/aKHYlE0ah6/mkgL6rP8prriOp4fbG8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794262292; x=1794348692; bh=bedrW7nSbW/XmU7HYc8LvpcrlJ02Ch266Bg
	OyNWtEmM=; b=o0tLJW/FXH6xbniev3Z1BgQMv7sE8fHjjPssWO16v9T6SaHFZBu
	pLnLPISLo2x2MNc6HUHUDZ9QqToS5WgSd20de7Hv2niIjw39qAtGfpAJ3v3AtoF+
	T5h+il3h0eLG+o6QzbXammhusC0aAct0SLSZ/6XSxQXrNbC0RJ4vaKtrLhVwztjV
	9z+Ysjuj743LAvnkuHUklTcWhymfi3qtwpT+CrOTX77s3nc7AJ9jNODcdmrgZaWL
	Z9drN6+nn/1rQhvLWXGqrKsGdj5g3DE2ls0gKlZZsxPd65JgQMbC7hxq57CZKNQV
	gCf+L4bBwM03brdLEe5Qt8uaZ8NG0tRrbzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794262292; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eXWyUUY7IVYCQGnqrt67ZEMdVzBo+7TkrROa6Q2FRLol10e
	hOZJ7Z/rfpn2rE6LssrVoLbGsnJN2UysuCmL0YsMq4DexP/kv9aVuGIHhrFtJRdV
	5iE3NtKM9F03DlQtLOsBnvLdX2o9r5fyjLXoRUXQ5LVLGse+tb3H4DNW76qoxkGO
	o1X+oaI5Ip1GBl/0h9u2d/0VEOak8wV3y6tpOVLWrlSlPqr9ekHXO9DyZ4wATFn2
	bmln4ynNTptIMGN6MxFXweMIweml2/NgQ2Qw4OCfPL4syaTIChB9wdKFB4axW531
	u72OoIzXG/ozzU50OVO/e0WJaiz+1QOyiimmNgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4vKZtiriC7N/FYT7UxdX2EQlF7qM+WawBcD46msXtxY=:mkqQ/1gL5bNPgFp/yuJFvQUW9Hjt5T/mkaFlzWxGs84=;
X-ME-Sender: <xms:E0XyaniIeuqJD29Re8YB_QNb2zjra7tRy7Me4XIUkIUay_ITJSjXMw>
    <xme:E0Xyanss2cKwhxLl42qebqXREtSaOpgwl5F6yQjL7zh79nT_APmiA7kMCgg6rZutB
    7k3MFRmR1CHP05vQB3u7gD4iov-Chxli6wFOC4n9ka4t5ky02Xfx-4>
X-ME-Received: <xmr:E0Xyag7NlQg9HbGUA6V5b_WklNKIcUSNxqc7pBKChHUMjhuGbhTjb6hvoAT8E98r_G65JOW2yd8fjnNffYF7G_qxg1p3wxbHJKJW>
X-ME-Proxy-Cause: dmFkZTFBl4lWAzYIIok/pYrBuhWKbo+2WZkG/Ajm6RqnPM7bkYysIDQ6pjQs/qc1uxMNCA
    0y7osPkph6m92+3emPAY2Yu4Bv0odVNVGx3rYmFubx0VIktimQpeq8N/rMWKhmj6kqp+nA
    q84EhT3rL5pf7RU53dAwTacGO7Ycc3pXH0YqcH6EEKqhDc+TU+1cwnDP27ThkV2+hMYGsg
    ffMXzjMBeagbr3hfGxRTy9KNqAquyz+tQU7O2e+DQY8awBb8mBRT9p3RB2PUVJl1hDts3j
    rJDk8jBEgGeLVL3Fyacfa6zXdVqTBjshuXwmnlT3jQQPhz9HNQ9ePyVBx0Hv3Idb4JsXKB
    lgfMLfhMKpREG5SAGnt1zgwU2iHs690BRPoF+bIWMwQj1Aw+WdiIGKQ3at5fT97e5KEIYJ
    QLG/IjrDPnVso+W4rcab5qQEq0pefEKA0HrmkwDyF4bYStgghtC6vW57oqUGdgvW9XNXqD
    vOk+0OZDNHrIrw/0JOCDVJOGah+WEgCpcHpNs3C6MfsutFGnrD5drfEMDAxOnFfajINhDV
    H+z6/ZPbUXxflf5gqPX3WBADz0+7ZIallVS5IcTdU+TD9VjLF0RSM+Rrn6Fat5P/StS+/N
    +tCCxI/zVpBk0e5j3wCevwyFjEKAu0FLSW0bwWYm1UvCt4XbR73x8BCh4z6g
X-ME-Proxy: <xmx:E0XyarNS2E56p-jEUbIGwrZinLVjhgleriS41_QIzsncis1aFX380A>
    <xmx:E0XyamvX4clNwhpB-zM018YMp-1sifunMKc3rVTXD7nhd93FIfnKcg>
    <xmx:E0Xyamb5hswigG-YcrsBy5mtzraYFrh1DBOU4Jy4HbzgdzPlDVk-1g>
    <xmx:E0XyagxLmsU4QPCWURf11aj0aOe_ef1Uyuj_-QqpNgj88019KVzl8g>
    <xmx:FEXyahRpzQmPgY4JgxBxHAblnhenvDAZJtWwkG7CgQaZIEdAhv6w-9uw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 17:11:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
In-Reply-To: <4696f458-62b5-4d18-a74c-aa692708f7d0@app.fastmail.com> (Julia
	Evans's message of "Mon, 09 Nov 2026 17:01:01 -0500")
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
	<xmqqo6bxwtxa.fsf@gitster.g>
	<4696f458-62b5-4d18-a74c-aa692708f7d0@app.fastmail.com>
Date: Mon, 09 Nov 2026 14:11:30 -0800
Message-ID: <xmqqecctwt7x.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

>> I wonder what incentives, carrots and sticks we have on those who
>> have in-flight topics that are so close to the finish line to
>> concentrate on completing these topics before sending new ones.
>>
>> Ideas?
>
> For sure, I can avoid submitting new topics in the future until the
> current ones are finished. I don't have any other changes in progress
> in any case. 
>
> I'm very conscious that reviewer bandwidth is limited and I'm very
> interested in ideas for how to make the docs review process easier.

My interest in making review process better is not limited to
documentation patches, though.

Thanks.
