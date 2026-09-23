Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17251FC0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150990; cv=none; b=byycPYMpZahuN6s8cK57teNlx3TQFcY8cZDntqugx3bt3r/u8Wv4Jcu2WuviTIDuJXUSZWwZapzzMb3Qtb68WG4jnMdiHygPMJt5tkOtmbZ/Jq8EzH8q2DTGuyFmp7x0nLlJ8JiyDb0h2/C4bmcx6Nm+8o2hrAKaCxqqvyrSeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150990; c=relaxed/simple;
	bh=UQMQe+5sFO+J0JYzdGRPEift4j+5jxZJtv4Dae9zZNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyH927QCbQVckqihLjnVIOQddy4H/15VTfxMhLeAxrN0yE2kTBMmQyc4ywGkTqdldsqTM5/a8q+R2jVsXEAJ+E9//93QvQ443Abhb3Mw3GF1xkq8LM4XuYMU1hCSQ3kBJ28j+xJ4iBZnSnvF9suYL/2+kjgZZct15vL23Z/A/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrD58rrd; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrD58rrd"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4858bc96fabso551072f8f.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150986; x=1790755786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UijdBnn6WOiz2IYzdQK3bkuIV6Ami5lrn2usdhsplRI=;
        b=LrD58rrdBKWDrDQoDo+7tHgHWT9w0MGaivuMlK8QMIIcWw4rD/PsrOmtYYDzLTWs9f
         cFbv8CRDLV6rqLLm/oVdoGCmwL96bcZHD/oJS6mDuCw309n4SmUELsDLQImL3oKEP+K4
         /whjQgHcWv+WN1Wrvbq8UYdmW5kJjYPazWlrFOnkk/8d/okP98IgS53d4FfvpOU9ZOre
         eS+IHhjb3o4yLYIpruflmVGV9zuODvtlWc05zYdfGdlEcTg4uPzFl2ZBSb1WNII6U3Vw
         HVwpDQclgbjSStNaXvcfJIs7mvspSbknvidyrb9wNYutkyGgWxRF+DI0WseWXWYYPnvY
         atRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150986; x=1790755786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UijdBnn6WOiz2IYzdQK3bkuIV6Ami5lrn2usdhsplRI=;
        b=fkqjyfADIxjzB9hNd8q3xof0Rpy4D5oQlT0eaK0PGWJVP1SMSypL86XIjdIRMMN+PH
         Iy8u/k8p5TYIReBRjBvAurvSISJ/s6pqTiDBB7ypoaM6W0A4gF8h8P1hRRiqKNqqi6cg
         8FGLR3mvCCy9GWyBXMh04M1LAXw1kDOaviQRybOEwGSbrpBcgrgC/6nn5KiyH3puYGmE
         yhuer2o4Fr/bCpfgOmlnNdXLDPwLiKI5HFNlcBk4b1VrH8/I2lM1gyWyIUqYnuEByye8
         OPwtWf6va/gLHuo406BrPz7sBnSWk4QV6ZKxwuz4/7PedbBRdDuUk1NPPonteKg8wi8C
         UokA==
X-Gm-Message-State: AFuF++lQIMBqf+/CdgYvsz1MtFN7CW03CMtYwkv0tTwGDL5+hatF8b8G
	Rfy+0TMAsD0xlhqEVRt1Znl3DU2d/SFsM+5SJarBTi0JPRaPXtF65sFvPFkRMQ==
X-Gm-Gg: AYBFou1xG9ajRm1OMLkSzrmz077rOMf7N8V7/N1YN9Zefk4vdKTyfW/2xwQ3cEt9fy1
	WqUrsWCXbdNntajqaqxFy90+jjnqccsnNmP/OdXmshfJ5IWt3ok0dcXmK5GmKIt7dwbyuhs9+3U
	B8eP4D+Nkk4FJjSx6FNsvY6H1PI46KTvWo6X1v+9oeQzwVYb+fkp1+jAYiXG4WbHyl+KP3So3o6
	Nq89LQoMlzzNmHAbb8nny5GEvQfESeDgBhOUuRrnf5NeCS0YndyBwOJrjb1e4Q540kSQMUNLj8c
	aDIaMdYtGgZh0gILXoAbWQ7QKiKCrCh9QrIkTMYZApONXfsQGG8npANm+W7hREVUGzQRCumK9k+
	dsyA/FR14Tj+AJB+BQzsaYsRLvAuCkoT8p3kCp8JklRehtL8phfgkToDPb2xyKoqga6HudA1ToR
	+htYvq8WPi7QB/gYIUqAyX96j8WQhp1ywQBPU8GNMqz7t743WpcnPvHyzwQen3lUnWfKNtAPZG7
	zbdoobHjQG6k2nzfRkL/7bd/Nrrvc1os0NDYH42NF8ymRavTn3xJcuXyXJSM5OhjdYt8CrDRHFz
	RY+rUW7SYj1msGtBolgjKclC5CFEgugv9C6Bn0UYDgUVRPF/GF/m1Z06MpxMQwSXPY8mjRUZ7oO
	h+/dufuik
