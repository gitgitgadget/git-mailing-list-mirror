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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9641F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfFRUV1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:21:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45579 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRUV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:21:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so23508864edv.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+iMM/coHWtcp94WSW/aFRQPfwX6XZmtIsYwPhvrTszA=;
        b=aOUUZMAOKJV/gc7nE4dOaY7ASRVNbpSKT26gH5ETLtRWgYYn0K8GjyVZtBwGqKUc2y
         irSq0Y+qxxZJ3qt4LSDTkWHuB5v2gfL4WkbYqtdnejcLIdaOfTdSvZov5XhILOaQPUF9
         JpLNy1MIeU1vcvCMIWIpq8kW1AlefzxhlbMgCvgZPBXsUn8+BQK+dBGeI4FRIh8TMe0R
         40lSD0vw3wZbefaeg7YtkI36Ub4/i5yjZeLSzFTJNzKceweoGEHV269dM9KbtsBw7V1M
         /4rTKh3PIdutGY+lpsbuUIC0gBjjcqBWu2bKUd/9nrEUfUA4H9bYBuTEQoAINLJ7s3oE
         419w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+iMM/coHWtcp94WSW/aFRQPfwX6XZmtIsYwPhvrTszA=;
        b=piO+/Vx4F+5dz5SwIrRtvLqtzozjI815eBGV4WEpahCBbAxlaOSxyXdaThXVCMGps2
         Ns7rwKplpUMTDARZL8Cc8KALR4TkdrCWrw6M3VctDzohEU+OSUaaxjkyMganSL54Bckb
         b/w2bW2HdunADME4ebwa/b6mrqo6iKfNEqxACZdLfGZ1JyW/SqVf5nP2K9xoYT7pAFQl
         5xjf0tnVcU7vcjkcjQaFujEw8K8fm5lJcYnfS0Vkd76hhqYS2zYsH33aGjnHRHlLMjaz
         XBgL8eTomfCa3nDXAxX3iCHMkKI6KKfmZe3VIY44jJ0EINZ+IW1m0UdT9L9kTq0N1Yl1
         ZfuQ==
X-Gm-Message-State: APjAAAXVQAlLJD1u2tkwpVWvvXjBvYzzjktzaTaGvnUbj6rWFhBVuemI
        5dGULASpi/fJOJP011ZUibWwlllW
X-Google-Smtp-Source: APXvYqx2cU0krzaHqTkJ3TD0EygGIITsRE+uk89p78Wr+SYOdfmJV34MfT28wR6FV4uCWADJZsHoxg==
X-Received: by 2002:a50:91ef:: with SMTP id h44mr99933096eda.276.1560889285687;
        Tue, 18 Jun 2019 13:21:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p37sm4947419edc.14.2019.06.18.13.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:21:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:21:25 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:21:20 GMT
Message-Id: <pull.272.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] git-status: create config for ahead/behind calculation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git status builtin includes a calculation for how far the local ref is
ahead or behind the remote tracking branch. This check can be expensive, so
we already have a --[no-]ahead-behind command-line option.

This series adds two bits of functionality to the feature:

 1. Add a new status.aheadBehind config setting.
    
    
 2. Add a new advice.statusAheadBehind config setting associated with a
    warning that suggests status.aheadBehind when the calculation takes a
    long time.
    
    

We have been running with these commits in microsoft/git for a while now.
The only change I made in adapting Jeff's commits was to add the advice
config documentation.

The status.aheadBehind config setting is a candidate to be added to the
proposed "large repo" meta-config setting previously discussed [1]. I'm
putting this out for independent review as it is much smaller compared to
the potential of that series.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Jeff Hostetler (3):
  status: add status.aheadbehind setting
  status: warn when a/b calculation takes too long
  status: ignore status.aheadbehind in porcelain formats

 Documentation/config/advice.txt |  6 ++++++
 Documentation/config/status.txt |  5 +++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/commit.c                | 19 ++++++++++++++++++-
 t/t6040-tracking-info.sh        | 31 +++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh         |  8 ++++++++
 wt-status.c                     | 17 +++++++++++++++++
 8 files changed, 88 insertions(+), 1 deletion(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-272%2Fderrickstolee%2Fstatus-ahead-behind-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-272/derrickstolee/status-ahead-behind-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/272
-- 
gitgitgadget
