Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A6331ED7
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034891; cv=none; b=kQl62Zl6THEEKjkwAAUzz1/g3/Z9WSnxhjv578tHApUlQ7QO+N59cdmbsOVB2D4LMHZVrVJPCYlHwcN6LHGVuCkUwGCA8oq4eFv8LBthGCXm0USW5CpBKZLtI96BRCMD6YrcaX7Mq/BFpY7/ucW1kJnv/hUbUFRUPxU2RttZLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034891; c=relaxed/simple;
	bh=o+KPM3xq1HmQF6+JqWERIb1wakKPLslB+FDxKe4XEx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3UgeUL+2KDMa37dvk/X8frZqeq0GYudfrL7XisHT8IsNcGnzex/HG4peohp9fMSwhprOOhdtc9Tu85nUyvU3Hx0GV4/dKCWbxBk4ee11EIhGly6Oa6MwrM0MK8cPfSOWYCW9lCPPAwmc+GtQLhAMvW+mBvvGY0GiBQRr2FVOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=fxcDQ67b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fboag7NG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="fxcDQ67b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fboag7NG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB9BF1400040
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 09:41:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 03 Oct 2026 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791034888; x=
	1791121288; bh=FRwOlxPn0E63vRp0ha3OAG/BBnPl1ALg+O9tjcNwUPU=; b=f
	xcDQ67bPmtE3LhAU56Vv5Eke55uX4qgQYd8/6kGXqUxuF2Rs0nr7Sblo+dUbU/PB
	k1QYuh/j3Vd9uACYX5hfTiV5psKEqvqVgkyG+wuQNIWYDCJ5djgXAQK35ME5ikKp
	9hnY4WDmHKaOBTGc6sOf+GaDtUP0XrftlOOC3gYIpLRNykDxEECyb8WAtSxcIou3
	Lg6v7wdTsSK3jJf4QvG8zyWMxlVpr4t30FIwZ7Acrkf9p52pP+OQILV7yXqi/tqt
	7rAVc4wUsI89/AIb8LGR6SSSHCxrfQXPv6v1loXcy/2rRjEqUx/htFcZDMi2dP7+
	SYJVGlcVrr1YAi90IXlOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791034888; x=1791121288; bh=F
	RwOlxPn0E63vRp0ha3OAG/BBnPl1ALg+O9tjcNwUPU=; b=Fboag7NGrgNtOzGcO
	JdYNPNehBg03ZH//htZiB2txRYDW68NhwCowMV+jcAraqn550qOrMyOTmmmcELAH
	qVWUpAn0IXmmUjQkoAk+hmwqTOm+CcGJsUhGV8GAHsCnBVG+oyBos2nIg3sClxUw
	2LUG1LgCdj7Bl1ODDipamhA19iosM0wHvb+b2k4j46B106QlkdScbyOan+2RuPs5
	Yxn9y0JvtSTG4NgEnE87ibbs9jVj8MbGGa7aUqumkx8FiYYbE/tPPnOoPli/Y6x7
	fJrrbSalYzouG5jQtwIXenRxmtrYTZ6uHtZB7ipH5YY8GfGWspamh4pQHfOlPMUs
	kQCcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791034888; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oJ8M65MWfuBOou7UVIA2pcUtgmIiuny0AKb50omKZ9tu2b1
	/5zEe0iplSkZjJUie9L126EVdm8JhR9Y5z9YSG8dPrwwUYDdp1jT7a9aFD/IsoS6
	2ZwHnUJxCjT5ZwpGM/oUgl52MKXU48Igy9RXXbA/QepUYv3ufpC9cWMBZIIn8baq
	RiIKeTCTcq5biOuA6PuTsqX0RWyno+GNtJtz3d3LyuOFc7WvIDQmgazt0q/m14xC
	NOWAyI6/C6YBpSfDSZpxqpJc8H0d71wytn1FZ7/R5xnugcAU7gPkdp5Y2P+P/lJw
	Bo8zx6MLWT76mSUg7qQhYNJ8tDGZlR1aiGIoVVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xEelB3/Y8ho4gv/vQUbhIoLnGaxjUjLoVsmXcCGecOE=:o+KPM3xq1HmQF6+JqWERIb1wakKPLslB+FDxKe4XEx0=;
X-ME-Sender: <xms:CAbBar79lXvgMK2bkZ12F1fers-KMQkX3BYpQ4PgA7DqPs2qIMp8Hg>
    <xme:CAbBan5-LHOMRCbCIvtf_IDSpED-VCQT33I0aoDdOPZdeIc3bdaY3cEeW9QbXRu3b
    fx9h4cAY0GIl7fwRp2UDLSabzpQ2z-BlCiSHACPsqSgn-FjSKsKysX3>
