Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79911C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5786060296
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhJ0I3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhJ0I3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CEC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j35-20020a05600c1c2300b0032caeca81b7so2457069wms.0
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qkoXr7vi4HQn1de4t7jUwtlp8Q6IPQ3WbZ3Y6yopBWo=;
        b=AsJjoPFIij8MHDsTZc7oKwgvFFRpwIpNs/kv9HpCYSaysdJ9wmdoaxzLg5YN1d8A6/
         q87N8bp+Ibesng0/xutt6SbfhsyFaIUR2N/vgyZeV/RrhjNMRtkXeabv6KZRwxN6wS4Y
         IlOxpWv96FAtNqm/TpA5aHDvXB5ztltZiU6bvawdvrElAOkMrX2zalnh6EF2PB7Ezh/o
         OvAaN+pB8kOwmAXY02rAJqNfrkMxJf1y1G0ZUWmEtpDOhgc7xXSHAq96nqJO5b6i4x7L
         Y/zsUaf/AkQg8RrSp+8lUoR9xk31wYmHI9NQT8muKY1g6B0MS/VPYf/BKsXeyRJKLq3C
         98oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qkoXr7vi4HQn1de4t7jUwtlp8Q6IPQ3WbZ3Y6yopBWo=;
        b=IFIJBEm18ohhQkZrtW8IMEj722WdL2fhrj0jHAmYyQkoJEo9wS5/Xywqa4B9YbOQgH
         FFFz9miFzv+91EBzgesRLaYt2QJ9brkU2Wl4g1kgtOWTaVueBwj8ztbUpuPmKa8ONUTU
         3wrDVpIPpmZ1T/AQYcRe1m/Tw3h+mmDLBPiqpirsRsgX4b2YZb3/VPt7ygNxTwZNGSQh
         kmmneRBkWjdMOJx2frGVV6zjZms6sFOR1iaT1rYUCIHz6EfpwseJuUKQyZpQvhf1GDZ/
         rrO14zSe41ymtYdu2V+enFnN8PhvXZwZ7YZQpjnUdnjB8Mm/VU6OhiPou74KRBNVkDUi
         CPhA==
X-Gm-Message-State: AOAM530L7tD3LeLrIy+FzbG74M/fp/dSxCTa8baLMwCnveitNBzy+2s9
        X81vablsZwwQWN2n9RC7l/tFCxAh+UA=
X-Google-Smtp-Source: ABdhPJx4KorFTlMY73awAi13VNraZu+a2d4ZUt3h43qdQqjmyuppOIG1HWWim6aZEnMTC5Kk/dvQuQ==
X-Received: by 2002:a7b:cb12:: with SMTP id u18mr4208760wmj.109.1635323240323;
        Wed, 27 Oct 2021 01:27:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm2944800wmq.0.2021.10.27.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:19 -0700 (PDT)
Message-Id: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:04 +0000
Subject: [PATCH v6 00/15] Upstreaming the Scalar command
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

Years ago, Microsoft wanted to move the source code of the Windows operating
system to Git. The challenge there was to prove that Git could scale to
massive monorepos. The VFS for Git (formerly GVFS) project was born to take
up that challenge.

The final solution included a virtual filesystem (with both user-mode and
kernel components) and a customized fork of Git for Windows. This solution
contained several key concepts, such as only populating a portion of the
working directory, demand-fetching blobs, and performing periodic repo
maintenance in the background. However, the required kernel drivers made it
difficult to port the solution to other platforms.

But it was realized that many of these key concepts were independent of the
actual VFS and its projection of the working directory. The Scalar project
was created to make that separation, refine the key concepts, and then
extract those features into the new Scalar command.


The present
===========

The Scalar project provides a completely functional non-virtual experience
for monorepos. But why stop there. The Scalar project was designed to be a
self-destructing vehicle to allow those key concepts to be moved into core
Git itself for the benefit of all. For example, partial clone,
sparse-checkout, and background maintenance have already been upstreamed and
removed from Scalar proper. This patch series provides a C-based
implementation of the final remaining portions of the Scalar command. This
will make it easier for users to experiment with the Scalar command. It will
also make it substantially easier to experiment with moving functionality
from Scalar into core Git, while maintaining backwards-compatibility for
existing Scalar users.

