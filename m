Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AD204694
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697389; cv=none; b=oK6txVWyMQZSzPO/4cKeSm+J4D6B3fjOAqHz4otEuIoeeIru9jpQXVAANG+vXxmY0m7stEDfq4EBWCPDdrAcKSXlAlr0DMwoNPL50APFsqtWJOu3agdCURRKDiIRogkR3IAiaiFtjZy1LAe4qS7aI1afoYyvzMQ3wV5Ds/HExGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697389; c=relaxed/simple;
	bh=YWPrn7B88jYbd+c9Kajwc5LWJFG13PZY14FU4YMWGtM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=k9qW5PbJpq/8fw7KzqwMyKrI12Ze1LghB4mAII0OPDDXsqVzpwUlCkhY92DaZhXoJF2Zxj+lshLexCEH5OEgUwSnrbXXhST9UKtYEYAQUcTci6UcFJ8I5sO7w7YYnuehunNZO2pZ2BUHvasxAozcCuP/y0NDc9vBPgZd9ENM8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CDI+0+0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n+qent9S; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CDI+0+0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n+qent9S"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7645F114006F;
	Fri, 20 Dec 2024 07:23:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 07:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697386;
	 x=1734783786; bh=Dv+IcrQ8K/clOR+EPfzjEwhBE+jbnQU0ioNv3WB9EqA=; b=
	CDI+0+0o2LDXorCYeAEGnVHf3ILEei6VEcSqWQhOZOxH3w3Q7rrpILlMQehaN0Ix
	266Xcvs/YEMmMwALC6ODo9sudyGPMaEfRqD0wuiz0VDm93yYvsxsI7zzjTIIqN7p
	3QnlCYnMGj/7DfQo3jgXaJGbhm7fOO3Nq5g1yCZNpUufuZlMKUZOT9bA7nDOyhKu
	ygLR7eDltZM5yMhikR3zDU/9yHiGheffK4xwNj16l28bF20CTIXR5P+DC6siBqrv
	ohn1MNZy5LxXz0PMF8p1sBVXH1Ui7nUFPvH7fbw2o1WJmmuH8CdRQk6cnl4C3DsV
	mkbAWDDFtR0+TFeM6PixHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697386; x=
	1734783786; bh=Dv+IcrQ8K/clOR+EPfzjEwhBE+jbnQU0ioNv3WB9EqA=; b=n
	+qent9S/dyTMvae4lirNhPkOaUlB21neSBQEv53oRFaYnxVXlernfukL94RUvHuy
	bYq8pd1OIv80gWUHwy3r0O4CltaR+iRnGVn3amkbQsYwugCFrZcU6I0nRckTldow
	7xKHA9/wcqQS5sNhil3i5oniv+6AVn3c3SOXEz8gKGkCiCiIfttN8HqARPodapST
	8lob1hDuJuxss8cozG6thjSMi+VyibR2+mLihy7UDljVrpHsGJHO78N/5odzhQUQ
	UY9dTk1rSAX6sM70BryhjzF+FA+EjIEOhQ5GibiMEGR0IJ5CsmO6ECSbMHkFMVvr
	KTQIBl1fjaAbkUkgWn7CQ==
X-ME-Sender: <xms:qmFlZ2GWXXR4fUOHerh1n1TrOlsVCvDsZ1ehPMZ1Zh3QeAaO85YKYw>
    <xme:qmFlZ3VJVqhV2EXMtu0SgnPZvpDeLKXEOOoC5pBbAE2cfXqVfsR4BgDyfKNGfqLdX
    sfx4muRRID91HuDkw>
