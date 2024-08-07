Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713011422A8
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059776; cv=none; b=TMUggyYz0zHaMSTnut/9f8CeMdP1OPffwNpaE82KjnjeeuILSr/W+dmsNwxn2iIkl75mB6RX2jNoem8YaXvqXyrvLDvF7QmC0dgub9EKCYYbbV8X2BlaW7JxVyxk9hp7ZjO3sUwG7iJWz7hctsoZzhY9gX/lUvhPs3C02u/r3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059776; c=relaxed/simple;
	bh=WJlPtzPbyGRUiRk2VKEF5VWKxq/Bl5YL7h2cyFuclIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Tlz0mzNwKXfGIdGr2IK5Q9ldQP+IJHLatsJh6EyTmdQWAnPsHBrw+jMp/E9Qsg209Cj6Xxh8LWlqOUA0FUt2DkrCtKzh6zEtKcQgA8Mr+w1lSxe6Fqo+7y3igmVQorwHg3iWJqzhwKh83b6jNKOspGfa109XLRv/t7z3uFoNthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVAPlKua; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVAPlKua"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso130923f8f.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723059772; x=1723664572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywtp7VXJ7Qvw0b/q62/oMo10qCWj5XqIty0WPIsMV2E=;
        b=eVAPlKuaNgx4RzM0IygmoI5obfPFNUz8ZQNHAqYZwTp1RRQPwJOsU9bYBY4RmLT+J5
         JHtLhi5Wbzpcjgwe8lKVMh2jPQOldFgbnNJGDl4z9PNXhGKsdBUjWqK06Xnof+LrqekU
         Vc0evgPm6rSZk4XzfqTT7jOMNo/SQ/D/Bmu0F+w/razA8Ni3kAFdOD30NEtS5+Z/iE5I
         QbaBZSRCW+MmJNK6H+RuJsxF852+dDeJUst/UkU7Ds7h/9e49NTYi/Xs8uXarN0NNFHR
         vvWJLjTXo73/vSveK3mDQYmsgiXPBwyUTX9rJAOCbNxAwPMuAj+LxUwyOKbR7+RElwFo
         IBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059772; x=1723664572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywtp7VXJ7Qvw0b/q62/oMo10qCWj5XqIty0WPIsMV2E=;
        b=RESvjEaZIoeL7eevsEbaxU6YATPLRTMaaXwNdTswSqTa5MZRba/+SAQKDDEb0SEYHQ
         5ELGGSFnTVY8BvvwPZl8CCEzosNayUIhOF/V2F7WjZkU0LFX1Zz01HOud4uCo59CGpJK
         8h05eWEB09KDujWXMYnjpJEKfzaeLj7e2M3TyyEkH5cpxcigbBLry6qt4wUADSGPZ7WO
         XZa6QicQdyg2J6yTkd/4Qh2HycqqeWmP9VZ2zp7YLpN/y0O9MRGircpBa35o7xLkCO6m
         N/Lv9p0PCOQQM9uMBoC+UHJthN37u/FoExnnoO/FTybeTXGY6J4pGQzKHi1htZ6donPz
         uuug==
X-Gm-Message-State: AOJu0Yy23jMiRnAYugZyxvdJbPXUN+OU0TU2UJpnIRZ5i9J0vz6oeeQD
	G+Q7eq7l+gXZs26k5xygZ5ADLocEdrC6sMBk1EobgvvfXLbZOJJeIYG4eA==
X-Google-Smtp-Source: AGHT+IHTrMGlNLMGVO9y2nb7RIhlC60ZBn2n1jyp7+YZMxcaGFdIDvjQkTWXw4d99r+rEorRbBgxkw==
X-Received: by 2002:a5d:6d49:0:b0:368:557a:c64d with SMTP id ffacd0b85a97d-36bbc0cda74mr12859620f8f.9.1723059771903;
        Wed, 07 Aug 2024 12:42:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06dfa9sm16894436f8f.102.2024.08.07.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:42:51 -0700 (PDT)
Message-Id: <fc3defd9c47e32bb23ba0fcb5c885274f3706b23.1723059769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Aug 2024 19:42:46 +0000
Subject: [PATCH v3 1/3] refs: keep track of unresolved reference value in
 iterators
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Since ref iterators do not hold onto the direct value of a reference
without resolving it, the only way to get ahold of a direct value of a
symbolic ref is to make a separate call to refs_read_symbolic_ref.

