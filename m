Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0463A7820
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220754; cv=none; b=eaIV136fMuXMSTqiiNvdbxC92PuAuN0tGNm252ZCnwTJJnl+z2GGIAB8cggJp52spqI10ymk9dfa/LMIUVyxgERufuz3BfPWkCXI9gfx2MmaW+9dUsA/GF07SgrKAsW1IyX63eZOWkDRl3frhBebhjQSyNEgDhKBX380/1/D7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220754; c=relaxed/simple;
	bh=zPfO79k+4NXihOQMRvOphdE9jvnKdacqZcShvxjCunA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ui9BcNDyQaUbBMUbTO58M11Tlo2g5dZk4Y0qacQ3TeqOoa90IW8670gn4G5kzOh5bPzNfmwBTzdXQ/OIHXGegKpnZRbn2U8C3RJ4+iewb/ldyeGtDEmVvSmn5OefwWXdkyELmMOzPsbodLxbHcKdfwaOlQbCsYy5RswvCcNZZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMk7LK5z; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMk7LK5z"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b21f09ea42so3249883b6e.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788220749; x=1788825549; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eONUHyxEvruxuorRnRWlOi1qA5u2pDFlEuRkRuyZOqc=;
        b=FMk7LK5zQl0gRJD62Cg1YE/pmIXotwSIkJD7pa+ulLOAU8K4GkDsZLohEKRWBjd/KW
         WxqcKcVhf1QrzpS/qKaeJtWa0z9Cn7AbaWoJxqp8XaXva1+mM3J6E307iA6mHKb/IPHf
         NOvM5FNzfG1UldSge0NDVJHWWtlFeLeEbzxe400PFXfNrQxjOi17nRFv384w/8gGhnwf
         Bgr5KRTM5REOnvn5xqvziyyAUDVurM1Qqs/G3Joo2UyIvizjE98YEXfI4m5sRNqA7QBM
         wetJ/pxOX4cViaVzbFb3/RPTXCXArio2gWdjPHfd+YtkT0eWpx6FKnFR4unslyNn7f/W
         I5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788220749; x=1788825549;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eONUHyxEvruxuorRnRWlOi1qA5u2pDFlEuRkRuyZOqc=;
        b=RdosYn3FhZbYeWB1m3h0XIH2PrlBfW34SjDgck7Zlf8LP2YoZKcrzXy6iRVS0/U4bT
         snTg35zVOpcbqKjzIh4WJ3RN8bqjAT7e3zTPGd07SCReqP19L3EuOquFqBQMyAsGOmos
         M/fL4ivtC1ZjKCgcWnYy/u6c4i87CqTNL5Vk+QnEendstn0DtY0NgXhk7UmUwxFEBYan
         iw/VHEOSRGQHjZwuA6NPOxDnklUKCkbnN+5QLTUGHyLod+/N5arE7iRA5w/Nw3usmLIB
         9eZOvwHM+4nKz8xi6MgiNAwdhFxHuI4w+dhiKEfiqtXhi9yu0OJqV+hmceciBAMwiMfD
         XSoA==
X-Gm-Message-State: AFuF++l08/Zupjn9qaRLgEtbUxPvG9SHzP8rSgtQUkfSEFEHd8DkQ7/j
	KlTKCS+awUTGYQu/S26ITpr8VAC2VTu8hW4ZPY/Kub1hu3Y4fZGxbVZPzk82HA==
X-Gm-Gg: AR+sD10YGLQ1WuBLQqddcYkW6Y4qBN7Xk+kosvE5tnB9sBoQXLPO58gq9x0Paz8I18b
	UqXfdGQoxBoVnG/viyKirhwmYZ8zlz2TYjesN4P7g2PYX2jEjBRx6HvClb5InBPJ2KfRPXxSfgT
	6XaXld+dbqBLil18EDbkEBG17B/5q9+Sjsb5lFq/Nkwwv+fEqlIoKi8qLwcKNQ6taLGMw0/Z6s9
	tvXYKvvIxajoTptFbETXbEyOBC6O7la9bR2Aw4nTt9tnaFL1HDsT7D8IGL61u5td+G0Ai1YSLAt
	ghow0NQAwHxw49fh53K8ElhrT1K/u/lFs5MifPyKmJOTUGE8YxH+z9Y9DGt13n6ZXif5M9Rgxtf
	5WN2lRRLZWnmO+QWWeDT5WF67iJFVfxrgxzKWRv/rRBOyHAuewOKb5zRQg7J2FS4WhFlb19DzpK
	tl9sjVymSrk3nIxscPLAPefceb4T3MkNk/7ybx47OrH9Gd/PZxZ03tcByTVEJ3CvU=
X-Received: by 2002:a05:6808:c1ad:b0:495:f8a6:81f8 with SMTP id 5614622812f47-4b3981e5467mr32026966b6e.13.1788220749040;
        Mon, 31 Aug 2026 16:59:09 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.39])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a1625641sm9745756b6e.4.2026.08.31.16.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:59:07 -0700 (PDT)
Message-Id: <pull.2388.v2.git.git.1788220746663.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 23:59:06 +0000
Subject: [PATCH v2] builtin/ident: add new 'ident' command
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
    Andrew Pleeter <andrewpleeter@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>

From: Andrew Pleeter <andrewpleeter@gmail.com>

Add a builtin 'ident' command to inspect and display the resolved author
and committer identity along with optional commit signing configuration
used when creating Git commits.

While existing plumbing commands like 'git var' and 'git config' expose
individual pieces of identity and configuration, discovering what identity
and signing key will actually be attached to a new commit requires multiple
independent queries and manual correlation. 'git config' only reads raw
values without performing environment overrides or GECOS detection, while
'git var' returns full ident strings with timestamps without exposing
commit signing status.

'git ident' provides a unified command with additive, composable options:
  - Identity scope selectors (-a / --author, -c / --committer) choose
    which identities to format (defaulting to both when neither is specified).
  - Component selectors (-n / --name, -e / --email) choose which parts
    to format (defaulting to full 'Name <email>' when neither or both are
    specified).
  - -v / --verbose prepends 'Author: ' or 'Committer: ' role labels.
  - -s / --signing-key resolves and outputs the commit signing key.
  - --porcelain produces machine-readable key-value pairs.
  - -z / --null terminates output records with NUL bytes.

