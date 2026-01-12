Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5192C029C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234155; cv=none; b=s9u7omvqi9jv7FnczSooTVd0MaQIkB9sIy/Sm99zcGOH+t6jTwBXODNwTgWZlqr4071JdbCqE2k5yBBgz6UIVQ4cKmX6srE8qvnEhmajdrCdl6iG7E2tycMVsTODGnTFYuxLpUNSCcdLSVHf8U6TUgk9ekMJc0bsGdhkqeFivyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234155; c=relaxed/simple;
	bh=iHu0Lfc9UTeE89hPgxwBjn56M2d5jjtEyn3d76nvYDw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hXl0lcfsgbuRiFS1RgiWVLGtGMY6kyvDohWq0Jrj04p5BpexZ39Nx3irPfcNzIAx6yIbdU/KSefjs9wN3T9IFxEGaREVC9WErNFOuEYTYVlbs1HQ7q4LxHdQKq+R+tTDSpHdoYw/jsAzNiOCZ3v9ppKkIf/ppxLb38FuNoe2HWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PLXmynNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBwnPxiN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PLXmynNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBwnPxiN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B86AEC004F;
	Mon, 12 Jan 2026 11:09:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 11:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768234153;
	 x=1768320553; bh=bXtubmxllvrAKUSCd8L6jgEZapPyGr6CI+8k3pKc21c=; b=
	PLXmynNuW+e69zI21YOnjH28ePWJG25vCLVl05QiXPXhxBEdTCVE03MonAnrk68a
	rDDarlIcOELL0HNlYp9W8Yaw6OpVZDscHYii1JCv2Ku4NbwJpBEPIkOE9fWNqaVe
	aLvTnMOHMm4ifCu4VmfmEbNa3S+LrDoANGZatl1R1VvPmUCXhfZ9jX386sabB4SQ
	jQSfX6Gv9KZ3hT6CwEck7Dqm07xSvoYCG/ItV8M6+I8iQIUhHs0t+e2brAZgK1F0
	Tj148PJFTgRqHN5bj0Vk8GfdDg4ZqG7ZZlo4+KZBtCaracfxHpS1jDiB4mQc8Apb
	RLlQnuM8KH9bFjxD5HFVEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768234153; x=1768320553; bh=b
	XtubmxllvrAKUSCd8L6jgEZapPyGr6CI+8k3pKc21c=; b=WBwnPxiNUujifJaLn
	tmW5byAQ/4PL+iBvm3IEf2yXM9VFjB97yQtkE2eF+PMsPnyAy2A5VVB+9604r7ax
	Q/+FrswLa8mneXqkiYc7ljk4cZV6auhW3243VALpxzfAA8RldLtAmEJCVCj5OQwb
	fByj8dWd7FTesgNchrSVDPpZkv15QOIDapRwX08IAzPPU9kLgH/4Mc8pJSv+7xQd
	NLCT922zzLWz0c8kUlpsrQniiffRC4damKtyY3YBVxx1MTY9RYG8pUuajE/IFtMx
	TYnexCZWAtuy/qmwDwOzMjiSDZtRC1UTgxa4cSO3m3Ca+fq72VAXcQOCLay4TTJb
	dPF9w==
X-ME-Sender: <xms:qRxlaZ6z42psP9UIFALxAhQgNkWJLrBj1Pu_t0WTca1H-owkh3qcYkw>
    <xme:qRxlaRtCiovQoXQDikzB_9Oo1Mg70mi6MxesR9-V1yBE7ETZJYLLaOmTAtxIRcncR
    527jyVP-rzbuxr4abBb0b2uzbL1zoQLLNfKBZ1gLspx4o46WIcXWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrtg
    hmsehmuhgtrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qRxlaUk-Gordnn6m9a8akS8JgdtoHuEdaoGQXAKdY8vKOKcGDS2CqA>
    <xmx:qRxlaRxkSEL1tr4VQCstMMII-UXP6PbHMZ_ULym6L1NvzJWsSavCcQ>
    <xmx:qRxlaaNFWr6YbCxHyI7fKMcQIICVBcXc9mEPU4mSAdNgmGWQ6_pCfw>
    <xmx:qRxladQD3FA12wp4OcnB5b2zN1f5glOpOBYiHgDtp6QUaa7Ril49oQ>
    <xmx:qRxladLJEbCAVNBrGtRafDJgWMdGOZqwYtJ7jzIepQyCQjJKFDi2oT3X>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 338971EA0068; Mon, 12 Jan 2026 11:09:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW75hKX_PcrZ
Date: Mon, 12 Jan 2026 17:08:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Alan Mackenzie" <acm@muc.de>, git@vger.kernel.org
Message-Id: <fefb3d25-3723-4e10-893a-620fbdc0cc45@app.fastmail.com>
In-Reply-To: <aWPFxQloyfx8x0ED@MAC.fritz.box>
References: <aWPFxQloyfx8x0ED@MAC.fritz.box>
Subject: Re: Difficulties using git rebase.  Help, please!
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Jan 11, 2026, at 16:46, Alan Mackenzie wrote:
>[snip]
>     $ git rebase --onto master origin/linux-6.13.y HEAD
>
> ..  This didn't work well.  In particular, I got a conflict in a file that
> I had never changed.  Why?
>
> Well, I corrected the conflicts in that file, git add'ed it, git rebase
> --continue'd, then got another conflict in a file I'd never touched.
> Same again.  After the third such conflict, I gave up with git rebase
> --abort.
>
> Criticism: there doesn't appear to be a --dry-run option in git rebase,
> with which one can see how many files will be conflicted.  Instead they
> are notified one at a time, drip, drip, drip, .... to the user.  In my
> case there might have been four conflicted files, there might have been a
> thousand.  Either I'm missing something, or git rebase is missing
> something, hopefully the former.

Just a dry-run? I would use `git merge-tree HEAD
origin/linux-6.13.y`. Then you get to see what files are conflicted
without stepping through anything.


>[snip]
