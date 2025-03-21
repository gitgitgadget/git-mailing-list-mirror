Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05911EB9E5
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599237; cv=none; b=afXYuAXpLvAxYpg28iLGTkSG9iQESsTs4SeT1Wfkpm6BThvKYoEOv66Je/dSpC/1pdSdG30ABptm34Lkie3Ly3k6Aq+HLhDrmGB2y8EQrRZ9LDNv+8Qv9sqSrDpHxpfOqHNQ7L8BvkLwqy9W4dATq0Lg5f2FWaTtYtg+BIDt96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599237; c=relaxed/simple;
	bh=2eJ5BNzH7tcDLGBs/snwtQo8y1maOrZY1ER0CmgvYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxBzbx4rHgKsPQALpLEHjgvYaiJ3Bw+1m1zOap0loBXhxFn7PxjbBOdXvFf+DAZyDt/fgtlPAsdynU+zQO1V7dXRvzhekWAQIFQLgzJE7wIWk2LBDjp3daHbrg4UsElX9ImIxM6NIJZSsyz855r4XGN59pMSj6TWiUWo5AefUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGtYWzft; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGtYWzft"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bd5f25ea6so733440a34.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742599233; x=1743204033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSbO26uzvg2PRdA73hjAzjaq9HGkRU+Bx+FlwdjiTlI=;
        b=eGtYWzftbHUcwJcb5B45Oo5ZwxT242vvwlDTNnM1UTy02WxefzIXmXgVV6sUIlHSZG
         W6ABy/J2wT0RV1QSez0KUQB4ZfO/524wTrT0LZv+85eCMBgwFa/eIJHPW+Sh+J6YVQVs
         8IGKOX6cuSX0D+j1UP7SX4e2z28OvLbvcnXAf49kvCOLZAWliHTES8R9JDN6yBiHBh2z
         0xAliPw5olZq8hfqstmR5ektHr9mEGL46SwUe3NfoaUvDL3bYLPQoTJ7TdKisaubODJF
         T5issTBA7D74bvBniuE68QE3TgCHvLOOF1HNaYTFkKeLEgy4LuWSQDJlbNi3UDl6/rHT
         Fo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599233; x=1743204033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSbO26uzvg2PRdA73hjAzjaq9HGkRU+Bx+FlwdjiTlI=;
        b=jhFD7oP2snzZGdYoA9wyKFTbtS7+vY7UYfmaH/4/MpFG2oI/msf6pOaXeZckxnf+dk
         WfoDFCxlxTYgFubuIxWFNNZvooSzR15mPGj3Vnad7X64kiyRfRxAo5ACnNaWDcbUjZon
         Q8Io/iwNFkYg3STQ+A8apKpRF5gVjzbN1RZPRtOSE17hEUtKD8OvHBDU4MY6U/uwpnNL
         x7wmnZOdS3COvTpUJ4IeqGskav1JhPLVbyx7cwgeGrh6Q9Byuw38jFEwyoYno3kM4Jz5
         NkYplz0GlT2qB0riLKh2nkTDyuprs38IM7C0OM2re3uleMt3Cgc1r4C9Dv2WlU31pyYL
         vIsg==
X-Gm-Message-State: AOJu0Ywy//QI1Fpk/R8FHmtiXxoKzTg0fLU/gk/H7TWgfLMO4eliKrVA
	DC6CwvSo+4jFtV9PZqwraiS6omhk4Zhwa9yoF2hNHuewHuQWKXFG1Chs4g==
X-Gm-Gg: ASbGncsdVR3F1EuDfIwPc/AGQm1WdMeh2YgEqGWECwmL0KZkoJ8h5eCBuNKzIm8ajJO
	0fyeCJSjGfgdlM4ezZ1NfJGxf9vjcAXyp4ibfXiHr27ZiuPGDOyPKT0S+5aamAsHQUsQdt6TzUU
	9lonQRq3mD6lf+c69yJFUL5b8JB3M6A+a6B80jiNHb5mrNV/DWpzxVQptK2M+WSCpkyaK/lQHEs
	rn80jCDr0leMFwQlhuWVd54uOHLSYCWv825vWFQ84/Fh6dQhVsS3JrE6zJZP0tISFrV2nD8RF4A
	U8fqkarBngvJOoeWmTT5HFK4kGMD8Eg+w6GpODiGxNwXiGQHuVUsbuN1Lb8hmDw=
X-Google-Smtp-Source: AGHT+IHKGH0wRdmMT+MyFKgvehJmRhrUFsSwP9OETE6ADX8hZdWdrxvOKzJMXxD6Xco7xvkaY06YHA==
X-Received: by 2002:a05:6870:8199:b0:29d:c624:7cad with SMTP id 586e51a60fabf-2c78026e8d6mr3363553fac.3.1742599233471;
        Fri, 21 Mar 2025 16:20:33 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0ed8easm715097fac.46.2025.03.21.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:20:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/3] remote: allow `guess_remote_head()` to suppress advice
Date: Fri, 21 Mar 2025 18:16:37 -0500
Message-ID: <20250321231639.180762-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321231639.180762-1-jltobler@gmail.com>
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
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

