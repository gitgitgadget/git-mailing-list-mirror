Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399543;
	b=GKSmYhnomKMcfabvnzWn6+j1g8TNm1S+CkGBdBaKWlU64anpOPxiBBOCmgj6GWE9fht3
	 D6PzDCHSwCIDaSmv1r+UZKcQ+4N7gknIb73iIis02xeYrv2BY8BU9e8eSnIyV1dgBG8tg
	 SlajPgg+nE6ss4vSrNkGk6hvaDkczOTAzqNkq5qxFYlXEQvXV+2lxAbcyCKiA1LbY9m8m
	 5muF0WeoTlsC6+eY1sEAvAtZLWMLn0E4tGlXfLSV2OkurDhKQeQGVpIrVZZKuBXH1r7Fz
	 SFoa2nDGnW2MMa1cJ17bxqUnFWMYwTlzQqVOUZmcsS8WukPDhaaDgS+x8c7G4WyExBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399543;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Xmm2ZN1NUnrw/8Dj+1ClU5YAV+z2rkYd8juo2JoFmCQ=;
	b=fT4ZGHHIBRS1f04seQK844Y/vWcMjy945L3eg5fgCOeBymmzGLCaHptxMfBVM6nzrAzv
	 2OkN38uVU1Hi6KAcs9XTHGaeXbY9L7dJb0/9GtU7INIVIbKLVC+VXsfecVtSlvH6ALm3B
	 r/ksXiTybQsFa88yfjLpEepPLMK4TBqPTJ9x3qELP0ap455MhTju2v3Wir70lT4EKKitY
	 XW5SMdfiIqqfzbQGvG4Yl+5wLG5W+fKV/4nk7PCCG1qfrKm1SNyAYOyZQc4/541GWsgJu
	 bl/fxdPUDtjrggDBNNFiWRFFJqCX/lyy8qgiDx09B6z525o5NeZjSamcWYSYSjS2uUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LlAZuvRs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Yszn+NBo;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC048606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC048606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LlAZuvRs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Yszn+NBo
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F29927A02DA
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 07:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399541;
	 x=1794485941; bh=Xmm2ZN1NUnrw/8Dj+1ClU5YAV+z2rkYd8juo2JoFmCQ=; b=
	LlAZuvRsbltUGLTjaH7jtfM3ZB+sNlUXaR0ZHQYRlZJWa2/ak/HEBKtIFajT98eC
	I0T1PENuGeMhchznmgyWctkKFi4L2Kx3Q/0NN+G4TzK5dFhJn481NXPAwZCYtsPW
	0JmAMSQ3BPfxZAK3oZrThWHE3UdAp41TkUcGbt6l//z1IIV8J4AF5l7hXabHN9hT
	LsXMcqa9hkKR5/LGWsCJLiho2PyjB/K5ggchRfAMKKCaB+YR2WQkwWJ+IZUA6SKz
	eQPIunXOreOsZZOEYgR8SZUGiTkEzy+MaupzBZmlWIlRsiQrYhdc+MpSq3D4Vohz
	s+JQu4bvdVem5w+HqZ9SBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399541; x=
	1794485941; bh=Xmm2ZN1NUnrw/8Dj+1ClU5YAV+z2rkYd8juo2JoFmCQ=; b=Y
	szn+NBoVDmnNd1IpLJbHUQFCTld7OeveCKYrF4L2v/K+beypJzgT1R0Koz9ha6uI
	z5LVJt/x3PajobYqJ9SYPeMjQLwU4vQF00bBeQtVrFMuMCrRRTv8l44fguQJ8N8x
	gGa/4wncj47itUqST7lVbtNQx4MJREqQ9aNe1YsrUJO7vGtyxcTqnul7BkL++1ja
	90f2MWqC33cUdY4mIdcbcOEPee/dlixv7QbvdESRdZomJr4o1a1mQ50e7CWr9bK2
	o6Af6U8aYaSTn7hNb2B7/2LD5trW2vDgcmDV21FgFsSwlAj4EDWEgE5f2tya3wh4
	0xFzaRbt1FDS29yQWziEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399541; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DFHX+cHWievuiybdQ1yc1/Z64QKM3KBL1LcM+y6eV2b/txD
	u/4FVwsTNQT0UgjrHh6tlc1ZVkCSUGswHnZO4Iqlmn/dpo6KEEB4tj02cL6CBGV7
	AHq4CAT32OgaSIoABguTHrXOuQV2zOoIfcGzEatlCnsK4UUFwMPzZBkD6ZbEfZg9
	N3uzT3Cpvd7Uijka4ElbzYhB+8ctpni9uUOO7cV96W2n0XGVAVc5hBfCyk1pPKtD
	1pnP3ptPBa1iH5aIlHtRiaTy2wWf6HDK7IUP0ENHkHAY0EoGmuvDdeb8ggshofD7
	hTQCA4smQR1CpbC6OL5TQCZ7BoVK1RCPw7OSbxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZP+XAxtfQCa5s76I7tqBpw/qDYmpn0G//dMGruDrHMc=:z2XZ5jb+IrSL4blpVgWODomnHVRQyQZvS5UKm4sQuY0=;
