Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF238C1B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474831; cv=none; b=jt5CzcRzhzSFO4dUkf5eHTBrGk8Fb4FdTvyO/85qUHVsLJ8TxmikYDbxY8mZpQBVAMf9CZ2S18HQRXyb0NQ03s0pIMHdFFKKOXA/Zh284h4VyTZ6KuDsVfLbTzp5EGewUq/FdzHSjQl1uzXtw60vLmHF58/BFme7eSntBzCYGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474831; c=relaxed/simple;
	bh=SKD+GWccwEyWC7kx9zPlI4na0+doh+ya39rPeKZimyA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dvisbWdQPplh6OU8e79ayAS8DgsnYDU4/b7E+9kOQDLZKCIp85vfKvTwTK4bKEc+qRzSWRXBcmUKBy1f6paiUeWD+W/d1RBF9wt+WSMjDs/lN0TKIaAzkPhow0OrdoRdsYdwT4QoHATFhSdRA22MYxUJbqLf9eKgQCB8a7RIfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=prMPU8Zh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENbqWFyp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="prMPU8Zh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENbqWFyp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 01A10EC099D;
	Tue, 14 Oct 2025 16:47:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 16:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760474828; x=1760561228; bh=NitfcqhB+8/I6xYdnf/wD5ZbSMtrVgbL
	Ioaa3VmOWxc=; b=prMPU8ZhG/MuTjPIeyTXAlAgv43ihVzSpIsf3TzUW33THUn6
	4Rha52yxxNRVeMTwiVmIAUEmlXOGTC0TTAA5PeqAY69bPp12roZLDb1eTmdWelpx
	uaTfWQf9PijhiUNUVfaggQn6dhZZjxH0cZWdWkZETVWfIDU8nbV1TwAwWAVBLTJZ
	wRKZss0PV+VAiOp9PF5OXDbsIwWaf9Li1pWVFe8EpjZk7hCSJ8Da4NCHVDFwErn4
	IGVtTJOXIplglfm2imASrlMWIkjMjVcSwkVQkoxWKkr+tjhro332a14LZiNPdA6w
	YM4HocAgOKgzpUmp7xnTK7th07v30XrNXfWnwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760474828; x=
	1760561228; bh=NitfcqhB+8/I6xYdnf/wD5ZbSMtrVgbLIoaa3VmOWxc=; b=E
	NbqWFypXo2PdX9nolvq1NKsN0PU0OHlPiBeK6msNZkGUxaQAKavCCZ+ZOBEQhRK3
	miAroab3YdyOaF+0DPccWPJcJtV0sgZqctQ162qmxk2s8duABFQLqXcmONT7G8oS
	/HkEXHH595wyFW3+13oEn3/9Hkz8c1Dhzc0/CwK5WFhFKMMPs5/JCtuf3+QqyS94
	AKeSEBde9+ZRlsgww8/A2gltYAQDsj4UKMz2mcAe+aewsx+3SCAIL6kf3G1CybvQ
	Q2KRvWt886r+Cxgi81nLx2YxlNQD91vfrbD9zmHh75vpGSqJuUp1ZLXcapldFZEU
	32R8Rqbso+268BI40351A==
X-ME-Sender: <xms:zLbuaEmutlmA3aXjpOjd-os0Kee5iHicL1bRN9ze2F-Cjs-YLvtv6Wg>
    <xme:zLbuaOqeOCiH0wwho3xEh7bT_Q7_4IfVL1mcxC3SGPcuy5VSmFShivnyIrTiUFi4s
    N5SnairTX3TY6lcq-C50Z7GzynSwQojDftnYO4N6CPe3o119GYP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zLbuaMKee0vwKQUZQd6EqO5hXgxNV0nt4ibUdBxsY9PQCG6nogmOjQ>
    <xmx:zLbuaNoOvlBrXNEztgOR0nQctwbN-pFuzHoYQOQIMinDlsyJ1sTS3w>
    <xmx:zLbuaMzrURSfODUO683br4tvm9VzgpNMCyBziclS3yQF3g2ODq5brQ>
    <xmx:zLbuaJMHx4wlsJz9HsSnVxsi7IN9XZmystJpJuUNXShkVEh5jVgt2A>
    <xmx:zLbuaNkIh_Dk6PmB0JHj8YK_5K452iIjkiwaQF72sFLY-LmF9MVWNMop>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66BFE1EA0062; Tue, 14 Oct 2025 16:47:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBFpqMSI4bk
Date: Tue, 14 Oct 2025 22:46:48 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Jeff King" <peff@peff.net>
Message-Id: <c9314e08-e0eb-4de4-8f34-a6b4de69e28f@app.fastmail.com>
In-Reply-To: 
 <CAPig+cSQB0HbhY2L1Y4mkbaCMiZTH72AtQ+qRg=Z0U9_ggkcug@mail.gmail.com>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
 <v2-38645ea253c.1760369708.git.code@khaugsbakk.name>
 <CAPig+cSQB0HbhY2L1Y4mkbaCMiZTH72AtQ+qRg=Z0U9_ggkcug@mail.gmail.com>
Subject: Re: [PATCH v2] doc: patch-id: convert to the modern synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025, at 18:53, Eric Sunshine wrote:
> On Mon, Oct 13, 2025 at 12:28=E2=80=AFPM <kristofferhaugsbakk@fastmail=
.com> wrote:
>> Convert this command documentation to the modern synopsis style based=
 on
>> similar work.[1] Concretely: [...]
>>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patc=
h-id.adoc
>> @@ -7,8 +7,8 @@ git-patch-id - Compute unique ID for a patch
>> ---unstable::
>> +`--unstable`::
>>         Use an "unstable" hash as the patch ID. With this option,
>>         the result produced is compatible with the patch-id value pro=
duced
>>         by git 1.9 and older and whitespace is ignored.  Users with p=
re-existing
>
> Is the mix of "patch ID" and "patch-id" intentional? If so, should
> "patch-id" be wrapped in backticks?

I originally assumed that =E2=80=9Cpatch-id=E2=80=9D here meant =E2=80=9C=
patch ID` but now I=E2=80=99m
not sure (what was intended).

The way I read it then made me change all of these =E2=80=9Cpatch-id=E2=80=
=9D to =E2=80=9Cpatch
ID=E2=80=9D for consistency.  That=E2=80=99s a future change/topic.
