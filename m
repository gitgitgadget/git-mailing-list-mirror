Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA15C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B660F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhJGLBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhJGLBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45835C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r10so17792378wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+zlMvpAIp6d9s58zyHXaOtFtVWBHp27PItrIqlbJDs=;
        b=NFcpN+5g/7/bzpFPTlJdU1sQb3L24PoQU6Ajlccd7rCGaQtmhwKLARhAp3LPEMGdFS
         C2H1ThMjhvT3iQYzyThjuijKN/RgIEyFDohyz/5vvdUpc2dxIOK0KNNS2xAOMQZOkLqa
         N+AKvN6YrKpyUeiH3r9y3H7QEzrZLEISlseI9icqMFwNJ87arUZFQFRk/Myx7/x9zTJN
         fkPoSWNbtjZsi9jSaBq7LdxrGE/JaV8Lz5rAtGfcgv8hz5nRKp828j9EvLvogOOAgmRS
         TtXduQxsIaDM2u2cxnRUF6lGffC+7wxWLkEGD6ejvGaITzG1KxR/QpMWjtAAwFep8SMJ
         lGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+zlMvpAIp6d9s58zyHXaOtFtVWBHp27PItrIqlbJDs=;
        b=MaHloh41dFougZt4PdlCKggMVRKgvC8qnopcoMAB98w4CR7yiOubp0swFxPkHefUfG
         WGKX379p8Gm3/CWRKSsCI7fWCuIFqbMt1kQGSBVpDQymZIT6MOcJ2XXb/VT6ESgcIfiS
         FuvpsO8UclCLdlhOBvx8tn6k3Nsvi1E10wY6l+7/laHhDDrDL2tUpzYCUEhckkR9Deor
         aMc3/+IF06XtvGABZUVfwqgP4t+Ow0Mt5dEOcu4eUOZsLAw2gvS/hUGED9XWXU0fHfOS
         2bs1YuqhwcI73seXzCoIiOoEOtV4whJJjLsuFPk1GaqS1654EEmg/v/KedSVl/LKqHVQ
         CHuw==
X-Gm-Message-State: AOAM530+NYOqQZFvsUlh0FGR5sayU5T2CTwz3iCa48Rzo5Bi84wrA8Zu
        J06n06JQC/kd47qAZ/ed9Ss/IzWHVKI=
X-Google-Smtp-Source: ABdhPJzgHvVAdnFF6aG5yaGHV7GaANFFQLO0y2w+05v1IX1CfYuF5SE0lVEjoPZ3zpTwrARMkHA6KQ==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr4466449wrh.261.1633604350537;
        Thu, 07 Oct 2021 03:59:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm7891501wmq.12.2021.10.07.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:10 -0700 (PDT)
Message-Id: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:58:54 +0000
Subject: [PATCH v5 00/15] Upstreaming the Scalar command
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

tl;dr: This series contributes the Scalar command to the Git project. This
command provides an opinionated way to create and configure repositories
with a focus on very large repositories.

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
any interested reader:
https://github.com/microsoft/git/releases/tag/v2.33.0.vfs.0.0 (it offers a
Git for Windows installer, a macOS package and an Ubuntu package).


Opportunities
=============

Apart from providing the Scalar command, this contribution is intended to
serve as a basis for further mailing list discussions on moving (some of)
these key concepts into the main Git commands.

For example, we previously discussed the idea of a "git big-clone" that does
much of what "scalar clone" is doing. This patch series is a step to make
such functionality exist in the Git code base while we simmer on what such a
"git big-clone" command-line interface would look like.

This is one of many possible ways to do this. Creating a 'git big-clone'
could lock Git into backwards compatibility concerns so it is necessary to
approach such an endeavor with caution. As a discussion starter, the scalar
clone <url> command does roughly this:

 1. git clone --sparse --filter=blob:none /src
 2. git -C /src sparse-checkout init --cone
 3. git -C /src config (many times)
 4. git -C /src maintenance start

It is my hope inspire discussions about what parts of Scalar could go into
core Git, and where, and in which form. While we wish to maintain
backwards-compatibility of Scalar's command-line interface (because it is
already in use), by having the Scalar code in the same code base as Git's,
it will be much easier to move functionality without having to maintain
loose version coupling between independently-versioned Scalar and Git. The
tight version-coupling, along with having access to libgit.a also allows the
C-based implementation of Scalar to be much smaller than the original .NET
version.

