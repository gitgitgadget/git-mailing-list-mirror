Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1411DFD95
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053702; cv=none; b=aDBv+O0z+544YokURL36Htw/86L0+1cH56mspR5HnNifNrziVwdbuBhZl7FJLGBkt4dnW4wK++xs7h7RvF0P8X7JeUXqK0SXjR/iNw4bAJXwFUlumgVsD/BRpYJdbH8B3wbxcStwGjm4NThrHD7hmQdNHYvRk+9XgHRXh5Y4N38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053702; c=relaxed/simple;
	bh=wea3ymJk0/i//MLq1BgjUAkYzo3NBCJNoCmcTAGPYMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxdZ7z8lQEk2LdWo0N4d+m5eB73d6sXz2ouFj1nWNqpRo4YcT4+W+QM/ABAIcL8tciN/ErICN3MWTI/mW9jvvGrm2qQiSe31tXTts81+L0K+MqxA1rgyuKb3BzV1X93hRR7Bed3Fv8JXJQRkIzMB1jKAcJ7v5n9AiaAHA3MSV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fJG6zkYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn4rA8+t; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fJG6zkYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn4rA8+t"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A6E6E1140169;
	Tue, 28 Jan 2025 03:41:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 03:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053700;
	 x=1738140100; bh=MNmhqm5MzuHL8mwArKnuUyGInnqN8BoBPuKdduYohy4=; b=
	fJG6zkYRkDklhb5gm+dNi72aJmOnIe/lEGxtiZIQDN7vkBHZKDjxfO5BfhWTbw5E
	8tYq9ZMhSB+GQF2xkM+T7PkTvqSa2SB0pEZQb16K79+8X42UM63jgjlf3Ib7e1ci
	PgEyh8Et3VdsSRh4AUcIoXjv97FEsFFpZ4qJsxj4ZtvCeqjgBE0IFKgdRDlAOVAx
	wiTjvlr8bFAmgL8E2t8YZ+D8KjZeBaIbfr6vSxOXFnW3s54m2h+qtccXCo3Nc+P/
	W6w6cJ30TBM8z9NWaoMAuXBslpdQYyeXkkbO7aIrfs2SEQ9hXxSfMP5tSeb28yfM
	BX+nU4wTIg/iNcbj2mEGoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053700; x=
	1738140100; bh=MNmhqm5MzuHL8mwArKnuUyGInnqN8BoBPuKdduYohy4=; b=M
	n4rA8+tl2IdKDJGSuuXsAB0TgSPtfXSAVe3raT7XwUrsaLwPlfkyTjDbUW6Pgmus
	LqMTcHPj/MHpvJHKyzMBzjF7RN45HcoBPiGAcl5PF6vNLrNAc82hmF2FPuMKa6r/
	NJo94Tx1Fj6+mt791wjQ6YAU6vWUu33Bi1GM6tGaNOn8KNSfrWgsLmc3MdgzfkuY
	3wfL7UvjvioHZ/tBTbRE5inso0J62dbPz3xpfxebyxN5oczu6qQjsZT/LKhQzLbq
	zKYzInY27dQy3yhrtmolray9uWizWkl75CkNQ9yUAMDtcqGGiLLomel1NhUbLuLV
	CDBLQdM+Dj7kX2QEq4OTQ==
X-ME-Sender: <xms:RJiYZxqqBxrZ-Qso0P3h6ol42OvRBxVukXveatXvalX7h303pL5vug>
    <xme:RJiYZzrlBJw1aVqpyjee9AkM5RFDBaTBCBJGY9Gdublou-OZz5yUZdgUBSUZZF8cu
    RhIh0zCfeFHQw2wuQ>
X-ME-Received: <xmr:RJiYZ-MN4GiQgTK5_ZZNlbgVZd-4DAyC9AqwayfYswbubwClA3hlayhAPXmYc_QqWamFzHTSClxuo7Xahwva_l2gOuiSFdxwmNYwKmEEKfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RJiYZ85HB-A_iK4yE3OTNWmTEcjzGy2vOyOSrMGJ5_Tzo5hS3o-ZgQ>
    <xmx:RJiYZw5ryP--CUHTzHx2nxYdCKX_m1YqVPLmAATi8rz6Zaj--ana3g>
    <xmx:RJiYZ0jFUk7UUc2WGCxSBfaH4yRkXa8rl5mY8zoiEkS6inXkRmBIPQ>
    <xmx:RJiYZy5Benc9inhQB76z1HfOVjacmglkFT_cc0unWkpu9zTIS72MUg>
    <xmx:RJiYZ-mLQ6ItIRT1IoivnxuzGOnthNrb-x5ogDcQ72tNGEBNr2z7FZP->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 760e2178 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:36 +0100
Subject: [PATCH v4 10/10] ci: make "linux-musl" job use zlib-ng
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-10-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We don't yet have any test coverage for the new zlib-ng backend as part
of our CI. Add it by installing zlib-ng in Alpine Linux, which causes
Meson to pick it up automatically.

Note that we are somewhat limited with regards to where we run that job:
Debian-based distributions don't have zlib-ng in their repositories,
Fedora has it but doesn't run tests, and Alma Linux doesn't have the
package either. Alpine Linux does have it available and is running our
test suite, which is why it was picked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5ae80b0486..be7ab4b1bf 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -25,7 +25,7 @@ fi
 case "$distro" in
 alpine-*)
 	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;

-- 
2.48.1.362.g079036d154.dirty

