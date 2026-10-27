Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098034;
	b=aaXsmjybDT0uQUtymZCTl19Q5unUFBc1EcE84JpBSbHfkuaCWw7OhK++g3CbIW090NHX
	 04sr6XDBEAbTH0gVkHC3w020g+rzvfP/JWau0j7jCTEIwW8vGdoMxUq2jyZ2vm23l12Fp
	 7Y/0wSo7yal6cY3qOu/vDgAyOdphJDBurAnG+Oek4/LZX/fcdtpuNw4/xiTawJGWhEkK+
	 T7XDqSCqgAdKSW0Y8zf5FNbcofGEOPWDmGRoKKHihlo66RZwbPBZsA/hJpMGlor87gjFE
	 BflR7K7S62YThtJmsn84K7OxAR6GYrTtheUpybF5kccX43w5ZFQtBfFOxFBvEXwP8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098034;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=q21vaw2fRJTEIekPPIBRe4LBE5IOylvPep0xwHM2kpk=;
	b=pz3g4LEE4yiL1yJLDWIuKJIrkGVYi8WqRN2/79xFqxzykJR9R1SXn8/XYh7Jh5LVMlGP
	 +I39USHEKpbjCxCPzKJ9BTJebXNTxW49UBGoTJLYHmQvDwhaTx4TNlecfUknu/oyHOarV
	 mpRR2rV1Y6SyHAO7cZ1EI/vh8jhMt+f8nYDwYo0OeMF4b1HnRpyL+vUbNrmq8aNvZY2QO
	 2iQztgbqePbbP+YVVGharFOLbgf+gLXOOEJReVlwSXHcgD4xG5+LxlCxgNk8KUKBFPb9m
	 mK7tQ/P93bP/DvbVWepkI3bHrc6jQ2KoeNzoQE2FyMmUjOV0MUkiDH6G1dSDhA7T/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vuC7X9gG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=d4pBx0to;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AA606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vuC7X9gG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=d4pBx0to
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 64AF61D00119
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 06:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098033;
	 x=1793184433; bh=q21vaw2fRJTEIekPPIBRe4LBE5IOylvPep0xwHM2kpk=; b=
	vuC7X9gG7F9o9Ir3/GWvhV6JRCOJFw2fMaDUKePphj/uT37rtwI9ad00nub5VYjw
	IGwpzo5t+HGbv8Rry9ors79VhOKq+RfnAm8euaZPEAy9btHbo2ZvtsmCsbwNlKyw
	lY8S2oKIGNixFvEsrBX1oMZyD+6ZQio9aJLs5d5g+LHg0WeUXWdAiy3h93Wf2IDt
	6Bz1ACOhWCchdm9ZufbgxYdpZN5MX8hZyFXKiuwNFVuKQMFve0WGVkcOdlkPDqqr
	UXPGuLBTSQ4SypL4Pt+tn8gmWteyJos8DGaPi7dtrxhYP3tSrpfyrMRbLVrFrRMF
	4YsFTCvc+3ogg0Nmdmn1kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098033; x=
	1793184433; bh=q21vaw2fRJTEIekPPIBRe4LBE5IOylvPep0xwHM2kpk=; b=d
	4pBx0toVT72mm3BXcAoka38l89zJ0Y0vY8NbWfCYAh8o0j5JOsZJlNedDdXQ8RPz
	OSfE+oE/LthZu9jcgOounlHlyUqb11yUsUc7slr91YZ6xyLSHZJkL3u3IUVHdnXJ
	6Ef7JZgPmHw5eYdfVsboiObEZDjL8r4wtZRSJTs+7dUUeFmB/MZ9Yv2h9vh+z6Tr
	CFxuq/V4L1zh7W9lnCaITqL+hGAtjnigALo3EIkeg0168OBHl2UEC8IGEkmFWv8s
	v2i3s0CzN5MTe4Ek7f1eU15KOi3oIsAZkAw5oZ/foWgXoc+TBLvItd5AhJkfxPvw
	of8he1c5+oknlgAlJeY7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098033; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sKE0q/pg2qIQ/yA+LVPkgBssRdGvtKippMde3xylvj3w4j0
	P+ELPyF8ksxbXd0nVGykY4/5d10v14f9o4CXODN29/60XPOOmR46786WtAtXRF1j
	Vdgs5WhFnnPU3P/rW60mQMXJO7c6UndxqjjK0d53zYQbjFnW8Q9pWhlETtghmEVl
	XFsLC8W7kak0fKEJp8Ve5N1+p2btzrs+MEDs1+YEud3AY2PR7ENhRkAgNXTNNO6m
	knjIAx7uKmI9BejP97BWHNbam+3P82ak1ryHZKigCOHFy1SD6uNYBjpZqOu/ZpxZ
	rnsdO8KSI3s3wODzuq7UqW42YSkg0QHAKkITqrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9Rh42D1eMBCVCHs8MyHxTccnO6yDiUOdgGtGbp+eZeA=:Rzyg6M+cUSgsNQd/Uw4ppWdq5Vmg4zh4tpiQV50vA38=;
