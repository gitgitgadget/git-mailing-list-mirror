Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721056;
	b=rPf3jEhT+vVu6Qm3+dtw9YeryB/kcKNiq+LJnZTzjPOe6ne5gL3+Q4wj0v15Sx1PsExZ
	 JPLvmdK1PdxBnpCecR/zM/VhJVe3eZnQ4IozwWHzKdqgyYpIfNm8o9lw9599EoCBXbjJe
	 uKqAfSqMf+7RyrYPJHlaqWrEDXovKsBrG/gji9ff1tBeAXlUc5fGUTzp9jRMdWDOO4GV2
	 Cl59H+7DhHxwhM29fo4gtgfdYt8j2edzHbAVwHuC4qofOJ5alMcTbqdMcwYVIgwlnSmxD
	 8ZSCI7dJwp5k6iJWkj4GTpROUJcV5pgxTV5kSspzxO0qSRG/ot+nmcdxyS97gbAQlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QEOYl7NEkcXa1fkNN48zIKU8JflT+p+0xRAeUGO1Nag=;
	b=kRo2R8JoO5Ju6RLOC8JWBnjuSZ3lxrz1gEfdGCHXJfge61cj9mEQz2aBD4gfQdTq+DBT
	 vRd5uAvfpFar6KYRKN9+f3lbgP4rlGf5MKX/NLzDhni68lt1j4gKOBiHBYUHdzVd4e0kG
	 j6xtR+NMug9PfiNLzGrVGOBJz+mWqAIVI4lmrMXgtPUwmwuHGxhZptVP3F2/LpgQx2SlS
	 /ckOYlkKD5ThEF3rXlI2+gqr7TM5q2rZnbRFj0HqHoLqyAivNGABZ0jxPKA1JSblYhgh0
	 seacjsZZJRqp4mOVc4KKpdmjRVhfnuSKzaukwvt2rD73ahAry2a5D0XETadVvwuo0uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejLh9YpU;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36F606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F36F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejLh9YpU
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40e30c26a4so157261566b.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721055; x=1794325855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEOYl7NEkcXa1fkNN48zIKU8JflT+p+0xRAeUGO1Nag=;
        b=ejLh9YpUfSU54FJNLzts67RFyPxPdx/0+HA9X3FjCDKIdjnR5HroTvA3PIvN5qHIYI
         5e1YsFDVUN90CV/WAN7cvMDWEEHE3ZLhlR/DpPXYE0IxGnWYwDaWDh08932OJKHl10hN
         MafoVCVlqWWgPlep56R09qy7jd0I0MBAlXHkZTqz9ymgyAumVVha8GekdxSuVLyyY5Pg
         lBfMnmrWDPSvetjfNBs1/fsjjAI7AQr10xfqZoxs7nWJNjCHSbJ1DjNwtlIaB67N9ClV
         QelBJdJZCggLOV26MZHCPNK1CFPXvSufELckDDGZkMOL8/nlUyPHvYeVaCTeN/xfxtWf
         WA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721055; x=1794325855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEOYl7NEkcXa1fkNN48zIKU8JflT+p+0xRAeUGO1Nag=;
        b=pwXoZtctlO/WN84Xh+rLG+kOgIh4U9R9/ktZsnkvfF21WYCMJXbEx5teUdgCiA/YkD
         gbzOfeWCtNYWYWKnRgSalMl26rJDWPXpyd06OXO1H/l1OorVmjAOpWWKk0zRfxbxezLN
         eXhFarkCEPHZzybN+/Yuvirsnd3y+2jkANhoSUVmdRv/MkjOctjCAD3rd25H7K2ewl27
         YwN4KblUw1WvvYz1h72pn2S1i3Rt/DLae0H+Y+VR32/xqVpmW8c2tMQgRhnPxl+o1oJ+
         ChJrsQ/g7pHBIOcF4ycG60AqUQj+YKxfD4390nHeAOqexF//SGuVZfpkbQmGYAXoMvXi
         LvZA==
X-Gm-Message-State: APuU4Z/rvYG1JBTIPmOkH54ocZsLCzMblEP8l4FGlWhI0rbbr44dYHQ3
	dhiK8nN+FsDpzDAU8SCVvCY5zDwK6mXEtwF5BzcDf0tBH0dvfrGV2T0VEm7hR5PeI8o=
X-Gm-Gg: AYBFou1+km1oYnhmRj6IZrvJjzpfQ7LFfONPikqBL6tazm/5vpot2ryl4v0iNTNob1Z
	wRGqpKE/WjEa8783c9+7+oXGDVqPMrdWwSAWYKSwpHmJwpLNJNjlzW9rDGkjcALdGMIQRLSNOao
	BQ/M1WfF10Z7q0OVGFT9OzjW8pTVtRFg7YYHwG2tMTtu/nnM138I1L9zCvJNDvfodSCEFc2e8NR
	mPc21mefmJq6K8Xw7VwbhjAiIDzpFxOD/ZOMhHyTzNQHTtBUz3qy+z/g9KID5WX+azzcK4LeTCa
	PULOrJq7GjYBRUgFnEv3U5aInSlfVcXoAACj3NdaF9M+0ktJfs8/2DtJnevCXpUNNau1LLJWqQw
	jpYhl7xUQKD6UT3WjiuGQ8j76X5Lx3XJdVw8/jscwgwoiDK1Jq8yCiOtIwNntV4jxSCKNeIJZfI
	XRR37Lm6ZfB0HVfD0MOhOdcTEl7MP0viuiP67x76rfHNOo2Ctw5e+5mIICYZ0Lav8pypfZm+ega
	3inPS80JBwVAVm4txZ/nNIK3IVsrk/ot7ODtf0jA9tOhaKPTkhjoKXp1Qv6zl2otBQ5uFQNhTwx
	/A8hONrwvuWwAGgRS90zuZAeb7nJKTBvhGSEUTajG8vgcPrJkDJCP+mCvHRHaXOVhtHpK9bGJvf
	C8QR1ptqzS/xcH9CTAhiqjUsZjKafMHc+zmdo+RGmgAMcoU0lbOfQaOYYMmub3qltmH46HKTVF+
	7eW0zCcfMXWNYVlFtROdMtfyGp/rK4
