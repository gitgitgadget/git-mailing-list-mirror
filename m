Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221391;
	b=tfNmXzooDdQBGBjcl90XEZzyjAvthAdai8Z94axqmykNKQAhxAkFAmcIa+bzPGtb9V3z
	 hPrEUkbYTp7b6EJq56LWKSlf2VRljadXfODyyQTmH5BswoQ7/9v/BT7XOm6YEiKMQ542Q
	 Ig2gvxb/Ylk/m6H4pcS66bRMVRoono/qADCl7M/6NYJ/LcHO6SqBlqAi4yQkvldMst5tW
	 lTmRaizFUJpIMUZmKpY7picCycEJABwyHq21us6xAHQr0o9NmaHRqKZW45hdcfHUe5Wov
	 DTC+I+CyZcJXwMsLePIzEJA+xT+sq1csHTbllvgq03QKClp3SKQ86yg3RQvkcgLhQ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221391;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=drNPX6ycDED/iOXEHYpBdSh4jI8GgTWvAwU2IhaQiM0=;
	b=cS2Kdhs30/4ZKaFDKqMv9xz++YlN9m4VpRJpD8zWkieYCWT/CJFi5Su+i8/lgK7RBzW6
	 zpFmhx1xRpHglhLiMw2cDnufBoJcHYHY4Qa0NB1PAIeC2Q0MporjN7sApstIfkJbfdXus
	 R7pJvtHt8qM4NL0ZVZayPyv24RDdK/olcj3dBCtGqgij5GakM9UDGoPKBIQx09hYsCsgX
	 rob9X4edhZllSQNT+ShiHgiL42by0BZGFcccY1HARvx9FQUJkvoiMYcBfbo9BYvNu81vE
	 9z/n35meuxKuKI36SX42gg7iOqLg1V0/iif9F+jym/J9BP7elSBcuZFnb0QQ/kpMOPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DK70ceU9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=teB7MTXJ;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E8606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 065E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DK70ceU9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=teB7MTXJ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 36835EC068B
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:03:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 17:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1793221390; x=1793307790; bh=drNPX6ycDED/iOXEHYpBdSh4jI8GgTWv
	AwU2IhaQiM0=; b=DK70ceU9LnPZalnZrO3JFznI6R2Fz4HHJXJYmqruUfUKMbQr
	mS/GDeqHNPxYok6P6puPeJk0sOrJJ6TKuTXx6u1RW7SHygHzDiMonQcWnXz7yGEz
	cK2Y1FFtTS7fQBrowSqojj3CCEwlfnJEktD8XRuYQqTIYwKxCPLnLnuFVzpi7qqz
	/TdjFyafhERC3YTt4Cu42ey92ZhIJM1fKEUIGKokwQH0ApIGpJazXzhiSuPvRMZP
	Wx80b/T/4wBBTFMtn/9agh4vU7ru0TGU8bwsQL8djOE35+UHMedOF1aABYvGg0k6
	Cuo/vGup9LyP6fqaCYuJovpFTo9O52lgEug41g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793221390; x=
	1793307790; bh=drNPX6ycDED/iOXEHYpBdSh4jI8GgTWvAwU2IhaQiM0=; b=t
	eB7MTXJQaJU/MyStrLSarbyUoRq5EVyPaYvnml91PeLGi5r5n1CE1u5Q0Mot5zNi
	9M9jhBgvTBCctmDFEPcqpsuh9PSBdXuP/tHsnneLq2gsnR42ab7UwDGBfRxkRFtb
	XV4pYKgJMtdJeAf0PRdTBm7hpInIS4/4GOlE+cuss27pvEGwMobnrcdA7Gk4fvpY
	H4OFkItaV2GNowokE0uD6CYoBNU5W03S8NLtiVcfhgEzRbvDDjnW9ZL4ZiVoO/11
	WnNaO2Qidgay2I7IkN9OKIkLT/bZr8pGXA1GDvM7XliXJK1nT6evRI+uI1qJecmS
	TWUHRQXMcs3BBBbJ4jb/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793221390; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Se5eCNDXbQIRRPEr9V47NIv3a86Yyar6g14qjP0Ti7YA1ps
	7sM99zRrieYusW0CctBxA/2wigoG7fTfXVtbW2VSST8rrDdW+4iYCOhHmYm7nXrU
	U60TVLSf+qDztRTTV5A1KirQRXFJw+i8Ao6V1/xPPcd3oLrkd/RGeL/1oOq/neG2
	tnPV1Fvn+eMo33m14fHBroX2OWCAAWpJTWUWyIuYhD8lM7zbUAo+4Ad0IfqNpwr0
	dZ+Bk60+RCxnXGe59eBHkeDYYHJ2PWkOmVHi5zyr8VQIYall43MYKz8k7AHgW4+e
	yH8vq+OIHJvG0fHK/JyprUHf9+i2VtGYsGv1IDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:nnMHSLlUPCRRnptfMdVZAwlmWBR/YZB2Wl2rd8ruKbo=:6DY/OMhquTRcC/CDQ7O+0EL6vjRSyJSMHej3/Ay/jvI=;