To make accessing the direct value of a symbolic ref more efficient,
let's save the direct value of the ref in the iterators for both the
files backend and the reftable backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 refs/files-backend.c    | 19 +++++++++++++++----
 refs/iterator.c         |  2 ++
 refs/ref-cache.c        |  6 ++++++
 refs/ref-cache.h        |  2 ++
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 10 ++++++++--
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c7..5ed69c23f74 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -245,9 +245,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 {
 	struct object_id oid;
 	int flag;
-
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
-				     &oid, &flag)) {
+	const char *referent = refs_resolve_ref_unsafe(&refs->base,
+						       refname,
+						       RESOLVE_REF_READING,
+						       &oid, &flag);
+	if (!referent) {
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_ISBROKEN;
 	} else if (is_null_oid(&oid)) {
@@ -268,7 +270,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+
+	if (!(flag & REF_ISSYMREF))
+		referent = NULL;
+
+	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
 }
 
 /*
@@ -886,6 +892,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		iter->base.refname = iter->iter0->refname;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
+		if (iter->iter0->flags & REF_ISSYMREF)
+			iter->base.referent = iter->iter0->referent;
+		else
+			iter->base.referent = NULL;
+
 		return ITER_OK;
 	}
 
diff --git a/refs/iterator.c b/refs/iterator.c
index d355ebf0d59..75fbe5d72ab 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -29,6 +29,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 {
 	iter->vtable = vtable;
 	iter->refname = NULL;
+	iter->referent = NULL;
 	iter->oid = NULL;
 	iter->flags = 0;
 }
@@ -199,6 +200,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		}
 
 		if (selection & ITER_YIELD_CURRENT) {
+			iter->base.referent = (*iter->current)->referent;
 			iter->base.refname = (*iter->current)->refname;
 			iter->base.oid = (*iter->current)->oid;
 			iter->base.flags = (*iter->current)->flags;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4ce519bbc85..bf80a62af17 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -5,6 +5,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
+#include "../strbuf.h"
 
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
@@ -34,6 +35,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
@@ -41,6 +43,8 @@ struct ref_entry *create_ref_entry(const char *refname,
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
 	ref->flag = flag;
+	ref->u.value.referent = xstrdup_or_null(referent);
+
 	return ref;
 }
 
@@ -66,6 +70,7 @@ static void free_ref_entry(struct ref_entry *entry)
 		 */
 		clear_ref_dir(&entry->u.subdir);
 	}
+	free(entry->u.value.referent);
 	free(entry);
 }
 
@@ -431,6 +436,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->index = -1;
 		} else {
 			iter->base.refname = entry->name;
+			iter->base.referent = entry->u.value.referent;
 			iter->base.oid = &entry->u.value.oid;
 			iter->base.flags = entry->flag;
 			return ITER_OK;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 31ebe24f6cf..5f04e518c37 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -42,6 +42,7 @@ struct ref_value {
 	 * referred to by the last reference in the symlink chain.
 	 */
 	struct object_id oid;
+	char *referent;
 };
 
 /*
@@ -173,6 +174,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len);
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag);
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa975d69aaa..117ec233848 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -299,6 +299,7 @@ enum do_for_each_ref_flags {
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
 	const char *refname;
+	const char *referent;
 	const struct object_id *oid;
 	unsigned int flags;
 };
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fbe74c239d3..50a072b97b0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -455,6 +455,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	struct reftable_ref_iterator *iter =
 		(struct reftable_ref_iterator *)ref_iterator;
 	struct reftable_ref_store *refs = iter->refs;
+	const char *referent = NULL;
 
 	while (!iter->err) {
 		int flags = 0;
@@ -494,8 +495,12 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				the_repository->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
-						     RESOLVE_REF_READING, &iter->oid, &flags))
+			referent = refs_resolve_ref_unsafe(&iter->refs->base,
+								      iter->ref.refname,
+								      RESOLVE_REF_READING,
+								      &iter->oid,
+								      &flags);
+			if (!referent)
 				oidclr(&iter->oid, the_repository->hash_algo);
 			break;
 		default:
@@ -523,6 +528,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				continue;
 
 		iter->base.refname = iter->ref.refname;
+		iter->base.referent = referent;
 		iter->base.oid = &iter->oid;
 		iter->base.flags = flags;
 
-- 
gitgitgadget

