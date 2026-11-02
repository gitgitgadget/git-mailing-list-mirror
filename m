Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632524;
	b=0ZphY8oo/HufWZLkiHHJTWLMxgCaIfYxOBERuhR5vXaJ25iYozYAb8OPDNYfOdvS/xho
	 5NRz0lY9n9maAZr0Rvlin3RgsNPzbLCD6dSd2RN+zX9KTXMQJwBS+V0ZV2j8JQrICY+rD
	 bCEEko+DszlaGUGYwqjZ6T0oDnCIj31/NbydM9yTS9mBej3+KK0Z4Zq46cijU5Wvqo0kH
	 KC5mt4vwDcLpbgb/3kDu0hqPUUrbcqUV8PTGf5/N1toic5aqbFW+XDkL1m87nkwH2xSN7
	 XvCnhbJ/5lWltpY5J0FhzUNOVNnQjqho+11k/o3xpU/8m9ka8Sr4JxAiKJI76kQ6jiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z1QEJw8dMvWu1RH2yAPNw+2dWpH9cLinbJfyFG6oI7E=;
	b=0zv1+MyaryVDi1AHptkr54N9X3i4jSulcH2dBKDvjUXmCCO1obO7Bi6cXLg1ec9Yoe5X
	 Mv0WqyBDoNKrOqx44m5YpGVLVuSYoUWbO+WieNiY/OFWYFbcJ4NJArCiKNdc5F5V1lmrR
	 dAawNcgPiWHiA7aBUaf1NzvM83DIQ13fDxetTwLBbCm7/iAE88O08Sc4dLE8M3TewBSOF
	 G6DpwaMs9nnat4iSWLE9zmd+HxrSaFQN+fgkDQ5d0wVRMskYzdrHtLRzf4xzahTSXQyDB
	 SkREtIKRYuYcl+HRPS6KqEvZVE7AYbmU9Ts43/Q8yEt0R2cLTE4UbOloY8Cub4T6ucA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WsOsf+Ym;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7C607A8AA
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB7C607A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WsOsf+Ym
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so19509405e9.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632522; x=1794237322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1QEJw8dMvWu1RH2yAPNw+2dWpH9cLinbJfyFG6oI7E=;
        b=WsOsf+YmJ3a3mG4TsLdPvoaiMKxzh+ZgnAi6U7bYT6wYF6QIPjjQvU0J1dlVwsbSZu
         36/idln2EMM7EdmOiDX+d6dztOgBzIrJxkBkXw3lz9VS5xuVA5wdOn5LTVJq872m+rwN
         5vS8WfeQY4NcPMENTfBVO8s9dZKZabfTSOA6TsFtYnNy/r9xiNsDqVcfuQYs3BQSyfjZ
         sfKPESsmSdSbJhUHNrgJHE7DXiN1DTJ+tA6Jib54/CE62fXSNU+/hVcO7HlffwRf60fu
         +x5bTjztNxcU3BwXyIYYgZjB3tYehpqzBhvYLHnzp2GEleMuU+0za1RH6IPBmar0RCR5
         aDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632522; x=1794237322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1QEJw8dMvWu1RH2yAPNw+2dWpH9cLinbJfyFG6oI7E=;
        b=tI+yWkeoilcQ6ti0hdJcF+YLt8cIl7mU1qPG8wZeFX04gLsIWw0CUlV92FNFBWFfr3
         pAAAZ+plkJ9VsZcWmH8RFLFpwYNYaAu5XEkQSFT1SHAMXQZWt3RtNoyDFoTd6XraCVS3
         3mkBLAz0Ohi9k2R+SjLKuLmv9PuKNXSCjlWwAHDrQyYtbOrd/a5oW7batIte7+twDol+
         tiZSogiVHXvmQjEpqi3rkfKVqNKOxqb28v81VIvacT0bzqE/B9ZLGYPShUmFIER0ZjTT
         66PpIyrqzSsD6qyOG4rmMS02vkr3A9hMIJkYh05gpWibIBJ2lgQCxIj7X6wQX/cLIj9T
         WygA==
