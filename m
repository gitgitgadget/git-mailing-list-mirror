Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632833DEDD
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824768; cv=none; b=tl5xiTerETzHbxgZMMTsCrfoNPNpj/p32Fb9Lp1seM5qsZqUnz7ik4wamzCUo39Z9ZCiphhmsNeT6Jjsxx3/7YdzBKQLPqymBeKqaQjg+HWLxhR+N7kj74vDKlw7jB4peLRHv4bF1hZxPj9BNola96BHkLNWAEGsa9AzjDTsRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824768; c=relaxed/simple;
	bh=szkwaHBzsWFaMq6d45uQqnvkNySFsVlpnCS8j/eeB0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2NLmPptYn3Fs9kelMgGPRbQ+SUYkWrzlThnxCavktiOeqWu95vqRvdB44GsAclst8AWEztdGwVv2onOdp/H/zMoS3CI/peNcH7dM/0y21LhvN9BVy31CO50Qut44C2ZXSus9bVy0Ympn2pG15NLZrTv0qdpfYzLHYGqPYp22rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7TjLLpw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7TjLLpw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7422399586so142614a12.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824766; x=1774429566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOydFPPIo4A6FoZykjastN7S9753B0+CYIGzSmmPFYM=;
        b=P7TjLLpwUWYXZnn3UEP7TGvBMRQtz5mYtB21QqQK7GVJ4lxntlEDAqMfXhDFT9I198
         /1XeU9WNrwAKt9EVpmjysZX5EZvwGZbL9ZCMQMAIlODkMBYkzqSvrGXR2fV1DeBfKqDt
         eiuBYXkw2YNnwEbp0H6FQVzsN/h5lCyQxv6fieCitymdYzo9IjpLoED756kuk+PJ0QxX
         ny3p3fQNs0JAJ66Mwj6qn3Q6M4j8pGqDVFz71Yp0bEb+HMN8QAqjQNBvMZXAAkB7c7di
         HTa+acccAp8rxI4/vnY/jNbNlSfMN4p1RaqYxGxoUwe79rlPfOXCIS4i5QomxNB5ful5
         3Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824766; x=1774429566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOydFPPIo4A6FoZykjastN7S9753B0+CYIGzSmmPFYM=;
        b=OUU0nzP2WJ9+CNUKw6bDBePURdwj/Ct2W7ed9fZ9FDxVYxuF+mBj8QrhYCq4mrZO5k
         Un5/ire1NFDcxeVXw+l2XNgX0Sf6jKAyX3begP8PUTu5D3ul3uN6s0PWQ+LqxPN4z/j6
         u314boZZdrnxx2dbNnL1nnmIkdp3yS/YK5618iWJLit+RhtyiR6mpxh8Pq5tKFJfOA+V
         WCgeD0G6nULSaB+yNPeoQO3iwqJcYt/bUc8mqGVzIeq/nxqm068X/WKARnca1o+kyz87
         MHgBOeUp1TEntQ4sFT8sW+43Wh3K2bYjqX5DQ0vNbe9bJTOtAFbN4+8sAe39yVcDLZzk
         i3IQ==
X-Gm-Message-State: AOJu0Yw7RwZ2ERdSRbN+B2ITc73fp4SCmejh1c+g4ObF8KkCK9yCrSsh
	Yds+vbeDX/4W40dGHs8X3ustj/wo404UC0lrv02uIeqkyj0ilf3f0k6sBKpyhA==
X-Gm-Gg: ATEYQzzCNwGN4pBwoG6NrJfss6IoFr+unT8SRyEKxOyUAa8u3pmsHmavVfWK/ZG9g3+
	cx9WOh1Ts9C7Zrp1TCQJd49nHQoYAKYbbMeYIG+FE+QoZ9VtM7c27ay2qcB2BsGR2b8c8wWzHyC
	Qx0hkmAt5pqfLlQeAPTyuvfKJJEnV79lanhctZabAEELupKGCwkTDPqlLSRUFJSGwa4fP96VLiS
	VuvByyBdsUXyAv39KxNJ5/3HIgu/gS5VdxXOzUXxTJK65ZqmJ70o6paEdBSK4vtxYgLWmJ4/K2e
	1WdAt8I43fDrEp+MJ25GTW1GoXrFREnKp+BHW38qUC17BBJvEw5AIl21dUvG03e9nnJ8np8iqLc
	B9gCRvGo5fB4v7Xfof7ezCMzP3CrGxM3tJbTKrhJuanb56WYj39Ubu9e7W9ESayLKMXMBSTbCG5
	5R0QtZdW1vSPFr/EfrjVWOjaTEVewzjCTmmGazNYz4YOo=
X-Received: by 2002:a05:6300:6705:b0:38d:ec8c:7e55 with SMTP id adf61e73a8af0-39b99f67d91mr2326587637.32.1773824766312;
        Wed, 18 Mar 2026 02:06:06 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:4c9f:17e6:42d9:c5c6:178b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e568e36sm1947750a12.23.2026.03.18.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:06:05 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 ] add-patch: use repository instance from add_p_state instead of the_repository
Date: Wed, 18 Mar 2026 14:30:03 +0530
Message-ID: <20260318090546.1213077-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
the_repository even though a repository instance is already available via
struct add_p_state *s.
Use 's->r' instead of the_repository to avoid relying on global state.
All callers pass a valid add_p_state and this does not change any behavior.

This follows recent refactoring that removed 'add_i_state' and moved
repository pointer and other add-patch config into struct add_p_state [1].
This aligns with the ongoing effort to reduce usage of the_repository
global state.

[1]- https://lore.kernel.org/git/20260302-pks-history-split-v1-3-444fc987a324@pks.im/

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
Changes in v2:
 - made changes on top of ps/history-split and used s->r instead of s->s.r

 add-patch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 4e28e5c187..f27edcbe8d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -558,8 +558,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args,
 			    /* could be on an unborn branch */
 			    !strcmp("HEAD", s->revision) &&
-			    repo_get_oid(the_repository, "HEAD", &oid) ?
-			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
+			    repo_get_oid(s->r, "HEAD", &oid) ?
+			    empty_tree_oid_hex(s->r->hash_algo) : s->revision);
 	}
 	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
@@ -1271,7 +1271,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"removed, then the edit is\n"
 				"aborted and the hunk is left unchanged.\n"));

-	if (strbuf_edit_interactively(the_repository, &s->buf,
+	if (strbuf_edit_interactively(s->r, &s->buf,
 				      "addp-hunk-edit.diff", NULL) < 0)
 		return -1;

@@ -1679,7 +1679,7 @@ static size_t patch_update_file(struct add_p_state *s,
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
 				if (use_pager) {
-					setup_pager(the_repository);
+					setup_pager(s->r);
 					sigchain_push(SIGPIPE, SIG_IGN);
 				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
--
2.53.0

