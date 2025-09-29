Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108F2C1786
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136322; cv=none; b=i7Vp9utLO40lx+cS6WmSBArP+lYem5RiQQKg0ItRoM78jNtjGQbk3LTNhctrfzEHiuzDbtIZFtlM0g4wtlWQkLMvEfJ7l5FI6pqmK0SWCKWlk0S7j7TolneVtGCjtCDMEr80EZdZc7oLcdLoJsG9c47uahjU0mYzCHSEJYfpakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136322; c=relaxed/simple;
	bh=s/0rvi5Drq2cLNjP6yYshcj4dK+TictZ0yvs5xjT0QQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xs378Qg5gXrVpfPC8XypXT3v/XeZih/ZbyCVlLiLztKGioy76l5vNr8BjFezJ0Qkrsxe4DgRb6LIK3HxShxBxZvmFzsHqhaJLmvogDYl4nvHJ8aAnHFqzvlYPfRB6SsPFFEGWz4VOrbDa2f2FARzfyXgmckv5VdJEkjgBgiwGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KMpVbCgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZA7XnDg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KMpVbCgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZA7XnDg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EAA8EC01FF;
	Mon, 29 Sep 2025 04:58:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 04:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759136319;
	 x=1759222719; bh=Cz5b8J4YNz6YKqx3llKHdnzcIbVZclmQ0aOTlKtpjV4=; b=
	KMpVbCgB1S0MCwMc+QfVFxT++HmXBTrQabznHekqb93iAhl5oX1xfT3VpPq5xSr8
	gUmnsbbvDExP5JgF2V03sfkLeDQL+yEjGHmfm7B6X3LBYW83uCznnWrP7cSiQNI4
	TB0+U1YrUxgu7hUSEB00JEmZ7mKd1N5O2k/X2bg7rGqqXiSFqMDL3EuA4BBz6DYv
	PtW1tAJVgfd3ycLLoLF7nAEigWsB8ZV1Lte/JfvCvWsegmewq6xGYsxk7XCTHCCD
	sQhVPQRpDhkUZ8POqwZF5WQi/biz+oZV5vvLUZDMVeQ+FGXRWVjNnBkVeSzH5xK7
	ZDeeelXE2DFcSEfPwmEElw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759136319; x=1759222719; bh=C
	z5b8J4YNz6YKqx3llKHdnzcIbVZclmQ0aOTlKtpjV4=; b=CZA7XnDgLNcdaUEZ8
	qKoOh3oA6drQr24aHlpQ2ivE38WJKIhLfJrlPtKDEhYnr6vx4bqlAfcOqqoM9Qfv
	rRrqBGsHqmNeTl2r7S/kKHd7D/xiTUZqbjmjWZmj480EKEXK38dI8gHN/fmRwD1M
	g8AGi4Vnm8oH8mkx7Sdyj7XqdTWj/06aMQ9H/WvJF4a69WoOH6Rd6FjMbF9ZPeEX
	Hy4cAGrGaSfDzbV1m21u2t63v+uQf8tDKhFelNddCGo8g9gqdK1lCRF9fbuuK9X1
	cjrQJ+/PoqRBKxJXKoc5/nr5Dxd2wI8Wv0sTtjVPD5jtbVz3hcVmGz2TRgc0lUc5
	GlUWg==
X-ME-Sender: <xms:PkraaOfrR_YeourrPhyz-Lx5VfUinD22HERgcQO_671QqOEY4cQqj2k>
    <xme:PkraaDDPEyF4Vq5yGyobvZ3SSQmw7uLTi-CuQCmgmsoKvCjMtug8KIFBwJGzJruTR
    a-RSmPXU4MQbs1tWnTbvlL3ytraIEnJ3Gi8cMorXALVL4J9SG2fFfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejjeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehhvghnrhhikhdrsggvnhhnihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PkraaNIaEZhyNfn5KIY8rROJq3H1wR-ZCmzyFDnASZRneQvUveyr-A>
    <xmx:PkraaHFg0xrtlItpSgWT_69y6OiIbHH970R7CgIfRQOjZo5MxEVucg>
    <xmx:PkraaNQTmCT_zg1vnj98O7zTfwyAJmLeMqqLNFcvPjrsDiryAsyodw>
    <xmx:PkraaLHUmPPaRfjgF9P3hqXaO3TuvTnQwv_BiM-jp6LC0hiotgvjaw>
    <xmx:P0raaLat1w1YupITvHblCqYmtq1Gxp5EeuGinsCGEUJYosDFbbDCsIt6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4B1C1EA0068; Mon, 29 Sep 2025 04:58:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9j7Cp5uc5a3
Date: Mon, 29 Sep 2025 10:58:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Henrik Bennin" <henrik.bennin@gmx.de>, git@vger.kernel.org
Message-Id: <971c5431-f203-41b6-a629-e06480afbf1e@app.fastmail.com>
In-Reply-To: <FAF6A70E-D242-49BB-B303-A7859CAC8E11@gmx.de>
References: <FAF6A70E-D242-49BB-B303-A7859CAC8E11@gmx.de>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025, at 10:42, Henrik Bennin wrote:
> May I ask not to remove git whatchanged because I still use it regular=
ly?

What the error message you got doesn=E2=80=99t say is that you can use
git-log(1) instead.  It supports everything that git-whatchanged(1)
supports.

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more use for
`--stat` or `--name-only` rather than `--raw` if you are only reading
the output.
