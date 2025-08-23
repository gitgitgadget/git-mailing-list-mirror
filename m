Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E951448D5
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959215; cv=none; b=IhDK6dyzw2RbOTLorkgRJOnl4nf7N5KCJL9pa9BWCmLbA9e5zbBqAtNLl4NWF8nKgoIsp0s5h1oHnFx41vsabWzpQWysoZQuZu+D0Bs71sdbQop4/NF7z+Ag1My4mHAtKRCfTXS+hNSPf9GO6Ci1W4tg6NFETuKtYFQEZ5Ql9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959215; c=relaxed/simple;
	bh=USeX8vWLY5SkRCnd6NFQz/C9vvjtAQ8xVbeRuh4i7aI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bm7ZdkeYsgNJDicMVEA4C9gaKkUcZhNJcrsMpR0q+YzVj8F2e5qOLwPNOLSEN3T2WsxeTvclrQ4Ryb1To4m6oW0kI4Ay2vomWWRKUB9WTT7M+wVBu3eJ6uA8gy/Pl3knCXqq+Odmpm2P0YXCBrdQ1UYDS/Hz9arz0328+C1wFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MBE9GfUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMep7E8y; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MBE9GfUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMep7E8y"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 19BEE1D00099;
	Sat, 23 Aug 2025 10:26:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 23 Aug 2025 10:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755959211;
	 x=1756045611; bh=USeX8vWLY5SkRCnd6NFQz/C9vvjtAQ8xVbeRuh4i7aI=; b=
	MBE9GfUEmXoIfy1VlTebJgniyiRFD72C77WPKDd9Xm9UvfffaWtcWeQa7H1BXUDq
	BXQqxjsXilOvGU88XCS9N9GoDzTzUqawmf+CQf5U6mWQfOegG3eDHp8mD0HiZoKq
	nOw9SA9hiGreZ5CkLYjeiGFSwAErhgB8bDJXiKd0ZMvI7/OI8lf6XkvreADj6Nu+
	3zIeI8ZSw49/Ka/CVCs0ga9VtD3ezrK89Y65/lR16256rXoL0MbWTDkpuVBYZCsV
	qio18gt27f42mr+e67RxjA0nBYA5sgzoviH1v4bWfwj8Voh7Ovk+JGzH7NwPfE8F
	YcdHwnzixizKBdtQ2Bw7yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755959211; x=
	1756045611; bh=USeX8vWLY5SkRCnd6NFQz/C9vvjtAQ8xVbeRuh4i7aI=; b=J
	Mep7E8yfcgOL6fajIGYBFwgX0yjeyZ2aOk1aoTX+b6gJWattDJhtsCNbs15cq+zS
	GtUAHtUIGi+pP6wM9KkycwAeNMVnQOpSqoynakZSpyuNbb7unKqY97rcAWJr8M8k
	lb/laqXOLaEQ0jTPs77xU6i5IBjJLwclQHDzj4vJlXsR09Yc3GLvcfA+PH58bBdw
	qwgUc7uHQAjoFh4yzCdhbPxgN2AIqY4hRAv8BAxR6brTIx/S9FCf13BkEzn5Cdak
	P98ih092/8qCmMbdZ417tX7J3eZskKT+98z6GqLlpFJAMEFW+XT9eR5WAnnrBhVN
	/mj5kFZwPf+NXe0kAzXtg==
X-ME-Sender: <xms:qs-paHHdD3EMeoDfFy1TqaRQo_JQW9PjbJTxQN_JQ-IEo4HuGymHgZU>
    <xme:qs-paEXr1s7g9oRPXNo3bCKpsLAGNFNzurzypuoOOs7RoCZmzi-UIkAFPYgULNMsb
    4ISrBvU8LENU2AWFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeikeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhivghrrhgvqdgvmhhm
    rghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepvghstg
    hhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohho
    rdhorhhgpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtohhllhhinhdr
    fhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:q8-paKCRBPNmojbaxMSVQThBJvUEOfMEYcPmtWQvVwC5nuOn1_1O6A>
    <xmx:q8-paKQJlMagMqg-jg_X9_uBZs4JWVMGbvrfU5ThoreiLY6UOZRtNg>
    <xmx:q8-paLrB5IQzfJDyy54OXvkZ3ZMRzxhMhYCBC2DObbQ2DgVxqoqQVg>
    <xmx:q8-paDV__wc339NLDblTSDQOpGPgKYbf05VInb3mbgAArK0AZt0OSQ>
    <xmx:q8-paDiFElF3O5z76wfxtpwm0VLstFA02j82VjQ5dM9xDnciUVgQsbNI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8D6E1EA0066; Sat, 23 Aug 2025 10:26:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOa9vZLLinOw
Date: Sat, 23 Aug 2025 16:26:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, "Josh Soref" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Taylor Blau" <me@ttaylorr.com>, "Christian Brabandt" <cb@256bit.org>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 "Patrick Steinhardt" <ps@pks.im>, "Sam James" <sam@gentoo.org>,
 "Collin Funk" <collin.funk1@gmail.com>, "Mike Hommey" <mh@glandium.org>,
 "Pierre-Emmanuel Patry" <pierre-emmanuel.patry@embecosm.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>
Message-Id: <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
In-Reply-To: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 23, 2025, at 15:43, rsbecker@nexbridge.com wrote:
> On August 22, 2025 11:56 PM, Ezekiel Newren wrote:
>>From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>>Upcoming patches will simplify xdiff, while also porting parts of it to Rust. In
>>preparation, add some stubs and setup the Rust build. For now, it is easier to let
>>cargo build rust and have make or meson merely link against the static library that
>>cargo builds. In line with ongoing libification efforts, use multiple crates to allow
>>more modularity on the Rust side. xdiff is the crate that this series will focus on, but
>>we also introduce the interop crate for future patch series.
>>
>>In order to facilitate interoperability between C and Rust, introduce C definitions for
>>Rust primitive types in git-compat-util.h.
>>
>>Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>>[snip snip]
>
> Does this introduce Rust as a mandatory dependency for git? If so, it cuts out
> numerous platforms.

The proposed platform support policy is in patch 1.

https://lore.kernel.org/git/6d065f550fe871cf010409f7bd2a63438cf52723.1755921357.git.gitgitgadget@gmail.com/
