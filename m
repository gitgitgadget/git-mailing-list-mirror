Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807861;
	b=C8DHW/mz/w0VHDlEdGpi0W2OHDfSr5HUlPd4/mmLJardXmv7mN6adI/fUq/aoIvhlDOJ
	 yTPz0Cq3/6CuB7n+n3o+ezBRobW839kbysT/ZYuudgX7DY5pn4Sv1MYvVgRRdCN+bFwWf
	 pLL8/EULceQ/ZsQG5mz5CB87zDC/gr1XpnQ0TofVNvrred9jKj1/p3eRIjpldX4V0Wex5
	 RRpxx0f2nHL6VdilZg1vHnevS+fTX7+Ft68vFXCpAJOmpOOC/3DkLgEDMVyegP3tEJHlq
	 DRz23jEF3sKqd8mfH3dmWKn3Uuw5UWBdQsybqmoHN0aq8EV8VIAOcqHiKtzGI3SciRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vQYW+6VJnTf8vMpJKKIGEyPcsFAoIMQv8hiSKHb+QqQ=;
	b=1kAydNJnLojDQCqga2eaGpERctQXluoyv0haU24dprw2wVcjVfiLgvfyX+PmD065fqYK
	 UqI8lfzu0GVCBmjf654x+UYRUpWvXy0TxkGhGNgxUKI4WQr44uV6a13YolY5pOfaY2mVs
	 wM728XHN+UpUVDFmcQlnIZdMcu/yDWwKUC7v12hkWH4Y+Gf1frpivphKEDDk2rlU85Jjh
	 wcFihBQnaHqTALjtW6bxIp8oBVi3TZFqWEmsAxvfPvrM5KM1zaCvxI3Hlg72e4EjNm1h3
	 mhH2+MtXSWccuilPauh3XwXOvsFi5Thwu+Glotzk7IANL2oDCLiXLUJEax0k7Vpe3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=okjophQv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kRbyWyP5;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9860A2629
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA9860A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=okjophQv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kRbyWyP5
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C23ED1400176
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 10:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807859;
	 x=1793894259; bh=vQYW+6VJnTf8vMpJKKIGEyPcsFAoIMQv8hiSKHb+QqQ=; b=
	okjophQvXAj1NqKi4U+Mk3IkEK7TkyCRPWg9ipgdNeer/FFKEtxmN6QTXRChsZW7
	TOTVySkbvu/RbwcQNNw8z23N5BB1AsJeV7bsfwP+l3vw3eb0mI4B87bXW/pXROpo
	+nv1Mxahm6LSVmLSX2Uo+j7mJyqjvm0mcyWKwM/TKZFcrrFtitdIKPyqQWQ3rXI7
	1f12cexqv6chEutE3qetzU3kUxCnp6LL1jxBVfxG1PpOHwK5sOZ9q9mF1Qfqrnsu
	IIteJdL74BjI5j6D8LC5mBqlk+SCOIW0oNipbXF2DNhNocmNvRm/NylSWD91XSqY
	CBONR50iekzZ1bHt4FPb7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807859; x=
	1793894259; bh=vQYW+6VJnTf8vMpJKKIGEyPcsFAoIMQv8hiSKHb+QqQ=; b=k
	RbyWyP578OMyHgVKCJfP0TpVW/5DDsMELNULlSabxOlHZnMovWgL5pY5cCq5q6uJ
	Ex/VK32eSZwfNmHiuJWnTOpmWGrADGCWBH46MEl1a+LxhLVDG1tMD2GBso3TM1Wj
	1VFM0p+G5qctPK/5vMu07xaj54IVenNsJ2idFrakr0d1CvxE62cw/ID9y44NlWs6
	TKl8zMnTchlCigZBbCEledi5VlmZoruZf6nAwabtxUj4dsg3/n2SEoS4/TGVoMDD
	aYNTz+cFUKWKqnbr3JrJ8lntmzCB6Bk6W1K0cTX/NzOEQBqNvmbV+E5MfSUkLGAZ
	E1b1bCV5/0f1PJBxSemFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807859; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CYJJw0sko3Q8PjPmNBFggS09ns25ouPnzA7G+Tl5CK8HwEa
	IF2iX4A3CInfG4l6kf/d2hpxNBuJIJH5v47hhCjEFZf5qj6mpX2mC/8jPwIsqVqE
	xPqbqpJdHTfYkRutud3YP7aUTMS/bQFZgQJZcF8izFt/bW0omJ2LjGZejcPRB8Aq
	JR+vIX5mcXzqP9vc0DEwYDK/tzBa+P8jDX3CGPlnptRtGbr+kx9r0rIZ4LDomF3x
	y0+v56Lio7LXpYd7YONwRgELrXqJpDVsTHOnhtiTXcdvLVpTwzeu6Q2J+oTHgkg2
	0LeOixkPUgF4IPUW1C09YURteuI8dB2cPrZDh4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Y/+2efig/hsAXNln+WXvUwIozLWBtKPhS0ziWo96Res=:KChcuxi6OdLa5ky5QdhQdCh9zXkAjOOzAIX/M9gByD4=;
