Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9061EB54
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="dFqb4VGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYZy2P42"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043110C0
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:29:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C4D2E5C01B1;
	Wed, 18 Oct 2023 16:29:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Oct 2023 16:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697660956; x=
	1697747356; bh=1A1+MKStWzTe15/xnUdUSnsMAe8tg8mGNFD2jzOu7kA=; b=d
	Fqb4VGO4j3qthoa/+JnQ68utoEQUfEYBB3rzjWpe9lcXlyojIeZTJhqpnJdc5rpp
	xmVwYKXvZfX0AXPEeMZzwzWBekmk5vIaXKZgIO6dXRenAsGnOAKEaXYIV6Ujv7SP
	Q//P8oRu/0T0e4DMygDnldrh9K61eKvVdo1MUzMfIFs6F2AUBF8W5NFE4d/8jKYB
	tvPspTeBBlB6LBzsiSnMfNg9RhqOcxhKmQFLDIlZ7JBwEfJVEld+60UVrGp0FPBV
	D5QKOqf5bO/W6wZKZkR8aqTVDSIE6/iGoo2/qPQib/9JMLuL0zBm761V76h56M45
	+fWYetrmIgv7LeyUk4qxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1697660956; x=1697747356; bh=1
	A1+MKStWzTe15/xnUdUSnsMAe8tg8mGNFD2jzOu7kA=; b=oYZy2P42ho2D94qah
	aLQeiziUiDs7oCSBGKfhhGducLV7SrRV7XWvXrNSy2ZUZzYoZ3HV7b3RrHej5vGG
	V/94i/f1LfcFpXVcciCnJaPHB19pVYRIt4+L8gigIQEaDZeFhU4ABIw5QAAGdal1
	24XINE6ZhPYuB9A5Bui0gIMdGOZT5tLAbwVsLN+rM5r99W5NAkFrrvLEh+6J3/1p
	fwaCs8swmKARS1pxezRXvihpQLnSQK7KQ49t2lNnho3Hqg+GnbmEAO9pmH+tcU1v
	vQpR4qcMAJb2u/eUjUfk6PE/caZoil3ymxXZWXEgKIWShLW4EBtvtxtWrpvzxREp
	yeyiQ==
X-ME-Sender: <xms:HEAwZe-usL9-wtD2XIAHQfaq75-Gz6_YMHPzG6QLVzDGFdLR0bmA-4s>
    <xme:HEAwZetRrymeikoHvRoAvPMR5k2rW3omdZ3XJ43mfUeKXkKyzMpHpsShyj1yk98YH
    YeHFbFbKeM0wJRIZA>
X-ME-Received: <xmr:HEAwZUBbQ4kDs5yHiLAsaojMNC6S21bNf906lh9ysMUP4YecI4WwIiNdqXeYFbI8RFj8PS4x74Sea_BD0Ldkpwli31S4zpg1fOf-xOW8O4DNZhrN0Zb_wFq0aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetgedtge
    ehieehfeejtdelhfeuueeitedttefgtefhveevuedtledvfeejheevjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:HEAwZWfGjNlBI3Jskre-An-GaIqPeUJgzY3BPrGL42W0VQTTvZ5SFA>
    <xmx:HEAwZTPIaJDTsAymIgmrY-kXW9bKPjhVdFY-2h0giXERAB2bcvxfng>
    <xmx:HEAwZQmsZepmqC5iAgkGVxBoEaKfeeOHShNGCrxzQcgihltbQc_4BQ>
    <xmx:HEAwZcaIAwvFeGIdSi7SgbADbJHT0rgqJp9dDIKNwi2G_MnIt2MrTQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 16:29:15 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v1 0/4] maintenance: use XDG config if it exists
Date: Wed, 18 Oct 2023 22:28:37 +0200
Message-ID: <cover.1697660181.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

maintenance: use XDG config if it exists

I use the conventional XDG config path for the global configuration. This
path is always used except for `git maintenance register`.

§ Other discussions

While working on this series I found that Phillip Wood[1] had pointed out
that `xdg_config` is never used. However that was on a series where this
was the existing behavior (not new), so this wasn't acted upon.

🔗 1: https://lore.kernel.org/git/448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk/

§ Patches

• 1–3: Preparatory
• 4: The desired change

§ CC

• Patrick Steinhardt: `config` changes
• Derrick Stolee: `maintenance` changes

Kristoffer Haugsbakk (4):
  config: format newlines
  config: rename global config function
  config: factor out global config file retrieval
  maintenance: use XDG config if it exists

 builtin/config.c       | 26 ++------------------------
 builtin/gc.c           | 23 +++++------------------
 builtin/var.c          |  2 +-
 config.c               | 30 ++++++++++++++++++++++++++----
 config.h               |  3 ++-
 t/t7900-maintenance.sh | 21 +++++++++++++++++++++
 6 files changed, 57 insertions(+), 48 deletions(-)

--
2.42.0.2.g879ad04204