X-ME-Received: <xmr:qmFlZwK9-Fdbjo4ueWke66MuQ2rsX-ChdZefUvm9KzMwgsHITaNxEnxoi8ptjKwIyxPAMQnQ0yijKL2dJFLjrzaJkkEQa-2Bh0e3TQ7rTiDxhI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhf
    fhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:qmFlZwGycy1bAiwXiI0KdV5lvHAyQPQc4yenpYv9fc-dICNk8uWWzw>
    <xmx:qmFlZ8V0X38uom331h-188QRKW2NjZiL_NLmW93osIzPFJb5FOFarQ>
    <xmx:qmFlZzNSEPuRhJuh9XtvQgeLfALfBdWdeBmpoDms9k2rbHoYKxVzqA>
    <xmx:qmFlZz1jbgNmq4i2f-nUyD9jpiD4GQGIE5px1jPJgoD1JpSA3vMYhg>
    <xmx:qmFlZ6w8oJCEefAgzUtoafHarBTrFakMgJ7lUW9qJZEgXFfeNpPjzqlE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ac650c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] GIT-VERSION-GEN: fix overriding values
Date: Fri, 20 Dec 2024 13:22:44 +0100
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRhZWcC/5WNTQ6CMBCFr0Jm7Zj+Yawr7mFYFBxgYmhJSxoN4
 e4WbuDye3nvexskikwJHtUGkTInDr6AulTQT86PhPwqDEooI5W02Blc3glHXjFTPOqY2SH5zDH
 4mfyKQtfGCtdRr25QREukgT/nybMtPHFaQ/yen1ke6V/6LFGg1Va7QdR3ZURTFleeod33/QeIU
 0Wj0QAAAA==
X-Change-ID: 20241219-b4-pks-git-version-via-environment-035490abec26
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

Peff reported that overriding GIT_VERSION and GIT_DATE broke recently
due to the refactoring of GIT-VERSION-GEN. This small commit series
fixes those cases, but also fixes the equivalent issue with
GIT_BUILT_FROM_COMMIT.

Changes in v2:

  - Don't strip leading `v`s when `GIT_VERSION` was set explicitly.
  - Allow setting build info via "config.mak" again.
  - Wire up build info options for Meson.
  - Link to v1: https://lore.kernel.org/r/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      GIT-VERSION-GEN: fix overriding version via environment
      GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
      Makefile: drop unneeded indirection for GIT-VERSION-GEN outputs
      Makefile: respect build info declared in "config.mak"
      meson: add options to override build information

 Documentation/Makefile    |  6 ++----
 Documentation/meson.build |  1 +
 GIT-VERSION-GEN           | 25 +++++++++++++++++++++----
 Makefile                  |  6 ++----
 meson.build               | 13 +++++++++++++
 meson_options.txt         | 10 ++++++++++
 shared.mak                |  7 +++++++
 7 files changed, 56 insertions(+), 12 deletions(-)

Range-diff versus v1:

1:  3560d0934f ! 1:  f9aabaa9b7 GIT-VERSION-GEN: fix overriding version via environment
    @@ GIT-VERSION-GEN: export GIT_CEILING_DIRECTORIES
      then
      	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
      elif {
    +@@ GIT-VERSION-GEN: else
    + 	VN="$DEF_VER"
    + fi
    + 
    +-GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    ++# Only strip leading `v` in case we have derived VN manually. Otherwise we
    ++# retain whatever the user has set in their environment.
    ++if test -z "$GIT_VERSION"
    ++then
    ++    GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    ++fi
    ++
    + GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
    + GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
    + if test -z "$GIT_USER_AGENT"
2:  ec7477d14e ! 2:  2db637757e GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
    @@ Commit message
     
      ## GIT-VERSION-GEN ##
     @@ GIT-VERSION-GEN: then
    - else
    - 	VN="$DEF_VER"
    +     GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
      fi
    --
    - GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    + 
     -GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
     -GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
    -+
     +if test -z "$GIT_BUILT_FROM_COMMIT"
     +then
     +    GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
-:  ---------- > 3:  1024d10b46 Makefile: drop unneeded indirection for GIT-VERSION-GEN outputs
-:  ---------- > 4:  14a2e5d7bb Makefile: respect build info declared in "config.mak"
-:  ---------- > 5:  974ab29b35 meson: add options to override build information

---
base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241219-b4-pks-git-version-via-environment-035490abec26

