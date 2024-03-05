Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F512E6D
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658086; cv=none; b=pnVWEIM199HOljuljpQM6vDjmWD7CTlCfkdDdgQkx8FbEciUgYIyvcpr7QaQWxnJ/o+PNx/Nn1MRqGSINQCa9cYs0PuSn/Miss1FxHy8qONeWoaFw4VN9tfRD+xAxgaFL+kOUaOhhtca+IIDipEwYizN1/LRjBfy4Bg9+0O8HoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658086; c=relaxed/simple;
	bh=Yss1GtikzAH6m2TopQTq2VbMOmJTu/iDpJPv5Rq8Vvw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lnvLWBAPlwrZk87BibXLnt2AvgK36wNAjdXYbxy5+8Z6peWfu9m2rgLc+I5tEhBBhHMAPMPM4yzr6wFTRBclLZoo0jeRyozqExxg0/ZkGXcaf1eCAj/FoZ0F0oRiSsEAPKwvtr9Tm0fSNlKTycgiC2mMOaNE00ZSmboTLe+k+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SO2TqAyH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlVJz62h; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SO2TqAyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlVJz62h"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id A2CEF18000B1;
	Tue,  5 Mar 2024 12:01:23 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 12:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709658083; x=
	1709744483; bh=Yss1GtikzAH6m2TopQTq2VbMOmJTu/iDpJPv5Rq8Vvw=; b=S
	O2TqAyHHGq/KeEWsYMflgz8kCGcBm+v393Ek/YQFiXwZdE51I1x0bcyMOzxaqFHz
	ljOKwR0C7OgzAuvkHQx2F7MZ160i/QJw9tBSTJXIyB7zp/YhOsro+KjAUPX+5NPu
	jzOwdgH91AYNyUJSTB+xLh3J1w/ASF8JBkZqUXtPNwfFPWlrwXG1ZK0jKv6c+tYD
	utnANUhOgghDg1AhgL6HAHVvA2/bxlB2h/acpV/S5Qf8WTQZAOQZByxrQwH8QEK5
	oV/prj7iCZggut0G6sQr2s3bZtV8PFFCVa2GQrnv3GnkQ1qEORxQJ89aIoMBGrT/
	2kH8ZJTOz7Hk+vZJLHvmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709658083; x=1709744483; bh=Yss1GtikzAH6m2TopQTq2VbMOmJT
	u/iDpJPv5Rq8Vvw=; b=GlVJz62hQ0XI5aLXzb8Zj7DknjLqv61jOihxMXjQ+RoG
	AjOepjzx8MPUTiE43MEtGtlc8fFQhy4KaegZs0W6kVSIsa2jfhnNxUgYWGIJR+Wj
	vS9UDKQ1OuWVyo0gHWAIfjwzJB075Ps7x70ZGPI8w0wlOaumiDh2gULBiKu9DwHz
	pfZbaWUwWBj75hcWRjd0kut/57RmRVuerItFKqAn5l66WB+tlJ+/rOZq9B6+bvs3
	JjmLZl05cVXzXkEmX4iY7bd7FynvVZZxTJU77EhGMWQYEs2t30e521Zr+gEO/8lz
	RWXJsxqLpGZ++hJnzQVc20A7DI05z8n1Pc2Nc4mz+w==
X-ME-Sender: <xms:4k_nZUfd-hNGmysAOuuceWoiHtFbO3V9FrYFruY_p23g404PMcTKS60>
    <xme:4k_nZWMdCLyljvBzw_kI6N3zzJxJOf4M5Xc2mSoOrk2o4lh5zjgq4rMAVnufhZdlC
    aqTYY9zYpMsC2WgKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffgheel
    ueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:4k_nZVjNf0I1zdqYrYaLx-q-0yzYtpKyN3TAJkAwDbANqBW7Saxzzg>
    <xmx:4k_nZZ_q6gSxm1RdSlgb8ct8Y2RHEx3eOIrUw0Ah_Yb9i4Xii2STMA>
    <xmx:4k_nZQuEqI-gmkSOlqmyPdbZb93uFRrvYihVdiZ3pyNMsUOGrJjigw>
    <xmx:40_nZcKbeqHOOOvRYYoEU68ug_X4aFbnXKMP6L1S4Ol3PqST2z0w-4VpDKU>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2151815A009E; Tue,  5 Mar 2024 12:01:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <177596a5-dae3-4fb1-902e-7ad74a678ff1@app.fastmail.com>
In-Reply-To: <a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>
Date: Tue, 05 Mar 2024 18:01:01 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: "John Cai" <johncai86@gmail.com>, "Josh Soref" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH] show-ref: add --unresolved option
Content-Type: text/plain

On Tue, Mar 5, 2024, at 16:30, Phillip Wood wrote:
> Hi John
>
> On 04/03/2024 22:51, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> For reftable development, it would be handy to have a tool to provide
>> the direct value of any ref whether it be a symbolic ref or not.
>> Currently there is git-symbolic-ref, which only works for symbolic refs,
>> and git-rev-parse, which will resolve the ref. Let's add a --unresolved
>> option that will only take one ref and return whatever it points to
>> without dereferencing it.
>
> "--unresolved" makes me think of merge conflicts. I wonder if
> "--no-dereference" would be clearer.

Yeah, a `--no`-style option looks more consistent.
