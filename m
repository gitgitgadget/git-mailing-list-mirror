Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188969;
	b=HbE6AkBik0OUMg1GfPknp4UgLCv3Zw8Z2LHZH/MLr5Bg3BzrevqDmeHry13kiHyrgdo+
	 w24XIcwYR+XSqMEEtInJGnHDqBRDTP6DTn4nOp4+uj0yUyHbhXgVaibL/FxA2hso4aKsW
	 5A6ZbInHvc70xD46hmReK4jXC8Q5t4nGn/ESvQ4xQNX/ClSyAk9ghT0ujW3Gif6t8om7X
	 6jFetzS0bIZElntfvoR+LkNuilBiLD0jZjkO0/5sr+fVrLgY714oa94gkjsEOjEY2HVCi
	 BVHHAqwEf7hLsMZCzjHFHggAlK6D/zFDN4hVhIh+vyOiaa/AkToO7hf21ECn7hCtAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188969;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=mjnWer1CV3YVeS7+3JTXzRcSTM/0NeXUO+wSPVvnMnI=;
	b=VrDHMlK3CRbb89H+AMHhJquHOMu57VFrw6gSDswqfDbBwEpqlu+GaB96Vy7rqhYWivT8
	 M/5OO77LDgbgSl/Dwf1ztkTVdKPN3t+zQ6ORAv/cNL/ZrYM8KZcr2kBiQsVrxWEyRT0E9
	 YC9IWTKrOJK8r2Be+z0nRev6phAUto/rcygmrwork87DkbEg7jWIQlfAMQ6Ynla7iU5tY
	 B9C5XKjLY6lh7QFd5klX+I+pcP3Hha0mulFjziX+PhcVfL7yK/AgVXWehHuF2MAqaI2Dw
	 Uc1rWvCST79F6FxIzQ6QM6GQrAzgNJIKWLZZhi+kTPnCh/K72yhpb2UdjX6eiMQ88eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vR3Z3cYp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p2obHjKr;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D07606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D07606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vR3Z3cYp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p2obHjKr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 50E7AEC00EF
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188968;
	 x=1793275368; bh=mjnWer1CV3YVeS7+3JTXzRcSTM/0NeXUO+wSPVvnMnI=; b=
	vR3Z3cYpD7DI1sdpWguPzV1K9i8xJMTbPTiGC7QgjIktRnvCM+Ck/ZgtDQ1iJo6K
	CUNRiHiK9qvjQ7ZSiWKHL+CDK4hOUkPiuyVGwFv9SKA7rXU5ZMG19OwFFECNuwQo
	MuWNCZaDpsbV8qri9MfKy2Ln7G4NzoyJRiuTTFbmp/oQChPic9OWFyiyYzJLXu+1
	khmjJtYr+J3+zfhoF52Sz0BDBDK/AoY+/w2+kXjqHp4YU5CvC0O2xnPzENKO0aBC
	3ImQ31FBeNB9j/JHMfsNxnapbY2QnZLRya7cAInERAcIykw3YRQiIJMurRguWvuE
	1YWc6P3VJO/2y9d6y7ZxoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188968; x=
	1793275368; bh=mjnWer1CV3YVeS7+3JTXzRcSTM/0NeXUO+wSPVvnMnI=; b=p
	2obHjKrY6m5Cbm1Fz/DMYfPTpzZBTzwArS5PUxaWNiDoFD5WBltX+U5qlgm0EUHb
	d+VjAPJ1Qni7mfTA6ynrko7U9HbaDtYSO4WjZd52Ph4jBWhn8mvMMH5TLtrMe5P7
	0szR5j0dWh+lzxR6pnU6XQVDxn5wkq94AC3OrKCapNV9dwdR/Zcvc7CRaRrznSjK
	AQuqE2De3DcI3lNLtkHZnBJesuusYAx5cnMhpUqyujfpkY5TS0CQNN79U13wAzuP
	NIaHXGtnVL4U36n5+lEuBmCdDs1FTtlra6jqVEWuaux75izFtof1/MKDtUL5+POU
	14R44L2cH3mGsAuFIbGGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188968; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kXPsBc0J4nn2LEoSToU/tYqjuSHyY2WijMiUb4XIgI9Bucj
	pANOMBVOOlqUMAinSl3MoyibH4xa37oqEGv5ho7Bg0ixCG1TDl2ameYlg9gwQ5AY
	TsejSKSlTKwwWedBGAPqeaarHbwBOPMyQGfCXU1Z1EToL7PHDmAeghVmjvgbBXrI
	E08y8sBe2c+JO2UQtdeT22YerMCcX1lmLkRA+tDTSWk9fwZi4YAETO/O8a9fMUo9
	15zh/9d1zOnbbZUgT/p6f9msFVhYbVIhItXOLxsXpxZ0sstKKIiNTv+yEB8ide67
	ZBIH6h2TRMOxpFiN18JJjgMhwdpE0pm1tUd6VoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kHOmhLoDfIwwm6oJ0yLYQShhWyqpwovSAktbTt5MKEk=:wcxoLPhpLnmYiMgdiUlwijMw/MoTb2EgELuPmq3aDB8=;
