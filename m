Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994331;
	b=mHWKG5D2gm3bLQlYqwS9/H9IxTciBzfFliNJHDaxeu1lWyz/O26kuiYhrmLTQM1yutkO
	 VjIHlVz7MTTq5Gk4rNYOAWac7bB5Z0EjquHqwU5rQqX6SuXtxa3XJ1k99DZTRuN6ju57X
	 gcKCDdMizd61olKxLTsklswsPNfZ0wua1ief6eRINVYnvS38zICdSVNO3U1DzCcy7vkFX
	 Q8bmtAa79HPByA6DR+pbkviPhHMhrMDbM6uW6jSxhyVb79DOM9s1pJ1cr5cWAN2Oh/Y06
	 r9NZwL+XJsoUHQazIbfyGwe6MWP4IA4O0FjtvDLxgIjNqgjuRlZCx4TlTbP1SXOC1fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994331;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yA+tlTxid/EpbCGQie5PzT2WvHL49C30NpnN1LJOoS4=;
	b=LbloHQ4fcKOzuHrudLUI/XhQsi71Kx7gpSWZx4ISa/xp+ZAMXXXR1LzL2QGHlo560dNV
	 vCeu1/1cRhZBYEZgnhoLpEFixyscSfDCkRxWOk5nXcdhiFQTlcHZUQvW+7Y7xNAtKQQzT
	 FcaLBt5hLhAN4S0RPrlGGkWC6lmvBl5YY3vR/Vr6ZKpyawX/7TWsGBs4P/UmTTefHnRdG
	 OnN8uWnp9JlJ0hXOE9/39139Rd9Kw2qeW8HRBZPUEhRvL0mUhgcbJhkV4Ulf7xu15VOir
	 jhfItMljhvE1DCQjNBgVaEixRZEIrcrK9DIzNzm1PMThJTewDenmV98zcgCMi3ob88Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XPPT5JDC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z9Gqo44o;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87261606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87261606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XPPT5JDC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z9Gqo44o
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB8741400103
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 04:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794994329;
	 x=1795080729; bh=yA+tlTxid/EpbCGQie5PzT2WvHL49C30NpnN1LJOoS4=; b=
	XPPT5JDCn/hkOjrwL3P2bYH6i2okmvTwhOhAnR+SYeVP2GRKgmSdClxvJ+V9BG33
	nMQb0N5jCZ3EPTVLi9jRBmCnKBDt3jV4MqIgZDNVHSBD2BFX5mW/+VaKm+ADTqVa
	bvz/wg3RWsBUK+VRVu5ZarHYhKmnLU8Qj3TKgfgk6uJAB5PEea/42TaFgqC6RA3M
	gNE0odDDW0uRIty7dMufH3RvCP5GVmZ6RKVp5d1gI5MJJ0tiKAxSrK0PdsqJZat7
	cpYHpr6jB8jnrcmz/Jpn1JBK6CUki+wCXZotupqwy34VxM2OvbWiqq0m1j9WiWp4
	3W7H2ZndhK8bMYf+vkkrig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794994329; x=
	1795080729; bh=yA+tlTxid/EpbCGQie5PzT2WvHL49C30NpnN1LJOoS4=; b=z
	9Gqo44okzCyB6NWeQ7li6QQu9LmmSMWl0kHdp82o1bkbWmKDDtIlcx6YmuFUOtlq
	hqhdkeFc8QEhRZLyWGKZwdM8BurhyZHai6LOumY20KRT+Ua8xbLvIvc4wLokgXq6
	7GQePRpCUelw1mwsidxV2Q84UQN/EKnZDUeIPqPOdxUWiKszgW7bqrYluYvfV9ib
	Cef2ahUeDsPRk09KpOTo5RRrp8+D0u3bpHHCsB9ImmWDmebbtg6BzQC4+S2pGTUO
	k24gSE/S1anLjVU2m0QCAvebR+DTwyckVuZa+4kknXd26wJekWMLF+0RpTHMsz3u
	MxcA8x1qZFMbHkKqAIcSg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994329; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FLhrWoEnFq9R48ailiaTKJfBRU5WnwvEBCacXQp2x+gfkvz
	iQF8PeJAoI85OVe21SB6mtYgy20YobbizvlHIbNPxzyWvALCfjBSkMHNJvHXL5UB
	VIydVhxHxX4H/J9Q6PD0eaLnlE/hlDnL1HbNBCdVXswRjw32V6oBPd0nDnGvMBaG
	CsqnoRnDT9wIqItN91DGcjMN5cVLqLRaOLHAD/uVjwAIljCPPDrNRo48+v061KfQ
	GtAYLOfpOWCx1IN3EtxF0aPHQmUD3I8pQyRhNttoC0eLaxeeyWeh5Qi+HEXdxCBy
	FLnyefAvfSVAtJsS3al19I4dNNFaeTM9pUWdWfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wpAMuo9lJrH1Q4q8KZmk5kIPhVlGjM/OCKf+H9xrr4A=:XRqiaLUiAv/74Mur/702XFnGZdeUYTXotwSyvk+gUok=;
