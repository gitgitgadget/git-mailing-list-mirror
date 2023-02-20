Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF6C61DA3
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBTVEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTVEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:04:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD7193CF
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:04:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j2so2271477wrh.9
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7po4SfcwoNK/KmD752V0yO1WxAeWG6HAYfWZsx7xiQg=;
        b=mIUanu1n76JN7nzMahLDc0o/mTNcCNJza4gpeY2h6YZu8YXy9HeOo0IrRfciXI1knG
         ylulYfq/OpKrIlDX4iJegQIn0z0JfPRHx3Ucyqish3gW/Jqqs3fEVjThYdk407woefhz
         ImzYEq9xvg/iZk1WiRxFqOq/cOT1y2b3Wt/zfahVFRET8CivN2tMydhwoic2nX25ARaJ
         i2bzVVvZL9xhGWv4UWO95wI0/XEWO/Guvl6SK/QIhSgzDZh7WU4c2mQhBrGWvVYb498e
         RuiwGfJI154kp9h1B4q5Vb+VLeBqQEfKAQqu/lPeD4moBsefw+YyOV5S/sqKM1w4ba4S
         kIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7po4SfcwoNK/KmD752V0yO1WxAeWG6HAYfWZsx7xiQg=;
        b=Zk67O0jwbexHZ33S9i3ws/2qcRYpkq0ReosY7fvRusZaKtI9Z4PzKZjd8diFRB3Cgu
         nOSqS5WX2BfBFP5duA84Vt/HZ13qDsM/NIVBxKwW98HgImgwwQZMBG65rYNWOtO0Lshd
         +W9AHu6OyQMNq6IqsTzq6CGznhhxPfR9SBpU3Je92dW1caAYpgGk8diSBZm+n8d/Hdxh
         AZnHTlpcl2N7JRzSsat+dOCwDAL1I3KYX/Yp4B68Cs1rzDJgVoDIHJRXoPHlncHYciiE
         Q6U6Cz3gQEDNaw+S082A+jpfEKdqIwvl95KO6QRZ4oi2bsyjWQ2kkGOLqcELabjWefG7
         XANA==
X-Gm-Message-State: AO0yUKX1Pg55tfg/Ot6OhHQ5CJgtjIb7bEALtc2fRkx4S4vpNJx3WuZ7
        MJgRapQPuFNn9M8H5/VPDhPxgVV+1Xw=
X-Google-Smtp-Source: AK7set9M/w7s9zOgFFXPROMtXShWqKJFPySiDELXkBJHDX3tsPXHj1d1GYF2gOR9RCIfOww4EW8Xrw==
X-Received: by 2002:a5d:6a06:0:b0:2bf:e443:ea70 with SMTP id m6-20020a5d6a06000000b002bfe443ea70mr2700195wru.1.1676927084156;
        Mon, 20 Feb 2023 13:04:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c54f4d0f71sm3838532wrw.38.2023.02.20.13.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:04:43 -0800 (PST)
Message-Id: <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Feb 2023 21:04:40 +0000
Subject: [PATCH v4 0/2] Teach diff to honor diff algorithms set through git attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository contains different kinds of files, it may be desirable to
use different algorithms based on file type. This is currently not feasible
through the command line or using git configs. However, we can leverage the
fact that gitattributes are path aware.

Teach the diff machinery to check gitattributes when diffing files by using
the existing diff. scheme, and add an "algorithm" type to the external
driver config.

Change since V3:

 * cleaned up documentation, typos
 * minor cleanup such as if statement ordering, and overly long lines

Changes since V2:

 * minor clean up and variable renaming
 * avoid parsing attribute files for the driver if the diff algorithm is set
   through the command line

Changes since V1:

 * utilize the existing diff.<driver>.* scheme where the driver is defined
   in gitattributes, but the algorithm is defined in the gitconfig.

To address some of the performance concerns in the previous series, a
benchmark shows that now only a minor performance penalty is incurred, now
that we are no longer adding an additional attributes parsing call:

$ echo "*.[ch] diff=other" >> .gitattributes $ hyperfine -r 10 -L a
git-bin-wrapper,git '{a} -c diff.other.algorithm=myers diff v2.0.0 v2.28.0'
Benchmark 1: git-bin-wrapper -c diff.other.algorithm=myers diff v2.0.0
v2.28.0 Time (mean ± σ): 716.3 ms ± 3.8 ms [User: 660.2 ms, System: 50.8 ms]
Range (min … max): 709.8 ms … 720.6 ms 10 runs

Benchmark 2: git -c diff.other.algorithm=myers diff v2.0.0 v2.28.0 Time
(mean ± σ): 704.3 ms ± 2.9 ms [User: 656.6 ms, System: 44.3 ms] Range (min …
max): 700.1 ms … 708.6 ms 10 runs

