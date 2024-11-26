Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCC1CEE9A
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607937; cv=none; b=Lg0z4SAaaGyraiQnxQKciOnRYaKGhNH/qlKvZSO5q4Ao5Yewnjxkg6wxRNk7/4kxUQYJLootS80sCDUte3FVbP5XcjUOvQYQafF9utNrZfD4snLgKT4B/eqHH6VF8a5ulLLpxOhCMwr7EkffdSTzyeZjuFfkDEA8BB3lxALhrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607937; c=relaxed/simple;
	bh=NX9wipaxjxeLKdEZ5adgTBYXyQrqfi7zsnLTHdoVAVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oHh7a7+mReGaNPIQAxpzAL+bcijwa5KBQtxWCcd9gAXQe8bJdd+lpxuGNosO6FipNIBgRZAqhVT/ar55SqsXcEQNC+yBud0nC9ht150b3Tiz5Q+mSISj94lzNxpLlaFSckoRQX6WfG2PfaFVn6iBDtdCk6GiBC4AQenkpfQrrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FN8o1IyP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FN8o1IyP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C6A01140171;
	Tue, 26 Nov 2024 02:58:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 02:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732607934; x=
	1732694334; bh=NX9wipaxjxeLKdEZ5adgTBYXyQrqfi7zsnLTHdoVAVo=; b=F
	N8o1IyP9oW263TOmsSfUZPmbRwkAjXCTKvKCREPFHXqekYxMcgnTJJh6GoAVK6Bj
	AzbfgQpxtIIBLJ7wo86NcQwoXPpJLudBWAMgggAPBVLth+LAkU6MLIdS77ZusM2U
	XzSNAyqk45LB7JJGcNJnvYjV4tBqeYZXGfFMA7eNpblJoKPshUVoRc0j6vMiU8Bq
	b+xkLchfrvJmCFfcn/nl3R+qmzBcCN1GhUmOc1YOOjoquAvkxxRvRtoAlGUwnV8n
	YA3VKRAIprFAgJIRObW0SMWJeWvXmrDXzwopjzvRMiZNzbUKIpcbf2lIPD1n0TCS
	4T2HZcgkNK+uzLmEmBP+w==
X-ME-Sender: <xms:vn9FZ7zW-yM9ZGabPqKaElhelki36RqZi8cUy9HdkIoq7OzhFMzurQ>
    <xme:vn9FZzRybdpzWmcXSjOp2-ve1NBM0FO09LNUmAJWSVc45Gh02Q0E_vbDRlMC8YI_M
    WV5uEMFp6tcY5sf-A>
X-ME-Received: <xmr:vn9FZ1WwhKyOsfUdVapDhSKrUSEW0IFPFsOMqMvYJl6p8BeU2mP3PXmDWy3FJ4lbRDftkZ4rwEGpxh-qyQN4TJX7udn4kWprkt4byZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehlvghvrhgrihhphhhi
    lhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:vn9FZ1jeKjQ8fET142BTHCge1Iuo2arPOmp3oFxtFCshzHxPUTQ9yA>
    <xmx:vn9FZ9B_Zz8dCG-csJKQbOb2XG3N3STStd-7Ljg8M7SxposwJFVIuw>
    <xmx:vn9FZ-LnjLCK4thLc2KrlIaIG9m-DB_gK1m0ojU0lzXnqgcvdHtEmg>
    <xmx:vn9FZ8BYSfft9c9kjAh3D7IpTQSt5PVvHN7VqaIaPlRaJej9yolJQg>
    <xmx:vn9FZ3Dxp4L47siB5K-XZuDUDMa6qISUD7yb-Sb8GHEA1P3GmejvVGqX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:58:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes
 Sixt <j6t@kdbg.org>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs
 in the analysis
In-Reply-To: <eb502feb-1563-b1b5-5345-784673c89c79@gmx.de> (Johannes
	Schindelin's message of "Mon, 11 Nov 2024 21:07:02 +0100 (CET)")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
	<pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
	<444e4a94-0005-bed6-1092-20770c226109@gmail.com>
	<eb502feb-1563-b1b5-5345-784673c89c79@gmx.de>
Date: Tue, 26 Nov 2024 16:58:52 +0900
Message-ID: <xmqq34jezarn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Philippe,
>
> On Sun, 10 Nov 2024, Philippe Blain wrote:
>
>> Le 2024-11-08 à 08:43, Johannes Schindelin via GitGitGadget a écrit :
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > The `git log` command already offers support for including diffs for
>> > merges, via the `--diff-merges=<format>` option.
>> >
>> > Let's add corresponding support for `git range-diff`, too. This makes it
>> > more convenient to spot differences between iterations of non-linear
>> > contributions, where so-called "evil merges" are sometimes necessary and
>> > need to be reviewed, too.
>>
>> Maybe "between commit ranges that include merge commits" would be more
>> workflow-agnostic ?
>
> Good idea, this is much clearer than what I wrote, too.

Sounds good.

>> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
>> > index 1b33ab66a7b..901de5d133d 100644
>> > --- a/builtin/range-diff.c
>> > +++ b/builtin/range-diff.c
>>
>> The changes look good to me. Maybe it would be nice to add a corresponding
>> 'range-diff.diffMerges' config option to allow users to configure the
>> behaviour more permanently ?
>
> Seeing as there are no existing `rangeDiff.*` options, I am loathe to
> introduce the first one lest I am asked why I don't balloon this patch
> series into introducing config settings for the other options, too.

Yeah, I think it can be left for a follow-on exercise, done even by
other people who are interested.

Thanks.
