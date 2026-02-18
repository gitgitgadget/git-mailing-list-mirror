Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29844238C29
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437439; cv=none; b=H13X0HORUZJOLz+WCoMUx+fC8dCgxWPNDxMutkXIqDCLaTDvwwKzE79UVxl90zle9sDeUCJPXVvxfKbFKtfiFUzkt0mAtq1t/c5VJdQp2zsciGfPB2djYY1frJK2n+xxiqvFm2SUpoO8qqiZbLOhw9LSrMwdyPUCCsRJBgq8D68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437439; c=relaxed/simple;
	bh=oMOo81TtaJw1Q8S+HxYcR5kdgwflWrMLER/R8IrgjT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXPU5I9hf0RwiTVQG96giEzJXIfPXGVdJBZuatfJ8nVTj18TFMwp73noFUlj7GOyCPKd82K76xCzMuBT/pPOMwdDEgrhozs6IgfWxw0JAe1acaUyVuWRApfK7Ln2anxb8joGz8MtYw8PNcYDAgKM/LFRnMktEH1D6r1Dr3A5WRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOLg6f6c; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOLg6f6c"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c626bd75628so12963a12.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771437437; x=1772042237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7gsUIMSheGZxBotfdVco272vQBWUsZPdMkRMyJH2Sk=;
        b=EOLg6f6ctZe/qlVwTXPhcLte5521Tcyj8HRo1MMiFUjps7jvy4Z31hzZmaUxhLZA47
         gGh434g6W1DQYRWkp+tCHsAVMe0HCxYHp1MwVuWhu26TTwRES6cJVkwDAxVrPvxvjOUi
         +FEQquwo3Y6xPalJhI6W0Y5k+Bcxg/zPvqA6dMORzy+GjuHP/XQppe4CjGq9/XE3TnaV
         pbzJcXtnwyVtUCR1Bso3L+nDnzjDy4swp7F4+HbXHc3NLTidad3x8dLilTAmGq54r760
         EYAaQWHxgrG4CnEdykLONCN7HGTdaa7ntc0o1jFw9dheC8ZW2nWFwybocmMEUNSmA5cV
         ob/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437437; x=1772042237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7gsUIMSheGZxBotfdVco272vQBWUsZPdMkRMyJH2Sk=;
        b=CM92IyZHgbFC64PsEW5+cu6emYNf0TsJ6dTn6qP/OH1qXyDzIqcKxAln7/MYiDiQi3
         xtCoPzH1GVmN2eSweuCypJDVOzWOnqtagSwFjYKi8Puqxog6Amjup08Wm0JQmjtICB3d
         sL97f3RqnWoK+YOwwyBI7thVG6Ubzz24bPkamFrhhNmKI2U/LyumwHjr4SclTUpbmT+E
         J5lqSDeV/Js2DvXAvM7X4fJxgXPLbxYSGejYHy1AX4e4TvcEFH6B3COPqOwTxQ06yDKQ
         PSPqpYNNu/qe6cK4R401CIum2EuHEYEhgn9+XSwZiJjC72rEbfu567Xa7MPD0P+FTMpq
         KLvw==
X-Gm-Message-State: AOJu0YyGfNzf96Q0MJRYF1d4ehRAg3DSn2NUed6ddbs4iMwHFwazeACn
	GVPWLuRKWNGF+6LiSpveS+oVFae8VDfX/njMsyE4rF2jNASD5E4TTjaUlXfxMlan
X-Gm-Gg: AZuq6aLYqSAYmFv6W8nbPz9tfh2WW2EVywYX4romDwsYJuxgY7Ac3rmO29qMxUSEkP/
	NavfMQMFcTyAJSt+W5SNWgK294EYXItY3R5RG/jIpO1cx8Ms/G9vRUgf34MVWL/23fqQlxJQjro
	z25qhsVjiNE9hiqLna+NOfKP7TCZASk5iE3eSgCHNBCTo/EVcfDrKmsOE7t2xXnZ3wNgUvEY6tk
	iKlsTz4hRk4zCa0PIha8akx7Cvjb9JJANKZRyAYXJ4u72kmRoPW7riZL0sPOVBGrAg609sgRVR4
	JXgFnlnRugNdP2OhSlnrrzTcxOZAmGF4BOO+2uxKrSvMnNEPPONfZy3sn1aJ10cqgMeAbFCqpqN
	aDy95TG0wt15lDb8wU5p9l+84sCwcezNoTZIA605x/50oiFopvihTv8ZDxX5fSa+U7m1MPDWtcw
	YT1Mebc24Gn13ODfC6q9j35W6SDkWc9nNgP++GTgWrYul8xN+mKXyADG2UwA==
X-Received: by 2002:a17:903:910:b0:2a9:4450:abb7 with SMTP id d9443c01a7336-2ad50f6378fmr22812435ad.39.1771437437208;
        Wed, 18 Feb 2026 09:57:17 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e531e6c51sm13440957a12.16.2026.02.18.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:57:16 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 1/3] wt-status: pass struct repository through function parameters
Date: Wed, 18 Feb 2026 23:23:40 +0530
Message-ID: <20260218175654.66004-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions in wt-status.c (count_stash_entries(),
read_line_from_git_path(), abbrev_oid_in_line(), and
read_rebase_todolist()) rely on the_repository as they do not have access
to a local repository instance.

Add a struct repository *r parameter to these functions and pass the local
repository instance through the callers, which already have access to it
either directly by struct repository *r or indirectly by struct wt_state
*s (s->repo).

Replace uses of the_repository in these functions with the passed parameter.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..97c2e10a8c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -984,17 +984,17 @@ static int stash_count_refs(const char *refname UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	refs_for_each_reflog_ent(get_main_ref_store(r),
 				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
 
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1287,10 +1287,10 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static char *read_line_from_git_path(const char *filename)
+static char *read_line_from_git_path(struct repository *r, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
 						      "%s", filename), "r");
 
 	if (!fp) {
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
@@ -1362,7 +1362,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 		return;
 
 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+	    !repo_get_oid(r, split.items[1].string, &oid)) {
 		strbuf_reset(line);
 		strbuf_addf(line, "%s ", split.items[0].string);
 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
@@ -1372,10 +1372,10 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	string_list_clear(&split, 0);
 }
 
-static int read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
 	int ret;
 
 	if (!f) {
@@ -1384,7 +1384,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			goto out;
 		}
 		die_errno("Could not open file %s for reading",
-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
+			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
 		if (starts_with(buf.buf, comment_line_str))
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

