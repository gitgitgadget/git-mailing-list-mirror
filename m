Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC940D58E
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782612205; cv=none; b=BTf7iKsD+auJM8mU2sHxnIqZxS1QSzqmfU9RgNbYYWsNW5qoDbzAvQ87ygpKSrNBDL1eKIdhXJI+ZN5ZMIf37R0cIA3NFM8QXyWH0b/byxPDuYSb6mQOwsuH0f2MqDqkO/FIDwDTAgJaHnZwfq+ZCmT+CAQlYuZOzszkS5o6YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782612205; c=relaxed/simple;
	bh=lctbzgaOSm5QNf/DiJRbnse9YEQMrPIQM8s0euHPP5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0YwckGQ96Zl4Q1Oz1NMAHy6HpudNClJ7cjUHrgLQMGGIQ8GzRW4vRcvuYE7BSCg39YBr7ZgEanxgV6hVG2UMlxjaa0echCvpnf0J96XND7uQt8dktSxwshTzPget9D86SxPaV97ys7Qd4rrpdkmlk2vgWQ7ZSrQBJXbnnEmbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hNZbZ3AD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=INLQ46gr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNZbZ3AD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="INLQ46gr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1F98140012F;
	Sat, 27 Jun 2026 22:03:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 27 Jun 2026 22:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782612203;
	 x=1782698603; bh=gOmEIiXBfYzN62X238qsrHWGDLkYdSyMsJ3PmQm5DZU=; b=
	hNZbZ3ADmhwZUa1r9F7flvIy9LY/pxophlau127DxWMLHrbTxHbXQyIzD8OXf8Fk
	k2drqZJH1D68AAcev6MHRiRok2/sKIJGEiyE50tKbmV7Szu1m1i82+G/GWRdQTeS
	oY9hckGGtBwNloCCqWPUYFyoqvLeJd47lktAyeTqD/atXg+j7dzZ+804vVA2FxyE
	hoOxTy4pPpbpA94NgZs2EvsLvZSuR2a4ctLCdPAEbEjRW/GPfwnHH46MtI0fa7p2
	bMDv6y4dCvUqkYvxqGCPC9Mw8z+dTcbi8QvPDtz8FIPjylJZkKg2Qri0aIKMD85S
	EdZiyc8jB60M172YHcI7Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782612203; x=
	1782698603; bh=gOmEIiXBfYzN62X238qsrHWGDLkYdSyMsJ3PmQm5DZU=; b=I
	NLQ46gr70drgMGN82OSOcU46wnAGd1J2WtWmks/TJ8m4qE5L8bmfhNcQkV8s0UI/
	YAZNhBSl0y3zR22UW2W98tNPxkUgT8tAYZobMBVJdc2FXUbYp23l8O5I160ik12s
	f+CjXFliiZqi4f3W+gzMvhmt0wZkk8Js/SJtblevPD67Jb97Wk1UqnO3NWLH85/k
	6sEbd7nPzbkxAiGY7N8xddLPd1byo0azb2iaRtHoUQDFxkpMUA02X2jZl5FWEYK+
	JiPurejjs/LYUwdEUGXispm6ZjXooi1kQxkdq0udMNXwqEYKkQ0wwPUJfwXSbjrN
	cnZuARVsd9yHCygYGaI2w==
X-ME-Sender: <xms:64BAar0Kn1jfAZIKfgq1olCbtYRlGiF_9ACMk-fpfoQTcG-MJCjrig>
    <xme:64BAasVkZ2pxxa3otepxo1jVHbXCrnm3BEMZVO5P2TasBCzWJHLNCWeAAXuNhV2Cb
    wtgSXf6DB7Tumy-rPxEJCcKhDRto9MGcIC09fMOZEnZWQPve3lU_A>
