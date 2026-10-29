Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267850;
	b=2MScx4wXpzB0/KpFBXj5T3tNMGQMw0F8iHmMjzwgSALTe73T9pb41VoTH47/uoC1vDZ5
	 T35nae4AJsT9+TiPdo3oBLs8YIHz2rwpueGpiCil5GiYaiRD0w5sKj18DzeNjq96KeMF/
	 w1FT90johwvdSXydIUZ/D7qyy0OzZr+w8bWmwIym3+9NOc0H3kxnmQPqwmBIbjkR9slff
	 omHkonrm9AIr0TmXNsvI5rP0QiyiuF7Id43QRHjWnqGcGxFLsRJ/FNwAOwUpqCYVZ+h8P
	 eHF1swCEzOHj4DJHT2HmU7rzWU1eFPmEIAqewZ2DjDV0Sz5b+0h7dsUI/AU0FD+9Guw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267850;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2lDC0VR6nggv1dMJ5OaITZTUM+ZCuIxABhhG3zWQ8kA=;
	b=hOAMChtHsHges2LJnOfYiSBkT2K/Y+tK4jzXtJmS6B7HhsWsrhboFJ+Wkykl/OXlOntd
	 ih6A0LeTLe25DQQ/sm0LD/S8zO/UiDril3Bw3SwyFT7JuFZFQY1lDtC8MCs17Ele6myEp
	 XQTbwz1oYLTncxFx3hCZvoYY+Nh8RMFNjkLwoG6HWN+xapeRFhbZUOeyJlvTtSCxlkzoS
	 LHkXaNlxbLKt2FoXAdQIwTKXEMjzvpMjN+jtCWCkQVdMnExyuBv6ZNnwTkpJhsSgp+QC3
	 oJzSPaS1+bUdP01hrpR6pcx/FpKP2W5+wUfpGAXEYp43Cf/HWfQnbWtHYrkV2WNrOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=luASZYdh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wa6bMgeC;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DE606A327
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856DE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=luASZYdh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wa6bMgeC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D56D91D000EE
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 05:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267848;
	 x=1793354248; bh=2lDC0VR6nggv1dMJ5OaITZTUM+ZCuIxABhhG3zWQ8kA=; b=
	luASZYdhLnbqUW3CUcZU5n5Xc6eK6Oz8OAg6vURNBwcIF1XWYJGLiHbJwY4xtfVu
	aL1xvQXzcWebodpzhKDP0ICCZi/w0Sawi+xzS++zCVwEg0xiSXQKIYhKFqFWO8A5
	7VrMKTEwDiMn//U93VjoKhnj8+jZDGfBa8XXIU0tt8w7uWe+tDXhW3QS5c3/o2Fs
	qbkI9ekFX5jZImiCSSM0HHZKKE9nPS/58blsCW1zcc5Q/ATNXUNo/ksZSV0y+yf5
	FYMBmNPGLv8T/ctbcgNpoL87d+ntcoB8pzbM5kzEE5+27oHNZJbvxJygv+fSSpoI
	GVv4vM3MhDkBhvGyhYTRVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267848; x=
	1793354248; bh=2lDC0VR6nggv1dMJ5OaITZTUM+ZCuIxABhhG3zWQ8kA=; b=w
	a6bMgeCujlZX4d/n6WDhJoVwRSszo7v60IzZo3npy0dZfsdjKP5KHzLa2CGzVGNb
	9GDYDUUGuHiSBqJH57/L9wCiojKaaWHJX6o9k/yn8pHufstDEfsp+L9j4c6FkC1f
	u+p7tfhyMxVu3GmRrUBQt5yEQERIMl8DSqc78rlIFl06dGXpGdr1vo3iQJTdCAL+
	Fq+Qq8Z7OMZ/8dZkIHvDyh25Q2de6HpF2Sm8xgtYPUGkJ2TAec9UJDLfDl/FnrXD
	OVDnMAM+vzuvUFyc80HWxatq2rp1jWezDXVdTjvsk0gO/mLbRrwCcOOQwiY8HnlV
	sYNqzQ686xjaEPldVIigg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267848; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ABclQJIxMLVefBYxP+sDH2dwBsXmuR8HPQp0VRf8yRhv2Pq
	kXLT8Wy53gl+mamQ11eryrox6DbkiIvPzxHgipHWbO7s1/IXW/c/AvzLsBl65z9c
	wspWkmV8B8g4LeScWYyllb7c3iVKtPHPHuWdRF6dyCaizroRjlICZVc7Ueo6m/Ib
	jIYJjTp1vgxw68hSZyqdJHI7ODrBCGeOOCZJCtPpuUWDiy96DBiZ/Yb9mvKmcFIA
	luv7PuFYZCYBDW7wPy9OjqvLdd/9CyQW2/O61gOZHS/XOfrpLvX05eYI+8qUQ5Gy
	C3uKBcRqO4BApDnG0+NtehFG6+tmoFXqbBOUTLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1x7xvTlhtRWaLl6xgwrjRPhPgtcOKr8WSyoQjJmSAGk=:+NUNUVeIP4fQo1zBHn4VZ1CsmY2tCNaJkZKdgl+lRGw=;
