Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB091B0F27
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685053; cv=none; b=a4r2ydQuaYUW+r4iu/3p1rx2JwPkDEUGWYvs1qHb5Q08Z6vCP+5qrWdl7k0DSLk34ObEOTlDjoSjIuqgnseWKBq4c+Aow+l5yxTXmYxrwGj7tO86SGAdJqICftFp8OUQeYZC6nLopCdKxrW2aTeNzZZ4IZnXeaLcXFVYLbBFfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685053; c=relaxed/simple;
	bh=s5qc+bfCLS3rfhb3yuYkHv8dMVSQrDXwyOddKudJ4tI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JWD1cTLG5C63fiQFYNBTsEDQUiYw7/9cXtgY5Rd/svPZ7Yy8rnu1lH8TlA/Nrlphz7tW8ryZFNJQtn5sD+dEk4uzOn79Sw0RVNMz/g5pH44OddD6a3ItFxpt+hnv13MpSIGSZiK4NLFgKLv8PGb9ZBU3EEn0pxjmtc59o2chdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Nj73eujN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tII/Nowk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Nj73eujN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tII/Nowk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B2A81140100;
	Sun, 12 Jan 2025 07:30:50 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 12 Jan 2025 07:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736685049;
	 x=1736771449; bh=o/9Fxfc8q9dA2XmwT3WCyoiFdf4BconQfImGYYige90=; b=
	Nj73eujNqxddtFoiZn0INkXHfyiO9uyBf0Lwcc87Vo176molROcNlVvxc+aAjy6m
	wsvP0GIJ9P4foquVMSS8cSNuS7rpizrPyU0yAEV8dV5ox8ayl8RPLhDZEMJUe7LL
	h2O4fdPVNovh63B4RMhZZEurBD9WAcuUx50honXL4g7jc4n+T8AACCSiPjaFP5D0
	IQ03kDfaCmlzlooguDL+gRcJX3KU8X8z9tCaxHofzKYFr/1ybQJiwi1hA/SfO/9c
	lor0aIOWRi9K0jZ4BFbOemzubydlVh/+eFDC1eWtKeXg8RRzHgcEYKfHMOcQM5ct
	IxdYGn+Y2PSY/2VHxLTP4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736685049; x=1736771449; bh=o
	/9Fxfc8q9dA2XmwT3WCyoiFdf4BconQfImGYYige90=; b=tII/NowkTb6AkE4Lq
	pc/buHTh851U3uNOYvygY9rnN3cVq9KAaUTtxxQCpEJNLikmZhdTc4PlV5nj4PxS
	hImw3KVycg2G1yC8tAUWNQnZHT9altKVr2xRf3pVqW1/8pVp5GEliU+3w6DYCg5g
	aHZ4ocnbDfATixk4mIXVz/Jp1RfaAv/NWoV0TdQ4kD6UQhzVvV5M4Lxpv7VfSpWf
	vSg8Oyq0uhLtHKxVQDkVslEg8pkvOfpNR83Vfvi7vUaba7+abA+yf8y60Wc1+sk5
	56r+2Sbd4KWeea31HGjGoZsriznQx6F+e9kgAB+qhn0jvAF6+a4+zvC4fxoP0f7F
	FxWVw==
X-ME-Sender: <xms:-bWDZ1P5MxB4a0qAA13yqqLWpnyonCPjiY5nMUXtfwjF0l4kV5x_ycU>
    <xme:-bWDZ3_Wm7JI7I-yllNjn66YymJEoYhYuOz4jsl9A-jsoUaI-M9wTSJnCiw5Orefj
    nqRCOJ052I5OWy0XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepueffheetfeelgefgfeehkeejkeevtdevueelhfeuteejteejheek
    tdefgfeigefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-bWDZ0TGhOVI2Xdv1VEZsgU1EOmF5VWvqNjAnYDVtrvwPFhpTrT6_Q>
    <xmx:-bWDZxvvPAeDiNKni__NrtglEOUMHrFMoNAGMLaWToe2iKoh4lUhlA>
    <xmx:-bWDZ9fU6-ZYqHXo7hebDKM6iEnmRWSHEo7CgZljr6YrkmBIS14hXg>
    <xmx:-bWDZ91lvVwgVo_zXuuRXlXkpatM1EaYeKMMfGQASJI8Ou9LQYsKDA>
    <xmx:-bWDZ9GimjZ_j51lUJgx7uXdfbEOmNcryzwIpqEtj1LSS69pitFbUMMD>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AE2A780068; Sun, 12 Jan 2025 07:30:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 12 Jan 2025 13:30:28 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <64913dd3-f336-4e65-8694-2392fa7a049c@app.fastmail.com>
In-Reply-To: 
 <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
References: 
 <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
Subject: Re: [PATCH v2] Revert "doc: move git-cherry to plumbing"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I forgot in-reply-to:

<e5b20f9ceb437a82c422136cb81b05a0521cab07.1732973210.git.code@khaugsbakk.name>

-- 
Kristoffer
