Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B9423A7C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103462; cv=none; b=nX2YwdB5bW6Cb0RgKWO1n0busdghVT30o2teqfHnCEDEa3YsQb26Uo8gf35Faj+6sDR274C3FMZVfeCepJC5S9Sv8aKRC9JnCRlNafoxLOG/DXUpJrleGJn7dUV6jYu0q1l6Gk96BDIc5522j2f0SJ417lfPWjnLZhbJP3aI3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103462; c=relaxed/simple;
	bh=gQnoBbKE6H152qBKPWvelT1WncsZqv/NQ6rs+FpMMHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOlP3NU3aS29MBy+uaEwoumo9LOVRe/nX1jaY5oO3dK4LImHhDYNn+ALpZMhXRckp/Z4hfPUFK3vX2R94yfH7Hbs8yQ+0x6htHaYYvboIzjUXhvjS4GNcTafGfiEuA8IVoZHtR5lDAtIoqbte8LvSfeyBwqPqPWrKrP1+oMoyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dEsbhhZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UffMVkgp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dEsbhhZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UffMVkgp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 58AACEC0086;
	Wed, 10 Jun 2026 10:57:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 10:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103459;
	 x=1781189859; bh=lWFOjVLYgX4glUVv+Qts0wrj9vZio9DcTRiXAqA/1Ac=; b=
	dEsbhhZEGlVH44s0HLnTX6IZNVc6OiIAxIVauxi+k2W3Cd6OakSTgENsEyWwtwiX
	AlgzhiWYbePKZHbwibeI7w/ygY+NqAAQig7ltqlwon/wFRTjyr4RiT3V17LDYANQ
	Gp8z1thzX3z0AzrlYRw2FUnnbMiDrBS8UowuelV/zLECZAn0z8TG38/Nph9+nNqA
	MLJaGdKufLedWqax/Q6BN+tMZSUbIkJtlkc+Rzc0zdtmoLX89dO1grIofAwBNb9j
	MCz17HYQfbS4fjR5ARrJmyuO9E0fRiLb+jkC55PX4ZXLZLVwuWWs8ZVnUikmBWxA
	GmAlhzciT1WTPlOQPZZ7dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103459; x=
	1781189859; bh=lWFOjVLYgX4glUVv+Qts0wrj9vZio9DcTRiXAqA/1Ac=; b=U
	ffMVkgpfleNrUMmX914i82SzyVJBT/jGZVXD/yV+/hf8cV4PlQc7IywuIeUs+3Eb
	okdgbbHQj0DEcig9eyVG/fEBeDONaAM/QwhpRWEJd9vlSqTPpmXkHBKfzVJKfXGY
	b/urfm6aeuOGV8ss82NldQdeqoPzczpSE0u7JTPAqcH4xdsffPVPikQyC95j39/Y
	jXwztzEeEk9ImjV60DbmBrIaj5sHvm21dMMgo+Hsl8664Dn2p9adsZY0qPsKQZil
	TAst+/P+DhEwoz5obB4x+zCDnsYUDeZMs8ZAigVCcDNdyW/KLt2BYzeCY1AFgOxQ
	t25l2wURNuqR+CsKwsoaQ==
X-ME-Sender: <xms:Y3spaq7ZW5b_ykSEgANXe-XZ-C-tifYhm6qULXjYtqZmrp4Ba81oHQ>
    <xme:Y3spap6iqfPgEr2raZgSNmA4vA-YBpryPf5-wAeODdPel4DDyZKdJOAhSnFF9gyoa
    kN2eJuMQQA879EVcXG_K5mxMxTJnP2SCG7or_SIw7xPWvqwZjnoO5g>