X-ME-Sender: <xms:mXD9aqgazeVn3Wx5VZ0HQx1oHYqedOGOHfRj-SzjhLdGi0iytTiVtg>
    <xme:mXD9ah9exwexlmD5d1gaxB1e2_FUAUNTP0beiJU9kOrR4Z-i9_YbcnKFaKnRq6ehM
    YFTQIlWKE9W5MBAlKPxzFPhh1c4GiZZ4yd8SCsJVg6lrMwz_UM1nEA>
X-ME-Received: <xmr:mXD9antYKZHGSFD8kq4lhzvz2rmYA2Frz76fXdxrW1oBzrsoD4lTMA>
X-ME-Proxy-Cause: dmFkZTGcvMX63WB6NAv+rCi+Ol/GpWxetEFZUqV9F9xGRCcR2NpUu0iVtA1iDuilpY3giW
    buYwGET8/1jUU29psDH7CeS/Sc3dVZfwdZLfkRySvrtiVTVy7NIu+fqfIjZao2MRAenSmb
    U0C0u/7ccu2lx8p/gWL1JIPNoF9dlwqrV2KQyl/gj9g8ZlQ7LndAdOqTz1obrPGQwZqwvz
    jOu2dYq6L8NHsQUL5XSXswY9xn+flIZmh6n0UzTRk44yj3ZhU+Wj5/jCaKCkbksya6ZBBe
    A6ozBxKLeWVeduiprO521zrst5UQ8wRp1703l325ayhl/iHY/XDvOtw7EOmJcWeByy6TIx
    D11T0ceCw7sMYgdsIMt2OcXW7tKPzjXAKl+ETieiPb5nk2fs4Ph82XUcQT1mcjQeHCk88f
    5+LyGix3VVBY1DTS/HLKdEse7WGAWN8WPoYh42xUnfk+yAjlVAgahkBBmJwQV0pKgBdxjp
    iEYlvVxAYPR1uDeBeJwhobXNHSLQ5mQYDkb8ob2qQksusilTe+C823w/pTQbM4klALHXJS
    f9jouqSmxXUTi/m+GmXxtXZTzebTBXnbkyQsefekyKEx/jUh0e/gzlLM8WprtHi75ksLee
    Oh3U/uMWMbkTVcRzk5VWqHjIMG+d65YijZCQ4DiI2H2vdTm3L03Dy3cIoOCg
X-ME-Proxy: <xmx:mXD9aoav8pePI07r3LLTV0q_kh4C2rheCeAlJggd8YiUXb2TuTq3mA>
    <xmx:mXD9anoVtGDai2od1bOBGOiAgTBsWBd4z-r1XZOoDuVP8m1pqRRs3w>
    <xmx:mXD9at-tG1KV3ZlZ2h1CTlB6qgdrScrG8xkCUkjgKVVmZp6dR3pQjg>
    <xmx:mXD9am9rko4O_XT-30lGbt_1YAxiiD71bfiHSg51MkI02HDu1MKEBA>
    <xmx:mXD9anjsqaSCsVz_xSN7Kja_l5eSvB0KQ-_NEPuE1cI4L6NdqZw6B3lf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e393c474 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Nov 2026 09:32:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Nov 2026 10:31:00 +0100
Subject: [PATCH 1/4] refs/reftable: don't write new table on dry-run expire
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `git reflog expire` subcommand supports a dry-run flag. When set, we
print what would be pruned without actually pruning anything on disk.

But even though the expectation is that the on-disk state won't change,
the reftable backend still ends up writing a new reftable to disk that
contains the changes. This is of course rather pointless, as we would
have already printed the entries that we're about to prune at that point
in time.

Skip writing the data, which provides a small speedup:

  Benchmark 1: git reflog expire --all --dry-run (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    414.2 ms  ±     2.2 ms     411.8 ms  …   418.0 ms
    Memory       116.9 MiB ±     0.1 MiB    116.6 MiB …   117.0 MiB

  Benchmark 2: git reflog expire --all --dry-run (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    369.1 ms  ±     3.2 ms     361.9 ms  …   371.9 ms           -10.9%
    Memory       116.8 MiB ±     0.1 MiB    116.7 MiB …   117.0 MiB           -0.1%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3ba6a9ac0db..4216a18684d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2706,6 +2706,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
 
+	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		ret = 0;
+		goto done;
+	}
+
 	arg.refs = refs;
 	arg.records = rewritten;
 	arg.len = logs_nr;
@@ -2720,8 +2725,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	 * Future improvement: we could skip writing records that were
 	 * not changed.
 	 */
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN))
-		ret = reftable_addition_commit(add);
+	ret = reftable_addition_commit(add);
 
 done:
 	if (add)

-- 
2.56.1.831.g720f3f5937.dirty

