Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152E37F729
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050911; cv=none; b=pxn6H4kCq/bV/8P7ZVYyAzbST31sTA5fPOAAx9KOsLxZ87DW1Butxl8uYCG2nhN1XGLTXR1DtsPtmIClGIaKvxTqZ/bR7d6GVCpZeroik1Osz6Byy+sPTGQLn18aJUqzdhqY8L6TkGmAjfXfcN+z2Ps3A6RBiB12PHne5Sk5DWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050911; c=relaxed/simple;
	bh=OzNh+5D0X5e7vKWK8zji7Bw1QhrqAWRZyI0EmlipPDE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vF7oQSTMOWpper8bRfWbifp3+wNm+0S99ODHozS99LzlJQ6Km4M0gICDQ6FcDSY4bA8Yc71qMqABh4w7NB1iZnGojmBXSVNx9/HZHOAq6D+MTiiiw9KmNcdigKT1IVRmwCxxhSEW/yj3w2FENl40bIyGmbJNk1yCGQzf6xNgui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N4VjZGJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJR0n5Ue; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N4VjZGJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJR0n5Ue"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86F5C7A007C;
	Mon,  2 Feb 2026 11:48:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 11:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770050908;
	 x=1770137308; bh=lJQfSckGB7IUEomHDB7ogRhL+za08hBC2zLdCuDZC7A=; b=
	N4VjZGJ3nmEz1wZrvHGwvMtTUxHg+5R0MHnkmCop1MBPFqAW9LZNop7daimlNu7G
	5aFAmdArXHGaoF0Iru1Dr9/xxNyHeEdotmMAQt6l5d/O4lKcTJidj4Ce0HJOnAOj
	3i34HPHrHNxEXfFBYTwbI5Bc8gL6zEdt6Urz/ulXdfK3Y4+V9VZ+mtMSL/C3v6fi
	+KQSV/rgdW52+nZ/0iTPTIBfrxxfK+TZvmeLtmuraEw90AzzgfB6hgqGJ4QbTONW
	NRMoHzk+1K57c2OXOYsCuC5CgSjAa871OSoOuwypv0FuTyGI0CwibtHePkAw1ZJK
	KEzI9d8DaZ7v/P0g7kicvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770050908; x=
	1770137308; bh=lJQfSckGB7IUEomHDB7ogRhL+za08hBC2zLdCuDZC7A=; b=h
	JR0n5UeaNh4pHG3yksI58DLcY1T4XO3K7ZWPQQFfFRdCvWccYIZ123TeE2zDfX4B
	r0Q6mhkleGE/pJ8K8j0NE+JlEmQ/zUYJkxBn53ewYpU5NH7Pnt1XdsoNWFJsRW/h
	JmZZ//fIlUVoxkvJlvlV901z18NA5nkz0RA13LAraefjmv1ZC8PUEapxQ43QmqdI
	KOxFERCPy+1wECjo8eG5MfuKKpMVFkL+YobV6X4UjfSXLuC7aPTpMBH9TkOtrbQY
	Xx4UoxYWz8YneiWplDUxjFeFiJ/OFcuOa45yRY11mc7/4q/7/FIptbQ5SOK+lMcY
	no5k9n5iaQevLBwgbyUeA==
X-ME-Sender: <xms:XNWAaZHmFDwoXY8W3QuWl0N_17kap0JnpPkAsvHAq3A1mHq0XKraEog>
    <xme:XNWAaZJFR4PvQBDgVeYqiZmvTm4C4JKn4osPPH5Im_ZoNkqfLVgzi3TrvoFpuuW_u
    8VXwnoZimcpOUzdquRd1zq-XR90gMKj_RblA6S5Wmo_2QXMopJYkpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhknhgrhigrkhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehkhhesphhkshdrihhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XNWAaTfVF4xOng4TsykmCHxcK8NpmPmoiLrZgPIQ2oGbbNoPEvmp6w>
    <xmx:XNWAaZ6gGN9fu-yGTYchDIw1HqtJG68qbaPB1b7cZ9ReYuVru9kPqA>
    <xmx:XNWAaasrJ3trDKGHIdKGfPuZnKwi5Ox3EMxA2YCRjP04EvwmDOELcQ>
    <xmx:XNWAaZiZ2n7e5ieaO78SHhq7SE0ZKBCTOBwEQTfEswiKMugOqk3Xmg>
    <xmx:XNWAadoHZKMjYqKOZrWpSArluuCUc3MFcglumyjK78pCM1abc8weUQDV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A4AE1EA006B; Mon,  2 Feb 2026 11:48:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AS2MEUNsH-lk
Date: Mon, 02 Feb 2026 17:48:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Pushkar Singh" <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
 karthiknayak@gmail.com, "Patrick Steinhardt" <ps@pks.im>, kh@pks.im
Message-Id: <fd0da056-effa-43c8-a387-1db02b5636c8@app.fastmail.com>
In-Reply-To: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
 <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 2, 2026, at 17:22, Pushkar Singh wrote:
> Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
> is given by downgrading INCLUDE_ALL_FILES to include-untracked.
>
> This fixes ignored files being incorrectly removed despite
> --no-overwrite-ignore, and removes the stash FIXME by plumbing
> overwrite_ignore into unpack_trees().
>
> Add regression tests covering both overwrite and no-overwrite cases.
>
> Changes since v1:
> - Use OPT_BOOL correctly for overwrite-ignore.
> - Fix stash -a cleanup when --no-overwrite-ignore is given by downgrading
>   INCLUDE_ALL_FILES to include-untracked.
> - Add regression test for --overwrite-ignore.
> - Adjust no-overwrite-ignore test to explicitly use -a.
> - Add Signed-off-by.

These patch version changes are supposed to go after the `---` (after
the `Signed-off-by`). I guess people who are comfortable editing patches
write them manually in that place (unless something like b4 or
gigitgadget does it for them). I prefer to use `--notes` and let
git-format-patch(1) inject it for me. :)

>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  builtin/stash.c                    | 14 ++++++++------
>  t/t3905-stash-include-untracked.sh | 16 ++++++++++++++--
>  2 files changed, 22 insertions(+), 8 deletions(-)
>[snip]