X-ME-Sender: <xms:aOThakeqPHV_SqS3KpRam7UzYfx3fBy3Qb1yzWgFKLI4tZLSDKNImA>
    <xme:aOThatJe5J1fldtZJrbBTfa83JNuKttkd4kFUg1kvN8dTbycZ5hnRCRjDoYRpXt9e
    D5pMWy_dy-nk_Rb3Hf3u5V5MkH1I6fJJ6q_gqDAAnuM1BCayMo81g>
X-ME-Received: <xmr:aOTharJ2J2leyFODtdEwDIfUHX6sFrf1hbXtxzD9mFjsX-X9YXZnew>
X-ME-Proxy-Cause: dmFkZTF2Mc3g8z5gD8+pUCnfHo0lMqlp5+WCfQ6DsmMs7ZRLfmLWaPAYb3OxASUOPEyWii
    rrGgpP73XAFgqgFdZiQVcNzt70BknD6/ZmmrBAMiD3EdIwO8hYWgJwBghKUmNI97PfWjJD
    dgtYN9YY/E9q22Yhy2fa1Ym1d7UZTvT8Vq/JeZlfbe+TNu5Z8lvZt2oScPfQq0wGB7wmKU
    8IuWikhTGkGoqr4o6kk9jMI6s5BGPq64SYLjB8oDNH2FzUqfRY7ONmZsx4k/2aG8zqU7e+
    d/F1HDktwSDIEvNqnYSx2X+hHzOrsWqsioMfYGiJmCA0Ad0vys5hak9zDzQvBEnHvC85Ze
    DKEDU3ki3imYET3uQbuIRdwFmooelx9gJ/vLDG9Jt1YgjXmSObS6CKBb+QpB2FsS6ywiD2
    LiuQHrVvWkKoPM5cJXLf9zzXMvYNonna9JFgceaGfqWsVvZkfsX+SoI3uVgrrHXQvcKVWe
    DILO78dx+M62wk4JIjPUxFAV295FzUHDIs4XDXv/BI9kmgtUVR9vdSYlXO1zpNQRxCRlkJ
    jEgu6yvA/m0uQhcilsyyfgAz3vS7ldF6wOztZX1FcU8BSTtD9eoO6fww7bcYr1GxjfANlx
    T4qYczhXPlCb6nsrOVg768d7EeAb8fczl96cT+SYZbscKAHqdpu7YeJ4fpQQ
X-ME-Proxy: <xmx:aOThavH2_mr_os0gcK3lMEYLn9B65vwSNi5qqtzjInt6WbF6RLqtEQ>
    <xmx:aOThagmgvOWqLBxbcHcCzcZaP_CFjMAT8PVqgzcu8ikUiZG-Wpwkhw>
    <xmx:aOThasImD2G1Om0g1qBkgKQl7RH5pzEJbuED4iZ5u4yd255QGlGb0A>
    <xmx:aOThahbWHPYS1FWGZfwD1TY4kUEjiNdAzLZtTHGmqf9jXqF3iJNjvQ>
    <xmx:aOThaqPk0s-y11IQ8bBz7Xv3GjCaY_Q8ZS7yjAYqYXKCVwvn34A712mx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a115f17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:56 +0100
Subject: [PATCH 4/7] builtin/commit-graph: drop global "--object-dir="
 switch
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-4-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When invoking git-commit-graph(1) it is possible for the user to pass
the "--object-dir=" switch either before or after the subcommand: both
"git commit-graph --object-dir= write" and "git commit-graph write
--object-dir=" do the same thing. This calling convention is very
atypical in Git, we don't document this and none of our tests even use
the former syntax.

Furthermore, this requires us to keep track of the object directory via
global state as we don't have an easy way to pass the parsed option down
to the individual subcommands. We _could_ of course adapt the logic and
prepend the object directory to the `argv` we end up passing down. But
that feels rather pointless.

Adapt the code to only allow the "--object-dir=" option for subcommands.
This brings the command in line with how Git typically handles options,
and it avoids adding complexity in subsequent commits where we're about
to remove all global state in "builtin/commit-graph.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f8825980f40..7140433a39a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -365,12 +365,11 @@ int cmd_commit_graph(int argc,
 		     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
-	struct option builtin_commit_graph_options[] = {
+	struct option options[] = {
 		OPT_SUBCOMMAND("verify", &fn, cmd_commit_graph_verify),
 		OPT_SUBCOMMAND("write", &fn, cmd_commit_graph_write),
 		OPT_END(),
 	};
-	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
 
 	repo_config(repo, git_default_config, NULL);
 
@@ -379,7 +378,6 @@ int cmd_commit_graph(int argc,
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_commit_graph_usage, 0);
-	FREE_AND_NULL(options);
 
 	return fn(argc, argv, prefix, repo);
 }

-- 
2.56.0.341.g393f52fd96.dirty

