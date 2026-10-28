Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188974;
	b=zweI7AXntnVYJD27IvZaoVecetbDA87JM5U6XTUkqzUNxHSOqkDGfO1MNfh8yHN5BLF6
	 chuMP7C8z4QOmSycbzwrSuxAjt7iKdWT8ucOzEn56L3GffGaA8Qy7Ze2tX9NdYSOkfqR1
	 DVBWQu5h38nPhUQwGXpm0T8LA6SO2WUaCHIT7gNoreSVlzZ3p1luf3zk8yRQost5KQXPh
	 tG1+3H4S0gLlit3uP1NJd4hd/gsoLxTX/3KQEHulxiScW2Os7S51PBn7ntGg+s1D7lKOZ
	 wtKm9koMKRRVI9G0RwvmA4XdJhGNmSu25hGpWzbXwX+Cf/KIoLf8xFD4kh/iAt93xpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188974;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=uWXO4+HQAEC7hnLCQEJkYd6i45SL66sZApr9HHGxEjk=;
	b=ArdM1yGiC6qGf6YlY84sBpCK254KRA1xMYoK2xij+PZhmJ00if5DKjVooShbtwyumuaS
	 78mMRZp6WXE/P+PIygBxrw8v8OaZBzZg7lLu0N5MfPSjIFgl8L44LeIHgBTWOc0Y84fd6
	 +TAMh9D/CtYqwp2VMTMZFywm1c8d/1v8lSpiS+IWDLQtq6InBm9tyuu0OAJj7JrsorMZu
	 ESqZpSDLQmGNyejbTHxWUFNF9vnbOPrPDZ4DZ0TUgVxX2Fc/UbRbT8VH/9+weKsKLnTBw
	 uBe3Uf1h2YDWd4GpXAlItGYgw0fY0+TozFQp+L5TW3hK1q8Kwl68TAtZWZyxapaTfVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=S0YM7MnA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Jm8E8Z0p;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57932606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57932606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=S0YM7MnA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Jm8E8Z0p
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C337AEC009A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 08:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188973;
	 x=1793275373; bh=uWXO4+HQAEC7hnLCQEJkYd6i45SL66sZApr9HHGxEjk=; b=
	S0YM7MnAJUj/7bAVLN3fy+y5a/0KR+aPD0lPs01Izm4j4cbf6DES2SmmEffTtz+Y
	2BkkTQybVUf1qPOBJvCIIvmDf4YmSq6YfsPSXfo2FG2rT2yTuexFQmZ5xDUEE2BL
	tUVtGcLDaf+9X4Lx2Mpa08yYW8inR++bOVF0V1vbgghxr/WLdEz6dIKrYoE4aIv2
	2Y7mVmUdn6t5/utxCDRgHMopiXEcOR2PO5k+UifYu0N0P0p6/1KTPUuB8cjhaEsf
	GaBc6fFZFqGn2nvsqKV0mWUIDCbxk+xBl8hR/pE0t9PZ0LDperg0xsYIDboE5Gi1
	JgagqJ+GOqF/2KXjURU8eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188973; x=
	1793275373; bh=uWXO4+HQAEC7hnLCQEJkYd6i45SL66sZApr9HHGxEjk=; b=J
	m8E8Z0ppA9gZtNBMG2+p1KrIBmppbSnNddtIspW69AecCT0TZIQTM7Kp37Fhoc97
	cThBGIoF8RfJZYLwPbcU7NJKmpM9gkUtXBq5wyR/fvRt37wFMuhyygILppmr0863
	3lt+U1G1E5Ur1N4tXoFC3hcN8j4V4JGlT+oZqCdswHNJQHMxwM+TqfvIXPLhmxj/
	fcrd0lJE2i/bLs9ZKrrVkz6nQfGgF774/hu/ss8EhcEEUQ1+SGDR1ab2f+OPnb8o
	38A0XGduE0OuYPjaO8Ozs9T374IAn+iEbX7Ac2wCR/NI8icMqY/Osxiw789HXhym
	9h9eRPx/jc+g1ngT7f3CQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188973; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aXP0J4AaA1Bha6AzQB552Yg0OiwL8xiUIlDM/cTy6tXX+OQ
	c3VHBlOciW0DA4r4tZuiIqs4RkEOxpwI4V5+mBEP6q1rhZXXlUt7+rrA49PWTqYz
	dcEUjIPBoEs6ldU9AZR7Ms2Izy9Y7YA4rYFNL55J0PsR5DTyf13IcQSgQkRAzOvo
	KH2EEjQ9PngUr3oYM5t9aMSxXPr6zpnWZVMpW4KZHw90JpgcdJ99ayM/9tLVNDVN
	KnEryJtAkKLayV28DKYIGeLjo2xytiKfuij2YipJUAbEI/a+trglmUf8i/APo51K
	EwYLe9iwH34uH6SCVBiLYl0XxeXA+Q4jv0d4Wrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+5Od2dwpe4xHEomfmKb3m7AyEKzshK80ZZcPfRmeV0Q=:NiVAHbEeiMPyvc/ePWkrqSTq93BTPYQw/7nVufNXsgA=;
X-ME-Sender: <xms:beThahpAq3SWVpRrbkD6LbhEXxF9wM0-ncFDR-AP2etOHOjJfaM0Aw>
    <xme:beThaqm7GdN-AnvbCxxG-zXbKyVuVORqbarjnZ9Zb69WC_ot6WXl0nd44HW8LPrRZ
    UmObJpQzgCj3iGIXHTlQHBHcugxHpocPQcFCvFIkveSwpqFniX1EUQ>
