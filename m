Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349F21A4D0
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452492; cv=none; b=b9d9YedpAhm8WZtxgZGLRu7TOID/uH47EzJdbT3PoJZA5inm5wJyoZH8UBv4VXN02Vpdq/bLPnoz0UH48buKaNyRyBY4yZhoxJUuf/EdGSJ7Ujlwe8FJmW8IK8JmUWu9OLKmx9UA7Z23oQKfAXgQaolM4R9Ja4fXLkuF5K8CgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452492; c=relaxed/simple;
	bh=OFV/l6VB7eaWyrBiDPIcYWTILLZQ6usA1vzMJv/EeG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hd5el1MWK+JYj79+cX2Xq1PInPmSGUPCcIzgLhJoYWyygiw55xs3YpcywDRKZnOg9GFMWNWdtrgS6fA5SGNCNLRcV90t12+pXLquf9AHJSqj+vY2pZ95uFUhMGlOJfsyKJmLytN+3vie9Sj8CirWYKThJQwdbpd0mo35zLHxo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzvYEIgQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzvYEIgQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 52D3E1140094;
	Tue, 12 Nov 2024 18:01:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 12 Nov 2024 18:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731452489; x=1731538889; bh=WBEOlLMnGnU32rqX7ZjK7yj47BKyLFN0d+V
	41mZfcYk=; b=OzvYEIgQREF++INj++tBm55cvsPjBunxCLNve9qujWmuBZff9Ho
	dGwIsOd9xpvaaMA7X7F9Z/mz8MKgLVM1Y45yqyTKg7CfoebMX23ADNHsSgJIr+yu
	2cgzzYoBdIowx9Vts4SLe8fe9J/pjiQeGNZ2OvftFRhN8WdRb0Km73pQUh/4YCKb
	yUHd+Xqd3hlm1NGtYRVh4Sp97hU+08UHujpq3wa9z7WSlbnSHcS/bURRzaAECLoe
	lsdpIU8BwnOK7ezUFvHvL4Lopu69YqZs5zYtdAdQVtHRurKWI2g2tXsLAiEQdZzo
	gLe0UQnbJaqm4xKzBDch5mOVyp7LB0C27OA==
X-ME-Sender: <xms:SN4zZwa-Pcfm46TwZkTHFL48mJahYi-Fyo2OCygC9IPf1u0OXP4Xow>
    <xme:SN4zZ7Zogfc95Yc3dojcVQNOAwGsfj-zhpeAqZe-hYZqKcuWj-qrRlGW4JfeBFBeZ
    FyWjcuVEuOr3GTGxQ>
X-ME-Received: <xmr:SN4zZ69xVfmLMGj5VK2Pwt2HFbwTcp0QtYirdlFE8yGAPCQAo_IizcRurJy9zM21qPch4Jj6JllyLRNQsQQ_l_uCr2gHWBhpUn0e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SN4zZ6oNvMEI3rKcaT9nl0q8Jps2bJD39M1XmcxeEaCcf3_zHHkqkw>
    <xmx:SN4zZ7pRVLJF9JrO3exKQI__bc2avXqNKirnFU07LKA_V58rlTAD3w>
    <xmx:SN4zZ4SEstM29HSqbqDwKvpA71nGs71_Ho6U7CfqeiryrHqjDGIIjA>
    <xmx:SN4zZ7qVXpqN_5Mb0HHsQJ8Qpfhq4FisIMGZjfQQa9qm7WA_H5NprA>
    <xmx:Sd4zZ8ewThgcZUbGSHbXWTUU9al7p5J29vTSpNnyEzhyF6s0fhnYgSnb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 18:01:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
In-Reply-To: <45211c3c-e077-4de3-a167-0fc973a78dba@kdbg.org> (Johannes Sixt's
	message of "Tue, 12 Nov 2024 19:28:34 +0100")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
	<xmqqo72l8egu.fsf@gitster.g>
	<7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
	<xmqq34jw6ci7.fsf@gitster.g>
	<45211c3c-e077-4de3-a167-0fc973a78dba@kdbg.org>
Date: Wed, 13 Nov 2024 08:01:27 +0900
Message-ID: <xmqqcyj03vlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Does
>
> `-1`, `--base`::
> `-2`, `--ours`::
> `-3`, `--theirs`::
>
> not work? (I think we agree that grouping synonyms should be done and
> not all tokens moved onto a flat line.)

With the current

    -1 --base::
    -2 --ours::
    -3 --theirs::
	body text

these are coalesced into a single header and get rendered as

    -1 --base, -2 --ours, -3 --theirs
	body text

which reasonably shows that 1 and base belong to the same family
that is different from 2 and ours, etc.  With an explicit comma
in between 1 and base, would we end up with

    -1, --base, -2, --ours, -3, --theirs

which may be worse than what we have currently?

Thanks.
