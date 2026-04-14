Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6D2C3255;
	Tue, 14 Apr 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180166; cv=none; b=sRZfbqjm0dzMNgePsxvpyLyFUn0zyMzsFwxX+TfIrxOrhrR28ByNW9WxQew2CVba4suM5Qn2dAPPa/SHfah2pJLK2anzScHogM5Hfoygl9VvaPGzJDQ2hBHDP+Q15q95CBEMjCPocgajE4djO6jhqJ87SwHBbuwgMwiabqaDBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180166; c=relaxed/simple;
	bh=FObqsGql8QPbH3lp82OS8zjshxupvvPQCLf8doaqEI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CejMjCSJAHj72PhwcrssMxmbm0tKlRYHqbFtIr6+l+ZQnngUm1e3SF6qrKfEeadqsZInA4vruuKFWLomQIhFnmNnR/pE/q11mrltpQOx2I9/MZecHJw/dDR0yMnxST+UNNVHYhEnjCmx+y2AK4V5prInvtbhSpqzmt7TArhTHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GFWeDV0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EbIYUnjN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GFWeDV0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbIYUnjN"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 21D7F1D0014C;
	Tue, 14 Apr 2026 11:22:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 14 Apr 2026 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776180160; x=1776266560; bh=DZ
	VlDZL5YJYoiAb2RMjxKetWM0Ff3L4Ze57uLtGSSvo=; b=GFWeDV0yoQOHRtdhTQ
	JLv9kkDBVzZOB9DPJLEK5wJzNF6jnnPzXTLqBgYSWeDg1QW7rovj8IKIR63+ycAu
	evWHP52gSibwDNPYZN3ABCHoM04L4cRuTev6ys1N+QBaTW6gmEk4xjzHGds1dYlE
	MwwnfvX6fb9E4VAyptO2rfCcCDZg+/nd/zN436Kii1SreNuo2mpepAGsVNvnOm5o
	IoRuieFJdQbJUfWs3uCV0j+ulQ5qgS34dfddetG7jlx5k+gDFgPrYdqv9HEBh/A/
	GPOp7wrqALY7ieFfbtm0lM2HW+M4rkColifBj6dXX9DppMEduOzgFAHwQfauLCgY
	Zz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776180160; x=1776266560; bh=DZVlDZL5YJYoiAb2RMjxKetWM0Ff
	3L4Ze57uLtGSSvo=; b=EbIYUnjNK2XirsbTyqlx1DPUoTeGh8XzI+NCfFJxK+dl
	wBk5TlQcqcH68rj0Vfbime1SS9NufqkkPFgq1FWnAnEoqep/HCvKmuyjlh54lGE8
	wyrVzNF/agcH6UwrRlHKCSDbAVPh3JssFPJXUMfmuLvIf30Lt3PSbehxxpEaX9kg
	QJp3YZh6Teod9RR1Yj0Hc9itiPJcQKAUe0BPu1SMCskPUJBaL665DSRfvhwxmDSg
	zAf2cdokCIOSEpU/Els4ITdWxG7DRJOwXfc8U2MzIGTbVHlcMqsf6YkJJ+NyEz8r
	Kubu4WgzCw7Ybqpz5pKwnEzGImvrEaJueMxVIDvOXQ==
X-ME-Sender: <xms:wFveaWsi1U71H-L4WqAR4YOpzHdTHncVuX0QcamrRM7RfK7OO5twCA>
    <xme:wFveac_z8BfWRiTpAH537VBVVJMivlIe0eEY2O26O7P0A0SsDRiXgQw8huftWw-p0
    VvLNv6rSKR0srDgHQvs20vi2fVR7a5_qH6ej4_IWzi9Vhjdp5wM>
X-ME-Received: <xmr:wFveaR2GjSbFoPyqndlSd1bTmJ4Bc0oed8463mRWwlqsUQzyIp-aiLAapFxsHPoTO7T3XMrz8WcxK4Cdr7TwiTvKYd6u2AJfrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptdeggedtvefhieevvdehgeffffefffegleeugffhfeetgffhjedvffegffefgeeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhoohhglhgvshhouhhrtggvrdgtoh
    hmpdhorhdrtgiipdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghr
    shesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplhifnheslhifnhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wFveaRCCeF1LLtFzCV83P08v_LfStgORozJI4qqH89_xFlS97u7vlQ>
    <xmx:wFveadcIIy5t-DiD69EGfdtRLS22b3nX-VUzOpz6isgkDOCTJKX_dQ>
    <xmx:wFveae4uga5U5m3uYF_Fm-qmesUuSF2nm05t5eLDrB10HiPvLxQZgw>
    <xmx:wFveaQUqVk0lWvjzimtwm4GDOb9WseiqNpQjQpYwJ6rVKveATE2xfg>
    <xmx:wFveaUCk3EbGQ6ZWKKgZBXJNywqSuJhfsKj08rmRhjF1DGdzlJBDJOVu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 11:22:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.54.0-rc2
Date: Tue, 14 Apr 2026 08:22:38 -0700
Message-ID: <xmqqqzohd0sh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A release candidate Git v2.54.0-rc2 is now available for testing at
the usual places.  It is comprised of 744 non-merge commits since
v2.53.0, contributed by 127 people, 64 of which are new faces [*].

