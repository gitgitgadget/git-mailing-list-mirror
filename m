Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796864;
	b=qmLzh3eyBRi82iuWBeqL0cerZKz47Y4lNI0s5s8zV6bRvBqcgWxle771qyQAYnNGO95R
	 T+tHMqiM6zOnt/9m8N+Q4M1h+ob8LY7OMgvZaNQXCP3LE9/zBimxtTSpmw0WKBg0HdI28
	 LDORZUQiMUgP1eHE7G7vi/RcHtLskI3xBYb8WnNupJ6HMDBQCSqUWzN5BvpquB5EB3Wjb
	 O1hbe5cavbQOTH8uad3I+MAyikAYhYiw30+wfiYtkRDy7T1TZX2vhX+G8b/scEn9WJzL+
	 p0B5b3GNcrCj105kR+zwOV7B8tcTMjn6WZj4YswsAR8dcV7bMGy67b90lIAtAKrFLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796864;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ajKoHVbp5OXtJQ4SiE5DI9lI+wNopCngA5tAO5/63rI=;
	b=sV4+qCkCiW2zz/WTKS3JxBhWUXo5oB8RSGiuPgH1n9pNbl0uYOJjA+Uned9zm/LouuK/
	 Cvb6b0QxjLH905v/n3h7w4JhOoGR5dIzCwLS02wP3iQvWjUwLIJxLvgX7BEC3bEY/HgIq
	 n74jYuOQJqtezx+8ggy2aVS6UzAJ13KZ7u61DnngjzDWiJM2Az1fijxd+1natMAk/i+t+
	 kRgf5bvT+qEo9X/DrG2y7x8v6jrfQwCjNKkbrvKZkoJ4Z2cqXn8g7nMKh7pW+27iAatgm
	 p0EJGBgd9Rt8PSSzyBj6VUHWUI3gIfIW4DzjgoEyvoIl9eM0r2CNxqZElM9IhYFTOhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZBWb1uxU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CLYsomux;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9342606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9342606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZBWb1uxU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CLYsomux
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6ADB7A0124
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 19:07:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 19:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792796862; x=1792883262; bh=ajKoHVbp5O
	XtJQ4SiE5DI9lI+wNopCngA5tAO5/63rI=; b=ZBWb1uxUAiAZ6NGLwK6cIdrG/W
	OcDuiQIAIlhm3YPlCAGtLqn1ZdoCQnNL5buVUASz3BXDS5XXUGQMd+LDXSgVDcum
	9AbFWoms5Xsl/jQRkTBVgUMpvkDCv/xjcDIK+4BHU7+YGoMu9lccTgoQaQdXNEh5
	+RUBHT7ZmHq2MRQiT2PE0XpPGjMsjCFT1O2CsOOSdo3wE4OYzPOq4mgK5a9+eY2q
	HbCfHZRaSvRq3kQJymrWAQirb1hl+qLPyUk+YXSdBslGvDE4PEv5q9f0epWJXS3I
	+i3mBpSo9OdYtXp1Xm3qnZbo9wFJXe3ZdMbU0gjBcotsFYOTUXc1ALnI5UqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792796862; x=1792883262; bh=ajKoHVbp5OXtJQ4SiE5DI9lI+wNopCngA5t
	AO5/63rI=; b=CLYsomuxIMHiBoUVThfUkLt8GS7uPC1udJEpnerw4QzyzNeclDh
	zDw7gH1QXiXZkp167/KxOVRHUnWmnr8Zsmb98spm2IEFqWVRx3/6e8gXVbnWWzho
	fRf/LPLMm0Zzm2eCpTVYf7leNeu6zDZIOwu1PzSdXJZiJeAea5fJkR5hO/lHUzWz
	uF8XQJHkVE0UFTNWwGaAWrl1vYnsAUI/X1Of7tZo7wJMKf3Pkdqgezs6vBIY7nJ8
	W+/TNHV6wdFLZEkbdSg1Zx0Ta+rbHacmxPoMsq+UJENtesIjVSaixpdecy6c1aOT
	tYxWuqfOGGMzngdLhIUWjc6jTBaIfwjEcDw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792796862; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VRuZon6azRXy8LZAdSHq1SYNatoXVqYruL9vYAPhbnjLoWZ
	Zh6eOasH90vk7IWqU0RSxdRdGiZccfEZrzHTc5UTUoXlXMMpnnvNmS7S+ySVPmwh
	msVmgd4vFdtlQ2GFOaG/dgPg76RPTR5lgQ+ppypP+ordY4/reWzr/p0bFJ1iKzhr
	5qUiveWvbBJfFI7jgBhx/eGZtVGW/wypQuuOUHoVb2nwYeJdfqXq81H4z/uN8LVv
	ACmHrunFD4AfAvdlvtHLIX1qcm6UDgtVWha5KTOhEdE398y70yRqF/JSGXxwrnbM
	Nzk+XHou3D56ydauLOMMvOme2Luz8Gsqp24ceIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CWEVq5yUgZJhLo9qSOSKkAdaYUUaS2G0tZL5GPoNy9I=:ltZF5ur9DNpOfg7PdaDb6cCl7j1fuIWd2rir8jSvAuE=;
