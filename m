Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373112AACC
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717570; cv=none; b=ar7WfxM+olbaCpLfYJrgxzwCjqfCewnEGdVrHJF72N2gvIYO2nlJ7r+wXcBQJ1XEgHsnkCAMkYVODfz3kdHMrqE1NX/F9jDG0aEfhxaF1kWdl2h0dZAeXHj6KA8kE8wC2ONc8C0lBIZ+vPxJNwW0dXnVV8SDEG1g6Af4p2baMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717570; c=relaxed/simple;
	bh=7uurYYxe/qwxnc+BSQzq4hfc1+8/7nlvVjTlCWnvy84=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WW0G0r/3uUlny7hN/uJ0RmmDF7LOLASYiu0/WgxZWJrcw3E9JZbJ51bDsmTEb7Qn6+Tb6qF9mmgAqTVFS+gJ93GbJlqf/rFiC2/7j1TqcNzUmsuFHa8z/6OfEQwZZceLzK9ArsrGCp7la15I/j/B90HoiLZJssnYHSsUUykHPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eZbzJrRV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtP1iH8W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eZbzJrRV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtP1iH8W"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C39B0114005D;
	Wed, 31 Jan 2024 11:12:47 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 31 Jan 2024 11:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706717567; x=1706803967; bh=IWDWeCO7i2s5sQ3feKKUgiLv58gv9aqR
	iGOB8kOj5vM=; b=eZbzJrRVfBx69Wr16DpK+17/0bypM8jBofknOq/T1lQjjxDs
	ZJWWe59GRfjXjB0GmqsSE8smYZPRoRJG21hZbNnLpD70YkbUQYtgaZJeozkmtbst
	beQuURE667s3AlCzFnXztFw+1tFkuMj09xBE+mZkY7bEJb8/fZBZRGLiulrGj4ED
	a5wy5MbiHdXnJ7b9Pt2yed7KLPiZA1x5DIr1cKigrpE6ifXnRU2xZRfwhTh40SB9
	47QQvr2pBOO03F1vbTFzuogzwrT6XyDnfJMt5VIgzUXE53+KvpR+MRvdUuUN8nZR
	hIB7wxYi6aoTW5oFSZWRkIE8swPStx65CciafQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706717567; x=
	1706803967; bh=IWDWeCO7i2s5sQ3feKKUgiLv58gv9aqRiGOB8kOj5vM=; b=O
	tP1iH8WKR0cn/dPNVkSk+lty8SY4I+BIYNKiNnij7kkqT0Yz/mcfVaJ0bz7lGr1Z
	zkQ4smXK3CP7i8QAPugKBYcvLd67h11J2rDXpgMimfnqANitBszGXZgwgS7HPeiU
	cTPGlMTM6QE9tB08NkULKEbK+BRj1pYQ5dNjGM9zG1PEsjQdLB/jgZ+Xi/w0zj+e
	FiaLiFxpVLnES5RjLb2wQ8oAzFldt79504WApEqQrkaL+oQu/AHWuHegmICav3GY
	KN3+mcGD6SJ0F7foYN+9HURUY2Tau0xsTAdN9HFXeYn20VADCX5J8OSttyMjjU+G
	+BP7SWo4FocqOlKQCvKHw==
X-ME-Sender: <xms:f3G6Zb1LaBFBQxYdtsSJDv0pWLl0TEl4VZEA7M5FRynBLwZ1N8ZsW7M>
    <xme:f3G6ZaEpph1tfV9nx9AFSCa7mmY7xlt0d9p_GTNdH5TQd7KIcstufq68YBVWUCV3h
    6fxbLrFj-b7mjmFNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:f3G6Zb638t4wO7JfQhNwEtzkAmtnnSk_frwl-ufM9AlJhFN-Y5pIRw>
    <xmx:f3G6ZQ1ceGrtiiSeyD9lh6cUW3DKCyf-V2ln9eyqJb0J5A00X4bAyw>
    <xmx:f3G6ZeGjMtY2-Db4icQRB9HRnBE_zZMU3quFQ-mBbwBolpEeR6xlSA>
    <xmx:f3G6ZTTsnzuI4QmcN4Gc-L1BYS0_BkjVlZdbsJTF6Xxvibf7mkJfkg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7595015A0092; Wed, 31 Jan 2024 11:12:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d0efd0f-f35d-4a3a-aea1-e08cc55bd2d9@app.fastmail.com>
In-Reply-To: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 17:12:27 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: Haritha <harithamma.d@ibm.com>, git@vger.kernel.org
Subject: Re: [PATCH] This PR enables a successful git build on z/OS.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> [PATCH] This PR enables a successful git build on z/OS.

Maybe the subject could be:

> [PATCH] build: support z/OS (OS/390)

There=E2=80=99s some indirectly related things in `SubmittingPatches`:

 =E2=80=9C  Describe your changes in imperative mood, e.g. "make xyzzy d=
o frotz"
    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
    to do frotz", as if you are giving orders to the codebase to change
    its behavior.  Try to make sure your explanation can be understood
    without external resources. Instead of giving a URL to a mailing
    list archive, summarize the relevant points of the discussion.

From which I infer that =E2=80=9CThis PR=E2=80=9D is considered redundan=
t.

As for the `build:` prefix: many different prefixes have been used for
this file (`git log --no-merges -- config.mak.uname`).

--=20
Kristoffer Haugsbakk
