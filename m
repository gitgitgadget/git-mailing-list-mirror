Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D33E491
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993896; cv=none; b=dtYUkC97snw6zY9IviakjHWH8cSEtBr7Fakr3bEprbQ6mIL8Iqp5GUiduTUQJNOyACGlzDs+pK0V7bpYKXqSR0qFYFD64/xTQ13HedHLsOSk1BuGzdEUUp4kim1E4lggPZPUSQ5bCmpk/sS6P8wbpQ5vltE2WJIrJEFS3Zwcnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993896; c=relaxed/simple;
	bh=ef3rJFqnZeabqgPkZ0znJ/VBitb1PbWatzowhX8Nilk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZfWeIpst0AtuvfDiQQli/ZM0rFezuXU+BnXdhV3iIjHe3OfajXZKMG/iTjM85rCCp14+1zhiIXsR8p0DH+c4tJa5xz9TUEG9i4/qriJsL6sqxHbVJPyoueUK/UILsoRHC8Q3+k8tV2Q9UGK0RFUHvI7r6jRAoWbRjlL27BLIY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mjWYov7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=humBFZ5u; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mjWYov7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="humBFZ5u"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1F0BE3200A74;
	Tue, 23 Jan 2024 02:11:33 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 23 Jan 2024 02:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705993892; x=1706080292; bh=ef3rJFqnZeabqgPkZ0znJ/VBitb1PbWa
	tzowhX8Nilk=; b=mjWYov7hPYHsK0MvXX8iNGA0CZSOXM3ijTLtyNUd6i21gNl/
	4rkU1De1c+CjtvQ2w1S754jKbfKJLKOCf3gZGNjNArjNzEjAFwwhZgWTUbkgyina
	R08/alyBcIFBcsUWYwGH1Kz2fo0q7m8baEzCqa3w0AtocJ81VO/QuO2z0QouhGp6
	64IsZJ5VKdEgSzcnJ0dDEMXF8cxqRooE1mof0kxbZjK4aQ1FyxhBqNMeMf+wj9en
	1V/v7355GwIYPGs5bKkNmk/zcJGJrimOrLPiZyR2Bd6/KYMykur3LXJNMe1LaC43
	rq6N1/8sIQ4E+/I8LLZcCtlJl+Vuo5CWFR03xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705993892; x=
	1706080292; bh=ef3rJFqnZeabqgPkZ0znJ/VBitb1PbWatzowhX8Nilk=; b=h
	umBFZ5uVhgEpTNAB6MUj9jcjiD13mV5q3j1OzDHP0KrMWb0Q/xNAT8g6GNsxqCoc
	cs2GGfbrw2l5PoKlK2ud6d66jyCWGrTOnvJAbLAIyWZJ7fStkh9ltnvnyYGDPCCC
	Cmo1q+egiLWwu0j4UxNpfjLaXQ7zxTInOFfqanD/+rygXBwNIrlIHC0tUpcEykC1
	MD7EIIhd5YTZ1pxqJfT/oW5f+sF0B8TU5Umf3xezWZsdmCp0cf0S6JrhoeBDTEpw
	yG87DX7147la1DhoM7qrswTskF0px2hnOswL1xHuq5Ii7Um4FdXSnQzdJhkuTgfB
	lan2yMJzHafrAES9anE9g==
X-ME-Sender: <xms:pGavZVe8wHv-UfFZ0wzO_B4d2tF38VDzu0d9eHO4sIOHuxcc8WptmzI>
    <xme:pGavZTN3cDSChZsF8N4NF2IU4KCMMXO9tG37GPqyCjfpXiC0MQ0WfEiejQDaA6KJr
    mIKo92xbXgQUqBYTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdekudevtdfhleeuveehffehvdev
    ieeuieehheduheevgeeuteetuddutdefleeunecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:pGavZejqXnORWGh0Tz6Yimx52suDtyD66p8VmaBDOMOIgw2lU6w77g>
    <xmx:pGavZe_gOWlGtEZDCMP204hUKf1hX7tOXTTqWz3SjKxB2IJj2XsiHw>
    <xmx:pGavZRtEU6ga5nnPre4VTb0NF-J_VE1wLxvXkGM9f0BtXJ_p31BJhg>
    <xmx:pGavZSV7DJILCr_Iu2IeQPeCMz1_qx2W6ztUzIFMV1UI4XvlmKKA6w>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3EE4F15A0092; Tue, 23 Jan 2024 02:11:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6475ad33-423e-43ef-aa75-3ff5539a04d1@app.fastmail.com>
In-Reply-To: 
 <CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
 <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
 <10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
 <CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
Date: Tue, 23 Jan 2024 08:11:12 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: brianmlyles <brianmlyles@gmail.com>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant commit
 handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024, at 06:23, Brian Lyles wrote:
>> Oh, and this thread reminded me https://lore.kernel.org/git/xmqqle8hr=
tcs.fsf@gitster.g/T/#t
>>
>> that editorconfig[1] has this option:
>>
>> ```
>> trim_trailing_whitespace =3D true
>> ```
>> [=E2=80=A6]
>
> Is there a good reason that this should not just be added to the
> `.editorconfig` in this repository? Would a patch for this be welcome?

I was thinking the same thing when I saw that other thread. It doesn=E2=80=
=99t
hurt to try.

I was also curious about some subtleties like: does it dictate enforcing
this for all the lines of a touched files or only the modified ones?
Because the latter is much more useful.

--=20
Kristoffer Haugsbakk
