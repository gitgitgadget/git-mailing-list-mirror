Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682093;
	b=SzwJyJOays4PWjlLwzGtPk8lKbv1lffbv/jXa0kGouoDnnqrNwGdj8TlEXdWZQV2Xv9N
	 CTNABriaqlH4ZaprOddu6h/snGz75vnBa3wFsshOL72ZpCPCIxD7o8X8PkR2TInmfZWYG
	 m+rZKtwdgC1XbWWcrZWecRxERnnbAQ4GHgOoYWlFxpcFrJTfEqP2R9UgOhAKvb0ffPwzx
	 oGeIznwtk/KKUkltP4M7MJZdYyfVsX0/0tYuMvr9GcB9ZLqM/5d7S+XxIxshM0NSUHrD9
	 tevnyJJIvIjIqf/JAJOLHDGNIuucnEb21FEOPVoJjwR7bjotLPWJIH9MySyYNQECFoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YK2ps72YuSCPGSfyQtjWxgXODZREkj2sr3qLPLs4Ssw=;
	b=Obcg8ISUlPaZXS8eiXfw78Emiu5tdzkPV1fZL+hhAGxnAyqwPPQXyMejM39F0jszL8lP
	 O+gYJMOsKdzxzJcGQpizQCFsrYYUTURBbI0/0KfRv+IZsuxlXoKTqsHAKrybmCN4pw/oF
	 NlPNFj/tKKr/jEbqKmTURmtfuGeGvC3y4Qd4k0NVMZyZ/VJAti846e6ba3/6/QwWTH2kg
	 FJXtFtrKKbrxiDAY9ZiDOt4mybyglqtTtljxp6bcsB9waUYhSt4SDdh0BSAz6bi8IDV8m
	 rN1N/lN7XJVv/cWfmiKJXxwgcVe8tInPWQdB/m8cvNCb66OuBcvgMnAs1O/57wsSJGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGLyIV6N;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF5606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EF5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGLyIV6N
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so13354465e9.2
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682092; x=1795286892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK2ps72YuSCPGSfyQtjWxgXODZREkj2sr3qLPLs4Ssw=;
        b=OGLyIV6N6NOCpwxwmhad9DVC53TPuMyWCYS3eqqFbAG8j2PbPUK7Yk9rYzkBLr8CMb
         Q65/e2YYhwAuW145jSxcQtIcTmCzGP1TdQOLg5C7ymVe1Y5OTI99nIugmD5yGl0OcUjf
         hYrrBLs962lvY56lWOjZiwc3F68Zj23XTRUzoXIY6yGvXBfD1e9HQroxg90BB6vNIIRO
         NWvpvHs/7klUehKXHwKiIvPBP2HwduqZPJtmuAzTZ5d9Br2w7qgCdw3bABi97WrQU9VA
         sYH9cwRA62xDLS/TA+HpBSZ0xa+oMQlD78xnl54nrOfXjXJXzsKAXk4BjcIiQ53aoIPS
         o4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682092; x=1795286892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YK2ps72YuSCPGSfyQtjWxgXODZREkj2sr3qLPLs4Ssw=;
        b=pj5lwZIn+G1IfN3pW7cO6mGcYze+W0I/pv4/03x400UGt2KGay5N7dftViCGdYolFT
         S8O6In0WeMlV6EWZA1IdPrFfKEE5oVtnUIRytUOSwJD8yqrxOO+2geZqTCuOxhfDW43P
         iPiK2StQiBbpQTzo5105ROxyilC4+RRnVV5NrmdEL8ZgErtfP/QpQ7DDTXJfYRiTeCfI
         N2nmQf6RCsjYr3rGtEKx87CXQHBi/q5w9nWHYfhu1Q1iyLbpo14sxGRf0oSYaWrlj9QX
         1kNv/n4taUV0lJTjj+JIYsPQfZ9pTlhfErqH9QYLHDHEkESQokuxrjewPxa29IMJ/nOU
         wNYA==
X-Gm-Message-State: APuU4Z82VIFkVWZM8d/dlZIg3EnlCsa6a9nWhzxIcJrpbLzhEBuzpk5g
	y5pef3HED6ShhmmRa9bjTfpi01d2vCNwRN4vVCZmexRDy3QqbvNynIlDx2c3KhpP88c=
