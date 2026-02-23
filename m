Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F6365A07
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848011; cv=none; b=cilyMW5pnAqfuEJWfeViKmWRGCod4SovIHidrJ6jvLc86G6CQY5z1EIccDGoGqWKfPJM7+85F1ePZXnPbFRCRkT8Pn9gjPcwWLJTyb1qJWjaYizHkbmuXqM6Qx+doVvdYZpUyL8kusKOaOZu/tlHZpbZNPTELKFSPaf9N+4N7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848011; c=relaxed/simple;
	bh=6dkEt2J+5rYhzMySzQbRwCbqmOsBF+frzlA/w4qU27s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppyPk+AeNyOtJuaGruyF23o8WegEybPytnVIyzn9YPd5IdLWu367GOPvlO8rjkAYsSqfwAfrmjCoBlU2yQqAMPbjBfr0Nnf/vIAsYBrcVvyYZnuK4U+CYlA//wWxO5noc0ngzmgHFVcoJwjqywdwl5AvwuKJpix2MIhK6wrPGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nbzunlBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0W/9utp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nbzunlBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0W/9utp"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E75FBEC05C5;
	Mon, 23 Feb 2026 07:00:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 07:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848009;
	 x=1771934409; bh=nxa8TRepbSkgdGVISwUcXwyYYHFbnUU+zqWeuvCO4E4=; b=
	nbzunlBMYdM3tocw4T23D4AzREQlqi7EiLGVmV7SleL+r8qW4Ko7UoTixG34SSC0
	H7NENnar8Yc8BN9y1x7iDJcW8B/LeilSO7YXnMKBvKjYtOBSd+0IK0bagM85+5uV
	TlBgN443W3nUvNvQPImrerqy/LSYMJQDjErNuESeDbb9oG6vYn+eMkY9nGgy5sCs
	pekG9QoAp0qa48iKS2zz7IPUoLWhzZEuV3npV/fqhEhudidsx8WX5KtUY0GLdZgd
	zJthFfNuSpHEzPes9Q/tim/Zz+A6TsYq86YDBhJ9V5CLWQlNdHi0TfmkWK7ULNhq
	8qAncZuRqPsYo9q3Ngsv3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848009; x=
	1771934409; bh=nxa8TRepbSkgdGVISwUcXwyYYHFbnUU+zqWeuvCO4E4=; b=e
	0W/9utp2TSBUaWdhW8VlC8KYUxdwGhWjBoF1oB8W1yxtRCPig2dppjg8kOccPzA2
	jskkHii0ar2izR25kkamDbhv8OVsvLYqCOX4s54kKez97hdHTrrBYGky0JjrjT5U
	BqYAYG7T4CfFf3nHXyc5lsOPXNJ7noxVU0+Qr1HqUsraXbK1vXnH6WByYTs3DVEg
	/rwRbqoLMdtZeDQ9DW0WTAlbrTL+0lzwGtEK6srlZZpD71prM2Mlj81jjkTYWka5
	xJhQR4z7P/cqUGinvvWmfABkMwTAKg3zUfudvC6wQAgEFUDEO0mgvmRzZmVaQWQt
	8tcIjbC5LgZdRikwXHYZw==
X-ME-Sender: <xms:SUGcaXceWysy61Sxa07BPP4ApjuTGZsfJYB5wEhCWJgZ578QYInYXw>
    <xme:SUGcaUrasExi2thOXg8keSpU0uvotKhBKBXCDRMhSP_wdmEwftiJA-A_n8StZqbyK
    H-9eBVUfetKes3jfU4Gqngvv_T6356CURCAc_VJtmP0VspL_Zjv>
X-ME-Received: <xmr:SUGcad51ISi--Xr2YnVgux_d7LkF5fkEbyBStMvyustAdCom5-rLbkn7lXgArToVhdjy7y7Vkj2NEo3C5sxPdauy6b6SojpLt0jRPSsG6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:SUGcaSonlzuOt4hXyIp_5Ra2kHuo6NDqJuf-98_2pMi4ZNhU9jiZvg>
    <xmx:SUGcaXjkpB0_zkyoKlciVNSKG_M5HgY3-M2vKRiqarYUlltDFG_xJA>
    <xmx:SUGcaUKYqn2j_-yjUWABwfPFQVWHWKCwRrxVSq6abpKYQgg4W_teNQ>
    <xmx:SUGcafApGc240pPGA-DYUv89h3ghpY1SQSICZxmlPkfRee6nrashOA>
    <xmx:SUGcaYI536Hs2zxdHMFvAxW3QD4NtrFURm_uMtsGK15niD_iId8C8Jh3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f444541 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:44 +0100
Subject: [PATCH v2 10/17] refs: improve verification for-each-ref options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-10-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Improve verification of the passed-in for-each-ref options:

  - Require that the `refs` store must be given. It's arguably very
    surprising that we simply return successfully in case the ref store
    is a `NULL` pointer.

  - When expected to trim ref prefixes we will `BUG()` in case the
    refname would become empty or in case we're expected to trim a
    longer prefix than the refname is long. As such, this case is only
    guaranteed to _not_ `BUG()` in case the caller also specified a
    prefix. And furthermore, that prefix must end in a trailing slash,
    as otherwise it may produce an exact match that could lead us to
    trim to the empty string.

An audit shows that there are no callsites that rely on either of these
behaviours, so this should not result in a functional change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 0aa3b68dd9..a57eafd6de 100644
--- a/refs.c
+++ b/refs.c
@@ -1859,7 +1859,18 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 	int ret;
 
 	if (!refs)
-		return 0;
+		BUG("no ref store passed");
+
+	if (opts->trim_prefix) {
+		size_t prefix_len;
+
+		if (!opts->prefix)
+			BUG("trimming only allowed with a prefix");
+
+		prefix_len = strlen(opts->prefix);
+		if (prefix_len == opts->trim_prefix && opts->prefix[prefix_len - 1] != '/')
+			BUG("ref pattern must end in a trailing slash when trimming");
+	}
 
 	if (opts->pattern) {
 		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))

-- 
2.53.0.536.g309c995771.dirty

