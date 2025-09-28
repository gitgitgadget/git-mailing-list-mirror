Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EA19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097262; cv=none; b=fnK22jw76DNyqFcnu0H6zoOjL2TGloJmzs/uzoY/pGI3/GjRpcELrwEOnCBzmAAGpU1MsKmud4aYt8nq5MHMxpKgm1rRiwxmYKKh8QKvhtSPf/SBQkofQmXYcDjRq7IQtIR+Ic3CLZEC+t2Q9kseIIMrl2TCoYgOiE7c/kxejxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097262; c=relaxed/simple;
	bh=fxfPJdffrWsblaU75o0NyYPNBEVd3FzFYKqYt6/4bDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBBRsqrBIjeCWATCYsoZnBvSuj+Dn6d8YqWzlzX7F5II/IM+Xl7Wp8uhjlQCmW4x92qHjVGkIaKp8STt3neIgV02UMPUqjGMHuSEDtm4FrgWvtkMUCldDyYvd775LhNJiA81rEyqGSZXTGq5DYQKy1wxMa9keNjENKvkHIqlGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I+d4Hsxp; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I+d4Hsxp"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-62bbc95b4dfso3614149d50.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097260; x=1759702060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdJ6D5F277vooGFusEZrSrCqnuKugNjweyGhl7aMMdY=;
        b=I+d4HsxpvUQmcocjXXJn5Js97kEPdwVwZhy4uqyJ2VBCBmIByLZYao8jTe/a/iIp+V
         GhIcCSfkZDeAxqaptBZsnGxzZ/d39DAMnhWw7HcB5KIWNgCrZGMn6Hz0ESS4vL6EwOAk
         BJpjQ6unOgvDijFaniB+rvqnNxfYESBEYO/zi8++Os/wSgxOF3desQcI9hHullX3fIVQ
         Ca1vCfmyURQelYyrwaR2lYXOpzVZUayx0bSy/ZZ3HuAPHUzcZRdQEfGH/CM3Tk3c/j9E
         VCJUrAyI7gQ4/TZXU30Qb983Uz3z6TjhWUH79zYf7bI6WQaStG/rztmrVbaoDs4+ZYEY
         4Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097260; x=1759702060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdJ6D5F277vooGFusEZrSrCqnuKugNjweyGhl7aMMdY=;
        b=NXChaW+7A6swQggCNt+fYIsHICyqQPz1pkjdO/L/uAiSHJR96LUihZYK9YVkQDNLcH
         c51+6pFcrrgFkYplNHw5B6MKJRNr7/iRdrWFyx2VZ0mAFB6XhjsNLuspPwfxlxHslkpk
         7ogShZLqzApZcsKL3YGEVeHB69jU8vA/g5rNE9+ypQX6h2Ja1v+qxhG0xTZoFbl/Bc9a
         l12gK5zwcraxIw3Ga6Wc64bY6yujkdTENZzzUfRM4wgzNVY9U4jsos1Hz8QMiZNivXBE
         BdSRFxoEdv1O2ujYcqHZIVm2DMrh6A4xT02dnzknVWxppwcMPPXeuRYyNWYJVYmJc+aG
         RAuw==
X-Gm-Message-State: AOJu0Yx8iJ34Dl6vpZLvbsX7SP00dq83RpvK4jb9mHwhksmj0JkYMiAR
	SY0NiU0fC3Ry+TpUyLgYwqMCev1wwvA0LL0Qk2LVVL/N6Dsc+NjFFJERPcHA8PoR/KArtACtfnX
	sHBVRblk=
X-Gm-Gg: ASbGncu+vkjqUhYOWBoVJJ2TRE2phTtMswq2vXovZ9eIaG2WX0q9SkbVWdmeucNPueQ
	xwWuL0WALloA/NB2z1Mz5wtky+UyzO39PBETPXTRyn2ER1PVtgkr8MZm8IZCZz5p54cPgJAvIaf
	w893J6wsxfM+mRdvMaNf7pp4y5w+cLmaCiAqbyZkppWt4rA06KkY4q6q6Kuk4HlzBw0L1zqBqQQ
	Hrj4a+kzCrC/MH981+mc1NUkxt+XNPYMbxwwIBL1yds8kcVchiXd8/2OJ9Obl/uledvuBpbdD0m
	5e2R/mWHER0lHIvw4liHErVRUETStjm9pZtSAaWzQv1GB86BitzqPE7RisaJY8UFSEIO45Jf/0I
	99J6RFv4ap5yE+1vX/tPZD/mXL5Mq/9ZTAbr5yFp7kpNe1MAJTZXlD0b8EMAOrHdnJU1VH2YYOW
	fg8KKVjCrvCmnzPcOv941WNH+vEPXlho0AOKuU
X-Google-Smtp-Source: AGHT+IGn9/UQU6YMD+ywVwYaJXF50d21UmsHo1TLxXm41hZQHGRt/ix4NTGERJ1hsAd7fBwuqbiJ3g==
X-Received: by 2002:a05:690e:1610:b0:5fb:14bf:d7bc with SMTP id 956f58d0204a3-6361a6b137amr14649815d50.10.1759097259806;
        Sun, 28 Sep 2025 15:07:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38394e492sm2949277276.30.2025.09.28.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:39 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 07/49] builtin/repack.c: avoid "the_hash_algo" in
 `write_oid()`
Message-ID: <37a7dea848f9618f7243fd9ff8ed704adfb3cf4e.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

In a similar spirit as the previous commit, avoid referring directly to
"the_hash_algo" within builtin/repack.c::write_oid().

Unlike the previous commit, we are within a callback function, so must
introduce a new struct to pass additional data through its "data"
pointer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 094f5a0cc2..7d62959dc2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -339,6 +339,11 @@ static void prepare_pack_objects(struct child_process *cmd,
 	cmd->out = -1;
 }
 
+struct write_oid_context {
+	struct child_process *cmd;
+	const struct git_hash_algo *algop;
+};
+
 /*
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
@@ -347,14 +352,15 @@ static int write_oid(const struct object_id *oid,
 		     struct packed_git *pack UNUSED,
 		     uint32_t pos UNUSED, void *data)
 {
-	struct child_process *cmd = data;
+	struct write_oid_context *ctx = data;
+	struct child_process *cmd = ctx->cmd;
 
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
 	    write_in_full(cmd->in, "\n", 1) < 0)
 		die(_("failed to feed promisor objects to pack-objects"));
 	return 0;
@@ -413,6 +419,7 @@ static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
 				    struct string_list *names)
 {
+	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
@@ -427,7 +434,9 @@ static void repack_promisor_objects(struct repository *repo,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(repo, write_oid, &cmd,
+	ctx.cmd = &cmd;
+	ctx.algop = repo->hash_algo;
+	for_each_packed_object(repo, write_oid, &ctx,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
-- 
2.51.0.243.g16eca91f2c0

