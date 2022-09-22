Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B5C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIVNiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiIVNiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 09:38:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CFF160C
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1362692wmq.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=lV2Q/wDcncPHPzZL/ZEBcJSfLIpxHju+5gt4OmyMHLo=;
        b=FDgNE/eoyzZDcP33J2g/3A8J0Qff+HBjSKVQNBkaecTHgMJh4qakv2R7wrCx+fGw4u
         oHA03dZggMjKr2XMKLnCmm7DLuV/QI9hn75+I6uvcpeE8RGLQGOuGQ0pFn/DQHd/OuHb
         7de65lN2mNDS331t1d5Gz55hfDXCo6cDeNqPAe/H8fgTft1hF+vKr7eJnZpinWVoqn6j
         H8tVtVCw1V3DnrnvX1A34pnjKOkBDUcl8uIUfeamYSpB+JnzcukLveNvusGYWOAv0Gv/
         D6ZNN00S43PssnMjjdxJHH+oX0qOjpFgdiUiwbnljn0CictE6uUxv++BrlgxRGhlz+RJ
         UvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lV2Q/wDcncPHPzZL/ZEBcJSfLIpxHju+5gt4OmyMHLo=;
        b=yQo9CqjmmJUI5prYLhC2WbfF3IUTx1f0G8m+fDs/3w7X/BO4R/H2HCkNoTQJJXUcMB
         frFwbjFnapiziyryY1O+J87l/B1MO6RQ9eFG8xT88ElzLW+Rz7ZQmNA07xaw/LfJ/wrc
         ygR+FYrj50ikGxvMIFvkyiU+Njff+MtFS4NvJoI2xID3BCrv5iF6w2l32PkH2Bg4MfnL
         UG84gGD6OP2zhBPn3uhx3HNAl3FZbnpze93jSogGCKy/XkclhJPpZAu4z+nAPPwJMIsN
         lEwdMYpFlvfb9k9rTsox7VJ/BXrMiKT5D5Knf+9wPJ/jMGrPkJhbCgxM8ONjSRipFrlC
         YdQQ==
X-Gm-Message-State: ACrzQf1n/OcyAUgTCzlm0L5Qe2oU/kOQY72pieOfTc0FA+J1cc8LCdRP
        V9FCCsf3TyjxoPjzHEkFg3+2BSob/Z8=
X-Google-Smtp-Source: AMsMyM4K/QQ80UaSHQU1ZVUWwCWE5vep6vAu2cMgGpTW5+0HYs7Nd8bMTh81dPbpBWcBr/62MN2dpQ==
X-Received: by 2002:a05:600c:2202:b0:3b4:6189:fc6a with SMTP id z2-20020a05600c220200b003b46189fc6amr2495289wml.171.1663853838710;
        Thu, 22 Sep 2022 06:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az7-20020a05600c600700b003a531c7aa66sm6528472wmb.1.2022.09.22.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:37:18 -0700 (PDT)
Message-Id: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 13:37:15 +0000
Subject: [PATCH v2 0/2] scalar: make unregister idempotent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed this while we were updating the microsoft/git fork to include
v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
before, but instead some change in 'scalar unregister' led to it relying on
the return code of 'git maintenance unregister'. Our functional tests expect
'scalar unregister' to be idempotent, and I think that's a good pattern for
'git maintenance unregister', so I'm fixing it at that layer.

Despite finding this during the 2.38.0-rc0 integration, this isn't critical
to the release.

Perhaps an argument could be made that "failure means it wasn't registered
before", but I think that isn't terribly helpful.

Our functional tests are running the unregister subcommand to disable
maintenance in order to run tests on the object store (such as running
maintenance commands in the foreground and checking the object store
afterwards). This is a form of automation using 'unregister' as a check that
maintenance will not run at the same time, and it doesn't care if
maintenance was already disabled. I can imagine other scripting scenarios
wanting that kind of guarantee.


