Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283540;
	b=lrIbJNrdsb3reIkVpAyiP3w8NSM5O6Tc97kLyUgzqFQmXssyKLjlai+R2R7SHGbqCiAc
	 eXCC3PxkHACZFM7hCjFEAZwA1XWvrPl2UZzd1RCkqyjuqSQYL0BtwUY6I+v5HgC/yruax
	 7iPORH3p4bK5DpDe3AecgTySSDK7x55z1x2lPgWUxYHoxE7d0encELPQiL27V6rKFPuri
	 6ATYsxfXeCHjAWltFshZFSqpMLk33b2FTZtrRsbfZ8QGbWXDUT6C3AHsrpNOLD+1rDcea
	 yMxqNLbPlRVNJDAn8CvTn0UZ1iy4QPL56lmerw6RavmoNE0rLSZENFk/BhFE+DXKivA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2pMifm4HfXe5s5V/PdYbxrhsO5n4ASeN9HY3JQxQ8Pk=;
	b=Pk9dh+8HziyKn/UqtvmAWeDb6JVl2QKC+TcWSbuBbLcxWwNyz9XOBkJ9u5NJfjGaKTvv
	 b405LSAQ+OxVaJ0CNOE+smQe4NsMBkYDE5Sl4btwBsEbg/V9PxQzGZcPTV1cpqtuMHNL0
	 bzZd8Gxrpj/z+zlfPvYzmKlgltBUzTDwCAun/Gg1j7z5MkX3dO0In5cwPuc/KaZdvuqih
	 i38rAIYdiaeDbVE+11U76ZyKi3f/r8kx+khU658MeC0AjxTSxojEZ+mibvT99gsC90G/x
	 Fk3H56un4t5PAIdzUFibvNAX28Pxf3bD0iy5Gsi6GOilypUhBQ9bLDurSMl0oQ+gJoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hb3WpJgt;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E0606C470
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8E0606C470
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hb3WpJgt
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d885929so1691792f8f.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283538; x=1793888338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pMifm4HfXe5s5V/PdYbxrhsO5n4ASeN9HY3JQxQ8Pk=;
        b=Hb3WpJgtypKjJw0B6v//EYR1FyQh9v03vj6Rz6qgPX4xSZQdw+tAzuAP8qFFqH9b/N
         D7kZ9ov9AYOAE8kzKQ8qgGgfKBekLyXoAPyNMISj4jbEry99oH4Pc4tJoXjX+lvhPNX0
         My/h0gs2sumFnKTAENq0bsrTyFRsdQn4Ogy9sRnqgH9MmOEXSk9eVMub83PD9fEqT6hs
         SgXmGeuC+88u0/zB32s2uMAepJSV5JiCoJScz/3p7QqPuvJ4neZqMF20eEI5rq0d/tCw
         /7BXWwud5JF9TDMsu68CnZM/dxl9ewtObRNUh1TuQuMgtV5rxNpE48PiCWjLouZcI9PH
         BoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283538; x=1793888338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pMifm4HfXe5s5V/PdYbxrhsO5n4ASeN9HY3JQxQ8Pk=;
        b=Ja+kCOEQVgEuDws+ztI7WyR377c/UmhhnwQZo62qMms4PgW0o+XkeGjDY/xmN5FSOB
         ZSbsSMeBcEq0WRW57mBV32LZp/E2FzqbXBwLCXkx3Ohjgmy1jlupczM6RE/KKA0FmgMe
         +f6ycdoz6jFkPPMAzuYbc4CpWZdCHafsiRrp7gXCk1+YVM0IU9Z0EMDuenKMgI9CnuX0
         0fN9wJLP8FPukPdDTGZrWFyne9a3nux/ZJ347F9tKgPSu7kOQ4OD0LGhl2mqjKO9l4Af
         NMnCwmP2x5Z1B2eLrXbk1oTrEi1RijsEUDDeaQydXD5ku1GHUWQI2qYjjU0Q1QeM+GiT
         +V0Q==
X-Gm-Message-State: AFq9FYIzMZ25OusLA7bGe9NiuugC6OAIdkdlMpkIRhmAB84REV0AcadY
	VtR3q8DNNh59k32SZRcB8JYUduojQz8Jy/tRGtj5x5XUZT0d23TUz58K78yCSMEZxX4ifw==
