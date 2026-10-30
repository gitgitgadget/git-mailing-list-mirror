Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382007;
	b=lz0RnHEAulgb1DIjiouQjemgZBRf144AOfZ0N7nIRj0Fy4C0/Num30Lap41pcyqFQcsi
	 W0iynV/B2Ojc/izMagmN3QcDab4O7iqE2fcv77r7ipi3DJIoA8ohcJ3K0bz16vmDicClr
	 G1M+Tr2MzA8yjgaci0fsdWymsmjHo11TnCEaR5onNoi4rcdOQmgTawauTzN3rvax9HgOA
	 S3IRSsURR3XViHyDGfxw9z/iz8mjWT2B8F0nTXVDgR12sGhidoBPvvBcZW7/EDCOLhH2o
	 lau3k78CR7FdjiEDNwm97m2REF8b+rKtqZJCPtcuM1ASy54chW1+baMbLw9T7WrsSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382007;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=piqguQnhqo2IH+IJil7lIZaZ2uTIDuKntqodCoVcGZA=;
	b=PHxRQwl5phs719tbeMUp1Kgiy5ieNMdUCmult4AW5mipbrEdwVMqXjhvUuipBaWAne23
	 hJfLSf7H8OB4qNlfxUCzF5ZV+7tgTul19BRGT69D1XEddrHylFAezak6NBaux+bMhsHxU
	 k+c/FMm+iDeydR/6aoKnhGiarscDktt5a92fbjDlZVGh+JgBfCWxBuRij/k2NE+3jT7yO
	 noMfP2CTFUgQMe2/IeNmkH2jyO5W3K25PPli0a3T8u67nAAoUVc0S+PeBnayXf95HwdgJ
	 Bj6CoRhiUo76FECK7kJs8CLnsOPS5B7qTWqGggS7XFCkLGJtNIQNDLiYUC25uwwtnlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gyRvie8i;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KhGRZ7Be;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DD606A327
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gyRvie8i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KhGRZ7Be
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3C197A0120
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:40:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 30 Oct 2026 13:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793382006; x=
	1793468406; bh=piqguQnhqo2IH+IJil7lIZaZ2uTIDuKntqodCoVcGZA=; b=g
	yRvie8iSqihbFHAtqvoxOQg6ywtMbEJtTBdFJ3b/6BsAprm3LxhqWZT8Iz4WXKC5
	TLHaDCe2ywKv+tcCBeShTWFMldBjLCamoLY48cNiTx/XTPLjWzjw4/JeWFumprqO
	Y+ecRMg7N854LhCohyjECVrYM21H4RDGq8lBXlXQ8aZ9vgpZWkCvXz12FfkJFBBy
	Q8xKboIi5QrchNP6MUcqRQKmXxQJkMMO75l8p0OkZsK/2ExIqwd0qNzwdRshUm/l
	PsKeKoTyz4Q+I+FlHfm2qk52IhRJcxps48yjveYz5k3inEtZvmh3GoZqLBsfoqKb
	QyvEoIPb0vtXtPITFK9Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793382006; x=1793468406; bh=piqguQnhqo2IH+IJil7lIZaZ2uTI
	DuKntqodCoVcGZA=; b=KhGRZ7Berc/kmx972d/J6rxzGGaj2TdgJLjp/CUQ2qtf
	zsMeMTtrDPiyG2DV9sUFv2TSxdFKqgGhqDcSzpHd1wcTn4mOzi26zTNXWX7ghyMv
	t5mRAMbkvAetTFYh/ScyUG+qkcIOdai+JbHFkDs2NQzTTxyuiAmnectwXKAsfgNW
	lcW6HaOKQ+fo5L2yqpk4fH4pqZEHHkCg0C4wFrjBAORexg44iHfHXRfvirfHwGlV
	BqdmwfcFjKSH9xZSzSujrkmpsBWYkpM+4gZLhNZuTMWZX5pc21Q++z3wrgpN6DgO
	LHIjBffbI/NjqoOfIEBcaMcUYRUdJUj4QN1yoCLGvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793382006; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:M+vVy4NZ/CF8PK+73eQYaFgKZyqpgOhj9cY7gOUdh7mZ906
	R1y0b4IKCsputUo65tJIFXD4q44+qQGQ/heTf+TYZk0d1DV/f8EqOHV3p8gBYdhO
	eTL4M1vbKUjanqPKOgvqti/RFb8vPTG+Ba/+Bn0aZIaD5oeV5viRiusg+TdHUHX/
	10pPZDsmxUfL6g5luME7JM4KoK+Mwkv3YsjlXZhN1tZTb/5GFyxUnHqE/T1NzFSZ
	0Kzk404pXqsUcwuXiOJ8Ujb3RVpQeVyVcY26Wqyg4UuO4vdwOAwWmOhmGal3xd0v
	Fb+tJoxBmAzMgT1Ts5TmUD04dljJ7xHfEB4OiyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9byA3eUdm1xrIYxdnX9/IBSQ0wOS/QDOp62CNLjmhyI=:xf3RFkaZhMtysvxixf+bacxKUD0y/2Vb8l619+XU8fw=;
