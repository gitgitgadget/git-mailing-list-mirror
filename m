Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0921286A9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763221419; cv=none; b=cxSiseyfEFxswJzJiL+Doms/4Vqc1123sFDlfD3eM/jkJIydHQ5SMtWPA76l/R18KrBYHwBQizGi6/Od921OVpzQsj34LvQ2Q+nuO8mPLstExHVFIsuBfGMhUuBrqXg08OMoU97lDz9wVpL1gPnQrM7Q5Pbc0Ej9yOZEO4V+2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763221419; c=relaxed/simple;
	bh=ujqqbuYL9Wrk6AhGrPgoaWq0eSKILfg2TeDRNFSDqnU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f5MpkFNuT7J8uwH5ePn1WJ9XzN4y1qg41FxR9Uf956rszgpPx7Ub8KY+yNxtdFxQajm6yby6S9MaDEpDUonwRX02v92qudV5P7QURSO656MU6eYwhjUsriUrf+5HNhVJzFjgCG6I0CCzldiCiuyQIs8a9/t1fNUV/T5MBkW61Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU45Ar4s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU45Ar4s"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so3661216b3a.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 07:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763221415; x=1763826215; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h+I8cFJZnRWrokbsIp5T/czeMQojy6ZWTkQi1/iRjE=;
        b=BU45Ar4shEQBHh3Pkql6oj4TRHIEpd4t9MBBDruFxmoVcv3eOFSUNF6F7+WgZiMYKY
         iT88D6Q0Skm8KUtJsq2Kqp5Fg21DjJU8dIk8OmzPPl74DgG2Cy15ueJZo0gmk2KbwLkV
         oGEwsnUdSuIXW7NSO3ScpfaKEKuurbrkBdCDCaqiYKqZKrJdXsXPM2FcSz7pOBhLt1AA
         SQhVh4scDNCeMnAJP/weA9gKOwilEGiWtoB42NB+wIL0BUS77LGkem9fd8fX2t+keGu6
         ifcPZxL7mTK2j0HqrAvPJt5OghtLVTChEhHrw7e3YY9CxAS7v9S5E+V41yi/Q6ox+kJ3
         0Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763221415; x=1763826215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7h+I8cFJZnRWrokbsIp5T/czeMQojy6ZWTkQi1/iRjE=;
        b=SjNkgxqgHNuCAAvMMz/Ss7qG6CEYFV4AwFZ720/3Iclqv8Bmax02WbFX3sIMthH3Tw
         UKw2PzXW+/eHKdcKcX46cSrRtaoLCoJ0bNQkwDOxIEevgWztX4K7msv+Q7w6sW5NjfsT
         MsurM2Pcq2Ll10YaBo9gZgrZPe8SH7x3+1btu6O+82afmAOWrthMcUbdWr8XkjX0kcwD
         KiAxeGKBKLr49JA1QFt3MLrt7YNmq9PZd2nlgbgz8G5Sivd3TYNINspd1uPrnXJ+iE1N
         +V+2nQqjoHF7b03JopeRYZvZOYxVKO5ctLAqPtnvBt+0E+yZxCbv3enZhNHF3Lwz9+rM
         CaIQ==
X-Gm-Message-State: AOJu0YzgzXxHjSfyCZLAzR4rziVj0o4v75mvEi62tCwD1FTG7+8Kr84N
	Svr5B5Q55wr5OI31Cf2Vq+rmIYnlqX24Os+kaIZHqwdDeRoUYwxDc5TVL86btw==
