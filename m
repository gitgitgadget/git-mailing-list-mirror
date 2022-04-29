Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 09:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357142AbiD2KAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiD2KAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E242EE4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e2so10073821wrh.7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xi1JjH4TkWp/yO542WL8D/nLwCQNYfi63Mnk1uhlthI=;
        b=QkxByOKWj/EzpT3DSze1h+QfKlu6YWVqVetyTWkUekz8FU4PRQTkuzTf6JqfLWPnqn
         ieNcv2iUqdMK4gglo2wQXsu7SoOrPFMJn664lW+DQmWD7cu1hl3mMj/5p3lnmDTvylTH
         NOc8I+Whm9qJ+V2369XbT5HfOe4m0tI+0gCPN7IAnS5p9bNvPNdAuWFcQVXtjwvJ1+5Z
         HEQqJOWNPtWCe9T8hjVjL+A7XGYZfmmmaoIUSPxsdiLPtWC4Pd3t3jv5SdvOcbDDNBeI
         4CrMXdkxDM8Pq3vsD2aEOsty4vuQi0b3LPoa1Wa2praWoDu927cWgCJ7J6d3DSGgl5se
         MvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xi1JjH4TkWp/yO542WL8D/nLwCQNYfi63Mnk1uhlthI=;
        b=pgw8J4+5qq0UQjaOQBEPtGH8fs6g5FVFjMC5XhJt6Zb66n4woY5iULtNbbtJDxWgaV
         YT8fe/zqxb07OS5iRztlKBdCUHWMQvPyxtoVAEFjNzRi1deefEAOWYEhh584WS0POg94
         MjBpbGE8rodejz9RCWo5jjm2Z5ULmLgATXD/qQ73FiMpFK2NUVD4LqGmW/nzNCqofIYH
         S1NNsuBIF2U4rfOQg1rlJ3yYdU7VcQzrkGljsaP92PNaVCHaz3rpm3RodhD60l1ow1lw
         vo/cRZRjOHXrUkL8DYMsUlBkHLo1Botyd9Y2rZVHzN7jCUS3LxramfwZST6KuJoQf+ZA
         BkVQ==
X-Gm-Message-State: AOAM530P9uySD3HKk4d6hsI0A5qupH7cURbV8BgUaWfUTsKNyjvPy/c1
        zNtZgeyUbzOwX3T6bSR/fURj+x5PuJM=
X-Google-Smtp-Source: ABdhPJw1ucXnWuvbAMT5v9Zd316/UpTS3/2KlPVnS9+HxYsyM2NdRnVcGGgNvOKA/WXuPVFvhkGXBQ==
X-Received: by 2002:a5d:460b:0:b0:20a:c12a:734d with SMTP id t11-20020a5d460b000000b0020ac12a734dmr29587924wrq.95.1651226208459;
        Fri, 29 Apr 2022 02:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b0039424a07762sm199003wms.35.2022.04.29.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:56:47 -0700 (PDT)
Message-Id: <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Apr 2022 09:56:43 +0000
Subject: [PATCH v5 0/3] New options to support "simple" centralized workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces two new configuration options, intended to be
consistent with and complementary to the push.default "simple" option. It
also improves remote-defaulting in "default push" scenarios.

In some "simple" centralized workflows, users expect remote tracking branch
names to match local branch names. "git push" pushes to the remote
version/instance of the branch, and "git pull" pulls any changes to the
remote branch (changes made by the same user in another place, or by other
users). The default push.default option, "simple", supports this kind of
workflow by "raising eyebrows" if a user looks like they are trying to push
to the "wrong" remote tracking branch.

None of the existing branch.autosetupmerge settings support this
workflow/expectation well, so the new "branch.autosetupmerge=simple" option
addresses this - acting like the default "remote" option only when the
remote branch and (new) local branch have the same name. The new option is
referred to in new advice in the push.default=simple mismatching remote
branch error text.

At a later stage in the new-branch workflow, when a user first goes to push
a new branch to the remote, the default "git push" will complain that there
is no remote tracking branch (unless push.default=current). For users that
always expect remote branch names to match local branch names, on a single
remote, this is inconvenient. New config setting "push.autoSetupRemote"
addresses this by automatically specifying "--set-upstream" (and allowing
the push) when there is no configured remote for push.default options
"simple", "upstream", and "current". In the case of "current", this helps
make "pull" work correctly (under these workflow assumptions). For the other
two options the primary benefit is being able to simply say "git push" and
not be interrupted with an unnecessary "but this is a new branch!" error.

Along the way, we also enhance the remote-defaulting behavior for "git push"
(and ls-remote) to not only support "origin" as the default remote, but
rather any single configured remote. Default push should only fail for lack
of a remote if there are none, or if there is more than one and none are
called "origin".

