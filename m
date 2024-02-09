Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE077B3D2
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500342; cv=none; b=pqIfbjijyyCQadf/Ec5n0wPe1gv3pwcZX6/4cEpAy1FswygUOPAf00z+S9PFA6CvNpLWpIQ7iQhfwVSel3lz2mzYmU0MLnRRysigq7XCXgyBvpsssSc9hP1vtzRIdyNlfhjD38osb3vTXqNg3s6n+sTzNizGsaWI51QdQwlIihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500342; c=relaxed/simple;
	bh=JAyKiN/2lXb5rsGsiseD6Jm1NaNMsaZcLz4w6MWP8YQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aNcv5njMs9fca3b+dVsxy1OBluRcHbKMbHczGVszquQ7DAo4yLJ7XUEtkQC6S2x1FIVu4Qc58bhEYDYEoJEuZijIH693MqAUHf1C1fTA4tts1QdY/POs10jCY7+e7AnGeZb4no2nzK+EsNBaR7lj4U2VVVJyMhfaBlLMNdi6w30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=l3g8k33r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3cy6m7w; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="l3g8k33r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3cy6m7w"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5B57532002D8;
	Fri,  9 Feb 2024 12:38:59 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 12:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707500338; x=1707586738; bh=MENpdS/EiI33mv3FksqRlePsaoygPc6M
	7sopKAmc2F0=; b=l3g8k33rvFw4vqtOur25KyHDfVkZuvN292dSjHg1WKy3yDiK
	6X/i4CqgRop6hrCR2YqCmXIgsCy6m/nqumlGwlKMu201vpYgAztdJ7gOO0KdUejL
	kyTINX6zn/MWK2J92rOYelm7Xu+ONJ4rv/ClFXr7Q2p1Yfs2XAzeeQoH3kAYc2UF
	WCcnOJtDKODHK+zEPbDPKJ2sNOfi19jQmZr1A6BcSs0pyJcf72OyKbI2CQFt0PQc
	S4qRubFxwDYRpvc+KE4VsrULAUrTuByTFwe7wvJzf++XJZJi6HQUpcljbh+Toinz
	d853Tcj3vxyWFgcTMOk2EZYtlm71Oqj1zXzaIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707500338; x=
	1707586738; bh=MENpdS/EiI33mv3FksqRlePsaoygPc6M7sopKAmc2F0=; b=k
	3cy6m7wLx5vIHTITBNtj7qO8F/aLAqeWQy7UsSv+O4I1dx+s/B6x2vvU8UmKqrn+
	exWiPHm9titk5rTX6np4rR4R9X2ZfuYgc7hd8BQVvAG8cwmAmKdVhjuNySaNB/eS
	TN2c6QDBs0rvk7Op5VtHmHvcreHRFf6fzmQVu3wMdo0vAoJ9Gt9cNAUvRviUIi1P
	VvjtnEJYBZee2ij5h/a8ftcANf/hId20zUWYBWh+xAE3oCudpxC6qs+ebelLzvoi
	tWhy8xNHoo3kLnSOeuwHqrIBHihp0jGe8uB6Yjdz7nRCAkhTI/7Z9lUisY24ACjO
	mXZawekZ0HmJvKFzvNmsw==
X-ME-Sender: <xms:MWPGZSeb2PmZ-hHowb9u4HUzcj5nHs3XxfXtxQUO4o-LM4xjMQ_5m7o>
    <xme:MWPGZcM1iR7oFoWHHuaJoIIOMSzTFq7RHR6jndjnFdKd5krf1awUninQAGPVQr6uw
    RpWRCiUpxvN1Vo3yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:MWPGZThu3efg0M59t9LETTRRq5E9t970iiyspLskX9e61z9wi6lH5Q>
    <xmx:MWPGZf-p0Rqo6oKKev8R8zFeLTbvkdItk2TASZMMHH4vbJECUGiNzw>
    <xmx:MWPGZes_WN_547raysv54NZ-8UrtIcdP_ZerXIY4MaiHdfHDKrEMOA>
    <xmx:MmPGZX4_1YgIxVASXxxyhtINy7lM54Kd1IpDbu5RjX685F06qIwVcA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A152215A0092; Fri,  9 Feb 2024 12:38:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
In-Reply-To: <xmqqfry1h7ej.fsf@gitster.g>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
 <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
 <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
 <5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
 <xmqqfry1h7ej.fsf@gitster.g>
Date: Fri, 09 Feb 2024 18:38:37 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though --author
 is used
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024, at 18:30, Junio C Hamano wrote:
> So, now, let's be productive.  When somebody who does not know much
> about Git tries to commit without configuring anything and hits the
> error, what is a more appropriate message to guide who does not know
> what he or she does not know?
>
> The user claims that "committer identity unknown, please tell me who
> you are" were not helpful enough.  Would it make it more helpful if
> we append how to "tell who they are" after that message, perhaps
> with "git config" on user.email and user.name variables, or
> something?
>
> Or do we need three-way switch that does
>
> 	if (neither is known) {
>         	printf("neither author or committer is known");
> 	} else if (author is known but committer is not known) {
> 		printf("author is known but committer is not"):
> 	} else if (author is not known but committer is known) {
> 		printf("committer is known but author is not"):
> 	} else {
> 		return happy;
> 	}
>
> 	printf("please tell us who you are...");
>
> perhaps?

I think a three-way switch looks good. With the amendment that it steers
you towards `user.*` instead of setting both `author.*` and
`committer.*`.

Something like

=E2=80=A2 Author is set, not committer
  =E2=80=A2 Message: author is set but not committer: you might want to =
set
    *user* instead (prints suggested config)

I can try to make a patch later.

--=20
Kristoffer Haugsbakk

