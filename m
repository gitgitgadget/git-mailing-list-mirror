Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660326;
	b=A21Z7Mfn7YmUS3bj8Bzv14Z+EqxiQppDlAfZgac3G9EhXYv1M/kB/0TP+h2B7/O2IRdt
	 Xc0ZpXjX1g2eBYKVVd+8QPFmzqXVYcq975IeVAToc+PJCPhWyIqEVOOqxzbeSGtoLtJK3
	 BQbHZWyOdiUjp5rV2aQ4895E21dVCG256zmKAQ+CWHgjjm9zv2S3K7uWCDh3H0Ixat/mj
	 QuhmeNCs3LtUrF2X9sv/hR5H+1xQZDoroKx2FSo7TslZrGki7aHCyRqZ6LFVENYW9c+lD
	 tkIZAwAUY3+2IdcdmPSkcr5IQrw5KQVqIdwZUWRyH9ePQxkigEzWHVic+npyIpY4XNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660326;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XlXxkenldlsEPh+QRUUjgc33n4MTNe4PCqq9WK1EXJQ=;
	b=5XrdQjr9AR+HlnuHSdPHRv8Svo+9IGPGvB4zvCRAR6IsDm4x/kCJCKHbuTeCKfe59xmt
	 /83+K9qa5uDIaKlLJwyuqOlLSmw+EIEHdII1C8zz/x+LkJkSpD+nM9maZWsr3qpuWrpdN
	 07PFMxoi40MuKoHVk/ydZ8/ir9lme/Lm5X5JPyMJMSMGARAb3BRzM+X87pGLQMO0/+IMW
	 D1he7Sf0zp48FziXP2ZgIYUFtPY6QI7+s3A5hYmxQeYlxeeZNfUHdPIZneo8ONcBQWVPq
	 j2V8uLwDEWVc7FEn+fRw1W2D+EqPR8shVO1P7u0AXolk7caFcX5/OUh/LI/oWdq/V5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aRcWI1My;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0WyQyS1v;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A7606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 12:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aRcWI1My;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0WyQyS1v
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B7B1140007E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:45:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 14 Nov 2026 07:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794660324; x=1794746724; bh=XlXxkenldl
	sEPh+QRUUjgc33n4MTNe4PCqq9WK1EXJQ=; b=aRcWI1MyS6ifSlF0nFJAneCguJ
	9qmDp7udu3m5zUWqJOA+qO6AHuv0e7SIqmXrhNX//4Wy0RCu/LzQm2Wnamtq6KvG
	EgQfPf02PyZWX/rdb/uhgfDNTKpxCS9ifMGfOLiM1fWb02s7MtY25zKm9gj+mIzX
	OYWSZjkWKnF0tOSEfkqRGaZlp5IcuhclwfrsVv8TVeN4yRMhPeNd/yI1hPn1gqiX
	iGVbkC38wQhPgyBPbquFWR2YBIGMa+A9obooT3JiF/xyc6z6RNrT1Fz+uGau2tQ4
	+qatw3zbW2dk3nJsF12BF2QElbc7LlIexnNwrn0I1by27QrW3JKiv/TPRXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794660324; x=1794746724; bh=XlXxkenldlsEPh+QRUUjgc33n4MTNe4PCqq
	9WK1EXJQ=; b=0WyQyS1vtDTD9bBx5bRsjaseLJsd5VsPLO+yNsNbIPHM91rfHLZ
	t5u5bcjjgPDqYuFSoLRsnTJNbAaH1zbPfgME0U7EmU9Xo0AX2GKEiWgmNzLoRL+F
	fQPEx3kq4V2xrp5865m6NCmz1tIbqk/QYAOwGOHOOms7QKpenUVCtV1Znc/AZzXx
	jynDXs2rO0VTFUnZySnm2cZBDgEueP+zBTGuKkiR6ZR3ojk17XYCrbXy3wEqcblC
	i4jBYM7f/wRrXFg4xr6KytgcE4OLMjVR1aaFQChoOUj1R8QILLGtPazSheI+MipX
	JhkT5UiFSMt4jX9IWtDcjD+OisN9XGn4/jA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794660324; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ju0tOiVO8MeGKuFGOruCx8hDPJUE96+yKoYiTqhcnapO5vX
	qdX45Ze+XqDB5rqZuYAMv9KXN4YdOXpCfkfYxPY9VUXGECy8QDUfjJGe91nWTygF
	0AoD8sJrL8XHzIUUbd+iXxN0spR2dB3tdhusjrbx62Z0kXzw9uJCF7uYnRke+3Pf
	XpT+AbT1aVmKTy0KOqoewfHAJdTu3R6I+bSgVQLsG264XBquyeVUHE7m8eyVJqCn
	BFS/+NoTUigCbe1ymP9InFvKUAIOOAQwWwd+xPFIdgcvwlLYenCG7Qf4LOss+sRy
	sjn7MmMvLhcU+4pCGUz6ByrQoKF0Msv+DJqh4vg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Syb8TDS42Bwn9yjU2Vs+XAc8jmWU7YZAWj3qJRzVkbg=:MO0+LmrNJXbC2xF/58ySKZKWult1NFPucDNrIVngnQw=;
