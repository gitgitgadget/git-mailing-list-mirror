Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129053;
	b=HE5wXmNWds6RbY+Kv2vU55OI6zFDTJ1JNosh0DLuHoXbClcHm0iyzvFYb+iBSTbS67rX
	 /qIA8q0zbbRK1F4mn2MgH9I1tWBA7vrRgkD0EgpUN13NK7kpcIvdovqUiZsX2fDb7Ai+u
	 ZPGB1Yuy2WKiNkFbjVspeMC5DypX/zxeEkJmNp6q0nDYZwlrgZ9rEf6VFi+cyoaYQnz1L
	 BWzixoQhe608JWBGgadQ2EMlApSNH1QIG348ZGuygizYWnV+c8abZy8n4ZOtT46YrrG5y
	 9sMsHhSHLTpF1iuxeJTh0dBvTtYF1kzHF4GAwnaVTTrOyiwAhINDysuGW9pWh5qp2dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129053;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4YZx09bwWMhjw4eSYO+jen//KpmmLlrlCHgfFQoRQxg=;
	b=efz8inN7CWmxd2C1KiCsrjwB39ovu+S8dlM6ORfF7aM2Wm39wCS3a7gzYxt5pzvmYqsh
	 lVNBuG6F8iMqhvrEs70Pi8liGV+LB9/1057FtWa6qHDtFjgsT5sc84zTFLOzVjTB2DUl2
	 BMUfjkBjeu52MZ6VVxKBYAHogAVBo9lZEM6lAi1K8f8p2YD2+NxU7UMpfhUJHHAhBWXFi
	 /Df4iv/+OuZ25nm4lONg7jaTPDegn/n+EXqPX+f8vrN0gwOUQiK7GEHv5u2KZh+umQG6u
	 NA7AE867jcbvgYVL2QIvgiGyvJLDQYEIOCjR1qJBLeJIQ/OdtttKGs6Aiot8InZtBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=d6F30LjW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZoZA6dEA;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F194606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F194606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=d6F30LjW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZoZA6dEA
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 881E21D000B4
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:24:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 27 Oct 2026 15:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793129051; x=1793215451; bh=4YZx09bwWM
	hjw4eSYO+jen//KpmmLlrlCHgfFQoRQxg=; b=d6F30LjWKMOR7ZTzNZCAS29axs
	Ki9cBZgfpoGsXpKDHMou9EP9eoiEMGyOdcaHE+aheYFYLPWHO2O+9kEOQiobWiGM
	T1Pi++iI8aV6Cx2nftl6NCbm+UJTShYKexVka5VMQq4C2a8IdgLlJQ/yiZLsnWSv
	KfJKY4U9RGruRNRYSwJyS//qHbyI8+0kGXScaflvGqzfONyRo/TUw3BQYsWTjE2T
	6TqpgzhQ+yDPAi1v9CRJ0zc+7Jyi+qw08My8KpbNNpFsS+kWamskVsnP1sns2Lel
	MTiSbadLG7gVENxa9IEOgn8nvrIMCBXaUZFqTBCFJolLQBPSd2iMnIXn5v5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793129051; x=1793215451; bh=4YZx09bwWMhjw4eSYO+jen//KpmmLlrlCHg
	fFQoRQxg=; b=ZoZA6dEAYqfIeISo7AaxmvfijzsfnSqYpNC3aXvhUT6rB0knFMk
	E0WzBnuSIfEtMeLeLDwOPMzI7n9gKFoW0qaoKWXgkjyf+vvFqVbktE+x2GF8MHc7
	cvcnE/b8b6rwN4Fyx5Namx04Hii5zL9lZ7oI7veofbO50FUz12srMAsEJJ+w71yr
	9Pom0Tbqwbw5V+7SQznrXcLHYhBqTGTGkV4lI9hK4U4YJlVXAor2+DxSUrgLcYlB
	YLDQJjGTqIPeEC6cvIO2bnPcEUYOlE2XTwQIdbedk4iZgnoj5kA59iA0cvYWS8cK
	gv3wGHYa1iyA0CQkRXl+mJxKcqNRLIw9Qrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793129051; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fCz+RLKjoUh6XT5XSkrhIuQOxeQu6/0uG0ZjeU4E+m4BKDx
	AmbJqWEwHmuWjwGdvejxvSy9v4+3pNZEP2s3ia0O57bwqFLf+hKZDE3tyX9zpT09
	i+xNn30UojWv716T/DlQm+GJcJdggFfO/V4/6VzTZ6UTGQkz+2mZ0RM3YdXNpogq
	Us0ogt1Mp6axBo5dH8VYbsIhUKdXn5ky2CWPb9hiOCXdJBcZCsS0HvVWlyluqhEk
	oYaNc4ifZUnp0ON0/1NrDjY+stYSUltwaOjwQwKcM0hcDn0SezBvzRINhejvpVwM
	LqOa4cfTe3VBaECHWaFCrzIhraTBXt5CoDgGB1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ycTDMshECG+BtzMtEKjDx6vIS8s+6i1MlDTNAGMSiO0=:cVoBSX44qsLjBk22pt2lUjRqeLz5V7OncE11I3ncdAY=;
