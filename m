Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160263;
	b=M+WmnxT2utqPz+teQN1NbbQbnWAxMVJTfeGZ2gH8nAzQXluy5cIiTKHt58bF7bBQvyFm
	 Cz+l+2VqM/2op6CxmPT1agKKHNGV/qhAA/PBD6K46+xnltT6/IzdmmlOZCG5I4zs9JOMk
	 sETGlrfyRdL2RTrbHlgrD4JG5JbbpRFzguVTeQkmY2wGPb9AvVpNOdz/JQ1lvLMK68I0U
	 m7t1dnrIXbZo+TrSuFvwjAnvGClagqI05qTC0QFJT8diQuCUN9vsJxJ2ZeD9yJII08HzK
	 jKPf2RirVK6/Rn+bAxU8HX7mYmExxt4q5Ev31T0rpqpnnieFiPhkMyQ0Ql/DxP+moag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bQEwTsGLI60P0D3e67GuxTBGA9ZdIA35oRYcZy0mrMw=;
	b=4Ds3jg6Pi5JZvGpX3xQCas4OXjiotp0R8jFPY2HKRzoMbetHDGw1nkKr6Jn/+cX+THdH
	 dTqEKJOO1Jpjer6OTvrc6QDbMstO0BTQAz27fi2nEJ1kb5b882lqCT6kJlbyDQwixNSua
	 0lKWoE8HqyRHOulSfjZcyfjpq/BMku63Vr/GY7cqrLee6jHdS6eoiUoV+wpDz7XPOqAQ5
	 L2Xzf22PXlda18RnpPRnt6h9Bg5QvenAlZF63R0dGoXEWXLzhwl+nkYHpGjilj2WHd7NP
	 jQ7xi4mObh3mcq8Y/GpE8mMbgoQvXBFLnKb6e0pnKZffmknkfL9pyCabQnaRksQSUNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aK4vFtnh;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE86606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aK4vFtnh
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4922523d1afso93441f8f.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160261; x=1794765061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bQEwTsGLI60P0D3e67GuxTBGA9ZdIA35oRYcZy0mrMw=;
        b=aK4vFtnh5vB4rl6O02i4jA+fAp8NESXK+vxMnZI6k8pqheAAnUIGbvaK2AVAQOm7/v
         IP4UsxCpWoloGnqzMFJ7ms7VltPA7o1K2NI7TdK56ZxIoIujZL7tgLa9PhiUWjiFX73s
         iAabGxZ8/Z1FZfh3TokM2RwXG3SlQeGZrzOM3Lb7FLdyx3iYk1+hWAQ+ZlOYUfz2o2Z+
         ncpF3Gvdjv+qiafzkpVx+1hxzRwkq6CU+v3xJ9tHLIZfRFgNesTX35XZ1ku3YfgvlX0E
         rHUm4o2XHDQkxu9jWHfIpUWe7JwCRnrdPRtxY9VJ2o+/NM2nqFDRBEQzNdUftoTiP77L
         hmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160261; x=1794765061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQEwTsGLI60P0D3e67GuxTBGA9ZdIA35oRYcZy0mrMw=;
        b=fCP5YoZMecMgObcqWEIB2IXDx3IXasMRPEOvIwJavhgaDUx3eGI+mKoBXCdfYmq4v2
         MQ8rCVYE65gBeZpAV2/vlipeuOFpmJJ+eYXKl1c04QFzx25ujtTl0VCFft3iQhiksqI/
         ClKvKm1HjQAYw7WvCR7H2lqOaPiR5QkzL1/RY13iAZ3u+K1IM2dtVbGlA4FirFAUrgL0
         xd5cyMgxgoHTdAhuEOTllLgSX7/5x2X/ZUfhsbafIeBsV7RGa4/n5Ngw6tcJFEeFiWlc
         Kd9UdaeblfEQv63O0v0g+HaVEo0Kb2A7C313Rxam6fqnDIBUbVQGStTJCGThVaK0rF3E
         bnpQ==
X-Gm-Message-State: APuU4Z/BzjrVEgrNGT9zXa98Rpp4jx+QuFaHmTBbGMoCjAODuYLgMPvA
	x6OENzavRdDWkjBJCKlYMEpXlUzF986Sxl1rEx3hjh/hzA3ZR702MUildnOozoX9Ldc=