X-Gm-Message-State: AFq9FYLPGOXPicpeQiejz48vmvH/x/WKOpHxl50b/Lti3QM6daUQo3SR
	YNrTnhRHaAOGV0UfLo9/k/qOs+bAOvKPEAzPOmwIB1QAcjJGqm5vHy4wu1ta6g==
X-Gm-Gg: AYBFou2+aDahE2K/5jA61+4z5l95FDdWTYvnFwLmwCaCRxOIW+rX4TwlDYWwIXcpDn5
	MWvurIG/Ukf+mBAqyJzyARC8zJIjLWQjlApVZ5OnksQVNeCxVWD2hHsLgeVpV8yDzKXZBVWF7e9
	bQP/6pjV1k2O1OS+OV0CV9b5NhH3c5avVFS3fWDcPy/Lh5RpH+ZZuVRLnGSxsoTNA5aFKyyoGF6
	xegkyJ92keQX8fbm24mFFSYuSE4dc59kr6wbTc5jLKiTNbP4U7SB0UKA8cq6wsnd6eCUOMSYF04
	bWsN5/+kGyoVXeFd1cQHYSOQTz5UusCX30ITzN5TnEGqKqPgqAv4NHhGJyaBHB/gP6wlK85OEld
	fkMA1L2TDVgwNgBScz3JwDBd1xC7iCUI5TT6cjXS+EKoD14ln+yEPSFs3aer2vh+gMCatZD1z/n
	WW8/hkzxEUCCoZZ89NVPQASGyRrbV4vklT/o/NRvOhKA86Ng1r7JVWHhOi5EUmTCRQJsJyEzuEV
	s+8e4nInxtcbPeitniIq4zVjYnruU/GvT+ytrFk7UfwRC+7HnFThnaWeveBwCvUyLNqI044oS9X
	aT4Gu+PLOhTGIpIoaw4cGPGOmsUpIfY2ungsU08cP5wW5AfzsEkFzEBLFdF3a57ewHsp/9wAJfD
	KNGBM9t960sdOeFjkza4iq5d5lldf9m0e2ZwbF9kCbPvdkSudXYdfOB+XPPa14EzbovCljNjEdI
	9Ce3BmVZJiOeQlYM4/sTHv+QVZ4p93ueAlvOJOhXQ=
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4ac16fa4dadmr238577235e9.7.1793632521661;
        Mon, 02 Nov 2026 07:15:21 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm21851553f8f.34.2026.11.02.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:15:20 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Cynthia Uche <herroyalpriestess@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/4] Standardize early option scanning
Date: Mon,  2 Nov 2026 16:14:48 +0100
Message-ID: <20261102151447.734680-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.4.gceeb21e89e
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
References: <20261012074413.337183-1-christian.couder@gmail.com>
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

This is deliberately implemented as a new simple and fast scan. A full
'dry run' of parse_options() would have to avoid writing through
`opt->value`, calling callbacks or dying. Instead, the scan reuses
only the long option lookup of parse_options(), and stops when unsure.

This allows negated options ("--no-..."), unambiguous abbreviated
options and aliases to be properly handled. The early scan also agrees
with parse_options() on which options take a value, including those
with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT.

To never misinterpret an option's value as an option though, it stops
at any argument it cannot reliably skip:

 1. a short option, or a bundle of them,

 2. an unknown option, or an ambiguous or disallowed abbreviation,

 3. an option with a low-level callback, as such a callback may
 consume any number of arguments,

 4. an option with a missing or stuck value that parse_options() would
 reject, like "--no-<name>=<value>".

So the scan may fail to see an option that parse_options() would
accept, but it doesn't report an option that parse_options() would
not, and callers can safely err on the side of not having seen it.

This holds as long as the scan is told how the later parse_options()
call treats its arguments: EARLY_SCAN_STOP_AT_NON_OPTION should be
passed when parse_options() stops at non-options or has subcommands,
and the scan should not be used with PARSE_OPT_KEEP_UNKNOWN_OPT, which
disables abbreviations in parse_options() only.

The early scan is performed by a new early_scan_options() function
which takes a regular `const struct option *option` array as
argument.

