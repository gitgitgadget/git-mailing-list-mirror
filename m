Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908673;
	b=qWM8sZOkoQdGq9onhKWL80xp9JWfdho7JxWrPLDePvqi8nGYQPF36EJN/V7+oAITsWFm
	 ilu801Ov0qRRSZb9NhpSv1ppl/Z9+QjpJmeectCzX3ZNeq8Dlzi1lC5WU6+d1XR4Sxr/e
	 yUUYD+PHhiydtOFmgKpNLJ9CJkf8me8RXvNj41DsjxogGV3OX+NL2xb9jBKSAckx1tbxf
	 iyMZpwLlVsXTh0Pxdxnwh3TYyRoFhjmGNwDrARlkQFPpggL36fnwEVC/U884ghOCzIhJ1
	 QPLpHeYCsOZYvgMR3LTjCjWv9iCan6zMqpMRRfo5Fnwu2VS6dH92mHfh+nW89ek285w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m05ZrW0LahIFkJ+JGDjuDvziIBnBUxhXlEzuUCq4qRQ=;
	b=axpHZRA0jX6Vpx3Wf9GwTrZzSYZOb4AHgXU4de+2X/9rUXYDa+a+0f+tBT1Y7WET2d4L
	 tyJAKwbH0XySIJ8iMgLDCN0iOnYIU0SD0UoDapgWLBdxiEFlm3SYOBIYIHcStg9eEzCR4
	 LSSE5z8N1UBrWenyjDtyygKhu9tpdpUZ6kmI8XfpCAiGfnIliDJxdISkJbKV0d6DOH2sN
	 lj1O8p+0Qc4ZAWvy+V7uChG0LCpPS98UWttyoGc336wj9Ke6UMNvznmRHmM+9P8UliTC1
	 MQm7quFS+setV1Z5MHiU5VwqSU2AvVlDdEeUvxBQMad/NB1SqJ0FJpvwUnLiMEJ9NZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZKUPwNP;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46220606A332
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46220606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZKUPwNP
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c450ab1483cso23854666b.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793908672; x=1794513472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m05ZrW0LahIFkJ+JGDjuDvziIBnBUxhXlEzuUCq4qRQ=;
        b=XZKUPwNPup7lMPbfWJ3dA39JIVwI6wmOy0QdeNc9Cmfw5D1CC4iCBVeKCg58lBlVwu
         il3nv67ZzZQZGVligXyTnjQkyubw6IlQigHqXUUswraYFu7UJG3TrOzQAJ0rinDqEqFT
         UyJfOtoRRHGxAQDaJN+6wt9yxA9f3yoOBmOcKlgyWRHdvbortKiD+nwHuGwOV4KZ91Sk
         RFT/Wrn9u7UnRigECyoC2qoxZ3eKrFqSTpiL3akoJez1mxWSySPNgRzZNLludJUZGLPJ
         QO7b+g3c5RQ2eBmFKuRGWLK2FWhkTWpkg9UktEske9RhNDaVcyfF+m4QfZjKSL1RVCMK
         kRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908672; x=1794513472;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m05ZrW0LahIFkJ+JGDjuDvziIBnBUxhXlEzuUCq4qRQ=;
        b=JFLlmbjy6hBJup+3hXW9yCdjo5M7AD95FVnwKb8WhB5t89hUok/6kRjKs1qVI0Kgog
         23XC1qT1SxJtVsJ48bYYKEO2t2ENtwTscnbzthfdh1TzcCll0Ieod6v9BNma7HFRrGIM
         bbBuPVNPYveHXlJ3IYE6XNKUvnXVDINKRPcgH3TZH8k8Xk5AoILA6Aedyww2WkXRLFVb
         nNjFwQCE7EBC70pBdqxz9V32IyZw5wr6Y4ZIA8l8xs7hm1X8xAY7UEvmrDOyrwH1tNFo
         mRi3nzM1Uh2fExZ8MinwjHyFGi4AmCTnMEmPW4nvuG4OTUcRCMy6cAywEAQAIWf24zJX
         1RgQ==
