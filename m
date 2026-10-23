Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759700;
	b=nYoQ97+bf6A1dD/XVFvCXG5h8gLlS1BbJ9Mit361ck7OXlS6KUH2wWCK1Rj2pcBc27MM
	 j5AkLKThhDb/1xBJ7rZY9rZDIDdOdYTz7ytbBMvsJbnKP+vhfA4SbMlWJ2RWjNnztLQtu
	 0Dx//A44Kq/yIczw/3xQhLdCUmxmz9WblVL2PJcStCmUkqFAzZVXxbtLSqG9672o4wEvN
	 BW6XB1eqZqJcEvu5SRWn8U30K+Ip+NPbsck2ittABmIgxTXjq1zsP6hPgSEJ04yf57PFL
	 ujBrY8dviVrivhFk4vgVyxNBDanxK5xLMbMBptDqqDFCXAovOgo1RdmnW2e1KlzQq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=7OwCuxRZ73xRUkjnjJmkhqMjDgruMRBND8qi8D2j17E=;
	b=uZwxqLB+PgU3FCuvAd1Q1JemU3awj6r6OwZaBe0ugdIu4m7HoI6wdjpciyFGdLf4ehLB
	 ZPtPsubrsO8u3GfUF4MEvvSqPkNXzqetTVC9F7oY8HfhQia5ypKubDbaD3bp2+DRN1dMM
	 S9vlJuVuXLJAXc5GF84EpCBPkD7iPEs7RFOy45VYALKs40TO7oQ2QzPUteXxUMM1tZCiv
	 8qjHdQuyJPOQrp2I/aERcd9jbA+9dpvSsuY08U561PhmvJIcIqN/JGMjrrAmBmXMizaDO
	 JTiopgYUjgeAGB7VQKRd/CjQLLJTeTrHSDFQyg0CXZ7PMxUVeiOsu1+yBYa44YVa7sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Lj6dQouM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cJeugHGF;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E6606A322
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 459E6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Lj6dQouM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cJeugHGF
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA2337A017C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 08:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759699;
	 x=1792846099; bh=7OwCuxRZ73xRUkjnjJmkhqMjDgruMRBND8qi8D2j17E=; b=
	Lj6dQouMaXUaWuSgtn//ZIJKgFXLVC+JcaidwRDXJxW9MUQX+oBF5jzhRoA9MdTg
	JAM6mpEnb6LPpoYCGkbMktUKHAQQbOzpa02eDih5FHifGjDiHq6TvuRosT28FnGl
	n4djBockWzYy3saVPRDOWr3SCD8hnHOqMIQKxfkTWlTjXCLfC9yO3LunMwqLKhvx
	682BZiXUR43HKPEuDLBkGMYORqOvrIIdK3RcFB62iRu4UWPKuR2FJukkBQ3AR6DA
	MSqgIsA9/UwxmMKUFLa+LbWUDhK+TwY6VMF+vkRKdV0D0B7gKP6rzhni5t9wz25D
	1DOsk/vrJ/GiHhjFW3wkiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759699; x=
	1792846099; bh=7OwCuxRZ73xRUkjnjJmkhqMjDgruMRBND8qi8D2j17E=; b=c
	JeugHGFU0nCkWAVdLM9UsVyZgOPX+4lDlHq+jkXkjGBej7y0xrLQOk1jKULYDW0e
	z+djzAoUqFIH6uBHS/iFG6BKq/qyi2eHeBK6SWDkWoldYsHowvK+nCjakewzzhEa
	ODFlRyBYAFNlK8moNd2iHouRBD5Avn1/f2umlJOPq6Vkv0BtnRb41ch0Hsc2hOJW
	wPzIrQ3/+DW3d3NaPvku51aiDSzoQ6j9ObO9z5VZOVGGIj88TGQ6cBz+dCmuvKYJ
	slBuHy/LQ0SFxnNhDLxtMrOia2hQ3FlXIs+e6Oe1ZXQoAhAS+vg0MWaOOCyJvUNN
	ct9QQatSar07oTUfO9vug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759699; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TIj62qaeE8O4I9Sv19KrFsys4tSfgDrTmGeMEhvdOCN8SZe
	zXcwjTw1fusXXEUveU89Kfe7Xvev5/sJiBO22B13PHqa+p2piX6rzfeQSg0xHdwC
	x89NbQtNZ3sYQZDwEgLvYJE2XGBFzwIhHKaqTuEffyYh4TDCxlijUwhjW4W+R4J0
	Qxv504Iul9KQkFvkNPMQlCGz32s8Y3qCOqYVqrsI3EeKK2rCHPCnlg7S4wxQ07V5
	KdL7W8Ur9LLfszY6u7VwZYeOQ05Kg4ma/CuQotYY6yxg+YrIzxj9C6DK6eMPcIFT
	1PcxgZbnUD6DNdY3+ibM7S5zykyDnWaQC6p+tNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9r1c5wZhzXCDaKf+9WT+ek3IPcaKfZ38NF1MRZ2H5sQ=:T9sQPf9abcvraHywbrKGqK/vLsQhBVI14s6wVa9dZDw=;
