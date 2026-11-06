Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978085;
	b=FPlI86WjTQLwYjCiBFNmLAooPovAg3UOL8hIXimKteBf+7aJ2bBFsbV0Fnal/oVUKAyS
	 h2JdudLN/Pxgt8xtOjsTJ+mBr7xGuRd+ErpFIekNIGYpaoLZ8Vi78gLbpTuuWdDrnGKL6
	 CQxuoCE0j8OpE+yb/YRLfG1MHKB+zOvaya8sXK8bC/31SS33OQYF/rzKIZUN2B7l6zcJ1
	 Rd0AqwasjqYt7zeUULCvULfzEKAakr3G1kwhIQDzNPazln4mZTDeuJnwxBuPavS6XIcLd
	 5Ftmf+/0Nh40AanP6LiiqUdFnxF9Vtf3AavHU4DIrR7nnK/Ug8rP+0P+FzIBTNxxxnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978085;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=C2jPvJ8cDCYexT2gpZYqr7uSYri0CgJCpEMckLiwiT0=;
	b=BW1LVs3ayz4f8O7pPtnAL4B+5eRZvpFxQ5gGpMlutIR6vwmJDNxV1+0fzsa0ZgChEjzH
	 91nsfLV9bWoxO0qmlEnIPd3Sx7iQISIkXNWNA6W8ZUVqgb7yAXvSzyDIf3HDjmkwhufs1
	 0qWCDD+HiZ0p7NjKVvBVHpCMP0wZBtDapppZmd/LTXW38g49B/3FNx+h1RjrS3GrvYmns
	 /7t0iBeO/Y+xMzi+jGITEI+fRbAu5PW3nIpH4Kctx0r+ak74irIsS3v+Vw8gARXyx74Tv
	 BQGQ1CRYX1xDEyFx+v3kNWCIicuh97BR7p8PXUDMFjEY9vjY8azdNDIEbkHUWGeGWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ZSsF3Dr7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UYwL9XYG;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D6606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A7D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ZSsF3Dr7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UYwL9XYG
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6618D1D00145
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 10:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978084;
	 x=1794064484; bh=C2jPvJ8cDCYexT2gpZYqr7uSYri0CgJCpEMckLiwiT0=; b=
	ZSsF3Dr7ugZhzRKRAjXKJ703eX4qnDSVNYtyY8sh2xLd3Nt9qEtXKpSqYpSGVU3d
	eYt2m1lttomX46BjHckktbuJRJcOZ2a+t/C8LJXxT705rPhKfrfD0Ba0EUg3+rUK
	KNe8hAqEx/8M8u6LPeEujqbXbP1jT8vhp2cWvPbq04Cnwou1Hrr/75El8tfUlcTz
	oWpmyYC6kFi01DmZhlnJHUV7mIINFP00xRFq9w2GkKOOLnWzEZSf3eoh18X/8Q7S
	56MfqIF5CxXZ7+/bhyRjM1Prq0lol7EFhQ+WqiY93ehPfawba8Q7vEzQYaR1XRMx
	5CgCYEd5tKqyZXh/9MXykQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978084; x=
	1794064484; bh=C2jPvJ8cDCYexT2gpZYqr7uSYri0CgJCpEMckLiwiT0=; b=U
	YwL9XYGN1EmP4FLB2cz4b9S532NAKYHvilPun8C6iIOPsdBDGcE3uR9bn4q0iSQ0
	i91lz+XaPUv50U1FtUKQQ28EumR7Ug9WkiJOf9T7J9bg7EtkiGfPxBR1Mi5veVtM
	bcqP9thIgleEOv7W0pzN61ss0b6GwZheVjNKjo9MIkY/YcTLdH8ETwYsqVNeP0WA
	iYc3FmaWrxbZJG9T9VWBtrvMVNRBbKSTZmyo20/V9VsutDbaj8j9D+Y8qa+J+zTS
	/Hr5pH0Z0kizPmNfgAhua4k6Owur1LIN7AvDMECU8dU8usaQ1RS8840B5zB7MAD7
	iIDL3DsuZqoNwi9XQhPBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978084; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XlAUgCh64rFnxxJAUE5AhWGRyrcRlH0ksMkf0zfvEJriYVJ
	KiXE2N59Jz3++IhD0vf0aImeUVaxEjhnznOwyHWzgJG2Fq5CNtzBaEpcFexI0jVE
	5Tfwm9zgzZ/xmg8DSx8i4dEDL4zgzuEI8nVMm+RzDtnHUvmBlaczKBT23ru37ir4
	n9F4gOOxpf8yIW5Yljz8N6Cb+9ibAGXp6WDRccvbMd3dv5ZvlL2ZlYv9OuPPfiqQ
	yjrpdbAs6dpGmcIyQsgtcdRkYjBJBLC6eBfq+XGIKDDvxu0nc+7UJbeXUmjc9az/
	la2WORduKMm4iwpaS4B8gvmHLmf81okdt3Gi6cQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YLJ512jn+EHbpj33pzLZN9wcnAje7VQaIyX1QK7QLV4=:zcfNpREIYkN/42p0WlIWosGeiay10LM2rp5xefmSokM=;
