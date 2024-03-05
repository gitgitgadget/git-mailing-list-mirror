Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE259B55
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635028; cv=none; b=iBHiX5llZ+U5XQDnnYHlkzkry1SJMQKF6G3UrYN9DXeGvG9k+OQbN41DpBWqXzq7F7yUY3wy70twr+SzdD2nT/EMyRULvFqdagsEwoWlRyDULTvJ651eylMhgJ8/0WH/gESyOn7ZbPFA0+KJV1YN5UaIdPGULU3adEJ5wMRfCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635028; c=relaxed/simple;
	bh=7+2lQrO10ejpocVuu7HP8qptNk5UHKCpY5bqHQulF98=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GLH+Ge1Lw3I1e1PvqXI4Ej/LfXwAMdRgs/so65xuxy/OtElbCQcb5zkNwNn/zMdUvWRaJ1bQOxNDu02BsiVelg/5+qwdCtaIKvgdoEWRlZ2AvYL5mbK5aROUUFV1v6Ur1s6Ei98Dm0ocGDHQuGmcHe++rpfqGxUsq5364YKY7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=qqXc86xR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gP9aI3Oz; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="qqXc86xR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gP9aI3Oz"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 672861C000C4;
	Tue,  5 Mar 2024 05:37:05 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 05:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709635024; x=1709721424; bh=T6GVdd1Hbd/iDtjuNC+CJQIQo0FvagFN
	ltJLDRARXiI=; b=qqXc86xRX05G9y2chheUlF/9Ct8s3ui43IUpEGNmhFVTGMDW
	VDHXBJuy9oVjKD/OOmqu8pI06KNgCBbufiNErophg60ZMM8Bk10BY1U5QPF/JuM4
	ALJkPyGfm6a9GBJPCM3TxdDktcRAK/4l+Pd6EENvvFEnTdIEB5+hfgiSGoBV2GNe
	JAs+4KnrM0IuFtGQoqV/MPe1lS0fDNzlxAm55+RtfS2dAFSVUpJGryKxrRVg7M4G
	2uiuT+4+cnbM997kpXRUrBhqerRLwHhHKokdzYpSlgPV0pO1oEhkGUgYBzMfI/vk
	/tBP9+wnEgqOMKDU+D/G2d1VH7DdPw+dNPZvnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709635024; x=
	1709721424; bh=T6GVdd1Hbd/iDtjuNC+CJQIQo0FvagFNltJLDRARXiI=; b=g
	P9aI3Oz08svtxm8/ExqUWqVTsHMX9Zc0qjJlpaEEEnfOv/no1rU1MA5y4fqOJoZV
	0f79lgOnU8n8yM6pasAtNJWOFH+St+/7NhV0GR8C8xMGGb3yik1Si6jtXDFabcpV
	nHuxL2D07bcyS3iIaUY7b4FQMe1K35f9BaX9BfS2AWLTGSj1mTXY9cPMtQTho+yY
	wzuH7cipxgqG/x+LtooXqZxq+yTAHSii7ncNw85XtfrfFAoD7yBSfxQ/l1tPIWbw
	TlXAv4JCL84ZdpAV+GEVnx8UUPTdE+J6IHq+FGKLatSTOZsaxgFecqWn6BhClVcC
	sNasJrEaNgnXIVxfme43Q==
X-ME-Sender: <xms:0PXmZbpoAZ5s0xreybY-PTPe5XYmrcWL3wSQM-tL_O03Fea2bJ_KLBA>
    <xme:0PXmZVrPHqqxS8h6kigXinyEgTj_-w9dloZiP-ugYqXL0-NxuePo7SFrFDL-tTk5H
    bAiU5uNe-trbED8mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:0PXmZYN9wUfksOSg1jqf9A5EHHSj_dofy2nI_nSZZd7IiRMGAYVA_A>
    <xmx:0PXmZe6Ozfc2nh5W56fck80UaCRLs7WcNARkkoffuCBmISM0Zog1tg>
    <xmx:0PXmZa5zm5T2rAvERmzB9Pwi5TnqmMX1TS3omjCiGFsAo2laxt_o3Q>
    <xmx:0PXmZQRKAjMKvEKnUFTD13mnA-f5lrp75m6AikXhUDcxZcSKeKL7hYrKhLU>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B16FD15A0092; Tue,  5 Mar 2024 05:37:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83b2748f-0af9-4fce-a88d-a016e85f91ef@app.fastmail.com>
