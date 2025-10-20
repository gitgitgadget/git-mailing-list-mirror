Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEE238D32
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948321; cv=none; b=puRaifr/A369Vmp9A9FOaRr48/rpuQg/tAVvVC96yS/IxDERr1GezQYEA1ljJPbie0xuvQgw1357hD/YZF7sRK7oE9pwB3IF6NCJPq1aX6F6RbRrtpkT8FwhzJ2cDh2FfB6PqRFky9KWe6K6hTnc1Jib2BOJkXV1SiMoOxqWzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948321; c=relaxed/simple;
	bh=0gQPHEGkLKH2ZqmKUPYRQ5A/K7dPESiAYfhLJVJNEwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EHZyLL2cY8F/XfrO7BVHlehA3rqBGd3ZHhCnch4LEYJiQpd1quCsqIPL0ZXbGDh2TnnctBv8fnu95Y77GoICko+zlpnOpJjcXITcr8j+WP++UWPpmV2zK/RIM2vjvK7UgF1uFhb1zX9U/Uj2roWIxY3mms8Bf7MzbXgv81AdHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF9A3dT8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF9A3dT8"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deaef9so799507266b.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948318; x=1761553118; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNtjJ1k7znFwge/aadf6NXHCU+6T2CiHONXmegXkJsE=;
        b=eF9A3dT8nUBsK0vdmwd5Gfg5CdEdgTa39BfHpaekudO5r2kzFwzaA+ea/oNY1Unhim
         eCLw4mG2kDqxwVu5P+M8jCotDGq1UJdR334ZhGTS4beDqRA5pqn9i7m2CJjDNpLZbivb
         R8ij+YEhQQL6ANtOj1qFvzjsUkwORIZfgDGSaAvegODavBWblHGN5/Uq85jF0gzqooeh
         gS77YHkMzt5tO9YVcHe5TbezmzdQTOXX/l+6t7dAl2TJzRoCweh69BkLbrYqt5mPG04f
         cu42DjgqEhrwFJmLLJ13NB72wyvkLGwYoPzz8mN/tH1mY41pxr5gKJTmtVVM/jPEi73E
         cyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948318; x=1761553118;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNtjJ1k7znFwge/aadf6NXHCU+6T2CiHONXmegXkJsE=;
        b=urGUepqTCUsaZs1B+R0G2aHBV1+7X1Go/e/QL/0BijYZbedm2gKsgsUIGXhfGph/Cf
         IB/4RQkIAThg7KTJVK8tLL4OgBX/YFFFaAmApY8r4puRAPq2j9YUAh/TpoU6lo+LzvvM
         N3h/4MzJOGZOhVMbDQf6xrOqSbutEupKPYHU/FcE8F/KeOY2fDpoF8d0nG/hb3OOrf1i
         Xm1vXl3q6qcjYZX9A0rMZQHvoD2pxhpQGi9KNsXoUJmex9EM6EBeMgWDpl5t7Ig8myHS
         UIjEJa2zRJqJBrg4N52mRID2NOv61DEGzuCZIVveGYNQUkl+gg6jxVlp2gO/WND9Fl3j
         wVkg==
X-Gm-Message-State: AOJu0YwuyQ0nTSSASG6sjWe8EB+YTwUjw5z4z5xXz0C0l3C7np9atLa6
	dZcn5L/9yzHs4E9CNG+A/UMwBhtcWebh/5vVUR7nP4xUuw7NBZY7ZB2w6oGqDZf6
