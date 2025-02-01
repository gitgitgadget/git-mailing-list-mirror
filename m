Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1294BA34
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392147; cv=none; b=Te3ARCy8se4ZWVXW+N1C4VCXZBNCoIqcTJYB+QoD2zooRM3sePEfaU8RFm5BIa92a48bP04H93RJScy+hQTJ4hQ5mmE7QuB5uKZ++jiaLN9dm1RYIGRkD9u5HxyS8iSocjou8hTvMYhiWyVWJs7shimuE2zoscSjFT/3dL7GNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392147; c=relaxed/simple;
	bh=qlvjZ2KUWml8iv4NVkWwEfbn+w4mr49QxIEEpR/NYew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knCHH4c8kVm7YC3ubQwot+W1suJDoZCkFu3jiR9VAYO6KfGiTjWT5nRZjUvGHwAav10yCXd8aCvRZQhtADtm4deckZgMBxIq2cctehHNUWlqHTnPS4WqFIDiGQiX5GYNuincP6MTJwvdRWGWYfAzRkl2tFgRRCELj7Qf8JZY+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMFOWFe4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMFOWFe4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21636268e43so60859905ad.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392144; x=1738996944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z185qw2TkPhkaXPv9d9MWlUr9LbKryATESxwPhIt+0=;
        b=HMFOWFe4eVKMkv5OlOmhI/cmbQNRDxlFwlbumidA3ZTKXXTczdD6NiVVVMVPL+ptQ7
         iiV+QrKK13AdZbBnkGw94nqL61nkkeJ8LWX2bZ1/CZyHNJKXRA2goheA/hWS6292EcRo
         Umx2Vcj2aEv2SZ7PGYGSv9P6VvWWnKSgY0xJMgN6eNOIpHmjErio9dWZT4RiKU4xu5e8
         3R8bYyZnvup14bgS+tM7FvLHl88LhckMBEej23yX7Web+dEqMz6IY8IroBtWP/EtaseB
         xczFvQuy7RFEnVZuBEfdWtmlP9S8u7rYdCT09LdDHSSeoWsGhRWJMhC8mXAXRM9azP6u
         2CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392144; x=1738996944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z185qw2TkPhkaXPv9d9MWlUr9LbKryATESxwPhIt+0=;
        b=kFy0wTLGLKOdW7I3yPuWGKtlZJgVsbvDxGa7KWMPgLLqbXdsy2btgzqvLgCsdvrzDZ
         UuOQ0Y89p5vlI6E1dUh/D7bXz30EXE0gFhGbU9RkcTkGl2a6MkBqbBUqOo6GjBmKY+ZO
         GmA5LZ9AF6WvrNB4gZyA8XUXzIpsuTRGM96gmU027VKWeLqxCDDhrzB2SELiLAbvlo1q
         or3O7TfpK5pMuC+evKgRjxGHSf1gpwW4X/tFBZoZ+I5f/FSYfdPdgWllqCIQMS7XmFdV
         OX3YJBJPiYoiitC42JlRQM/Wt8pBFgSnPWRMlelhHz75xv9ryONqIDl8RBLWvZV0FSUs
         Zz+A==
X-Gm-Message-State: AOJu0YzfnzH4P/MpcubYbNtc58XnselNgRgGLtbdVHVTK1t57xq0nGeA
	TF9V5mnCLdbm+Au0c/3Ru6dEpZqUVfBF66vSEuFXgh88e3t6lt/IPasidc9h
X-Gm-Gg: ASbGncu7TX2g9tiwaw1Tzf7IkTAML2tfMGK4peZ/3nJVSd406xqZjqKWqA4j5q/qgBh
	/BpbAvDkE2QtoGdmRqegayzRQeDSErn9s66Nl2yZXyYNU03086d6CgcaxtqYSx3ZREagJ/raSDC
	Vjxal8MEnxYcfbPz34H0CjgjdZNdRHPkN3UBkcOnxIm3cCzfWYpBqJS1fz0vK/BG2ponculmsFY
	D4ak70lGTegIprU6v9yjhRo4foyxV1iXjc03/p3qnt5Vd9MiqqLczoTJJq7jborAK/3GjnMr8B3
	A9/O+TzNaUTRpA==
X-Google-Smtp-Source: AGHT+IGdAIgbndpd2n9L3vYEeIxq4fcPHLyhveUCZVSI/Fal3uDMF0ZXrP0PxK8pDNYC1yWRscVtQg==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1ed7a5fafdemr24307835637.13.1738392144332;
        Fri, 31 Jan 2025 22:42:24 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:42:23 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v3 0/5] refspec: centralize refspec-related logic
