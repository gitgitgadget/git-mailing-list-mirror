Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5F1EF0B9
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765548560; cv=none; b=jRZHRvNY38pJjSMJIVNHsyVMXkIxYDJqJ1Jm5g4QkWkY6ubg0B9jDKm65JUVLRl+vIpEJqEr54xGfeq///8FLjhgjyfQuFT0R9jKJQ5vVZ9UVKEP3mdvh1I62zosgcWbFkplKqixHqP2Lf5hI9Ac3iBNr5KOZ8ccJiX2ayNxr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765548560; c=relaxed/simple;
	bh=9/BwugOuEIhIF1JerAuuB8Pt+mm1aF9ocXWAqa9mUQ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FWVsT1p/KcbeTqaMA2GRkEDwxYxAvkfKi0nP4p8y7Ub/xYLmGM6KYQC56/OSsWOU2fTHz9NA3vD3Ry1d1w+YfW8yVC6tni8zjT52Gb+lCJIVF1va54xucJARdHYB5NE3NDtVAFCQZc4HxT8v6KxcBsKy053kW9Iyf54s71rv5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VY0dgUeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrAGALFv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VY0dgUeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrAGALFv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D71081D00141;
	Fri, 12 Dec 2025 09:09:16 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 12 Dec 2025 09:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765548556;
	 x=1765634956; bh=REhHhpwI5CpdGOJGl+LwydlJbIQAJL5I9/o+mWgN4Fc=; b=
	VY0dgUeJNrZRSJnSstW6oqeqRLBm9kvQ7TTdIUtznIzfGY5sPL7kl4M6Eu9TgZcN
	RFmPZd5Npbl9NWC53VOK3sY3xBSH15K2otFZLFOHty+ZgkwczduZZRaopZyB1J94
	yfBTpuaobBYAjIDfqqecvx3ngs+AWuSE1U+/a6dc1P2EAf14xJxUlGjdSjD3lvYJ
	yy5SFJCzTINots44e9HNIX6jDbKKD8TDwFQwG0GJ6+m59GY3006QBZgQ2k3yiCUz
	AQWVShAI1y90ts7t3EUafyDpH1tpLXf7nIsQmpYgbRzQjJ1MezW9RZRtMh7Rd9ow
	GGOuB9/MrjxJ86zQz0qMVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765548556; x=
	1765634956; bh=REhHhpwI5CpdGOJGl+LwydlJbIQAJL5I9/o+mWgN4Fc=; b=r
	rAGALFvLmlZo9i/lZsrUsMuCZJmvC/rttpxQie7BkLO1ffSEDP+B6Uc2csfKIF2n
	Sde+D8ek+g+DDVKrUO2JLBoakzTryV/UVBWFnQc9a/Ry3S/NmgpGsmYLxn9Dlcye
	0FfHPxszY3Mhel6DExmo2VyEMn8rSqkewVpoyrICH3EskEM7UxQgYASpF1i1ADuE
	PTuIg676CIuF2B7f7VOkJ7iZWgfdfWC+3ape3ozKGl2GCxnzRApxnVX5EyxQj9jr
	I17Gu3gQR5uNliqPKEf7jSm03bDPjZIVXRs/A04UooRQvkGEpCmiHstS43K23pm8
	hUJMM3dgaj/M9IF2t8DfQ==
X-ME-Sender: <xms:DCI8aRfDpphRqxJTEW_BbPyUfAc5aGTgUfAPUjrqPD0YsDeOkPtVi9U>
    <xme:DCI8aaCOCnmCTfsKenwNI9eybja5j3ZhcpIKqCLaFHOFvjtgYQqXs1_6idIu8pLCS
    eluUXxSLjCprZoDQCNJbyxEAA7spwdQ2rCTUInzmS9Ay_bv-H-pWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrg
    ihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DCI8aXaFrCHVSByM01hWWoOuf-zjXuSs77ONO9i3YShcc-eFNcE7gw>
    <xmx:DCI8aeJa75u7UyvpttPfUpMRc5SgRnkACGzjC2BL8zg6C-bESG7RCQ>
    <xmx:DCI8adA5Sp8ATs_dJlz-d5Q5sA7ZpvDXfkFur-olsWL_Q-9Er20viQ>
    <xmx:DCI8abr-3DhYf9iH5cQKr6tsQJAWmS5Hy38QCvcaRoCgI2oFHA8alA>
    <xmx:DCI8aUXL-eYq9wdOuqKBhAeIUdQQqCoADjXZNgYkoq7IZ-6slZNsSuwD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 942CA1EA0066; Fri, 12 Dec 2025 09:09:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlEAuNDsVKz3
Date: Fri, 12 Dec 2025 15:08:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "JAYATHEERTH K" <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <52483794-bdba-44b8-9222-761184ecea95@app.fastmail.com>
In-Reply-To: <xmqqikeccnhx.fsf@gitster.g>
References: <20251212020930.11654-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqikeccnhx.fsf@gitster.g>
Subject: Re: [PATCH] Make pull.c match the structural conventions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025, at 05:50, Junio C Hamano wrote:
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
>> The builtin sources follow a predictable structure, and pull.c departs
>> from that pattern by arranging its option table in a way that disrupts
>> the expected flow of the file. The irregular placement makes the file
>> harder to read, breaks the visual rhythm shared by other builtins, and
>> forces readers to jump around to understand how options are handled.
>> The lack of consistency makes pull.c feel like an outlier rather than
>> a peer alongside the other commands.
>>
>> A consistent layout helps readers rely on established mental models,
>> so bringing pull.c into alignment improves clarity and makes the file
>> easier to navigate and maintain.
>>
>> Pull.c, become structured like the other builtin/*.c files, keeping t=
he
>> option definitions where the reader naturally expects them and restor=
ing
>> the uniformity of the builtin command layout.
>
>
> The above is, what should we say, overhyped?  I do not know an
> appropriate phrase, but there are subjective judgements without
> backing it up with exactly which pattern the code "departs from".
>
> In other words, too many adjectives, so little substance.

I=E2=80=99ve seen some commit messages in the last few months that have =
too many
adjectives. I=E2=80=99ve never seen that style before.

>
> I expected something a lot more than a simple change that can be
> summarized a lot more concisely, like
>
>     Unless there are good reasons, it is customary to have the
>     options[] array given to parseopt API in the function scope,
>     not in the file scope.
>
>     Make builtin/pull.c:cmd_pull() to follow that convention.
>
> or something.
