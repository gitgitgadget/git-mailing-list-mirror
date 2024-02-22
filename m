Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEF3D97D
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599215; cv=none; b=JCJ83fLN6sIYiX1sHjpF16tL0ktqAr/8DwXyehPXCFrdcaUp3aqeevYqAIz8nhVP/3cZ5HpWt32gd3h7kIF3RBCfC6heFI2DIYFMA3gp1sIoHgBwt2kWGm0wiTEqpaM/iZ/FVhDAcdVrpAW+Qy37o21/vznFcJ6QHcSQ1jNTb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599215; c=relaxed/simple;
	bh=y8XutkbArEjruhAZLE9wSsmvHI4OqrRna2CjU6B86F4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=B0/5+4WTTbRYoNW5oHA8oAUHFDSHVhtuj88MBZQjiL2otkHtaVDvYhzrvLU2CVc5x9P6krmZCZVhu6R7rIoGgcTvaOWoLJNfehfGk2DwBYufcusHAu0jsyfAwQVQeAwR1ZyT21Uze2eJOaxWjh40GmXhDHQ5wFYA4Pak8tg4mzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=i6lXFTFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4W80qOE; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="i6lXFTFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4W80qOE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 943D33200B92;
	Thu, 22 Feb 2024 05:53:31 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 22 Feb 2024 05:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708599211; x=1708685611; bh=MQoo5TxCdvlG+U5LPqsSFfcqwR7/bm5z
	mSBDEqIJavE=; b=i6lXFTFhBjE2uE6cDqI5Dm49kPSwHdpYHRSu354B8RUhW0yN
	cOXE8AZl2msbPS4/OrCwS6LUWfLzndgdnO1TjGJXWw0AXjmDF5SwVb8M2XVhXzFS
	cxjwqx1HJsZi3/LjZQj90SsyYuL9+4/ECLnPPeVZnmw3QfArNSibHKSSKxuEgarw
	oQn5iweZqRsZIo+5hotKRxQS0oJE9n7srKwdIumhkpCOPxX52p0vow33gVUfBxJm
	QdlhW5rmLy0LHcSMdsrE4qxB/BfhWyPpRe7ESJl9g09UfrU7gwXL+oyfRakF8KWh
	tv7qXEiRzNWpbq5NQRgWgafTQhfBpjdWifakZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708599211; x=
	1708685611; bh=MQoo5TxCdvlG+U5LPqsSFfcqwR7/bm5zmSBDEqIJavE=; b=G
	4W80qOEXHCl5QLgaoYFry4//XeZu7TXAmFprFCskhSwFV/5Ha2/W2+qNiKkKON2n
	o8lKufLaydnJDE2QI6F04xqIwgxWnnpNJ0pzifZSCB+pfkGd5b7qvetmwmg3U/ba
	1oil+4bRtlBQ9yQRu2t+apTk3OL2CFKdiC37AzXeBiBtorGX7pfgkaOsr4rkGqOr
	pOvIAo/zJ58Z0iw5E1+m1cUTuB01b9+dgIKO+UJB4TMzfkqiD4/uMF+fq5JfQD3r
	AxVtP0i6nSHIh5C0MPBJZjYjsbxgKryG/tB+Mk7GR+jbhq2TqQLd34IDuXUicR2x
	m+vNaOcLUEv+LUcJ9IR9A==
X-ME-Sender: <xms:qifXZenM-ly5FeSTd6pAC4ZXh4LgP2yFQ3MkTWj60zeQwAlv2bIxdcI>
    <xme:qifXZV2xpCdzjCq7I-_eaI2tPd7ieZ_6Zyc0uZ4pCyQd_-j0E4nNGC7c_ZTF_DJ9a
    D-fdwlalH7h8xDqoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:qifXZcpqlfdgmUo9MwoES8uX-3Q1tEAfIU1RKmoAfBnhhnra7k_I7Q>
    <xmx:qifXZSlgq4sjBPs_-ABt0F0xZQS1UUm7rsHZXKrhhOeG7tmf9mAQlw>
    <xmx:qifXZc2LbOCaWLFt4LvF7rrZHM7XPzWIoCIyZGxiRShXuLS36cvE5A>
    <xmx:qyfXZZ_nFOqoVxPGva_YvUQYTTD9xGJRnfxXw0uU_y-BLPWvDuIfwQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CADFB15A0092; Thu, 22 Feb 2024 05:53:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <759cbb30-96dd-456a-baab-b9451d400dcb@app.fastmail.com>
In-Reply-To: <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 11:53:10 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Harmen Stoppels" <me@harmenstoppels.nl>, git@vger.kernel.org
Subject: Re: [PATCH v2] rebase: make warning less passive aggressive
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 18:38, Harmen Stoppels via GitGitGadget wrote:
> From: Harmen Stoppels <me@harmenstoppels.nl>
>
> When you run `git rebase --continue` when no rebase is in progress, git
> outputs `fatal: No rebase in progress?` which is not a question but a
> statement. Make it appear as a statement, and use lowercase to align
> with error message style.
>
> Signed-off-by: Harmen Stoppels <me@harmenstoppels.nl>
> ---

I=E2=80=99ve interpreted this error as: I=E2=80=99m not quite sure but i=
t looks like you
are not in the middle of a rebase? Like it can=E2=80=99t be completely
sure. Maybe from a more =E2=80=9Cprimitive=E2=80=9D time, implementation=
-wise?[1] :)

(I waited to make this reply in order to see what others would say. And
apparently there is no need for a hedging/passive aggressive question
mark.)

=E2=80=A0 1: 031321c654d (Add --continue and --abort options to git-reba=
se.,
    2006-04-26)

--=20
Kristoffer Haugsbakk
