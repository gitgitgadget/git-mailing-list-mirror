Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C642192FA
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780763520; cv=none; b=Jq+sCzJ0ZOrvQ8yR60R3So5AnEXP/7rXCx5BZYKUf11TmnvTXYvbYXBtedtRozP1Yosdnie+Gjfy3VwWdaOSxSFGIErPX1K4fwTg8/WWMaQVC34StE40sMhBxaUM9mFcCZWOxc3CaBaQ/7Vw4k/eRfPY605FNeLLRgEdM6pvZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780763520; c=relaxed/simple;
	bh=EdGZCte+q0yxIySKe1RzU9y+eAp6m+BL5S0JLMMl4oQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KaEb+ZOcodiTBAlwcxh9Vkp/xMSi4pgQI8VloNYQHfvFp6MEN8103s9AlZ69kSAXb4uAMoCU96WM4oMhxBMnO/1oSailDeECzJapovsdAdXCEXD0xDvI8oZYAHH/Pj4nxFUpAud5EjUaQ4HoGTrW2onmtY7qrtvffpAn1Jan6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NaitgajA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXDAdIqu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaitgajA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXDAdIqu"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9B177A0082;
	Sat,  6 Jun 2026 12:31:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 06 Jun 2026 12:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780763516; x=1780849916; bh=dVkPM2Fr7L
	/mVrftujuVM8h6ZMqqqG6UVxIoHHesnkc=; b=NaitgajA41SBFkQNE8piT/erBb
	LmHgMSgPXAOaGoqIeDI/0sm9tVNwzQi46u4gBjlgNWx/8ZGA5mpeidcaQSKpQgnD
	DjBIChu4mO90BCJSPF94KSjuspQlQXJimzIrdFKL5nyxlZu6rOBf6qdEP9GN9mIA
	9o/CmtORyo262zc+19Pis1xagB/+LhFYeUmpqmx/raR1QfTEo+mGsguUtbEwNuWk
	rQhzv/PfTAIAlHig6wEqnpi38NikTNoAhOWr5yxep4qFGWNqaUosaQOfwBSU1XrI
	ge3wNc4DV92Ubm9rm9xJvZsne1YAKea1y1jtpm8ZNsEHvV84kL64buBCt+pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780763516; x=1780849916; bh=dVkPM2Fr7L/mVrftujuVM8h6ZMqqqG6UVxI
	oHHesnkc=; b=eXDAdIquyujX+j1zuu+kENEl0ADBqmx+HecqylvZfY7NOoOc3nO
	buWNo0rMt1mFmS8Iw+jwnSj3bWaDuILiF07G0OA37jP89FtFpnzqSzcIgMMoA+CA
	ly9/zxUzo7KM8eZTFL8h3L4LhydtqMywgbho9ACSdOLwFrM2Ml87PpTrw59VQWEe
	OdAOdh31b47EmTS/Z3xVDBuOYL84WTtjqMUK+Lya/f+lNbGF3VFvkhqDMDkTd2om
	8L//Cpc9gmvbmq7ee20KzsX5SUubWGN5Far1Ypuy5XCqxEX5C04vUiMyWrYTgHDL
	S0crROc6Lv4k9wtAZQCrHGBKFgcdjxQAfyQ==
X-ME-Sender: <xms:fEskaqX7zAVX2Jj2-5PQtW9W8-m67Dlv_8PzA9wIAvxcSvlXw59cnA>
    <xme:fEskatdJps-mxihsJsB-KxUZPe0c_wPpv0NflEKpCePlL7EVlFxsu_mVkFCLMubuI
    lliJvG6tVPnbv6m-KobxweqwhktLGqOLTM9WCoTozuAW8kf0fCx4eQ>
