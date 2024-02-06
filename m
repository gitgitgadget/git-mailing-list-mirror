Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82307316F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203329; cv=none; b=X9KMOI3uQAsjC1eowLAPDu97v4dwhyKFoJTNN39rKiCDP1SqgZMQg0QCQ6yE36XQcfTj238E95r3yZ1hZzUMJoYEg6/V/Byrb8NOBBcFx2SbWyJCutVW/u+NS5L66qimt0ETkhdBefIfuyv98chct7/JxG2686ZlArBKK45wPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203329; c=relaxed/simple;
	bh=dIMDUf3g0JpYZpeFqUIXJaoYnBW1a0s2OsN7zMlI4b4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=T0gPqZtVPtu2Epywc4pz81qPjKuJFWOF0MLvOk7ZCWvT2VTo0MBeHAkhnRgJTTgARvo7lJ7CicSsiNQq0BaVt18afmC5TNyE1PqZ/IONjnE8wZMDGeCm4LqQxTVfl/c/aIG0NW823gyOiEQfDs7/+m1ebKwiIQLOAjg0KhKknE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=B5YPjVoK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aXMnZNb1; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="B5YPjVoK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aXMnZNb1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id DBB4B3200AE9;
	Tue,  6 Feb 2024 02:08:45 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 02:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707203325; x=1707289725; bh=gHHQM7zADuv7H3E4bODEVgVxoV4VMDdC
	Hxr9ePaeNmk=; b=B5YPjVoKb2CLEJ9pHsm7HfUgtaZ/UcyEGZYIySRdiWQYH9NZ
	Gk+QSsTiuxkmnKZKfdpehnBzyd6GRQKxw991I7mYkdH1rLccmcnJZSgMaTkq4VcT
	o07FzwRREJh9Jb5xerWSbKoav/B8vnrEr14D/QpXCdIXqotJWmdByyRcahvwpild
	YFLjDMc5fVBp36z2NeVEpaD/VhCEtPD/Q9k5eJx9GongqkHs26Ettc6NJyP095Zb
	bxrKEZkuuXniKHrMlusweyfptTteMBQhy8mPGpPZBggAHB30L6Xa+E1C9vB3+lit
	KgOPd0Nd7rQ9kVURx7Bw8a0/qfO+Z8sGnKgjZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707203325; x=
	1707289725; bh=gHHQM7zADuv7H3E4bODEVgVxoV4VMDdCHxr9ePaeNmk=; b=a
	XMnZNb1MyXz6hvlYhDoF8I4J8WGB9XmbT6zD14sxBaJI3W3GMYCZ3QYUJJgbxp2D
	CvqpbbKNbLVuuOM4JkHkUfHRcJjur0Lq/1IsouEr5O7qoy6UCt7CSy6jSIjvYWJi
	Lgr1LoBYfcGQng8I4F9EoCMPx0PP9+BQlaMmuCaMvJGOvFQyKzayv3kV+fHXmvDX
	gqZ04XmGa3PotZenK0hRGnXnP6pUl+W3HHOtlDXlK694Xe8YDFlJ8Z+zpi9trpDE
	R9jN62k4oNFoTtcL3ny9dDnZ/ArC/ktU8y3XK8AhRroikButJYiqtMKcT5NXAIc6
	gCbObXUN4f75szpfO+vog==
X-ME-Sender: <xms:_drBZY8iRuBLPNz9SLryTT0rAzR4Ju09__5TpdeGgNmnEKeP0BVP6qo>
    <xme:_drBZQtNs6ZFrcFk9LmalHU3d9Xlv4wu1Q3uZIMKbKn7KnB2dfJnPFrV5Q2t6Y9Un
    y2KtTczFQ2XFMW39Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdeitddvteeltedvtedvieevhefg
    ieffueejtdduhfdtieegjeehheetheefheevnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:_drBZeAHFJli8unDBE9tHcELPCir2HEJhKkSunLbDJ1BgEgVojCVIA>
    <xmx:_drBZYcG_vMcps9gwtvepw3NwNkdUGacj7DId31geiioJCx-kZE8xw>
    <xmx:_drBZdPVvW-TpXlm9CsfLEQnYRfzypuOvKyldmX4AojLPDGq7JjBqg>
    <xmx:_drBZb27ph8KNN1mUdr4XgGv8qcl3JXakC0NOAupTOFtA9zNf0XU2A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2984A15A0092; Tue,  6 Feb 2024 02:08:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa98146f-9308-4844-bec9-4605575b9cd9@app.fastmail.com>
In-Reply-To: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
Date: Tue, 06 Feb 2024 08:08:24 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Maarten Bosmans" <mkbosmans@gmail.com>
Cc: "Teng Long" <dyroneteng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] Speed up git-notes show
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024, at 21:49, Maarten Bosmans wrote:
> BACKGROUND
>   We have a script that runs a range of build tests for all new
>   commits in the repository and adds a line to the commit note with
>   the result from the test.

Nice. I=E2=80=99ve seen a few tools that do that:

=E2=80=A2 https://github.com/spotify/git-test
=E2=80=A2 https://github.com/mhagger/git-test

Thanks for improving this use-case.

--=20
Kristoffer Haugsbakk
