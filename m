Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088844;
	b=Pn6VJcn8H0i3DJZlO9JMHdoD9VHDgNOw6Lh5LBxd2A0TPAd+FUCyyTck2/1a4DBEmCve
	 6iY6iEYSv3WEKiK9MsLIuVCBF/IV6ahMvQw/9oMJed30aU/sqy/L85YTKn4m6iC8W/tPX
	 7gZ+zf2hSee69KT/faGf7Fazlh9Yzmo0mz39v1xs+DrMfL2M12l6PRBzevNLf16DTccdQ
	 +hGuAzVNLFRYx8iuEJ0/YOyjtmS9o8LgJaHRLWs+0olylMtr8F9l2KgE0wsxeRq6dlo92
	 LGrskO7IehonKgLLlDrPEmxztFgyY019aB7VE8AWgRX3KakquYwXJPKgG6HAqeGkLYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088844;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Jm676oiynuLUq+Br4QzhgSYxgg3Mcb8D/iB7fejk8jM=;
	b=YGo6GFLrqwPv3yVvhYLEaHLFp/+zlBcpz+wGeKybJZREGdUjHv4ft2nH2l2GIFc2iycX
	 /je3aoQMZe5c/ittJl9oJLL9vrA6HIVYR6f6VV0BCUCaQOmXFjGCKFeEJNsGjt69QJMcS
	 CaLDxCw5pObXv+jIdSkdb7eM8EJ8GqTm+PwTZRAiunCsCH0vWGgwfzXdz3Ng74S4b4urp
	 UqR9p7oENxqxYKHt4yUxe33XUyGsgZvUJ+l4kKNEkNdy5okaMKvGLAqaWH/Y2oE68IWEC
	 ZRiMMtMkEgQTzvzXDCc0JaLTO4uy9vtw5FoRVzO/wTIZtm9mPb7/kgfSJEkh0jkU8Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="G/Kbhv4a";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="lr4116D/";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2960A2627
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A2960A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=G/Kbhv4a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lr4116D/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F07014001CB
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088843;
	 x=1795175243; bh=Jm676oiynuLUq+Br4QzhgSYxgg3Mcb8D/iB7fejk8jM=; b=
	G/Kbhv4aAkXeK8mzRWsHAK4kVJ52DIk25WCvbHeFxwSh8DyVYBzLBftZ0QoVz8Nt
	af/r3dYjUgDxFGPdcxP7OmI2D5GlTK9nkjGcBIRKX+wZrJwuwPNkmXdbJIsMADBg
	/qyvY/7GW3WyFQpD3S2k+Gxxo6huPNqrMiVm6AxgL2I+59JvdwIeFtC5Je/sxlrf
	C+MxVpgFjSa0tXi5LfxHERHe2dcvEP9g6qr2KtTS4kLc7ixIBQRfFRYFGlaWpbZ1
	EgvgBRg+zUulVRMnDbEGQVW2YTD1IyyMCIjKW97dTllJKeS/pyZaSer6UPwvdP+5
	LLRHW5108M4r7LvtjA2oeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088843; x=
	1795175243; bh=Jm676oiynuLUq+Br4QzhgSYxgg3Mcb8D/iB7fejk8jM=; b=l
	r4116D/0+WClw8f5+7akRsFmlR8E79E3iCTgz6EviEvvGlng/AvTEX77vXFmif2T
	3gzfkal8cm+MXsBO6WY0wFFf+9UMtaiT9eAiu8P+kZNyc1kDZllgAbJhQFlZ2N3K
	gaxok+rrloeb3Sao1eC/mZ5RHIovZE7v1X+euZHIDS/TQ5s4JvxgcmGdj1EHIi8A
	cGLPeJv0xu3g6T9xac7M7h/E2MEpTj4cOQro3DX1vpMkGYG9sjB6HC6OvViTuj07
	DNr8rtVI9vgHqQqf0OYbZD1AxO18PgZjalzw+FmRPMRdVojParBhLH3khThZs6ig
	uxdssyYziD4DmQh4h0NXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088843; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:n6HGWCg6hJAZlAtvaDwbtoWpmGiiD440PQaN537NGupQ41B
	LdorMbctKProobdNnt0WwWYZdcd0/CBTsyHwFmXTC2p403Wwh6G6tI7p/FsnBDg3
	u78Mw9hk5mJG4uFOMPNd4OZdYRWRsguwoQACi9qmcAlyg/MQDVFvTriZdX7gcU0V
	Ft9+xaxar/3tVs1HAa0pUmzdnPb3UNGpSBu0tS74FrAkPrqTOcLzMqV+wRNRduWs
	oHAyx43Qtb3amw0zLVZNYB+WcEvATcqpAoj1AEMoySpwtWEakvibvHyn8Bn/CPSp
	zEZzKk//qINdH1fcaoPE/iEO1OXYENlDJhplZMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DVEWeUhFinpc7E3C70fp54CPIGylEUPlsHCAEvQZ4SU=:nZYr+lRMXLqns01T7CrYLT1DpxJhfeRm4Jhkq4RyJxc=;
