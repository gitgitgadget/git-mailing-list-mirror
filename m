Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175632;
	b=KotBzG/Tf8f4Nc4lom9pGexKCXepQimJ+P33sETRTZ9Ptr3gq668MdVRcoGOO3mx20SR
	 i1TgpF2fHoTqmIS5Cbsc3FvpC9Qcq3y8ie763WnPRJ4Sm+VPcsGVU6LSLn7EcYfBfVU6U
	 uj/nW5cV2+lGRtPcLtx5+Y5tRb19YR638jMZ5Gr9vRb83xUh5tYzAA6PP+c+ibTp6HHt2
	 a/JpKROv3mXsiPa7JfYxdg01ZSUg1RZiCCODEHH8XX7NQJ0J7Ldwh0EhdaRjwWLJHWifI
	 VuD4oesPnu7Gbogq5CD3yq6dSF/79HEyHmXfli7XngOMQWItgJC9h8j96IrCHXrtf6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pTAvbRanHGifkQzeSYyPhlsUaPySwCnHwuAPB5sGYsE=;
	b=aMXFhvtvRPqEWutQQEI6ApyStG7M2bMYPEASTjyiC3XE2XKH9N7QdniE/vh3eRNBO4Fj
	 E4Zj0id8/v4YeVSf9x+Qhr/LhxAMcaYFwYEyD3jxbdxnqDq0jTquxKKH5Nt3y8CzXj3J5
	 58WFpjKJt0ReZdo4OV4VHQSoGUCMIQJziqyHmnoDNmnBkr09OTvCoZRUrgq9X0yqpWymc
	 hqwaFwRmOrzlp+YO5XFDla3tMlc5+n0ima3tywtWXyxe3aCDB3TATLXU6fE8xqSbiaYxI
	 HpJcCQvLgzaS52YMHLAmPpUWRABA4xMyvA/7DM7IUhInMyc4+mluZTYPh1Tym8shfhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tliYe1U5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E43606A331
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 22:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E43606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tliYe1U5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so2405655e9.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794175630; x=1794780430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTAvbRanHGifkQzeSYyPhlsUaPySwCnHwuAPB5sGYsE=;
        b=tliYe1U5kddmcJxgbS+HPbfh6qYbOw4K1uTMDpHQQjBHK/Bt0B07YimGaJJPlWaPFm
         VQeDnRuJdPZn67M9hFcrdykXJ06vBg7OMRDwfjPJmCXVGHw6JCRvBEDDeyF3nKd+PP1Y
         q456CV3BCM6trlR/AyLuFMrPk4e9IRSLhxNdpkOFMpBiw2KVuoHA6Ghn+IYq8ypzn1FS
         Joj4i4NoyWxVz75umoq3ahjZN/Y9BgCXajtESJZuPhTeyMgSnZKJnP3gsJDt9KRoBg9p
         ISKJYZH/V9l08OxDOzHC/EDz+DjhPwvP4a0jLxQCdc5q9oW6tWkf80I/97MHxQuNyFdI
         6+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794175630; x=1794780430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTAvbRanHGifkQzeSYyPhlsUaPySwCnHwuAPB5sGYsE=;
        b=dF0Lb9X1aO5Botcgwxc7wR8QmCz190PSRojFMYL1pEk2RZG3l5BEk2L8M9YXMk6TZD
         /Y4w1auY0zOHpBxoK7kxobUBhFkd0hqLHNTuDKemKH+oNnpvsoF7XisD/mCucraPP0GG
         MNX8iIZQHx5fPvsiACOyz6j9DVlyiLDbG4e91cUWAlJ0ISp51HkwUkdDVeMKZ6J7+RU5
         I1ZCckMFZ54ZVpJub353AOKwpjcotFCOCOiNuy7eDEjF1qAuCcFien2vstGmGrxCgrdQ
         +o+g/2WuBOm7eTcj5slpkoP3zS2UgGnIlJqtpqTrKwBNuhDTtZ8YA4RI1dGZv2ya6jg2
         35zA==
