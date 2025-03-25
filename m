Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D0537E9
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864136; cv=none; b=Xt2imqhr1+DiteLcYlmNi9OeAfUG/AQfYJLeccMD39u6VdhI4QD3l5EnKbhCxmbZj/NAhtC7NpDHcfS8hXm81AEWrYbZFtzYvla5aahxUnAjB406U4iUxq8/rHPu3BLG7dEj8YIe1eokcsTGVt5Mp1CKF2QOgg0nb4nHhvBjvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864136; c=relaxed/simple;
	bh=2eJ5BNzH7tcDLGBs/snwtQo8y1maOrZY1ER0CmgvYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKqfBPhkmoXEqefgEyzUm8DKnhCDt3D2URlnZS/t6oC+SeBMy2JzbPw3g8UWY9t5KbCuG0DvQikP4Bo0fZrEZiWMq0sGkeOTRjdyHkkxhp93I59YVbYNvNb6i68GWsEXAOYroyjGBfeF1gwlW6K8rQKuF8tVCi47c7yc3R8PD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsHygbUJ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsHygbUJ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c16e658f4so982376a34.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742864133; x=1743468933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSbO26uzvg2PRdA73hjAzjaq9HGkRU+Bx+FlwdjiTlI=;
        b=nsHygbUJ0aPIIFY6IweSQVZyKUK9aYbe/AjDpl7EktGDUENsTTXYGaLy0Ahdl2Ss06
         a0ADqO/ptyGh5TvZI+PH8iqdGHYDQa5dJrOyoxc+PlTxZF2SzcNhqkKzxISq9NBOv2B+
         +DF6TGR5lA0vpKYFaEzAuWXUw+VXYxkYVjfDzL6E0gSRI/umDiZq+Ij5Kkrb3CUN+BPr
         V+gXeYV0oHCbpVvLhiQj46pb3XZi3ZbvMKDSesOWUiE91+HC4egcW6KZieqHhHjBOCNt
         NNaQ8GTfvUJp40I9PeoZ7uoq8mVeP6NeHOmwoGWV8InsZ3co86cjXhpjgEgmWZ2RL7SL
         Ulhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864133; x=1743468933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSbO26uzvg2PRdA73hjAzjaq9HGkRU+Bx+FlwdjiTlI=;
        b=Y7iqiOFtzAwE5j/rJp+agVueWavS7/I1DKbv3sM23Rqrl8NjPL45v6jnyp64Gwi1+S
         5fFf0utrJ6LRpi0xLTarhRy6mv46rRDRAgJxNupXCfCyLLghuMCPXWmE4lwPLrR+hSa4
         HjYohAwOmhhBTLLuz6L7WytOJsV3LNEr3rbIgCS2waAyU8srGOMFP9wiYFhcg2Gk1Zfn
         0n7Te9m5azVs29h6xm8JuLY5ecbtv/Sm35y1cmpO/Ni3OMRk82X0Toa0TmDQ6r/oxiJP
         4jZgCRcSiSUyVqUjGqeI2i2/y+dneHH5QEptirEc0Ft1/KilvwltyLTly8eV2CWa1vVK
         SNtw==
X-Gm-Message-State: AOJu0YziLPyXo/Bwcgz+R8l35tHtwWbbf3Xqh/GeW4YpXB8B1enpUujH
	CtrhryMAsT5hqkrk+qpX1csZ76AL0erO5NUzFp/bvhMl/UIefaH36NJIPA==
X-Gm-Gg: ASbGncu+dyaT3t92sIDeMGMkdUkahtw9+sLSt23o7syn9UnIbQscVRUCW/1TEdVlqnG
	zbO1YzA6puORRAJZnkczt+KRyutFg1DoY+zpRF/qAk7wVvuC3qmWUxMRbJ+Tzk5BpHlnPd6sYew
	yA9rZejdK9eYg+LfHkQGgvkBoskgS0j/bunPL820G9yPus0yS3bP8l/aCw13snhoCOpy+A0JE+8
	LHjQTyzROJti3iCtJvakcwjvWzH/SK2zsfdXYqgD9MDimNzO1al/MiBO8/gekHlvXRl4GIqTyHU
	LtTpEAX0rN5Mjscws/RO0ISRbSv5JiXG6mTajEYqMuzZ0X5JPBWW