X-ME-Received: <xmr:64BAauLBbtlmsUaLFpX3Xs3LDvHjfl9H2i6wRQrm6uZvqYbQ_OK2omhRCHt8yHuLe3LcF_i0wyjfEbaGDwAZLnrNsI_tVjAFUEjkJfE>
X-ME-Proxy-Cause: dmFkZTEJrfLI9pmSAPf6ZAXYVd7WZ14jXEPaAsDneeJxWfKdr2isDiHb7a3LOCjizTbXW6
    kYvZTbkv7M9gmfKnFYkX7W7TWr8P/PGmuOkI2tpARKcLnqdqQfG949vQLWYEEtG89wnbI0
    r0+EJXREn/BWrxOmI952C1zbe+Xy+tYruIe9EUi6bjKCGE54TrJl7J26U4AO05nEnGonmn
    /ZfQWceIuKwTbepKWW/FyiQkNI6pW9Ay2LhL241FscgURrEln36Z6NGVGvReixv7D+hmQa
    WCbKZv/6XECH1dVUffLY6MJPMMTChpxM3bodS8zT9IgGnFwQ1ZtTeKj/bp7sh8xwaagzek
    XZ+omJGibdl8MR4Su+pyxj3YMsn3u7lEwUI1Zd4MIRh3GmxUbFYq/QoBDN02Tu+Nq3HKuw
    ROyj+o4cdsBOVpANXGrA2bRrnUofnUp4VL22b18h6qzk0y42tc7kumRhnn6K095ayqUfAS
    hfHbmtQAyfOladsffzXOgHjmX6RdgGA853GnShFfDcS7o8bm+lKCzV+++wO7Ut61SvFYY4
    NV/APrWJKP2rmJn8ut0tjZs7YFwZpRarWahGlLE85R08MiULZ1kFEfinO+SlJBkl5nYKE3
    ZA4Rfbe/gJUuNLUSJm1cK8ZvdwxxeWBzFSPxkhoucLuUk6HEgTSAosvXuBog
X-ME-Proxy: <xmx:64BAam0HYV3nd2WchVKq2FQmA8-KCugo1vpI9js_9atDVBhqbXW0Kw>
    <xmx:64BAas7rLJVblIPTnE179AApLGykUTCSZoWc8hqoASyfXKoOmgJ3YA>
    <xmx:64BAan_aMDi51W7bU1I2xhbH7FXv5pyfzxrs5X1GXIDs5Op1_OKHRg>
    <xmx:64BAarV9CdRj4OtC6p7Khv9cK9vrEimnTzvCkuX4r9yC_ZDMi8ueVQ>
    <xmx:64BAah1rw8yUWTL9VCxaC02meKCawm6xb4iwdj-VqcXvTTIlX-jhKxKl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 22:03:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
In-Reply-To: <xmqqldbz4f1a.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jun 2026 18:41:53 -0700")
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
	<aj93BE8MYatQAjoy@szeder.dev> <xmqq4iio59uv.fsf@gitster.g>
	<xmqqldbz4f1a.fsf@gitster.g>
Date: Sat, 27 Jun 2026 19:03:21 -0700
Message-ID: <xmqq4iin4e1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>>> I think in this case checking the file3's contents is wrong, because
>>> at this point file3 should not exist in the first place.  I've sent a
>>> patch to fix this long ago, but apparently didn't manage to follow
>>> through back then.
>>>
>>>   https://lore.kernel.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/
>>
>> Thanks.  I guess the test_grep can be extended to catch this case,
>> where 
>>
>>     test_grep ! -e pattern1 -e pattern2 file
>>
>> does not find any hits, but only because 'file' is missing, as an
>> error, ...
>
> Wait.  The necessary check is already there, isn't it?
>
>         test_grep () {
>                 eval "last_arg=\${$#}"
>
>                 test -f "$last_arg" ||
>                 BUG "test_grep requires a file to read as the last parameter"
>
> So why don't we see it every time we run that test that inspects
> file3's contents with Michael's series merged in?  Puzzled...

Ah, of course.  Michael sidesteps this mechanism by not using
"test_grep !", with

       ! grep dirty file3 && # lint-ok: file may not exist after --quit

and if we realize that "may not exist" is actually "never exists",
then your other patch from 5 years ago would become the most
sensible fix for this line.

It may not be a bad idea to go through "# lint-ok:" introduced by
Michael's series with finer toothed comb (there are only a handful
of them) and see if there are similar "look, the file we are
grepping in never exists with correctly running Git" gotchas.

Thanks.

