Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DC2144C4;
	Tue, 14 Jan 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877625; cv=none; b=abuFK3OocEqjSbCdpGljyGWpICdTYyKu1IsSuyhpEeGx/333WRVRMkt6oLsWkUXUOQSjAoGAISQ60Klb6rujRatm9vJvZPAvllgrG4WOB35zpjAUfT6jbwJJcHZrWU6ZOKOojpAQWQLw4NLbzuaQM98sajkeLY1fF7o/Xxkdaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877625; c=relaxed/simple;
	bh=8f0QgSt0ni6f9PI9JWCXdJ2Ri1wh4Bqr/mxivHTqTP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mrtRFTZEZz8tLvUfaei5BBjOc1RPF7Z36OyakHdNagSsstLyclEZ+KE6fyy/drOdyEAn/pGGStcN0KpY9rERRUWSeU85Du4IXRfhI8mEX40mUuHjR+gFcdmoWIddDj1q3gTGXQH67IW577ENgkq5hAnwJJOIh65T2qnnNvD9GqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tagg9jX5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIqyH9rC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tagg9jX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIqyH9rC"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF1301140242;
	Tue, 14 Jan 2025 13:00:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jan 2025 13:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1736877621; x=1736964021; bh=4rVKUMBz8Epx03nJgUK5DUfhChS7p7jj
	T2ZHEDNz2vk=; b=Tagg9jX5QAA31mq90Ua+mDQTDRuoPrxnVTW55yTCXhS81hqt
	wbYCXttzWAnHkIoXwiDHo0Qsf6KlsfvwshtWsmbOdnLD4RzR5f0JViI9mugPBkoM
	+hYrPupVYfQLzwEixcEM4/82hIbwqWy38OAztH1A9EHkgOBO5pUB3P39op+x/lwS
	YYYJWf4uiic3COI/lKqULdbGJByB5XK4Yz5wYiUsYE6iIPrwYEn/r+ppCLBL7FrP
	3L0VVDW+CeaxVAWAoaqQrE0Oz6NknOUPll1MdA8kKtkxRKI2ipHIgASBABmliPUA
	6PQM7EEXG2oY2keX0u5LSgWHYcQqDZ4DxGAsiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736877621; x=
	1736964021; bh=4rVKUMBz8Epx03nJgUK5DUfhChS7p7jjT2ZHEDNz2vk=; b=W
	IqyH9rCcwuPDjWPpZ5ztsBmR+71kYQdlz+6aRYCLGZSGRyjzyd4FFL+uYjWl7qKA
	Iuo/NP9rBnQjEWrsRTgc2ewWK1sm3Q29JDB2peEiN/bJIA59aYzCiS8B0UsIO7Ip
	HHX/ArVpiqMbzzg/icJXBw/jseiSXqzF2I12Qv88yWmcBYuatYJw9SGWcdmpz4ie
	Dloi3yeAvd4AB5PdwK/fB8Mr+/lHXZxkOKj2HM9AtQZ462qcviWcAKVAqtVnVXgE
	rMS6hKc25yyHIU6V8qbtrJph4OvjuLGkTHkRMziS6TpvqYY7GMNyVcOGU94E1QVV
	0cnoBIe5155DTTFUlCnSA==
X-ME-Sender: <xms:NaaGZ2D5MrmUtuX1NGf3jc9KkPy0KybU9zvxr3mcbYVCC6AZK0GWmA>
    <xme:NaaGZwiKNhMMVeHhFxKCpr_-BUT4jXUSqsTjKbZGtfRKZt6oFkHLnYb7PN5uGyyJ4
    j5kC8FRhqNpLjfk-g>
X-ME-Received: <xmr:NaaGZ5lN_FQy0u9_90YvWMUQ7TVWdrbNe-YURJPlQaDjqMLvAivBRqCNhielD-OA3EHY3FGSXYUbOXzSXAJAmRvTKLL8C3ARA2QhH4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeifeegvdegfefgveetgffhgedtkeegkefhleei
    vdffheeifffhteelhfegudduueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgoh
    hoghhlvghsohhurhgtvgdrtghomhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:NaaGZ0zsE1mq4n714drgfYz63FOspbl14EbQBqEoGJFNKKtK0bUVAg>
    <xmx:NaaGZ7SoG84x5HJ80iXZXFJveoT50_YP6EKbdO0msRYNdnlocVvqMQ>
    <xmx:NaaGZ_YoL7ocHsrW2POZFx7Wbpg2NeZaggFyXg_e5jwow1W1AEV3bw>
    <xmx:NaaGZ0QGRy5Em2h-Y21b9d0QtUW1gEtGhaQKhlcvt8Njc7FrcnKDkA>
    <xmx:NaaGZ6F20RYDFgA_F5fYKqcQC0TyJ5uZ-DrfnD204Qjk8koTM_BgoSa7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 13:00:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [ANNOUNCE] Git v2.48.1 and friends
Date: Tue, 14 Jan 2025 10:00:19 -0800
Message-ID: <xmqq5xmh46oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A maintenance release Git v2.48.1, together with releases for older
maintenance tracks (v2.40.4, v2.41.3, v2.42.4, v2.43.6, v2.44.3,
v2.45.3, v2.46.3, and v2.47.2) are now available at the usual
places.  These are to address a couple of security issues.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.48.1'
tag, as well as the tags for older maintenance tracks listed above.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git


These releases make Git refuse to accept URLs that contain control
sequences to address CVE-2024-50349 and CVE-2024-52006.

 - CVE-2024-50349:

   Printing unsanitized URLs when asking for credentials made the
   user susceptible to crafted URLs (e.g. in recursive clones) that
   mislead the user into typing in passwords for trusted sites that
   would then be sent to untrusted sites instead.

 - CVE-2024-52006

   Git may pass on Carriage Returns via the credential protocol to
   credential helpers which use line-reading functions that
   interpret said Carriage Returns as line endings, even though Git
   did not intend that.


Huge credit goes to Dscho who led and coordinated the fixes for this
set of releases.
