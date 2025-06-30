Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659162E9753
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310660; cv=none; b=ZwvvZSC3hgny8Q7RGft6bthcDnNdImIDt89++TRbGXxDWHBdoeO4bP5n4HkOf+++58qBazFwqsH6De8PaZDzDkxgJkCdcCu04zNXJuBc2NOOYLMOGhubJ+PnyJHUBFdLq5Hvk1c7KSyTGH5NZCsv89mxB8+H/CdS1AKY8LG8Oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310660; c=relaxed/simple;
	bh=ozX3GsIakrRPFYXfD75uWGjezb3k8WT1ytv6r+J0G2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/HrFNqvTJfNh/l4/RaX7YMOJTuFr/RlxZXCmx43wvRMe3E17mdRY/h6KwlJuxH6rEeufx0q+HJWxXcVM0L9n4P6Qpspn2/ltUDsTw3REVvd7brQ11fvZBVuuvTPA9JRV8O3r6AY4k4v0TXUjFAmo6jtbubKDPD+gFYVp3Df7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ecrXQq40; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kezJKQxf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ecrXQq40";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kezJKQxf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A24EA14002F6;
	Mon, 30 Jun 2025 15:10:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 30 Jun 2025 15:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751310657;
	 x=1751397057; bh=8+RYrMIzpS0mxo4/RgUjQl4AtcuQYd7iBkyH2o7uqng=; b=
	ecrXQq4052rMmFCZVLY/TdWoDl6J+WSbsvTYrCtxPDDqTY26xLcisEh5RU2pjt7W
	jnTWv/uYf9z8vhrc34qKp+T7muuWdwPU/BylDfiEX3vI8eLOb5AGtoV2/lDTOjKo
	AsZruMbfms/H3FCRJ0Ejh9YD2ZOoBOs+D6eLuN2nFSzJ1Xfy+peNC5+awAPo0YZf
	LuRf85fDxOsZxp0R6xJV7Hg7Y3mJaHwyKyobx4sRnF/6NDUpOW/IN0sP0ToZtoDu
	lLxDCI/mHcoegkKZgcLGX29Ja6WK9WQw9efbHoiPphr1T3WNi9h8Ke3nQKzrDYou
	sk/XD5Gti1AyHtLddK1o1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751310657; x=
	1751397057; bh=8+RYrMIzpS0mxo4/RgUjQl4AtcuQYd7iBkyH2o7uqng=; b=k
	ezJKQxf018M8AsI3cITykMxgDYVQKSoO9v+leIz/7jjYbnupv3P8gEHU6jN+/TXA
	yPsjHOnrEp7anwNLLw2M8sa9SXl4O412cy+HjIigHMP1amU1gSdRY4YKNZkZhUgf
	ff/QXBBtiiVTXBdhPP+asLEiBY+z/I4oO6GP7tJk4ZwU7L7iIS2UdHV4x41FA9kY
	JxOx52VAOcgrhZKkVwi5QcEw+TuzSJmBrfrkMym3t6XnO29iU7T3J0aLb2Gcy+fT
	l9LgnU1WrKmKmDfZcXbH/zRzOyfAuI7pVwIXNlYzOw/+gWm6lBl/QMEEEw/GQQhs
	0WbwweieopbRpxlfrgDcw==
X-ME-Sender: <xms:QeFiaMJB-iN0UiQdAEW2DTte5lmXEYDzc1aH49YlzqdXTTppJDFKJ58>
    <xme:QeFiaMJncEvYvN396rR0UzZlthPxKXrtUCx_Evl6hJyulC3MFr0XJnTQXd5G-zCeG
    YXMrUpV8PR2B-c8Zg>
X-ME-Received: <xmr:QeFiaMvRTPbszP-0iL3L9UYLDhcIhIh5yWzaFD_q8sNhKOiMYo9-fvmC-Dhf5cw78OExXVWcm519XtwYIi_ofAacQuczT3QEXSGehVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:QeFiaJYhOZnA59friLgXHBdOQUeEveNmmxoAO37_KJGMFmN6FjaBWA>
    <xmx:QeFiaDbVC9inMBMHkRfDy9IJ5ik4Ro_eUfEIxxD5k5CDQMzOnwM1Fw>
    <xmx:QeFiaFDoRoFONuf--DF31NYCKp5MeDf40PjvIo7Ey3UjKf7G2MK7hw>
    <xmx:QeFiaJZbRrzu7gf0kDpgcZ2dkMsBGe35GvFV6jXrIlmCPelPbTiZXw>
    <xmx:QeFiaE7512CEZTvvz0pQynNytC6Wu4IsjlleLrfZdaHfenPspcbhQumW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:10:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 3/5] doc: config: document --[no-]value
Date: Mon, 30 Jun 2025 21:10:25 +0200
Message-ID: <f8407f331e0e4bf66a7e26b87f9b021ab950a4ad.1751310455.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0-KH
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These options were introduced in a series of commits from
fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15).[1]
But they were not documented here.

Document this option and the negated form according to the current
convention.[2]

† 1: `--value` is a replacement for the `value-pattern`
    positional argument
[2]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index d3ddc538555..03808b18d3e 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -200,6 +200,14 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
 
+`--value=<pattern>`::
+`--no-value`::
+	With `get`, `set`, and `unset`, match only against
+	_<pattern>_. The pattern is an extended regular expression unless
+	`--fixed-value` is given.
++
+Use `--no-value` to unset _<pattern>_.
+
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
-- 
2.50.0.138.gf67de2ec4e7

