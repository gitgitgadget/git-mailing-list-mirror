Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AC17F394
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318260; cv=none; b=nNkSD4G0LZKnlaH046VOeqiktnLjgNK2iAMc+WaG2G4VIiXcDTKZRMxh9EJvUWtdH45HUrtSOXSQmuOzrGGd4Wyr309CjzfDs/Ac1m0jIk3Kt/vsWFSLWbK+6RbOjjjMlLorGYhXpUuUk6B6Sq9K1gt+8gRykzxWspMmyy1DLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318260; c=relaxed/simple;
	bh=DEea8iumaiIyTjdVibVHbZDBXPo2P26lnOzw+eVBliw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzitB8H6koF6lscRFR2Q4kex+dFpNItTIXFZ4NhKfiP+DRz+qx0qqQ5oc31vjOU9zGUugJq3P0hruV3j6vFfvbskKnNgq6u6SJ/EYT4CH1Z8Na+pBprDB0h/4INAPoJFnK7V1cuXjEljbpN/kCXtEhdep6mdo1ZiQMaGnG1XsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mURU4J69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjwGRyK+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mURU4J69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjwGRyK+"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 65440138FFF2;
	Thu, 22 Aug 2024 05:17:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 05:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318258; x=1724404658; bh=TBKopDpBE3
	gNhl9eJ/7zC7QF/PLppGWTdOdaR3zQNxY=; b=mURU4J69bsEtD+n9z+1iNIhxJK
	+ASLhNZFva6WB+RRlFOBsvuVDjFM5ttLT+v7q9dcyRfkipacf2a8USC0majjrww8
	p4j3DekGQeNus+Vu8cuFLeW4VQlzFNV7ScKQOWiciHj7JUgn/R2cqowvCWex1ELl
	4IBKjQnEfJ8vSR7+7HKoZYywcU5x3BCDmHR9IQbKkRsekxvpzJ77+fhaEpad0xfi
	axCqKRrNQDPqJdhdvNBE0RYH1rxAp8B1gVbYdE4KxXFmrZEXGEguAjEggT3RAMJd
	UPdtX74DOqHU4ferUR4CuiSjjlu/CeaCBtO5BN6Di9gkYEAzc1m63kCHM6cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318258; x=1724404658; bh=TBKopDpBE3gNhl9eJ/7zC7QF/PLp
	pGWTdOdaR3zQNxY=; b=ZjwGRyK+bjSLCLSt1CZgxojMj90Ps6r+wG3d2Y22bfV/
	aZScMxXAxKo3IIzVgiBhJjjC+WZrv50XCSQCacefgkwG0AEr+xlBToyybovqlqg/
	nhZ+i2vWLn3tF5u45rCBdWEmfx+t+1zt2uQfAWfpWi5csFRDFRWH2jRXyPF1P7el
	1+jnrz+s2LVCYxNPeMOcVsMezd+rvz1fFLZC8ZPHz3ZBqHiUuGpKxaAUxwQP3co1
	2yRIhiQQT3kcUUXkjD1EwB5pq15cKA12nHcxpo2dp5YhkCGfUe38LC/WaudUa5rc
	eX8+B9/YNVZ8CW1nc3GRHbJn2XLOkTN0glE3CfCjgg==
X-ME-Sender: <xms:MgLHZhl8vCoardEuazc7FjlqAkSdYrk1fger8_jtnTFjFWg4qNAN6g>
    <xme:MgLHZs1oweaY11s64OyaGHy62yZRZMtsKqWamwoYHX9Rh0LR0eAl9s3goa4zHxaif
    KhzU8jG6jAPBgVfEA>
X-ME-Received: <xmr:MgLHZnol3l6nPiNZDNpWZy2byIUl-yqbyjrWrKKLdhF-SlDS6_5606rCF66tloOqC2idqQtZ40MZfv0_T9XV968jg2JFwSxqKoBT80yX_8UndNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:MgLHZhn9nJf5FE_qqpQyQgMclJhC3zdqZCBU5u1fq0qRGQtkLOuGAg>
    <xmx:MgLHZv39i9ZE0tKfJzkS1Hij6TGy1PRb2ddtDqCkYWWbL5rFGLhcmA>
    <xmx:MgLHZgsP7yv4xo0-3Rf9eVqKfjpH8oJnVacTy6hmZa6uJtJztWKkmA>
    <xmx:MgLHZjXbDleCMogGeM2waYqtHtETSizk8eSpJqcHwFoMj7u6gkYu0A>
    <xmx:MgLHZtDtJzD_OiryflQGObCRtU961WnSADQW8c63KD2-pGCmZoC7Exgy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c048520 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:03 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/20] builtin/repack: fix leaks when computing packs to
 repack
Message-ID: <6bca72e5c574d5f930c9cefe7fc803ac30e0c28a.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

When writing an MIDX in git-repack(1) we first collect all the pack
names that we want to add to it in a string list. This list is marked as
`NODUP`, which indicates that it will neither duplicate nor own strings
added to it. In `write_midx_included_packs()` we then `insert()` strings
via `xstrdup()` or `strbuf_detach()`, but the resulting strings will not
be owned by anything and thus leak.

Fix this issue by marking the list as `DUP` and using a local buffer to
compute the pack names.

This leak is hit in t5319, but plugging it is not sufficient to make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 62cfa50c50f..8bb875532b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -732,14 +732,23 @@ static void midx_included_packs(struct string_list *include,
 				struct pack_geometry *geometry)
 {
 	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+
+	for_each_string_list_item(item, &existing->kept_packs) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
+
+	for_each_string_list_item(item, names) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "pack-%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
 
-	for_each_string_list_item(item, &existing->kept_packs)
-		string_list_insert(include, xstrfmt("%s.idx", item->string));
-	for_each_string_list_item(item, names)
-		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
 	if (geometry->split_factor) {
-		struct strbuf buf = STRBUF_INIT;
 		uint32_t i;
+
 		for (i = geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p = geometry->pack[i];
 
@@ -754,17 +763,21 @@ static void midx_included_packs(struct string_list *include,
 			if (!p->pack_local)
 				continue;
 
+			strbuf_reset(&buf);
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
 
-			string_list_insert(include, strbuf_detach(&buf, NULL));
+			string_list_insert(include, buf.buf);
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if (pack_is_marked_for_deletion(item))
 				continue;
-			string_list_insert(include, xstrfmt("%s.idx", item->string));
+
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
 		}
 	}
 
@@ -784,8 +797,13 @@ static void midx_included_packs(struct string_list *include,
 		 */
 		if (pack_is_marked_for_deletion(item))
 			continue;
-		string_list_insert(include, xstrfmt("%s.idx", item->string));
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s.idx", item->string);
+		string_list_insert(include, buf.buf);
 	}
+
+	strbuf_release(&buf);
 }
 
 static int write_midx_included_packs(struct string_list *include,
@@ -1476,7 +1494,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		mark_packs_for_deletion(&existing, &names);
 
 	if (write_midx) {
-		struct string_list include = STRING_LIST_INIT_NODUP;
+		struct string_list include = STRING_LIST_INIT_DUP;
 		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry, &names,
-- 
2.46.0.164.g477ce5ccd6.dirty

