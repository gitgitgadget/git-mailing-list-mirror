Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F0487BF
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291247; cv=none; b=VEbbm7+2TuXQtbK8gJXz8wjW+5YG19Od7mYR+27SKvwoBslBCgvYhySDLr/tOiD0DmydGJEjbZW0flUyILP3KnjoulvzDa59b47nx+UAKYd78vU1EAsbY8Ik5ctAdm4HtotGHKDahh7BzZc5mZ1bQTFxuNO3jMROvSXdALh97kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291247; c=relaxed/simple;
	bh=eaOSVf0OVXpQZNuZW6NLEf4/nvy7B5si0bTKyTSJi84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7+WLNvFGgxnNX8CatpnxKk//tajA7L3INrdMEKwGIoJWVYVBb6MGWodrEx2CJ3BU2MBnHC9H/igWRuBSph0z/HVA236GT3B8MQJCF5fNR9SNht3ErFn2btItgwzkuLeAHu8hJ0uV0WLzmYsKwfrTlueuQWhNFix9yt6ITjRL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x8gzMgFG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x8gzMgFG"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5463E138072B;
	Wed,  4 Dec 2024 00:47:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 04 Dec 2024 00:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733291244; x=1733377644; bh=/MKnYkAvkQXwTxvjIpScJXfQ8r5/PIWCRko
	ODjtOc7I=; b=x8gzMgFGQWH50t9V7n3xDje0S3NAsBqS93bCsvYLrEj7a+45R6o
	aj4CdD5k6lOZ0m487Au4MIq5dxUb6B7E4OQgEndo3Biq4oH4qkpDCYmnzXGwoMMJ
	0LRc4LM7gb5EaxGcy2f0sRyoKR/UZxXE7+0VuFDJgCfbA9k3U0FIZwk1Z/ggm9ae
	DiZZSf/ffug4kC5N/mVFm9TB+U9NVdxMs/tBdWYS2Za/+y180XOyd3/DPcHtvj5i
	0k6K3HfDlTbD6lUQXLCNxNpFCjJDxCPPpHQyPRKmpdusL0AuGlwvHYqpcidL0xs8
	++ZvoXAnT5KWhkWHx5Bf3qsiA4Mh0p2rP+A==
X-ME-Sender: <xms:7OxPZ9IbOIb3ytDGDLHXFgajIxpAdYUb-hYBk6DTyvKDvj9i05fBrg>
    <xme:7OxPZ5KgcJjC3f3TooiZ0g0qTXEAGG5t5tKXhyhjWN-bmXcuBkFYNyCxCoPUwShV4
    xVWV1ZXxAhDqOsvDQ>
X-ME-Received: <xmr:7OxPZ1viL7LEotPqmcrFcTbyZuaLGXxqBFyC1UWdEm2WOeajdNA9KKulmYZi8je5AmsHphx9b3g3mnCTKESciuWQktACfFNTjyE_ql4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7OxPZ-aOiL7JUDj1BSrMHP9R0qP5BW2c5gNUTdB8gaHsqrWRF0NEww>
    <xmx:7OxPZ0ZA0zwrya2BDyT0ZLoA2RZJv2ddwHtVfpWNFatoSLTRVARFkg>
    <xmx:7OxPZyDeHyfkR0TKuoGcuLVJ06O3k9SvCNxSiMGlDvBlq3niOHPfFw>
    <xmx:7OxPZyblP0LK5FjhhjuGDPpGumlJu8I2nVv5ZFn_YNNrddKp9M9UbA>
    <xmx:7OxPZzyrJfg9JcARKnZ_htgktNxcUbLbwa5TA2p08OJ_Fj77cUq-1gdO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 00:47:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: [PATCH] sign-compare: 32-bit support
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im> (Patrick
	Steinhardt's message of "Mon, 02 Dec 2024 13:04:32 +0100")
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
	<20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
Date: Wed, 04 Dec 2024 14:47:22 +0900
Message-ID: <xmqq4j3k3sph.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 32-bit platforms, ssize_t may be "int" while size_t may be
"unsigned int".  At times we compare the number of bytes we read
stored in a ssize_t variable with "unsigned int", but that is done
after we check that we did not get an error return (which is
negative---and that is the whole reason why we used ssize_t and not
size_t), so these comparisons are safe.

But compilers may not realize that.  Cast these to size_t to work
around the false positives.  On platforms with size_t/ssize_t wider
than a normal int, this won't be an issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * These were needed to make linux32 CI job compile the
   -Wsign-compare topic cleanly.

 csum-file.c | 2 +-
 pkt-line.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index c203ebf11b..c8ec7b73e6 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -23,7 +23,7 @@ static void verify_buffer_or_die(struct hashfile *f,
 
 	if (ret < 0)
 		die_errno("%s: sha1 file read error", f->name);
-	if (ret != count)
+	if ((size_t)ret != (size_t)count)
 		die("%s: sha1 file truncated", f->name);
 	if (memcmp(buf, f->check_buffer, count))
 		die("sha1 file '%s' validation error", f->name);
diff --git a/pkt-line.c b/pkt-line.c
index 1c7e8d826d..a2bce206c2 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -360,7 +360,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
-	if (ret != size) {
+	if ((size_t)ret != (size_t)size) {
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
-- 
2.47.1-574-g3b2d6bb55a

