Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBF19CCF9
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264240; cv=none; b=L9v+nw3SRzZWKrjLiadD8YhUvj9XyYa+DCHECcBo8vWx/ewXlBn1pQ5jr1vMKa7OlBSgVhD2c2uqTEDyjT924dbUVKK4i/DY+lr8s+2H0MvW7Oyj+FAImpV1v0qxBXZ+8BTBSf+/rSbLR5j7JoORE4Vb35fEfK3Gs7nDK+/+WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264240; c=relaxed/simple;
	bh=dhDXApfQXf4fVbLuGMfdAfLXIIflU8N04Elq8qiJgzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4mLT1Imqcg1gsDr2UwhvRIddefAhoBmvNGJAEHdaaRPUReuMNnTonZBIzdgtRLE/cvMEEXcmpQffLzSS28iJwpZfjP01ZLZN28WGJJJbmdrKk8wemWVaP35u80fSSYv3GSQXQ2T0RkEwYSK0VQzSmAdGFLjKaKfE9ngX1tcFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8vSYSjl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8vSYSjl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C95A2114010F;
	Tue,  3 Dec 2024 17:17:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 17:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733264237; x=
	1733350637; bh=p+N8q5MO5zi1+bZfm7Hvvk34bBb/22thErzcR9d/1cE=; b=n
	8vSYSjl8fWW5Bq3V9ufRtHkhvp8Gu96mdXmFF7dCbPwUkNmi6isu7eQWTMf/o/fS
	8qsD+CALvWs9HX+zWA2idYEISMmrmvQXyHMrTS/QUTwHqKToLcWd740DA4HzILOX
	c4JaeGuP28UVU++xuixJAZyPSXM7AtGwdX1tPF7yK5IjZ4Xp3ezjyacdgK0thT8k
	8OqUBk+QnY4HZkT2cZEO629S7FoAggi3OGvzMh2LNFTZVQ0H5n/OzvLsT2aZTDcf
	rsbETeZ2USbysfFzb0KUMGLGGENOTATAfXO3ozQhUXvMuswhBBx8FB5vWsdZ5pdz
	34MfSaNZgDUEo1xJNd5ZA==
X-ME-Sender: <xms:bYNPZ4DumRYGfed-y8KYDlVTfu3vDuZjBATqy3VfS6PgdE8huinuIA>
    <xme:bYNPZ6ioxxG0uPUKZJB7tACGlIqeuxeNEcDM9LRam3qlsdD1M2TdJA0YWuWRc00gU
    x-vYgGzGo4OT1tcKg>
X-ME-Received: <xmr:bYNPZ7kXyhV5cjNazS67r3RtGzIjIJ0D1ih4LOoAaFgth3RoVmIvs48woSF1-1m3Y4tlMqi7eeM44mPCN026SQCjV_EC5-qO3bwPSvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefh
    gfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bYNPZ-y7y2lWMyiLT97gmzu6gnAV99FwHUfvAYpqobzmJIovgC6WKg>
    <xmx:bYNPZ9TPaDjC5bS3-pdZy_0Cr72SAU3Xzyo2R0vGBgeCqEsJiNklwg>
    <xmx:bYNPZ5aRrx9-pbDmK9xfgOfPHozgZCQ8HeNSYcUvcZMsFKpt4GDlfg>
    <xmx:bYNPZ2RSc_dabkEw7UNXORjc8mDB6t1s-Y1eF8K4GmNRWdqwfEO8Xw>
    <xmx:bYNPZ4FgAnTuD1kg4Y-EAb9nz5Etdw3RCAhb0L0rr51MR52JnRlHNTd8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 17:17:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] fast-import: disallow more path components
In-Reply-To: <CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 3 Dec 2024 00:01:51 -0800")
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
	<pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
	<20241201214014.GC145938@coredump.intra.peff.net>
	<CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>
Date: Wed, 04 Dec 2024 07:17:15 +0900
Message-ID: <xmqqwmggbedw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Sun, Dec 1, 2024 at 1:40 PM Jeff King <peff@peff.net> wrote:
>>
>> On Sat, Nov 30, 2024 at 01:09:29AM +0000, Elijah Newren via GitGitGadget wrote:
>>
>> >     Changes since v1:
>> >
>> >      * Moved the check to a higher level, as suggested by Peff.
>>
>> Thanks, the code change looks good. Is it worth tweaking one of the
>> tests to do "R innocent-path .git/evil"? Otherwise I don't think there's
>> any coverage of the file_change_cr() call at all.
>>
>> -Peff
>
> I would say yes, but since this patch too has made it to next and is
> marked for master, I'm kinda tempted to just leave it as-is...

It is perfectly OK to have a follow-up patch that adds a test or two
;-)
