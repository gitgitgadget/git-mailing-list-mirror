Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D15C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CF363215
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhKQOWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbhKQOWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DEC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso3909285wmh.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/iEoI0xLK7Ig68LSchrkOG1DLBoSRm6uaW7L2FDCCsw=;
        b=nOlK7Js09WnygTwu9QumeMB2lj3tpuFtmV+4DX4jzM1RZF+KcCjsLZJ8/qXOSeBVez
         yqk/PlKgh5QOHnPdSdeqgjfO05WxQa+FiIbrY09yFbsQKA1zD7ExjvnXuS5WNvSaM1Wx
         OZqWuv8/4a/48qQ45tjDXHG0dFlUKqsbo1NnI8WoojiYbC7EVQDTxPLP/GXyNac34o0O
         NEtGEC0VZRQb5sKnHD32OboPMlckRnUjoypbTm+A0j8jBjG5R+mZhyAPcGWXV/apdy7D
         AiipZC3r7lQZBS9TUIaiBNKEq7IGCwMf7M8OX0l4ukIH+IhvOaTk1vhYenRoGWyIQ4gw
         zENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/iEoI0xLK7Ig68LSchrkOG1DLBoSRm6uaW7L2FDCCsw=;
        b=brmmAfwFGDgsjLALPOuSRANFZjf0kp5BzhclZyFVXIQQmm3DUe/8TE/XAaBnCYu36O
         F/rseF6WWOduQCpkvvQpoonjVvRbjPgy/laJ3lVUGl8l7Om9jbM3ctvLip9yCQFx2LpX
         14/JtbN5TiTAdMpB7Nb1ZuxHAy95+jUtdLbrq6fkis0aVo3fZpp+3j39DsxBxLy0KrGM
         TUrgIfCkY4p8AN97CLcyXn58gliCOuE3PtTaccquR4FrzZwEOl6/+LYWyQ7t9PlO5iKH
         8CNOgqUjGWd8qmyrM21OTANmVs59Ytq2a0KGVY1+zIoamLExtmQm1cmEPsWi011GXAbL
         rC+g==
X-Gm-Message-State: AOAM531DfdO8FqTI1B/ZtfPitHwaHqfaufiGDGhGYHIx2pajzFHrQbL4
        EdTzjux2olN7jbpA96iOWqGUjBgaFWI=
X-Google-Smtp-Source: ABdhPJyRikdClEW7xrCFc71z/m4LcQ750GluGqPUYk0iVhY5tauJqcMvrY5cHN8mQLjzss5GNQ47eg==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr18492642wml.53.1637158763805;
        Wed, 17 Nov 2021 06:19:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm1424wry.80.2021.11.17.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:23 -0800 (PST)
Message-Id: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:05 +0000
Subject: [PATCH v7 00/17] Upstreaming the Scalar command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr: This series contributes the core part of the Scalar command to the
Git project. This command provides an opinionated way to create and
configure Git repositories with a focus on very large repositories.

Changes since v6:

 * Rebased on top of v2.34.0.
 * Inserted a commit that adds contrib/scalar/README.md, containing the
   roadmap of what I have planned for Scalar.
 * The Scalar test's definition of GIT_TEST_MAINT_SCHEDULER has been
   adjusted to accommodate for a change in v2.32.0..v2.34.0.
 * The config setting defaults now include fetch.showForcedUpdates=false,
   which has been identified as helping with a performance issue in large
   repositories.
 * To avoid mistaking the current patch series for being feature-complete
   enough to unleash onto end users, I moved the Makefile rules to build
   HTML/manual pages to a later patch series.
 * The patch that adds support for -c <key>=<value> and -C <directory> was
   moved to its own add-on patch series: While it is obvious that those
   options are valuable to have, an open question is whether there are other
   "pre-command" options in git that would be useful, too, and I would like
   to postpone that discussion to that date.
 * I added two patches that I had planned on keeping in an add-on patch
   series for later, to build and test Scalar as part of the CI. I am still
   not 100% certain that it is a good idea to do so already now, but let's
   see what the reviewers have to say.

