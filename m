Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267858;
	b=X7jbN1wo4P2/pSaNPIqSDyOZo3T7tqPohhcXFDeULeDumCIoa8LMgvkfpkhlM7B6wXKq
	 Q0UfJKgUsSQv/n9pTkFT3f/Qhbbzf4pjixwp28AVBqyNrPLPMTds4dp5WVTou+ZO9BO/L
	 lm27CX7xonzBxDDXnhvJMDYjapaGgJL8b7EIgJbon13ksffZWy+r0iZpLsE8UaoP/egK6
	 KC/q8hZO1KuC5X67MFsZ1wdiiciRJsEpMSX0m8RDt+5VdImSADvUJLSBrHc9iwovnWA4T
	 ANi+YpE2/a0ZAlYaRwvDjxvLiiGP6/W7O0k/9w3uI3hIMGKvTSKatei7/q3zIjbXHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267858;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=8KTMNdKBkO0TAVmQAKeqGNS3LHX212BTfB2pHNrju/s=;
	b=gO9717qhVxdR7iZ0XNLbqF25PA7Jt5LQ4gexPUJr9yp9iaNXmY4WXsVcA/MA0fgFE1mI
	 Zgxo4T3+ANNcotQBWh5sHyqKluec6Za7OnMCQVlg3N2kpzCaeaM0hNp/Oi4RhOnwo1V4q
	 tF844rW4bwq3TaU/0eL340Gaq0TSm2chjlIOEUv2+SeXQRj8PakPDN1vcZb7Q5Ie+itqA
	 oN6kg1Pb5mC546ITlZtL+5cpgNNdsQahDQz7B2owLwpbkaHjhryZUh8WqihYeyzabjjMl
	 x91hMBxfcTl7R20ScTtYiNorOGDbNpJq3O5eiy8PtRxtTh27FRhHDB0kek6aRiNQvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="VOS1V/Jm";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rsYHioZL;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED056606A323
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED056606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VOS1V/Jm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rsYHioZL
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 570B41D00055
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267856;
	 x=1793354256; bh=8KTMNdKBkO0TAVmQAKeqGNS3LHX212BTfB2pHNrju/s=; b=
	VOS1V/Jm8cvw7WxRdb66X3vU2wKbcaZFUUmze2Gaybj1CaahGKhlEl2Fz+UQOCTr
	3k0LThBvFzSE9huLjxEs18A1epD7NJhpZ6pU+BNt/imIOltnZ6RJc4MzBPlzKjDa
	oCBi9ayMgynZxztRs3wEagwR4sy3hBclWO+JkVTUcvt6h723OyX4G7lscbhlce+g
	wq7xL1PBcIRvmX5WEW8hLRc7UUuvsDTcGfE8QjGaTkQi9Rjr2bpoM+FDFv0e1uk4
	OCyOA/PNvAci2MuYfw7DYlnUjeXfMxzgRcbvkLG9tYYfTf9etRZueX7+U1/EZs/F
	ImnWvCa+jgpYKl+An3PaaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267856; x=
	1793354256; bh=8KTMNdKBkO0TAVmQAKeqGNS3LHX212BTfB2pHNrju/s=; b=r
	sYHioZLtYMnLisc4LoylWsQQh1plO20HTPXurs/kDAtgpssRX/L7aGwx8gsX2gcv
	+GeRR9mYaHGoplisvoxuyFNDkSDRGybHXxGwj41AtG629HqezJ8s0ariTWyrGs4L
	NgW/W4FyHKPxjNGHYVW126VpP2fKzD0xjd5Iv9p4GXQME6oNyFyL85qoaJE+V1aX
	p2DxgxuVUD4aE6BecAc31cCMCq9hgZnqysevFTfnuptEniXo4fRBWS6/BJY5UJst
	Xb+2bdxTjQIfwwa2W6UiqRnbPPBfLUX3vQK7738TnWizSbLBJ6lo22sI7u1bkmm8
	ksl3SPpuR55bQ3ytJ0DrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267856; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:I3RcXLAhjXR8pshtg23Ijcg0oDaDo/cCo4UFC6auTGhw2Uy
	gijRLNV2/BtAsZ8sHypt/UHyJyqWyo/29E0xCUoMxHGqw7iXyJueN8ejADSXYoJQ
	jhkRDIUXPnc5nNtoH4Sw0ST+qVvyUDbI60qv4FzhaXgDr7pZO9VAN0705x0UQ0+L
	Glva75X24WfdIWCNc6VJsPrRHcRBUfFW4SAlj9nObnXb/EVtQRd/Gy6vq9ojbPsp
	aJNjf+efh8kUNsWZQZtg0jKzAP44cb91KLeyST9zJh3KNyDdFYtn+Fse5WJ9XNfW
	6gNWelpIFlxMHbSdL7Cd/tUnMT2qENSDCOE1LmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vWH4JciinW5IYaQo4+8cTb/B6iTKsl7SQlWuW6SLTgM=:4y2Pc98XaubX1n0HAz7iD6GGhFHfqwFAR/cns76vl9I=;
