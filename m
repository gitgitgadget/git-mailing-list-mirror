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
	by dcvr.yhbt.net (Postfix) with ESMTP id D60921F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 10:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfJ3Ktm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 06:49:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36003 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfJ3Ktm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 06:49:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so1604415wmd.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iw4tRbxIqsrHfPw3k2l0TJs/vsftTcIhbmF99JXIA/k=;
        b=MuGiSEGHBXN/0ubSB994J/uWJmUtMr+dYaoXacReyeP6cuqaNcHuZYtzzeD7hZT77g
         zpmfblLMOjOPjdEdLikvHSwyHt+ceG771kdO/F8+7kEfcvgKnJvM49WRWhKvSDK/04eo
         SmYYr/uOv8RmnkghtK4tkLlr4TLrmP16oXcrtvRNzmdmoumbsKPAfEvbZIvPQscZEiYU
         9uu5L9gCy6h0ADb0GZ0jQvpbR4eI/pf/RJP9cYemComVM5OSy/ky593Tb+PgBcbL21d9
         6qylOzIbut06+lHzjngx7HwV1vzgFuDvxDzEEMJdO9dMFeuQ6ugr32wn1oHfrXi/LLiD
         +X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iw4tRbxIqsrHfPw3k2l0TJs/vsftTcIhbmF99JXIA/k=;
        b=RJEL7jhkOeG1AwOv4jfIdR0GX2FM9lA8HF1bgsH/vEDfjJjo2nRjrxgkBoYst+jTmE
         xRSUqaT2Fjp9UsbfHD9QxGuC8EDT9f7WAbSDJfrt26I9Z202hgGyBzfYmf/Ja8kZVBTJ
         oHnDNyT7VRDBXrhNl0jbxRV3r1TWKKCIyqdAbrS9AfD+Yqyl8gWHxGspROlh9eY/zNaa
         4CQtxtHES0s/MvYWyueaA6mpEMZZa1lfXKa9faJdjKg8Z7+JRFzprKW5f3D0l9ZRfIlM
         /NViDao8Ickt6MqvGIuNcQwn2ZjqdDJn4WLapsisxmHsPm1lupcMzYp9qOhrg5CeJzOG
         faSw==
X-Gm-Message-State: APjAAAWeKWiO4+JczPT4b6QwmkJavBzFeoWrNb0OaWS3Gx9XILj1qyoI
        kXuc53xtG4+usCaGPfTa45FB95Wn
X-Google-Smtp-Source: APXvYqxf/eCFMzxh6cxLtnL+m8CsArxPl9+syDxyrDo6V41IIzq/0OsLAYp4FrwZG5hfNy9M6t2d5Q==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr1983293wmm.133.1572432579538;
        Wed, 30 Oct 2019 03:49:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm2577974wra.74.2019.10.30.03.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:49:38 -0700 (PDT)
Message-Id: <pull.355.v3.git.1572432578.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
References: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:49:36 +0000
Subject: [PATCH v3 0/2] Fix git stash with skip-worktree entries
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

[This patch pair has made it into next already, but since we're too close to
v2.24.0, I think it would be good to revert it out of next and take v3
instead.]

My colleague Dan Thompson reported a bug in a sparse checkout, where git
stash (after resolving merge conflicts and then making up their mind to
stash the changes instead of committing them) would record files as deleted
by mistake (and files that were not even in the sparse checkout's cone!).

I first considered changing the behavior of git diff-index to simply ignore
skip-worktree entries. But after re-reading the documentation of the
skip-worktree bit, I became convinced that this would be incorrect a fix
because the command really does what it advertises to do.

Then, I briefly considered introducing a flag that would change the behavior
thusly, but ended up deciding against it.

The actual problem, after all, is the git update-index call and that it
heeds the --remove (but not the --add) option for skip-worktree entries.
"Heeds", I should say, because the idea of the skip-worktree bit really is
documented to imply that the worktree files should be considered identical
to their staged versions.

So arguably, it could be considered a bug that git update-index --remove 
even bothers to touch skip-worktree entries. But this behavior has been in
place for over 10 years, so I opted to introduce a new mode that does what 
git stash needs in order to fix the bug.

Changes since v2:

 * Avoid a file name that some might consider rude in the test of 1/2.
 * In the test of 1/2, verify explicitly that a deletion has been staged
   without --ignore-skip-worktree-entries.

Changes since v1:

 * Added a test even for the --ignore-skip-worktree-entries option alone
   (i.e. without going through git stash)
 * Rebased onto tg/stash-refresh-index to avoid merge conflicts in 
   t/t3903-stash.sh.

Johannes Schindelin (2):
  update-index: optionally leave skip-worktree entries alone
  stash: handle staged changes in skip-worktree files correctly

 Documentation/git-update-index.txt |  6 ++++++
 builtin/stash.c                    |  5 +++--
 builtin/update-index.c             |  6 +++++-
 git-legacy-stash.sh                |  3 ++-
 t/t3903-stash.sh                   | 11 +++++++++++
 t/t7012-skip-worktree-writing.sh   | 15 +++++++++++++++
 6 files changed, 42 insertions(+), 4 deletions(-)


base-commit: 34933d0eff5d4c91fae6ad6f71a6e6a69a496ced
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-355%2Fdscho%2Ffix-stash-with-skip-worktree-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-355/dscho/fix-stash-with-skip-worktree-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/355

Range-diff vs v2:

 1:  86dbb11f15 ! 1:  163b42dfa2 update-index: optionally leave skip-worktree entries alone
     @@ -81,17 +81,18 @@
       '
       
      +test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
     -+	test_commit geroff-me &&
     -+	git update-index --skip-worktree geroff-me.t &&
     -+	rm geroff-me.t &&
     ++	test_commit keep-me &&
     ++	git update-index --skip-worktree keep-me.t &&
     ++	rm keep-me.t &&
      +
      +	: ignoring the worktree &&
     -+	git update-index --remove --ignore-skip-worktree-entries geroff-me.t &&
     ++	git update-index --remove --ignore-skip-worktree-entries keep-me.t &&
      +	git diff-index --cached --exit-code HEAD &&
      +
      +	: not ignoring the worktree, a deletion is staged &&
     -+	git update-index --remove geroff-me.t &&
     -+	test_must_fail git diff-index --cached --exit-code HEAD
     ++	git update-index --remove keep-me.t &&
     ++	test_must_fail git diff-index --cached --exit-code HEAD \
     ++		--diff-filter=D -- keep-me.t
      +'
      +
       #TODO test_expect_failure 'git-apply adds file' false
 2:  9835e66399 = 2:  8f49a393e0 stash: handle staged changes in skip-worktree files correctly

-- 
gitgitgadget
