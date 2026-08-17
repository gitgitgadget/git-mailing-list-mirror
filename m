Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3F3A6EEE
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997299; cv=none; b=ppJXOb2zldJRDxWmkPYpwmkd9j79uM7LO4ipdz7gsfv0AntLA2aOGlUxlHVbHummFzuokHNRLhGdFCFu5pE8/K/pgOzDdpXnbgutx7sABt5+vkLkmWAxY6/wPTXUXSxLfAcaHcezCM8NeZgwX6/8FsxTleIbxtQVcZkAtr1WJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997299; c=relaxed/simple;
	bh=+2NQ9NbqTm3NDip6qeJrOpomVoNl0yixTSPUOIEjWt8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hSMpYOupW6Q2id27u3eZowQGdsMZWmVZpXqT4rG53yJBIyBn/aFLhBbzBXbckNmH2W2iVWLhY9OMxlPrDma5Y+SdasS6LEiTtUxDcTz9raM+IbfeZ/joF8dqb4MzW6fFb1S70QE+2WoonK31riU7czE7Zt8Li+rPydSuVXezo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Pqx96pcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgkkXntr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Pqx96pcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgkkXntr"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08FE97A016E;
	Mon, 17 Aug 2026 16:08:15 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 17 Aug 2026 16:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786997295;
	 x=1787083695; bh=EaUeP+2SlKWXyCy9ih0ChwrUOCg79yvHetdOBD9gpuA=; b=
	Pqx96pcvRRTia1zYbh/8xVocEMnOJ/rCMaM+qlMI2wMJjixiuEj63TH839WaMOjr
	Wg+trf/PW461mAxRvZ54ZIKHayLXGo4Tc0DjZ2h3zMH8eeJRaxPMtO7mJUkSCZNG
	6glakhK0Jvryy0ZFjcsUtTC2Y9CheBnMC5cH1JpEXs+bh/WKDm8VvdpZy+mIDfG0
	5edF+VjwnaeI2Rxaw40R5jXffKlIAabfm5CToeWwHKM3AtJoppp6LZZ9zJKk/zbv
	sNjLQC35bqagMilg9TSaU4cWJZTx7t4Y6S/EA6u7ReDsMBAuFPNScypBCO83tnKC
	nmfqZzDJTQJ6zBdHtY/21w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786997295; x=
	1787083695; bh=EaUeP+2SlKWXyCy9ih0ChwrUOCg79yvHetdOBD9gpuA=; b=F
	gkkXntrKwPcDMQwpiG+udxuZv2kT7QY4rjTodCWCWydqYQL1yLvnm2mu3OHn3XSD
	HOpLmPZ7c8EGHIjBVK0HcIUmRzIcgGR42LV2IuI3lHQoqrOUTj2gQ/jxVvCTP9LT
	VDvJeRbyTMWVRSBTSfMbACqd51zZMkr0bBxbgdO8/UUU8SY0cCxVeXLrivaLIEEK
	Sbc2pmpiYhBsFsDOtmXos03FKieWfv8415Qg5CsOn2KxhVzMXvsasPlzgmlEdyLB
	/C6QfW1DgZly5m0VE2tNlcGE8fGqZkhBL3hJ/PM6n5GE3UN+/fwEp5lhAqcquOjb
	fTFUnw/yi32OrfzuzoGAQ==
X-ME-Sender: <xms:KmqDahZEKYyM_O6O4KYHEdkbCjK_H84jXiqyYg6Ho-zNjzB0zzqJUmY>
    <xme:KmqDajOVlHQFbAr3WaOKSPzZ_JrIab0HpEoqMSKg9LH6pYDLwe1B2dJzsPszu-O6r
    1bj0g-ADjOk20CCtyJxvXvmutuwmVmCZ2EswXR2L8EYjFD35PN2xA>
X-ME-Proxy-Cause: dmFkZTFpcRRDbCm8k8wdBsl+eWKineHhvKhRsvl7mWe6inYCaqMHUOFCnhi3ZTgTWPprPM
    BvlpPC5kVzsYx7E1SM/g9Kpt3ssOp4DJpnfxbYNH3YVTJRfyYMGJFMB9LI1bPgxvBvtHhs
    iaEfkyNMPLn+ivmDrnWjKg/PoX4pLXGW8YNRVYQXJOAX5Qk3G+zffp6NW1sLQrbFZ51BlA
    XaocpqNku0IWHRhFqUWTyUAFTH7+v0ID0NUrEWh/HN6AVTdv4PKRctRkZ0QIymG6QQIIVs
    X1IYTFDJ037h9wH8VuKdD6yBj/SvZJZhwF5bvWEDWgvENeJy7hxpK9riWN7iph5d38u4HI
    f2ZnB+fClOP6M8c3Dop9Gvft0I59NPFJP5gIEhTV3paXuV1NNvr6jfFKRWb9lJAivgt9BX
    IKGDioSFcT3dCOC1ZiqyH9146B5XFZky6xK+6xzCclLl01k32kqkAFY/5KPU07CJaHxYqe
    hmzzqAtmL0BjbDVs3pkFUcSEOsDtXbWnRq6u+Lja0jzr1LR7lmSrnRH5orn6ih7bhdU9tU
    dblxkuh63ZlF/xQEQU5ucpbWZXh3OYUwC7huJansFdFROxi9Ff6d3hbImJtvr8+rBB6GDy
    p5Gt8PTP7Re0LJGY6BkpJeZVTY4N2VLQ/ym7S1l4imwRIq+1mSSNNRvl+H1g
X-ME-Proxy: <xmx:LGqDarZTqYGK5iceYnPdJ87N5ep7eqvDaP3yE0bqLK6clb4DI42oiQ>
    <xmx:LGqDamYmzjbdo0xanuZSBvqxNXeYIaCQIu8bNPJEBgMR6hxCdsiCPA>
    <xmx:LGqDagJOEem8smYNa9Da2qPAmiz1hW5zIQReXgfY7ysu0NWJe-Y-BQ>
    <xmx:LGqDaivj_6CE-zHSC8wqPhnq7pp5GoBdlmKhd_wZD0qVztJWt928sQ>
    <xmx:L2qDahOVPoWDXFb4Da3fXFxf6O7obJgeSGR90-KyUa5pMycsk9ttQRkI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ED67322C0075; Mon, 17 Aug 2026 16:08:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 22:07:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Matt Hunter" <m@lfurio.us>
Message-Id: <29d56a3e-6bde-49a2-b7b2-3eeb4c439e01@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnXVepLAsNZHZe_qqXbqYjBt6RpDXVQUP3s7vPwbEg2FXw@mail.gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
 <8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
 <xmqq4igyszeb.fsf@gitster.g> <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
 <CAHwyqnXVepLAsNZHZe_qqXbqYjBt6RpDXVQUP3s7vPwbEg2FXw@mail.gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2026, at 19:38, Harald Nordgren wrote:
>>  >> Inspired-by: Sergey Chernov <serega.morph@gmail.com>
>>  >> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>  >> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Thanks for the Helped-by: trailer, but this and several of the other
>> patches are missing my sign off from the fixup patches I sent. My sign
>> off should come above yours to reflect the chain of custody.
>
> Got it, should I use both headers?
>
>     Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>     Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>     Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

In general swapping the first and second makes more sense.

    S: PW
    H: PW
    S: HN

Because as a chain of custody this says: Phillip
signed off, then Harald said that PW helped him,
then Harald signed off on what he got from PW
with perhaps his own changes mixed in.

sent from mobile