X-ME-Sender: <xms:81XrarJb2AHFstT3GlCG6yYclvf-XldW84Ihw7j1T5XySpBQO2AEDg>
    <xme:81XramELObYTka1k1NByx-naZ9HkqEWGccXVdpWPnlJFffUXWAqRqZj074Kb6u_BE
    ATg64OpkQwFg1T-gKCj5lSsIrg_9knaOSl_US6Nd6DUAox22NMA6h0>
X-ME-Received: <xmr:81XrapVpEe6gSfN8Ghaz3lOxj5j7PJElUOogtQt4JAwmqVifybCBcTUa7WpVsMV6F5XD8Yo>
X-ME-Proxy-Cause: dmFkZTFP9F9oJWwJG85mnHzfFOqny0OiD5iiWGUykvkiOCtsZJx63XeSWFS5hvnOTWaXXM
    pVNW68EmUAqObsBxHEoTqZGxr1uInZq5ObL120XJ6obWw31M/SqAAh2FRln8SyYDsBRQAc
    XgLSwbTYIIRAuqer3KFyQcFJVx1upExtgeuk4+nospz6pknGbvTFoQtONK00uHdyGa71ei
    05eeKL8ZFbs8tu8jIH8bDRz+5s8LGUqkWAZAgjQZeduYIONS+s4caycfiuwagcsfkJCBbf
    gsJbttQXJ4DA/1KBEx2aj29+xUBhITr/+i7EpjG9SxzktIlj30krZRuziPbpuPiywKxRIC
    /8HDRztqmOG45uB89dU+o/i0X4yhWFw1HeIm5DhjQ4ybRLUi9mPUIj8yXywntWbBA8ASne
    9pkmR0s5vhNfhni0Ism/Ku9PxvOp5RW3iN/d4/ELyIYo5XB+zMKXvaq+HWQGHOGe/KWqO5
    ofJ7qQx6Seclz8yiOtAWqrcgvXRT48pr/V81e7t9sO4sRE/Ig2b4KSzRKDCrWxpHGJqhuX
    CV/1XSHE/bqzsGYZbgACLH66ZbLgb5q9JsydKnSh+FvrXE/bwgprTiCJjkVk5O8wQ9qIE2
    2bqdKTRcxdrv1WZZNjqPiFPbnAqFYh84yrhTOn7ou9hPQA+e038K2CFqtqRA
X-ME-Proxy: <xmx:81XraphTF_a8C6h3qgYCPc7NmHzZupcgUu1aCeVsOpJSiTWCXgrNrw>
    <xmx:81XraiQdTj53faA8ud9kCJ4ywVOOxEWoGto6Xx3a6SkH8g6qokFang>
    <xmx:81XrakGtS4xyQEo0bbBxGIQiInLX8w5svz_0iE6B8v7cFyOQLXoeMw>
    <xmx:81Xraik0zN7KW_gSeY_mTtmj-ZVTJSUVqkWPczbubE2cQl-OD8fZKA>
    <xmx:81Xragq5Z-2af5xCGqoQtiRH0LEZHovyyH6b6db7bcP6mG6jw7BwRRwL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36cfd5b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:23 +0100