X-ME-Sender: <xms:5O7tajkQxDnKRxBQR_lAMpzrQ2kqhU0BUA-TVRHh7ZidvwtGX2LBwA>
    <xme:5O7tat3eyITho9Eh9sQG8-w5Ka6Qk3-MHbPsKw9Bx51xIe4ydJt6wo2B-wBMk_bKW
    RhDOKGUtL5vR_4oGmI2Ph7M0XmfsRT77tKSEl2JrfJhUAh8kP6AXdTZ>
X-ME-Received: <xmr:5O7taup_Z4kM7-bVWMY6AN1H4saWWXSyqkui-OmLAu3qixjnQ0WM5sVvxFnQFLxBYRsTzA>
X-ME-Proxy-Cause: dmFkZTGiZi4I3D3CFJhnJomFWQgm7nh8fATounvHJJfJTKhJBDSXwFkf1UTNQevRgOo/XS
    B0fO+LwfdZ/bVUfdSuMB1rI9hxrRIUUzGqtg5r0mZwU9GqbnYsAJ9TYE84IT8txAPorJbn
    NHN8gdy0sDIRzMTLMfTG1SxQ9FhHmC4Yb+T18pDVlgOMkbZViM13BXioSzd+HshVnOA4CA
    hqqMmliZ65/IjfPQyvweLauBA9UpUdkd9ioUeNq/OTed1TrI2A1Y22k4iBYwYD8kqUFvJc
    Bt5wfnc3+XBqzyHwL4SNO5UZ/abkYXxesxYHlJVHJguw+GJ9QeFSxn3NE/5/+bILf359ji
    +Ytnf1zwsrY7lDv5QGAmHBUYwjNU6wHUriK12iT/1dmCqxruiEY3Z9UjJ68HsOMjzUVJn2
    mCPAPc52FCdGDPyzU0d6IUf1XeRBjJAG9ufv0IMg/CpcbRj2562xSsygpd5nFK7afQazYK
    0sqQDQ0c0jPlYlO3HT/yIBrtT6lRSc8d4hw0zumaS3ZqfyVKuGWuewTMljiU+kqaS7dBI4
    xVNWLAHQ0/eYwzD+SxfhrRYRq3rGNqmSLKmUei8/lbb8473yVmS4xn+0/w9BzIeiODaiql
    V2wyvdHS0BnzREORsYL+dhFdFvwTiGnT2ERXnXfmKp1YdrRm+aZwJOxggXqQ
X-ME-Proxy: <xmx:5O7taqfA1S7RehLDHQngAo_Bax0MXVqsNnzcFclodyd4mR6K9gG-1w>
    <xmx:5O7tatpGThX2T2v3TgatSo6ltw0AOPKY9wzjUts-lsnQhPiL58yahA>
    <xmx:5O7tarFUihHPnNVjJrU98lWeU8ROm1nsbGB-uFc9TIjlWZyZuzAhTQ>
    <xmx:5O7tatsoFNnZHfWUdgJuTMZ7g372TeJxMJRgxQMc1oTTN1viz_k66w>
    <xmx:5O7taqLuR9okjTZJgOdKrlToQs3sZuEpNx4YAKSPwzpWMe2y6OQ9cFVu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6c01f1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:06 +0100
Subject: [PATCH v3 12/12] builtin/rerere: introduce proper usage strings
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
Message-Id: <20261106-pks-rerere-subcommands-v3-12-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.56.0.500.g5d06dc02cd.dirty

