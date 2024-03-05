Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD95490B
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634493; cv=none; b=kAN2dzxpPzMt6qeLV1k9AA2NwgN+gST0hpjvguEXLFPQZNHXb6Yr2QyLJ6eaLPz1TaDRfdRhXjhc4BFLeHn2v54FAr5e8YBMO4zD4defq1PT4cR5EzLYDT3yp15MWw0v9pcULcllVZ0nyNAssck4xdzu31V0W0Bs5ycnwjUxjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634493; c=relaxed/simple;
	bh=ObWMUlj1tWKsfSUsZat7cEo2pHW6Z+G+bSaF9y5gaGo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rAzvC60nWVJjW9NejnY5cBFNJBHpagjNAncbA64kWRDUxxQz6/YVrrshtuUtUze5eZtB0785tdKXIsT+VvONTqMCvgZHtnN5+KOohkc5RIbuk8IqPkn0TuGRpjbLXkEDdJzQUbJ79BCMIwEobQ6AvD2lZFKT7Qw/wfqEvS4IV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=x0ElH+Mm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5Lp3p4k; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="x0ElH+Mm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5Lp3p4k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 7EB9E1C000B9;
	Tue,  5 Mar 2024 05:28:10 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 05:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709634490; x=1709720890; bh=hcWtuc13RwOu0pqax5bGzLl1Ww64HkvV
	OKwB0eSP5bI=; b=x0ElH+Mm+W/kG0X5PQfsEK0QTJHhZCrusm7pvDWn99lMeTag
	gkETprhMmEsJfMqwJmgk2Ip4iGHe+6QoR5mXVkcf1h5pC2xCx7g108W2SumSVXTT
	vlluH0LW/A2wmfqJQSq5lIMYdvX9k99eVJZzrOqPG+vlfkGqOiddQ0LvqhzEZXP6
	y3zIu/ZimTKlUJMBCUUUOk73Dc2rwnTFGnyylyZpTAgcxfl+U/rXKfYxi5m4ubjk
	ECZWoUej9EOIuSjyVhbwsft6IEcDmjbGb1kpqjHQl/KG86yNX1Br80HRnr8aLd9s
	GzMoVba3o11zKjq5tzAyH40vC+EfAyBBU28m4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709634490; x=
	1709720890; bh=hcWtuc13RwOu0pqax5bGzLl1Ww64HkvVOKwB0eSP5bI=; b=O
	5Lp3p4kxDo7PyA18vGRLp6OdXwLVt6RNjNC05FqcADKyk9pFiNcYzNlvbL6QkJZO
	W7wqphM/pG5Jbvoe5RxE0oRQ68RcX6gSmxweLLxM7vVMY9hwgrvv/GQNJNm+rBCF
	a2nxQasMJLJyDc4O5Gc+lCalQKgA4ynQI15zXHHJ6SvIGg70mescgltGro8AFr7y
	g+pzzVe+CTWWp6Cw535X4rXaBEiqQxQKdzHBGdIeQnV8rsSVuhO33dbOoXx1DJ8h
	+/l+ufxVs0PJdnqMn659bPhkEAxpUr0af1Nw8OuDItNeRLNUnKtoEFP2pnpg5z1t
	e6SIGLYeiIpPdUC9k8h8Q==
X-ME-Sender: <xms:ufPmZaDaCb0NuYXEQzssqmnOomSuRzwjoqn4H-Tr5mpQY2BXrEMI1mk>
    <xme:ufPmZUjyE-vHnRT-F26khe8RKR7r0wIx51hGMvBQVp3l9iNhntPvB1Ss6yjMTixbD
    028xCOGmhmHgsUjHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ufPmZdkw68QPWpce0Jc9UfEXtGlg3gjKTN2gF9MqCe8QZHa4a6lF3Q>
    <xmx:ufPmZYwu9qDNvM1kgzf2zFaucNECin0CrTZh92N0K-rwhvttbETktg>
    <xmx:ufPmZfRd90PFcLSEE35xh-RwrZMIK2kiVhWN6bETk0XeiFmVGGl1Vw>
    <xmx:uvPmZWL_N3Df8PmZK9xjFBZu8jiFTYMvygtMAKRdhnChCFtSiyCqAZy-iw0>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C4D7115A0093; Tue,  5 Mar 2024 05:28:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <166d2baa-933c-44f8-b6fb-94c8bce63a86@app.fastmail.com>
In-Reply-To: <xmqqplw9lbav.fsf@gitster.g>
References: 
 <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
 <cover.1709590037.git.code@khaugsbakk.name>
 <e6a2628ce57668aa17101e73edaead0ef34d8a8c.1709590037.git.code@khaugsbakk.name>
 <xmqqplw9lbav.fsf@gitster.g>
Date: Tue, 05 Mar 2024 11:27:48 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] t3200: improve test style
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 02:25, Junio C Hamano wrote:
> Especially the change to use "-\EOF" to make them align better
> caused too many tests to be touched, but overall the result may have
> become much easier to follow.  Good job.

I reckon that this can be worth doing now as long as no other topics in
`next` or `seen` happen to touch the same code. What do you think? I can
evict hunks if they happen to overlap with other in-flight topics.

>> -mv .git/config .git/config-saved
>> -
>>  test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without =
config should succeed' '
>> +	test_when_finished mv .git/config-saved .git/config &&
>> +	mv .git/config .git/config-saved &&
>>  	git branch -m q q2 &&
>>  	git branch -m q2 q
>>  '
>>
>> -mv .git/config-saved .git/config
>
> The above is a truly valuable clean-up.
>
> But I am not really sure if the paritcular condition is worth
> testing in the first place these days.  No configuration file means
> we cannot even read the repository format version, and working under
> such a condition is quite a bad promise that we would rather not to
> having to keep.  But that is an entirely different topic from what
> this patch is doing.

Okay. I could undo this change and remove the test in its own commit?

>
>> -git config branch.s/s.dummy Hello
>> -
>> -test_expect_success 'git branch -m s/s s should work when s/t is del=
eted' '
>> +test_expect_success '(setup) git branch -m s/s s should work when s/=
t is deleted' '
>> +	git config branch.s/s.dummy Hello &&
>>  	git branch --create-reflog s/s &&
>>  	git reflog exists refs/heads/s/s &&
>>  	git branch --create-reflog s/t &&
>
> I do not know if the change of the title is warranted.  It is doing
> its own test, not just setup.  It may be merely donw for the side
> effect of making the step unskippable, but still ....

Sure, I=E2=80=99ll remove `(setup)`. The test name suggests that the test
depends on the previous one in any case.
