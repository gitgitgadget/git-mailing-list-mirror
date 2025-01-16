Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EC22A80E
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035857; cv=none; b=hKR69o4HSgF9y+hb6hUpgw0irOIwGjvnUUqHzdXlu50uPDwwigjh4B18RDzh8LRSxzRvKQb3QdNPcPRF4W8wVRDFuy+R07Byzpn5Tpeo579LmE309WA+Wf3+a5MtZbp6/20+7I/x+E6t1twWzexF4navQQWjpDcqZ5omv+q97gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035857; c=relaxed/simple;
	bh=EFai3tCA9XhdCDkrR6vi8bgiL0EEzyxusF/Qj9TFNMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biyVUwvaf+p7EvBuUiS+Na+90yinzoujvHIHcsanJY3uvS/iPCR8sPYG1D2jaApTcnuX+S2Ae4h4gMVs3jGDJXdWj6OrcgTKwc0P7Ruyq2Vpg2ZWKaE6fzaVs72ifKigDvG6058FPATbKFoOW9tWqfBes+4+QSnn6w1yRZUrU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgS+YGlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSjeil1x; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgS+YGlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSjeil1x"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE9742540149;
	Thu, 16 Jan 2025 08:57:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 08:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035853; x=1737122253; bh=EFai3tCA9X
	hdCDkrR6vi8bgiL0EEzyxusF/Qj9TFNMI=; b=kgS+YGlQ0L8JWIEhJlntTGRs+M
	Aijo7nIZTLXf67HTl8Zx/Mtv5L9XolXhT3eB31fwqJiHlmBJir9Hj9Eb3Lcel66r
	ZY3pN21sBvcdUocEIHL6pOs+yN4PQalRiEbDr9nmzhcsdKLMs0yEMaYXXdfzvOtn
	Ol8S/E0GzmjqVGyGT2nO+CbQQ/ecIv9szFksMjWkBw5MLODtSQzZ60guKMu5z7Pq
	hvL10y/sWqxNBDqmZsLGx9kZ2UwS4JpNg3NlriZXgnUUeXEcd+/N8mv7fZnhQcX8
	ka3zdZ26uwPwVLfdXvLQG/txChGNMPC4BbhIp28/amFgtq2HjUwk7OE1/HRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035853; x=1737122253; bh=EFai3tCA9XhdCDkrR6vi8bgiL0EEzyxusF/
	Qj9TFNMI=; b=qSjeil1xTYKitMkTtOK4xgwg6u5q8hU54Gv6HPd9K/l+3veiItE
	QvS3AEJAoTEHR9fdFWdQPJym2uwQxq3p89PGwVz2VTGjL8sX6eGuXEgDe5JT27Hm
	XIGR5cYzxSq4soiMrH7x4+g6wFE2Q2MurJhJNSxIngGBJsCVlJq9M8KyXPlzbmuY
	f7vnbwTCQZvj7O0mXt+aqDK0IQzLjUxmg9Y6GmBR22ZitxE/G+IWF50hsc10yisT
	/Yi9NFdIoC2BQM9E956JiXlOSZsx5aNoKMMS8N1EDdCVmT1qRqDLNRdesMnI2xnS
	tXbPVc0aMoIfTJ9d/QoKOAScpScJ4vTaMMg==
X-ME-Sender: <xms:TRCJZ9JYnB3srUzXt7UcMydm5xfBqp1mazi9eOMpbVNFkjRp8zAYmQ>
    <xme:TRCJZ5KZ7FglItfG4lpDmFJ0wSNvqxLsSwDaQRUrS7YsbyYvFrvqCHmgQyjp9Jf8v
    z0EKOesq0clRqTfWw>
X-ME-Received: <xmr:TRCJZ1vnrpSfiVt4WVM6zBU67ICNnvKKr9_DNHLjubOoRQcPkIlBTP3911TaiLh8JFurjL7uApLkbfB8Xcgd-YETlnHREUab4-UoSnc7OyLDFMwydg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhh
    rghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:TRCJZ-avG-nsOW7ZbN5PQh4cn_Rfl5agERdxB37gMd7thF1NnVem-w>
    <xmx:TRCJZ0ZNHvkrnBP9v02sxUBl2G4qDxseNpdlB-UyjrB7Vn3IWvSWJw>
    <xmx:TRCJZyBnwrxQLduvx2E0iIl01yakijWC16Wh2CMeQf8f1rMSAR4gbg>
    <xmx:TRCJZyY6ikvfTkOph9pDRbETIIJALIKEWABXpsxI3HIvYzyQ4Vn7sA>
    <xmx:TRCJZzz8HuGEnGG8MZfq3z-Cyya_4lsebF61ldyr6NOH8Ee5wsT-88cH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30e3acf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:31 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/10] builtin/refs.h: get worktrees without reading head
 info
Message-ID: <Z4kQStWArejI2Zk4@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN30z1NCXa3AX-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN30z1NCXa3AX-@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:19PM +0800, shejialuo wrote:

The commit subject is a bit funny with "builtin/refs.h:". You probably
wanted to say "builtin/refs:".

Patrick
