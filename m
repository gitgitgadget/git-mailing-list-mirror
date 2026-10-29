Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297865;
	b=OgZyvEdkpleMFzReu5AOH3Gy2VWguNvnFx6ElhrvqxOFhGsouZpwiwSc8v8TVig3cgpR
	 /L/gmzr9STMHlcKGhg+nGIa6TsuAaC7u8pDTm7cV4GFsoOqS38deEA3SGi7qnMQ6K6NKD
	 iZ3YURCpr6edCe7RFmcDo/WPhytVnQhpbf4MvWIx2y8nQnM0U3UKcUGY0d4jG33KdQJGA
	 Lk38RGbehhKhVbW/ozupcyjZThsIaqxN1A8eCesE+ZUp3XDYit6ehnkK9wx9w5t8nNFEB
	 krcOX7k128XBUCSlLj97BIEaQs7xc9Uiz72aMoiUrJ1pWBWpOR1UfbxscKP754BMMkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297865;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rlVLb4o8Et74Rq2TyTVnjga6vHaPIM3GKOoH/O4t7lY=;
	b=4Kl8jy6PKTbDUlFZnotAgnJ3NY2V2jKCsNigp5qEh/fF+q3OWfHjVCt8oSjGIM8Wtjix
	 ISDOSE5YsZ8YS9NvxI5E0FZvOgxUGjF07mWpXkpU9LQJfLrAT3lS22d1fASbGxJQT26iQ
	 qiZEN/47tc51Fw8X8KL+LePwkNaIaU4o8S3L+XJKvDjtxCbQmwNIqyp0yTb6UD5yZG9Ax
	 dYUfEH3zYHzHLmXaFmTW1zpCPzL/4aBxart09XiDNvJlFpGrru5W4nT7acZQTIW57VxwG
	 52IoWlPeycmDIxzaoVvYG/EhCxV9aeIqC9X28YFIIg6BWGWQ6mXASgDwonUEha/5eug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kQ2hKtOb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lvbRMFiR;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACF606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7ACF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kQ2hKtOb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lvbRMFiR
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A8817A00AE
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:17:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 14:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793297863; x=1793384263; bh=rlVLb4o8Et
	74Rq2TyTVnjga6vHaPIM3GKOoH/O4t7lY=; b=kQ2hKtObk0di00ISXif7rJVm+v
	RE5KurTBtKdM77MKax9Z2bSDH0NAu3w1QpMEfNO19AP0t3LjXxOK8XxAr9GsaGqZ
	SKKIpSIlqYb0zNuW0Xkqzi9XaY3SGAJw5a+5c3uX/K6DuGjx2fw3Iu7zu8sY5jjK
	6JmuIPifwRZajuluDwYAFDY6wncsuEOx3OeE3zPhdsPNWpE2QMeCM1AqClqy64Ko
	4dzRTDWAChPv+4OTYDSymMijjtZ8J82CGoR+ZfuIEU/Uu9aJ6D5/+J1cO1h1l2bK
	QM765h4fCYpZuVyhQeA6c0WEy+BuD5pxhrZ1DuND/Ujzqs15zTaqJQf27y6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793297863; x=1793384263; bh=rlVLb4o8Et74Rq2TyTVnjga6vHaPIM3GKOo
	H/O4t7lY=; b=lvbRMFiRKrNJEeJaKKIzG/6g0SthM0w9QociTcfsM8Ixw7LY2nm
	OZBGDeX5HEfLxGVg41bnI50YmYS4p4xqehGCrtS4gqmUPOsHdj9nc6soZiw2hhkE
	YTJc3k7gh4q7J+WjpiC9i0ldsBhpBxMkM3tmXS1WtWpvYh+YM59sZIpMYBzM5kKk
	pLrs/pJ3TGu53+gfYDpdLv8lVwH//gx7/Pq0/GLZLVmOxrlEJmH582zyqAQ3ARIS
	TYuTERTN21Q0eawYuBd8WYGaYLVwhz1kozdWWcPskj1l0BB1vOLrYRal73tovMqf
	dQ4nfdO0G2+ZpMfHxPcpZRJUYszD9mDJDOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793297863; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GHWUTpPAQMLmH1fRL3NdH692Il6NPgD1j1drTlA+bRHvHi/
	m1SAhlOvkid+AGhfzMcx55XJIYh/dij7JvjK481CHGFToEqKfBdF9r9904sWFEA6
	chG5fWKrBg7H8ZaDdHsm3SHPp0/u3QXFVdmRbY7n4UmHmU/e4Vm/8WiBYrW2Gd2M
	Knq9sHZD7GcJ+o9qHZkEmwOfqlmXIUxOBFghfyh7+x4WSiB32i5uHZP7qvqBNEua
	xGu8beQfINbDgDibQEOtVljoAcFL5wUL8FVxzJT7x7MfVDLpMcHAeNbR1049RgHR
	5PoOps7Rzg36feX/hU5SJr8KZjxzgxwF6FwH+Xg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ua4BuvBCI5SNiubHqrN2CvKtYvNrFF1gNTwXsayozYA=:hvpX5W9xveCbV1vcw23H/q0VKY0Wl1nKEJJEjWiCXSA=;
