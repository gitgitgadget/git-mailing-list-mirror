Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD55214816
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731460; cv=none; b=cwFtOVEwU7j0/kN9HANjnZQT1TuxVUTbwQ7mGmyz0N3z2lyb+zEKw89G35PGFO+/cg7MSm7LFusbw4IpEC/ItEdbh7glNZH7F7/5iaIixM4Z3R+7pLQFP7emrx/04wOrq+Abcg6To1t9M6MdcZGx8DV4LjNTzjLRJNhx5s9oHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731460; c=relaxed/simple;
	bh=suB4b5jrqjSkimpVZfCOm8WAyBcks9KQuNOlsRy7W+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4+mDr/ycVZ4F6sDmQR/DSYFTgH7Ybj8cw5iXa0ETVmJ9Yte15uNopVuErmkLDOaK3FW7qVKE3kNP/hx/FPR7TUk0p8D+3g2JL17ANXNJIWGK+4lbaED//cGqVAqZq91O3sKosGNgK4thIlyG/Yor5fZBorJTk8oMFbeK2BxpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isoKskJ0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isoKskJ0"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B3CC11400A7;
	Mon,  9 Dec 2024 03:04:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Dec 2024 03:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733731457; x=1733817857; bh=De+ffx2gs+T9MbxponS/l1JMw+OrI8Yjp0d
	ENDn8kc8=; b=isoKskJ0HVDHFo6FcUUxG+9jsH6TgLHhQwBHFKlJ/5i+hm77fzC
	eoUf8PWOlo9ixZ+TTNtjy94cOUdEZTvN0GkUeTRRWkOPQ3j7nUrVPQ8SZNYN/s7i
	rOGbKelDhjmyQ3xs8Y7XN+FSky0QRzEi+pCBfZIRFURVRgQoE170mC0HGj7klovt
	ousSPup9kBAwLynY91QJRQ01YC+gSTfS3uSViIEgtiS1Jx5oHySFhIOekvNIk7yr
	pBuIfkrmAalXvSPP8/1st1/sXwN705QBdl5Jza2VgrWxONw1gNX5ojNjE6QxIRkL
	1LZKbagGhOHx30+jv3Ey7rPypRBKz/jf1Ww==
X-ME-Sender: <xms:gaRWZ9dfxLrlJoq-lKZmEGv22P0tpl3Vs_lCSCApKJCOeYp3Zd0Crg>
    <xme:gaRWZ7MU4gfS3JkZaR1FD_B98KCgD5twPccd7rMgkXmmgU2Hl247rXx2JTSSrTCPf
    50yRopF1IrsuutSuA>
X-ME-Received: <xmr:gaRWZ2j6P8DSxuJ3-UqKWmjzcMTn-OoGdlMr508tqopTrsFi2UmVhe7qhDS5ECE-bHt0H6l8_oAOnZhJal4IiFsJUjxclufgeu4LV44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepjeekueejgeetveejteegieelueejieejfeeu
    geeiteeitdelffdvffehieehudefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gaRWZ296-qIdvc9YrpYKAAuT0dzmFxviY5-H6IYiBX1MUv3k9j--CA>
    <xmx:gaRWZ5ufPcutPJ0E5c6l0FQBE5uDGp717o8tDuunu6QPV4Ns2kmvGQ>
    <xmx:gaRWZ1HTbPRiyNHZEw3wKwTA9S0sDx7ArsTsCJ7Sqm6Q-1Y-tKGsZA>
    <xmx:gaRWZwNReldSxOJOHt6vh_bCLU-XKkaPWgn0oeLqHGAXc6zaUAlZfA>
    <xmx:gaRWZ68xFjh3LRwRm5qNggW0EuRuVP8v1iyU_w0TCj_E5n9FyhnHXIb0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 03:04:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
In-Reply-To: <20241206124248.160494-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:43 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
Date: Mon, 09 Dec 2024 17:04:14 +0900
Message-ID: <xmqqikrtnuyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This work is part of some effort to better handle large files/blobs in
> a client-server context using promisor remotes dedicated to storing
> large blobs. To help understand this effort, this series now contains
> a patch (patch 5/5) that adds design documentation about this effort.

https://github.com/git/git/actions/runs/12229786922/job/34110073072
is a CI-run on 'seen' with this topic.  linux-TEST-vars job is failing.

A CI-run for the same topics in 'seen' but without this topic is
https://github.com/git/git/actions/runs/12230853182/job/34112864500

This topic seems to break linux-TEST-vars CI job (where different
settings like + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
is used).