Changes since v4:

 * Changed patchset subject to "New options to support "simple" centralized
   workflow", reflecting the fact that there are now two new config options
   available
 * Added some advice to the default push "mismatching remote tracking branch
   name" error, offering the new branch.autosetupmerge=simple option, so
   that new users can potentially discover and benefit from it
 * Introduced a new commit improving the defaulting of remote for "default
   push" (and ls-remote), and fixing and adding related tests
 * Introduced a new commit for new config setting push.autoSetupRemote,
   which will avoid the need for users to explicitly push to a specific
   origin, explicitly requesting tracking, when doing a default push for a
   new branch (with advice and tests).
 * Rebased onto current 'master'

Open questions:

 * The exact text of the two new pieces of advice should get some review, it
   is likely improvable
 * The name and config help of the "push.autoSetupRemote" config setting
   should also be reviewed - there is confusion (at least in my mind)
   between "upstream", "remote tracking", and "remote merge" concepts.

Tao Klerks (3):
  branch: new autosetupmerge option 'simple' for matching branches
  push: default to single remote even when not named origin
  push: new config option "push.autoSetupRemote" supports "simple" push

 Documentation/config/branch.txt |  9 ++--
 Documentation/config/push.txt   | 11 +++++
 Documentation/git-branch.txt    | 18 +++++---
 branch.c                        | 27 +++++++++++-
 branch.h                        |  1 +
 builtin/push.c                  | 64 +++++++++++++++++++++------
 config.c                        |  3 ++
 remote.c                        |  2 +
 t/t3200-branch.sh               | 35 +++++++++++++++
 t/t5512-ls-remote.sh            | 17 ++++++--
 t/t5528-push-default.sh         | 77 ++++++++++++++++++++++++++++++++-
 transport.h                     |  1 +
 12 files changed, 237 insertions(+), 28 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1161%2FTaoK%2Ffeature-branch-autosetupmerge-simple-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1161/TaoK/feature-branch-autosetupmerge-simple-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1161