Include documentation in Documentation/git-ident.adoc and regression
tests in t/t0015-ident.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    builtin/whoami: add new 'whoami' command
    
    
    Title:
    ======
    
    builtin/whoami: add new 'whoami' command
    
    ------------------------------------------------------------------------
    
    
    Description:
    ============
    
    SUMMARY
    
    Adds a new builtin git whoami command that inspects and displays the
    user's active author and committer identity along with their commit
    signing configuration (GPG/SSH key ID and commit.gpgsign status).
    
    MOTIVATION
    
    Users often work across multiple environments, profiles, or repositories
    with different global/local configs and signing keys. Currently,
    verifying what identity and signing key will be attached to a new commit
    requires checking several individual git config and git var settings.
    git whoami provides a simple, direct porcelain command to verify this in
    one step.
    
    CHANGES
    
     * Core implementation: Added builtin/whoami.c using Git's ident.h and
       gpg-interface.h APIs.
     * CLI flags supported:
       * git whoami (default overview)
       * -a, --author (author identity: Name <email>)
       * -c, --committer (committer identity: Name <email>)
       * -n, --name (name only)
       * -e, --email (email only)
       * -s, --signing-key (signing key ID)
       * -v, --verbose (detailed identity and signing breakdown)
     * Documentation: Added manpage in Documentation/git-whoami.adoc.
     * Build integration: Added to Makefile, meson.build, command-list.txt,
       and builtin.h.
     * Test suite: Added comprehensive automated tests in t/t0015-whoami.sh.
    
    EXAMPLE OUTPUT
    
    $ git whoami
    Author:    Jane Doe <jane@example.com>
    Committer: Jane Doe <jane@example.com>
    Signing:   /Users/jane/.ssh/id_ed25519_git (format: ssh, commit.gpgsign: true)
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v2
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v1:

 1:  263aebca08 ! 1:  f322e7fedd builtin/whoami: add new 'whoami' command
     @@
       ## Metadata ##
     -Author: anpl1623 <andrewpleeter@gmail.com>
     +Author: Andrew Pleeter <andrewpleeter@gmail.com>
      
       ## Commit message ##
     -    builtin/whoami: add new 'whoami' command
     +    builtin/ident: add new 'ident' command
      
     -    Add a builtin 'whoami' command to inspect and display the resolved
     -    author and committer identity along with the commit signing
     -    configuration (GPG/SSH key ID and commit.gpgsign status) used when
     -    creating Git commits.
     +    Add a builtin 'ident' command to inspect and display the resolved author
     +    and committer identity along with optional commit signing configuration
     +    used when creating Git commits.
      
     -    Support optional flags (--author, --committer, --name, --email,
     -    --signing-key, and --verbose) for targeted querying and scripting.
     +    While existing plumbing commands like 'git var' and 'git config' expose
     +    individual pieces of identity and configuration, discovering what identity
     +    and signing key will actually be attached to a new commit requires multiple
     +    independent queries and manual correlation. 'git config' only reads raw
     +    values without performing environment overrides or GECOS detection, while
     +    'git var' returns full ident strings with timestamps without exposing
     +    commit signing status.
      
     -    Include documentation in Documentation/git-whoami.adoc and regression
     -    tests in t/t0015-whoami.sh.
     +    'git ident' provides a unified command with additive, composable options:
     +      - Identity scope selectors (-a / --author, -c / --committer) choose
     +        which identities to format (defaulting to both when neither is specified).
     +      - Component selectors (-n / --name, -e / --email) choose which parts
     +        to format (defaulting to full 'Name <email>' when neither or both are
     +        specified).
     +      - -v / --verbose prepends 'Author: ' or 'Committer: ' role labels.
     +      - -s / --signing-key resolves and outputs the commit signing key.
     +      - --porcelain produces machine-readable key-value pairs.
     +      - -z / --null terminates output records with NUL bytes.
      
     -    Signed-off-by: anpl1623 <andrewpleeter@gmail.com>
     +    Include documentation in Documentation/git-ident.adoc and regression
     +    tests in t/t0015-ident.sh.
      
     - ## Documentation/git-whoami.adoc (new) ##
     +    Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
     +
     + ## Documentation/git-ident.adoc (new) ##
      @@
     -+git-whoami(1)
     -+=============
     ++git-ident(1)
     ++============
      +
      +NAME
      +----
     -+git-whoami - Show current user identity and commit signing information
     ++git-ident - Show current user identity and commit signing information
      +
      +
      +SYNOPSIS
      +--------
      +[synopsis]
     -+git whoami [options]
     ++git ident [<options>]
      +
      +DESCRIPTION
      +-----------
      +Displays the author and committer identity (name and email address) and
     -+commit signing configuration that will be used when signing and recording
     ++optionally commit signing configuration that will be used when recording
      +Git commits.
      +
     ++The identity selectors (`-a` / `--author`, `-c` / `--committer`) and component
     ++selectors (`-n` / `--name`, `-e` / `--email`) are additive and composable:
     ++
     ++* If neither `--author` nor `--committer` is specified, both identities are shown.
     ++* If neither `--name` nor `--email` is specified (or if both are specified),
     ++  the full identity format (`Name <email>`) is shown.
     ++* If `-v` / `--verbose` is specified, entries are labeled with their role
     ++  (`Author: ` / `Committer: `).
     ++
      +OPTIONS
      +-------
      +`-a`::
     @@ Documentation/git-whoami.adoc (new)
      +
      +`-e`::
      +`--email`::
     -+	Show email only.
     ++	Show email address only (formatted as `<email>`).
      +
      +`-s`::
      +`--signing-key`::
     -+	Show commit signing key only.
     ++	Show the signing key that Git would resolve for signing commits.
     ++	Resolution proceeds in the following order:
     ++	* The explicitly configured `user.signingKey`, if set.
     ++	* If `gpg.format` is set to `ssh` and `gpg.ssh.defaultKeyCommand`
     ++	  is configured, executes the command to obtain the public key.
     ++	* If `gpg.format` is `openpgp` or `x509` and `commit.gpgsign` is
     ++	  enabled, falls back to the committer identity.
     ++	* If signing is disabled (`commit.gpgsign=false`) and no explicit key
     ++	  is configured, exits with status 1.
     ++
     ++`--porcelain`::
     ++	Give the output in an easy-to-parse format for scripts.
     ++	Outputs key-value pairs (`user.author.name`, `user.author.email`,
     ++	`user.committer.name`, `user.committer.email`, `user.signingkey`,
     ++	`gpg.format`, `commit.gpgsign`).
     ++
     ++`-z`::
     ++`--null`::
     ++	Terminate output lines or entries with NUL instead of a newline.
      +
      +`-v`::
      +`--verbose`::
     -+	Show detailed identity and signing status.
     ++	Prepend role labels (`Author: `, `Committer: `) to identity entries.
     ++
     ++EXAMPLES
     ++--------
     ++
     ++* Show full author and committer identities:
     +++
     ++------------
     ++$ git ident
     ++Author Name <author@example.com>
     ++Committer Name <committer@example.com>
     ++------------
     ++
     ++* Show author identity only:
     +++
     ++------------
     ++$ git ident -a -e -n
     ++Author Name <author@example.com>
     ++------------
     ++
     ++* Show labeled author name:
     +++
     ++------------
     ++$ git ident -a -n -v
     ++Author: Author Name
     ++------------
     ++
     ++* Show author and committer email addresses:
     +++
     ++------------
     ++$ git ident -a -c -e
     ++<author@example.com>
     ++<committer@example.com>
     ++------------
     ++
     ++* Show labeled author and committer email addresses:
     +++
     ++------------
     ++$ git ident -a -c -e -v
     ++Author: <author@example.com>
     ++Committer: <committer@example.com>
     ++------------
      +
      +GIT
      +---
     @@ Documentation/git-whoami.adoc (new)
      
       ## Documentation/meson.build ##
      @@ Documentation/meson.build: manpages = {
     -   'git-verify-tag.adoc' : 1,
     -   'git-version.adoc' : 1,
     -   'git-web--browse.adoc' : 1,
     -+  'git-whoami.adoc' : 1,
     -   'git-worktree.adoc' : 1,
     -   'git-write-tree.adoc' : 1,
     -   'git.adoc' : 1,
     +   'git-help.adoc' : 1,
     +   'git-history.adoc' : 1,
     +   'git-hook.adoc' : 1,
     ++  'git-ident.adoc' : 1,
     +   'git-http-backend.adoc' : 1,
     +   'git-http-fetch.adoc' : 1,
     +   'git-http-push.adoc' : 1,
      
       ## Makefile ##
     -@@ Makefile: BUILTIN_OBJS += builtin/var.o
     - BUILTIN_OBJS += builtin/verify-commit.o
     - BUILTIN_OBJS += builtin/verify-pack.o
     - BUILTIN_OBJS += builtin/verify-tag.o
     -+BUILTIN_OBJS += builtin/whoami.o
     - BUILTIN_OBJS += builtin/worktree.o
     - BUILTIN_OBJS += builtin/write-tree.o
     - 
     +@@ Makefile: BUILTIN_OBJS += builtin/hash-object.o
     + BUILTIN_OBJS += builtin/help.o
     + BUILTIN_OBJS += builtin/history.o
     + BUILTIN_OBJS += builtin/hook.o
     ++BUILTIN_OBJS += builtin/ident.o
     + BUILTIN_OBJS += builtin/index-pack.o
     + BUILTIN_OBJS += builtin/init-db.o
     + BUILTIN_OBJS += builtin/interpret-trailers.o
      
       ## builtin.h ##
     +@@ builtin.h: int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repo
     + int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
     ++int cmd_ident(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
      @@ builtin.h: int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repo
       int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
       int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
       int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo);
     -+int cmd_whoami(int argc, const char **argv, const char *prefix, struct repository *repo);
     - 
     +-
       #endif
      
     - ## builtin/whoami.c (new) ##
     + ## builtin/ident.c (new) ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
      +
     @@ builtin/whoami.c (new)
      +#include "parse-options.h"
      +#include "strbuf.h"
      +
     -+static const char * const whoami_usage[] = {
     -+	N_("git whoami [options]"),
     ++static const char * const ident_usage[] = {
     ++	N_("git ident [<options>]"),
      +	NULL
      +};
      +
     -+int cmd_whoami(int argc,
     -+	       const char **argv,
     -+	       const char *prefix,
     -+	       struct repository *repo UNUSED)
     ++enum ident_who {
     ++	IDENT_AUTHOR = 1 << 0,
     ++	IDENT_COMMITTER = 1 << 1,
     ++};
     ++
     ++enum ident_part {
     ++	IDENT_NAME = 1 << 0,
     ++	IDENT_EMAIL = 1 << 1,
     ++};
     ++
     ++struct ident_config {
     ++	int gpgsign;
     ++	char *signing_key;
     ++	char *gpg_format;
     ++	char *ssh_default_key_cmd;
     ++};
     ++
     ++static int ident_config_cb(const char *var, const char *value,
     ++			   const struct config_context *ctx, void *data)
     ++{
     ++	struct ident_config *cfg = data;
     ++
     ++	if (!strcmp(var, "commit.gpgsign")) {
     ++		cfg->gpgsign = git_config_bool(var, value);
     ++		return 0;
     ++	}
     ++	if (!strcmp(var, "user.signingkey"))
     ++		return git_config_string(&cfg->signing_key, var, value);
     ++	if (!strcmp(var, "gpg.format"))
     ++		return git_config_string(&cfg->gpg_format, var, value);
     ++	if (!strcmp(var, "gpg.ssh.defaultkeycommand"))
     ++		return git_config_string(&cfg->ssh_default_key_cmd, var, value);
     ++
     ++	return git_default_config(var, value, ctx, data);
     ++}
     ++
     ++static void print_ident_entry(const char *label,
     ++			      const struct strbuf *name,
     ++			      const struct strbuf *email,
     ++			      int parts,
     ++			      int verbose,
     ++			      char eol)
     ++{
     ++	struct strbuf out = STRBUF_INIT;
     ++
     ++	if (verbose && label)
     ++		strbuf_addf(&out, "%s: ", label);
     ++
     ++	if ((parts & IDENT_NAME) && (parts & IDENT_EMAIL))
     ++		strbuf_addf(&out, "%s <%s>", name->buf, email->buf);
     ++	else if (parts & IDENT_NAME)
     ++		strbuf_addbuf(&out, name);
     ++	else if (parts & IDENT_EMAIL)
     ++		strbuf_addf(&out, "<%s>", email->buf);
     ++
     ++	printf("%s%c", out.buf, eol);
     ++	strbuf_release(&out);
     ++}
     ++
     ++int cmd_ident(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo)
      +{
      +	int show_author = 0;
      +	int show_committer = 0;
      +	int show_name = 0;
      +	int show_email = 0;
      +	int show_signing_key = 0;
     ++	int porcelain = 0;
     ++	int nul_term = 0;
      +	int verbose = 0;
      +	int ret = 0;
     ++	char eol;
     ++	int selected_who = 0;
     ++	int selected_parts = 0;
      +
     -+	struct option whoami_options[] = {
     ++	struct option ident_options[] = {
      +		OPT_BOOL('a', "author", &show_author, N_("show author identity")),
      +		OPT_BOOL('c', "committer", &show_committer, N_("show committer identity")),
      +		OPT_BOOL('n', "name", &show_name, N_("show name only")),
      +		OPT_BOOL('e', "email", &show_email, N_("show email only")),
      +		OPT_BOOL('s', "signing-key", &show_signing_key, N_("show commit signing key")),
     -+		OPT__VERBOSE(&verbose, N_("show detailed identity and signing status")),
     ++		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
     ++		OPT_BOOL('z', "null", &nul_term, N_("terminate entries with NUL")),
     ++		OPT__VERBOSE(&verbose, N_("show detailed identity")),
      +		OPT_END()
      +	};
      +
     ++	struct ident_config cfg = { 0 };
      +	struct strbuf author_info = STRBUF_INIT;
      +	struct strbuf committer_info = STRBUF_INIT;
      +	struct ident_split author_split, committer_split;
     @@ builtin/whoami.c (new)
      +	struct strbuf author_email = STRBUF_INIT;
      +	struct strbuf committer_name = STRBUF_INIT;
      +	struct strbuf committer_email = STRBUF_INIT;
     -+
     -+	char *signing_key = NULL;
     -+	char *gpg_format = NULL;
     -+	char *ssh_default_key_cmd = NULL;
      +	char *resolved_key = NULL;
     -+	int gpgsign = 0;
      +	int is_ssh = 0;
      +
     -+	argc = parse_options(argc, argv, prefix, whoami_options,
     -+			     whoami_usage, 0);
     ++	argc = parse_options(argc, argv, prefix, ident_options,
     ++			     ident_usage, 0);
      +
      +	if (argc > 0)
     -+		usage_with_options(whoami_usage, whoami_options);
     -+
     -+	die_for_incompatible_opt2(show_author, "--author", show_committer, "--committer");
     -+	die_for_incompatible_opt2(show_name, "--name", show_email, "--email");
     -+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_name, "--name");
     -+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_email, "--email");
     -+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_author, "--author");
     -+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_committer, "--committer");
     -+	die_for_incompatible_opt2(show_signing_key, "--signing-key", verbose, "--verbose");
     -+	die_for_incompatible_opt2(verbose, "--verbose", show_name, "--name");
     -+	die_for_incompatible_opt2(verbose, "--verbose", show_email, "--email");
     -+	die_for_incompatible_opt2(verbose, "--verbose", show_author, "--author");
     -+	die_for_incompatible_opt2(verbose, "--verbose", show_committer, "--committer");
     -+
     -+	repo_config(the_repository, git_default_config, NULL);
     ++		usage_with_options(ident_usage, ident_options);
     ++
     ++	die_for_incompatible_opt2(porcelain, "--porcelain", verbose, "--verbose");
     ++	die_for_incompatible_opt2(porcelain, "--porcelain", show_name, "--name");
     ++	die_for_incompatible_opt2(porcelain, "--porcelain", show_email, "--email");
     ++
     ++	eol = nul_term ? '\0' : '\n';
     ++
     ++	repo_config(repo, ident_config_cb, &cfg);
      +
      +	strbuf_addstr(&author_info, git_author_info(IDENT_NO_DATE));
      +	strbuf_addstr(&committer_info, git_committer_info(IDENT_NO_DATE));
     @@ builtin/whoami.c (new)
      +				   committer_split.mail_end - committer_split.mail_begin);
      +	}
      +
     -+	repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign);
     -+	repo_config_get_string(the_repository, "user.signingkey", &signing_key);
     -+	repo_config_get_string(the_repository, "gpg.format", &gpg_format);
     -+	repo_config_get_string(the_repository, "gpg.ssh.defaultkeycommand", &ssh_default_key_cmd);
     ++	is_ssh = cfg.gpg_format && !strcmp(cfg.gpg_format, "ssh");
      +
     -+	is_ssh = gpg_format && !strcmp(gpg_format, "ssh");
     -+
     -+	if (signing_key && *signing_key) {
     -+		resolved_key = xstrdup(signing_key);
     ++	if (cfg.signing_key && *cfg.signing_key) {
     ++		resolved_key = xstrdup(cfg.signing_key);
      +	} else if (is_ssh) {
     -+		if (ssh_default_key_cmd && *ssh_default_key_cmd)
     ++		if (cfg.ssh_default_key_cmd && *cfg.ssh_default_key_cmd)
      +			resolved_key = get_signing_key_id();
     -+	} else if (gpgsign) {
     ++	} else if (cfg.gpgsign) {
      +		resolved_key = get_signing_key_id();
      +	}
      +
     -+	if (show_signing_key) {
     ++	if (show_signing_key && !show_author && !show_committer && !show_name && !show_email && !porcelain) {
      +		if (resolved_key && *resolved_key) {
     -+			puts(resolved_key);
     ++			if (verbose)
     ++				printf(_("Signing Key: %s\n"), resolved_key);
     ++			else
     ++				printf("%s%c", resolved_key, eol);
      +			ret = 0;
      +		} else {
      +			ret = 1;
     @@ builtin/whoami.c (new)
      +		goto cleanup;
      +	}
      +
     -+	if (show_name) {
     -+		if (show_author)
     -+			puts(author_name.buf);
     -+		else
     -+			puts(committer_name.buf);
     -+		goto cleanup;
     -+	}
     -+
     -+	if (show_email) {
     -+		if (show_author)
     -+			puts(author_email.buf);
     -+		else
     -+			puts(committer_email.buf);
     ++	if (show_author)
     ++		selected_who |= IDENT_AUTHOR;
     ++	if (show_committer)
     ++		selected_who |= IDENT_COMMITTER;
     ++	if (!selected_who)
     ++		selected_who = IDENT_AUTHOR | IDENT_COMMITTER;
     ++
     ++	if (show_name)
     ++		selected_parts |= IDENT_NAME;
     ++	if (show_email)
     ++		selected_parts |= IDENT_EMAIL;
     ++	if (!selected_parts)
     ++		selected_parts = IDENT_NAME | IDENT_EMAIL;
     ++
     ++	if (porcelain) {
     ++		if (selected_who & IDENT_AUTHOR) {
     ++			printf("user.author.name=%s%c", author_name.buf, eol);
     ++			printf("user.author.email=%s%c", author_email.buf, eol);
     ++		}
     ++		if (selected_who & IDENT_COMMITTER) {
     ++			printf("user.committer.name=%s%c", committer_name.buf, eol);
     ++			printf("user.committer.email=%s%c", committer_email.buf, eol);
     ++		}
     ++		if ((selected_who & (IDENT_AUTHOR | IDENT_COMMITTER)) == (IDENT_AUTHOR | IDENT_COMMITTER)) {
     ++			printf("user.signingkey=%s%c",
     ++			       (cfg.signing_key && *cfg.signing_key) ? cfg.signing_key :
     ++			       (resolved_key && *resolved_key) ? resolved_key : "none",
     ++			       eol);
     ++			printf("gpg.format=%s%c",
     ++			       cfg.gpg_format ? cfg.gpg_format : "openpgp", eol);
     ++			printf("commit.gpgsign=%s%c",
     ++			       cfg.gpgsign ? "true" : "false", eol);
     ++		}
      +		goto cleanup;
      +	}
      +
     -+	if (show_author) {
     -+		puts(author_info.buf);
     -+		goto cleanup;
     -+	}
     ++	if (selected_who & IDENT_AUTHOR)
     ++		print_ident_entry("Author", &author_name, &author_email,
     ++				  selected_parts, verbose, eol);
      +
     -+	if (show_committer) {
     -+		puts(committer_info.buf);
     -+		goto cleanup;
     -+	}
     ++	if (selected_who & IDENT_COMMITTER)
     ++		print_ident_entry("Committer", &committer_name, &committer_email,
     ++				  selected_parts, verbose, eol);
      +
     -+	if (verbose) {
     -+		printf(_("Author Name:      %s\n"), author_name.buf);
     -+		printf(_("Author Email:     %s\n"), author_email.buf);
     -+		printf(_("Committer Name:   %s\n"), committer_name.buf);
     -+		printf(_("Committer Email:  %s\n"), committer_email.buf);
     -+		if (signing_key && *signing_key)
     -+			printf(_("Signing Key:      %s\n"), signing_key);
     -+		else if (resolved_key && *resolved_key)
     -+			printf(_("Signing Key:      %s (default fallback)\n"), resolved_key);
     -+		else
     -+			printf(_("Signing Key:      %s\n"), _("none"));
     -+		printf(_("Signing Format:   %s\n"),
     -+		       gpg_format ? gpg_format : "openpgp");
     -+		printf(_("GPG Signing:      %s\n"),
     -+		       gpgsign ? _("enabled") : _("disabled"));
     -+	} else {
     -+		printf(_("Author:    %s\n"), author_info.buf);
     -+		printf(_("Committer: %s\n"), committer_info.buf);
     -+		if (gpgsign) {
     -+			if (signing_key && *signing_key) {
     -+				printf(_("Signing:   %s (format: %s, commit.gpgsign: true)\n"),
     -+				       signing_key,
     -+				       gpg_format ? gpg_format : "openpgp");
     -+			} else if (resolved_key && *resolved_key) {
     -+				printf(_("Signing:   default key (%s) (format: %s, commit.gpgsign: true)\n"),
     -+				       resolved_key,
     -+				       gpg_format ? gpg_format : "openpgp");
     -+			} else {
     -+				printf(_("Signing:   enabled (no signing key configured)\n"));
     -+			}
     ++	if (show_signing_key) {
     ++		if (resolved_key && *resolved_key) {
     ++			if (verbose)
     ++				printf(_("Signing Key: %s\n"), resolved_key);
     ++			else
     ++				printf("%s%c", resolved_key, eol);
      +		} else {
     -+			if (signing_key && *signing_key) {
     -+				printf(_("Signing:   disabled (key: %s, format: %s, commit.gpgsign: false)\n"),
     -+				       signing_key,
     -+				       gpg_format ? gpg_format : "openpgp");
     -+			} else {
     -+				printf(_("Signing:   disabled (commit.gpgsign: false)\n"));
     -+			}
     ++			ret = 1;
      +		}
      +	}
      +
      +cleanup:
     -+	free(signing_key);
     -+	free(gpg_format);
     -+	free(ssh_default_key_cmd);
     ++	free(cfg.signing_key);
     ++	free(cfg.gpg_format);
     ++	free(cfg.ssh_default_key_cmd);
      +	free(resolved_key);
      +	strbuf_release(&author_info);
      +	strbuf_release(&committer_info);
     @@ builtin/whoami.c (new)
      +}
      
       ## command-list.txt ##
     -@@ command-list.txt: git-verify-pack                         plumbinginterrogators
     - git-verify-tag                          ancillaryinterrogators
     - git-version                             ancillaryinterrogators
     - git-whatchanged                         ancillaryinterrogators          complete
     -+git-whoami                              ancillaryinterrogators
     - git-worktree                            mainporcelain
     - git-write-tree                          plumbingmanipulators
     - gitattributes                           userinterfaces
     +@@ command-list.txt: git-hash-object                         plumbingmanipulators
     + git-help                                ancillaryinterrogators          complete
     + git-history                             mainporcelain           history
     + git-hook                                purehelpers
     ++git-ident                               ancillaryinterrogators
     + git-http-backend                        synchingrepositories
     + git-http-fetch                          synchelpers
     + git-http-push                           synchelpers
      
       ## git.c ##
      @@ git.c: static struct cmd_struct commands[] = {
     - #ifndef WITH_BREAKING_CHANGES
     - 	{ "whatchanged", cmd_whatchanged, RUN_SETUP | DEPRECATED },
     - #endif
     -+	{ "whoami", cmd_whoami, RUN_SETUP_GENTLY },
     - 	{ "worktree", cmd_worktree, RUN_SETUP },
     - 	{ "write-tree", cmd_write_tree, RUN_SETUP },
     - };
     + 	{ "help", cmd_help },
     + 	{ "history", cmd_history, RUN_SETUP },
     + 	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
     ++	{ "ident", cmd_ident, RUN_SETUP_GENTLY },
     + 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
     + 	{ "init", cmd_init_db },
     + 	{ "init-db", cmd_init_db },
      
       ## meson.build ##
      @@ meson.build: builtin_sources = [
     -   'builtin/verify-commit.c',
     -   'builtin/verify-pack.c',
     -   'builtin/verify-tag.c',
     -+  'builtin/whoami.c',
     -   'builtin/worktree.c',
     -   'builtin/write-tree.c',
     - ]
     +   'builtin/help.c',
     +   'builtin/history.c',
     +   'builtin/hook.c',
     ++  'builtin/ident.c',
     +   'builtin/index-pack.c',
     +   'builtin/init-db.c',
     +   'builtin/interpret-trailers.c',
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
         't0012-help.sh',
         't0013-sha1dc.sh',
         't0014-alias.sh',
     -+  't0015-whoami.sh',
     ++  't0015-ident.sh',
         't0017-env-helper.sh',
         't0018-advice.sh',
         't0019-json-writer.sh',
      
     - ## t/t0015-whoami.sh (new) ##
     + ## t/t0015-ident.sh (new) ##
      @@
      +#!/bin/sh
      +
     -+test_description='basic sanity checks for git whoami'
     ++test_description='basic sanity checks for git ident'
      +
      +. ./test-lib.sh
      +. "$TEST_DIRECTORY/lib-gpg.sh"
      +
     -+test_expect_success 'default output format without signing' '
     ++test_expect_success 'default output format (author + committer)' '
     ++	cat >expect <<-EOF &&
     ++	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     ++	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     ++	EOF
     ++	git ident >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident -v / --verbose default' '
      +	cat >expect <<-EOF &&
     -+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     ++	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
      +	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     -+	Signing:   disabled (commit.gpgsign: false)
      +	EOF
     -+	git whoami >actual &&
     ++	git ident -v >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git whoami --author' '
     ++test_expect_success 'git ident --author / -a' '
      +	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
     -+	git whoami --author >actual &&
     -+	test_cmp expect actual
     ++	git ident --author >actual &&
     ++	test_cmp expect actual &&
     ++	git ident -a >actual_short &&
     ++	test_cmp expect actual_short
      +'
      +
     -+test_expect_success 'git whoami --committer' '
     ++test_expect_success 'git ident --committer / -c' '
      +	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect &&
     -+	git whoami --committer >actual &&
     ++	git ident --committer >actual &&
     ++	test_cmp expect actual &&
     ++	git ident -c >actual_short &&
     ++	test_cmp expect actual_short
     ++'
     ++
     ++test_expect_success 'git ident -a -c' '
     ++	cat >expect <<-EOF &&
     ++	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     ++	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     ++	EOF
     ++	git ident -a -c >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git whoami --author --name and --author --email' '
     ++test_expect_success 'git ident -a -n and -a -e' '
      +	echo "$GIT_AUTHOR_NAME" >expect_name &&
     -+	git whoami --author --name >actual_name &&
     ++	git ident -a -n >actual_name &&
      +	test_cmp expect_name actual_name &&
     -+	echo "$GIT_AUTHOR_EMAIL" >expect_email &&
     -+	git whoami --author --email >actual_email &&
     ++	echo "<$GIT_AUTHOR_EMAIL>" >expect_email &&
     ++	git ident -a -e >actual_email &&
      +	test_cmp expect_email actual_email
      +'
      +
     -+test_expect_success 'git whoami --committer --name and --committer --email' '
     ++test_expect_success 'git ident -c -n and -c -e' '
      +	echo "$GIT_COMMITTER_NAME" >expect_name &&
     -+	git whoami --committer --name >actual_name &&
     ++	git ident -c -n >actual_name &&
      +	test_cmp expect_name actual_name &&
     -+	echo "$GIT_COMMITTER_EMAIL" >expect_email &&
     -+	git whoami --committer --email >actual_email &&
     ++	echo "<$GIT_COMMITTER_EMAIL>" >expect_email &&
     ++	git ident -c -e >actual_email &&
      +	test_cmp expect_email actual_email
      +'
      +
     -+test_expect_success 'git whoami --signing-key when signing is disabled and unset' '
     -+	test_config commit.gpgsign false &&
     -+	test_unconfig user.signingkey &&
     -+	test_must_fail git whoami --signing-key
     ++test_expect_success 'git ident -a -e -n (additive full ident)' '
     ++	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
     ++	git ident -a -e -n >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident -a -n -v (labeled name)' '
     ++	echo "Author: $GIT_AUTHOR_NAME" >expect &&
     ++	git ident -a -n -v >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident -a -e -v (labeled email)' '
     ++	echo "Author: <$GIT_AUTHOR_EMAIL>" >expect &&
     ++	git ident -a -e -v >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident -a -c -e (unlabeled emails)' '
     ++	cat >expect <<-EOF &&
     ++	<$GIT_AUTHOR_EMAIL>
     ++	<$GIT_COMMITTER_EMAIL>
     ++	EOF
     ++	git ident -a -c -e >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident -a -c -e -v (labeled emails)' '
     ++	cat >expect <<-EOF &&
     ++	Author: <$GIT_AUTHOR_EMAIL>
     ++	Committer: <$GIT_COMMITTER_EMAIL>
     ++	EOF
     ++	git ident -a -c -e -v >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git whoami with explicitly configured signing key' '
     ++test_expect_success 'git ident -a -c -n -v (labeled names)' '
     ++	cat >expect <<-EOF &&
     ++	Author: $GIT_AUTHOR_NAME
     ++	Committer: $GIT_COMMITTER_NAME
     ++	EOF
     ++	git ident -a -c -n -v >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident with -z on single fields' '
     ++	printf "$GIT_AUTHOR_NAME\0" >expect_name &&
     ++	git ident -a -n -z >actual_name &&
     ++	test_cmp expect_name actual_name &&
     ++	printf "<$GIT_AUTHOR_EMAIL>\0" >expect_email &&
     ++	git ident -a -e -z >actual_email &&
     ++	test_cmp expect_email actual_email
     ++'
     ++
     ++test_expect_success 'git ident with -z on multiple entries' '
     ++	printf "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>\0$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>\0" >expect &&
     ++	git ident -z >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident --porcelain format' '
      +	test_config user.signingkey "TEST_KEY_123" &&
      +	test_config commit.gpgsign true &&
      +	test_config gpg.format ssh &&
      +	cat >expect <<-EOF &&
     -+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     -+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     -+	Signing:   TEST_KEY_123 (format: ssh, commit.gpgsign: true)
     ++	user.author.name=$GIT_AUTHOR_NAME
     ++	user.author.email=$GIT_AUTHOR_EMAIL
     ++	user.committer.name=$GIT_COMMITTER_NAME
     ++	user.committer.email=$GIT_COMMITTER_EMAIL
     ++	user.signingkey=TEST_KEY_123
     ++	gpg.format=ssh
     ++	commit.gpgsign=true
      +	EOF
     -+	git whoami >actual &&
     -+	test_cmp expect actual &&
     -+	echo "TEST_KEY_123" >expect_key &&
     -+	git whoami --signing-key >actual_key &&
     -+	test_cmp expect_key actual_key
     ++	git ident --porcelain >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git whoami with signing disabled but key configured' '
     -+	test_config user.signingkey "TEST_KEY_123" &&
     -+	test_config commit.gpgsign false &&
     -+	test_config gpg.format openpgp &&
     ++test_expect_success 'git ident -a --porcelain format' '
      +	cat >expect <<-EOF &&
     -+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     -+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     -+	Signing:   disabled (key: TEST_KEY_123, format: openpgp, commit.gpgsign: false)
     ++	user.author.name=$GIT_AUTHOR_NAME
     ++	user.author.email=$GIT_AUTHOR_EMAIL
      +	EOF
     -+	git whoami >actual &&
     -+	test_cmp expect actual &&
     ++	git ident -a --porcelain >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident --porcelain -z format' '
     ++	test_config user.signingkey "TEST_KEY_123" &&
     ++	test_config commit.gpgsign true &&
     ++	test_config gpg.format ssh &&
     ++	printf "user.author.name=$GIT_AUTHOR_NAME\0user.author.email=$GIT_AUTHOR_EMAIL\0user.committer.name=$GIT_COMMITTER_NAME\0user.committer.email=$GIT_COMMITTER_EMAIL\0user.signingkey=TEST_KEY_123\0gpg.format=ssh\0commit.gpgsign=true\0" >expect &&
     ++	git ident --porcelain -z >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git ident --signing-key when signing is disabled and unset' '
     ++	test_config commit.gpgsign false &&
     ++	test_unconfig user.signingkey &&
     ++	test_must_fail git ident --signing-key
     ++'
     ++
     ++test_expect_success 'git ident with explicitly configured signing key' '
     ++	test_config user.signingkey "TEST_KEY_123" &&
     ++	test_config commit.gpgsign true &&
     ++	test_config gpg.format ssh &&
      +	echo "TEST_KEY_123" >expect_key &&
     -+	git whoami --signing-key >actual_key &&
     ++	git ident --signing-key >actual_key &&
      +	test_cmp expect_key actual_key
      +'
      +
     -+test_expect_success 'git whoami with openpgp signing enabled without explicit key' '
     ++test_expect_success 'git ident with openpgp signing enabled without explicit key' '
      +	test_unconfig user.signingkey &&
      +	test_config commit.gpgsign true &&
      +	test_config gpg.format openpgp &&
     -+	cat >expect <<-EOF &&
     -+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     -+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     -+	Signing:   default key ($GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>) (format: openpgp, commit.gpgsign: true)
     -+	EOF
     -+	git whoami >actual &&
     -+	test_cmp expect actual &&
      +	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect_key &&
     -+	git whoami --signing-key >actual_key &&
     ++	git ident --signing-key >actual_key &&
      +	test_cmp expect_key actual_key
      +'
      +
     -+test_expect_success 'git whoami with ssh signing enabled without explicit key' '
     ++test_expect_success 'git ident with ssh signing enabled without explicit key' '
      +	test_unconfig user.signingkey &&
      +	test_config commit.gpgsign true &&
      +	test_config gpg.format ssh &&
      +	test_unconfig gpg.ssh.defaultKeyCommand &&
     -+	cat >expect <<-EOF &&
     -+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
     -+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
     -+	Signing:   enabled (no signing key configured)
     -+	EOF
     -+	git whoami >actual &&
     -+	test_cmp expect actual &&
     -+	test_must_fail git whoami --signing-key
     ++	test_must_fail git ident --signing-key
      +'
      +
     -+test_expect_success GPGSSH 'git whoami with ssh defaultKeyCommand' '
     ++test_expect_success GPGSSH 'git ident with ssh defaultKeyCommand' '
      +	test_unconfig user.signingkey &&
      +	test_config commit.gpgsign true &&
      +	test_config gpg.format ssh &&
      +	test_config gpg.ssh.defaultKeyCommand "cat \"${GPGSSH_KEY_PRIMARY}.pub\"" &&
     -+	git whoami --signing-key >actual_key &&
     ++	git ident --signing-key >actual_key &&
      +	test_grep "^SHA256:" actual_key
      +'
      +
     -+test_expect_success 'git whoami -v / --verbose' '
     -+	test_config user.signingkey "MY_SIGNING_KEY" &&
     -+	test_config commit.gpgsign true &&
     -+	test_config gpg.format openpgp &&
     -+	cat >expect <<-EOF &&
     -+	Author Name:      $GIT_AUTHOR_NAME
     -+	Author Email:     $GIT_AUTHOR_EMAIL
     -+	Committer Name:   $GIT_COMMITTER_NAME
     -+	Committer Email:  $GIT_COMMITTER_EMAIL
     -+	Signing Key:      MY_SIGNING_KEY
     -+	Signing Format:   openpgp
     -+	GPG Signing:      enabled
     -+	EOF
     -+	git whoami -v >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git whoami with environment variable overrides' '
     ++test_expect_success 'git ident with environment variable overrides' '
      +	test_unconfig user.signingkey &&
      +	test_config commit.gpgsign false &&
      +	cat >expect <<-EOF &&
     -+	Author:    Custom Author <custom.author@example.com>
     -+	Committer: Custom Committer <custom.committer@example.com>
     -+	Signing:   disabled (commit.gpgsign: false)
     ++	Custom Author <custom.author@example.com>
     ++	Custom Committer <custom.committer@example.com>
      +	EOF
      +	GIT_AUTHOR_NAME="Custom Author" \
      +	GIT_AUTHOR_EMAIL="custom.author@example.com" \
      +	GIT_COMMITTER_NAME="Custom Committer" \
      +	GIT_COMMITTER_EMAIL="custom.committer@example.com" \
     -+	git whoami >actual &&
     ++	git ident >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'incompatible option combinations fail' '
     -+	test_must_fail git whoami --author --committer 2>err &&
     -+	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --name --email 2>err &&
     -+	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --signing-key --name 2>err &&
     -+	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --signing-key --email 2>err &&
     -+	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --signing-key --author 2>err &&
     ++	test_must_fail git ident --porcelain --verbose 2>err &&
      +	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --signing-key --committer 2>err &&
     ++	test_must_fail git ident --porcelain --name 2>err &&
      +	test_grep "cannot be used together" err &&
     -+	test_must_fail git whoami --verbose --name 2>err &&
     ++	test_must_fail git ident --porcelain --email 2>err &&
      +	test_grep "cannot be used together" err
      +'
      +
     -+test_expect_success 'git whoami outside of repository' '
     -+	nongit git whoami --author >actual &&
     ++test_expect_success 'git ident outside of repository' '
     ++	nongit git ident --author >actual &&
      +	test_grep "<" actual
      +'
      +


 Documentation/git-ident.adoc | 116 +++++++++++++++++
 Documentation/meson.build    |   1 +
 Makefile                     |   1 +
 builtin.h                    |   2 +-
 builtin/ident.c              | 243 +++++++++++++++++++++++++++++++++++
 command-list.txt             |   1 +
 git.c                        |   1 +
 meson.build                  |   1 +
 t/meson.build                |   1 +
 t/t0015-ident.sh             | 234 +++++++++++++++++++++++++++++++++
 10 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-ident.adoc
 create mode 100644 builtin/ident.c
 create mode 100755 t/t0015-ident.sh

diff --git a/Documentation/git-ident.adoc b/Documentation/git-ident.adoc
new file mode 100644
index 0000000000..292a361c9b
--- /dev/null
+++ b/Documentation/git-ident.adoc
@@ -0,0 +1,116 @@
+git-ident(1)
+============
+
+NAME
+----
+git-ident - Show current user identity and commit signing information
+
+
+SYNOPSIS
+--------
+[synopsis]
+git ident [<options>]
+
+DESCRIPTION
+-----------
+Displays the author and committer identity (name and email address) and
+optionally commit signing configuration that will be used when recording
+Git commits.
+
+The identity selectors (`-a` / `--author`, `-c` / `--committer`) and component
+selectors (`-n` / `--name`, `-e` / `--email`) are additive and composable:
+
+* If neither `--author` nor `--committer` is specified, both identities are shown.
+* If neither `--name` nor `--email` is specified (or if both are specified),
+  the full identity format (`Name <email>`) is shown.
+* If `-v` / `--verbose` is specified, entries are labeled with their role
+  (`Author: ` / `Committer: `).
+
+OPTIONS
+-------
+`-a`::
+`--author`::
+	Show author identity.
+
+`-c`::
+`--committer`::
+	Show committer identity.
+
+`-n`::
+`--name`::
+	Show name only.
+
+`-e`::
+`--email`::
+	Show email address only (formatted as `<email>`).
+
+`-s`::
+`--signing-key`::
+	Show the signing key that Git would resolve for signing commits.
+	Resolution proceeds in the following order:
+	* The explicitly configured `user.signingKey`, if set.
+	* If `gpg.format` is set to `ssh` and `gpg.ssh.defaultKeyCommand`
+	  is configured, executes the command to obtain the public key.
+	* If `gpg.format` is `openpgp` or `x509` and `commit.gpgsign` is
+	  enabled, falls back to the committer identity.
+	* If signing is disabled (`commit.gpgsign=false`) and no explicit key
+	  is configured, exits with status 1.
+
+`--porcelain`::
+	Give the output in an easy-to-parse format for scripts.
+	Outputs key-value pairs (`user.author.name`, `user.author.email`,
+	`user.committer.name`, `user.committer.email`, `user.signingkey`,
+	`gpg.format`, `commit.gpgsign`).
+
+`-z`::
+`--null`::
+	Terminate output lines or entries with NUL instead of a newline.
+
+`-v`::
+`--verbose`::
+	Prepend role labels (`Author: `, `Committer: `) to identity entries.
+
+EXAMPLES
+--------
+
+* Show full author and committer identities:
++
+------------
+$ git ident
+Author Name <author@example.com>
+Committer Name <committer@example.com>
+------------
+
+* Show author identity only:
++
+------------
+$ git ident -a -e -n
+Author Name <author@example.com>
+------------
+
+* Show labeled author name:
++
+------------
+$ git ident -a -n -v
+Author: Author Name
+------------
+
+* Show author and committer email addresses:
++
+------------
+$ git ident -a -c -e
+<author@example.com>
+<committer@example.com>
+------------
+
+* Show labeled author and committer email addresses:
++
+------------
+$ git ident -a -c -e -v
+Author: <author@example.com>
+Committer: <committer@example.com>
+------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..864e5f620c 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -67,6 +67,7 @@ manpages = {
   'git-help.adoc' : 1,
   'git-history.adoc' : 1,
   'git-hook.adoc' : 1,
+  'git-ident.adoc' : 1,
   'git-http-backend.adoc' : 1,
   'git-http-fetch.adoc' : 1,
   'git-http-push.adoc' : 1,
diff --git a/Makefile b/Makefile
index d4b775953d..359d8a8917 100644
--- a/Makefile
+++ b/Makefile
@@ -1442,6 +1442,7 @@ BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
+BUILTIN_OBJS += builtin/ident.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 4e47a4ebd3..b17abed3d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -199,6 +199,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repo
 int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_ident(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
@@ -284,5 +285,4 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repo
 int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo);
-
 #endif
diff --git a/builtin/ident.c b/builtin/ident.c
new file mode 100644
index 0000000000..3571d8ad66
--- /dev/null
+++ b/builtin/ident.c
@@ -0,0 +1,243 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "builtin.h"
+#include "config.h"
+#include "gettext.h"
+#include "gpg-interface.h"
+#include "ident.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static const char * const ident_usage[] = {
+	N_("git ident [<options>]"),
+	NULL
+};
+
+enum ident_who {
+	IDENT_AUTHOR = 1 << 0,
+	IDENT_COMMITTER = 1 << 1,
+};
+
+enum ident_part {
+	IDENT_NAME = 1 << 0,
+	IDENT_EMAIL = 1 << 1,
+};
+
+struct ident_config {
+	int gpgsign;
+	char *signing_key;
+	char *gpg_format;
+	char *ssh_default_key_cmd;
+};
+
+static int ident_config_cb(const char *var, const char *value,
+			   const struct config_context *ctx, void *data)
+{
+	struct ident_config *cfg = data;
+
+	if (!strcmp(var, "commit.gpgsign")) {
+		cfg->gpgsign = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "user.signingkey"))
+		return git_config_string(&cfg->signing_key, var, value);
+	if (!strcmp(var, "gpg.format"))
+		return git_config_string(&cfg->gpg_format, var, value);
+	if (!strcmp(var, "gpg.ssh.defaultkeycommand"))
+		return git_config_string(&cfg->ssh_default_key_cmd, var, value);
+
+	return git_default_config(var, value, ctx, data);
+}
+
+static void print_ident_entry(const char *label,
+			      const struct strbuf *name,
+			      const struct strbuf *email,
+			      int parts,
+			      int verbose,
+			      char eol)
+{
+	struct strbuf out = STRBUF_INIT;
+
+	if (verbose && label)
+		strbuf_addf(&out, "%s: ", label);
+
+	if ((parts & IDENT_NAME) && (parts & IDENT_EMAIL))
+		strbuf_addf(&out, "%s <%s>", name->buf, email->buf);
+	else if (parts & IDENT_NAME)
+		strbuf_addbuf(&out, name);
+	else if (parts & IDENT_EMAIL)
+		strbuf_addf(&out, "<%s>", email->buf);
+
+	printf("%s%c", out.buf, eol);
+	strbuf_release(&out);
+}
+
+int cmd_ident(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo)
+{
+	int show_author = 0;
+	int show_committer = 0;
+	int show_name = 0;
+	int show_email = 0;
+	int show_signing_key = 0;
+	int porcelain = 0;
+	int nul_term = 0;
+	int verbose = 0;
+	int ret = 0;
+	char eol;
+	int selected_who = 0;
+	int selected_parts = 0;
+
+	struct option ident_options[] = {
+		OPT_BOOL('a', "author", &show_author, N_("show author identity")),
+		OPT_BOOL('c', "committer", &show_committer, N_("show committer identity")),
+		OPT_BOOL('n', "name", &show_name, N_("show name only")),
+		OPT_BOOL('e', "email", &show_email, N_("show email only")),
+		OPT_BOOL('s', "signing-key", &show_signing_key, N_("show commit signing key")),
+		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT_BOOL('z', "null", &nul_term, N_("terminate entries with NUL")),
+		OPT__VERBOSE(&verbose, N_("show detailed identity")),
+		OPT_END()
+	};
+
+	struct ident_config cfg = { 0 };
+	struct strbuf author_info = STRBUF_INIT;
+	struct strbuf committer_info = STRBUF_INIT;
+	struct ident_split author_split, committer_split;
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf committer_name = STRBUF_INIT;
+	struct strbuf committer_email = STRBUF_INIT;
+	char *resolved_key = NULL;
+	int is_ssh = 0;
+
+	argc = parse_options(argc, argv, prefix, ident_options,
+			     ident_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(ident_usage, ident_options);
+
+	die_for_incompatible_opt2(porcelain, "--porcelain", verbose, "--verbose");
+	die_for_incompatible_opt2(porcelain, "--porcelain", show_name, "--name");
+	die_for_incompatible_opt2(porcelain, "--porcelain", show_email, "--email");
+
+	eol = nul_term ? '\0' : '\n';
+
+	repo_config(repo, ident_config_cb, &cfg);
+
+	strbuf_addstr(&author_info, git_author_info(IDENT_NO_DATE));
+	strbuf_addstr(&committer_info, git_committer_info(IDENT_NO_DATE));
+
+	if (split_ident_line(&author_split, author_info.buf, author_info.len) == 0) {
+		if (author_split.name_begin && author_split.name_end)
+			strbuf_add(&author_name, author_split.name_begin,
+				   author_split.name_end - author_split.name_begin);
+		if (author_split.mail_begin && author_split.mail_end)
+			strbuf_add(&author_email, author_split.mail_begin,
+				   author_split.mail_end - author_split.mail_begin);
+	}
+
+	if (split_ident_line(&committer_split, committer_info.buf, committer_info.len) == 0) {
+		if (committer_split.name_begin && committer_split.name_end)
+			strbuf_add(&committer_name, committer_split.name_begin,
+				   committer_split.name_end - committer_split.name_begin);
+		if (committer_split.mail_begin && committer_split.mail_end)
+			strbuf_add(&committer_email, committer_split.mail_begin,
+				   committer_split.mail_end - committer_split.mail_begin);
+	}
+
+	is_ssh = cfg.gpg_format && !strcmp(cfg.gpg_format, "ssh");
+
+	if (cfg.signing_key && *cfg.signing_key) {
+		resolved_key = xstrdup(cfg.signing_key);
+	} else if (is_ssh) {
+		if (cfg.ssh_default_key_cmd && *cfg.ssh_default_key_cmd)
+			resolved_key = get_signing_key_id();
+	} else if (cfg.gpgsign) {
+		resolved_key = get_signing_key_id();
+	}
+
+	if (show_signing_key && !show_author && !show_committer && !show_name && !show_email && !porcelain) {
+		if (resolved_key && *resolved_key) {
+			if (verbose)
+				printf(_("Signing Key: %s\n"), resolved_key);
+			else
+				printf("%s%c", resolved_key, eol);
+			ret = 0;
+		} else {
+			ret = 1;
+		}
+		goto cleanup;
+	}
+
+	if (show_author)
+		selected_who |= IDENT_AUTHOR;
+	if (show_committer)
+		selected_who |= IDENT_COMMITTER;
+	if (!selected_who)
+		selected_who = IDENT_AUTHOR | IDENT_COMMITTER;
+
+	if (show_name)
+		selected_parts |= IDENT_NAME;
+	if (show_email)
+		selected_parts |= IDENT_EMAIL;
+	if (!selected_parts)
+		selected_parts = IDENT_NAME | IDENT_EMAIL;
+
+	if (porcelain) {
+		if (selected_who & IDENT_AUTHOR) {
+			printf("user.author.name=%s%c", author_name.buf, eol);
+			printf("user.author.email=%s%c", author_email.buf, eol);
+		}
+		if (selected_who & IDENT_COMMITTER) {
+			printf("user.committer.name=%s%c", committer_name.buf, eol);
+			printf("user.committer.email=%s%c", committer_email.buf, eol);
+		}
+		if ((selected_who & (IDENT_AUTHOR | IDENT_COMMITTER)) == (IDENT_AUTHOR | IDENT_COMMITTER)) {
+			printf("user.signingkey=%s%c",
+			       (cfg.signing_key && *cfg.signing_key) ? cfg.signing_key :
+			       (resolved_key && *resolved_key) ? resolved_key : "none",
+			       eol);
+			printf("gpg.format=%s%c",
+			       cfg.gpg_format ? cfg.gpg_format : "openpgp", eol);
+			printf("commit.gpgsign=%s%c",
+			       cfg.gpgsign ? "true" : "false", eol);
+		}
+		goto cleanup;
+	}
+
+	if (selected_who & IDENT_AUTHOR)
+		print_ident_entry("Author", &author_name, &author_email,
+				  selected_parts, verbose, eol);
+
+	if (selected_who & IDENT_COMMITTER)
+		print_ident_entry("Committer", &committer_name, &committer_email,
+				  selected_parts, verbose, eol);
+
+	if (show_signing_key) {
+		if (resolved_key && *resolved_key) {
+			if (verbose)
+				printf(_("Signing Key: %s\n"), resolved_key);
+			else
+				printf("%s%c", resolved_key, eol);
+		} else {
+			ret = 1;
+		}
+	}
+
+cleanup:
+	free(cfg.signing_key);
+	free(cfg.gpg_format);
+	free(cfg.ssh_default_key_cmd);
+	free(resolved_key);
+	strbuf_release(&author_info);
+	strbuf_release(&committer_info);
+	strbuf_release(&author_name);
+	strbuf_release(&author_email);
+	strbuf_release(&committer_name);
+	strbuf_release(&committer_email);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 21b802c420..39a22c271f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -118,6 +118,7 @@ git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
 git-history                             mainporcelain           history
 git-hook                                purehelpers
+git-ident                               ancillaryinterrogators
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 96df15b5cd..926187351a 100644
--- a/git.c
+++ b/git.c
@@ -593,6 +593,7 @@ static struct cmd_struct commands[] = {
 	{ "help", cmd_help },
 	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
+	{ "ident", cmd_ident, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/meson.build b/meson.build
index d86f2acd2b..37821ed890 100644
--- a/meson.build
+++ b/meson.build
@@ -654,6 +654,7 @@ builtin_sources = [
   'builtin/help.c',
   'builtin/history.c',
   'builtin/hook.c',
+  'builtin/ident.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
   'builtin/interpret-trailers.c',
diff --git a/t/meson.build b/t/meson.build
index 181d61a8a0..3738d86140 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -87,6 +87,7 @@ integration_tests = [
   't0012-help.sh',
   't0013-sha1dc.sh',
   't0014-alias.sh',
+  't0015-ident.sh',
   't0017-env-helper.sh',
   't0018-advice.sh',
   't0019-json-writer.sh',
diff --git a/t/t0015-ident.sh b/t/t0015-ident.sh
new file mode 100755
index 0000000000..8b6358e771
--- /dev/null
+++ b/t/t0015-ident.sh
@@ -0,0 +1,234 @@
+#!/bin/sh
+
+test_description='basic sanity checks for git ident'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success 'default output format (author + committer)' '
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git ident >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -v / --verbose default' '
+	cat >expect <<-EOF &&
+	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git ident -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident --author / -a' '
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
+	git ident --author >actual &&
+	test_cmp expect actual &&
+	git ident -a >actual_short &&
+	test_cmp expect actual_short
+'
+
+test_expect_success 'git ident --committer / -c' '
+	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect &&
+	git ident --committer >actual &&
+	test_cmp expect actual &&
+	git ident -c >actual_short &&
+	test_cmp expect actual_short
+'
+
+test_expect_success 'git ident -a -c' '
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git ident -a -c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -n and -a -e' '
+	echo "$GIT_AUTHOR_NAME" >expect_name &&
+	git ident -a -n >actual_name &&
+	test_cmp expect_name actual_name &&
+	echo "<$GIT_AUTHOR_EMAIL>" >expect_email &&
+	git ident -a -e >actual_email &&
+	test_cmp expect_email actual_email
+'
+
+test_expect_success 'git ident -c -n and -c -e' '
+	echo "$GIT_COMMITTER_NAME" >expect_name &&
+	git ident -c -n >actual_name &&
+	test_cmp expect_name actual_name &&
+	echo "<$GIT_COMMITTER_EMAIL>" >expect_email &&
+	git ident -c -e >actual_email &&
+	test_cmp expect_email actual_email
+'
+
+test_expect_success 'git ident -a -e -n (additive full ident)' '
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
+	git ident -a -e -n >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -n -v (labeled name)' '
+	echo "Author: $GIT_AUTHOR_NAME" >expect &&
+	git ident -a -n -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -e -v (labeled email)' '
+	echo "Author: <$GIT_AUTHOR_EMAIL>" >expect &&
+	git ident -a -e -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -c -e (unlabeled emails)' '
+	cat >expect <<-EOF &&
+	<$GIT_AUTHOR_EMAIL>
+	<$GIT_COMMITTER_EMAIL>
+	EOF
+	git ident -a -c -e >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -c -e -v (labeled emails)' '
+	cat >expect <<-EOF &&
+	Author: <$GIT_AUTHOR_EMAIL>
+	Committer: <$GIT_COMMITTER_EMAIL>
+	EOF
+	git ident -a -c -e -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a -c -n -v (labeled names)' '
+	cat >expect <<-EOF &&
+	Author: $GIT_AUTHOR_NAME
+	Committer: $GIT_COMMITTER_NAME
+	EOF
+	git ident -a -c -n -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident with -z on single fields' '
+	printf "$GIT_AUTHOR_NAME\0" >expect_name &&
+	git ident -a -n -z >actual_name &&
+	test_cmp expect_name actual_name &&
+	printf "<$GIT_AUTHOR_EMAIL>\0" >expect_email &&
+	git ident -a -e -z >actual_email &&
+	test_cmp expect_email actual_email
+'
+
+test_expect_success 'git ident with -z on multiple entries' '
+	printf "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>\0$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>\0" >expect &&
+	git ident -z >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident --porcelain format' '
+	test_config user.signingkey "TEST_KEY_123" &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	cat >expect <<-EOF &&
+	user.author.name=$GIT_AUTHOR_NAME
+	user.author.email=$GIT_AUTHOR_EMAIL
+	user.committer.name=$GIT_COMMITTER_NAME
+	user.committer.email=$GIT_COMMITTER_EMAIL
+	user.signingkey=TEST_KEY_123
+	gpg.format=ssh
+	commit.gpgsign=true
+	EOF
+	git ident --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident -a --porcelain format' '
+	cat >expect <<-EOF &&
+	user.author.name=$GIT_AUTHOR_NAME
+	user.author.email=$GIT_AUTHOR_EMAIL
+	EOF
+	git ident -a --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident --porcelain -z format' '
+	test_config user.signingkey "TEST_KEY_123" &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	printf "user.author.name=$GIT_AUTHOR_NAME\0user.author.email=$GIT_AUTHOR_EMAIL\0user.committer.name=$GIT_COMMITTER_NAME\0user.committer.email=$GIT_COMMITTER_EMAIL\0user.signingkey=TEST_KEY_123\0gpg.format=ssh\0commit.gpgsign=true\0" >expect &&
+	git ident --porcelain -z >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ident --signing-key when signing is disabled and unset' '
+	test_config commit.gpgsign false &&
+	test_unconfig user.signingkey &&
+	test_must_fail git ident --signing-key
+'
+
+test_expect_success 'git ident with explicitly configured signing key' '
+	test_config user.signingkey "TEST_KEY_123" &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	echo "TEST_KEY_123" >expect_key &&
+	git ident --signing-key >actual_key &&
+	test_cmp expect_key actual_key
+'
+
+test_expect_success 'git ident with openpgp signing enabled without explicit key' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format openpgp &&
+	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect_key &&
+	git ident --signing-key >actual_key &&
+	test_cmp expect_key actual_key
+'
+
+test_expect_success 'git ident with ssh signing enabled without explicit key' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	test_unconfig gpg.ssh.defaultKeyCommand &&
+	test_must_fail git ident --signing-key
+'
+
+test_expect_success GPGSSH 'git ident with ssh defaultKeyCommand' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	test_config gpg.ssh.defaultKeyCommand "cat \"${GPGSSH_KEY_PRIMARY}.pub\"" &&
+	git ident --signing-key >actual_key &&
+	test_grep "^SHA256:" actual_key
+'
+
+test_expect_success 'git ident with environment variable overrides' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign false &&
+	cat >expect <<-EOF &&
+	Custom Author <custom.author@example.com>
+	Custom Committer <custom.committer@example.com>
+	EOF
+	GIT_AUTHOR_NAME="Custom Author" \
+	GIT_AUTHOR_EMAIL="custom.author@example.com" \
+	GIT_COMMITTER_NAME="Custom Committer" \
+	GIT_COMMITTER_EMAIL="custom.committer@example.com" \
+	git ident >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incompatible option combinations fail' '
+	test_must_fail git ident --porcelain --verbose 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git ident --porcelain --name 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git ident --porcelain --email 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'git ident outside of repository' '
+	nongit git ident --author >actual &&
+	test_grep "<" actual
+'
+
+test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
