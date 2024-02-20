Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B3605C1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421787; cv=none; b=AxApW0FEqvL5bqw0Xp1ZPvMY5WIl4CSHLsMegZHj+VHwrbFqeU59fVAq05zQz8mqX3BZ/S8xPovLXvctUoJlwq1cMf0OImoJhgSEeWd1etQZODfYuWDHszQ1TzvPHuyCshzGL0MHs7vcHQR82p8Q6va6pXoaq7VHzhV4LNa6fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421787; c=relaxed/simple;
	bh=32XzmmfBzGDVxjf4o5mEnJhKhslKUahRy9LaW4ha+kk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LdhVrVUyDiXHS3+vS8p5U+dojN1yYfVoQpuxlRCPZ4bhMPqEhz/s04hKsuKr3FCH1QL1iqDOArdE5i3S8LpaKqAoPyyUpIODx7jZ7IBEXTu1XIXPg0Kd3v8IgO78N02ecpGT84XnfzX1NTIdnnj5ZR94BffgeYsSCiwrHiRU5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=KjqVQqP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7lefLFa; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="KjqVQqP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7lefLFa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D42D180008F;
	Tue, 20 Feb 2024 04:36:23 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 04:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708421783; x=1708508183; bh=32XzmmfBzGDVxjf4o5mEnJhKhslKUahR
	y9LaW4ha+kk=; b=KjqVQqP4qO3fszTlwf8lR0k9qxCPhjqwXpJ1whTWq6UK8TL2
	BOchCiFt9G8O84wOfqa3tkrIz536t/EFM1Vt0D24g3YMQAmEUsqp0WdCjqCI2tXo
	Rl59LEGbRaBLudXz+1IwLTyhXpbG9yEY59PxGtHB/r56KU1BLgmvVkPRUwX1KJT6
	LKLNJ1o2e4q2LFKtnQYpX7KjPoYQPFEqU7pJ+2Ogd4kKq+4NFuYLCa1+SKWtNqAE
	J4FtA0R4XxshUUgaR0sFEgR5ldur03/bILBW7wOb3du6PyAjnxDUtNzkwMJXVTle
	d1hgWGNrINz93BUmK3hyw4Yu2i1jjV5/z1dvFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708421783; x=
	1708508183; bh=32XzmmfBzGDVxjf4o5mEnJhKhslKUahRy9LaW4ha+kk=; b=c
	7lefLFaf8ZzGpkW4xADfmpomBnF1qsDLqZb4l2SpC96d1+r838rSfZTEOCH0czdD
	BAQLA+gUVCorS1zw4Pyyie/pGcW32qZOuV+83x/rD9xOgTJn8VXx9goQgDXNZGyE
	o1P5pMKyQGVCv7nC5ZrYaMb5HmEQmtdOvOjJko12u2jgDdIAVaJVSTLQl8OSNfIE
	9bBr0jNcUBStqXBrZvDCBL6H4a0+RT2TObKxH6bt3Ofk89b+Xrd43L6MxUR5usvB
	YUs81frsb83It7ZTExR/BGgmQu3BAQqjwJaB3sfyXQdH829LtXHexvw3uXZZMS8p
	lZU/g5QFQQfPGJAGDKghA==
X-ME-Sender: <xms:lnLUZQrHqJptzNff3HxOZgL27gXMjAjFidfPK-_LU_eWSAXnBfrYyD0>
    <xme:lnLUZWrX3e2soLPyEBlBGczgprQM-u10F3iPZcf-TVLrbGB1yq9CZHeqiSgm9yYu5
    9oU3gWfDVrT5hTFWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:lnLUZVNMFhA0HCOfBUvvI26fj9XAxRc__ZpLcQqAcJQ94hhCOlorfg>
    <xmx:lnLUZX59eH1NUQKtpLj8GLAKqKMwui4C18IJNYrvmeN1xxiTXEh0HQ>
    <xmx:lnLUZf5meN08lre-8Mom4eT3Y7ubWDrajZH6ByQtzAagmwbDitx5lQ>
    <xmx:l3LUZRnnEAy2i17as7DQ4XtXqYWCfU6UM-2HiXpOKvzOUjWX0yFgoON1gg4>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D2F9515A0092; Tue, 20 Feb 2024 04:36:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
In-Reply-To: <20240220092957.1296283-2-matttbe@kernel.org>
References: <20240220092957.1296283-2-matttbe@kernel.org>
Date: Tue, 20 Feb 2024 10:36:02 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: 
 =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= <pclouds@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore experimental"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 10:29, Matthieu Baerts (NGI0) wrote:
> This reverts commit 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd.
> Version 2.44 is approaching, almost 5 years after the introduction of
> these two commands, it then looks safe to remove this experimental
> status.

Is this only based on the amount of time passed? Has there been any
relevant discussions on the mailing list that discuss how mature these
commands are and if they should be changed (with presumably a =E2=80=9Cn=
o=E2=80=9D to
the question about being changed)?

--=20
Kristoffer Haugsbakk

