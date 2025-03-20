Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950221C32FF
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437310; cv=none; b=eX6mUfe2NhuzYVr1QkOmZvhAbvpYHzLGZcyqKAIOV/3rPzuE0rpLxK0fSSMd9dgceHoKv9V2YbXRrCk2lhngKl0n04z6vLfGYWvYxnUk1QJyRvjvF+tUoV+8z4UU6yFL/Xbry1U+Kz30VeDwpxCf+38lGCNsofED/umWxU0BsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437310; c=relaxed/simple;
	bh=3asnbd2DSUxU34V/pyMZP2e0kZkB4MxoMUdw1izAH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLnL73ZjN5XyrzUdaU8MIB2YTprNiIiWMs+/jc5/EinhVrnuvpHQPgL2D0nl/0So4eC00ZwygYN8hIZ/ePPR2Tx9DKt4SXG0aXcMSbI8GhWuGCrT5p/ZOCE62orIltDZloku1Odez68h4cn6NJ+DLCjBBlSzoY5jvLEmBM8n9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu54YigG; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu54YigG"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7273b0d4409so90196a34.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 19:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742437307; x=1743042107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNHnw4OKnproYsPdwqg16BrbgkiRL+ay8d04xCUG7ME=;
        b=hu54YigGFnSwhc8t1E5AGBUQAU9QOcycV1KRemuXyMJytPA140cEsqWSbY3ct13tMC
         G22xfoua6edNLrcHkGIdJ9Hz0fUJlONqvm8softWkThz+tIeBad78mgUVmy4neMl4u0n
         1MxgG6O1ixyU97pcTQvkRyCDkTNmC2Lv8FplYfH6DNkTSTJqOlqR/eF2jIEwCmoHetLR
         vNXQbGVLQH9ObzMT1gBKhhXp3/HphrvM4rk0WkjocIzeV4gTLpNesZbuh/Hv+MHCrYck
         4ZJNlzWJ/Vq4+aE7lwrARZW54AFNeCJJYHNKa8SO+JGcQ7AzUoP88XTCqP+P3UdGKnLL
         Cqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742437307; x=1743042107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNHnw4OKnproYsPdwqg16BrbgkiRL+ay8d04xCUG7ME=;
        b=oANu52wazlEWOQLJxmeF1gDVhcZQXk8xPJWMc8WDGm2pw90k5OEVsyEMEaIgNjEInw
         JMDJXN2hrbuKSFEEQ7QlrLHRdjhQR4d2Zn6zaPOkblshzvZwdgh7qLfdoUQyobB3USXR
         WtDapP8xXIih1Ykm/BGHybVAKRZFNIAQ+GJI8PijjUIWm28W2+kXgDvkOrSTPKPGhX3b
         vxP+jEDHqDuJ9QtWiUIjlHjtR6sx2PjmqXP4UYpbXlJOGatMhBxgLWBRdHUXbaMa7MwV
         C6nZm+o68/eIkbwhNUHoT8OYA6oafsPs+LRaSH8Dr4I5LqOWWoHGk2GSLzW7s+VHWMdh
         7bSw==
X-Gm-Message-State: AOJu0YzoEGAMXFdfIYP+zD/VC0e/uTPerGRwYGnzeWJY/h6nm/Pb/wAx
	yHz9ygyDoYGy/XHaH/uIaCK4O1mMVP/n9F+wLZ5BELL8ZUcGdqNq9J5MEA==
X-Gm-Gg: ASbGncs4z9TOFarreKVT9CQEPdhmIth74LpPkPu38sRuXu8MJsj40q96E+w7jZWo+4q
	9vofxh/7svz+j/+obTMCz2WbwdHStkWRr4cwWT/DYxcxitLOscscKIpG/ereh/7YZo6wNPzCYwG
	NhFqyy+JukXA2Wf9kFq88eD3SZ8U6YWLKsPbNtOmbKyRXbvu7Tp+RoDpQ0FiowKizYx8ff1jhqm
	mtvrKopaWPX3RKX27Cd95DNMhLfsME0oPfNW4MwJPOA5YxXXLB+FwSeCHiZMd7DmBSdZQ2u/VO2
	aAzF0ZuJ4faTnlLhDmcz6KjRwKeUx5AA2b5e1pV0HyF5wTofmWwk3gJ7W1r7IRY=
