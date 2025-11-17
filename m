Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59DC13B
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763339111; cv=none; b=AAFTxYdl1tZc42vFR0ggpswQoXLGI06ygyNYLcDzYyUAWk0HkfQ/356d3ZB6dTM/GqgaHULvHaGiaYXqDVp6j08+H6I52l/byOusl4at0HKwjIj+FWYIEzmMbqlU2m3bI2USCTcmqU8S2cllfuU/tdsHOF8Tsc44lDS4yC5J1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763339111; c=relaxed/simple;
	bh=1zGa+eG02wyQPfo2OcZwgX9m+qaHZYdc3zRvLwrIBgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qMgXEtMZaSRNLB4NSt21nvr9MwA4xRIlwyaxLtC1S5h5SYkTneqBT9L0GstSdGZL442dhnXAkog35Vh5JKmMjTa6oiCNsc+JnS/bX5W6OJ6Kl9QmOt+d4bbYDqrLlBejcMeXh5U5RiAjKi9CR8Vit8i+6m/aFa5+VdWTvrZm7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kfpPqd7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vgtXggz3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfpPqd7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgtXggz3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F6107A00D4;
	Sun, 16 Nov 2025 19:25:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 19:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763339108;
	 x=1763425508; bh=c5q3Y5gms9LTZt0zmAWN9q68j3NmkERFQ7wk8P9Vm7Y=; b=
	kfpPqd7kqC1+l60lbdTsW0JBFLNCJ6DGg0+Zvz/nLkd8DZv8Zw+xKDYvDuKS7dAm
	O9HrcF6d9NPMlDMqn2hrzWcHZ+AgPaTKN7izCg0MPhdCFvL4OpZi6i/jCc/G7ps9
	0AIQAIMebDwY6nkUzUCtfQtdad2VnXyc+EvdhzwQn3MW0U8XxwJRZOlbv4t50GVE
	7o+iuzNiHmnkm6I4wfc2v/632P6iqk6Ahq6w5BMkcP8htxLXBgk8LDnds7+Wuv+Y
	+Fxwuo378QlN+JZzfkSHgMc0XRIUDqdUEZwSg8x9or7vnpQfgoX4AwInhetFEWdq
	LWVOyArjGGJXZlKNcR7c0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763339108; x=
	1763425508; bh=c5q3Y5gms9LTZt0zmAWN9q68j3NmkERFQ7wk8P9Vm7Y=; b=v
	gtXggz3GZi5LBB9fXdPT21EVelXtZt+vMvvxx+GGqTM8macFG/A/rm1JmUH2uSPl
	y2kMdNAl5xiPVYsKL7EBMWyMANph4AmOqYdlvs8zGKUFOZy8m0DwPqxPaRx6Y5LB
	zUZuD8sE6ITXAr6mt8dT/wrI5OvOQRoaLy0uKi1L7Rq978KLcDCKRQ+2W9FoBiG4
	Rq1a2Rm95wwtvBjoiuj0ASJSwdAyVz3dFAGJne2k3zgqGybzf3hZc45hh7u00/C7
	hxMQ+X/GepBiQe7zVHlgEEvMBz09f90upiGkqO5QrqLH0v3CtcOp1GF64B0279Wa
	QHcKc9uxItpqHTRWTPMIw==
X-ME-Sender: <xms:Y2saaYmOtmkLcTCUO-LGX08or5xNqQrgPb1CRj6L9ydJwN2Z5GO5fQ>
    <xme:Y2saafS95-zwbiVhAQZhGtF0GkTcRzHfsUoV82NArndUW-61durt5kKdE2ct-mEMN
    spIf-0XhyLzspvOJumDh68WI8oY5QR9FIrZs92AknS89nA0VWvEhQ>
X-ME-Received: <xmr:Y2saaUAhw_ye1Tj0bcCpWNo0s2XFQe5uBg-B6DRnC1AIvGLigTolC1k3QdeVWV2_Es_PkHYxQSJ_FnuMLwx5cBSnnJ2QqUFgTWye>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvueejhfduleegledtudegheeijeffhfehheeugfdtieetfeevvdehgfdt
    jeehleenucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y2saaeQrv_7Adq4genieWOhNAbEETelQntwyEXuSG8hpF9D7X0zvMA>
    <xmx:Y2saaaoDZtEqwy41xt-fqN_tbHpKN_AYDo3OJoixFwOIj1ZHR-vCxQ>
    <xmx:Y2saaYzMA6fvOGX6GOhiwuMPCDnT4PtvC721ibCNYjYIryRjkcai_w>
    <xmx:Y2saaXLpRu1DJWEyj4avzEmFx8E0OO8XBQqTC4O8pqXcq5OtDEl7lQ>
    <xmx:ZGsaaQ_BsLpD11P1M4GcpqN0totBmYiItN9OCGwMaeT2OaVNyZV3JYIV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 19:25:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: CI Failures (osx with p4)
In-Reply-To: <CAOTNsDzqXZVMhW+kuWG_ZnxSc0U-g01AXkG7EbP8HXzR16LO7Q@mail.gmail.com>
	(Koji Nakamaru's message of "Mon, 17 Nov 2025 08:25:10 +0900")
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
	<b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com>
	<xmqqv7jcgy8y.fsf@gitster.g> <xmqqqzu0gxq2.fsf_-_@gitster.g>
	<CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>
	<xmqqh5utdhfv.fsf@gitster.g>
	<CAOTNsDzqXZVMhW+kuWG_ZnxSc0U-g01AXkG7EbP8HXzR16LO7Q@mail.gmail.com>
Date: Sun, 16 Nov 2025 16:25:06 -0800
Message-ID: <xmqqms4lbj4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> On Mon, Nov 17, 2025 at 2:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > --
>> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> > index 50628ee2dd..16ee593d30 100755
>> > --- a/ci/install-dependencies.sh
>> > +++ b/ci/install-dependencies.sh
>> > @@ -7,7 +7,7 @@
>> >
>> >  begin_group "Install dependencies"
>> >
>> > -P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
>> > +P4WHENCE=https://cdist2.perforce.com/perforce/r24.2
>>
>> Just being curious, other than "because it is newer than r23.2", was
>> there a particular reason why r24.2 was picked?  It is not the
>> latest that has arm64 macos (r25.1 also has bin.macosx12arm64
>> subdirectory at the above distribution site), and r23.2 also has
>> bin.macosx12arm64 subdirectory, too, which makes the above update
>> curious if it comes without explanation, given that this would also
>> affect Ubuntu that slurps bin.linux26x86_64 from there.
>
> When I first looked in r23.2 in the browser, somehow I could not find
> bin.macosx12arm64, so I looked for another version that included
> it. It now exists in r23.2 as you mentioned, and I totally agree that
> it is better to keep using r23.2. I confirmed r23.2 runs without any
> error [1].
>
> [1]: https://github.com/KojiNakamaru/git/actions/runs/19413263298

Thanks!