X-Gm-Gg: ASbGncueAzQHindH+VwqU1w7f5/6eKimCjysTaF6hroR5yVOhWLxTJxVQ14dlgE58Ih
	96rEWuuPZU4PNM7Z5J/LbbnQbpSuiHXbtkNtUT6YA+VSwOJCYk2bBOrM13Binj6BLN3/MOrHzFS
	UT80rM3e5o5Ikyy4qZ74r+BPKeEgpIlDWDE6aQOyfeZCKJYnzDYeeeIPs+OkYg4fqpW9KtWCt+g
	E+9zSpFWsE4u08koWZOz+LzD54a4/1djik7FeDb8XxxlCA6XG8LqL+nEmqUX5x6oZCsG3RkXNIZ
	6C69twkZDxFzjlxxC+TI+GDLQJyKW1sbxrLcma84CDbt3OlpKqDubSB8nV00oov2KzBucWtUr+8
	anZQp7xIcnbAeVASdZpROtw9fwtGWbSXZaGfxYKXH/Hlgk8pbnqwCJiMrZusVJQowO7qxrQyvq6
	yDWAfqzzNS
X-Google-Smtp-Source: AGHT+IE38zYF16Bn+GuTqJ63XX/LqUeR+7xhe4ty502ATZMdrbsVN66miULI36vtZsX3he8Kg59vwg==
X-Received: by 2002:a17:906:2acc:b0:b6c:d50:f8b0 with SMTP id a640c23a62f3a-b6c0d510442mr3089766b.51.1760948317463;
        Mon, 20 Oct 2025 01:18:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5fd9:4a3c:9f89:6c65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42bc5sm716186066b.76.2025.10.20.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/3] refs: cleanup code around optimizations
Date: Mon, 20 Oct 2025 10:18:28 +0200
Message-Id: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXw9WgC/32NQQ7CIBBFr9LM2jGAEhpX3qPpAmHaTtKWBpRoG
 u4u9gAu38//7++QKDIluDU7RMqcOKwV1KkBN9l1JGRfGZRQWgqpMdKQ0AVP6Gay62vD1khrHBn
 Xeg91t9UKvw9n11eeOD1D/BwXWf7Sf7YsUaDWYvC+tZfHVd7HxfJ8dmGBvpTyBV4k0oqyAAAA
X-Change-ID: 20251015-refs-code-cleanup-871a7ce7c8dd
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9950; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0gQPHEGkLKH2ZqmKUPYRQ5A/K7dPESiAYfhLJVJNEwc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGj18FlGhagGsilRYXO6FlSL0KgXkGjiIndGV
 5joFKaRZEBR0YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo9fBZAAoJED7VnySO
 Rox/UIQL/1XTSKOShISwRLtNL8yZEiBq3hp3xjRlEc2eBkbUxicWjH4/dl7k/Y3a9LNd9WnV5ff
 QREAY2ExwvqoDCd7hejDS55H7pFAYxFkCRwB6wtCzdniCmvn7+C8xYFT29EOAOE5ETz46ijc7F8
 774+LoHv4xWJf5HQA9+OR4Fds6YnieXT4I95V9YnfvuEPNJfhvDAuqFE38oiXN0COJD4c7AIazm
 /2XPb1qfJhCdMEEKx8XLo/9InXrQPr1a2R/0YjGucuTWWvjdMn8aRFLKVWJrftlfdVTWgIM6iyZ
 YqnGV3G5H/PBOupC10Po+PoYV9Vp5tc9Kd722QBCh+4JjXHVDm0aB4Uv58oAPalvbCW6KjDLFQR
 8FpaBC2XQDG7pT9w8wq7BOUsJGAceVR2Y8bZONyrjngtuf5H3IZu0yZXAFVUtA5a1NyVGl0po55
 9KxBSltv5pZqc0T5dB2ph+dU2QfcO1CQIE/RtVX5UUkvIJxjHWrROx6HrnniPGs03XqylyRzxh5
 Wg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is extracted from a recent series I sent [1], which I've since
dropped to follow up with a different approach. I think these patches
hold value individually.

They mostly cleanup code around 'git refs optimize' which was added
recently in db0babf9b2 (Merge branch 'ms/refs-optimize', 2025-10-02).
The code in the refs subsystem contains both 'pack-refs' and 'optimize'
functions, which are one and the same.

This series unifies this to only retain the 'optimize' functions and
naming, since it backend generic.

This is based on top of master 143f58ef75 (Sync with Git 2.51.1,
2025-10-15) with 'ps/ref-peeled-tags' merged in.

