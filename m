Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC482664DA
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428995; cv=none; b=Gbgi0AD2jmMoXPYQCxdVJzEVhK4fMl3Uj7JfqdWxBKJrjOG6LVtIqRdVi2MQHE2ga2ZzCTo92O40WVDtc3xDPsQf/llOu4TBtYesRbMs5eZLuvf0+wUFRpNZLSknkVtV1wmBEejU86Gu00v50xuQiIqfntjjf86eEekqxVZ5kfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428995; c=relaxed/simple;
	bh=3ccUvUMq/hoFhARFBHZIJ/KzAZlW3gLV+eumK85hfBw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=T9qoRn0hCnHNcAN++qxKqRVbXPkYBnhfMB3SeqKQcHrvfV63e7VvuJhvFWBSjxNlcpyqJ0sK6HYcoNOmFMY3wX/PtT46IcS1DoQQkxg7tF5PiRmw2bFyturOr2YAvQwqMds1uz32qyzl4iXkHSIhZJL5Lb6cgI/kX11rPSFr/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=pLgxZm6F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHvawlLF; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="pLgxZm6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHvawlLF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 883F61C00095;
	Tue, 20 Feb 2024 06:36:32 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 06:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708428992; x=1708515392; bh=3ccUvUMq/hoFhARFBHZIJ/KzAZlW3gLV
	+eumK85hfBw=; b=pLgxZm6FbsP7TThYj482lOsWslr3PhSxHL9CQmGuuuhBz84I
	z8CKsRQS30RGdK5/qcTTfNXuGak29rutIEAzu1q+yThLtO6AMykmVJdHyQaRVewg
	pxvj186S32BXCPmldIqZ9Oxw+X/uBq99VwzyLEtjbExFCJ29cX7+aCqww9Ihm41Q
	1pP0pQilve5Sa/UJWF7pdhaqO5E0z9wlQOvL/DwBGE7FIBs+WE0v28fJkzRFGnce
	3zQ4C5U3qZal+kMDeeM4H3KC6cxG+bIJEiqqVbfVdVeCE47IJGgTlc6knHKHzjOp
	RzGulO3wqT3JaGZ+smYSx43grTXoLlmVBIpGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708428992; x=
	1708515392; bh=3ccUvUMq/hoFhARFBHZIJ/KzAZlW3gLV+eumK85hfBw=; b=P
	HvawlLFJ5mRfS82I8V+rdWxcGDD3ljjcl7Yqq8WPuTsQ1+MtXuwd57aYHw8x4Jg8
	OjxRZapoujOeMv4JddG6UhFSf17q2buc1pStcR6WzeiGozADs4KNLOvdSI+BpFl+
	s5P3ANAv1CpSP2ocq4KRxEC1nDTfPQ6LjTVeAHDkYq0wDuc32VmUl/3AYNmhhrj9
	HVtTbTbPVH+nbyEEVrYstNghTrGXYcNld6kgKlQUJ0adKd091lDfQXQd1m/ETdM/
	VBQyiSED0pyB6t+p7pinATX4pYcGoLiCL9ro394iN34z9NuB0dy+9P8go2tEG7id
	oduiB9gOmyii6SDk+hStA==
X-ME-Sender: <xms:v47UZaGvGVC7TQgabG1UgjwfS_gmwUEX5HLw9O0IxurePw3y298Qh0k>
    <xme:v47UZbWJHP3NnbKVHYq77zSjpOxMx9m3swA-GeJjpin_8YpLS6LPuHl4iGaCclxjg
    GXQfAQSE3JvYWV3tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:v47UZUKYG0m7pTcY1K_fa177CK4SGiJ7hEHUUkWPURTDFMeN7K-1BQ>
    <xmx:v47UZUGMRskwfMKWD1MSE-i94JYh3KmW40tAqJDd6jt7tyfG4AjDnQ>
    <xmx:v47UZQXiO_vdoBGBQFok8sCT0IQomm_RP_3pLtfr9Tb0UGhrtrjouA>
    <xmx:wI7UZXT3VVBNhmkdZa-PiIUSz5sAhM_pAOg4VVVjuBQ5HJfmFmGxknCO6Zk>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C57DF15A0092; Tue, 20 Feb 2024 06:36:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <920a0f61-d30b-49f1-87b3-fb947cb3c33d@app.fastmail.com>
In-Reply-To: <95eb92cb-7954-41c0-b542-5169ed5f9892@kernel.org>
References: <20240220092957.1296283-2-matttbe@kernel.org>
 <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
 <95eb92cb-7954-41c0-b542-5169ed5f9892@kernel.org>
Date: Tue, 20 Feb 2024 12:36:10 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: 
 =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= <pclouds@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore experimental"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 10:58, Matthieu Baerts wrote:
> Hi Kristoffer,
>
> Thank you for your comment.
>
> On 20/02/2024 10:36, Kristoffer Haugsbakk wrote:
>> On Tue, Feb 20, 2024, at 10:29, Matthieu Baerts (NGI0) wrote:
>>> This reverts commit 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd.
>>> Version 2.44 is approaching, almost 5 years after the introduction of
>>> these two commands, it then looks safe to remove this experimental
>>> status.
>>
>> Is this only based on the amount of time passed? Has there been any
>> relevant discussions on the mailing list that discuss how mature these
>> commands are and if they should be changed (with presumably a =E2=80=9C=
no=E2=80=9D to
>> the question about being changed)?
>
> It is only based on the amount of time passed, indeed.
>
> I initially wanted to start a discussion on the mailing list: "is it
> normal these commands are still marked as experimental?". Then I saw t=
he
> patch introducing this status, which was suggesting doing a revert in
> version 2.24 or 2.25. That's why I sent this, to start the discussions
> with a patch that is ready to apply. Is it not OK to do that here?
>
> Also, when I quickly looked at the history, I didn't see any behaviour
> changes since their introduction. Maybe there was a minor change with
> commit 088018e34d ("restore: default to HEAD when combining --staged a=
nd
> --worktree"), but it looks more like a fix than a behaviour change.

All good reasons.

The only reason why I ask is because I was vaguely aware of some
discussions (don=E2=80=99t know how long ago) where someone was skeptica=
l about
changing one of the two experimental commands, and then someone else in
turn expressed some frustration about this concern since they are after
all marked experimental. And the context was some UI/UX problems with
the command.

But we=E2=80=99ll see.

--=20
Kristoffer Haugsbakk