X-ME-Sender: <xms:vujbamgnWUiiSMfvWqSWD28hRAwHWkqxlOSbRU_3ITMapiuGIolTsw>
    <xme:vujbaqt4rmLgBdlbzzCM_L-cnQNvKL2HVAmGXj-WY5V817_ycJjAw4j5l3Z5j47gZ
    qgU_GfWz48cWFnMNnshq4agjG7wTk9JWOp5JVSQl2nkiJ_u7tuwAw>
X-ME-Received: <xmr:vujban5dGpWDDMccZikgC_-RpMoCAmgFvePyLI7ieMHcy7q0KIrR1Ef88sMuvCXd5vVJBUtc8jiUAwmtuufAoDzOjFMX-f8IHEhy>
X-ME-Proxy-Cause: dmFkZTEUWSEl6yWv+curSOgs8G5QMSq7lfIRWQeR9qjf6xygLUfQTmYPyzadm4OAJnw+YT
    i430XgseXYZhRtfDzk90FWrLIr9W85cze2itP5UAlF0kex9xw03V2/9fMUG26o2KSCaLH/
    XbD6wLFZ68rTSg+W09wZfAK52VpRjGGXhifi8amQFox4afuVrRd0rtzTM8X8+OF22G9s1y
    iQe9u6oFsCa0Tf6A97MBuCkHurn+0E0IOO3OjPx242RFiymwYRDa7zJEjfqsUvDtecKc5E
    C69t+qXwAD0Oui5djWYqk39nYuOX9V/MBs4ExagEmNGG3SBU5/ysJgmV6HfbikgPy/w2cK
    A3H7su8FykBVbATzk7SFnRuEgFN2cCsWt579XVn9XS57OVuUtK92u29nyIAthyfejsocij
    ynGTDPnBposif/D9ZKjELwxBSLJcdrtO+ppko4SGVCTsP/zUrx4TZl6OQpDHrjaLqJtcSp
    Kf37Las0gnBNg5SoBEkgsRW+MMA9E+j5ttuu/fNAZDZzJjPJwRXJppl1zHmahkiVXjUhwg
    pbNy287lCRMLkUm9WXgOPySfClB6C41H0Wg1govjpqRhDkbBYhyjrtLWFbRyuHwuwXZdfw
    jrJ9v3D+YTfVGgllCb3t9seCzsw4O36Lij4UH2JeM2qEmYmS7lahPygP+g+A
X-ME-Proxy: <xmx:vujbamNyToSJqKlPK8BRzVJXLesg9xRP-3LGputRIYQf-hE48g-JwA>
    <xmx:vujbalt15YNSpXJQ_YZH8JTj70v0Wdf25FrHn4P0DHSMzar5EDz7aQ>
    <xmx:vujbapbYNvkZgvYjyKBIdBFP3I95A2BZxB1IhGrvGJkblNvIeF1JZw>
    <xmx:vujbanxyQS_hzpGnvJPu0lPzr_S1-oOaPLsuLfTw8rBpOQC618kltw>
    <xmx:vujbakE52l2fo4cnUaxmNgESwqangHrlAOAs-gh57AofVx7w3RSl7JFH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 19:07:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push
 branch by default
In-Reply-To: <CAHwyqnXwFwJYSA-ktNuDKk6RfXjyvFiYka-K13-9wq=qFgKnjQ@mail.gmail.com>
	(Harald Nordgren's message of "Sat, 24 Oct 2026 00:54:01 +0200")
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
	<pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
	<xmqqld7o71ot.fsf@gitster.g>
	<CAHwyqnVMgAhyHrevXOJ0sBKkaPPzSmCcCPSSeqm6dm-MRX65cQ@mail.gmail.com>
	<xmqqtsmc2hmn.fsf@gitster.g>
	<CAHwyqnXwFwJYSA-ktNuDKk6RfXjyvFiYka-K13-9wq=qFgKnjQ@mail.gmail.com>
Date: Fri, 23 Oct 2026 16:07:40 -0700
Message-ID: <xmqqh5ic2eyr.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > This is the point behind this: To ease users into triangular thinking.
>> > We should not assume our users are git experts, many of my them never
>> > read the git docs.
>>
>> So instead we should assume that they start from mental model that
>> was destroyed by use of GitHub?  The need to do so somehow makes it
>> smell like a sad world.
>
> I think it's better to accept the world as it is rather than engaging
> in wishful thinking :)

At least you could push whatever is encouraging the use of "-u" to
break their mental model into also suggesting to set the necessary
configuration, which would make _them_ internally consistent, without
breaking existing users (and without bothering me).


