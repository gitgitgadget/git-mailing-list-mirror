Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832502;
	b=gd2ljvkbxsCcNvQ/EKBxcoPfzgMV+wR2g/YXAEeEfKEcYttzZ558CxjqIhBI9fPvQNrC
	 t7s9mIkcxc6/u9TsGsfXq0o2U/+vqL4KzmUYXsZ5i0KtnPXwL8X/Z2VUQT/KohhV3eTad
	 qcCiiny74U5hR2Nu8SYezfs3rRhUNIMconb5TQ1OiPqLg44cfgMM8WKB3ACnvFvFezfjI
	 7h1bi2VoTmrkLU0pNtgvJ4AhmN/8SFhlO9IJ1tVL4ng94O29NrLN058xP2GzTtSnjQvoT
	 8J9FSAGO5WyA4Y9K/Kx+yLeESIxUTTsW52/S+P/v3QSiyc5VaqSgeeD/CXfGy6y6iLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832502;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Dx6ac82K1o8c/OSj/mQIYpel4REhbrYFs6/hsmdXT3g=;
	b=f13OKqdeVasME2lXeSx5gAXyfSw+Iy6QWpp4WmhQSnKZxR4ueZB7JadMkY1w34FDYmOI
	 UBWcDxs7QYO93TC4qlu+YbdHLpaqv8EuHq7aAjw39qJwsFa7rTEBv7KOXT98UN92ARgbk
	 FyAEiXCn4xNTpmR1pGscHJy2zII6hNTfzN462yk3ubHJbcfKy/xtClFBmRzf8/VwA/sse
	 Ntlru4/UrF0yCpGWSfqpPEg9i0xY8fpDztERX3f5gfFVszM5XMsmX40lxPKVwaWus9JpE
	 n/FySSerfWa9lbvomEDOuBPNKiI02Cv7EfSp20dx/ioAiUml8SvBxyx+scXZ+sBUsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n2MItLNk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lr0ZyJIP;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F67606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F67606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n2MItLNk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lr0ZyJIP
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4287DEC01C5
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:48:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 04 Nov 2026 17:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793832500; x=1793918900; bh=Dx6ac82K1o
	8c/OSj/mQIYpel4REhbrYFs6/hsmdXT3g=; b=n2MItLNkJVFqfvYUehE257Vvvf
	C2+2/0cG6aeLYRD//cDA6Rgo9b14V3m+arpR+ynJ2vU+WgfsnDpuq7HWPW4YTeYO
	YrZhG4TyNaDEGov7cdXDC87MoBwYWLS+37P3s4qOUWMun6Bx/tV7MpvOE4k8si3P
	Qa9YCB4qs/ZUElcUxVzX18Nb9KVcUOIgUGSvFWKdX0zKzW6vZ8lAIY1h+3b6FTL7
	zBR0mPj8+ZAJ13DS1b7Y5Jx/MSdR7WIk1INbqdDhg4MblEKzwCMEbsy22FbSTlZn
	/T5n8Qm0YTMtdEfYQzvHP9Gfn4kDa1zQi/9Ax9+cFaFL/eTeHmA8LFHxbN+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793832500; x=1793918900; bh=Dx6ac82K1o8c/OSj/mQIYpel4REhbrYFs6/
	hsmdXT3g=; b=Lr0ZyJIPlMBAFv8I3enIhQhnwCgGWH/MgBRxjbbC/TyB6cBM7BS
	lYbjHtNSFBGPU84GcyqlRjM1ZzjrIXLNIwx9eGN5aoGq7LfLZYdyZ+GITms3sAx7
	7pfCSmYZa7z4SqMApcytktWb8nKyuLZf2N324AOKSNb2gTREOHdITJSRYz3K8Yh8
	ZRshY4JUu+WRFJPjUwav2i8y0j0yoHknm7SqFxSU+lg6rs9Dzghl8yDnUwuwD/vW
	FOFD8TrpAh/DqKcktaA9ZCpxiIkiqjtFvzp3F4NazEM494QTbkinTt+CVM1CUZK7
	ESR4T1XmqXLt2Z8kT554tnFGO8hRMVA4+gw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793832500; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a9pyEw6cPT9f+vwORevN0XrsDWPHrN+7WL2dT+LTnrlYnb2
	B9cDJGn8vIRv9OUxptnonUGVqB+/adr8GW6c8lUJrClqaPY6Z1XroTvrm99/uoz/
	U2AeaWgbNglAECazFnVhNMcKev5viRK5Z7LVqRnBr6HXYNUx/iQrYmiC+XlYGdL2
	W9+iXo5WyoxouQ+YGitIlW/svq/Goa7libSD6G7IIVNgw58J5cDpCNfuRyvYEJF7
	3JYSR0zhM5njvCwyjd3vpvyDRnlOU1g5VEGtaEsicsWPHpHdnWGW3UlxQRGuqaqa
	lhpg9PvspyvpCySuYnNMC4126kCGwSwzjp7gk9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8tkawWSy6Iv9Nfuxjybyr9SAlVM8QPyNjxycDO+ylLY=:QNSrSmAba7BBv/r9qIHIkqJH/teQd1IkF5bOXFstr5A=;
