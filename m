Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FB1DEFDC
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526869; cv=none; b=OeymqpMKGYTRdf+8HqsbGrC7YMfggYVWtnTS4lEjs/IjwmgkwHCa16hp7vjYvNUWacPIH6yj0kRmBMyyz+KCGXs4+lU8ynPhcYCTwvNGuqP4Kj4ZNrhpM3pp5U9MxOZGLCkOm8eti1r6yuxloziSQGfD6wF2QwFkb445PPemX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526869; c=relaxed/simple;
	bh=3cexoOCabYeuchAxPHPe/DCyZTBpbdu3kosFzRkd4WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KN01ptgliAAmT8S/LIdr1eNM3Qb9Y7HzBK9ojERX13TEpfFhamHp7dxsDUXw3Uspnja5qWG4D6YbWGPHSEXnx7IdsvacSdEYPZ26rP9ylP29UigbqoXQKnq7IzpUZ4D1VCSVoOgHHqaBjBQzEZtcAzaKiaLMoOSMPsCHMGSNmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL7jdEPJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL7jdEPJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so10805575a12.3
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526865; x=1744131665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iWRhUb2iPFABfZjrPH6cKCGFFLrRfK3clvvdQZwibU=;
        b=TL7jdEPJSHIpEE6pnmXMotZsgdkFrB+CPFG3aBBKinpkzkJtKffLXSA6HhNO1sZeTV
         GVVD+sKIRqHQbYDFXHp+dvV91C2hbreHjK2dxZvyFz6M1IA4jXCnpRrx1WDl6NgSbgRD
         CPLRks8c30c+wmr7iIyZGIE++CGzyuz/5u186hn43uoUeH/KfiAY0mkwVcGI8nVBHv3F
         OvjVJEllzOpmTJaFwjiO1wjxPyLWYuLCx9dWocTQbH0Q8TBUGbnHU15/FmafvVIoubJo
         kq402mXNSvoyql33JMZsZlHQvBlg+AjS/zuuQRH816cTZD0TdilLoc+PupkTwLAhtLXV
         Gscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526865; x=1744131665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWRhUb2iPFABfZjrPH6cKCGFFLrRfK3clvvdQZwibU=;
        b=lX5UhN3aJspPare4zk2gGrkrQNrsvvPAb5LcgCarRqm4fAvw95HXpkGrWxAJzNpddw
         0LW1tDzP6Hre5ozu+qHqRUWZ1CUeCcgnn97UKNdbcviz7OQzlUXOXuMmhOqcphWpA1/T
         h1gSXLUDJ08PrO+VmbpPrRY/DUvsDo9uuaAaUx2hdkTy5mEsTEvlO0g4q8lFZPW8ywnb
         W9c/aA0b1KwwV8gjBg7SX2sTBNWcNzJV0uX8prT5CdIZkC6BBIAxFFNqTctYikCEWVTP
         Rj6ULINQF3w6KKA0M8qtYMAcdWUd97rXpw2h5OJgYAvo9lqjReaGXjqEcWhvm7z+VOWU
         dxhw==
X-Gm-Message-State: AOJu0YwaO5IHYfKYDWUCqETjvlg/3b5QESXEmd9383lGHlXrQhr16/ZN
	BSVQ/EmfW+dMw5D0sUWfWIq6e5lGVVkH4w50qllkfMf9jxiH45YPf3KF0iPa
X-Gm-Gg: ASbGncssS426dR01zkn48oX+LiJTZznn/gw6igdq+5h09/0jT8qZw8a5J9S/Fmczj1g
	k0xPeA8Urqw7HOXk6ElV4OSZXXXZMDK7AOt2ixmA8Qn2nlDJta9gtkxUx5511sph/BGPPvr0cjA
	AhQ3FqdirwVds4SaZRwFob6nTD1yvMhQ0qe56MM/7NYPY6KRq45HglDR7AYinI3V9IlQodtSbVB
	IRM9oYkRHjJDK/ifV83padwQnvbSIj59bCC+AvPcBQBi2C0/2Xkq3QVJWs8vLFEg9TIj2YqG7pZ
	SwKljwVqRby51qkITZzwGTuqaobCtK6SswHBhI8rCc1gs2jl
