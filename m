Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9B23F417
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105171; cv=none; b=s6bkHmn9Y4DD5JSYwsL8KloI9LU6nSbPWshADDC7DvWYwbYcu+J9MMtyABhDq9633WXhaIKgAu9ZrYZw3iMUtNdtJIV6gIROLhn96UiWALCnTa0MJq8Oc09Mz37FwT/KjjQemuQ5GnWR494LaTVyuS6M0ylrJvZ2LCxIcDgElOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105171; c=relaxed/simple;
	bh=Y96dXppD1Kc/nxfphB8V8wkvaLl82OFO1brr5yu6l7c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AyueslcoSVPuWj3fSKMQ7xswtD2+wFdvFANLW1vS/RR8mQwJc8uhe1sBeQTYIeS0ET4INZKuwoTWpP7xuhZ4euQBzgIBGls4XT17Xt7bipxal/xywD1n2/7QqJP+1dMcUAKZRfrYSuoYs8IwtxH6Z/zqBEaXFoRec77g2Y1v+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=1/VguJaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4skjC9t; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="1/VguJaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4skjC9t"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 054157A0085;
	Tue, 30 Dec 2025 09:32:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 09:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767105168; x=1767191568; bh=geLAmyci/BVdizmWZUflGMpzpor6fGe/
	JcYIcqHsBlk=; b=1/VguJaOzaAA1ajHn6JYTVDjI5d2yaohqSBpJQFYzqWgGXeN
	OxUvAXFuz1/VLjIRxYWOl0L7f6jrtYw2AeuzZPhZwukMxgkwm1/1CyxmD4jZwc1L
	3aviaHcNF1gqWW3BHWtosZ12Iu81CyIpfyB9pMoA3jOr4AoOz22tXnOrFmlQTDmQ
	bP0yXBwaA3zevluSH8KSKw8YTwUnFsDpWnkSxkDDsp1+d3knwG/Pb54jeOTlXOcP
	+GTNnb+GnyMN39Vuxs5qeOhXDLTIQnyl8fL5Jh+SAkEoVa9EQqDMI2or6IGuY6WY
	QCw2YsLWWqSBaJfJRF7tJFA7in5ZnH3nKtJy1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767105168; x=
	1767191568; bh=geLAmyci/BVdizmWZUflGMpzpor6fGe/JcYIcqHsBlk=; b=J
	4skjC9tkYH11XDe6ArWzyYmcUvTBPzB8oqqUTMqpYHo8TowRNcoQLRo8av/p1erP
	Wj2hqCPzPLZhUTq5sMKcv7lQ1i27Jbyj2RluhxCggf4CPoFqrJnGRnasxJsXQbB5
	GGv63IUitLYTCs291q3GnqCiDkgmePi5hkAiyUI4FcqQBDA6y2ZpfjSGR2X+Iojx
	RQGA7UVHXL6uwhRh9fXD5OdE+PH/sdB0ZenIRxLFIAuum2689HCuVpBxxrzpKVOf
	wdQrI3Hm9vgPBr9UExQoaSS/LTPV8WDtLJp7H3Qh90RUJvweUXheFuaNzcRLPZ1z
	MT6a6hW0iZNC4vMQqpEqw==
X-ME-Sender: <xms:kOJTaRp4X2GlIFcfM9J6jm5uTyd6mjpAOU-4HyxOSpgI9HjJ-L5SuTQ>
    <xme:kOJTaedSFFviWf80y0B4fYwKoD0B8lXC5WK1ZcXx3kg-KNzw9KN7KCYU21KIUTYtA
    BXCZlg41SrFzs3RzQgn-KOb529fy-HbI-9LZh2saz51Jk9NgWrRyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:kOJTaftfhICvBSKKB0eE2w0A7v_GJNV7b7WCNZOIgLsQHumEvE0DLA>
    <xmx:kOJTaR-KnVEFT-ULbejIIYMVygxQdSOqN5EKZVVmm_71to7qbLjQyw>
    <xmx:kOJTaS1m1bV9ycovs0PplfOrT4sEE88Fyz3hhvZjZ0NtWtzC2-pUTA>
    <xmx:kOJTaeBIIWFWKOFp-uT3l58HZvLnJDqyMNq-5F07WPb5uVLsfmD_fQ>
    <xmx:kOJTaUBpRZ4RMRypEEgLiOREjhuez2_LX6HtYM9c3wIUZuJYUk84e91y>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A88311EA0066; Tue, 30 Dec 2025 09:32:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkV22KuyfT4B
Date: Tue, 30 Dec 2025 15:31:47 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Elijah Newren" <newren@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <3914e3cc-d90b-4992-8c15-889c34c52a25@app.fastmail.com>
In-Reply-To: 
 <CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commit-ish
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025, at 04:03, Elijah Newren wrote:
> On Mon, Dec 22, 2025 at 2:04=E2=80=AFPM <kristofferhaugsbakk@fastmail.=
com> wrote:
>>[snip]
>
> Thanks for working on this.  I have nothing to add beyond what others
> have already commented on the series, except that I can maybe answer
> one question...
>
>[snip]

Thanks for explaining! I=E2=80=99ve removed this code in version 2.