Date: Sat,  1 Feb 2025 12:11:57 +0530
Message-Id: <20250201064202.76116-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Patrick pointed out in [1], the logic related to refspec is currently
split across multiple headers. This patch series addresses that by
renaming and relocating refspec-related logic from remote to refspec for
improved cohesion.

[1]: https://lore.kernel.org/git/ZysQvUyxgdRqjvj2@pks.im/

Specifically, the following changes have been made:

    Refactoring and renaming functions: Functions such as
    omit_name_by_refspec() have been renamed to better reflect their
    functionality. 

    Relocation of functions: Functions that are primarily responsible
    for refspec related functionality, have been relocated from remote.c
    to refspec.c to maintain a clear separation of concerns.

Thank you for considering this patch.
Meet


Meet Soni (5):
  refactor(remote): rename function omit_name_by_refspec
  refspec: relocate refname_matches_negative_refspec_item
  refactor(remote): rename query_refspecs functions
  refspec: relocate matching related functions
  refspec: relocate apply_refspecs and related funtions

 builtin/push.c   |   2 +-
 builtin/remote.c |   2 +-
 refspec.c        | 203 ++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h        |  37 +++++++++
 remote.c         | 205 +----------------------------------------------
 remote.h         |  15 ----
 6 files changed, 244 insertions(+), 220 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  399e59ff67 refactor(remote): rename function omit_name_by_refspec
