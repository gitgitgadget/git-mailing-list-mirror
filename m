Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131E403AFF
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679772; cv=none; b=MLlRlTu9ZH5WG+haJZ0wIPQHUikJcQmmL0WzwYzurl9nhUEoHXO2YwKXGV3mC1KL9kNnMbzFNjfPwe/69M+/wf/vvZbnKPliQ+bEpDbVuV5OTD5w83qaiSKXEwlJqv59oeX6yKlZBv0LmQCucVMzCCE9XbJyoNzNhWi0U7Kf7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679772; c=relaxed/simple;
	bh=aDGZAgiPAnCR24AX91QPuP5je8Er2D/BfEJohjoJ7fw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=am6m1zkRKJOaOvqquilH/WE6P7e4CxlZFclVTXFWhE0lMVbO5sxSmwJbVv4rH5WXd010ZCVfdOAltpjj44D1+3gzpRiHW+p7U+HCSASEaa8S9znxuIAE05CdH3wkb9YQV98Q53A6yzX/u5VfeOCE03Xd2neKRpELRzzPVUMMxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOc9gg7r; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOc9gg7r"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so5849536d6.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679769; x=1784284569; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aD7/I3d3oDMxysMD1EFRaadjTIyatIcX8hwBj+IBDC0=;
        b=dOc9gg7rf2f0dQTPu/L62TjGWBeIlJE9/1asOeLOOvpFpmkVa+z6wU81c6aHWUu4T5
         wuWz5G56pQeayw8xcAG1rKrrH0gQikIv0/Hv+df1brvl3R0VKjlc6gfL/DP17R1SeRHQ
         IW0cfzU4HxeIxkhRYKT8kcyiiMYeVQNnnc1ggRAB7GyGyKRgFobw1E6PYynu2AWSyrPl
         FogIdUTgyoiXRgMevoU0UOvY8B550RXWLnsbzhw3fO8PihnBFnYAA6UxuvPFyFXvktqy
         5B6Ud/6T1p9dyP8taJhcrinTBBvTB06e3cAHqNHEe5JMD5omn76wpkLk/1OcbKkwksP6
         O6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679769; x=1784284569;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aD7/I3d3oDMxysMD1EFRaadjTIyatIcX8hwBj+IBDC0=;
        b=Dt4AQPxFfJ7En6eDw9l4S8r9dDuQhvXM1EvK1hTIt3Hirjga0GLRfc57TIPcHlHkOA
         OMsnTng2+0URxZUG8tGg5HKksvtbjtB2yywyr/s+x1K6IMQAX9vgaVegSyfOESvRC0Sn
         gQ61zOFxkEo2fq7evUPG3haGJtTpzcyA4ZtEAI+SSfjSxUTMA6XolTNEVGj3D8jCVuY/
         69Lp5BXUlIeRm+252ke37SsLtOv3vONY16AJyJA7y27duqfmkIVgUxkvS1TVl8YXFHow
         u2JehYu3zFf0zTa54qn1O1Jc9TjkjOQ2piD68V4bsAC0EFuLB/YTHZ/U2/A7arXDNrvZ
         psZg==
X-Gm-Message-State: AOJu0YzTZO1iXnrPigYmbi+jvrKgzYlml13hwtACvd4sH00GCwkjK4fE
	O4AVACSulesUakLzQfmjkhBUkXVGXdPTfmINeLCWbkYnRMm4PRk0j+8mHNNUZw==
X-Gm-Gg: AfdE7clGWZKjuVG5j5V5SjudWi4g7nLVi444IM1dUw9gM24EDbcoDhrGp9YgOe8Quhu
	tOhgnj0eonD07/h5f/3j6Vpd535IBOBZkXc1Hy+JV7+M3vlyCSmOEPe3uLIoHD/BEm7V3LkSi46
	HaFjv7mBNezr/oNZk00IkUTwyEh8Wqw7n/W5XZJQpAz1BtXCxLHIelThMwy3B8uuDgKvK4w6hLH
	J2otxaOp9oskfpJ7t8GQWHI1EC1KO2xugO4kh3fbK0/J7UnHRXiWmu1MBIIjnjuS/PcppZyQXiW
	pdx9eb+BzsZUVZQs+cxgd7hMRGagtZrulJNPLnTCkuu74itp7JkhqRJAa51R+kz7B5PKfS+0q9j
	IzD/HXgr7Hxm0zfdOhR5cQ2dhuWYHhxZT6GKKkFh5URpaA9eubZRywqNQ0RDb0TTeARMPpDw8Qb
	2qkiIBxmtFHOYMxIEZJVbFLGUaVA==
X-Received: by 2002:a05:6214:2dc3:b0:8f0:65c7:3237 with SMTP id 6a1803df08f44-8fec02f1a14mr127331196d6.5.1783679769427;
        Fri, 10 Jul 2026 03:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.134.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea876sm38237536d6.40.2026.07.10.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:36:08 -0700 (PDT)
Message-Id: <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 10:36:05 +0000
Subject: [PATCH v3 0/2] reftable: fix quadratic behavior when re-creating deleted refs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>