X-ME-Sender: <xms:y-H-amBpOrcGUrzDO-CDzHdyN9DR3_U2J5Akdq4GiCCUBWnRnbR7fA>
    <xme:y-H-anjeOUbrMVtV9OHJNCJJgJ9u16uHFGMgmGKGFtKk-E-RsK4377X4cN3jx2f_T
    3LFiCTuqNO-PFuZ3q8IP9-V0lOT-CAzVmjpCqE2h0JtSw4lj8lolmo>
X-ME-Received: <xmr:y-H-aumWDXkbSVp7-O8lIjVX9-bcGcGpVNtDrRcigPPN0IEkr2hqvoV943XlGYg5EC56hQw>
X-ME-Proxy-Cause: dmFkZTEXZEOjEM71ry1bXEPUyrZqX+lj5LhX/Ly29UsKVTRe21Y2eyCJWlEh2udTa5KEnz
    eoYFQvG6xuLPKNhARxbzj1z6+z2YrzJTj986YPy3tkngcgZgyh68VJu3U+YO+6PVTUMcr5
    QrGQnWpmNB7xda1uSgfFh/KJf5SXDY6GlebuSQ92BiRMVpqzNBycNApFQ/CVd94QPxkbTY
    oT7JtdpLBwothcIX9cCJMncyBzKol0AVwv35ZuDgRg8O7e+Z46ZE2TEt5Unuz+pSoLCA80
    zjaGnGvt9lT1UHSuOmdpS63tiMV7a+SeTYrp7EU4JoyaBnbYKfZ1JZKJ30mydOX4feVhHx
    UP12EdYopRXsEu3/ynmfYhsUuZ7OV6lrJ9YJDnLyIwfStlZtEF3VGeFzxiDcBHq6DN2QRK
    L4AhtgccteJfobH9c0mAwtY/CCvBgXHbwBhye+NGJY1nXIpfjUZz2C5ZQm9LWEymAOOFHk
    KZETfAEkq+m3jhcjY1FPdBBlNJDDyNeBYISiZbkVlvATaR1vpMdr/hjTYCXu0yZX5HQYdT
    FkD6sHuDpAlyX2Tc1/bv05A21xAvH1Wcpv/DWcDwK1ZDmXSSEii25YMZ0u+GbTPjeNeI5A
    kGGOS0LUFcK/XUos8XmL3quZks2un0ftI8eQBiDPTVC1QH1jsk2c0duMM+cw
X-ME-Proxy: <xmx:y-H-ajqlSsY5oo4Ytt3zsx7fnFAzogYXDy_a-8aM_e7OVQTdenfT9w>
    <xmx:y-H-anGr88jYRymb0EPIs34EgnyYrI1Y5Ss7SyZDVAJWMzBzXfoNOQ>
    <xmx:y-H-avzSidRnb1BEyop6jdMYKuXnBcJBaFwkf0QPjBcsjeBlK5Tfxw>
    <xmx:y-H-aspQeOLhLOawkf9narxw-U0t-LW15t0HfOTAWc8TbF5Yk_7spA>
    <xmx:y-H-aoTf7ORkJeEB6XAdIOW1L8U2QA7kYqIlH8GXIvfz8anMO2ZNIQ5c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e972efb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:04 +0100
Subject: [PATCH v5 03/13] builtin/rerere: drop `the_repository`
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
Message-Id: <20261119-pks-rerere-subcommands-v5-3-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
index a499e7b9151..83fb3783c61 100644
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
-		return rerere(the_repository, flags);
+		return rerere(repo, flags);
 
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
2.56.1.831.g720f3f5937.dirty