Summary 'git -c diff.other.algorithm=myers diff v2.0.0 v2.28.0' ran 1.02 ±
0.01 times faster than 'git-bin-wrapper -c diff.other.algorithm=myers diff
v2.0.0 v2.28.0'

John Cai (2):
  diff: consolidate diff algorithm option parsing
  diff: teach diff to read algorithm from diff driver

 Documentation/gitattributes.txt | 31 ++++++++++++
 diff.c                          | 90 ++++++++++++++++++++++++---------
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 38 +++++++++++++-
 userdiff.c                      |  4 +-
 userdiff.h                      |  1 +
 6 files changed, 140 insertions(+), 25 deletions(-)


base-commit: c867e4fa180bec4750e9b54eb10f459030dbebfd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1452%2Fjohn-cai%2Fjc%2Fattr-diff-algo-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1452/john-cai/jc/attr-diff-algo-v4
Pull-Request: https://github.com/git/git/pull/1452

Range-diff vs v3:

 1:  816c47aa414 = 1:  816c47aa414 diff: consolidate diff algorithm option parsing
 2:  b330222ce83 ! 2:  77e66ab98fc diff: teach diff to read algorithm from diff driver
     @@ Commit message
          finally the diff.algorithm config.
      
          To enforce precedence order, use a new `ignore_driver_algorithm` member
     -    during options pasing to indicate the diff algorithm was set via command
     +    during options parsing to indicate the diff algorithm was set via command
          line args.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`,
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      +
      +The diff algorithm can be set through the `diff.algorithm` config key, but
     -+sometimes it may be helpful to set the diff algorithm by path. For example, one
     -+might wish to set a diff algorithm automatically for all `.json` files such that
     -+the user would not need to pass in a separate command line `--diff-algorithm`
     -+flag each time.
     ++sometimes it may be helpful to set the diff algorithm per path. For example,
     ++one may want to use the `minimal` diff algorithm for .json files, and the
     ++`histogram` for .c files, and so on without having to pass in the algorithm
     ++through the command line each time.
      +
      +First, in `.gitattributes`, assign the `diff` attribute for paths.
      +
     @@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`,
      +------------------------
      +
      +Then, define a "diff.<name>.algorithm" configuration to specify the diff
     -+algorithm, choosing from `meyers`, `patience`, `minimal`, or `histogram`.
     ++algorithm, choosing from `myers`, `patience`, `minimal`, or `histogram`.
      +
      +----------------------------------------------------------------
      +[diff "<name>"]
     @@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`,
      +git-show(1) and is used for the `--stat` output as well. The merge machinery
      +will not use the diff algorithm set through this method.
      +
     -+NOTE: If the `command` key also exists, then Git will treat this as an external
     -+diff and attempt to use the value set for `command` as an external program. For
     -+instance, the following config, combined with the above `.gitattributes` file,
     -+will result in `command` favored over `algorithm`.
     -+
     -+----------------------------------------------------------------
     -+[diff "<name>"]
     -+  command = j-c-diff
     -+  algorithm = histogram
     -+----------------------------------------------------------------
     ++NOTE: If `diff.<name>.command` is defined for path with the
     ++`diff=<name>` attribute, it is executed as an external diff driver
     ++(see above), and adding `diff.<name>.algorithm` has no effect, as the
     ++algorithm is not passed to the external diff driver.
       
       Defining a custom hunk-header
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     @@ diff.c: static void run_diff_cmd(const char *pgm,
       	}
      -	if (one && two)
      +	if (one && two) {
     -+		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
     ++		if (!o->ignore_driver_algorithm && drv && drv->algorithm)
      +			set_diff_algorithm(o, drv->algorithm);
      +
       		builtin_diff(name, other ? other : name,
     @@ diff.c: static void run_diffstat(struct diff_filepair *p, struct diff_options *o
       	const char *other;
       
      +	if (!o->ignore_driver_algorithm) {
     -+		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
     ++		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index,
     ++								    p->one->path);
      +
     -+		if (drv && drv->algorithm) {
     ++		if (drv && drv->algorithm)
      +			set_diff_algorithm(o, drv->algorithm);
     -+		}
      +	}
      +
       	if (DIFF_PAIR_UNMERGED(p)) {
     @@ t/lib-diff-alternative.sh: index $file1..$file2 100644
      +
      +	test_expect_success "$STRATEGY diff command line precedence before attributes" '
      +		echo "file* diff=driver" >.gitattributes &&
     -+		git config diff.driver.algorithm meyers &&
     ++		git config diff.driver.algorithm myers &&
      +		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
      +		test_cmp expect output
      +	'

-- 
gitgitgadget