X-Google-Smtp-Source: AGHT+IHOLnMeCfxdYkwIYs0cIrjzGUu+39X5haWbyP7Dx37cd89gSZyy1yHq8FXZgcyqgCBHkOvWKw==
X-Received: by 2002:a05:6830:3c05:b0:72b:87bd:ad5b with SMTP id 46e09a7af769-72c0ae5061bmr9975028a34.4.1742864132880;
        Mon, 24 Mar 2025 17:55:32 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac7bbafsm1735316a34.65.2025.03.24.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:55:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/3] remote: allow `guess_remote_head()` to suppress advice
Date: Mon, 24 Mar 2025 19:51:46 -0500
Message-ID: <20250325005148.1771502-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325005148.1771502-1-jltobler@gmail.com>
References: <20250321231639.180762-1-jltobler@gmail.com>
 <20250325005148.1771502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `repo_default_branch_name()` invoked through `guess_remote_head()`
is configured to always display the default branch advice message.

Adapt `guess_remote_head()` to accept flags and convert the `all`
parameter to a flag. Add the `REMOTE_GUESS_HEAD_QUIET` flag to to enable
suppression of advice messages. Call sites are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/fetch.c  |  2 +-
 builtin/remote.c |  2 +-
 remote.c         | 10 ++++++----
 remote.h         | 11 +++++++----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b9..763314bfcb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1638,7 +1638,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
-				    fetch_map, 1);
+				    fetch_map, REMOTE_GUESS_HEAD_ALL);
 	for (ref = matches; ref; ref = ref->next) {
 		string_list_append(&heads, strip_refshead(ref->name));
 	}
diff --git a/builtin/remote.c b/builtin/remote.c
index 1b7aad8838..d2aeb5ba1f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -511,7 +511,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
-				    fetch_map, 1);
+				    fetch_map, REMOTE_GUESS_HEAD_ALL);
 	for (ref = matches; ref; ref = ref->next)
 		string_list_append(&states->heads, abbrev_branch(ref->name));
 
diff --git a/remote.c b/remote.c
index e609cf5c56..1db88beaf3 100644
--- a/remote.c
+++ b/remote.c
@@ -2297,7 +2297,7 @@ struct ref *get_local_heads(void)
 
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
-			      int all)
+			      unsigned flags)
 {
 	const struct ref *r;
 	struct ref *list = NULL;
@@ -2315,8 +2315,10 @@ struct ref *guess_remote_head(const struct ref *head,
 		return copy_ref(find_ref_by_name(refs, head->symref));
 
 	/* If a remote branch exists with the default branch name, let's use it. */
-	if (!all) {
-		char *default_branch = repo_default_branch_name(the_repository, 0);
+	if (!(flags & REMOTE_GUESS_HEAD_ALL)) {
+		char *default_branch =
+			repo_default_branch_name(the_repository,
+						 flags & REMOTE_GUESS_HEAD_QUIET);
 		char *ref = xstrfmt("refs/heads/%s", default_branch);
 
 		r = find_ref_by_name(refs, ref);
@@ -2339,7 +2341,7 @@ struct ref *guess_remote_head(const struct ref *head,
 		    oideq(&r->old_oid, &head->old_oid)) {
 			*tail = copy_ref(r);
 			tail = &((*tail)->next);
-			if (!all)
+			if (!(flags & REMOTE_GUESS_HEAD_ALL))
 				break;
 		}
 	}
diff --git a/remote.h b/remote.h
index 6be5031f64..7e4943ae3a 100644
--- a/remote.h
+++ b/remote.h
@@ -387,15 +387,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 int show_divergence_advice);
 
 struct ref *get_local_heads(void);
+
 /*
  * Find refs from a list which are likely to be pointed to by the given HEAD
- * ref. If 'all' is false, returns the most likely ref; otherwise, returns a
- * list of all candidate refs. If no match is found (or 'head' is NULL),
- * returns NULL. All returns are newly allocated and should be freed.
+ * ref. If REMOTE_GUESS_HEAD_ALL is set, return a list of all candidate refs;
+ * otherwise, return the most likely ref. If no match is found (or 'head' is
+ * NULL), returns NULL. All returns are newly allocated and should be freed.
  */
+#define REMOTE_GUESS_HEAD_ALL	(1 << 0)
+#define REMOTE_GUESS_HEAD_QUIET (1 << 1)
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
-			      int all);
+			      unsigned flags);
 
 /* Return refs which no longer exist on remote */
 struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
-- 
2.49.0

