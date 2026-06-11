Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A3DB309
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179582; cv=none; b=rlKnKiY0+Xy0qruSXBIFL846qH+luRMd1Q0SqJO6HxvssIr8c9OuFg4TKv9DEqhm1XUPZxffgzlZWbHNWHqCeAXALo/xoCxsOhSh+PbrfJdjlKHFfRdBwOGAZW/E/wrpouLTuUwgxOKQMx4eyTmazj5a7dz0eSCm0aKzAf9N0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179582; c=relaxed/simple;
	bh=uPJMvsNdXaXcQBjAuDDGeA2b5XrpcvdrqTr+y9kUd50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eEfVcmI4dcf+qMun0qBcLhJJlpz0YD7p1CUCgt/tq31kdql4oojhJ8J/A2HsftqVOslqwqI1yYjbzD9OBArPdTRyPUo9bwIBCvthgWiwCV8DIsF5USu7wD65ygrOd0SLvacoTd+7XPDtimw1477xTh5igxQzmdxqZSsWccoALzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mxXKdQB0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHJCUwrF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mxXKdQB0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHJCUwrF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B7C57A01E5;
	Thu, 11 Jun 2026 08:06:19 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 08:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781179579;
	 x=1781265979; bh=yOZMdkSfZUZEI+pbVhOR1vA5jy2AI/Oy3qyLC/MQJ90=; b=
	mxXKdQB0Qs/00QbKiI4lgUYY1Fy8cnr/Y2FD7Gh1P/sufmrjAjacgo39XLM0+02e
	DTzYqQzqI4nwu6On5wfcibMaSVpeDiBHxOc2cmVBueM4Sru/FKVfzEJUAUc/V0KC
	TnnRTpx9vqLO2K5zkdnkrHU0k26v7Kelu0tVxrTgxDRUMIuauCnefDR7fBmdJG2H
	zOI46IeoVHE9XiG0Uhpu9h2/oazX+db1sevIO8sHzI/QyCvOXyxT8nXkeeez/RCW
	h/UjIs7oRbr1oTel/yRzuTxg3d8k6Q6SbuqSgooXw3sMMkJBDtP2AM0S0u90WTIW
	szV5kvXnnM5HcHim7HJKbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781179579; x=
	1781265979; bh=yOZMdkSfZUZEI+pbVhOR1vA5jy2AI/Oy3qyLC/MQJ90=; b=G
	HJCUwrFlJA8cae5JBZAC/3ernedjOmSAsSVj43efmHW6v2iNCzs56dcuQ0bPbE8q
	BJ78oQfMa9RHwLl36lHGOhFoC6Gm2zxC+W99Ym1M8RtP1ndaxQkJ/zi/ZK3AwcaW
	Xgm4oXFQB+wGd685m50kooM9dkctOJwT99Hw47x8VQwmVxekIFjHKLLEX8V40O5v
	fwKTconXbYrRkjGLKQ/wvJ9GJpnaSspJK86dbdkePt1ZSxWrkm3ZCmGSl5cLdpTx
	LoyAYeedyux/xDsEpULDyPQmYp7eD8prkE4pnxP+LFemagIhQB7M/nUCBXFGCcyH
	HVrogxzAJQiPPWEEmYQgQ==
X-ME-Sender: <xms:u6Qqal_aX64e4Tov5Y6cFKjiRE7tYZTmiblrtQH0yc5is1LjM97dqQU>
    <xme:u6QqakgoJOoy7jKu6p3n2roX58WzRDXutTUFwbW-EGjVGy2Xv4WwxpKTOIoAWYrW1
    dk-MkfTOlwlVZxI1sF_vsgCtt8LLvBTXiJswfHe5stme5ONYurqNzc>
X-ME-Proxy-Cause: dmFkZTE3X/dyLCSdjKGXOYR8Au6mq1CgWyMLZFDq0d1/rp5V8ItICWJ0CZ6j43c7GZEDGR
    /RksDK/ep2fw97KDx+pCvExUJnt1otBytIaOXq3Dhx0kFxPaCCoq74bp3SGL7Tdi9YYAQk
    rD0qvxClLGVYE7EDqjlnVoozNGkTBpCllwlV14wmuSXUaRJPNud78X3IydE8luK7y2j41X
    p3DbNLJFJEKbMvE85hEGf3phHGW+dirIwTG155n6q4XMLECzfJCyagc1cEpCxzqRF4n4pS
    pcP4+kr5163XhxCcG+maVYaRA6qM8o6xuJPu/PAcYo8icu7StOj+Im2jiN7kQvZL5Z+FSB
    9XsiUYfkqufd/DAUP3fKXu/tzFId5WDNUJOZeL2h+xbtUfVmUEySfwjbvcIdgPMyr/0FEo
    EFBSEFkC/GBjmaQUxLwWOummFA7eDcYukzAEo6pkyi9l8ZQBeR9tNDipOClV+Z7P9PeJQS
    NptVwgxB5m06cGUqxhl8RUsST4ilXJvh6rr0wB2xl0OeLv/pXHGF8mKqBKBZOkq87HpMIV
    d2dJe0AhxtVGcJ6yneFdRMEHrYDxcDo/SNHgzuMgqf0GLc+F0YTm75e8nYWK1FOlhXd23u
    IOKC77m9LW/rgqQZ3frrDklsp59MsXoi0/MLN/yXfcGz2r/BkPUpyvDuO1GQ
X-ME-Proxy: <xmx:u6QqalVP0pX8p3NpLiUVMwws-2_S2BDFXnTXS7vKV9SGtpMJsM37DQ>
    <xmx:u6QqamST3SR7KpyaPo0tEOmoj7Ua0H3UG_taRPxFJNyuXDaOc0awSw>
    <xmx:u6QqavltqKREzl5z1sBFpEKVjPoUod6ffR6rfPqI_4W10PAxFWoYGw>
    <xmx:u6Qqas7oXRCc8RCHMptQrlbrnoqCckgSxLK0EgBliDPPFSPvPiFFRA>
    <xmx:u6QqapWDce8bjoKN-PpTK91dF8uCSyUPKKt8GrRSp6Sv0Amnpk8Go8Hm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3863330201A8; Thu, 11 Jun 2026 08:06:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Thu, 11 Jun 2026 14:05:58 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <f738e97b-1aa6-492f-82df-c284a2f94c6a@app.fastmail.com>
In-Reply-To: <xmqq1pedthkv.fsf@gitster.g>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz> <xmqqcxxyt4op.fsf@gitster.g>
 <xmqq1pedthkv.fsf@gitster.g>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 13:57, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> Interdiff against v2:
>>> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentati=
on/git-interpret-trailers.adoc
>>> ...
>
> By the way, what I queued last night was missing [10/11] as I used
> "b4 am" to grab the latest thread messages by giving the message-id
> of the cover letter, but somehow [10/11] had a bogus value in the
> e-mail header.
>
>     Subject: [PATCH v3 10/11] doc: interpret-trailers: rewrite
> new-trailers paragraphs
>     Date: Wed, 10 Jun 2026 23:21:28 +0200
>     Message-ID: <>
>     X-Mailer: git-send-email 2.54.0.22.g9e26862b904
>
> So, I reverted to the old and battle tested way to pick these 11
> messages manually in my newsreader to replace the topic.
>
> If you have a chance, could you investigate where the send-out
> process went wrong and gave one message a bogus ID?  I am worried if
> you may have triggered a bug in send-email, in which case we would
> want to fix it to avoid hurting other users.

I=E2=80=99ll investigate. It=E2=80=99s 99.99% chance a problem on my end=
, created by me.

Sorry for the trouble!
