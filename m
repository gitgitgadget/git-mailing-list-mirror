Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C13FA5D8
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001040; cv=none; b=RLFLz4Yxlf8dQccM+FoR3EGPDYEWqbrZB1ejBWYAiYWS231EcIga7J81JGgVj9B9H7YmppZE1FeKgNDjqGaqKAkz2qejaML3dctOH0ARXcnNbYHbRbPdC6t6st7JEHPCcgRrUfwb0mQKFSpxZERhRH8r9fixs5pf7BKX3hZgk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001040; c=relaxed/simple;
	bh=v+fzTYbe2bKl7j13EWaStk5uYAZheBixPglmd38c7BE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cTV0Ij1aHOinA4cLWhH8140DARmk2MxcFr0XjEgGTL3N1xRVuHClyNj6d24K6Xmnul4jMrC3khPT5cLabpzZO2GzDSoaJY+QOphbjkWx6xcAH5eqh+0MABWIUrC/yf9zKlzV48RFgO0DyoSLyN3j9LNFiFxNVPAcTFXvM5qKBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AwsT8Vdp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VV+UMx+T; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AwsT8Vdp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VV+UMx+T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 540621D00160;
	Tue,  9 Jun 2026 06:30:37 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 06:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781001037;
	 x=1781087437; bh=GuNTkSGugQsUtjSDLf3BgGZj8rIv1nzHGEPHHPxU3cE=; b=
	AwsT8VdpQr3AKPRd5ynZFyUTrcFwmfwSPV9sYF9C+ykXG/e2Ghq40RrGgWR7epdG
	OasUf9nectN614SEGp3xF4xdJEvRxgTBY8zWjlCgNIoZt0VnzqF9CBbVYM8iLL1O
	qKzXg3QfBZ/jAJb5VtBH4FpSyrMu0DKlCHNubN7wefrHC1Bmzg1Reb7tKoCqZbWR
	okeSWz5bMAfn9bCI/LnVcq0v5dROT2DwjePh/tp1KDh2LV2MjXuicAAeIM2ncbtw
	g2Lbl/0yXnmlNUpEqmIcBeCNchw0zq0LELbVXo2X3IkKYBSjmvpJkPL6yUCZvnlH
	dRP9rR8l6DSMOT5ZS3c+vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781001037; x=
	1781087437; bh=GuNTkSGugQsUtjSDLf3BgGZj8rIv1nzHGEPHHPxU3cE=; b=V
	V+UMx+TMwZDCyJBCdEpLuFZHTLJwpX01lEDLVjSKngkHeP4ETxIDyaUew2i7BNwK
	kZyFbbHMl+veF+ByW8izWQGeqx07skf0kHZwN+COZmpCXq9zUxvNfTvdoegVwciY
	jEbZeyLURNYTVnJpYeF4Rpyl31XKfI+Q6oiagXdIBZ+I5Efz9jo1X9F4VUncmM9U
	tl0YBZYw4kd20b1UvziGjFAHw496ofm66OGN6xpo6MCDteCvvhwbise78uV78scn
	GlDkc/7+bA+w9qUmhDQDE0dtoxqukftrpobtIpMNnywX7/x/BBmjd1cdAzmZobBM
	0ocZYUq4B7liyza5m+ayQ==
X-ME-Sender: <xms:TOsnarUknSrdUQ8ftROIKqPrfrLzC1w6nOwjCUe6qDtdVuSkUI2VKpw>
    <xme:TOsnauYSTvyEjr7FNEPrApGTau3hOeP7VcXHJhLeesZ43_CseqTCG3QbhbY4FS0RJ
    ci8SIVIQTphwVEH76k_Fr-BLPG8PVc4zBfh77JkZj0qYjH1TzMJquQ>
