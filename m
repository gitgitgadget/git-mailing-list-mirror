Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25A339386
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840599; cv=none; b=s/squPOb6mvn7pgO1GhXPY5PYiizwJfPY8tEKMO0BT48ANRSzxERq2JllqfRaBs64ygtqI++LD9hSfJnAlv03ERb0K4rf0Fjn+PrH4i4JjM1SDeg14wynwBUnkLSTUrVkyiHj/aAKgOIgW8BBIJGMeV1bu5cPU2wpmTcso/xdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840599; c=relaxed/simple;
	bh=gGXnVPy21eC4BqhBFzbvspCwtOBl+QwF1lzr03nz/j0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pqhCbxxHEksRFh7PpYcYFRO/fvan9xdQFX2PI07JYx/hteOfAE4RmVMFf187v/les1M4Dqivm5JWVyz7TU7AA7r56Fx8DZhYpBE+N+p+IsQO+QvP8U3sJp3UaEDg9xPxntrsghJ/MZEI1ASYu/t/647rmdkuyTeyMS01TIGahmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrRDzbZ0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrRDzbZ0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53024149d40so19973531cf.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 21:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788840594; x=1789445394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p0eOnkdullp8iDduGfep6Nt7tgfBO2ApctH/gD96cdY=;
        b=DrRDzbZ0IurKW4yRcu2xqHpIUCs1qDOejNUtCgX0e9qluj3hnemeD4e/8wHHajQeIX
         yQv4FwJaslDsBiXetuw22ZnEhosjruuM/UqyUD1wccbR8m9+T3fuZivlcDl7AC2yLfK3
         nvdLW2hskP5AhLfQJ6BGUAcmCHw2QUHR/+I4SQWVh4oZgD7COi1q2bnKbtU4D0OXz3OR
         HzZ6Zz2LaQS9p81h7kuDxWki81fkWxs4iUc1RG8kV6RmfozwZJUl19LJlNl12kA73ohq
         0ofF0MAxeU4S5FZuhgKq3InOLeyDuVGGczsMsTkMYn01h0HMtMZbQHeokhO3mq73RUWE
         UhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788840594; x=1789445394;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0eOnkdullp8iDduGfep6Nt7tgfBO2ApctH/gD96cdY=;
        b=XHdasHTiXmdaOOnKowD/UVVc99mxlgXG1JzzDsv1Gwmw9oaQeG3caaIJ21BBJ8ZUd7
         gtn8FhjZ3UhnjmdeuPt13hdO8Q2hNddxtLTHwH0HgXgeSpEMQhKtn3zO8eQ98HlG7Hdr
         ZlguSF8fl5GoAVA5mvJM057sJWxwZwLVDrP9IXWHm24rF6r/sbr8A4qe6IfxP1cKZVJ0
         KikWRMW0QSmThQ/LZG0FGdNWXaD6j1ElY5rQ/8zk9PV6mf2pKws7qPNQaLln0jaOjfwk
         6mEs/d7gJvTq6moaEhxvGU4CUn/8NJI0DnY6Ov6cpnYrOTvLjHS6ctkcbLqS+Bkg9om/
         0OhQ==
X-Gm-Message-State: AFuF++kypxeCyHI90DXtfG+omWfOltA8L/ewPkRbX0oPb7Y0nfOT919x
	VcxDy12hkdmvEycpB3ZnhvavEvmcka48Jcj9AZ17ZZllZIPJUQZSGdpDBiE+dw==
