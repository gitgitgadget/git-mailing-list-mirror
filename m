Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582771F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeIEByF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:05 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38013 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:04 -0400
Received: by mail-pg1-f180.google.com with SMTP id t84-v6so441709pgb.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HaFD5q7nowUR8gtvjlV1w7QGWvro5dHvGN2iJ/6NCUU=;
        b=jKA9MCz7yxiqU2t7eF8eEh4QQmrRh/SsMnqcjGE9Yp5O5NtflmgiA0CVcZwQdql3k5
         l8EtBtKbGEZZlWsFN/Mhj+clvX1NNck2BZMMaw0JOETdDF7g64PFPdnyhOHmA71UxsqP
         70e6hH7Yz7FTVkzQmk4ftAIJy9Obzz7TJ6rnx63I9RLZbSy2aC0aPqJeCShs5Oh+AIYX
         jNi+Ni5NDN/BQJ2dmHv8OnHYUpfVU8f1nK+idvT+FWib/lly2TEuNVQWaXuFjWxg7bWI
         bUk/7TuqizeHi7mGB9ISohxSSBYvWaJr1L++iszQgiL2Y1MeL2sl11R3ADKx9qM2ZvFs
         Jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HaFD5q7nowUR8gtvjlV1w7QGWvro5dHvGN2iJ/6NCUU=;
        b=egjnookG+jBiL5sPiMIpyCzltg+dALkNe5dpLEjkaDra1JX3Pukp6QCQTJnj/LRf1k
         mMLlyCXi2dfzRh/iyIDLtJEWrGGXq551Oe1n/PDVXSUK0+CgciwvweMUGV017efEpkZH
         vaY+r4YrIl8J1pRtdKtCT/lUfLlogxH3Wl9rGdtJB2fU5Gx9zdApl92GrCAsX8kIo9Hj
         dgsglA6Xs1lbSqB+HXxRpGzB7VrUrgwJTHRZ3nx9lcTaEHMzJ+6a7U9LOj7dyS6wT2kw
         QQzjJmUcTsHu3SRe+7/sACUnm7hcK2qNxq/T0Owsjnp4KXfNPdyCfNGYifxjVjPEcf2C
         Zalg==
X-Gm-Message-State: APzg51BOxDdlgQQzkq+fOStuEYNqrACnhz2+ge+03QAkra4/G4qFct/S
        88imX7y0EJkRQBhbIHE34H8HhBOz
X-Google-Smtp-Source: ANB0VdaeOvcIv2NAO8msToowp3bEouy/0nxSCQaKbPu7Ch1Rt/M33FtIQyrXb1kEUY7oYcDq3i05Kw==
X-Received: by 2002:a63:77ce:: with SMTP id s197-v6mr33618830pgc.172.1536096427152;
        Tue, 04 Sep 2018 14:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s14-v6sm44604745pfj.105.2018.09.04.14.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:06 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:06 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:53 GMT
Message-Id: <pull.32.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/11] A minimal builtin rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series provides the bare minimum to run more than just the
trivial rebase (i.e. git rebase <upstream>): it implements the most common
options such as --onto.

It is based the latest iteration of pk/rebase-in-c.

This is the second patch series that brings us more closer to a builtin "git
rebase".

Changes since v1:

 * Many commit messages were reworded.
 * An indentation fix was folded into the commit that introduces the
   incorrect indentation.
 * A missing space after a comma was inserted.

Pratik Karki (11):
  builtin rebase: support --onto
  builtin rebase: support `git rebase --onto A...B`
  builtin rebase: handle the pre-rebase hook and --no-verify
  builtin rebase: support --quiet
  builtin rebase: support the `verbose` and `diffstat` options
  builtin rebase: require a clean worktree
  builtin rebase: try to fast forward when possible
  builtin rebase: support --force-rebase
  builtin rebase: start a new rebase only if none is in progress
  builtin rebase: only store fully-qualified refs in `options.head_name`
  builtin rebase: support `git rebase <upstream> <switch-to>`

 builtin/rebase.c | 333 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 320 insertions(+), 13 deletions(-)


base-commit: ac7f467fef8b836084afdce5eded047c79a6858d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-32%2Fdscho%2Frebase-in-c-2-basic-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-32/dscho/rebase-in-c-2-basic-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/32

