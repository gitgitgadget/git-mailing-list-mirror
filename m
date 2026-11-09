Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237016;
	b=Gkguo7G4vk5T0HJOHGbjbONMIFVxbywrcFApxm2nT41wlimrv8+5A26evQanEe7lRGvO
	 QAdDxjs4uVSASIlTN2ZmencKNhxZujwAfg3D9zhLOHoYHrFbXeNQzT3x2NOgkZH5dP7J6
	 8VQhuzWqNrGyGtUMPL4QUMxumVsnapdn1J+nk2RF6RUz8JY3HqgnQ0gXKl2Q0d83zX0gR
	 3WtPs8hWKjJzf3YTAtLXEkq1Z6x8GrK7Y9tnFujuVAyjeCKk5A07mCjiInGKB80DDDx9w
	 N3WgEO6KpaF3HzmxBq7nwA2vkEHRRTl5zrgXNHcRLAHlZZqi/SgfUNuzKBEkVb2aAsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=08eV2XAiVjxmfsbH6I3DbTNynEVjhNeu8FUTEU8oqBU=;
	b=gEuMdDHyeKv/N3TJOvXw9FeHGwKxt/N0XYo1EW9zV+UD7IniORzNYyra1qNlwqr4wAlT
	 wrMx+xsG6Im8ro8wO+TE4uuRSRI16C9oeFdvL4eahF9meobU8XN+apg+K5kMbRFKbN1E7
	 36fIpJBJZbZYoTb36IV6VU/J7wrLC5TimMKcMndesLS3CQBj8D1Mk3R1wonY/YIvtsGNF
	 gEHWpv7Qric8aEQebV90Sf4dUUlFW4qcGeI9EBsjE2kgXu1Z4RF5GToxVgpYcCIxlma9p
	 Lfs2H367At4+eI8t5dpRcT2CSffJJUCDi9jDDMMjRqXLZUzX5NNmH1ozhv/PETxSlRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1z19598;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFA606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95CFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1z19598
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dee593f18so612441f8f.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237014; x=1794841814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08eV2XAiVjxmfsbH6I3DbTNynEVjhNeu8FUTEU8oqBU=;
        b=O1z195988Jljkjo+w1onNDMM6Sul7zzACWe6cGOSs+r5z2ApsO7BCQRt38IfpwlnWL
         LFvxrd5GTsKc/a/vV1bUMwrhcKCiOTDiWnfg258vy7x6vRdnT8MYRQkMc7Ss5RkMSDtU
         BbiQ3hdux+naFGUnQmvmzkIk1oL+sQNJyt/12S3OE4wCWM/MOV7axvBCkRqtiUQYLmyc
         D30GvdRGmW6fM4psdv6ROu42+aoMjsuAyaT+dRBFil3pPTfpTXqCiRpNHPS8S2e7OXJd
         Ozi6DkAzihOPppCy9lLUNIxzhJcubC40+JNrDOO8IIPNyXUGM6RJq27Xf5i6V/J8gfzX
         6pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237014; x=1794841814;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08eV2XAiVjxmfsbH6I3DbTNynEVjhNeu8FUTEU8oqBU=;
        b=XAJby4sItp5VOEkTbw3nNkAEYvtTM1eQhwq/6nlgKWW1rPGmdjMTcfCprHuSp8VyTZ
         VWXc3PI04t6/j8u76RFddzm7tnnjqBro3FOgltn/o9rxK8Y60BHaunuZF01C8XmKtEo4
         O7XWL7IUonKJyyyUQCvAYBoOjigJCtO2LwI8GGrffyrtTphtqzEZMAgSjJLXZUblk0Yw
         fUkLNg7++H+Ajs4VDdD68Ug+RMC8vjFIwAvkK3xyaoh1aZ3Ku9RTPEuJAybkxrhAv67o
         WMahDgcQ8g9SDcqBA+TXrTCwge5clEGfKgMgl69RramlnKq8qoHxuZ7DVviz6rl8Akql
         0+Vw==
X-Gm-Message-State: APuU4Z9Qt2jp3BKlJX45Wi8znEn1CtCAZ9jJeeLpHQEJE4frmMB+AEmN
	2T1HE9X0FdcGYVniFQI6MavfrT+OrhjwCHOoJrMip1Vf9hWA9FieHDv/HSO/FsVzBPY=