Updates in v2
=============

 * This is now a two-patch series.
 * I rebased onto v2.38.0-rc1 for two reasons: Scalar is now merged, and the
   usage for 'git maintenance unregister' removed its translation markers.
 * Instead of making git maintenance unregister idempotent, add a --force
   option for those who do not want to require that the repository is
   already registered.
 * Make scalar unregister idempotent, with reasons argued in patch 2.

Thanks, -Stolee

Derrick Stolee (2):
  maintenance: add 'unregister --force'
  scalar: make 'unregister' idempotent

 Documentation/git-maintenance.txt |  6 +++++-
 builtin/gc.c                      | 31 +++++++++++++++++++++++++------
 scalar.c                          |  5 ++++-
 t/t7900-maintenance.sh            |  6 +++++-
 t/t9210-scalar.sh                 |  5 ++++-
 5 files changed, 43 insertions(+), 10 deletions(-)


base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1358%2Fderrickstolee%2Fmaintenance-unregister-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1358/derrickstolee/maintenance-unregister-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1358

Range-diff vs v1:

 1:  f028208a3ab ! 1:  69c74f52eef maintenance: make unregister idempotent
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    maintenance: make unregister idempotent
     +    maintenance: add 'unregister --force'
      
          The 'git maintenance unregister' subcommand has a step that removes the
          current repository from the multi-valued maitenance.repo config key.
     @@ Commit message
          running 'git maintenance unregister' twice result in a failure in the
          second instance.
      
     -    Make this task idempotent, since the end result is the same in both
     -    cases: maintenance will no longer run on this repository.
     +    This failure exit code is helpful, but its message is not. Add a new
     +    die() message that explicitly calls out the failure due to the
     +    repository not being registered.
     +
     +    In some cases, users may want to run 'git maintenance unregister' just
     +    to make sure that background jobs will not start on this repository, but
     +    they do not want to check to see if it is registered first. Add a new
     +    '--force' option that will siltently succeed if the repository is not
     +    already registered.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## Documentation/git-maintenance.txt ##
     +@@ Documentation/git-maintenance.txt: SYNOPSIS
     + [verse]
     + 'git maintenance' run [<options>]
     + 'git maintenance' start [--scheduler=<scheduler>]
     +-'git maintenance' (stop|register|unregister)
     ++'git maintenance' (stop|register|unregister) [<options>]
     + 
     + 
     + DESCRIPTION
     +@@ Documentation/git-maintenance.txt: unregister::
     + 	Remove the current repository from background maintenance. This
     + 	only removes the repository from the configured list. It does not
     + 	stop the background maintenance processes from running.
     +++
     ++The `unregister` subcommand will report an error if the current repository
     ++is not already registered. Use the `--force` option to return success even
     ++when the current repository is not registered.
     + 
     + TASKS
     + -----
     +
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
     +@@ builtin/gc.c: done:
     + }
     + 
     + static char const * const builtin_maintenance_unregister_usage[] = {
     +-	"git maintenance unregister",
     ++	"git maintenance unregister [--force]",
     + 	NULL
     + };
     + 
     + static int maintenance_unregister(int argc, const char **argv, const char *prefix)
     + {
     ++	int force = 0;
       	struct option options[] = {
     ++		OPT_BOOL(0, "force", &force,
     ++			 N_("return success even if repository was not registered")),
       		OPT_END(),
       	};
      -	int rc;
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, con
      +			     "--fixed-value", key, maintpath, NULL);
      +
      +		rc = run_command(&config_unset);
     ++	} else if (!force) {
     ++		die(_("repository '%s' is not registered"), maintpath);
      +	}
       
      -	rc = run_command(&config_unset);
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
      -	test_cmp before actual
      +	test_cmp before actual &&
      +
     -+	# Expect unregister to be idempotent.
     -+	git maintenance unregister
     ++	test_must_fail git maintenance unregister 2>err &&
     ++	grep "is not registered" err &&
     ++	git maintenance unregister --force
       '
       
       test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 -:  ----------- > 2:  f5d8d6e4901 scalar: make 'unregister' idempotent

-- 
gitgitgadget