This requires that the command already uses `struct option` and the
parse-options API to parse its arguments. As the majority of commands
performing an early scan don't use the parse-options API yet, they
will have to be converted to use it before they can use
early_scan_options().

In this series, only `git fast-import` is converted to the early-scan
API. Its hand-rolled scan disagreed with parse_options() in both
directions:

  - `git fast-import --depth 5 --allow-unsafe-features` silently
    ignored `--allow-unsafe-features`, refusing unsafe features from
    the stream, and so did `--allow-unsafe`, its abbreviation,

  - `git fast-import --quiet --export-pack --allow-unsafe-features`
    and `git fast-import --end-of-options --allow-unsafe-features`
    allowed unsafe features from the stream, while parse_options()
    takes `--allow-unsafe-features` as the value of
    `--export-pack-edges` in the first case, and as a non-option
    argument in the second one.

All these cases now agree with parse_options().

Overview of the patches
=======================

 - Patch 1/4 refactors some existing code into a new
   parse_options_takes_argument() helper that will be used in patch
   3/4.

 - Patch 2/4 extracts the long option lookup code from
   parse_long_opt() into a new lookup_long_opt() function, so that the
   function can be reused in the next patch.

 - Patch 3/4 introduces early_scan_options(), the early scanner that
   will be used instead of hand-rolled ones, along with the
   PARSE_OPT_EARLY flag and tests.

 - Patch 4/4 uses early_scan_options() to fix the early scan for
   `--allow-unsafe-features` in `git fast-import`.

Changes since v3
================

Thanks a lot to Junio, Kaartic and Cynthia who reviewed previous
versions.

There are a number of small changes since v3:

 - In patch 2/4, a `switch` statement is now used in parse_long_opt()
   to process the result from lookup_long_opt().

 - In patch 3/4, a parse_options_check() call has been added to
   early_scan_options(), after aliases are preprocessed, so that the
   options are checked before the scan relies on them, rather than
   only later by parse_options().

 - In patch 3/4, in "parse-options.h":

   - the comment before early_scan_fn() has been improved to mention
     that the `option` argument may point into a temporary copy of the
     options, and

   - the end of the comment before early_scan_options() has been made
     clearer and now mentions that EARLY_SCAN_STOP_AT_NON_OPTION is
     safe to use even if PARSE_OPT_STOP_AT_NON_OPTION is not passed to
     parse_options().

 - In patch 4/4:

   - the comment before the call to early_scan_options() in
     cmd_fast_import() has been improved to explain why
     EARLY_SCAN_STOP_AT_NON_OPTION is passed,

   - a new test has been added to check that unsafe "feature" commands
     from the stream are refused when `--allow-unsafe-features` comes
     after a non-option argument, which parse_argv() rejects anyway.

CI tests:
=========

Some failed, see:

https://github.com/chriscool/git/actions/runs/41450228024

but the failures in t5550 and t5540 on ubuntu:rolling and
alpine:latest are unrelated. They come from recent curl stripping
credentials from CURLINFO_EFFECTIVE_URL, and are fixed on master by
jk/http-curl-strip-creds.

Patches
=======

Christian Couder (4):
  parse-options: add parse_options_takes_argument()
  parse-options: extract lookup_long_opt() from parse_long_opt()
  parse-options: add early_scan_options()
  fast-import: use early_scan_options() for --allow-unsafe-features

Diffstat
========

 Documentation/git-fast-import.adoc            |   7 -
 .../technical/api-parse-options.adoc          |   5 +
 builtin/fast-import.c                         |  42 ++-
 parse-options.c                               | 291 +++++++++++++---
 parse-options.h                               | 109 ++++++
 t/helper/test-parse-options.c                 |  96 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 321 ++++++++++++++++++
 t/t9300-fast-import.sh                        |  36 ++
 10 files changed, 844 insertions(+), 65 deletions(-)

Range-diff since v3
===================

