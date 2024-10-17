Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F01DED4C
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179055; cv=none; b=a4kZbKnwwmdECDoXKKQ7XxYXYI0dnyg8Gq/H3ItQUd+08YW/0ub0507AGA9fqQNNwFp0IA9zI6jcY5hptDQF9nZWBwime0OZ61xf3BHMzVzhDdaQcyhZNmMXeHhXBQ+TjivPtxTM6q34+L9AlQn1W0n8zWbJ1HrZE1HYxbuYodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179055; c=relaxed/simple;
	bh=5WVTOaafawEGifxaxGwMmltZDNv3U/MBWcDEHRdlJgI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iRO+FpYUvaCd5ekgpTtQ5de0N7BWDVjEvZbbwO/CLQbEq7nA7Vvb1jAp3mr3Yfw3xM3T5UIIGWrNU/x+X5/mBmi+j8o6BovyjPVuFuN6A1G8BlGoVUZwfVA4KwSK6DpOToYaY9F76msyIegRaC1i5erCjoMGt9oTklpvoWKJM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TgmPqlr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjXvXWja; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TgmPqlr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjXvXWja"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98E86114042A;
	Thu, 17 Oct 2024 11:30:49 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 17 Oct 2024 11:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729179049;
	 x=1729265449; bh=rA+PWteJVp8dzv/KtQu+MpA6ZMzvwHHd2svV66XJ2D0=; b=
	TgmPqlr+glin/bMA8zno4ZYPPYPDCDtjLRI9UNXXpIeqoi5KQYj7MlfTkmeEwoMT
	fF5jeEtZ906u0OC71MM86+Eb/Iqg+Ai8S+3TMZEBtk3N4bCZz0U7w40O3CQG4P7r
	DkYmc+3IqMYA0jIo++47EhwO+kVDyWHnZrtBnPOF5d5Rwuoq78HUcdGcXKZHRkHv
	55Hd40eoTd3E8XvMjXIDsfjLZbxvY1QJO3kYQg0Lk25cBpq597pRVzS87YAviNNn
	j1Rg39XOP4Icq6V669sfxSi2IWR460Bv0amGfp7mEMWBubl/21wUjMQCxXTj+d4F
	jTR2cdVDlgx33mhnMFx3qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729179049; x=
	1729265449; bh=rA+PWteJVp8dzv/KtQu+MpA6ZMzvwHHd2svV66XJ2D0=; b=h
	jXvXWjalC2Bk01ZxW+u9vAxu512rWo9n5jsUpyqt9ScWXTttpXg09dAoRNWab8+a
	7IX1+B4XsZBM6gPMskB9H7lOqXBr37//20Jj2Xm6/fR/EAVs5jZiJowEK4DRfiAu
	chvfiRLYuyO2eHCd1WiTlCDHQWbXNQ/Lvebp6bJieGAWgKKlm4Ze4PE/umXECw2t
	xmeC5QFtS8ETiyr08TsW+CG/4ksMkFVNr2asu1Q7y0wvEMCUyNQEaqiLGKt50T33
	hQcVGiwyAikfhoTWCRTK48gFXQReJ0rLtVa5O5aIS0Ds7+adYORqh689tTig4D2b
	SjLSGITyyr2MpRLAsCwdQ==
X-ME-Sender: <xms:qS0RZyZfLcq3NJck5cLrRrW_Rj4rJYJY4hKXPCoNCvJ5JQvY8mvF5kM>
    <xme:qS0RZ1bDy8sWYmMlXk61nEakxE0UejTb4Shd-p-MBGUEB-GuB1olW6oP3y5TArSwZ
    8vOsSaNnGvd5RgT_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegs
    vghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qS0RZ8_H6XWwM4eMkvGdZ_vMLReenPBBuTnyuvEGwmdK47mxoEBcLw>
    <xmx:qS0RZ0p5xTfyuRZ7HR7ucslxctIZdyRomqTMDtn9EuDuUM9t48TPHw>
    <xmx:qS0RZ9rkiGLZh9YsS6OI7MTVhsrD_mHnoHDwzYYMNowWEPP7yXFAqw>
    <xmx:qS0RZyTpw3ekGB-2XcmtoP4CIZZOF-aX5-uIpvMaPaCFHTc5YBWQqg>
    <xmx:qS0RZxLPpAvSQGLWcam7BD_zfbWj5MYpoUGTYAgCOt2ykgLy8TkXY8oo>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E7FAC780068; Thu, 17 Oct 2024 11:30:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Oct 2024 17:30:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <24297144-c08f-4bc4-89dc-c3d8c12523de@app.fastmail.com>
In-Reply-To: <ZxA5ni7McD1c1yuf@nand.local>
References: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
 <ZxAmBsZzwBuEGN3N@nand.local>
 <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>
 <ZxA5ni7McD1c1yuf@nand.local>
Subject: =?UTF-8?Q?Re:_[PATCH_1/6]_doc:_update-ref:_drop_=E2=80=9Cflag=E2=80=9D?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024, at 00:09, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 06:08:05PM -0400, Eric Sunshine wrote:
>> On Wed, Oct 16, 2024 at 4:46=E2=80=AFPM Taylor Blau <me@ttaylorr.com>=
 wrote:
>> > On Tue, Oct 15, 2024 at 09:03:10PM +0200, kristofferhaugsbakk@fastm=
ail.com wrote:
>> > > -With `-d` flag, it deletes the named <ref> after verifying it
>> > > +With `-d`, it deletes the named <ref> after verifying it
>> > >  still contains <old-oid>.
>> >
>> > It looks like we may want to re-wrap this paragraph after tweaking =
the
>> > wording on the first line.
>>
>> I think we typically avoid rewrapping after minor edits like this
>> since rewrapping introduces unnecessary noise which makes it more
>> difficult for reviewers to identify the important (actual) change.

I was skeptical at first.  But I saw that this line is only 55
characters long.  So I think (like Taylor) that rewrap is in order.

What if I make a commit with just that word drop and then an immediate
fixup! commit which wraps the paragraph?  That way the review is still
straightforward.  And hopefully the integration part is not complicated
further.

>
> I have done it in the past myself, since I often find the result of
> re-wrapping much nicer to read. But I see what you are saying, and
> certainly don't feel strongly.
>
> Thanks,
> Taylor

--=20
Kris