X-Gm-Gg: AYBFou31iumztjWlm1oz0k1KylaKQaXmojgEPC0bAfZjSAVbpgay1nG0aw+NqXHcD0O
	FOJYcppKL3riq4grY2TjGNen5GdKMe5VrWhQwk4MVoYO4Bg4tfg+NYM2eyJDvDUgVzJsUuCsf6D
	jvc6Hae/zbtZ3QyWMcCAK54V4pUVmocDJvuzQbmfxgRAqzpB/aCSwyInBAHudj1Nb8972pMh72N
	/zChyLnA6iDBLgxkQIIIIhcdZVSLlXSzbYlybvR9fO+xYjO55wIaE886n67z+kVmpzJtlR2c71r
	QLtFJw/u/urW/ZyPv8zxKfh3lBXKWDV215Wb8QxhgC7kOsowHjFGlRzs5NFWIrJlEU86xZPTHl4
	5okQF6yGNd0c85Whn9A8sj9uVXopEEpmwD04H3TI+6W4dD0HoQPcfPCkhQ4pJhqrE5nOes3ifoU
	NDhj+lCQUpzU8E/Mpk1oY3Z8ljM0k3rKvrobooFBLarXERbv9BI8cwDPykd4bOq5qziJjZLNWGK
	FIRWYUFSeX97unUKbQvwvGwJexUOIvKhNQU/2iUpjlrH/nG7C5gLP+K6gVfY61ePCgJLpglRrZs
	17kFZSxfPv93NMvjhEwqAr+zomi13u9/MmsDRI/FUbcTxf/HtB0XL+2pHbtLyuW4kthk072kczn
	sUEMcOInJyOBdYwa4BJk63Tw7V8G45rUZ9Mm70N3pTH+dSiZe7OX2jg==
X-Received: by 2002:a05:600c:c166:b0:4a2:fe11:9a8a with SMTP id 5b1f17b1804b1-4b943f77038mr38523425e9.0.1794160260746;
        Sun, 08 Nov 2026 09:51:00 -0800 (PST)
