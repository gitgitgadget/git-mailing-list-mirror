Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7392550BA
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793788; cv=none; b=dIz+uIWOnZBovzlgCindeOJtYzyOEQDqCY6TyxYmGF7WxGiN6FLtuyNmpSlph0sE0lqY5t3MaaHGVrVvS54PeM1t/7y9CkKp3ChznH+31V4bPrSeApuzgNxRLqm1M9NI4kFJJqKMAM9MGhJtEw8vHUM11HvhxhiLbjQYAw+oIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793788; c=relaxed/simple;
	bh=yJRTihvlQ1M4K1imd4/ZjLH8qWhlDNBjp8siPs7W5xo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ThHKVu90ycXBVOjpdkhN1ol+XtyP7rLwfGZ/Udus9pJhC6EDvsO7dR1FsE7SGf5htthgxJEHRqc5D7WV1z2wMhLK1GugTM+J2XBzvOXoCz9i01lB/HYgOAkPG6jhCsb9USzVi6uuw+Ol9JlBoXU9rahyM74lB7KA3uVW9zVbyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG6DGUXM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG6DGUXM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29599f08202so41216225ad.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793785; x=1763398585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SRZND1/clG2DIK67rHvRwJvdXUFewak7XyKzDj1gIU=;
        b=VG6DGUXMyNhjU1OdWD/jSID2xH4annQryOA8MP0p7d70S/KD83KJbZTVhHDIMIQHiW
         zqCxensjYeKA2jEikWFaaIUXiju+w+QpdInBkqyDAPsm8no2NUcmuwYiULP/m61WDpRR
         WD9nY6ZAmXeLebVmK6rY3L9V8yN9xQ3YlLqvur7sTETS6aEVp3g75VQUwK/WaSYVZmUt
         iu/hFz3xx56bHxjEBfG6dnLZhWHtauej4dMKhjhZmveBQolIMfY8iqOBYyspQiBb5UE9
         8sM3ilo/7mxOoW5B3FEBrVpsptKmQMiovXoFVTZ1lIQG06G40j9zAQ1sKtuvBlKRbCOQ
         UxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793785; x=1763398585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SRZND1/clG2DIK67rHvRwJvdXUFewak7XyKzDj1gIU=;
        b=K2GFlgrBfiD2diNlBtvhuKw0WYKuzNDQbtzwJAlTFewLnFwD7KX/XY9bh8zB3njqxT
         hIigbSORAp5LpEHdyQdJPvbzA+UsD1E2ejgo/yl86QhgcYzfV4TmKLgCKHPp6IaAADgx
         S2gzbRX9b88xL2xk8iPA6pb1DHOZDb3bNIJ/e9oBuiw2YbIoxPaP3lZSQa/XGCOlNEW9
         9kbVTuR7ElKU8PheS+bOeqESPSIEG+88jj78HaddPADCtlgGcDNnPHrxVIDD0Uj8Qq1S
         HoDkEwxL4kd63JSaluzLk74aJJDUfcmOoV9n4Qf07lUN9WMWB4+4kD+ZwBsYqvoL6rBI
         ulMQ==
X-Gm-Message-State: AOJu0Ywt4JbqOypxbVPkd5EaLP1KrLwG1t/3f8SzlBhEELgcOfb75LtA
	HT8ag/OcxW1LBmOXB+ZwrctKYvd3TWEGd8vssK+gjR3jqqYSrERHubbBDJFhlQ==
X-Gm-Gg: ASbGncvgzYAPQvR6ikvYDbmpdtJ0A2MBkvf+RzT6wpmIoa2WsjtJfsPqI3NpKMHvXMr
	jRBahA5nzlyswVczAANfeXwNPwrgSROh/4pKSFiQOf0Dd3YSud2urjrMbviJ07E1MSWoaMr4HaP
	2dEe9q2724gFH4nAxKiMsHvGLOcmA1a4bSAxCKuWP+oRmF3LeQpDc6d3zbYlsO8uEm9EW9e9+HF
	ISOWuJB+nAOOqhuajCrGtOhNJ4ZjtkW2o08xPH4krutR5N6wOH+7LL1p7SAnjywbqVhmx6geyJ0
	lh1vxCFmRwh0Ghuy98BVmk9ck/crtTxEk6205Wr+XNqcB1W0ZyPWRp5PxqDTNXCldWed3IVVrkG
	wxG2E8kaNjQVc7DQLfuPvV9t9DU2NQfXz/FxdK1yu/e8+k7SEv1ZfZJ1lm0EFjJRC87zs+NYgtW
	aA07PYtKDkUwZtKsWNWhadnQ==
