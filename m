Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399539;
	b=t5ruLTU4Cmh9Vk/HZIWwxBgiWAO0RbB5FQwbneYovCs/xsnqVFe0NYtjt6kQZkR8qMt4
	 I6kSQ3E+yEFPcCB1YSEy/0FGp9Z5EoqYiDB5vVhFEc3GiWeNbOdYrCYJr8ueJFuln63LC
	 2NgaKPz3vVcLR5u+aPs4bfrsMvpGRCg4tCLvBph6kbHRbp+fCHZ/YiDCGOqcCQD0SP2TA
	 kldfmaBQeCw6GAht/hvAY/gA/obhbwZvGqd7x4QHbwMwjFNRTA8+RfyIawQfUJoQVYUSt
	 OMz+GyVl7SpOB956GVOe9WVWu4/dG2pP3eJyNgZMnw1uOGblslZHGBPqD6nZM94DJzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399539;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=OJIQo4Hzxe1JTVwAH6/iTg/L4/15XkCsDZmMBH40sQI=;
	b=5e+bpX7rfKQXYHsfmP6nPUiG/+Zw8xHn0AzlchmAhelV95UMGVtSXGvOSDqPuaSc+fJc
	 vbOGNhTP5rN2COX3aQqK3ojbZgfzuumyN344hIanLdz7zkZZVlWHtSn1G5l3MZTyQC7mI
	 VXB309vXccR0IVV6lkEDjTaqxpRI3CcB8Ju9VyBrBst2qoIhOQxilQ1fndsk+25cZFi+1
	 SfNYjXiTGkenoKQkOzaKPb1f2yCdlThjHjlvz7NaHk61ABLqhZPsfR2PNvDPYKLwpkxac
	 gczdAnUkyEaiU6z/eakNGzdlHNSC6cPyTaxiaIJnkQtFggpwKygoD4r1Ks+Navt6k8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=COubE7HC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xIR01x1k;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4EF606A332
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C4EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=COubE7HC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xIR01x1k
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B363D1D0015F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:18:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 07:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399538;
	 x=1794485938; bh=OJIQo4Hzxe1JTVwAH6/iTg/L4/15XkCsDZmMBH40sQI=; b=
	COubE7HCCde67/NRmwnrNhAafWbFS7m/drFhYAggxePJUoViLmeTbE4IdmA459Xl
	CxGPWoEStGbOQeetuQ0i+yzSOzJ/RrS00ArOEymCzbO24gbZlFWioKvoatjaIpcy
	ke767PItL4e0bu/4Ci9sYjn/6ouheiKtmB4nNy57kbDbQZBnH+ZoJrfPzx9Souhp
	TMq/IF4f3iJ2Lkv7rUTkQEkZAB3m3cWyo7hE89QANMgI2jNfBLaz9lOkEQOuBXZ/
	YV8JLiQPmcWzMwrGrBez8hOfP4fAA8DHc7m62NI/2LPR7XV871lN+ai2Kon/HB3q
	ItguWwxv0B+quNXDqm29bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399538; x=
	1794485938; bh=OJIQo4Hzxe1JTVwAH6/iTg/L4/15XkCsDZmMBH40sQI=; b=x
	IR01x1k/YZvoomJYZCkKrAuyElowZF/vYzJDCg/1Vp2RiYVY3+ZRFbUEE8GUAO2X
	Xqvmq2JmXiEWYEMqolF1s9UINj7IhKd/34YrTlwi1z8ri9NSuZOF2u86w5rK/FsY
	h1FatMEDhBbVYb2LTS6VKYtYVvywSmfs8mlfV1KzxabIXv4Jv2Us3DZuzv0MbSW4
	pML+1bBIRXxoYnpZfGzoDWfEZFRO8HuQNUvCHtaocJars5R0/x5G4zNV+LRDpH11
	UmMIyEOG9llBuUaPFf100G9AOyfJ5yybL5mngRsgckFaeu6mssEPJlY/BPZMXLOZ
	xv9JVg5AfWQ6cNs4UPwjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399538; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ydJ4Av586NV41QII0Vjq8flNBMuS2kxhhVvpLdsAMovmJ/m
	X9npVCqJLtotx9MgP2+QnZxU5wkFKdsJmWXR3VB6NXUxJLVOrUcJ5J6JMUmsaFN5
	rXxFmEsE3f345S69z3lJ48Lj/gWBV2PvmKwNHdqB/ZpomXLFlkZsUcWZmcLAW4ZF
	1WoGxddIdWQHixecZN2h37Vpb+S3Z45ZA0yOEhmYPzVhbo3nycyt+Gj99hat/jdy
	ujATig4PCc+bhHRINuTUFZKSSEP6X2MGfjEK7l6lD9Xi7FJQcwflV6Xr85+7g1Gf
	YDrcf3JX5xF4s7TRzfhaHh4xUPd4SmOu1whmEJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jM4MdlcVg1HqE5HO3NlHEbbjoCWPMeAVyTat4S5wSKc=:/Yi4RFCZwiGnKNxuLx6r3GPk9Bdg5P+MCDaox3cVZ3c=;