Range-diff vs v4:

 1:  eca8ab2eb7b ! 1:  5b08edcdeef merge: new autosetupmerge option 'simple' for matching branches
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    merge: new autosetupmerge option 'simple' for matching branches
     +    branch: new autosetupmerge option 'simple' for matching branches
      
          With the default push.default option, "simple", beginners are
          protected from accidentally pushing to the "wrong" branch in
     @@ Commit message
          a "default push", they get an error and explanation with options.
      
          There is a particular centralized workflow where this often happens:
     -    a user branches to a new local feature branch from an existing
     -    upstream branch, eg with "checkout -b feature1 origin/master". With
     +    a user branches to a new local topic branch from an existing
     +    remote branch, eg with "checkout -b feature1 origin/master". With
          the default branch.autosetupmerge configuration (value "true"), git
     -    will automatically add origin/master as the remote tracking branch.
     +    will automatically add origin/master as the upstream tracking branch.
      
     -    When the user pushes with "git push", they get an error, and (amongst
     -    other things) a suggestion to run "git push origin HEAD". Eventually
     -    they figure out to add "-u" to change the tracking branch, or they set
     -    push.default to "current", or some tooling does one or the other of
     -    these things for them.
     +    When the user pushes with a default "git push", with the intention of
     +    pushing their (new) topic branch to the remote, they get an error, and
     +    (amongst other things) a suggestion to run "git push origin HEAD".
      
     -    When one of their coworkers works on the same branch, they don't get
     -    any of that weirdness. They just "git checkout feature1" and
     -    everything works exactly as they expect, with the shared remote branch
     -    set up as remote tracking branch, and push and pull working out of the
     -    box.
     +    If they follow this suggestion the push succeeds, but on subsequent
     +    default pushes they continue to get an error - so eventually they
     +    figure out to add "-u" to change the tracking branch, or they spelunk
     +    the push.default config doc as proposed and set it to "current", or
     +    some GUI tooling does one or the other of these things for them.
     +
     +    When one of their coworkers later works on the same topic branch,
     +    they don't get any of that "weirdness". They just "git checkout
     +    feature1" and everything works exactly as they expect, with the shared
     +    remote branch set up as remote tracking branch, and push and pull
     +    working out of the box.
      
          The "stable state" for this way of working is that local branches have
          the same-name remote tracking branch (origin/feature1 in this
     @@ Commit message
          the remote "master" branch instead (a completely different class of
          changes!)
      
     -    Any experienced git user will presumably say "well yeah, that's what
     -    it means to have the remote tracking branch set to origin/master!" -
     -    but that user didn't *ask* to have the remote master branch added as
     -    remote tracking branch - that just happened automatically when they
     -    branched their feature branch. They didn't necessarily even notice or
     -    understand the meaning of the "set up to track 'origin/master'"
     +    An experienced git user might say "well yeah, that's what it means to
     +    have the remote tracking branch set to origin/master!" - but the
     +    original user above didn't *ask* to have the remote master branch
     +    added as remote tracking branch - that just happened automatically
     +    when they branched their feature branch. They didn't necessarily even
     +    notice or understand the meaning of the "set up to track 'origin/master'"
          message when they created the branch - especially if they are using a
          GUI.
      
          Looking at how to fix this, you might think "OK, so disable auto setup
          of remote tracking - set branch.autosetupmerge to false" - but that
          will inconvenience the *second* user in this story - the one who just
     -    wanted to start working on the feature branch. The first and second
     +    wanted to start working on the topic branch. The first and second
          users swap roles at different points in time of course - they should
          both have a sane configuration that does the right thing in both
          situations.
      
     -    Make these flows painless by introducing a new branch.autosetupmerge
     -    option called "simple", to match the same-name "push.default" option
     -    that makes similar assumptions.
     +    Make this "branches have the same name locally as on the remote"
     +    workflow less painful / more obvious by introducing a new
     +    branch.autosetupmerge option called "simple", to match the same-name
     +    "push.default" option that makes similar assumptions.
      
          This new option automatically sets up tracking in a *subset* of the
          current default situations: when the original ref is a remote tracking
          branch *and* has the same branch name on the remote (as the new local
          branch name).
      
     +    Update the error displayed when the 'push.default=simple' configuration
     +    rejects a mismatching-upstream-name default push, to offer this new
     +    branch.autosetupmerge option that will prevent this class of error.
     +
          With this new configuration, in the example situation above, the first
          user does *not* get origin/master set up as the tracking branch for
          the new local branch. If they "git pull" in their new local-only
     @@ Documentation/git-branch.txt: The exact upstream branch is chosen depending on t
      
       ## branch.c ##
      @@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
     - 			free(tracking->spec.src);
       			string_list_clear(tracking->srcs, 0);
     + 		break;
       		}
      +		/* remote_find_tracking() searches by src if present */
       		tracking->spec.src = NULL;
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      +	 * that supports multiple entries in tracking_srcs but
      +	 * leaves tracking.matches at 0.
      +	 */
     - 	if (tracking.matches > 1)
     - 		die(_("not tracking: ambiguous information for ref %s"),
     - 		    orig_ref);
     + 	if (tracking.matches > 1) {
     + 		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
     + 					    orig_ref);
     +@@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     + 		exit(status);
     + 	}
       
      +	if (track == BRANCH_TRACK_SIMPLE) {
      +		/*
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       	if (tracking.srcs->nr < 1)
       		string_list_append(tracking.srcs, orig_ref);
       	if (install_branch_config_multiple_remotes(config_flags, new_ref,
     +@@ branch.c: static int submodule_create_branch(struct repository *r,
     + 		/* Default for "git checkout". Do not pass --track. */
     + 	case BRANCH_TRACK_REMOTE:
     + 		/* Default for "git branch". Do not pass --track. */
     ++	case BRANCH_TRACK_SIMPLE:
     ++		/* Config-driven only. Do not pass --track. */
     + 		break;
     + 	}
     + 
      
       ## branch.h ##
      @@ branch.h: enum branch_track {
     @@ branch.h: enum branch_track {
       
       extern enum branch_track git_branch_track;
      
     + ## builtin/push.c ##
     +@@
     +  * "git push"
     +  */
     + #include "cache.h"
     ++#include "branch.h"
     + #include "config.h"
     + #include "refs.h"
     + #include "refspec.h"
     +@@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
     + 	 * upstream to a non-branch, we should probably be showing
     + 	 * them the big ugly fully qualified ref.
     + 	 */
     +-	const char *advice_maybe = "";
     ++	const char *advice_pushdefault_maybe = "";
     ++	const char *advice_automergesimple_maybe = "";
     + 	const char *short_upstream = branch->merge[0]->src;
     + 
     + 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
     +@@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
     + 	 * push.default.
     + 	 */
     + 	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
     +-		advice_maybe = _("\n"
     ++		advice_pushdefault_maybe = _("\n"
     + 				 "To choose either option permanently, "
     +-				 "see push.default in 'git help config'.");
     ++				 "see push.default in 'git help config'.\n");
     ++	if (git_branch_track != BRANCH_TRACK_SIMPLE)
     ++		advice_automergesimple_maybe = _("\n"
     ++				 "To avoid automatically configuring "
     ++				 "upstream branches when their name\n"
     ++				 "doesn't match the local branch, see option "
     ++				 "'simple' of branch.autosetupmerge\n"
     ++				 "in 'git help config'.\n");
     + 	die(_("The upstream branch of your current branch does not match\n"
     + 	      "the name of your current branch.  To push to the upstream branch\n"
     + 	      "on the remote, use\n"
     +@@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
     + 	      "To push to the branch of the same name on the remote, use\n"
     + 	      "\n"
     + 	      "    git push %s HEAD\n"
     +-	      "%s"),
     ++	      "%s%s"),
     + 	    remote->name, short_upstream,
     +-	    remote->name, advice_maybe);
     ++	    remote->name, advice_pushdefault_maybe,
     ++	    advice_automergesimple_maybe);
     + }
     + 
     + static const char message_detached_head_die[] =
     +
       ## config.c ##
      @@ config.c: static int git_default_branch_config(const char *var, const char *value)
       		} else if (value && !strcmp(value, "inherit")) {
 -:  ----------- > 2:  31184c3a65d push: default to single remote even when not named origin
 -:  ----------- > 3:  41c88e51ac6 push: new config option "push.autoSetupRemote" supports "simple" push

-- 
gitgitgadget
