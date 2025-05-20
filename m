Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790124C692
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769762; cv=none; b=DxQzpsG8j9pmL+hPvG2aFZ4I8RHiPKRAOO/pfViLNy+fMQvuV+2Zx/TbIyuDfS0B/r/DBZG09JNRigsYSgRylHeec34It7Lcn4bCv2ObG04dbmqRjfl4oA0/1/kqdjfScVwgxb0XKOIBwm/XyGICwU7Aj1i85XHEXQGIsnBsOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769762; c=relaxed/simple;
	bh=4uiPtSH8qGP5sqBu9LNlICfFxwdJneX/wH/md0eLVUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwdPYioXNzvwvuof8WJJM5QxBB6zp5hhhZIVQt6Slrgd/F7JDzaoxnYJW6PhrkawPdXC8Og5QyMgCtzGAMQXFiRNrihJb6bX5xqh0PDghkLZAZSNT1BqpDHPGcKQSQEiYnIlN/efNnf28cNIqsMqqnauwnc3ddhYjVnLzMjOqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwRswjKL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwRswjKL"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b99f387e8so2405857276.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769759; x=1748374559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWbYoLVWNR9/e4A3FE0yiexMcEqtwK5Hl1LnPRTQ0pM=;
        b=CwRswjKLolmoB+zWaVtoaZht2kUUeiYX5eWPT3qK8QpeWgh9yaUNul54dpYV8MOchM
         lRfOj7FkUxedWJkVheN6V0J10eBFz9kyZR8aE0adZaRCBZ2aKEWrvqmyDdUwTzpnVFGw
         fEDDh4VE2CVKci/rRyy+1gdE4KpZTp/vq3ZAPebr4lo61nLty8lAA2wKqmgnhAfpd0n/
         tO0+udxmyL6ad9UkqwdprznzK4gyUPHo3UQac0d2xeiN+1KHWbClbEnYqndu02Up0xna
         AuQy7NkiOhkorZnVNWcXxcMxBa4sydh3xsmFm/zlevh9dUlWsWSptJ8Zqcj0MqP1wgT9
         whjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769759; x=1748374559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWbYoLVWNR9/e4A3FE0yiexMcEqtwK5Hl1LnPRTQ0pM=;
        b=ryl4xQr9oXrgcdOzzouTAufpfZ4RiPoUfNtQ4ZUOgZZKdy8qd1z4Lsj+T1CbIucrFT
         l4s2b//DH5yyaAcBiJEW0IVAsJF6ZgT5tmzFL21xqja+UEcWG5a+d4hcLyW6zx77Uu6P
         2FUB2sgdlckc5TN2XlNAXSwUUgIe0Tt1rtibZNJso1JDr2FDOXIYsPpdASjWMFFQPWxe
         S6ea8H0wp9fjqg3bInTyaKKZ1/mip507UgTkORSmLDrnxNu6GKvSOKtSIa+KX8VD7HpI
         Z7xqA0rGV1XMg7Y27NFhDU3XBGy6KWT8cnRCGxG05wYdytUa5aJpGyF6zQ3PeVwf+3g7
         Sk6g==
X-Gm-Message-State: AOJu0YxShxcpD8eo9FjtxaCiInezIi1rBI1Z+qgN3gFrImjRq6v6Vlq4
	ruc65JoENhSEB5gs/pl+OKv2fTn8TODHY6xLWRp8Knsf2uNEOuTr4P2ENE39OBIZ
X-Gm-Gg: ASbGncvFhZm9TtIS56SRjUkk+Tkx0qYWwNuuoK73itk8gpJh5H9yv7Cnyb+oGQ4DUCi
	lBtQO/dsCWQo2o0KgEZrg8QEL+tiWmzNAGdIiJ9cO2K1mK2oy1yPYLZHrGFVQTng4EKLA/chaVo
	KgHp4ZSxewBAmxWfWdWT93O2riL1yt180DPlr0Q4trysheVl7tpLUVK8Ko0KZuVZbBnOKkkn1ze
	6ODEi52sFkt7d9w6M738xMhLEmyFoOWsDyDfOhIFyk15AhISSKP5kcV0m99CAywoxzYvFs/qGY4
	CMS0z294mq7ggIikH0FfJybvGC0jlqtdRjr4D2LPeCTarBbeCYQON93RzVa9m47HDKH/FQNIe0z
	Zmzn7FC2YivLPKREk8oU89QVtJQ==
X-Google-Smtp-Source: AGHT+IE7ml0JB4da0sIsrtO4J9dCR5alYe0+Q7SS8aI68jE4OA9HUGVotvs6qMKkgWCq22HQsYSZ3w==
X-Received: by 2002:a05:6902:c08:b0:e72:ba52:87fb with SMTP id 3f1490d57ef6-e7b69e8637emr25083747276.11.1747769759415;
        Tue, 20 May 2025 12:35:59 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:41e8:72c5:601a:7e86])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d597dd6e0sm131664276.26.2025.05.20.12.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:35:59 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Date: Tue, 20 May 2025 15:34:58 -0400
