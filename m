Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5D29ACF6
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961491; cv=none; b=bGWTxnyVzk9hfIBx9awzWZBuwiwexuD3Px3XpK+mCDjAHeIfawxYW1v2YWxlf2h7JutJWIn+ZGzFrxFDWm9D3pFCLAVFA7EL5kgbMnINtEV0H3akcky0V4oqm2v1jDxYTDtlex84Is1HVkvs/NxklgfSZQaiTAi6uYWUxUYF7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961491; c=relaxed/simple;
	bh=P0JTjd2RPLT0j/TkBAPo98N778vFQh6OhRsPZc+Q20w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHJzDNwKt3X9v9PsQzWsfb4h6Hxbn1nWA8HqUza+lwY6Q1L0/iI26fcakIKDCr56VFU/NdvinYU0RNp5izwft/z/lIjuCMlQBp9miJuFbz7QTXG6QfLorLcf8CkhPG0J8JsCX+6ZWB57T9RCcAwLgMmR1TNX04ZB6gpsl0iPhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BLxopGbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUPSz0zx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BLxopGbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUPSz0zx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0549A1400219;
	Tue,  8 Jul 2025 03:58:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 03:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961489;
	 x=1752047889; bh=EH46pZ09Tg1RnoZ1ARn/5nnxg8onKDznyyMv3YvVzcs=; b=
	BLxopGbVaMR4kCOInMooaWbeYhVFZlb5LPZSf6E703dCvM5lg7bZstSKJnO/qb8G
	BvX+543YYJe0Mho2A5EaHtVDihXGAfiZiYUlCvznRWdDse8XQnUgvUKirtlDbsv2
	vYSW9QPw5/CfwhiKtYgs2p7FW/czdC2Y0yA+dsXBgT5estBgLeRY/bjlwL3JdRZI
	xdyBSvATMGq+4y0Ip66j0qZfr7hGb+j+5uJPQ3fqAuVwVQAavK/9sBDK+W7fI6JQ
	3dfPYRMsi1yNby39HoewIUpb2IQUz9ZnB4VRSwHUudi3G05kAZ8gFGVYZnlJb54z
	VXHQGHCXY1BbRahWITrztQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961489; x=
	1752047889; bh=EH46pZ09Tg1RnoZ1ARn/5nnxg8onKDznyyMv3YvVzcs=; b=A
	UPSz0zx8Ui2ugi86CBGGT3QY25os/vc5kBh4pBuLK7r1ZTGNbg4X7nATPwMRhwOr
	vYCakeoucd4XKl9InlrCeBvmdbvnm65DtNhR47QdXLcr3Tf0c22DdeA8/u/AgY6g
	rSlo0enu6V0DkbGLIND++i6CftT+zcYT0jfhT5VjHHy1ifXdL13voXlpE+QCTLtk
	ZTl2Q5NkfDDHi6j8kQGYxqJnXQ6FeUsGMQ6a01yUyshKcFwXb2PdJX1/0/9rNkbE
	4J0w/l82tIqSSiYYkDqX9RqORiZAmC+kvECPaRvLoh6/cICC+wnSGJr7sUbXLdNU
	32bmaB61tRyPM6Rj3846w==
X-ME-Sender: <xms:kM9saNLPpBocZhzoEIqO-x4QzZlXc_iwC65Mea2qzNNocP7zjK-p0Q>
    <xme:kM9saJ738ILKtgxRfrjJdxWSZotj9fQQrNhEEZ93HqXEDBsXxOVD15HSju_ygpCT9
    QoAoq8Y-4vPJHYNpg>
X-ME-Received: <xmr:kM9saB2B6RfAjRydSLmvDxrSr1oD7pW8_ksaTenGU0w7yABaAa9akn1sS0A1mhYmsh3jZCYA6gItBQ7YgvIFFyAtDtudIWwJoFtYCoZJREM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhmrghilhdrtghomhdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kM9saPd9MDOj2mJnpuigRwQz-pBuWcTNYXF4AzOkjTy9pYsSERff7w>
    <xmx:kM9saHeQU61soIpBllG644T6sSzE4zqNxpmOUQn5aSIGYzzRDELqug>
    <xmx:kM9saKxIVytm2MDXUpANT2dBMI0GRDnLdMj5VPSyp2BZQk_qeQM1Qg>
    <xmx:kM9saG_ns5T_5i_7h1gjmTxFHl-ft4llbC393pTras8BAGbO9j6Psg>
    <xmx:kM9saOrgJV9QcjNAPWZPzQUj6z6eFAwHwUsBgWmhPmg94wE3mB2EuQ1H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:58:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d3835a8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:58:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:47 +0200
Subject: [PATCH v2 6/8] meson: fix GIT_EXEC_PATH with overridden
 -Dlibexecdir=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-6-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 837f637cf51 (meson.build: correct setting of GIT_EXEC_PATH,
2025-05-19) we have fixed how we configure GIT_EXEC_PATH in some cases.
It was reported [1] though that this causes a new issue when overriding
libexecdir with `-Dlibexecdir=`:

    $ meson setup -Dprefix=/tmp/git -Dlibexecdir=libexec-different
    $ meson install
    $ /tmp/git/bin/git --exec-path
    /tmp/git/libexec-different
    $ /tmp/git/bin/git daemon
    git: 'daemon' is not a git command. See 'git --help'.

While we correctly propagate the libexecdir to Git's GIT_EXEC_PATH, we
forgot to append 'git-core'. Consequently, it cannot find its binaries
anymore.

Fix this issue by appending 'git-core' to libexecdir. With this, things
work as expected:

    $ meson install
    $ /tmp/git/bin/git --exec-path
    /tmp/git/libexec-different/git-core
    $ /tmp/git/bin/git daemon -h
    ...

[1]: <66fd343a-1351-4350-83eb-c797e47b7693@gmail.com>

Reported-by: irecca.kun@gmail.com
Based-on-patch-by: irecca.kun@gmail.com
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index bef80b118a8..0da14255820 100644
--- a/meson.build
+++ b/meson.build
@@ -1596,7 +1596,7 @@ endif
 git_exec_path = 'libexec/git-core'
 libexec = get_option('libexecdir')
 if libexec != 'libexec' and libexec != '.'
-  git_exec_path = libexec
+  git_exec_path = libexec / 'git-core'
 endif
 
 if get_option('runtime_prefix')

-- 
2.50.0.195.g74e6fc65d0.dirty

