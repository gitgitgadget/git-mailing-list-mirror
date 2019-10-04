Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533CD1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfJDMbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 08:31:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35722 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfJDMbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 08:31:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so5676229wmi.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ez0/4EvGXG4Gxp60at6ygt4SGTvHsaCDXInIS9fuTg=;
        b=eKYeRTIy6uMNN1UVn7EembruwycNHEnQmRcGhL45xEepEpbP5VN+nxieLuANJetEEi
         pSE0axTlFPuUxxT7RNS3ws7kSL2HLEs7eKLlOpNOY4JEe/ql36RDAwL+eqy0iJQ4te3b
         kaxHkJmRpz/ZSHL4ZtA/trHEj4THRBWYydbFXWo2UHEaZRxs35ItomuD9mE7IJUA/sBv
         tnoNjhJySHUL4h5FS3YuwXET0EYlg+ddtoFiUuhRg2vOU94skCrsZyfSc1kfQ07pCJo6
         ug7T9aILvYoyrivADN9NfNZd81J9ic6YdBl5adkP8qXwgFFNXq9yQ3JIt5GHKe8XQD0X
         EbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ez0/4EvGXG4Gxp60at6ygt4SGTvHsaCDXInIS9fuTg=;
        b=rrF71oXc893UePP+Ij9JV1q1k1F8D+IrNQgl8QOO7R+/X2m6CZZlzSUmpfey6clC01
         O1O6mEw/VDO3mnua2n1qz/JgXnKfADDqtXaapCZXq77W8dFBBvDrPi2ezFSehRADwR7y
         J/VTnQ8XgeUbKLVU6iaNcStlJO/YLKoSL/iblDR2ekIhW9Y+5GCdw65YcZzDkADSP1zO
         KNHF9EcLjtP57awuWbkNlBiHMGOx6kisgJeRtnQ/F5gU0juMpvzBhBFTVbHbfHpNI7Hd
         KQXb7faiYLhhVD3Oqg3HokCSFPbug03c3fwlNko/zBdwlCiMKvK/6sGXNLpN8HDoD0f8
         SgNA==
X-Gm-Message-State: APjAAAVFB79m+gzR6GDbUeqPAQ20oJL83DT6URqhlMUm1jpMZ33sDMHs
        Xy0LodbVISsjf8HE16ZtgU2i4gvW
X-Google-Smtp-Source: APXvYqxVqt1Q3gmp+rVup3cUf47/4oRcUNLjkeCMgWkEplO8gMybQ46UhrgCCv4h3xSddsyiSNxzDQ==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr11223547wml.14.1570192258928;
        Fri, 04 Oct 2019 05:30:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm17284986wmg.2.2019.10.04.05.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:30:58 -0700 (PDT)
Date:   Fri, 04 Oct 2019 05:30:58 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 12:30:56 GMT
Message-Id: <pull.354.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.354.git.gitgitgadget@gmail.com>
References: <pull.354.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] stash apply: be prepared to run in a worktree's subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saw this issue a couple times in my setup, and always wondered why nobody
else seemed to be hit by this. When I finally found/made some time to
investigate, I found out that it really requires a specific setup: I have
many worktrees connected to my main git.git clone, often run inside t/ and I
do stash quite often (now that git stash's performance is a joy on Windows).

Changes since v1:

 * We now make sure to also set GIT_DIR.

Johannes Schindelin (1):
  stash apply: report status correctly even in a worktree's subdirectory

 builtin/stash.c              |  4 ++++
 t/t3908-stash-in-worktree.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 t/t3908-stash-in-worktree.sh


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-354%2Fdscho%2Fapply-stash-in-subdirectory-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-354/dscho/apply-stash-in-subdirectory-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/354

Range-diff vs v1:

 1:  a687c16b82 ! 1:  4e19436fbf stash apply: report status correctly even in a worktree's subdirectory
     @@ -3,15 +3,20 @@
          stash apply: report status correctly even in a worktree's subdirectory
      
          When Git wants to spawn a child Git process inside a worktree's
     -    subdirectory, we need to take care of specifying the work tree's
     -    top-level directory explicitly because it cannot be discovered: the
     -    current directory is _not_ the top-level directory of the work tree, and
     -    neither is it inside the parent directory of `GIT_DIR`.
     +    subdirectory while `GIT_DIR` is set, we need to take care of specifying
     +    the work tree's top-level directory explicitly because it cannot be
     +    discovered: the current directory is _not_ the top-level directory of
     +    the work tree, and neither is it inside the parent directory of
     +    `GIT_DIR`.
      
          This fixes the problem where `git stash apply` would report pretty much
          everything deleted or untracked when run inside a worktree's
          subdirectory.
      
     +    To make sure that we do not introduce the "reverse problem", i.e. when
     +    `GIT_WORK_TREE` is defined but `GIT_DIR` is not, we simply make sure
     +    that both are set.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/builtin/stash.c b/builtin/stash.c
     @@ -23,6 +28,8 @@
       		cp.dir = prefix;
      +		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
      +				 absolute_path(get_git_work_tree()));
     ++		argv_array_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
     ++				 absolute_path(get_git_dir()));
       		argv_array_push(&cp.args, "status");
       		run_command(&cp);
       	}

-- 
gitgitgadget