X-Google-Smtp-Source: AGHT+IHNwil6PMR012EUp3BLV31lFRCxCzaqCHgT/HEH9F7EDDQ6OHtYV9b8OwoCR7G9B1nN2HqG2g==
X-Received: by 2002:a17:903:1b64:b0:297:ece8:a3cb with SMTP id d9443c01a7336-297ece8a482mr96173315ad.25.1762793784398;
        Mon, 10 Nov 2025 08:56:24 -0800 (PST)
Received: from [127.0.0.1] ([57.151.138.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297fc2227cesm61758235ad.95.2025.11.10.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:56:23 -0800 (PST)
Message-Id: <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
In-Reply-To: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Nov 2025 16:56:22 +0000
Subject: [PATCH v2] commit: add --committer option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

Add --committer option to git-commit, allowing users to override the
committer identity similar to how --author works. This provides a more
convenient alternative to setting GIT_COMMITTER_* environment variables.

Like --author, the --committer option supports two formats:
- Explicit identity: --committer="Name <email@example.com>"
- Pattern search: --committer="pattern" searches commit history for a
  matching committer and reuses that identity

To share code with the existing --author option, this patch refactors:

1. find_author_by_nickname() into find_identity_by_nickname() which
   handles both author and committer searches through an is_author
   parameter.

2. determine_author_info() into determine_identity() which handles
   identity parsing and setting for both author and committer through
   an is_author parameter.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
---
    commit: add --committer option
    
    Currently, when users need to override the committer identity in
    git-commit, they have to set GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL
    environment variables, which can be cumbersome in scripting scenarios or
    when frequently switching committer identities.
    
    While git-commit already provides the --author option to conveniently
    override the author identity, there's no equivalent --committer option
    for the committer identity. This asymmetry creates an inconsistent user
    experience.
    
    This patch introduces the --committer option to git-commit, providing:
    
     1. Consistency with the existing --author option
     2. A more convenient alternative to environment variables
     3. Better support for automated workflows and scripts
     4. Improved user experience when managing multiple identities
    
    The implementation follows the same pattern as the --author option,
    accepting the format "Name " and properly validating the input.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%2Fadlternative%2Fzh%2Fimplement-committer-option-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adlternative/zh/implement-committer-option-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1997

Range-diff vs v1:

 1:  05e97b439f ! 1:  58e9e5c9d7 commit: add --committer option
     @@ Commit message
          committer identity similar to how --author works. This provides a more
          convenient alternative to setting GIT_COMMITTER_* environment variables.
      
     -    Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    Like --author, the --committer option supports two formats:
     +    - Explicit identity: --committer="Name <email@example.com>"
     +    - Pattern search: --committer="pattern" searches commit history for a
     +      matching committer and reuses that identity
     +
     +    To share code with the existing --author option, this patch refactors:
     +
     +    1. find_author_by_nickname() into find_identity_by_nickname() which
     +       handles both author and committer searches through an is_author
     +       parameter.
     +
     +    2. determine_author_info() into determine_identity() which handles
     +       identity parsing and setting for both author and committer through
     +       an is_author parameter.
      
     +    Signed-off-by: ZheNing Hu <adlternative@gmail.com>
          Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
      
       ## Documentation/git-commit.adoc ##
     @@ Documentation/git-commit.adoc: git commit [-a | --interactive | --patch] [-s] [-
       	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
       	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
      -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
     -+	   [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]
     ++	   [--committer=<committer>] [--date=<date>] [--cleanup=<mode>] [--[no-]status]
       	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
       	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
       	   [--] [<pathspec>...]
      @@ Documentation/git-commit.adoc: See linkgit:git-rebase[1] for details.
     - `--date=<date>`::
     - 	Override the author date used in the commit.
     + 	commit by that author (i.e. `git rev-list --all -i --author=<author>`);
     + 	the commit author is then copied from the first such commit found.
       
      +`--committer=<committer>`::
      +	Override the committer for the commit. Specify an explicit committer using the
     -+	standard `A U Thor <committer@example.com>` format. Otherwise _<committer>_
     ++	standard `C O Mitter <committer@example.com>` format. Otherwise _<committer>_
      +	is assumed to be a pattern and is used to search for an existing
     -+	commit by that author (i.e. `git rev-list --all -i --author=<committer>`);
     -+	the commit author is then copied from the first such commit found.
     ++	commit by that committer (i.e. `git rev-list --all -i --committer=<committer>`);
     ++	the commit committer is then copied from the first such commit found.
      +
     - `-m <msg>`::
     - `--message=<msg>`::
     - 	Use _<msg>_ as the commit message.
     + `--date=<date>`::
     + 	Override the author date used in the commit.
     + 
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static const char * const builtin_commit_usage[] = {
     @@ builtin/commit.c: static const char * const builtin_commit_usage[] = {
       	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
       	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
      -	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
     -+	   "           [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]\n"
     ++	   "           [--committer=<committer>] [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
       	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
       	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
       	   "           [--] [<pathspec>...]"),
     @@ builtin/commit.c: static enum {
       static char *logfile;
       static char *template_file;
       /*
     -@@ builtin/commit.c: static void determine_author_info(struct strbuf *author_ident)
     - 	free(date);
     +@@ builtin/commit.c: static void set_ident_var(char **buf, char *val)
     + 	*buf = val;
       }
       
     -+static void determine_committer_info(struct strbuf *committer_ident)
     -+{
     -+	char *name, *email, *date;
     -+	struct ident_split committer;
     -+
     -+	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
     -+	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
     -+	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
     +-static void determine_author_info(struct strbuf *author_ident)
     ++static void determine_identity(struct strbuf *ident_str, int is_author)
     + {
     + 	char *name, *email, *date;
     +-	struct ident_split author;
     +-
     +-	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
     +-	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
     +-	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
     +-
     +-	if (author_message) {
     +-		struct ident_split ident;
     ++	struct ident_split ident;
     ++	const char *env_name = is_author ? "GIT_AUTHOR_NAME" : "GIT_COMMITTER_NAME";
     ++	const char *env_email = is_author ? "GIT_AUTHOR_EMAIL" : "GIT_COMMITTER_EMAIL";
     ++	const char *env_date = is_author ? "GIT_AUTHOR_DATE" : "GIT_COMMITTER_DATE";
     ++	const char *force_ident = is_author ? force_author : force_committer;
     ++	const char *param_name = is_author ? "--author" : "--committer";
     ++	int ident_flag = is_author ? WANT_AUTHOR_IDENT : WANT_COMMITTER_IDENT;
      +
     -+	if (force_committer) {
     -+		struct ident_split ident;
     ++	name = xstrdup_or_null(getenv(env_name));
     ++	email = xstrdup_or_null(getenv(env_email));
     ++	date = xstrdup_or_null(getenv(env_date));
      +
     -+		if (split_ident_line(&ident, force_committer, strlen(force_committer)) < 0)
     -+			die(_("malformed --committer parameter"));
     -+		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
     -+		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     ++	if (is_author && author_message) {
     ++		struct ident_split msg_ident;
     + 		size_t len;
     + 		const char *a;
     + 
     + 		a = find_commit_header(author_message_buffer, "author", &len);
     + 		if (!a)
     + 			die(_("commit '%s' lacks author header"), author_message);
     +-		if (split_ident_line(&ident, a, len) < 0)
     ++		if (split_ident_line(&msg_ident, a, len) < 0)
     + 			die(_("commit '%s' has malformed author line"), author_message);
     + 
     +-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
     +-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     ++		set_ident_var(&name, xmemdupz(msg_ident.name_begin, msg_ident.name_end - msg_ident.name_begin));
     ++		set_ident_var(&email, xmemdupz(msg_ident.mail_begin, msg_ident.mail_end - msg_ident.mail_begin));
     + 
     +-		if (ident.date_begin) {
     ++		if (msg_ident.date_begin) {
     + 			struct strbuf date_buf = STRBUF_INIT;
     + 			strbuf_addch(&date_buf, '@');
     +-			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
     ++			strbuf_add(&date_buf, msg_ident.date_begin, msg_ident.date_end - msg_ident.date_begin);
     + 			strbuf_addch(&date_buf, ' ');
     +-			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
     ++			strbuf_add(&date_buf, msg_ident.tz_begin, msg_ident.tz_end - msg_ident.tz_begin);
     + 			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     + 		}
     + 	}
     + 
     +-	if (force_author) {
     +-		struct ident_split ident;
     ++	if (force_ident) {
     ++		struct ident_split force_ident_split;
      +
     -+		if (ident.date_begin) {
     ++		if (split_ident_line(&force_ident_split, force_ident, strlen(force_ident)) < 0)
     ++			die(_("malformed %s parameter"), param_name);
     ++		set_ident_var(&name, xmemdupz(force_ident_split.name_begin, force_ident_split.name_end - force_ident_split.name_begin));
     ++		set_ident_var(&email, xmemdupz(force_ident_split.mail_begin, force_ident_split.mail_end - force_ident_split.mail_begin));
     + 
     +-		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
     +-			die(_("malformed --author parameter"));
     +-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
     +-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     ++		if (!is_author && force_ident_split.date_begin) {
      +			struct strbuf date_buf = STRBUF_INIT;
      +			strbuf_addch(&date_buf, '@');
     -+			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
     ++			strbuf_add(&date_buf, force_ident_split.date_begin, force_ident_split.date_end - force_ident_split.date_begin);
      +			strbuf_addch(&date_buf, ' ');
     -+			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
     ++			strbuf_add(&date_buf, force_ident_split.tz_begin, force_ident_split.tz_end - force_ident_split.tz_begin);
      +			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
      +		}
     -+	}
     + 	}
     + 
     + 	if (force_date) {
     +@@ builtin/commit.c: static void determine_author_info(struct strbuf *author_ident)
     + 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     + 	}
     + 
     +-	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
     ++	strbuf_addstr(ident_str, fmt_ident(name, email, ident_flag, date,
     + 				IDENT_STRICT));
     +-	assert_split_ident(&author, author_ident);
     +-	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
     +-	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
     +-	export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
     ++	assert_split_ident(&ident, ident_str);
      +
     -+	if (force_date) {
     -+		struct strbuf date_buf = STRBUF_INIT;
     -+		if (parse_force_date(force_date, &date_buf))
     -+			die(_("invalid date format: %s"), force_date);
     -+		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     ++	if (is_author) {
     ++		export_one("GIT_AUTHOR_NAME", ident.name_begin, ident.name_end, 0);
     ++		export_one("GIT_AUTHOR_EMAIL", ident.mail_begin, ident.mail_end, 0);
     ++		export_one("GIT_AUTHOR_DATE", ident.date_begin, ident.tz_end, '@');
     ++	} else {
     ++		export_one("GIT_COMMITTER_NAME", ident.name_begin, ident.name_end, 0);
     ++		export_one("GIT_COMMITTER_EMAIL", ident.mail_begin, ident.mail_end, 0);
     ++		export_one("GIT_COMMITTER_DATE", ident.date_begin, ident.tz_end, '@');
      +	}
      +
     -+	strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMITTER_IDENT, date,
     -+				IDENT_STRICT));
     -+	assert_split_ident(&committer, committer_ident);
     -+	free(name);
     -+	free(email);
     -+	free(date);
     + 	free(name);
     + 	free(email);
     + 	free(date);
     + }
     + 
     ++static void determine_author_info(struct strbuf *author_ident)
     ++{
     ++	determine_identity(author_ident, 1);
     ++}
     ++
     ++static void determine_committer_info(struct strbuf *committer_ident)
     ++{
     ++	determine_identity(committer_ident, 0);
      +}
      +
       static int author_date_is_interesting(void)
       {
       	return author_message || force_date;
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 	return 1;
     + }
     + 
     +-static const char *find_author_by_nickname(const char *name)
     ++static const char *find_identity_by_nickname(const char *name, int is_author)
     + {
     + 	struct rev_info revs;
     + 	struct commit *commit;
     + 	struct strbuf buf = STRBUF_INIT;
     + 	const char *av[20];
     + 	int ac = 0;
     ++	const char *field = is_author ? "author" : "committer";
     ++	const char *format = is_author ? "%aN <%aE>" : "%cN <%cE>";
     + 
     + 	repo_init_revisions(the_repository, &revs, NULL);
     +-	strbuf_addf(&buf, "--author=%s", name);
     ++	strbuf_addf(&buf, "--%s=%s", field, name);
     + 	av[++ac] = "--all";
     + 	av[++ac] = "-i";
     + 	av[++ac] = buf.buf;
     +@@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
     + 		ctx.date_mode.type = DATE_NORMAL;
     + 		strbuf_release(&buf);
     + 		repo_format_commit_message(the_repository, commit,
     +-					   "%aN <%aE>", &buf, &ctx);
     ++					   format, &buf, &ctx);
     + 		release_revisions(&revs);
     + 		return strbuf_detach(&buf, NULL);
     + 	}
     +-	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
     ++	die(_("--%s '%s' is not 'Name <email>' and matches no existing %s"),
     ++	    field, name, field);
     ++}
     ++
     ++static const char *find_author_by_nickname(const char *name)
     ++{
     ++	return find_identity_by_nickname(name, 1);
     ++}
     ++
     ++static const char *find_committer_by_nickname(const char *name)
     ++{
     ++	return find_identity_by_nickname(name, 0);
     + }
     + 
     + static void handle_ignored_arg(struct wt_status *s)
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       	if (force_author && renew_authorship)
       		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
       
      +	if (force_committer && !strchr(force_committer, '>'))
     -+		force_committer = find_author_by_nickname(force_committer);
     ++		force_committer = find_committer_by_nickname(force_committer);
      +
       	if (logfile || have_option_m || use_message)
       		use_editor = 0;
     @@ builtin/commit.c: int cmd_commit(int argc,
       		append_merge_tag_headers(parents, &tail);
       	}
       
     -+	if (force_committer) {
     ++	if (force_committer)
      +		determine_committer_info(&committer_ident);
     -+	}
      +
       	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
      -				 parents, &oid, author_ident.buf, NULL,
     @@ t/t7509-commit-authorship.sh: author_header () {
       message_body () {
       	git cat-file commit "$1" |
       	sed -e '1,/^$/d'
     + }
     + 
     + test_expect_success '-C option copies authorship and message' '
     +-	test_commit --author Frigate\ \<flying@over.world\> \
     ++	test_env GIT_COMMITTER_NAME="Frigate" \
     ++		GIT_COMMITTER_EMAIL="flying@over.world" \
     ++		test_commit --author Frigate\ \<flying@over.world\> \
     + 		"Initial Commit" foo Initial Initial &&
     + 	echo "Test 1" >>foo &&
     + 	test_tick &&
      @@ t/t7509-commit-authorship.sh: test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
       	test_cmp expect actual
       '
     @@ t/t7509-commit-authorship.sh: test_expect_success '--reset-author with CHERRY_PI
      +	git checkout -f Initial &&
      +	echo "Test env vars" >>foo &&
      +	test_tick &&
     -+	GIT_COMMITTER_NAME="Env Committer" \
     -+	GIT_COMMITTER_EMAIL="env@test.example" \
     -+	git commit -a -m "test committer env vars" &&
     ++	test_env GIT_COMMITTER_NAME="Env Committer" \
     ++		GIT_COMMITTER_EMAIL="env@test.example" \
     ++		git commit -a -m "test committer env vars" &&
      +	committer_header HEAD >actual &&
      +	grep "Env Committer <env@test.example>" actual
      +'
     @@ t/t7509-commit-authorship.sh: test_expect_success '--reset-author with CHERRY_PI
      +test_expect_success '--committer overrides GIT_COMMITTER_* environment variables' '
      +	echo "Test override" >>foo &&
      +	test_tick &&
     -+	GIT_COMMITTER_NAME="Env Committer" \
     -+	GIT_COMMITTER_EMAIL="env@test.example" \
     -+	git commit -a -m "test override" \
     ++	test_env GIT_COMMITTER_NAME="Env Committer" \
     ++		GIT_COMMITTER_EMAIL="env@test.example" \
     ++		git commit -a -m "test override" \
      +		--committer="Override Committer <override@test.example>" &&
      +	committer_header HEAD >actual &&
      +	grep "Override Committer <override@test.example>" actual


 Documentation/git-commit.adoc |   9 ++-
 builtin/commit.c              | 121 +++++++++++++++++++++++++---------
 t/t7509-commit-authorship.sh  |  84 ++++++++++++++++++++++-
 3 files changed, 180 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 54c207ad45..ed4c54ae81 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--committer=<committer>] [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
 	   [--] [<pathspec>...]
@@ -178,6 +178,13 @@ See linkgit:git-rebase[1] for details.
 	commit by that author (i.e. `git rev-list --all -i --author=<author>`);
 	the commit author is then copied from the first such commit found.
 
+`--committer=<committer>`::
+	Override the committer for the commit. Specify an explicit committer using the
+	standard `C O Mitter <committer@example.com>` format. Otherwise _<committer>_
+	is assumed to be a pattern and is used to search for an existing
+	commit by that committer (i.e. `git rev-list --all -i --committer=<committer>`);
+	the commit committer is then copied from the first such commit found.
+
 `--date=<date>`::
 	Override the author date used in the commit.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..3b249dd878 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] = {
 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
-	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [--committer=<committer>] [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
 	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
 	   "           [--] [<pathspec>...]"),
@@ -112,6 +112,7 @@ static enum {
 } commit_style;
 
 static const char *force_author;
+static const char *force_committer;
 static char *logfile;
 static char *template_file;
 /*
@@ -630,46 +631,61 @@ static void set_ident_var(char **buf, char *val)
 	*buf = val;
 }
 
-static void determine_author_info(struct strbuf *author_ident)
+static void determine_identity(struct strbuf *ident_str, int is_author)
 {
 	char *name, *email, *date;
-	struct ident_split author;
-
-	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
-	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
-	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
-
-	if (author_message) {
-		struct ident_split ident;
+	struct ident_split ident;
+	const char *env_name = is_author ? "GIT_AUTHOR_NAME" : "GIT_COMMITTER_NAME";
+	const char *env_email = is_author ? "GIT_AUTHOR_EMAIL" : "GIT_COMMITTER_EMAIL";
+	const char *env_date = is_author ? "GIT_AUTHOR_DATE" : "GIT_COMMITTER_DATE";
+	const char *force_ident = is_author ? force_author : force_committer;
+	const char *param_name = is_author ? "--author" : "--committer";
+	int ident_flag = is_author ? WANT_AUTHOR_IDENT : WANT_COMMITTER_IDENT;
+
+	name = xstrdup_or_null(getenv(env_name));
+	email = xstrdup_or_null(getenv(env_email));
+	date = xstrdup_or_null(getenv(env_date));
+
+	if (is_author && author_message) {
+		struct ident_split msg_ident;
 		size_t len;
 		const char *a;
 
 		a = find_commit_header(author_message_buffer, "author", &len);
 		if (!a)
 			die(_("commit '%s' lacks author header"), author_message);
-		if (split_ident_line(&ident, a, len) < 0)
+		if (split_ident_line(&msg_ident, a, len) < 0)
 			die(_("commit '%s' has malformed author line"), author_message);
 
-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+		set_ident_var(&name, xmemdupz(msg_ident.name_begin, msg_ident.name_end - msg_ident.name_begin));
+		set_ident_var(&email, xmemdupz(msg_ident.mail_begin, msg_ident.mail_end - msg_ident.mail_begin));
 
-		if (ident.date_begin) {
+		if (msg_ident.date_begin) {
 			struct strbuf date_buf = STRBUF_INIT;
 			strbuf_addch(&date_buf, '@');
-			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
+			strbuf_add(&date_buf, msg_ident.date_begin, msg_ident.date_end - msg_ident.date_begin);
 			strbuf_addch(&date_buf, ' ');
-			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
+			strbuf_add(&date_buf, msg_ident.tz_begin, msg_ident.tz_end - msg_ident.tz_begin);
 			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 		}
 	}
 
-	if (force_author) {
-		struct ident_split ident;
+	if (force_ident) {
+		struct ident_split force_ident_split;
+
+		if (split_ident_line(&force_ident_split, force_ident, strlen(force_ident)) < 0)
+			die(_("malformed %s parameter"), param_name);
+		set_ident_var(&name, xmemdupz(force_ident_split.name_begin, force_ident_split.name_end - force_ident_split.name_begin));
+		set_ident_var(&email, xmemdupz(force_ident_split.mail_begin, force_ident_split.mail_end - force_ident_split.mail_begin));
 
-		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
-			die(_("malformed --author parameter"));
-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+		if (!is_author && force_ident_split.date_begin) {
+			struct strbuf date_buf = STRBUF_INIT;
+			strbuf_addch(&date_buf, '@');
+			strbuf_add(&date_buf, force_ident_split.date_begin, force_ident_split.date_end - force_ident_split.date_begin);
+			strbuf_addch(&date_buf, ' ');
+			strbuf_add(&date_buf, force_ident_split.tz_begin, force_ident_split.tz_end - force_ident_split.tz_begin);
+			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
+		}
 	}
 
 	if (force_date) {
@@ -679,17 +695,35 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+	strbuf_addstr(ident_str, fmt_ident(name, email, ident_flag, date,
 				IDENT_STRICT));
-	assert_split_ident(&author, author_ident);
-	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
-	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
-	export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
+	assert_split_ident(&ident, ident_str);
+
+	if (is_author) {
+		export_one("GIT_AUTHOR_NAME", ident.name_begin, ident.name_end, 0);
+		export_one("GIT_AUTHOR_EMAIL", ident.mail_begin, ident.mail_end, 0);
+		export_one("GIT_AUTHOR_DATE", ident.date_begin, ident.tz_end, '@');
+	} else {
+		export_one("GIT_COMMITTER_NAME", ident.name_begin, ident.name_end, 0);
+		export_one("GIT_COMMITTER_EMAIL", ident.mail_begin, ident.mail_end, 0);
+		export_one("GIT_COMMITTER_DATE", ident.date_begin, ident.tz_end, '@');
+	}
+
 	free(name);
 	free(email);
 	free(date);
 }
 
+static void determine_author_info(struct strbuf *author_ident)
+{
+	determine_identity(author_ident, 1);
+}
+
+static void determine_committer_info(struct strbuf *committer_ident)
+{
+	determine_identity(committer_ident, 0);
+}
+
 static int author_date_is_interesting(void)
 {
 	return author_message || force_date;
@@ -1137,16 +1171,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-static const char *find_author_by_nickname(const char *name)
+static const char *find_identity_by_nickname(const char *name, int is_author)
 {
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *av[20];
 	int ac = 0;
+	const char *field = is_author ? "author" : "committer";
+	const char *format = is_author ? "%aN <%aE>" : "%cN <%cE>";
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	strbuf_addf(&buf, "--author=%s", name);
+	strbuf_addf(&buf, "--%s=%s", field, name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
 	av[++ac] = buf.buf;
@@ -1164,11 +1200,22 @@ static const char *find_author_by_nickname(const char *name)
 		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
 		repo_format_commit_message(the_repository, commit,
-					   "%aN <%aE>", &buf, &ctx);
+					   format, &buf, &ctx);
 		release_revisions(&revs);
 		return strbuf_detach(&buf, NULL);
 	}
-	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
+	die(_("--%s '%s' is not 'Name <email>' and matches no existing %s"),
+	    field, name, field);
+}
+
+static const char *find_author_by_nickname(const char *name)
+{
+	return find_identity_by_nickname(name, 1);
+}
+
+static const char *find_committer_by_nickname(const char *name)
+{
+	return find_identity_by_nickname(name, 0);
 }
 
 static void handle_ignored_arg(struct wt_status *s)
@@ -1321,6 +1368,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
 
+	if (force_committer && !strchr(force_committer, '>'))
+		force_committer = find_committer_by_nickname(force_committer);
+
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 
@@ -1709,6 +1759,7 @@ int cmd_commit(int argc,
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
 		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
 		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
+		OPT_STRING(0, "committer", &force_committer, N_("committer"), N_("override committer for commit")),
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
@@ -1785,6 +1836,7 @@ int cmd_commit(int argc,
 
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	struct object_id oid;
 	struct commit_list *parents = NULL;
@@ -1930,8 +1982,12 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	if (force_committer)
+		determine_committer_info(&committer_ident);
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
-				 parents, &oid, author_ident.buf, NULL,
+				 parents, &oid, author_ident.buf,
+				 force_committer ? committer_ident.buf : NULL,
 				 sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
@@ -1980,6 +2036,7 @@ cleanup:
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
 	strbuf_release(&err);
 	strbuf_release(&sb);
 	free(logfile);
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 8e373b566b..7e163e02d1 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -12,13 +12,20 @@ author_header () {
 	sed -n -e '/^$/q' -e '/^author /p'
 }
 
+committer_header () {
+	git cat-file commit "$1" |
+	sed -n -e '/^$/q' -e '/^committer /p'
+}
+
 message_body () {
 	git cat-file commit "$1" |
 	sed -e '1,/^$/d'
 }
 
 test_expect_success '-C option copies authorship and message' '
-	test_commit --author Frigate\ \<flying@over.world\> \
+	test_env GIT_COMMITTER_NAME="Frigate" \
+		GIT_COMMITTER_EMAIL="flying@over.world" \
+		test_commit --author Frigate\ \<flying@over.world\> \
 		"Initial Commit" foo Initial Initial &&
 	echo "Test 1" >>foo &&
 	test_tick &&
@@ -171,4 +178,79 @@ test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success '--committer option overrides committer' '
+	git checkout Initial &&
+	echo "Test --committer" >>foo &&
+	test_tick &&
+	git commit -a -m "test committer" --committer="Custom Committer <custom@committer.example>" &&
+	committer_header HEAD >actual &&
+	grep "Custom Committer <custom@committer.example>" actual
+'
+
+test_expect_success '--committer with pattern search' '
+	echo "Test committer pattern" >>foo &&
+	test_tick &&
+	git commit -a -m "test committer pattern" --committer="Frigate" &&
+	committer_header HEAD >actual &&
+	grep "Frigate <flying@over.world>" actual
+'
+
+test_expect_success '--committer malformed parameter' '
+	echo "Test malformed" >>foo &&
+	test_tick &&
+	test_must_fail git commit -a -m "test malformed" --committer="malformed committer"
+'
+
+test_expect_success '--committer with --amend option' '
+	git checkout -f Initial &&
+	echo "Test committer with amend" >>foo &&
+	test_tick &&
+	git commit -a -m "initial commit for amend test" &&
+	echo "Modified for amend" >>foo &&
+	test_tick &&
+	git commit -a --amend --no-edit \
+		--author="Test Author <test@author.example>" \
+		--committer="Test Committer <test@committer.example>" &&
+	author_header HEAD >actual_author &&
+	grep "Test Author <test@author.example>" actual_author &&
+	committer_header HEAD >actual_committer &&
+	grep "Test Committer <test@committer.example>" actual_committer
+'
+
+test_expect_success 'GIT_COMMITTER_* environment variables' '
+	git checkout -f Initial &&
+	echo "Test env vars" >>foo &&
+	test_tick &&
+	test_env GIT_COMMITTER_NAME="Env Committer" \
+		GIT_COMMITTER_EMAIL="env@test.example" \
+		git commit -a -m "test committer env vars" &&
+	committer_header HEAD >actual &&
+	grep "Env Committer <env@test.example>" actual
+'
+
+test_expect_success '--committer overrides GIT_COMMITTER_* environment variables' '
+	echo "Test override" >>foo &&
+	test_tick &&
+	test_env GIT_COMMITTER_NAME="Env Committer" \
+		GIT_COMMITTER_EMAIL="env@test.example" \
+		git commit -a -m "test override" \
+		--committer="Override Committer <override@test.example>" &&
+	committer_header HEAD >actual &&
+	grep "Override Committer <override@test.example>" actual
+'
+
+test_expect_success '--date with --committer changes both author and committer dates' '
+	git checkout -f Initial &&
+	echo "Test date override" >>foo &&
+	test_tick &&
+	git commit -a -m "test date" \
+		--author="Date Author <date@author.example>" \
+		--committer="Date Committer <date@committer.example>" \
+		--date="2024-06-15 10:30:00 +0800" &&
+	git log -1 --format="%ai" >author_date &&
+	git log -1 --format="%ci" >committer_date &&
+	grep "2024-06-15 10:30:00 +0800" author_date &&
+	grep "2024-06-15 10:30:00 +0800" committer_date
+'
+
 test_done

base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
-- 
gitgitgadget
