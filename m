Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53E1A08A3
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987480; cv=none; b=HWPBYUxJPqWOY5nObPiZzh/8pLmhjmTgz7nsj7DT+iiveFoPRi7OPZFTPDdXg8em9JyEoPqcCfoXMOGQKQ4fnY4YTjS79eGk5xXMzUTocKVGe/38Skzw315Fd5HhVLnCI/0R9i2jeFrahXpE1hsiscnSOVDgS9d4nhCYzT2dSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987480; c=relaxed/simple;
	bh=rnTIp4wV4UfVWXsyzw02NkSJWaa59Y+XwnUSf0Z/yHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cUBGK+NskIWhdrUCfuEUsL6iEO6nwws/6F/rn+6gBMGZXJbBOUvEepcJgYoGBiCP+0x3dAbrsi8AjrGN0EhSK18JvYKT+cplK7FLmuyq1nxfHMqYTKCIEpM0JdBJkobhjFqWyBQ4yKcphUWjLoTVWSF2S1vAgW9J6sF9LgSH5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CBjzV9eu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMfgNPVy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CBjzV9eu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMfgNPVy"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C7D96EC0598;
	Fri,  5 Dec 2025 21:17:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 05 Dec 2025 21:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764987476; x=1765073876; bh=dLSMPGXtqc
	dT+91Jx1J7hTulGZvRuLAyIPXUtr9EmzI=; b=CBjzV9euU7HBrp3ccb0P6Kg0Sm
	bWSh3QHe1LMN4Eu3YWr8Guz0w2colGLqJppwjSh+/R6nFIyf5JZdMWwdOoSUZ56f
	DBSmE/mGXqiUn24ZK0COu9ug9gvSl93gkye5u70YrxlVv6jEM5UCG5MHxKJfJ/5f
	+M5SlBybFmJA4wu22lz6+4/SJLSB/xcZERlRNccGdDHVwYoYy5PpaN61xd40DtVy
	zaop6HdNuDrzcGi3aQRx4VdGM4noANBPxWYR7RvgQZq46AMQ6NRMVvlpUlcLCn8w
	q4iCQXbzP48uTFit+Xjze/kgDw+cSl6yLsmk+6tdUZo0rgRdjZEq/4VLlOzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764987476; x=1765073876; bh=dLSMPGXtqcdT+91Jx1J7hTulGZvRuLAyIPX
	Utr9EmzI=; b=JMfgNPVynhqrcKekxn/B3Vgen/3JNHYAz7Db/pc9XIKguHLqk8f
	x2QeG0XJX/Jtkfa6LTtoaluKepwYZsLnbUYMq8Cl3ETarICfMpF65i/dS8Qjfprr
	1w11LuKNoG4DatWtEFFsgsr6cuCx0TGO3xf9OMCpYX8m9uWp/x0gwcNIbCjvA+VA
	hvgHUe7D6L32f3c/z8P2MrjUE+86RKGd34moPlsPhMyv+e3akMu5jFbLs2lcqi7L
	Wh+htE5/wfbOA+DqVViqoGtd6wAdy6dJMKruPaSJaI+Wnp19Wovrl7Lff5rdZwSD
	aS4K8xqSMQjguTQS1SCwTzQsm0STUkdZWmw==
X-ME-Sender: <xms:VJIzad5lHGnQRNCeHU5rMfh-zwdA9178F3CxZA_kS0FaZHrxdssdJg>
    <xme:VJIzaR6UcxR0MJ_WJ4-WqoVsL1M0hOoNLt6B7pbjj93IFGW5msALWe_aj4B9ebRV3
    M4dj2_NJ6XiKJHjR_XNujfZBCKnqfON54NUVbiqJ4Zo4lUgoloUDw>
X-ME-Received: <xmr:VJIzaZcS24kHJ-30sDSIBsd8i_27d_JGR8qxizksDznWSSh45AuIkv79kZlu9z2ETMgOjiJVhN24ar5werBFLmZPKZof9--DXi5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptefggfevvdehheeutdfhleejveetfeelleekteeufefgkeejvdegfeehhedvgedu
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:VJIzaVCiTnPJmV5jP0qN2LYrg-maJ3lUwPfToljwdWSTjZOGehKo-g>
    <xmx:VJIzac8xUG1tUbwTVzpSF8Hga4UBSOSKSfpaAzfrvZzc4MD3LY01yQ>
    <xmx:VJIzaQJ9T1NOhY9PUwj_iF0migfi3s0iA9a4DO1gib-Wmgc8mEbDBg>
    <xmx:VJIzaVgZ62Qaz6mudICEds0F2PlK8TcxO-sJf5DsWx21_kNTPD-jBg>
    <xmx:VJIzaQWWaJLK4r64vxjkJE5bE2moFKqbSKRMOjgi4-96tHj48ZmJXOrt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 21:17:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 03/10] mingw: special-case `open(symlink, O_CREAT |
 O_EXCL)`
In-Reply-To: <4cf1c638-3b0b-a36a-ce35-41d55e9fae12@gmx.de> (Johannes
	Schindelin's message of "Mon, 1 Dec 2025 14:18:17 +0100 (CET)")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<96e279f50ebc26084095e781cf58db233fa05b74.1764440906.git.gitgitgadget@gmail.com>
	<xmqqecpgc8wd.fsf@gitster.g>
	<4cf1c638-3b0b-a36a-ce35-41d55e9fae12@gmx.de>
Date: Sat, 06 Dec 2025 11:17:55 +0900
Message-ID: <xmqqbjkc5p64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 29 Nov 2025, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > The `_wopen()` function would gladly follow a symbolic link to a
>> > non-existent file and create it when given above-mentioned flags.
>> >
>> > Git expects the `open()` call to fail, though. So let's add yet another
>> > work-around to pretend that Windows behaves like Linux.
>> 
>> "like Linux" -> "as POSIX expects"?
>> 
>> cf. https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.
>
> You are both correct and incorrect. The behavior I described indeed is not
> limited to Linux, insofar you are correct. The behavior I wanted to
> imitate is Linux', though, not POSIX.

Well, I do not think we require our open() to be so Linux specific
that other POSIX compliant systems (e.g., BSDs) would fail.

Here, Git expects open() to behave as POSIX specifies, so it is good
enough to emulate open() to be sufficiently POSIX, not Linux.
Making it like Linux is purely _your_ doing.

And it would not help future developers who finds this commit by
reading "git log" when they find the code that was changed by this
patch in "git blame" output, and they want to further tweak what is
left by this patch to fit their needs better while trying to avoid
breaking our intent.  Our intention is never "open must work like
Linux, allowing the caller to rely on Linux-specific quirk that
other POSIX implementations may not have", but writing the log as if
"a work-around to make it work like Linux" was necessary will
mislead them.


