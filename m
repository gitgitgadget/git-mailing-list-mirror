Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78902135D7
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007861; cv=none; b=FpwGJNoNI+BQhhMdH0UbtBuw2loL0sD8DfIpFmmheGDR7VFfdlt7a35FbO0esgR+DNz1oZDlWZSUsKKvyjt4Yez0fMEa/CYa+X5UDY6GqYrd1y9Jdl0uQAZwO+mh8XiME3IYR5uqWPeN6/TcW/Ee0aGcMmkGTBOuhMSf41P7lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007861; c=relaxed/simple;
	bh=/KPt1hJehJaAr6kXkrQcJJ1Jp+H1JRl83T9fyjjNLug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=RMsqCAgeKz+4e8WyYiS9oDa8ynxxldX8qJO0Ahd4jQCiNAiGy4QbMj6qFOJEoTTT9kQqQQA7gBtCd9SRdhRdu33jVdPm8rKjcu15JFkYG9RaNlJt6U83rwC41b/5/1MuiCUGPyBdWo8FF3JozIdAqWScsDZ3IulQ69u2BBvKRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbNYm7wZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbNYm7wZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b32384e586so13888191cf.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757007857; x=1757612657; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js6LktNktZCU/SwBkpj1PQVoWIXet2SsOB/pMNGhXZ0=;
        b=fbNYm7wZ5MvL166zlFbi3VeZTas++Xl0n/6NGsD+fOrivG/VyxulzNyl7PG4OuP0I5
         J307Zk7vcEGhI7Tzv7wgQ2ErNSZ5Dj7AARgyZ19moC6mBAl5iHbLRRgqD7gUZw3MtxQ0
         c/Wg7aRV2jv37r5v/B8nvcQErWQN25Sa8JIQcZ48tCxQfHaY8fYt4X+n8VItTQsUgfrN
         UvbIgOF+RrnXQGHSzIKHbqyAfUbs4FznejSrIW5N/zSvqEY7KfzFccP4K1ReQy3DUuea
         ryG2JZDdZYPdKbTWs9BZJMqG/NwDferV9KEiBZ0JcZwd0i1olx0BorxBDDVPLrqV1Rki
         v7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007857; x=1757612657;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js6LktNktZCU/SwBkpj1PQVoWIXet2SsOB/pMNGhXZ0=;
        b=QzQoSrCN+0ObCr4kfd55HqZS3oO3OUhXNgx5bT1dARC9mCc6VuKYVb/PM0tzv9SNQd
         V5JGdPScDEloF+y0yJ59CicLGBzUH7pg0Fmwf61yytVJbH8cYFrtZfboocBn5TtRBdrX
         BC43Qtq16dfi6mWOlDcQCRXgLQvnHLqYZu1rHG8quSW6WoN9Whh4CclnAy/aosfqB2nm
         nqP5QU2xdBzjiURcbfJVB/EsloFEiv36dBXCyVGlTJo0WReMJGHWTZ8b59BeB8isUxSP
         QSTtA3M1tRTC+40V59V7/0CqwdSRikanLlD5F8rxRVGBYrjdnEOucoQFEaXaL8kU50Xk
         37gQ==
X-Gm-Message-State: AOJu0Yw9IGfeVwfkR+zY3wtyFrFWwfff+f7B6gXqt++nbUIgNQwn6ffT
	H1D5+VdEwtqEH+DJiPzSa8UZ7yYZFuhObZRd4W7W/m70Hwij7wFrO1nFwk/MOA==
X-Gm-Gg: ASbGncsDZ3LjJ688U3Dyz2FMGl4aDdLt+nspJeJlJjwQKUC/A8/vl3wFgbY1fdfxq51
	wVD4scP5JJmd6vljy+0CifEuhZ/WAPWBv1uhx8B9ONKN766131X8XiovyV6KSD+OVp+vvxbomZX
	vpbTeNIzo7hyNPqc6elAjf4OLSyU0KD6PI92IpLbReWc9vQRhTTOljFdpCxsxP7sVJ9YD63wq3v
	TRoZ7Pyo4Z63J0IS3jNTnxltXJNrbc95QbIcg1wUCvdWWjL9PWQv413HRNFJUo0yM81N+SBNB2f
	0aYo8f55NegxQ4spKDg+oewc7vjxdqn7mLmf9ULGePQSp3fRjAmW69L4rQS+WGmEsLcgTqM1uWS
	3L8furG6bZSNteG29rHvP1lw=
