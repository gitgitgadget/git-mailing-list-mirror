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
	by dcvr.yhbt.net (Postfix) with ESMTP id E04DC1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395541AbfJQWIA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:08:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfJQWIA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 18:08:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so4046602wro.4
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=38cSmOB7ljePAj3fZ6wGAgymB/uOzsYIYzXZw+k3D28=;
        b=M3goQwb0VENzy+NlOXLEqOo0T3astQrZBbzMM9c7R57gHmMSFCCxyhdjOWn2Y56H1+
         +IT0JpagsSR7+887C5z0xjpPR4VG56PG8lGSo/ZG5hEd003crUz++yD2cs7nF5h0oy82
         nRVcuobu82TLy4dAZPkqk5DgJ0d5Mon52w57urI8BCbmfMbW9LFJlZgG7awMkg4v5rvt
         eK3oBRgmdT7B0ZZENWAE0OfiiCKMV9nl766exmBT8ooXXRHK8jTP/hN6oa9EqAldpoeS
         fY02Zshf0/xI6y6SoE799A/Ea/ELvtUJVMJlx/11pQWfIxOgyu2fpFmVB0ECx2a8dsr8
         bAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=38cSmOB7ljePAj3fZ6wGAgymB/uOzsYIYzXZw+k3D28=;
        b=t5nHp4Wn54LruL8bcp1iN57jKaIN/1wj7Tkfy22fTge4WKEfppEnmPLa0jOba8o3p5
         Wz6Cg+jqGGEEUi1Vs32Auvm2+Nl98/knn8JEL/Du5cl8LHq9v3+mLJNUH1vJf1BgxkrC
         nRhRVliPo4wB0oF+p4cUhjK4IqKzoG6NBf84IyHhJgfZ78v26c/cECj0B2TVvJBgqyWc
         KUs66MupE3LF1lFmDVJtxIGt2ZFHcdP/ld20kgOuCW1MC/BeUxIQhArxKJ0jLDaCpE5G
         pXFxtRclgz54XbYv6FEweqOs30+csR6o/8oV8xQEYo0EHhOTFt0ZEXqvOhxFzZigiRsm
         VDvg==
X-Gm-Message-State: APjAAAXTFOSQK4gwlhsIQGkjbM7rNn+NPDIpNL/iWs/tN1RCWtBnEIL1
        IlTjYwY8cIzKLsIDTlgug1QZvqXi
X-Google-Smtp-Source: APXvYqwTAd/mIbwIRD8PDMLE3fYTXBSgyA4Pxe0/ET1GyM9UIKBf0Pw1hnRXzyJwDqLsV4oe+ux4Dw==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr4840402wrc.15.1571350078430;
        Thu, 17 Oct 2019 15:07:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm3930519wrs.49.2019.10.17.15.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:07:57 -0700 (PDT)
Message-Id: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.git.1571209637.gitgitgadget@gmail.com>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 22:07:55 +0000
Subject: [PATCH v2 0/2] Handle git_path() with lock files correctly in worktrees
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

I stumbled over this during my recent work in Git GUI
[https://github.com/gitgitgadget/git/pull/361] that was originally really
only intended to use the correct hooks directory.

It turns out that my fears that index.lock was mishandled were unfounded,
hence this patch series has a lot lower priority for me than "OMG we must
push this into v2.24.0!".

Technically, the first patch is not needed (because I decided against adding
a test to t1400 in the end, in favor of t1500), but it shouldn't hurt,
either.

Changes since v1:

 * Clarified the commit message to state that index.lock is fine, it is 
   logs/HEAD.lock that isn't.

Johannes Schindelin (2):
  t1400: wrap setup code in test case
  git_path(): handle `.lock` files correctly

 path.c                |  4 ++--
 t/t1400-update-ref.sh | 18 ++++++++++--------
 t/t1500-rev-parse.sh  | 15 +++++++++++++++
 3 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-401%2Fdscho%2Flock-files-in-worktrees-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-401/dscho/lock-files-in-worktrees-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/401

Range-diff vs v1:

 1:  cf97c5182e = 1:  cf97c5182e t1400: wrap setup code in test case
 2:  f08c90ea02 ! 2:  93dba5a3a3 git_path(): handle `.lock` files correctly
     @@ -3,8 +3,9 @@
          git_path(): handle `.lock` files correctly
      
          Ever since worktrees were introduced, the `git_path()` function _really_
     -    needed to be called e.g. to get at the `index`. However, the wrong path
     -    is returned for `index.lock`.
     +    needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
     +    specific to the worktree). However, the wrong path is returned for
     +    `logs/HEAD.lock`.
      
          This does not matter as long as the Git executable is doing the asking,
          as the path for that `index.lock` file is constructed from
     @@ -13,10 +14,12 @@
          However, Git GUI just learned to use `--git-path` instead of appending
          relative paths to what `git rev-parse --git-dir` returns (and as a
          consequence not only using the correct hooks directory, but also using
     -    the correct paths in worktrees other than the main one). And one of the
     -    paths it is looking for is... you guessed it... `index.lock`.
     +    the correct paths in worktrees other than the main one). While it does
     +    not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
     +    let's be safe rather than sorry.
      
     -    So let's make that work as script writers would expect it to.
     +    Side note: Git GUI _does_ ask for `index.lock`, but that is already
     +    resolved correctly.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
