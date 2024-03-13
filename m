Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B344D9ED
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360608; cv=none; b=Uh8mV8JUwwi2UHfUoXOwtNQA9F+qmHwE6pUje6vUUJRrUdK6CwU9r7s8scfk4U2TvXgFWKh6HlP4Wr7YhWy/QECz2NHmsl+WfOrOKNo7GkCGUHHhTTFDq6amkqtb3RmYh1Llj2TaSL13MYX//IDBjO6BRqMy+Y5AiMwHGblVFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360608; c=relaxed/simple;
	bh=5dZA1EeacihZKL1R8G8d/EpYJTURLD0eEg6D6dkd8zk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lMbW6NpEqE+slU0SQ1OwcLbKPs2bXsmq2eTlNoErnMRze5g/bER/+dTs7epHbm++pXYaUoSStLbbGkyKRrnl2nmWEe6jLeFP5ZvGmjfSkugwF2ECtl7PvsRIdPauxXcYwkf8Jn6c2K50/ihTWGK0ERWPM38zl6t9aHZwkxH7peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=i6W9O7SV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ya+Qvc/E; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="i6W9O7SV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ya+Qvc/E"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 183481C000CE;
	Wed, 13 Mar 2024 16:10:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 13 Mar 2024 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710360604; x=1710447004; bh=5dZA1EeacihZKL1R8G8d/EpYJTURLD0e
	Eg6D6dkd8zk=; b=i6W9O7SVkpAM/pRX9LCdfnLn7yHAZoPtGkfuCytYMIKqO8oy
	5WcKP/GmzsCFD+tXW3if0J54JYIbX0gd3PWacyveGkx+q7zmm7L9Y3/ZjfB7K7vP
	YZIsJMitbyU08xG0PsmnVG3VktIijirK7B62UEW8g66lE8PXCPPyJBj1Dvq6T4gs
	CZoIcofsyBKN/qHAbJqpZeRCSKgxsMSswefLf0Mwa5rCJ9Qwkd8nx0kllHmNevIX
	z/ho6QKWeJIpqICpe0WHap0FbV9VIr6dR7vFXKf3amNsPPPxYAqUQ1vqDRqIZwNW
	/AuY8MPbr6+XHuZ2Na3c0+jidOtIKDM3q6/MVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710360604; x=
	1710447004; bh=5dZA1EeacihZKL1R8G8d/EpYJTURLD0eEg6D6dkd8zk=; b=Y
	a+Qvc/Ezzrnbf4gHECwtKuGjv4SwDu2ePtKfR7C+/7dmPRdAOOlnZWpVjUa30uuH
	/knikXDkD1HYMaxb/LRPTIsQOO8ozeRWNNBPdiekziMZxK1kzG+08VR+wFQIFz/d
	NMrkQIHy5Z2AI5KyfWwe2Ftt4scwUirmbHEqMOTh/jVJxRvzV4HTHzaaKRe+OupP
	/6WVb3QAmKW3SKpbH6R6zDx96jXZtUysw/y2CF/Kb9WHs3EUhhGOkKjpNf6a9au3
	+KuAC0bDCrCXLG3C+N/5wq5SxVIJLI/bvyyctHVw5ikmnb4aOmcy4gDTM7+vx1hl
	u8Qgi+E3/wTf5mE5R52Tg==
X-ME-Sender: <xms:HAjyZaWLd4hTzg_rXkV6qOFTGgiqSNrHDkbkKwh7DY0e5UI1GB6_lVQ>
    <xme:HAjyZWnPbpyfpkcNIasdqlQOExv7EMGm3WEmXvzvnPpUY8RdiPNZh_DXZUK_MnRHt
    x84Zle7tafcsXuwOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:HAjyZeb9smNnM2phuW_2HSYYY63-AqMVoRnXsijWm5z32C_LKzDy-g>
    <xmx:HAjyZRUrPgzXnY1gVRFax1zIHlSPP672mVAJ_9dx76zW7ckI7LzNWw>
    <xmx:HAjyZUn6zDovqvybz25gJlVm3jEhmuO_uxkPEcOfkw4wRJmK-YHUdg>
    <xmx:HAjyZWfDVryI186D4sOs3a_h_QU5FfykpzKnU_TtP31wp9iicKVaww>
    <xmx:HAjyZTvAFtksqxUIImiHOjGDiJOHY0vPX7AMIvU7VPaqMZWjUYps6SxOjUI>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4899015A0092; Wed, 13 Mar 2024 16:10:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63cb03c6-fc2c-4fab-8aef-caba19adbb8d@app.fastmail.com>
In-Reply-To: <20240313175000.2148-1-dev+git@drbeat.li>
References: <410d458c-ae5b-40cc-9c8e-97b016c74a76@siemens.com>
 <20240313175000.2148-1-dev+git@drbeat.li>
Date: Wed, 13 Mar 2024 21:09:43 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Beat Bolli" <dev+git@drbeat.li>, michael.osipov@innomotics.com
Subject: Re: [PATCH] date: make "iso-strict" conforming for the UTC timezone
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 18:50, Beat Bolli wrote:
> Reported-by: Michael Osipov <michael.osipov@innomotics.com>
> Link: https://lore.kernel.org/git/410d458c-ae5b-40cc-9c8e-97b016c74a76=
@siemens.com/
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

I personally don=E2=80=99t really think `Link` trailers are necessary in=
 this
project given the existence of `refs/notes/amlog`.

=F0=9F=94=97 https://lore.kernel.org/git/ebe188e5-7289-4f7b-b845-d59a47c=
d06fe@app.fastmail.com/

--=20
Kristoffer Haugsbakk

