Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56B78F35
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508743; cv=none; b=AZWRpu/bsxJ8DAnmf55yoFo51gG3ywfrgtSIYW4j+BEgPo1fGAY814VJzkyRznXKy0Mft7WL3KSNjOOGGQ7itTwPrLpbIljm8zQDILY/lFDFsCFtAeZk9BM4FyHrCOIsyJegfzYLR4KB2k2Nux6bjM3y1CJfTuTDLHTIuEqLnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508743; c=relaxed/simple;
	bh=Pw3z9o+kUxJpZxKRgSvXpacK5lCJj5GH/n7+SaPqQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3/7NQYC5CCkRrkUX93Wmr1FZTf+bdf52cxI0nhvrvrF5hdNqkHvvj2MONGUSHAdC0Jh4w28tTfdazJZCTE5ejOpogZisRxFXJhyIab2eTaHGD1c7VUWntjl1SqKXh+41DLJooovIFuYNlOIUuvsOEqDyDIUEEXlFRvz5hUT3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klbpi4LO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klbpi4LO"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f9c6d147edso15596917b3.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508740; x=1740113540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Qe1T9rOx9zjzY4gdVYk5gvUXaPpIeOaRjiZtE7aaY=;
        b=Klbpi4LOSrQUFmtjg+reRIJM3NEPtZO4yt54wA2sm8zJ/YvliQI1xqGGBgNVb16roY
         sYG8lottg+DveFrxbEcKnGVb4l6acl1K9ZpkRhZpbv/CBWcRjpUNbm2Gk2G592fGoM8E
         L1CNtWMe8P6nAxiumTdTkyfkZkXl+FByNC+/imc0T6z6bG9QiDg854ZA7ZAmnd3BdrTk
         Q66aR/pUB4tm6XAuI0xiqLn/1NTssS2Ta9bdUXurbwzGoxICXds80kP/jBXwOX3Bxdsp
         bD6kO4V9YaiuW+t342xsCgiea9hvgfETgc0tx623YW/qHnQavNck/uvlH2SgZBNvQC20
         eK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508740; x=1740113540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1Qe1T9rOx9zjzY4gdVYk5gvUXaPpIeOaRjiZtE7aaY=;
        b=LYsngaRgnp9voCtQoGetCejURt4HLHkX+SEdESD60EVVuy6gbZ3Z/rrue6rmwNooM3
         wkFAAn+tMZ9Cv6y044fovXBzkalX9jRXz1nECnv+QdRGNMxTb3zWj69xX1HqVayY+5/J
         aIJ6MXyaOB9HagczXQR6WxjRF0lKBCsehW265DGACKePv6LJrOJYqQTdtOUkJBD25LiC
         DOUFxE3ql/ZoQ5pkVn8ZIyTHJCf3pIAJjeRWikp6OqZU3HxtuZas/7W9TqBNIBcxuM4P
         4zWgmWvPp/ivjmbTppgO+7+aVE34L+Atd64gWnxwwoABN2vHKR+q9ya0gxjv2ORH+n2R
         YT3A==
X-Gm-Message-State: AOJu0YxBvUb8X6ah+CR0KAnLj3ffbHdRfkDHUad+XKNcW9aLNw04Yv0R
	pzXQw/h5kGHJA677WAjp/YZL9hBUjnMn3lmWrG+Y+tPskCLou3H80g0hJSkC
X-Gm-Gg: ASbGncv3S3mluoIPuOxrfjojj4lAG+K+T7Wde1ks8i8K2WPA0oRL/Id8sIW1CZ3ogkz
	jdnIMp/UvFwPBC0NXqG6Ibqa1BGa0K9KlxIj0V9UyFcaODIhKWaW1Hr7KJJpsArfB2j9sSzYP4P
	U0CEpZARqCVRZubCQJL+h8gN9Kn516zGVMbdrT2/Fw42SYD+k9wmcwwbsGwoN6R29OSHgDxw8PO
	SXAcs7oNdm1cuMY6tstcAwWgENBrHKpHi30w6BlXWHV+QfLcjbZwxF2D9LGQmzR6VXWhg==
X-Google-Smtp-Source: AGHT+IHieUjAeb932Wst7bHhZGSZrEgiCCTXjlu8tnyC7En7whkN6VgT+DQBk9+fmk4tfK8fxmIipQ==
X-Received: by 2002:a05:690c:6911:b0:6f9:ad48:a3c7 with SMTP id 00721157ae682-6fb1f1e5e09mr94842957b3.21.1739508740305;
        Thu, 13 Feb 2025 20:52:20 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dade8aa10sm803879276.12.2025.02.13.20.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:52:19 -0800 (PST)
Date: Fri, 14 Feb 2025 12:52:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 2/8] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z67L_lmCd6NNXpWZ@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

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
"git fsck", we should avoid reading the head information, which may
execute the read operation in packed backend with stricter checks to die
the program. Instead, we should continue to check other parts of the
"packed-refs" file completely.

Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
worktrees, 2023-12-29), we have introduced a function
"get_worktrees_internal" which allows us to get worktrees without
reading head information.

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