Message-ID: <20250520193506.95199-5-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We setup_path() with git_exec_path() unconditionally (8e3462837b (Modify
setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
starts; as a result, all child processes see Git's exec-path when run,
including editors and other programs that don't need it [1]. This can
cause confusion for such programs or shells, especially when they rely
on finding "git" in PATH to locate other nearby directories, in a
similar vein as a0b4507ef7 (stop putting argv[0] dirname at front of
PATH, 2015-04-22) solved.

Since we only need this for finding git-* subprocesses, drop it from
child processes that aren't Git commands.

[1]: https://public-inbox.org/git/CALnO6CDtGRRav8zK2GKi1oHTZWrHFTxZNmnOWu64-ab+oY3_Lw@mail.gmail.com/

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Notes:
    A few interesting points:
    
    - I'm not sure how best to deal with the memory leak here.
    - Dscho suggested the essence of the patch in
      https://github.com/git-for-windows/build-extra/pull/616#pullrequestreview-2839055049,
      for the curious. My only major tweaks were this diff to skip past
      "PATH=" when searching for the matching path (but still modify the
      original buffer; b always points into buf.buf, so the later operations
      with p and buf.buf are valid).
    
    --->8---
    diff --git i/run-command.c w/run-command.c
    index b567e4fdd5..8a8b5c8455 100644
    --- i/run-command.c
    +++ w/run-command.c
    @@ -452,17 +452,24 @@ static void remove_git_exec_path(struct string_list_item *path_item) {
    	struct strbuf buf = STRBUF_INIT;
    	const char *exec_path = git_exec_path();
    	size_t exec_len = strlen(exec_path);
    -	char *p;
    +	char *b, *p;
    
    	/* Value comes from environ; we should not modify it directly. But
    	 * strbuf copies data, so we now have our own playground. */
    	strbuf_addstr(&buf, (const char *)path_item->util);
    -	for (p = strstr(buf.buf, exec_path); p; p = strstr(p, exec_path)) {
    -		if ((p[exec_len] && p[exec_len] != PATH_SEP) || (p != buf.buf && p[-1] != PATH_SEP))
    +
    +	/* skip past "PATH=" to start search */
    +	p = strchr(buf.buf, '=');
    +	if (!p || !*(p + 1))
    +		return;
    +	b = p + 1;
    +
    +	for (p = strstr(b, exec_path); p; p = strstr(p, exec_path)) {
    +		if ((p[exec_len] && p[exec_len] != PATH_SEP) || (p != b && p[-1] != PATH_SEP))
    			p += exec_len; /* false positive, skip */
    		else {
    			size_t offset = p - buf.buf, delete_len = exec_len;
    -			if (p != buf.buf) {
    +			if (p != b) {
    				/* include the preceding path separator */
    				offset--;
    				delete_len++;
    --->8---
    
    - I /think/ this resolves the issues in my earlier mail beyond just Git
      builtins; for example, git-jump also doesn't get exec-path because
      it's not invoked with git_cmd set during execv_dashed_external.

 run-command.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t7005-editor.sh | 13 +++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index dee6ae3e62..8a8b5c8455 100644
--- a/run-command.c
+++ b/run-command.c
@@ -448,11 +448,51 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 	return 0;
 }
 
-static char **prep_childenv(const char *const *deltaenv)
+static void remove_git_exec_path(struct string_list_item *path_item) {
+	struct strbuf buf = STRBUF_INIT;
+	const char *exec_path = git_exec_path();
+	size_t exec_len = strlen(exec_path);
+	char *b, *p;
+
+	/* Value comes from environ; we should not modify it directly. But
+	 * strbuf copies data, so we now have our own playground. */
+	strbuf_addstr(&buf, (const char *)path_item->util);
+
+	/* skip past "PATH=" to start search */
+	p = strchr(buf.buf, '=');
+	if (!p || !*(p + 1))
+		return;
+	b = p + 1;
+
+	for (p = strstr(b, exec_path); p; p = strstr(p, exec_path)) {
+		if ((p[exec_len] && p[exec_len] != PATH_SEP) || (p != b && p[-1] != PATH_SEP))
+			p += exec_len; /* false positive, skip */
+		else {
+			size_t offset = p - buf.buf, delete_len = exec_len;
+			if (p != b) {
+				/* include the preceding path separator */
+				offset--;
+				delete_len++;
+			} else if (p[exec_len] == PATH_SEP) {
+				/* include the path separator following GIT_EXEC_PATH */
+				delete_len++;
+			}
+			strbuf_splice(&buf, offset, delete_len, "", 0);
+		}
+	}
+
+	/* Overwrite PATH value with new (owned) data. This leaks memory because
+	 * the only future owner is a char** childenv, which is freed, but whose
+	 * contents are not (because most of them come from environ). */
+	path_item->util = (void *)strbuf_detach(&buf, NULL);
+}
+
+static char **prep_childenv(const char *const *deltaenv, unsigned git_cmd)
 {
 	extern char **environ;
 	char **childenv;
 	struct string_list env = STRING_LIST_INIT_DUP;
+	struct string_list_item *path_item;
 	struct strbuf key = STRBUF_INIT;
 	const char *const *p;
 	int i;
@@ -486,6 +526,9 @@ static char **prep_childenv(const char *const *deltaenv)
 		}
 	}
 
+	if (!git_cmd && (path_item = string_list_lookup(&env, "PATH")))
+		remove_git_exec_path(path_item);
+
 	/* Create an array of 'char *' to be used as the childenv */
 	ALLOC_ARRAY(childenv, env.nr + 1);
 	for (i = 0; i < env.nr; i++)
@@ -746,7 +789,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->close_object_store)
 		close_object_store(the_repository->objects);
 
-	childenv = prep_childenv(cmd->env.v);
+	childenv = prep_childenv(cmd->env.v, cmd->git_cmd);
 
 #ifndef GIT_WINDOWS_NATIVE
 {
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 06fa1ecd91..560e500b53 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -127,4 +127,17 @@
 	test space = "$(git show -s --pretty=format:%s)"
 '
 
+test_expect_success 'editor does not see GIT_EXEC_PATH on PATH' '
+	cat >e-path <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$PATH" | tr : "\\n" >actual
+	EOF
+	chmod +x e-path &&
+	(
+		test_set_editor ./e-path &&
+		git commit --amend
+	) &&
+	test_grep ! ^"$(git --exec-path)"\$ actual
+'
+
 test_done
-- 
2.48.1