X-Gm-Message-State: APuU4Z9JM+fpTpCzbHwKN25BeBzQ5zpZEq7SAorS/9UafbKdZzOw3aav
	WM5LbV++yx/jT5H/OWG7xgDjTKXUYM25OMXirl82+f/6k97+/2OLrXzgPcOLYdL4
X-Gm-Gg: AYBFou2wPyb5OP66RrKRiSagX4Zx3ANmAH9oy2ul2fXdJH0NWxnO65l1HMrbaOSQBA6
	jw3sOzP+jlbK44yvuIhZ9ZonGOKUpT/tycUrLRYyDIwPwiaEORfp90qoDBdbCuuXsscGe/sppYR
	qnuczWs03sRcH6ozfybWtjh2qQSGqDFN6KRLpeugzUx5YPX8/TDupT2q+8XFqRi2nwgiSeSj7S2
	VZHjFAW8AJ1668iV0o7Fde24k9eOqk6Za+ELtZKk6jruN2Sv40OB55vJOp7QFXJGh++rGYChabG
	l+1J7fLqsI6pEDXPOuAwXyT2pWA42CQLKO91w1qksfmJLNAj99aNMZXzvIVp/QLvQZdNaOIBXDu
	AIe2wPUxsFW+mcYvfQY3Qiou2Ch59DgLuRq8iMTQ6ctBCH69OEoVOd0sXAQhBD1JIciqnVK9g2C
	IIli4uaYeBjT1bwoHW8UCtDEsqX8MDocZmz64bZVWHpQgH9n+njxlCZOeAa/7OmB1yUHNjF9mIz
	Caln7DkD4WZqBcTr5X2XV95rPLdEY0veR/XPDS+5RkV1e09GeFbF6ub8w4sY7D04FzKWsD9QIcl
	1EjWM9ZNEsz1xC0n305J9Hlwcp6P6/A86WyMtngXk/7it6QyBFP0Ef7UgpnrranmGuUEfpa8OvS
	XlT8db5xzsSXSTKwgLIRg00gPMrbIYDoLfzI=
X-Received: by 2002:a17:907:6d0f:b0:c29:f5d8:9c78 with SMTP id a640c23a62f3a-c4d353a7a05mr42770066b.39.1793908671257;
        Thu, 05 Nov 2026 11:57:51 -0800 (PST)