X-Received: by 2002:a05:6000:220b:b0:487:219e:5e20 with SMTP id ffacd0b85a97d-488670a04damr2939115f8f.51.1790150985480;
        Wed, 23 Sep 2026 01:09:45 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm5037470f8f.2.2026.09.23.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:09:44 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/3] Standardize early option scanning
Date: Wed, 23 Sep 2026 10:09:25 +0200
Message-ID: <20260923080928.1534413-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of commands perform an early scan of their arguments to look
for specific flags or structural separators (like `--`).

These hand-rolled early scans are often fragile. They especially fail
to account for options that take their value as a separate
argument. This leads to disagreements between the early scan and the
actual parse_options() pass. For example, the early scanner might miss
a special option entirely, or mistakenly treat an option's value as
the `--` path separator.

To allow these commands to safely skip option values during their
early scans, this series introduces a new "early-scan" sub-API into
the existing "parse-options" API.

This is deliberately implemented as a new simple and fast scan, which
has some limitations, instead of a full refactor and reuse of the
parse_options() code, because the limitations are not very significant
in practice, while a full refactor and reuse of the parse_options()
code would be much more complex.

The current limitations of the new early scan code are:

 1. short options are ignored,

 2. an option with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT never
 has the following argument skipped as its value. This matches
 parse_options() for PARSE_OPT_OPTARG, but not for
 PARSE_OPT_LASTARG_DEFAULT, which consumes that argument when the
 option isn't the last one,

 3. negated options ("--no-...") are not matched,

 4. abbreviated options will not be matched,

 5. subcommands (OPTION_SUBCOMMAND) are never matched, so an option
 marked with PARSE_OPT_EARLY cannot be a subcommand,

 6. aliases (OPTION_ALIAS) are not resolved to the option they stand
 for, so the separate value of an alias of an option taking a value
 is not skipped.

Note that while the others could be real issues for some commands,
"3. negated options" and "5. subcommands" are not practical issues
because negated options never consume a separate argument, and
parse_options() doesn't match subcommands as "--<name>" either.

The early scan is performed by a new early_scan_options() function
which takes a regular `const struct option *options` array as
argument.

This requires that the command already uses `struct option` and the
parse-options API to parse its arguments. As the majority of commands
performing an early scan don't use the parse-options API yet, they
will have to be converted to use it before they can use
early_scan_options().

In this series, only `git fast-import` is converted to the early-scan
API, which fixes a bug as:

  `git fast-import --depth 5 --allow-unsafe-features`

silently ignored `--allow-unsafe-features`, refusing unsafe features
from the stream.

Overview of the patches
=======================

 - Patch 1/3 refactors some existing code into a new
   parse_options_takes_argument() helper that will be used in the next
   patch.

 - Patch 2/3 introduces early_scan_options(), the early scanner that
   will be used instead of hand-rolled ones, along with its
   infrastructure.

 - Patch 3/3 uses early_scan_options() to fix the early scan for
   `--allow-unsafe-features` in `git fast-import`.

Changes since v1
================

Thanks to Junio who reviewed v1.

