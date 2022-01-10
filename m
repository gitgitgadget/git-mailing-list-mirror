Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A873DC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiAJS76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbiAJS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:59:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C4C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x4so3430180wru.7
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UdFr2HaLKoReaJ1pGUlcHaab3Uedo3tizAHFvvRXX0w=;
        b=PSSXMO/wo8oT+zBCdg9lAsqnbjO0Psp2xGwlv18sSNNqaAiZ3dZMyuyT178m53ILOO
         yPo3tGfo38pF6K7w8VV2k5GF81UgPgKEjk/7S/Yynw9TMTiyJQR3hpf13L5JArBx4EY+
         N1NdLKbIwuSOLfDvphHQDlib8Vjmtt+nTb9XmY1py0/7V3IWvVw0JdC3R8D3LFJgjy2/
         hG7uyiU2ftYsrjwPRWUaPzp/I6KKShh2iVKSIbhT2juyTB+xDcuZnVPAPjCWGr8XX+5M
         TDIn/N5fckH0FiGutaLvYDURGf7EEuuDEhu77jM731ir8pyRRr3oXwR+k7H8oAQqnPbJ
         Nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UdFr2HaLKoReaJ1pGUlcHaab3Uedo3tizAHFvvRXX0w=;
        b=k77gIDtvPuUgCrWMzU0yHuQMnIqksHqCjSHH7eoMaV/biwqnzc4bsRSbjZ0xeab431
         dwS8Tqi4MLkLg0FtDJQGgcz0ecLQYqVbH/2cZNC9Bd7zd5ZKX8X3fJQsjj9N0jiQE5Mi
         y5QAGeLeYnXy8mr8WKzzzSdtJOfqMxTGnKHTIVTuWineH9y5GEUUWmH3Nh58B/acTWiZ
         ek1Ssli8J0/FOnsOGMhiVtYuf5oXr5cHkrsOppfIzuE9wiXqsInLp9+VDFP21+8dYnQa
         PIgx0GHwAyvKzBOZZ4/6W+98YGbEpzcip/UcLAq+mgYLX/SiHvjMDUKIIPNkGtTJoAGm
         Vryg==
X-Gm-Message-State: AOAM5329CFQYiffXCe/Ek7C/b58ADXzto9WvNu4UJ1pZfG10lGm36xq5
        oaKYo2Lh+7t2taFkoDGghX6N7vzPEPY=
X-Google-Smtp-Source: ABdhPJwwcNyEQT4FuTQkYqgEo4yr5vAbEQQ4rrxf6oFui/89eSnmFgwc1ybSRot8uubHIG2phYvIHA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr769651wrs.633.1641841194883;
        Mon, 10 Jan 2022 10:59:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az1sm7518695wrb.104.2022.01.10.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:59:54 -0800 (PST)
Message-Id: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Jan 2022 18:59:49 +0000
Subject: [PATCH v3 0/3] sparse checkout: custom bash completion updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on en/sparse-checkout-set. It updates custom tab
completion for the sparse-checkout command. Specifically, it corrects the
following issues with the current method:

 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
    (it is missing reapply and add).
 2. git sparse-checkout --<TAB> does not complete the help option.
 3. Options for subcommands are not tab-completable.
 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
    both file names and directory names.

The first commit in this series is a set of failing tests that highlight
each of the above issues. The next commit updates the _git_sparse_checkout
method in git-completion.bash to enable each of these tests to pass. The
final commit modifies the original implementation (which recursively printed
prospective directories for completion) to only print directories at the
current level for improved performance.


Changes since V2
================

 * Change use of $prev to $subcommand in _git_sparse_checkout() method in
   git-completion.bash.
 * State explicitly that directory completion applies in both cone and
   non-cone mode in 'sparse-checkout: custom tab completion' commit
 * Add new patch with __gitcomp_directories method to improve performance by
   only outputting directories at the current level.


Changes since V1
================

 * Rebase onto en/sparse-checkout-set.
 * Add subcommand options (including --no-cone) for set and reapply.
 * Extend 'sparse-checkout completes subcommand options' test to validate
   new set/reapply subcommand options.
 * No longer set index.sparse to false in 'sparse-checkout completes
   directory names' test.

Thanks, Lessley

Lessley Dennington (3):
  sparse-checkout: custom tab completion tests
  sparse-checkout: custom tab completion
  sparse-checkout: limit tab completion to a single level

 contrib/completion/git-completion.bash | 68 +++++++++++++++----
 t/t9902-completion.sh                  | 94 ++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 12 deletions(-)


base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v2:

 1:  955fcab0052 = 1:  bbc2d21e1d1 sparse-checkout: custom tab completion tests
 2:  cecf501e076 ! 2:  256e5f034c6 sparse-checkout: custom tab completion
     @@ Commit message
          2. The --help option is tab-completable.
          3. Subcommand options are tab-completable.
          4. A list of directories (but not files) is provided when users enter git
     -    sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
     +    sparse-checkout add <TAB> or git sparse-checkout set <TAB>. It is
     +    important to note that this will apply for both cone mode and non-cone
     +    mode (even though non-cone mode matches on patterns rather than
     +    directories).
      
          Failing tests that were added in the previous commit to verify these
          scenarios are now passing with these updates.
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
      -		;;
      -	*)
      -		;;
     -+	case "$prev" in
     ++	case "$subcommand" in
      +		set)
      +			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
      +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
 -:  ----------- > 3:  aa9ea67180d sparse-checkout: limit tab completion to a single level

-- 
gitgitgadget