X-ME-Received: <xmr:beThaj0ofQqqrJDtfF2yvrePYZ3sU6hwXQzLqzk2UR6B9zvJ1PlqxQ>
X-ME-Proxy-Cause: dmFkZTFjaMO81Uwl0DQke6MvXEzmRiRiJrleyijnJcUoClQ1FJgTabaAZst9GU7axPbPUs
    ci+XjwtLk/1F2seh+HI0fLaTM5AvqwhiBAu0pyNT5FueTXc0a5OL5ZJy4++8m//n6j8hVu
    m9KR7jaYNVeIJlMoMTjMEmdbcX1uXy34PJhPjLoqjTJBzdDa2gE3mm+Dp+rc7aMzbo6Yu2
    gEGoe0kGtjaPAR+wOq/QJbGvF14sHEDhRQ3hzcEInVVh4EXi7arWXbuXvpMjGaGeFQANJ1
    /9z7xpF1bNK560EKD77aTRwQ65O4KdrKy9/vl7m/UpkkvCl2sKv/aUIW8BbKkipfjRLvJ+
    gNnIWeH3ywn1CvDJ8kc/W6yoN/XP/86P0tjXSTrOU2uUYITJsuYpIBepkcwRgiVcjzGd9n
    lKTJ/DiXTrMUGhFSubW5F37SYWhtK2RNvrWs/V5qKMKyszUxTSQDlHCmPQS8XvZuWGZ+T5
    TELU4h7cWgK5SCPkcMqnvLp+kphYkO+Zcc3JU/awK+JSZJT7F4xyQYzQzxs0gf+BmQfTSy
    5u2dVPWzI9K6VM+AH1/cWGybGPYpMXbrKWicXcCL+yrHv7A+bmSBCrDLPvIAXAQArFVn3L
    f9LV2hxL3CeBD521XS65ZJ4JqExLSCt+OuNBAgp7c5iOvLr/zft8h40WPvQQ
X-ME-Proxy: <xmx:beThaiBxIlCsJPBapPbF16SE0h0zHegO26U7n6NIau8H4RVptc0ZCw>
    <xmx:beThagzg8br55NASuMnGMKefgkeo7mziXQwp7teDYjKErN8olL0xVA>
    <xmx:beThagkaAp1zFvB2FFgCdf2UgwNHnY3jsVevj5h2ZGnq2HH5OLi6Cw>
    <xmx:beThalE1lJr1gAV6Gu-TMkY3WbAhkUkLuFeeRu-CiljeFKFNYV9MiA>
    <xmx:beThapJIFUJVDPDdx2ACxswDdqqhFNi-6OitmVaJdCRSHZYisqM3gjX6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d23e160f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:58 +0100
Subject: [PATCH 6/7] builtin/commit-graph: de-globalize write options
 handling
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-6-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The commit graph write options are stored as a global variable even
though they're really only required by `graph_write()` in the first
place. The only other function that needs access to it is our config
parser, but we can trivially pass it through to it via the callback
data.

Refactor the code accordingly. Note that as part of this refactoring we
introduce a struct dedicated to parsing the configuration, and that
struct only contains the write options. It's thus a bit heavy handed
right now, but we're about to add a second member in the next commit.

Note that this requires us to drop the `static` modifier for our options
array as it now references a local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 165dfcb827f..2126619ad3e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -138,7 +138,9 @@ static int cmd_commit_graph_verify(int argc,
 	return ret;
 }
 
-static struct commit_graph_opts write_opts;
+struct commit_graph_write_config_data {
+	struct commit_graph_opts *write_opts;
+};
 
 static int write_option_parse_split(const struct option *opt, const char *arg,
 				    int unset)
@@ -204,10 +206,12 @@ static int write_option_max_new_filters(const struct option *opt,
 
 static int git_commit_graph_write_config(const char *var, const char *value,
 					 const struct config_context *ctx,
-					 void *cb UNUSED)
+					 void *cb_data)
 {
+	struct commit_graph_write_config_data *data = cb_data;
+
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
-		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
+		data->write_opts->max_new_filters = git_config_int(var, value, ctx->kvi);
 	else if (!strcmp(var, "commitgraph.changedpaths"))
 		opts.enable_changed_paths = git_config_bool(var, value) ? 1 : -1;
 	/*
@@ -222,6 +226,13 @@ static int cmd_commit_graph_write(int argc,
 				  const char *prefix,
 				  struct repository *repo)
 {
+	struct commit_graph_opts write_opts = {
+		.size_multiple = 2,
+		.max_new_filters = -1,
+	};
+	struct commit_graph_write_config_data config_data = {
+		.write_opts = &write_opts,
+	};
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
@@ -229,7 +240,7 @@ static int cmd_commit_graph_write(int argc,
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
-	static struct option options[] = {
+	struct option options[] = {
 		OPT_BOOL(0, "reachable", &opts.reachable,
 			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -261,14 +272,10 @@ static int cmd_commit_graph_write(int argc,
 
 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
-	write_opts.size_multiple = 2;
-	write_opts.max_commits = 0;
-	write_opts.expire_time = 0;
-	write_opts.max_new_filters = -1;
 
 	trace2_cmd_mode("write");
 
-	repo_config(repo, git_commit_graph_write_config, &opts);
+	repo_config(repo, git_commit_graph_write_config, &config_data);
 
 	argc = parse_options(argc, argv, prefix,
 			     options,

-- 
2.56.0.341.g393f52fd96.dirty