Range-diff vs v1:

  1:  c5f67c35ea !  1:  fba1b3e2a9 builtin rebase: support --onto
     @@ -15,6 +15,7 @@
          command name, but to the first (non-option) command-line parameter.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  2:  35d141c32a !  2:  f9826ab58f builtin rebase: support `git rebase --onto A...B`
     @@ -7,12 +7,18 @@
      
          The equivalent shell script version of the code offers two different
          error messages for the cases where there is no merge base vs more than
     -    one merge base. Though following the similar approach would be nice,
     -    this would create more complexity than it is of current. Currently, for
     -    simple convenience, the `get_oid_mb()` function is used whose return
     -    value does not discern between those two error conditions.
     +    one merge base.
     +
     +    Though it would be nice to retain this distinction, dropping it makes it
     +    possible to simply use the `get_oid_mb()` function. Besides, it happens
     +    rarely in real-world scenarios.
     +
     +    Therefore, in the interest of keeping the code less complex, let's just
     +    use that function, and live with an error message that does not
     +    distinguish between those two error conditions.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  3:  e223f2209d !  3:  7100820def builtin rebase: handle the pre-rebase hook (and add --no-verify)
     @@ -1,12 +1,13 @@
      Author: Pratik Karki <predatoramigo@gmail.com>
      
     -    builtin rebase: handle the pre-rebase hook (and add --no-verify)
     +    builtin rebase: handle the pre-rebase hook and --no-verify
      
          This commit converts the equivalent part of the shell script
          `git-legacy-rebase.sh` to run the pre-rebase hook (unless disabled), and
          to interrupt the rebase with error if the hook fails.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  4:  19919e7e24 !  4:  5034f53024 builtin rebase: support --quiet
     @@ -7,19 +7,23 @@
          the rebase command: both `--quiet` and `--verbose` default to `false` if
          neither `--quiet` nor `--verbose` is present.
      
     -    This commit goes further and introduces `--no-quiet` which is the
     -    contrary of `--quiet` and it's introduction doesn't modify any
     -    behaviour.
     +    Despite the default being `false` for both verbose and quiet mode,
     +    passing the `--quiet` option will turn off verbose mode, and `--verbose`
     +    will turn off quiet mode.
      
     -    Note: The `flags` field in `rebase_options` will accumulate more bits in
     -    subsequent commits, in particular a verbose and a diffstat flag. And as
     -    --quoet inthe shell scripted version of the rebase command switches off
     -    --verbose and --stat, and as --verbose switches off --quiet, we use the
     -    (negated) REBASE_NO_QUIET instead of REBASE_QUIET: this allows us to
     -    turn off the quiet mode and turn on the verbose and diffstat mode in a
     -    single OPT_BIT(), and the opposite in a single OPT_NEGBIT().
     +    This patch introduces the `flags` bit field, with `REBASE_NO_QUIET`
     +    as first user (with many more to come).
     +
     +    We do *not* use `REBASE_QUIET` here for an important reason: To keep the
     +    implementation simple, this commit introduces `--no-quiet` instead of
     +    `--quiet`, so that a single `OPT_NEGBIT()` can turn on quiet mode and
     +    turn off verbose and diffstat mode at the same time. Likewise, the
     +    companion commit which will introduce support for `--verbose` will have
     +    a single `OPT_BIT()` that turns off quiet mode and turns on verbose and
     +    diffstat mode at the same time.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  5:  cbf318d0de !  5:  ce1e1f266a builtin rebase: support the `verbose` and `diffstat` options
     @@ -11,6 +11,7 @@
          calling) git_default_config().
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  6:  b440bf9884 !  6:  f11f21d5c6 builtin rebase: require a clean worktree
     @@ -6,6 +6,7 @@
          whether the repository is ready for rebase.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
  7:  0efe9b41f0 !  7:  2ec0b744bf builtin rebase: try to fast forward when possible
     @@ -11,6 +11,7 @@
          rebase).
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -105,7 +106,7 @@
      +		if (!(options.flags & REBASE_NO_QUIET))
      +			; /* be quiet */
      +		else if (!strcmp(branch_name, "HEAD") &&
     -+			resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     ++			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
      +			puts(_("HEAD is up to date, rebase forced."));
      +		else
      +			printf(_("Current branch %s is up to date, rebase "
  8:  ae019dec3f !  8:  78d90e67de builtin rebase: support --force-rebase
     @@ -10,6 +10,7 @@
          fast-forward even if it could.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -63,8 +64,4 @@
      +		} else if (!(options.flags & REBASE_NO_QUIET))
       			; /* be quiet */
       		else if (!strcmp(branch_name, "HEAD") &&
     --			resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     -+			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
     - 			puts(_("HEAD is up to date, rebase forced."));
     - 		else
     - 			printf(_("Current branch %s is up to date, rebase "
     + 			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
  9:  d58d504c03 !  9:  b639bfa5a8 builtin rebase: start a new rebase only if none is in progress
     @@ -7,6 +7,7 @@
          ongoing rebase operation completes or is terminated.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
     @@ -84,7 +85,7 @@
      +		      "and run me again.  I am stopping in case you still "
      +		      "have something\n"
      +		      "valuable there.\n"),
     -+		    state_dir_base, cmd_live_rebase,buf.buf);
     ++		    state_dir_base, cmd_live_rebase, buf.buf);
      +	}
      +
       	if (!(options.flags & REBASE_NO_QUIET))
 10:  ef468bf3d7 ! 10:  aab01f0b8e builtin rebase: only store fully-qualified refs in `options.head_name`
     @@ -12,6 +12,7 @@
          "detached HEAD" for display only. Make it so.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
 11:  9a26fc3fac ! 11:  e64190d8ed builtin rebase: support `git rebase <upstream> <switch-to>`
     @@ -7,6 +7,7 @@
          `git-legacy-rebase.sh` is converted to builtin `rebase.c`.
      
          Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c

-- 
gitgitgadget
