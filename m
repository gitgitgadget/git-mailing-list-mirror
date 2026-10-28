Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188963;
	b=kAc3uV+qCEUAzQuCTwwKGY8IIAWEqW8SKUYNZy2Yd1uPgDYREKS7vbfOhvxaSSjJdWIJ
	 KH3yce+bhhIvZ+CyNjON0CJLO/8wQ4uBjcSXU/S38GXLuKpXRb7SKGamx1GqQIAmL8Ozl
	 MjdSn4UVqt8oax1V5djL+DtiGNtnJpkgc6349bLgMZOtg1xtlCNZ3QXbjVp8dAYmfIdM8
	 vJgS19u9NR/NeCrdikyXOT5oNKg8OkcjUi+FA8SIqDeNEEB2xGAPP5lb8FP7KHHirAfeH
	 r2oACpo7vEYI7gYJWeEdMfYDo6/h4kUmHxQylJrAlpQDHqL/Q8m58Qg3OwPqzEu7ZqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Jq9/r2tsLo6jPJYtwcEu8c4+G5E8lqGc6GbZHT3SoYM=;
	b=uEgGrkKjsKJnQrD8JLuH3gUZ4RFELxck+U37upc088SSasi6f61KTDaXi82tQ8e5vLQq
	 JnBNXQXsmipyJf8LAgP+3RSjCRUCfUqzz79fxv745yZrriuln+vfFDfnBXafctN2xrEXu
	 r3yI8O49Q6KNH+0Nzdhvjix4Dtk2HLZ9X3pGMhfC8rYO/G/dGutmrtbf1iQN0ZJq1d7mV
	 B/fd6PqbaA+QOx3CdLHAOUHdpZML3xOBxsI8G2eu2sjU0v2oGkOSyYMHYY40NXiwJ1KDZ
	 g2NRDTsR2cg+IU99aZcL1VaOXgdb3wO7BotwvJKsZH9saORsNmx4lPl/q2QMknDYfHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fC2+xOTF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EHplGFEU;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37F606A31F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D37F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fC2+xOTF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EHplGFEU
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4C0E1400067
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188961;
	 x=1793275361; bh=Jq9/r2tsLo6jPJYtwcEu8c4+G5E8lqGc6GbZHT3SoYM=; b=
	fC2+xOTFUtdBjqRdxLV4+QdBVK+VpSOCcgtuwSaYATVB8YRZsnJz/yYTakTb2on7
	FxQ//ZhmrOXFhPMBcOGXsh5szkd0Yp29AWQ1Q+H2n6RBIdFyKM/fwaqA5fDRUaxN
	LI7sUHJrUsXEhdgIq3vcsC1MASoWygNricloez+wb0bLYimPqugj4I33ksmZoulv
	yRSAgdZiqGETuwoY7g8rX3RmZyUV8OcshbUwlX78IzZi4KS4g3Ykn80ARyAIk+Eh
	FvIfPdcAEI5k+WAfQpJE+kjigV43add5tac9GWDtpzn5AgPxdop97jbFBgBdxuUk
	D7u+3WNDSnZiPp87kN4mow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188961; x=
	1793275361; bh=Jq9/r2tsLo6jPJYtwcEu8c4+G5E8lqGc6GbZHT3SoYM=; b=E
	HplGFEUrZYd3MiPanQAPfqINNS99rZr3Cl0zphZyuT+gabzZjj6ueIbPNkZeCcSJ
	gGWIqqVf7+JjDhHGWS6X3pzoesQsKmdbEeQr7lihIlLjXoEuoIzgKuhmHGsWSIy9
	NagGbtUspujozo7UsAuxukaEhN7uYq3pvd523/WbnGibYRsfF1f+NYOtrzltW8xm
	F/3gQITNqgv8pTfdIlh8AJuG7cxWUQ0EsAE9ypKQpzyOsK7KSfLXkSNBU/4Rh4uU
	gZVnDeI/OCCXCj1W9B1yoI14rxJ4cdt/2IR8+KXjqH6LP1Y8n2xIbUAaLqLJ+sBd
	rGbJOpqT92F4cc5NFRxXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188961; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WUsIh9DVFCsGVeV30ZuUghD98UIZ0eQnIQiP3jX2ufVI8lI
	HZegA+4dMYRPxXPd0+QLtB4CGlj2nGstA79hnBvC1j3FLE7pGAXABSzh2hLhCgfA
	D9Znh5h9JqCdBKWCK+W9pbqIZvHSqznfegsSig+RWIt3IdCJd5Z6TSXCHBwkES3h
	GoereY/EMq/fC1v2/pDamTLruZLsKylQxBpR5v/jf/FD9C3HNoX13IJYsRDafkGy
	13f5RrlH63/6IoWDagujUuPDi3zijVfAY8BwXfhGnaze1bIlCu8Htjbg9cqY+h4p
	Ng0tuweFQD5BVNoKj1HxRv9pwHb2kPR1eKsWBtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vfrdEhXOIbtrfgi1JjHoLGGP2pD6vzZl7REz7s3A4bA=:XAQXhwhI0uiQXpStFsYOnLummQk2PXwn6PuP6irmMtU=;
