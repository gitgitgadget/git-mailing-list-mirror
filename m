Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760841;
	b=vHSwi4OnEshEQTanrOVu0Sz4N/LxCFGY2w22QPVqys+MkoaJcZsSdTY3bhaZudncCfGm
	 QMmnUeI3d2A1Vf+6be8XBVXOtYZHhcmw9ez23OL6aNQQISi+dYudipWh+dPim4rut4G9N
	 PXPBSx0OHbWjNxyYxqL8AgOxqw/GqJWqDS7ng9PLjons5qp6alYAOAGZJ9WMzYlYlnjsC
	 88mVt5tusSkCmnv4HvsWjX0jIRXjc3NJsugFUTqWLs3f+kiQgz9BUXxOqAK2zdzwsIZIG
	 +ah5fyQ4ArIhC1lqBUnCIYwdV3hOcyyHEc7ul5vvHQdYB1dufw+kUDZumTl5Rw0EZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gpqN1wkZxitYN7t5TT4UK1Srgpk3GGa/rOHfFohOpIo=;
	b=Af6xC/7hv+96KBN9GqbnJdNvO5ZuIx/6fEu3SCK+gW9gpimVPmY04AdDAjBqo3WzvoKo
	 1BZEgNReX5QQhY1nNZoZs4Dyqv+pCkcWaBgv3kAzZL43E55jygfimC1EjMulcYWovW8Wr
	 nkZqmY5IofJ2mbpPcY9Of32szXTMBpC8DJuPzU2WFZyJZZ0xiUojXU9Dqe7FFqrsDFfTd
	 TW5fl+4Qio7X5IBMrmciYLv0ODc0MpCwWAXAihUZ80IY2ntp+vz3g7Ts53TCGcL1q0hEx
	 mSmC7YsjUznhUFL6XDqp7LK+qGCnRt5VSMc4Gzluo1g26vqsXMKVWRs79+yw85ZGyOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWHPfPAx;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331D606A33C
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 02:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D331D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWHPfPAx
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so178975f8f.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 18:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793760839; x=1794365639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpqN1wkZxitYN7t5TT4UK1Srgpk3GGa/rOHfFohOpIo=;
        b=cWHPfPAxVHs5f1PtJmU5N9rCLMzffYRdn1DkXn8hBibVoKxCrEJ1Lp9h7n4OzQPRgJ
         dx/oBgQ5hN2nBW0Dhrorr0azMDhuuB66UoOsMbijF1ei0MKmK/y9dDb092CaVB+B/rYF
         VQOmDoUO3QIDM4DlFpk7oftYXtVxvBtgnJ2WfHvCt4AyrGJpC6orxaHGeQ2DUN6P6lVG
         +saMg84HuaYPFkW0JDEm9ETjRdqJUiA3VOF5C6/oIa32naWSPsv4GwRosZ7MZu0UZiTV
         t1PpOCX0ouAtc9EQ1ijGEC0lL8qkd6eMaXWNoLb26CWSk4510Xb4yTatZ0i5Jmxf5ZgI
         9hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760839; x=1794365639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpqN1wkZxitYN7t5TT4UK1Srgpk3GGa/rOHfFohOpIo=;
        b=nYaU/f7QBU+7vOeJETNzQf6ar4bqgKiwGvMdFZ7HTEpho6rxs0NhtXRyhN920Srjm7
         YSZidLDJdTtMcsLLvP/gf218I8f9AzOfpruKm0tMbt4cYAJmLApfmciw4+7a7+37YIjF
         SC5zkyuMy4riXHauUF4Z5Kj1htiAHtkmnM2KV6tJ3ubUlQp6ulTOP6+evh4nrTpEqSYf
         ZsqkPKimo/0meFlA+eiYn9z053zDvMSN34/8Iwv7VNCEgDrpta35h/HB7ofy4rlCZD6v
         rnRZEvx60h8Zh1Ws/qNuM8ShW6wxraPhIzEyyrv+v2inpTe9REZq3YaURNtbAIoiQ06H
         srbQ==
X-Gm-Message-State: APuU4Z9/zmzjGp48P8KbdfaDqI3fSxQAVm1DDd0KllJQOnigq+cRDQD1
	8iqZ1ka/b5EOq0pBVQq0FB0DQk8E9DD4T4oL66dq9hZ/JjQHHV21Z0jq9q7T0tlq7z3EPA==
