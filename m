Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C22B1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeILBWD (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:22:03 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46341 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILBWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:22:02 -0400
Received: by mail-pg1-f182.google.com with SMTP id b129-v6so12793827pga.13
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fMVZjk6pZKZJOEoSKpHlGoqW4U/A4s9WvkFm8uMlpXI=;
        b=S0m2PbL8kvW7uBV5eiQUFH0C0WjHUYPXewjQRn75TuQLiehlNZHLTT+mCcYSMKUjA8
         siVPZSc/W8NyxCOXPZNagZg0z0JX5u+JyXph2guLYFlo3XZzQerbDzoSQ7aSF8w8N5nz
         SHm0zA90yt2OSZkMEr0kO1d2JSX6h8tDR26F6SR5oDakt3oL/py3uNT1AoUX2jaOKWo/
         ig50ZQTGKqBQO3oLdpKuZ8EHru8xcuF59B5ZAtQGzLO366j1rZWIuBYhFvhowcNyteny
         N3Ubr4eCpT8AnBHQbFZHn4UlcHkSbgjyNneP7w80p6UqUdbFIVQUA9WV6CCwmIMQWylG
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fMVZjk6pZKZJOEoSKpHlGoqW4U/A4s9WvkFm8uMlpXI=;
        b=OpOwWpyWeyF/t6hUCHGxPU+MP4zmsiy1jxsn6y5kOBXENuP8ohTNPtneLTcjqVjE4i
         hpRqp9AUFNo1bU+7O+t7/fWbRlAtGZuUVuA4cFCPeyPRbV4GlK3G7XNKRK4/qy2rZsv/
         SXamjdNiuveDFeJFmPnpYFtA03zwJUPg2pnH5u269oyN+1TzVOffN/hyVKBabCMUvtA1
         KQ1FfOlaQ7VW4nXwehVdmP91VUHXyZZ0Dzm0QE4LFEYIU4qNwmry0f4H7qmupcPhDLQw
         ueI32i53B1eZMGMll3PCria5ZsBC4HltT480StANjJ8jcehhpgHumokwZUJZzgzK9p/Q
         ZHUw==
X-Gm-Message-State: APzg51BXerFjkrIVwLh4kauSPLMRoEzteb8neZkT3x6P4E9d/o5y+Wuz
        /QtEbteUbg7KkZDNydR2lxLiaig/
X-Google-Smtp-Source: ANB0VdZuQfPGcP2VUwXXXphf4L8s6DIi2ir4rhblVLKOXOPwdTf0+2wT+FFjCAKstXEUWx8roDD1ig==
X-Received: by 2002:a62:dbc5:: with SMTP id f188-v6mr31868050pfg.182.1536697265668;
        Tue, 11 Sep 2018 13:21:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k69-v6sm20310552pgd.9.2018.09.11.13.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:21:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:21:04 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Sep 2018 20:21:01 GMT
Message-Id: <pull.37.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Add coverage for 'git format-patch --range-diff' single-patch case
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

In es/format-patch-rangediff, we added a '--range-diff' option to
git-format-patch to automatically add a range-diff. We also added an option
to write the diff as commentary to a single patch submission. However, this
check was not tested.

I discovered this test gap by running 'make coverage-test coverage-report'
on 'next' and then comparing the uncovered lines with those in the diff
between 'master' and 'next'. I have a script that automates this process,
and I'm still working on polishing it. You can see an earlier version at
[1].

Based on es/format-patch-rangediff

Cc: sunshine@sunshine.co

Cc: peff@peff.net

[1] 
https://github.com/derrickstolee/git/blob/coverage/contrib/coverage-diff.shA
bash script to report uncovered lines that were added in a diff.

Derrick Stolee (1):
  t3206-range-diff.sh: cover single-patch case

 t/t3206-range-diff.sh | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 40ce41604daf200cdc85abded0133d40faafc2f8
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-37%2Fderrickstolee%2Frange-diff-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-37/derrickstolee/range-diff-test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/37
-- 
gitgitgadget
