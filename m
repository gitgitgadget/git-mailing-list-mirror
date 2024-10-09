Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9613D8A0
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491767; cv=none; b=r8k7SHhhFLRH+Oq7oWOlZxmzTQRqZqjEwZK26zD6Vfd3uAiDOScB8B2cGerBIuDPqeI2/pgQi7bN7z34kKaOx2r+v0fD52ag1b6NMi+IweYSo0I1tECs0OeOjBDSykMdwwYYQ5wb85qZRa6htzGnNKdC33aTOJoVV02OUpOaoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491767; c=relaxed/simple;
	bh=F1j6iySuZaA2SWXcizWQxD7Slj1BT3ptdW7yJGkY/s4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D+uw/ObG/fk2hLf/2RBlMm2KvqQ4jOD5mkV5WO5TV5bgRkXG/20cxa+A4HDx8jfJ5vRn/4f/Kxt1zEVc/O/eRv6Vtxa7uKfyXOOc33kmwJ9o4rtFX6Gdpe7q/ODEhVm5JNfHzMXb07GEp8JikkFwi3i3aQ+q2cFEvaMggl+4YhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RzcL69lU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcDAbWcC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RzcL69lU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcDAbWcC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB98A11401C4;
	Wed,  9 Oct 2024 12:35:56 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 09 Oct 2024 12:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728491756;
	 x=1728578156; bh=CmU4FSgNwpElg9m6vD1q5lit8Tlef/5ClZOudRAprA8=; b=
	RzcL69lUlWCu0twp4iY8xKu8G+xG5LcFynyUC8GHECXmnCkcYPAKcK3juOz/2Y5d
	YiJJDCjYg9E1OhfFd5VaR+0i1rtqVJtpvF20xvIp9+HfhmLj6xaxTrmG8M1r+tY9
	b+zb2my/uHQFEg3s6u2d3CAsFuiqq1nZMasymUsbrE3EKWVPlbdTYrc6YrxW7/I/
	h/xwMQxYRY4pFZby/u5U+yrtuihm0A94ituDvU8tBavZQ6aK9oWSKygB1JVlxODZ
	UzhQO4hNRPiaYFOQrjeNfcxR7/AWXF4ePzn3asIn8na7Aa1sr3WsryUCzwv2zjTK
	WihrTmWtzgXxq/xqaKz7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728491756; x=
	1728578156; bh=CmU4FSgNwpElg9m6vD1q5lit8Tlef/5ClZOudRAprA8=; b=A
	cDAbWcCeUc5R1D5sX9nRoTfNVuTBwpoCD6u3gojvpGzqssmBhQncST1L/I3ErWG4
	fl/eIO0RqB3Sduyrv9gjLr3ByeGFvJ9RWZavpa3yUgAr/fDoPlis7SJ+bIsBSffI
	KggduWxM+P/9VxP5Aot9ZYK0vTlR9FbVqBI2lwxYX1zOsSN4kh/MXJdpB3dT9nnU
	PrxaYNxoCtEndLJmfUdkfgsaAP3eycHOzEPaMo6ZiwWKpNdGjWDWneh4f0aPzftg
	3d1MZixK6RL3t8IVp5QspX7bnIgp2NSGBP4gEs0qMCs9rqmjwvbEP9f1B4znHn3A
	UHHxKo633P542AybLC5/Q==
X-ME-Sender: <xms:7LAGZ0l_cao4LtfkPhqoxvNG0tnhuhiTdSlF94gvDDsFnWivq_alGXE>
    <xme:7LAGZz3k8Hcg08tQF63gP514A0uGWdw2u609osrns1G-5mvf_23X_HTw0wMNeDdh_
    YNCLcvUGEXaOld_Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7LAGZypUPMTb38HmznffV5iRoiDUasrx6T-NFLwrJtZdX2sTdSocnw>
    <xmx:7LAGZwn-6AirCpgHHAft0YaQP2YLbi4LRV33gAaF2xtYLdqHOfHp5A>
    <xmx:7LAGZy0EAFqGwPpj87ibi4JYNICFsLrpDVu5PuINTBD7cr4pJvTpdw>
    <xmx:7LAGZ3vRJLY7LW6kVqrkHlYy_D_T8kKLiET_eR7LDQgMPpsrRWLyqA>
    <xmx:7LAGZ1SrIAXNH5uJDZMkBQMbW2ZWSDaoQKoKahAkE8WHLpK8JMr9vaBP>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B4D4780068; Wed,  9 Oct 2024 12:35:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Oct 2024 18:35:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <e339f796-bb9c-439f-a24c-0c5e79257379@app.fastmail.com>
In-Reply-To: <xmqqo73uz5qg.fsf@gitster.g>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <cover.1728413450.git.code@khaugsbakk.name>
 <b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
 <xmqqo73uz5qg.fsf@gitster.g>
Subject: Re: [PATCH v2 1/2] doc: merge-tree: provide a commit message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024, at 22:42, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>> Provide a commit message in the example command.
>>
>> The command will hang since it is waiting for a commit message on
>> stdin.  Which is usable but not straightforward enough since this is
>> example code.
>>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>
> Makes sense.
>
>> -       NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH=
2)
>> +       NEWCOMMIT=3D$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_M=
ESSAGE \
>> +           -p $BRANCH1 -p $BRANCH2)
>>         git update-ref $BRANCH1 $NEWCOMMIT
>
> The shell should know, after seeing $FILE_WITH_COMMIT_MESSAGE and
> encountering the end of line, that you haven't completed telling
> what you started telling it.  Do you need " \" at the end of the
> line?

I tried that and got an error: `-p: not found`.

> I know that it was suggested to use a file with message, and I agree
> with the suggestion, but then I wonder if we want to be more
> complete and show that a file gets prepared in the example to avoid
> making readers wonder where $FILE_WITH_COMMIT_MESSAGE comes from?
>
> E.g.,
>
>         vi message.txt
>         NEWCOMMIT=3D$(git comimt-tree $NEWTREE -F message.txt
>                     -p $BRANCH1 -p $BRANCH2)
>
> or something like that?

I=E2=80=99ll do that.

--
Kristoffer but any Christopher-variation is fine
