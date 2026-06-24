Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1C30AAB8
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272388; cv=none; b=ZHzm+4D+xrkGiwafuWoXUsTfk0LKLIRPhYVKG34yztLZ0tYcOWzt2oB8df6NNx8kjb57OPkQ5KBz/AtM4LgRLIgRTBHMbqSAnO61FH9IwBG/v4iC4gqlx3E5LzQmS1yhnWmayKXXNoXErqFCVqw1Iii4Jc8DLkyD+VxZwIySPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272388; c=relaxed/simple;
	bh=T1pLy3vVZAvp84cAx8pufJeRJAuMlqwpAwsRT070whg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RebSL2KZb2HpzFV7RvAN59MZ8plHDokZcfh0qeV9SOib2DBOeOf48xvVp9qefnLPJAfvlpNzGxM45Y2TiL8u9U8S6+GURtfQlC8obz1R1qc/74Cq485ydDZV8lEGo/5kMgXzt/esanbm1rrF5uso32Gzl8lxosxjYJGJamEHEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi/ECmK0; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi/ECmK0"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c6874d295so397360eec.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 20:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272386; x=1782877186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHok5FAOseNrF/YCsBxJ0WeJed4uu0ghvO4ZvSdZlCo=;
        b=Fi/ECmK0Su2tnLBAk2HNjLi8L9c5rG5MNzPY7kxtDfSzhQNyKJRgWMEEHDRvljZvUm
         IwBTiSJYeW52XpiFpwPKoGzo3kw7gghCEnA5rhzosE8CdjHf+v9zjRXJyxDntJGf4Jh3
         s9qPvY3gVSQ7osT+pOWGhOS7PLKA6Ch4AnR9VYSlBesVQ+oAMMBOqHgBJQm0bLxInlI+
         b323/J+12coKcKbGEvccueyqyrFqOkAeLPBBXZRbqsCx9gN/7FZxERV/JRZboOME+lvv
         plkIlpantMNEEaOSgT0JGOLxOZw+CISNsofe8tYwMsqmVPfxs02G1q+iey8kxr8J9dNz
         5pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272386; x=1782877186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHok5FAOseNrF/YCsBxJ0WeJed4uu0ghvO4ZvSdZlCo=;
        b=ZqqNbzXZQcj3PJsJW0tu1T13zhNn0yf8wzLy+jh6fEEP6Pk7SL+eUPtTHQhuFC7e9A
         PKzbnyHiYnHy6Rlq/w0ifyCDLl/hb9r+3V8NlOFevzvhwO8TIWUgPZdFLXEFE+TV2U5w
         AvbqQeNfrh4iEnMvZLzSuDnQ0FZb8oWvDu6udknwLfHgnTn8FoVL8VApXfTuvEcK+R94
         +LTbuSHXQ6cF4LjDtsfZkXVe+1BobC8yeI0hzsl32BCPHHcyjg/SKj5uE0OroslTkZ3N
         Gd4nsh4PprqlHOGa/Zd89uA7R6C7a8oWGNvKsGoOBUPfhJtG19cnbLSl/cgU1rEkN9sx
         S0Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rqh+PE4Kd+mgL7xHoWFJCrD9x90dw1YYiWGofQIlv+qC3lRN71JXwMukePbtCvK9xbK+s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfc1i86rYeO17y99RU+/Zy6LbzGftCW4Yj0JjbnJGGiVFZxY9B
	UgYXfOmc0sPXF9f7XX1y4OS/N8BVnQWEqWOKPYSLXrJWznMWM30/4pH8
