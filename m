Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16481F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHaBpv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54922 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBpv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3332627wmb.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JnGbXGjU9DdfDBOTRt2DRDmrjue5B37tyi9KorByz7g=;
        b=WH6lP9kH5dXzys3MoD0f+xhCMsXAYk9qL9Udf+7S8k79ABnAtOyr0LoitD5kaJlmXK
         JsLMQkzK0aWBTfDUmKt7VpbFer1Y+jzNYFvGZQsMosFlQ5JnGvbzRQEqi822tlLC5z94
         XEtqg4qetz5WHkJI9ZJjePf5u+LAaEaoV+R2+fxpDR+a+Uroc5Yq/deWbr1mUDyJsDcB
         1mn9t3pO6oxF7EZ/4irNrTsppPyIg/TwBcjP4SXTFLiCuDt6I/RxBTvDB8ErndU7fxQn
         V3g5xIiDzZhzyBPirEM5ATsC1yjOh4RHnNvLJgD3vvO2VXwpxiWgPqv4tAcdZ+E7vQRM
         4Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnGbXGjU9DdfDBOTRt2DRDmrjue5B37tyi9KorByz7g=;
        b=dAL3Ysdx5Ba2jmCsAzyTwhtGjCoONnN/B7Klkrv44dd/zoD6ynnzM/bpnp5nNuZSu0
         KlvJImaIBlYQ/zRX51W89/PppLgHHg3yhYdYzOfCgIKa/8koX7KPAc0Gqd0AjAZ2bBaq
         WgBP/pzekvjHG5d/JXNhyTdc9r8gvniqiIHPCp9q6BJ/JojWwyJ7+n9JRHho/8qAjfiF
         YGop9UxIiUUg4kZQszxr/TLKzlbN6xiptzkHyJeGxcHOWPuJ1XAD6dmZBP98PobRpmOR
         EDEZF/+YQ3QoahglZSn0ZthP8RwiHcy4jxvLF61swaPBdpIZlJJGXL3z41u0h70gN1dP
         +DcQ==
X-Gm-Message-State: APzg51DwqzCihTaoaZnwCxavZmgH3UklLQP8iZlYEQQ2YK04V7zGbTAR
        O7bCFcyhcIXKPVZQ4OrrAq0TM5K5
X-Google-Smtp-Source: ANB0VdbWXm6ZrdUcmeQ48DP9LiiY/Wc9xgg9Tl5LROkX38l+OoiyXRW4kc3vMJcSEJC/1Frro47A5w==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr2807493wmh.108.1535665298103;
        Thu, 30 Aug 2018 14:41:38 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:37 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 00/20] Convert "git stash" to C builtin
Date:   Fri, 31 Aug 2018 00:40:30 +0300
Message-Id: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This a new iteration of `stash.c`. What is new?

 * Some commits got squashed. The commit related to replacing
 `git apply` child process was dropped since it wasn't the best
 idea.

 * In v7, there was a bug [1] related to config `git stash show`
 The bug was fixed and a test file was added for this.

 * Fixed `git stash [push]` [2]. In v7, `git stash -q drop` would
 act like `git stash push -q drop`.

 * Fixed coding-style nits. Verified that messages are marked
 for translation and are going to the correct output stream.

 * Fixed one memory leak (related to `strbuf_detach`).

 * Simplified the code a little bit.

[1]:
https://public-inbox.org/git/20180815210142.GN2734@hank.intra.tgummerer.com/

[2]:
https://public-inbox.org/git/20180818165102.GF11326@hank.intra.tgummerer.com/

Best regards,
Paul

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Paul-Sebastian Ungureanu (15):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  stash: update test cases conform to coding guidelines
  stash: rename test cases to be more descriptive
  stash: add tests for `git stash show` config
  stash: convert list to builtin
  stash: convert show to builtin
  stash: mention options in `show` synopsis.
  stash: convert store to builtin
  stash: convert create to builtin
  stash: convert push to builtin
  stash: make push -q quiet
  stash: convert save to builtin
  stash: convert `stash--helper.c` into `stash.c`
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls

 Documentation/git-stash.txt  |    4 +-
 Makefile                     |    2 +-
 builtin.h                    |    1 +
 builtin/stash.c              | 1563 ++++++++++++++++++++++++++++++++++
 cache.h                      |    1 +
 git-stash.sh                 |  752 ----------------
 git.c                        |    1 +
 sha1-name.c                  |   19 +
 t/t3903-stash.sh             |  192 +++--
 t/t3907-stash-show-config.sh |   81 ++
 10 files changed, 1795 insertions(+), 821 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.19.0.rc0.22.gc26283d74e

