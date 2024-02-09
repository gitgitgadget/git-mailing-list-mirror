Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FB4176F
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467859; cv=none; b=IbReQTxx5c/M2Ui+HFIXJgvTZvianQXE7mSit7Y4l1bD4bQe/eEpmu75NDqyoJrnvMYz76bm5dZ3V8wdPkVZFc8FFjX4oTp5giNc6yIQ6QZ3GigIpCaDlmvclZNgL7ASI8K/5uGm+H9TsAP32Gg2V0vSHhYU/4AvrDgydFBfqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467859; c=relaxed/simple;
	bh=uGyscL8GC41K0R9xSYSQmuwh4s0E4HSzPRsUVAJQtis=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e8scos2k7qyUx1eporhRznIW5ksFx91ieC7cNLvpBCKP84bv4J58vc/S24lPtOofgdxJweQ024uzr+0qWxpNmSrS3BMIiA+BzY7mxfZ3S+qAvHYJP6vvrEwYDdybm774OzvBJanahLXCR++03Hin6LBLHOekUiLK6ARwMj4qt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=faFZOovK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XET+ksfo; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="faFZOovK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XET+ksfo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 70F993200AC6;
	Fri,  9 Feb 2024 03:37:35 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 03:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707467854; x=1707554254; bh=F3HuO40TItAGiRoBuUzmooQ4JcHnp4PF
	AvuRORM/GtY=; b=faFZOovKzK6JBtzmXM17IKpF5H38Nfhwmb+zhjsiPfpoOQuH
	IqS3pTQ7Xh5LHCXyXRkf5NuhQ7yX+FaY8iBnQbX8o5QoYDOe23Rs/WAOpCVaMQGS
	99yX+ShKzV9MvM0tNYlfVyqNRY00kKOUTRIMoxOQDBe1Tjh4GPsY/vi30ZysaF91
	asG6BuchLPCcsYvzT36HHAVtxtvKBOOWYeFrhljPjdw4RzpYdVKchgG9bBt6jfyO
	l0p8U8c3ONfCfc9F7KytYTlnYidD5qsCyDlEmpihoDQ9Qh5rQTJYbFv3UXfF9xEK
	GRuEHD4ELb19+67HbGD1ZWDFgbyjZbBFp3XQ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707467854; x=
	1707554254; bh=F3HuO40TItAGiRoBuUzmooQ4JcHnp4PFAvuRORM/GtY=; b=X
	ET+ksfoC7OEKWg02wj00EGaENtmQU9EIVkLLhuwMh/RQEg90tTT5uXzkLRNP4+Jh
	QhEhZp2FgiLJxJZ0VUb0nwJ+JZ8PKPK9hNKIA6iMJ2y0+PbxPJasxigb1VoBPI3P
	Ud2bXj/jJ3Q6rpG/y7uBgAk5r53RXekuZR9P0qMhWvTYXhvkgPZLPf9kH8QJFm+5
	waZv4ZozpKrOQ/BdF+YfRPrfSWHedCqZ31c2CXpFFwPKtR4yJmEf+fJJJxK8QBNJ
	7LrSc/gNsvOBpC9+XtEHy3ir89XjiNNs3PG23GmYcwIlW0ug71RVRViJIIiXt6DJ
	KuEXi/ohTrN/RsVuzD+Yg==
X-ME-Sender: <xms:TuTFZesbTTFkM7TEVY1fZQNFUc5DR2k87PJw5dFy0AeEMpV0vl5kkEg>
    <xme:TuTFZTchhBNC-fidKf8bY1l408kRizIab8pMgtq0gPsJ3GVAekmLZQTCqSZOOKjSa
    uDNmIcACBXM-MA62w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:TuTFZZzmLU1_JebXvXVnTAF83B-5UiEA7I48w-V5_SlmD1CuNlQEfg>
    <xmx:TuTFZZPEbj4o8eg7NyBiTdqId-aGcaopfm4MjXDBRnXjwR8e_42xQw>
    <xmx:TuTFZe-IjQf--6dBO7lrUDjJmXkCT2V_do2hv6tbrlu_Is6tPxXjFQ>
    <xmx:TuTFZUmv9KlZNuJbA1ESZErPEV6vLih4_QcPnj5N4rxfjG-WfhUnEw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2711B15A0092; Fri,  9 Feb 2024 03:37:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
In-Reply-To: <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
Date: Fri, 09 Feb 2024 09:37:12 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though --author
 is used
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024, at 08:43, Marcus Tillmanns wrote:
> Uff, that=E2=80=99s a mean trap. Especially since there is no =E2=80=9C=
=E2=80=94committer=E2=80=9D
> option as far as I can see.

Your report would have been more clear if you included the error:

```
$ git commit -m "Test" --author "My Name <my@email.com>"
Committer identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got '<machine>')
```

I guess there is no `--committer` since there are use-cases for
attributing the commit to someone else (like you just received a
patch or diff from someone) but there isn=E2=80=99t really a common use-=
case for
attributing the committer to someone else=E2=80=94the point of the =E2=80=
=9Ccommitter=E2=80=9D
is to identify who did the commit itself.

And the error tells you about something that you would want to do in any
case. Because passing in the committer with

```
GIT_COMMITTER_NAME
GIT_COMMITTER_EMAIL
```

every time is a lot of work.

I guess the most common workflow is to configure your user globally. But
it=E2=80=99s often the case that you might have a work identity (like the
email). What I do is to try to remember to configure it locally in those
repositories as well. But in the most recent case I forgot about it and
had to rewrite the commits. :) So an alternative is to not set any
global user. And then you will get this complaint every time you start
work in a new repository:

```
Committer identity unknown

*** Please tell me who you are.
```

And then you can copy=E2=80=93paste one of your identities into the local
config. And be certain that you won=E2=80=99t make any commits with the =
wrong
identity.

That=E2=80=99s more work but also safer.

So I guess that =E2=80=9CPlease tell me who you are=E2=80=9D might be a =
part of some
peoples=E2=80=99 usual repository setup workflow.

--=20
Kristoffer Haugsbakk