X-ME-Sender: <xms:WvrgauH05dQpsjfz-DZdvsZdmr_eo4a56nx08Yi4V9G81ntbIk85nw>
    <xme:WvrgagDYBqxhzZ4E-FdZEvlHutPT4u_HXBHYYXnr9ftZIG21El2eo_aSGlCoUFrDc
    P4Np6mcpSQOTbHkiLSjQAVbdsEjXVYBgEgDBmzfrnAPeYPvBQLdZyA>
X-ME-Received: <xmr:WvrgamXMrszXHckGbdvf2w_69yhSsXZSXnNbvpXcGlOo2siIN0-uBVOQ0yDIlHkUmMPI0f6B6hIFc5CpAMg7CUJxoUSyGUg7W1wk>
X-ME-Proxy-Cause: dmFkZTGTDVjzO0/uX7UAhx1Wqgh0Uofp8JO5Hqlz50Jp2QAUq29WqjZCqIGDua+J7KN/tv
    IY3dRbTUg/H6UacOgOMWXi0cO9FVbIFKTbQ0/kijY0FddSdAqe1CJzkMdNatDExQz9Jy3p
    HFBV9pd8ANEdMz/YK5SGJXnLA1yBiN9D/qZ4dy20Uti+E1j4qipuIpAyM76R58q2r4sUaC
    TrMXqLyHMH4J4cB4Qhi+ZqtL68hrXcgGUAS9Eyz31iNJzTdLngGD/ti8M5iwGGfp4J3z4I
    2HH6PWG7cZIBK3g+Q1FFGe1We/+nnsPISmktS6j77aGD6mQc/UyP/loVGd2JuOlgtzj4dT
    xs0+4lLMocPDGO9VXnvSt02MsQjaOHgQkTdRLn1XGwA2d7oHQDdLDgIQtj0p4k06OEXJLE
    gjMBu0gEV7VrHOLkZPtjxj0uQJX7NZNd1i2Atv2ixUiGgUJuRCZ+H6fC6CLKk7WowPGL5b
    +fE4Z7Q5FsD1qmsNUFO2W7lWo2qOtsH4iQKEh9RASmX/uNLwr7CB4ZptJ25/rEU7iX6GRL
    UxFWe1MQUIYEVNIRwKciK/5x1LyLX1Hdxzic7/Z0K79Dj0TXPXMDlytiCqBqNlF5FC4URd
    XKYr76ZyztvF/qbqzvRSBOtuE1Lz7sbiBZIFR3MoFz5RJlndMjDMS55YSK8w
X-ME-Proxy: <xmx:WvrgasokeYf3PPHPnV7sFIhPwRVwE48D0da-9lZs0_8nRj9VxroJQg>
    <xmx:WvrgaqSBtA-QKuxfwfLLeTn7s5jcOZSzkzrVcanNVaVjSiefURBLuw>
    <xmx:Wvrgau2F7SWF3y6sFWQqBKUbmQRWK1x5RysLpvX3r79wI0phIt2Kzw>
    <xmx:WvrgauCxfRygJgNHpVEYZpBuhay6nTIxLuPuYiEJ51_97jIJnbOU0Q>
    <xmx:W_rgaqTOwKVkt7fwS3GXG0x2z7jkT-w60PkANLu_sfdnrJ8Du-YkrNNA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:24:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood@dunelm.org.uk,
  Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
In-Reply-To: <C1614059-9903-4F95-8570-90EC5DEFAE8F@gmail.com> (Ben Knoble's
	message of "Tue, 27 Oct 2026 09:40:32 -0400")
References: <xmqq1p9cv6tp.fsf@gitster.g>
	<C1614059-9903-4F95-8570-90EC5DEFAE8F@gmail.com>
Date: Tue, 27 Oct 2026 12:24:09 -0700
Message-ID: <xmqqcxsvj6au.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> I do use and prefer vanilla Git as it was designed to work, though.
>
> But you also workaround limitations in am by detaching ;)

Not at all.  That is not a limitation.  It is a flexibility.  I do
apply patches directly on my branches when that is the behaviou I
want.

