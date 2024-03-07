Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E113B7A2
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847067; cv=none; b=SDrLAql+5I023ox01t2w1wVjsef6Da4j3ZhNKYABsXm/KjKVX7g30Oo93XqiLyEy0YLntX9BM/bGhSx/T9wrMP4GD4KP9QmljFk74bOuGlhqARbi1xTSvwvNVaGUhZ51ioh7k9j7/qudokh/W2uCoqUtzj18qjzyEIZIB8YSbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847067; c=relaxed/simple;
	bh=4mxs0RhoGCG4YDerQv9sFy+e9cGT4maDamaIVfkZA0w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Y6+tr2TJgMzVBmlGx+Fhb7wOaeUxRNLi9rPBgL7kpWy0qGJG6gLgSgxLwYw0vyd3GWqirj1Wftu71rhZt6pNadmvs0IUW7KrDJMuGb8iHWOM7cSprH8s8LgeLaJtp2jss2vxmibnpf5daAOLuNRoWemxc/rY1w+sKnQMGUdWW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=BpSDVTfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdFjWlwl; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="BpSDVTfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdFjWlwl"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 87F705C0060;
	Thu,  7 Mar 2024 16:31:04 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 16:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709847064; x=1709933464; bh=TnVZrJ+4k/YBZP/Z/J5iKFJElelQbu5W
	nmG3QUJo7T4=; b=BpSDVTfhMCmt4euAMlB5AC/XcmWqwF9I0XjiDEuNsOooLY9n
	X0cFU6pH09kZfY7cEkWX7RyIQE3+3H+RoMqs5NFTBQ0GuDUNxsTzzrIyB5Vm/AoF
	qHVM/3xswjB4mKUafwPLTY3g1PhqEn77kS2ZxejEC4znKlcoCCPWz0NWnOshPpQZ
	dIt3Bomd/FuvbwExUVtOt13RXmfnZctU6SRGbUJkwOJ9fsNVoZjlnzelyuVbEclQ
	wAw/RK40KqFuIZWihoJy3eS/ky170v/tz2fnPUnLkjV/NepTw3GLKucg2Ixy3oxo
	YNU9iSHXoCajbk3r8gtNvhr44cZjjgXb/GMKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709847064; x=
	1709933464; bh=TnVZrJ+4k/YBZP/Z/J5iKFJElelQbu5WnmG3QUJo7T4=; b=q
	dFjWlwlpMIsgc6uSNS/z7Y82cc6ZAQJZCvfDlwqRPY25ipmF7Q6ikreAE9tIF0Th
	iwVmWzVb8CEsokJAqfux8FZSvijwtoItFrnD7s0yvitTIKqc3XaQdax4QpJJJak9
	ZpA4asdER54yYrDhPUHyC7qih/rvXBe+sy7tFnkfgEvXhbG5/EWLyPxpg5hJdGlE
	Wc+UKeYXxtVDCzCn6NM9aPaadk+cvienWc1cNrb6YHgFFgPZ62OVzNXfrSEGMUPC
	lTTaya1JN+RzJTiWO43CmCqvwxJO4QkxBwmdrtZc3rLGq++sA1IHf7GOSBHDAegv
	sYGzUHuBvmCFxSuIoXE0w==
X-ME-Sender: <xms:FzLqZSNrMP1lZEQ8TRusIOOX7mEBVdB5Pr2czSRLxGURWJJba06VB2w>
    <xme:FzLqZQ8sGbQ5VxV-oVWpNg0F8VWHzXkjE2onPs5qSyZV9-zzRDOCUjZBWgiq2SIvg
    c0JmnMwdk08xadUKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FzLqZZSUgeO6Vzts2TJV3acLR7vIZdKpzjyhWbuo6hUronV_1-H1ZA>
    <xmx:FzLqZSun_N5tiw5c_aW0sHz4JLqOxV5ZlU5dydRYQMssqGZByiAPAA>
    <xmx:FzLqZaeTq5ExBi8t8uwYaikKCird2kUQ7L7fFIfUsxxO5q_gPf-Luw>
    <xmx:GDLqZSTfagG2OQsYzK6ToPlk3KrDXYiKi09nMVPwnZd40PdH1opNXQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C206715A0092; Thu,  7 Mar 2024 16:31:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6acdc464-825e-48bd-a2d6-97671b58f879@app.fastmail.com>
In-Reply-To: 
 <CAPig+cRNa22A=fEmc__JvEjYiVF-QG8o7w0gukhbeL3e-PwVkA@mail.gmail.com>
References: <20240307183743.219951-1-flosch@nutanix.com>
 <xmqq34t1n91w.fsf@gitster.g> <xmqq7cidlqg5.fsf@gitster.g>
 <f8de2b3a-9e12-49fe-a7d9-481317f10c4d@app.fastmail.com>
 <xmqqo7bpka6e.fsf@gitster.g>
 <CAPig+cRNa22A=fEmc__JvEjYiVF-QG8o7w0gukhbeL3e-PwVkA@mail.gmail.com>
Date: Thu, 07 Mar 2024 22:30:33 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, "Jonathan Davies" <jonathan.davies@nutanix.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Denton Liu" <liu.denton@gmail.com>, "Linus Arver" <linusa@google.com>,
 "Florian Schmidt" <flosch@nutanix.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>> > On Thu, Mar 7, 2024, at 21:47, Junio C Hamano wrote:
>> >> [jc: tweaked the commit log message and the implementation a bit]
>> >
>> > Just a question. Given the imperative mood principle/rule, why are =
these
>> > bracket changelog lines always written in the past tense?
>>
>> These are not giving orders to the code to become like so.  The
>> trailer block records what happend to the patch in chronological
>> order---think of those written there at one level higher level,
>> "meta" comments.

And when I think about it the trailers themselves are of course in the
past tense=E2=80=A6

Thanks guys

On Thu, Mar 7, 2024, at 22:26, Eric Sunshine wrote:
>
> Also, they are not always written in past tense[*].
>
> [*]:
> https://lore.kernel.org/git/20240112171910.11131-1-ericsunshine@charte=
r.net/

--=20
Kristoffer Haugsbakk