X-Gm-Gg: AYBFou1nenGynF1hpMfFPViC2GxiTpKPWH+OpBCfjSFe/owgMIcJHVcgcNLYqaJnV5E
	I6aA1n59cbxjkUS4Pflq2Z9YHNn+C91rsooE52vejjWXTfkGW+hYR+UQTgf+fiv8WeWPfPGDDri
	xFh6xvfgPntCn4t/dwiDJHV7Gw7lPuzNZaADRDuh3nDJCd1upYEJ6xa5xVD4VVvoN4vDPnxYinM
	99a7BjqdhQ4/VJClFbxaB1mL0ra9CisiaUB+CLZw7Dz4aTb0dFZXFW5EgIUR7VdG6q5Oc6i7awI
	mmjubB7m/v4LbcxWYHJkp69sfHTzl8ujhRgKUFUgnkWlzIO3XV6Q7Y1XQBjs0bbGosI8pOnuPFE
	BaKZMa+OscVhJRa66noIBhuOwMRzZ5ZWVesmlDoPQsQBjF4LjDk/5dBapFXv6z8NbN8jBgpDCub
	R0M5Gs5Yr+cOKVnSJASRqcPkS31GRULgY6Ll0+sxKu1MgR7RNghNa1iefVh8tHGzHlHwuPNh6o6
	wSS4KP3TdvuC6h5zmOZJ+q1NVDcmnG0DdYu0nVZ4eVaqnC4FvPk5GLvcolyv5haJ/BFH0uFZ7IT
	0rCZ6ZXinqXm6n5Pr7sMLZZM2LdO/xw01nRw+vIpqCZ8DW6ZP1B1Xa5DHuC2xpcI21U50AxI0Q=
	=
X-Received: by 2002:a05:6000:186f:b0:48f:db47:6ebf with SMTP id ffacd0b85a97d-48fdb476f92mr1623573f8f.38.1793760838770;
        Tue, 03 Nov 2026 18:53:58 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.58.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180e7csm1277777f8f.5.2026.11.03.18.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:53:58 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com
Subject: [Outreachy] Proposal draft v2: Improve how command arguments and options are scanned and parsed
Date: Wed,  4 Nov 2026 03:53:40 +0100
Message-ID: <20261104025340.7799-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261101210623.622-1-herroyalpriestess@gmail.com>
References: <20261101210623.622-1-herroyalpriestess@gmail.com>
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

Hi team,

This is the second draft of my proposal for "Improve how command
arguments and options are scanned and parsed" for the December 2026
Outreachy round. v1 is here: [11]. I would appreciate
feedback, especially on the candidate inventory (section 4) and the
timeline (section 5).

Changes since v1
================
 - Section 2: Christian replied to my review of 4/4 and v4 of the
   early-scan series includes my suggestion; I also added my other
   two reviews.
 - Sections 3.2 to 3.5: v4 of the early-scan series and where it
   stands now.
 - Section 4: Fien Dora's t1402 tests are in 'next'; the status of
   rerere; the build the observations were made on.
 - Steps I have taken: updated.
 - About me: updated.
 - Communication: updated.

1. About me and logistics
-------------------------
Name:     Cynthia Uche. I'm also called Priestess.
Pronouns: she/her
Email:    herroyalpriestess@gmail.com
IRC:      Priestess
GitHub:   https://github.com/herr-priestess
Blog:     https://herr-priestess.github.io/
LinkedIn: https://linkedin.com/in/thecynthiauche
Location: Nigeria (WAT, UTC+1)

I have read the Outreachy eligibility rules and I meet all the
requirements.

I am a software engineer, mostly working on Python and backend
projects. C was the first language I learned, so I am comfortable
reading and writing it, although I have not used it much day to day
until now.

