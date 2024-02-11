Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991E1E488
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675401; cv=none; b=QSgrAciNXS4xKvL+yJvgTmU7OVIhw5tX8JXfOglk8EiybSZn42n6eB/7EZ6ynynxc7vIg8Ro0K5rvfyqOvfxVifI+cwq2tln2vOU66KsJSmEafBvpfcuqgaQaB4e+0qhT+55cYErIeqtMBdplwlY7gowqQK+osbBS9Jx9x1ks50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675401; c=relaxed/simple;
	bh=T67fTBol4IeIUWuL2n57UmbH65FcGms09bdk4vdaUMc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pCZkCOUu5z7zC6jZXSfcwUZJf+ZTU5G8Sy/z8hjITJZDyBfYUF72Xkgd28dhU9kx8FamPjO6n+v/VapW8EZX5aKc6o+fJ4EUkS2c+MI2CfGEx6Y6r0r3Y74JfR4ffgRGKyQtQFb5IEekUkrsOOdiLaF5dRCBMibrnLhM7vxpADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ifBreNeP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vu/9H6zB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ifBreNeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vu/9H6zB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2F296114007D;
	Sun, 11 Feb 2024 13:16:37 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 11 Feb 2024 13:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707675397; x=1707761797; bh=+aauMZwAplbHETx85AUlFmy4Uo5hKY0g
	KgnAecu6NcA=; b=ifBreNeP2halhxAiP3zqn7oWGysQT4cPaeFiBwxfj4QqUjP/
	a7Xvv51ioGt1OGBOoFfN2p4q5Wl6MZBD1e6WcdCwmpgq62T4DGY5khoANTKPwTRs
	st59B7eTXDyUulyaKxHs8FTKGVQVRy022ewlaCNzZg2qLQULHM3h3zNGMqa+mfP4
	FFniEBUTOv6oOT7EZ07vzREXAb0h/ohnpQb7f0aBFjGOTuUO6siGNiCCdnl138k2
	HKJP29O6BC4eszvx9A+FcoV1ue4CZBUEyrilgMrrLrlIVtJb0t7vmQH2CT4aAqKF
	ZGtgJsjBPawHugAa+IBUAASeA5/wCC3EON48Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707675397; x=
	1707761797; bh=+aauMZwAplbHETx85AUlFmy4Uo5hKY0gKgnAecu6NcA=; b=v
	u/9H6zBhk77LlEmg6I6fudXoYt4KfpIU/PZor81mQRIT5ZPFWFV5KS6OVQz85+x/
	xxTA18OLRgIpGHOJa6u5BreEkWmwhw/GLo8TADuB3JyP1q36Ks56lbE3biPrtWAd
	cY1wN4hSA76sxDN8KBvk7KvLlZNJmh+I1UFgA3TgDKdLCwnUxQYQ/7wgYKfN3xuv
	kDPFznS7Tjb84dFU48bAtrzYamRBgQZC2t1cVzpvh2RNSiBalM9uIZyp+yltk7JD
	CNpSGuiW7Bo3xA70LEBHnB+4KmB9ON0om+UXxwBUNZKB40GVO7XZssnNmGI8o938
	CZNBNdGoID/GhALoiBA2w==
X-ME-Sender: <xms:Ag_JZbROih0LeeSwq8HbClH1Ijj0xLGknOuCZMRHgONWWdDvphORtls>
    <xme:Ag_JZcxWf8TqYGe6aOHatOSv-Q4-djPHMDkmq69Ogg_fw1VaUNEIy2LB7kmVkaVr0
    IyJiEVV1BP2PZexuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Ag_JZQ2Vo_WiT5kfIkuISNaGM4TrMPcUADnZQviQRUJBTcZ9pG_iXw>
    <xmx:Ag_JZbCQb4EdemiHEXe1a-EchjS5_kaCI_W3ETxHWykx51MX0GDheQ>
    <xmx:Ag_JZUh_ApfvwJTGyMMGMS5_CgW4l2c3uAwCNx1Nc5lDWS_Ie40POg>
    <xmx:BQ_JZdvo6aWzm-xXlNRC5SWRhrG9P534knLJIosLdOZLBusWw7XBVg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 349B315A0092; Sun, 11 Feb 2024 13:16:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c22f49a-538b-41eb-bdce-39e547c614ef@app.fastmail.com>
In-Reply-To: <xmqqfry1fm2e.fsf@gitster.g>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
 <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
 <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
 <5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
 <xmqqfry1h7ej.fsf@gitster.g>
 <d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
 <xmqqfry1fm2e.fsf@gitster.g>
Date: Sun, 11 Feb 2024 19:16:05 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though --author
 is used
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024, at 20:56, Junio C Hamano wrote:
>> I think a three-way switch looks good. With the amendment that it ste=
ers
>> you towards `user.*` instead of setting both `author.*` and
>> `committer.*`.
>>
>> Something like
>>
>> =E2=80=A2 Author is set, not committer
>>   =E2=80=A2 Message: author is set but not committer: you might want =
to set
>>     *user* instead (prints suggested config)
>>
>> I can try to make a patch later.
>
> Wait. I didn't realize this when I wrote the message you are
> responding to, but we *do* already suggest settig user.* variables.
>
> If the user chose to ignore that, then there isn't much we can do to
> help, is there?
>
> Puzzled, but I'll stop here.

Aye, good point. Maybe I misremembered and/or didn=E2=80=99t look carefu=
lly
enough at the error message back when I set `author.*` instead of
`user.*`.

Maybe the error could say (back to the multi-way switch):

```
Author identity known, but committer identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "code@khaugsbakk.name"
  git config --global user.name "Kristoffer Haugsbakk"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident name (for <>) not allowed
```

And then (see above) fill in the real information in the proposed config
commands if the other identity is known. Maybe that could be
accomplished with one more parameter to `ident_env_hint`:

```
static void ident_env_hint(enum want_ident whose_ident, char *other_iden=
t)
```

(turned out to be a bit more tricky than I thought)

But that=E2=80=99s a slightly longer error message, which (again) can ca=
use the
already-discussed glaze-over effect caused by the =E2=80=9Cwall of text=E2=
=80=9D.

--=20
Kristoffer Haugsbakk