X-ME-Sender: <xms:5Ff4au5PkRguNfW7R_bzU1Cph8bwBvYZi3oPGuLqlAlpGEjZpytUPg>
    <xme:5Ff4auzCQzLG90cQ3yCikzUX2uCku8j9zz8HEKBOutyyg3SJXGR1sEM3AznTj1z76
    XrzPJ65he4dT8kBZs5exGSNa7Ofuk5otZ6b7k92oJQIqi5A9HlNNg>
X-ME-Received: <xmr:5Ff4alyZnETRCMiwLeCtmGTbe-lfoP3wavBqpToDVVg8ricj_9z5aZAe0DKnag2sLMISIeGI6R3BHmSceEfzvWtywmq9l9uRT8OG>
X-ME-Proxy-Cause: dmFkZTEER7nSnIoqdqeAJ/hcepPU1On5a+YcFuEv0vG3RpXlw9WYFjPjOgV6hqxVxFqSer
    rw6nQi7aG4o1cUfoRA0s0rWyLWcixPBzfj/6GG2AORhkckOml0/l+xH1BRH3TgTbBELE5w
    +qzCuzfJ6fDVyMmi+axerTIxeNqfsbD28WsOOgEHjxFuF/HfkeYuQIcOKz1IxEeJqhCHtd
    Dd/n7FJbwnWcbxRChomVKaWtaguA2/pqXLfZE9cnWedlnwkhz7QsB65lNJSdXKg8wnmvaz
    BwFtsHtPpqm0JDzzE6kNevAFJe7kpXjYamTsPbsnxN8mKNOWhZnHuhMuPZMIxgBlQPMUbE
    H3SVW04yiCXQVWd7mq/yvQ/LSmisecBXZxoVewBBsw6jxFSz8PRfax7ycFdzuN0K+7irZQ
    6uUw5fcfiZGzDH6xB4aA0j/JE9vCjvkwzCvvgj33lx6c2Aj8o/ucDtCqPGq5kwSWJmErzd
    zFoRTl8jR+fqO0gD6kLBzTQZpLzJCCol24oNwZyZlEg+wyiX0M08JMG8IXAoC5jvHbfc66
    CMYfkFcKTyI9hLGaTKRibxie/El8CND8hkNzykCFnV7GKkcMUI2/9EU5+LbShGou8vYGQa
    RuFJobETL0v1+OZxm5KYJwgzTPCJmr6i8qJPlYuX/eal3yUjpBsUG1hUPL+g
X-ME-Proxy: <xmx:5Ff4amwe55ZebB-EB7j0FubhMkAURIZNR_YuMdI8_X8Ow689wYX2PQ>
    <xmx:5Ff4ava4Ys50ktxXV7z1m0KOZ6UEk97quQ_L4V7QfFNDow1w-TvG8A>
    <xmx:5Ff4anUe-mxKLrDwt226r9p472JCC5gqisyflVBR8_PffA4uA6Ex1A>
    <xmx:5Ff4athd8f3e7uWz0Z8pIehzJdVhbTNpvGGAbN-Y13entx-yc2Yf2w>
    <xmx:5Ff4aqA_x9TdsCXT7500f7eTDhVHeSZHM2UetHQ6VLerh2-rMh0__Nry>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 07:45:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Nov 2026 13:18:36 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
Date: Sat, 14 Nov 2026 04:45:22 -0800
Message-ID: <xmqq7bifponx.fsf@gitster.g>
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

Does the new syntax introduce a subtle UI regression that does not
allow certain options before subcommands?  We used to take "git
rerere --skip-locked gc", but now it has to be spelled as "git
rerere gc --skip-locked", it seems.

I do not particularly care about the '--skip-locked' option itself,
and I personally prefer to see options after non-options as a
general CLI principle, but it seems that it is now required to give
the option after the "gc" subcommand.

I do not know how often people run "git rerere" with these
subcommands themselves.  This subtle change in the CLI may go
unnoticed in a smaller project, but because we probably have more
than a few thousand users, I am afraid that somebody will notice.

In the transcript below, "rungit TRACK" is my short-hand to run
version of "git" from that integration branch.

$ rungit master rerere --skip-locked gc
$ rungit next rerere --skip-locked gc
$ rungit seen rerere --skip-locked gc
error: unknown option `skip-locked'
usage: git rerere [--[no-]rerere-autoupdate]

    --[no-]rerere-autoupdate
                          register clean resolutions in index
$ rungit seen rerere gc --skip-locked
