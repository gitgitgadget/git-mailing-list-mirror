Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35A3911B5
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426232; cv=none; b=mr4AEAFFFdMLPADndhdxi5Xq7hWvT/QUnesmcNmHux2Ivji85fJmUelfjQ8rTjKJI5Rid0clCm4udK6xD3jJ5O+fIRKlfe+anBiw7Vmiso5myPqAA7s5OSiFFoOvf9rYeUlhNq0txT2cjXhfYZTBzIruWLX85+q9tmNve2TJJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426232; c=relaxed/simple;
	bh=4NxRRv9y1/63e/6L84WclnFp4k5GO0MeoUrDa1bF2jg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ibB9ZhgbB4nyM9cGtbWezDC9jzo893sdKzKV+04wokzqqW/QRFhN4lVEYX2zqJfYs0gAlv2DbUKnvUR+0t+fJ2LDXKCfJbvVxJ4Lz5pOkpHGcvJcmtWswff1nS/ngXTrHQ0H7QIXpPSN4+OFyxTXFMCEA2ZY2JE3nOo5xo7nLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmJLuxgr; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmJLuxgr"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so2041185b3a.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426228; x=1790031028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnXm8kuop1jgbjylBLOVIeDx603zmEFCgMRhuoWZA/A=;
        b=UmJLuxgrnuspWmrzACf29IKLmlHDxYVejZ3F37rNOQqWE1LwjdKqiU8IhVkIfB5sC2
         1xJ55OV5wL3bhOJUILLeq/ILqhFDlGMiPE2Ahbi7aTn2MjMVcJ4Tg9u3Va8jJrZKO7uP
         8OAC/FxC5X+vOC5hmz3fBBPjcBkQ7PFFzM7OQ75jvxCZQYPfIM9dOFE9HmwMl3uXslwl
         FhsEcRNZ/X4AVOkdd6DHvtcKTh/PB27E5yt3RxOgdM7YphY3uJ43qJARRWGQNV8uMmiI
         wvcWyhsyDdaGYmiTKJPaM4fkw/nAkg4299yy+dPkOff1PyrMmIz3ru9TEMKWkctbbRo0
         CgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426228; x=1790031028;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnXm8kuop1jgbjylBLOVIeDx603zmEFCgMRhuoWZA/A=;
        b=OVZPIfxIWtgj2xdWZOxVgm/Va2p3qlwBDbkO1UD9cD1RDOiZbTTM/66f9jQbt2+1Je
         JVEjWKWaqJ5LvvAy22w4Avoi6k9bK6V1mysY6lFHxyPaS4D9S8kj2zdTXybAzXWOqdSs
         R51MSmjRolG0010tpd+0wWygSDAmFu6FEZjs4RMWtFFvqE6jw969H+Jjg5zL/LWGjjlo
         FriV/YTaKj7XdK2/l9KTiuECWgUcZ5Pnq8Q/tJo4bMZEMFe3wZ17u4NP2fO8snhux26x
         yB8z+clg/D+e7zcMfjgCbC8mmIjie9qFBgKC44kP7xmunNIUdtL3BNU4MwUSUiwM9ImU
         jROw==
X-Gm-Message-State: AFuF++mBmt33YOpDgu+0TIkx4snPWi3CDQU7VFkWKu3+PqfTyAvDZMq4
	Xqhcs1Zacf2OyjCixedeT0lPsoO26lUoW1f+PJcYhSIQGHx1ssrwxK07mVX/sw==