X-ME-Sender: <xms:dtbkaiUwu_Nyy3C7D7VnxgJlX33zHUnV3sSy3d_A3RzDFAS40HHeqA>
    <xme:dtbkakldpETBuB9v-AdjGAOLwIjHAdsn-_MSAdsTONX78_Z7LxnMPuIvvdDsA0f5s
    wXxUN0ffAirZhyb_l0wA0rf_Rg-xua-NR1EmITxG67J7f92EkdIFu4>
X-ME-Received: <xmr:dtbkakBEYGfwd4N5P3WjYXQaq24LPcQ7o5osnvEZCu7JpP4XvgtjOcnN6H7ceJ-PvYJUUjF1FsO5PrQay6UdlQRYnm7-63krqujS>
X-ME-Proxy-Cause: dmFkZTES3TQjvhT6JGxcQNqra5Fje/GmahBRK2K5UBap7web+fxi8llJ2UQwMHhz4o0Wk4
    u1gSVYlNvxziRqdWFFEdVU0gnOBvfSNDKg7b8p1KwZVlp/wx+Rligg3XtLOsnRLHNisBPJ
    R319bxIG4V5vfZhBJ9sIoZvBMJKa9fcJW0AxsCCu6itePzJNX3dHxtIoWNP4fK3cf/GP3q
    2JOD+s+bQ9JDoGHtixt4mZh9cl5ozb971FLY5mR5gCy/sLuE8x19+n4Ok/RWwLPI8Y5rVf
    XZ5vyawgOYICQv3CdI5BdQjI5NPto+nWBi8U9HYq7645bDA6rrUQBuKgHCBy8J0x+/ICr+
    QOJBt5UHgq3eSR5wH4n4YeW0o9lAlWvfRRaZRXdos8wA++k4TfNd2KNQa9oXvBTx5u3z/g
    mjL3tgwGzrag+NmsKXOqsFGGE6p4il0MSI3M7V3kE84PkQ3iD8psy64dUak68cUzhfKOCn
    iaTeQtudnuIGnTIawT28wsDBshuQFjzZOG+Mufprr3T7nC+0EVcRnLD2sjiAsQLmZFgsfN
    Zob+6HorvDM4G/3vF30XDy3Jq4aeb1TVvaH4+5p436Xh97t3re19K9ZGsL7tpITDqmw1wu
    nqKPw6pKl/oiCyOKnBv8bggQCbEHBGg4ruxLHu1CH1M3tbAeUMZi6C4O2nVQ
X-ME-Proxy: <xmx:dtbkakfYKBRQmhwuzklzZYEVfkMmBxPgSbbpreNZMN3zyn5V77rMag>
    <xmx:dtbkavJd7iR6hYz5f1pIblGdWgzUkdk2zmUlYu0e0FqUtMAvXU5WtA>
    <xmx:dtbkandXlfa-dOxpTUjZoZ37HAc6qReDg4lW521Sy-CGs4RYKFA7vA>
    <xmx:dtbkam3ac9kOOMdNr4s70zaRRYKEmre1IGDhaxHSAmim1LMea0MMuw>
    <xmx:dtbkats0rNvvtNBy0-22eYtCmhg8B1X7MTLQepF0hCrTpYuKwbX-X482>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:40:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] unpack-trees: hide verify_uptodate()
Date: Fri, 30 Oct 2026 10:39:56 -0700
Message-ID: <20261030173956.585250-5-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-486-gd49ba3b80a
In-Reply-To: <20261030173956.585250-1-gitster@pobox.com>
References: <20261030173956.585250-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.56.0-486-gd49ba3b80a