X-ME-Sender: <xms:x43jamXx4DJ-M9hWM41Gv7gQ6QOsMthkKDPrbCLjoAeixOLb8RGWxA>
    <xme:x43jaqB9lZOCgSAtP4pmrgIDoL3sggXq2TGDodLGhuiuyegSqWh_nsVnCRcAsPpTg
    _DFeXsd1dcwfPFSxOYfQ8gWektF3J6zPcUfLY2ltV0nsRScg_aeCTs>
X-ME-Received: <xmr:x43janxFguk4gcIBsYMD_ZXt_H4jJn0l1sTjqDXJa3HlURVAszcBX0DZdCQJEy70DobaM2Iy8myFBpSyV56y_7BIr308-5T8up40>
X-ME-Proxy-Cause: dmFkZTE7myKVU21TptsC2YDHKBGSLHjm7NOnw8iekv0go3e5rlflXk5QCzhLpdW8vOYjDi
    z/HduGQbmJNpabo1hRjqSBmW6DgO6iHA7RRkMEZKlbmDQavHgv7cFGnC6S9ysomK/PVE9D
    iQG+Nxb6sfq4Hj6d+bBXAZ5F5PsCoiQvq3oNSqQOmffDd93v6sslYhXo965UUNuf6whyve
    DsfE8BvOuCS06c4kl11E+NE915BAL1fPR6yKZ1l353wGwHxKSkSKcbpBn+VRkavtt0+Wx9
    DAmibCOa7WCjE6uY5hl/xjzo6a6uB4Jl9yQaTLmyCSF0YxSS3NkL6U8Sm01ni9amz8n7VJ
    ndFvzg+swi9iVQYTZqZqxMTX/EbMyt37Ziuw574T4sz7cbUKb9aHiRsmCItIDxfbOK+BCR
    ZfA5h+WWlf1NxzU9KkSO3mqGUxe5c7WAh/y7lyVg6azUNzhvS5rySM2CqNpHU83ej8zO9E
    eOpP397iEXwy9ReTJl4qpoX4CbZXupxVXVqZ1/4e6BBRr4WRvl7U2HIweFR0y65uDa/o/G
    ZHTswJbqrZwDNdYspEbFALQowLpiekbQ1efoM52yDa/vf5ZZL5C5YA5UxI8QwtOi37U3zI
    feX2E5ZPQ5cAKTJdRhi9tah0Tlb9uIfsOdDX6NRg7Kws0MCZunAZE0fYxQoA
X-ME-Proxy: <xmx:x43janCB__WaNaxAPrGV-gNUsrOz2qSlzSBN-dzP4LNPefu5cbpF5w>
    <xmx:x43jakY4tiktpQfzQeJpg9cg5itkPGR-tfa6kC4oIKvzc09pLvqO8Q>
    <xmx:x43javhaPhiXtWMQdXwDAQVpGkMwuu9jbeQVYrQ_0x0rTswhVHQp4A>
    <xmx:x43jam6VurIPossj6BI52aK0omviHnBRm1A0B6kfur1OCAF_ZcOmDg>
    <xmx:x43jauBvzGamN2miHBEDPA2ods1_Sna-XzlZqIFkRca47CvryWzEzYf7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:17:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #10)
In-Reply-To: <CAOLa=ZSKqRU0okvmvazTieLFKJKZPAxF=1fsVFa7mQhkAz4iLA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 29 Oct 2026 05:46:45 -0700")
References: <xmqqo6cd5hnt.fsf@gitster.g>
	<CAOLa=ZSKqRU0okvmvazTieLFKJKZPAxF=1fsVFa7mQhkAz4iLA@mail.gmail.com>
Date: Thu, 29 Oct 2026 11:17:42 -0700
Message-ID: <xmqqfqxo2wxl.fsf@gitster.g>
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

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * kn/fetch-tag-backfill-batch-fix (2026-10-28) 3 commits
>>  - t5510: cover upstream info update on fetch failure
>>  - fetch: advertise fetched refs when backfilling tags
>>  - transport: add `transport_options_release()`
>>
>>  The tag backfilling negotiation in 'git fetch' has been updated to
>>  explicitly include the in-flight fetched tips as 'haves', preventing
>>  the server from resending objects when batched reference updates are
>>  used.
>>
>>  Will merge to 'next'?
>>  cf. <auHfmzP3aXyonp3C@pks.im>
>>  source: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
>>
>
> I've sent in a v6 with minute fixes, that version should be good to
> merge to 'next'. Thanks

Replaced.  Thanks.
