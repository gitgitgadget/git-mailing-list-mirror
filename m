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
	by dcvr.yhbt.net (Postfix) with ESMTP id 012F51F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfJJMBl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:01:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39795 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfJJMBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:01:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so7564518wrj.6
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wsmWODy5uDWrcSivHMbMqFYWoIpAh8xyoeIMqnpig68=;
        b=McSzYn0ryEyUxkh9eVsV9RPgxnYe2UQyxBcj3VxlG+g+5dHqSLfcNkANmQ47Vx1U9u
         97JzQ9wgqxVobYq5swr5SPwndYzWl7F95b78CyQvwup/r2o5bZdfmkqxJ4JDYV9YD+Si
         Ti3qq52J3FgXAhovafvLzHJeTgPCMM3G1PjA6QXA38cOjMwO7KdxMgsQ0HEQj11ZyIX4
         TbEROChxApvr8xDlDPdlkcCKKkyois7Jsa95Sk29pqLB0NNkDxD0fyO2xcVSWrnNbVaY
         9COQ0VZpNVJcYbBsJmJmeW9/a/Jkf1Maiy17gIdNwgRFXA9OlusEnC77tz4n2n+eDbKE
         c7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wsmWODy5uDWrcSivHMbMqFYWoIpAh8xyoeIMqnpig68=;
        b=W4Ipiaw56VPJAyTgKG9nmBjeqZrwtrH6y5qcc91/k58KtV9NT+b5UKgx31z6ibKgC9
         4Kf0LWmZMpsZx4qmEGQ0oKUMDRpANfP4u0B2EQlTPcwHk/FwvTDb5ZFKRwZZI0elxfpO
         Pe1VGcg+NE6V8RYZmbe5CWeUJRk60O+GIYEuB8gQ56pAgSnD5MbocmPQVYO0AD5AF8rZ
         kb4XEXJXcgYhx47EBHmTZFQJ3wlgxT5tLz+wzL2uAUop2fiMdFMbSfIAJjK6GchkwyKE
         GMHGTD8ZDQEIwKEWeM2ynXYG58NLXszDhHCc3HBruStJRmxT8FEQl/Rz75AFuZjOMJel
         j37w==
X-Gm-Message-State: APjAAAWiGmYQ0EOxOLnm6cgZdV+3GiFG4kqTU+iasgFdWQWw2nKhKAS+
        sRg2qgYqmQUYb9J8iLoktp4S5Vbm
X-Google-Smtp-Source: APXvYqz1CkcM5LJwUHGbtExi47z1qAECubJ0f7KYj24x+7Vg8odP2oJ3Ktx9m0G7kpvJcIOCmvma1Q==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr5984838wru.31.1570708899155;
        Thu, 10 Oct 2019 05:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm7120026wro.14.2019.10.10.05.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:01:38 -0700 (PDT)
Date:   Thu, 10 Oct 2019 05:01:38 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 12:01:36 GMT
Message-Id: <pull.385.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Pass through the exit code of post-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Magne Land <magne.land@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my attempt to revive an old discussion
[https://public-inbox.org/git/20180314003816.GE147135@aiede.svl.corp.google.com/] 
(related to this StackOverflow thread
[https://stackoverflow.com/questions/25561485/git-rebase-i-with-squash-cannot-detach-head]
).

> [...] is this the right behavior for "git checkout" to have? I.e. is it
useful for "git checkout" to fail when the post-checkout hook fails, or
would it be better for it to e.g. simply print a message and exit with
status 0?


To answer Jonathan's question, at long last, yes, it is useful. A hook is
not only an opportunity to run code at given points in Git's life cycle, but
also an opportunity to stop Git in its tracks. Further, if you script the
operation, it may very well be useful to discern between an exit code from
Git's operation from an exit code produced by your hook.

If you don't want your git checkout/git switch/git restore to fail due to a 
post-checkout failure, just make sure that that hook does not fail ;-) (This
could easily be achieved by trap EXIT { exit 0; }, I believe.

I discovered, however, that the original patch contribution missed that a 
git checkout -b <branch> will not pass through the exit code, but instead
return exit code 1. As part of my contribution, I fix this, and also
introduce a regression test to document the now-consistent behavior.

Johannes Schindelin (1):
  switch/restore: consistently pass through exit code of `post-checkout`

 Documentation/githooks.txt    | 3 ++-
 builtin/checkout.c            | 8 +++++---
 t/t5403-post-checkout-hook.sh | 9 +++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)


base-commit: 70bf0b755af4d1e66da25b7805cac0e481a082e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-385%2Fdscho%2Fpost-checkout-hook-exit-code-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-385/dscho/post-checkout-hook-exit-code-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/385
-- 
gitgitgadget