Changes since v5:

 * Fixed the commit message talking about make -C contrib/scalar/Makefile.
 * Fixed the git ls-tree invocation suggested in the manual for scalar
   clone.
 * Invoking make -C contrib/scalar, then changing a source file of libgit.a
   and then immediately invoking make -C contrib/scalar again will now
   implicitly rebuild libgit.a.

Changes since v4:

 * scalar delete now refuses to delete anything if it was started from
   within the enlistment.
 * scalar delete releases any handles to the object store before deleting
   the enlistment.
 * The OBJECTS list in the Makefile will now include Scalar.
 * scalar register now supports secondary worktrees, in addition to the
   primary worktree.

Changes since v3:

 * Moved the "Changes since" section to the top, to make it easier to see
   what changed.
 * Reworded the commit message of the first patch.
 * Removed the [RFC] prefix because I did not hear any objections against
   putting this into contrib/.

Changes since v2:

 * Adjusted the description of the list command in the manual page , as
   suggested by Bagas.
 * Addressed two style nits in cmd_run().
 * The documentation of git reconfigure -a was improved.

Changes since v1:

 * A couple typos were fixed
 * The code parsing the output of ls-remote was made more readable
 * The indentation used in scalar.txt now consistently uses tabs
 * We no longer hard-code core.bare = false when registering with Scalar


Background
==========

Microsoft invested a lot of effort into scaling Git to the needs of the
Windows operating system source code. Based on the experience of the first
approach, VFS for Git, the Scalar project was started. Scalar specifically
has as its core goal to funnel all improvements into core Git.


The present
===========

The Scalar project provides a completely functional non-virtual experience
for monorepos. But why stop there. The Scalar project was designed to be a
self-destructing vehicle to allow those key concepts to be moved into core
Git itself for the benefit of all. For example, partial clone,
sparse-checkout, and scheduled background maintenance have already been
upstreamed and removed from Scalar proper. This patch series provides a
C-based implementation of the final remaining portions of the Scalar
command. This will make it easier for users to experiment with the Scalar
command. It will also make it substantially easier to experiment with moving
functionality from Scalar into core Git, while maintaining
backwards-compatibility for existing Scalar users.

The C-based Scalar has been shipped to Scalar users, and can be tested by
any interested reader: https://github.com/microsoft/git/releases/ (it offers
a Git for Windows installer, a macOS package and an Ubuntu package, Scalar
has been included since v2.33.0.vfs.0.0).


Next steps
==========

Since there are existing Scalar users, I want to ensure
backwards-compatibility with its existing command-line interface. Keeping
that in mind, everything in this series is up for discussion.