There are a lot of important changes since v1:

 - Now the early-scan API requires the parse-options API to be already
   used, and early_scan_options() accepts a regular `struct option *`
   instead of a dedicated `struct early_scan_option *`.

   (In v1, early_scan_options() took a dedicated
   `struct early_scan_option *` array, which the caller either wrote by
   hand, when it didn't use the parse-options API, or derived from its
   `struct option *` array with early_scan_options_from_options().)

   This simplifies things significantly, but requires that code doing
   an early scan be ported to the parse-options API if it doesn't use
   it yet.

 - bisect_start() and cmd_rev_parse() are not converted anymore to the
   new early-scan API. Converting them didn't bring much value, and
   they can still be converted in the future after they are converted
   to the parse-options API.

 - Options that should be looked up during the early scan are now
   marked with a new PARSE_OPT_EARLY flag (which is documented with
   the other per-option flags in
   "Documentation/technical/api-parse-options.adoc") in
   `struct option`.

   (In v1, a `wanted` flag in `struct early_scan_option` was used for
   this, and this flag could be set by passing a `const char **wanted`
   to early_scan_options_from_options().)

 - parse_options_check() now rejects PARSE_OPT_EARLY on an option
   without a long name, and on a subcommand, as the scan can never
   match either of them.

   (In v1, early_scan_options_from_options() raised a BUG() when a
   name in `wanted` was not in the option array.)

 - The EARLY_SCAN_STOP_AT_DASHDASH flag has been removed, and the scan
   now always stops at both `--` and `--end-of-options`, as
   parse_options() always stops parsing options at them whatever its
   flags. (PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
   decide if the terminator is left in argv, not if it terminates.)

   (In v1, the scan walked past `--end-of-options`, so
   `git fast-import --end-of-options --allow-unsafe-features` allowed
   unsafe stream features before parse_options() rejected the command
   line.)

 - "--<name>=<value>" is now matched for any option that is not
   PARSE_OPT_NOARG, instead of only for options taking a separate
   value. Whether the next argument is consumed still depends on
   parse_options_takes_argument().

   (In v1, an option with PARSE_OPT_OPTARG or
   PARSE_OPT_LASTARG_DEFAULT was missed entirely in that form, while
   parse_options() accepts it.)

 - The different patches changed in the following way:

   - Patch 4/6 is now patch 1/3.

   - Patches 1/6 and 5/6 have been squashed and heavily modified to
     create patch 2/3.

   - Patches 2/6 and 3/6 have been removed as bisect_start() and
     cmd_rev_parse() are not converted anymore to the new early-scan
     API.

   - Patch 6/6 is now patch 3/3.

CI tests:
=========

They all pass, see:

https://github.com/chriscool/git/actions/runs/35749173266

Range-diff since v1
===================

