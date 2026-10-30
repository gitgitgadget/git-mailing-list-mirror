Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382000;
	b=gRB31LxRZ6+FKYxeHUV2apcn/4oiP39yDHOhH8cLqtMUPyEfdxPep4leXt2kXiXLZ8AD
	 DkGOmDefuN3y9lVfEB8kfHN653CFVMhfDhm1qQNSzH1rinHVfHn7OhBUHrVMcxgXhuprY
	 W9I/DMA2KQKQzTpz72tdu8L1r2A14CJZetaAuFs/Il6QUFVwrF+goGZp68xu7x0FRClTu
	 9TU2z7qi/M+zFuJFpwgSIVbPfi9YRLEZqJn8DEBmkLv7DnfbZiIsLCE8vVdfMlKEA4uGM
	 0H+qrodFMPADJCTViYyVBmmLbnBO8uPyCISG+lXgSQoQYh6jWojLTsrWVoj3vRZSRww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382000;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cKpbO2VwwIoYVStWl9l79rH59JkxaSQ4kTzGGUx2j2M=;
	b=TA0UoF5bPGpaMICQaqqB/+yQpHKvY/BqVRW/rPzyjz+ats2+aJCjdVgrLyVADL1uGOmD
	 ZvUDHjSEiyH3Z9m3zJUSyovtXBNCQgzCFHx7jtK4wTAtrkiND9Vil08Binv/9//bxrAcb
	 SQ1KNV1KZsHgYXgDsr+h+BP6A9gqilwF6McMq4GVazxY1E7yjLQyDWp6KyxTz+J7NcUrO
	 bpMPfGIYlBRAd+nfzSlhIGfvKjuJxHNw/f27F5FMUc8g9iFYEBIBoNRM/fvFdQ9HPo75l
	 0QwJnJT00AF1OpQqGdAO7vKlcbBwPvDHhRcPtqBbf94J7xWml4msWvvtspzKtwrKyzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Oqkvyuo7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c8EgR1gb;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41B606A326
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E41B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Oqkvyuo7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c8EgR1gb
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F4641D0000F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:39:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 13:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793381999; x=
	1793468399; bh=cKpbO2VwwIoYVStWl9l79rH59JkxaSQ4kTzGGUx2j2M=; b=O
	qkvyuo7hxtAdwonkgktnmmaGQybgx7mEMUr33aj/0H6DLeW5de0BqLNB7/qzzIX4
	B9tCCbAf2PUyslrJ3NC3MXmkOF6CZkaiMhhi9wUkhM2qUDg7MFmq4d8ozeODc4il
	akGZWcoSZGINsolChK4YUHEppRJ4+SurkuxnZDUXD/WTzgtVF/SxfUoW0LeQcryV
	wVwwU6GHqPWWqHGGcFwLwg7nwi8hOinrCkAnsnpWWBTF7LNjjXbD/Y9jP4e7xImG
	G/gdejo8l7eRKeelgh8tHM3PmiegLrRtcyObsIiNwgvaWazj+VPergtYKQ6J0M5R
	hrko8gLOZIUbs/dIUzUmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793381999; x=1793468399; bh=cKpbO2VwwIoYVStWl9l79rH59Jkx
	aSQ4kTzGGUx2j2M=; b=c8EgR1gbqVx/i++TmHjPryrex85AwNwOmuLMlBAxIMtE
	GWJwxoGu6upMc7AABNjlToG8ZgjbIJ/WVvFvNyoeFjQid58D9BgyTy19MAEb+WJo
	yZyLobrUwRV4+sW8bGbhfY+z4H16d4gsPAjnnVXFsoiOGLpnN97FSzFfs6vecItD
	9tVK9LtyzojsaqVhQxRGfipSM2UEsGqMXX13rbMlxxeFunWLR1tpmvftOPbZcfeq
	lTKKeWCxdsspZhGTXTmv00Om03ciMNCS0O05bSjTs0MXg9rTiScErtcel6PiJIwN
	92AWHJByCsToY/5TkU0rFABpUZA2dYO8qlvQ1/HMrQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793381999; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:heFmdTJ5FshPYykFLl0+3s4ZweT6W1EqRrxQ52n8Pb3BD+4
	QZxilAXt8Se0dQJ8M420uj+w5aOtjBd74KrcBmwSVymgZ4tzEiJfzKtp/eS2wfEg
	xxSu3MNrKgEc2b/+rYbwRWwTQx7zDMCfuMFKyrnOg88YwyOM9RdrpQe1ruVT82Ux
	md3m39mrWsfKLHRD7nGnQyThQhnMQqiC1P0SdGRBl1sXxrwJNicnZAyOcmsIMPLP
	vxmaPx8bNBKQunAy3we3mMFY3SVxgWphmN8q4Gejr7i6LQ8Y/CMDjTAN77qJJNZB
	RgMrg6JtexHzmhh2MKByvIIQYsCKswumNftCjfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qiqkhapRgjCtiNeAemzVaOQlmfKF4mRaOiVop7hXymQ=:R31KjEsyPhyG8Z1n+2yGe6j7dboG1skv6+wF+8pisnk=;
