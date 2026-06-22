Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1813914FD
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116946; cv=none; b=LzUrdnUvNCdaceN4HLSi93q97Wih4NXNfKQIAfbMGsXTII9tjNlpRpfcHK/2LVn/C8U1K6FkT1IBwfikt+Y+U/gJF1Q/k6pGalAEbo2Ysjwc+iyjiqwPghEXRo0tjplQqEkL63ySmRbMzrhR+JWOYy2PMn7q2B7jzK+Bnz97fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116946; c=relaxed/simple;
	bh=Kr80nzQbcM8c5bi+DAsnrGWgqHTypnuEq2rCI/5E2bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T90DjojuKgrxwj05Qw7pnzfg2+kP2BNuz88UFDSBmyMMZ4juyEhES3NFsvlnvAQbgVc5kp/o13SIxtvOrRHo58zEb55BsBP3ZigkHQ37hsUK0od1v7uui6ICJj8s1PAOGZkfc0dhm3X0q5IX8/DsC4JxX7NOghncIQpkzHEr3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EpqWgpzB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hd6nNWWT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EpqWgpzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hd6nNWWT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 041307A018A;
	Mon, 22 Jun 2026 04:28:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116937;
	 x=1782203337; bh=neR+tVEDYOSdy354voOiPSodt4y98BRYeSvVJ2N9lwQ=; b=
	EpqWgpzBt0SNLaskteL9HovK2uhJ6s5WTbc06c/huWIeWGK+iHPVW5lznbSoPg0z
	uWAUHyD/CgThfXC6VJOVsc4xJmQoOLLu3GJQp4q+sf2UTN1vEAIYgMcq+wsIuRK4
	+QiuXzyELptDjAFE4ttz0um+OOX7GG2Gnq6g7bnC7hEEV89T9bb+P8dCWgTmyvsZ
	my5cpqKco7e6KOKAltr1PqpAUIOI+z6UdLaioxqh0GcyP1/ZtwKfMZjIx2VwcCs1
	X+GTzpChGXrDRbTXQymzsz/T2/+GjwBluRMtrO5o71Adl7qU2OXiErAEJ6Rnag2j
	u6A5e24Gt6ADEUvei2OWdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116937; x=
	1782203337; bh=neR+tVEDYOSdy354voOiPSodt4y98BRYeSvVJ2N9lwQ=; b=h
	d6nNWWTkZpMnr5khVtDkpK1Ju5YYDPbb6N/AcqU2puYQ8mctibWKhAL+4nRASQZP
	zwYxzDde6dRltCMgB+hvYFmQM4NdqmgBguIVLy0bu7NkrttPtxhotg8O+MZWoiP/
	7NJQPhZJ/XKayTELns+z6Zl/TKhLFrue44PCBk62dXcb9X657zLvEcwM/e3IV+fQ
	Tj4r4wKQo7taw1fTOr0HKAGxr5RrdbiChItR29f1iU8IkSkDk2d5QzxyQlRzBur7
	dbEK2qx3tRKdeO4YlNtZRtiQNIYnHC5btKM8VnECkHDvyrptVYEPtQ+xKDsA+S4G
	2jJhFVENgyXvExD4w3j9Q==
X-ME-Sender: <xms:SfI4am5ADL-7mvmrRHRXBPBEZgKclexGDS7XqNqsfWaJ7zP6PKPmJg>
    <xme:SfI4am4DsYYSO0xFVgk6aC3-4jfNwKxulYTOc3hIzC81U5DllfqDSqONDw6ofONXD
    bLijpFJgljgqV8Jmwx_aLfwfQCYap1gjIFCMuej35PZREw78UofbQ>
X-ME-Received: <xmr:SfI4aqdXxV3qquleTXBNEVgW5ATCTim6kSaMhrfgMIepJhyjzBA4bzogwmzNR3M7tGW-5F4NobnAxihdTKirSKABxPeYKeT0wdgcpD6Uww>
X-ME-Proxy-Cause: dmFkZTGRJzKlQ6gnwyTVNoJTMV6EJ+dpdvcHXpMKF4cCTYLs/I/HEfYoTVTWhJlCuJZf+3
    8yEG6Ga+z9NUHNxb6sEAQgIcEMrCQ7zhy89lSIq7LwLpCSWdjLCZdgEIOK6JXNXsoxlBP+
    X3AK4ImJIJc1cQUOGFcPr3zCjSpfQ7DfbP790Lt5EaBgh+CukXwDvRLkUDUiPZsEyK77bq
    RYP/STzkdvTx5WFUfXeVizPl8pQ7AGsrPmWUoV3r5tQV/IdZMOhwWWTFB9vAtxnNf0wCcV
    PskJ4WY7GuIG8X27f5y5hVZlKXmO6qFTXhSHEWFG8bAsyhTOttidBGeIQjLEMgsbMZ9LI7
    nx6LaUZiH2/xfUnjjS9MhsPAYRra6pufI+p5nPuLPK5BlOVtRbKIR81wRYkn2f2vDCwNSu
    OQxquswtPHlQNrZX29tJ6USoYAPAxJhoMSio+iMeXN7hqURv4SzlBaHUq0GoKu5tY/i6SZ
    t90VOavNRTMEBlthY944iwwy6ZyeLh7pABVrDYhtha7HlwUYyrDKUB/wQKMZT2QJr5MPKh
    YzZEXpmM2LmRpsjxil0UGQrxTumODk/m9C1TItqv/eHxXgYMOHrJNPiAKQbyPr2SdKqk8s
    G0o1I+9KwaHwtpMPQftraGtBDZdLS6z4zSBC9kZlZf1lzkK6POWJWiNRWpDw
X-ME-Proxy: <xmx:SfI4aiBq2rKD1-aBWH6_Rw5MBesBEEWoYq7cfLx7Hc4JdMMqYqoIlw>
    <xmx:SfI4al8lGaWwqhwfOjNMonCswY4V1LqpUZi_Ur9S-4_i0eL2aAvdhA>
    <xmx:SfI4alKRcgc80wFePy6iqdEXDEibcw--4A07J-S-2X2oBFUae9u7aw>
    <xmx:SfI4amif2rXX6BvA_iPi1_ZaGgPhZiD4N_4LQGuGMquG4lQdjePDHQ>
    <xmx:SfI4akg-rnlJtzrreujX3Artknls1gl80DM5k34Uyq1XME48qkk75-Dl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 856ffa94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:33 +0200
Subject: [PATCH v5 11/11] refs: protect against chicken-and-egg recursion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-11-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commits we have fixed recursion when creating the
reference backends due to a chicken-and-egg situation with "onbranch"
conditions. Unfortunately, this issue has existed for a while, and we
didn't really have a good mechanism to detect this recursion.

Improve the status quo by detecting the recursion when creating the main
reference store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index 5b773b1c15..1d24637891 100644
--- a/refs.c
+++ b/refs.c
@@ -2359,15 +2359,22 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	static bool initializing;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
+	if (initializing)
+		BUG("initialization of main ref store is recursing");
 
+	initializing = true;
 	r->refs_private = ref_store_init(r, r->ref_storage_format,
 					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	initializing = false;
+
 	return r->refs_private;
 }
 

-- 
2.55.0.rc1.745.g43192e7977.dirty