This series fixes quadratic behavior in the reftable backend when many
tombstones are present. Any operation that seeks into a range containing
tombstones is affected, including ref lookups and D/F conflict checks.

The root cause is the merged iterator's suppress_deletions flag, which
silently consumes tombstone records in a tight internal loop. This prevents
higher-level code from checking iteration bounds until after all tombstones
have been scanned, making both refs_verify_refnames_available() and
reftable_backend_read_ref() O(n) per call in the presence of tombstones.

The fix makes suppress_deletions configurable via reftable_stack_options
(defaulting to off) and handles deletion records at each call site in the
reftable backend, where prefix and refname bounds are available. This lets
existing bounds checks terminate iteration early when encountering
tombstones past the relevant bound.

Downstream users of the reftable library (e.g. libgit2) can enable
suppress_deletions through the stack options to retain the previous
behavior.

The first patch adds a perf test (p1401) exercising two tombstone scenarios
with 8000 refs. The second patch is the optimization. Both p1401 tests go
from ~13s to ~0.2s with the fix.

Note that auto-compaction typically merges tombstones before they accumulate
to this degree, so the quadratic behavior may not show up in every workflow.
But the fix ensures correct time complexity regardless of compaction state,
and the change is fairly contained.

Changes since v2:

 * Add suppress_deletions to reftable_stack_options so downstream callers
   can control it at stack creation time (suggested by Patrick)

Changes since v1:

 * Keep suppress_deletions in the reftable library for downstream users;
   only stop setting it in stack.c
 * Broaden scope description to cover all readers, not just ref creation
 * Use separate repositories in perf test to avoid cross-scenario state
 * Drop correctness test (implicitly covered by t1400)

Previous discussion:
https://lore.kernel.org/git/20260701080014.GA3748390@coredump.intra.peff.net/

Kristofer Karlsson (2):
  t/perf: add perf test for ref tombstone scenarios
  reftable: fix quadratic behavior in the presence of tombstones

 refs/reftable-backend.c              | 54 ++++++++++++++++++++++------
 reftable/reftable-stack.h            |  2 ++
 reftable/stack.c                     |  2 +-
 t/perf/p1401-ref-store-tombstones.sh | 46 ++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 12 deletions(-)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2166%2Fspkrka%2Freftable-tombstone-perf-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2166/spkrka/reftable-tombstone-perf-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2166

Range-diff vs v2:

 1:  889d0d38bc = 1:  889d0d38bc t/perf: add perf test for ref tombstone scenarios
 2:  c13f15ddc2 ! 2:  4fdcec8440 reftable: fix quadratic behavior in the presence of tombstones
     @@ Commit message
             found", because the merged iterator skips the matching tombstone
             and searches for the next live record.
      
     -    Fix this by no longer setting suppress_deletions on the stack's
     -    merged table and instead handling deletion records at each call site
     -    in the reftable backend, where prefix and refname bounds are
     -    available.  Tombstones are now returned to callers, which skip them
     -    after their existing bounds checks.  This allows iteration to
     -    terminate as soon as a tombstone past the relevant bound is
     -    encountered.
     +    Fix this by making suppress_deletions configurable via
     +    reftable_stack_options instead of unconditionally enabling it.  Git
     +    no longer sets the flag, so tombstones are now returned to callers in
     +    the reftable backend, which skip them after their existing bounds
     +    checks.  This allows iteration to terminate as soon as a tombstone
     +    past the relevant bound is encountered.
      
     -    The suppress_deletions flag and its logic in the merged iterator are
     -    retained for downstream users of the reftable library (e.g. libgit2).
     +    Downstream users of the reftable library (e.g. libgit2) can still
     +    enable suppress_deletions through the stack options to retain the
     +    previous behavior.
      
          This also requires adding deletion checks to the log iteration paths,
          since suppress_deletions applied to both ref and log iterators.
      
     -    Both tests in p1401 go from ~14s to ~0.2s with this change.
     +    Both tests in p1401 go from ~13s to ~0.2s with this change.
      
          Reported-by: Jeff King <peff@peff.net>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
     @@ refs/reftable-backend.c: static int reftable_be_fsck(struct ref_store *ref_store
       		case REFTABLE_REF_VAL2: {
       			struct object_id oid;
      
     + ## reftable/reftable-stack.h ##
     +@@ reftable/reftable-stack.h: struct reftable_stack_options {
     + 	 */
     + 	void (*on_reload)(void *payload);
     + 	void *on_reload_payload;
     ++
     ++	int suppress_deletions;
     + };
     + 
     + /* open a new reftable stack. The tables along with the table list will be
     +
       ## reftable/stack.c ##
      @@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *st,
       	/* Update the stack to point to the new tables. */
       	if (st->merged)
       		reftable_merged_table_free(st->merged);
      -	new_merged->suppress_deletions = 1;
     ++	new_merged->suppress_deletions = st->opts.suppress_deletions;
       	st->merged = new_merged;
       
       	if (st->tables)

-- 
gitgitgadget
