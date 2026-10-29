Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267875;
	b=glQyWIofJi6NoXHgXiOaQTIi7Qu3GKssGFQTmIx1QAtuoQDLLMo0CaSkLZcofe9E05Ey
	 XE5MVqj6njhaWEmJGilUlKB9WYEAvYwbh456jP63MiPMyQ4qwCtX1jd4CVHO/7dHZ3N5E
	 ZWhYKEjdmpOf365FdmqY02MAn6za1b3N+0LU9d6aIGRHwwmVNXh0Pao79wjrS/8xHigQO
	 YWYOko1Yv+IYAnFjzECsiHBC7ffeGfmMifzYyDZPNfyJOvTZrAuRxlmn0oUeXe0ayxviw
	 BxARqUAYoPtwm/NPvQpl1gjAW4KQIrjawivikvO0VRsYhFGPdw2BGoqk25BcSfQboQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267875;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=DNf7IKINRMDhQs86uMCK8IrRraK51iywU9KIt8Fmp1s=;
	b=noNnfrSQl0I0lgPuV/b3Tgt9jfq4UHQKV3WV6ztzqZW4uDqm1gACWLsnHt8NtpAiqZR2
	 Nh5NXYuRYTwi7+2Be9h/DC6Teupr3dOTLD27SM7nggoyb9t3Fpn2DUGN7xXWVjqCRlyaY
	 tMxLlLbeGRaCd5L56DoaZUiiPGFum7erxOsKpvFGsEmm/3XhUbkzLN0JyTtzfBvSIee6g
	 w+5/ysxt8FgIMhLeXy33s5VMRZ3bo/ISX9LzQ5u0F191N2rsWgduHxjzXlczWnv2b22Ry
	 YTUGmZK35n++DZDbziBe/JlaU3piJgynB7MnPOYCt6Rye+nv3K1D84GNGfxW0y4qw2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TPBMHXeN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TULyzmkF;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDC606A32A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3DDC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TPBMHXeN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TULyzmkF
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24D5C7A012A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 29 Oct 2026 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267873;
	 x=1793354273; bh=DNf7IKINRMDhQs86uMCK8IrRraK51iywU9KIt8Fmp1s=; b=
	TPBMHXeNDikP3h4qls75sv9LapB6xVdcB0bVxY6Nf5mtiDjLdKEOtpY2DAP1s3wD
	juY0Vuykl7/C6cnsvx3in/WBlHcIrxdeSBsemhDiYE1irswgGZ9bPW0Vv5CmsIiA
	V4oLzq9zSqC0NPP2ZnsP+Sn1fePoKuOWds53TtbN5Kukv1ItF1E6gR5uxOZsKrxk
	+ZdnUi+S/2dIrxeZt3mY/dmR+Rr7765iMwhiX7zjfB3ylS68X8qybecGWHcRpcrK
	BGdfq9SYaOiWM4zyOnGEjfVrl5GHwXeyNRxGDluVYaopwe1anBtQq4NCItO6CVGX
	6QDMnZ8+93cISCvNbWx+zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267873; x=
	1793354273; bh=DNf7IKINRMDhQs86uMCK8IrRraK51iywU9KIt8Fmp1s=; b=T
	ULyzmkFJZKO2oSt6mRa4uQnvX1mwU0QBFZ+r31P7DZzCbzQkp6UOjr8cjd57MIwq
	inhx/kqrchmA0YsNYMB699cRc9fqZ4SZVN6kklbkIss5Lk+RNUVdoB7qXhM6NJuY
	6npMotkscUbVG6yolp6lG9Bn3mmj0kyVAv3JbCWSRdsz1PCLlz6BKNi0Y1Hz9LUG
	j7yPNebhbEAhWctBtyeL2ix/fA8Ga2QEIaUIBIQlM9QTpfm6/UXarGzPUPIIJUNU
	su8QMCq8Nwbzp8JA3VdLuBrwFRX8KzCjsRfN5ghnByP2usWV39sz1cIxH+2Y3zUp
	McxkKRYSvsgVMWlkgsW5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267873; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CjcAXXRuiDvSUDp1ZRfKgNZ4OZ3KjJsyy08ILyQg70IKUU2
	F8S2izy+riQZ4O5e2Ifumqm5QtS3AKqAS+pvvL4kVKNlvvEaRgRFBNZ56CFo/DwE
	8Ie+8SSntuwC+q45kmemReSXrO/ABp9HZbkgdxLpnFjkMguLi74knP6Lyc4WYLy5
	D0pSVJqMPQZlzH53j4Hr8CMmmYVQdMNLrJmx67NtxsZk3+25Hj52YLRNA8dKB4yF
	Qn9HT21jrxmS5p5JSnjPbdcEWr8lJcBDoeQX3Nie6IcD4N5ImUPaqExVFGg3Yhwl
	sHW5JUlVlH87gpqNf9VmWV+dTMuD8I9/uEnneFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mJ+ifyF+VCUKDX6QVOQ6TLyCUuZOk4g9Us8sAPGXlWg=:bThy/Fj+HSvlHhPQxPLdSPuG8CC+S5GHG5fTsSDUmlw=;
