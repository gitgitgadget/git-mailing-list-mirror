Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761782899
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349456; cv=none; b=ObBka/qI00vUerYwAl+Dt9gKlh6NAxW8enSkceUsn09yFq+UgqIPFG5YjGxJlsOCe/C5d5EULkKPw+Lsa7RATAKSGPgjqnsBTCQBumUGuzPNHUs2dlUuZK1yNOXIIN7l+3KcHgg7rRaJsN+GSV/UcA/fjEDy/+X9JBa2qw6ce78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349456; c=relaxed/simple;
	bh=mEQ+H5/+Aal7ANtY7elW6Yy9RqjIbKFXJv/vRVwK6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Erxi4kKqRPhZmNxZkTn1m9SKdMIKMMZ5gJCezZJKjFi8DXy9iGuBWD/7/8kLsvQ7Q8K+E1jIa5Xx3Y55PSMLeRtVU5ZyVLM9KSyLzBUqfMWO6RXWzeNOj32m7E6d2L6cXyoS2cf4ztaq9BrhDKXdWnZGpBEK6tfIR5fCX15WYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALY8YoM5; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALY8YoM5"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3562e858da5so1884062a91.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349454; x=1771954254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k1mOeiGF7LDWXAy09UgHlUdyTUZ1Vli9ukD832zZEQ=;
        b=ALY8YoM5cCrNp36JWvRaLhhKvPPkJrwyTNPttIu7/eZQd/NNGtOYms0LzDH2Qs7GLH
         tu1x8t9blQTwgNycRUCDIi6++vx+xtt/JdwpTsZDr1v+1XvI/x2pBW1VZwdNnBEsF+b3
         qwAimkins1wZsJ4b9QYJ8i7sCPjkwWjOZNKYckpab17gh+K4vSZGP8rEOqVhwpU6xmtI
         g1GBs2oVePU98STzhkmd+KDOtZ5wXDrYsrSMeQJRMyzPorozE6ZEFj4eRciMWioN1hi/
         uO8JhGxjhVRz3NEaLg9C6HzOUmCgcszVxdPU9NrdWECsh8BeW0QJ0b2Z33QyCOY6RW1L
         Z9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349454; x=1771954254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5k1mOeiGF7LDWXAy09UgHlUdyTUZ1Vli9ukD832zZEQ=;
        b=EYc+hflToGWf4GBABk9Oeh48Huc4g/U+QGqJTXr1aZhGtt+gRg6pgoyKR7eFV3BDTL
         SY1dP59gjPX7ff+aEDV23VE6AG7wp8WtFugQrG5YpskRVZ4eVpESz8tJCgnUQ67WJi2k
         D1CR8xsEhmGRq6ls8PdNlUuUCQcSOmnYWWkh5KJWNoNHf1it5tj4JMgI9iwKlh5fr66w
         K5UjVExHLlrkk9+FQpvj1+2CQNW5aYiNcQD2Rhm5U4WyJACD1wGVh/reVoF+wb2Gvet7
         tt3bhcwfmMvORgnFTT+Qo0iT8bZ1YKuDJio89lwkQDFfZPO1LxxCkCMjZGtvDfelA4iN
         pQJA==
X-Gm-Message-State: AOJu0YyXkVbr00Y66J4Cf8Mf80SqzYdMjjLOicMKAnXz3g6E9rGsMGUK
	uzN6Hx0qC5CMmU0lu8hcjhhaf5QhY1p9jnkdu1FQmfFAw2zqIyrG74hdUxfFMaWCFB5JYQ==
X-Gm-Gg: AZuq6aKIawd7wLOj2tAMlRIgaqtnrY0J50KuJFZ1msvJC74KCLI8I+G5c2CAr2tO8g3
	Z5sZl6IooPFRwv3qtNN/RyV8aABeb8ShvQFuzOzGzRmL/AohXUZ3GAH6ERXywuQPhgOcW6xcFZg
	LXAOXYZ/abYKqbVGczVxS+JPjgPGoL3QVJNafebdacjW6vVCmxlCugnuRF4fQs+9Wjbci+VLGZO
	HXC9URr/R+GkIIG8opKA27IfvKXBr0nkBHJqD+hAOOhE5aQwD1z2ZEpLBUcB3wTp2XugyPM/P4c
	45vylCMKKjOUY15XqhAA4lPyjDDr7ahLNm4l4iZVJnPOk6IzpFH1vjMdvCjU07weOiseN2ghxHf
	Fn8w+16poV5YtCG/usHLegwBdIdiLwqfNbFMommEZa3uZ7OAq3KtDgXFdKxbKKnX0gi8o8EF5zs
	RxlvA604nTh/toGgH9SdWbfqHdcodg4ZPlhUvShwQdWfH4zSgQVdDgJG+RGg==
X-Received: by 2002:a17:90a:e70b:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-35844f85dcemr9774731a91.24.1771349453885;
        Tue, 17 Feb 2026 09:30:53 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:a392:d36:fa44:db83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cd1esm24135222a91.15.2026.02.17.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:30:53 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 1/3] wt-status: pass struct repository through function parameters
Date: Tue, 17 Feb 2026 22:59:46 +0530
Message-ID: <20260217173037.63438-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions in wt-status.c (count_stash_entries(),
read_line_from_git_path(), abbrev_oid_in_line(), read_rebase_todolist())
do not have access to a local repository instance and rely on the_repository.

Add a struct repository *r parameter to these functions, and pass the local
repository through the callers where already they can access a local repository
instance either directly by struct repository *r or
by struct wt_state *s (s->repo).

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..e10565f495 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -984,7 +984,7 @@ static int stash_count_refs(const char *refname UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
@@ -994,7 +994,7 @@ static int count_stash_entries(void)
 
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1287,7 +1287,7 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static char *read_line_from_git_path(const char *filename)
+static char *read_line_from_git_path(struct repository *r, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
@@ -1325,8 +1325,8 @@ static int split_commit_in_progress(struct wt_status *s)
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
 		return 0;
 
-	rebase_amend = read_line_from_git_path("rebase-merge/amend");
-	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
+	rebase_amend = read_line_from_git_path(s->repo, "rebase-merge/amend");
+	rebase_orig_head = read_line_from_git_path(s->repo, "rebase-merge/orig-head");
 
 	if (!rebase_amend || !rebase_orig_head)
 		; /* fall through, no split in progress */
@@ -1350,7 +1350,7 @@ static int split_commit_in_progress(struct wt_status *s)
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
  */
-static void abbrev_oid_in_line(struct strbuf *line)
+static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 {
 	struct string_list split = STRING_LIST_INIT_DUP;
 	struct object_id oid;
@@ -1372,7 +1372,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	string_list_clear(&split, 0);
 }
 
-static int read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
@@ -1392,7 +1392,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		strbuf_trim(&buf);
 		if (!buf.len)
 			continue;
-		abbrev_oid_in_line(&buf);
+		abbrev_oid_in_line(r, &buf);
 		string_list_append(lines, buf.buf);
 	}
 	fclose(f);
@@ -1413,8 +1413,8 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
+		read_rebase_todolist(s->repo, "rebase-merge/done", &have_done);
+		if (read_rebase_todolist(s->repo, "rebase-merge/git-rebase-todo",
 					 &yet_to_do))
 			status_printf_ln(s, color,
 				_("git-rebase-todo is missing."));
@@ -2259,7 +2259,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  */
 static void wt_porcelain_v2_print_stash(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 	char eol = s->null_termination ? '\0' : '\n';
 
 	if (stash_count > 0)
-- 
2.53.0