Relative to Git 2.54-rc1, it contains many minor but a few notable
clean-ups like reverting the writev() series that had portability
issues.  Hopefully we can tag the final next week without having to
do any major last-minute scrambling.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.54.0-rc2' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.53.0 are as follows.
Welcome to the Git development community!

  Abdalrhman Mohamed, Aditya, Amisha Chhajed, Andrew Au, Ashlesh
  Gawande, Ashwani Kumar Kamal, Bilal El Khatabi, Burak Kaan
  Karaçay, Chris Darroch, Chris Idema, Christian Heusel, Claus
  Schneider(Eficode), cuiweixie, Dan Drake, Daniel D. Beck, David
  Timber, Eric Ju, Francesco Paparatto, Gabriel “gabldotink”,
  Guillaume Jacob, Gusted, HodaSalim, Jakob Haufe, Jayesh Daga,
  Jialong Wang, Joaquim Rocha, Jo Liss, Jonatan Holmgren, Lambert
  Duclos-de Guise, Li Chen, LorenzoPegorari, Luca Stefani, Lukas
  Wanko, Mahi Kassa, Mansi Singh, Matěj Cepl, Matthew Gabeler-Lee,
  Matthias Beyer, Michael Montalbo, Mirko Faina, Nick Golden,
  Omri Sarig, Pablo Sabater, PRASHANT S BISHT, Quentin Bernet,
  Ritesh Singh Jadoun, Rito Rhymes, Runxi Yu, Sahitya Chandra,
  Samo Pogačnik, Samuel Thibault, Scott Baker, Seth McDonald,
  Seyi Kufoiji, Shannon Barber, Siddharth Shrimali, SoutrikDas,
  Trieu Huynh, Vaidas Pilkauskas, Wang Zichong, Wolfgang Faust,
  Yannik Tausch, Yuvraj Singh Chauhan, and Zakariyah Ali.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Aaron Plattner, Abraham Samuel Adekunle, Aditya Garg, Adrian
  Ratiu, Beat Bolli, brian m. carlson, Chris Packham, Christian
  Couder, Christoph Anton Mitterer, Colin Stagner, Collin Funk,
  D. Ben Knoble, Derrick Stolee, Deveshi Dwivedi, Elijah Newren,
  Emily Shaffer, Eric Sunshine, George, Han Young, Harald Nordgren,
  Jacob Keller, Jean-Noël Avila, Jeff King, Jiang Xin, Johannes
  Schindelin, Johannes Sixt, Junio C Hamano, Justin Tobler, Karthik
  Nayak, K Jayatheerth, Koji Nakamaru, Kristoffer Haugsbakk, Lucas
  De Marchi, Lucas Seiki Oshiro, Matheus Tavares, Mathias Rav,
  Matthew Hughes, Matthew John Cheetham, Matthias Aßhauer, Matt
  Smiley, Nasser Grainawi, Olamide Caleb Bello, Patrick Steinhardt,
  Paulo Casaretto, Paul Tarjan, Phil Hord, Phillip Wood, Pushkar
  Singh, Ramsay Jones, Randall S. Becker, René Scharfe, Sam
  Bostock, Shreyansh Paliwal, Siddharth Asthana, Simon Cheng,
  SZEDER Gábor, Taylor Blau, Tian Yuchen, Todd Zullinger, Toon
  Claes, Usman Akinyemi, Uwe Kleine-König, and Yee Cheng Chin.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.54 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * "git add -p" and friends note what the current status of the hunk
   being shown is.

 * "git history" history rewriting (experimental) command has been
   added.

 * "git replay" is taught to drop commits that become empty (not the
   ones that are empty in the original).

 * The help text and the documentation for the "--expire" option of
   "git worktree [list|prune]" have been improved.

 * When "git show-index" is run outside a repository, it silently
   defaults to SHA-1; the tool now warns when this happens.

 * "git merge-file" can be run outside a repository, but it ignored
   all configuration, even the per-user ones.  The command now uses
   available configuration files to find its customization.

 * "auto filter" logic for large-object promisor remote.

 * "git rev-list" and friends learn "--maximal-only" to show only the
   commits that are not reachable by other commits.

 * Command line completion (in contrib/) update for
   "stash import/export".

 * "git repo info" learns "--keys" action to list known keys.

 * Extend the alias configuration syntax to allow aliases using
   characters outside ASCII alphanumeric (plus '-').

 * A signature on a commit that was GPG signed long time ago ought to
   be still valid after the key that was used to sign it has expired,
   but we showed them in alarming red.

 * "git subtree split --prefix=P <commit>" now checks the prefix P
   against the tree of the (potentially quite different from the
   current working tree) given commit.

 * "git add -p" learned a new mode that allows the user to revisit a
   file that was already dealt with.

 * Allow the directory in which reference backends store their data to
   be specified.

 * "gitweb" has been taught to be mobile friendly.

 * "git apply --directory=./un/../normalized/path" now normalizes the
   given path before using it.

 * "git maintenance" starts using the "geometric" strategy by default.

 * "git config list" is taught to show the values interpreted for
   specific type with "--type=<X>" option.

 * "git add <submodule>" has been taught to honor
   submodule.<name>.ignore that is set to "all" (and requires "git add
   -f" to override it).

 * Hook commands are now allowed to be defined (possibly centrally)
   in the configuration files, and run multiple of them for the same
   hook event.

 * The way end-users can add their own "git <cmd>" subcommand by
   storing "git-<cmd>" in a directory on their $PATH has not been
   documented clearly, which has been corrected.

 * "git send-email" learns to pass hostname/port to Authen::SASL
   module.

 * "git send-email" learns to support use of client-side certificates.

 * "git send-email" has learned to be a bit more careful when it
   accepts charset to use from the end-user, to avoid 'y' (mistaken
   'yes' when expecting a charset like 'UTF-8') and other nonsense.

 * "git status" learned to show comparison between the current branch
   and various other branches listed on status.compareBranches
   configuration.

 * "git repo structure" command learns to report maximum values on
   various aspects of objects it inspects.

 * "git rebase" learns "--trailer" command to drive the
   interpret-trailers machinery.

 * "git fast-import" learned to optionally replace signature on
   commits whose signatures get invalidated due to replaying by
   signing afresh.

 * "git history" learned the "split" subcommand.

 * The reference-transaction hook was taught to be triggered before
   taking locks on references in the "preparing" phase.

 * "git apply" now reports the name of the input file along with the
   line number when it encounters a corrupt patch, and correctly
   resets the line counter when processing multiple patch files.

 * The HTTP transport learned to react to "429 Too Many Requests".

 * "git repo info -h" and "git repo structure -h" limit their help output
   to the part that is specific to the subcommand.

 * "git format-patch --cover-letter" learns to use a simpler format
   instead of the traditional shortlog format to list its commits with
   a new --commit-list-format option and format.commitListFormat
   configuration variable.

 * `git backfill` learned to accept revision and pathspec arguments.

 * "git replay" (experimental) learns, in addition to "pick" and
   "replay", a new operating mode "revert".

 * git replay now supports replaying down to the root commit.

 * Handling of signed commits and tags in fast-import has been made more
   configurable.

 * "git config list" is the official way to spell "git config -l" and
   "git config --list".  Use it to update the documentation.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * Avoid local submodule repository directory paths overlapping with
   each other by encoding submodule names before using them as path
   components.

 * The string_list API gains a new helper, string_list_sort_u(), and
   new unit tests to extend coverage.

 * Improve set-up time of a perf test.

 * ISO C23 redefines strchr and friends that traditionally took
   a const pointer and returned a non-const pointer derived from it to
   preserve constness (i.e., if you ask for a substring in a const
   string, you get a const pointer to the substring).  Update code
   paths that used non-const pointer to receive their results that did
   not have to be non-const to adjust.

 * Rename three functions around the commit_list data structure.

 * Transaction to create objects (or not) is currently tied to the
   repository, but in the future a repository can have multiple object
   sources, which may have different transaction mechanisms.  Make the
   odb transaction API per object source.

 * "git merge-ours" is taught to work better in a sparse checkout.

 * Allow recording process ID of the process that holds the lock next
   to a lockfile for diagnosis.

 * Reduce dependency on the_repository of xdiff-interface layer.

 * Code clean-up to use the commit_stack API.

 * "git diff --anchored=<text>" has been optimized.

 * A CodingGuidelines update.

 * Add process ancestry data to trace2 on macOS to match what we
   already do on Linux and Windows.  Also adjust the way Windows
   implementation reports this information to match the other two.

 * A handful of places used refs_for_each_ref_in() API incorrectly,
   which has been corrected.

 * Some tests assumed "iconv" is available without honoring ICONV
   prerequisite, which has been corrected.

 * Revamp object enumeration API around odb.

 * Additional tests were introduced to see the interaction with netrc
   auth with auth failure on the http transport.

 * A couple of bugs in use of flag bits around odb API has been
   corrected, and the flag bits reordered.

 * Plumb gitk/git-gui build and install procedure in meson based
   builds.

 * The code to accept shallow "git push" has been optimized.

 * Simplify build procedure for oxskeychain (in contrib/).

 * Fix dependency screw-up in meson-based builds.

 * Wean the mailmap code off of the_repository dependency.

 * API clean-up for the worktree subsystem.

 * The last uses of the_repository in "tree-diff.c" have been
   eradicated.

 * Clean-up the code around "git repo info" command.

 * Mark the merge-ort codebase to prevent more uses of the_repository
   from getting added.

 * The core.attributesfile is intended to be set per repository, but
   were kept track of by a single global variable in-core, which has
   been corrected by moving it to per-repository data structure.

 * Use the hook API to replace ad-hoc invocation of hook scripts via
   the run_command() API.

 * Code refactoring around refs-for-each-* API functions.

 * The parse-options API learned to notice an options[] array with
   duplicated long options.
   (merge 237e520d81 rs/parse-options-duplicated-long-options later to maint).

 * The code to maintain mapping between object names in multiple hash
   functions is being added, written in Rust.

 * A bit of OIDmap API enhancement and cleanup.

 * Move gitlab CI from macOS 14 images that are being deprecated.

 * The object source API is getting restructured to allow plugging new
   backends.

 * Reduce dependence on the global the_hash_algo and the_repository
   variables of wt-status code path.

  * The way combined list-object filter options are parsed has been
    revamped.

 * Editorconfig filename patterns were specified incorrectly, making
   many source files inside subdirectories unaffected, which has been
   corrected.

 * The run_command() API lost its implicit dependency on the singleton
   `the_repository` instance.

 * The unit test helper function was taught to use backslash +
   mnemonic notation for certain control characters like "\t", instead
   of octal notation like "\011".

 * Adjust test-lint to allow "sed -E" to use ERE in the patterns.

 * Clar (unit testing framework) update from the upstream.

 * Reduce system overhead "git upload-pack" spends on relaying "git
   pack-objects" output to the "git fetch" running on the other end of
   the connection.

 * Add a coccinelle rule to break the build when "struct strbuf" gets
   passed by value.

 * Further work on incremental repacking using MIDX/bitmap

 * The logic to count objects has been cleaned up.

 * Tweak the build infrastructure by moving tools around.

 * Uses of prio_queue as a LIFO stack of commits have been written
   with commit_stack.

 * The cleanup of remaining bitmaps in "ahead_behind()" has been
   simplified.

 * split-index.c has been updated to not use the global the_repository
   and the_hash_algo variables.

 * The unsigned integer that is used as an bitset to specify the kind
   of branches interpret_branch_name() function has been changed to
   use a dedicated enum type.

 * Various updates to contrib/diff-highlight, including documentation
   updates, test improvements, and color configuration handling.

 * Code paths that loop over another array to push each element into a
   strvec have been rewritten to use strvec_pushv() instead.

 * In case homebrew breaks REG_ENHANCED again, leave a in-code comment
   to suggest use of our replacement regex as a workaround.

 * MinGW build updates.

 * The way dash 0.5.13 handles non-ASCII contents in here-doc
   is buggy and breaks our existing tests, which unfortunately
   have been rewritten to avoid triggering the bug.

 * Object name handling (disambiguation and abbreviation) has been
   refactored to be backend-generic, moving logic into the respective
   object database backends.

 * pack-objects's --stdin-packs=follow mode learns to handle
   excluded-but-open packs.

 * A few code paths that spawned child processes for network
   connection weren't wait(2)ing for their children and letting "init"
   reap them instead; they have been tightened.

 * Adjust the codebase for C23 that changes functions like strchr()
   that discarded constness when they return a pointer into a const
   string to preserve constness.

 * A handful of inappropriate uses of the_repository have been
   rewritten to use the right repository structure instance in the
   read-cache.c codepath.

 * Internals of "git fsck" have been refactored to not depend on the
   global `the_repository` variable.

 * Reduce dependency on `the_repository` in add-patch.c file.

 * The way the "git log -L<range>:<file>" feature is bolted onto the
   log/diff machinery is being reworked a bit to make the feature
   compatible with more diff options, like -S/G.

 * Further work to adjust the codebase for C23 that changes functions
   like strchr() that discarded constness when they return a pointer into
   a const string to preserve constness.

 * "git rev-list --maximal-only" has been optimized by borrowing the
   logic used by "git show-branch --independent", which computes the
   same kind of information much more efficiently.


Fixes since v2.53
-----------------

 * HTTP transport failed to authenticate in some code paths, which has
   been corrected.
   (merge ed0f7a62f7 ap/http-probe-rpc-use-auth later to maint).

 * The computation of column width made by "git diff --stat" was
   confused when pathnames contain non-ASCII characters.
   (merge 04f5d95ef7 lp/diff-stat-utf8-display-width-fix later to maint).

 * The "-z" and "--max-depth" documentation (and implementation of
   "-z") in the "git last-modified" command have been updated.
   (merge 9dcc09bed1 tc/last-modified-options-cleanup later to maint).

 * A handful of code paths that started using batched ref update API
   (after Git 2.51 or so) lost detailed error output, which have been
   corrected.
   (merge eff9299eac kn/ref-batch-output-error-reporting-fix later to maint).

 * "git blame --ignore-revs=... --color-lines" did not account for
   ignored revisions passing blame to the same commit an adjacent line
   gets blamed for.
   (merge d519082d4e rs/blame-ignore-colors-fix later to maint).

 * Coccinelle rules update.
   (merge 60614838a4 tc/memzero-array later to maint).

 * Giving "git last-modified" a tree (not a commit-ish) died an
   uncontrolled death, which has been corrected.
   (merge 525ef52301 tc/last-modified-not-a-tree later to maint).

 * Test contrib/ things in CI to catch breakages before they enter the
   "next" branch.
   (merge c591c3ceff jc/ci-test-contrib-too later to maint).

 * A handful of documentation pages have been modernized to use the
   "synopsis" style.
   (merge a34d1d53a6 ja/doc-synopsis-style-even-more later to maint).

 * Small clean-up of xdiff library to remove unnecessary data
   duplication.
   (merge 5086213bd2 pw/xdiff-cleanups later to maint).

 * Update sample commit-msg hook to complain when a log message has
   material mailinfo considers the end of log message in the middle.
   (merge 83804c361b pw/commit-msg-sample-hook later to maint).

 * "git pack-objects --stdin-packs" with "--exclude-promisor-objects"
   fetched objects that are promised, which was not wanted.  This has
   been fixed.
   (merge f4eff7116d ps/pack-concat-wo-backfill later to maint).

 * "git switch <name>", in an attempt to create a local branch <name>
   after a remote tracking branch of the same name gave an advise
   message to disambiguate using "git checkout", which has been
   updated to use "git switch".
   (merge 12fee11f21 jc/checkout-switch-restore later to maint).

 * It does not make much sense to apply the "incomplete-line"
   whitespace rule to symbolic links, whose contents almost always
   lack the final newline.  "git apply" and "git diff" are now taught
   to exclude them for a change to symbolic links.
   (merge 6a41481c6d jc/whitespace-incomplete-line later to maint).

 * "git format-patch --from=<me>" did not honor the command line
   option when writing out the cover letter, which has been corrected.

 * Update build precedure for mergetool documentation in meson-based builds.
   (merge 58e4eeeeb5 pw/meson-doc-mergetool later to maint).

 * An earlier attempt to optimize "git subtree" discarded too much
   relevant histories, which has been corrected.

 * A prefetch call can be triggered to access a stale diff_queue entry
   after diffcore-break breaks a filepair into two and freed the
   original entry that is no longer used, leading to a segfault, which
   has been corrected.
   (merge 2d88ab078d hy/diff-lazy-fetch-with-break-fix later to maint).

 * "git fetch --deepen" that tries to go beyond merged branch used to
   get confused where the updated shallow points are, which has been
   corrected.
   (merge 3ef68ff40e sp/shallow-deepen-relative-fix later to maint).

 * "fsck" iterates over packfiles and its access to pack data caused
   the list to be permuted, which caused it to loop forever; the code
   to access pack data by "fsck" has been updated to avoid this.
   (merge 13eb65d366 ps/fsck-stream-from-the-right-object-instance later to maint).

 * "git log --graph --stat" did not count the display width of colored
   graph part of its own output correctly, which has been corrected.
   (merge 064b869efc lp/diff-stat-utf8-display-width-fix later to maint).

 * The configuration variable format.noprefix did not behave as a
   proper boolean variable, which has now been fixed and documented.
   (merge ea3a62c40e kh/format-patch-noprefix-is-boolean later to maint).

 * CI fix.
   (merge eb35167dd4 ps/ci-reduce-gitlab-envsize later to maint).

 * "git diff --no-index --find-object=<object-name>" outside a
   repository of course wouldn't be able to find the object and died
   while parsing the command line.  The command is made to die in a
   bit more user-friendly way.
   (merge b0ddc7947c mm/diff-no-index-find-object later to maint).

 * Fix typo-induced breakages in fsmonitor-watchman sample hook.
   (merge 41366e4677 pt/fsmonitor-watchman-sample-fix later to maint).

 * "git for-each-repo" started from a secondary worktree did not work
   as expected, which has been corrected.
   (merge e87493b9b4 ds/for-each-repo-w-worktree later to maint).

 * The construct 'test "$(command)" = expectation' loses the exit
   status from the command, which has been fixed by breaking up the
   statement into pieces.
   (merge d3edca979a fp/t3310-unhide-git-failures later to maint).

 * While discovering a ".git" directory, the code treats any stat()
   failure as a sign that a filesystem entity .git does not exist
   there, and ignores ".git" that is not a "gitdir" file or a
   directory.  The code has been tightened to notice and report
   filesystem corruption better.
   (merge 1dd27bfbfd ty/setup-error-tightening later to maint).

 * Plug a few leaks where mmap'ed memory regions are not unmapped.
   (merge a8a69bbb64 jk/unleak-mmap later to maint).

 * A test now uses the symbolic constant $ZERO_OID instead of 40 "0" to
   work better with SHA-256 as well as SHA-1.
   (merge 30310f3cc4 ss/t3200-test-zero-oid later to maint).

 * Instead of hardcoded 'origin', use the configured default remote
   when fetching from submodules.
   (merge 3b5fb32da8 ng/submodule-default-remote later to maint).

 * The code in "git help" that shows configuration items in sorted
   order was awkwardly organized and prone to bugs.

 * "imap-send" used to use functions whose use is going to be removed
   with OpenSSL 4.0; rewrite them using public API that has been
   available since OpenSSL 1.1 since 2016 or so.
   (merge 6392a0b75d bb/imap-send-openssl-4.0-prep later to maint).

 * Fix an example in the user-manual.
   (merge 5514f14617 gj/user-manual-fix-grep-example later to maint).

 * The final clean-up phase of the diff output could turn the result of
   histogram diff algorithm suboptimal, which has been corrected.
   (merge e417277ae9 yc/histogram-hunk-shift-fix later to maint).

 * "git diff -U<num>" was too lenient in its command line parsing and
   took an empty string as a valid <num>.
   (merge 4f6a803aba ty/doc-diff-u-wo-number later to maint).

 * The handling of the incomplete lines at the end by "git
   diff-highlight" has been fixed.

 * merge-file --object-id used to trigger a BUG when run in a linked
   worktree, which has been fixed.
   (merge 57246b7c62 mr/merge-file-object-id-worktree-fix later to maint).

 * "git apply -p<n>" parses <n> more carefully now.
   (merge d05d84c5f5 mf/apply-p-no-atoi later to maint).

 * A test to run a .bat file with whitespaces in the name with arguments
   with whitespaces in them was flaky in that sometimes it got killed
   before it produced expected side effects, which has been rewritten to
   make it more robust.
   (merge 3ad4921838 jk/t0061-bat-test-update later to maint).

 * "git ls-remote '+refs/tags/*:refs/tags/*' https://..." run outside a
   repository would dereference a NULL while trying to see if the given
   refspec is a single-object refspec, which has been corrected.
   (merge 4e5dc601dd kj/refspec-parsing-outside-repository later to maint).

 * Fix a regression in writing the commit-graph where commits with dates
   exceeding 34 bits (beyond year 2514) could cause an underflow and
   crash Git during the generation data overflow chunk writing.

 * The value of a wrong pointer variable was referenced in an error
   message that reported that it shouldn't be NULL.
   (merge 753ecf4205 yc/path-walk-fix-error-reporting later to maint).

 * The check in "receive-pack" to prevent a checked out branch from
   getting updated via updateInstead mechanism has been corrected.

 * "git backfill" is capable of auto-detecting a sparsely checked out
   working tree, which was broken.
   (merge 339eba65a7 th/backfill-auto-detect-sparseness-fix later to maint).

 * add_files_to_cache() used diff_files() to detect only the paths that
   are different between the index and the working tree and add them,
   which does not need rename detection, which interfered with unnecessary
   conflicts.
   (merge c0ce43376b ng/add-files-to-cache-wo-rename later to maint).

 * Doc mark-up update for entries in the glossary with bulleted lists.
   (merge a65cbd87ea jk/doc-markup-sub-list-indentation later to maint).

 * CI dependency updates.
   (merge 4bdb17e3a8 jc/ci-github-actions-use-checkout-v5 later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge d79fff4a11 jk/remote-tracking-ref-leakfix later to maint).
   (merge 7a747f972d dd/t5403-modernise later to maint).
   (merge 81021871ea sp/myfirstcontribution-include-update later to maint).
   (merge 49223593fd ac/sparse-checkout-string-list-cleanup later to maint).
   (merge a824421d36 sp/t5500-cleanup later to maint).
   (merge df1c5d7ed7 kh/doc-shortlog-fix later to maint).
   (merge 2d45507f15 am/doc-github-contributiong-link-to-submittingpatches later to maint).
   (merge 68060b9262 hs/t9160-test-paths later to maint).
   (merge 486386c687 cs/subtree-reftable-testfix later to maint).
   (merge 0728012c53 jc/diff-highlight-main-master-testfix later to maint).
   (merge 831989ef38 mc/doc-send-email-signed-off-by-cc later to maint).
   (merge c44b3f3203 sd/doc-my1c-api-config-reference-fix later to maint).
   (merge 6c21e53bad rs/version-wo-the-repository later to maint).
   (merge 10c68d2577 rs/clean-includes later to maint).
   (merge 168d575719 bk/t2003-modernise later to maint).
   (merge 6bfef81c9a kh/doc-rerere-options-xref later to maint).
   (merge aaf3cc3d8d sd/t7003-test-path-is-helpers later to maint).
   (merge 2668b6bdc4 jc/doc-rerere-update later to maint).
   (merge 2f99f50f2d jc/doc-cg-c-comment later to maint).
   (merge a454cdca42 kh/doc-am-format-sendmail later to maint).
   (merge 8b0061b5c5 jk/ref-filter-lrstrip-optim later to maint).
   (merge 5133837392 ps/ci-gitlab-msvc-updates later to maint).
   (merge 143e84958c db/doc-fetch-jobs-auto later to maint).
   (merge 0678e01f02 ap/use-test-seq-f-more later to maint).
   (merge 96286f14b0 ty/symlinks-use-unsigned-for-bitset later to maint).
   (merge b10e0cb1f3 kh/doc-am-xref later to maint).
   (merge ed84bc1c0d kh/doc-patch-id-4 later to maint).
   (merge 7451864bfa sc/pack-redundant-leakfix later to maint).
   (merge f87593ab1a cx/fetch-display-ubfix later to maint).
   (merge a66c8c7f91 jk/repo-structure-cleanup later to maint).
   (merge 5ee8782f87 ss/test-that-that-typofix later to maint).
   (merge f31b322008 fp/t3310-test-path-is-helpers later to maint).
   (merge b22ed4c4f9 kj/path-micro-code-cleanup later to maint).
   (merge a56fa1ca05 lp/doc-gitprotocol-pack-fixes later to maint).
   (merge 0d6bb8b541 ss/t3700-modernize later to maint).
   (merge 63c00a677b ss/t9123-setup-inside-test-expect-success later to maint).
   (merge beca0ca4be os/doc-git-custom-commands later to maint).
   (merge 4c223571be ty/patch-ids-document-lazy-eval later to maint).
   (merge 476365ac85 jc/doc-wholesale-replace-before-next later to maint).
   (merge 35f220b639 ss/submodule--helper-use-xmalloc later to maint).
   (merge 02cbae61df cf/constness-fixes later to maint).
   (merge 69efd53c81 ms/t7605-test-path-is-helpers later to maint).
   (merge d39cef3a1a ss/t0410-delete-object-cleanup later to maint).
   (merge 2f05039717 rj/pack-refs-tests-path-is-helpers later to maint).
   (merge 2594747ad1 jk/transport-color-leakfix later to maint).
   (merge 48430e44ac mf/t0008-cleanup later to maint).
   (merge fc8a4f15e7 gi/doc-boolean-config-typofix later to maint).
   (merge 37182267a0 kh/doc-interpret-trailers-1 later to maint).
   (merge f64c50e768 jc/rerere-modern-strbuf-handling later to maint).
   (merge 699248d89e th/t8003-unhide-git-failures later to maint).
   (merge d8e34f971b za/t2000-modernise later to maint).
   (merge 849988bc74 th/t6101-unhide-git-failures later to maint).
   (merge 0f0ce07625 sp/doc-gitignore-oowt later to maint).

----------------------------------------------------------------

Changes since v2.53.0 are as follows:

Aaron Plattner (2):
      remote-curl: use auth for probe_rpc() requests too
      t: use test_seq -f and pipes in a few more places

Abdalrhman Mohamed (1):
      .github/CONTRIBUTING.md: link to SubmittingPatches on git-scm.com

Abraham Samuel Adekunle (5):
      add -p: show user's hunk decision when selecting hunks
      interactive -p: add new `--auto-advance` flag
      add-patch: modify patch_update_file() signature
      add-patch: allow all-or-none application of patches
      add-patch: allow interfile navigation when selecting hunks

Aditya (1):
      t2107: modernize path existence check

Aditya Garg (1):
      send-email: pass smtp hostname and port to Authen::SASL

Adrian Ratiu (36):
      submodule--helper: use submodule_name_to_gitdir in add_submodule
      submodule: always validate gitdirs inside submodule_name_to_gitdir
      builtin/submodule--helper: add gitdir command
      submodule: introduce extensions.submodulePathConfig
      submodule: allow runtime enabling extensions.submodulePathConfig
      submodule--helper: add gitdir migration command
      builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
      submodule--helper: fix filesystem collisions by encoding gitdir paths
      submodule: fix case-folding gitdir filesystem collisions
      submodule: hash the submodule name for the gitdir path
      submodule: detect conflicts with existing gitdir configs
      t1800: add hook output stream tests
      run-command: add helper for pp child states
      hook: allow separate std[out|err] streams
      reference-transaction: use hook API instead of run-command
      hook: add jobs option
      run-command: poll child input in addition to output
      hook: add internal state alloc/free callbacks
      hook: include hooks from the config
      hook: allow disabling config hooks
      hook: allow event = "" to overwrite previous values
      hook: add -z option to "git hook list"
      builtin/receive-pack: avoid spinning no-op sideband async threads
      hook: move unsorted_string_list_remove() to string-list.[ch]
      builtin/receive-pack: properly init receive_hook strbuf
      hook: fix minor style issues
      hook: rename cb_data_free/alloc -> hook_data_free/alloc
      hook: detect & emit two more bugs
      hook: replace hook_list_clear() -> string_list_clear_func()
      hook: make consistent use of friendly-name in docs
      t1800: add test to verify hook execution ordering
      hook: introduce hook_config_cache_entry for per-hook data
      hook: show config scope in git hook list
      hook: show disabled hooks in "git hook list"
      hook: reject unknown hook names in git-hook(1)
      t1800: add &&-chains to test helper functions

Amisha Chhajed (5):
      sparse-checkout: optimize string_list construction and add tests to verify deduplication.
      u-string-list: add unit tests for string-list methods
      string-list: add string_list_sort_u() that mimics "sort -u"
      sparse-checkout: use string_list_sort_u
      help: cleanup the contruction of keys_uniq

Andrew Au (1):
      transport-helper, connect: use clean_on_exit to reap children on abnormal exit

Ashlesh Gawande (1):
      t5550: add netrc tests for http 401/403

Ashwani Kumar Kamal (1):
      t9812: modernize test path helpers

Beat Bolli (3):
      imap-send: use the OpenSSL API to access the subject alternative names
      imap-send: use the OpenSSL API to access the subject common name
      imap-send: move common code into function host_matches()

Bilal El Khatabi (1):
      t5315: use test_path_is_file for loose-object check

Burak Kaan Karaçay (5):
      t2003: modernize path existence checks using test helpers
      mailmap: stop using the_repository
      mailmap: drop global config variables
      run-command: wean start_command() off the_repository
      run-command: wean auto_maintenance() functions off the_repository

Chris Idema (1):
      git-gui: shift tabstops to account for the first column of patch text

Christian Couder (9):
      promisor-remote: refactor initialising field lists
      promisor-remote: allow a client to store fields
      clone: make filter_options local to cmd_clone()
      fetch: make filter_options local to cmd_fetch()
      doc: fetch: document `--filter=<filter-spec>` option
      list-objects-filter-options: support 'auto' mode for --filter
      promisor-remote: keep advertised filters in memory
      promisor-remote: change promisor_remote_reply()'s signature
      fetch-pack: wire up and enable auto filter logic

Claus Schneider(Eficode) (5):
      read-cache: update add_files_to_cache take param ignored_too
      read-cache: submodule add need --force given ignore=all configuration
      tests: t2206-add-submodule-ignored: ignore=all and add --force tests
      tests: fix existing tests when add an ignore=all submodule
      Documentation: update add --force option + ignore=all config

Colin Stagner (5):
      contrib/subtree: fix tests with reftable backend
      ci: ubuntu: use GNU coreutils for dirname
      contrib/subtree: capture additional test-cases
      contrib/subtree: test history depth
      contrib/subtree: process out-of-prefix subtrees

Collin Funk (4):
      global: constify some pointers that are not written to
      gpg-interface: remove an unnecessary NULL initialization
      bloom: remove a misleading const qualifier
      dir: avoid -Wdiscarded-qualifiers in remove_path()

D. Ben Knoble (2):
      completion: add stash import, export
      build: regenerate config-list.h when Documentation changes

Daniel D. Beck (1):
      doc: fetch: document `--jobs=0` behavior

David Timber (1):
      send-email: add client certificate options

Derrick Stolee (27):
      revision: add --maximal-only option
      config: move show_all_config()
      config: add 'gently' parameter to format_config()
      config: make 'git config list --type=<X>' work
      config: format int64s gently
      config: format bools gently
      config: format bools or ints gently
      config: format bools or strings in helper
      config: format paths gently
      config: format expiry dates quietly
      color: add color_parse_quietly()
      config: format colors quietly
      config: restructure format_config()
      config: use an enum for type
      for-each-repo: test outside of repo context
      run-command: extract sanitize_repo_env helper
      for-each-repo: work correctly in a worktree
      for-each-repo: simplify passing of parameters
      revision: include object-name.h
      t5620: prepare branched repo for revision tests
      backfill: accept revision arguments
      backfill: work with prefix pathspecs
      path-walk: support wildcard pathspecs for blob filtering
      t5620: test backfill's unknown argument handling
      t6600: test --maximal-only and --independent
      p6011: add perf test for rev-list --maximal-only
      rev-list: use reduce_heads() for --maximal-only

Deveshi Dwivedi (6):
      t5403: introduce check_post_checkout helper function
      t5403: use test_cmp for post-checkout argument checks
      worktree: do not pass strbuf by value
      list-objects-filter-options: avoid strbuf_split_str()
      coccinelle: detect struct strbuf passed by value
      stash: do not pass strbuf by value

Elijah Newren (6):
      merge,diff: remove the_repository check before prefetching blobs
      merge-ort: pass repository to write_tree()
      merge-ort: replace the_repository with opt->repo
      merge-ort: replace the_hash_algo with opt->repo->hash_algo
      merge-ort: prevent the_repository from coming back
      replay: prevent the_repository from coming back

Emily Shaffer (9):
      run-command: add stdin callback for parallelization
      hook: provide stdin via callback
      hook: convert 'post-rewrite' hook in sequencer.c to hook API
      transport: convert pre-push to hook API
      receive-pack: convert update hooks to new API
      receive-pack: convert receive hooks to hook API
      hook: run a list of hooks to prepare for multihook support
      hook: add "git hook list" command
      hook: allow out-of-repo 'git hook' invocations

Eric Ju (1):
      refs: add 'preparing' phase to the reference-transaction hook

Francesco Paparatto (2):
      t3310: replace test -f/-d with test_path_is_file/test_path_is_dir
      t3310: avoid hiding failures from rev-parse in command substitutions

Gabriel “gabldotink” (1):
      doc: add missing space on git-config page

Guillaume Jacob (1):
      doc: fix git grep args order in Quick Reference

Han Young (1):
      diffcore-break: avoid segfault with freed entries

Harald Nordgren (3):
      refactor format_branch_comparison in preparation
      status: add status.compareBranches config for multiple branch comparisons
      status: clarify how status.compareBranches deduplicates

HodaSalim (1):
      t9160:modernize test path checking

Jayesh Daga (2):
      read-cache: use istate->repo for trace2 logging
      cache-tree: use index state repository in trace2 calls

Jean-Noël Avila (4):
      doc: convert git-submodule to synopsis style
      doc: finalize git-clone documentation conversion to synopsis style
      doc: fix some style issues in git-clone and for-each-ref-options
      doc: convert git-show to synopsis style

Jeff King (45):
      remote: return non-const pointer from error_buf()
      remote: drop const return of tracking_for_push_dest()
      remote: fix leak in branch_get_push_1() with invalid "simple" config
      remote: always allocate branch.push_tracking_ref
      ref-filter: factor out refname component counting
      ref-filter: simplify lstrip_ref_components() memory handling
      ref-filter: simplify rstrip_ref_components() memory handling
      ref-filter: avoid strrchr() in rstrip_ref_components()
      bisect: simplify string_list memory handling
      ref-filter: clarify lstrip/rstrip component counting
      check_connected(): delay opening new_pack
      check_connected(): fix leak of pack-index mmap
      pack-revindex: avoid double-loading .rev files
      object-file: fix mmap() leak in odb_source_loose_read_object_stream()
      Makefile: turn on NO_MMAP when building with LSan
      meson: turn on NO_MMAP when building with LSan
      transport: plug leaks in transport_color_config()
      contrib/diff-highlight: do not highlight identical pairs
      diff-highlight: mention build instructions
      diff-highlight: check diff-highlight exit status in tests
      t: add matching negative attributes to test_decode_color
      diff-highlight: use test_decode_color in tests
      diff-highlight: test color config
      diff-highlight: fetch all config with one process
      t0061: simplify .bat test
      revision: make handle_dotdot() interface less confusing
      rev-parse: simplify dotdot parsing
      revision: avoid writing to const string for parent marks
      rev-parse: avoid writing to const string for parent marks
      config: store allocated string in non-const pointer
      convert: add const to fix strchr() warnings
      http: add const to fix strchr() warnings
      transport-helper: drop const to fix strchr() warnings
      pager: explicitly cast away strchr() constness
      run-command: explicitly cast away constness when assigning to void
      find_last_dir_sep(): convert inline function to macro
      pseudo-merge: fix disk reads from find_pseudo_merge()
      skip_prefix(): check const match between in and out params
      pkt-line: make packet_reader.line non-const
      range-diff: drop const to fix strstr() warnings
      http: drop const to fix strstr() warning
      refs/files-backend: drop const to fix strchr() warning
      git-compat-util: fix CONST_OUTPARAM typo and indentation
      run_processes_parallel(): fix order of sigpipe handling
      gitglossary: fix indentation of sub-lists

Jialong Wang (5):
      t2203: avoid suppressing git status exit code
      apply: report the location of corrupt patches
      apply: report input location in header parsing errors
      apply: report input location in binary and garbage patch errors
      object-name: turn INTERPRET_BRANCH_* constants into enum values

Jiang Xin (3):
      gitk: i18n: use "Gitk" as package name in POT file
      gitk: ignore generated POT file
      gitk: l10n: make PO headers identify the Gitk project

Joaquim Rocha (1):
      apply: normalize path in --directory argument

Johannes Schindelin (2):
      cmake: use writev(3p) wrapper as needed
      mingw: use strftime() directly in UCRT builds

Johannes Sixt (2):
      gitk: fix highlighted remote prefix of branches with directories
      gitk: commit translation files without file information

Jonatan Holmgren (8):
      help: use list_aliases() for alias listing
      alias: prepare for subsection aliases
      alias: support non-alphanumeric names via subsection syntax
      completion: fix zsh alias listing for subsection aliases
      doc: fix list continuation in alias subsection example
      alias: treat empty subsection [alias ""] as plain [alias]
      git, help: fix memory leaks in alias listing
      doc: fix list continuation in alias.adoc

Junio C Hamano (56):
      diff-highlight: allow testing with Git 3.0 breaking changes
      test: optionally test contrib in CI
      Start 2.54 cycle
      whitespace: symbolic links usually lack LF at the end
      checkout: pass program-readable token to unified "main"
      checkout: tell "parse_remote_branch" which command is calling it
      rerere: minor documantation update
      The second batch
      The 3rd batch
      CodingGuidelines: document // comments
      The 4th batch
      CodingGuidelines: document NEEDSWORK comments
      The 5th batch
      The 6th batch
      object-file.c: avoid container_of() of a NULL container
      The 7th batch
      The 8th batch
      The 9th batch
      The 10th batch
      The 11th batch
      The 12th batch
      The 13th batch
      SubmittingPatches: spell out "replace fully to pretend to be perfect"
      The 14th batch
      t: allow use of "sed -E"
      The 15th batch
      The 16th batch
      The 17th batch
      apply: fix new-style empty context line triggering incomplete-line check
      rerere: update to modern representation of empty strbufs
      The 18th batch
      cocci: strbuf.buf is never NULL
      The 19th batch
      use strvec_pushv() to add another strvec
      The 20th batch
      The 21st batch
      regexp: leave a pointer to resurrect workaround for Homebrew
      The 22nd batch
      The 23rd batch
      The 24th batch
      Git 2.54-rc0
      A bit more on top of 2.54-rc0
      A couple more on top of -rc0
      A handful before -rc1
      A bit more before -rc1
      Git 2.54-rc1
      A bit more post -rc1
      A bit more for -rc2
      Revert "cmake: use writev(3p) wrapper as needed"
      Revert "sideband: use writev(3p) to send pktlines"
      Revert "wrapper: introduce writev(3p) wrappers"
      Revert "compat/posix: introduce writev(3p) wrapper"
      rust: we are way beyond 2.53
      CI: bump actions/checkout from 4 to 5 for rust-analysis job
      Hopefully the final tweak before -rc2
      Git 2.54-rc2

Justin Tobler (21):
      odb: store ODB source in `struct odb_transaction`
      object-file: rename transaction functions
      odb: prepare `struct odb_transaction` to become generic
      odb: transparently handle common transaction behavior
      object-file: use `container_of()` to convert from base types
      builtin/repo: update stats for each object
      builtin/repo: add helper for printing keyvalue output
      builtin/repo: collect largest inflated objects
      builtin/repo: add OID annotations to table output
      builtin/repo: find commit with most parents
      builtin/repo: find tree with most entries
      Documentation: extend guidance for submitting patches
      commit: remove unused forward declaration
      gpg-interface: allow sign_buffer() to use default signing key
      fast-import: add mode to sign commits with invalid signatures
      fast-export: check for unsupported signing modes earlier
      fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
      fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
      fast-import: add 'sign-if-invalid' mode to '--signed-tags=<mode>'
      fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'
      object-file: avoid ODB transaction when not writing objects

K Jayatheerth (6):
      repo: remove unnecessary variable shadow
      path: remove unused header
      path: use size_t for dir_prefix length
      path: remove redundant function calls
      remote-curl: fall back to default hash outside repo
      refspec: fix typo in comment

Karthik Nayak (12):
      refs: skip to next ref when current ref is rejected
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details
      fetch: delay user information post committing of transaction
      setup: don't modify repo in `create_reference_database()`
      refs: extract out `refs_create_refdir_stubs()`
      refs: move out stub modification to generic layer
      refs: receive and use the reference storage payload
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Koji Nakamaru (1):
      osxkeychain: define build targets in the top-level Makefile.

Kristoffer Haugsbakk (21):
      doc: shortlog: put back trailer paragraphs
      doc: am: normalize git(1) command links
      doc: am: say that --message-id adds a trailer
      doc: am: add missing config am.messageId
      doc: am: fill out hook discussion
      doc: rerere-options.adoc: link to git-rerere(1)
      doc: add caveat about round-tripping format-patch
      doc: patch-id: emphasize multi-patch processing
      doc: patch-id: add script example
      doc: patch-id: see also git-cherry(1)
      format-patch: make format.noprefix a boolean
      doc: diff-options.adoc: show format.noprefix for format-patch
      doc: diff-options.adoc: make *.noprefix split translatable
      doc: interpret-trailers: convert to synopsis style
      doc: interpret-trailers: normalize and fill out options
      doc: config: convert trailers section to synopsis style
      interpret-trailers: use placeholder instead of *
      doc: replace git config --list/-l with `list`
      doc: gitcvs-migration: rephrase “man page”
      doc: am: revert Message-ID trailer claim
      doc: am: correct to full --no-message-id

Lambert Duclos-de Guise (1):
      t2004: use test_path_is_file instead of test -f

Li Chen (5):
      interpret-trailers: factor trailer rewriting
      trailer: libify a couple of functions
      trailer: append trailers without fork/exec
      commit, tag: parse --trailer with OPT_STRVEC
      rebase: support --trailer

LorenzoPegorari (7):
      diff: improve scaling of filenames in diffstat to handle UTF-8 chars
      t4073: add test for diffstat paths length when containing UTF-8 chars
      diff: handle ANSI escape codes in prefix when calculating diffstat width
      t4052: test for diffstat width when prefix contains ANSI escape codes
      doc: gitprotocol-pack: fix pronoun-antecedent agreement
      doc: gitprotocol-pack: improve paragraphs structure
      doc: gitprotocol-pack: normalize italic formatting

Lucas Seiki Oshiro (10):
      repo: rename the output format "keyvalue" to "lines"
      repo: add new flag --keys to git-repo-info
      CodingGuidelines: instruct to name arrays in singular
      repo: rename repo_info_fields to repo_info_field
      repo: replace get_value_fn_for_key by get_repo_info_field
      repo: rename struct field to repo_info_field
      t1900: rename t1900-repo to t1900-repo-info
      t1901: adjust nul format output instead of expected value
      Documentation/git-repo: replace 'NUL' with '_NUL_'
      Documentation/git-repo: capitalize format descriptions

Mahi Kassa (2):
      repo: factor repo usage strings into shared macros
      repo: show subcommand-specific help text

Mansi Singh (1):
      t7605: use test_path_is_file instead of test -f

Mathias Rav (1):
      merge-file: fix BUG when --object-id is used in a worktree

Matthew John Cheetham (6):
      trace2: add macOS process ancestry tracing
      build: include procinfo.c impl for macOS
      trace2: refactor Windows process ancestry trace2 event
      trace2: emit cmd_ancestry data for Windows
      test-tool: extend trace2 helper with 400ancestry
      t0213: add trace2 cmd_ancestry tests

Matthias Aßhauer (2):
      unify and bump _WIN32_WINNT definition to Windows 8.1
      compat/winansi: drop pre-Vista workaround

Matěj Cepl (1):
      doc: send-email: correct --no-signed-off-by-cc misspelling

Michael Montalbo (5):
      diff: fix crash with --find-object outside repository
      line-log: fix crash when combined with pickaxe options
      line-log: route -L output through the standard diff pipeline
      t4211: add tests for -L with standard diff options
      doc: note that -L supports patch formatting and pickaxe options

Mirko Faina (18):
      format-patch: fix From header in cover letter
      pretty.c: add %(count) and %(total) placeholders
      format-patch: move cover letter summary generation
      format-patch: add ability to use alt cover format
      format-patch: add commitListFormat config
      docs: add usage for the cover-letter fmt feature
      t0008: improve test cleanup to fix failing test
      apply.c: fix -p argument parsing
      pretty.c: better die message %(count) and %(total)
      format-patch: refactor generate_commit_list_cover
      format-patch: rename --cover-letter-format option
      docs/pretty-formats: add %(count) and %(total)
      format.commitListFormat: strip meaning from empty
      format-patch: wrap generate_commit_list_cover()
      format-patch: add preset for --commit-list-format
      format-patch: --commit-list-format without prefix
      docs: fix --commit-list-format related entries
      format-patch: removing unconditional wrapping

Nasser Grainawi (1):
      submodule: fetch missing objects from default remote

Nick Golden (1):
      read-cache: disable renames in add_files_to_cache

Olamide Caleb Bello (3):
      environment: stop storing `core.attributesFile` globally
      environment: stop using core.sparseCheckout globally
      environment: move "branch.autoSetupMerge" into `struct repo_config_values`

Omri Sarig (2):
      doc: add information regarding external commands
      doc: make it easier to find custom command information

PRASHANT S BISHT (1):
      t4200: convert test -[df] checks to test_path_* helpers

Pablo Sabater (5):
      test-lib: print escape sequence names
      t9200: handle missing CVS with skip_all
      t9200: replace test -f with modern path helper
      t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees test
      receive-pack: use worktree HEAD for updateInstead

Patrick Steinhardt (184):
      builtin/replay: extract core logic to replay revisions
      builtin/replay: move core logic into "libgit.a"
      replay: small set of cleanups
      replay: support empty commit ranges
      replay: support updating detached HEAD
      wt-status: provide function to expose status for trees
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand
      commit: rename `copy_commit_list()` to conform to coding guidelines
      commit: rename `reverse_commit_list()` to conform to coding guidelines
      commit: rename `free_commit_list()` to conform to coding guidelines
      odb: rename `FOR_EACH_OBJECT_*` flags
      odb: fix flags parameter to be unsigned
      object-file: extract function to read object info from path
      object-file: introduce function to iterate through objects
      packfile: extract function to iterate through objects of a store
      packfile: introduce function to iterate through objects
      odb: introduce `odb_for_each_object()`
      builtin/fsck: refactor to use `odb_for_each_object()`
      treewide: enumerate promisor objects via `odb_for_each_object()`
      treewide: drop uses of `for_each_{loose,packed}_object()`
      odb: introduce mtime fields for object info requests
      builtin/pack-objects: use `packfile_store_for_each_object()`
      reachable: convert to use `odb_for_each_object()`
      odb: drop unused `for_each_{loose,packed}_object()` functions
      meson: wire up gitk and git-gui
      gitk: fix msgfmt being required
      builtin/pack-objects: don't fetch objects when merging packs
      builtin/backfill: fix flags passed to `odb_has_object()`
      builtin/fsck: fix flags passed to `odb_has_object()`
      odb: drop gaps in object info flag values
      odb: convert object info flags into an enum
      odb: convert `odb_has_object()` flags into an enum
      git-gui: fix use of GIT_CEILING_DIRECTORIES
      git-gui: prefer shell at "/bin/sh" with Meson
      git-gui: massage "git-gui--askyesno" with "generate-script.sh"
      git-gui: wire up "git-gui--askyesno" with Meson
      builtin/history: perform revwalk checks before asking for user input
      builtin/history: check for merges before asking for user input
      builtin/history: replace "--ref-action=print" with "--dry-run"
      builtin/history: rename "--ref-action=" to "--update-refs="
      Documentation/git-history: document default for "--update-refs="
      commit: avoid parsing non-commits in `lookup_commit_reference_gently()`
      commit: make `repo_parse_commit_no_graph()` more robust
      commit: use commit graph in `lookup_commit_reference_gently()`
      ci: handle failures of test-slice helper
      ci: don't skip smallest test slice in GitLab
      meson: fix MERGE_TOOL_DIR with "--no-bin-wrappers"
      github: fix Meson tests not executing at all
      ci: make test slicing consistent across Meson/Make
      gitlab-ci: use "run-test-slice-meson.sh"
      gitlab-ci: handle failed tests on MSVC+Meson job
      pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
      pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
      bisect: fix misuse of `refs_for_each_ref_in()`
      t: don't set ICONV prereq when iconv(1) is missing
      t40xx: don't use iconv(1) without ICONV prereq
      t4205: improve handling of ICONV prerequisite
      t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
      t6006: don't use iconv(1) without ICONV prereq
      t/helper: improve "genrandom" test helper
      object-file: adapt `stream_object_signature()` to take a stream
      packfile: expose function to read object stream for an offset
      pack-check: fix verification of large objects
      refs: remove unused `refs_for_each_include_root_ref()`
      refs: move `refs_head_ref_namespaced()`
      refs: move `do_for_each_ref_flags` further up
      refs: rename `do_for_each_ref_flags`
      refs: rename `each_ref_fn`
      refs: introduce `refs_for_each_ref_ext`
      refs: speed up `refs_for_each_glob_ref_in()`
      refs: generalize `refs_for_each_namespaced_ref()`
      refs: generalize `refs_for_each_fullref_in_prefixes()`
      refs: improve verification for-each-ref options
      refs: replace `refs_for_each_ref_in()`
      refs: replace `refs_for_each_rawref()`
      refs: replace `refs_for_each_rawref_in()`
      refs: replace `refs_for_each_glob_ref_in()`
      refs: replace `refs_for_each_glob_ref()`
      refs: replace `refs_for_each_namespaced_ref()`
      refs: replace `refs_for_each_fullref_in()`
      t: fix races caused by background maintenance
      t: disable maintenance where we verify object database structure
      t34xx: don't expire reflogs where it matters
      t5400: explicitly use "gc" strategy
      t5510: explicitly use "gc" strategy
      t6500: explicitly use "gc" strategy
      t7900: prepare for switch of the default strategy
      builtin/maintenance: use "geometric" strategy by default
      ci: unset GITLAB_FEATURES envvar to not bust xargs(1) limits
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      add-patch: allow disabling editing of hunks
      cache-tree: allow writing in-memory index as tree
      builtin/history: split out extended function to create commits
      builtin/history: implement "split" subcommand
      meson: simplify iconv-emits-BOM check
      meson: detect broken iconv that requires ICONV_RESTART_RESET
      gitlab-ci: update to macOS 15 images
      odb: split `struct odb_source` into separate header
      odb: introduce "files" source
      odb: embed base source in the "files" backend
      odb: move reparenting logic into respective subsystems
      odb/source: introduce source type for robustness
      odb/source: make `free()` function pluggable
      odb/source: make `reprepare()` function pluggable
      odb/source: make `close()` function pluggable
      odb/source: make `read_object_info()` function pluggable
      odb/source: make `read_object_stream()` function pluggable
      odb/source: make `for_each_object()` function pluggable
      odb/source: make `freshen_object()` function pluggable
      odb/source: make `write_object()` function pluggable
      odb/source: make `write_object_stream()` function pluggable
      odb/source: make `read_alternates()` function pluggable
      odb/source: make `write_alternate()` function pluggable
      odb/source: make `begin_transaction()` function pluggable
      editorconfig: fix style not applying to subdirs anymore
      odb: stop including "odb/source.h"
      packfile: extract logic to count number of objects
      object-file: extract logic to approximate object count
      object-file: generalize counting objects
      odb/source: introduce generic object counting
      odb: introduce generic object counting
      upload-pack: fix debug statement when flushing packfile data
      upload-pack: adapt keepalives based on buffering
      upload-pack: prefer flushing data over sending keepalive
      upload-pack: reduce lock contention when writing packfile data
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      sideband: use writev(3p) to send pktlines
      csum-file: introduce `hashfd_ext()`
      csum-file: drop `hashfd_throughput()`
      builtin/pack-objects: reduce lock contention when writing packfile data
      clar: update to fix compilation on platforms without PATH_MAX
      Introduce new "tools/" directory
      contrib: move "coccinelle/" directory into "tools/"
      contrib: move "coverage-diff.sh" script into "tools/"
      contrib: move "update-unicode.sh" script into "tools/"
      builds: move build scripts into "tools/"
      git-compat-util.h: move warning infra to prepare for PCHs
      meson: compile compatibility sources separately
      meson: precompile "git-compat-util.h"
      oidtree: modernize the code a bit
      oidtree: extend iteration to allow for arbitrary return codes
      odb: introduce `struct odb_for_each_object_options`
      object-name: move logic to iterate through loose prefixed objects
      object-name: move logic to iterate through packed prefixed objects
      object-name: extract function to parse object ID prefixes
      object-name: backend-generic `repo_collect_ambiguous()`
      object-name: backend-generic `get_short_oid()`
      object-name: merge `update_candidates()` and `match_prefix()`
      object-name: abbreviate loose object names without `disambiguate_state`
      object-name: simplify computing common prefixes
      object-name: move logic to compute loose abbreviation length
      object-file: move logic to compute packed abbreviation length
      odb: introduce generic `odb_find_abbrev_len()`
      fetch-pack: move fsck options into function scope
      fsck: initialize fsck options via a function
      fsck: store repository in fsck options
      fsck: drop USE_THE_REPOSITORY
      builtin/fsck: fix trivial dependence on `the_repository`
      builtin/fsck: stop using `the_repository` when snapshotting refs
      builtin/fsck: stop using `the_repository` when checking refs
      builtin/fsck: stop using `the_repository` when checking reflogs
      builtin/fsck: stop using `the_repository` with loose objects
      builtin/fsck: stop using `the_repository` when checking packed objects
      builtin/fsck: stop using `the_repository` when marking objects
      builtin/fsck: stop using `the_repository` in error reporting
      commit-graph: fix writing generations with dates exceeding 34 bits
      CodingGuidelines: document our style for flags
      treewide: use enum for `odb_for_each_object()` flags
      odb: rename `odb_write_object()` flags
      odb: use enum for `odb_write_object` flags
      odb: rename `odb_has_object()` flags
      odb: drop unneeded headers and forward decls
      reftable: introduce "reftable-system.h" header
      reftable/stack: provide fsync(3p) via system header
      reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
      reftable/system: add abstraction to retrieve time in milliseconds
      reftable/system: add abstraction to mmap files
      t: work around multibyte bug in quoted heredocs with Dash v0.5.13
      t9300: work around partial read bug in Dash v0.5.13

Paul Tarjan (2):
      t7527: fix flaky fsmonitor event tests with retry logic
      fsmonitor-watchman: fix variable reference and remove redundant code

Paulo Casaretto (1):
      lockfile: add PID file for debugging stale locks

Phil Hord (1):
      .mailmap: fix email for Phil Hord

Phillip Wood (13):
      replay: drop commits that become empty
      xdiff: remove "line_hash" field from xrecord_t
      xdiff: remove unused data from xdlclass_t
      meson: fix building mergetool docs
      diff --anchored: avoid checking unmatched lines
      templates: add .gitattributes entry for sample hooks
      templates: detect commit messages containing diffs
      wt-status: avoid passing NULL worktree
      path: remove repository argument from worktree_git_path()
      interpret-trailers: refactor create_in_place_tempfile()
      worktree: remove "the_repository" from is_current_worktree()
      worktree add: stop reading ".git/HEAD"
      worktree: reject NULL worktree in get_worktree_git_dir()

Pushkar Singh (3):
      subtree: validate --prefix against commit in split
      path: factor out skip_slashes() in normalize_path_copy_len()
      archive: document --prefix handling of absolute and parent paths

Quentin Bernet (1):
      docs: fix "git stash [push]" documentation

Ramsay Jones (1):
      object-file: fix sparse 'plain integer as NULL pointer' error

René Scharfe (12):
      blame: fix coloring for repeated suspects
      commit: use commit_stack
      remove duplicate includes
      version: stop using the_repository
      xdiff-interface: stop using the_repository
      pack-objects: remove duplicate --stdin-packs definition
      parseopt: check for duplicate long names and numerical options
      history: initialize rev_info in cmd_history_reword()
      use commit_stack instead of prio_queue in LIFO mode
      commit-reach: simplify cleanup of remaining bitmaps in ahead_behind ()
      split-index: stop using the_repository and the_hash_algo
      history: fix short help for argument of --update-refs

Ritesh Singh Jadoun (1):
      t/pack-refs-tests: use test_path_is_missing

Rito Rhymes (5):
      gitweb: add viewport meta tag for mobile devices
      gitweb: prevent project search bar from overflowing on mobile
      gitweb: fix mobile page overflow across log/commit/blob/diff views
      gitweb: fix mobile footer overflow by wrapping text and clearing floats
      gitweb: let page header grow on mobile for long wrapped project names

Runxi Yu (1):
      t5516: test updateInstead with worktree and unborn bare HEAD

Sahitya Chandra (1):
      pack-redundant: fix memory leak when open_pack_index() fails

Sam Bostock (3):
      worktree: clarify that --expire only affects missing worktrees
      merge-ours: drop USE_THE_REPOSITORY_VARIABLE
      merge-ours: integrate with sparse-index

Samo Pogačnik (2):
      shallow: free local object_array allocations
      shallow: handling fetch relative-deepen

Scott Baker (2):
      diff-highlight: drop perl version dependency back to 5.8
      diff-highlight: allow module callers to pass in color config

Seyi Kufoiji (2):
      oidmap: make entry cleanup explicit in oidmap_clear
      builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()

Shannon Barber (1):
      gitk: use config settings for head/tag colors

Shreyansh Paliwal (11):
      doc: MyFirstContribution: fix missing dependencies and clarify build steps
      t5500: simplify test implementation and fix git exit code suppression
      show-index: warn when falling back to SHA-1 outside a repository
      show-index: use gettext wrapping in user facing error messages
      wt-status: pass struct repository through function parameters
      wt-status: replace uses of the_repository with local repository instances
      wt-status: use hash_algo from local repository instead of global the_hash_algo
      tree-diff: remove the usage of the_hash_algo global
      send-email: validate charset name in 8bit encoding prompt
      add-patch: use repository instance from add_i_state instead of the_repository
      doc: gitignore: clarify pattern base for info/exclude and core.excludesFile

Siddharth Asthana (2):
      sequencer: extract revert message formatting into shared function
      replay: add --revert mode to reverse commit changes

Siddharth Shrimali (8):
      t: fix "that that" typo in lib-unicode-nfc-nfd.sh
      t3700: avoid suppressing git's exit code
      t3700: use test_grep helper for better diagnostics
      t9123: use test_when_finished for cleanup
      t3200: replace hardcoded null OID with $ZERO_OID
      submodule--helper: replace malloc with xmalloc
      t0410: modernize delete_object helper
      t7004: replace wc -l with modern test helpers

SoutrikDas (2):
      doc: fix repo_config documentation reference
      t7003: modernize path existence checks using test helpers

Taylor Blau (22):
      midx: mark `get_midx_checksum()` arguments as const
      midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
      midx: introduce `midx_get_checksum_hex()`
      builtin/multi-pack-index.c: make '--progress' a common option
      git-multi-pack-index(1): remove non-existent incompatibility
      git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
      t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
      midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
      midx-write.c: introduce `struct write_midx_opts`
      midx: do not require packs to be sorted in lexicographic order
      midx-write.c: introduce `midx_pack_perm()` helper
      midx-write.c: extract `fill_pack_from_midx()`
      midx-write.c: enumerate `pack_int_id` values directly
      midx-write.c: factor fanout layering from `compute_sorted_entries()`
      t/helper/test-read-midx.c: plug memory leak when selecting layer
      midx: implement MIDX compaction
      midx: enable reachability bitmaps during MIDX compaction
      pack-objects: plug leak in `read_stdin_packs()`
      pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
      t7704: demonstrate failure with once-cruft objects above the geometric split
      pack-objects: support excluded-open packs with --stdin-packs
      repack: mark non-MIDX packs above the split as excluded-open

Tian Yuchen (7):
      t/perf/p3400: speed up setup using fast-import
      symlinks: use unsigned int for flags
      setup: improve error diagnosis for invalid .git files
      patch-ids: document intentional const-casting in patch_id_neq()
      .mailmap: update email address for Tian Yuchen
      diff: document -U without <n> as using default context
      builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE

Todd Zullinger (1):
      RelNotes: minor typo fixes in 2.54.0 draft

Toon Claes (13):
      last-modified: clarify in the docs the command takes a pathspec
      last-modified: document option '-z'
      last-modified: document option '--max-depth'
      last-modified: change default max-depth to 0
      last-modified: rewrite error message when more than one commit given
      last-modified: fix memory leak when more than one commit is given
      last-modified: remove double error message
      last-modified: verify revision argument is a commit-ish
      cocci: extend MEMZERO_ARRAY() rules
      replay: support replaying down from root commit
      builtin/replay: mark options as not negatable
      replay: use stuck form in documentation and help message
      replay: allow to specify a ref with option --ref

Trieu Huynh (4):
      t8003: avoid suppressing git's exit code
      t8003: modernise style
      t6101: avoid suppressing git's exit code
      backfill: auto-detect sparse-checkout from config

Uwe Kleine-König (1):
      gpg-interface: signatures by expired keys are fine

Vaidas Pilkauskas (3):
      strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
      strbuf_attach: fix call sites to pass correct alloc
      http: add support for HTTP 429 rate limit retries

Wang Zichong (1):
      gitk: support link color in the Preferences dialog

Wolfgang Faust (1):
      git-gui: grey out comment lines in commit message

Yannik Tausch (1):
      merge-file: honor merge.conflictStyle outside of a repository

Yee Cheng Chin (1):
      xdiff: re-diff shifted change groups when using histogram algorithm

Yuvraj Singh Chauhan (1):
      path-walk: fix NULL pointer dereference in error message

Zakariyah Ali (1):
      t2000: modernise overall structure

brian m. carlson (17):
      repository: require Rust support for interoperability
      conversion: don't crash when no destination algo
      hash: use uint32_t for object_id algorithm
      rust: add a ObjectID struct
      rust: add a hash algorithm abstraction
      hash: add a function to look up hash algo structs
      rust: add additional helpers for ObjectID
      csum-file: define hashwrite's count as a uint32_t
      write-or-die: add an fsync component for the object map
      hash: expose hash context functions to Rust
      rust: fix linking binaries with cargo
      rust: add a build.rs script for tests
      rust: add functionality to hash an object
      rust: add a new binary object map format
      rust: add a small wrapper around the hashfile code
      object-file-convert: always make sure object ID algo is valid
      docs: correct information about reftable

cuiweixie (1):
      fetch: fix wrong evaluation order in URL trailing-slash trimming