1:  57c48ab0fe = 1:  57c48ab0fe parse-options: add parse_options_takes_argument()
2:  38243ce8bf ! 2:  1c001e577e parse-options: extract lookup_long_opt() from parse_long_opt()
    @@ Commit message
         when disallowed only if there is no exact match, and the ambiguity
         error message is unchanged.
     
    +    Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## parse-options.c ##
    @@ parse-options.c: static enum parse_opt_result parse_long_opt(
      	}
      
     -	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
    +-		die("disallowed abbreviated or ambiguous option '%.*s'",
    +-		    (int)(arg_end - arg), arg);
    +-
    +-	if (ambiguous.option) {
    +-		error(_("ambiguous option: %s "
    +-			"(could be --%s%s or --%s%s)"),
    +-			arg,
    +-			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
    +-			ambiguous.option->long_name,
    +-			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
    +-			abbrev.option->long_name);
    +-		return PARSE_OPT_HELP_ERROR;
    +-	}
    +-	if (abbrev.option) {
     +	if (other->option)
     +		return LONG_OPT_AMBIGUOUS;
     +
     +	if (found->option) {
    -+		if (*arg_end)
    + 		if (*arg_end)
    +-			p->opt = arg_end + 1;
    +-		return get_value(p, abbrev.option, abbrev.flags);
     +			*stuck = arg_end + 1;
     +		return LONG_OPT_ABBREV;
    -+	}
    + 	}
    +-	return PARSE_OPT_UNKNOWN;
     +
     +	return LONG_OPT_UNKNOWN;
     +}
    @@ parse-options.c: static enum parse_opt_result parse_long_opt(
     +	enum long_opt_lookup result = lookup_long_opt(p, arg, options,
     +						      &found, &other, &stuck);
     +
    -+	if (result == LONG_OPT_UNKNOWN)
    ++	switch (result) {
    ++	case LONG_OPT_UNKNOWN:
     +		return PARSE_OPT_UNKNOWN;
    -+
    -+	if (disallow_abbreviated_options &&
    -+	    (result == LONG_OPT_ABBREV || result == LONG_OPT_AMBIGUOUS)) {
    -+		const char *arg_end = strchrnul(arg, '=');
    - 		die("disallowed abbreviated or ambiguous option '%.*s'",
    - 		    (int)(arg_end - arg), arg);
    -+	}
    - 
    --	if (ambiguous.option) {
    --		error(_("ambiguous option: %s "
    --			"(could be --%s%s or --%s%s)"),
    --			arg,
    --			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
    --			ambiguous.option->long_name,
    --			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
    --			abbrev.option->long_name);
    -+	if (result == LONG_OPT_AMBIGUOUS) {
    -+		error(_("ambiguous option: %s (could be --%s%s or --%s%s)"), arg,
    -+		      (other.flags & OPT_UNSET) ? "no-" : "", other.option->long_name,
    -+		      (found.flags & OPT_UNSET) ? "no-" : "", found.option->long_name);
    - 		return PARSE_OPT_HELP_ERROR;
    - 	}
    --	if (abbrev.option) {
    --		if (*arg_end)
    --			p->opt = arg_end + 1;
    --		return get_value(p, abbrev.option, abbrev.flags);
    -+
    -+	if (result == LONG_OPT_ABBREV || result == LONG_OPT_EXACT) {
    ++	case LONG_OPT_ABBREV:
    ++	case LONG_OPT_AMBIGUOUS:
    ++		if (disallow_abbreviated_options) {
    ++			const char *arg_end = strchrnul(arg, '=');
    ++			die("disallowed abbreviated or ambiguous option '%.*s'",
    ++			    (int)(arg_end - arg), arg);
    ++		}
    ++		if (result == LONG_OPT_AMBIGUOUS) {
    ++			error(_("ambiguous option: %s "
    ++				"(could be --%s%s or --%s%s)"),
    ++			      arg,
    ++			      (other.flags & OPT_UNSET) ? "no-" : "",
    ++			      other.option->long_name,
    ++			      (found.flags & OPT_UNSET) ? "no-" : "",
    ++			      found.option->long_name);
    ++			return PARSE_OPT_HELP_ERROR;
    ++		}
    ++		/* fallthru */
    ++	case LONG_OPT_EXACT:
     +		p->opt = stuck;
     +		return get_value(p, found.option, found.flags);
    - 	}
    --	return PARSE_OPT_UNKNOWN;
    ++	}
     +
     +	BUG("unknown enum long_opt_lookup value '%d'", result);
      }
3:  c36cae4e44 ! 3:  9e2d7fc5d6 parse-options: add early_scan_options()
    @@ parse-options.c: int parse_options(int argc, const char **argv,
     +	int i;
     +
     +	s.option = real_option ? real_option : option;
    ++	parse_options_check(s.option);
     +
     +	for (i = 0; i < argc; i++)
     +		if (!early_scan_one_option(&s, argc, argv, &i))
    @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const ch
     + * Called by early_scan_options() for each argument matching a
     + * `struct option` with PARSE_OPT_EARLY set.
     + *
    -+ * - `option` is the matching option,
    ++ * - `option` is the matching option, (may point into a temporary
    ++ *   copy of the options, so must not be used after the scan,)
     + * - `value` its value, or NULL if it doesn't take one or if its value
     + *   is optional and wasn't given, as with PARSE_OPT_OPTARG, or with
     + *   PARSE_OPT_LASTARG_DEFAULT when the option is the last argument,
    @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const ch
     + * parse_options() would not, so that callers err on the safe side.
     + *
     + * This requires the scan to be told about the way the later
    -+ * parse_options() call treats its arguments though: callers should
    -+ * pass EARLY_SCAN_STOP_AT_NON_OPTION when parse_options() is called
    -+ * with PARSE_OPT_STOP_AT_NON_OPTION or with subcommands, and should
    -+ * not use the scan when parse_options() is called with
    -+ * PARSE_OPT_KEEP_UNKNOWN_OPT, which disables abbreviations there but
    -+ * not here.
    ++ * parse_options() call treats its arguments though:
    ++ *
    ++ *  - when parse_options() is called with PARSE_OPT_STOP_AT_NON_OPTION
    ++ *    or with subcommands, callers should pass
    ++ *    EARLY_SCAN_STOP_AT_NON_OPTION,
    ++ *
    ++ *  - when parse_options() is called with PARSE_OPT_KEEP_UNKNOWN_OPT,
    ++ *    which disables abbreviations there but not here, callers should
    ++ *    not use the scan.
    ++ *
    ++ * Passing EARLY_SCAN_STOP_AT_NON_OPTION in other cases is safe, and
    ++ * useful when the caller rejects non-option arguments itself.
     + */
     +int early_scan_options(int argc, const char **argv,
     +		       const struct option *option,
4:  515f13df83 ! 4:  ceeb21e89e fast-import: use early_scan_options() for --allow-unsafe-features
    @@ Commit message
         about it.
     
         Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Cynthia Uche <herroyalpriestess@gmail.com>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/git-fast-import.adoc ##
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
     +	 * two agree on which options take a value and on abbreviations. In
     +	 * case of doubt, the scan stops early, so unsafe features are then
     +	 * refused rather than wrongly allowed.
    ++	 *
    ++	 * EARLY_SCAN_STOP_AT_NON_OPTION is passed even though parse_options()
    ++	 * is not called with PARSE_OPT_STOP_AT_NON_OPTION, as any non-option
    ++	 * argument makes parse_argv() reject the command line, and the stream
    ++	 * should not have been processed with unsafe features by then.
      	 */
     -	for (int i = 1; i < argc; i++) {
     -		const char *arg = argv[i];
    @@ t/t9300-fast-import.sh: test_expect_success 'R: export-marks options can be over
     +		--allow-unsafe-features <input 2>err &&
     +	test_grep "forbidden in input without --allow-unsafe-features" err
     +'
    ++
    ++test_expect_success 'R: --allow-unsafe-features after a non-option' '
    ++	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++	test_must_fail git fast-import --depth 5 extra \
    ++		--allow-unsafe-features <input 2>err &&
    ++	test_grep "forbidden in input without --allow-unsafe-features" err
    ++'
     +
      test_expect_success 'R: catch typo in marks file name' '
      	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.0.4.gceeb21e89e