For example, we might choose in the future to implement, say, git clone
--scale=partial,cone to initialize a partial clone with a cone-sparse
checkout, that would not only be totally doable, and not only would we
already have precedent and data to prove that this actually makes engineers
happy who have to work on ginormous repositories, but we could then also
implement it by moving parts of contrib/scalar/ to builtin/ (where
contrib/scalar/ would then call the built-ins accordingly rather than
hard-coding the defaults itself).

We now also have the opportunity to discuss the merits of Scalar's clone
caching, which is not actually part of this patch series because it is a bit
coupled with the GVFS parts of microsoft/git for the moment, where clones
automatically get registered with a populated alternate repository that is
identified by the URL, meaning: subsequent clones of the same repository are
vastly faster than the first one because they do not actually download the
already-received objects again, they access the cache instead.

Another thing that I could imagine to be discussed at length is the
distinction between enlistment and worktree (where the latter is the actual
Git worktree and usually lives in the src/ subdirectory of the former). This
encourages untracked and ignored files to be placed outside the worktree,
making Git's job much easier. This idea, too, might find its way in one way
or another into Git proper.

These are just a few concepts in Scalar that do not yet have equivalents in
Git. By putting this initial implementation into contrib/, we create a
foundation for future discussions of these concepts.

We plan on updating the recommended config settings in scalar register as
new Git features are available (such as builtin FSMonitor and sparse-index,
when ready). To facilitate upgrading existing Scalar enlistments, their
paths are automatically added to the [scalar] section of the global Git
config, and the scalar reconfigure --all command will process all of them.


Epilogue
========