X-ME-Received: <xmr:Y3spanEnRUnZMi-oh7l0-VNANQ-kXoSbMvnjY3MxdFDTlrtoFGMwBWc556tJQoXvEd1PSZ9siqd9yhd1fNuJOlI9fTk1PnhAMftc0OQvuQ>
X-ME-Proxy-Cause: dmFkZTGGDIv7UKfdrq0F0Y5ZMusWd3/oSa4L2w5TcrIRi+/tkHyPCKVbzpUd2iWFjE/Vxx
    8WD2y1OL2rZyV87G9Xs/4n79Z5KP5ybBR9lyrra1wdYkKeo6qYpWIMpPWZ/dVSPeuzNjMS
    RdJV9Y1b7bZN0S55WKRUXOFfaWFHeouFPDRlVd9kchWJx2sIaCWwQ4VXGT9dn5u1weO2yB
    qb92gmlCdwx3/C42nJk6sVaQZtpKIjLhjMofqbVbxvg7BRG64J14ZdFG/AgP7hQ2xfAWQB
    Kp3n+P8W5YJbiW1FKaTRqeY8F7INWwtx94q40Vy4NbNFSQ1Im54FdRY5O7LjZt3pYnEkfg
    2rxIMskbUlgqsV8KVRjG9cP0Gh2gSQWZFGtuIr8mp2stuN89vOOu53hxiTq50jyEBMs3kZ
    hG34UHogF7Y8OzmfmyXAYYkYhoTDFny8dfR6JcmfZP3kI/TaQPJbxnX9wz2OaGLNBeoFEU
    uyToE5xEgHc2xRywlKimgvvAbDs89mcLi8aN3sqJDjJO5yFPjfx695an8VaD3FQeTZl4Ei
    k9sJ2vTOl8JjODfW3p53d+Ln2MJuB9dLnFdj+Mx5TqB6JnLao6WjzIUqI6xGoF4H3sVX/f
    jth8xt/sfKcGUNRfzr9o24qeFgW3bkiHjQI4q5QCXF79zw9T6XLGmQE3pF3Q
X-ME-Proxy: <xmx:Y3spaiSa59ULoH8NM4Phb5x3nHXldVq7kUikpJQVHnpZZyM7sGM-Sw>
    <xmx:Y3spagt3D2PludRb0NHS2u1UxChQjWX-Ed38ejKoyXXk_iWv5yd8nQ>
    <xmx:Y3spahx9RfhhF2qqlG5-2ipT4pC0238_TJk_cI1EHNMX72Jubq01bQ>
    <xmx:Y3spaq4fYp0BckMXRzWA74xoPRx7133a0ZzYH-JD9h_rG1lk1ecJnA>
    <xmx:Y3spaoo_dL6e1EM175EX9ws2sFFXqj2e2PMc5sHou7yRmEtXQ4IDW-WR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 541dafd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:13 +0200
Subject: [PATCH 7/9] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-7-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When we have an "onbranch" condition we need to ask the reference
database whether HEAD currently points at the configured branch. This
unfortunately creates a chicken-and-egg problem:

  - The reference database needs to read the configuration so that it
    can configure itself.

  - The configuration needs to construct a reference database to fully
    parse all of its conditionals.

The way we handle this is by simply excluding "onbranch" conditionals
when we haven't yet configured the reference database.

The mechanism for this is broken though: to verify whether or not we
have configured the reference database we check whether its format is
set to `REF_STORAGE_UNKNOWN` in `include_by_branch()`. But typically,
the format _is_ already known at that time because we set it up during
repository discovery in "setup.c".

The consequence is that we have recursion:

  1. We call `get_main_ref_store()`.

  2. We don't yet have a reference store, so we call `ref_store_init()`.

  3. We parse the configuration required for the reference store.

  4. We eventually end up in `include_by_branch()`.

  5. We have already configured the reference storage format, so we end
     up calling `get_main_ref_store()` again.

We still haven't finished (1) though, so `get_main_ref_store()` will now
call `ref_store_init()` a second time. The end result is that we have
constructed the same reference store twice.

Of course, as both reference stores would be assigned to `refs_private`,
we leak one of those two instances. This never surfaced as an actual
leak though because the pointer is kept alive by the "chdir_notify"
subsystem.

For now, we can fix the issue by explicitly unsetting the reference
storage format before constructing it. This makes the mentioned check
trigger as expected, and consequently we won't end up constructing a
second reference database at all. Ultimately, this means that we
consistently stop evaluating "onbranch" conditions when constructing the
main reference database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d3caa9a633..e69b9b8ac8 100644
--- a/refs.c
+++ b/refs.c
@@ -2351,15 +2351,31 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	enum ref_storage_format format;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->ref_storage_format,
-					 r->gitdir, REF_STORE_ALL_CAPS);
+	/*
+	 * When constructing the reference backend we'll end up reading the Git
+	 * configuration. This means we'll also try to evaluate "onbranch"
+	 * conditions.
+	 *
+	 * We cannot read branches when constructing the refdb, so it is not
+	 * possible to evaluate those conditions in the first place. To gate
+	 * their evaluation we check whether or not the reference storage
+	 * format has been configured -- we thus have to temporarily set it to
+	 * UNKNOWN here so that we don't end up recursing.
+	 */
+	format = r->ref_storage_format;
+	r->ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
+	r->refs_private = ref_store_init(r, format, r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	r->ref_storage_format = format;
+
 	return r->refs_private;
 }
 

-- 
2.54.0.1189.g8c84645362.dirty