X-ME-Proxy-Cause: dmFkZTEH0S0nAFBRrKWH5gXLg0fWDEY5/nJnLmOHV/mbThpeCmrEG+AQwTzLxQ8MS6bxD7
    8ETDeCJUe9OxyltsRiSjMLzRoHaNik523KZShLB4qrN1MZco1ynrbEuvZQpU47Ylq3Ixow
    4M6BENpi4Ncgm7Xy1q0910CFpff1FLn3usZaAeQAvemKUSmYAQHckwrXxzx5m9sratJiuF
    3fH6rAIvFdTcQzX705R9O1B4sSwAqJW8wx6GMcG6w7P45PvgW/mDxEJLDZ0ZCr3zD1/urO
    N1krpuY5cfDsn84qHQj3FZOr8jGVUFguv/MMrkBC2Qnj6Q3bhzZVddBTU27qVMAREatPii
    H9h14wyiR0re09OMHNGkFAW6I5AME1HMukx/gzPIzQ9bi4fq/sE1X1X/255A7hVBzgvvo3
    NfH5lbJazguJGde/uneg1MENxNEkelU5OZoLiCuQa2JzK4sXev2yL9xTzAZ3EgkWgRiiIY
    +BATBhT3GwWUe2tgVoCGfj/etjU9Z362QXr5s7yF+PQ00la62dBHDIg4iP4Po+0areORcx
    1SlCb5hO1KEvnhuR7Q6TqTKdzertHDufER6rp8xD4oTo6HiXCovH4Vu9fMG2P9ZGwpee8k
    O7L/oZ2fEXCPDUA80qnC8Bo2r+U/JLV7T5btk/GrbbulcdsNePnzavVK0a1g
X-ME-Proxy: <xmx:TOsnag5_sW6tzNbkmYBGdX1qaLHO8oQdl8UlCOFZGJYNioovZCNbSw>
    <xmx:TOsnajbXQmR8zU-nA1b8gTMrT1J8KK-rj9tQiHIsx_TAPuO8N5RfLQ>
    <xmx:TOsnavjirSxMhlu32rMjPSYMUrekTXsB2ALEL4MS5rPWM_aQ3OIiKQ>
    <xmx:TOsnak_NkJBwNfIJKb6x54Syhi68nCnmD2DbOTGNHzVpBUYJ3T-avQ>
    <xmx:TesnahP-dUsJCbhRlLHLpavpYO7qHnKcQLYmFso3KLjIY5pwQ0p_YITp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFA0530201A3; Tue,  9 Jun 2026 06:30:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AL2zUF52AFeF
Date: Tue, 09 Jun 2026 12:30:16 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Message-Id: <cfaa5636-f722-4217-b49e-e0354f1b80ef@app.fastmail.com>
In-Reply-To: 
 <CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
 <xmqqmrx5z0po.fsf@gitster.g>
 <CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026, at 12:14, Pablo Sabater wrote:
> El lun, 8 jun 2026 a las 14:16, Junio C Hamano (<gitster@pobox.com>) e=
scribi=C3=B3:
>>
> [snip]
>>
>> `git rebase -i` may have an excuse that because it, unlike "git
>> commit --amend", operates on multiple commits by design.  A single
>> "--force" option given to the command would not have worked as an
>> escape hatch to allow the user to tell the command "in this reword
>> of this particular commit, I ended up doing nothing, but I still
>> want an updated committer log timestamp".  Perhaps giving the
>> "--force" (or --force-rewrite") option at "rebase --continue" time
>> may work, but in any case, unless we plan to transition to these
>> "better" default behaviour at a big version boundary, speculating
>> what a "better" behaviour would have been may be fun but not very
>> productive.
>>
>>
>> [Footnote]
>>
>>  *1* Besides, doesn't "--update-refs" in "rebase -i" allow you to
>>      adjust the branches?
>>
>>  *2* But it is an established behaviour people _rely_ on, so even
>>      though it may have been better if these commands behaved
>>      differently, it probably is a bit too late to change it now.
>>
>>  *3* This includes the case where the original author is especially
>>      difficult to work with and would complain any change to their
>>      commits, even if the only change you made for them is a
>>      typofix.  Fixing a small typo/grammo may not be worth your time
>>      and unpleasant exchanges with them after touching their commit.
>
>[snip]
>
> About the --force sounds good to me. I could seek to implement it in
> this series if it's ok.

When starting without historical baggage anyway, I have doubts about the
`--force` name in general. This often just begs me to ask what it is
forcing. Why not name the thing that is being forced? Verbosity
shouldn=E2=80=99t be a problem for a =E2=80=9Cforce=E2=80=9D option. So =
`--force-rewrite` if you
are forcing new commits to be created (like already mentioned).

See git-clean(1) which has two levels of `--force`.

> The footnote 3 is indeed a good example haha, but yeah, why rewrite
> the history unnecessarily.
