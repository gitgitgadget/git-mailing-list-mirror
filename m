Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088848;
	b=km1KD5OQ337geQZdPDuRWuqdRXt+iG1mcyyYLOcVPaXS2ofwEk96Z8v3sNnVedBISGS1
	 XUi9fyRgMNadU3V1Lz6MSJgNer6lFk/sVSFM9eZEeru4Hrehpahb1kuzYwyEAlkYmCQs9
	 3EkbV0Jh+WdjCQ7LobNDeqqKIRuHEIguqHAQeWJrlCeF0yk0IrYt8tvP6QYOP38XYiu++
	 sBqwTQezxgHHMIebhkISchV8U+P2CFxjs0vKej69kspiMi4/TOqO4/G2WACyRpFwySzKA
	 zzVZZJzYxftWFZpih6DDEjI5Dxc9wK4Q/q1Z0o17sa/yV7yR4Zl3lVL+kcrdzOLglgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088848;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=5CxxlaYBzXBOTEs21DibkFQUOWpgmHDGWuWI2MlZJdc=;
	b=pAFB1eysT+XZTwTzx1oP3q8VSgE8eqDu8g4xLLTs6hvaLzxkG8pzqSz4YEAOvsHPkZA3
	 UxGz7vMsCpi6x+owp6FyV7XhhQ3Zsmy1V/QDUJ85TTaBZilAvxNaIXx2yid63RIhC4UEe
	 keu0vkUXMjnhnPVtqr/uir2s0yon65HVfztOtIZavCWtABPAG2A5JpjTmaUrx9cWf8HI2
	 HbX3wCKxG8OkUoznc/CjuerJVgdWh3Vzx+MqBL/BsXiZRcIFr3UCI18WL67oNODpaAtki
	 DhEXDE1Wr9iZRmnw0DMDHNCaxEmwkWyEwKBfnF3jf/5HagQgMJVYCTGWqGC5SqP4Zng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=tE5izVgz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ae2RRe7c;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210C606A33A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4210C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=tE5izVgz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ae2RRe7c
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F2F41400066
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Nov 2026 06:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088847;
	 x=1795175247; bh=5CxxlaYBzXBOTEs21DibkFQUOWpgmHDGWuWI2MlZJdc=; b=
	tE5izVgz0GzNEIxQZrkwBnEZ57dKnDO+6kdHAT1hqcui2YwuWcKIVwK5hrRtpb1N
	IlMCh8I6JieiQsasbe4YSoGXj36CIA95UkFRB8ukNDIYNtx8yvCkKw6Gjw2tFvw1
	z1FnD+q63nU1R17VjuDqsKACC3kFGN/6sqDpV0unKlYZpvhPl/UD/ZLUFmLteTxc
	GTRTNmirtHWU0dhJXqs+wnf1EnaoEW8DJA+KJY+Sv3Ebvg9mr2CdWUaWkuRxzNOT
	m+Gg3C1IG3JYmldf6pnLiAl2YwdjOiHOHzPs3Te6NxLyZrpQR6BaAtBYVTVhi42f
	ssDSc6aR1VoIkWk0MdVi6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088847; x=
	1795175247; bh=5CxxlaYBzXBOTEs21DibkFQUOWpgmHDGWuWI2MlZJdc=; b=a
	e2RRe7cn4cFVN9s9ZwnFcuqcCnZU9xjrgdmlgEtzyQAyYhYOCc/Kfcu+VESgHS3H
	G0R6YhNtobCvH5AoTrQQ0FGtKFdXd99dS/48VjIaVexwQhfwxXFirBC5QlZMMvDp
	yknG3ZLEVsNoXAciMeiONTBxtzz+bGqjF7cZg4SbF/pPFcsxio8vUH+Spdlr9Qwq
	A/xO2Qhd1a1nYhPQBohAiEoCiQ5dtQxwICIRuSHVFX7CBOEe7xI1tHMCtgA1JHnk
	ZbULaVYwk8z51SO/DqFcm9y4ArixVe57CrDCrHAJhsZafY2UPvC0hPC/vjjip7fY
	UTBw6VVqXE1m0CVpm9qNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088847; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:pogZC2r5TEzCkVcj+ZKI2A0c8qm4xl0tpA9FNjhv+50Cxd2
	SwHBOxDaTXAF4rFZFibGifpIEWI+GgqrI7vF0otqNzyjV35LlvLdcNeEBj6jwzLV
	0c1zLCzwVnTlE8RHshehfdeHy4tP95Fgu7zcbKOGzgM79do4AwMQJ3RfgYYgiuIC
	uUIiDivP7B847YbM+r38SOLk1DxTTL7seOZ5XsLAyK6IiiSrETRrUK9uKMIyPkal
	meATg4TG8NM0GGdo46Yz+wwW9O8VJDeOyIfuGaq3TsXEwMOSfeTU/emLNKryDj/K
	2Xhmls9qnGbLj/4FeJLc5OXnvLhwP0hoxE1xXLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2+TADKJ0sJc8fg86WzItJuHL4fVhwFjDm2Nmy3vC+5A=:AtRSipa3SpQsyLVa+UWwvgPlvBdcrPWc6jGv3z3mcRY=;