I obviously believe that Scalar brings a huge benefit, and think that it
would be ideal for all of Scalar's learnings to end up in git clone/git
init/git maintenance eventually. It is also conceivable, however, that the
scalar command could graduate to be a core part of Git at some stage in the
future (such a decision would probably depend highly on users' feedback).
See also the discussion about the architecture of Scalar
[https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/],
kicked off by Stolee.

On top of this patch series, I have lined up a few more:

 1. Implement a scalar diagnose command.
 2. Use the built-in FSMonitor (that patch series obviously needs to wait
    for FSMonitor to be integrated).
 3. Modify the config machinery to be more generous about concurrent writes,
    say, to the user-wide config.
 4. A few patches to optionally build and install scalar as part of a
    regular Git install (also teaching git help scalar to find the Scalar
    documentation

These are included in my vfs-with-scalar branch thicket
[https://github.com/dscho/git/commits/vfs-with-scalar]. On top of that, this
branch thicket also includes patches I do not plan on upstreaming, mainly
because they are too specific either to VFS for Git, or they support Azure
Repos (which does not offer partial clones but speaks the GVFS protocol,
which can be used to emulate partial clones).

One other thing is very interesting about that vfs-with-scalar branch
thicket: it contains a GitHub workflow which will run Scalar's quite
extensive Functional Tests suite. This test suite is quite comprehensive and
caught us a lot of bugs in the past, not only in the Scalar code, but also
core Git.


Epilogue
========

Now, to address some questions that I imagine every reader has who made it
this far:

 * Why not put the Scalar functionality directly into core Git, even a
   built-in? I wanted to provide an easy way for Git contributors to "play
   with" Scalar, without forcing a new top-level command into Git.
 * Why implement the Scalar command in the Git code base? Apart from
   simplifying Scalar maintenance in the Microsoft port of Git, the tight
   version coupling between Git and Scalar reduces the maintenance burden
   even further. Besides, I believe that it will make it much easier to
   shift functionality from Scalar into core Git, once we took the hurdle of
   accepting the Scalar code into the code base.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   our data-driven approach provides evidence that Scalar helps handling
   huge repositories with ease. By contributing it to the core Git project,
   we are able to share it with more users, especially some users who do not
   want to install Microsoft's fork of Git. We also hope that a lot of
   Scalar (maybe all of it) will end up in core Git, to benefit even more
   users.

Derrick Stolee (4):
  scalar: 'register' sets recommended config and starts maintenance
  scalar: 'unregister' stops background maintenance
  scalar: implement 'scalar list'
  scalar: implement the `run` command

Johannes Schindelin (12):
  scalar: add a README with a roadmap
  scalar: create a rudimentary executable
  scalar: start documenting the command
  scalar: create test infrastructure
  cmake: optionally build `scalar`, too
  ci: also run the `scalar` tests
  scalar: let 'unregister' handle a deleted enlistment directory
    gracefully
  scalar: implement the `clone` subcommand
  scalar: teach 'clone' to support the --single-branch option
  scalar: allow reconfiguring an existing enlistment
  scalar: teach 'reconfigure' to optionally handle all registered
    enlistments
  scalar: implement the `version` command

Matthew John Cheetham (1):
  scalar: implement the `delete` command

 .github/workflows/main.yml          |  15 +
 Makefile                            |   9 +
 ci/run-build-and-tests.sh           |   1 +
 ci/run-test-slice.sh                |   5 +
 contrib/buildsystems/CMakeLists.txt |  14 +
 contrib/scalar/.gitignore           |   2 +
 contrib/scalar/Makefile             |  45 ++
 contrib/scalar/README.md            |  71 +++
 contrib/scalar/scalar.c             | 826 ++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt           | 145 +++++
 contrib/scalar/t/Makefile           |  78 +++
 contrib/scalar/t/t9099-scalar.sh    |  88 +++
 12 files changed, 1299 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/README.md
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v6:

  -:  ----------- >  1:  3aa095dc824 scalar: add a README with a roadmap
  1:  9b0b00438ec =  2:  e0693cc713c scalar: create a rudimentary executable
  2:  40fee75968e !  3:  d80627615f8 scalar: start documenting the command
     @@ Metadata
       ## Commit message ##
          scalar: start documenting the command
      
     -    This commit establishes the infrastructure to build the manual page for
     -    the `scalar` command.
     +    Let's build up the documentation for the Scalar command along with the
     +    patches that implement its functionality.
      
     -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -
     - ## contrib/scalar/.gitignore ##
     -@@
     -+/*.xml
     -+/*.1
     -+/*.html
     - /*.exe
     - /scalar
     +    Note: To discourage the feature-incomplete documentation from being
     +    mistaken for the complete thing, we do not yet provide any way to build
     +    HTML or manual pages from the text file.
      
     - ## contrib/scalar/Makefile ##
     -@@ contrib/scalar/Makefile: ifndef V
     - 	QUIET_SUBDIR0  = +@subdir=
     - 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
     - 			 $(MAKE) $(PRINT_DIR) -C $$subdir
     -+	QUIET          = @
     - else
     - 	export V
     - endif
     -@@ contrib/scalar/Makefile: $(TARGETS): $(GITLIBS) scalar.c
     - 
     - clean:
     - 	$(RM) $(TARGETS)
     -+	$(RM) scalar.1 scalar.html scalar.xml
     - 
     --.PHONY: $(GITLIBS) all clean FORCE
     -+docs: scalar.html scalar.1
     -+
     -+scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
     -+
     -+scalar.html scalar.1: scalar.txt
     -+	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
     -+		MAN_TXT=../contrib/scalar/scalar.txt \
     -+		../contrib/scalar/$@
     -+	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
     -+
     -+.PHONY: $(GITLIBS) all clean docs FORCE
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.txt (new) ##
      @@
  3:  e3507c2d5f7 !  4:  9da1616849e scalar: create test infrastructure
     @@ Commit message
          more tests in subsequent commits that introduce corresponding, new
          functionality.
      
     -    Note: this test script is intended to test `scalar` only lightly, even
     +    Note: This test script is intended to test `scalar` only lightly, even
          after all of the functionality is implemented.
      
          A more comprehensive functional (or: integration) test suite can be
          found at https://github.com/microsoft/scalar; It is used in the workflow
          https://github.com/microsoft/git/blob/HEAD/.github/workflows/scalar-functional-tests.yml
          in Microsoft's Git fork. This test suite performs end-to-end tests with
     -    a real remote repository, and is run as part of the regular CI builds.
     +    a real remote repository, and is run as part of the regular CI and PR
     +    builds in that fork.
     +
          Since those tests require some functionality supported only by
          Microsoft's Git fork ("GVFS protocol"), there is no intention to port
          that fuller test suite to `contrib/scalar/`.
     @@ contrib/scalar/Makefile: $(TARGETS): $(GITLIBS) scalar.c
       clean:
      -	$(RM) $(TARGETS)
      +	$(RM) $(TARGETS) ../../bin-wrappers/scalar
     - 	$(RM) scalar.1 scalar.html scalar.xml
       
     +-.PHONY: $(GITLIBS) all clean FORCE
      +../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
      +	@mkdir -p ../../bin-wrappers
      +	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     @@ contrib/scalar/Makefile: $(TARGETS): $(GITLIBS) scalar.c
      +test: all
      +	$(MAKE) -C t
      +
     - docs: scalar.html scalar.1
     - 
     - scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
     -@@ contrib/scalar/Makefile: scalar.html scalar.1: scalar.txt
     - 		../contrib/scalar/$@
     - 	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
     - 
     --.PHONY: $(GITLIBS) all clean docs FORCE
     -+.PHONY: $(GITLIBS) all clean docs test FORCE
     ++.PHONY: $(GITLIBS) all clean test FORCE
      
       ## contrib/scalar/t/Makefile (new) ##
      @@
  -:  ----------- >  5:  dbaad4753c1 cmake: optionally build `scalar`, too
  -:  ----------- >  6:  1b0328fa236 ci: also run the `scalar` tests
  4:  53224e506ea !  7:  cca604ef326 scalar: 'register' sets recommended config and starts maintenance
     @@ contrib/scalar/scalar.c
      +		{ "commitGraph.generationVersion", "1" },
      +		{ "core.autoCRLF", "false" },
      +		{ "core.safeCRLF", "false" },
     ++		{ "fetch.showForcedUpdates", "false" },
      +		{ NULL, NULL },
      +	};
      +	int i;
  5:  3591e53700b =  8:  9fea89cd161 scalar: 'unregister' stops background maintenance
  6:  fe04ae7ec66 =  9:  5e077bf892b scalar: let 'unregister' handle a deleted enlistment directory gracefully
  7:  136aec439fd = 10:  dfa0c470989 scalar: implement 'scalar list'
  8:  ed24a5e9b4c ! 11:  febefe39886 scalar: implement the `clone` subcommand
     @@ contrib/scalar/t/t9099-scalar.sh: PATH=$PWD/..:$PATH
       
       . ../../../t/test-lib.sh
       
     -+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
     ++GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
      +export GIT_TEST_MAINT_SCHEDULER
      +
       test_expect_success 'scalar shows a usage' '
  9:  5ee54a9e25f = 12:  2677bcff335 scalar: teach 'clone' to support the --single-branch option
 10:  3361eb8f091 = 13:  99affb84284 scalar: implement the `run` command
 11:  c4778c1dc5f = 14:  69e2242240b scalar: allow reconfiguring an existing enlistment
 12:  cd824e9e483 = 15:  0068c18aa62 scalar: teach 'reconfigure' to optionally handle all registered enlistments
 13:  843026d5481 = 16:  d5218523a38 scalar: implement the `delete` command
 14:  5ca169b3f3a = 17:  96a803416b5 scalar: implement the `version` command
 15:  e3a6eea0534 <  -:  ----------- scalar: accept -C and -c options before the subcommand

-- 
gitgitgadget
