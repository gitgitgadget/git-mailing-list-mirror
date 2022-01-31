Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8C7C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiAaWHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiAaWHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:07:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1996C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u15so28190409wrt.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=q47I71Ub6tRXsXGOAZSa/24+wW+BEa+tuXa74S9b280=;
        b=Pwh+lZmjn+1mO575LqH6fvTO2YEyk8kRZSpE6r0ePQyQJovTm9kBInxriUDrmZW/1D
         GTnGUuRkV0tzSvytlyECv8n5r12pwFYp6zn4nm3mXGgABU1WY7rwBNuGUvY7WKUTy7za
         EY105TEu2mJEx5SANA7axOuCj2FhDmswVYQ+oVphYpvAR4/6B0UnGt+W0bwJDW89uVVc
         eJHUCujOvdGGjVr4idiDsj7VQ6VNzUPySw4UaR1eC1s6FBid5oXfWcY4uV9+67f8C9Jh
         FwPobMFRw3A+RfmNioeLqXWgrA3gexth5B+ZGmZ1UFjw9NEJZmcdGXPa4gB9drDxwyiE
         TGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=q47I71Ub6tRXsXGOAZSa/24+wW+BEa+tuXa74S9b280=;
        b=urwPTztm6dSn6FzoKUN+Bv079Pzt1vj6h/mBE8/eRQVC67yTz4/ubkkOYL6l5tcQMf
         cHldXUxVy/h3jbFfde0C6GkcN3RhFDbPOrWa5UsYHQdPjNw5kurJ8WMyY/NdXkX96bOt
         8IPMUECh8y83DYbguQOolrnYm+D/EN/U3jmuL4TVVsNmA/oduIIhoMQhqHBY95gnFMcg
         nfAl/mlmDa3Lrdins++RLiZ4OFXfKxEM9Qd1O9mOvPqVa/YgwNcbBYzMTk5CaqlBJL9W
         Da1si2E29+1vokiSTtWoa4XGsJJy2cLGFQmAcFCcQ16on05t4PkhrlScwx0ZbPAsMtbr
         ZErQ==
X-Gm-Message-State: AOAM530WRQu9/ZGjCGtya6vrq7VT2Amic5iQ7hpRaSVObBnQAm4YcPV9
        xmx9eGWm4E3wcDTwMU0E+KgmrRSo0Is=
X-Google-Smtp-Source: ABdhPJzNZ5qPn7wnI8oA0ErJ4BvL7n3y7sNu9RGOuTGEOg+i9vLbZtfc1rpVUDH8OomDgKFYsN3RFA==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr18539696wrw.157.1643666871277;
        Mon, 31 Jan 2022 14:07:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm13763941wrs.51.2022.01.31.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:07:50 -0800 (PST)
Message-Id: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 22:07:45 +0000
Subject: [PATCH v4 0/4] Factorize i18n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small series of i18n factorizations. Again the idea is to:

 * reduce the number of strings to translate
 * make life easier for translators by removing constant parts of the
   strings to translate
 * uniformize the UI by using a type of message for the a given type of
   condition.

Changes since V1:

 * factorize checks of more than 2 incompatible options into dedicated
   functions which list all the incompatible options present on the command
   line

Changes since V2:

 * switch to tab size 8
 * rename die_if* to die_for*
 * make 3 arg check a call to 4 arg check
 * switch another part to die_for_incompatible_opt4

Changes since V3:

 * remove spurious blank line
 * reword last commit to better reflect the changes

Jean-Noël Avila (4):
  i18n: factorize more 'incompatible options' messages
  i18n: factorize "invalid value" messages
  i18n: remove from i18n strings that do not hold translatable parts
  i18n: fix some misformated placeholders in command synopsis

 archive.c                                 |  2 +-
 builtin/am.c                              |  8 ++++--
 builtin/bisect--helper.c                  |  6 ++--
 builtin/blame.c                           |  7 +++--
 builtin/commit.c                          | 35 ++++++++++-------------
 builtin/count-objects.c                   |  2 +-
 builtin/difftool.c                        |  5 ++--
 builtin/fast-export.c                     |  2 +-
 builtin/fetch.c                           |  4 +--
 builtin/grep.c                            |  8 ++----
 builtin/hash-object.c                     |  2 +-
 builtin/help.c                            |  4 +--
 builtin/log.c                             |  5 ++--
 builtin/merge-base.c                      |  6 ++--
 builtin/mktag.c                           |  2 +-
 builtin/mktree.c                          |  2 +-
 builtin/notes.c                           |  6 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/prune-packed.c                    |  2 +-
 builtin/pull.c                            |  6 ++--
 builtin/push.c                            |  2 +-
 builtin/rebase.c                          |  2 +-
 builtin/reflog.c                          |  6 ++--
 builtin/remote.c                          |  2 +-
 builtin/replace.c                         |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/send-pack.c                       |  2 +-
 builtin/sparse-checkout.c                 |  8 +++---
 builtin/stripspace.c                      |  4 +--
 builtin/submodule--helper.c               |  2 +-
 builtin/update-server-info.c              |  2 +-
 diff-merges.c                             |  2 +-
 gpg-interface.c                           |  6 ++--
 ls-refs.c                                 |  3 +-
 parallel-checkout.c                       |  4 +--
 parse-options.c                           | 34 ++++++++++++++++++++++
 parse-options.h                           | 16 +++++++++++
 sequencer.c                               |  2 +-
 setup.c                                   |  3 +-
 submodule-config.c                        |  2 +-
 t/t4150-am.sh                             |  2 +-
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 42 files changed, 139 insertions(+), 87 deletions(-)


base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1123%2Fjnavila%2Ffactorize_i18n-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1123/jnavila/factorize_i18n-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1123

Range-diff vs v3:

 1:  aac3f9821c7 ! 1:  2eac2ef502b i18n: factorize more 'incompatible options' messages
     @@ parse-options.h: NORETURN void usage_msg_opt(const char *msg,
       /*
        * Use these assertions for callbacks that expect to be called with NONEG and
        * NOARG respectively, and do not otherwise handle the "unset" and "arg"
     -@@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *, int);
     - #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
     - #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
     - 
     -+
     - #endif
      
       ## t/t7500-commit-template-squash-signoff.sh ##
      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword: give error with pathsec' '
 2:  078336ae418 = 2:  2d359118d8f i18n: factorize "invalid value" messages
 3:  d5ddd903df7 = 3:  cdaa576aac1 i18n: remove from i18n strings that do not hold translatable parts
 4:  b8e80e178ee ! 4:  f37b03128b2 i18n: transfer variables into placeholders in command synopsis
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    i18n: transfer variables into placeholders in command synopsis
     +    i18n: fix some misformated placeholders in command synopsis
     +
     +     * add '<>' around arguments where missing
     +     * convert plurals into '...' forms
      
          This applies the style guide for documentation.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     +    Reviewed-by: Phillip Wood <phillip.wood123@gmail.com>
      
       ## builtin/fast-export.c ##
      @@

-- 
gitgitgadget