X-Gm-Gg: AYBFou1cmWcg1sn7Qza+5rk603LjmnyE2M0vlL+EdEOQAxjnewwWgnDHybdPWJmJwLg
	qQAZPHdWaOazQjsn/sQzUTDZJD39eltBiePXhFgAJ9I4XKt6dXNtX7NHBcpp0DSUwCdgLQgBYyJ
	pHpygFQyQk1936qeRgJJ2sdJ++A3edJr45dnKZzH0V8HUj9nFuxa1601RahxADiqezuWIK2TgKl
	nnlIYyoBrK+AqOpHBGl+1DvOP1iW9of7YJhwvwm/9ZLAHdxxxqv8bGnbPtbA0mDKna993fuBtl6
	4X6FXg2yh9h78kruEN/+v/jU9yN8XU1xZeer0UZt7Lpug3Pp9GYt467c06HjtgeOWDdTXK+zroZ
	4037MYFxaroqlws/RdzEgTfaeNUMcA9B52A57xljOflS0fvBEc/BQ4jRw0bv3Rc/Ao2BLGk+xD0
	0Eavs6LwX5zgtmLxOGPxeWl0gFiNRIZSfqkpfJKz52wjpE0gkUqo7H2t7LV3JusCqp3DmEq0cRJ
	nso7gHQ
X-Received: by 2002:a05:6a00:3288:b0:86e:ff2c:49dc with SMTP id d2e1a72fcca58-86f86da1c44mr9955683b3a.24.1789426228145;
        Mon, 14 Sep 2026 15:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.40.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291c1601sm5414691b3a.31.2026.09.14.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:50:27 -0700 (PDT)
Message-Id: <pull.2388.v8.git.git.1789426226860.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 22:50:26 +0000
Subject: [PATCH v8] var: support broken-down idents, signing key, multiple
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
  GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL').
- When a single variable is requested, print its bare value for backward
  compatibility.
- When multiple variables are requested, model the output after
  'git var -l' by printing 'VARIABLE=value' pairs (or 'VARIABLE\nvalue\0'
  when '-z' is given).
- Format multi-valued variables in multi-variable mode as repeated
  'VARIABLE=value' entries (or 'VARIABLE\nvalue\0' with '-z'),
  eliminating stream ambiguity without extra trailing delimiters.
- When querying multiple variables, omit any variable that has no value,
  continue processing remaining variables, and exit with code 1.
- Support '-z' to terminate variable outputs with NUL bytes.
- Format 'git var -l -z' using the same convention as 'git config
  list -z' (newline separating key and value, NUL separating entries).