I have a merged patch in OpenStack Shared File Systems Service (Manila)
(https://review.opendev.org/c/openstack/manila/+/982431), which went
through Gerrit review, so reworking a change after review comments
is not new to me.

Availability: 30 hours per week

2. My Git work
--------------
Microproject: t2104: avoid suppressing git's exit code
  Thread: https://lore.kernel.org/git/20261021033723.5265-1-herroyalpriestess@gmail.com/
  Topic:  cu/t2104-avoid-pipes
  Status: merged to 'next' on 2026-10-24 and graduated to master
          (merge commit 84bea4324a); What's cooking Nov 2026 #01
          [6b] lists it under "Graduated to 'master'".
  Patrick reviewed it and found it good, so it needed no second
  version.

Review of the early-scan series:
  (a) [PATCH v3 4/4] fast-import: use early_scan_options() ... [8]
  I ran t9300 (261 tests) and t0040 (118 tests) on the topic as in
  origin/seen (tip dabb68a20d); all pass. I noticed that
  EARLY_SCAN_STOP_AT_NON_OPTION is passed although the real parse
  does not use PARSE_OPT_STOP_AT_NON_OPTION. With that argument set
  to 0 locally, "--depth 5 extra --allow-unsafe-features" reached
  the usage error (exit 129) instead of the "forbidden" error
  (exit 128), so the unsafe feature line had been accepted first.
  I suggested documenting this in the comment at the call site.
  Outcome: Christian replied on 2 Nov and sent v4 [12]. In v4 the
  call site comment explains why the flag is passed, the header
  comment of early_scan_options() says when callers should pass it
  and when they should not use the scan, and a new t9300 test, "R:
  --allow-unsafe-features after a non-option", covers that command
  line. Kaartic then wrote that v4 looks good to him, and Junio that
  he would mark the topic for 'next' [13].

  I tested v4 (tip c2b4099f84 in origin/seen): t0040 (118 tests) and
  t9300 (262 tests) pass, and the three command lines from my
  review and from the series behave as described.

Other reviews:
  (b) [PATCH v2] test-chmtime: use parse_options() ... [14]
  With the PARSE_OPT_KEEP_UNKNOWN_OPT argument set to 0, the new
  t0082 still passed 3 of 3, while "test-tool chmtime --get -86400"
  failed with "unknown switch `8'". I suggested a test for negative
  offsets and listed three behaviour changes that the commit message
  did not mention: flags after the timespec are now accepted,
  "-g -v" now dies, and usage errors exit with 129 instead of 1.
  Outcome: Shashank answered that all three are intended and that v3
  will add the test and document them. v3 was sent on 2 Nov [14].

  (c) [Outreachy PATCH v3 1/2] parse-options: answer
  --git-completion-helper before command runs [15]
  On master (ebdc087dc9) with the series applied, t9300, t0012 and
  t9902 pass, and "git --list-cmds=parseopt" lists the four builtins
  that the series unmarks. I compared "git <cmd> --git-completion-
  helper" and the "-all" form for every builtin, with builds of
  master and of the series, and the output was identical. The new
  test only covers the plain form: with the "-all" branch changed to
  show_gitcomp(opts, 0) it still passed. I suggested a test for that
  branch.

How these relate to the project: its tasks are to find hand-rolled
argument parsing, move it to parse-options or the early scan, and
discuss the patches with reviewers. The three reviews are in that
code: the early-scan series itself, a test helper moved to
parse_options(), and the parse-options completion code. Each time I
started from running something (a mutation of one argument, a
comparison with a base build, a loop over all builtins) and not from
reading alone. In (a) that led to changes in v4. Junio told another
applicant that topics move forward through positive reviews [16], and
that is how I want to work during the internship: start from the
failing command line, make it a test, then change the code.
(b) is also a real case of the flag that the v4 header tells callers
of the early scan to avoid: test-chmtime keeps PARSE_OPT_KEEP_UNKNOWN_OPT
so that a negative offset like "-86400" is not rejected as an unknown
switch, so a command like that could not use early_scan_options() as
it is today. So before choosing a candidate in section 4, I would
check whether its parse_options() call uses that flag.

Steps I have taken: read the microproject and application pages,
SubmittingPatches and MyFirstContribution; built Git and ran the
relevant tests; sent my microproject by git send-email; read the
early-scan series v1 to v4 with its reviews; reproduced the
git column behaviour (section 4); reviewed 4/4 of v3 and tested v4,
and reviewed two other patches (above).

3. Project understanding
------------------------
3.1 The problem: two parses that can disagree

Some commands must look at a few options before they call
parse_options(), because the result changes how they read their input.
fast-import is the example: the "feature" lines at the start of the
stream are handled before the command line is parsed, so
cmd_fast_import() scans argv early for --allow-unsafe-features.

The old scan was a hand-rolled loop. It compared each argument with
the exact option name and stopped at the first argument that did not
start with a dash. parse_options() is more permissive: it accepts
unambiguous abbreviations and values separated from their option by a
space. So the two disagree:

 - "--depth 5 --allow-unsafe-features": the scan stops at "5" and
   never sees the flag, although parse_options() accepts it. Unsafe
   features are refused. That is the safe direction, but still wrong.
 - "--quiet --export-pack --allow-unsafe-features": every argument
   starts with a dash, so the old scan saw the flag and allowed
   unsafe features. But parse_options() takes it as the value of
   --export-pack-edges, which --export-pack abbreviates. That is the
   dangerous direction. (This example is from the 4/4 commit
   message [4]; I did not run it on an old build.)

3.2 The API in v3 and v4

early_scan_options(argc, argv, option, flags, fn, data) walks argv
using the same struct option array that parse_options() uses. Options
the caller cares about are marked PARSE_OPT_EARLY, and the callback
receives (option, value, unset, pos, data); a non-zero return stops
the scan. It returns the index of the first argument not consumed.
Two helpers make it agree with parse_options():
parse_options_takes_argument() (1/4, which also counts
PARSE_OPT_LASTARG_DEFAULT options as taking a value) and
lookup_long_opt(), extracted from parse_long_opt() (2/4), so negated
forms, abbreviations and aliases are looked up the same way without
side effects. The scan always stops at "--" and "--end-of-options";
EARLY_SCAN_STOP_AT_NON_OPTION is for callers whose parse_options()
call uses PARSE_OPT_STOP_AT_NON_OPTION or subcommands. As of v4 the
header also says that passing it in other cases is safe, and useful
when the caller rejects non-option arguments itself, and that the
scan should not be used when parse_options() is called with
PARSE_OPT_KEEP_UNKNOWN_OPT [12]. Since v4, early_scan_options() also
calls parse_options_check() on the options, so a bad PARSE_OPT_EARLY
mark is caught before the scan relies on it.

3.3 Why "stop when unsure" is safe

The scan can miss an option that parse_options() would accept, but it
never reports one that parse_options() would not. It stops at anything
it cannot reliably skip: short options, unknown options, ambiguous or
disallowed abbreviations, low-level callbacks (which may consume any
number of arguments), a value stuck to a negated or no-argument
option, and a value-taking option given as the last argument. Missing
an option only makes the caller behave as if it was not given (for
fast-import, unsafe features are refused). Mistaking an option's value
for an option is the dangerous failure.

Why not make parse_options() do a dry run? Because it would be a much
larger refactoring. According to the 3/4 commit message, a dry run
would have to avoid writing through opt->value, calling callbacks,
dying on invalid values, handling --help and tracking command mode
conflicts. Junio has said he would prefer this in the long term [2].
The scan is simpler, and it keeps the option array and the
PARSE_OPT_EARLY marks, so it does not block a dry run later.

3.4 History of the series

 - v1 (2 Sep, 6 patches): early_scan_options() with its own option
   table, a bisect fix for "--" detection when a term is "--", a
   rev-parse fix for "--" when it is an option value,
   parse_options_takes_argument(), building the scan from a struct
   option array, and the fast-import conversion.
 - v2 (23 Sep, 3 patches): the scan reads the real struct option
   array and PARSE_OPT_EARLY marks the wanted options. The bisect and
   rev-parse patches are gone.
 - v3 (12 Oct, 4 patches, rebased on Git 2.56, a018953688): adds the
   lookup_long_opt() extraction, handles LASTARG_DEFAULT, stops at
   more cases, adds the "unset" callback argument, and removes the
   NEEDSWORK comment in fast-import.
 - v4 (2 Nov, 4 patches, same base): a switch in parse_long_opt()
   (2/4); parse_options_check() called from early_scan_options() and
   clearer header comments (3/4); a clearer comment at the call site
   and a new t9300 test (4/4).

Why bisect and rev-parse were dropped: Junio said he saw little
practical value in them, since he doubted users would name a bisect
term or a --default value "--", unlike fast-import, where the bug
affects a safety check. Christian removed both patches in v2 and said
that bisect_start() could use the early scan once it has been converted
to parse-options [2], [3].

3.5 Current state and open follow-ups

v4 was sent on 2 Nov and addresses the three points Kaartic made on
v3 (the switch in 2/4, the parse_options_check() call and the comment
about the option pointer in 3/4). Kaartic said v4 looks good [13].
Junio replied that it looks good and that he would mark the topic for
'next' [13]. As of 3 Nov, cc/early-scan-options is still only in seen
(git grep -n early_scan_options origin/next).

Not covered by the series: commands that do not use parse-options
at all, short options (the scan stops at them) and low-level
callbacks. Those are what section 4 is about.

4. Candidate inventory and risks
--------------------------------
Method: I counted hand-written option checks per builtin with
  git grep -c 'strcmp(arg' -- builtin/ | sort -t: -k2 -n
  git grep -n 'skip_prefix(arg, "--' -- builtin/
and listed builtins that never call parse_options with
  git grep -L parse_options -- 'builtin/*.c'
The counts include small value converters (am, config, log, revert),
which I treat as out of scope. The densest real parsing is in
rev-parse (43), rev-list (18), index-pack and diff (13 each) and
bisect (12). Observations in this section were made on origin/master
at v2.56.0-307-g50fe5cc63f, unless stated otherwise. I found no topic
in What's cooking #01 [6b] that touches column, bisect or
unpack-objects.

 - git column (builtin/column.c, cmd_column())
   It already uses parse_options(). Only the early step is by hand:
   if argv[1] starts with "--command=", config is read with that
   name before parse_options() runs, and a die() follows if the
   parsed and scanned values differ. Observed:
     git column --command=foo               works (exit 0)
     git column --command foo               dies (exit 128)
     git column --width=40 --command=foo    dies (exit 128)
     git column --com=foo                   dies (exit 128)
   The three failures all print "fatal: --command must be the
   first argument", even when "--command foo" really is first. I found
   this rule only in the die() message: searching Documentation/ and
   t/ for "must be the first" finds nothing related, and t9002 does not
   test --command.
   Fits: replacing the scan with early_scan_options() and
   PARSE_OPT_EARLY on --command, once the series is in next. I have not
   yet checked whether any option in column's table would
   make the scan stop.
   Risk: user-visible change (errors become success). Question for
   the list: is the "must be first" rule intentional? The callback
   receives pos, so it could be kept (pos == 0) or dropped.

 - bisect (builtin/bisect.c)
   bisect_start() has two hand-written loops: one looks for "--"
   (the bug of the dropped v1 patch) and one parses --no-checkout,
   --first-parent, --reset-when-found[=...] and the four --term-*
   options, each in a "--opt value" and a "--opt=value" branch.
   bisect_run() checks only argv[0] for --reset-when-found, and
   bisect_terms() compares one string with --term-good/old/bad/new.
   Fits: convert to parse-options first, order: bisect_terms(),
   bisect_run(), then bisect_start() as a stretch.
   Risk: bisect_start() is called from "bisect start", from
   bisect_autostart() and from "bisect replay"; the original
   arguments are written to BISECT_LOG and replayed, so they must be
   kept. Abbreviations and "--no-" forms would start to be accepted.

 - check-ref-format (builtin/check-ref-format.c)
   One loop over leading dash arguments handles --normalize/--print,
   --allow-onelevel, --no-allow-onelevel and --refspec-pattern;
   --branch is special-cased as exactly argc == 3; anything else
   calls usage(). git.c lists it as NO_PARSEOPT.
   Tests: t1402 covers --normalize, --allow-onelevel and
   --refspec-pattern, alone and combined, and --branch (also from
   outside a repository, and with the name -nain). It does not test
   --print, abbreviations or "--". Fien Dora's patch adding tests for
   the precedence of --allow-onelevel and --no-allow-onelevel [10]
   was merged to 'next' on 1 Nov and is marked "Will merge to
   'master'" in What's cooking #01 [6b]. Her commit message says she
   plans to explore converting this parser in a separate series [10].
   Observed on origin/master (v2.56.0-307-g50fe5cc63f):
     --norm refs/heads/x           usage text, exit=129
     -- refs/heads/x               usage text, exit=129
     --normalize -- refs/heads/x   usage text, exit=129
     refs/heads/x --normalize      usage text, exit=129
     --branch -nain                "fatal: '-nain' is not a valid
                                   branch name", exit=128
   Fits: parse-options: OPT_BIT for the flags (--no-allow-onelevel
   then comes for free), OPT_ALIAS for --print, and dropping
   NO_PARSEOPT in git.c.
   Risks: commands that fail today would succeed: abbreviations, "--"
   and negated forms such as --no-normalize would be accepted, and
   so would options after <refname> unless I pass
   PARSE_OPT_STOP_AT_NON_OPTION. --branch needs an explicit check
   that it is not combined with other options, and "--branch -nain"
   must keep failing with the invalid branch name error (exit 128),
   not become a usage error from short option parsing.
   Question for the list: is accepting "--" and abbreviations
   welcome, should options after <refname> keep being rejected?

 - unpack-objects (builtin/unpack-objects.c) [if time allows]
   -n, -q, -r, --strict[=<msg-types>], --pack_header=,
   --max-input-size=. Risk: other Git programs run it with fixed
   arguments, so those must keep working; I will list the callers
   before choosing it. index-pack and fetch-pack are larger,
   same issue.

 - Not proposed: rerere (Patrick's ps/rerere-subcommands, v2 of
   29 Oct, would convert it to OPT_SUBCOMMAND [9]; "Needs review" in
   What's cooking #01 [6b]), rev-parse (options are actions run in
   order and mixed with revisions, and its main option handling is
   not table-driven), rev-list, diff and setup_revisions() in
   revision.c (Christian has said it should be converted to struct
   option first).

Common risks: behaviour change for scripts; abbreviations
(GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS); short options and low-level
callbacks that stop the scan; PARSE_OPT_KEEP_UNKNOWN_OPT; test
coverage before the change. parse-options.c is changed by several
experienced contributors, so I will coordinate on the list before
any API change.

5. Plan and timeline
--------------------
Internship dates: 7 Dec 2026 to 8 Mar 2027.

Now to Dec 6:  Follow cc/early-scan-options until it reaches
               master, review related patches, and discuss the
               targets on the list, including check-ref-format.
Weeks 1-2:     Agree on the inventory and a first target with the
               mentors. Write tests that show the current
               behaviour. Start the weekly blog.
Weeks 2-5:     First series: bisect_terms() and bisect_run(), tests
               first, then the conversion.
Weeks 4-8:     Second series: check-ref-format if it is still free,
               otherwise bisect_start(), which is then a main item and
               not a stretch.
Weeks 6-10:    unpack-objects, if time allows; index-pack and
               fetch-pack only if time remains.
Weeks 8-11:    column on early_scan_options(), once the series is in
               next and the "must be first" question is settled.
               Tests first, then the change.
Weeks 11-13:   Rerolls, documentation, final report, and a list of
               remaining candidates for the next intern.
Every week:    Weekly blog post.

The ranges overlap on purpose: each series usually waits days for
review, so I can work on the next one meanwhile. If I fall behind
I drop unpack-objects first, then the bisect_start() when it is only a
stretch. If the early-scan series changes shape or stalls, the column
step becomes another conversion from section 4 that does not depend on
it. I have not planned any time off, except possibly 1-3 January, which
I will arrange with the mentors beforehand.

6. Communication
----------------
A weekly blog post (Christian asks for one), linked on the list;
weekly written updates to Siddharth; calls with Christian planned in
advance; questions asked on the list first; replies to review within
1-2 days.

I will publish the blog on GitHub pages and link each post on the list.
I love sharing about what I'm learning, and I trust that I'll be
learning a lot in the next few weeks.

7. After the internship
-----------------------
After my internship I intend to keep reviewing patches, help
newcomers learn the ropes, just like I did, and keep working on the
follow-ups that did not fit the internship. I believe in paying it
forward, so if I ever get the chance to mentor someone else, I will
consider it a privilege.

8. References
-------------
[1] v1 cover:
    https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.com/
[2] Junio on the v1 cover and Christian's answer:
    https://lore.kernel.org/git/xmqqpkyviizc.fsf@gitster.g/
    https://lore.kernel.org/git/CAP8UFD3qUpjUayhkMumZ41iMut=1=Pcmzx1YYcEV9NMG18OPsw@mail.gmail.com/
[3] Junio on v1 2/6 (bisect) and Christian's answer:
    https://lore.kernel.org/git/xmqqse3rffr4.fsf@gitster.g/
    https://lore.kernel.org/git/CAP8UFD3sh9Ejfgv7CB33LRU_z3i662_+tjdW7JqwRrzexWX_Ow@mail.gmail.com/
[4] v3 cover and 4/4:
    https://lore.kernel.org/git/20261012074413.337183-1-christian.couder@gmail.com/
    https://lore.kernel.org/git/20261012074413.337183-5-christian.couder@gmail.com/
[5] Kaartic on 2/4, 3/4 and the v3 cover:
    https://lore.kernel.org/git/02ba1b9d-b598-454b-897f-cb33ba190b13@gmail.com
    https://lore.kernel.org/git/6782fa63-1e46-4ae9-b129-a157986c2556@gmail.com
    https://lore.kernel.org/git/1e194ea7-2e28-4142-b678-d8cb8bca8e35@gmail.com
[6] "What's cooking" Oct 2026 #10:
    https://lore.kernel.org/git/xmqqo6cd5hnt.fsf@gitster.g/
[6b] "What's cooking" Nov 2026 #01:
    https://lore.kernel.org/git/xmqqcxsmejd9.fsf@gitster.g/
[7] My microproject thread and merge commit:
    https://lore.kernel.org/git/20261021033723.5265-1-herroyalpriestess@gmail.com/
    84bea4324a
[8] My review of 4/4:
    https://lore.kernel.org/git/20261031142255.4941-1-herroyalpriestess@gmail.com/
[9] Patrick's ps/rerere-subcommands:
    https://lore.kernel.org/git/20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im/
[10] Fien Dora's t1402 patch (v3) and Junio's reply:
     https://lore.kernel.org/git/20261029121715.3845-1-fiendora5@gmail.com/
     https://lore.kernel.org/git/xmqqqzh81goi.fsf@gitster.g/
[11] Earlier drafts: v1:
     https://lore.kernel.org/git/20261101210623.622-1-herroyalpriestess@gmail.com/
[12] v4 cover and Christian's reply to my review:
     https://lore.kernel.org/git/20261102151447.734680-6-christian.couder@gmail.com/
     https://lore.kernel.org/git/CAP8UFD2m+wpcgqB2SasWLxyekY+5khrYyPkOuLoYwANqZws8fw@mail.gmail.com/
[13] Kaartic on v4 and Junio's reply:
     https://lore.kernel.org/git/faf0b5e6-1c63-4c68-9f23-42a452879854@gmail.com/
     https://lore.kernel.org/git/xmqqv76dal2l.fsf@gitster.g/
[14] My review of test-chmtime v2, Shashank's answer and his v3:
     https://lore.kernel.org/git/20261102024623.24897-1-herroyalpriestess@gmail.com/
     https://lore.kernel.org/git/CANHmUQS15GGDOXm-WZ9M-UyKf2N0K+VixowL_heNKW0vjE0vJw@mail.gmail.com/
     https://lore.kernel.org/git/pull.2280.v3.git.1793639275978.gitgitgadget@gmail.com/
[15] My review of Tanga Joris's v3 1/2:
     https://lore.kernel.org/git/20261103092503.14872-1-herroyalpriestess@gmail.com/
[16] Junio to Tanga Joris, 26 Oct:
     https://lore.kernel.org/git/xmqq33ttvz0q.fsf@gitster.g/

9. Closing remarks
------------------
Git has a VAST codebase, and it can seem quite intimidating at first
to a newcomer, but the support in this community has made it much
easier to start. Resilience is one of my core attributes, and I also
know to ask for help when I need it, so I won't be the first to give
up should things get more demanding than I expect. I would be glad to
be mentored by experienced contributors and to keep contributing after
the internship.

Thanks,
Cynthia Uche