X-Gm-Gg: AYBFou0DBTeVoLys7h2daf4Q1cdgceluB3sqEDUAIWXK5JGf+pcGrPeYOOc0dIk29I8
	EGLM+4nOgXrcCJvvG4zHQ1jtfYIDUvP23K7IfxrLD2XaXYcx93QFLCn5Xu2L4Fu5kAlWuERWKVN
	Iml15UYoktRiQeOlyap6ZEyrY3EOToFDTLq0dpS68TNAO/hLb3vB4vTrdsyUwek9hOMyJHUjl8p
	ztTiyv4BzKEIfmKjwWnq0ggFLvK6Spy4DATubUvVdcNMgVwdoPA8FWW7EVK/x1eK3wsD+L2HaS4
	MN4bDfhYuPAEZCWSWJ0ST5jR513Nx3e1bAY5XTyIIImVcjxz7j6cXQGqODz93R3LYg4o6Lz3t2/
	SFpuvSImGWYHfn2qtg7yYSCoq8RF+Wj0NDs/VlXirhCQMw5213dHxjLublbhTmfv1xr9FNomeWA
	H+qF5WkPtByLQDvJcTip4KJXIpYMeIPReMVsSsmktS2PcK5FbnXZfMaxdqbN9X0xh5rBr3cBiUp
	xj68nFBNDv6HYR5Z7U4HXQoK/v6UBNenrU4+JqnQj37BKTeS+wH6I/O66C+4dktoC2I6w9eaK83
	IUupvQGMaTz9aPhLcBObFYcnJRPB9RKv8Fhf5R4BU3QOh1YFB5AikkfXZAjA5KKJsPyTZmEXsTp
	7PXJNPjvNzZ3iT7Ihg74pK6HPyPY1QSasmYo=
X-Received: by 2002:a05:6000:2506:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-49586b30adfmr8700142f8f.8.1794237013558;
        Mon, 09 Nov 2026 07:10:13 -0800 (PST)