[1]: 20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Squash the second commit into the first.
- Change some variable names to also no longer refer to pack_refs.
- Fix commit messages.
- Link to v1: https://lore.kernel.org/r/20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com

---
 pack-refs.c                   | 20 ++++++++++----------
 refs.c                        |  8 +-------
 refs.h                        | 24 +++++++++---------------
 refs/debug.c                  |  8 ++++----
 refs/files-backend.c          | 22 ++++++----------------
 refs/packed-backend.c         |  6 +++---
 refs/refs-internal.h          |  5 +----
 refs/reftable-backend.c       | 15 ++++-----------
 t/pack-refs-tests.sh          |  2 --
 t/t0601-reffiles-pack-refs.sh |  2 ++
 t/t1463-refs-optimize.sh      |  2 ++
 11 files changed, 42 insertions(+), 72 deletions(-)

Karthik Nayak (3):
      refs: move to using the '.optimize' functions
      refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
      t/pack-refs-tests: move the 'test_done' to callees

Range-diff versus v1:

1:  ded0c04d60 ! 1:  fa153f2552 refs: move to using the '.optimize' functions
    @@ Metadata
      ## Commit message ##
         refs: move to using the '.optimize' functions
     
    -    The `struct ref_store` variable, exposes two ways to optimize a reftable
    +    The `struct ref_store` variable exposes two ways to optimize a reftable
         backend:
     
           1. pack_refs
    @@ Commit message
         latter is more generic and covers all backends. While the naming is
         different, both of these functions perform the same functionality.
     
    -    In the following commit, we will consolidate this code to only maintain
    -    the 'optimize' functions. In preparation, modify the backends so that
    -    they exclusively implement the `optimize` callback, only. All users of
    -    the refs subsystem already use the 'optimize' function so there is no
    -    changes needed on the callee side.
    +    Consolidate this code to only maintain the 'optimize' functions. Do this
    +    by modifying the backends so that they exclusively implement the
    +    `optimize` callback, only. All users of the refs subsystem already use
    +    the 'optimize' function so there is no changes needed on the callee
    +    side. Finally, cleanup all references to the 'pack_refs' field of the
    +    structure and code around it.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    + ## refs.c ##
    +@@ refs.c: void base_ref_store_init(struct ref_store *refs, struct repository *repo,
    + 	refs->gitdir = xstrdup(path);
    + }
    + 
    +-/* backend functions */
    +-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
    +-{
    +-	return refs->be->pack_refs(refs, opts);
    +-}
    +-
    + int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
    + {
    + 	return refs->be->optimize(refs, opts);
    +
    + ## refs.h ##
    +@@ refs.h: struct pack_refs_opts {
    + 	struct string_list *includes;
    + };
    + 
    +-/*
    +- * Write a packed-refs file for the current repository.
    +- * flags: Combination of the above PACK_REFS_* flags.
    +- */
    +-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
    +-
    + /*
    +  * Optimize the ref store. The exact behavior is up to the backend.
    +  * For the files backend, this is equivalent to packing refs.
    +
      ## refs/debug.c ##
     @@ refs/debug.c: static int debug_transaction_abort(struct ref_store *refs,
      	return res;
    @@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
      	.copy_ref = NULL,
      
     
    + ## refs/refs-internal.h ##
    +@@ refs/refs-internal.h: typedef int ref_transaction_commit_fn(struct ref_store *refs,
    + 				      struct ref_transaction *transaction,
    + 				      struct strbuf *err);
    + 
    +-typedef int pack_refs_fn(struct ref_store *ref_store,
    +-			 struct pack_refs_opts *opts);
    + typedef int optimize_fn(struct ref_store *ref_store,
    + 			struct pack_refs_opts *opts);
    + typedef int rename_ref_fn(struct ref_store *ref_store,
    +@@ refs/refs-internal.h: struct ref_storage_be {
    + 	ref_transaction_finish_fn *transaction_finish;
    + 	ref_transaction_abort_fn *transaction_abort;
    + 
    +-	pack_refs_fn *pack_refs;
    + 	optimize_fn *optimize;
    + 	rename_ref_fn *rename_ref;
    + 	copy_ref_fn *copy_ref;
    +
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
      	return ret;
2:  7670a662af < -:  ---------- refs: cleanup code around optimization
3:  ad2c55175e ! 2:  16e8ec5501 refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
    @@ pack-refs.c: int pack_refs_core(int argc,
      	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
      	struct string_list included_refs = STRING_LIST_INIT_NODUP;
     -	struct pack_refs_opts pack_refs_opts = {
    -+	struct refs_optimize_opts pack_refs_opts = {
    ++	struct refs_optimize_opts optimize_opts = {
      		.exclusions = &excludes,
      		.includes = &included_refs,
     -		.flags = PACK_REFS_PRUNE,
    @@ pack-refs.c: int pack_refs_core(int argc,
      		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
     -		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
     -		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
    -+		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
    -+		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
    - 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
    +-		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
    ++		OPT_BIT(0, "prune", &optimize_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
    ++		OPT_BIT(0, "auto", &optimize_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
    ++		OPT_STRING_LIST(0, "include", optimize_opts.includes, N_("pattern"),
      			N_("references to include")),
      		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
    + 			N_("references to exclude")),
    +@@ pack-refs.c: int pack_refs_core(int argc,
    + 		usage_with_options(usage_opts, opts);
    + 
    + 	for_each_string_list_item(item, &option_excluded_refs)
    +-		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
    ++		add_ref_exclusion(optimize_opts.exclusions, item->string);
    + 
    + 	if (pack_all)
    +-		string_list_append(pack_refs_opts.includes, "*");
    ++		string_list_append(optimize_opts.includes, "*");
    + 
    +-	if (!pack_refs_opts.includes->nr)
    +-		string_list_append(pack_refs_opts.includes, "refs/tags/*");
    ++	if (!optimize_opts.includes->nr)
    ++		string_list_append(optimize_opts.includes, "refs/tags/*");
    + 
    +-	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
    ++	ret = refs_optimize(get_main_ref_store(repo), &optimize_opts);
    + 
    + 	clear_ref_exclusions(&excludes);
    + 	string_list_clear(&included_refs, 0);
     
      ## refs.c ##
     @@ refs.c: void base_ref_store_init(struct ref_store *refs, struct repository *repo,
    @@ refs.c: void base_ref_store_init(struct ref_store *refs, struct repository *repo
     
      ## refs.h ##
     @@ refs.h: void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
    + 				const struct string_list *refnames);
      
      /*
    -  * Flags for controlling behaviour of refs_optimize()
    +- * Flags for controlling behaviour of pack_refs()
     - * PACK_REFS_PRUNE: Prune loose refs after packing
     - * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
     - *                 result are decided by the ref backend. Backends may ignore
     - *                 this flag and fall back to a normal repack.
    ++ * Flags for controlling behaviour of refs_optimize()
     + * REFS_OPTIMIZE_PRUNE: Prune loose refs after packing
     + * REFS_OPTIMIZE_AUTO: Pack refs on a best effort basis. The heuristics and end
     + *                     result are decided by the ref backend. Backends may ignore
    @@ refs/packed-backend.c: static int packed_transaction_finish(struct ref_store *re
      
      static int packed_optimize(struct ref_store *ref_store UNUSED,
     -			   struct pack_refs_opts *pack_opts UNUSED)
    -+			   struct refs_optimize_opts *pack_opts UNUSED)
    ++			   struct refs_optimize_opts *opts UNUSED)
      {
      	/*
      	 * Packed refs are already packed. It might be that loose refs
4:  c065b61ffb = 3:  6cfaeb7207 t/pack-refs-tests: move the 'test_done' to callees


base-commit: 854a80fd48848f942c4a566c9880dc5f089887af
change-id: 20251015-refs-code-cleanup-871a7ce7c8dd

Thanks
- Karthik

