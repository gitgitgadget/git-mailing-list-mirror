Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098031;
	b=pfGooFdZCJhjSUqct7dpqmhp8rEbvK6XSRF36afEdufQgEIc2D0+juGfNBhWsW324UuH
	 rtLTRD8hSB/y9CK8TZEZx5SefGcN+gLy5JtgZ3ClppZBasoWkg4XTDXYLX7vqsZuR/8+s
	 5/512SLKZVWWYA0dqplcQaCQZkdVZo2hegLEBkKhy3AQrY6E2xxvEMNdT/+Z4V0eXW0/7
	 hxloXLRUnUOhcuXcjyf0/GQ31zZnZEf4r5co4ilf8Jicr2HBHRhUF/SEyXE8dKcJ3DZg1
	 Gl55VuXpvjt0IpWkDkRBYz04e1Ybf8LyXWnixVtZyT5QafPwXnN5VVffdo93Zh8qPRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098031;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sbbxhgESOF+f+c/hPWPFWzJxRE0xTEKzor8Mqxnv9uk=;
	b=Gs68TTMf4mNx1L27DiNI4VTon2mFMdg4sQHUV0wmf5qgGGmC6ix0uNtLu3wZtyAU9Xhg
	 MZ7TIEzfbnXor4XB42YVJA2cv1+KwWrhMy68FMnTMU7zxnTH1rnW0kvxhm88xdiBaVMV3
	 g39Tl3RG6gK3JmCD5/OP7EOwU6uLHUHpPN4ex9wJScjupKcibk70dUO8ElBAQMvdmZ4o7
	 vyyMjbWrXp2CKE+AfX9Mnn46sw2byjG8giSksT6nrTvMzsBdD2sflevFoEPYH+PailHQZ
	 uDCNOTHJ1hj2xZ3XYxbMgLEs8B1oe1IrZ/RHLRRA2SeYx/dTnIik6Dw6EJZwc4Rxk+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZtQycPvd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vhkgstWX;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF8606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11EF8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZtQycPvd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vhkgstWX
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CAAA1D00143
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098030;
	 x=1793184430; bh=sbbxhgESOF+f+c/hPWPFWzJxRE0xTEKzor8Mqxnv9uk=; b=
	ZtQycPvdv1TAkK/ojgnvEBfX06RmGtjEoSCT5ARLCvSbYk24XGH/RPWffA4fCUc5
	4p9/Wg1v3gYZMyk790EnYxX9J5tSUMAe7Iz84eCV+/IigFgQsWY2z+IbL7VEr6hB
	TTmzzUimqcR7VDPaTXS4zNvh8AiWnSwbcMecdi2Gym6gpXc8NKqtH0mcprinaACP
	mbO2DqGRlVEVUT7Bx8LGtnvPhuv1sJCHaih2xFx5l4gb/OmrfkLA1BHQp+hnhvGC
	FFslmPUpzB+uxs07PaHBQWmRpV2lIILcv77/fzRgTayKkIHo3BcaLcvo/JkMtfWW
	FqBV5McA/NzZ/ns1gbp8gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098030; x=
	1793184430; bh=sbbxhgESOF+f+c/hPWPFWzJxRE0xTEKzor8Mqxnv9uk=; b=v
	hkgstWX7FuBQ732b/bCMENOGUKWYyad4ITtcVBDkTLcSvqz7grMCvUB3+Nar00eJ
	1gjxLjVXIVuOtfKTqpgH4LASnpZTSsAWPOrJswBPYJcWN7K/BKkDNBEoRgv4iYht
	JXu8CmjFNNnkEBwwVU8v3P+eR+i9umsbFsLJQBy/1vB/3rTZmngzd0VWOvx4CyOx
	2x3mNa0MNMiQcvD76utgeGBiTz/VwaO0U6Jg4KO4h2Zd9m63FvTef7McW4Gn+ZST
	05RwCdUkBBqpIMTxakGHDG99KMr37am8ZHcQTIlUX5vOccpqKP+K846N90qI8c8Q
	gfbY0DbQ7zaHeN9Jr80hw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098030; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:srkYM6aAbwtszBrqmegKJJZap9Q7A/ytUHq4Dz3o8D4u3Cb
	NJqKaGwB7pZdWCqvGhUBCcvJBglECGQ5G2K/p7f6LUXkR1MPoGpBNUZPzKXqZBJD
	s2OHDDSeo+b4XW+8UW+i/AgyUNz5Cl3LEnXUDVc3BwBDjYyFHtVKfU0wS3D1iqCq
	9BM/q2OxN2t6YRa0ZXf299hbGSDfNFK1SYqObyro0dSu++xj46VQ3Ixgua7a6p12
	ZW1rCCdKXhEItL14ujqKynqekNje9NAbUYS4gyKcnK6UYYje0JWD5eX0B+9YkV8b
	bYCI/3mHISOShK9vyQ2NuL+4lWx+OdHpGwlUDpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:geOXiiGM9Lc2BcKLzSoLnfWtsY7+NjTvy3dSMhfrhok=:DxgsrcH91JZQ1fveihnhoFqvVe04m8KLquJuuJ8kwsM=;