X-ME-Sender: <xms:NV30am3VzmOzpsui7XEejbk2D3hT_mMFgZ0FgzyjGrZ-x1F_c6PA6w>
    <xme:NV30agGOe_xvDSMVjzdEAezhuYefzbB9sp4AqADdtSE5bYYjk0ccfz-SegWTG2OmZ
    k740LRXvWn-UykxstJiSyHzDYIP3HCteconubFHIe-khQv4S5HCqMg>
X-ME-Received: <xmr:NV30aj5qBrdfaI1OSLea-KjEPBi0BqftZ66v9Z_mFz4Mri9kwE_LdIvG4YjSiH9_z2r4UQ>
X-ME-Proxy-Cause: dmFkZTFX2c5zW7c3oLnSv0zcB+vdAUp3jsyHjOLJrg2xt/Ai/ZIo1TWOtwcJyo0qppmrMe
    thD7RnWdfdPsqo8u2WsKeMa7MRQYq2uWmgZAI382h9RDsZdYes2Id/eE1PyStFbEp3TrOe
    /ljcMS7fhS52JercJmsTuE3Me/s9aGfbTHkqRTwr8ymeNJbCtPDwfFFo3uBNrSaztlmsjS
    +Dagnpv1PuXT+4pDYznbLpmvTE0sFzbCSE5h2v95QYYoBsiyaOO1jcJxw/V7N2gIfS6TPa
    Zc93YTl6kHR25M13El3ysZfQKiG9LkJ78Myfzb7Znz1fg7m0Ik1v1E4JHHHCG3uMVf2JfK
    XCANbCC2v9toEJxRIxaMwelrO0bXbEdqtvZ1e6AP0gzPndDbSuAYzWtyAI1AO3FD1y2vx3
    QrF0uCRTWJZ/B/XBXl7LSTUjaiEYvCHdybaSC3D6Bpyppl7Gs/07vAmRcscV0/2XypoTmR
    UvDZj9c+9/IEqNwdZWBNqfHCbX4qkMeHTiwTcUewJOcH3jOZW8TWJJiPUl7LDNjBV/gvBd
    HrQ5pJUjImsqObQO9CvQ1GqOj+qNUtvSmW+vs3GmgycPCHHx8N8xijbUlXofed1E8OgUan
    2XzLeQL+F6hTpfxyVi15IW8LwwHGflhljSKuVcjMIQGbt2cOwT/B2/gWHWiQ
X-ME-Proxy: <xmx:NV30amv-dj-K678ff0cVVvJzws3lfVFRMfSk5U0v9F6YsSKaU92SLA>
    <xmx:NV30ak6rI_Bs1s8NxgIT_4YFdSB8RF3CaBT3tR5Ccjgopfccw3bFMg>
    <xmx:NV30ahVSliluRZZuW0FPQee1s2U0BRcqr5pkZzJ_iBUryz2Z4VeCmA>
    <xmx:NV30am_kBiwuCDoQmYsL8zDXNosPSZ1qgJhi1Cz_Fr7zl_pgA_yRiw>
    <xmx:NV30avaJ_yQbiXhNPv2LtKvu_wwlO1IxqcorK1IiNG1VIoJ9P8tQeP0L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd2298b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:40 +0100
Subject: [PATCH v4 04/12] builtin/rerere: stop passing flags to subcommands
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
Message-Id: <20261111-pks-rerere-subcommands-v4-4-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
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
2.56.0.611.g1030f0b940.dirty

