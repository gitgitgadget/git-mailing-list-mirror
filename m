Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5D383A5
	for <git@vger.kernel.org>; Sat, 31 May 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748731782; cv=none; b=FDjxlXz2njrvNQKAIZ3A3Q9TzRwAlbEsZY5K8AxT6XlRPqfrJC+CGjvwsWFaBOChL5/+Trh6ilHmoJ9oZBsKiLKBvO/jWqfM/Vw4Yi33CPKpYUa0NwTHFPhFyE4WewBH04bgp9fj//2V6xAIiAJRRWypSIF1Gwq2rLJM4VyAmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748731782; c=relaxed/simple;
	bh=TB8H40BkHa+5vU+Txc8sTutbqSM1AAgaIx2rt9y9mCs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WLJZUBo5wUJ6AlaRfe6A/m07F1hQVKDFazBklSF5wVWOK6gN8+MVMRol9WBgpz+FRYeMIiWWfFP88ZMxeeQftDLHZTL6zIdgFthWaep0tBFpXE87Ukr/HJggwX6WS4JCFfStzi/9OJ2pOyN+YdVJ0OPvTArM1VAPWrvj0RGouaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=cOm1hus5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNh/HINi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="cOm1hus5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNh/HINi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD283114012F;
	Sat, 31 May 2025 18:49:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 31 May 2025 18:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1748731778; x=1748818178; bh=3gpw1E/PJsa/RjWXPKah0d/Mn9YHQlxb
	DeoqmeU7JWo=; b=cOm1hus5ktHflnQQvvEe2VasysCOgcJCTo9FAI586aiPLwZA
	mVlaTFr9/Yov3gly9ZTqT5JK1/BX67KdAlzfIFY+HDTfPDndjOMMBvd7njMy6beU
	cfjVkJ6fIYwdkEUdpiyzHB4aWyMfk97XEIfsyLi6pD+AqQu8qqoMfrg4kLpKwZEI
	5v4TQHprhZZlQEgWHUfJWUjp9nwJZuKMV1WW0I4ih0Q5YKs59PP77LjS8L+6VYZl
	gndd07MFeKVYxBkL7LqFK16PnOz83lwUoEsLA58XmfKN+nMbVVfD7TfT9YgHC/Nh
	nNqyDPm0Z5J8HtipbNlwCz26hXQNmykgduHNcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748731778; x=
	1748818178; bh=3gpw1E/PJsa/RjWXPKah0d/Mn9YHQlxbDeoqmeU7JWo=; b=g
	Nh/HINiXzGwaIuePT/Yz54XzxPv0jXHltU6dQ/+yG6lfLjwvQtHWTTVNtaDaSJ6V
	vOCiqSFPizy/sA8jTVIRPQ71LXlpW5NVLZ/PFaj37HPUYzsXn8ia0QUKLN5jXwLd
	Opd+at6wLM8UdD09WINs/RD25tCrsCvDjgZ/8guXhA7nsYNQFTOZ1sb3Bq4PLRHP
	9nygwfXmTGus6YTf8fj6hEhbp7mkxfk6Zl9W+2J5RGZ9VEcgGpIFKJA8RBHf66Ib
	LKx0ac2TWqsH3qOPS0dPXRpFB7mgwJYCS4tHRAMEga06DKK/hT7dNKuf3xB5NKvi
	GeBbyv3f0ztUJjeFSygEA==
X-ME-Sender: <xms:goc7aInG7vy2Qvwqsxx-L-VfF8Y1uv1tw_QsM6pSMeRKNX9cS3j9JEs>
    <xme:goc7aH26S1ReJ-H2J7vYpddENlvZjhsd9JCtfEt9VDNRYS9TW0yWFkh9QFLJlAXqf
    yq3bmnv_KczYxTdMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffedufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffr
    rghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudejlefgudffffejleffff
    eludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrh
    gvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:goc7aGoNZzZsJqlXgsHhcM1ysd9w43V56IjbR3rdoyFqB8lK_IkEkw>
    <xmx:goc7aEleiU7RH_B2INJTnY2-vai0kvQkZ7Gy15OTItAEbnrTDm-Ibg>
    <xmx:goc7aG1_wlAHdmSBiBMjl_vq4CDTDDd8Fulg1UnWSrv0xg-3KkEZWw>
    <xmx:goc7aLvLrqBE6kPqZ6OReCqpyHk8ZjYeUP-23s60fTFrFvjNOelhlw>
    <xmx:goc7aBXjLlFOOS65PyD8Gr6sH3dKSnTVWEA0Ybqzp8gXfS1R-BLQei_o>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A8E41EA0060; Sat, 31 May 2025 18:49:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1f6d1e89a2d6ab32
Date: Sun, 01 Jun 2025 00:49:12 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <212bce25-e8dc-42dd-a70a-573f09b1f74a@app.fastmail.com>
In-Reply-To: 
 <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
References: 
 <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
Subject: Re: [PATCH] doc: column: fix blank lines before block delimiters
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> doc: column: fix blank lines before block delimiters

=E2=80=9Cbefore=E2=80=9D is technically correct since these changes happ=
en to only be before=20
the blocks.  But maybe it should be =E2=80=9Caround=E2=80=9D in order to=
 be stay consistent
with the commit message.  I=E2=80=99ll go for that.