X-ME-Sender: <xms:LoHgaq81zCPn7qUSaSMzYkKxui-9Qo9rSL37hy3mbSjh3umaUOaRRg>
    <xme:LoHgahoqIpxrPiF8thcfxSDEffzAP6Eji6Df7NNgkLUrlsE9oWOzLOz44ldUyUnFy
    J4g1CNxkBlNW0s0Yer4JTTV1kzlsnlTeJ7hYB21xfty_JfWASw5jQ>
X-ME-Received: <xmr:LoHgalq0eQTwlL4_ok_mH-eMNPhY2M5P974-jn2Rtz_JeleHSyry4Q>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYgD
    2/XJ6Wn1GtefvdYHdrrr0cilnPXP00Tc/fZyIrlINHs+xeiDspBHVfAyRTaxmF1N3ZpPTb
    8cb7mKgR7EQ/rUrrfkkBnQ9H1hvIQ/jLAzxgby/mIU/r0Cx6Dp77jAleqtlmXK0T/KDW81
    3OaPF1aWD/9PdK2xr9SYXdqvhMZvAYhG9AUh+Tnk0YTdSbUjuqGoo8iANmxhethoL+T5bF
    4cOJR1sBWx0LGjWkGn5q3t2BmyH/CllGJsK3AoA8t96WwoyLCxEP3ck7sL2vGi2BnylkDM
    6W2UXRlyNnsyFimqoE+QLdggxiRwO54clSpa43DiNWyG6ZGVq2rEXnNHYoew
X-ME-Proxy: <xmx:LoHganknSPfEOPDroIZEXfR6fbomOLCHITBtgJ-8WblOCuWqTN4H9A>
    <xmx:LoHgavF54A9DzKIoy3NNrqo5KaHVbKBOlXr4OfouRaM2VAz3MpZDQQ>
    <xmx:LoHgaope-ZkQVdz1UoBhNV1snjwaMS2jc1NppibKthKTtux3JB5MXg>
    <xmx:LoHgaj5GVHxXAoxNT8DQivNgHEperYwE4tazzzYe6d8feDr3x-o66Q>
    <xmx:LoHgaitHaf6ocg6Uv5HkF9TWtwtHy-e0h6ajpT8TNJ4xe148iHdzIM_x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f69c8007 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:46 +0100
Subject: [PATCH 03/12] builtin/rerere: drop `the_repository`
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
Message-Id: <20261027-pks-rerere-subcommands-v1-3-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

There are a couple of references to `the_repository` in git-rerere(1).
As that command cannot run outside of a repository these references can
be trivially replaced by the repository that's passed in as parameter to
`cmd_rerere()`. We don't have to worry about the repository being `NULL`
when called with "-h", either, as there are no references to the repo
before we call `parse_options()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 1717fb7a65d..556f267f37d 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -57,7 +55,7 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int autoupdate = -1, skip_locked = 0, flags = 0;
@@ -75,7 +73,7 @@ int cmd_rerere(int argc,
 	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
 		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
 
-	repo_config(the_repository, git_xmerge_config, NULL);
+	repo_config(repo, git_xmerge_config, NULL);
 
 	if (autoupdate == 1)
 		flags = RERERE_AUTOUPDATE;
@@ -83,7 +81,7 @@ int cmd_rerere(int argc,
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return rerere_record(the_repository, flags);
+		return rerere_record(repo, flags);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
@@ -94,21 +92,21 @@ int cmd_rerere(int argc,
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
 
-		ret = rerere_forget(the_repository, &pathspec);
+		ret = rerere_forget(repo, &pathspec);
 
 		clear_pathspec(&pathspec);
 		return ret;
 	}
 
 	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(the_repository, &merge_rr);
+		rerere_clear(repo, &merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(the_repository, &merge_rr,
+		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status")) {
 		struct rerere_cache cache;
 
-		if (rerere_cache_setup(&cache, the_repository, &merge_rr,
+		if (rerere_cache_setup(&cache, repo, &merge_rr,
 				       flags | RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++)
@@ -116,7 +114,7 @@ int cmd_rerere(int argc,
 
 		rerere_cache_release(&cache);
 	} else if (!strcmp(argv[0], "remaining")) {
-		rerere_remaining(the_repository, &merge_rr);
+		rerere_remaining(repo, &merge_rr);
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)
 				printf("%s\n", merge_rr.items[i].string);
@@ -129,16 +127,16 @@ int cmd_rerere(int argc,
 		struct strbuf buf = STRBUF_INIT;
 		struct rerere_cache cache;
 
-		if (rerere_cache_setup(&cache, the_repository, &merge_rr,
+		if (rerere_cache_setup(&cache, repo, &merge_rr,
 				      flags | RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
-			if (diff_two(rerere_path(the_repository, &buf, id, "preimage"),
+			if (diff_two(rerere_path(repo, &buf, id, "preimage"),
 				     path, path, path))
 				die(_("unable to generate diff for '%s'"),
-				    rerere_path(the_repository, &buf, id, NULL));
+				    rerere_path(repo, &buf, id, NULL));
 		}
 
 		rerere_cache_release(&cache);

-- 
2.56.0.341.g393f52fd96.dirty