X-ME-Sender: <xms:z-H-alX2RaU9_QuYpFS9yz0muBleRMUawSAW0h53JEMTZfB1Vh0oxA>
    <xme:z-H-askApWk-p7KvC-CQFHtFzEvMabalp9tM7XwRIMJ-spGVNKUf8n3NG2ArMIuGn
    u9UKOJmqk3cOQl6O1Rkrh6cWBWV52eTrQbbfKNmsvnHLt9R-Vt3ij0>
X-ME-Received: <xmr:z-H-amb5K69KCD49cRrtpbvUQ31LXA523m3A_pN-4mhVtdCKIahFo_8yG4LKueKGU0UndFA>
X-ME-Proxy-Cause: dmFkZTEPAOKFkNIN9JrLINfOL+vzl7aeHye+PEVaH8rmB50p5bwOyu4ptgvgpfRf1s/mG1
    Abgi6RPwooNXOg6dyVxgN0zZcvC1VWVkE+aY/0i6joQxdzJjZDhdQSuCvysvZdpkXnnYqY
    Q0v/AD1qiF09BgTEto8tIvzNp7QU5tMj8iwxbJK49hmfH2W0E1hFMaZwSPRTUCqZlRDJxs
    sO+KQS9nX/mVNnn6FQ9wa+nDOyBcRXnQWQGT662oeWSLiZNnrnammbTqyk2u0wXz7s/7JZ
    yClyD9FJZGu9NreLP2AgsbsqGaczH6IseQc00Nf9KKeoFxk9A0u7GbZfSSSKGvUsJaklnB
    PVqt2qZkOG6h9FHAmEclqqLxXGWYmvnRhkevvJcByPFIhYX2i3WrRxlvM/8XA1e9fDVcY9
    SGmsft96LOg6s9vJnpsQiFfOySDkpfwc22sBfg/wB4SnRosYB6SGmtEHFo0NSouY22eg+1
    SwKwhdxq99Muky6MNIy7KfkKjUFltfAtGVuz1i7nfURdhx6WFPWnPoa/zcGL0qVB28i4vM
    tyr+YoYfMkDTkFBL6VvqkN43wvs71jroi3MO0ZjMZ9mX61zm5nbZnSoK4YgDYTzl7G1gzB
    HATFCVZNpbBEbHXamDi+/jJf7f6j7/fnLMPH5nkft1LRrwba5zdg6h398jXg
X-ME-Proxy: <xmx:z-H-anPi8k4jr25p_ASphietfSXMK_X0uYCuELBHa0OR12XN245uag>
    <xmx:z-H-arbyIv7i9VTx3PfRS95gE-32gkNGtOjY6Saa8J3ivMXH_7bTEA>
    <xmx:z-H-al0pT30WIAjhI0mtAFIiJFEWKCEMkw6gaJVC-FDOrTUeb5aeXw>
    <xmx:z-H-ahc-hcnWYyrgL92J0gfY6fUflHqWft7dWrRknABGenvsfu1bxA>
    <xmx:z-H-ah6b2FWJdDi4jshOCV3FQJCYCgOCxG3aUcekdyjiraKGfUh3cn0g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f497eb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:05 +0100
Subject: [PATCH v5 04/13] builtin/rerere: stop passing flags to subcommands
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
Message-Id: <20261119-pks-rerere-subcommands-v5-4-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
index 83fb3783c61..405276cc94b 100644
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
2.56.1.831.g720f3f5937.dirty