X-Gm-Gg: AfdE7cldl+YLa9QDwL2CKokuedk97Zta7qjaFFggwOhz69jxkbS5r7wH83UWtffRulR
	yphoxBTU7RTAzF0XjOG1XkVNIdT/1wQCZKGOb2oyNkGBktqDFti6LaKZpdcg5CvssoaErIL0Q9x
	wEB0wE4N96zaCbT0HG60IlGVMWNJWT6F2GJthVqbmARwZStF2uWEX/jZ1BJzaOXDaWlYk0eRH97
	iRrllsr6UMBaco41Y6A/1S/pGgv3qXlWI2dkfQ7EtK5CaCCDZ3q3EfHwTA09QkDtG3QiXiwPIuS
	yNeKn+RA0V4J9M1NuLFZCgjIlIN2pwqbobVbyCq7llz2TXOXsvO83LLaZMRRBqJIf71tnDOkQQK
	GVCKeZ6p8XAZ+8Hzw1cCm0c6Xcef1jFOv0pf368ULrbSxAI6JNuud16BR9q0mzZ76m7VY8CcRH8
	PiN7vs7oik0e+z3IMthX9MkU2CsRYUD60m6EKX4p0gqYkSzLoau7IniIbqq7vro0oYM/TXqZ/yp
	2oNblK3nGQZiuUecBx/uG1+i2EinApzUQ==
X-Received: by 2002:a05:7300:642a:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-30c555b8663mr6061014eec.12.1782272386294;
        Tue, 23 Jun 2026 20:39:46 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm23924891eec.20.2026.06.23.20.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:39:45 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v8 0/3] teach git repo info to handle path keys
Date: Wed, 24 Jun 2026 09:07:45 +0530
Message-ID: <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

3. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

   Changes since v7:

   * Renamed the helper to format_path() and changed semantics to replace/reset
     the destination buffer instead of appending (Junio).
   * Eliminated wasteful intermediate strbuf allocations (e.g., canonical_buf)
     by passing the destination buffer directly where safe (Junio).
   * Refactored the print_path() switch logic in rev-parse.c to evaluate
     FORMAT_DEFAULT first for better readability and future-proofing (Junio).

   Keeping the name as format_path() made sense to me. I understand we already
   had a discussion stating format_path() wasn't a good name back then because
   we were clearly appending to the buffer.

   I believe it is a good name now. Although, if there are any other name
   suggestions, I am happy to change it.

   P.S: I have thought of:
     replace_formatted_path
     strbuf_format_path
     populate_formatted_path

   In the end, I came to the conclusion that format_path() is simply better.

Tagging Justin Tobler, Lucas Seiki Oshiro, Junio,
Phillip Wood, brian m. carlson, and Ayush Jha.

Thanks for helping improve this series!

K Jayatheerth (3):
  path: extract format_path() and use in rev-parse
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc | 15 +++++++
 builtin/repo.c              | 50 +++++++++++++++++++++++
 builtin/rev-parse.c         | 79 +++++++++++++++++--------------------
 path.c                      | 69 ++++++++++++++++++++++++++++++++
 path.h                      | 30 ++++++++++++++
 t/t1900-repo-info.sh        | 58 +++++++++++++++++++++++++++
 6 files changed, 258 insertions(+), 43 deletions(-)

