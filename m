Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910135963
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497034; cv=none; b=dZhZXmcK6TAX/hsWLndDUu37CSBSPcA9dWmLY5CJP1D8MRLOjxAUZsVnJH/0LVLIiMGLRUjwB5rusk7FB9M7YDTR3nclHH2ti5wwWdWKp0plQcl1ryrh8mhI1JFsvX5bT8mfWowm/ZIZWlKM9PIIxfZE+2jgMKh4rVFCfHtj6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497034; c=relaxed/simple;
	bh=Q+vVoqWU3yffxd4ISZVi/moSH12OM428Wz9TZjTgGSw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wp1xLDqb7gJ8OJPN9AyRs59LxjE9X8WZgPU3zYq9w3fDRCFd1GNJF2DuCwqPmFQnUw34eA+bCeRmtpR8dMQX1f47yqWWzrdqFvVZpFftcDHiqC5a2f9wxUeCyi+rmlKPNTyRKGjkp9k5VhzFB6APW6T3VqTmMkYAMBad4tdbPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hVMDFNNx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=debfa3u6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hVMDFNNx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="debfa3u6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FB48114014E;
	Tue, 17 Dec 2024 23:43:50 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 23:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734497030;
	 x=1734583430; bh=Q+vVoqWU3yffxd4ISZVi/moSH12OM428Wz9TZjTgGSw=; b=
	hVMDFNNxN39915TZtOt7ars1gIMVTFlioRz8eIDM1QfwH7gmvWkToC+2F58ZmfjW
	4nqU93JBdx10TsaOMAM/RH8CF/ESuoXH7NiVhzHh/lNZK11+1I0NpgGej3FlVn3b
	oql+1Y/huHcBGzfXZ0mM3xP6j76Shmu17QQsgOy4oMn3IK+FyBl7BKfx6iDfRCTA
	vAYQ1pmmKItGOBSU7DWH48KOlS1lZHQ5UoTRxjDgXlfKQcrPQtsFnpml5cy7p+dQ
	Wa98DS/4ZtpST5Us6aWAT2Y0jLg1uCHme7KIu/HRKqNcpkJ0K+QLAj94Y466VziF
	2bLyd38fSPyb3WTfDeOgsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734497030; x=
	1734583430; bh=Q+vVoqWU3yffxd4ISZVi/moSH12OM428Wz9TZjTgGSw=; b=d
	ebfa3u667eFMRWsKYOHSugKotcmdy9oGPVJbFijvC1HQMGFyWQf/g8Tv9rX/L2A0
	e3qp2Kt7zKH/votBSl3++Yj3gIJXb3E96KGtDpgZPORYGbMEXTZEhBet81LJPNWv
	QkVxVbZLmQPVEsukBRflnFvkZ+NrHAvWiS1/j4nW00xnEgczgq5MFA8FdOQ0CgXp
	oN24R2izA7m0oP3qRoFmSA10Q3ayNq5Vpipr25YBvAnG1yol3h/YfweMUQroyhk8
	0687rhYow9QvFWXVmt5YgluJbGoIZe1QAnnQGXE28SJ+6D/zku2HTNEMm1XG6RW9
	UeKF2Q/A2rRD7rHTvfQyw==
X-ME-Sender: <xms:BlNiZ-E8Y26JCVdGMQznoIk4Lp8L7uRVdtpmZwygS7PLOO6xfZg9dTY>
    <xme:BlNiZ_UtVa6VLbhPV7l24qSdLCAntl8PTNgJk1yrr3sc2CTB_Dr362_xezUHrniO5
    GDNeYWXT_-66IUcSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeutdeutddtiefg
    vdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopeguohhrvghmhihlohhvvghruddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BlNiZ4IHy4zJpViWEUPQK7uK_nPZxIvUdBdhIe59tWtOyZQKg1VCTQ>
    <xmx:BlNiZ4Fq7EeYSwJjt-dScFclGcfqt2eDaM8-3Y8PsTiWcSlR-g-ANg>
    <xmx:BlNiZ0UDiVBBa9MnCbl5QaSHUepaQ-nHgkHQmiIn-i_RV8qSY7VlEQ>
    <xmx:BlNiZ7P-yL0al4XAogBHKZ1rSDAbchkum5lt_lAFu4HNLH4OGrVLeA>
    <xmx:BlNiZ7RnoS-ZI6yw7s7rDgcsUP5R7EqElFI7Ac14rzHMkzyKnJ6p4nYk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 667B7780068; Tue, 17 Dec 2024 23:43:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 05:43:25 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: AreaZR <gfunni234@gmail.com>, "Seija Kijin" <doremylover123@gmail.com>
Message-Id: <56a77219-d60b-45bc-ad6b-1225e9ee313c@app.fastmail.com>
In-Reply-To: <pull.1453.git.git.1734493992236.gitgitgadget@gmail.com>
References: <pull.1453.git.git.1734493992236.gitgitgadget@gmail.com>
Subject: Re: [PATCH] pathsec: make check for PATHSPEC_LITERAL more readable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Commit subject area: s/pathsec/pathspec/
