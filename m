Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFB3B776E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149116; cv=none; b=u+uBF0OIBYYyregfZR9z04Nb28p8FP/z6lISeZPJv9ls/W91yXmiawVn84jPTpjr8S+8R7+oojn7TFoxHmbTeXFBGLR9oib19Fk2myTvyKQpR/t0WH01fqWFeETrkEeajof2sAYotgcpO4odByBM4gjjccZvLK76yS8fUoMxZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149116; c=relaxed/simple;
	bh=UDqFDBFnUglSdR7P/pvn1cnlQX+rsiFokLt2ygGLrUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQqgfe5PydRQSqBT1WJ6UYTiQO0GjSOwavj9YeRhO6126M4oXrzcz0keF2XrMLZ0+MnPgH+jXoyr4lXdJuV6L7wwrOfWlpIQxB+vXDTksdCTjBYL0SAQV04ACRT5K328pydayKSV2o7oMbEp+iSEAEevhggLws0H/LP0rNxBON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kzQkffda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imMVM1Mq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kzQkffda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imMVM1Mq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 37573EC0B0D;
	Tue, 10 Mar 2026 09:25:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 09:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149114;
	 x=1773235514; bh=xNaAwW075X6A9+WrOSrZwO/l8Lu15cadrxxX6H8QDhc=; b=
	kzQkffdaBDaPJOteqrv1IIb9d24CEg0DO8wySDwyIB/1w4qwGU/BRhXlzubGakd4
	jYYuhiPTEktn9X6cfGtH8JAO/39r+b6xC9msc6ZCgYgEwWuJSg0uJXfLRXWMSPj4
	WAy3sNGCYJM3bct5Uwl7gemUeDHJvvN1AM7gz45CB2y0PJK3MgAreI2j9IIa1D7/
	EIQU3yNVlifAC4ar/G8TLXGD1I+ZFemKzsmeE/wxJ/WfT0p0IOwKxyRfuRN2jK0Q
	vDDJaGQFDoe0cXB6sfcX0cLZ2p9jOFaSMpVojVCCuQPi0RiyxrqoCbFEw7IsJ0aH
	MSzEsbE9rmRE2OrFmNZO1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149114; x=
	1773235514; bh=xNaAwW075X6A9+WrOSrZwO/l8Lu15cadrxxX6H8QDhc=; b=i
	mMVM1MqW2f43GzWYmJqqHMZWJOu+8ix5MHdMCfF4ptV/r2O0cgR6gnqJYIgtaoAD
	8lckUzgzoKOWQZFNao6FfvalrAEubkh2EdHIf4iEFxFOIXC2zpouG2nEk33nhP2F
	HjcwYeiir7F4nu+k6/mIhIT7oljO1LmHzKDkTiWcUFIB2wgpv4LXdWc0fUU7q6/6
	YsnUTY733N0cdiNRLXJTJqPnU1X2ug5wkbAsnX6fizZJCCwZLOyxot20IFBSa5cd
	Oes8oS7UMgp8lnopu7ya3W9rga6sysKHBAQMpoJQvl/IW7fVdLhO1feMTQex0g72
	fl7/GFYXBOrjlUinn9M1g==
X-ME-Sender: <xms:uhuwabSLudVmhvyaP_H6LKEOOzkfmj1e-yBF2bgcug9fdR6udhhtcw>
    <xme:uhuwaToaobBKU6-_O-_acpUTsV4fnwNOjD-tVOpRpOzAZBKYIh6wRsOo620YVVrCG
    2q_ZrfpwdzyWGHzKNmw8JRpGfL9_cPMBVzVRt-F1XlpIPpXdftN0Q>
X-ME-Received: <xmr:uhuwaZLZsg5uZie9fjYrKJ4gy76X6qohaStBREReoBf_8IhgBL6N4N_1hiVTpeuGmQtfa3FGsKn5OnH7UV7ZY40E4uZbVUI8GdYcIb9i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:uhuwaWr52KXnK0WZCGSmt_WvMAzfq4KoumIuX2t6S2Lugqfcm_1EYA>
    <xmx:uhuwaRwrRZw6BSEWX74le_EFgB2kXJL7rEjZn-7duCNvglDZu-rrrg>
    <xmx:uhuwaaPc-re5moS5N2hMDJWE_kziqFeQnMWVbi85QTT45Y7xO_9NZA>
    <xmx:uhuwaW6rh867w6ZmOrNxQlMrgfQ4Tr1OwZgJ9OitfezYIJbtIruW8w>
    <xmx:uhuwaTLva8cqFoe0y3XJJScPYoBYt4MRqmvLrCB_wLeX-ZB5W85y3j1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 711b0c3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:24:59 +0100
Subject: [PATCH v3 03/10] upload-pack: prefer flushing data over sending
 keepalive
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-3-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

When using the sideband in git-upload-pack(1) we know to send out
keepalive packets in case generating the pack takes too long. These
keepalives take the form of a simple empty pktline.

In the preceding commit we have adapted git-upload-pack(1) to buffer
data more aggressively before sending it to the client. This creates an
obvious optimization opportunity: when we hit the keepalive timeout
while we still hold on to some buffered data, then it makes more sense
to flush out the data instead of sending the empty keepalive packet.

This is overall not going to be a significant win. Most keepalives will
come before the pack data starts, and once pack-objects starts producing
data, it tends to do so pretty consistently. And of course we can't send
data before we see the PACK header, because the whole point is to buffer
the early bit waiting for packfile URIs. But the optimization is easy
enough to realize.

Do so and flush out data instead of sending an empty pktline. While at
it, drop the useless

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f6f380a601..7a165d226d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -466,18 +466,27 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		}
 
 		/*
-		 * We hit the keepalive timeout without saying anything; send
-		 * an empty message on the data sideband just to let the other
-		 * side know we're still working on it, but don't have any data
-		 * yet.
+		 * We hit the keepalive timeout without saying anything. If we
+		 * have pending data we flush it out to the caller now.
+		 * Otherwise, we send an empty message on the data sideband
+		 * just to let the other side know we're still working on it,
+		 * but don't have any data yet.
 		 *
 		 * If we don't have a sideband channel, there's no room in the
 		 * protocol to say anything, so those clients are just out of
 		 * luck.
 		 */
 		if (!ret && pack_data->use_sideband) {
-			static const char buf[] = "0005\1";
-			write_or_die(1, buf, 5);
+			if (output_state->packfile_started && output_state->used > 1) {
+				send_client_data(1, output_state->buffer, output_state->used - 1,
+						 pack_data->use_sideband);
+				output_state->buffer[0] = output_state->buffer[output_state->used - 1];
+				output_state->used = 1;
+			} else {
+				static const char buf[] = "0005\1";
+				write_or_die(1, buf, 5);
+			}
+
 			last_sent_ms = now_ms;
 		}
 	}

-- 
2.53.0.880.g73c4285caa.dirty

