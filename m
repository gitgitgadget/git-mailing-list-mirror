Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A63AFD03
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206283; cv=none; b=TwsEQJkAzwIhqVtt5ClL/U7ymwjXqrVfsmsrBIPScxILiqDFPBKDOZzgBcePYbZ5czTAEk9J6mskINGy4BsH2MoRFCZe/M4eV5le50AZmiGAPk4xuKe9joKeVjkXs0gX/Dj2uJ1dONew2OUUUB6ny7LEeSI3dvo9MHkDXzrEH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206283; c=relaxed/simple;
	bh=9rkXGx9UOjnFCC/RZhrBFmyhqaLVy0FgxF76Ta6ZUeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Mp+BxuYKvfkAysyz34vwE81hQi4MTkwRHfl76xy1Jvv4gWGmNB0pba3ozhLB0/mct7lLbn3Gh/AZIIjGlnKfE2GrPP33TPwDg0obdP+RjwSDtleUiTi9Qwttt3X3BxC25jO8EKujGlqvU5bqjqa8A1HDZgC62KtdZj5UDSJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QCM/pdvs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QCM/pdvs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b41fdf9de2so24349807b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206279; x=1779811079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO1qfmjNUyAZAxudWL3z09AGcE2UhnrBGT/UIwI0Vh8=;
        b=QCM/pdvsIbOQF0bcOmEf01PVOBFEl/U7jc8vl6KAqqNBmHn/BNbDYDWz8yus++8F7I
         LlI1aPvd+APGvIgorsFTFwTsdFYGOBJdhlzhWj8kBqat4Lbh9cnjOH6R9RF3QjyLOlwZ
         lFibN/v4ZDXRncyY/2ud1bq1XrTKT1DmRUFCTK5Un6RJXyMXAGgShoVqdG8rQ+xDayej
         0c5BhFu/WyhPgOezqqBMPR+PluW/sb7z/hNSxd+xxQH8AL2HFh0PDenW80Z26x98z1U+
         7ACn67XPns1Jhi7GQIjDuOPN7SKQgbIZ0qF8zqIAs9V25VS6VWQ+8rsd7V8cXMeEJbXT
         9Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206279; x=1779811079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO1qfmjNUyAZAxudWL3z09AGcE2UhnrBGT/UIwI0Vh8=;
        b=W6QwFUtMffUhR2GbXYfIQR/NLhPIawUS7TNCOhP0JlaDbR2ODmQf63Ah3BM66xbVUh
         iIgyMAbvnHKXniwrFEZDUQRIbNdW3LSxZoeW6d/ESPvv4W5is/uEA3KfdkwtchsuhDwS
         pGbNp6FsJrObIz7ssIpOah4u6hxdWr+qIqGiCRXralgkDkDgIhGxY6NFK9WKcqmZ1VRo
         yIiD5XXYHcZHeQKNSGskmtqgyumHFCHo4XkTOrwKCsWv+kY5ms+c2NK81pD2DbRWrFoY
         Hj4ClkQOKgFMeCxXPeb2bsxuDFPzwqVsK6zzvRkq2HPct3lZo5p5osCMn3Q7zZphT9Vu
         BedQ==
X-Gm-Message-State: AOJu0YyhMqYA5rf2uG8F71gDNcomtsCOlyemCvyIFiJx46NjFIAJxf1e
	8FDd1eEwZj39Lgu4DP5f56In15S8rIwTat+RwuvVaSs9fnV7hVvissj5SYpJKIViwGKiyc4YNq/
	zdA0/G3cNqg==
X-Gm-Gg: Acq92OFrPrO83c14L6k/+BmQYx2TKwwrdbplw6nwYjRjqP2hN/uVMZqeIRNVhw7Qrjz
	TRLEVMXabtg6t8PCRt3iGMnRCWhx1hDZCfgkXfEYz511neqfmygAJZPrgheURqIk6A2+IMtyCxa
	RLSQp7ih6XYUsxjaE7kGQfWGC+uAoAWpYqbdBTX7fmTI60LZlBMIBDpIVMYDumL+at2tUMdZZv/
	/2jZmYRAbVv8hWTQzr+IVZhwU//tmPyqGH7GyIvTthAvqTJqQ+3cD7nsGZaqJani3El3va6G4hr
	mYWr2IRMafzFBJTkBgALKH6oKABqLBHQWgqv0Ro1cP9ilMZ//SXtxZ8KklI4GQC2RxxkG1LQY84
	NJ2cTddVCzi4Tv8sW92Dwtn5eTzp/r2ioXA9UR4EIJWPztiGY4P/uoVLEhOFnmbwl45VbLqrE+g
	pHaA7S/lyUWsesOyFEZKGcHz4qhp5HF6wvXDp+10NCyLbypK8V11KLXb+pGGoq68lMzOE0BoIV0
	hZlyM0PvS264yg7LzcObkuWGkysi2k6hm2yOJ5H1zSqVPgIIWCTbOd6+xNF3rZ4K3JEgIJV6twg
	nBQT2QBO0lTRO3C9
X-Received: by 2002:a05:690c:3489:b0:7b2:aabd:535b with SMTP id 00721157ae682-7c95b8275bemr223350477b3.27.1779206279174;
        Tue, 19 May 2026 08:57:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c97absm39243847b3.8.2026.05.19.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:58 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 07/16] repack: track the ODB source via existing_packs
Message-ID: <4a93adb3ad3f2d408c03db885c698fbcbf39d109.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

Store the ODB source in the `existing_packs` struct and use that in
place of the raw `repo->objects->sources` access within `cmd_repack()`.

The source used is still assigned from the first source in the list, so
there are no functional changes in this commit. The changes instead
serve two purposes (one immediate, one not):

 - The incremental MIDX-based repacking machinery will need to know what
   source is being used to read the existing MIDX/chain (should one
   exist).

 - In the future, if "git repack" is taught how to operate on other
   object sources, this field will serve as the authoritative value for
   that source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 ++---
 repack.c         | 2 ++
 repack.h         | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4c5a82c2c8d..24be147d39a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -417,7 +417,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(repo->objects->sources))
+		if (!get_multi_pack_index(existing.source))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -564,8 +564,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo->objects->sources,
-				NULL, NULL, flags);
+		write_midx_file(existing.source, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/repack.c b/repack.c
index 596841027af..2ee6b51420a 100644
--- a/repack.c
+++ b/repack.c
@@ -154,6 +154,8 @@ void existing_packs_collect(struct existing_packs *existing,
 			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
+	existing->source = existing->repo->objects->sources;
+
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
diff --git a/repack.h b/repack.h
index bc9f2e1a5de..c0e9f0ca647 100644
--- a/repack.h
+++ b/repack.h
@@ -56,6 +56,7 @@ struct packed_git;
 
 struct existing_packs {
 	struct repository *repo;
+	struct odb_source *source;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
-- 
2.54.0.175.g8bd0ec98dc3

