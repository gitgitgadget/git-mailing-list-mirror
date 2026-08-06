Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57D432E60
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007998; cv=none; b=UughZlYa+nHEmlt1TgJZkD8AnuyC71eZNfdnJdWXEN6CbLJAt0oSan2rYYPf5YYHRtwUcPbT9gwD7KWiQbe2wWl+KINh1MwQlyzEeI6HnwbmT6l9XyiwBoKhY986V9r5o9TU0acpKY0j/DOREsYG0YU8r+6EU7HljBCADpTGtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007998; c=relaxed/simple;
	bh=OuibsFWRYUErfSwf13ZlF/xgN1if2tJItaYLEXmsnb0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O0/Lrl6984PVx1Xv71nhWAONYzvLosyHE5j3lyTyWnkhLRYHhX0hbJA8MR9VnqVj+1o9y+OCFHKkPqUzJFm+Xj2YvIA6Xlq/deKRHk4OyxTXJ9eteDFmbIzvC/xNgM1cc1boJMkfz96h+lNt3erhkmnf0ZkJGRtR4rSWgCG/yDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F2D/OOnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQPd3ajs; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F2D/OOnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQPd3ajs"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 10EA51D000F5;
	Thu,  6 Aug 2026 05:19:53 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 06 Aug 2026 05:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786007993;
	 x=1786094393; bh=OuibsFWRYUErfSwf13ZlF/xgN1if2tJItaYLEXmsnb0=; b=
	F2D/OOnYzPKYZRO/RWO10VH2ZFP4rhv55/8sMm+aYN7IBhWrQW5JhjiDQhp2ArNe
	yqmgGFon0XAWkyw3VGYzclxX73EH0WvWQNl2nHxBKHrV77W1btZ7gutlnWKsQgcN
	ApD2GBZMXj6zgVxYqdEBm7nTv1/smkSaHb/PkpMMFc5Sft82V+9NTS4iGxMfx5nf
	khyCvfyOlwDvu1yVwX/GJ0Gtu9at+TZhgjqbVbw9f4YyD0LOnLAhEg3/cVvSA1jE
	OvVIi4CzaZs1zPMBeBkJ9WDnIFbHGFcZktNKxbixwktjWmxmFyr+2JGtUh9x5nFB
	ep3qv6bj1rEph2krAAcNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786007993; x=
	1786094393; bh=OuibsFWRYUErfSwf13ZlF/xgN1if2tJItaYLEXmsnb0=; b=B
	QPd3ajsjfz/rvdXjDFtiW94jQ4+KNMLK2x0yvnQ2uWAaSBFSceUjNCkIQgbMn+wK
	OJ2vLxvqGkLFsTIZrK/eN32uniRZe4Mqhqun7f4d3PR38nOnhZJ1azqdp4/BMcK5
	yO9o8fiUfAmXvPqT+778GnbpAS7iRh/nuqai/bbe3IFf10irRxAyhlJQ1BCrclVf
	PDfiXZ36708i2+sfmlC5mNt4pDNG8U6VCx8HuRG0fh55HphOoissssQysmOMp5tt
	p43Mi2fCF7riHE4Az6n6Ml+Spry2FZt2q3iqNF3pnyfGZ9ORPuqn/dVAiDUpwZwc
	4s9c1qMCWqeWuBgV6Kraw==
X-ME-Sender: <xms:tFF0akync2JI92bBh9TxCApi8WBa72YMdgu62DOl-Jx8_Zxy4izbBSw>
    <xme:tFF0ajFXK9GCGj5rLf97YTiSKONUcHJeDqk1nVTDyl1Si6rPp_WAaamgkGVUWJSqg
    l6E8X0p6M1k_sMh2T_ggS4wp7_TBkTCELjaYm3qiaZ_cLpv1OOqeA>
X-ME-Proxy-Cause: dmFkZTEP1KAW4bdkU5AXNdae+39OhadzZd6oliMZ1McVZH7mJLAXeIu3p3Ijg6PUaMI3yF
    Z93VVKEsgI3p+ExIl/MtrE32LvOJOcpMIYekwlfI6IxmxG+T3F3M3IGI4/gHIWBHLO16u3
    XVZ0dsdPKqaVBuTAwWM/76HoB4pSKqboZRJkfqvrOSXR7ua/7Uxvs0dbdFT8RTaGsnzMIL
    RhITb5qBY6vXfKlw+rTxx01+VUCsVpdGdYLK++gHPTc4Wx4lADODnyXV2Y3IL25pk4Cc7h
    BGqdiRpD3M1MzAOzcEDIs4htY7ijFxDzK88hrLiN0Fr0+3SzPwiilyu0tufyfSJmaQEjEl
    Ac1M2QQsXu0xjDOlDJMG1HvErglgcKG9bLmfOP31rgtAIKT+xnEzSlqtbY+iApoKs/vhom
    5K+6DmF3fInTd0D7Z+emeMo11w+S5eKcBHaShN/ZUKou3OapxiirBW23PDUPqaUsOFS88R
    fpDRMgh62+BPuHh9VPh9Fkd+iEZ2eCakqKeKWgOrthg+EKUg7/OwA2aFNHe5g1OUR7ulPB
    rZpO/iMV1GH2JDvgIgTbZZm0DinEFgvseIo5y3XFmU4I+gF0fVA/OiLq4+CQnUqUEBd3kp
    aYRDXE7wwSHAtpybQCgiuaArHZILUFOJhE4Teo0tvyQ6LKbH/n6kv/lOR1Cg
X-ME-Proxy: <xmx:tlF0aqbqcoqcdTfuvIjSOYIbAtQbZyRlUNbFVVPD-T6i-_sBW9ZyZg>
    <xmx:tlF0andsFMk92wURZePOQxSQpClEFxQjgnGJFVJyrvlUUoV9q-y4fw>
    <xmx:tlF0ak10s5ry_9LdfR4KpSTQMjJJCMV4M6A9pK9PpkPmrBBRjFMZFA>
    <xmx:tlF0auKtSqQb3pLSM2vbT0LX_oYDymx5xCSHQ3ow93DKe6MkSaDuww>
    <xmx:uVF0avUqVatt73yb_EUP18HAzgdZ3DZGuEnt5f-wYn0hOtLV9JAsDMnt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2545822C0068; Thu,  6 Aug 2026 05:19:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AU9vex-uNCKo
Date: Thu, 06 Aug 2026 11:19:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunlem.org.uk>, git@vger.kernel.org,
 "Matt Hunter" <m@lfurio.us>, "Patrick Steinhardt" <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <665321c0-b73a-479f-8c03-73ddc9e66e98@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
References: 
 <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk>
 <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g>
 <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026, at 22:41, Harald Nordgren wrote:
> I admit I=E2=80=99m trying to expedite the process. Especially given w=
hat
> feels like endless review cycles, and some frustration that this topic
> was queued for =E2=80=99master=E2=80=99 and now it feels like we=E2=80=
=99re miles away again.
> I recognize that this mindset is not a good collaborative attitude, so
> I=E2=80=99ll try to step back and re-adjust my mindset.

Collaboration is at the heart of wanting to integrate your changes with
the main Git tree.

You already know that you can have this extension for yourself right
now, in fact immediately after you were happy with it. But you want to
get it into the main Git tree as well. Maybe because you don=E2=80=99t w=
ant to
deal with updates to the surrounding context as you have to update your
tree according to the main Git tree. Maybe because you, for example,
know that someone else is working on another subcommand. And all of that
is about collaboration, just one level higher (or one step further?).

>[snip]