X-ME-Sender: <xms:Ml30amkldc0FMsDUtkQRGkqmxuu058KOrxMe-S1Kxa8KEww6kB7KSg>
    <xme:Ml30ak0EeKiIhjTHPnP_BLPoziFQpXFu3tSAjGqPN5h8k52CmsslEQmBzhJCxMtyV
    nhNOL3HrAfUaHezl0CQvlNIBwIpFmR4hZK7uVRkKfWIew5wsNYzeoY>
X-ME-Received: <xmr:Ml30apoQ3bm6bjYdw5Jfr5vtbWpOS99HmjWBtmlHwzt_HxGViOpJrPx1uIwcG51t8W-h3w>
X-ME-Proxy-Cause: dmFkZTFDM2UfMmXJZR1iHcNsSwiMuOCbMl5T818vkXV/qNRQFpT6PgDNN8oRUZX1XoIjn9
    7Xg/XfWwtaYe4Ka9dUY7guzpRuB2SfZ/12BRs2qbqYdBuSIunG3pmbzkFcYDqZchCA+oB4
    MDf+NFgTUOijFI5iwMbLndfo2X1CFCd1p3PJx6jUwOtgKvNVwHykRaWWnozBx8shDL0hNm
    xae6qKlIJqDeAMK4vx85nweNDVFlJi4aWx/7fwoodyEswyM5figra6ZOK/+Fc5zONeDQdr
    FjaAbo2MRfLuDwPH1DErm6nU5HhqV3tB/+00MAfBNFIW5nbAiKPlcFEPdHSFhik9usH3Co
    svPPztLEe3zSfwJTmeZioV09KMGmNTPq6vduDiGwjZlymPvH94E17Rs70ltR+7ZH0zco6z
    tuBJaDx9y3+8IeWOYW+bZf9T52qoFNSYi4Q/DmPY/nNeNjCZ/BN81VgzKfnxTK5jximYj1
    ty7e71WjoOtY45iprDupHGUmvEe8VxoHVtJaMq6wGpZH9NEYoyZqhuk3RF1gqNLzlq/Gep
    k8G9mK9C+OHOVx70UhUax1qgkowEyeSqjuUo4Hkptmrt4/XbHje745znNzjr3O/mUmlomp
    /Dml+knIE4bQbqLfNOfkZXkFXKCCkqTZFUJjkDs5QpDqG+7LeOnDh+kIYXsg
X-ME-Proxy: <xmx:Ml30apd7InOkcgdP-9AqOGMq0sLkHNg35_1-rtS4b_tSIdUQ3qa8Vw>
    <xmx:Ml30agp_LY8c5huFKzuSZnIBg4WqpdtQIa-mOWeAQTW6iRYQdH_GWQ>
    <xmx:Ml30aiFhUO59b06WqybQSzaDEpNCN1Co6kRiUFcEm5S9Xljs8-jFVA>
    <xmx:Ml30aosU1F_JqbOl2f-PFNKlZMAc0jfNWx2AcbNsj6Fp8nKpVf1wqQ>
    <xmx:Ml30alI7Z8BT6wRno2pINXwWtYYepRSKWebsm8MdQkxrbqBMq7BocxsQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:18:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36f0e9d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:18:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:39 +0100
Subject: [PATCH v4 03/12] builtin/rerere: drop `the_repository`
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
Message-Id: <20261111-pks-rerere-subcommands-v4-3-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
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
2.56.0.611.g1030f0b940.dirty