X-ME-Sender: <xms:k1fbanb7yv90t24zR8xawBKU76KWkG85202MX5bmo3j5BwCRvhLLOQ>
    <xme:k1fbasa0tESMz3ZihI2-VA5XNOeqFAIM4CN2fW3JBt3DNUjwpiTZecU-khNQBZGt5
    4oGoNSvXbtRU7Rx2xm0penDzKPLy294cche2vqbED2FSeY2pH3KvXAy>
X-ME-Received: <xmr:k1fbannSKyq_ff5GAJxeFt-IMtTzplDGlnUanQonPq3UAcgyvB2y4O2_dM9re3xIUhAdYA>
X-ME-Proxy-Cause: dmFkZTEsP9rvaXc5w03Q155sMS/D9z92m5ujAkaN8fdTfhwcWbS2VdD7BG/f8OPc7VrDbE
    p1WSOh2TWLugQvPv/IkonZKSkl4RAoEIWiOVb3g7W7rII9IwjDtNLOpCmVSTz47JZC8mif
    peOk9pX6Eg6d3f5CHBr8nxtOgboRLAxMkM1rFdTISk6EFK3G13LbChqI32gbleTXhH5xfD
    eMKV0fl34BRUMv2fI4BuDWzq1octdv8yEX5gsRiCxZWOS3Iz3+Tzhv++k7zUIhD2WI8MvV
    L7+NyP0tNaip4ntFxK92zjuyrZuNYtHkcUmHd7cPDjj6tVlmgVN/6ylKwskqaDCoJsJtJB
    TxU5+P4BnmeCx68aI5fcrqb1JWpIhBDOUPnSdzJPgZAuyAnaMSzjmGHqikEG4xc0cIRY9w
    XZrDO1752EaG/XMRUkK4cectVDaTeIxa870vWH96vgqM7rfYjaxM1G1IDeYAIZMQdY6jY8
    AOoe++OOHW6TP3perrnO9UFCRO54eaEiyDYgxwxNvl33QnaKusXcvSQDARGpZ8Nz7p/cJP
    azv8uVJ9zZs8+EYQ4bfp2fJK9NcZvfBbAQrZdAi3ZzbmgxAOeoq4Aa0QyBuwZA0929yPrs
    61byrBW7FKTOhieCReHo1PRaht/aqx5ayW9wefH6N2GDgyAFeyUAh1M1xXKg
X-ME-Proxy: <xmx:k1fbaoycJ3Houyt9OKIrXy1kITjKrnaCEHjF8_5N6hxOPzMaO7iRdw>
    <xmx:k1fbalPtWWfzUP4SMoANa8svtOaxPxqSPCMPm1oNOYIdeJAuVOdtpQ>
    <xmx:k1fbasSJnix0SUkTXuqbRkAOFmMoR7TbUvTqvQWR-Dm135uTEC5KVw>
    <xmx:k1fbajZzi0ONQ7qUSUWwZSxzXlk9w2xY5In2CPAVji7NMgZcfAb0nw>
    <xmx:k1fbatI9suTJjQSZeHJSHr2roAaXZUxLJA2w1Gkpic3v8HAdLuSmZ1mH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f666ae8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:04 +0200
Subject: [PATCH v2 5/6] odb/source-files: avoid stat'ing already-known
 alternates
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
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

When adding alternates we first check whether the alternate exists
before checking whether we already know about it. This results in a
useless stat(3p) syscall in the case where we already track the
alternate.

Reorder the logic so that we first check whether we know the alternate
already before checking whether its directory exists to avoid the
syscall. Using the same benchmark as in the preceding commit:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    289.5 ms  ±     3.4 ms     285.0 ms  …   300.7 ms
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    185.3 ms  ±     3.5 ms     181.2 ms  …   200.8 ms           -36.0%  (1.6x faster)
    Memory         5.7 MiB ±     0.0 MiB      5.5 MiB …     5.7 MiB           +0.2%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    269.2 ms  ±     4.5 ms     264.9 ms  …   290.0 ms            -7.0%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.9%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    260.7 ms  ±     3.4 ms     256.8 ms  …   271.1 ms           -10.0%
    Memory         5.9 MiB ±     0.1 MiB      5.8 MiB …     6.1 MiB           +4.7%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 22e96828d2..f7eb4a9df7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -185,14 +185,6 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	struct strbuf buf = STRBUF_INIT;
 	bool usable = false;
 
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path);
-		goto out;
-	}
-
 	/*
 	 * Prevent the common mistake of listing the same thing twice, or
 	 * object directory itself.
@@ -224,6 +216,14 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	if (strset_contains(&files->dir_paths, buf.buf))
 		goto out;
 
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      path);
+		goto out;
+	}
+
 	usable = true;
 
 out:

-- 
2.56.0.307.g5fe7bd680c.dirty

