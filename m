Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29BD2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209943; cv=none; b=KDFTGGH4CxgudSSb9cf9VM3VaKI8LYDMijFoZgTSIMpt/QFfvGZ8ceJJzWpbhoRoMZq1yiHZLgTaEcRpksNMfl2v7D6ygTp6Pu8r/KlMqskdKdLBnhUtL+42Fk8izPJzZPVfdiIOjvuwoTBMAawu2p1o5tvjaw05Ehn4NShCkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209943; c=relaxed/simple;
	bh=RJ+/KtB4oHuOOWTrleOLNBPb2UDAx7GKq2u9+tKiwdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOFrzvNoDtwMlZ+EfnF7HinHEQwbybRnuRzr8Is3qrD+tO6E5Pjnal6lyJmR6zLAA8DxddUcKEvWkbnAIN3FMnyQH5x5mfVpVjV27NqtpRA1fiONTRt1zTeYzxIZIcXCMNw8xvV9r0Sshl2fys2oxJB7a4Cu2jOZ/kZmwi8h0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Idp/CcMD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idp/CcMD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216281bc30fso8216335ad.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209940; x=1738814740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+rQIqQi9bILdJ/YeMf5sG6gz5qveqPPh1jQvi84pNA=;
        b=Idp/CcMD7/16NAb0+yArtc7eEdJ/a1JsB2TnEA/6v1Hr0q31odwjiN40hGdomJbVSj
         tHiANocfbDBGyOfaBLPW6hQ78zUXnInYLnK58fNQfiN1MX+CzkEverOm1qaXcHyg/0fo
         1UQHwr5LrP7kFZt5pxHXBTsHrbW7wSQGm03HlagryCwkKG2Clu8ITqW5vtrqsbqytuij
         pQ7bU8hnQEmywSHJl2XyRVGKn9Ck2VZXYPIhi3zJFrEZt9UM3Ap2alSFHsmIuOF8WllC
         MEwBrnQyMcHBPN5nBY17w3O5YDVBQTaNTZi1k0R6mGL1zXoPAEyKA+u79TkHREeMd1I8
         ROdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209940; x=1738814740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+rQIqQi9bILdJ/YeMf5sG6gz5qveqPPh1jQvi84pNA=;
        b=gaNuUYqY7i7TeiPwHBvk/vv4w1gvlysK64FNJYNFdIYtpnL3UItFKStiXxYTTbMheZ
         0VqcJQZqDxCk0OKuY138xxXcdts0KI31WcG7MQb21puT6Bc5EX3/+nE2abH90VE9/tKY
         bTAGvCLAC4aZnF9lTjIowLzHo1kUqjiRWxXm9zE/TeyH+P4BwNiI9DIY5izmvW6xoJpS
         6j8E426Xq0uGRzh9FYLhCQJjbGjJXKlgZ2n/GrAN/UjFnkMUST16PvJF7Uy10WDnR79j
         EA6qeLLg+ldsh+6tTq+qjEQX5eSnuQijA0g3gfTFYNRKuMJd708TMjh8CaC7ZVHchh3R
         sHgA==
X-Gm-Message-State: AOJu0YyOmpG9Can9PVcNclebScCvSvNE6g0L494PCjHwr481cdpvhBTH
	ofjl2Y2JABORDvjtJks1gn7B4iVXjl4tbhCTDaUrXzCnTdDjrJyRJYmn537A
X-Gm-Gg: ASbGncsbe1pg153gRv2ugN04sLeL50nJ//8ZAlJ4TdKmbRsHTxNsQRc4bu02W46jT1g
	Sr1hiXIqrI1FNvmf1uekKH2lWLSBxiD9CJrcSaEHOwuGi7wILyoWuwTEUBFOfoBxSMG2fMKVFz0
	tvVWIK0wjY4C0Szyt0D5QMZdT2Dcdv4STFQMUECSzJaWK/xvtsRVEBKAgQMG6nZWk7aowTID+WK
	XmUsGqkE/UcemKegYR5lpP0W5r8yqdrjcuymzcKAF8syjM5rJEUhEvUAW0keNSK8HdgBw==
X-Google-Smtp-Source: AGHT+IHzTC7MbP/qbAv7y1qrFsB0Pqf4MhuOFR+ZH+hvfuGrc0iGUu0VVoR5pVDCWDE91H/g1/Ixdg==
X-Received: by 2002:a17:902:ccc2:b0:21a:8d8c:450d with SMTP id d9443c01a7336-21dd7df960cmr96261525ad.53.1738209939857;
        Wed, 29 Jan 2025 20:05:39 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de33007f1sm4018245ad.174.2025.01.29.20.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:05:39 -0800 (PST)
Date: Thu, 30 Jan 2025 12:07:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/8] builtin/refs: get worktrees without reading head info
Message-ID: <Z5r679AyETgMO5Ge@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

In "packed-backend.c", there are some functions such as "create_snapshot"
and "next_record" which would check the correctness of the content of
the "packed-ref" file. When anything is bad, the program will die.

It may seem that we have nothing relevant to above feature, because we
are going to read and parse the raw "packed-ref" file without creating
the snapshot and using the ref iterator to check the consistency.

However, when using "get_worktrees" in "builtin/refs", we would parse
the "HEAD" information. If the referent of the "HEAD" is inside the
"packed-ref", we will call "create_snapshot" function to parse the
"packed-ref" to get the information. No matter whether the entry of
"HEAD" in "packed-ref" is correct, "create_snapshot" would call
"verify_buffer_safe" to check whether there is a newline in the last
line of the file. If not, the program will die.

Although this behavior has no harm for the program, it will
short-circuit the program. When the users execute "git refs verify" or
"git fsck", we don't want to simply die the program but rather show the
warnings or errors as many as possible to info the users. So, we should
avoid reading the head info.

Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
worktrees, 2023-12-29), we have introduced a function
"get_worktrees_internal" which allows us to get worktrees without
reading head info.

Create a new exposed function "get_worktrees_without_reading_head", then
replace the "get_worktrees" in "builtin/refs" with the new created
function.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c | 2 +-
 worktree.c     | 5 +++++
 worktree.h     | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index a29f195834..55ff5dae11 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
 		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
 				 &fsck_refs_options, worktrees[i]);
diff --git a/worktree.c b/worktree.c
index 248bbb39d4..89b7d86cef 100644
--- a/worktree.c
+++ b/worktree.c
@@ -175,6 +175,11 @@ struct worktree **get_worktrees(void)
 	return get_worktrees_internal(0);
 }
 
+struct worktree **get_worktrees_without_reading_head(void)
+{
+	return get_worktrees_internal(1);
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index 38145df80f..1ba4a161a0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,12 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but does not read HEAD. This is useful when checking
+ * the consistency, as reading HEAD may not be necessary.
+ */
+struct worktree **get_worktrees_without_reading_head(void);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-- 
2.48.1