X-ME-Sender: <xms:MYHgaqKKezw6VGYgvCWpuDeF4bLWpdkY1ixo-w76SmFDZYzbxxmiQw>
    <xme:MYHgapGnH6-Dx6jCl0pS5QgvJwrFy4Z75eDsqSaTSUOromK2nTYt8JxwdrAZqHQo_
    550tPeeUaQy31KHv3IMMW0kmlI98ajufkPCv5jYwFuUCZuO9YzM4AlR>
X-ME-Received: <xmr:MYHgagUK1bSIwKbVBs1XvpJxmQL-7Z1QEfp7va6WIzzJwufovW-pog>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYZ3
    /UJbBhHLmB1OLJDNdCdqIwYntQldnQfKGzNUr1wV9Kj1SHBPNc+961txdWBPJhlqKfsqcR
    ch31yjE4fXFuqheDWoB44BH0H7E4S3yvATEQboWequOhlxH8eA9rGgR3xwpuJAKkLlh+gi
    In/LH9Sc3Q1B10V8TitcjZoPKlp+LKOAUZAvUqQWKyVKl13a1XQi2mpj/osGqevlhIqGrD
    /wU60wTZaFNLucZWTcGueUmLo570XYYtMlCgKvSCILC5X4t92DaBznXvHN2j6BCH0Af4tw
    LNlqisU81gc3f9cENMzGvsYBeXLUT8+Bioh0GISHd4rx+Ef6eF8e373NrIQw
X-ME-Proxy: <xmx:MYHgakhDx2AO0nC1kQulIhryAT42VLgp3l_RX2NAWy9Ovq30RwOQkg>
    <xmx:MYHgahRLz1LusxrQV0E3Z5zmuxpUe1EEfesX1mtSpiK4gjeeLP7tOA>
    <xmx:MYHganHc0c9x7aHaaZfdVMccrqtSA7DQZ-QkEEVZZtudTJyCWvptvw>
    <xmx:MYHgaplrk039z-SGAU6lYeIwxXvyh-15CdBuBo0ljbcBJ2idWC2U_A>
    <xmx:MYHgarr0sv9b5LRSdJuYtIWIKjzn1eFEyJrlhXlDhJhjlckwwA1lYMfq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c09adfed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:47 +0100
Subject: [PATCH 04/12] builtin/rerere: stop passing flags to subcommands
 that ignore them
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pks-rerere-subcommands-v1-4-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The git-rerere(1) command has a "--[no-]rerere-autoupdate" flag. If
passed, we explicitly enable or disable recording clean merge
resolutions that are staged in the index. This flag only matters to
git-rerere(1) when not executed with any subcommand, but we also forward
the flag to `git rerere status` and `git rerere diff`.

This is mostly harmless as we would ignore those flags anyway, but it
makes subsequent refactorings harder to understand. Prepare for these
refactorings by not using the flag in those subcommands anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 556f267f37d..d65870779f3 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -107,7 +107,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
@@ -128,7 +128,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				      flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;

-- 
2.56.0.341.g393f52fd96.dirty

