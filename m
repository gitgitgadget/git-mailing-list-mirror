Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188972;
	b=165LZL5ubsNMYYSjFCoJITbCDbhjCvBgg44CBzKcRITjmfiuIF5WzspjrlKg6qnzPTyl
	 1Vnrwj4viYnWXiS85kKOuyatQHG6Tvg5yM9bI2j0WpDocTmLQ1B+8pBbqx8ntHZ2HEsQW
	 qPzJWOIuJNf2G7XYu0BVs8+4TLmOIT8W14hXyweZCHQT/4ArS6vJZ0V6IBcHF+zKF8vr7
	 ipqg/baANbccVRENW0vmYdJkIL6yTAnmwJZuKCG9ZxkGb5kR3j8Cy0KM5Sk5aonpr4Tmz
	 XxD7zqt/iEPNOya5gmo2UlGIwGXS0y8w3vXH2So5Of3+nbdXTRzLpAlhUIupyDkH2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188972;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+OuMJzv23oW+gF2SKRbpG/muo3jhDE2oynOvgsl0IEI=;
	b=pOtjYxF4YUZ5b2B0/6vA9/Wq0f2IkKODHesIliJaUby5TGYiaW1LDzmMeqwbZSBgIrK0
	 /0sIsVU6+Oi6OWSWCCWAT79vPer4svTFBXrpoTlVb+ZZ61ochi5/0W0YMl2jcuu2reKaN
	 TwyctY2HGRaMMm0IHkIWy54YNm5b140MRKjb1H1gyHf3996Wb/apwyu5Osb0IPDJXLHUM
	 8TjS4UZ2PH9rVk2XjBulSWJzGrXE3KXPVa1WyhEzpdJZ+/onhDJkdUKYWQfoxn/sXExJU
	 F/KWnMJKkkse3LGWYIdTCfKZ2Ne3jnlKjUfQES2Mrv6Q75/oH4KJFUmgrldD5vRPmGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uFYRrSoQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m4mXfih4;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DE606A31F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9DE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uFYRrSoQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m4mXfih4
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1077514000FB
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 08:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188971;
	 x=1793275371; bh=+OuMJzv23oW+gF2SKRbpG/muo3jhDE2oynOvgsl0IEI=; b=
	uFYRrSoQ/pUYlvqYOTMVeAwWmIgtxYKMT5GP4f6w/5R3ZVGoF46++9/6nwZcnxSc
	UrszIRYrxL3NyvjBF/PaejXjvWSn2+UoQ4yWfsSpiggq+OqFpE/3KDL0Tf4g2Zzy
	JG2qFt6d+sxkGkCcFjUHwZ/KyON0fdp25eIODY0x6lgP23azs2PMp8BqPR+SYyaO
	VXr65AO9FDu/ub2RreFLoFLiifsCHACtPBVhEq5dogOC3YUggxFe9LrNF6ipxSkf
	7/N9q56Ipn/QoPtorYpOwv6XTYPkZ1Tpf1i2xg1vjp86s4odxbwrVxiyLx5EO6Wq
	M8D/+7Vrll0Qy8+B1Zqbzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188971; x=
	1793275371; bh=+OuMJzv23oW+gF2SKRbpG/muo3jhDE2oynOvgsl0IEI=; b=m
	4mXfih4H/SpYe/Gt4wk60WtRKOTEMUuZtzMZ21CPg7dhG65koIUlhInWIBCs1FV5
	Lg16GKsaO+3asU1QH/ceagp6WBYeRNlEcvVbJlbG3wEhfABI3YyembMVtG8TfY2u
	3XZqtyvF0b4u484uW6G31d13zJs9y7weI9HumJ6wbXq/EhCG7KkXQ4E0NzPnEl3V
	ClKyhEWpBX/hTz+lKqPwqKn8wpcPcDrjtLsxZq5n0BLF8CDQKmsEhLz5YK1ZpqCe
	rMNxz+4ScZgmiYgUmgvzVMnovScBCaMDYvcF87+IUGm0mJ4JTN5C4IDPE6IyRq3K
	yTPSuKnSBZHCRuWh7/NPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188971; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KW1wis7lD2Yjz5VmwGjcPOdVZ6y8JldygFbMoLUBHBlOKwo
	avFHOXlCS9XmAQQ7mb8XXYWvPgckQLmgBmh7NB3SnJ6zV14XQEYYwFoMwNdNS2a7
	19SYl0aW/A2yXdUNRYq/dotP5O4q1JoUma+tzqYChdcfoa7iOEoWyzpCFcANYIUK
	wP+Vr55qY91DQca89oixq0osNdqNcxjqFG2ojEd4Q9DqzlPOzkjRsG28ugt2MHMO
	rJ5qVxV8WsZ/xEy1Xw+pGFJyLg20EIwqQxGNsz0jlC88WcbuBnT7TCBbHQq2F+ef
	/Bgv2dCmCYBn6kC2RYHfrpTNoBuWFWJrP2j+NyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dBuaE6skVZIXWJfJODtZ+WyJbig28khtn7fydAp3fFw=:2A1L/kPyRqNJkr3oAU5Ym24uFIb/ETLh9IIYU0nTKDA=;
X-ME-Sender: <xms:auThakJX9qKRipguGmv7JLMqmzL91i6lX9PdfeEVPLic7YUQ4mMNww>
    <xme:auTharGHwAhJjkqjoLk_BsNyaYECFNzTaNKtHLqW0dCXbFeBPvQyZJXCv4hM2VpCE
    gkCPWM1qk_H13luyQTKXcMBr7FF8LvYmcXNI_4icl7BCMjLe9lDeSEd>
