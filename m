Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC413A267
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342483; cv=none; b=Q9cI0lgAq437mG93PCElzN2bjme/cvMTQUhspnJ26ruI06fUn+FHAtk29qPvpz6AwW1dHWSlZB1dWe9U7mTnw9dpVgYJ2/IgZK4EUd5rpmdIE9z5ynk84whrJTJqp+bbWrgWYpFys7HIWjD7CAErrIvuYgnpbbQwYU9vDPy5BV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342483; c=relaxed/simple;
	bh=fteVdpun+5W2GkS/y1TEAkYSx9jmounOshotf7ITHU0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HavQXb1Dij7Y7E+LYchi9jnOuX6qarBSonaTi2sSUe5uslKu4q0/9S7jPDbS5APn9xTAHG3nczUdUZDreuqHkSFU0byOzMTVkARjsla7nAPqPA7irtpRojbtplEOa5O64VpgOi9cgEPHKbe0fX8ED3Caeiate4gLWOtsz3UgGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=MOr6Dzjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ny92gRw+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="MOr6Dzjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ny92gRw+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A60A313800B5;
	Wed,  7 Feb 2024 16:48:00 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 07 Feb 2024 16:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707342480; x=1707428880; bh=BInNS6GYWiC+YqwNONwvKffDwipVlfrV
	liebOtmaQ1Q=; b=MOr6Dzjz0BOY09FereflULcAt8vrgo6RFQPNx7pf49Wkg74/
	BCHliRjJOI4vHIxx8RK4lVhJPjM+Nj9/lVKxOfYjq72mKIt/iJPcBJZ5FlE/z0T4
	iDOWMFWcZOOAqzz1/hmW4Eq7h3Q80Q6xV8I+MkoQo2aadcZrebEeqzpHjLGh65GN
	2nLLpOVPoh2F+un6dXPwB0u11y/I/XOARDLslp+IauNlnPm56se/TIuPmXmLWa+b
	LOVdnLr19VKUi/berS9/jmy8uqipXWuV1wPPbMPXPZmTlw1OBNuxK3TMgl6mpbML
	beBDO/HCmQwURQqtU5KPrTz6tv1Uu/OQWeQ37w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707342480; x=
	1707428880; bh=BInNS6GYWiC+YqwNONwvKffDwipVlfrVliebOtmaQ1Q=; b=n
	y92gRw+aPWSmkP1L/WqPUn+RVvXIm7sEH38+evLoYvhyFLGEJePz33Fl/WV9+WyD
	CmUq0YBF0dT42d6+iNorznBT8OdYxjVpP1vWX39Rn/M60XYHefnIKJ7RXZwjx4JH
	JW7bB9cOtQWiTU3CoPZbu/eE0L1h8oITHSRQ26fU8o5VDq0MX/SeRdGSJLwm6E6b
	egk9iw+gHSTlfpMNQ992FjLfLrnwfYp97xBJrb+I6OuN+Xcqku8eRlZB6XUqd5ob
	10XpCxAMpiiM85tkI/JvjFH9WBOcnAAfXUF3cOd5vhAgS1V6gSGKxy2NeqqZgAAj
	59Dqye0V0cJiUjT9u+JhQ==
X-ME-Sender: <xms:kPrDZcWJpZtJVsdCk7EKtW2YywObkpFBeEUk0TNJSNhsNhHh0ev38S0>
    <xme:kPrDZQnD1B7K86r4cIIKdMA6Via_cEML3vmxttsfmNkuv-9rEVWBtA0MhBNZqqhXi
    06kVBghk_-kSowIig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:kPrDZQZ5fdmIWBkvSC854sJLbgSCDXe3_P0WgMeU7zg6hcOOmMgf6w>
    <xmx:kPrDZbVXk1_5T5rtJBtKp3iEGSBqIYzeb--7NYMnTmrGl31OC_UxCA>
    <xmx:kPrDZWm6qB9LDE-XsylhfiVtwTxbwSnHMbUKi4pXmaE6y1za9xUfsA>
    <xmx:kPrDZavE9wg-rCPkrV68IuPBnFUimIUYyz0tFnC4NHIyuwlMB6LYhA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 682E315A0093; Wed,  7 Feb 2024 16:48:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a18532ba-b168-4928-bced-d1604a483f24@app.fastmail.com>
In-Reply-To: 
 <CAGHpTBKpYp370QTw93wK_RP+X2S+44jd-8kjodiUj4k0BoAEqA@mail.gmail.com>
References: 
 <CAGHpTBKpYp370QTw93wK_RP+X2S+44jd-8kjodiUj4k0BoAEqA@mail.gmail.com>
Date: Wed, 07 Feb 2024 22:47:40 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Orgad Shaneh" <orgads@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: git gc destroys autostash
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024, at 21:52, Orgad Shaneh wrote:
> Running git gc --prune=3Dnow during rebase with autostash deletes the
> autostash object, and it cannot be recovered when the rebase ends.

Things like this is why I don=E2=80=99t use the stash.[1][2] I just comm=
it
everything of value and non-value.

=E2=80=A0 1: With very rare exceptions where the stash is popped before =
the
    whole operation leaves my own working memory
=E2=80=A0 2: Also how you have to find unreachable objects using git-fsc=
k(1) if
    you pop the last stash

--=20
Kristoffer Haugsbakk