X-Google-Smtp-Source: AGHT+IFrd5CH+quhzw2F/cW/DFHlenAtRWAihelz3JdOx1Q68tce7n6IDa85TjGqk5FCkv+ff5Gy9A==
X-Received: by 2002:a17:907:6e90:b0:ac6:d0f6:c85c with SMTP id a640c23a62f3a-ac738aa34d8mr1236882766b.20.1743526865247;
        Tue, 01 Apr 2025 10:01:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:90eb:ce:1988:2fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dd46asm780219666b.160.2025.04.01.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:01:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Apr 2025 19:00:57 +0200
Subject: [PATCH 2/2] bundle: fix non-linear performance scaling with refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-2-6d23b2d96557@gmail.com>
References: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
In-Reply-To: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7856; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3cexoOCabYeuchAxPHPe/DCyZTBpbdu3kosFzRkd4WM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfsG86mK/YZc217ElPRrqKOEU4nZu6NYMul/
 avO6TQbJhoeMokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn7BvOAAoJED7VnySO
 Rox/gSEMAKT8TKJ5NxZIGofY1A6IlaO7GGaoVUul8RUh5FcYu+Y5yzxq/Ko+AJ11RWmXfsNNjJ4
 t9qwSdM/uyCkbkEmp1BQ0gT5AdHkuv9IZRmm+UAlJM4dkzdFQ1FuKSAd2HM+4Zgoqji7kb0qoFp
 9BG7f6/mtBCHmA3q8ve9p9h1if2pZrWZQvdroammdJ5WsNcGRiiO4qKZ4cjwyxoK66ey3mWEI4W
 TLit8J9p/9nIZFtqhzSYLroh8nXKi0iziO87NfLYSZAWR0NSgQG2RZBc2Vu9tRvos8OA7Fxx00p
 jeZw9VCC0F3WxS0UoMUztyJVN3x67rpPjctUEIM9+p1O4OvhvSdXeVjqu2fu9HWIH6WkMgh7ROp
 BWnwWzFhhSO3H9XLgD7cD1Gf8LakB36mkRDqTKWzMYsoiZXq+Kw+scRB+pjrBHVum5kT3epdnXk
 wwmh3wAiNi+WqUMW7uWszTb1j+XuVcs2mFs1sCUuCtS5nfPsAhdes8hu8v7kz2cKJd172xRL8O4
 0g=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git bundle create' command has non-linear performance with the
number of refs in the repository. Benchmarking the command shows that
a large portion of the time (~75%) is spent in the
`object_array_remove_duplicates()` function.

The `object_array_remove_duplicates()` function was added in
b2a6d1c686 (bundle: allow the same ref to be given more than once,
2009-01-17) to skip duplicate refs provided by the user from being
written to the bundle. Since this is an O(N^2) algorithm, in repos with
large number of references, this can take up a large amount of time.

Let's instead use a 'strset' to skip duplicates inside
`write_bundle_refs()`. This improves the performance by around 6 times
when tested against in repository with 100000 refs:

Benchmark 1: bundle (refcount = 100000, revision = master)
  Time (mean ± σ):     14.653 s ±  0.203 s    [User: 13.940 s, System: 0.762 s]
  Range (min … max):   14.237 s … 14.920 s    10 runs

Benchmark 2: bundle (refcount = 100000, revision = HEAD)
  Time (mean ± σ):      2.394 s ±  0.023 s    [User: 1.684 s, System: 0.798 s]
  Range (min … max):    2.364 s …  2.425 s    10 runs

Summary
  bundle (refcount = 100000, revision = HEAD) ran
    6.12 ± 0.10 times faster than bundle (refcount = 100000, revision = master)

Previously, `object_array_remove_duplicates()` ensured that both the
refname and the object it pointed to were checked for duplicates. The
new approach, implemented within `write_bundle_refs()`, eliminates
duplicate refnames without comparing the objects they reference. This
works because, for bundle creation, we only need to prevent duplicate
refs from being written to the bundle header. The `revs->pending` array
can contain duplicates of multiple types.

First, references which resolve to the same refname. For e.g. "git
bundle create out.bdl master master" or "git bundle create out.bdl
refs/heads/master refs/heads/master" or "git bundle create out.bdl
master refs/heads/master". In these scenarios we want to prevent writing
"refs/heads/master" twice to the bundle header. Since both the refnames
here would point to the same object (unless there is a race), we do not
need to check equality of the object.

