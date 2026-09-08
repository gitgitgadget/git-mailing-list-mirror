Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EB3B9D91
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900187; cv=none; b=ss0rro/QeU19iouPcGICDhVezTzb4WlazuYsdDsRsXWmXIwy+HxoVfyM5X8tNGIcNKiiQYHhLTMEvqGHefsr+/c6nPZmfpJU79N1phjKUzm6uFrp1ZwFuiO7jjm6dkYbk0os+2ay3fKgLxJ/iH7rdgiX2MndrDDwBxYgxu6NghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900187; c=relaxed/simple;
	bh=nDJ8OD+i8DIz+DF5lNpoRmGiqKxk1ZIqfKM2tNG0Hrk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hJN8xLFqT/pWrya1xSda12759n96r9qpNiwPbb6VrbIVRZGzUWfD8oDaq7mRsh5x/GTInTxoAeh2462vJNgEmp7FV8y1YSr21+Dpc/7MFn6spszmE+7iawEZVxBl4bPs3lD1UZ59idMD/ifpkC0/qk6ntnGSbkq8pLumZs4qKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYLktKm6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYLktKm6"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso3829077b3a.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900185; x=1789504985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ECoW117OEQRjnHXvKur9a8tw/weCRTLhrpVvBfgtR2s=;
        b=kYLktKm6IuwdNBvRDpgYYg6e4Kjxkx1k2tFKoqCUS2u8Na4Kd9TJRUaC/bcLGV4o3s
         R4zeQBD7oKQTnVjrwIfnxvybHJ+dsQdmj5v0czVe0S0/0CeRtSke2Gs0pVtxB7NO+bfQ
         9IJvmhSPua6fkGp4gjno6VvG+fXlO4QMtueGdC+dPsYod0hc6yVpwG2/89kFR5/bhQas
         GUfcKAcec5ypSp7hpjzvufx4Z6Dshyn/j6qepLGsXxZvUBy2meF7AaUot6w1UCJDT2aB
         z2u3+oMb4/T0GdlhOSeqVjDc7+NMeocnUi/4J9jPTUjvejMA7v5dqoFABTJWYY4HTUhx
         h7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900185; x=1789504985;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECoW117OEQRjnHXvKur9a8tw/weCRTLhrpVvBfgtR2s=;
        b=lD/cTaaJATrnuON0h87jXFbEBy7uC/mMp2qLuCOyBmK1FZHrji648QoLu3ZHXGjVVu
         GjiIOSCqIz3a9tJ9V5exLz1CkIA+1VuTLgWKTFq+exxpJ3xdtoBRk73v4cwUKVCfu4ZR
         sjepb9JcvjcL+pFYTyZsN/a8NgMTsFRJDnFvEDblibDoHj29NRZlWaR9vdk8BedIsHbU
         Y0FGHn2Ks2LA77ilfBbd/VdOcd4ny1qmVNXkXNLFV7v1AUCy/hYeH5yPpoeHexfKGMp/
         8+aYYpumrKUbc1LOaFGcRYxB+uyL4bFHICe0dVJ3SgcAJ5BTcvHz++OoXEWBphioONaX
         YQUw==
X-Gm-Message-State: AFuF++kb7Kbk++0nBkeKPEz34XBeWLC879EC6dS/BnOfBTciQEkIT4vq
	GvPr8cZfww/Ztb6WRaEbz0a3YuYzCSd5wEpzxV4cGAlIWg1u3pPFEuL9KGyRHA==
X-Gm-Gg: AYBFou0kSTiKyXn9Sy8yY1yH49n4lWJrvGw2mGdFGHo9QmrzrI3s0kW7dookpckZ9Xt
	PcEB9s4wDcn5TO9UK5n5CcYltqcDImhnl3iKNC2rbVjJ2YXZJO7P88iHZtCHwWds5lmangUkoLm
	j7p/bTSiCTxdBvdijCTrxeFZ3l/ggNJ6L77uy7a6hTqYRcLV0PuiM/hN+wwWZQaWSVKxX3lEddD
	bWe4oYOGuXMZU9zNGE1G3RDss+3vWEt7knHOsbEOSKRkgzGfBH0wk71abp3Jt5Jjc0IzH3DG6ll
	3H32iPlP9OOT+EgV1rDfvE6OqFOvLOz9KIxFwJO0bP6VVayW1ISTPlnrq6nEq1aoHIMxVF9AlNY
	5EANFUo0r3GvL9/fRaeP8Q5YDhyI5M4sRiwd3w6o8LCvuMeGstIVcUW069ym8y3ZxeQ46h8zJoS
	2cp+esIIOM8aSw4Hn8EXv4T6hOAniE4joBfJa+hxbP0hi/dlFK9XEA11zU+0hMFag=
