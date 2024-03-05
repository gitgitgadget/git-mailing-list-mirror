Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0585675B
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634599; cv=none; b=ZFbyTpYUvkckPOfpKcI85ueK+Eie+WaJ4vg1+t4Ihl/ClVA690LinnreQc5PtRDoeo+kfBke8DmXjMigCU7tydyuZEMhvUgJl5M65qTqrncUu0lAGVJSSltLGF99W97IIfco2mCagz2c4fVIXmhJ7VSuwTBJCEbZr18azKo+S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634599; c=relaxed/simple;
	bh=PGUgbDb/ryIWQZmZW3GXKggHVeZaLNM4jX2kJmxHWn8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SZkFrUmmNeBvn8DHBiumtd37vOrv+eqaw8whMwYKtICXNh1Ns4feb3qJa5tv9mG/D9x3fmO//6tRuAuDz6jWVsEfNs9MmRVzODdernIwtuVpx80heBylVRd0IrKtM2fL3InW8mv/f9fxa2C7R2tzfXxaiiPoR8e6QgTJwoWGMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=a4yIYKWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sy5RcTgz; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="a4yIYKWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sy5RcTgz"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B5E803200488;
	Tue,  5 Mar 2024 05:29:56 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709634596; x=1709720996; bh=nNIsZljrU0NTCARkGWIScmlRNo668bQp
	Zhps9qs7e8I=; b=a4yIYKWf+4tYv1xC8RAmnRN3uHmGusNRCeNBFd4o3l0t6gyI
	9m4pF4R/PKqCFZzhIx7c32UjSIp6KhJMus46QLAkAp4nn5hLEoVvkyyGOjo4/I9O
	eYb4MaX/+SqmSjRk12mz4DzUlWu3eNO6XUCdWqcGY8orQiWLWoWwCXh8yRz5tKND
	0LgxjoKcI8YxhKKnrvjN68+m0yR8RJ6kNVwXm99opMNmmvgBsZnfTzndkRHTPYyn
	SIyjBEwfFtr/wq24RMv0KYXQq4STAn9IKlWwcM+fbR4ktILgtRiHN2ySDCPA7+hc
	Y/uFAj4L6WSZTyKJK5c6TEvvfIelbQP+65AwLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709634596; x=
	1709720996; bh=nNIsZljrU0NTCARkGWIScmlRNo668bQpZhps9qs7e8I=; b=S
	y5RcTgzY5rKcTOboUlkK0CakIoUF3hj53AUUzZkm/mJQ4nyvkecmGeRM8OlYQDOR
	eya+X5lAnjqO4Xqo0hK66a++ZCjgN9SAXnU2DIsh0ASzWtLZiM0nXIFvEMvgVy6Q
	bd171jFdq29+drotShzV5s/wW9wxgKY7GmDLl8gWAeHStBetxKWtoH/liWBP64v+
	iNt+rZiwgsTQ8JHvBWF0P8TyrgtoDnlEVqfD1j4XiZxxQVn9Z9XVNJRvdWVD79IR
	5liwd+0uOWwArPVSiXU4QHBcM2NJEYTRJvzJusyuVTNYnEUD0dHKzj49qvCH8BPc
	KStb7WsXdmedPpBqisdNQ==
X-ME-Sender: <xms:JPTmZSIU4xbfK-70XK8MAKDFR1UPWbFY2ACuxbbN1_7IJzrtDEtSVUI>
    <xme:JPTmZaI6FBa7Sjto9NkCA7KRCqH0QDMgQJXv7LKMvMnSaeEIxi_vOQ0V5On0lKCPu
    LvMOPafCjmA6TjasA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:JPTmZSvbAhTmKo3OOa9EV7kN8IQgUxGRyddvLm9jmsSmbBeXjD2oBQ>
    <xmx:JPTmZXZfp7BufxWSDueQ7SSs-Ff7iyiARZ19xf-gO4sAXC-yEfxSRg>
    <xmx:JPTmZZZtEyj0NTy2HSs2h8Zi_Ruo-d-2s2SCVhAhLQlFbBTWh8gSuw>
    <xmx:JPTmZaASAuUKnQUHLcFXqBumi730aLtOl0nTkxqLtIYrt-eGctMsWQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0CBFA15A0092; Tue,  5 Mar 2024 05:29:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d8556af-5ff9-4e5c-a2f0-05480d1feba9@app.fastmail.com>
In-Reply-To: <xmqqzfvdlfhp.fsf@gitster.g>
References: 
 <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
 <cover.1709590037.git.code@khaugsbakk.name>
 <30d662a04c75b80166db9ef94f95e8a841994fb5.1709590037.git.code@khaugsbakk.name>
 <xmqqzfvdlfhp.fsf@gitster.g>
Date: Tue, 05 Mar 2024 11:29:34 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] advice: use backticks for code
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 00:54, Junio C Hamano wrote:
>> Use backticks for quoting code rather than single quotes.
>
> Good.  Technically it does not have to be "code", but rather what
> the user would literally type from their keyboard verbatim, but
> "quoting code" is so concise way to describe, it probably is good
> enough hint for future developers who will find this commit via "git
> blame" and read "git show" to read this explanation.

I agree. Either works fine but =E2=80=9Cverbatim=E2=80=9D is a more gene=
ral term. I=E2=80=99ll
use that.