X-Gm-Gg: AYBFou1QUHSQ+rMhR+A+f6N2QCvheuit/3AEiIjY6nHoEkyt8iVObKT/cP6wRkZmyI1
	dZPkLqq7ICCrqCKaD+FANPGcu5r0LUa6QqvteSpCxRraMIRalM1XwqkuA6bX0r7743MnW+EY0rK
	11MhKgc+WmCE4mXklsEZqNYmgNJN80xdP9JGafkP/x+MrWg6RYeKjH+PJ1U/xM31X8O+AkVisNY
	y+V7xXMfjeNnfIVKS8PhLcRyXSoivNgz2TYx44xG4CdEcnmJKZpic+SCRWfQ737jXnqvEDZLLtf
	vkQyMANaCQSf/2qed3r6jtQBt9cqjXyCwWDA7z8N5u14Cp9MxmPZfmMZF+4Uvq60gzdV24y8Jas
	/jXNzntDgMzt1YYbmkvn3Y8weBmnFq+PiDz1Fa200WU9lXiY1k7wJSgFs77ExEv+m3IJi4inJMT
	/EZfr2RwvNhVfuTfZPMyBruiQP6zl/fe+1f1sT1+hkEevvqmw9AUqCTLmjQpZjkismtw3uJjzKx
	91pzEmgjRKNwKk34e6bGbsmxjEuovA8KC5+uKeh+6iAWPj3Nsfwm57+E8VaOwuIjOg4E+EPm3H4
	adB6jd/N4VAfasnWFz1ttZkYxl8oFRckGMvTS8jDzeXTg8hSiW6BlM2tf0XxcC16uvvW55623x+
	3ByKYYWAuTMLCpi2n2WjVJODLZ1qGpvUv3bQi8Xr5SFF3A+vAeIeJcyIGsiScwlrIzIvU1+nRqY
	9l+frpk9LZ1NbL2pol1jwHtLAhpUgr421A
X-Received: by 2002:a05:600c:3509:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb559f2cc3mr128711325e9.2.1794682091403;
        Sat, 14 Nov 2026 10:48:11 -0800 (PST)
