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
	by dcvr.yhbt.net (Postfix) with ESMTP id 401811F454
	for <e@80x24.org>; Mon,  4 Nov 2019 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfKDRuq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 12:50:46 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42027 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfKDRuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 12:50:46 -0500
Received: by mail-wr1-f43.google.com with SMTP id a15so18133231wrf.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pUK3mm4ZguVjlGysokJ72OyK7H27bltT/qQ4jOw7O8A=;
        b=iOFR0ofkl3ef14fSUmYLO2vRPZLj41dv3doNdpgPW9xxAG9xdZOiHjS8w0MO9eZTvc
         y+2hfAQUgoKmCRB7kXpqZH+p4lea5lgElvUnQNt+N/x79QtknsCfRVz0J+qV9PMPJzF8
         +EkbPAJOZ217zm8vDp1ocvJ2WA9szlXQbtZ1NRWdI0rglg2aF+zB1ZjnWBLz/hS/1dpV
         ilxx4ylRxNL+AzJ9DgDrShF5O4+NvxDnbzx1plz35rpzkSolLbJxRFmvjuVTApozyLKL
         a2KEcUjS1YSPlEw2DrKwZy80OjdBSIBq1SPdg4Y+dQ03fS2cOVpkujQ3xdKdS+GbgPxt
         DN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pUK3mm4ZguVjlGysokJ72OyK7H27bltT/qQ4jOw7O8A=;
        b=kTcbvYRwl04R6rxbtd4jAxGIYaSy9dstf/J6zKMtVfhHA5m9Auxpaf6uv8xtfrKkax
         dIvtvK+D7TIFkuM4rDeLxNE+Hhp45GORloWGPHZPvCR8Bf+KB6UARsZWCTE0FrWqnctO
         2xqiWuiacI8cmHTRUAQ8l97nn5Lz6uulJkHAOZgVYJeWkvD/x41VKr/arBlqH39oBH1p
         N2TEp8xA8Yfup6R3uJQ51xf7S5/2NaqY7a66l5byQx1JZ99Ags1yDiFXiqdAzcJ+ecd7
         CgQlmvFLTVLPxw9ABDNQYAkd+R82PTK63v49HLEniTuG56TGa6rtCh3RHsxGSIi1quic
         U5lQ==
X-Gm-Message-State: APjAAAU3X+8AEJeUslLQDlG+FkGzryunlNrGSOspOHC6+UAqj89VIRrh
        5KOHTYsv32f6JCMKfKajf4avoAAx
X-Google-Smtp-Source: APXvYqz8ixarntTQjgGdTeSmQuua36aHWenFXMEwoa9YolYb6kNAKFVsK4bXUWW+BqBsH/tbjxrIGQ==
X-Received: by 2002:adf:e701:: with SMTP id c1mr20167979wrm.166.1572889842297;
        Mon, 04 Nov 2019 09:50:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g69sm19040952wme.31.2019.11.04.09.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 09:50:41 -0800 (PST)
Message-Id: <pull.444.git.1572889841.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 17:50:40 +0000
Subject: [PATCH 0/1] fsmonitor: fix watchman integration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running Git commands quickly -- such as in a shell script or the test
suite -- the Git commands frequently complete and start again during the
same second. The example fsmonitor hooks to integrate with Watchman truncate
the nanosecond times to seconds. In principle, this is fine, as Watchman
claims to use inclusive comparisons [1]. The result should only be an
over-representation of the changed paths since the last Git command.

However, Watchman's own documentation claims "Using a timestamp is prone to
race conditions in understanding the complete state of the file tree" [2].
All of their documented examples use a "clockspec" that looks like
'c:123:234'. Git should eventually learn how to store this type of string to
provide a stronger integration, but that will be a more invasive change.

When using GIT_TEST_FSMONITOR="$(pwd)/t7519/fsmonitor-watchman", scripts
such as t7519-wtstatus.sh fail due to these race conditions. In fact,
running any test script with GIT_TEST_FSMONITOR pointing at
t/t7519/fsmonitor-wathcman will cause failures in the test_commit function.
The 'git add "$indir$file"' command fails due to not enough time between the
creation of '$file' and the 'git add' command.

For now, subtract one second from the timestamp we pass to Watchman. This
will make our window large enough to avoid these race conditions. Increasing
the window causes tests like t7519-wtstatus.sh to pass.

When the integration was introduced in def437671 (fsmonitor: add a sample
integration script for Watchman, 2018-09-22), the query included an
expression that would ignore files created and deleted in that window. The
performance reason for this change was to ignore temporary files created by
a build between Git commands. However, this causes failures in script
scenarios where Git is creating or deleting files quickly.

When using GIT_TEST_FSMONITOR as before, t2203-add-intent.sh fails due to
this add-and-delete race condition.

By removing the "expression" from the Watchman query, we remove this race
condition. It will lead to some performance degradation in the case of users
creating and deleting temporary files inside their working directory between
Git commands. However, that is a cost we need to pay to be correct.

[1] https://github.com/facebook/watchman/blob/master/query/since.cpp#L35-L39
[2] https://facebook.github.io/watchman/docs/clockspec.html

Kevin Willford (1):
  fsmonitor: fix watchman integration

 t/t7519/fsmonitor-watchman                 | 13 ++++---------
 templates/hooks--fsmonitor-watchman.sample | 13 ++++---------
 2 files changed, 8 insertions(+), 18 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-444%2Fkewillford%2Ffsmonitor-watchman-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-444/kewillford/fsmonitor-watchman-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/444
-- 
gitgitgadget