In-Reply-To: <xmqq4jdlmu6q.fsf@gitster.g>
References: 
 <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
 <cover.1709590037.git.code@khaugsbakk.name>
 <d48b4719c275ef06da014b6d22983db9ae484db2.1709590037.git.code@khaugsbakk.name>
 <xmqq4jdlmu6q.fsf@gitster.g>
Date: Tue, 05 Mar 2024 11:36:39 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/5] advice: make all entries stylistically consistent
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 00:52, Junio C Hamano wrote:
>>  	detachedHead::
>> -		Advice shown when you used
>> +		Shown when the user uses
>>  		linkgit:git-switch[1] or linkgit:git-checkout[1]
>> -		to move to the detached HEAD state, to instruct how to
>> +		to move to the detached HEAD state; instruct how to
>>  		create a local branch after the fact.
>
> I agree "Advice shown when" -> "Shown when" is a good change for
> brevity, but I do not think the other change is an improvement.
>
> This advice message is shown when the user does X, in order to
> instruct the user how to do Y after that.  And "to instruct" is a
> common way to say the same thing as "in order to instruct".

Well argued. I=E2=80=99ll go back to the comma.

>>  	implicitIdentity::
>> -		Advice on how to set your identity configuration when
>> -		your information is guessed from the system username and
>> -		domain name.
>> +		Shown when the user's information is guessed from the
>> +		system username and domain name: tell the user how to
>> +		set their identity configuration.
>
> Should that be a colon?  Stopping a half-sentence and connecting to
> another half-sentence is usually done with a semicolon (like you did
> in the new version of detachedHEAD above).
>
> 	Shown when ... and domain name, to tell the user how to set
> 	their identity configuration.
>
> perhaps?  There may be other similar entries whose updated text uses
> colon followed by an imperative sentence, but I didn't look very
> carefully.

I=E2=80=99ll spoil it for you: there are a lot of colons. ;)

Good point. I=E2=80=99ll go over it again and probably use more semicolo=
ns
instead.

>>  	statusUoption::
>> -		Advise to consider using the `-u` option to linkgit:git-status[1]
>> -		when the command takes more than 2 seconds to enumerate untracked
>> -		files.
>> +		Shown when linkgit:git-status[1] takes more than 2
>> +		seconds to enumerate untracked files: consider using the
>> +		`-u` option.
>
> Earlier ones after a colon (or semicolon in detachedHEAD case), you
> gave an order to the advice message (e.g. "hey detachedHead advice,
> tell the user how to create a local branch"), but this one is giving
> an order to the end user, which feels inconsistent.
>
> I do not have a strong objection against giving an order to the
> advice message, as long as it is done consistently.  If we did so,
> the part after the colon would start with "instruct the user ..." or
> "tell the user ..." and the like, and the gist of what this one
> would say would be "shown when it is taking too long: suggest the
> user to consider `-u`".

Yeah, I paused for a minute when writing that. I=E2=80=99ll change to =E2=
=80=9Ctell=E2=80=9D or
something similar.

> FWIW, my earlier "in order to" took an approach that is different
> from either of the two "giving an order" approaches.  I was trying
> to make the description explain what the message tries to do and/or
> why the message is given (e.g., "shown if it takes too long in order
> to suggest users to consider the -u option").
>
> Thanks.

--=20
Kristoffer Haugsbakk