Received: from HP ([105.163.158.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356a2760sm12770166b.57.2026.11.05.11.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:57:50 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy] Proposal draft v1: Improve how command arguments and options are scanned and parsed
Date: Thu,  5 Nov 2026 22:57:30 +0300
Message-ID: <20261105195730.1518433-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.386.gfebd08c307.dirty
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

This is the first draft of my proposal for the project "Improve how
command arguments and options are scanned and parsed" for the
December 2026 Outreachy round. I would be grateful for feedback,
especially on sections 4 and 5.

In short: before a command does any real work, it has to answer
requests like "-h", "--help-all" and "--git-completion-helper". Today
that happens in three places that do not agree. On master, all 120
builtins that use parse-options answer "-h" outside a repository,
but only 31 of them answer "--git-completion-helper" there. I would
like to make these entry points behave the same for every command,
guard that with tests, and then move the early scanning of options
towards parse-options itself.


1. About me
-----------
Name: Tanga Joris
Pronouns: he/him
Email: tangajoris@gmail.com
GitHub: https://github.com/tmjoris
Blog: https://tmjoris.github.io
LinkedIn: https://www.linkedin.com/in/joris-tanga
Location: Nairobi, Kenya (EAT, UTC+3)

I also meet all the Outreachy eligibility rules.

I am a curious developer who loves playing around with systems.
Identifying and solving technical problems is my jam, because it
gives me the sense that I am making an impact somewhere. I am about
to graduate from the United States International University - Africa,
where I study Applied Computer Technology. I've had the luxury of
playing a lot with C during my time learning at ALX, where it was my
introduction to programming.

I first met this kind of parsing problem in my own project, kiln
(https://github.com/tmjoris/kiln), which is a Go CLI and daemon that
runs code in Firecracker or gVisor sandboxes. Its main() parses
the global flags with flag.Parse(), which stops at the subcommand,
and each subcommand parses the rest with its own flag.FlagSet. So
"kiln -addr host:7070 run" works, but "kiln run -addr host:7070"
fails with "flag provided but not defined: -addr". Git has the same
question of who looks at an argument first, and what they do with it.

Availability: 40 hours a week from 7 December 2026 to 8 March 2027.
I have no classes, exams or other work during the internship.
Nairobi is UTC+3, so my working day overlaps with European hours.


2. My Git work so far
---------------------
Microproject: checkout: use Q_() for messages with counts
  https://lore.kernel.org/git/20261022004834.246892-1-tangajoris@gmail.com/
  Topic tj/checkout-orphan-more-plural, merged to master in
  a04194e134. v2 reworded the log message as Junio suggested and
  also converted "only one reference expected, %d given." after
  Tuomas's comment.

Series: drop NO_PARSEOPT from builtins that use parse-options
  v1: https://lore.kernel.org/git/20261024052449.95869-1-tangajoris@gmail.com/
  v4: https://lore.kernel.org/git/20261105003914.708836-1-tangajoris@gmail.com/
  Topic tj/drop-no-parseopt.

  patch-id, diff-pairs, fast-import and var use parse-options but
  were still marked NO_PARSEOPT, so bash completion never asked them
  for their options. René noticed that once fast-import was
  unmarked, "git fast-import --<TAB>" would wait for input, because
  fast-import reads its "feature" lines before it parses options. My
  v2 special-cased that in fast-import. Junio found it "way too ugly
  to target this so specifically" and suggested teaching
  show_usage_with_options_if_asked() to answer the completion helper,
  which v3 does. In v4, Kaartic's review added a pointer to the next
  commit, a comment in parse-options.h, and a t0012 test that catches
  builtins that use parse-options but are still marked NO_PARSEOPT.
  Cynthia showed that my test did not cover the "-all" form. When I
  tried her test I found it still passed with the fix reverted, so I
  added the leftover tmp_pack_* check to it.

  The lesson I took from Junio's comment is the one this proposal is
  built on: when a command has to answer something before it starts
  working, the answer belongs in the shared place every command
  already goes through, not in one command.

Patch: annotate: pass the arguments to blame unchanged
  https://lore.kernel.org/git/20261105073101.1449292-1-tangajoris@gmail.com/
  cmd_annotate() put "-c" in front of the user's arguments, so
  "--git-completion-helper" was no longer the lone argument and the
  diff option parser answered it instead. "git annotate --<TAB>"
  offered the options of "git diff", without --porcelain. I found it
  while trying to make the completion helper work outside a
  repository (section 4.A): with only that git.c change,
  "git annotate --git-completion-helper" segfaults there.
  Junio: "Nice simplification." ... "Looking good. Thanks."

Bug triage: "Git crashed on `git apply --check`"
  https://lore.kernel.org/git/CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com/
  I reproduced the assertion failure and found the trigger in the
  reporter's file: a blank line after the "diff --git" line of a
  new-file section. An indented "new file mode" line and a
  "--- /dev/null" before "new file mode" crash it too. All three still
  crash on master; the fix is my next patch.

Reviews:
  rev-list: skip --grep argument in early scan (Azuama), v3
  https://lore.kernel.org/git/CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com/
  The tests fail without the fix, but --author, --committer and
  --grep-reflog still have the same problem, and the NEEDSWORK
  example above the loop becomes stale.

  promisor-remote: honor promisor.fetchOrder when trying remotes (Nelly)
  https://lore.kernel.org/git/CAKrRMNpAW+f2XXMFqpB8ffZsTdyPsaFtHe8dku=JVXACp1M3Hw@mail.gmail.com/
  Setting the new variable makes "git show" in a partial clone die
  with a BUG() in string-list.c, because an in-place split is used on
  a list that duplicates its strings.

  hash: handle invalid algorithms when formatting object IDs
  (shrimech, Rust)
  https://lore.kernel.org/git/CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com/
  "cargo test" passes and the new test panics without the fix. I
  asked whether algo 0 should be printed the way the C code does it.

  config: move pack size limit into repo config (Joy), v3
  https://lore.kernel.org/git/CAKrRMNqzOX=vUUMrMf5P_Atar8_qCSbGdtBktfT+iL4hJfFX-Q@mail.gmail.com/
  2/2 adds a member to struct repo_config_values, which Junio's
  jc/freeze-repo-config-values asks not to do for now, and v3
  conflicts with cc/pack-index-v3 in 'seen'.

Blog: https://tmjoris.github.io ("From git config to git
send-email", about my first weeks on the list).


3. Where commands look at their arguments today
-----------------------------------------------
Before a builtin's real option parsing runs, its arguments can be
looked at in three places:

  1. git.c, run_builtin(): decides whether to set up the repository.
     A lone "-h" or "--help-all" turns RUN_SETUP into
     RUN_SETUP_GENTLY, so "git cmd -h" works outside a repository.
  2. show_usage_with_options_if_asked(): called by 15 builtins that
     must answer before doing any work (fast-import reads its input,
     others need a repository). With my series it answers -h,
     --help-all and both completion helpers.
  3. parse_options() itself answers them for everyone else, but only
     when the request is the lone argument.

Then there are the early scans: commands that read a few options
before the real parse, such as fast-import's
--allow-unsafe-features, column's --command, and the hand-written
loop in rev-list (the one Azuama's patch touches, whose NEEDSWORK
comment calls it "utterly broken"). Christian's cc/early-scan-options
gives them early_scan_options(), which reads the same struct option
array as parse_options(). Junio's view on its first round is the
direction I want to follow: "in the long term we would rather see a
properly refactored parse-options machinery perform the prescan
(perhaps with some kind of 'dry-run' option given to the machinery)
than yet another ad-hoc parser".

Junio was also clear, on the diff-files conversion, that converting
a parser is not worth it on its own for plumbing "meant for use by
scripts". So in this proposal every change has to fix something a
user can see, or remove a place where two parsers can disagree.


4. Plan
-------
A. Make the entry points agree (weeks 1-4)
   - Teach git.c to set up gently for --git-completion-helper and
     --git-completion-helper-all, as 129b3632f3 did for --help-all,
     so that completion works outside a repository. This needs my
     NO_PARSEOPT series and the annotate fix first: with the git.c
     change alone, annotate, am, ls-files and checkout-index
     segfault outside a repository, and branch, commit, merge,
     rebase, status and update-index hit a BUG(). With all three,
     all 124 parse-options builtins answer there. Add the case to
     the per-builtin loop in t1517-outside-repo.sh.
   - Look for other commands that rewrite their argv before handing
     it to another cmd_*(), the way annotate did.
   - Turn the checks I ran by hand into tests: t1517 for "outside a
     repository", t0012 for "parse-options users are not marked
     NO_PARSEOPT", and a check that no helper reads stdin.

B. Conversions only where there is a concrete reason (weeks 4-8)
   - merge-index: -o and -q are only recognised in that order. On
     master:
       git merge-index -o -q cat -a   -> works
       git merge-index -q -o cat -a   -> fatal: git merge-index: cat
                                         not in the cache
     Parse the leading options with parse-options and
     PARSE_OPT_STOP_AT_NON_OPTION, and drop its NO_PARSEOPT mark.
     Tests in t6060.
   - Early scans that disagree with the real parse, like the
     rev-list loop above, but only with a reproduced user-facing bug.
     column, bisect and check-ref-format are in Cynthia's plan, so I
     would not touch them.

C. Towards parse-options doing the prescan (weeks 8-13, RFC first)
   Christian's series already lets the scan and the real parser look
   options up the same way. The scan still stops at short options and
   at options with low-level callbacks, because it cannot run them.
   I would like to study what a "dry run" mode of parse_options()
   would need (no writes through opt->value, no callbacks, no die()),
   send that to the list as an RFC, and implement the first step only
   if the design is agreed. Otherwise it becomes the final report's
   list of open problems.

Every change is tested first: the test must fail on master, every new
branch must make a test fail when I break it on purpose, and output
and exit codes are compared with master. That is how I found the
annotate bug.


5. Timeline
-----------
Now to 6 Dec   Land tj/drop-no-parseopt and the annotate fix. Send
               the git apply fix. Keep reviewing parse-options patches.
Weeks 1-2      git.c gentle setup for the completion helper, with the
               t1517 test. First blog post.
Weeks 3-4      Turn the outside-repository checks into tests; look
               for other argv-rewriting wrappers like annotate.
Weeks 5-8      merge-index; early-scan fixes with a reproduced bug.
Weeks 8-11     "dry run" study and RFC on the list.
Weeks 11-13    First step of the RFC if agreed, otherwise the open
               problems report. Rerolls, final blog post.
Every week     A blog post and a written update to the mentors.

If I fall behind, I drop C's implementation first (keeping the RFC),
then B's early-scan items.


6. Communication
----------------
Design questions go to the list before code. I answer every review
comment on the list before sending another version, as Kaartic
reminded me to. I will blog every week at https://tmjoris.github.io,
which anyone can read without an account, and link each post on the
list.


7. After the internship
-----------------------
I want to keep working on whatever is left in the final report,
especially the parse-options dry run, keep the entry-point tests up
to date as commands change, and keep reviewing parse-options patches.
I would also like to help the next group of applicants the way
Kaartic, René, Junio and Cynthia helped me.


8. References
-------------
[1] Microproject: https://lore.kernel.org/git/20261022004834.246892-1-tangajoris@gmail.com/
[2] tj/drop-no-parseopt v1 and René's review:
    https://lore.kernel.org/git/20261024052449.95869-1-tangajoris@gmail.com/
    https://lore.kernel.org/git/8b60c7f6-4a1c-495a-a594-aaf322279539@web.de/
[3] v2 1/2 and Junio's suggestion:
    https://lore.kernel.org/git/20261029012616.139783-1-tangajoris@gmail.com/
    https://lore.kernel.org/git/xmqqy0bg2xj5.fsf@gitster.g/
[4] v3, Kaartic's and Cynthia's reviews, and v4:
    https://lore.kernel.org/git/20261029231621.48958-1-tangajoris@gmail.com/
    https://lore.kernel.org/git/123de4e4-3387-4eef-8a05-9ed1ad1fce30@gmail.com/
    https://lore.kernel.org/git/d026d6a0-5b1b-4bbf-bd1f-5f41c9c2a4e4@gmail.com/
    https://lore.kernel.org/git/20261103092503.14872-1-herroyalpriestess@gmail.com/
    https://lore.kernel.org/git/20261105003914.708836-1-tangajoris@gmail.com/
[5] Junio on the early-scan v1 cover (long-term direction):
    https://lore.kernel.org/git/xmqqpkyviizc.fsf@gitster.g/
[6] Junio on diff-files v6 (value of converting plumbing):
    https://lore.kernel.org/git/xmqq8q3blfh1.fsf@gitster.g/
[7] 129b3632f3 (builtin: also setup gently for --help-all, 2025-08-03)
[8] cc/early-scan-options v4:
    https://lore.kernel.org/git/20261102151447.734680-6-christian.couder@gmail.com/

Thanks,
Tanga