X-ME-Sender: <xms:DmPiao-MqFEJNvF-h4S_76DxTjVq_37yjUylsiGfBEfpdDtLUDvg9g>
    <xme:DmPiamvyc6Ft7-Ex6wbjDzm8tEiw58S01hE0R11YkuosJE-YlCv2fioUFX3K-gdd2
    Gv9mPFP1sV1HvhTpyX3ELrFCEonGyZBpeFm3j5XxkG0qNbCLROIaw>
X-ME-Received: <xmr:DmPiarpPF2OQr0-t_uvW1TdCzoSsECiZCkuUFbWWBSZnP-9LVm2AuYhaaP4hRlLah2CxyaU83X2gqSLfMn3VxNt_BE9uggK7k4B9>
X-ME-Proxy-Cause: dmFkZTGLuU+7ZONqnSc70BaO/HQylPtm5UYmwbzAYcV5wA854Qcp0vd+Azl4Cmngs/NP/D
    WYBlOZ17Ng96zFGtZfsaU/A3Nrq6+saQMZzRmxXy8Bu+HnFXYmPznTnV0EwDBQx/IyZA0V
    kuCjD+Lm5x9eAVvLpkMzrRrPVW6GdTsKCCNHlIzU8kwqomtDfnq+S9uFoMbsKTlgdBZ86y
    J7eJrVrACEr64PR+ECGh2sW1k/ftYuYA9J2M263Z2h2YUXkjVBlAr1sI6QkESA0J9TH0dE
    R86Stx0mfm11DTkQWus3wswvaIIE5/Qty4AQqLmFYcWrGlFQ9x/D4lZbnYz2UNRT5Og8Ts
    rLGSb0dl1fwVqHjowwRzrH3SXc+enYOXUn6RxL7YfkXaZJQ+0wxnKZHlCuuCMBKsMjLhdM
    P9RvnnRYzOjJBUhlMCZbHaBjgGqa/cRxL38vRmJ5W3krpRFnjq7fefn3IF+CaBkpJoRzLD
    Fw0/E3krNc9AcW26ZSyDWKqsn7DEmweb98xcqtRre+xfL+0hZfR/lsywHrUxZvwCT+yI7e
    ueONn84bFcVNvgi5PxYVMSgChUDf8ocfN5gR4AggbW/bbwGUAHeycJ860SOcKmQhiqikQ/
    Ymo/raWOO8CT2YQjTbOTwbZWQzHqeaOi2gBNXgS5kMxH4b6D9MO6I7PUO4BA
X-ME-Proxy: <xmx:DmPiajlX4BWGgW-RIRQq8aaJZDHXTQ8BxoCEEs8eq8no6bJjGISXfA>
    <xmx:DmPiavzWNJ-t2E5fE-4lkTlaLW2n4YckMOmYP7hkrsaM2iUg79KOlw>
    <xmx:DmPiarncjZgPS7soA3leR1HNOOEZ34vEyp7McT8FjIcQxCuNf4RWiw>
    <xmx:DmPiaofj1SzEMR9sK_RRuRV1BRahuuKWxU1JJugiVlEWxpUniARr0Q>
    <xmx:DmPiakUOou3QrHFIBf072d1qPdH0yfUdboMtyuDarIkEHVUtTy2EOyzR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 17:03:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] unpack-trees: hide verify_uptodate()
Date: Wed, 28 Oct 2026 14:03:08 -0700
Message-ID: <xmqqqzh97d2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

64b1abe962 (merge-recursive: fix overwriting dirty files involved in
renames, 2018-04-19) made this function available to external callers.

With the removal of the "recursive" strategy in ad45b327c0
(merge-recursive.[ch]: thoroughly debug these, 2025-04-08), the last
external caller of this function want away.

Make it file-scope static again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 4 ++--
 unpack-trees.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1802809ad3..3298773490 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2269,8 +2269,8 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	return add_rejected_path(o, error_type, ce->name);
 }
 
-int verify_uptodate(const struct cache_entry *ce,
-		    struct unpack_trees_options *o)
+static int verify_uptodate(const struct cache_entry *ce,
+			   struct unpack_trees_options *o)
 {
 	if (!o->skip_sparse_checkout &&
 	    (ce->ce_flags & CE_SKIP_WORKTREE) &&
diff --git a/unpack-trees.h b/unpack-trees.h
index 5867e26e17..638a6b076d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -123,9 +123,6 @@ enum update_sparsity_result {
 enum update_sparsity_result update_sparsity(struct unpack_trees_options *options,
 					    struct pattern_list *pl);
 
-int verify_uptodate(const struct cache_entry *ce,
-		    struct unpack_trees_options *o);
-
 int threeway_merge(const struct cache_entry * const *stages,
 		   struct unpack_trees_options *o);
 int twoway_merge(const struct cache_entry * const *src,
-- 
2.56.0-433-ga9209adf11