Second, refnames which are duplicates but do not point to the same
object. This can happen when we use an exclusion criteria. For e.g. "git
bundle create out.bdl master master^!", Here `revs->pending` would
contain two elements, both with refname set to "master". However, each
of them would be pointing to an INTERESTING and UNINTERESTING object
respectively. Since we only write refnames with INTERESTING objects to
the bundle header, we perform our duplicate checks only on such objects.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 bundle.c               | 10 +++++++++-
 object.c               | 33 ---------------------------------
 object.h               |  6 ------
 t/t6020-bundle-misc.sh |  4 ----
 4 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/bundle.c b/bundle.c
index d7ad690843..30cfba0be2 100644
--- a/bundle.c
+++ b/bundle.c
@@ -384,6 +384,9 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
 	int i;
 	int ref_count = 0;
+	struct strset objects;
+
+	strset_init(&objects);
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *e = revs->pending.objects + i;
@@ -401,6 +404,9 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
+		if (strset_contains(&objects, display_ref))
+			goto skip_write_ref;
+
 		if (e->item->type == OBJ_TAG &&
 				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
@@ -423,6 +429,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		}
 
 		ref_count++;
+		strset_add(&objects, display_ref);
 		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexsz);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
@@ -431,6 +438,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		free(ref);
 	}
 
+	strset_clear(&objects);
+
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
 	return ref_count;
@@ -566,7 +575,6 @@ int create_bundle(struct repository *r, const char *path,
 	 */
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
-	object_array_remove_duplicates(&revs_copy.pending);
 
 	/* write bundle refs */
 	ref_count = write_bundle_refs(bundle_fd, &revs_copy);
diff --git a/object.c b/object.c
index 100bf9b8d1..a2c5986178 100644
--- a/object.c
+++ b/object.c
@@ -491,39 +491,6 @@ void object_array_clear(struct object_array *array)
 	array->nr = array->alloc = 0;
 }
 
-/*
- * Return true if array already contains an entry.
- */
-static int contains_object(struct object_array *array,
-			   const struct object *item, const char *name)
-{
-	unsigned nr = array->nr, i;
-	struct object_array_entry *object = array->objects;
-
-	for (i = 0; i < nr; i++, object++)
-		if (item == object->item && !strcmp(object->name, name))
-			return 1;
-	return 0;
-}
-
-void object_array_remove_duplicates(struct object_array *array)
-{
-	unsigned nr = array->nr, src;
-	struct object_array_entry *objects = array->objects;
-
-	array->nr = 0;
-	for (src = 0; src < nr; src++) {
-		if (!contains_object(array, objects[src].item,
-				     objects[src].name)) {
-			if (src != array->nr)
-				objects[array->nr] = objects[src];
-			array->nr++;
-		} else {
-			object_array_release_entry(&objects[src]);
-		}
-	}
-}
-
 void clear_object_flags(unsigned flags)
 {
 	int i;
diff --git a/object.h b/object.h
index 17f32f1103..0e12c75922 100644
--- a/object.h
+++ b/object.h
@@ -324,12 +324,6 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data);
 
-/*
- * Remove from array all but the first entry with a given name.
- * Warning: this function uses an O(N^2) algorithm.
- */
-void object_array_remove_duplicates(struct object_array *array);
-
 /*
  * Remove any objects from the array, freeing all used memory; afterwards
  * the array is ready to store more objects with add_object_array().
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index dd09df1287..500c81b8a1 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -684,7 +684,6 @@ test_expect_success 'create bundle with duplicate refnames' '
 	test_cmp expect actual
 '
 
-# This exhibits a bug, since the same refname is now added to the bundle twice.
 test_expect_success 'create bundle with duplicate refnames and --all' '
 	git bundle create out.bdl --all "main" "main" &&
 
@@ -701,7 +700,6 @@ test_expect_success 'create bundle with duplicate refnames and --all' '
 	<TAG-2> refs/tags/v2
 	<TAG-3> refs/tags/v3
 	<COMMIT-P> HEAD
-	<COMMIT-P> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -717,7 +715,6 @@ test_expect_success 'create bundle with duplicate exlusion refnames' '
 	test_cmp expect actual
 '
 
-# This exhibits a bug, since the same refname is now added to the bundle twice.
 test_expect_success 'create bundle with duplicate refname short-form' '
 	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/main" &&
 
@@ -725,7 +722,6 @@ test_expect_success 'create bundle with duplicate refname short-form' '
 		make_user_friendly_and_stable_output >actual &&
 	cat >expect <<-\EOF &&
 	<COMMIT-P> refs/heads/main
-	<COMMIT-P> refs/heads/main
 	EOF
 	test_cmp expect actual
 '

-- 
2.48.1