Received: from localhost.localdomain ([212.88.111.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e3fsm128620355e9.5.2026.11.14.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:48:10 -0800 (PST)
From: Wasswa Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	Wasswa Edson <edsonwasswa54@gmail.com>
Subject: [PATCH v2 0/3] credential: parse subcommands with OPT_SUBCOMMAND
Date: Sat, 14 Nov 2026 21:47:49 +0300
Message-ID: <20261114184752.1417-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261104202228.24642-1-edsonwasswa54@gmail.com>
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git credential" dispatches its subcommands by hand with strcmp().
This series converts it to OPT_SUBCOMMAND(), so that each subcommand
gets its own "-h" usage and the subcommand names become available
to completion.

Changes since v1:

 - Split into three patches. The pre-existing mismatch between the
   "-h" output and the SYNOPSIS (1/3) and a refactor moving each
   subcommand into its own function (2/3) are now separate from the
   switch to OPT_SUBCOMMAND() (3/3).

 - Factor the repeated parse_options() call and argument check into
   a helper, which rejects leftover arguments with "too many
   arguments" (Tanga).

 - Add a test for the rejection of extra arguments (Tanga).

 - Drop the claim that the code gets shorter (Tanga).

v1: https://lore.kernel.org/git/20261104202228.24642-1-edsonwasswa54@gmail.com/

Wasswa Edson (3):
  credential: make -h output and SYNOPSIS agree
  credential: move each subcommand into its own function
  credential: parse subcommands with OPT_SUBCOMMAND

 Documentation/git-credential.adoc |   3 +-
 builtin/credential.c              | 143 +++++++++++++++++++++++-------
 git.c                             |   2 +-
 t/t0300-credentials.sh            |  27 ++++++
 t/t0450/adoc-help-mismatches      |   1 -
 5 files changed, 142 insertions(+), 34 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  d1bffb83df credential: make -h output and SYNOPSIS agree
-:  ---------- > 2:  c7708ac31b credential: move each subcommand into its own function
1:  85e3f2ce94 ! 3:  7c9842bb9e credential: parse subcommands with OPT_SUBCOMMAND
    @@ Metadata
      ## Commit message ##
         credential: parse subcommands with OPT_SUBCOMMAND
     
    -    "git credential" dispatches its four subcommands (fill, approve,
    -    reject, capability) with a strcmp() chain after an argc check,
    -    instead of using the parse-options API used by other builtins.
    +    Now that each subcommand of "git credential" lives in its own
    +    function, switch the dispatch to OPT_SUBCOMMAND(). This gives each
    +    subcommand its own usage string, so that "git credential <subcommand>
    +    -h" shows help for that subcommand, and makes the subcommand names
    +    available to the completion via --git-completion-helper.
     
    -    Convert the dispatch to OPT_SUBCOMMAND(). Besides making the code
    -    shorter and more idiomatic, each subcommand gets its own usage
    -    string, so "git credential <subcommand> -h" shows a targeted help
    -    text, and the subcommand names are reported via
    -    --git-completion-helper.
    +    Each subcommand takes neither options nor arguments; reject any
    +    with a common helper. Drop NO_PARSEOPT from the git.c entry, as the
    +    command now uses parse-options.
     
    -    Since the builtin now uses parse-options, drop NO_PARSEOPT from its
    -    git.c entry so "git --list-cmds=parseopt" includes it.
    +    This changes the behavior only on error paths:
     
    -    Two pre-existing inconsistencies are fixed while at it:
    +     - A missing or unknown subcommand is reported as such ("need a
    +       subcommand" / "unknown subcommand") before the usage text.
     
    -    - The usage string did not mention "capability" even though it is a
    -      documented subcommand; it now lists all four.
    -    - Documentation/git-credential.adoc marked its SYNOPSIS as a plain
    -      literal block, which t0450 cannot extract; mark it [verse] and drop
    -      "credential" from t0450/adoc-help-mismatches.
    +     - Extra arguments are reported as "too many arguments" before the
    +       usage text of the subcommand.
     
    -    Behavior changes are limited to error paths: a missing or unknown
    -    subcommand is reported as such ("need a subcommand" / "unknown
    -    subcommand") before the usage text, instead of only showing the
    -    usage text, and "git credential <subcommand> -h" exits 0 after
    -    showing the subcommand's usage. Exit codes for failures are
    -    unchanged (129).
    +     - "git credential <subcommand> -h" shows the usage of that
    +       subcommand and exits with 0, instead of failing with the usage of
    +       the whole command.
     
    -    Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
    +    Failures still exit with 129.
     
    - ## Documentation/git-credential.adoc ##
    -@@ Documentation/git-credential.adoc: git-credential - Retrieve and store user credentials
    - 
    - SYNOPSIS
    - --------
    --------------------
    -+[verse]
    - 'git credential' (fill|approve|reject|capability)
    --------------------
    - 
    - DESCRIPTION
    - -----------
    +    Helped-by: Tanga Joris <tangajoris@gmail.com>
    +    Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
     
      ## builtin/credential.c ##
     @@
    @@ builtin/credential.c
      #include "config.h"
     +#include "gettext.h"
     +#include "parse-options.h"
    - 
    --static const char usage_msg[] =
    --	"git credential (fill|approve|reject)";
    ++
     +static const char * const credential_usage[] = {
     +	N_("git credential (fill|approve|reject|capability)"),
     +	NULL,
     +};
    - 
    --int cmd_credential(int argc,
    --		   const char **argv,
    --		   const char *prefix UNUSED,
    --		   struct repository *repo UNUSED)
    ++
     +static const char * const credential_fill_usage[] = {
     +	N_("git credential fill"),
     +	NULL,
    @@ builtin/credential.c
     +	NULL,
     +};
     +
    ++static void parse_no_args(int argc, const char **argv, const char *prefix,
    ++			  const char * const *usagestr)
    ++{
    ++	struct option options[] = {
    ++		OPT_END()
    ++	};
    + 
    +-static const char usage_msg[] =
    +-	"git credential (fill|approve|reject|capability)";
    ++	if (parse_options(argc, argv, prefix, options, usagestr, 0))
    ++		usage_msg_opt(_("too many arguments"), usagestr, options);
    ++}
    + 
    +-static int cmd_credential_fill(int argc UNUSED, const char **argv UNUSED,
    +-			       const char *prefix UNUSED,
     +static int cmd_credential_fill(int argc, const char **argv, const char *prefix,
    -+			       struct repository *repo UNUSED)
    + 			       struct repository *repo UNUSED)
      {
    --	const char *op;
    -+	struct option options[] = { OPT_END() };
      	struct credential c = CREDENTIAL_INIT;
      
    --	repo_config(the_repository, git_default_config, NULL);
    -+	argc = parse_options(argc, argv, prefix, options,
    -+			     credential_fill_usage, 0);
    -+	if (argc)
    -+		usage_with_options(credential_fill_usage, options);
    -+
    -+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
    -+		die("unable to read credential from stdin");
    ++	parse_no_args(argc, argv, prefix, credential_fill_usage);
     +
    -+	credential_fill(the_repository, &c, 0);
    -+	credential_next_state(&c);
    -+	credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
    -+
    -+	credential_clear(&c);
    -+	return 0;
    -+}
    + 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
    + 		die("unable to read credential from stdin");
      
    --	show_usage_if_asked(argc, argv, usage_msg);
    --	if (argc != 2)
    --		usage(usage_msg);
    --	op = argv[1];
    -+static int cmd_credential_approve(int argc, const char **argv,
    -+				const char *prefix,
    -+				struct repository *repo UNUSED)
    -+{
    -+	struct option options[] = { OPT_END() };
    -+	struct credential c = CREDENTIAL_INIT;
    +@@ builtin/credential.c: static int cmd_credential_fill(int argc UNUSED, const char **argv UNUSED,
    + 	return 0;
    + }
      
    --	if (!strcmp(op, "capability")) {
    --		credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
    --		credential_announce_capabilities(&c, stdout);
    --		return 0;
    --	}
    -+	argc = parse_options(argc, argv, prefix, options,
    -+			     credential_approve_usage, 0);
    -+	if (argc)
    -+		usage_with_options(credential_approve_usage, options);
    +-static int cmd_credential_approve(int argc UNUSED, const char **argv UNUSED,
    +-				  const char *prefix UNUSED,
    ++static int cmd_credential_approve(int argc, const char **argv,
    ++				  const char *prefix,
    + 				  struct repository *repo UNUSED)
    + {
    + 	struct credential c = CREDENTIAL_INIT;
      
    ++	parse_no_args(argc, argv, prefix, credential_approve_usage);
    ++
      	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
      		die("unable to read credential from stdin");
      
    --	if (!strcmp(op, "fill")) {
    --		credential_fill(the_repository, &c, 0);
    --		credential_next_state(&c);
    --		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
    --	} else if (!strcmp(op, "approve")) {
    --		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
    --		credential_approve(the_repository, &c);
    --	} else if (!strcmp(op, "reject")) {
    --		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
    --		credential_reject(the_repository, &c);
    --	} else {
    --		usage(usage_msg);
    --	}
    -+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
    -+	credential_approve(the_repository, &c);
    - 
    - 	credential_clear(&c);
    +@@ builtin/credential.c: static int cmd_credential_approve(int argc UNUSED, const char **argv UNUSED,
      	return 0;
      }
    -+
    + 
    +-static int cmd_credential_reject(int argc UNUSED, const char **argv UNUSED,
    +-				 const char *prefix UNUSED,
     +static int cmd_credential_reject(int argc, const char **argv,
     +				 const char *prefix,
    -+				 struct repository *repo UNUSED)
    -+{
    -+	struct option options[] = { OPT_END() };
    -+	struct credential c = CREDENTIAL_INIT;
    -+
    -+	argc = parse_options(argc, argv, prefix, options,
    -+			     credential_reject_usage, 0);
    -+	if (argc)
    -+		usage_with_options(credential_reject_usage, options);
    -+
    -+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
    -+		die("unable to read credential from stdin");
    -+
    -+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
    -+	credential_reject(the_repository, &c);
    -+
    -+	credential_clear(&c);
    -+	return 0;
    -+}
    + 				 struct repository *repo UNUSED)
    + {
    + 	struct credential c = CREDENTIAL_INIT;
    + 
    ++	parse_no_args(argc, argv, prefix, credential_reject_usage);
     +
    + 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
    + 		die("unable to read credential from stdin");
    + 
    +@@ builtin/credential.c: static int cmd_credential_reject(int argc UNUSED, const char **argv UNUSED,
    + 	return 0;
    + }
    + 
    +-static int cmd_credential_capability(int argc UNUSED,
    +-				     const char **argv UNUSED,
    +-				     const char *prefix UNUSED,
     +static int cmd_credential_capability(int argc, const char **argv,
     +				     const char *prefix,
    -+				     struct repository *repo UNUSED)
    -+{
    -+	struct option options[] = { OPT_END() };
    -+	struct credential c = CREDENTIAL_INIT;
    -+
    -+	argc = parse_options(argc, argv, prefix, options,
    -+			     credential_capability_usage, 0);
    -+	if (argc)
    -+		usage_with_options(credential_capability_usage, options);
    -+
    -+	credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
    -+	credential_announce_capabilities(&c, stdout);
    -+
    -+	credential_clear(&c);
    -+	return 0;
    -+}
    + 				     struct repository *repo UNUSED)
    + {
    + 	struct credential c = CREDENTIAL_INIT;
    + 
    ++	parse_no_args(argc, argv, prefix, credential_capability_usage);
     +
    -+int cmd_credential(int argc,
    -+		   const char **argv,
    -+		   const char *prefix,
    -+		   struct repository *repo)
    -+{
    + 	credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
    + 	credential_announce_capabilities(&c, stdout);
    + 
    +@@ builtin/credential.c: int cmd_credential(int argc,
    + 		   const char *prefix,
    + 		   struct repository *repo)
    + {
    +-	const char *op;
     +	parse_opt_subcommand_fn *fn = NULL;
     +	struct option options[] = {
     +		OPT_SUBCOMMAND("fill", &fn, cmd_credential_fill),
    @@ builtin/credential.c
     +		OPT_SUBCOMMAND("capability", &fn, cmd_credential_capability),
     +		OPT_END()
     +	};
    -+
    -+	repo_config(the_repository, git_default_config, NULL);
    -+
    + 
    + 	repo_config(the_repository, git_default_config, NULL);
    + 
    +-	show_usage_if_asked(argc, argv, usage_msg);
    +-	if (argc != 2)
    +-		usage(usage_msg);
    +-	op = argv[1];
    +-
    +-	if (!strcmp(op, "fill"))
    +-		return cmd_credential_fill(argc - 1, argv + 1, prefix, repo);
    +-	if (!strcmp(op, "approve"))
    +-		return cmd_credential_approve(argc - 1, argv + 1, prefix, repo);
    +-	if (!strcmp(op, "reject"))
    +-		return cmd_credential_reject(argc - 1, argv + 1, prefix, repo);
    +-	if (!strcmp(op, "capability"))
    +-		return cmd_credential_capability(argc - 1, argv + 1, prefix,
    +-						 repo);
    +-
    +-	usage(usage_msg);
     +	argc = parse_options(argc, argv, prefix, options, credential_usage, 0);
     +
     +	return fn(argc, argv, prefix, repo);
    -+}
    + }
     
      ## git.c ##
     @@ git.c: static struct cmd_struct commands[] = {
    @@ t/t0300-credentials.sh: test_expect_success 'interactive prompt is sanitized' '
     +	test_expect_code 129 git credential foo 2>err &&
     +	test_grep "unknown subcommand" err
     +'
    ++
    ++test_expect_success 'credential subcommands reject extra arguments' '
    ++	for sub in fill approve reject capability
    ++	do
    ++		test_expect_code 129 git credential $sub extra \
    ++			</dev/null 2>err &&
    ++		test_grep "too many arguments" err || return 1
    ++	done
    ++'
     +
      test_done
    -
    - ## t/t0450/adoc-help-mismatches ##
    -@@ t/t0450/adoc-help-mismatches: checkout
    - checkout-index
    - clone
    - column
    --credential
    - credential-cache
    - credential-store
    - fetch-pack

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
2.53.0