X-Forwarded-Encrypted: i=1; AL+hErECtdoLTJOmCy8ka1W+TiN77XhFWHuzBzqVAjnIwTYKloW6BM8TWl+9KlX5/xT0yX5l++I=@vger.kernel.org
X-Gm-Message-State: APuU4Z80LMYUy6aji0PQUejobuE8gbC2wjSoLrQi8KqASSItrEykRKXu
	IvYJN4vfDqfZeiaDzK7o1oYTRiQ61pJcJa4GAnHjMx+TSsmycEIBc+pw
X-Gm-Gg: AYBFou1xr8Y/4XojB6Y1JU+zm1fTPHjFAiVAJkjPi2zYcwBzwOPHiUgEIluGy9XxAID
	RHgpH4WVgkRNf3mEBx+9RlNFLqqykb5f9Sa8kTgfB9cD16HQro635BSXm5ZNC1TjqCo/Mhn4059
	kMbsAWt/Lt5d8pkuWKFVS+uFy7aMmaL1QQuZFzuUOdvu8PDZXcWGWkVr9eEb/HprSL9R530+12y
	ywSlqJ70AOWtflr1O60gZ4eC2YyrKVjIclPbccTrTIFsSr0yEX1qJZ3zVwAXKAACR0VAgkjMt2+
	4UMD1uhcE1Jx7pWyJzFqM4wGfPlPxn5dUERcygFsZZnxCRB3isu7JwUENwMu+HUPyOewbEwECHS
	GPLCu2Fzw1RCw+8nb5vsL50X0vv6xL8D35tuQQ08tI/xCzkSaWHGisBJPX1I6LTrO8/gt5eX/2K
	yZ2qI7po+pITZv5tlo8trE9CV2gIIFlWYE/PuidxE12wepb6WTQ4+9tTcTD/6jPOpDeRhbNzlU/
	acdhR/aiuso0YRyZCeH+iNLHHNp1a59v/U/jB4vV0fOSLA4GaYlJL6RtvGRSKRhic+2KIt9KGxc
	jQYGjEYiIL/1lftA6AsahRBO3JGFft5aKQoEpR0rc6c12HXUJt0V
X-Received: by 2002:a05:600c:8b34:b0:4b4:49d7:bc25 with SMTP id 5b1f17b1804b1-4b963c6d78cmr42782255e9.21.1794175629367;
        Sun, 08 Nov 2026 14:07:09 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.58.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7c4afc8e8sm74869975e9.3.2026.11.08.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:07:08 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: herroyalpriestess@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	siddharthasthana31@gmail.com
Subject: [Outreachy] Proposal draft v3: Improve how command arguments and options are scanned and parsed
Date: Sun,  8 Nov 2026 23:06:36 +0100
Message-ID: <20261108220636.306-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261104025340.7799-1-herroyalpriestess@gmail.com>
References: <20261104025340.7799-1-herroyalpriestess@gmail.com>
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

This is the third draft of my proposal for "Improve how command
arguments and options are scanned and parsed" for the December 2026
Outreachy round. v1 and v2 are here: [11]. I would appreciate
feedback, especially on the candidate inventory (section 4) and the
timeline (section 5).