X-ME-Received: <xmr:CAbBancdqVG8oa1oG2_edYFKxk-CV04jwI-kD36RrGr15_ubZ0Ltfow_VLP69iCbCH9JXJMDvvYbSLpwskWe_d486E4Wo8mpmEbpkPFOjTw>
X-ME-Proxy-Cause: dmFkZTEOeC8kwRILiVjK/UYpCStXnnHQi/ufv/zo99gpz4aRFhpDLFRmf357u/EPpi4E91
    y2yoUIsgZ1j7/X3EppQ8948OxgwANuoJTHHdIj6Q89MciqLQV6a5EbcHM7sM1DNje9XBmT
    aEjUe25Bv17nuZEiIrli0J9OYhezIAb6fJrkNK8jwmlvDhdESEAlFc+/9npuWEkfdsZ3GO
    p0xnTc3VzHSkdQ2HPHji95s/JxRYR6ynPBk0M4JdPfpPQ+nacVBpw7XvxIjjbBJc0M6Aem
    dW2XOqCsZlkWe48ZVMM4R7fEnmEPyZvHc/Y/gGvj5JItfh1PtChTtfInHF2cwPBRXiK6Sq
    hL3LDk4GKFA92wisbQnVLF0o55aI7Hnkrd9jqIw3kLjDLJhvj81tiv832G2U9a4gYIYIah
    42LDEzxSY5xzNSQb7fxguunI53D+YMCtvqwv3lSocbaoNtpJyYqBHm093la0QvMYiz3GYN
    XpmfvFzQXxikI3w1awDQlFqtaWRnUDFstpZnwea0M3vhtBIlDzGTpyG8PwNIGsXXL5PqDf
    5CBbGBaEXUA4g5WBrU5Nsu1BA9QwV06/qfKJ3aEVnmWJjn7efBxCawda8qEX+q/PGPf0Re
    BoRgOD/4s28tuSsxe8kio/8qAiNrNDmDfIpjheK6jjdX098dbJUif2AvtfoQ
X-ME-Proxy: <xmx:CAbBarCDTupqkMM5X9bzf7nuJyGIgPi2K5Cr9Y1mjBeKCQ0hlJgplw>
    <xmx:CAbBaq9nPwE-0gitk9ynpx4p7ZvkM9NjFCFiP8Jg9zmD3nvVui_Adg>
    <xmx:CAbBamKtECUGbM-fl9tBxyeIYXWOg5W0z1VRRtuf8e1M5l_DEwH42g>
    <xmx:CAbBajjyIh41Q_0IIEUsEHAOkadPIa1A_4vjoURVQE6gg5Qlpki5Nw>
    <xmx:CAbBanwqJaTYbaY6DJdvpAfkY4bmYM2H48K1E89LOGFmjkJkgwqjWK7W>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 09:41:26 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v5 1/2] replay: allow callers to sign commits
Date: Sat,  3 Oct 2026 22:40:57 +0900
Message-ID: <20261003134058.23494-2-git@5ouma.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a signing-key option to replay_revisions_options and pass it to
commit_tree_extended() when creating replayed commits.

This provides the replay infrastructure for history commands to sign
replayed descendants.

Signed-off-by: Souma <git@5ouma.me>
---
 replay.c | 13 ++++++++-----
 replay.h |  6 ++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/replay.c b/replay.c
index f415103023..3e8a70bce1 100644
--- a/replay.c
+++ b/replay.c
@@ -85,13 +85,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -288,7 +288,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
@@ -361,7 +362,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode,
+					    sign_commit);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -481,7 +483,8 @@ int replay_revisions(struct rev_info *revs,
 
 			last_commit = pick_regular_commit(revs->repo, commit, base,
 							  &merge_opt, &result,
-							  mode, opts->empty);
+							  mode, opts->empty,
+							  opts->sign_commit);
 		}
 
 		if (!last_commit)
diff --git a/replay.h b/replay.h
index 2c71afbfde..2eb7704b74 100644
--- a/replay.h
+++ b/replay.h
@@ -57,6 +57,12 @@ struct replay_revisions_options {
 	 */
 	int contained;
 
+	/*
+	 * Key used to sign newly-created commits. An empty string requests the
+	 * default configured signing key, and NULL disables signing.
+	 */
+	const char *sign_commit;
+
 	/*
 	 * Controls what to do when a replayed commit becomes empty.
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
-- 
2.56.0