X-Google-Smtp-Source: AGHT+IEHvvpA4nuTnhINNEsRFc6JUMfqLK0k+spzNUMmcE7WlcunTcg717ft++bU0XsSUhJ+Ew3YAQ==
X-Received: by 2002:a05:622a:11c1:b0:4b1:dd3:e399 with SMTP id d75a77b69052e-4b31dc6791fmr263370491cf.64.1757007857091;
        Thu, 04 Sep 2025 10:44:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.206.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f785d71sm32226501cf.44.2025.09.04.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:44:16 -0700 (PDT)
Message-Id: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Sep 2025 17:44:16 +0000
Subject: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare <nouraellm@gmail.com>,
    =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

All callers of clear_alloc_state() immediately free what they
cleared, so currently it does not hurt anybody that the
alloc_state is left in an unreusable state, but it is an
error-prone API. Replace it with a new function that clears but
in addition frees the structure, as well as NULLing the pointer
that points at it and adjust existing callers.

While at it, rename allocate_alloc_state() and name the new
function alloc_state_free_and_null(), to follow more closely the
function naming convention specified in the CodingGuidelines
(namely, functions about S are named with S_ prefix and then
verb).

Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
---
    alloc: fix dangling pointer in alloc_state cleanup
    
    cc: Torsten Bögershausen tboegi@web.de cc: Jeff King peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v5
Pull-Request: https://github.com/git/git/pull/2040

Range-diff vs v4:

 1:  82d228661d ! 1:  d04b0258f5 alloc: fix dangling pointer in alloc_state cleanup
     @@ alloc.c: struct alloc_state {
      -void clear_alloc_state(struct alloc_state *s)
      +void alloc_state_free_and_null(struct alloc_state **s_)
       {
     -+	struct alloc_state *s;
     -+
     -+	if (!s_ || !*s_) return;
     -+
     -+	s = *s_;
     ++	struct alloc_state *s = *s_;
      +
       	while (s->slab_nr > 0) {
       		s->slab_nr--;


 alloc.c  |  7 +++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dd..3a5d0b2bd8 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,22 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
+struct alloc_state *alloc_state_alloc(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
 
-void clear_alloc_state(struct alloc_state *s)
+void alloc_state_free_and_null(struct alloc_state **s_)
 {
+	struct alloc_state *s = *s_;
+
 	while (s->slab_nr > 0) {
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
 
 	FREE_AND_NULL(s->slabs);
+	FREE_AND_NULL(*s_);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
diff --git a/alloc.h b/alloc.h
index 3f4a0ad310..87a47a9709 100644
--- a/alloc.h
+++ b/alloc.h
@@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
+struct alloc_state *alloc_state_alloc(void);
+void alloc_state_free_and_null(struct alloc_state **s_);
 
 #endif
diff --git a/object.c b/object.c
index c1553ee433..986114a6db 100644
--- a/object.c
+++ b/object.c
@@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 
 	o->repo = repo;
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
-
+	o->blob_state = alloc_state_alloc();
+	o->tree_state = alloc_state_alloc();
+	o->commit_state = alloc_state_alloc();
+	o->tag_state = alloc_state_alloc();
+	o->object_state = alloc_state_alloc();
 	o->is_shallow = -1;
 	CALLOC_ARRAY(o->shallow_stat, 1);
 
@@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	o->buffer_slab = NULL;
 
 	parsed_object_pool_reset_commit_grafts(o);
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	alloc_state_free_and_null(&o->blob_state);
+	alloc_state_free_and_null(&o->tree_state);
+	alloc_state_free_and_null(&o->commit_state);
+	alloc_state_free_and_null(&o->tag_state);
+	alloc_state_free_and_null(&o->object_state);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