Changes since v2
================
 - A short summary at the top and a new "How I work" section.
 - Section 1: updated, including how I have been preparing.
 - Section 2: the outcomes of my reviews so far (including
   Shashank's v3), my review of Karthik's patch and a doc fix.
 - Sections 3.4 to 3.6: v4 of the early-scan series, and a
   corrected account of what needs a decision in a conversion.
 - Sections 4 and 5: updated after Christian's review of v2 [18].
   column is deliberate and is no longer a target, check-ref-format
   is already being converted, and bisect is described correctly and
   becomes the main target.

In short
--------
Some commands read a few options before parse_options() runs, and the
two can disagree: fast-import's hand-written scan could allow unsafe
features on a command line that parse_options() reads differently.
Christian's early-scan series fixes that, and this project extends the
same idea to the other places that parse arguments by hand. When I
counted on origin/master, 29 entries of the command table in git.c
were still marked NO_PARSEOPT. I would start with the sub-commands of
git bisect: cmd_bisect() uses parse_options() only to dispatch them,
and bisect_start(), bisect_run() and bisect_terms() parse their
arguments by hand. I studied other candidates too; column turned out
to be deliberate and check-ref-format is already being converted, so
section 4 explains why I left them. So far: a merged microproject,
four reviews and a doc fix.


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
reading and writing it, and contributing to the Git project is a good
opportunity to revisit and relearn it.

Earlier Outreachy: I have a merged patch in OpenStack Shared File
Systems Service (Manila)
(https://review.opendev.org/c/openstack/manila/+/982431), made during
the contribution period of the summer 2026 Outreachy round. That was
my first time using IRC, Gerrit and Launchpad bug tracking, so working
outside GitHub was not new to me when I started with Git's mailing
list. Git's list is different, and I have learned it in public over
the last few weeks.

Availability: 30 hours per week from 7 December 2026 to 8 March 2027.

How I have been preparing: the microproject page asks applicants not to
start the internship project itself, so I have worked on the code
around it: reviews, a doc fix and tests. I have read parse-options.c,
parse-options-cb.c, api-parse-options.adoc, the early-scan series v1
to v4, fast-import.c, column.c, bisect.c, check-ref-format.c, t0040,
t1402, t9300 and t9002.

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
  line. Kaartic then wrote that v4 looks good to him, and Junio
  that he would mark the topic for 'next' [13].

  I tested v4 (tip c2b4099f84 in origin/seen): t0040 (118 tests) and
  t9300 (262 tests) pass, and the command lines from my review and
  the new test behave as described.

Other reviews:
  (b) [PATCH v2] test-chmtime: use parse_options() ... [14]
  With the PARSE_OPT_KEEP_UNKNOWN_OPT argument set to 0, the new
  t0082 still passed 3 of 3, while "test-tool chmtime --get -86400"
  failed with "unknown switch `8'". I suggested a test for negative
  offsets and listed three behaviour changes that the commit message
  did not mention: flags after the timespec are now accepted,
  "-g -v" now dies, and usage errors exit with 129 instead of 1.
  Outcome: Shashank answered that all three are intended, and sent
  v3 on 2 Nov [14]. I checked v3 on top of master (0ffa3e35c7):
  t0082 passes 4 of 4 with the negative-offset test, that test fails
  when I set the PARSE_OPT_KEEP_UNKNOWN_OPT argument to 0, the commit
  message now lists the three behaviour changes, and the output
  matches a build of master for the command lines I compared.

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

  (d) [PATCH] api-parse-options: add missing flags and macros
  (Karthik Nayak) [20]
  I built the page and checked the behaviour text against
  parse-options.c and parse-options-cb.c. The commit message listed
  OPT_NO_WITH although the macro is OPT_WITHOUT, and did not list five
  macros that the diff adds; OPT_ALIAS was undocumented. Karthik
  fixed the message and added OPT_ALIAS.

Doc fix: api-parse-options.adoc, restoring a dropped word [21]
  The description of PARSE_OPT_KEEP_UNKNOWN_OPT lost the word
  "stopping" in 0d260f9a09 (2009). Junio: "Makes sense. Thanks for
  finding and fixing."

How these relate to the project: its tasks are to find hand-rolled
argument parsing, move it to parse-options or the early scan, and
discuss the patches with reviewers. The four reviews are in that code:
the early-scan series itself, a test helper moved to parse_options(),
the completion code in parse-options.c, and the parse-options API
document. Each time I started from running something (a mutation of
one argument, a comparison with a base build, a loop over all
builtins) and not from reading alone. In (a) that led to changes in
v4. Junio told another applicant that topics move forward through
positive reviews [16], and that is how I want to work during the
internship: start from the failing command line, make it a test, then
change the code.

(b) is also a real case of the flag that the v4 header tells callers
of the early scan to avoid: test-chmtime keeps
PARSE_OPT_KEEP_UNKNOWN_OPT so that a negative offset like "-86400" is
not rejected as an unknown switch, so a command like that could not
use early_scan_options() as it is today. So before choosing a
candidate in section 4, I check whether its parse_options() call uses
that flag.

Steps I have taken: read the microproject and application pages,
SubmittingPatches and MyFirstContribution; built Git and ran the
relevant tests; sent my microproject by git send-email; read the
early-scan series v1 to v4 with its reviews; reproduced the behaviour
of the candidates in section 4; reviewed 4/4 of v3 and tested v4, and
reviewed three other patches (above).

How I work
----------
For every change: (1) a command line that shows the current behaviour,
with its exit status, on a base build; (2) a test that fails on that
base; (3) the change; (4) the same test with the fix broken on purpose,
and with the whole fix reverted; (5) a comparison of output and exit
status with the base build over the commands I touched. Examples are
the mutation runs in (b) and (c).


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
Christian noted that improving the early scan can lead to
refactorings like the one in 2/4, which could make a dry run easier
to implement [18].

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
 - v4 (2 Nov, 4 patches): a switch in parse_long_opt() (2/4);
   parse_options_check() called from early_scan_options() and clearer
   header comments (3/4); a clearer comment at the call site and a
   new t9300 test (4/4).

Why bisect and rev-parse were dropped: Junio said he saw little
practical value in them, since he doubted users would name a bisect
term or a --default value "--", unlike fast-import, where the bug
affects a safety check. Christian removed both patches in v2 and said
that bisect_start() could use the early scan once it has been
converted to parse-options [2], [3]. Junio then said that "--"
detection could come for free as a side effect of using
parse_options() [17], and Christian wrote on 6 Nov that an early scan
may not be needed at all for it [18].

3.5 Current state and open follow-ups

v4 was sent on 2 Nov and addresses Kaartic's points on v3 [5]: the
switch in 2/4, the parse_options_check() call and clearer comments in
3/4. Kaartic said v4 looks good, and Junio replied that he would mark
the topic for 'next' [13]. It was merged to 'next' on 6 Nov.

Not covered by the series: commands that do not use parse-options
at all, short options (the scan stops at them) and low-level
callbacks. Those are what section 4 is about.

3.6 Where a conversion is not mechanical
----------------------------------------
Studying the candidates, I found three places where converting to
parse-options needs a decision, not only a rewrite:

 (a) Arguments that start with "-". test-chmtime must accept
     "-86400". With the PARSE_OPT_KEEP_UNKNOWN_OPT argument set to 0,
     "--get -86400" failed with "unknown switch `8'" (exit 129) [14],
     and the v4 header of early_scan_options() says the scan should
     not be used with that flag [12]. I check this for every
     candidate before choosing it.
 (b) check-ref-format --branch must come first and take exactly one
     argument (argc == 3 in the code). parse-options has helpers for
     options that exclude each other (die_for_incompatible_opt2() to
     4()), but I did not find one for "this option excludes all
     others", so a conversion needs an explicit check. Hussain's v2
     [19] keeps the argc == 3 check before calling parse_options().
 (c) bisect: the sub-command functions receive what the dispatcher
     left unprocessed. I still need to check which flags a second
     parse_options() call needs there, for example for the revisions
     that follow the options and for "--" in bisect_start(). That is
     the first thing I would study in week 1.

For each, I would ask on the list and use the least invasive fix (a
check in the caller) before proposing any change to parse-options.


4. Candidate inventory and risks
--------------------------------
Method: git grep -n NO_PARSEOPT -- git.c lists the builtins marked as
not using parse-options, and I use it as the backlog. When I counted
on origin/master, 29 entries were marked (26 distinct functions, since
the four merge-recursive entries share one). The marks can be stale:
fast-import is marked, but it calls parse_options() in parse_argv(),
so I check each file before choosing it. I counted hand-written
option checks per builtin with
  git grep -c 'strcmp(arg' -- builtin/ | sort -t: -k2 -n
  git grep -n 'skip_prefix(arg, "--' -- builtin/
and listed builtins that never call parse_options with
  git grep -L parse_options -- 'builtin/*.c'
The counts include small value converters (am, config, log, revert),
which I treat as out of scope. The densest real parsing is in
rev-parse (43), rev-list (18), index-pack and diff (13 each) and
bisect (12). Observations in this section were made on origin/master
at v2.56.0-307-g50fe5cc63f, unless stated otherwise. What's cooking
lists only the topics that Junio has picked up, so I also search lore
for patches in flight before choosing a target; Christian's review
[18] is how I learned that check-ref-format was taken.

 - bisect (builtin/bisect.c): proposed main target
   cmd_bisect() uses parse_options() only to dispatch the sub-commands
   (OPT_SUBCOMMAND with PARSE_OPT_SUBCOMMAND_OPTIONAL), and the
   sub-command functions do not call it [18]. bisect_start() has two
   hand-written loops: one looks for "--" (the bug of the dropped v1
   patch) and one parses --no-checkout, --first-parent,
   --reset-when-found[=...] and the four --term-* options, each in a
   "--opt value" and a "--opt=value" branch. bisect_run() checks only
   argv[0] for --reset-when-found, and bisect_terms() compares one
   string with --term-good/old/bad/new. A conversion would give each
   of them its own parse_options() call.
   Fits: in the order bisect_terms(), bisect_run(), bisect_start().
   Junio said "--" detection could come for free from parse_options()
   [17], so these conversions may not need the early scan.
   Risk: bisect_start() is called from "bisect start", from
   bisect_autostart() and from "bisect replay"; the original
   arguments are written to BISECT_LOG and replayed, so they must be
   kept. Abbreviations and "--no-" forms would start to be accepted.
   Before the internship I will search lore again, to make sure nobody
   else is converting it.

 - unpack-objects (builtin/unpack-objects.c), if time allows
   -n, -q, -r, --strict[=<msg-types>], --pack_header=,
   --max-input-size=. Risk: other Git programs run it with fixed
   arguments, so those must keep working; I will list the callers
   before choosing it. index-pack and fetch-pack are larger, same
   issue.

Studied and not proposed:

 - check-ref-format (builtin/check-ref-format.c): already being
   converted. Hussain Sitamouwala sent "check-ref-format: use
   parse-options API" (v1 on 29 Oct, v2 on 3 Nov) [19], as Christian
   pointed out [18], and Fien Dora plans the same [10]. I will not
   start it. What I found on master: one loop over leading dash
   arguments handles --normalize/--print, --allow-onelevel,
   --no-allow-onelevel and --refspec-pattern; --branch is
   special-cased as exactly argc == 3; anything else calls usage().
   git.c lists it as NO_PARSEOPT. Observed:
     --norm refs/heads/x           usage text, exit=129
     -- refs/heads/x               usage text, exit=129
     --normalize -- refs/heads/x   usage text, exit=129
     refs/heads/x --normalize      usage text, exit=129
     --branch -nain                "fatal: '-nain' is not a valid
                                   branch name", exit=128
   Hussain's v2 commit message states three of the differences that I
   listed as risks: abbreviations such as --norm and "--" before
   <refname> are now accepted, and options after <refname> are still
   rejected (PARSE_OPT_STOP_AT_NON_OPTION). It also sets
   PARSE_OPT_NONEG on --normalize, --print and --refspec-pattern,
   which covers the negated forms. v2 changes only
   builtin/check-ref-format.c, so the newly accepted forms have no
   tests yet; I leave that to the review in progress. Tests today:
   t1402 covers --normalize, --allow-onelevel and --refspec-pattern,
   alone and combined, and --branch (also from outside a repository,
   and with the name -nain). Fien Dora's tests for the precedence of
   --allow-onelevel and --no-allow-onelevel were merged to 'next' on
   1 Nov and are marked "Will merge to 'master'" in What's cooking
   #01 [6b] [10].

 - git column (builtin/column.c): deliberate, not a target
   It already uses parse_options(). Only the early look at argv[1] for
   "--command=" is by hand, and the code says "This one is special and
   must be the first one". Christian said the rule looks deliberate,
   and that git tag, the only internal user, does not use --command
   [18]. Observed:
     git column --command=foo               works (exit 0)
     git column --command foo               dies (exit 128)
     git column --width=40 --command=foo    dies (exit 128)
     git column --com=foo                   dies (exit 128)
   I do not plan to change it.

 - rerere (Patrick's ps/rerere-subcommands, v2 of 29 Oct, would
   convert it to OPT_SUBCOMMAND [9]; "Needs review" in What's cooking
   #01 [6b]).
 - rev-parse (options are actions run in order and mixed with
   revisions, and its main option handling is not table-driven),
   rev-list, diff and setup_revisions() in revision.c (a much larger
   change).

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
               target with the mentors (my proposal is bisect).
Weeks 1-2:     Agree on the first target with the mentors. Study how
               a second parse_options() call behaves after the
               sub-command dispatch (3.6 (c)). Write tests that show
               the current behaviour of bisect_terms() and
               bisect_run(). Start the weekly blog.
Weeks 2-6:     First series: bisect_terms() and bisect_run(), tests
               first, then the conversion.
Weeks 5-9:     Second series: bisect_start(). It is a main item,
               with tests for replay and the BISECT_LOG contents
               first.
Weeks 8-11:    Third series: unpack-objects (after listing its
               callers), or another command from the NO_PARSEOPT
               list that the mentors prefer; index-pack and
               fetch-pack only if time remains.
Weeks 11-13:   Rerolls, documentation, final report, and a list of
               remaining candidates for the next intern.
Every week:    Weekly blog post.

The ranges overlap on purpose: each series usually waits days for
review, so I can work on the next one meanwhile. If I fall behind I
drop the third series first. If someone else takes bisect, or the
mentors prefer another command, I will pick the next candidate from
the NO_PARSEOPT list with them. I have not planned any time off,
except possibly 1-3 January, which I will arrange with the mentors
beforehand.

6. Communication
----------------
A weekly blog post (Christian asks for one), linked on the list;
weekly written updates to Siddharth; calls with Christian planned in
advance; questions asked on the list first; replies to review within
1-2 days.

I will publish the blog on GitHub Pages and link each post on the
list. I love sharing about what I'm learning, and I trust that I'll be
learning a lot in the next few weeks.

7. After the internship
-----------------------
I like to give back to communities that have helped me grow. I have
volunteered as a backend technical coordinator for the Nexascale
community, where I helped new developers learn the ropes in backend
development. I have also helped to organize tech programs in my local
community (DevFest under GDG, Women Techmakers, SheCodeAfrica).

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
[11] Earlier drafts, v1 and v2:
     https://lore.kernel.org/git/20261101210623.622-1-herroyalpriestess@gmail.com/
     https://lore.kernel.org/git/20261104025340.7799-1-herroyalpriestess@gmail.com/
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
[17] Junio on "--" detection coming for free from parse_options():
     https://lore.kernel.org/git/xmqqmrt7c1zf.fsf@gitster.g/
[18] Christian's review of my v2:
     https://lore.kernel.org/git/CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com/
[19] Hussain Sitamouwala's check-ref-format patches (GitGitGadget
     pull request; the thread is on the list under the same subject):
     https://github.com/git/git/pull/2470
[20] Karthik Nayak's api-parse-options patch, my review and his
     answer:
     https://lore.kernel.org/git/20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com/t/#u
[21] My doc fix and Junio's reply:
     https://lore.kernel.org/git/20261104224559.4197-1-herroyalpriestess@gmail.com/

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