X-ME-Received: <xmr:fEskamsta_dsYX5Lsnw-aq6bh8z2aqSVBvimuoSSYWB-iv0JvswVO3j8UbteRajFEnYRQIAiZp4BgGRJkuVEf4pxNijncB4EklfP>
X-ME-Proxy-Cause: dmFkZTGbpQmAFOIcziiFI49hy9Lrw4WnIQKRMkLVmZSRrZfkxLrlKjMYNGJ69VzZJHed+k
    yXP/Pq1ShR3Ii6k96zVJ3SIPxav7EdBcdPMWWe+xPDHbzb6IftBsaZd+fEvFgRPFQsOuSW
    YBqzxsL2raJhTVKSZWYcbbVYOe9rNg4l5DdQ39zfY/pWWIfBSe/VxK2OOrHjNnWRLgjXJL
    TV4+wWcOhjVGqcem4h3baIRpcUDLDt5uJAbdiV4C5c72HJRWG2MrVQJfQtvtNXC7osz+I7
    4DqYxVUW9WlNK9XOdWNtqNG4aoJKpZid29onxfPPUqNR5jpTBWqFnzcJpUuAarpWTbTrhz
    VeyCizwrVtnQwqVIIaoWlS1ZkmxgHbyNM5u2MnvW5uo7qe+5ZJUW9amopmng7hdMrhADd2
    Xx2fAGmxxi/+XHWt6vA1/r3LOxaEWSGVAbN7GwrbLp9HMP2XVr/Usd9jYm1Zxe4mv7cVA+
    DL8PIWyOThJi/mutkVWtgTF2xzYIr+eklcJxR6iMOhSfDH0IUbdTasXrnM/+fIcdRT2jrk
    o1wJLfP6VFu3RHh7e5TVl5Tj/dAoYQTGCCXFQVc4NpKxFEbWJ34OpL452eVxk8TkPeu0Ct
    r5vU67jj00BTfPqlykBZjcnTs8V+mvBGFqvRKM2PknESWlS7V/ScNjJ7ykvA
X-ME-Proxy: <xmx:fEskas-itdE58RzBZ3LikS9tomzXLQNnWDNRf0BAmIJQcQs5Ooh5nA>
    <xmx:fEskah0JhkiAr7c-X8ePvbVZy8G0S6ifay9RptwUUw8ql5Obo1yc6w>
    <xmx:fEskahBJ-t07_shOyxP5KrrXqLR8DbqHxoL2Z800ugPihk9kh8b_Qw>
    <xmx:fEskatfDLvKpeKF8ZFmTKMxRA4vSuJn8Q5SAXYtWvTxT9jEVhqSkbw>
    <xmx:fEskaqhLw_p6nmWYHlC2nevchDVrFxu3lXtyVKD4DzeUXqgty27CaFM->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 12:31:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
In-Reply-To: <pull.2140.git.1780757885582.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sat, 06 Jun 2026 14:58:04
	+0000")
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
Date: Sat, 06 Jun 2026 09:31:54 -0700
Message-ID: <xmqqqzmjbpfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Add prio_queue_size() for callers that need the logical element
> count, since the physical nr may temporarily include a
> pending-removal element.

Many code paths used to learn how many elements it logically has by
directly peeking into .nr member of the prio_queue struct.  Now they
should call this new helper function, and you converted some in this
patch.

How can we be sure that all such users of prio_queue has been
converted?  Are direct references to .nr member, outside of the
prio-queue.c implementation, all now suspect?

For example, object-name.c:get_oid_oneline() uses a prio-queue
"copy", and loops "while (copy.nr)".  In the loop, it calls
pop_most_recent_commit(), which does a get followed by put of its
parents.  If the get become hanging (e.g., root commit, causing no
_put() performed in pop_most_recent_commit()), would copy.nr still
remain 1 but logically no elements remain in the queue.

There seem to be other direct peeking of .nr member remaining in the
code.  Perhaps the member should be renamed to catch in-flight
topics that add more users of prio-queue that peek into the .nr
member, or something like that.