The C-based Scalar has been shipped to Scalar users, and can be tested by
any interested reader: https://github.com/microsoft/git/releases/ (it offers
a Git for Windows installer, a macOS package and an Ubuntu package, Scalar
has been included since v2.33.0.vfs.0.0).


Next steps
==========

I have lined up a few more patch series on top of this one:

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
   built-in? Creating a Git builtin requires scrutiny over every aspect of
   the feature, which is difficult to do while also maintaining the
   command-line interface contract and expected behavior of the Scalar
   command (there are existing users, after all). By having the Scalar
   command in contrib/, we present a simple option for users to have these
   features in the short term while the Git contributor community decides
   which bits to absorb into Git built-ins.
 * Why implement the Scalar command in the Git codebase? We ported Scalar to
   the microsoft/git fork for several reasons. First, we realized it was
   possible in the first place, now that the core features exist inside Git
   itself. Second, compiling Scalar directly within a version of Git allows
   us to remove a version compatibility check from each config option that
   might or might not apply based on the installed Git version. Finally,
   this new location has greatly simplified our release process and the
   installation process for users. We now have ways to install Scalar with
   microsoft/git via winget, brew, and apt-get. This has been the case since
   we shipped v2.32.0 to our users, read: this setup has served us well
   already.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   we do have evidence that the Scalar command is a helpful tool that offers
   an simple way to handle huge repositories with ease. By contributing it
   to the core Git project, we are able to share it with more users,
   especially some users who do not want to install the microsoft/git fork.
   We intend to include Scalar as a component in git-for-windows/git, but
   are contributing it here first. Further, we think there is benefit to the
   Git developer community as this presents an example of how to set certain
   defaults that work for large repositories.

Derrick Stolee (4):
  scalar: 'register' sets recommended config and starts maintenance
  scalar: 'unregister' stops background maintenance
  scalar: implement 'scalar list'
  scalar: implement the `run` command

Johannes Schindelin (10):
  scalar: create a rudimentary executable
  scalar: start documenting the command
  scalar: create test infrastructure
  scalar: let 'unregister' handle a deleted enlistment directory
    gracefully
  scalar: implement the `clone` subcommand
  scalar: teach 'clone' to support the --single-branch option
  scalar: allow reconfiguring an existing enlistment
  scalar: teach 'reconfigure' to optionally handle all registered
    enlistments
  scalar: implement the `version` command
  scalar: accept -C and -c options before the subcommand