X-Gm-Gg: AYBFou1jcxdbok84yK6rkA6jLRHQ/b8DrgUPMXEH8poqxL1FE1/w8fZrcj7LJ3zd3Ef
	qEe584XRW3B46H/8p2CFAc+lvgnosvofgXSVr0v5qu2Avh+BFOpVNmIuDY9WlQedojLzTnIL9A5
	ll2j2gVqbwrtfU13apinWLhgUQtwvAgz3WAfDjrqIgOFABFCnGuOobNARHKcGUk8hz0so9NHp89
	F6g7bcWtsKjN6KFyOKMMSJUIgp8Y0/9OCsq3C76Y9lN0YrH5f+SlWyJvv8DolzmvO774+93szKV
	Q4D0e8FvzTwfM42RTy8d2ai0uFpJ9/VgScNWzTwuwDPuFmKfvF+6epip8kBmsNShE41RO/ti56M
	icg8yfaQdQRedyZKZyTadCMfcBr5oNp5hRHUgoG28glZiS30hK/OTbU4nkmkXh0ZPo+ijGfSV+l
	8qBSaMIweMgJjgLb1vsPRHne3zK43DW9AqcDIPOpAv83pKazMpgSOmYq9hzZBlWBNj9Q==
X-Received: by 2002:a05:622a:244a:b0:530:3bd3:1fa6 with SMTP id d75a77b69052e-530547d3a4fmr327348361cf.4.1788840594196;
        Mon, 07 Sep 2026 21:09:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.253.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91043b54cd6sm96514386d6.34.2026.09.07.21.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:09:53 -0700 (PDT)
