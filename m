Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978060;
	b=x3L5ovvhNf9XVPjDCcEfMGkySNIlN7MbIszODmnKBeM2Uh4h+FvkLIuixW2PcbuCYDhP
	 fXVbjerajTTBVW2SBxE7kW+3NKUlBsbthS8aXI0tF6Q1vmoVqo3pjnE0C8bMsYd+rBXkD
	 uQaBxzDnTcqrWZOn0/rEvoe9wIKg+Sn9RV3ve8hVVsxH+xrBGggvTBDObveCSm+e/s/n3
	 aDbVgXJus0+pvgogpCq28woj9jDiLE4xpYObltyMSVlgTYApORxxcX+8j8b7MTlU1zlAF
	 FtFrtOH3yE3uVxTEnOl2lzthPhO209+Z+PrNsuj1gVRbJyU27hlusB0FUhrOpWLlFLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=h1pSbr5ruGburMKxENjLvPwVvqkUQOYl85I16DBTJE0=;
	b=CFi0XfLwXKFXBSh8P8AR4qtk1O8x/r2AZnipWacUiqbo6FpAg18Hv71Iun9saeK0rBog
	 7Vv+NTS2NyNhJtYwr8mBj/ck88ka1GDnXmWbrvSwMgHhJEFhVhdx1OapCm8zrq7y1S1Bk
	 6PZ4RqCS09OnLjea5vUoguwWnc62/xX4u4zceomcaNhW60QyMo2BWZpP2zQx+biser6hS
	 IVJdTvy6M24nSe3U9h9oZR6nfssmSccInpDWQEw+JhtH3TbOlUCns5fxhbQZwzzJWV6x5
	 0BjTPWt0OZRI1pAfmGkZhLm9+IGLj9xHz3hfLeqlbvyJKDbZEkAeL6gBmdrYpRTz4FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ubJpREFY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dmfGwjLQ;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D85606A332
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D85606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ubJpREFY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dmfGwjLQ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13FD27A00D3
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 10:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978058;
	 x=1794064458; bh=h1pSbr5ruGburMKxENjLvPwVvqkUQOYl85I16DBTJE0=; b=
	ubJpREFY+hizrvQ1T2YmcbGCYj2tBxsFdcRHfeTXKGCwMpsXy5dzsoU5eYLWyhYt
	Ztr1JBhWOspktfMZcRDD+Ica/vr8jM55PKhtQE9ZkQIqsmo83hOqJ6KBYxRkXCPK
	P006Srt1oLUwVPh1niAh4GuLTdBVxQjgxlNQRbvyZ0HO8CMibEVd66qTfYK0QX3H
	cSirRkRVFbQnGeZOmMsiQhb6Thcc/J4PltiJGM4PjkPXDIdW0Y4R6gHoETEwMI94
	51L4/hVbJ+roaObDRG8HVQx+iNdYFSS2KbVUHk9e9/hLbWfbgzgB683mn7pBB7KW
	zz1urlHa2rK6XJdi1C27OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978058; x=
	1794064458; bh=h1pSbr5ruGburMKxENjLvPwVvqkUQOYl85I16DBTJE0=; b=d
	mfGwjLQfIRNk1qzwhQE/xEPgqj7HP5i9Bau1fjdgtKxgNWKR5geLCIIVvh09HiMM
	0u5dt4HifXigeZVNzGucAwFgVqNhTca12rKHtZQ1ZE9LlHBzkU/gGlw/fGUNUnsK
	IR+lYK4PDWvTi+slUAhOWrve+5rAazN77G3AXLAOK9SKyq4HmJ8AkBC04z2IT3UX
	7IRWI/HoTzgloekLVfgBRIMkFb1/kf6z7ypzDHUjXy0dpMnvOo/6HGjob7IhWQfT
	EzdjZaDg1UC2md1Qz0f8sf11jChCgSxleP+nPVr1fKxglbjhP1YjM0Mp3D2if+4H
	DnN1CHXNU00xfVpiaedLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978058; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:I4JB5oCKD7OcP3unLS2QzMlnEZfQMJEMaLe1fKvHv07u4qt
	VGEBfSf6sEE2fv9XsVANO/TIiV/2BjpjFsGkcwOQnt5GJG4KnpYAiOPreaExumMt
	wS+pi3JQEYjJhmQ2DRL+7aeuEYz0juR//y9kfKdvX/XgScf4Nxt0/KyRIv8Iuz2U
	3htfJ9VoG5GmmrFz2IpY4BWQ9T5XX0jAG7t6RExsU6UDRd+tB4I/Xwywn+kkMu/C
	PBbKLYCMkOscw5hxBwF5Qyhh/FDsj8tKJvKPkmJWvzviwLapZEO1L/gH49/8L8HA
	El+G/ABZMX4FoWoypjN7lPswYAhMXYBg1an9eyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gVm8vn7rzsh+nV6B2uirTZzbvdr50l3NvLAjWkAPOkY=:Q1xIqZVrLDxuHtPUk173P15eFQtIjF2mYN+LDK4kSVc=;