X-Gm-Gg: AYBFou2B8qV0QWhQpIf9RfTjPNtNvbjkpV5S5+0YNZqWPeUptTNTl4fIrtvEII6+TbJ
	01ZRddH3Ljk4s19B6rwuXQIoBQuBYxmxOakcCZhI+TSbQeR5ND3J4HTFuli/c6kxMDNhXw7Ib74
	bQpkhBpz+VNROY8npI4XedBSQyZj/iO0pFcaEg4n6WpjaWwciJqmNuadBdbGZtfzc4JMmCM+g54
	LTelNEGmN5KyNFZQeYy7GnbqanO9rWTJUtUDfFfXM+dPKo5EAC8zoUIh8h8pvFSbsEkoC9WJMxI
	Oo7jbwAG7AkJLln6H3pHrJDB+xpInp92zktOoywWpL/i4qRlpc9nc9DHJHMThHfv/1lW0Vh8jDA
	guWiew/KU/8TSc5MUIAydhMZ1OWIY7f6xA5uuOD7DYKcqa/Ayx/o62nNIUSDkj3IxHIwkrM4eU4
	o2KpvjXW6tKMQ+x9zN0F10hBCmXnzafgfzB+7mII+rVgX61r65xpHYG5EZSz02EyrnJVRvik0zC
	npb9DgPjvJ9X/p6D1KHuIjrSl4eLNpKVZu2r0XC9ZFQJ8jstW9odZnf80kxkml/TEpTlhu8fIMV
	eEcNRsJt9DyG4956jvx2958r9Rd3j3+mGwFU80eykKp047ezPNnIUJluPJ3/roVnejNhuUNpo2z
	brBhHOu90pJvhW3eODDHDGBLcu08k6cLXAYghUFjHM3GnHmjzd4O9zTvKmxdoruXYS5fKklq7p8
	/hmvxtx1GR1RjuSClg+txMOGUypuy4PQ==
X-Received: by 2002:a05:600d:8492:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4a9672f7853mr85447575e9.21.1793283537292;
        Thu, 29 Oct 2026 07:18:57 -0700 (PDT)