4:  1ea80545c4 = 1:  32adff46ce parse-options: add parse_options_takes_argument()
1:  acb475f98d ! 2:  82569fa602 parse-options: add early_scan_options()
    @@ Commit message
         commands get this wrong, as they just walk their arguments comparing
         them to the few option names they care about.
     
    -    Let's add early_scan_options() to help with this. Its callers describe
    -    the options to look for, but also the ones that merely have to be
    -    skipped along with their value, so that the scan can walk the arguments
    -    without being fooled by option values.
    +    Let's add early_scan_options() to help with this. It walks the
    +    arguments using the very same `struct option` array that the command
    +    already passes to parse_options(), and uses the
    +    parse_options_takes_argument() helper added in a previous commit, so
    +    that the scan and the actual parsing agree on which options take a
    +    value.
     
    -    Note that abbreviated options are deliberately not recognized, as a
    -    scan cannot know about the options it hasn't been told about, and would
    -    then resolve abbreviations differently from the actual option parsing.
    +    The options the caller wants to be told about are marked with a new
    +    PARSE_OPT_EARLY flag, so that nothing has to be spelled out a second
    +    time, and so that the mark cannot drift away from the option it refers
    +    to.
     
    -    So users must spell these specific options in full. This restriction
    -    could be lifted in the future though, once the scanner is adapted to
    -    accept a command's full option array, as this would give it the
    -    complete context needed for safe abbreviation matching.
    +    Using a per-option flag for this is not new as that flag space already
    +    holds flags that the parsing loop itself ignores, like
    +    PARSE_OPT_NOCOMPLETE and PARSE_OPT_COMP_ARG, which only the completion
    +    helper looks at, or PARSE_OPT_HIDDEN and PARSE_OPT_LITERAL_ARGHELP,
    +    which only the usage output looks at.
    +
    +    The scan is deliberately kept much simpler than parse_options(),
    +    instead of teaching the latter to perform a side effect free "dry
    +    run". Such a dry run would have to avoid writing through `opt->value`,
    +    calling option callbacks, dying on an invalid value, handling `--help`
    +    and tracking command mode conflicts, so it would be a much larger
    +    refactoring. If parse_options() learns to do it in the future though,
    +    the commands converted now would keep both their option array and their
    +    PARSE_OPT_EARLY marks, so their conversion would not have to be redone.
    +
    +    One consequence of staying simple is that abbreviated options are
    +    still not matched, even though the scan is now given the command's
    +    full option array. Resolving them the way parse_options() does would
    +    mean duplicating the ambiguity detection that parse_long_opt()
    +    performs. So the scan can fail to see an option that parse_options()
    +    would accept, and its callers have to cope with that, typically by
    +    erring on the safe side. This and the other differences with
    +    parse_options() are documented in "parse-options.h".
    +
    +    In practice, despite these limitations, early scans using
    +    early_scan_options() should still be safer and cleaner than the
    +    ad-hoc hand-rolled scans they are meant to replace, which don't know
    +    about option values at all and therefore disagree with
    +    parse_options() in ways that create plain bugs.
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    + ## Documentation/technical/api-parse-options.adoc ##
    +@@ Documentation/technical/api-parse-options.adoc: are the bitwise-or of:
    + 	Internal flag, set on options that were expanded from a
    + 	configured alias. It should not be set by callers.
    + 
    ++`PARSE_OPT_EARLY`::
    ++	Report this option to `early_scan_options()`, which looks at a
    ++	few options before parsing the command line for real. Ignored
    ++	by `parse_options()` itself.
    ++
    + `PARSE_OPT_NOCOMPLETE`::
    + 	Do not offer this option for completion.
    + 
    +
      ## parse-options.c ##
    +@@ parse-options.c: static void parse_options_check(const struct option *opts)
    + 		     opts->long_name))
    + 			optbug(opts, "uses feature "
    + 			       "not supported for dashless options");
    ++		if ((opts->flags & PARSE_OPT_EARLY) && !opts->long_name)
    ++			optbug(opts, "uses PARSE_OPT_EARLY, which needs a long name");
    + 		if (opts->type == OPTION_SET_INT && !opts->defval &&
    + 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
    + 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
    +@@ parse-options.c: static void parse_options_check(const struct option *opts)
    + 		case OPTION_SUBCOMMAND:
    + 			if (!opts->value || !opts->subcommand_fn)
    + 				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
    ++			if (opts->flags & PARSE_OPT_EARLY)
    ++				optbug(opts, "OPTION_SUBCOMMAND does not support PARSE_OPT_EARLY");
    + 			if (!subcommand_value)
    + 				subcommand_value = opts->value;
    + 			else if (subcommand_value != opts->value)
     @@ parse-options.c: int parse_options(int argc, const char **argv,
      	return parse_options_end(&ctx);
      }
      
     +/*
    -+ * Look for `arg` among `options`. On success, return the matching option
    ++ * Look for `arg` among `option`. On success, return the matching option
     + * and set `value` to the value stuck to it, if any, or to NULL.
     + */
    -+static const struct early_scan_option *
    -+find_early_scan_option(const char *arg,
    -+		       const struct early_scan_option *options,
    -+		       const char **value)
    ++static const struct option *find_early_scan_option(const char *arg,
    ++						   const struct option *option,
    ++						   const char **value)
     +{
     +	if (!skip_prefix(arg, "--", &arg))
     +		return NULL;
     +
    -+	for (; options->name; options++) {
    ++	for (const struct option *opt = option; opt->type != OPTION_END; opt++) {
     +		const char *rest;
     +
    -+		if (!skip_prefix(arg, options->name, &rest))
    ++		if (opt->type == OPTION_SUBCOMMAND)
    ++			continue;
    ++		if (!opt->long_name)
    ++			continue;
    ++		if (!skip_prefix(arg, opt->long_name, &rest))
     +			continue;
    ++
     +		if (!*rest) {
     +			*value = NULL;
    -+			return options;
    ++			return opt;
     +		}
    -+		/* Only an option taking a value can be stuck to one. */
    -+		if (*rest == '=' && options->takes_value) {
    ++		/* Only an option that can take a value may have one stuck to it. */
    ++		if (*rest == '=' && !(opt->flags & PARSE_OPT_NOARG)) {
     +			*value = rest + 1;
    -+			return options;
    ++			return opt;
     +		}
     +	}
     +
    @@ parse-options.c: int parse_options(int argc, const char **argv,
     +}
     +
     +int early_scan_options(int argc, const char **argv,
    -+		       const struct early_scan_option *options,
    ++		       const struct option *option,
     +		       enum early_scan_flags flags,
     +		       early_scan_fn *fn, void *data)
     +{
     +	for (int i = 0; i < argc; i++) {
     +		const char *arg = argv[i];
     +		const char *value;
    -+		const struct early_scan_option *opt;
    ++		const struct option *opt;
     +		int pos = i;
     +
    -+		if ((flags & EARLY_SCAN_STOP_AT_DASHDASH) &&
    -+		    !strcmp(arg, "--"))
    ++		/*
    ++		 * parse_options() always stops parsing options at these,
    ++		 * whatever its flags, so nothing after them is an option.
    ++		 */
    ++		if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
     +			return i;
     +
    -+		opt = find_early_scan_option(arg, options, &value);
    ++		opt = find_early_scan_option(arg, option, &value);
     +		if (!opt) {
     +			if ((flags & EARLY_SCAN_STOP_AT_NON_OPTION) &&
     +			    (*arg != '-' || !arg[1]))
    @@ parse-options.c: int parse_options(int argc, const char **argv,
     +		 * value and it has to be skipped so that it isn't
     +		 * taken for an option itself.
     +		 */
    -+		if (opt->takes_value && !value && i + 1 < argc)
    ++		if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
     +			value = argv[++i];
     +
    -+		if (opt->wanted && fn(opt, value, pos, data))
    ++		if (opt->flags & PARSE_OPT_EARLY && fn(opt, value, pos, data))
     +			return i;
     +	}
     +
    @@ parse-options.c: int parse_options(int argc, const char **argv,
      	const char *s;
     
      ## parse-options.h ##
    +@@ parse-options.h: enum parse_opt_option_flags {
    + 	PARSE_OPT_NODASH = 1 << 5,
    + 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
    + 	PARSE_OPT_FROM_ALIAS = 1 << 7,
    ++	PARSE_OPT_EARLY = 1 << 8,	/* only for early_scan_options() */
    + 	PARSE_OPT_NOCOMPLETE = 1 << 9,
    + 	PARSE_OPT_COMP_ARG = 1 << 10,
    + 	PARSE_OPT_CMDMODE = 1 << 11,
     @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
      		BUG("option callback expects an argument"); \
      } while(0)
    @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const ch
     + * whether a repository is needed at all.
     + *
     + * Such an early scan has to know which options take their value as a
    -+ * separate argument, or it could mistake such a value for an option. The
    -+ * `struct early_scan_option` array passed to early_scan_options() below
    -+ * describes the options to look for, as well as the ones that only need
    -+ * to be skipped along with their value.
    ++ * separate argument, or it could mistake such a value for an
    ++ * option. The functions below allow performing such early scans
    ++ * without being fooled by option values.
     + */
    -+struct early_scan_option {
    -+	const char *name; 	/* Option name, without the leading dashes */
    -+	unsigned takes_value:1; /* "--option=value" or "--option value" expected? */
    -+	unsigned wanted:1;      /* Report option to callback? */
    -+};
    -+
    -+#define EARLY_SCAN_SKIP_VALUE(n) { .name = (n), .takes_value = 1 }
    -+#define EARLY_SCAN_WANT(n) { .name = (n), .wanted = 1 }
    -+#define EARLY_SCAN_WANT_VALUE(n) { .name = (n), .takes_value = 1, .wanted = 1 }
    -+#define EARLY_SCAN_END() { NULL }
     +
     +/*
     + * Called by early_scan_options() for each argument matching a
    -+ * `struct early_scan_option` that has its `wanted` bit set.
    ++ * `struct option` with PARSE_OPT_EARLY set.
     + *
     + * `option` is the matching option, `value` its value or NULL if it
     + * doesn't take one, and `pos` the index of the option in argv.
     + *
     + * Returning a non-zero value stops the scan.
     + */
    -+typedef int early_scan_fn(const struct early_scan_option *option,
    -+			  const char *value, int pos, void *data);
    ++typedef int early_scan_fn(const struct option *option, const char *value,
    ++			  int pos, void *data);
     +
     +enum early_scan_flags {
    -+	EARLY_SCAN_STOP_AT_DASHDASH = 1 << 0, /* Stop at "--" */
    -+	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 1,
    ++	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 0, /* Stop at any non option */
     +};
     +
     +/*
    -+ * Scan `argv` for the options described by `options`, calling `fn`
    -+ * for each of those that are `wanted`. `argv` is not modified.
    ++ * Scan `argv` for the options described by `option`, calling `fn` for
    ++ * each of those that have PARSE_OPT_EARLY set. `argv` is not
    ++ * modified.
     + *
    -+ * `fn` may be NULL when no option is `wanted`, which is useful to only
    -+ * find out where the scan stops.
    ++ * `fn` may be NULL when no option has PARSE_OPT_EARLY set, which is
    ++ * useful to only find out where the scan stops.
     + *
    -+ * Note that abbreviated options are not recognized, as a scan cannot
    -+ * know about the options it hasn't been told about, and would then
    -+ * resolve abbreviations differently from the actual option parsing.
    ++ * The scan always stops at "--" and at "--end-of-options", as
    ++ * parse_options() always stops parsing options there too, whatever its
    ++ * flags. PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
    ++ * decide if the terminator is left in argv, not if it terminates.
     + *
     + * Returns the index at which the scan stopped, which is `argc` when the
     + * whole array was scanned.
    ++ *
    ++ * This scan is for now deliberately much simpler than
    ++ * parse_options(), so it differs from it in the following ways:
    ++ *
    ++ *  - Only the long form of an option is matched, and it has to be
    ++ *    spelled in full: short options and abbreviations are ignored.
    ++ *
    ++ *  - Negated forms ("--no-<name>") are not matched. This is harmless,
    ++ *    as they never take a value to skip.
    ++ *
    ++ *  - Options with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT are
    ++ *    treated as not taking a separate value.
    ++ *
    ++ *  - OPTION_SUBCOMMAND entries are skipped.
    ++ *
    ++ *  - OPTION_ALIAS entries are not resolved to the option they stand
    ++ *    for.
    ++ *
    ++ * So the scan can fail to see an option that parse_options() would
    ++ * accept, and callers have to cope with that, typically by erring on
    ++ * the safe side.
     + */
     +int early_scan_options(int argc, const char **argv,
    -+		       const struct early_scan_option *options,
    ++		       const struct option *option,
     +		       enum early_scan_flags flags,
     +		       early_scan_fn *fn, void *data);
     +
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
      	return parse_subcommand__cmd(argc, argv, test_flags);
      }
     +
    -+static int show_early_option(const struct early_scan_option *opt,
    -+			     const char *value, int pos, void *data UNUSED)
    ++static int show_early_option(const struct option *opt, const char *value,
    ++			     int pos, void *data UNUSED)
     +{
    -+	printf("found: %s at %d", opt->name, pos);
    ++	printf("found: %s at %d", opt->long_name, pos);
     +	if (value)
     +		printf(" value: %s", value);
     +	putchar('\n');
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
     +
     +int cmd__early_scan_options(int argc, const char **argv)
     +{
    -+	static const struct early_scan_option options[] = {
    -+		EARLY_SCAN_WANT("wanted"),
    -+		EARLY_SCAN_WANT_VALUE("wanted-value"),
    -+		EARLY_SCAN_SKIP_VALUE("skipped-value"),
    -+		EARLY_SCAN_END()
    ++	char *a_string = NULL;
    ++	int an_int = 0, a_bool = 0, a_short = 0;
    ++
    ++	const struct option option[] = {
    ++		OPT_GROUP("early scan test options"),
    ++		OPT_BOOL_F(0, "wanted", &a_bool,
    ++			   "wanted option taking no value",
    ++			   PARSE_OPT_EARLY),
    ++		OPT_STRING_F(0, "wanted-value", &a_string, "str",
    ++			     "wanted option taking a value",
    ++			     PARSE_OPT_EARLY),
    ++		OPT_STRING(0, "skipped-value", &a_string, "str",
    ++			   "option whose value has to be skipped"),
    ++		OPT_INTEGER(0, "number", &an_int,
    ++			    "option taking an integer value"),
    ++		OPT_STRING_F(0, "optarg", &a_string, "str",
    ++			     "option with an optional value",
    ++			     PARSE_OPT_OPTARG),
    ++		OPT_STRING_F(0, "lastarg", &a_string, "str",
    ++			     "option with a last argument default",
    ++			     PARSE_OPT_LASTARG_DEFAULT),
    ++		OPT_STRING_F(0, "early-optarg", &a_string, "str",
    ++			     "early option with an optional value",
    ++			     PARSE_OPT_EARLY | PARSE_OPT_OPTARG),
    ++		OPT_STRING_F(0, "early-lastarg", &a_string, "str",
    ++			     "early option with a last argument default",
    ++			     PARSE_OPT_EARLY | PARSE_OPT_LASTARG_DEFAULT),
    ++		OPT_BOOL('s', NULL, &a_short, "short only option"),
    ++		OPT_END()
     +	};
    ++
     +	enum early_scan_flags flags = 0;
     +	int stopped;
     +
     +	while (argc > 1 && *argv[1] == '-') {
    -+		if (!strcmp(argv[1], "--stop-at-dashdash"))
    -+			flags |= EARLY_SCAN_STOP_AT_DASHDASH;
    -+		else if (!strcmp(argv[1], "--stop-at-non-option"))
    ++		if (!strcmp(argv[1], "--stop-at-non-option"))
     +			flags |= EARLY_SCAN_STOP_AT_NON_OPTION;
     +		else
     +			break;
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
     +		argv++;
     +	}
     +
    -+	stopped = early_scan_options(argc - 1, argv + 1, options, flags,
    -+				    show_early_option, NULL);
    ++	stopped = early_scan_options(argc - 1, argv + 1, option, flags,
    ++				     show_early_option, NULL);
     +	printf("stopped at: %d of %d\n", stopped, argc - 1);
     +
     +	return 0;
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'early_scan_options() can stop at "--"' '
    -+	test-tool early-scan-options --stop-at-dashdash -- --wanted >actual &&
    ++test_expect_success 'early_scan_options() always stops at "--"' '
    ++	test-tool early-scan-options -- --wanted >actual &&
     +	cat >expect <<-\EOF &&
     +	stopped at: 0 of 2
     +	EOF
     +	test_cmp expect actual &&
    -+	test-tool early-scan-options --stop-at-dashdash \
    -+		--skipped-value -- --wanted >actual &&
    ++	test-tool early-scan-options --stop-at-non-option -- --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --skipped-value -- --wanted >actual &&
     +	cat >expect <<-\EOF &&
     +	found: wanted at 2
     +	stopped at: 3 of 3
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'early_scan_options() always stops at "--end-of-options"' '
    ++	test-tool early-scan-options --end-of-options --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --stop-at-non-option \
    ++		--end-of-options --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'early_scan_options() can stop at a non-option' '
     +	test-tool early-scan-options --stop-at-non-option \
     +		arg --wanted >actual &&
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'early_scan_options() takes values from struct option' '
    ++	test-tool early-scan-options --number --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --number=5 --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() does not skip an optional value' '
    ++	test-tool early-scan-options --optarg --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --lastarg --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() matches a stuck optional value' '
    ++	test-tool early-scan-options --early-optarg=one >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: early-optarg at 0 value: one
    ++	stopped at: 1 of 1
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --early-lastarg=two >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: early-lastarg at 0 value: two
    ++	stopped at: 1 of 1
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() does not take a separate optional value' '
    ++	test-tool early-scan-options --early-optarg --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: early-optarg at 0
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --early-lastarg --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: early-lastarg at 0
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() ignores options without a long name' '
    ++	test-tool early-scan-options -s --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() ignores negated options' '
    ++	test-tool early-scan-options --no-wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 1 of 1
    ++	EOF
    ++	test_cmp expect actual
    ++'
     +
      test_done
2:  2adb3b6229 < -:  ---------- bisect: fix "--" detection when a term name is "--"
3:  8bfbd627a8 < -:  ---------- rev-parse: fix "--" detection when it is an option value
5:  69cb1339c6 < -:  ---------- parse-options: build early scan options from a struct option array
6:  a55b275327 ! 3:  8e5092d421 fast-import: use early_scan_options() for --allow-unsafe-features
    @@ Commit message
         sees the option, so unsafe "feature" commands from the stream are
         refused even though the option was given.
     
    -    Let's fix this by building the options for the scan from the same
    -    `struct option` array that parse_options() uses, so that both agree on
    -    which options take a value.
    +    Let's fix this by using early_scan_options(), which scans the very
    +    same `struct option` array that parse_options() uses, so that both
    +    agree on which options take a value, and by marking
    +    `--allow-unsafe-features` with PARSE_OPT_EARLY so that the scan
    +    reports it.
     
         Note that the scan still only matches the exact option spelling, while
         parse_options() also accepts unambiguous abbreviations, so the two still
    @@ Documentation/git-fast-import.adoc: fast-import stream! This option is enabled a
     -them, while `--allow-unsafe-features --depth 5` and
     -`--depth=5 --allow-unsafe-features` allow them.
     +Note that this option has to be spelled in full for the unsafe
    -+`feature` commands in the stream to be allowed. So while
    -+`--allow-unsafe` is accepted as an unambiguous abbreviation of this
    -+option, it still refuses them.
    ++`feature` commands in the stream to be allowed. So `--allow-unsafe`
    ++is accepted as an unambiguous abbreviation of this option, but the
    ++unsafe `feature` commands are still refused.
      
      `--signed-tags=<mode>`::
      	Specify how to handle signed tags. Behaves in the same way as
    @@ builtin/fast-import.c: static int option_parse_quiet(const struct option *opt UN
      	return 0;
      }
      
    -+/*
    -+ * The only option the early scan below is interested in, as it decides
    -+ * whether unsafe "feature" commands from the stream are allowed.
    -+ */
    -+static const char *early_wanted[] = { "allow-unsafe-features", NULL };
    -+
    -+static int option_parse_early_allow_unsafe(
    -+		const struct early_scan_option *opt UNUSED,
    -+		const char *value UNUSED, int pos UNUSED, void *data)
    ++static int option_parse_early_allow_unsafe(const struct option *option,
    ++					   const char *value UNUSED,
    ++					   int pos UNUSED, void *data)
     +{
     +	struct fast_import_state *state = data;
     +
    -+	state->allow_unsafe_features = 1;
    ++	if (!strcmp(option->long_name, "allow-unsafe-features"))
    ++		state->allow_unsafe_features = 1;
     +	return 0;
     +}
     +
      int cmd_fast_import(int argc,
      		    const char **argv,
      		    const char *prefix,
    - 		    struct repository *repo)
    - {
    - 	struct fast_import_state state;
    -+	struct early_scan_option *early;
    - 
    - 	struct option fast_import_options[] = {
    - 		OPT_GROUP(N_("Common")),
    +@@ builtin/fast-import.c: int cmd_fast_import(int argc,
    + 		OPT_HIDDEN_GROUP(N_("Advanced")),
    + 		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
    + 			   N_("allow unsafe mark commands from the stream"),
    +-			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
    ++			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG | PARSE_OPT_EARLY),
    + 		OPT_CALLBACK_F(0, "export-pack-edges", &state, N_("file"),
    + 			       N_("dump edge commits to <file>"),
    + 			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
     @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      	 * line to override stream data). But we must do an early parse of any
      	 * command-line options that impact how we interpret the feature lines.
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
     -		if (!strcmp(arg, "--allow-unsafe-features"))
     -			state.allow_unsafe_features = 1;
     -	}
    -+	early = early_scan_options_from_options(fast_import_options,
    -+						early_wanted);
    -+	early_scan_options(argc - 1, argv + 1, early,
    -+			   EARLY_SCAN_STOP_AT_DASHDASH |
    ++	early_scan_options(argc - 1, argv + 1, fast_import_options,
     +			   EARLY_SCAN_STOP_AT_NON_OPTION,
     +			   option_parse_early_allow_unsafe, &state);
    -+	free(early);
      
      	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
      	for (unsigned int i = 0; i < (cmd_save - 1); i++)

Christian Couder (3):
  parse-options: add parse_options_takes_argument()
  parse-options: add early_scan_options()
  fast-import: use early_scan_options() for --allow-unsafe-features

 Documentation/git-fast-import.adoc            |  10 +-
 .../technical/api-parse-options.adoc          |   5 +
 builtin/fast-import.c                         |  38 ++--
 parse-options.c                               | 116 ++++++++++--
 parse-options.h                               |  82 +++++++++
 t/helper/test-parse-options.c                 |  62 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 173 ++++++++++++++++++
 t/t9300-fast-import.sh                        |  14 ++
 10 files changed, 466 insertions(+), 36 deletions(-)


base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.56.0.rc2