Now, to address some questions that I imagine every reader has who made it
this far:

 * Why not put the Scalar functionality directly into a built-in? Creating a
   Git builtin requires scrutiny over every aspect of the feature, which is
   difficult to do while also maintaining the command-line interface
   contract and expected behavior of the Scalar command (there are existing
   users, after all). By having the Scalar command in contrib/, we present a
   simple option for users to have these features in the short term while
   the Git contributor community decides which bits to absorb into Git
   built-ins.
 * Why implement the Scalar command in the Git codebase? We ported Scalar to
   the microsoft/git fork for several reasons. First, we realized it was
   possible now that the core features exist inside Git itself. Second,
   compiling Scalar directly within a version of Git allows us to remove a
   version compatibility check from each config option that might or might
   not apply based on the installed Git version. Finally, this new location
   has greatly simplified our release process and the installation process
   for users. We now have ways to install Scalar with microsoft/git via
   winget, brew, and apt-get. This has been the case since we shipped
   v2.32.0 to our users, read: this setup has served us well already.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   we do have evidence that the Scalar command is a helpful tool that offers
   an simple way to handle huge repositories with ease. By contributing it
   to the core Git project, we are able to share it with more users,
   especially some users who do not want to install the microsoft/git fork.
   We intend to include Scalar as a component in git-for-windows/git, but
   are contributing it here first. Further, we think there is benefit to the
   Git developer community as this presents an example of how to set certain
   defaults that work for large repositories.
 * Does this integrate with the built-in FSMonitor yet? No, not yet. I do
   have a couple of add-on patch series lined up, one of them being the
   integration with the built-in FSMonitor, which obviously has to wait
   until the FSMonitor patch series advances further.

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
 contrib/scalar/scalar.txt        | 154 ++++++
 contrib/scalar/t/Makefile        |  78 +++
 contrib/scalar/t/t9099-scalar.sh |  88 ++++
 7 files changed, 1236 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v4:

  1:  852ec003109 !  1:  7119a8efc21 scalar: create a rudimentary executable
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Makefile ##
     -@@ Makefile: endif
     - .PHONY: objects
     - objects: $(OBJECTS)
     - 
     +@@ Makefile: OBJECTS += $(FUZZ_OBJS)
     + ifndef NO_CURL
     + 	OBJECTS += http.o http-walker.o remote-curl.o
     + endif
     ++
      +SCALAR_SOURCES := contrib/scalar/scalar.c
      +SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
      +OBJECTS += $(SCALAR_OBJECTS)
      +
     - dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
     - dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
     + .PHONY: objects
     + objects: $(OBJECTS)
       
      @@ Makefile: $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
  2:  6ab9c7195da =  2:  edc1e5f73bd scalar: start documenting the command
  3:  14992033d7c =  3:  9eeb66d5b5d scalar: create test infrastructure
  4:  bbbc4c33390 !  4:  8ebfa51ae15 scalar: 'register' sets recommended config and starts maintenance
     @@ contrib/scalar/scalar.c
      +		const size_t len = path.len;
      +
      +		/* check if currently in enlistment root with src/ workdir */
     -+		strbuf_addstr(&path, "/src/.git");
     -+		if (is_git_directory(path.buf)) {
     -+			strbuf_strip_suffix(&path, "/.git");
     -+
     ++		strbuf_addstr(&path, "/src");
     ++		if (is_nonbare_repository_dir(&path)) {
      +			if (enlistment_root)
      +				strbuf_add(enlistment_root, path.buf, len);
      +
     @@ contrib/scalar/scalar.c
      +		strbuf_setlen(&path, len);
      +
      +		/* check if currently in workdir */
     -+		strbuf_addstr(&path, "/.git");
     -+		if (is_git_directory(path.buf)) {
     -+			strbuf_setlen(&path, len);
     -+
     ++		if (is_nonbare_repository_dir(&path)) {
      +			if (enlistment_root) {
      +				/*
      +				 * If the worktree's directory's name is `src`, the enlistment is the
     @@ contrib/scalar/scalar.c
      +			enlistment_found = 1;
      +			break;
      +		}
     -+
     -+		strbuf_setlen(&path, len);
      +	} while (strbuf_parent_directory(&path));
      +
      +	if (!enlistment_found)
  5:  eadcddb2a9b =  5:  51b5fc577c9 scalar: 'unregister' stops background maintenance
  6:  c3c2f3a4971 =  6:  0041477374e scalar: let 'unregister' handle a deleted enlistment directory gracefully
  7:  90ef9b826b2 =  7:  12efa86e4cb scalar: implement 'scalar list'
  8:  79cde4417d8 =  8:  670891d14cc scalar: implement the `clone` subcommand
  9:  0acdaeb7396 =  9:  03b8385ebb5 scalar: teach 'clone' to support the --single-branch option
 10:  64e3403ac12 = 10:  5a0b3843f98 scalar: implement the `run` command
 11:  ada242c7c8c = 11:  6d9aaeb05fa scalar: allow reconfiguring an existing enlistment
 12:  5c11117da51 = 12:  2967d7f1425 scalar: teach 'reconfigure' to optionally handle all registered enlistments
 13:  914c16c7fcd ! 13:  8069cc536fe scalar: implement the `delete` command
     @@ contrib/scalar/scalar.c
       #include "run-command.h"
       #include "refs.h"
      +#include "dir.h"
     ++#include "packfile.h"
       
       /*
        * Remove the deepest subdirectory in the provided path string. Path must not
     @@ contrib/scalar/scalar.c: static int cmd_unregister(int argc, const char **argv)
       
      +static int cmd_delete(int argc, const char **argv)
      +{
     ++	char *cwd = xgetcwd();
      +	struct option options[] = {
      +		OPT_END(),
      +	};
     @@ contrib/scalar/scalar.c: static int cmd_unregister(int argc, const char **argv)
      +
      +	setup_enlistment_directory(argc, argv, usage, options, &enlistment);
      +
     -+	res = delete_enlistment(&enlistment);
     ++	if (dir_inside_of(cwd, enlistment.buf) >= 0)
     ++		res = error(_("refusing to delete current working directory"));
     ++	else {
     ++		close_object_store(the_repository->objects);
     ++		res = delete_enlistment(&enlistment);
     ++	}
      +	strbuf_release(&enlistment);
     ++	free(cwd);
      +
      +	return res;
      +}
 14:  06995770120 ! 14:  2ecfaa5d0fe scalar: implement the `version` command
     @@ Commit message
      
       ## contrib/scalar/scalar.c ##
      @@
     - #include "run-command.h"
       #include "refs.h"
       #include "dir.h"
     + #include "packfile.h"
      +#include "help.h"
       
       /*
 15:  7539725bb4f = 15:  f81e8b3bcf1 scalar: accept -C and -c options before the subcommand

-- 
gitgitgadget