X-ME-Sender: <xms:kBjjagdew2jRfGtZv3o2qVy-gJR0vSx2XmrBho6h1LnJWjbECjcxUA>
    <xme:kBjjappK75PTZbLtdpb18iOYwMvhSLZozN6tSOzvVaHOKoq0xvNRRHed16uYqUyx1
    04g0CJd4SFiq8pnVqsNY0peRr1h-m78TAxI3kzxIxeO4RuKckJKpoQ>
X-ME-Received: <xmr:kBjjau4nX4BfNv6C12bJtqxKtb2h5WxUu03KQMOGKmATlUJjoDHYLg>
X-ME-Proxy-Cause: dmFkZTEAU3Rk0hdY9kXYjr/7MdMx2a9bcCAhabboH0Xo11Pw9i64eBT49g1wNmqIRSNuml
    cPdpmmAJo3KR88Ko0QnFkcyNT370hpE9T8q+3H8Yxw4TeZ25Zi88s8HG59In/DUh1FgqMJ
    pktZz4Wk+Tx6UN+06064/jToqm6crwVkFjoNqMtkuhH6jF5GW3iEImTgt7wCXN++kwv4Wa
    V0DyxrHM2niXcKvtfaqL6W3b5Tg1/VTpjSpIfWCItgKKxo8M9Ob5CAqr8qSv1IFuQpwUhd
    VfaNNJ7SvdDo6qT1FJNCOuA3XXYVGY0G1Lru0WNGocYF1SZmHLKGO6T7u8xJDemZcwnDUg
    W0hPln/+rtTFSLBpMU/HQbbiaTZWf5+RMiThz0dVoSPZQaveFodJkP+g0cwc7O2iQNCanU
    GxGvDlhDav84cwdlBQGb92DA6DGgSw0K59OlFqrlDg3k2ruXZYAhad9oJHi8EVdtCZgGQA
    SaiWa7sDp0MrlzCNly3CnUYRfPDHnd8hBfvluZ+Gq68k76chErUlhsQUOSs+2jgYjljxjR
    6sl/zUmiv+NAHBMSGNvG6wUGvZ5YGZhKvthNzWZERTM4Uio47pc/rGvqLSddUEIw00kMyb
    PlIcBDVQuG8vpOrOLXCJdxjxPYW51TJHDYnKfT/RhYYn0Lcs5Lg2VKE4H8Gg
X-ME-Proxy: <xmx:kBjjavpXlkIfMhG_lhSrTRJwWdXz8qRuZW_Q81T-lbnH8MGYaMcP9Q>
    <xmx:kBjjagiN571TKoa4IgigIqRNj-AtE_ls0IQKB9FMEJRulmehYnaUlg>
    <xmx:kBjjapK9PeKP_-Fwrygoa3lVog8lOrkEjDm7ULFn7GhKsUTNzk-sDA>
    <xmx:kBjjagDtBZn2VYkMWz6FnycYFl0HjOlyrBMfz61khHroC0ZeHE8xlA>
    <xmx:kBjjapwNNnbnHRns0VXXhV89yAEatwsqt5kxYh7O1sVCQC5lbYxUI--R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bf26eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:15 +0100
Subject: [PATCH v2 06/12] builtin/rerere: turn "clear" into a proper
 subcommand
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
Message-Id: <20261029-pks-rerere-subcommands-v2-6-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "clear" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 5d2ae154ff8..62f69b488b0 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,26 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_clear(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_clear(repo, &merge_rr);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -107,9 +127,8 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-
-	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(repo, &merge_rr);
+	else if (!strcmp(argv[0], "clear")) {
+		return cmd_rerere_clear(argc, argv, prefix, repo);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);

-- 
2.56.0.341.g393f52fd96.dirty