- Use parse_options() to strictly require options before arguments.
- Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    var: support broken-down idents, signing key, multiple args, and -z
    
    Teach git var to expose individual identity components and commit
    signing configuration, and allow querying multiple variables with
    optional NUL-termination.
    
    
    Changes since v7:
    =================
    
     * Modelled multi-variable querying after git var -l, printing
       VARIABLE=value pairs (or VARIABLE\nvalue\0 when -z is given) instead
       of bare values, per feedback from Junio C. Hamano.
     * Formatted multi-valued variables in multi-variable mode as repeated
       VARIABLE=value entries (or VARIABLE\nvalue\0 with -z), eliminating
       stream ambiguity and the need for extra trailing delimiters.
     * When querying multiple variables, unset variables are omitted from
       output and the command terminates with exit code 1.
     * Updated Documentation/git-var.adoc and t/t0007-git-var.sh
       accordingly.
    
    
    Changes since v6:
    =================
    
     * Grouped GIT_AUTHOR_* and GIT_COMMITTER_* entries together into
       concise definitions in Documentation/git-var.adoc to avoid repetitive
       descriptions, per feedback from Junio C. Hamano.
     * Added explicit BUG() checks in ident_part() for NULL name/email
       pointers and date/timezone to protect against unforeseen changes in
       split_ident_line().
     * Changed struct git_var member multiread to return void (void
       (*multiread)(struct string_list *)) since list->nr communicates
       length.
     * Simplified list_vars() to use an unconditional else block for
       ptr->multiread instead of redundant else if.
     * In cmd_var(), do not set a non-zero exit status for missing variables
       in multi-variable queries; callers can see the empty record (e.g.
       GIT_CONFIG_SYSTEM under GIT_CONFIG_NOSYSTEM), matching Phillip Wood's
       recommendation.
     * Used putc(term, stdout) in cmd_var() when emitting delimiters.
     * In t/t0007-git-var.sh, converted -z tests to pipe output through
       nul_to_q so test_cmp produces clean diffs rather than binary
       comparison errors.
    
    
    Changes since v5:
    =================
    
     * Reverted cosmetic refactoring in get_git_var() to keep the diff
       minimal and focused on adding ptr->multiread.
     * Added BUG("unknown ident_part %d", part) to default case in
       ident_part() and removed redundant NULL checks on split.name_begin
       and split.mail_begin.
     * Adopted first-class int (*multiread)(struct string_list *) callback
       in struct git_var for multi-valued variables like GIT_CONFIG_GLOBAL,
       cleanly populating a struct string_list instead of relying on
       embedded NUL buffers.
     * Improved GIT_AUTHOR_* and GIT_COMMITTER_* documentation in
       Documentation/git-var.adoc to describe the values that would be used
       if you were to run git commit right now.
     * Explicitly documented that single-variable queries and git var -l do
       not print an extra delimiter after multi-valued variables.
    
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v8
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v7:

 1:  87f5f459ed ! 1:  b9c14a51f5 var: support broken-down idents, signing key, multiple args, and -z
     @@ Commit message
          - Add GIT_SIGNING_KEY to resolve the key that would be used to sign
            the resulting commit if you were to run 'git commit' right now.
          - Allow passing multiple variable arguments (e.g., 'git var
     -      GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
     -      sequentially.
     +      GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL').
     +    - When a single variable is requested, print its bare value for backward
     +      compatibility.
     +    - When multiple variables are requested, model the output after
     +      'git var -l' by printing 'VARIABLE=value' pairs (or 'VARIABLE\nvalue\0'
     +      when '-z' is given).
     +    - Format multi-valued variables in multi-variable mode as repeated
     +      'VARIABLE=value' entries (or 'VARIABLE\nvalue\0' with '-z'),
     +      eliminating stream ambiguity without extra trailing delimiters.
     +    - When querying multiple variables, omit any variable that has no value,
     +      continue processing remaining variables, and exit with code 1.
          - Support '-z' to terminate variable outputs with NUL bytes.
          - Format 'git var -l -z' using the same convention as 'git config
            list -z' (newline separating key and value, NUL separating entries).
     -    - Delimit values of multi-valued variables with NUL when '-z' is given,
     -      and output an extra delimiter after multi-valued variables when
     -      querying multiple variables to disambiguate the stream.
     -    - When querying multiple variables, print an empty record for any
     -      variable that has no value and continue processing remaining variables.
          - Use parse_options() to strictly require options before arguments.
          - Update Documentation/git-var.adoc and t/t0007-git-var.sh.
      
     @@ Documentation/git-var.adoc: git-var - Show a Git logical variable
       -----------
      -Prints a Git logical variable. Exits with code 1 if the variable has
      -no value.
     -+Prints Git logical variables. Exits with code 1 if any requested
     -+variable has no value. When multiple variables are requested, an empty
     -+record (a blank line, or an empty NUL-terminated record when `-z` is given)
     -+is printed for any variable that has no value, and the command continues
     -+processing the remaining variables.
     ++Prints Git logical variables. When a single variable is requested, its
     ++bare value is printed. When multiple variables are requested, they are
     ++printed as `VARIABLE=value` pairs, separated by newlines.
     ++
     ++If `-z` is given, the output format changes depending on the mode:
     ++
     ++* With a single variable, the bare value is terminated by a NUL byte.
     ++* With multiple variables or with `-l`, the variable name and value are
     ++  separated by a newline, and each entry is terminated by a NUL byte
     ++  (`VARIABLE\nvalue\0`).
     ++
     ++If any requested variable has no value, nothing is printed for that
     ++variable, processing continues for the remaining variables, and the
     ++command exits with code 1.
       
       OPTIONS
       -------
     @@ Documentation/git-var.adoc: OPTIONS
       
      +`-z`::
      +	Terminate entries with NUL instead of newline. When used with
     -+	`-l`, the variable name and its value are separated by a newline,
     -+	and each entry is terminated with a NUL byte.
     ++	`-l` or when multiple variables are requested, the variable name
     ++	and its value are separated by a newline, and each entry is
     ++	terminated with a NUL byte.
      +
       EXAMPLES
       --------
     @@ Documentation/git-var.adoc: OPTIONS
      ++
      +------------
      +$ git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
     -+Eric W. Biederman
     -+ebiederm@lnxi.com
     ++GIT_AUTHOR_NAME=Eric W. Biederman
     ++GIT_AUTHOR_EMAIL=ebiederm@lnxi.com
      +------------
       
       VARIABLES
     @@ Documentation/git-var.adoc: endif::git-default-pager[]
      -multiple items.
      +values, which are separated by newlines (or NUL bytes if `-z` is given),
      +and are listed in order from highest to lowest priority. When querying
     -+multiple variables, an extra newline (or an extra NUL byte if `-z` is
     -+given) is printed after the values of a multi-valued variable to mark the
     -+end of its list. (Single-variable queries and `git var -l` do not print
     -+an extra delimiter). Callers should be prepared for any such path value to
     -+contain multiple items.
     ++multiple variables (or using `-l`), each value is output as a separate
     ++`VARIABLE=value` entry (or `VARIABLE\nvalue\0` with `-z`). Callers should
     ++be prepared for any such path value to contain multiple items.
       
       Note that paths are printed even if they do not exist, but not if they are
       disabled by other environment variables.
     @@ builtin/var.c: static struct git_var git_vars[] = {
       {
       	struct git_var *ptr;
      -	char *val;
     -+	char delim = nul_term ? '\n' : '=';
     -+	char term = nul_term ? '\0' : '\n';
     - 
     +-
      -	for (ptr = git_vars; ptr->read; ptr++)
      -		if ((val = ptr->read(0))) {
      -			if (ptr->multivalued && *val) {
      -				struct string_list list = STRING_LIST_INIT_DUP;
     -+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
     -+		if (ptr->read) {
     -+			char *val = ptr->read(0);
     - 
     +-
      -				string_list_split(&list, val, "\n", -1);
      -				for (size_t i = 0; i < list.nr; i++)
      -					printf("%s=%s\n", ptr->name, list.items[i].string);
      -				string_list_clear(&list, 0);
      -			} else {
      -				printf("%s=%s\n", ptr->name, val);
     ++	char delim = nul_term ? '\n' : '=';
     ++	char term = nul_term ? '\0' : '\n';
     ++
     ++	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
     ++		if (ptr->read) {
     ++			char *val = ptr->read(0);
     ++
      +			if (val) {
      +				printf("%s%c%s%c", ptr->name, delim, val, term);
      +				free(val);
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      -	char *val;
      +	int list = 0;
      +	int nul_term = 0;
     ++	int ret = 0;
      +	int i;
     ++	char delim;
      +	char term;
      +	struct option options[] = {
      +		OPT_BOOL('l', NULL, &list,
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      -	git_var = get_git_var(argv[1]);
      -	if (!git_var)
      -		usage(var_usage);
     ++	delim = nul_term ? '\n' : '=';
      +	term = nul_term ? '\0' : '\n';
     -+
     -+	for (i = 0; i < argc; i++) {
     -+		const struct git_var *git_var = get_git_var(argv[i]);
       
      -	val = git_var->read(IDENT_STRICT);
      -	if (!val)
      -		return 1;
     -+		if (!git_var)
     -+			usage_with_options(var_usage, options);
     ++	for (i = 0; i < argc; i++) {
     ++		const struct git_var *git_var = get_git_var(argv[i]);
       
      -	printf("%s\n", val);
      -	free(val);
     ++		if (!git_var)
     ++			usage_with_options(var_usage, options);
     ++
      +		if (git_var->read) {
      +			char *val = git_var->read(IDENT_STRICT);
      +
      +			if (!val) {
     -+				if (argc == 1)
     -+					return 1;
     -+				putc(term, stdout);
     ++				ret = 1;
      +				continue;
      +			}
     -+			printf("%s%c", val, term);
     ++			if (argc == 1)
     ++				printf("%s%c", val, term);
     ++			else
     ++				printf("%s%c%s%c", git_var->name, delim, val, term);
      +			free(val);
      +		} else {
      +			struct string_list list = STRING_LIST_INIT_DUP;
      +			size_t j;
      +
      +			git_var->multiread(&list);
     -+			if (argc == 1 && !list.nr) {
     -+				string_list_clear(&list, 0);
     -+				return 1;
     ++			if (!list.nr)
     ++				ret = 1;
     ++			for (j = 0; j < list.nr; j++) {
     ++				if (argc == 1)
     ++					printf("%s%c", list.items[j].string, term);
     ++				else
     ++					printf("%s%c%s%c", git_var->name, delim,
     ++					       list.items[j].string, term);
      +			}
     -+			for (j = 0; j < list.nr; j++)
     -+				printf("%s%c", list.items[j].string, term);
     -+			if (argc > 1)
     -+				putc(term, stdout);
      +			string_list_clear(&list, 0);
      +		}
      +	}
       
     - 	return 0;
     +-	return 0;
     ++	return ret;
       }
      
       ## t/t0007-git-var.sh ##
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +test_expect_success 'get multiple variables' '
      +	test_tick &&
      +	cat >expect <<-EOF &&
     -+	$GIT_AUTHOR_NAME
     -+	$GIT_AUTHOR_EMAIL
     -+	$GIT_COMMITTER_NAME
     -+	$GIT_COMMITTER_EMAIL
     ++	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
     ++	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
     ++	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
     ++	GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL
      +	EOF
      +	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
      +	test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +
      +test_expect_success 'get multiple variables with -z' '
      +	test_tick &&
     -+	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
     ++	printf "GIT_AUTHOR_NAME\n%sQGIT_AUTHOR_EMAIL\n%sQ" \
     ++		"$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
      +	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual.raw &&
      +	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +	test_must_fail git var GIT_AUTHOR_NAME -z
      +'
      +
     -+test_expect_success 'get multiple variables with unset variable outputs blank record' '
     ++test_expect_success 'get multiple variables with unset variable exits with 1 and omits unset' '
      +	test_config user.signingkey "" &&
      +	cat >expect <<-EOF &&
     -+	$GIT_AUTHOR_NAME
     -+
     -+	$GIT_COMMITTER_NAME
     ++	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
     ++	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
      +	EOF
     -+	git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
     ++	test_expect_code 1 git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'get multiple variables with -z and unset variable' '
      +	test_config user.signingkey "" &&
     -+	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "Q$GIT_COMMITTER_NAME" >expect &&
     -+	git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual.raw &&
     ++	printf "GIT_AUTHOR_NAME\n%sQGIT_COMMITTER_NAME\n%sQ" \
     ++		"$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
     ++	test_expect_code 1 git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual.raw &&
      +	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'get multiple variables including multi-valued variable' '
     ++	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     ++	cat >expect <<-EOF &&
     ++	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
     ++	GIT_CONFIG_GLOBAL=$TRASHDIR/foo/git/config
     ++	GIT_CONFIG_GLOBAL=$TRASHDIR/.gitconfig
     ++	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
     ++	EOF
     ++	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
     ++		git var GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'get multiple variables including multi-valued variable with -z' '
      +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     -+	printf "%sQ%sQ%sQQ%sQ" "$GIT_AUTHOR_NAME" \
     ++	printf "GIT_AUTHOR_NAME\n%sQGIT_CONFIG_GLOBAL\n%sQGIT_CONFIG_GLOBAL\n%sQGIT_AUTHOR_EMAIL\n%sQ" \
     ++		"$GIT_AUTHOR_NAME" \
      +		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
      +		"$GIT_AUTHOR_EMAIL" >expect &&
      +	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'get multiple variables with unset multi-valued variable' '
     ++	cat >expect <<-EOF &&
     ++	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
     ++	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
     ++	EOF
     ++	test_env GIT_CONFIG_GLOBAL= test_expect_code 1 git var GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_done


 Documentation/git-var.adoc |  74 +++++++++--
 builtin/var.c              | 263 +++++++++++++++++++++++++++++--------
 t/t0007-git-var.sh         | 151 +++++++++++++++++++++
 3 files changed, 424 insertions(+), 64 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..162d6d1722 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,12 +9,25 @@ git-var - Show a Git logical variable
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
+Prints Git logical variables. When a single variable is requested, its
+bare value is printed. When multiple variables are requested, they are
+printed as `VARIABLE=value` pairs, separated by newlines.
+
+If `-z` is given, the output format changes depending on the mode:
+
+* With a single variable, the bare value is terminated by a NUL byte.
+* With multiple variables or with `-l`, the variable name and value are
+  separated by a newline, and each entry is terminated by a NUL byte
+  (`VARIABLE\nvalue\0`).
+
+If any requested variable has no value, nothing is printed for that
+variable, processing continues for the remaining variables, and the
+command exits with code 1.
 
 OPTIONS
 -------
@@ -24,19 +37,56 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline. When used with
+	`-l` or when multiple variables are requested, the variable name
+	and its value are separated by a newline, and each entry is
+	terminated with a NUL byte.
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
+GIT_AUTHOR_NAME=Eric W. Biederman
+GIT_AUTHOR_EMAIL=ebiederm@lnxi.com
+------------
 
 VARIABLES
 ---------
 `GIT_AUTHOR_IDENT`::
-    The author of a piece of code.
+`GIT_AUTHOR_NAME`::
+`GIT_AUTHOR_EMAIL`::
+`GIT_AUTHOR_DATE`::
+    The authorship information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_AUTHOR_IDENT` consists of the author's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_AUTHOR_NAME`,
+    `GIT_AUTHOR_EMAIL`, and `GIT_AUTHOR_DATE`.
 
 `GIT_COMMITTER_IDENT`::
-    The person who put a piece of code into Git.
+`GIT_COMMITTER_NAME`::
+`GIT_COMMITTER_EMAIL`::
+`GIT_COMMITTER_DATE`::
+    The committer information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_COMMITTER_IDENT` consists of the committer's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_COMMITTER_NAME`,
+    `GIT_COMMITTER_EMAIL`, and `GIT_COMMITTER_DATE`.
+
+`GIT_SIGNING_KEY`::
+    The key that would be used to sign the resulting commit if you were
+    to run `git commit` right now.
 
 `GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
@@ -85,9 +135,11 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines, and are listed in order from highest to
-lowest priority.  Callers should be prepared for any such path value to contain
-multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given),
+and are listed in order from highest to lowest priority. When querying
+multiple variables (or using `-l`), each value is output as a separate
+`VARIABLE=value` entry (or `VARIABLE\nvalue\0` with `-z`). Callers should
+be prepared for any such path value to contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..3b651a3eb6 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,25 +12,109 @@
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
+			BUG("split_ident_line() gave NULL names???");
+		return xmemdupz(split.name_begin,
+				split.name_end - split.name_begin);
+	case IDENT_MAIL:
+		if (!split.mail_begin || !split.mail_end)
+			BUG("split_ident_line() gave NULL mail???");
+		return xmemdupz(split.mail_begin,
+				split.mail_end - split.mail_begin);
+	case IDENT_DATE:
+		if (!split.date_begin || !split.tz_end)
+			BUG("split_ident_line() gave NULL date/tz???");
+		return xmemdupz(split.date_begin,
+				split.tz_end - split.date_begin);
+	default:
+		BUG("unknown ident_part %d", part);
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
@@ -90,45 +174,61 @@ static char *git_config_val_system(int ident_flag UNUSED)
 	return NULL;
 }
 
-static char *git_config_val_global(int ident_flag UNUSED)
+static void git_config_val_global(struct string_list *list)
 {
-	struct strbuf buf = STRBUF_INIT;
 	char *user, *xdg;
-	size_t unused;
 
 	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
-		strbuf_addf(&buf, "%s\n", xdg);
+		string_list_append(list, xdg);
 	}
 	if (user && *user) {
 		normalize_path_copy(user, user);
-		strbuf_addf(&buf, "%s\n", user);
+		string_list_append(list, user);
 	}
 	free(xdg);
 	free(user);
-	strbuf_trim_trailing_newline(&buf);
-	if (buf.len == 0) {
-		strbuf_release(&buf);
-		return NULL;
-	}
-	return strbuf_detach(&buf, &unused);
 }
 
 struct git_var {
 	const char *name;
 	char *(*read)(int);
-	int multivalued;
+	void (*multiread)(struct string_list *);
 };
 static struct git_var git_vars[] = {
 	{
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
@@ -145,6 +245,10 @@ static struct git_var git_vars[] = {
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
@@ -163,8 +267,7 @@ static struct git_var git_vars[] = {
 	},
 	{
 		.name = "GIT_CONFIG_GLOBAL",
-		.read = git_config_val_global,
-		.multivalued = 1,
+		.multiread = git_config_val_global,
 	},
 	{
 		.name = "",
@@ -172,31 +275,37 @@ static struct git_var git_vars[] = {
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
+	char delim = nul_term ? '\n' : '=';
+	char term = nul_term ? '\0' : '\n';
+
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
+		if (ptr->read) {
+			char *val = ptr->read(0);
+
+			if (val) {
+				printf("%s%c%s%c", ptr->name, delim, val, term);
+				free(val);
 			}
-			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
+			size_t i;
+
+			ptr->multiread(&list);
+			for (i = 0; i < list.nr; i++)
+				printf("%s%c%s%c", ptr->name, delim,
+				       list.items[i].string, term);
+			string_list_clear(&list, 0);
 		}
+	}
 }
 
 static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
-	for (ptr = git_vars; ptr->read; ptr++) {
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			return ptr;
 		}
@@ -207,42 +316,90 @@ static const struct git_var *get_git_var(const char *var)
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
+	char delim;
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
+	delim = nul_term ? '\n' : '=';
+	term = nul_term ? '\0' : '\n';
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+	for (i = 0; i < argc; i++) {
+		const struct git_var *git_var = get_git_var(argv[i]);
 
-	printf("%s\n", val);
-	free(val);
+		if (!git_var)
+			usage_with_options(var_usage, options);
+
+		if (git_var->read) {
+			char *val = git_var->read(IDENT_STRICT);
+
+			if (!val) {
+				ret = 1;
+				continue;
+			}
+			if (argc == 1)
+				printf("%s%c", val, term);
+			else
+				printf("%s%c%s%c", git_var->name, delim, val, term);
+			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
+			size_t j;
+
+			git_var->multiread(&list);
+			if (!list.nr)
+				ret = 1;
+			for (j = 0; j < list.nr; j++) {
+				if (argc == 1)
+					printf("%s%c", list.items[j].string, term);
+				else
+					printf("%s%c%s%c", git_var->name, delim,
+					       list.items[j].string, term);
+			}
+			string_list_clear(&list, 0);
+		}
+	}
 
-	return 0;
+	return ret;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..da6cbaade9 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,155 @@ test_expect_success '`git var -l` works even without HOME' '
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
+	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
+	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
+	GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL
+	EOF
+	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z' '
+	test_tick &&
+	printf "GIT_AUTHOR_NAME\n%sQGIT_AUTHOR_EMAIL\n%sQ" \
+		"$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
+	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual.raw &&
+	printf "%sQ%sQ" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expect &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
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
+test_expect_success 'get multiple variables with unset variable exits with 1 and omits unset' '
+	test_config user.signingkey "" &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
+	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
+	EOF
+	test_expect_code 1 git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z and unset variable' '
+	test_config user.signingkey "" &&
+	printf "GIT_AUTHOR_NAME\n%sQGIT_COMMITTER_NAME\n%sQ" \
+		"$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
+	test_expect_code 1 git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
+	GIT_CONFIG_GLOBAL=$TRASHDIR/foo/git/config
+	GIT_CONFIG_GLOBAL=$TRASHDIR/.gitconfig
+	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
+	EOF
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	printf "GIT_AUTHOR_NAME\n%sQGIT_CONFIG_GLOBAL\n%sQGIT_CONFIG_GLOBAL\n%sQGIT_AUTHOR_EMAIL\n%sQ" \
+		"$GIT_AUTHOR_NAME" \
+		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
+		"$GIT_AUTHOR_EMAIL" >expect &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with unset multi-valued variable' '
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
+	EOF
+	test_env GIT_CONFIG_GLOBAL= test_expect_code 1 git var GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