Subject: [PATCH 01/10] commit-graph: rename `struct commit_graph_opts`
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-1-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct commit_graph_opts` is used by us to control how exactly a
commit graph gets written. Nothing really indicates that it's only
intended for use by `write_commit_graph()` though.

Rename it to `struct commit_graph_write_options` to fix that. Note that
in a subsequent commit we'll also rename `write_commit_graph()` to
`commit_graph_write()` to match our modern best practices for naming,
and that will align the naming for both of these.

While at it, also introduce an `INIT` macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  7 ++-----
 commit-graph.c         |  6 +++---
 commit-graph.h         | 11 ++++++++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4d28a9d51ec..0445302ba8b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -141,7 +141,7 @@ static int cmd_commit_graph_verify(int argc,
 }
 
 struct commit_graph_write_config_data {
-	struct commit_graph_opts *write_opts;
+	struct commit_graph_write_options *write_opts;
 	struct opts_commit_graph *opts;
 };
 
@@ -229,10 +229,7 @@ static int cmd_commit_graph_write(int argc,
 				  const char *prefix,
 				  struct repository *repo)
 {
-	struct commit_graph_opts write_opts = {
-		.size_multiple = 2,
-		.max_new_filters = -1,
-	};
+	struct commit_graph_write_options write_opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
 	struct opts_commit_graph opts = {
 		.progress = isatty(2),
 		.enable_changed_paths = -1,
diff --git a/commit-graph.c b/commit-graph.c
index 6c141a6555f..2f9bf7a44fd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1166,7 +1166,7 @@ struct write_commit_graph_context {
 		 trust_generation_numbers:1;
 
 	struct topo_level_slab *topo_levels;
-	const struct commit_graph_opts *opts;
+	const struct commit_graph_write_options *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
 
@@ -1916,7 +1916,7 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 int write_commit_graph_reachable(struct repository *repo,
 				 const char *dir,
 				 enum commit_graph_write_flags flags,
-				 const struct commit_graph_opts *opts)
+				 const struct commit_graph_write_options *opts)
 {
 	struct oidset commits = OIDSET_INIT;
 	struct refs_cb_data data;
@@ -2565,7 +2565,7 @@ int write_commit_graph(struct repository *r,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct commit_graph_opts *opts)
+		       const struct commit_graph_write_options *opts)
 {
 	struct write_commit_graph_context ctx = {
 		.r = r,
diff --git a/commit-graph.h b/commit-graph.h
index 3b55192c2a1..513713ecb62 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -168,7 +168,7 @@ enum commit_graph_split_flags {
 	COMMIT_GRAPH_SPLIT_REPLACE          = 2
 };
 
-struct commit_graph_opts {
+struct commit_graph_write_options {
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
@@ -176,6 +176,11 @@ struct commit_graph_opts {
 	int max_new_filters;
 };
 
+#define COMMIT_GRAPH_WRITE_OPTIONS_INIT { \
+	.size_multiple = 2, \
+	.max_new_filters = -1, \
+}
+
 /*
  * The write_commit_graph* methods return zero on success
  * and a negative value on failure. Note that if the repository
@@ -189,13 +194,13 @@ struct commit_graph_opts {
 int write_commit_graph_reachable(struct repository *repo,
 				 const char *dir,
 				 enum commit_graph_write_flags flags,
-				 const struct commit_graph_opts *opts);
+				 const struct commit_graph_write_options *opts);
 int write_commit_graph(struct repository *r,
 		       const char *dir,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct commit_graph_opts *opts);
+		       const struct commit_graph_write_options *opts);
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
 

-- 
2.56.0.500.g5d06dc02cd.dirty

