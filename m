Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462246B8
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467852; cv=none; b=nsMuqws+q3tNDlODT7p6QL9D873yT16lsrYiojkkZEEObbDvuOvKNjNa1pwWGO0jDRHZ1nXIlpbVOXqeABEVHCHS5J1Jc0z1Pz79T87mvy87vLHdoNfA2xuNMHVBSgG0ef/fnMIS6KpXNYKhhN8FFW6wQu1xrIH04m8vNkHNgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467852; c=relaxed/simple;
	bh=zyiDtsIuDCB4VYtbLt4AxYn5TkMdqLK1icb2kEyGHos=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O0XiYuScjAo/zRbb7MSlBh6rH+KEHM4lqTWJ/NeiPtkItViTO7IQxp2baJJFe6q/r0eXakj62LEZzUReOfeTHT5geRuTwFXi9C2tHAcaO7h/Vo3Jpi7kJ6xTGbRZ6O/Eu/1KGrl0acoFBF5u/AFrcGsdb9HL1x1J0aQzE0F+bvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BiNVEYsH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHJDqxS5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BiNVEYsH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHJDqxS5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33E921140141;
	Fri, 27 Sep 2024 16:10:49 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 27 Sep 2024 16:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727467849;
	 x=1727554249; bh=+8HkQKDavPS7q4vFqFyo2fI6TLJqz/5yS4F5YYeu140=; b=
	BiNVEYsHi6t9treXvcRI10w7sKwfqCX6EiGCfmtlL7MjrVPiVbItBHuQyJXnTjgx
	ODirNy9nqldDYuT9rw7SQYgmAFZrAf7+4UwVHVO0JJPejf11YkFOK17BkOsgz9U0
	OjQe8Zg0sKq/NbeYnXZREDyCiwy+wcol+1OHtfn+wIU7nQzqVQc548fzbTzfrvnm
	MqDSm41mXGv+0tDttW+RfUb416aN/eQmkHu0tGtrC/yMhsCaK1ghoaGERruHp+3b
	+2+RZZA0Vaqug6IBH3Tap8E0GS576C8wa2XkuBQdcquYMqOBWK7eghGUjp3r8qkS
	X3oU7SLJiZeiOF+CKhgmUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727467849; x=
	1727554249; bh=+8HkQKDavPS7q4vFqFyo2fI6TLJqz/5yS4F5YYeu140=; b=M
	HJDqxS5QcPUwiKrMLJg3PDnmOOj7gjn9QM1zJSLAJ8e/CeupX3T7f+OiOAP04w/m
	hvVfFRURnpOTnHQmzzmDhpS4Nk6sNTk8rUBv3D4VAv4+P0XkTrVgG8Q/VV/94sr5
	58JrgaB6nXpIOlWBMRmAWGiW4Kc6sEYjCj8m6xBTkKkiP45cPM4uCtvksWqMv6EF
	G1qgjMXS1XNla67cZ6PI9ODCe0tt8IJqIVKJFaH3kypGtpKOeH1VpMK5/2caDGIH
	rQxppF0yrb5Jv3UlH6m5zviq49TcM2nZQ4+zLhwR24SthOXDwVSZEjgmHLAvktFJ
	W1zPkei2SUJIdtholqKig==
X-ME-Sender: <xms:SBH3ZhXONIP-MkxOwJfCYmCrdENfBeTPbu3NUT_sMi9fWjD4i9zQRpw>
    <xme:SBH3Zhm59MdUd3sy59s0Lq_sKCtDM2yFV6bBhgZvxZHu1WEMaAZx2RCtMNI8nfiEz
    6beGiyOW5X_mwAeNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SBH3Ztad60l5cDPabwFZ_Zs1rDh9zj4QqYrc88CpKjSMNndXuW2shQ>
    <xmx:SBH3ZkXkS4MXZQ_1_VdnTKaEEEaOAASjzyFFkFf5Vhilz2U17yOAsw>
    <xmx:SBH3ZrnzRZjcWEhXgIWpyzkqGcsqQHmh3au9wsIJdUzhitfA0_ucHA>
    <xmx:SBH3ZheYM0xctnG_3wLvzV4-KTTfQpwl5pdd2gwr8vYNkjqqNxEbTw>
    <xmx:SRH3ZphJGAigLvcS8gDfVebdgrklc4buE_qrlnCeRomdm5WavJ29hkrF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9ED7C780068; Fri, 27 Sep 2024 16:10:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 22:10:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Message-Id: <555169c4-beea-40cf-a542-f8a75bcb44e8@app.fastmail.com>
In-Reply-To: <ZvcHpd26te8TPacz@tapette.crustytoothpaste.net>
References: <20240927085438.1010431-1-toon@iotcl.com>
 <xmqqikuggaz5.fsf@gitster.g> <ZvcHpd26te8TPacz@tapette.crustytoothpaste.net>
Subject: Re: [PATCH] builtin/clone: teach git-clone(1) the --ref= argument
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024, at 21:29, brian m. carlson wrote:
> On 2024-09-27 at 19:20:14, Junio C Hamano wrote:
>> Toon Claes <toon@iotcl.com> writes:
>>
>> > It's pretty similar to --branch and
>> > while --branch takes a branch name or tag name, it doesn't take a f=
ully
>> > qualified reference. This allows the user to clone a reference that
>> > doesn't start with refs/heads or refs/tags. This can be useful when=
 the
>> > server uses custom references.
>>
>> "when the server uses custom references" is a rather weak
>> explanation.
>>
>> The answer to "Doctor, it hurts when I turn my elbow in this
>> unnatural direction" is usually "Well, do not do it then".  The
>> answer to "Doctor, I cannot use the --branch option because I use
>> non branches to keep track of some histories" should be the same.
>> Why do you want to turn your elbow in an unnatural angle in the
>> first place?
>
> I can't speak for what Toon intended here, but GitHub uses some
> references under `refs/pull` that are used for tracking pull requests.
> We even have some in the Git repository on GitHub:
>
>   % git ls-remote upstream refs/pull/* | head -n 5
>   f0d0fd3a5985d5e588da1e1d11c85fba0ae132f8        refs/pull/10/head
>   c8198f6c2c9fc529b25988dfaf5865bae5320cb5        refs/pull/10/merge
>   d604669e32e847c2ba5010c89895dd707ba45f55        refs/pull/100/head
>   55ab0c9399879683b4cc6e1baea5dc41484ca52f        refs/pull/100/merge
>   08d39e0bb5b9dbd16e9e4c2250e75848718c453b        refs/pull/1000/head
>
> These are not kept under `refs/heads` because `refs/heads` belongs to
> the user, but it is generally useful to check them out in case of very
> large changes or changes with complex binary files which don't render
> well in the web interface (among other reasons) that might need to be
> inspected for code review.  So I think this is a generally useful
> feature, although I agree that perhaps the commit message might explain
> the benefits in a more concrete way for those who don't already
> understand the utility of the feature (such as our illustrious
> maintainer).

I=E2=80=99ve seen a few times that a change is proposed with a commit me=
ssage
that says that it allows you to do X. And plenty of motivation is
provided in a narrow (technical) sense of how X makes things nicer.
But without explaining why you=E2=80=99d want to do X. Then someone need=
s to
ask the the submitter why. Then they say that they need it at
<organization> to do something specific.

It=E2=80=99s certainly nice to have all that information in the commit m=
essage.

--=20
Kristoffer Haugsbakk

