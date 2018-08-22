Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910E81F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeHWBB6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:01:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41533 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHWBB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:01:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so707448pfk.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TGHt0NT14vcVOwG5/+StKWFKzpizagGkwFwoQTPmWfI=;
        b=GCpiMI6OdvCkS0WwJ4k64NEbt6QIdKsv6JVd9YPDr1pMeqzKqr8HfY5jc96vv4oJ2L
         lQEEkMyufx0kD7oRHZUFwWFbiVFvnRqZccQ5YKYSUOEuPw2O2tXAqUekqpw4ff/+ZTq1
         kvOwrCmupCt4G8VwwOVTp6qhZC1hcyOL7rF17fON+Rlg+3aiYXNY3zSyk+Bz8jcrM3e9
         nJHz8K7wfHwYsIVMl/GrsYngiBmJN2IOL/OpRCxwd2eLrO6sKuQ5brNRWB4sG1GXh1UW
         yQhqxaoQx6u86ZU8KEMEUcrIANHzqqIeCTfDReXVyTNgI4GxwPkfMIlMNI65xbcwastf
         oiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TGHt0NT14vcVOwG5/+StKWFKzpizagGkwFwoQTPmWfI=;
        b=i3UxJU+Wkf2xN7Qbde/64y6B7GvM2mEXiwebDdDAN41AsiL1kU0A2j+ebDRdnV52KH
         G+mRuRUUiJ12fBuBDtcoMAs+gKYC7yEv7+lMRIf1sWRVEHyW5GlATVYkAIn2siWBcLEy
         2QtGbkxSfJ+kB0Ocl7EGruIxNp63GUmJeS3eBmZPI0NoqQrRsntLzMOrdFljMOOrVThJ
         KkOCLsdVt+AWH51XIL05mM8gvCDL9MKV+EJ91IZw1mnfVgRMEJAG91V3VR7jv/IFA98U
         RRtTDp1VK0CiBmROM8IK/qkoreWJRSw1TlAU71R2e5u1gPQKiGpMlBS8SWTomHzOuDxr
         hg8w==
X-Gm-Message-State: APzg51BcGIGaFSeMbHS3yjlI5Z5iUTXiVb03r2ekMEtznfeEOftmQTsj
        6Hcsxq93ZLo7P8brqWB+Bfqo6cE7
X-Google-Smtp-Source: ANB0VdbhEYvlA0BTA6Eirc0JHt+CbyEwAlqjCuKRuBExvlH5s+3MQW9UK6JrADcejLqYFOwQj5rHqw==
X-Received: by 2002:a62:f208:: with SMTP id m8-v6mr405900pfh.222.1534973723234;
        Wed, 22 Aug 2018 14:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id t16-v6sm2858268pga.21.2018.08.22.14.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 14:35:22 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:35:22 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Aug 2018 21:35:19 GMT
Message-Id: <pull.23.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Teach the builtin rebase about the builtin interactive rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtin rebase and the builtin interactive rebase have been developed
independently, on purpose: Google Summer of Code rules specifically state
that students have to work on independent projects, they cannot collaborate
on the same project.

The reason is probably the very fine tradition in academia to prohibit
teamwork, which makes grading easier (at the expense of not exactly
preparing the students for the real world, unless they want to stay in
academia).

One fallout is that the rebase-in-c and rebase-i-in-c patches cause no merge
conflicts but a royal number of tests in the test suite to fail.

It is easy to explain why: rebase-in-c was developed under the assumption
that all rebase backends are implemented in Unix shell script and can be
sourced via . git-rebase--<backend>, which is no longer true with 
rebase-i-in-c, where git-rebase--interactive is a hard-linked builtin.

This patch fixes that.

Note: while this patch targets pk/rebase-in-c-6-final, it will not work
correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
applying this here patch, and only then cherry-pick "rebase: default to
using the builtin rebase".

Johannes Schindelin (1):
  builtin rebase: prepare for builtin rebase -i

 builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)


base-commit: a5bb2345d2d414aba04e18531de1e0f041f0434a
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-23%2Fdscho%2Frebase-in-c-6-final-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-23/dscho/rebase-in-c-6-final-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/23
-- 
gitgitgadget