X-ME-Sender: <xms:iBjjajvgTwwHu327Iv_3FrEqBZe9AMHL__q_3wtA9I8y1fdN4ViD6w>
    <xme:iBjjar5yrZNeGz0psZIhA4TWruYeN5j45iU9E31AL4cOnzpf-KgSEBD44vWhaxgsl
    v2qd2MZpg2nFmpAiVmKG49kfXOzKjVuPDFkllq5GeHkLKs3FEtBZyw>
X-ME-Received: <xmr:iBjjakKXlnXpGOWp-uO7w7VxTEh7ssvmh4WuExxzRzGZBurJT1b_aA>
X-ME-Proxy-Cause: dmFkZTFuJOAbUzu7EqolGX4mnxJ5uaVCBZsKwAgx+zFu05c+EPsW+5N6DPGUvU5vEt8Fq8
    /yfXqQoyjlguRMf3IINfNHKllzqR3NPVl+PcCSOZBRPo3hYsU9o72avu+S+u+OWLIK/UuK
    fSTlQJ5iBF7m5ST3XNkdoLZc84/Gp9ABF6POCKOtHs4wyqyc4wehYJKzxSTgPypokt4X8N
    P//SCnNcG/PpHnqtT1TGVpKXR4h4nrwtrfdXYcpT4qF3GxKHy8HbwP20t5q61TKRmeufd3
    tN2MrHYNln2qb2vDurDTJ9k9e9m4ZiauCDxxKYIZkIdG2qGDp0MXYW+lLI5KNPP4fLAJBI
    IVDdlW7n6nRxIzTRHhT/BSHxCkuxrLbtGGEgWBPaUk7/dl4mcmu+nsr4fhEzpSS6btBCp5
    +7jLPF6KWGqJnC8ihaFl9zbbIq/MP7aqOKpW+kDfFLPPZMxkCEPz26cYpsOqL9xf80fRnk
    alQDSsQOMTnlPlRd59gnis0yIO7HtohHja2uRjMude1/YSviLoQz0SzZFx/RD9gbreRdfY
    DBlG7u5faLIpbSAEZqGADfrTv/5L5R6d2yrWKh3WeJ4kW34aELGUAj6AMtXLjiQgPP9oSD
    F4P3Hd1bAxC3h/0olYDQ788b4HidQdG1RU3XFqpNef4RTRgtn6p4FvwjAAng
X-ME-Proxy: <xmx:iBjjar42pvI4ALIDIoIaHDcqXXd_vRXARhxYzYV_whmLNYpFXYg-PA>
    <xmx:iBjjanx-fUu7eyMDPMkupyjhxVVstUytYtbHDeSxMzi5LzG1FMdkDA>
    <xmx:iBjjavbD8xD4BG5rez2TdkdoWCkvNQJgC95d9U4luiy5lBFL_zUzYg>
    <xmx:iBjjapR9dKJpIbUf7g_5Vsdizch8lJv-Y-uQaoBcgbYtDSn4Vu59aA>
    <xmx:iBjjasAXf8FhRi2heJpVrBHrNKLAX_LtWIBLOXyJpx0QeHPQPDBoGzSt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4834191a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:12 +0100
Subject: [PATCH v2 03/12] builtin/rerere: drop `the_repository`
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
Message-Id: <20261029-pks-rerere-subcommands-v2-3-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