X-Received: by 2002:a05:6a21:483:b0:3c4:3112:3b with SMTP id adf61e73a8af0-3da3a0a264fmr54302226637.18.1788900184312;
        Tue, 08 Sep 2026 13:43:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.155.33.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm44566479eec.7.2026.09.08.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:43:03 -0700 (PDT)
Message-Id: <pull.2388.v5.git.git.1788900182711.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:43:02 +0000
Subject: [PATCH v5] var: support broken-down idents, signing key, multiple
 args, and -z
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>

From: Andrew Pleeter <andrewpleeter@gmail.com>

While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
extracting individual components (name, email, or date) currently
requires callers to manually parse the composite string. Furthermore,
there is no way to query the resolved commit signing key through
'git var', and the command only accepts a single variable at a time.

Teach 'git var' to expose individual identity components and commit
signing configuration, and allow querying multiple variables with
optional NUL-termination:

- Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
- Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
- Add GIT_SIGNING_KEY to resolve the key that would be used to sign
  the resulting commit if you were to run 'git commit' right now.
- Allow passing multiple variable arguments (e.g., 'git var
  GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
  sequentially.
- Support '-z' to terminate variable outputs with NUL bytes.
- Format 'git var -l -z' using the same convention as 'git config
  list -z' (newline separating key and value, NUL separating entries).
- Delimit values of multi-valued variables with NUL when '-z' is given,
  and output an extra delimiter after multi-valued variables when
  querying multiple variables to disambiguate the stream.
- When querying multiple variables, print an empty record for any
  variable that has no value and continue processing remaining variables.
- Use parse_options() to strictly require options before arguments.
- Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    var: support broken-down idents, signing key, multiple args, and -z
    
    Teach git var to expose individual identity components and commit
    signing configuration, and allow querying multiple variables with
    optional NUL-termination.
    
    
    Changes since v4:
    =================
    
     * Simplified git_signing_key() to directly call get_signing_key() as
       used throughout Git (in tag, send-pack, and sign_buffer()).
     * Renamed null_term to nul_term across builtin/var.c, and simplified
       show_config() callback handling.
     * Replaced the redundant pre-validation loop in cmd_var() by validating
       arguments directly in the main execution loop.
     * When querying multiple variables, print an empty record (blank line
       or \0 with -z) for any variable that has no value, and continue
       printing remaining variables instead of terminating prematurely.
     * Switched multi-valued variable storage (git_config_val_global()) to
       internal \0 delimiters, iterating directly through string sequences
       without allocating a temporary string_list.
     * For multi-variable queries, output an extra delimiter (\n or \0)
       after multi-valued variables to clearly mark the end of their list.
     * Explicitly documented the git var -l -z format and multi-variable
       handling in Documentation/git-var.adoc.
     * Added comprehensive tests for unset variables and multi-valued stream
       delimiters in t/t0007-git-var.sh.
    
    
    Changes since v3:
    =================
    
     * Renamed GIT_DEFAULT_KEY to GIT_SIGNING_KEY per feedback from Phillip
       Wood and Junio C Hamano; dropped the alias mechanism and
       commit.gpgsign check.
     * Used parse_options() with PARSE_OPT_STOP_AT_NON_OPTION in
       builtin/var.c, strictly enforcing that options precede variable
       arguments.
     * Adopted git config list -z format (key\nvalue\0) for git var -l -z to
       prevent ambiguity with = in config keys.
     * Delimited multi-valued variable outputs (e.g. GIT_CONFIG_GLOBAL) with
       NUL bytes under -z.
     * Replaced char part in ident_part() with enum ident_part.
     * Split synopsis in Documentation/git-var.adoc into separate lines for
       -l and <variable>..., and removed awkward legacy phrasing ("of a
       piece of code").
     * Added tests in t/t0007-git-var.sh covering the new -z format,
       multi-valued -z, and argument ordering.
    
    
    Changes since v2:
    =================
    
     * Drop git ident / git whoami subcommand entirely.
     * Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
     * Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
     * Add GIT_SIGNING_KEY to resolve commit signing keys.
     * Teach git var to accept multiple variable arguments (git var <var1>
       <var2> ...).
     * Add -z option to terminate outputs with NUL bytes (including git var
       -l -z).
     * Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v5
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v4:

 1:  6fbf973e84 ! 1:  04833673ea var: support broken-down idents, signing key, multiple args, and -z
     @@ Commit message
          - Support '-z' to terminate variable outputs with NUL bytes.
          - Format 'git var -l -z' using the same convention as 'git config
            list -z' (newline separating key and value, NUL separating entries).
     -    - Delimit values of multi-valued variables with NUL when '-z' is given.
     +    - Delimit values of multi-valued variables with NUL when '-z' is given,
     +      and output an extra delimiter after multi-valued variables when
     +      querying multiple variables to disambiguate the stream.
     +    - When querying multiple variables, print an empty record for any
     +      variable that has no value and continue processing remaining variables.
          - Use parse_options() to strictly require options before arguments.
          - Update Documentation/git-var.adoc and t/t0007-git-var.sh.
      
     @@ Documentation/git-var.adoc: git-var - Show a Git logical variable
       
       DESCRIPTION
       -----------
     +-Prints a Git logical variable. Exits with code 1 if the variable has
     +-no value.
     ++Prints Git logical variables. Exits with code 1 if any requested
     ++variable has no value. When multiple variables are requested, an empty
     ++record (a blank line, or an empty NUL-terminated record when `-z` is given)
     ++is printed for any variable that has no value, and the command continues
     ++processing the remaining variables.
     + 
     + OPTIONS
     + -------
      @@ Documentation/git-var.adoc: OPTIONS
       	as well. (However, the configuration variables listing functionality
       	is deprecated in favor of `git config list`.)
       
      +`-z`::
     -+	Terminate entries with NUL instead of newline.
     ++	Terminate entries with NUL instead of newline. When used with
     ++	`-l`, the variable name and its value are separated by a newline,
     ++	and each entry is terminated with a NUL byte.
      +
       EXAMPLES
       --------
     @@ Documentation/git-var.adoc: endif::git-default-pager[]
      -lowest priority.  Callers should be prepared for any such path value to contain
      -multiple items.
      +values, which are separated by newlines (or NUL bytes if `-z` is given),
     -+and are listed in order from highest to lowest priority.  Callers should
     -+be prepared for any such path value to contain multiple items.
     ++and are listed in order from highest to lowest priority. When querying
     ++multiple variables, an extra newline (or an extra NUL byte if `-z` is
     ++given) is printed after the values of a multi-valued variable to mark the
     ++end of its list. Callers should be prepared for any such path value to
     ++contain multiple items.
       
       Note that paths are printed even if they do not exist, but not if they are
       disabled by other environment variables.
     @@ builtin/var.c
       #include "run-command.h"
      +#include "strbuf.h"
      +#include "string-list.h"
     -+
     + 
     +-static const char var_usage[] = "git var (-l | <variable>)";
      +static const char * const var_usage[] = {
      +	N_("git var [-z] -l"),
      +	N_("git var [-z] <variable>..."),
      +	NULL
      +};
     - 
     --static const char var_usage[] = "git var (-l | <variable>)";
     ++
      +enum ident_part {
      +	IDENT_NAME,
      +	IDENT_MAIL,
     @@ builtin/var.c
      +
      +static char *git_signing_key(int ident_flag UNUSED)
      +{
     -+	char *signing_key = NULL;
     -+
     -+	/*
     -+	 * An empty string in user.signingkey allows overriding and
     -+	 * clearing a key defined in an outer (e.g. global) config.
     -+	 */
     -+	if (!repo_config_get_string(the_repository,
     -+				    "user.signingkey", &signing_key)) {
     -+		if (!signing_key || !*signing_key) {
     -+			free(signing_key);
     -+			return NULL;
     -+		}
     -+		return signing_key;
     -+	}
     ++	char *signing_key = get_signing_key();
      +
     -+	signing_key = get_signing_key_id();
      +	if (signing_key && !*signing_key) {
      +		free(signing_key);
      +		return NULL;
     @@ builtin/var.c
       {
       	return xstrdup_or_null(git_editor());
      @@ builtin/var.c: static char *git_config_val_global(int ident_flag UNUSED)
     + 	git_global_config_paths(&user, &xdg);
     + 	if (xdg && *xdg) {
     + 		normalize_path_copy(xdg, xdg);
     +-		strbuf_addf(&buf, "%s\n", xdg);
     ++		strbuf_addstr(&buf, xdg);
     ++		strbuf_addch(&buf, '\0');
     + 	}
     + 	if (user && *user) {
     + 		normalize_path_copy(user, user);
     +-		strbuf_addf(&buf, "%s\n", user);
     ++		strbuf_addstr(&buf, user);
     ++		strbuf_addch(&buf, '\0');
     + 	}
       	free(xdg);
       	free(user);
     - 	strbuf_trim_trailing_newline(&buf);
     +-	strbuf_trim_trailing_newline(&buf);
      -	if (buf.len == 0) {
      +	if (!buf.len) {
       		strbuf_release(&buf);
       		return NULL;
       	}
     ++	strbuf_addch(&buf, '\0');
     + 	return strbuf_detach(&buf, &unused);
     + }
     + 
      @@ builtin/var.c: static struct git_var git_vars[] = {
       		.name = "GIT_COMMITTER_IDENT",
       		.read = committer,
     @@ builtin/var.c: static struct git_var git_vars[] = {
       };
       
      -static void list_vars(void)
     -+static void list_vars(int null_term)
     ++static void list_vars(int nul_term)
       {
       	struct git_var *ptr;
      -	char *val;
     @@ builtin/var.c: static struct git_var git_vars[] = {
      -				printf("%s=%s\n", ptr->name, val);
      -			}
      -			free(val);
     -+	char delim = null_term ? '\n' : '=';
     -+	char eol = null_term ? '\0' : '\n';
     ++	char delim = nul_term ? '\n' : '=';
     ++	char term = nul_term ? '\0' : '\n';
      +
      +	for (ptr = git_vars; ptr->read; ptr++) {
      +		char *val = ptr->read(0);
     @@ builtin/var.c: static struct git_var git_vars[] = {
      +		if (!val)
      +			continue;
      +
     -+		if (ptr->multivalued && *val) {
     -+			struct string_list list = STRING_LIST_INIT_DUP;
     -+
     -+			string_list_split(&list, val, "\n", -1);
     -+			for (size_t i = 0; i < list.nr; i++)
     -+				printf("%s%c%s%c", ptr->name, delim,
     -+				       list.items[i].string, eol);
     -+			string_list_clear(&list, 0);
     ++		if (ptr->multivalued) {
     ++			for (const char *s = val; *s; s += strlen(s) + 1)
     ++				printf("%s%c%s%c", ptr->name, delim, s, term);
      +		} else {
     -+			printf("%s%c%s%c", ptr->name, delim, val, eol);
     ++			printf("%s%c%s%c", ptr->name, delim, val, term);
       		}
      +		free(val);
      +	}
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
       static int show_config(const char *var, const char *value,
       		       const struct config_context *ctx, void *cb)
       {
     -+	int null_term = cb ? *(int *)cb : 0;
     ++	int *nul_term = cb;
     ++	char delim = *nul_term ? '\n' : '=';
     ++	char term = *nul_term ? '\0' : '\n';
      +
       	if (value)
      -		printf("%s=%s\n", var, value);
     -+		printf("%s%c%s%c", var, null_term ? '\n' : '=',
     -+		       value, null_term ? '\0' : '\n');
     ++		printf("%s%c%s%c", var, delim, value, term);
       	else
      -		printf("%s\n", var);
     -+		printf("%s%c", var, null_term ? '\0' : '\n');
     ++		printf("%s%c", var, term);
       	return git_default_config(var, value, ctx, cb);
       }
       
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      -	const struct git_var *git_var;
      -	char *val;
      +	int list = 0;
     -+	int null_term = 0;
     ++	int nul_term = 0;
     ++	int ret = 0;
      +	int i;
     ++	char term;
      +	struct option options[] = {
      +		OPT_BOOL('l', NULL, &list,
      +			 N_("list all variables")),
     -+		OPT_BOOL('z', NULL, &null_term,
     ++		OPT_BOOL('z', NULL, &nul_term,
      +			 N_("terminate entries with NUL")),
      +		OPT_END(),
      +	};
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      +	if (list) {
      +		if (argc)
      +			usage_with_options(var_usage, options);
     -+		repo_config(the_repository, show_config, &null_term);
     -+		list_vars(null_term);
     ++		repo_config(the_repository, show_config, &nul_term);
     ++		list_vars(nul_term);
       		return 0;
       	}
      +
      +	if (!argc)
      +		usage_with_options(var_usage, options);
     -+
     -+	for (i = 0; i < argc; i++) {
     -+		if (!get_git_var(argv[i]))
     -+			usage_with_options(var_usage, options);
     -+	}
      +
       	repo_config(the_repository, git_default_config, NULL);
       
      -	git_var = get_git_var(argv[1]);
      -	if (!git_var)
      -		usage(var_usage);
     ++	term = nul_term ? '\0' : '\n';
     ++
      +	for (i = 0; i < argc; i++) {
      +		const struct git_var *git_var = get_git_var(argv[i]);
      +		char *val;
     -+
     -+		val = git_var->read(IDENT_STRICT);
     -+		if (!val)
     -+			return 1;
       
      -	val = git_var->read(IDENT_STRICT);
      -	if (!val)
      -		return 1;
     -+		if (git_var->multivalued && null_term && *val) {
     -+			struct string_list values = STRING_LIST_INIT_DUP;
     ++		if (!git_var)
     ++			usage_with_options(var_usage, options);
       
      -	printf("%s\n", val);
      -	free(val);
     -+			string_list_split(&values, val, "\n", -1);
     -+			for (size_t j = 0; j < values.nr; j++) {
     -+				const char *s = values.items[j].string;
     ++		val = git_var->read(IDENT_STRICT);
     ++		if (!val) {
     ++			if (argc == 1)
     ++				return 1;
     ++			ret = 1;
     ++			printf("%c", term);
     ++			continue;
     ++		}
      +
     -+				printf("%s%c", s, '\0');
     -+			}
     -+			string_list_clear(&values, 0);
     ++		if (git_var->multivalued) {
     ++			for (const char *s = val; *s; s += strlen(s) + 1)
     ++				printf("%s%c", s, term);
     ++			if (argc > 1)
     ++				printf("%c", term);
      +		} else {
     -+			printf("%s%c", val, null_term ? '\0' : '\n');
     ++			printf("%s%c", val, term);
      +		}
      +		free(val);
      +	}
       
     - 	return 0;
     +-	return 0;
     ++	return ret;
       }
      
       ## t/t0007-git-var.sh ##
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +test_expect_success 'options must precede variable arguments' '
      +	test_must_fail git var GIT_AUTHOR_NAME -z
      +'
     ++
     ++test_expect_success 'get multiple variables with unset variable outputs blank record' '
     ++	test_config user.signingkey "" &&
     ++	cat >expect <<-EOF &&
     ++	$GIT_AUTHOR_NAME
     ++
     ++	$GIT_COMMITTER_NAME
     ++	EOF
     ++	test_must_fail git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'get multiple variables with -z and unset variable' '
     ++	test_config user.signingkey "" &&
     ++	printf "%s\0\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
     ++	test_must_fail git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'get multiple variables including multi-valued variable with -z' '
     ++	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     ++	printf "%s\0%s\0%s\0\0%s\0" "$GIT_AUTHOR_NAME" \
     ++		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
     ++		"$GIT_AUTHOR_EMAIL" >expect &&
     ++	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
     ++		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_done


 Documentation/git-var.adoc |  67 ++++++++--
 builtin/var.c              | 249 ++++++++++++++++++++++++++++++-------
 t/t0007-git-var.sh         | 123 ++++++++++++++++++
 3 files changed, 383 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..40f9f320ef 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,12 +9,16 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [synopsis]
-git var (-l | <variable>)
+git var [-z] -l
+git var [-z] <variable>...
 
 DESCRIPTION
 -----------
-Prints a Git logical variable. Exits with code 1 if the variable has
-no value.
+Prints Git logical variables. Exits with code 1 if any requested
+variable has no value. When multiple variables are requested, an empty
+record (a blank line, or an empty NUL-terminated record when `-z` is given)
+is printed for any variable that has no value, and the command continues
+processing the remaining variables.
 
 OPTIONS
 -------
@@ -24,19 +28,57 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline. When used with
+	`-l`, the variable name and its value are separated by a newline,
+	and each entry is terminated with a NUL byte.
+
 EXAMPLES
 --------
-	$ git var GIT_AUTHOR_IDENT
-	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
-
+* Get the author identity:
++
+------------
+$ git var GIT_AUTHOR_IDENT
+Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+------------
+
+* Get the author name and email:
++
+------------
+$ git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+Eric W. Biederman
+ebiederm@lnxi.com
+------------
 
 VARIABLES
 ---------
 `GIT_AUTHOR_IDENT`::
-    The author of a piece of code.
+    The author.
+
+`GIT_AUTHOR_NAME`::
+    The name of the author.
+
+`GIT_AUTHOR_EMAIL`::
+    The email of the author.
+
+`GIT_AUTHOR_DATE`::
+    The date and timezone of the author.
 
 `GIT_COMMITTER_IDENT`::
-    The person who put a piece of code into Git.
+    The committer.
+
+`GIT_COMMITTER_NAME`::
+    The name of the committer.
+
+`GIT_COMMITTER_EMAIL`::
+    The email of the committer.
+
+`GIT_COMMITTER_DATE`::
+    The date and timezone of the committer.
+
+`GIT_SIGNING_KEY`::
+    The key that would be used to sign the resulting commit if you were
+    to run `git commit` right now.
 
 `GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
@@ -85,9 +127,12 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines, and are listed in order from highest to
-lowest priority.  Callers should be prepared for any such path value to contain
-multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given),
+and are listed in order from highest to lowest priority. When querying
+multiple variables, an extra newline (or an extra NUL byte if `-z` is
+given) is printed after the values of a multi-valued variable to mark the
+end of its list. Callers should be prepared for any such path value to
+contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..a6d14d7b35 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,25 +12,116 @@
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
+#include "gpg-interface.h"
 #include "ident.h"
 #include "pager.h"
-#include "refs.h"
+#include "parse-options.h"
 #include "path.h"
-#include "strbuf.h"
+#include "refs.h"
 #include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char * const var_usage[] = {
+	N_("git var [-z] -l"),
+	N_("git var [-z] <variable>..."),
+	NULL
+};
+
+enum ident_part {
+	IDENT_NAME,
+	IDENT_MAIL,
+	IDENT_DATE,
+};
 
 static char *committer(int ident_flag)
 {
 	return xstrdup_or_null(git_committer_info(ident_flag));
 }
 
+static char *ident_part(const char *ident, enum ident_part part)
+{
+	struct ident_split split;
+
+	if (!ident)
+		return NULL;
+	if (split_ident_line(&split, ident, strlen(ident)))
+		return NULL;
+
+	switch (part) {
+	case IDENT_NAME:
+		if (!split.name_begin || !split.name_end)
+			return NULL;
+		return xmemdupz(split.name_begin,
+				split.name_end - split.name_begin);
+	case IDENT_MAIL:
+		if (!split.mail_begin || !split.mail_end)
+			return NULL;
+		return xmemdupz(split.mail_begin,
+				split.mail_end - split.mail_begin);
+	case IDENT_DATE:
+		if (!split.date_begin)
+			return NULL;
+		if (split.tz_end)
+			return xmemdupz(split.date_begin,
+					split.tz_end -
+					split.date_begin);
+		if (split.date_end)
+			return xmemdupz(split.date_begin,
+					split.date_end -
+					split.date_begin);
+		return NULL;
+	default:
+		return NULL;
+	}
+}
+
+static char *committer_name(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_NAME);
+}
+
+static char *committer_email(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_MAIL);
+}
+
+static char *committer_date(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_DATE);
+}
+
 static char *author(int ident_flag)
 {
 	return xstrdup_or_null(git_author_info(ident_flag));
 }
 
+static char *author_name(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_NAME);
+}
+
+static char *author_email(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_MAIL);
+}
+
+static char *author_date(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_DATE);
+}
+
+static char *git_signing_key(int ident_flag UNUSED)
+{
+	char *signing_key = get_signing_key();
+
+	if (signing_key && !*signing_key) {
+		free(signing_key);
+		return NULL;
+	}
+	return signing_key;
+}
+
 static char *editor(int ident_flag UNUSED)
 {
 	return xstrdup_or_null(git_editor());
@@ -99,19 +190,21 @@ static char *git_config_val_global(int ident_flag UNUSED)
 	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
-		strbuf_addf(&buf, "%s\n", xdg);
+		strbuf_addstr(&buf, xdg);
+		strbuf_addch(&buf, '\0');
 	}
 	if (user && *user) {
 		normalize_path_copy(user, user);
-		strbuf_addf(&buf, "%s\n", user);
+		strbuf_addstr(&buf, user);
+		strbuf_addch(&buf, '\0');
 	}
 	free(xdg);
 	free(user);
-	strbuf_trim_trailing_newline(&buf);
-	if (buf.len == 0) {
+	if (!buf.len) {
 		strbuf_release(&buf);
 		return NULL;
 	}
+	strbuf_addch(&buf, '\0');
 	return strbuf_detach(&buf, &unused);
 }
 
@@ -125,10 +218,34 @@ static struct git_var git_vars[] = {
 		.name = "GIT_COMMITTER_IDENT",
 		.read = committer,
 	},
+	{
+		.name = "GIT_COMMITTER_NAME",
+		.read = committer_name,
+	},
+	{
+		.name = "GIT_COMMITTER_EMAIL",
+		.read = committer_email,
+	},
+	{
+		.name = "GIT_COMMITTER_DATE",
+		.read = committer_date,
+	},
 	{
 		.name = "GIT_AUTHOR_IDENT",
 		.read = author,
 	},
+	{
+		.name = "GIT_AUTHOR_NAME",
+		.read = author_name,
+	},
+	{
+		.name = "GIT_AUTHOR_EMAIL",
+		.read = author_email,
+	},
+	{
+		.name = "GIT_AUTHOR_DATE",
+		.read = author_date,
+	},
 	{
 		.name = "GIT_EDITOR",
 		.read = editor,
@@ -145,6 +262,10 @@ static struct git_var git_vars[] = {
 		.name = "GIT_DEFAULT_BRANCH",
 		.read = default_branch,
 	},
+	{
+		.name = "GIT_SIGNING_KEY",
+		.read = git_signing_key,
+	},
 	{
 		.name = "GIT_SHELL_PATH",
 		.read = shell_path,
@@ -172,34 +293,35 @@ static struct git_var git_vars[] = {
 	},
 };
 
-static void list_vars(void)
+static void list_vars(int nul_term)
 {
 	struct git_var *ptr;
-	char *val;
-
-	for (ptr = git_vars; ptr->read; ptr++)
-		if ((val = ptr->read(0))) {
-			if (ptr->multivalued && *val) {
-				struct string_list list = STRING_LIST_INIT_DUP;
-
-				string_list_split(&list, val, "\n", -1);
-				for (size_t i = 0; i < list.nr; i++)
-					printf("%s=%s\n", ptr->name, list.items[i].string);
-				string_list_clear(&list, 0);
-			} else {
-				printf("%s=%s\n", ptr->name, val);
-			}
-			free(val);
+	char delim = nul_term ? '\n' : '=';
+	char term = nul_term ? '\0' : '\n';
+
+	for (ptr = git_vars; ptr->read; ptr++) {
+		char *val = ptr->read(0);
+
+		if (!val)
+			continue;
+
+		if (ptr->multivalued) {
+			for (const char *s = val; *s; s += strlen(s) + 1)
+				printf("%s%c%s%c", ptr->name, delim, s, term);
+		} else {
+			printf("%s%c%s%c", ptr->name, delim, val, term);
 		}
+		free(val);
+	}
 }
 
 static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
+
 	for (ptr = git_vars; ptr->read; ptr++) {
-		if (strcmp(var, ptr->name) == 0) {
+		if (!strcmp(var, ptr->name))
 			return ptr;
-		}
 	}
 	return NULL;
 }
@@ -207,42 +329,79 @@ static const struct git_var *get_git_var(const char *var)
 static int show_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	int *nul_term = cb;
+	char delim = *nul_term ? '\n' : '=';
+	char term = *nul_term ? '\0' : '\n';
+
 	if (value)
-		printf("%s=%s\n", var, value);
+		printf("%s%c%s%c", var, delim, value, term);
 	else
-		printf("%s\n", var);
+		printf("%s%c", var, term);
 	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_var(int argc,
 	    const char **argv,
-	    const char *prefix UNUSED,
+	    const char *prefix,
 	    struct repository *repo UNUSED)
 {
-	const struct git_var *git_var;
-	char *val;
+	int list = 0;
+	int nul_term = 0;
+	int ret = 0;
+	int i;
+	char term;
+	struct option options[] = {
+		OPT_BOOL('l', NULL, &list,
+			 N_("list all variables")),
+		OPT_BOOL('z', NULL, &nul_term,
+			 N_("terminate entries with NUL")),
+		OPT_END(),
+	};
 
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (strcmp(argv[1], "-l") == 0) {
-		repo_config(the_repository, show_config, NULL);
-		list_vars();
+	if (list) {
+		if (argc)
+			usage_with_options(var_usage, options);
+		repo_config(the_repository, show_config, &nul_term);
+		list_vars(nul_term);
 		return 0;
 	}
+
+	if (!argc)
+		usage_with_options(var_usage, options);
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
-	if (!git_var)
-		usage(var_usage);
+	term = nul_term ? '\0' : '\n';
+
+	for (i = 0; i < argc; i++) {
+		const struct git_var *git_var = get_git_var(argv[i]);
+		char *val;
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+		if (!git_var)
+			usage_with_options(var_usage, options);
 
-	printf("%s\n", val);
-	free(val);
+		val = git_var->read(IDENT_STRICT);
+		if (!val) {
+			if (argc == 1)
+				return 1;
+			ret = 1;
+			printf("%c", term);
+			continue;
+		}
+
+		if (git_var->multivalued) {
+			for (const char *s = val; *s; s += strlen(s) + 1)
+				printf("%s%c", s, term);
+			if (argc > 1)
+				printf("%c", term);
+		} else {
+			printf("%s%c", val, term);
+		}
+		free(val);
+	}
 
-	return 0;
+	return ret;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..92b68b9ab4 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,127 @@ test_expect_success '`git var -l` works even without HOME' '
 	)
 '
 
+test_expect_success 'get author identity components' '
+	test_tick &&
+	echo "$GIT_AUTHOR_NAME" >expect.name &&
+	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
+	echo "$GIT_AUTHOR_DATE" >expect.date &&
+	git var GIT_AUTHOR_NAME >actual.name &&
+	git var GIT_AUTHOR_EMAIL >actual.email &&
+	git var GIT_AUTHOR_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get committer identity components' '
+	test_tick &&
+	echo "$GIT_COMMITTER_NAME" >expect.name &&
+	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
+	echo "$GIT_COMMITTER_DATE" >expect.date &&
+	git var GIT_COMMITTER_NAME >actual.name &&
+	git var GIT_COMMITTER_EMAIL >actual.email &&
+	git var GIT_COMMITTER_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get multiple variables' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME
+	$GIT_AUTHOR_EMAIL
+	$GIT_COMMITTER_NAME
+	$GIT_COMMITTER_EMAIL
+	EOF
+	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z' '
+	test_tick &&
+	printf "%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
+	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual &&
+	printf "%s\0" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git var -l -z' '
+	git var -l -z >actual &&
+	tr "\0" "\n" <actual >actual.lines &&
+	echo "$GIT_AUTHOR_NAME" >expect &&
+	sed -n "/^GIT_AUTHOR_NAME$/{n;p;}" actual.lines >actual.author &&
+	test_cmp expect actual.author &&
+	echo false >expect &&
+	sed -n "/^core\.bare$/{n;p;}" actual.lines >actual.bare &&
+	test_cmp expect actual.bare
+'
+
+test_expect_success 'get GIT_SIGNING_KEY with user.signingkey configured' '
+	test_config user.signingkey "TEST_KEY_ID" &&
+	echo "TEST_KEY_ID" >expect &&
+	git var GIT_SIGNING_KEY >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get GIT_SIGNING_KEY fails when unset' '
+	test_config user.signingkey "" &&
+	test_must_fail git var GIT_SIGNING_KEY
+'
+
+test_expect_success 'git var -l lists new variables' '
+	git var -l >actual &&
+	test_grep "^GIT_AUTHOR_NAME=" actual &&
+	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
+	test_grep "^GIT_AUTHOR_DATE=" actual &&
+	test_grep "^GIT_COMMITTER_NAME=" actual &&
+	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
+	test_grep "^GIT_COMMITTER_DATE=" actual
+'
+
+test_expect_success 'git var -l lists GIT_SIGNING_KEY when configured' '
+	test_config user.signingkey "TEST_KEY_ID" &&
+	git var -l >actual &&
+	test_grep "^GIT_SIGNING_KEY=TEST_KEY_ID" actual
+'
+
+test_expect_success 'options must precede variable arguments' '
+	test_must_fail git var GIT_AUTHOR_NAME -z
+'
+
+test_expect_success 'get multiple variables with unset variable outputs blank record' '
+	test_config user.signingkey "" &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME
+
+	$GIT_COMMITTER_NAME
+	EOF
+	test_must_fail git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z and unset variable' '
+	test_config user.signingkey "" &&
+	printf "%s\0\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
+	test_must_fail git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	printf "%s\0%s\0%s\0\0%s\0" "$GIT_AUTHOR_NAME" \
+		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
+		"$GIT_AUTHOR_EMAIL" >expect &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