Received: from HP ([102.0.122.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb0b0c2sm149137425e9.8.2026.11.08.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:51:00 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy] Proposal draft v2: Improve how command arguments and options are scanned and parsed
Date: Sun,  8 Nov 2026 20:50:38 +0300
Message-ID: <20261108175038.946313-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261105195730.1518433-1-tangajoris@gmail.com>
References: <20261105195730.1518433-1-tangajoris@gmail.com>
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

This is the second draft of my proposal for "Improve how command
arguments and options are scanned and parsed" [1].

Changes since v1:
 - v1 was mostly about making the entry points agree. The project
   page asks for converting hand-written parsing and improving the
   API where needed, so I rebuilt the plan around that.
 - Added the commands I plan to work on, with what I saw when I ran
   them on master.
 - Moved the completion helper work to before the internship.
 - The plan has three items: stash show, the number fixes, and "git
   diff". For "git diff" (3B), I ask the mentors which way to go.
 - Added section 4 with other places I found, like git daemon and
   the revision options.
 - Shortened everything else.

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

I had done some small parsing work before, in my own project, kiln,
and it made me curious about how much goes on behind something as
seemingly simple as parsing command-line arguments. I enjoy that kind
of work: starting with something that looks straightforward,
following the implementation, and gradually understanding the
decisions and assumptions behind it.

kiln (https://github.com/tmjoris/kiln) is a Go CLI that runs code in
sandboxes. "kiln -addr host:7070 run" works, but "kiln run -addr
host:7070" fails. This is because main() and each subcommand parse
their flags separately. Git has the same question of who looks at an
argument first, and what they do with it.

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
- apply: a fix for the "git apply --check" crash reported on the
  list [6]. While looking into it, I found two more ways to trigger
  the same assertion.
- Reviews:
  - Azuama's rev-list early scan fix [7]. The tests failed without
    the fix, but --author, --committer and --grep-reflog had the
    same problem. Azuama's v4 skips their values too, and its
    NEEDSWORK comment now uses my "--author --missing-only" example
    [8]. Junio then asked for a different approach than a list of
    options in rev-list.c.
  - Joy's pack size limit patch [9]. 2/2 added a member to struct
    repo_config_values, which Junio had asked people not to do for
    now. So I asked whether 1/2 could be sent on its own, and Joy
    sent it as a separate patch [10].
  - Nelly's promisor.fetchOrder patch [11]. Setting the new variable
    made "git show" in a partial clone die with a BUG() in
    string-list.c, because an in-place split was used on a list that
    duplicates its strings.
  - shrimech's Rust patch for formatting object IDs [12]. "cargo
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
     for use by scripts" [13]. So I would send small fixes for the
     numbers, and convert the rest only if the list wants it.
     unpack-objects has the same --max-input-size code, so I would
     ask on the list whether to fix it in the same series.

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
  values" [14].

  Junio asked in Azuama's rev-list thread whether a separate early
  scan is a good direction at all [15]. For "git diff" I think one is
  still needed, because --no-index has to be found before either
  parser runs.

  But early_scan_options() cannot be used here yet. It needs a list
  of the options, and "git diff" does not have one in a single place.
  It also stops at every short option, like -G, so it would first
  have to learn to step over them. For long options, patch 2/4 of
  Christian's series split lookup_long_opt() out of parse_long_opt(),
  so the scan can find them. Short options have nothing like that yet.

  Where the loop stops also decides when two paths outside the
  repository are treated as --no-index. So "git diff -G x ../a ../b"
  fails too, while "git diff ../a ../b" works. t4053, the test script
  for --no-index, has no case with a short option before --no-index.
  So I will add tests for these three cases first.

  Either way, the loop should not keep its own list of the options
  that take a value. In his reply to Azuama's v4 [16], Junio called
  that approach "inherently fragile".

  Question: should I work towards using the early scan here, or would
  you rather see the loop in "git diff" fixed first?


4. Other places I found
-----------------------
These are not in the timeline, but I would pick one of them with the
mentors if there is time.

git daemon. It reads all its options by hand. --port is read with
strtoul(), and nothing checks that the number is a valid port:
       git daemon --port=70000 ...    listens on port 4464, no error
       git daemon --port=0x2329 ...   listens on port 9001
A small fix would be a range check. A full conversion to
parse-options has to keep every argument form working, because
existing inetd and start-up scripts call it with those arguments.

Revision options. handle_revision_opt() in revision.c parses the
options of log, rev-list, show and others by hand. Christian's v1
cover letter suggests converting them to struct option [14]. The
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
Weeks 5-10     "git diff" --no-index, in the way the list prefers.
               RFC first if it changes the scan.
Weeks 11-12    Rerolls, or the git daemon range check if there is
               time.
Week 13        Spare week for late reviews, and the final blog post.

Review on the list takes days, so the weeks overlap. While one series
waits, I work on the next one.

At minimum: stash show and the number fixes in 'next', and the "git
diff" tests and a fix sent and discussed. If the list does not want
the early scan there, the fix is the loop in "git diff" alone. If I
fall behind, I drop the section 4 item first.


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
2. Which item from section 4, if any, would you like to see after
   that?
The question about "git diff" is at the end of 3B.


8. After the internship
-----------------------
I want to keep working on the early scan and the revision options,
and keep reviewing parse-options patches. I would also like to help
the next group of applicants the way reviewers on the list have
helped me.


9. References
-------------
[1] Proposal v1:
     https://lore.kernel.org/git/20261105195730.1518433-1-tangajoris@gmail.com/
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
[7] My review of Azuama's rev-list v3:
     https://lore.kernel.org/git/CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com/
[8] Azuama's rev-list v4:
     https://lore.kernel.org/git/20261105120937.10269-1-azuama69@gmail.com/
[9] My review of Joy's pack size limit v3:
     https://lore.kernel.org/git/CAKrRMNqzOX=vUUMrMf5P_Atar8_qCSbGdtBktfT+iL4hJfFX-Q@mail.gmail.com/
[10] Joy's separate patch for 1/2:
     https://lore.kernel.org/git/pull.2298.git.1793966368860.gitgitgadget@gmail.com/
[11] My review of Nelly's promisor.fetchOrder patch:
     https://lore.kernel.org/git/CAKrRMNpAW+f2XXMFqpB8ffZsTdyPsaFtHe8dku=JVXACp1M3Hw@mail.gmail.com/
[12] My review of shrimech's Rust patch:
     https://lore.kernel.org/git/CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com/
[13] Junio on the diff-files conversion:
     https://lore.kernel.org/git/xmqq8q3blfh1.fsf@gitster.g/
[14] Christian's early-scan v1 cover letter:
     https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmail.com/
[15] Junio on whether rev-list needs an early scan:
     https://lore.kernel.org/git/xmqqa4nlkelo.fsf@gitster.g/
[16] Junio on Azuama's rev-list v4:
     https://lore.kernel.org/git/xmqqwlqqokxr.fsf@gitster.g/

Thanks,
Tanga