Matthew John Cheetham (1):
  scalar: implement the `delete` command

 Makefile                         |   9 +
 contrib/scalar/.gitignore        |   5 +
 contrib/scalar/Makefile          |  57 +++
 contrib/scalar/scalar.c          | 845 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        | 155 ++++++
 contrib/scalar/t/Makefile        |  78 +++
 contrib/scalar/t/t9099-scalar.sh |  88 ++++
 7 files changed, 1237 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v5:

  1:  7119a8efc21 !  1:  9b0b00438ec scalar: create a rudimentary executable
     @@ Commit message
      
          The idea here is that you can (optionally) build Scalar via
      
     -            make -C contrib/scalar/Makefile
     +            make -C contrib/scalar/
      
          This will build the `scalar` executable and put it into the
          contrib/scalar/ subdirectory.
     @@ contrib/scalar/Makefile (new)
      +TARGETS = scalar$(X) scalar.o
      +GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
      +
     -+all: scalar$X
     ++all: scalar$(X)
      +
      +$(GITLIBS):
      +	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
     @@ contrib/scalar/Makefile (new)
      +clean:
      +	$(RM) $(TARGETS)
      +
     -+.PHONY: all clean FORCE
     ++.PHONY: $(GITLIBS) all clean FORCE
      
       ## contrib/scalar/scalar.c (new) ##
      @@
  2:  edc1e5f73bd !  2:  40fee75968e scalar: start documenting the command
     @@ contrib/scalar/Makefile: $(TARGETS): $(GITLIBS) scalar.c
       	$(RM) $(TARGETS)
      +	$(RM) scalar.1 scalar.html scalar.xml
       
     --.PHONY: all clean FORCE
     +-.PHONY: $(GITLIBS) all clean FORCE
      +docs: scalar.html scalar.1
      +
      +scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
     @@ contrib/scalar/Makefile: $(TARGETS): $(GITLIBS) scalar.c
      +		../contrib/scalar/$@
      +	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
      +
     -+.PHONY: all clean docs FORCE
     ++.PHONY: $(GITLIBS) all clean docs FORCE
      
       ## contrib/scalar/scalar.txt (new) ##
      @@
  3:  9eeb66d5b5d !  3:  e3507c2d5f7 scalar: create test infrastructure
     @@ contrib/scalar/Makefile: include ../../config.mak.uname
       TARGETS = scalar$(X) scalar.o
       GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
       
     --all: scalar$X
     -+all: scalar$X ../../bin-wrappers/scalar
     +-all: scalar$(X)
     ++all: scalar$(X) ../../bin-wrappers/scalar
       
       $(GITLIBS):
       	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
     @@ contrib/scalar/Makefile: scalar.html scalar.1: scalar.txt
       		../contrib/scalar/$@
       	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
       
     --.PHONY: all clean docs FORCE
     -+.PHONY: all clean docs test FORCE
     +-.PHONY: $(GITLIBS) all clean docs FORCE
     ++.PHONY: $(GITLIBS) all clean docs test FORCE
      
       ## contrib/scalar/t/Makefile (new) ##
      @@
  4:  8ebfa51ae15 =  4:  53224e506ea scalar: 'register' sets recommended config and starts maintenance
  5:  51b5fc577c9 =  5:  3591e53700b scalar: 'unregister' stops background maintenance
  6:  0041477374e =  6:  fe04ae7ec66 scalar: let 'unregister' handle a deleted enlistment directory gracefully
  7:  12efa86e4cb =  7:  136aec439fd scalar: implement 'scalar list'
  8:  670891d14cc !  8:  ed24a5e9b4c scalar: implement the `clone` subcommand
     @@ contrib/scalar/scalar.txt: an existing Git worktree with Scalar whose name is no
      +`git sparse-checkout set` to expand the set of directories you want to see,
      +or `git sparse-checkout disable` to expand to all files (see
      +linkgit:git-sparse-checkout[1] for more details). You can explore the
     -+subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
     ++subdirectories outside your sparse-checkout by using `git ls-tree
     ++HEAD[:<directory>]`.
      +
      +-b <name>::
      +--branch <name>::
  9:  03b8385ebb5 !  9:  5ee54a9e25f scalar: teach 'clone' to support the --single-branch option
     @@ contrib/scalar/scalar.txt: scalar - an opinionated repository management tool
       scalar list
       scalar register [<enlistment>]
       scalar unregister [<enlistment>]
     -@@ contrib/scalar/scalar.txt: subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
     +@@ contrib/scalar/scalar.txt: HEAD[:<directory>]`.
       	Instead of checking out the branch pointed to by the cloned
       	repository's HEAD, check out the `<name>` branch instead.
       
 10:  5a0b3843f98 = 10:  3361eb8f091 scalar: implement the `run` command
 11:  6d9aaeb05fa = 11:  c4778c1dc5f scalar: allow reconfiguring an existing enlistment
 12:  2967d7f1425 = 12:  cd824e9e483 scalar: teach 'reconfigure' to optionally handle all registered enlistments
 13:  8069cc536fe = 13:  843026d5481 scalar: implement the `delete` command
 14:  2ecfaa5d0fe = 14:  5ca169b3f3a scalar: implement the `version` command
 15:  f81e8b3bcf1 = 15:  e3a6eea0534 scalar: accept -C and -c options before the subcommand

-- 
gitgitgadget
