Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A54F602
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871699; cv=none; b=CCO2v8rFw7qzFRbhoBGnNFLRdfosz/xkn+ZYQ2vIz8y6/Xv+IHrwTrgKV0BbaLjfyg43RjSKTMa2EXBvg3BcX8KOvLjW0f0CP9zWH4jSPTPeYY3fsWRl0+giljc1ZH8z7jOcObrrjd7dHX2h/WaA1WogcP7PIjI74ldIHsAnT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871699; c=relaxed/simple;
	bh=LL0/SaLqOFve5xH1xfTUfREe4CEiZBQIkiBIkmOPtjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQ5ViAC4EEHLc0Mq+r3WWHUTdX6AK/nxhHpgp4ZoCEGhut6alnww+8r58E23d5lepbSGwgo6BO3IHaHWM3DCVCNVJ5XnbhZgQzYWkPp3INGJ+O1sO85s2ltbpbNHmIOsqVjK7lr2gXsYcRnsf7QtxDbCrfja3FgKGm91XyHhrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29121 invoked by uid 109); 1 Jul 2024 22:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:08:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18030 invoked by uid 111); 1 Jul 2024 22:08:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:08:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:08:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 0/2] here-doc test bodies
Message-ID: <20240701220815.GA20293@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a re-post of an idea from 2021:

  https://lore.kernel.org/git/YHDUg6ZR5vu93kGm@coredump.intra.peff.net/

that people seemed mostly positive on, and I just never got around to
following up. Mostly because it's not life-changing, but I think it is a
small quality of life improvement, and it came up again recently in:

  https://lore.kernel.org/git/20240701032047.GA610406@coredump.intra.peff.net/

So I thought it was worth considering again.

  [1/2]: test-lib: allow test snippets as here-docs
  [2/2]: t: convert some here-doc test bodies

 t/README                     |   8 ++
 t/t0600-reffiles-backend.sh  |  38 +++----
 t/t1404-update-ref-errors.sh | 196 +++++++++++++++++------------------
 t/test-lib-functions.sh      |  32 +++++-
 4 files changed, 152 insertions(+), 122 deletions(-)

-Peff