X-Received: by 2002:a17:907:3e19:b0:c48:a838:c17e with SMTP id a640c23a62f3a-c49d1307e11mr1494313866b.14.1793721054712;
        Tue, 03 Nov 2026 07:50:54 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebefc972sm97673666b.35.2026.11.03.07.50.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 07:50:52 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy PATCH v2] negotiator/default: stop using the_repository
Date: Tue,  3 Nov 2026 16:50:38 +0100
Message-ID: <20261103155038.87456-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
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

The default negotiator uses the_repository to parse commits,
clear marks, and walk refs. fetch_negotiator_init() already
has the repository but does not pass it down.

Give default_negotiator_init() a repository parameter, store
it on the negotiation state, and use it for those calls.
clear_marks() receives the repository through its callback
data. Drop USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Put the repository first in default_negotiator_init(), as
  Christian suggested.
- Pass ns to mark_common() in have_sent().

Thanks, Christian, for the review.

 fetch-negotiator.c   |  2 +-
 negotiator/default.c | 28 ++++++++++++++++------------
 negotiator/default.h |  4 +++-
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index be383367f5..a5183bb3bc 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -19,7 +19,7 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_CONSECUTIVE:
-		default_negotiator_init(negotiator);
+		default_negotiator_init(r, negotiator);
 		return;
 	}
 }
diff --git a/negotiator/default.c b/negotiator/default.c
index 19cdf3808c..f7cb52f10c 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "default.h"
 #include "../commit.h"
@@ -18,6 +16,7 @@
 static int marked;
 
 struct negotiation_state {
+	struct repository *repo;
 	struct prio_queue rev_list;
 	int non_common_revs;
 };
@@ -28,7 +27,7 @@ static void rev_list_push(struct negotiation_state *ns,
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (repo_parse_commit(the_repository, commit))
+		if (repo_parse_commit(ns->repo, commit))
 			return;
 
 		prio_queue_put(&ns->rev_list, commit);
@@ -38,9 +37,10 @@ static void rev_list_push(struct negotiation_state *ns,
 	}
 }
 
-static int clear_marks(const struct reference *ref, void *cb_data UNUSED)
+static int clear_marks(const struct reference *ref, void *cb_data)
 {
-	struct object *o = deref_tag(the_repository, parse_object(the_repository, ref->oid),
+	struct repository *r = cb_data;
+	struct object *o = deref_tag(r, parse_object(r, ref->oid),
 				     ref->name, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -78,7 +78,7 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
 			struct commit_list *parents;
 
 			if (!o->parsed && !dont_parse)
-				if (repo_parse_commit(the_repository, commit))
+				if (repo_parse_commit(ns->repo, commit))
 					continue;
 
 			for (parents = commit->parents;
@@ -119,7 +119,7 @@ static const struct object_id *get_rev(struct negotiation_state *ns)
 		commit = prio_queue_get(&ns->rev_list);
 		if (!commit)
 			return NULL;
-		repo_parse_commit(the_repository, commit);
+		repo_parse_commit(ns->repo, commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
@@ -179,9 +179,11 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 
 static void have_sent(struct fetch_negotiator *n, struct commit *c)
 {
-	if (repo_parse_commit(the_repository, c))
+	struct negotiation_state *ns = n->data;
+
+	if (repo_parse_commit(ns->repo, c))
 		return;
-	mark_common(n->data, c, 0, 0);
+	mark_common(ns, c, 0, 0);
 }
 
 static void release(struct fetch_negotiator *n)
@@ -190,7 +192,8 @@ static void release(struct fetch_negotiator *n)
 	FREE_AND_NULL(n->data);
 }
 
-void default_negotiator_init(struct fetch_negotiator *negotiator)
+void default_negotiator_init(struct repository *r,
+			     struct fetch_negotiator *negotiator)
 {
 	struct negotiation_state *ns;
 	negotiator->known_common = known_common;
@@ -200,10 +203,11 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
+	ns->repo = r;
 	ns->rev_list.compare = compare_commits_by_commit_date;
 
 	if (marked)
-		refs_for_each_ref(get_main_ref_store(the_repository),
-				  clear_marks, NULL);
+		refs_for_each_ref(get_main_ref_store(r),
+				  clear_marks, r);
 	marked = 1;
 }
diff --git a/negotiator/default.h b/negotiator/default.h
index d23a8f2fb8..98bc989cff 100644
--- a/negotiator/default.h
+++ b/negotiator/default.h
@@ -2,7 +2,9 @@
 #define NEGOTIATOR_DEFAULT_H
 
 struct fetch_negotiator;
+struct repository;
 
-void default_negotiator_init(struct fetch_negotiator *negotiator);
+void default_negotiator_init(struct repository *r,
+			     struct fetch_negotiator *negotiator);
 
 #endif

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0