Message-Id: <pull.2388.v4.git.git.1788840593177.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 04:09:53 +0000
Subject: [PATCH v4] var: support broken-down idents, signing key, multiple
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
- Delimit values of multi-valued variables with NUL when '-z' is given.
- Use parse_options() to strictly require options before arguments.
- Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    var: support broken-down idents, signing key, multiple args, and -z
    
    Teach git var to expose individual identity components and commit
    signing configuration, and allow querying multiple variables with
    optional NUL-termination.
    
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v4
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v3:

 1:  b86340dd0e ! 1:  6fbf973e84 var: support broken-down idents, default key, multiple args, and -z
     @@ Metadata
      Author: Andrew Pleeter <andrewpleeter@gmail.com>
      
       ## Commit message ##
     -    var: support broken-down idents, default key, multiple args, and -z
     +    var: support broken-down idents, signing key, multiple args, and -z
      
          While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
          extracting individual components (name, email, or date) currently
     @@ Commit message
      
          - Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
          - Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
     -    - Add GIT_DEFAULT_KEY (with GIT_SIGNING_KEY alias) to resolve the
     -      configured or default commit signing key ID / fingerprint.
     +    - Add GIT_SIGNING_KEY to resolve the key that would be used to sign
     +      the resulting commit if you were to run 'git commit' right now.
          - Allow passing multiple variable arguments (e.g., 'git var
            GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
            sequentially.
     -    - Support '-z' to terminate variable outputs and 'git var -l -z'
     -      entries with NUL bytes.
     +    - Support '-z' to terminate variable outputs with NUL bytes.
     +    - Format 'git var -l -z' using the same convention as 'git config
     +      list -z' (newline separating key and value, NUL separating entries).
     +    - Delimit values of multi-valued variables with NUL when '-z' is given.
     +    - Use parse_options() to strictly require options before arguments.
          - Update Documentation/git-var.adoc and t/t0007-git-var.sh.
      
          Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
     @@ Documentation/git-var.adoc: git-var - Show a Git logical variable
       --------
       [synopsis]
      -git var (-l | <variable>)
     -+git var (-l [-z] | [-z] <variable>...)
     ++git var [-z] -l
     ++git var [-z] <variable>...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-var.adoc: OPTIONS
       VARIABLES
       ---------
       `GIT_AUTHOR_IDENT`::
     -     The author of a piece of code.
     - 
     +-    The author of a piece of code.
     ++    The author.
     ++
      +`GIT_AUTHOR_NAME`::
     -+    The name of the author of a piece of code.
     ++    The name of the author.
      +
      +`GIT_AUTHOR_EMAIL`::
     -+    The email of the author of a piece of code.
     ++    The email of the author.
      +
      +`GIT_AUTHOR_DATE`::
     -+    The date and timezone of the author of a piece of code.
     -+
     - `GIT_COMMITTER_IDENT`::
     -     The person who put a piece of code into Git.
     ++    The date and timezone of the author.
       
     + `GIT_COMMITTER_IDENT`::
     +-    The person who put a piece of code into Git.
     ++    The committer.
     ++
      +`GIT_COMMITTER_NAME`::
     -+    The name of the person who put a piece of code into Git.
     ++    The name of the committer.
      +
      +`GIT_COMMITTER_EMAIL`::
     -+    The email of the person who put a piece of code into Git.
     ++    The email of the committer.
      +
      +`GIT_COMMITTER_DATE`::
     -+    The date and timezone of the person who put a piece of code into Git.
     -+
     -+`GIT_DEFAULT_KEY`::
     -+    The default commit signing key ID or fingerprint, if configured or enabled.
     ++    The date and timezone of the committer.
      +
     ++`GIT_SIGNING_KEY`::
     ++    The key that would be used to sign the resulting commit if you were
     ++    to run `git commit` right now.
     + 
       `GIT_EDITOR`::
           Text editor for use by Git commands.  The value is meant to be
     -     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
     +@@ Documentation/git-var.adoc: endif::git-default-pager[]
     +     The path to the global (per-user) configuration files, if any.
     + 
     + Most path values contain only one value. However, some can contain multiple
     +-values, which are separated by newlines, and are listed in order from highest to
     +-lowest priority.  Callers should be prepared for any such path value to contain
     +-multiple items.
     ++values, which are separated by newlines (or NUL bytes if `-z` is given),
     ++and are listed in order from highest to lowest priority.  Callers should
     ++be prepared for any such path value to contain multiple items.
     + 
     + Note that paths are printed even if they do not exist, but not if they are
     + disabled by other environment variables.
      
       ## builtin/var.c ##
      @@
     @@ builtin/var.c
      +#include "gpg-interface.h"
       #include "ident.h"
       #include "pager.h"
     - #include "refs.h"
     +-#include "refs.h"
     ++#include "parse-options.h"
       #include "path.h"
     - #include "strbuf.h"
     -+#include "strvec.h"
     +-#include "strbuf.h"
     ++#include "refs.h"
       #include "run-command.h"
     ++#include "strbuf.h"
     ++#include "string-list.h"
     ++
     ++static const char * const var_usage[] = {
     ++	N_("git var [-z] -l"),
     ++	N_("git var [-z] <variable>..."),
     ++	NULL
     ++};
       
      -static const char var_usage[] = "git var (-l | <variable>)";
     -+static const char var_usage[] = "git var (-l [-z] | [-z] <variable>...)";
     ++enum ident_part {
     ++	IDENT_NAME,
     ++	IDENT_MAIL,
     ++	IDENT_DATE,
     ++};
       
       static char *committer(int ident_flag)
       {
       	return xstrdup_or_null(git_committer_info(ident_flag));
       }
       
     -+static char *ident_part(const char *ident, char part)
     ++static char *ident_part(const char *ident, enum ident_part part)
      +{
      +	struct ident_split split;
      +
     @@ builtin/var.c
      +		return NULL;
      +
      +	switch (part) {
     -+	case 'n':
     ++	case IDENT_NAME:
      +		if (!split.name_begin || !split.name_end)
      +			return NULL;
     -+		return xmemdupz(split.name_begin, split.name_end - split.name_begin);
     -+	case 'e':
     ++		return xmemdupz(split.name_begin,
     ++				split.name_end - split.name_begin);
     ++	case IDENT_MAIL:
      +		if (!split.mail_begin || !split.mail_end)
      +			return NULL;
     -+		return xmemdupz(split.mail_begin, split.mail_end - split.mail_begin);
     -+	case 'd':
     ++		return xmemdupz(split.mail_begin,
     ++				split.mail_end - split.mail_begin);
     ++	case IDENT_DATE:
      +		if (!split.date_begin)
      +			return NULL;
      +		if (split.tz_end)
     -+			return xmemdupz(split.date_begin, split.tz_end - split.date_begin);
     ++			return xmemdupz(split.date_begin,
     ++					split.tz_end -
     ++					split.date_begin);
      +		if (split.date_end)
     -+			return xmemdupz(split.date_begin, split.date_end - split.date_begin);
     ++			return xmemdupz(split.date_begin,
     ++					split.date_end -
     ++					split.date_begin);
      +		return NULL;
      +	default:
      +		return NULL;
     @@ builtin/var.c
      +
      +static char *committer_name(int ident_flag)
      +{
     -+	return ident_part(git_committer_info(ident_flag), 'n');
     ++	return ident_part(git_committer_info(ident_flag), IDENT_NAME);
      +}
      +
      +static char *committer_email(int ident_flag)
      +{
     -+	return ident_part(git_committer_info(ident_flag), 'e');
     ++	return ident_part(git_committer_info(ident_flag), IDENT_MAIL);
      +}
      +
      +static char *committer_date(int ident_flag)
      +{
     -+	return ident_part(git_committer_info(ident_flag), 'd');
     ++	return ident_part(git_committer_info(ident_flag), IDENT_DATE);
      +}
      +
       static char *author(int ident_flag)
     @@ builtin/var.c
       
      +static char *author_name(int ident_flag)
      +{
     -+	return ident_part(git_author_info(ident_flag), 'n');
     ++	return ident_part(git_author_info(ident_flag), IDENT_NAME);
      +}
      +
      +static char *author_email(int ident_flag)
      +{
     -+	return ident_part(git_author_info(ident_flag), 'e');
     ++	return ident_part(git_author_info(ident_flag), IDENT_MAIL);
      +}
      +
      +static char *author_date(int ident_flag)
      +{
     -+	return ident_part(git_author_info(ident_flag), 'd');
     ++	return ident_part(git_author_info(ident_flag), IDENT_DATE);
      +}
      +
     -+static char *default_key(int ident_flag UNUSED)
     ++static char *git_signing_key(int ident_flag UNUSED)
      +{
     -+	int gpgsign = 0;
      +	char *signing_key = NULL;
      +
     -+	if (repo_config_get_string(the_repository, "user.signingkey", &signing_key) == 0 && signing_key && *signing_key)
     ++	/*
     ++	 * An empty string in user.signingkey allows overriding and
     ++	 * clearing a key defined in an outer (e.g. global) config.
     ++	 */
     ++	if (!repo_config_get_string(the_repository,
     ++				    "user.signingkey", &signing_key)) {
     ++		if (!signing_key || !*signing_key) {
     ++			free(signing_key);
     ++			return NULL;
     ++		}
      +		return signing_key;
     -+	free(signing_key);
     -+
     -+	if (repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign) == 0 && gpgsign)
     -+		return get_signing_key_id();
     ++	}
      +
     -+	return NULL;
     ++	signing_key = get_signing_key_id();
     ++	if (signing_key && !*signing_key) {
     ++		free(signing_key);
     ++		return NULL;
     ++	}
     ++	return signing_key;
      +}
      +
       static char *editor(int ident_flag UNUSED)
       {
       	return xstrdup_or_null(git_editor());
     +@@ builtin/var.c: static char *git_config_val_global(int ident_flag UNUSED)
     + 	free(xdg);
     + 	free(user);
     + 	strbuf_trim_trailing_newline(&buf);
     +-	if (buf.len == 0) {
     ++	if (!buf.len) {
     + 		strbuf_release(&buf);
     + 		return NULL;
     + 	}
      @@ builtin/var.c: static struct git_var git_vars[] = {
       		.name = "GIT_COMMITTER_IDENT",
       		.read = committer,
     @@ builtin/var.c: static struct git_var git_vars[] = {
       		.read = default_branch,
       	},
      +	{
     -+		.name = "GIT_DEFAULT_KEY",
     -+		.read = default_key,
     ++		.name = "GIT_SIGNING_KEY",
     ++		.read = git_signing_key,
      +	},
       	{
       		.name = "GIT_SHELL_PATH",
     @@ builtin/var.c: static struct git_var git_vars[] = {
      +static void list_vars(int null_term)
       {
       	struct git_var *ptr;
     - 	char *val;
     -+	char eol = null_term ? '\0' : '\n';
     - 
     - 	for (ptr = git_vars; ptr->read; ptr++)
     - 		if ((val = ptr->read(0))) {
     -@@ builtin/var.c: static void list_vars(void)
     - 
     - 				string_list_split(&list, val, "\n", -1);
     - 				for (size_t i = 0; i < list.nr; i++)
     +-	char *val;
     +-
     +-	for (ptr = git_vars; ptr->read; ptr++)
     +-		if ((val = ptr->read(0))) {
     +-			if (ptr->multivalued && *val) {
     +-				struct string_list list = STRING_LIST_INIT_DUP;
     +-
     +-				string_list_split(&list, val, "\n", -1);
     +-				for (size_t i = 0; i < list.nr; i++)
      -					printf("%s=%s\n", ptr->name, list.items[i].string);
     -+					printf("%s=%s%c", ptr->name, list.items[i].string, eol);
     - 				string_list_clear(&list, 0);
     - 			} else {
     +-				string_list_clear(&list, 0);
     +-			} else {
      -				printf("%s=%s\n", ptr->name, val);
     -+				printf("%s=%s%c", ptr->name, val, eol);
     - 			}
     - 			free(val);
     +-			}
     +-			free(val);
     ++	char delim = null_term ? '\n' : '=';
     ++	char eol = null_term ? '\0' : '\n';
     ++
     ++	for (ptr = git_vars; ptr->read; ptr++) {
     ++		char *val = ptr->read(0);
     ++
     ++		if (!val)
     ++			continue;
     ++
     ++		if (ptr->multivalued && *val) {
     ++			struct string_list list = STRING_LIST_INIT_DUP;
     ++
     ++			string_list_split(&list, val, "\n", -1);
     ++			for (size_t i = 0; i < list.nr; i++)
     ++				printf("%s%c%s%c", ptr->name, delim,
     ++				       list.items[i].string, eol);
     ++			string_list_clear(&list, 0);
     ++		} else {
     ++			printf("%s%c%s%c", ptr->name, delim, val, eol);
       		}
     -@@ builtin/var.c: static void list_vars(void)
     ++		free(val);
     ++	}
     + }
     + 
       static const struct git_var *get_git_var(const char *var)
       {
       	struct git_var *ptr;
     -+	if (!strcmp(var, "GIT_SIGNING_KEY"))
     -+		var = "GIT_DEFAULT_KEY";
     ++
       	for (ptr = git_vars; ptr->read; ptr++) {
     - 		if (strcmp(var, ptr->name) == 0) {
     +-		if (strcmp(var, ptr->name) == 0) {
     ++		if (!strcmp(var, ptr->name))
       			return ptr;
     +-		}
     + 	}
     + 	return NULL;
     + }
      @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
       static int show_config(const char *var, const char *value,
       		       const struct config_context *ctx, void *cb)
       {
      +	int null_term = cb ? *(int *)cb : 0;
     -+	char eol = null_term ? '\0' : '\n';
      +
       	if (value)
      -		printf("%s=%s\n", var, value);
     -+		printf("%s=%s%c", var, value, eol);
     ++		printf("%s%c%s%c", var, null_term ? '\n' : '=',
     ++		       value, null_term ? '\0' : '\n');
       	else
      -		printf("%s\n", var);
     -+		printf("%s%c", var, eol);
     ++		printf("%s%c", var, null_term ? '\0' : '\n');
       	return git_default_config(var, value, ctx, cb);
       }
       
     -@@ builtin/var.c: int cmd_var(int argc,
     - 	    const char *prefix UNUSED,
     + int cmd_var(int argc,
     + 	    const char **argv,
     +-	    const char *prefix UNUSED,
     ++	    const char *prefix,
       	    struct repository *repo UNUSED)
       {
      -	const struct git_var *git_var;
      -	char *val;
     -+	struct strvec vars = STRVEC_INIT;
      +	int list = 0;
      +	int null_term = 0;
      +	int i;
     ++	struct option options[] = {
     ++		OPT_BOOL('l', NULL, &list,
     ++			 N_("list all variables")),
     ++		OPT_BOOL('z', NULL, &null_term,
     ++			 N_("terminate entries with NUL")),
     ++		OPT_END(),
     ++	};
       
     - 	show_usage_if_asked(argc, argv, var_usage);
     +-	show_usage_if_asked(argc, argv, var_usage);
      -	if (argc != 2)
      -		usage(var_usage);
     ++	argc = parse_options(argc, argv, prefix, options,
     ++			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
       
      -	if (strcmp(argv[1], "-l") == 0) {
      -		repo_config(the_repository, show_config, NULL);
      -		list_vars();
     -+	for (i = 1; i < argc; i++) {
     -+		const char *arg = argv[i];
     -+
     -+		if (!strcmp(arg, "-l")) {
     -+			list = 1;
     -+		} else if (!strcmp(arg, "-z")) {
     -+			null_term = 1;
     -+		} else if (!strcmp(arg, "--")) {
     -+			for (i = i + 1; i < argc; i++)
     -+				strvec_push(&vars, argv[i]);
     -+			break;
     -+		} else if (arg[0] == '-') {
     -+			usage(var_usage);
     -+		} else {
     -+			strvec_push(&vars, arg);
     -+		}
     -+	}
     -+
      +	if (list) {
     -+		if (vars.nr > 0) {
     -+			strvec_clear(&vars);
     -+			usage(var_usage);
     -+		}
     ++		if (argc)
     ++			usage_with_options(var_usage, options);
      +		repo_config(the_repository, show_config, &null_term);
      +		list_vars(null_term);
       		return 0;
       	}
     --	repo_config(the_repository, git_default_config, NULL);
     ++
     ++	if (!argc)
     ++		usage_with_options(var_usage, options);
     ++
     ++	for (i = 0; i < argc; i++) {
     ++		if (!get_git_var(argv[i]))
     ++			usage_with_options(var_usage, options);
     ++	}
     ++
     + 	repo_config(the_repository, git_default_config, NULL);
       
      -	git_var = get_git_var(argv[1]);
      -	if (!git_var)
     -+	if (!vars.nr)
     - 		usage(var_usage);
     - 
     --	val = git_var->read(IDENT_STRICT);
     --	if (!val)
     --		return 1;
     -+	repo_config(the_repository, git_default_config, NULL);
     -+
     -+	for (size_t j = 0; j < vars.nr; j++) {
     -+		const struct git_var *git_var = get_git_var(vars.v[j]);
     +-		usage(var_usage);
     ++	for (i = 0; i < argc; i++) {
     ++		const struct git_var *git_var = get_git_var(argv[i]);
      +		char *val;
      +
     -+		if (!git_var) {
     -+			strvec_clear(&vars);
     -+			usage(var_usage);
     -+		}
     -+
      +		val = git_var->read(IDENT_STRICT);
     -+		if (!val) {
     -+			strvec_clear(&vars);
     ++		if (!val)
      +			return 1;
     -+		}
     + 
     +-	val = git_var->read(IDENT_STRICT);
     +-	if (!val)
     +-		return 1;
     ++		if (git_var->multivalued && null_term && *val) {
     ++			struct string_list values = STRING_LIST_INIT_DUP;
       
      -	printf("%s\n", val);
      -	free(val);
     -+		printf("%s%c", val, null_term ? '\0' : '\n');
     ++			string_list_split(&values, val, "\n", -1);
     ++			for (size_t j = 0; j < values.nr; j++) {
     ++				const char *s = values.items[j].string;
     ++
     ++				printf("%s%c", s, '\0');
     ++			}
     ++			string_list_clear(&values, 0);
     ++		} else {
     ++			printf("%s%c", val, null_term ? '\0' : '\n');
     ++		}
      +		free(val);
      +	}
       
     -+	strvec_clear(&vars);
       	return 0;
       }
      
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +
      +test_expect_success 'get multiple variables with -z' '
      +	test_tick &&
     -+	printf "%s\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
     ++	printf "%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
      +	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'get multi-valued variable with -z' '
     ++	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     ++	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual &&
     ++	printf "%s\0" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expected &&
     ++	test_cmp expected actual
     ++'
     ++
      +test_expect_success 'git var -l -z' '
      +	git var -l -z >actual &&
     -+	tr "\0" "\n" <actual | grep "^GIT_AUTHOR_NAME=" >filtered &&
     -+	echo "GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME" >expect &&
     -+	test_cmp expect filtered
     ++	tr "\0" "\n" <actual >actual.lines &&
     ++	echo "$GIT_AUTHOR_NAME" >expect &&
     ++	sed -n "/^GIT_AUTHOR_NAME$/{n;p;}" actual.lines >actual.author &&
     ++	test_cmp expect actual.author &&
     ++	echo false >expect &&
     ++	sed -n "/^core\.bare$/{n;p;}" actual.lines >actual.bare &&
     ++	test_cmp expect actual.bare
      +'
      +
     -+test_expect_success 'get GIT_DEFAULT_KEY with user.signingkey configured' '
     ++test_expect_success 'get GIT_SIGNING_KEY with user.signingkey configured' '
      +	test_config user.signingkey "TEST_KEY_ID" &&
      +	echo "TEST_KEY_ID" >expect &&
     -+	git var GIT_DEFAULT_KEY >actual &&
     -+	test_cmp expect actual &&
     -+	git var GIT_SIGNING_KEY >actual.alias &&
     -+	test_cmp expect actual.alias
     ++	git var GIT_SIGNING_KEY >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'get GIT_DEFAULT_KEY fails when unset and signing disabled' '
     ++test_expect_success 'get GIT_SIGNING_KEY fails when unset' '
      +	test_config user.signingkey "" &&
     -+	test_config commit.gpgsign false &&
     -+	test_must_fail git var GIT_DEFAULT_KEY
     ++	test_must_fail git var GIT_SIGNING_KEY
      +'
      +
      +test_expect_success 'git var -l lists new variables' '
      +	git var -l >actual &&
     -+	grep "^GIT_AUTHOR_NAME=" actual &&
     -+	grep "^GIT_AUTHOR_EMAIL=" actual &&
     -+	grep "^GIT_AUTHOR_DATE=" actual &&
     -+	grep "^GIT_COMMITTER_NAME=" actual &&
     -+	grep "^GIT_COMMITTER_EMAIL=" actual &&
     -+	grep "^GIT_COMMITTER_DATE=" actual
     ++	test_grep "^GIT_AUTHOR_NAME=" actual &&
     ++	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
     ++	test_grep "^GIT_AUTHOR_DATE=" actual &&
     ++	test_grep "^GIT_COMMITTER_NAME=" actual &&
     ++	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
     ++	test_grep "^GIT_COMMITTER_DATE=" actual
     ++'
     ++
     ++test_expect_success 'git var -l lists GIT_SIGNING_KEY when configured' '
     ++	test_config user.signingkey "TEST_KEY_ID" &&
     ++	git var -l >actual &&
     ++	test_grep "^GIT_SIGNING_KEY=TEST_KEY_ID" actual
     ++'
     ++
     ++test_expect_success 'options must precede variable arguments' '
     ++	test_must_fail git var GIT_AUTHOR_NAME -z
      +'
      +
       test_done


 Documentation/git-var.adoc |  55 ++++++--
 builtin/var.c              | 255 +++++++++++++++++++++++++++++++------
 t/t0007-git-var.sh         |  95 ++++++++++++++
 3 files changed, 355 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..999525ce71 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,7 +9,8 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [synopsis]
-git var (-l | <variable>)
+git var [-z] -l
+git var [-z] <variable>...
 
 DESCRIPTION
 -----------
@@ -24,19 +25,55 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline.
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
@@ -85,9 +122,9 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines, and are listed in order from highest to
-lowest priority.  Callers should be prepared for any such path value to contain
-multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given),
+and are listed in order from highest to lowest priority.  Callers should
+be prepared for any such path value to contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..6fc037543a 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,25 +12,130 @@
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
+
+static const char * const var_usage[] = {
+	N_("git var [-z] -l"),
+	N_("git var [-z] <variable>..."),
+	NULL
+};
 
-static const char var_usage[] = "git var (-l | <variable>)";
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
+	char *signing_key = NULL;
+
+	/*
+	 * An empty string in user.signingkey allows overriding and
+	 * clearing a key defined in an outer (e.g. global) config.
+	 */
+	if (!repo_config_get_string(the_repository,
+				    "user.signingkey", &signing_key)) {
+		if (!signing_key || !*signing_key) {
+			free(signing_key);
+			return NULL;
+		}
+		return signing_key;
+	}
+
+	signing_key = get_signing_key_id();
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
@@ -108,7 +213,7 @@ static char *git_config_val_global(int ident_flag UNUSED)
 	free(xdg);
 	free(user);
 	strbuf_trim_trailing_newline(&buf);
-	if (buf.len == 0) {
+	if (!buf.len) {
 		strbuf_release(&buf);
 		return NULL;
 	}
@@ -125,10 +230,34 @@ static struct git_var git_vars[] = {
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
@@ -145,6 +274,10 @@ static struct git_var git_vars[] = {
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
@@ -172,34 +305,40 @@ static struct git_var git_vars[] = {
 	},
 };
 
-static void list_vars(void)
+static void list_vars(int null_term)
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
+	char delim = null_term ? '\n' : '=';
+	char eol = null_term ? '\0' : '\n';
+
+	for (ptr = git_vars; ptr->read; ptr++) {
+		char *val = ptr->read(0);
+
+		if (!val)
+			continue;
+
+		if (ptr->multivalued && *val) {
+			struct string_list list = STRING_LIST_INIT_DUP;
+
+			string_list_split(&list, val, "\n", -1);
+			for (size_t i = 0; i < list.nr; i++)
+				printf("%s%c%s%c", ptr->name, delim,
+				       list.items[i].string, eol);
+			string_list_clear(&list, 0);
+		} else {
+			printf("%s%c%s%c", ptr->name, delim, val, eol);
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
@@ -207,42 +346,76 @@ static const struct git_var *get_git_var(const char *var)
 static int show_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	int null_term = cb ? *(int *)cb : 0;
+
 	if (value)
-		printf("%s=%s\n", var, value);
+		printf("%s%c%s%c", var, null_term ? '\n' : '=',
+		       value, null_term ? '\0' : '\n');
 	else
-		printf("%s\n", var);
+		printf("%s%c", var, null_term ? '\0' : '\n');
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
+	int null_term = 0;
+	int i;
+	struct option options[] = {
+		OPT_BOOL('l', NULL, &list,
+			 N_("list all variables")),
+		OPT_BOOL('z', NULL, &null_term,
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
+		repo_config(the_repository, show_config, &null_term);
+		list_vars(null_term);
 		return 0;
 	}
+
+	if (!argc)
+		usage_with_options(var_usage, options);
+
+	for (i = 0; i < argc; i++) {
+		if (!get_git_var(argv[i]))
+			usage_with_options(var_usage, options);
+	}
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
-	if (!git_var)
-		usage(var_usage);
+	for (i = 0; i < argc; i++) {
+		const struct git_var *git_var = get_git_var(argv[i]);
+		char *val;
+
+		val = git_var->read(IDENT_STRICT);
+		if (!val)
+			return 1;
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+		if (git_var->multivalued && null_term && *val) {
+			struct string_list values = STRING_LIST_INIT_DUP;
 
-	printf("%s\n", val);
-	free(val);
+			string_list_split(&values, val, "\n", -1);
+			for (size_t j = 0; j < values.nr; j++) {
+				const char *s = values.items[j].string;
+
+				printf("%s%c", s, '\0');
+			}
+			string_list_clear(&values, 0);
+		} else {
+			printf("%s%c", val, null_term ? '\0' : '\n');
+		}
+		free(val);
+	}
 
 	return 0;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..27cc595291 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,99 @@ test_expect_success '`git var -l` works even without HOME' '
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
 test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
