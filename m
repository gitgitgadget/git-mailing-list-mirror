Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8E1D31A0
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333625; cv=none; b=GhtsntZTAxMRPx+7xG73lMaewcIt8kkcHVV5di75+ZLGOJOs9G//2GOnAAERV+nS722xxPE4JOiOukBFeyulyCm5C20sxZxlQX/WY3ezng5N4WfVyIKiwplmIufpepbtYteF5P2IT4l90rPIpDUK9QGEDZAhQ/HjhvwvJKsYWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333625; c=relaxed/simple;
	bh=MscZkJ8RiBXGxQ6aHzNFKTMG5r6LXqjwAoko3z+I1eA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o9TIijPoBNzpEdnFTWTxc1a1+nPqBZzveCajV05PckgtJsmB5d9dYiBLxprmDorMxgsARD7Oy0n40jTwjdOED3d6mPkRKfdr2r6jpTkZdu+y7bv4cYUHjsSWBh/mPqdIRBq8Di0HO1kckvwvLBwSq/IzvJROvqYCoJJOkyoFOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=barLdhSI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWn1T61h; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="barLdhSI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWn1T61h"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4851D138044C;
	Mon,  7 Oct 2024 16:40:23 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 16:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728333623; x=1728420023; bh=Pd1KcyoL3htrw82p6xvJu5LWE3mIJO9A
	DiJMgBUOIgQ=; b=barLdhSIjizSLelH5Upb3g8EWnMuR5aUPW1Mn6HCs8Kd7576
	2DaJ8e509hDys1iXzPwSrjzyjNcGZhyl8xxwmYdyWMUgsGb7doeKJjFb/RxWAHyx
	62GGXdrRePrTtWI2dEUbef+CwDA1nDnsXkk9xkGAbIEK5BALoiNXsr3LZm5NQNXq
	zUYaOEfwlxCB3OPuyFCMwkJUhBeXM8GbfVyy1mkS8iWTawxwEhORb+zCqjuueR7i
	jdJ0HGcDUAjnKqku8ICwKKVeEc8E+MnpR9sJbVa4vrIHF/FDJ1/uXwYchPzUB7pS
	fzZSXofad/6CY7vM7ytKDIdcyP2DcnagQiCdSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728333623; x=
	1728420023; bh=Pd1KcyoL3htrw82p6xvJu5LWE3mIJO9ADiJMgBUOIgQ=; b=F
	Wn1T61h3d95i+9h7f/dI5GzDtx+qiISEtYoc93KlJO4w7YqwlOjvCQtF3gx04/rZ
	ueGi0QodVTiXTkfJElUKE5hA35FjTfC8blrU2ndLvpLFXiKkiXwYGR91/3KAct8r
	1E/L4BA8W0cIdpfJeVfiZm3B/Tx3Y/JCZynYL2LJ8Qvt/UiJLUYKoAowUo3e6bV2
	QbcstDZVL5rHziVJ7aOo55fGMHT7YuvZu9Po45/ea9xDfw5GmBj1+dPCMPJyuAA/
	4TbYrWjXXR3vk3r5gjxncBTxDbiac/zjNjAp5sfQy4Lnumknf/Dy8qfSUaMEroNh
	PFJYK3/TS79JntkxbVjug==
X-ME-Sender: <xms:N0cEZ7_Fs7oHHdFcP5xSC-7fNwIpo91pSb0o_Fdv5PrUCR3peGXVNDU>
    <xme:N0cEZ3voPjhzE1Ots2RXiDBkRRLUKxK1YuV1BBhiz2E27sM2DufDuZNMNl1b6iqMV
    YLS5MPnQ1D4mMfpEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqne
    cuggftrfgrthhtvghrnhepteekfeduhefhleefgfeuiedvleelvdejgedujefgheejtddt
    veelgfelkeeiveevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N0cEZ5DWa2pbEdcWXTaJpvyrVpcX_c4M9fWWWAM10VuJag5enRJ-mQ>
    <xmx:N0cEZ3cnUyTlOgOxOyKzHFfMtkpeLCTZT8Ge1mgj7W-hYo4fluSKWg>
    <xmx:N0cEZwN81PyDlUEhKY74djBpXmB9qFl1wOxVo5aKiixb5acoHeQoFw>
    <xmx:N0cEZ5kbjvvFs3H494ga7MilUg-jtoqNLDv5Pay32LfTJaSkrs1KWA>
    <xmx:N0cEZ60KxQwHWDXwpJbWC8sJFFxJ3ZiOX6ED1by5Gf_-77NuFZPQ94EB>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0BBF1780068; Mon,  7 Oct 2024 16:40:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 22:40:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <a727888c-9960-44a9-b0b6-a54d5ecaa5d6@app.fastmail.com>
In-Reply-To: <20241007203720.GA603285@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <20241007203720.GA603285@coredump.intra.peff.net>
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 22:37, Jeff King wrote:
> On Mon, Oct 07, 2024 at 10:15:16PM +0200, Kristoffer Haugsbakk wrote:
>
>> This has come up before.  There even is a test which guards the current
>> behavior (allow `@` as a branch name) with the comment:[1]
>> 
>> ```
>> # The thing we are testing here is that "@" is the real branch refs/heads/@,
>> # and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
>> # sane thing, but it _is_ technically allowed for now. If we disallow it, these
>> # can be switched to test_must_fail.
>> ```
>> 
>> There was no reply to this change in neither the first[2] nor second
>> version.
>> 
>> That series points back to a bug report thread[3] which is about
>> expanding `@` to a branch named `HEAD`.
>
> Yeah. The series you found was about not expanding "@" in the wrong
> contexts. So the test made sure we did not do so, but of course it was
> then left asserting the weird behavior that was left over. So this:
>
>> So that was tangential to the bug fix (`HEAD` as a branch name was not
>> disallowed in the patch series that resulted from this bug).
>
> is accurate. Those tests are no reason we should not consider
> disallowing "@" as a branch name.
>
>   As an aside, I have a couple times left these sort of "do not take
>   this test as an endorsement of the behavior" comments when working in
>   crufty corners of the code base. I am happy that one is finally paying
>   off! ;)

:D

> So I think the aim of your series is quite reasonable. The
> implementation mostly looks good, but I have a few comments which I'll
> leave on the individual patches.

Excellent. Thanks!

-- 
Kristoffer but any Christopher-variation is fine