X-Google-Smtp-Source: AGHT+IG1NJduesT0sW7xU0AArQsrYorX1P+gjqtPHkHZEF1L3ZpUxmcK8+l53nxJA9CJEZmflbdynw==
X-Received: by 2002:a05:6830:3c0a:b0:72b:8974:e3e6 with SMTP id 46e09a7af769-72bfbf525a3mr4739968a34.28.1742437307282;
        Wed, 19 Mar 2025 19:21:47 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601ff46adcdsm1549579eaf.10.2025.03.19.19.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:21:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] remote: allow `guess_remote_head()` to suppress advice
Date: Wed, 19 Mar 2025 20:46:45 -0500
Message-ID: <20250320014646.2899791-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320014646.2899791-1-jltobler@gmail.com>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `repo_default_branch_name()` invoked through `guess_remote_head()`
is configured to always display the default branch advice message.

Add an additional parameter to the `guess_remote_head()` function
signature to enable suppression of advice messages and update call sites
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/clone.c  | 4 ++--
 builtin/fetch.c  | 2 +-
 builtin/remote.c | 2 +-
 remote.c         | 4 ++--
 remote.h         | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f14229abf4..9eb66234bc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -450,7 +450,7 @@ static struct ref *wanted_peer_refs(struct clone_opts *opts,
 		if (head)
 			tail_link_ref(head, &tail);
 		if (option_single_branch)
-			refs = to_free = guess_remote_head(head, refs, 0);
+			refs = to_free = guess_remote_head(head, refs, 0, 0);
 	} else if (option_single_branch) {
 		local_refs = NULL;
 		tail = &local_refs;
@@ -1523,7 +1523,7 @@ int cmd_clone(int argc,
 	}
 
 	remote_head = find_ref_by_name(refs, "HEAD");
-	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
+	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 0);
 
 	if (option_branch) {
 		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b9..a4f5b3e683 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1638,7 +1638,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
-				    fetch_map, 1);
+				    fetch_map, 1, 0);
 	for (ref = matches; ref; ref = ref->next) {
 		string_list_append(&heads, strip_refshead(ref->name));
 	}
diff --git a/builtin/remote.c b/builtin/remote.c
index 1b7aad8838..ebd1a796d2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -511,7 +511,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
-				    fetch_map, 1);
+				    fetch_map, 1, 0);
 	for (ref = matches; ref; ref = ref->next)
 		string_list_append(&states->heads, abbrev_branch(ref->name));
 
diff --git a/remote.c b/remote.c
index e609cf5c56..e9e55ecdbf 100644
--- a/remote.c
+++ b/remote.c
@@ -2297,7 +2297,7 @@ struct ref *get_local_heads(void)
 
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
-			      int all)
+			      int all, int quiet)
 {
 	const struct ref *r;
 	struct ref *list = NULL;
@@ -2316,7 +2316,7 @@ struct ref *guess_remote_head(const struct ref *head,
 
 	/* If a remote branch exists with the default branch name, let's use it. */
 	if (!all) {
-		char *default_branch = repo_default_branch_name(the_repository, 0);
+		char *default_branch = repo_default_branch_name(the_repository, quiet);
 		char *ref = xstrfmt("refs/heads/%s", default_branch);
 
 		r = find_ref_by_name(refs, ref);
diff --git a/remote.h b/remote.h
index 6be5031f64..49c7b644bb 100644
--- a/remote.h
+++ b/remote.h
@@ -395,7 +395,7 @@ struct ref *get_local_heads(void);
  */
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
-			      int all);
+			      int all, int quiet);
 
 /* Return refs which no longer exist on remote */
 struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
-- 
2.49.0