X-ME-Sender: <xms:oRjjai70LxrChLGM9PhFcwbVweIp3Eao9fhkZj-EwxIGMUjbG6ubeA>
    <xme:oRjjajVDBuy1B2XP8wqfKew788k0oWWzSTBwKEHtxOjmFN6lEZYWJPEFQ-VL5lxFn
    D7p968-_qmll2r0e60e5U9LTN2OkLNT-zY853oVSoIStiBz1LGG86j5>
X-ME-Received: <xmr:oRjjau1DZj54qv7dPypHMjmndLjNS5NiZu5AhZTNZ89sf8X9xZyhCA>
X-ME-Proxy-Cause: dmFkZTFuJOAbUzu7EqolGX4mnxJ5uaVCBZsKwAgx+zFu05c+EPsW+5N6DPGUvU5vEt8Fq8
    /yfXqQoyjlguRMf3IINfNHKllzqR3NPVl+PcCSOZBRPo3hYsU9o72avu+S+u+OWLIK/UuK
    fSTlQJ5iBF7m5ST3XNkdoLZc84/Gp9ABF6POCKOtHs4wyqyc4wehYJKzxSTgPypokt4X8N
    P//SCnNcG/PpHnqtT1TGVpKXR4h4nrwtrfdXYcpT4qF3GxKHy8HbwP20t5q61TKRmeufd3
    tN2MrHYNln2qb2vDurDTJ9k9e9m4ZiauCDxxKYIZkIdG2qGDp0MXYW+lLI5KNPP4fLAJga
    JMKkNcSUdqSgQ//1cy15z0puRYvz3s66RaN5dVMhZnQDKU4anSDws3bJZRrVUM2FUjikyA
    5MhX+I1u/U7W4RqYyW48x3k3bky5SNDu39Z8kqOdTrsBaW1xNAb6Y6s7N+GP8sn62I75Md
    6Zo+gOG3Znam+YJgI2zntPn5f5y8DrwFunvBJn5V0Od8mSQlihW20hTeLr6Jt4WTVd5T7m
    /wiQSRHlABPmoO7j/Lcu+Svw8e6Y4CBErhbbSc2XnGky09gbUaa0d8AREq05IaQ9QTsfQi
    m2xrvko4BKojdUdk3JJ0LCQwpolUhmLod8i80Nwx1YXDcfffyaTMJQRZsumQ