1:  8e393ea1c2 ! 2:  4109b2bd1c refspec: relocate omit_name_by_refspec and related functions
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    refspec: relocate omit_name_by_refspec and related functions
    +    refspec: relocate refname_matches_negative_refspec_item
     
    -    Move the functions `omit_name_by_refspec()`, `refspec_match()`, and
    -    `match_name_with_pattern()` from `remote.c` to `refspec.c`. These
    -    functions focus on refspec matching, so placing them in `refspec.c`
    -    aligns with the separation of concerns. Keep refspec-related logic in
    -    `refspec.c` and remote-specific logic in `remote.c` for better code
    -    organization.
    +    Move the functions `refname_matches_negative_refspec_item()`,
    +    `refspec_match()`, and `match_name_with_pattern()` from `remote.c` to
    +    `refspec.c`. These functions focus on refspec matching, so placing them
    +    in `refspec.c` aligns with the separation of concerns. Keep
    +    refspec-related logic in `refspec.c` and remote-specific logic in
    +    `remote.c` for better code organization.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ refspec.c: void refspec_ref_prefixes(const struct refspec *rs,
     +	return !strcmp(refspec->src, name);
     +}
     +
    -+int omit_name_by_refspec(const char *name, struct refspec *rs)
    ++int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
     +{
     +	int i;
     +
     +	for (i = 0; i < rs->nr; i++) {
    -+		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
    ++		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
     +			return 1;
     +	}
     +	return 0;
    @@ refspec.h: struct strvec;
      void refspec_ref_prefixes(const struct refspec *rs,
      			  struct strvec *ref_prefixes);
      
    -+/*
    -+ * Check whether a name matches any negative refspec in rs. Returns 1 if the
    -+ * name matches at least one negative refspec, and 0 otherwise.
    -+ */
    -+int omit_name_by_refspec(const char *name, struct refspec *rs);
    ++int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
     +
     +/*
     + * Checks whether a name matches a pattern and optionally generates a result.
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -	return !strcmp(refspec->src, name);
     -}
     -
    --int omit_name_by_refspec(const char *name, struct refspec *rs)
    +-int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
     -{
     -	int i;
     -
     -	for (i = 0; i < rs->nr; i++) {
    --		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
    +-		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
     -			return 1;
     -	}
     -	return 0;
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
      struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
      {
      	struct ref **tail;
    -
    - ## remote.h ##
    -@@ remote.h: int resolve_remote_symref(struct ref *ref, struct ref *list);
    -  */
    - struct ref *ref_remove_duplicates(struct ref *ref_map);
    - 
    --/*
    -- * Check whether a name matches any negative refspec in rs. Returns 1 if the
    -- * name matches at least one negative refspec, and 0 otherwise.
    -- */
    --int omit_name_by_refspec(const char *name, struct refspec *rs);
    --
    - /*
    -  * Remove all entries in the input list which match any negative refspec in
    -  * the refspec list.
-:  ---------- > 3:  559224864f refactor(remote): rename query_refspecs functions
2:  ef6edbc15b ! 4:  13e49509fc refspec: relocate query related functions
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    refspec: relocate query related functions
    +    refspec: relocate matching related functions
     
    -    Move the functions `query_refspecs()`, `query_refspecs_multiple()` and
    -    `query_matches_negative_refspec()` from `remote.c` to `refspec.c`. These
    -    functions focus on querying refspecs, so centralizing them in `refspec.c`
    -    improves code organization by keeping refspec-related logic in one place.
    +    Move the functions `find_refspec_match()`, `find_all_refspec_matches()`
    +    and `find_negative_refspec_match()` from `remote.c` to `refspec.c`.
    +    These functions focus on matching refspecs, so centralizing them in
    +    `refspec.c` improves code organization by keeping refspec-related logic
    +    in one place.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ refspec.c
      #include "strvec.h"
      #include "refs.h"
      #include "refspec.h"
    -@@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
    +@@ refspec.c: int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
      	}
      	return 0;
      }
     +
    -+static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
    ++static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
     +{
     +	int i, matched_negative = 0;
     +	int find_src = !query->src;
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +	}
     +
     +	for (i = 0; !matched_negative && i < reversed.nr; i++) {
    -+		if (omit_name_by_refspec(reversed.items[i].string, rs))
    ++		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
     +			matched_negative = 1;
     +	}
     +
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +	return matched_negative;
     +}
     +
    -+void query_refspecs_multiple(struct refspec *rs,
    ++void find_all_refspec_matches(struct refspec *rs,
     +				    struct refspec_item *query,
     +				    struct string_list *results)
     +{
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +	int find_src = !query->src;
     +
     +	if (find_src && !query->dst)
    -+		BUG("query_refspecs_multiple: need either src or dst");
    ++		BUG("find_all_refspec_matches: need either src or dst");
     +
    -+	if (query_matches_negative_refspec(rs, query))
    ++	if (find_negative_refspec_match(rs, query))
     +		return;
     +
     +	for (i = 0; i < rs->nr; i++) {
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +	}
     +}
     +
    -+int query_refspecs(struct refspec *rs, struct refspec_item *query)
    ++int find_refspec_match(struct refspec *rs, struct refspec_item *query)
     +{
     +	int i;
     +	int find_src = !query->src;
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +	char **result = find_src ? &query->src : &query->dst;
     +
     +	if (find_src && !query->dst)
    -+		BUG("query_refspecs: need either src or dst");
    ++		BUG("find_refspec_match: need either src or dst");
     +
    -+	if (query_matches_negative_refspec(rs, query))
    ++	if (find_negative_refspec_match(rs, query))
     +		return -1;
     +
     +	for (i = 0; i < rs->nr; i++) {
    @@ refspec.h: struct refspec_item {
      #define REFSPEC_FETCH 1
      #define REFSPEC_PUSH 0
      
    -@@ refspec.h: int omit_name_by_refspec(const char *name, struct refspec *rs);
    +@@ refspec.h: int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
      int match_name_with_pattern(const char *key, const char *name,
      				   const char *value, char **result);
      
    @@ refspec.h: int omit_name_by_refspec(const char *name, struct refspec *rs);
     + * Queries a refspec for a match and updates the query item.
     + * Returns 0 on success, -1 if no match is found or negative refspec matches.
     + */
    -+int query_refspecs(struct refspec *rs, struct refspec_item *query);
    ++int find_refspec_match(struct refspec *rs, struct refspec_item *query);
     +
     +/*
     + * Queries a refspec for all matches and appends results to the provided string
     + * list.
     + */
    -+void query_refspecs_multiple(struct refspec *rs,
    ++void find_all_refspec_matches(struct refspec *rs,
     +				    struct refspec_item *query,
     +				    struct string_list *results);
     +
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
      	return ref_map;
      }
      
    --static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
    +-static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
     -{
     -	int i, matched_negative = 0;
     -	int find_src = !query->src;
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	}
     -
     -	for (i = 0; !matched_negative && i < reversed.nr; i++) {
    --		if (omit_name_by_refspec(reversed.items[i].string, rs))
    +-		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
     -			matched_negative = 1;
     -	}
     -
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	return matched_negative;
     -}
     -
    --static void query_refspecs_multiple(struct refspec *rs,
    +-static void find_all_refspec_matches(struct refspec *rs,
     -				    struct refspec_item *query,
     -				    struct string_list *results)
     -{
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	int find_src = !query->src;
     -
     -	if (find_src && !query->dst)
    --		BUG("query_refspecs_multiple: need either src or dst");
    +-		BUG("find_all_refspec_matches: need either src or dst");
     -
    --	if (query_matches_negative_refspec(rs, query))
    +-	if (find_negative_refspec_match(rs, query))
     -		return;
     -
     -	for (i = 0; i < rs->nr; i++) {
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	}
     -}
     -
    --int query_refspecs(struct refspec *rs, struct refspec_item *query)
    +-int find_refspec_match(struct refspec *rs, struct refspec_item *query)
     -{
     -	int i;
     -	int find_src = !query->src;
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
     -	char **result = find_src ? &query->src : &query->dst;
     -
     -	if (find_src && !query->dst)
    --		BUG("query_refspecs: need either src or dst");
    +-		BUG("find_refspec_match: need either src or dst");
     -
    --	if (query_matches_negative_refspec(rs, query))
    +-	if (find_negative_refspec_match(rs, query))
     -		return -1;
     -
     -	for (i = 0; i < rs->nr; i++) {
    @@ remote.c: struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspe
      char *apply_refspecs(struct refspec *rs, const char *name)
      {
      	struct refspec_item query;
    -
    - ## remote.h ##
    -@@ remote.h: struct ref *ref_remove_duplicates(struct ref *ref_map);
    -  */
    - struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
    - 
    --int query_refspecs(struct refspec *rs, struct refspec_item *query);
    - char *apply_refspecs(struct refspec *rs, const char *name);
    - 
    - int check_push_refs(struct ref *src, struct refspec *rs);
3:  ea72647439 ! 5:  891e01be93 refspec: relocate apply_refspecs and related funtions
    @@ refspec.c
      #include "strbuf.h"
      
      /*
    -@@ refspec.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
    +@@ refspec.c: int find_refspec_match(struct refspec *rs, struct refspec_item *query)
      	}
      	return -1;
      }
    @@ refspec.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
     +	for (tail = &ref_map; *tail; ) {
     +		struct ref *ref = *tail;
     +
    -+		if (omit_name_by_refspec(ref->name, rs)) {
    ++		if (refname_matches_negative_refspec_item(ref->name, rs)) {
     +			*tail = ref->next;
     +			free(ref->peer_ref);
     +			free(ref);
    @@ refspec.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
     +	memset(&query, 0, sizeof(struct refspec_item));
     +	query.src = (char *)name;
     +
    -+	if (query_refspecs(rs, &query))
    ++	if (find_refspec_match(rs, &query))
     +		return NULL;
     +
     +	return query.dst;
     +}
     
      ## refspec.h ##
    -@@ refspec.h: void query_refspecs_multiple(struct refspec *rs,
    +@@ refspec.h: void find_all_refspec_matches(struct refspec *rs,
      				    struct refspec_item *query,
      				    struct string_list *results);
      
    @@ refspec.h: void query_refspecs_multiple(struct refspec *rs,
     +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
     +
     +/*
    -+ * Applies refspecs to a name and returns the corresponding destination.
    -+ * Returns the destination string if a match is found, NULL otherwise.
    ++ * Search for a refspec that matches the given name and return the
    ++ * corresponding destination (dst) if a match is found, NULL otherwise.
     + */
     +char *apply_refspecs(struct refspec *rs, const char *name);
     +
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -	for (tail = &ref_map; *tail; ) {
     -		struct ref *ref = *tail;
     -
    --		if (omit_name_by_refspec(ref->name, rs)) {
    +-		if (refname_matches_negative_refspec_item(ref->name, rs)) {
     -			*tail = ref->next;
     -			free(ref->peer_ref);
     -			free(ref);
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -	memset(&query, 0, sizeof(struct refspec_item));
     -	query.src = (char *)name;
     -
    --	if (query_refspecs(rs, &query))
    +-	if (find_refspec_match(rs, &query))
     -		return NULL;
     -
     -	return query.dst;
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     -
      int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
      {
    - 	return query_refspecs(&remote->fetch, refspec);
    + 	return find_refspec_match(&remote->fetch, refspec);
     
      ## remote.h ##
     @@ remote.h: int resolve_remote_symref(struct ref *ref, struct ref *list);
       */
      struct ref *ref_remove_duplicates(struct ref *ref_map);
      
    +-int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
    +-
     -/*
     - * Remove all entries in the input list which match any negative refspec in
     - * the refspec list.
     - */
     -struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
     -
    +-int find_refspec_match(struct refspec *rs, struct refspec_item *query);
     -char *apply_refspecs(struct refspec *rs, const char *name);
     -
      int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