X-ME-Sender: <xms:YeThasntvWlAsFE0_SC-buxfttuE-AH8jxTLQ1vzIUgmHxw-P29I_w>
    <xme:YeThaizpbNMLgdewpP0cEtY5AK6JgeSsCpGKpU2DzCP5S2HhCZMgJCIABq_L5K2N3
    bPexUiWCQPEXc7DU6HXRLtlwB0IXpuJptort5tFA4rDrdp4MMP70kqj>
X-ME-Received: <xmr:YeThagQ7j3eVHXFdXCmbqaIhtv4_YpyOWldBUWfJX7p3iRqlOoevVw>
X-ME-Proxy-Cause: dmFkZTFjaMO81Uwl0DQke6MvXEzmRiRiJrleyijnJcUoClQ1FJgTabaAZst9GU7axPbPUs
    ci+XjwtLk/1F2seh+HI0fLaTM5AvqwhiBAu0pyNT5FueTXc0a5OL5ZJy4++8m//n6j8hVu
    m9KR7jaYNVeIJlMoMTjMEmdbcX1uXy34PJhPjLoqjTJBzdDa2gE3mm+Dp+rc7aMzbo6Yu2
    gEGoe0kGtjaPAR+wOq/QJbGvF14sHEDhRQ3hzcEInVVh4EXi7arWXbuXvpMjGaGeFQANJ1
    /9z7xpF1bNK560EKD77aTRwQ65O4KdrKy9/vl7m/UpkkvCl2sKv/aUIW8BbKkipfjRLvcz
    obqvX+opKDEguA8iMcSBlsAe1gKBvJwfNz8P76pNI0f9WkPnbNXq849mkmeM3tGEdy4brJ
    KD7QNpvpHbCCMgJo4+0W1sqxls7lGy/DFQ6Q9gwQxhSkrNzcFvzXcNqjTLvoQ85QCbXYFO
    I6XjHHmGoySm7gdZFDAQOAi0KPa8ccCytbSAC8ECsKIJCYRuFtQ8gdo43khKWZF0YFnXXp
    znHuuObss55/hHU4FsHDsdXw7R6+WnK0Im0TByIlf/oUvtXn42t8bRc9JQP503ZpYXIZ64
    KE4r7Fb004ewjVo8BKQqQaYRWwtAXk++oKbLk/VAjGkXm4juG7IRcxM5tGMg
X-ME-Proxy: <xmx:YeThats5J99WKYyJusv_lIL8L0VuhI_583GVdgLSBE4bGwJhDItG4w>
    <xmx:YeThaqtZtyL-HNvnVBuenD4zJwz4PhFFSfFxmKOM5mhpx4LaS7U0uQ>
    <xmx:YeThary87zc4VBaJWBpv8AYagd-M_IJIT7y7FE6GojkvgsQjJzQXDw>
    <xmx:YeThaohN80joLp7DYMqXtCQ6aN6fBle7MbFfBzk1inDRK4gqMcjJ6w>
    <xmx:YeThag22mbB4hqs7G0i-MOhyiyyzN9uemOLFEihdeiPDMZGUmKY7V9Xl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7550273c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:54 +0100
Subject: [PATCH 2/7] builtin/commit-graph: drop declaration for
 `read_replace_refs`
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-2-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have an `extern int read_replace_refs`, but that variable is not used
anymore since d24eda4e03c (repository: create disable_replace_refs(),
2023-06-06). In fact, that variable has been converted into a file-local
variable, and users are expected to call `disable_replace_refs()` now.

Remove the declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 415eb6afee9..14f9db5456e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -148,7 +148,6 @@ static int cmd_commit_graph_verify(int argc,
 	return ret;
 }
 
-extern int read_replace_refs;
 static struct commit_graph_opts write_opts;
 
 static int write_option_parse_split(const struct option *opt, const char *arg,

-- 
2.56.0.341.g393f52fd96.dirty

