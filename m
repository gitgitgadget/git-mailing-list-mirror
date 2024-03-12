Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D76FAE
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231245; cv=none; b=giHKHsHr8kfWCND7m6xHJOmXXcZtsNB33F3XuXakeYLEQcurYSK9GuqLYUaEIp76FsXD7iK7+HVB2aiYjUJE+82N74d8Ktjtt3W0YhdkD5fE5qQ3Ft3BajtefVavC9EBEXDEHYJ7bGS0ItBDfeuqcvvGgjRpcHrSPiWuJHmhCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231245; c=relaxed/simple;
	bh=C9LcMbc17n9gjdOqw8ZUs1RGDAhY4cytY0WZy3X1Lqo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cxUC04CSzOI58UTPAPbTGnnzu0s1D2C+2DdF//K+3T7SWafaX+NtrCZVCGpBbTgFbt9vl7XNrfhT3YNu8SpcKSeZVuz0gagIUUgAKz9YuTn4ePIVnZtF6UZYKg4Ex/eDxn+yOWpud7oGospB7HYn8vy0I3q4rVLpXxPzVxnJliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=MBjDgmsp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEsFjx8o; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="MBjDgmsp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEsFjx8o"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id E5A83180006D;
	Tue, 12 Mar 2024 04:14:01 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 12 Mar 2024 04:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710231241; x=1710317641; bh=dN1EXzmcKip642AG8tUFaKw4rKLCuEUg
	Dv6AaEfWoEs=; b=MBjDgmspJp7D2Z0LBuNbPJc7g7wJIyn4yvRNHcb2th9NbRot
	+ffYmeJhUMznVjEs4XxrkpH7xUeXeCV1hCFE4pvR+OvARvq5r2qUhH/ZM0ttAYdS
	jT41qx8+9AcJuCgMbMwNQRTb0e2x3XBnaKJBoIPY8SjTFtcNE/Tvu9vemN3tA+8q
	u49/G5XUNjiBBlfbpLM8ec225gr0OTOkWGXiXEPCmsMoVVY05VTr68mqtfOaS+hd
	YiHbZ9G+XjbzGNd3ZVRvKvVonTvQIn8w0JSGcFE/Kld4Pl5pBYmy4DiOz0CeOj8f
	W3wNzHfz8WKpWDhE+SAynqsDHRflppesjJghUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710231241; x=
	1710317641; bh=dN1EXzmcKip642AG8tUFaKw4rKLCuEUgDv6AaEfWoEs=; b=c
	EsFjx8o6QNJfa01tq9jqqrB/rWi/Tnh+TM/D9neRUJE8yjlMSOetB/r8liEYS6c8
	S1yTSg3ES36j77HiLqPfBneut+j7ggvQwaIA5iCKKNx09v5buoInpFTKyKa3GQpa
	OzXzmuNlfuWDkOnmh7Ymx5pBoLL4rGe7TxRj5CRjCZHeQbSwUZmao7FCzeKXi+VY
	PJtbdyE+zGpgXW8gFzT+YO/ynBCUQ/RsuKzSC6HxlmLKMiU2+QkP1BDMEokCiYgH
	14QPJnnDZOWiKzxVf7AfwupVL/V4PZ48kHJUEtl47RcSXk8xLk7o2N9DkQ+VhPF7
	JsEzTd0WdPK578L+aJruQ==
X-ME-Sender: <xms:yQ7wZaWghGScFiuBeawl5-Q-H2S90DbcLoxspM-ykq-b5jWl6VQoYQI>
    <xme:yQ7wZWnA3mp6w5UIGVYCEA3fZ3I9hsHvk1qI8ACgi_DpBdm3jW20_KsykVp3I2Rat
    AXJ3KNMmMRZp38ZCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:yQ7wZeaa4gdblbSHeUttxGsNWKPyrqsnCzSt-SdtoRuzY946nlqDpw>
    <xmx:yQ7wZRUEknd4b1DgW3u9dK9nzQOz_Z2VQ8LLcbOl7fui9xba5M2UVw>
    <xmx:yQ7wZUlfdk6wS5BhhthkWxzZ8gaL4NMu80yOeXw4CUg44de97z0Ahw>
    <xmx:yQ7wZWfENGgHIPj71_HlbBeF0B68H6yTmt-RyUPkCoBb7sWi0ly7_g>
    <xmx:yQ7wZZysyHt2a9iMH_QTbwGLfQnaLvOCG3BXfU7LkYzKfUxXJJwS9xQuKYc>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2F57315A0092; Tue, 12 Mar 2024 04:14:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d677ed9c-0f93-4fb9-a878-62711f9d6fdf@app.fastmail.com>
In-Reply-To: <53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
 <53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com>
Date: Tue, 12 Mar 2024 09:13:40 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] format-patch: teach `--header-cmd`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024, at 22:29, Jean-No=C3=ABl Avila wrote:
>> +--[no-]header-cmd=3D<cmd>::
>> +	Run _<cmd>_ for each patch. _<cmd>_ should output valid RFC 2822
>> +	email headers. This can also be configured with
>> +	the configuration variable `format.headerCmd`. Can be turned off
>> +	with `--no-header-cmd`. This works independently of
>> +	`--[no-]add-header`.
>> ++
>> +_<cmd>_ has access to these environment variables:
>> ++
>> +	GIT_FP_HEADER_CMD_VERSION
>
> Better use a nested description list like this:
>
> GIT_FP_HEADER_CMD_VERSION;;
>   The version of this API. Currently `1`. _<cmd>_ may return exit code
>   `2` in order to signal that it does not support the given version.
>

Thanks, I=E2=80=99ll do that in the next version.

>> ++
>> +The version of this API. Currently `1`. _<cmd>_ may return exit code
>> +`2` in order to signal that it does not support the given version.
>> ++
>> +	GIT_FP_HEADER_CMD_HASH
>> ++
>> +The hash of the commit corresponding to the current patch. Not set if
>> +the current patch is the cover letter.
>> ++
>> +	GIT_FP_HEADER_CMD_COUNT
>> ++
>> +The current patch count. Increments for each patch.
>> ++
>> +`git format-patch` will error out if _<cmd>_ returns a non-zero exit
>> +code.
>> +
>>  --[no-]cover-letter::
>>  	In addition to the patches, generate a cover letter file
>>  	containing the branch description, shortlog and the overall diffsta=
t.  You can
>
>
> Overall, thank you for correctly marking up placeholders and options.

Thanks for reviewing!

--
Kristoffer Haugsbakk