X-ME-Proxy: <xmx:oRjjao1d2H9auweZCDhP4MzT79xA4FAjCelhSxIl-8fjYeS6EOl_kQ>
    <xmx:oRjjap_-icHaUQYXJu-mRmcQUy42ShrGnxsIvtfB3UnBQDwhhIXz-g>
    <xmx:oRjjat3EqQkMH0FgLukiP84Rt7XsoFdwF-SYvifGBl85HdUPIUBPzg>
    <xmx:oRjjau9ptjPy1sJP8qq2oE9fAv0byAp-5nHr3_MDvB-aVIiFFz5DHw>
    <xmx:oRjjardvtBq9rxraX1jpNyyMtPbwR9GaVIXBVc843zKiDBPlGYDrJTAr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 645b62e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:21 +0100
Subject: [PATCH v2 12/12] builtin/rerere: introduce proper usage strings
 for subcommands
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
Message-Id: <20261029-pks-rerere-subcommands-v2-12-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Adapt git-rerere(1) to have proper usage strings for each of the
subcommands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rerere.adoc |  8 +++++-
 builtin/rerere.c              | 61 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c9..e04e9ef3ef8 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -8,7 +8,13 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
+'git rerere' [--[no-]rerere-autoupdate]
+'git rerere' clear
+'git rerere' diff
+'git rerere' forget <pathspec>...
+'git rerere' gc
+'git rerere' remaining
+'git rerere' status
 
 DESCRIPTION
 -----------
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 97c791e420b..051e50838ce 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -10,10 +10,13 @@
 #include "xdiff-interface.h"
 #include "pathspec.h"
 
-static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
-	NULL,
-};
+#define RERERE_USAGE N_("git rerere [--[no-]rerere-autoupdate]")
+#define RERERE_CLEAR_USAGE N_("git rerere clear")
+#define RERERE_DIFF_USAGE N_("git rerere diff")
+#define RERERE_FORGET_USAGE N_("git rerere forget <pathspec>...")
+#define RERERE_GC_USAGE N_("git rerere gc")
+#define RERERE_REMAINING_USAGE N_("git rerere remaining")
+#define RERERE_STATUS_USAGE N_("git rerere status")
 
 static int outf(void *dummy UNUSED, mmfile_t *ptr, int nbuf)
 {
@@ -61,9 +64,13 @@ static int cmd_rerere_clear(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_clear_usage[] = {
+		RERERE_CLEAR_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_clear_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -81,11 +88,15 @@ static int cmd_rerere_diff(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_diff_usage[] = {
+		RERERE_DIFF_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct rerere_cache cache;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_diff_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -115,10 +126,14 @@ static int cmd_rerere_forget(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_forget_usage[] = {
+		RERERE_FORGET_USAGE,
+		NULL,
+	};
 	struct pathspec pathspec;
 	int ret;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_forget_usage, 0);
 	if (!argc)
 		warning(_("'git rerere forget' without paths is deprecated"));
 	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
@@ -140,9 +155,13 @@ static int cmd_rerere_gc(int argc,
 				N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
+	const char * const rerere_gc_usage[] = {
+		RERERE_GC_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_gc_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -164,6 +183,10 @@ static int cmd_rerere_perform(int argc,
 			N_("register clean resolutions in index"), 1),
 		OPT_END(),
 	};
+	const char * const rerere_usage[] = {
+		RERERE_USAGE,
+		NULL,
+	};
 	enum rerere_flags flags = 0;
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
@@ -186,9 +209,13 @@ static int cmd_rerere_remaining(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_remaining_usage[] = {
+		RERERE_REMAINING_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_remaining_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -214,10 +241,14 @@ static int cmd_rerere_status(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_status_usage[] = {
+		RERERE_STATUS_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_status_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -247,6 +278,16 @@ int cmd_rerere(int argc,
 		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
 		OPT_END(),
 	};
+	const char * const rerere_usage[] = {
+		RERERE_USAGE,
+		RERERE_CLEAR_USAGE,
+		RERERE_DIFF_USAGE,
+		RERERE_FORGET_USAGE,
+		RERERE_GC_USAGE,
+		RERERE_REMAINING_USAGE,
+		RERERE_STATUS_USAGE,
+		NULL,
+	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);

-- 
2.56.0.341.g393f52fd96.dirty