Received: from localhost.localdomain ([102.88.133.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm76146385e9.5.2026.10.29.07.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 07:18:56 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
Date: Thu, 29 Oct 2026 15:18:18 +0100
Message-ID: <20261029141818.40193-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hello,

This is my proposal for the project "Reduce Git's global state to
enable Git's libification" for the December 2026 Outreachy internship.

I'd appreciate any feedback.

Personal Information
====================

Full Name: Okhuomon Rosemary Ajayi
Email: okhuomonajayi54@gmail.com
GitHub: https://github.com/six-shot
Blog: https://medium.com/@okhuomonajayi54
Location: Lagos, Nigeria (WAT, UTC+1)

About Me
========

I am Okhuomon Rosemary Ajayi, often known as "sixshot", a
self-taught software developer from Lagos, Nigeria. I am obsessed
with robots and intelligent mechanical systems. C was the first
programming language I picked up, before I moved into frontend and
mobile development. Working on Git during this contribution period
has brought me back to C, and I have enjoyed working at that lower
level again.

Before Git, I contributed to other open source projects. In Servo
I fixed clippy warnings in the script crate and improved some
documentation [12]. In the OCaml ecosystem I added Deflate support
and horizontal differencing to ocaml-tiff, and worked on raven and
YOCaml [13]. In LibreOffice I worked in the C++ core, fixing a bug
where Infobar keys reached the document and cleaning up unit
conversion code [14]. In Mozilla Firefox I fixed layout bugs in
vertical tabs and split view [15].

As a woman in tech, I know how much it helps to see someone like
yourself doing the work. That is why I volunteered to train girls at
Edunity for Girls, helping them get started in tech.

Honestly, I would like to be part of the Git community and keep on
contributing to open source. This project lets me do that in C, the
language I started with, and my patches on the_repository so far
have shown me how much there is to learn here.

Past Experience with Git
========================

I have been using Git since I started coding, for my own projects
and when collaborating with other developers.

This is not my first time on the Git mailing list. I applied to
Outreachy in October 2025 and sent about ten patches in about a week
(patch-ids, commit.c comments, builtin/patch-id.c, gpg-interface)
[10]. None of them were merged. I was sending too fast, my subject
lines had doubled prefixes like "[PATCH] [PATCH v2]", and my commit
messages did not follow the project style, as Junio and Christian
pointed out [11].

This year I slowed down. I read SubmittingPatches properly, wrote
my commit messages in the present tense, and sent one change at a
time. The hardest part was still sending new versions: keeping each
version in sync with the review, the right thread and the notes on
what changed since the last version. This time my microproject was
merged to master, and six more topics are in 'seen', some of
them marked "Will merge to 'next'?" in What's cooking.

Contributions to the Git Community
==================================

Microproject
------------
+ delta-islands: use Q_() for island count
  Thread: https://lore.kernel.org/git/20261013203042.58610-1-okhuomonajayi54@gmail.com/
  Branch: oa/delta-islands-i18n-use-q
  Status: merged to 'master'
  Commit: 60e16b0387 (merge commit 7ac84b7267), listed in the
  Git 2.98.0 release notes
  Description: The island count in a progress message was built with
  a plain _() so translators could not handle plural forms. Use Q_()
  instead. v2 moved a reviewer note below the --- line after
  Junio's review.

Patches related to the project (the_repository)
------------------------------------------------
+ merge: stop using the_repository
  Thread: https://lore.kernel.org/git/20261015142532.48175-1-okhuomonajayi54@gmail.com/
  Branch: oa/merge-without-the-repository
  Status: in 'seen'
  Description: Pass the repository already available at the entry
  points down to the helpers, removing the_repository and
  the_hash_algo from merge.c.

+ merge-blobs: stop using the_repository
  Thread: https://lore.kernel.org/git/20261017105244.90295-1-okhuomonajayi54@gmail.com/
  Branch: oa/merge-blobs-stop-using-the-repository
  Status: in 'seen'
  Description: Use the repository reachable from the index_state
  instead of the global.
  Usman suggested renaming "r" to "repo"; Junio preferred the short
  "r" used elsewhere for "struct repository *", so I kept it [9].

+ diffcore-break: remove USE_THE_REPOSITORY_VARIABLE
  Thread: https://lore.kernel.org/git/20261014114904.85300-1-okhuomonajayi54@gmail.com/
  Status: in 'seen', marked "Will merge to 'next'?"
  Description: An earlier commit removed the last use of
  the_repository in diffcore-break.c, so the file no longer needs
  USE_THE_REPOSITORY_VARIABLE. Drop the define.

+ checkout: make unique_tracking_name() use the given repository
  (2 patches)
  Thread (v3): https://lore.kernel.org/git/20261023211533.73433-1-okhuomonajayi54@gmail.com/
  Status: v3 in 'seen'
  Description: Pass the repository to unique_tracking_name() and
  carry it in struct tracking_name_data, so checkout.c no longer
  needs USE_THE_REPOSITORY_VARIABLE. Usman asked for a clearer
  commit message in v1. In v2 Junio pointed out that the function
  still walked the remotes with for_each_remote(), which only works
  on the_repository, so v3 adds repo_for_each_remote() first.

+ diffcore-rename: stop using the_repository
  Thread: https://lore.kernel.org/git/20261024221341.92086-1-okhuomonajayi54@gmail.com/
  Status: in 'seen', marked "Will merge to 'next'?"
  Description: diffcore_rename_extended() already has the
  repository through its options. Use its hash algorithm when
  checking for empty blobs, pass it to start_delayed_progress(),
  and drop USE_THE_REPOSITORY_VARIABLE. Patrick reviewed it and
  said it looks correct.

+ notes-cache: read the cache ref from the given repository
  Thread: https://lore.kernel.org/git/20261026102603.32377-1-okhuomonajayi54@gmail.com/
  Status: reviewed by Junio, waiting to be queued
  Description: notes_cache_match_validity() already receives the
  repository but read the ref from the_repository. Pass it to
  get_main_ref_store() so the check reads the same repository.

+ combine-diff: use the repository from diff options
  Thread: https://lore.kernel.org/git/20261026111303.92117-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: show_combined_header() and show_patch_diff()
  already have opt->repo; use it for the hash algorithm,
  abbreviation and gitlinks. The file still needs the macro for
  DEFAULT_ABBREV, which depends on the default_abbrev global.

+ negotiator/default: stop using the_repository
  Thread: https://lore.kernel.org/git/20261027153429.14131-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: Give default_negotiator_init() a repository,
  store it on the negotiation state and use it to parse commits,
  clear marks and walk refs. Drop USE_THE_REPOSITORY_VARIABLE.

+ bundle-uri: stop using the_repository
  Thread (v2): https://lore.kernel.org/git/20261029131325.79176-1-okhuomonajayi54@gmail.com/
  Status: v1 in 'seen' and marked ready for 'next'; v2 sent to
  replace it, and Patrick confirmed the v2 diff
  Description: unbundle_from_file() unbundles objects into the
  given repository but read and wrote refs in the_repository, and
  fetch_bundle_uri() used the_repository for tracing. v1 used the
  given repository for both and was reviewed by Karthik. Patrick
  then pointed out that only two more uses were left in the file,
  in find_temp_filename() and copy_uri_to_file(), so v2 passes the
  repository to them too and drops USE_THE_REPOSITORY_VARIABLE
  from bundle-uri.c.

+ range-diff: use diffopt->repo instead of the_repository
  Thread (v2): https://lore.kernel.org/git/20261029084720.93221-1-okhuomonajayi54@gmail.com/
  Status: v2 sent, waiting for review
  Description: output_pair_header() and patch_diff() receive a
  diffopt that names the repository, but still used the_repository
  and the_hash_algo. Use diffopt->repo, and give get_filespec() a
  hash algorithm parameter. v2 rewords the commit message after
  Pablo's review.

+ environment: move commit_encoding into repo_config_values
  Thread: https://lore.kernel.org/git/20261021155608.58509-1-okhuomonajayi54@gmail.com/
  Status: v1 reviewed by Junio; v2 in progress
  Description: v1 moved the global into struct repo_config_values.
  Junio pointed out that only commit.c uses it and suggested passing
  a "const char *" encoding down to the functions instead of the
  whole repository. v2 will do that.

Other patches
-------------
+ credential-store: add lockTimeout config option (#leftoverbits)
  Thread (v2): https://lore.kernel.org/git/20261016212216.58000-1-okhuomonajayi54@gmail.com/
  Status: v2 sent after Junio's review, waiting
  Description: Junio noted in the rerere thread that
  credentialStore.lockTimeoutMS is the only timeout setting with
  the unit in its name, and suggested a synonym without "MS". Add
  credentialStore.lockTimeout; the old name keeps working.

Reviews and help to other applicants
------------------------------------
+ list-objects-filter-options: pass repository to partial clone
  helpers (Dorine Tipo)
  My reply: https://lore.kernel.org/git/CAFpMFfCu6JrUC8i453qBP=AktqcG_9sGX=1-1ekEDCYm_+pkUw@mail.gmail.com/
  Description: Dorine asked whether USE_THE_REPOSITORY_VARIABLE
  could be dropped. I applied the patch, removed the define and
  checked that the file still builds, so it can go in the same
  patch.

+ Microproject idea: modernize a file-existence check in
  t/t0081-find-pack.sh (Immaculate Mecha)
  My reply: https://lore.kernel.org/git/CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com/
  Description: Pointed out that Shashank S had already changed that
  exact line, and suggested searching lore and "What's cooking"
  before choosing a microproject.

Learning resource
-----------------
+ "Learn C by reading Git" -- a zero-to-hero guide
  Link: https://six-shot.github.io/six-shot-git-c-zero-to-hero/
  Description: C was the first language I learned, but I had not
  used it in a while. I built this guide during this Outreachy
  contribution period so I could understand C well by learning it
  with Git itself. It teaches C from zero using real code from
  git.git (repository.h, merge-blobs.c, git.c, ...), with
  exercises. It covers the patterns this project depends on:
  structs and pointers, passing "struct repository *" down a call
  chain, and why global variables like the_repository are a
  problem. I hope it also helps other people who want to start
  contributing to Git.

Project Overview
================

Git keeps the state of the repository it is working on in a single
global object, the_repository, which is a "struct repository". A
lot of internal code uses this global directly instead of taking a
repository as a parameter. On top of that, many configuration and
environment values are stored as global variables in environment.c
rather than in the repository they belong to.

This design assumes that a process only ever works with one
repository. That is not true for things like submodules, and it is
one of the main things blocking the long-term goal of libifying Git,
where a program could open several repositories at the same time.
With shared globals, two repositories in one process would read and
overwrite the same values, which can lead to wrong behaviour that is
hard to debug. It also makes the code harder to read and test,
because a function's dependencies are hidden instead of being
visible in its parameters.

This project reduces that global state step by step:
- removing the_repository from library code by passing the
  repository explicitly through the call chain, so files no longer
  need USE_THE_REPOSITORY_VARIABLE;
- moving repository-specific settings from environment.c into the
  repository, mostly struct repo_config_values and struct
  repo_settings;
- and, where a value is only used in one place, passing just that
  value down instead of the whole repository.

A lot of progress has already been made: many settings that used
to be globals now live in struct repo_config_values, and many files
no longer need the_repository. But there is still plenty left.
Over a hundred library files outside builtin/ still define
USE_THE_REPOSITORY_VARIABLE, and environment.h still has globals
such as git_commit_encoding, git_log_output_encoding and
comment_line_str. That remaining library code is where I want to
focus.

Review of Previous Work and Strategies
======================================

From reading past series on the list and from my own patches, I see
three strategies, and the right one depends on the variable:

1. Thread the repository through the call chain, bottom-up.
   Patrick Steinhardt introduced USE_THE_REPOSITORY_VARIABLE so files
   that still depend on the global are marked [1]. Work then goes from
   the lowest layers up, removing the macro file by file (objects [2],
   path [3], packfile by Karthik [4]). My patches to merge.c,
   merge-blobs.c, diffcore-break.c, diffcore-rename.c, checkout.c,
   notes-cache.c, combine-diff.c, negotiator/default.c,
   bundle-uri.c and range-diff.c follow this pattern.

2. Move repository-scoped config into the repository.
   core.hooksPath and core.sharedRepository moved into repo-settings
   with accessors [3]. Later, Olamide Caleb Bello's Outreachy series
   added struct repo_config_values, with repo_config_values(repo) as
   the accessor, and moved core.attributesFile, core.sparseCheckout
   and branch.autoSetupMerge into it [5]. Others, such as Tian Yuchen,
   have moved more values there since.

3. Pass only the value the function needs.
   the_hash_algo was replaced by an explicit
   "const struct git_hash_algo *" in csum-file.c [2]. Junio asked for
   the same thing on my commit_encoding patch: since only commit.c
   uses the variable, pass the encoding string instead of adding it
   to repository config [6].

Roadblocks seen in earlier work
-------------------------------
- Not every global belongs in struct repository. When Ayush
  Chandekar tried to move core.attributesfile into repo_settings,
  Junio questioned whether attribute data belongs to a repository at
  all, since attributes come from the index and the working tree,
  and compared it to how index_state is passed around instead of the
  repository [7]. The config value was later stored in struct
  repo_config_values instead [5].
- State used during early startup cannot simply be moved; the setup
  code has to change first. Patrick did this for
  is_bare_repository_cfg and git_work_tree_cfg in his "setup: drop
  global state" series [8]. have_git_dir() is still left, and
  environment.h says it "should not have to exist at all".
- builtin/ commands: the "repo" argument of cmd_foo() can be NULL
  (e.g. "git foo -h" outside a repository), so blindly replacing
  the_repository there causes crashes. Library code is the safer
  target.
- Naming: Junio prefers a short "r" for "struct repository *"
  parameters [9].

Can there be clear criteria? Only partly. My working checklist:
  a. Who reads and writes it? (git grep every use)
  b. Is it per-repository, per-index, per-subsystem or process-wide?
  c. Is it needed before a repository is set up?
  d. Does only one file use it? Then pass the value (strategy 3).
  e. Search the list for earlier attempts and objections first.
Anything still unclear goes to the list as a question before code.

Example: git_log_output_encoding
--------------------------------
This is the encoding Git uses when it shows commit messages. It is
the twin of git_commit_encoding, which my commit_encoding patch
works on, but it is harder:

- It is set in two places: from i18n.logOutputEncoding in
  environment.c, and from "git log --encoding=..." in revision.c.
  Other revision options like --reverse are stored in struct
  rev_info, but --encoding writes the global. The parsing was moved
  into revision.c in 2006 (7cbcf4d557) so that rev-list and
  diff-tree could use it too, and at that time the rest of the
  code read the encoding from a global anyway.

- It is read through get_log_output_encoding() 15 times in 12
  files. Many of these callers (log-tree.c, bundle.c, submodule.c,
  sequencer.c) copy it into
  "struct pretty_print_context.output_encoding", so that struct
  already carries the value. That points to strategy 3: fill the
  context once from the caller and let the pretty-printing code use
  ctx->output_encoding instead of calling the global getter.

- Some callers do not print a log: remote-curl.c uses it to
  re-encode an error message from the server, and sequencer.c uses
  it when building the todo list. So the value is really "the
  user's display encoding", not something that belongs to one
  repository. That is a reason NOT to put it in
  repo_config_values, which is also what Junio said about
  commit_encoding [6].

My plan for it: first do commit_encoding (single caller), then
propose on the list storing the --encoding value in struct rev_info
and passing it through pretty_print_context, and ask whether that
design is acceptable before writing the series.

Internship Plan and Timeline
============================

The internship runs from 7 December 2026 to 8 March 2027.

Before the internship (now -- 6 Dec 2026)
- Finish open patches: commit_encoding v2, combine-diff,
  negotiator/default, range-diff, notes-cache and credential-store.
- Keep reviewing other applicants' patches in the global-state area.
- Build a list of remaining globals and USE_THE_REPOSITORY_VARIABLE
  files outside builtin/, ordered by how low in the call graph they
  sit.

Weeks 1-2 (7 Dec -- 20 Dec)
- Agree the list and order with mentors.
- First small series: one library file off
  USE_THE_REPOSITORY_VARIABLE.
- First blog post.

Weeks 3-6 (21 Dec -- 17 Jan)
- environment.c globals that only one subsystem uses: pass the value
  down, as Junio suggested for commit_encoding.
- git_log_output_encoding next: it is read in 12 files and also set
  by "--encoding", so agree the design on the list before coding.
- Ask on the list before touching the comment_line_str group and the
  abbrev globals, since they are read in many places.

Weeks 7-10 (18 Jan -- 14 Feb)
- Continue bottom-up removal of the_repository in library code,
  one subsystem per series.
- Look at a harder item if mentors agree, such as have_git_dir(),
  which still depends on the_repository.

Weeks 11-13 (15 Feb -- 8 Mar 2027)
- Land rerolls, no new big series.
- Final report on the blog and the list.
- Update the "Learn C by reading Git" guide with what I learned.

Throughout: small series, reply to reviews within a day or two,
weekly blog post, weekly sync with mentors.

Availability
============

I can give 40 hours a week to the project during the internship.
I am based in Lagos (WAT, UTC+1) and can adjust my hours for calls
and reviews when needed.

Blogging
========

I will blog on Medium (https://medium.com/@okhuomonajayi54) and
post weekly updates on my progress, what I learned and the
challenges I faced. I will share each post on the mailing list,
like previous interns did.

After the Internship
====================

After the internship I want to continue as an open source
contributor to Git: sending patches, reviewing others' work and
helping new contributors get started, the way Usman and Junio
helped me. I also want to keep the "Learn C by reading Git" guide
up to date so it stays useful for future applicants.

Appreciation
============

I want to thank Usman and Junio for always helping out during this
contribution period. I also want to thank Patrick, Karthik, Pablo,
Christian, Siddharth and Kaartic, and everyone in the Git community
for being so welcoming.

References
==========
[1] https://lore.kernel.org/git/cover.1718347699.git.ps@pks.im/
[2] https://lore.kernel.org/git/20250306-b4-pks-objects-without-the-repository-v2-1-f3465327be69@pks.im/
[3] https://lore.kernel.org/git/20250207-b4-pks-path-drop-the-repository-v2-14-13cad3c11b8a@pks.im/
[4] https://lore.kernel.org/git/cover.1733236936.git.karthik.188@gmail.com/
[5] https://lore.kernel.org/git/cover.1771258573.git.belkid98@gmail.com/
[6] https://lore.kernel.org/git/xmqq33tyn5qi.fsf@gitster.g/
[7] https://lore.kernel.org/git/xmqqwmcw97z2.fsf@gitster.g/
[8] https://lore.kernel.org/git/20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im/
[9] https://lore.kernel.org/git/xmqqwlrcrqaz.fsf@gitster.g/
[10] https://lore.kernel.org/git/20251009214445.1190274-1-okhuomonajayi54@gmail.com/
[11] https://lore.kernel.org/git/CAP8UFD2sdvkv_ZqiLZU9k5zF+tM3UTQ8+mJjziRZGzOra6dMFA@mail.gmail.com/
     https://lore.kernel.org/git/xmqqo6q5z6iu.fsf@gitster.g/
[12] https://github.com/servo/servo/pulls?q=is%3Apr+author%3Asix-shot+is%3Amerged
[13] https://github.com/geocaml/ocaml-tiff/pull/80
     https://github.com/raven-ml/raven/pulls?q=is%3Apr+author%3Asix-shot
     https://github.com/xhtmlboi/yocaml/pulls?q=is%3Apr+author%3Asix-shot
[14] https://gerrit.libreoffice.org/q/owner:okhuomonajayi54@gmail.com+status:merged
     https://whatsnew.libreoffice.org/25.8.4/
[15] https://github.com/mozilla-firefox/firefox/commits?author=okhuomonajayi54@gmail.com

Thanks for reading.

Okhuomon Ajayi