Range-diff against v7:
1:  bb1d3fd06f ! 1:  287281935e path: extract append_formatted_path() and use in rev-parse
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    path: extract append_formatted_path() and use in rev-parse
    +    path: extract format_path() and use in rev-parse
     
         Path formatting logic in builtin/rev-parse.c writes directly to
         stdout. Other builtins cannot reuse it.
     
    -    Extract this logic into append_formatted_path() in path.c and expose
    +    Extract this logic into format_path() in path.c and expose
         a path_format enum in path.h.
     
         Convert rev-parse to use the new helper in the same step to validate
    @@ builtin/rev-parse.c: enum default_type {
     +	struct strbuf sb = STRBUF_INIT;
     +	enum path_format fmt;
     +
    -+	if (format == FORMAT_RELATIVE) {
    -+		fmt = PATH_FORMAT_RELATIVE;
    -+	} else if (format == FORMAT_CANONICAL) {
    -+		fmt = PATH_FORMAT_CANONICAL;
    -+	} else /* FORMAT_DEFAULT */ {
    ++	if (format == FORMAT_DEFAULT) {
     +		switch (def) {
     +		case DEFAULT_RELATIVE:
     +			fmt = PATH_FORMAT_RELATIVE;
    @@ builtin/rev-parse.c: enum default_type {
     -		struct strbuf buf = STRBUF_INIT;
     -		puts(relative_path(path, prefix, &buf));
     -		strbuf_release(&buf);
    --	} else {
    + 	} else {
     -		struct strbuf buf = STRBUF_INIT;
     -		strbuf_realpath_forgiving(&buf, path, 1);
     -		puts(buf.buf);
     -		strbuf_release(&buf);
    ++		switch (format) {
    ++		case FORMAT_RELATIVE:
    ++			fmt = PATH_FORMAT_RELATIVE;
    ++			break;
    ++		case FORMAT_CANONICAL:
    ++			fmt = PATH_FORMAT_CANONICAL;
    ++			break;
    ++		default:
    ++			fmt = PATH_FORMAT_UNMODIFIED;
    ++			break;
    ++		}
      	}
     -	free(cwd);
     +
    -+	append_formatted_path(&sb, path, prefix, fmt);
    ++	format_path(&sb, path, prefix, fmt);
     +	puts(sb.buf);
     +
     +	strbuf_release(&sb);
    @@ path.c: char *xdg_cache_home(const char *filename)
      	return NULL;
      }
      
    -+void append_formatted_path(struct strbuf *dest, const char *path,
    -+			   const char *prefix, enum path_format format)
    ++void format_path(struct strbuf *dest, const char *path,
    ++		 const char *prefix, enum path_format format)
     +{
    ++	strbuf_reset(dest);
    ++
     +	switch (format) {
     +	case PATH_FORMAT_UNMODIFIED:
     +		strbuf_addstr(dest, path);
    @@ path.c: char *xdg_cache_home(const char *filename)
     +		break;
     +	}
     +
    -+	case PATH_FORMAT_CANONICAL: {
    -+		struct strbuf canonical_buf = STRBUF_INIT;
    -+
    -+		strbuf_realpath_forgiving(&canonical_buf, path, 1);
    -+		strbuf_addbuf(dest, &canonical_buf);
    -+
    -+		strbuf_release(&canonical_buf);
    ++	case PATH_FORMAT_CANONICAL:
    ++		/*
    ++		 * strbuf_realpath_forgiving inherently resets the destination
    ++		 * buffer, safely aligning with our replace semantics.
    ++		 */
    ++		strbuf_realpath_forgiving(dest, path, 1);
     +		break;
    -+	}
     +
     +	default:
     +		BUG("unknown path_format value %d", format);
    @@ path.h: enum scld_error safe_create_leading_directories_no_share(char *path);
     +};
     +
     +/**
    -+ * Format a path according to the specified formatting strategy and append
    -+ * the result to the given strbuf.
    ++ * Format a path according to the specified formatting strategy and store
    ++ * the result in the given strbuf, replacing any existing contents.
     + *
    -+ * `dest`   : The string buffer to append the formatted path to.
    ++ * `dest`   : The string buffer to store the formatted path into.
     + * `path`   : The path string that needs to be formatted.
     + * `prefix` : The directory prefix to calculate relative offsets against.
     + * Pass NULL to default to the current working directory where applicable.
     + * `format` : The formatting behavior rule to execute.
     + */
    -+void append_formatted_path(struct strbuf *dest, const char *path,
    -+			   const char *prefix, enum path_format format);
    ++void format_path(struct strbuf *dest, const char *path,
    ++		 const char *prefix, enum path_format format);
     +
      # ifdef USE_THE_REPOSITORY_VARIABLE
      #  include "strbuf.h"
2:  d2414bee58 ! 2:  69517f1a08 repo: add path.commondir with absolute and relative suffix formatting
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!common_dir)
     +		return error(_("unable to get common directory"));
     +
    -+	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!common_dir)
     +		return error(_("unable to get common directory"));
     +
    -+	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
3:  9962c7d530 ! 3:  ce43453975 repo: add path.gitdir with absolute and relative suffix formatting
    @@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo,
     +	if (!git_dir)
     +		return error(_("unable to get git directory"));
     +
    -+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo,
     +	if (!git_dir)
     +		return error(_("unable to get git directory"));
     +
    -+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
-- 
2.55.0-rc1