X-ME-Sender: <xms:yu7tahNhSEeqKZ1f0CqMOy_Wf4-IpNAid3R3otiySqGSmBHRlKtGBA>
    <xme:yu7taq8nu7uxVRHKPhHbUGCxHElySYuvCPO_QL--ygOXodFauI2gYtz7YNK9RexSl
    8VqNfQzSmApf-hpUV-bJAAWRjR0mTCe9aJu5EDGcSGudREf_0ZG5Kls>
X-ME-Received: <xmr:yu7talQtldnF6_EuwedmLhhH1cKzZZboFETmu93FQV3eTCLlacABOhzUL23kfOclqoRUfA>
X-ME-Proxy-Cause: dmFkZTE6ZXomNTUEL+e+IBM9J3WFYmVrzETiuBmHrXWYYpnYb3z2xrI2H2p3wZwHzIHUdn
    Ht6i4N2vYg8lTKGUn7nfYJhDCfOsiAX5Rb32S+0JuZSade3ipv3pJfoUQConGSwrl5ivhb
    yh7wnfzdvyUNkPwO+43Ods+U2NhkEWiUxzAUTahw5lEchXM3ZWgoo8/VsGgojq0Va2Rgff
    TNYXJkX4YMP88ocNKjUcT1QEWVLVfhEf3nFm6jSS51Gjfvq4foEmVCwV29RQ1ChVaZY/82
    sJU8gmt+TRcSCUZI3nbYq1W2NWgvfELKb+I6+WztnwLUYQ4iJzwfzWCg1LcHNCrORVWIWB
    lMOOKzAUPbOZ81XHUgfv8oWQm86CXgB7VCrtwpqjS0mmCPJFaFAkp7ibXo1e+biFJAdrPo
    5fnuXUi2HrOq7xuh3VIX192QhhBX6cJmR1Gkw5tP8mKYvA61eguEwvi4fItfdVSIn2wBtf
    jcewodjAQIdkV/Og/oepeUUjiUNioYsjUQrC6oDGscJaGOFNviRbs3insNmLuH+lJ0BqlZ
    uYiQget2EeVwLUcKyOjU6J8XXeS8uPE0IELpsGFlcwUm6Kq4/4sw6zxv9ZVJjPJByjnNyS
    jrCcF0uceVmZ0ci+O/qf8moqP+BJZm9wL0gynR8In3u4m7P9MF7uibKKYWcQ
X-ME-Proxy: <xmx:yu7tasnSzSWDwp-cs7z4ln3Dod4en29GJ8EvjF1lu65tJt2j8IROWA>
    <xmx:yu7talSLkFARpPVtkk49KS-w7zSl9p4BB_rqhWc41OkrMvd5Hu5XZg>
    <xmx:yu7taqMYv8JN-6dlDFiHc7oAl8W1LzDQk3X7yrd3wVB-I-NM9GzUgw>
    <xmx:yu7tauUCrzNeWpYACXWV07VXj7RDdhkhWHa13NXd9Un6Z08NdNnmdQ>
    <xmx:yu7taozEomeayVYkz_pjR0oYEDjewefBRU7kKnB67174bPacPeaLkuwp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c41188a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:13:57 +0100
Subject: [PATCH v3 03/12] builtin/rerere: drop `the_repository`
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
Message-Id: <20261106-pks-rerere-subcommands-v3-3-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
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
2.56.0.500.g5d06dc02cd.dirty