X-ME-Sender: <xms:b9bkaqpNBZGChv7_At024OMfs2TwCThRGzKW8WsdayqudHKOTIVHFg>
    <xme:b9bkaupsVGDrwhrzKirqwej_MiVFYnV6HgetJTKKOfiL6RajqaKrL-3IZHx-zZYFu
    jgOG5DYQ4xVLON1ReoHzU4AH7VrY9urJxl2R_iFz553GYv9zCPKYdc>
X-ME-Received: <xmr:b9bkas2RzWXQnm0agv3AbdFMQkI-MmCy66sWp_1pa3YEy2b5SylR8rct7L3DmPtP7TWDQ3wcs-sUijWvEjmUCiLYyLoAQ3v1GWw7>
X-ME-Proxy-Cause: dmFkZTEMiwDQ4/XUbgiEUqCqUBxI97pFnIKaHZFSvtEPfojp1VKqsPkA4mJxkwnAv829YY
    FZeVHQaYNnK3aCbhW8e2vxdxTrzY4fmx8KmyiaXG/DiDaEKYjDAVQ78xQJeasUtje3dZPF
    28HwzUXacagj98UYUaQBcwHueWNziHk5zN86bLaphWfAqZyMTDYgqDu283o9CFVakhTGhG
    XTCvaJHoYzq4tHWDi6fVg7I0op79IMpB5PPN8lJguIcFOuGH8ELO5ELLINyrqzEuClGKAd
    fagg9Lf7eOJlOT1A4qSMO3RZql3pJmP1tzxAE5TRYnrpYHNE96/ECabGwqXwyizgWnVJgJ
    Ismj7grsGBbHGW6tYtfSPRrQ03gqa5HwDj28Q8VQVv3WgERxy50HZfBfDTP3zkeiYjIz2r
    7+lHe8qSeKwLoWbIo93sDUQY4c9cCRiz6rjxkh8Lro9Tpq1MX6iRjVL9Frqbq7TFIIYTfZ
    wZ0vwg9/RvZMGqZ7vTY5brgKi+KLW68lDRLCiuuMrsXX4XZV0Mpk9siOBzfsCFS88anGyF
    fQoraMl2cc2l63MSYxzTVIZzHToYnt5tfBhBGxuVDOLdQQ2dNGs8oBw7FYil6rfZGgCZUH
    kogDQDdzIIBqfsg6ZBvYX2cMfBBry5s6oWovXDPd1ax5E7d8dqfJ1/ABdrlA
X-ME-Proxy: <xmx:b9bkalCLW2DRqbzbN8eXcvF8PVrTPnwyXJ6qJ0MkQH9cwRHYObo5mA>
    <xmx:b9bkaseuqv1EqH3cWyOCib3aLsuZY95_K5ciBZNA5OOpNQBTxdfsHg>
    <xmx:b9bkaiggv6k3sVhX3N03_urPjILXnKCQTXjdsIu3nBZKO7SgSqYMNQ>
    <xmx:b9bkaspTuS1Ew3dqjmJh0zb1tQh9LRMWk22pyKSeA6AXHw6tK504CQ>
    <xmx:b9bkauB4dC4FSl06e2sEXH5OfKaATo3nmt-FtibGkCM7yg1S0lg1S1HA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:39:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] ident: remove unused author_ident_sufficiently_given()
Date: Fri, 30 Oct 2026 10:39:53 -0700
Message-ID: <20261030173956.585250-2-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-486-gd49ba3b80a
In-Reply-To: <20261030173956.585250-1-gitster@pobox.com>
References: <20261030173956.585250-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pair of functions {author,committer}_ident_sufficiently_given()
were created to replace user_ident_explicitly_given() in d6991ceedc
(ident: keep separate "explicit" flags for author and committer,
2012-11-14).

But author_ident_sufficiently_given() is never used in our history.
We only check if committer ident is sufficiently given and use it to
nudge the user to set user.{name,email} configuration variables.

Remove the unused author_ident_sufficiently_given() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 5 -----
 ident.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/ident.c b/ident.c
index 0b7aacecd7..eb73d073d8 100644
--- a/ident.c
+++ b/ident.c
@@ -602,11 +602,6 @@ int committer_ident_sufficiently_given(void)
 	return ident_is_sufficient(committer_ident_explicitly_given);
 }
 
-int author_ident_sufficiently_given(void)
-{
-	return ident_is_sufficient(author_ident_explicitly_given);
-}
-
 static int set_ident(const char *var, const char *value)
 {
 	if (!strcmp(var, "author.name")) {
diff --git a/ident.h b/ident.h
index 3c03403879..7e60e36415 100644
--- a/ident.h
+++ b/ident.h
@@ -60,7 +60,6 @@ const char *fmt_ident(const char *name, const char *email,
 const char *fmt_name(enum want_ident);
 
 int committer_ident_sufficiently_given(void);
-int author_ident_sufficiently_given(void);
 
 struct config_context;
 int git_ident_config(const char *, const char *, const struct config_context *,
-- 
2.56.0-486-gd49ba3b80a

