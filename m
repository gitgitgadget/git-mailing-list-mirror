Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567194;
	b=4D0uWoJRHhnWrW7KnGBOroqV6uy1n0QzPipuM7T70dS76nNd4N5Ev6z571HDEAICVgnP
	 R9ej0twqNZTxu921gdDdfVJ8r+3k/rbYGo5M57eqK4lwx478K0rF7OlAwrAqflkIkBZR+
	 7/au7iusg2YnFPLobyulpAu/0UyPYyfOUz+3CABmR8XszIl7xfJQFM7jsWqvWJWY5ccPC
	 sdPWnCRfpDCJ4NLmV9jc6Vp65Km1bjRBNflC9uTVzuqtW55R50DtZV8c6qdRLZkaL4/rm
	 P2Icpx4/la4ecX2e1UlrktKcf7AC2w2916ygACiT+kjGlpXrsZ81ZP14jdarW9OkMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CmZSy427D9jQtYidHhIkIKe/yI52zvY4YB57YKjvJOg=;
	b=c7X7s8+x1DJbjv4kO7hXaaWesKt79+ZvnL6bWa7hlrYAv9kerYtAxMSJwmYcWTgaRKTC
	 IaruVCVwVrhoZtaQ2MNX5nyu0tBu/TKwNxzOSVFUqFe9UzzgGyC/mL8VwK8/WOfyaIPjh
	 ZRUWIv5y1nARgTInJLMOML2Bhak9HHs04/PUkXqOL8jRavjKO80VYq3PTG6CiSKFKvR+4
	 vPKKFBngS6bLXmazSSVPUnKAv02gvjy4FScjLVt/C0D7oKDAHuH33LqpIIl+ZrbKjSqGj
	 tFpc/9qklsoNXRkO0yutyFYlw4V7/MLa8EY/xXFi128iEKtvUeG2SJC0l9ePnt1Xnig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFKKrlo1;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C8606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 21:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF3C8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFKKrlo1
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so27002535e9.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 13:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793567192; x=1794171992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmZSy427D9jQtYidHhIkIKe/yI52zvY4YB57YKjvJOg=;
        b=UFKKrlo10EWW5GjCxu4Jl4MANgVoZopn4x/2de15XXHkzMbNEeiXKbISCGF82w9u+b
         iLHNkR+fwGRYMdB8tS4tbO9oTQz/8ZKqe19PrJ6/tX5gVwbV2PaEe/coFIEn1Ypz5pPJ
         Dn7Ep17EcjVewQDda1bQ3cDlov5PpsTfg/Ym/QD/Dq1HKMwzbGcIlY9fBYi6DDgkSvoD
         Y2aJ9yKx6wVGcrYf4yEAcASeh913z//aPJ0NZVaCrvikNuk/04X5tf4tUKeLzqxNTuyA
         nObI7pk6OKspaIfs/VaNfzzxWoMZ3ZE3D1JH4OFkmCHTDdcJW2tqPdfQFOaew4PMqrIM
         MDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793567192; x=1794171992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmZSy427D9jQtYidHhIkIKe/yI52zvY4YB57YKjvJOg=;
        b=plygUBgqkVWdsG7J6NMlfhenm+ZfQdHf1YgYkcaF2oOnONFVExxRdUv4cYWvBfIPiw
         c5I02fl1rxizCnc8GowGCUPtZzhzrujjs+/+COe+0TTkrkbaSk50yZfb5sTkwEeq+i8P
         bG4kjaKukzPXLOkQxCdaxCVbDHIJE+H0tLZRB3pOUBgGSog2/b5kTsF4v9T00ztBcZym
         dLPjeXj+hmMKXFTrJCbgN5GKjLFWk8ftoJs/0/vICp/DzcIAeVcSfItI2/BLfrn4a374
         LBNYgXxS86a8TkvJhf849MeoIIo5zIGHglaki83ExDwqOFGs3zcKin1GXpWjqGu2WWln
         ut7g==
X-Gm-Message-State: AFq9FYJVHhYngR2w/Kg8l9AFVoRLo8jKcNtsYCA+e/bmPFcujBPv1Zf7
	jrVRYFrrG73V3g34WBRR0HFq3I/TQkxrs46HiFIrbkZEK0bGiFahBCF5JeXocile2m0Yfg==
