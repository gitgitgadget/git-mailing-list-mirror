Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35613081AD
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567255; cv=none; b=iPTIX6oBOUI6IJdksjNU/ac1gG25IqMDtzLwDmTkOPLGON+WfIPCYiAjWa9pil7E/ZlJ8E504+WObFBDa3ZnfxDfpOhPF+iIGJ3GLSdBV5nzERg6WGJTcWTR2syJ8TGlftB/9yzC01NceFzrnWQ+5OiocSkmZBhk9VGMwObSXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567255; c=relaxed/simple;
	bh=9jriiT2oVPFc8S70ynov+XhVfZBmRKdx69VrCW0pmpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz/8H2ZcaXzcbVxNiazq5L6j0NLWVlsY4h0PxZuLzzajkeC+fqyfySeJAjl7AEg3HMynRSYx9caweh7l4WAHSwNDp9CCF6JppJBB8gflw60jlpVJ3Iwd+NOmjoG0ExkrppEGuWdE0buKjagRY4YtwJ3McReJMOaaEAK/5j5WSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EzVgvJl6; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EzVgvJl6"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-780fe73e339so511927b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567251; x=1761172051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2tF6q9E/9VOTR8c55yrMHBQUl9X9WmYz/wOqF2j1UU=;
        b=EzVgvJl6ptiy5RkhlRotqWizrYcmysYvJN+V1jk/8slQOFCIColQ8ZmblxQusDOrcb
         G+9A3fUwdwVuyBTD3anO8SacLwQFsjRsZKXqDuLm35lXn2On4M3Pt2CVyCpv9p4+j1Go
         1w0MDr0Ax0RxxnBvpVdqauBqr30SPOxHEsgD2lmGIrmtDvsYyr0KpH/sOUcDtSXxeOxA
         DY8BDW/yiKbEkKr+zf/hEWGvOVrqIKyzDIAXfRKIZqWKKWavkElrOKKquBy3/ar7jXiy
         JZvw9ud9DHxb42htawsWOoE2qm8Y5/KTph2Yt/C1xerad5xPH5RmERBNu4AkXkcuJvTO
         B2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567251; x=1761172051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2tF6q9E/9VOTR8c55yrMHBQUl9X9WmYz/wOqF2j1UU=;
        b=KIp//xvpqMHv9gswKTfTjwk97kG8e6V4syzJjcqOotEAZeNZzlg3OJYRZ0DnCFZ4kC
         eauyvko654doPF3xr19vfEGamCONV1y35wLrBOcj7u2JOtZy/J33izOz3WQq8+XDlm+i
         Bsvt8x2frPIHmwjAlghrdoAfjqbNTxHRyunM5fpZc5OQeK2oreX1KnKidm+gZxdbKuUy
         h6HqNn47Lldoj8oC6xF8pv3RLQTLeRBZUO47qTDjnY3/x/2KNznEPTAwDeMwPb7rRNVQ
         DJxmx17wiYWJ4SZzWzmiw/q884CuvgSxC0JqS+lStnQAQUlC6dCh14EPIQALciyfavpq
         cFZQ==
X-Gm-Message-State: AOJu0Yyh3zzlZVTp4PoOzXXqvnZdPAvbGf/ZhnR+mFjgVeup8GNLSxIy
	wWxLkBmLldJdQJTQddZUZkxLRtnv4cBhLSOhqeKtjRK9/0YIuH6gv6K5BlyNtOm1l95aWLkfRZw
	yKNB6s3ADHlUY
X-Gm-Gg: ASbGncu0uUAypqSVxKkcynAVcD16S1A+BS5Qyhk8VgqouXSJ2jDSDCIbzqMifpgAZjt
	S/aIiVgJZigZYIVu14qm/pY+n+ZthIYBxH+xMN/xv1bgPvoyBaemR2IwauYGIVMo502yBNXOUqJ
	fhNVDh7xrP+MhZeyck12pTA7v9s41gX1pOrzvW/r6vOcqak0foQwgnL0HbIA4pPZRm8a+6N22r1
	P/1kfbh0f3mx8OatbU2Lq2sj4HL3/K933wFaXu2YZpNcTbe0LkqQXnPLhM/hb+2ArLPa5A/BY+v
	g4kDQ9ujjCzPPOroJERq57CxXPD9PVVyoEJ0Uv4it0WXGCgrt2JtwJsCuslUKRK3KEMAw3jjyWo
	pk9KCrZzudVa/tD/Dvorwt8juYBr/nBoIWACI4Z891i7EZY6CxoGMpqIAIIpfD+k6VHN4s4mo1a
	DsORBWDfPtwk5u9B40K0aTOd8FlUTeCrDBVTxfcuKEhEaraPZawhBsIB/qrCqv9mNRRVPGowiHf
	keyuOs=
X-Google-Smtp-Source: AGHT+IGjKRrjsP+DMiJ/4vmHB2Funs8N076qGHoafzdOa+2t8U9F6V4cAlmU/31dTevRvj+pcyyxHQ==
X-Received: by 2002:a05:690c:67c6:b0:738:a712:6972 with SMTP id 00721157ae682-78269f40477mr17166247b3.12.1760567251527;
        Wed, 15 Oct 2025 15:27:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d3bfa7dsm2739487b3.20.2025.10.15.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:31 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/49] builtin/repack.c: avoid "the_repository" when
 repacking promisor objects
Message-ID: <0914ca113ff179bbf824c026fe1c0463a5acb7f1.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Pass a "struct repository" pointer to the 'repack_promisor_objects()'
function to avoid using "the_repository".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 93802531e1..4f08b57ddb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -407,7 +407,8 @@ static int has_pack_ext(const struct generated_pack_data *data,
 	BUG("unknown pack extension: '%s'", ext);
 }
 
-static void repack_promisor_objects(const struct pack_objects_args *args,
+static void repack_promisor_objects(struct repository *repo,
+				    const struct pack_objects_args *args,
 				    struct string_list *names)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -424,7 +425,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(the_repository, write_oid, &cmd,
+	for_each_packed_object(repo, write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
@@ -1458,7 +1459,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(&po_args, &names);
+		repack_promisor_objects(repo, &po_args, &names);
 
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&
-- 
2.51.0.540.ga7423965ad8

