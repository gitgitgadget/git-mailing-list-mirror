Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226D9110C
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724909; cv=none; b=UZFDZX1J+nphR77dfau+tS1+z8beqfOjVyQKcdfqCG/zMHOhOkYInAW2Rvc8QB2+IZjZLV6zmzsfP0u1bWuorEkqqiJvAbHvjvEFWewkVJCfKNq8WuuwmXKlF2gUkL17DZnH4yz5llS82MbkfylxZiGYbGdFdgy+8FKv4wJ1+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724909; c=relaxed/simple;
	bh=88HoqHQBY1GMq5il5m9TTzItmb5lIqc9BBj4057/j3M=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=V9Lt80+96OOJKqKZZ77fLjbjKh5UJ9eyjYMLDU1LZtTRK4UHb6VJpgJAtKA0sygnolvdA6isQ2Wm49b2mOjVUpb/GJzgPsxfXIP/bHS+HdVCA8DbhIvx8uyL+dUYyjqIGHedQTSXwPs3vJzRt9m2s8R95NWkZb7A6zgfup0qkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=farhan.codes; spf=pass smtp.mailfrom=farhan.codes; dkim=pass (2048-bit key) header.d=farhan.codes header.i=@farhan.codes header.b=dwYJfYNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FGT2WfLt; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=farhan.codes
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=farhan.codes
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=farhan.codes header.i=@farhan.codes header.b="dwYJfYNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGT2WfLt"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EED7F5C014F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 23:28:25 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Fri, 19 Jan 2024 23:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=farhan.codes; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1705724905; x=1705811305; bh=YXZfxIhZ7HR/h26nFmMPRvDOGC8u86TY
	gCgbB6JAWjQ=; b=dwYJfYNRA+fs8hP6oia1cx9bhj3bl2N25nEZDeBn84Oto3na
	H+CpI9zIw2fvLQedjsVHNDb1xuB9uYM5NG7q/vW3h2wvhDp4q+wpEo/45nM0ugro
	B4PO20r+VUgqd3Ur2J8zjoXO2gUOY5NuLY17sIZC/m3gf7RufQ7/1To2SjL4l7He
	bfXPIo5SvcTrSsqXzvGrrDRc2OSRMP+bBCweBvh+G0EC7AHM8+5av8YTW1uYu0Oj
	rebluPn2x4LcFWAWAKQxponbLt7o1Zv/Js9ssZENmPPwO0lLggHP1G7QxPJ9y6+S
	lHlFE/qUvQsTM4wYezq7JmMpA+oDgZ1ZZLn6hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705724905; x=1705811305; bh=YXZfxIhZ7HR/h26nFmMPRvDOGC8u86TYgCg
	bB6JAWjQ=; b=FGT2WfLtH2lPKee8TKIpZRMS4lU39VaXL0oXr5YZ1v3rSaY0ipl
	zDzlI3CtcyGLDhdv2xhz3uCos25ptjeEYYJWvP5ATKkHfRfACe0NGTWZZSz08AKh
	w6lQ1I2I/pVEqrHM8PMYZ0AzR9Tq7td92NHhlZ3lxhdw+yOjL00TooXUkH2I2Pyp
	yE9/aRbfQW04z6S/aujI8YkaN3fg6KXKr7snV/QdlR49ZEdq3S49wQOKu1eCsOOe
	Rxnv+4kSYMnUR8nmIXCBI+A3dHiYWTIKcfm/ih8AlSf42zXsrv53rlkwbM5hYGRk
	FnTc2ACT/ZHpNE4G5WKnEfUIrvTYFMcL+8g==
X-ME-Sender: <xms:6UurZS6KEafb2FPpIYAD-xwRaw6yTkGL0twskllxBwbTfXOv6Tn3aA>
    <xme:6UurZb5F-3L78BCWqhGmib7BhtPX7gEoi0lc11zd5SDz7g6PUbeSYC6By6qTQbbWv
    __N_N7CH7ZOYQhej7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekuddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfhfgrrhhhrghnucfmhhgrnhdfuceofhgrrhhhrghnsehfrghr
    hhgrnhdrtghouggvsheqnecuggftrfgrthhtvghrnhepieejtdegteevhfegvdefieeghe
    ethfduudffkeevffejueegudevfeffuddvheegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepfhgrrhhhrghnsehfrghrhhgrnhdrtghouggvsh
X-ME-Proxy: <xmx:6UurZRe-LbxYQG5XjfqzpyoDV-2JS8Ct1svlKj9Az1vS6TGjzLdHUA>
    <xmx:6UurZfIFWqyCh28zRvrDJwU0EoGhP1iB1Q7r3uCp9DXNHWs6QfENxw>
    <xmx:6UurZWK4B9cZX1sp75lOUIrRphomFY5tBAWP4Rmb2uKF3X5Rx2oTqw>
    <xmx:6UurZbXMC4XrWYaC88uW-nO57b36EX5bcfPXqsM7c2RaEE19QdqUeA>
Feedback-ID: i61914458:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 941E1272007C; Fri, 19 Jan 2024 23:28:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <afea6dc9-e557-4730-abe6-00947f77be06@app.fastmail.com>
Date: Fri, 19 Jan 2024 23:28:05 -0500
From: "Farhan Khan" <farhan@farhan.codes>
To: git@vger.kernel.org
Subject: How OBJ_REF_DELTA pack file size calculated
Content-Type: text/plain

Hi,

I am trying to implement REF_OBJ_DELTA, but having some trouble with offsets (sizes in the pack file) that do not align, specifically the size of the whole object does not seem to add up.

For example, consider this run:

git verify-pack -v .git/objects/pack/pack-48269bdfe1d28d20f603c6b23eed5717b7474e76.pack  | grep 82daab01f43e34b9f7c8e0db81a9951933b04f1b

82daab01f43e34b9f7c8e0db81a9951933b04f1b commit 94 101 82749 1 ecd0e8c88ed8891da372f5630d542150b0a0531e

The size of the object is 94 bytes
The size of the entry is 101 bytes.

My patching/reconstruction of the object works, the compressed size is 97 bytes. However, I cannot figure out where the 101 comes from. The size of the object header is 2 bytes, the OBJ_REF_DELTA is 20 bytes (the SHA1), but that does not add up to 101 bytes.

I am trying to understand where the 101 bytes comes from.

If not, can you please point me to where in the code the offset size for OBJ_REF_DELTA is calculated. I tried myself from buildin/verify-pack.c, but there seems to be some multi-threating/processing going on and I was not able to determine where the calculation happens.

Thanks!
--
Farhan Khan
PGP Fingerprint: 1312 89CE 663E 1EB2 179C 1C83 C41D 2281 F8DA C0DE