X-Gm-Gg: ASbGncshYgxFRnAaqQQz17YzyuGIZNXcsKISbbW1tVOQpDYhCUUgv40QoLdTfI1ADk6
	wpjp5jrnCcuv/Y/pg2pCufP+JUsGnDpCtrFblCDFpJbixtaLQPhkYcUhy5LatBUxIXVWogJ6xex
	vSE6gQqp1x0OxsBGmPupTPaG4eUlQ0UM1qf3qv37apI/SQhtOIaPeuSuYDm9Zg38uY04brT7OFG
	XtucongY5aiuWY5PC+PjYHOJd1cPfbtYLhupTXFcFpNsJBTEj2aIYpklXQAZPiXeyyWcmZrwOgM
	fSkzfqhoLVv7rV6OFuAS8n/ZD+eiM/jXcHRep8GXaAwwlsPhUAjC9tMrG/PnZPE+hm6Dv4Jns2Y
	vLUIsdPOkLfXfYKya5SseXwpyUzjBGoKkwbUAXwy/HEoJ1NkxRjs3mnIJto6lquFd5sVdJYIaup
	8m1ORkPVkka0zzHbY=
X-Google-Smtp-Source: AGHT+IHzbeWhteMmxds4Ts25VxG3es1l3BoohDBfRvKyC/dq6gf4qbYhD+2MW0oCMoFbQ2ziJ0D7BA==
X-Received: by 2002:a05:7022:612:b0:11b:65e:f2c with SMTP id a92af1059eb24-11b40fb06ecmr3303282c88.10.1763221415312;
        Sat, 15 Nov 2025 07:43:35 -0800 (PST)