Received: from HP ([102.0.122.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49673b94dc1sm6013398f8f.16.2026.11.09.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:10:13 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy] Proposal draft v3: Improve how command arguments and options are scanned and parsed
Date: Mon,  9 Nov 2026 18:09:10 +0300
Message-ID: <20261109150910.169348-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261108175038.946313-1-tangajoris@gmail.com>
References: <20261108175038.946313-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This is the third draft of my proposal for "Improve how command
arguments and options are scanned and parsed" [1].

Changes since v2:
 - Moved the git daemon conversion into the plan, so the plan does
   not depend on the early-scan work.
 - Tried early_scan_options() in "git diff", and added what happened
   to 3B.
 - Removed the fallback of fixing the loop alone from the minimum
   outcome.
 - Updated the timeline.

I would be grateful for feedback on section 3, and on the questions
in section 7. I plan to start with stash show. If someone is already
working on one of these commands, please tell me and I will pick
another one.


1. About me
-----------
Name: Tanga Joris
Pronouns: he/him
Email: tangajoris@gmail.com
GitHub: https://github.com/tmjoris
Blog: https://tmjoris.github.io
Location: Nairobi, Kenya (EAT, UTC+3)

I meet all the Outreachy eligibility rules.

I am about to graduate from the United States International
University - Africa, where I study Applied Computer Technology. I
learned C at ALX, where it was my introduction to programming.

I had done some small parsing work before, in my own project, kiln
(https://github.com/tmjoris/kiln), a Go CLI that runs code in
sandboxes. "kiln -addr host:7070 run" works, but "kiln run -addr
host:7070" fails. This is because main() and each subcommand parse
their flags separately. Git has the same question of who looks at an
argument first, and what they do with it.

That work made me curious about how much goes on behind something as
seemingly simple as parsing command-line arguments. I enjoy that kind
of work: starting with something that looks straightforward,
following the implementation, and gradually understanding the
decisions and assumptions behind it.

Availability: 40 hours a week from 7 December 2026 to 8 March 2027.
I have no classes, exams or other work during the internship.
Nairobi is UTC+3, so my working day overlaps with European hours.


2. My Git work so far
---------------------
- Microproject: checkout: use Q_() for messages with counts [2].
  Merged to master in a04194e134.
- tj/drop-no-parseopt, v5 [3]. Four builtins used parse-options but
  were still marked NO_PARSEOPT, so completion never asked them for
  their options. The topic removes the flag from them, and adds a
  t0012 test that catches such builtins. Junio: "OK. Let's mark the
  topic as ready for 'next'."
- tj/annotate-blame-args [4]. I found it while trying to make
  --git-completion-helper work outside a repository. cmd_annotate()
  put "-c" in front of the user's arguments, so the helper option was
  no longer the only argument. The diff option parser answered it
  instead, and "git annotate --<TAB>" offered the options of
  "git diff". The "-c" was not needed, so the fix deletes code.
  Junio: "Nice simplification."
  Both topics are marked "Will merge to 'next'?" in What's cooking
  [5].
  Both topics merge cleanly on top of 'next', which has Christian's
  early-scan series, and t9300, t0040, t0012 and t9902 pass.
- apply: a fix for the "git apply --check" crash reported on the
  list [6]. While looking into it, I found two more ways to trigger
  the same assertion. Phillip asked for an error instead of accepting
  these broken patches, and I agreed. v2 will follow once we settle
  the details.
- A fix for the splitIndex bug that Andy Koppe reported on the list
  [7]. With core.splitIndex and index.skipHash both set, index
  entries are lost when a new shared index is written.
- Reviews:
  - Edson's credential conversion [8]. I suggested a helper for the
    code that was repeated in four functions, and a test for the
    check on extra arguments, which no test covered.
  - Azuama's rev-list early scan fix [9]. The tests failed without
    the fix, but --author, --committer and --grep-reflog had the
    same problem. Azuama's v4 skips their values too, and its
    NEEDSWORK comment now uses my "--author --missing-only" example
    [10]. Junio then asked for a different approach than a list of
    options in rev-list.c.
  - Joy's pack size limit patch [11]. 2/2 added a member to struct
    repo_config_values, which Junio had asked people not to do for
    now. So I asked whether 1/2 could be sent on its own, and Joy
    sent it as a separate patch [12].
  - Nelly's promisor.fetchOrder patch [13]. Setting the new variable
    made "git show" in a partial clone die with a BUG() in
    string-list.c, because an in-place split was used on a list that
    duplicates its strings.
  - shrimech's Rust patch for formatting object IDs [14]. "cargo
    test" passed and the new test failed without the fix. I asked
    whether algo 0 should be printed the way the C code does it.
    brian explained that algo 0 coming from C is meant to panic.


3. Plan
-------
Before the internship, I plan to land my two topics. If there is
time, I would also send one small git.c patch so that
--git-completion-helper works outside a repository, as was done for
--help-all last year. That patch needs both of my topics first.

To pick the commands, I started from the 29 builtins marked
NO_PARSEOPT in git.c. I also read builtins that loop over argv by
hand before or after their real parse. That is how I found stash
show and the --no-index loop in "git diff". I ran each
candidate on master (fb255012ac), and I was able to reproduce
everything below. Other places I found are in section 4.

A. Convert hand-written parsing to parse-options

  1. stash show. git stash show has a problem when somebody uses
     -G <word>, which keeps only the changes that mention <word>.
     Running "git stash show -p -Gbar" shows the diff of the patch,
     but running "git stash show -p -G bar" fails with "error: bar is
     not a valid reference". -S has the same problem.

     It fails because, after parse_options(), stash show runs a loop
     over each argument that is left over. If that argument starts
     with "-", it goes to the diff options. If it does not, it is
     treated as a stash name. That is also what happens to "bar".
     Since it is treated as a stash name, and it is not a valid one,
     the command fails.

     blame and shortlog do not have this problem. They parse their
     own options and the diff options together with
     parse_revision_opt(), so -G gets its value. I would do the same
     in stash show. What is left at the end would still be the stash
     name, so "git stash show 1" keeps working. Some options, like
     --all, are ignored today but would start to fail, so the commit
     message has to say so.

  2. Numbers in index-pack and fetch-pack. index-pack reads
     --max-input-size with strtoumax(). The issue is that it only
     reads the digits at the start, and silently ignores the rest of
     the characters:
       git index-pack --stdin --max-input-size=1k   limit of 1 byte
       git index-pack --stdin --max-input-size=abc  no limit
     So "1k" means 1 byte, and "abc" means 0, which means no limit.
     fetch-pack reads --depth with strtol() in the same way, so a bad
     depth fetches the whole history:
       git fetch-pack --depth=abc ../src HEAD       no depth limit
     The receive.maxInputSize config rejects "abc" and reads "1k" as
     1024, so --max-input-size and the config do not agree.

     These are plumbing, and Junio asked on the diff-files
     conversion whether converting is worth it for plumbing "meant
     for use by scripts" [15]. So I would send small fixes for the
     numbers, and convert the rest only if the list wants it.
     unpack-objects has the same --max-input-size code, so I would
     ask on the list whether to fix it in the same series.

  3. git daemon. It reads all its options by hand, in one loop of
     about 150 lines. --port is read with strtoul(), and nothing
     checks that the number is a valid port:
       git daemon --port=70000 ...    listens on port 4464, no error
     I would convert the loop to parse-options, with
     PARSE_OPT_STOP_AT_NON_OPTION for the list of directories. Other
     programs outside builtin/, like imap-send and scalar, already
     use parse_options(). Existing inetd and start-up scripts must
     keep working, so every argument form stays, and --no- forms that
     do not exist today stay rejected. The daemon re-runs itself with
     its original arguments and --serve, and parse_options() changes
     argv, so I have to keep a copy. Tests in t5570.

     Junio's question about plumbing [15] may apply here too. No
     other Git program runs git daemon, which is why I picked it over
     index-pack and fetch-pack. I would ask on the list first. If the
     list does not want it, I would send a range check for --port and
     pick another command with the mentors.

  For each command I will first add tests for what works today, like
  "git stash show 1". The test for the bug must fail before the fix.
  I will also break each new branch on purpose, to check that a test
  catches it.

B. Improve the early scan where "git diff" needs it

  Before parsing anything, "git diff" runs a small loop whose job is
  to look for --no-index. The loop's answer determines which parser
  reads the rest of the command line: either the no-index one or the
  normal one. An issue arises because the loop stops at the first
  argument that doesn't start with "-". So in "git diff -G x
  --no-index a b", it stops at "x", the value of -G, and never sees
  --no-index. Since it never saw --no-index, the loop picks the
  normal parser, which then gets --no-index as an option and fails
  with "invalid option".

  The opposite also happens. In "git diff -S --no-index HEAD~1 HEAD",
  "--no-index" is the value of -S, a search for that text. But the
  loop takes it for the option, so Git switches to no-index mode and
  fails with "Could not access 'HEAD~1'". Inside a repository, with
  a and b in the work tree:
       git diff -G x --no-index a b         error: invalid option:
                                            --no-index
       git diff -S --no-index HEAD~1 HEAD   error: Could not access
                                            'HEAD~1'
  With the value stuck (-Gx, -S--no-index), both work.

  Christian's v1 cover letter lists "git diff" among the commands
  that could use the early scan, but were left out because it "has a
  number of short options like `-S`, `-G`, `-O` taking separate
  values" [16]. Few people type --no-index after -G. But "git diff -G
  x ../a ../b" does not need --no-index at all, and it fails too.

  Junio asked in Azuama's rev-list thread whether a separate early
  scan is a good direction at all [17]. For "git diff" I think one
  is still needed, because --no-index decides which parser reads the
  rest of the command line. So it has to be found before either
  parser runs.

  The early scan has one rule that I find useful. It may miss an
  option that parse_options() would accept, but it must never report
  one that parse_options() would not. So when it is unsure, it stops.
  Missing an option is the safe failure.

  To see how far the scan gets today, I replaced the loop with
  early_scan_options() on top of 'next', with add_diff_options() and
  --no-index as its table. "git diff -S --no-index HEAD~1 HEAD" then
  works. But "git diff -G x --no-index a b" still fails, and these
  stop working:
       git diff -p --no-index a b
       git diff -U1 --no-index a b
       git diff -Gx --no-index a b
       git diff -w ../a ../b
  The scan stops at every short option, so it never reaches
  --no-index. t4053 still passes with this change, because it has no
  case with a short option before --no-index. So the scan has to
  step over short options first. For long options, patch 2/4 of
  Christian's series split lookup_long_opt() out of parse_long_opt(),
  so the scan can find them. Short options have nothing like that
  yet.

  Where the loop stops also decides when two paths outside the
  repository are treated as --no-index. So "git diff -G x ../a ../b"
  fails too, while "git diff ../a ../b" works. I will add tests for
  these cases first.

  Question: should I teach the scan to step over short options? Or
  would a smaller fix be better, where the loop looks options up in
  the add_diff_options() table? Junio called a hand-kept list of
  options "inherently fragile" [18], so I don't plan on adding one.


4. Other places I found
-----------------------
This is not in the timeline, but I would start it with the mentors
if there is time.

Revision options. handle_revision_opt() in revision.c parses the
options of log, rev-list, show and others by hand. Christian's v1
cover letter suggests converting them to struct option [16]. The
diff options were moved to parse-options in 2019, but the revision
options were not. This is core code, so I would only start it if the
mentors want it.


5. Timeline
-----------
Now to 6 Dec   Land tj/drop-no-parseopt and tj/annotate-blame-args.
Weeks 1-2      stash show: tests first, then the fix.
Weeks 3-4      The number fixes in index-pack and fetch-pack, and the
               "git diff" tests from 3B. This is the holidays, so
               small patches.
Weeks 5-7      Convert git daemon to parse-options.
Weeks 8-12     "git diff" --no-index, in the way the list prefers.
               RFC first if it changes the scan.
Week 13        Spare week for late reviews, and the final blog post.

Review on the list takes days, so the weeks overlap. While one series
waits, I work on the next one.

At minimum: stash show, the number fixes and the git daemon
conversion sent and reviewed, and the "git diff" tests and an RFC
sent. If I fall behind, the "git diff" work stops at the tests and
the RFC.


6. Communication
----------------
A blog post every week for Christian, and a short written update
every week for Siddharth, by email. The update says what I sent,
what is in review, what is blocked, and what I will do next week.
Design questions go to the list before code. I answer every review
comment on the list before sending another version, as Kaartic
reminded me to.


7. Questions for mentors
------------------------
1. Should I start with stash show, or would you pick another command?
2. Would you like to see the revision options work from section 4?
The question about "git diff" is at the end of 3B.


8. After the internship
-----------------------
I want to keep working on the early scan and the revision options,
and keep reviewing parse-options patches. I would also like to help
the next group of applicants the way reviewers on the list have
helped me.


9. References
-------------
[1] Proposal v2:
     https://lore.kernel.org/git/20261108175038.946313-1-tangajoris@gmail.com/
[2] Microproject, checkout: use Q_():
     https://lore.kernel.org/git/20261022004834.246892-1-tangajoris@gmail.com/
[3] tj/drop-no-parseopt v5:
     https://lore.kernel.org/git/20261105223458.1534785-1-tangajoris@gmail.com/
[4] annotate: pass the arguments to blame unchanged:
     https://lore.kernel.org/git/20261105073101.1449292-1-tangajoris@gmail.com/
[5] What's cooking in git.git (Nov 2026, #03):
     https://lore.kernel.org/git/xmqqmrrlfzcd.fsf@gitster.g/
[6] apply fix for "git apply --check":
     https://lore.kernel.org/git/20261107195429.96842-1-tangajoris@gmail.com/
[7] splitIndex fix:
     https://lore.kernel.org/git/20261108234235.1594316-1-tangajoris@gmail.com/
[8] My review of Edson's credential patch:
     https://lore.kernel.org/git/CAKrRMNqsh=d+_C8u+q1EBeQVwDZaywGQGZ89oYLyyvmB=8u1jw@mail.gmail.com/
[9] My review of Azuama's rev-list v3:
     https://lore.kernel.org/git/CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com/
[10] Azuama's rev-list v4:
     https://lore.kernel.org/git/20261105120937.10269-1-azuama69@gmail.com/
[11] My review of Joy's pack size limit v3:
     https://lore.kernel.org/git/CAKrRMNqzOX=vUUMrMf5P_Atar8_qCSbGdtBktfT+iL4hJfFX-Q@mail.gmail.com/
[12] Joy's separate patch for 1/2:
     https://lore.kernel.org/git/pull.2298.git.1793966368860.gitgitgadget@gmail.com/
[13] My review of Nelly's promisor.fetchOrder patch:
     https://lore.kernel.org/git/CAKrRMNpAW+f2XXMFqpB8ffZsTdyPsaFtHe8dku=JVXACp1M3Hw@mail.gmail.com/
[14] My review of shrimech's Rust patch:
     https://lore.kernel.org/git/CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com/
[15] Junio on the diff-files conversion:
     https://lore.kernel.org/git/xmqq8q3blfh1.fsf@gitster.g/
[16] Christian's early-scan v1 cover letter:
     https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.com/
[17] Junio on whether rev-list needs an early scan:
     https://lore.kernel.org/git/xmqqa4nlkelo.fsf@gitster.g/
[18] Junio on Azuama's rev-list v4:
     https://lore.kernel.org/git/xmqqwlqqokxr.fsf@gitster.g/

Thanks,
Tanga