X-Gm-Gg: AYBFou0GHOkJCIcIoazWfLmQ8EmQGIzrI54xzsmpCoULdpGf11jx2dwljqFpdH1dOQX
	9c3UWs4rti0oOfDOGqo5Xj2n5AHDFVjQEL8nKLks3hhIV/tpTq9+R6NM+qPoS1/U0bTnR00w1up
	DFIuZBoMf0rUMOZ2RbbRkoSq2l1v1SuT7oGn6NOYglH3iFQwlLt/zPPUnJMN05aFPPlFvxjtu7h
	6sSLwU49t6j3ujvRbezMggTTvNVKIyBbjNZK7RsSDH255tr3tHu83MwE6/ZwuRqPbGHIzkPlhTR
	ceQz5fl42jGwDaHCzY2rmWV7oZMIG44ok1f70FaFH7PtvMFWf9Mt5y1Q/m3MD7xQVhxNtB5jaDG
	BtJTedmrKfk6oRHyW3nPg95g9iRX2/E2w8dbQkA9Jn5c93zuO3yc2TL1P9utwUaPZ+ySgD7jzxa
	QqkUB9DhruHUm5U7IZfP1+HP06yi19SicesxP6UBX/IjHhvyYAUS8+ggacmfLt1/KwaIysNo/u9
	/ooTc3DyDqeOD9wL3TTrTwAsGrrEQMmSbo5YcUXzkNB690/1tt+G+Nsr8kywJY1CgC9/QR35uGd
	x78FXZ+EWDAU1WnVmSr7U0ddz7cAsdmKZrygv2oKYL/UDfI5+t1HSQ2MCshJ4jcC5xsUr3HP
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4ac1793f8ddmr199424565e9.14.1793567191759;
        Sun, 01 Nov 2026 13:06:31 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm15776454f8f.46.2026.11.01.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:06:31 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	cynthianuchepro@gmail.com
Subject: [Outreachy] Proposal draft v1: Improve how command arguments and options are scanned and parsed
Date: Sun,  1 Nov 2026 22:06:23 +0100
Message-ID: <20261101210623.622-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
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

This is the first draft of my proposal for "Improve how command
arguments and options are scanned and parsed" for the December 2026
Outreachy round. I would appreciate feedback, especially on the
candidate inventory (section 4) and the timeline (section 5).

1. About me and logistics
-------------------------
Name:     Cynthia Uche. I'm also called Priestess.
Pronouns: she/her
Email:    herroyalpriestess@gmail.com
GitHub:   https://github.com/herrpriestess
Blog:     https://medium.com/@thegirlSynth
Location: Abia, Nigeria (WAT, UTC+1)

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
  Status: merged to master (merge commit 84bea4324a)
  Patrick reviewed it and found it good, so it needed no second
  version.

Review of the early-scan series:
  [PATCH v3 4/4] fast-import: use early_scan_options() ...
  https://lore.kernel.org/git/20261031142255.4941-1-herroyalpriestess@gmail.com/
  I ran t9300 (261 tests) and t0040 (118 tests) on the topic as in
  origin/seen (tip dabb68a20d); all pass. I noticed that
  EARLY_SCAN_STOP_AT_NON_OPTION is passed although the real parse
  does not use PARSE_OPT_STOP_AT_NON_OPTION. With that argument set
  to 0 locally, "--depth 5 extra --allow-unsafe-features" reached
  the usage error (exit 129) instead of the "forbidden" error
  (exit 128), so the unsafe feature line had been accepted first.
  I suggested documenting this in the comment at the call site.

Steps I have taken: read the microproject and application pages,
SubmittingPatches and MyFirstContribution; built Git and ran the
relevant tests; sent my microproject by git send-email; read the
early-scan series v1 to v3 with its reviews; reproduced the
git column behaviour (section 4); ran the new fast-import
tests in t9300 and tried two command lines by hand (section 2).

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
   dangerous direction.

3.2 The API in v3

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
call uses PARSE_OPT_STOP_AT_NON_OPTION or subcommands. It should not
be used with PARSE_OPT_KEEP_UNKNOWN_OPT.

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

Why bisect and rev-parse were dropped: Junio said he saw little
practical value in them, since he doubted users would name a bisect
term or a --default value "--", unlike fast-import, where the bug
affects a safety check. Christian removed both patches in v2 and said
that bisect_start() could use the early scan once it has been converted
to parse-options [2], [3].

3.5 Current state and open follow-ups

As of Nov 01, cc/early-scan-options is in seen and not in next
(early_scan_options() is not in origin/next). Junio's Oct 28 "What's
cooking" listed it as "Needs review". Kaartic reviewed v3 on
30-31 Oct and found it in much better shape. His points:
 - consume the lookup_long_opt() result in parse_long_opt() with a
   switch instead of an if chain (2/4);
 - whether the PARSE_OPT_EARLY checks in parse_options_check() should
   also be in early_scan_options(), in case it is called before
   parse_options_start() (3/4);
 - document that the callback must not keep the "option" pointer,
   because it is freed after the scan (3/4).

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
bisect (12).

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
   --print, abbreviations or "--". Fien Dora has a patch adding tests
   for the precedence of --allow-onelevel and --no-allow-onelevel [10];
   Junio said he would queue it, and it would guard that part of a
   conversion.
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

 - Not proposed: rerere (Patrick's ps/rerere-subcommands (v2, 29 Oct),
   would convert it to OPT_SUBCOMMAND [9]), rev-parse (options are
   actions run in order and mixed with revisions, and its main option
   handling is not table-driven), rev-list, diff and setup_revisions()
   in revision.c (Christian thinks it should be converted to struct
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

Now to Dec 6:  Follow cc/early-scan-options, help it get to next
               with reviews, and discuss the targets on the list,
               including check-ref-format.
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

I will publish the blog on Medium and link each post on the list.
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
[11] Earlier drafts: none, this is v1.

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