Received: from [127.0.0.1] ([172.184.219.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm24416537c88.7.2025.11.15.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 07:43:34 -0800 (PST)
Message-Id: <pull.1997.v4.git.1763221413640.gitgitgadget@gmail.com>
In-Reply-To: <pull.1997.v3.git.1762966535495.gitgitgadget@gmail.com>
References: <pull.1997.v3.git.1762966535495.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 15:43:33 +0000
Subject: [PATCH v4] commit: add --committer option
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%2Fadlternative%2Fzh%2Fimplement-committer-option-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adlternative/zh/implement-committer-option-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1997

Range-diff vs v3:

 1:  acf724fad5 ! 1:  bb17f810ef commit: add --committer option
     @@ Documentation/git-commit.adoc: See linkgit:git-rebase[1] for details.
       	the commit author is then copied from the first such commit found.
       
      +`--committer=<committer>`::
     -+	Override the committer for the commit. Specify an explicit committer using the
     ++	Set the committer for the commit. Specify an explicit committer using the
      +	standard `C O Mitter <committer@example.com>` format. Otherwise _<committer>_
      +	is assumed to be a pattern and is used to search for an existing
      +	commit by that committer (i.e. `git rev-list --all -i --committer=<committer>`);
     @@ builtin/commit.c: static void set_ident_var(char **buf, char *val)
       }
       
      -static void determine_author_info(struct strbuf *author_ident)
     -+static void determine_identity(struct strbuf *ident_str, int is_author)
     - {
     - 	char *name, *email, *date;
     +-{
     +-	char *name, *email, *date;
      -	struct ident_split author;
     --
     ++static void set_author_from_message(char **name, char **email, char **date) {
     ++	struct ident_split ident;
     ++	size_t len;
     ++	const char *a;
     + 
      -	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
      -	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
      -	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
     --
     ++	if (!author_message)
     ++		return;
     + 
      -	if (author_message) {
      -		struct ident_split ident;
     -+	struct ident_split ident;
     -+	const char *env_name = is_author ? "GIT_AUTHOR_NAME" : "GIT_COMMITTER_NAME";
     -+	const char *env_email = is_author ? "GIT_AUTHOR_EMAIL" : "GIT_COMMITTER_EMAIL";
     -+	const char *env_date = is_author ? "GIT_AUTHOR_DATE" : "GIT_COMMITTER_DATE";
     -+	const char *force_ident = is_author ? force_author : force_committer;
     -+	const char *param_name = is_author ? "--author" : "--committer";
     -+	int ident_flag = is_author ? WANT_AUTHOR_IDENT : WANT_COMMITTER_IDENT;
     -+
     -+	name = xstrdup_or_null(getenv(env_name));
     -+	email = xstrdup_or_null(getenv(env_email));
     -+	date = xstrdup_or_null(getenv(env_date));
     -+
     -+	if (is_author && author_message) {
     -+		struct ident_split msg_ident;
     - 		size_t len;
     - 		const char *a;
     - 
     - 		a = find_commit_header(author_message_buffer, "author", &len);
     - 		if (!a)
     - 			die(_("commit '%s' lacks author header"), author_message);
     +-		size_t len;
     +-		const char *a;
     +-
     +-		a = find_commit_header(author_message_buffer, "author", &len);
     +-		if (!a)
     +-			die(_("commit '%s' lacks author header"), author_message);
      -		if (split_ident_line(&ident, a, len) < 0)
     -+		if (split_ident_line(&msg_ident, a, len) < 0)
     - 			die(_("commit '%s' has malformed author line"), author_message);
     - 
     +-			die(_("commit '%s' has malformed author line"), author_message);
     +-
      -		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
      -		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     -+		set_ident_var(&name, xmemdupz(msg_ident.name_begin, msg_ident.name_end - msg_ident.name_begin));
     -+		set_ident_var(&email, xmemdupz(msg_ident.mail_begin, msg_ident.mail_end - msg_ident.mail_begin));
     - 
     +-
      -		if (ident.date_begin) {
     -+		if (msg_ident.date_begin) {
     - 			struct strbuf date_buf = STRBUF_INIT;
     - 			strbuf_addch(&date_buf, '@');
     +-			struct strbuf date_buf = STRBUF_INIT;
     +-			strbuf_addch(&date_buf, '@');
      -			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
     -+			strbuf_add(&date_buf, msg_ident.date_begin, msg_ident.date_end - msg_ident.date_begin);
     - 			strbuf_addch(&date_buf, ' ');
     +-			strbuf_addch(&date_buf, ' ');
      -			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
     -+			strbuf_add(&date_buf, msg_ident.tz_begin, msg_ident.tz_end - msg_ident.tz_begin);
     - 			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     - 		}
     +-			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     +-		}
     ++	a = find_commit_header(author_message_buffer, "author", &len);
     ++	if (!a)
     ++		die(_("commit '%s' lacks author header"), author_message);
     ++	if (split_ident_line(&ident, a, len) < 0)
     ++		die(_("commit '%s' has malformed author line"), author_message);
     ++
     ++	set_ident_var(name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
     ++	set_ident_var(email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     ++
     ++	if (ident.date_begin) {
     ++		struct strbuf date_buf = STRBUF_INIT;
     ++		strbuf_addch(&date_buf, '@');
     ++		strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
     ++		strbuf_addch(&date_buf, ' ');
     ++		strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
     ++		set_ident_var(date, strbuf_detach(&date_buf, NULL));
       	}
     ++}
       
      -	if (force_author) {
      -		struct ident_split ident;
     ++static void determine_identity(struct strbuf *ident_str, enum want_ident whose_ident,
     ++			       const char *env_name, const char *env_email, const char *env_date,
     ++			       const char *force_ident, const char *param_name,
     ++			       char *name, char *email, char *date)
     ++{
     ++	struct ident_split ident;
     ++
     ++
      +	if (force_ident) {
      +		struct ident_split force_ident_split;
     -+
     -+		if (split_ident_line(&force_ident_split, force_ident, strlen(force_ident)) < 0)
     -+			die(_("malformed %s parameter"), param_name);
     -+		set_ident_var(&name, xmemdupz(force_ident_split.name_begin, force_ident_split.name_end - force_ident_split.name_begin));
     -+		set_ident_var(&email, xmemdupz(force_ident_split.mail_begin, force_ident_split.mail_end - force_ident_split.mail_begin));
       
      -		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
      -			die(_("malformed --author parameter"));
      -		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
      -		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
     -+		if (!is_author && force_ident_split.date_begin) {
     -+			struct strbuf date_buf = STRBUF_INIT;
     -+			strbuf_addch(&date_buf, '@');
     -+			strbuf_add(&date_buf, force_ident_split.date_begin, force_ident_split.date_end - force_ident_split.date_begin);
     -+			strbuf_addch(&date_buf, ' ');
     -+			strbuf_add(&date_buf, force_ident_split.tz_begin, force_ident_split.tz_end - force_ident_split.tz_begin);
     -+			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
     -+		}
     ++		if (split_ident_line(&force_ident_split, force_ident, strlen(force_ident)) < 0)
     ++			die(_("malformed %s parameter"), param_name);
     ++		set_ident_var(&name, xmemdupz(force_ident_split.name_begin, force_ident_split.name_end - force_ident_split.name_begin));
     ++		set_ident_var(&email, xmemdupz(force_ident_split.mail_begin, force_ident_split.mail_end - force_ident_split.mail_begin));
       	}
       
       	if (force_date) {
     @@ builtin/commit.c: static void determine_author_info(struct strbuf *author_ident)
       	}
       
      -	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
     -+	strbuf_addstr(ident_str, fmt_ident(name, email, ident_flag, date,
     ++	strbuf_addstr(ident_str, fmt_ident(name, email, whose_ident, date,
       				IDENT_STRICT));
      -	assert_split_ident(&author, author_ident);
      -	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
     @@ builtin/commit.c: static void determine_author_info(struct strbuf *author_ident)
      -	export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
      +	assert_split_ident(&ident, ident_str);
      +
     -+	if (is_author) {
     -+		export_one("GIT_AUTHOR_NAME", ident.name_begin, ident.name_end, 0);
     -+		export_one("GIT_AUTHOR_EMAIL", ident.mail_begin, ident.mail_end, 0);
     -+		export_one("GIT_AUTHOR_DATE", ident.date_begin, ident.tz_end, '@');
     -+	} else {
     -+		export_one("GIT_COMMITTER_NAME", ident.name_begin, ident.name_end, 0);
     -+		export_one("GIT_COMMITTER_EMAIL", ident.mail_begin, ident.mail_end, 0);
     -+		export_one("GIT_COMMITTER_DATE", ident.date_begin, ident.tz_end, '@');
     -+	}
     ++	export_one(env_name, ident.name_begin, ident.name_end, 0);
     ++	export_one(env_email, ident.mail_begin, ident.mail_end, 0);
     ++	export_one(env_date, ident.date_begin, ident.tz_end, '@');
      +
       	free(name);
       	free(email);
     @@ builtin/commit.c: static void determine_author_info(struct strbuf *author_ident)
       
      +static void determine_author_info(struct strbuf *author_ident)
      +{
     -+	determine_identity(author_ident, 1);
     ++	char *name, *email, *date;
     ++
     ++	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
     ++	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
     ++	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
     ++
     ++	set_author_from_message(&name, &email, &date);
     ++
     ++	determine_identity(author_ident, WANT_AUTHOR_IDENT,
     ++			   "GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL", "GIT_AUTHOR_DATE",
     ++			   force_author, "--author",
     ++			   name, email, date);
      +}
      +
      +static void determine_committer_info(struct strbuf *committer_ident)
      +{
     -+	determine_identity(committer_ident, 0);
     ++	char *name, *email, *date;
     ++
     ++	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
     ++	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
     ++	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
     ++
     ++	determine_identity(committer_ident, WANT_COMMITTER_IDENT,
     ++			   "GIT_COMMITTER_NAME", "GIT_COMMITTER_EMAIL", "GIT_COMMITTER_DATE",
     ++			   force_committer, "--committer",
     ++			   name, email, date);
      +}
      +
       static int author_date_is_interesting(void)
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       }
       
      -static const char *find_author_by_nickname(const char *name)
     -+static const char *find_identity_by_nickname(const char *name, int is_author)
     ++static const char *find_identity_by_nickname(const char *name, enum want_ident whose_ident)
       {
       	struct rev_info revs;
       	struct commit *commit;
       	struct strbuf buf = STRBUF_INIT;
       	const char *av[20];
       	int ac = 0;
     -+	const char *field = is_author ? "author" : "committer";
     -+	const char *format = is_author ? "%aN <%aE>" : "%cN <%cE>";
     ++	const char *field, *format;
     ++
     ++	if (whose_ident != WANT_AUTHOR_IDENT && whose_ident != WANT_COMMITTER_IDENT)
     ++		BUG("find_identity_by_nickname requires WANT_AUTHOR_IDENT or WANT_COMMITTER_IDENT");
     ++
     ++	field = whose_ident == WANT_AUTHOR_IDENT ? "author" : "committer";
     ++	format = whose_ident == WANT_AUTHOR_IDENT ? "%aN <%aE>" : "%cN <%cE>";
       
       	repo_init_revisions(the_repository, &revs, NULL);
      -	strbuf_addf(&buf, "--author=%s", name);
     @@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
      +
      +static const char *find_author_by_nickname(const char *name)
      +{
     -+	return find_identity_by_nickname(name, 1);
     ++	return find_identity_by_nickname(name, WANT_AUTHOR_IDENT);
      +}
      +
      +static const char *find_committer_by_nickname(const char *name)
      +{
     -+	return find_identity_by_nickname(name, 0);
     ++	return find_identity_by_nickname(name, WANT_COMMITTER_IDENT);
       }
       
       static void handle_ignored_arg(struct wt_status *s)


 Documentation/git-commit.adoc |   9 +-
 builtin/commit.c              | 155 ++++++++++++++++++++++++----------
 t/t7509-commit-authorship.sh  |  84 +++++++++++++++++-
 3 files changed, 200 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 54c207ad45..a0c8a586de 100644
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
+	Set the committer for the commit. Specify an explicit committer using the
+	standard `C O Mitter <committer@example.com>` format. Otherwise _<committer>_
+	is assumed to be a pattern and is used to search for an existing
+	commit by that committer (i.e. `git rev-list --all -i --committer=<committer>`);
+	the commit committer is then copied from the first such commit found.
+
 `--date=<date>`::
 	Override the author date used in the commit.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..13138a3868 100644
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
@@ -630,46 +631,48 @@ static void set_ident_var(char **buf, char *val)
 	*buf = val;
 }
 
-static void determine_author_info(struct strbuf *author_ident)
-{
-	char *name, *email, *date;
-	struct ident_split author;
+static void set_author_from_message(char **name, char **email, char **date) {
+	struct ident_split ident;
+	size_t len;
+	const char *a;
 
-	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
-	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
-	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
+	if (!author_message)
+		return;
 
-	if (author_message) {
-		struct ident_split ident;
-		size_t len;
-		const char *a;
-
-		a = find_commit_header(author_message_buffer, "author", &len);
-		if (!a)
-			die(_("commit '%s' lacks author header"), author_message);
-		if (split_ident_line(&ident, a, len) < 0)
-			die(_("commit '%s' has malformed author line"), author_message);
-
-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
-
-		if (ident.date_begin) {
-			struct strbuf date_buf = STRBUF_INIT;
-			strbuf_addch(&date_buf, '@');
-			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
-			strbuf_addch(&date_buf, ' ');
-			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
-			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
-		}
+	a = find_commit_header(author_message_buffer, "author", &len);
+	if (!a)
+		die(_("commit '%s' lacks author header"), author_message);
+	if (split_ident_line(&ident, a, len) < 0)
+		die(_("commit '%s' has malformed author line"), author_message);
+
+	set_ident_var(name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
+	set_ident_var(email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+
+	if (ident.date_begin) {
+		struct strbuf date_buf = STRBUF_INIT;
+		strbuf_addch(&date_buf, '@');
+		strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
+		strbuf_addch(&date_buf, ' ');
+		strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
+		set_ident_var(date, strbuf_detach(&date_buf, NULL));
 	}
+}
 
-	if (force_author) {
-		struct ident_split ident;
+static void determine_identity(struct strbuf *ident_str, enum want_ident whose_ident,
+			       const char *env_name, const char *env_email, const char *env_date,
+			       const char *force_ident, const char *param_name,
+			       char *name, char *email, char *date)
+{
+	struct ident_split ident;
+
+
+	if (force_ident) {
+		struct ident_split force_ident_split;
 
-		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
-			die(_("malformed --author parameter"));
-		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
-		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+		if (split_ident_line(&force_ident_split, force_ident, strlen(force_ident)) < 0)
+			die(_("malformed %s parameter"), param_name);
+		set_ident_var(&name, xmemdupz(force_ident_split.name_begin, force_ident_split.name_end - force_ident_split.name_begin));
+		set_ident_var(&email, xmemdupz(force_ident_split.mail_begin, force_ident_split.mail_end - force_ident_split.mail_begin));
 	}
 
 	if (force_date) {
@@ -679,17 +682,49 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+	strbuf_addstr(ident_str, fmt_ident(name, email, whose_ident, date,
 				IDENT_STRICT));
-	assert_split_ident(&author, author_ident);
-	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
-	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
-	export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
+	assert_split_ident(&ident, ident_str);
+
+	export_one(env_name, ident.name_begin, ident.name_end, 0);
+	export_one(env_email, ident.mail_begin, ident.mail_end, 0);
+	export_one(env_date, ident.date_begin, ident.tz_end, '@');
+
 	free(name);
 	free(email);
 	free(date);
 }
 
+static void determine_author_info(struct strbuf *author_ident)
+{
+	char *name, *email, *date;
+
+	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
+	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
+	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
+
+	set_author_from_message(&name, &email, &date);
+
+	determine_identity(author_ident, WANT_AUTHOR_IDENT,
+			   "GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL", "GIT_AUTHOR_DATE",
+			   force_author, "--author",
+			   name, email, date);
+}
+
+static void determine_committer_info(struct strbuf *committer_ident)
+{
+	char *name, *email, *date;
+
+	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
+	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
+	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
+
+	determine_identity(committer_ident, WANT_COMMITTER_IDENT,
+			   "GIT_COMMITTER_NAME", "GIT_COMMITTER_EMAIL", "GIT_COMMITTER_DATE",
+			   force_committer, "--committer",
+			   name, email, date);
+}
+
 static int author_date_is_interesting(void)
 {
 	return author_message || force_date;
@@ -1137,16 +1172,23 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-static const char *find_author_by_nickname(const char *name)
+static const char *find_identity_by_nickname(const char *name, enum want_ident whose_ident)
 {
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *av[20];
 	int ac = 0;
+	const char *field, *format;
+
+	if (whose_ident != WANT_AUTHOR_IDENT && whose_ident != WANT_COMMITTER_IDENT)
+		BUG("find_identity_by_nickname requires WANT_AUTHOR_IDENT or WANT_COMMITTER_IDENT");
+
+	field = whose_ident == WANT_AUTHOR_IDENT ? "author" : "committer";
+	format = whose_ident == WANT_AUTHOR_IDENT ? "%aN <%aE>" : "%cN <%cE>";
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	strbuf_addf(&buf, "--author=%s", name);
+	strbuf_addf(&buf, "--%s=%s", field, name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
 	av[++ac] = buf.buf;
@@ -1164,11 +1206,22 @@ static const char *find_author_by_nickname(const char *name)
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
+	return find_identity_by_nickname(name, WANT_AUTHOR_IDENT);
+}
+
+static const char *find_committer_by_nickname(const char *name)
+{
+	return find_identity_by_nickname(name, WANT_COMMITTER_IDENT);
 }
 
 static void handle_ignored_arg(struct wt_status *s)
@@ -1321,6 +1374,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
 
+	if (force_committer && !strchr(force_committer, '>'))
+		force_committer = find_committer_by_nickname(force_committer);
+
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 
@@ -1709,6 +1765,7 @@ int cmd_commit(int argc,
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
 		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
 		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
+		OPT_STRING(0, "committer", &force_committer, N_("committer"), N_("override committer for commit")),
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
@@ -1785,6 +1842,7 @@ int cmd_commit(int argc,
 
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	struct object_id oid;
 	struct commit_list *parents = NULL;
@@ -1930,8 +1988,12 @@ int cmd_commit(int argc,
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
@@ -1980,6 +2042,7 @@ cleanup:
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
