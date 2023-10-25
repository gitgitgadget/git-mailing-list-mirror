Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B010FB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Tr4Wq0Ly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdSrjh4d"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA012133
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:04:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0FFBF5C0398;
	Wed, 25 Oct 2023 15:04:25 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 15:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1698260665; x=1698347065; bh=kPGLJUzDyKAN9Z4RqxrFEIh9w
	/WhBXwe0UiuCeNBFW0=; b=Tr4Wq0LyOdqkd77pl1J0w1qah5rNWOaHA8o0KIhPa
	HdNJyF7Czqxnf0Vs0S53DLtSbarbhUFd1aodRNq69CG3nefkaIvLbC56sV9oH04M
	3yOWs0niDzgFYaPvUDuJYIbhkDC4vV+Q7dbt/0VqMTxVU469rQe4dGNzYNLtBh7U
	7PZxG+Xw/fAc4swVwovZ/HEJFocRZhTfXsG5COAzLkVRtodSYif54jU+vhvfBf2/
	e2kcR7GYP6tQfY1CLWkq+vhSiT1wHNBp4s5x1L+A47PaYh1R5qqWfvGadVgJO8pq
	kLYqC2p/LXxE5Nu/JAaR6psP4ETVfFKREJYXZ8OFV4p3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698260665; x=1698347065; bh=kPGLJUzDyKAN9Z4RqxrFEIh9w/WhBXwe0Ui
	uCeNBFW0=; b=hdSrjh4dzvNC/8KRxtty5Fj0mZxTAFeWJHtRWHaE6HWRvnc+/b9
	8Tzrfz6UibnoOmLKGUts67ELd+TGk9ZrgEKmd98Cv1g17I3bL1uQc1cFIML0Glf1
	ISBjmnbiv+bX/9daaZvhjHUnxK8v96n3rJ+eQC8a0OsYXqnkuvM7JTL96NlB0YoV
	W773uFPyWyK66StEOfJ9t3d4KmYyHnht+OJSKlG2kLMC8STtmFZbc+SmxreYV1d3
	aPCCiXntCvLL2GT1ByvMryhOxQ22h/0hgZWKSbcMtjuFep+BeDNbYPjej7Nl5+el
	Q/Cg5QQ7ATafeffVDsEWftUXpTipVgHxbMg==
X-ME-Sender: <xms:uGY5ZThLSuwkdhrunPzxkkobdJ-r3zOypSasKaDJo1xtG6Sol6qHaJA>
    <xme:uGY5ZQBzzIopz-uJybDdKzLBFCSHdKmt-d9qqjUpbDdfCdcUuG9leiwetNmKac9aA
    klM67gv297RS3mtxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:uGY5ZTFPv8PRKVjLXkGTiwGwjL3uJ6wOtN2qq9Q0aG0ypbhhJIL-8w>
    <xmx:uGY5ZQQqqv3AMEVgB1tSCg8c2Fxkqnt-DuTDW78l5wp81IUk8k5jAQ>
    <xmx:uGY5ZQxAJ1NTh2Mw5XxSMfNXG0xZX-dFu6hefSfCl9R_JaW6aceOsQ>
    <xmx:uWY5ZdsFjO5wfHv9eYvwqyYC9e7h4PJ3F9u-13UqB00PlXANPRgfpw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AB8B415A0093; Wed, 25 Oct 2023 15:04:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <840358e1-05b4-4730-a89d-1efae568d04d@app.fastmail.com>
In-Reply-To: <e38ebf04-cf92-c80b-3432-bf86ecda1054@gmail.com>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <da246287-8530-4680-8fcc-f68f881bc24b@app.fastmail.com>
 <e38ebf04-cf92-c80b-3432-bf86ecda1054@gmail.com>
Date: Wed, 25 Oct 2023 21:04:02 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Ruslan Yakauleu" <ruslan.yakauleu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023, at 20:31, Ruslan Yakauleu wrote:
> Hi
>
> If we use squash we will lose some context and occasionally, we need
> multiple small features combined into one big release. We would rather
> not mix it into one monolithic non-readable blob.

The only context you lose is the point where your branch started, if that
matters. (Later in the email you say that you rebase before you merge so
apparently it does not matter to you.)

To squash one single commit doesn=E2=80=99t make a =E2=80=9Cmonolithic=E2=
=80=9D commit=E2=80=94it is
exactly as monolithic as the commit you started with.

> For us, sometimes it is better to rebase something to make history more
> accurate than squash everything into one commit. We can use squash only
> for one story.

No, squash one single commit. Not multiple.

> Anyway, squash is a different feature.  Same as rebase (of course we're
> doing the rebase before merge to clarify history and to make some
> regression tests)

Squash and rebase are functionally identical in this case. And since you
rebase before merge anyway it is identical to the flow of

1. Rebase before merge
2. Merge with your new option

Except you don=E2=80=99t have to split it into two steps.