X-ME-Received: <xmr:auThaqU3McXKNgU-5PHohB2p_2uHhqes13NdIFiicz8Zb0kJHCspUg>
X-ME-Proxy-Cause: dmFkZTF2Mc3g8z5gD8+pUCnfHo0lMqlp5+WCfQ6DsmMs7ZRLfmLWaPAYb3OxASUOPEyWii
    rrGgpP73XAFgqgFdZiQVcNzt70BknD6/ZmmrBAMiD3EdIwO8hYWgJwBghKUmNI97PfWjJD
    dgtYN9YY/E9q22Yhy2fa1Ym1d7UZTvT8Vq/JeZlfbe+TNu5Z8lvZt2oScPfQq0wGB7wmKU
    8IuWikhTGkGoqr4o6kk9jMI6s5BGPq64SYLjB8oDNH2FzUqfRY7ONmZsx4k/2aG8zqU7e+
    d/F1HDktwSDIEvNqnYSx2X+hHzOrsWqsioMfYGiJmCA0Ad0vys5hak9zDzQvBEnHvC85j1
    soXyrVkKJqhaiaqODSzurKa0dwgjF+yGXYo/QHMveTExeq1zwvT6Gp61YxqqVof5NSGgrs
    K4DoeMPEGc4tsRD57C7ugYdjlmmIs7+LWEmOnm1zgU9B2XOZqyMIUB7tsqEweLdaY+I+ot
    wKOThGcN+ZjxKiOzwk9CjsV+gi6Bua58393OwkgZ5udldtgsdAebH+CCyBTvcmDXy8SJeA
    1wYybkjD13rDppmUChQtXUzP8UzB+RtVPaIY+FIS0K9GoRo58xZtrTBx7SYOE06WRxvHEt
    usu7XyVKoEPKFhlO/O8VMeArIIR8QKSewV9RHuhGwRDRgftyuwOZvPtqC/6w
X-ME-Proxy: <xmx:a-ThamhwhPj_FDPJSvFa6TB4wuVaaD-jyva9W8AcyvRZd-WROyjxgg>
    <xmx:a-TharRBZj6-K8Bqs63gZD0df9u6A89KAaVtzgYQdDsEB20wPwuAGg>
    <xmx:a-ThapGeLNzM4b0HApx-4lKp16vPCPS7kIX0OOuMomiDaJxIG0yJWA>
    <xmx:a-ThajnTINCaWDm9tkzeTJa7PVyRwEoPlQn0OhySpA6qYPzc6N9wSw>
    <xmx:a-ThatqplXN3HE-cec5ZQvK5j6SqLJ4tVU4UM3nu0qa5uJbsawb8okjd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de7ab950 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:57 +0100
Subject: [PATCH 5/7] builtin/commit-graph: simplify how we wire up common
 options
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-5-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

All of the git-commit-graph(1) subcommands accept the "--object-dir="
option. To avoid duplication we thus have a helper function that adds
this common option to our array of command-specific options. This works
alright, but it feels rather awkward as this forces us to allocate and
free a secondary array of options.

Refactor the code to instead have common options as a preprocessor
macro that we can add. This avoids the extra allocation and is overall a
bit less verbose.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7140433a39a..165dfcb827f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -52,17 +52,10 @@ static struct opts_commit_graph {
 	int enable_changed_paths;
 } opts;
 
-static struct option common_opts[] = {
-	OPT_STRING(0, "object-dir", &opts.obj_dir,
-		   N_("dir"),
-		   N_("the object directory to store the graph")),
-	OPT_END()
-};
-
-static struct option *add_common_options(struct option *to)
-{
-	return parse_options_concat(common_opts, to);
-}
+#define COMMIT_GRAPH_COMMON_OPTIONS(opts) \
+	OPT_STRING(0, "object-dir", &(opts)->obj_dir, \
+		   N_("dir"), \
+		   N_("the object directory to store the graph"))
 
 static int cmd_commit_graph_verify(int argc,
 				   const char **argv,
@@ -79,15 +72,14 @@ static int cmd_commit_graph_verify(int argc,
 	int flags = 0;
 	int incomplete_chain = 0;
 	int ret;
-
-	static struct option builtin_commit_graph_verify_options[] = {
+	static struct option options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_BOOL(0, "progress", &opts.progress,
 			 N_("force progress reporting")),
+		COMMIT_GRAPH_COMMON_OPTIONS(&opts),
 		OPT_END(),
 	};
-	struct option *options = add_common_options(builtin_commit_graph_verify_options);
 
 	trace2_cmd_mode("verify");
 
@@ -123,7 +115,6 @@ static int cmd_commit_graph_verify(int argc,
 
 	FREE_AND_NULL(graph_name);
 	FREE_AND_NULL(chain_name);
-	FREE_AND_NULL(options);
 
 	if (opened == OPENED_NONE)
 		return 0;
@@ -238,8 +229,7 @@ static int cmd_commit_graph_write(int argc,
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
-
-	static struct option builtin_commit_graph_write_options[] = {
+	static struct option options[] = {
 		OPT_BOOL(0, "reachable", &opts.reachable,
 			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -265,9 +255,9 @@ static int cmd_commit_graph_write(int argc,
 			0, write_option_max_new_filters),
 		OPT_BOOL(0, "progress", &opts.progress,
 			 N_("force progress reporting")),
+		COMMIT_GRAPH_COMMON_OPTIONS(&opts),
 		OPT_END(),
 	};
-	struct option *options = add_common_options(builtin_commit_graph_write_options);
 
 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
@@ -352,7 +342,6 @@ static int cmd_commit_graph_write(int argc,
 		result = 1;
 
 cleanup:
-	FREE_AND_NULL(options);
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
 	oidset_clear(&commits);

-- 
2.56.0.341.g393f52fd96.dirty