X-ME-Sender: <xms:NLbrap6m7r0CpSifKlqSi7Da7e6NNem_BHrQslWkWcCNQ6DXbvdgIw>
    <xme:NLbraqkmaN19JtrYUzrx_7r2qcUpxQQW8yFiv1EGAxTPtCtHdi_EDVs7Teb77NDB2
    aenReFiKVgJFTbi42TGZ6GSlBs4CFEOE9Q01qscIZwVLi9EYaW7Q3M>
X-ME-Received: <xmr:NLbraqSmo1LDBPHKcjwRWxSCKbs5jYkOPGsoH0vOEW_uGtN9e64Yu7lGtzRJmUW8HXywF3J5Un9DV2WW6i03B-U_3hIMrwu2251h>
X-ME-Proxy-Cause: dmFkZTFHWqxQQaQdDu6AnCvelgGP9CgFiCLVtQUhosoqWMPhmEWF/Zt+fIXmfdU2ouIbOD
    OwxaURGQHii1GpbcOUSXCKrfkrdSrUbz9aJvNs9TIP/MZhmZCemnq+Mu7zxKuIteZD8HhP
    kj1MS6JfV67cq4xH677Evhe0ZUfk91XYSNjDWSQaVsJ1XhF/4hbeBUI6GdJHdpGuPA81Gt
    dcqYQyt1ZBsY3bBM/BonQcJr2I7lu/K4dJ1XuQKQ410DzdcKEffg5MNztkXR2+OSz7Pv2X
    sOLDYAynlxvRVhdl7Fd9Vf4J7xYRSOOqvnrYsiPBOVEKGjQSdq8EJzz5RlvYuf70yy3vTc
    njtaHLiPnD9gepYs1QSjnjWKwByRrU+QmOTP/WioeHKCkFTtJrGUlxtHVA7zCX5qVKZ6GT
    Eq1A74Plkq1Wjf+zUmSS861geMrJJ1+i2sHhjDIL7fQ8wdYAOg4aV4U7VksxyBQ1hGHM6+
    ftqdA0ugn9dpuueOUTyjEsEVZGh+Yc1zXeOwuexNzb/TbbPAhXNOrRu1f8jRLdZEgohdkT
    U5U6aEDy1EoyGGhbBhl7aqVIn6wP83a4Mvl6yGolghyVPColpw3ClrWe7MRUPUmKHBo4kR
    j3A0kRz4Go46XHPzb59zPyt81s9QlVhTWCFdUffPPVmd8f6QLoxKuyfxOMuQ
X-ME-Proxy: <xmx:NLbrapG7gvJUHQTgr_dOA_fmksV769PG5pABTSww7TMw9N1aW4-DEQ>
    <xmx:NLbravHxT8QoRQ73TRq-wW0sQPRthrEoTtz0lmCcK8TYJyt6B99Rqg>
    <xmx:NLbranSoxAClRUyCJQs9CSLpWRH1i46WtQjmbw52vEHZoL9uUEzIfQ>
    <xmx:NLbragJoDPSYW5DB8vOYpPbUBUpqCz72rcnGAv_w4v2NQO3HAAsHIg>
    <xmx:NLbranVG_FImkKPh90YG3CL6IJv0w7MGmXEj4NZdIDmb7Ch6ZAG_AnWy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 17:48:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Ted Nyman
 <tnyman@openai.com>,  Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 0/8] repack: various corner cases for cruft-less MIDXs
In-Reply-To: <xmqqse1o4g8t.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	29 Oct 2026 09:35:14 -0700")
References: <cover.1790731662.git.me@ttaylorr.com>
	<cover.1790827875.git.me@ttaylorr.com> <xmqqcxsufz55.fsf@gitster.g>
	<auFD5f8IWEHwaFLD@com-79390> <xmqqse1o4g8t.fsf@gitster.g>
Date: Wed, 04 Nov 2026 14:48:18 -0800
Message-ID: <xmqqqzh0z00d.fsf@gitster.g>
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

> Taylor Blau <ttaylorr@openai.com> writes:
>
>> On Tue, Oct 27, 2026 at 05:27:02PM -0700, Junio C Hamano wrote:
>>> Taylor Blau <ttaylorr@openai.com> writes:
>>>
>>> > This is a reroll of [1]. Thanks to Stolee, Junio, and Peff for
>>> > reviewing.
>>> > ...
>>> > Thanks in advance for your review!
>>>
>>> I am trying to eject stale topics out of my tree, and the discussion
>>> on this topic is about to pass the 1-month mark.  It seems that
>>> comments on half of them are "looks good" and the rest are "just as
>>> confusing as the original without improvement".  How viable is this
>>> topic?  Are we still improving on it, or has it long passed the
>>> point of diminishing returns that nobody is interested in polishing
>>> it any longer?
>>
>> This one should be ready to go as-is!
>>
>> Thanks,
>> Taylor
>
> Hmph, the question was not meant to be answered by the author,
> though ;-)

OK, so I bit the bullet and read the patches and their existing
review discussions again myself.  I too were confused by pretty much
the same things Peff commented on being confusing X-<, but I do not
have concrete improvement ideas to offer right now.
