Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9625F78D
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908470; cv=none; b=unxWjYTVUcye1xGymFqZejmhVe0vodDOyVNBk9/Mxm5dVGr6WnnaQOWzpdxc25CwOC27CzpOEX4hfgSzjt48pRv0gkkXuKp0EBFHgA9rKI/ebtr7l6o5aDjf96+xwvzQlGUofKZmbqtYid8Urzd4w/R5HvadIw9RkiSeM+6YGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908470; c=relaxed/simple;
	bh=0QvGEqC1CcXw7qB+3oNkUJawQaEJu+9o4Wx89q7QTk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJCaZMF/iOYIJI8W1SFXtyTzdTsLxW0v9+KI6ZIn7T2Np+6Y+0T1wtjR+B9P+BulQZ+QwUc/tvQRaMDAlVfnGFBP4EAEdaSrlbLq4smRP3SkJ1qLFFBgtrQytqQvfDaj8hdYo63zYSouAY60bIWGbXO9ehvNh1zUuA/CWCNWU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgaOvUyn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3xhjNh9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgaOvUyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3xhjNh9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E7EB1140297;
	Tue, 25 Mar 2025 09:14:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 25 Mar 2025 09:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908468;
	 x=1742994868; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=
	MgaOvUynqyj6M/MnDrls72IEdAFRNZLKBY7lOyZ/rkQnTFl/EsUxpTKcVvAm3hbN
	OZkYlvnCofYVIs3HnP2PdBrH0hfEWqR3Gs5YvwXuJq2tzijiUotyF1ZZaKQOU7ni
	IWvV6g2qfQNOwL2QU9ACAdx/HFMDmg+wMqpvw19bZqAFhDdk7+IycvT8mXmgc2SS
	si+OKej4h5FBq+Z90iVxYk9kxZumqz65G2dp69Otri1/wsYI0c0LbJWTMoozLFJ/
	RgsQ1pIyW8jQoxbCUP8hlmrktsKz8iORBOBCTP41VljPtsgtOPPbpPq7AGyIsvjV
	I6ZyYFGo1L529ETehF/L9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908468; x=
	1742994868; bh=TxAb3XKVEc3uafQcc1aYp4YdbmPnHpNoCoLGnfZwU+s=; b=K
	3xhjNh97yzt4WcHiR5HUW02m0m51ahijw2x6j/JZKH+gcjEziA5hwulJxRs5QzU3
	Z/rDiPnV57NPQJ8C1r7fB8MrVflmOpyuWwn7JamY/mY/kV/fqEbOioUhsYxO44kq
	tlp+NLgB2otWGgVm13Ra8cdWEmDhfaoIhmwkKHCY/VpqysEB4okUbFOD54TbtxOU
	wIi2STJ9Ab+GhTc1LWsBPQhNwF2cw6hbjadJA/JQiEZKxPDn9Eh0cLjTLN3M/6E8
	S3vn3ztOGcnD6UP+K7R2p+1gvFs4f4h1S6tkqekWYbHxtflRXQCXMZFFiCM1Zd0R
	zXvZBibDfPTGUAvGT4ZtQ==
X-ME-Sender: <xms:NKziZ75zL0Aixl5VgalfNZkVC7Toh4HU2uH57oNpMrHB7jBojhyycg>
    <xme:NKziZw4YT7UHJqclcylwSD6D1g3zneu2Zho5MeSlY9a8xsPPC0-WkcJuLjAdHzhmT
    UssCERWWoN3ulHOtw>
X-ME-Received: <xmr:NKziZycqkorj_OxPbx6v9eEC0NKJ-2P0ZlHJgIly7IjQzQhRHOh0H6PEfhADNMnCTHytPdnF_eNCM9DStgh22jj1n0wMehfge2czqVDynNGQyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NKziZ8Jo8kQJqncO0dyd21Yc23YjxWs5pQsezgl0OmiScPkREmCnXA>
    <xmx:NKziZ_KqcDCyDMTvMy08q61_WRkO5OvqbScsaj2dIPF9R8USwE3ZTQ>
    <xmx:NKziZ1zRjM22yjlh8iXJOE-JiWVFj0Ws4DsyJ1ZyQUnYoNm0WkI9KA>
    <xmx:NKziZ7Jde0Q-JqhxB7kGux8SV51bERkTHPT3gg0huqJB3B2iM2BIVA>
    <xmx:NKziZ1gei3s9Ty2ZOHiiZiWElVhdNn9Rq8zF3PxiWXWpQe89PpozyLNZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 198b8111 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:23 +0100
Subject: [PATCH v2 05/20] t: adapt `test_readlink()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-5-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `test_readlink()` helper function reads a symbolic link and returns
the path it is pointing to. It is thus equivalent to the readlink(1)
utility, which isn't available on all supported platforms. As such, it
is implemented using Perl so that we can use it even on platforms where
the shell utility isn't available.

While using readlink(1) is not an option, what we can do is to implement
the logic ourselves in our test-tool. Do so, which allows a bunch of
tests to pass when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-path-utils.c | 13 +++++++++++++
 t/test-lib-functions.sh    |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 72ac8d1b1b0..54d9ba98c0e 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -323,6 +323,19 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "readlink")) {
+		struct strbuf target = STRBUF_INIT;
+		while (argc > 2) {
+			if (strbuf_readlink(&target, argv[2], 0) < 0)
+				die_errno("cannot read link at '%s'", argv[2]);
+			puts(target.buf);
+			argc--;
+			argv++;
+		}
+		strbuf_release(&target);
+		return 0;
+	}
+
 	if (argc >= 2 && !strcmp(argv[1], "absolute_path")) {
 		while (argc > 2) {
 			puts(absolute_path(argv[2]));
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c4b4d3a4c7f..bff8c4d1b41 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1979,7 +1979,7 @@ test_remote_https_urls() {
 # Print the destination of symlink(s) provided as arguments. Basically
 # the same as the readlink command, but it's not available everywhere.
 test_readlink () {
-	perl -le 'print readlink($_) for @ARGV' "$@"
+	test-tool path-utils readlink "$@"
 }
 
 # Set mtime to a fixed "magic" timestamp in mid February 2009, before we

-- 
2.49.0.472.ge94155a9ec.dirty

