Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBB81F404
	for <e@80x24.org>; Thu, 30 Aug 2018 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeH3RAL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 13:00:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43885 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeH3RAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 13:00:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so3838623pfi.10
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NJFZaNqWioZOdTGg1YdcVEwnZMjQSKiS1ixKhoccgIk=;
        b=Mrcr9v2ah4sM+sZYd2ZKMPqMzvm5GB9V5+E2VBcS5jwsJmTpJAkeKEFPbdyrMljCft
         zCy4Gce2m1oHSYgSoEM+QX6hfEseyN7tXgNEEKDtNE11hifWI9oDFXbwO1ene0mKqghl
         IAGLR794N8e40MNVfGqG60qOSRctoXSpZkbo69SFdtihBEdiueqSsv6LM/TtuWD8Nh3g
         +FC0mpAfjgT+4y5YNx23drBG5Vhd1xpFlx4Q+S8cR4QeCWVT29YKhPELE4OzpTsxUpDj
         jTkX3FwA5J0aUDJ/VIn3U9h/z/e9m7v1DPmh9YYSvLdcxX7RJpXvW3NGHyQkO18lLuZk
         AhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NJFZaNqWioZOdTGg1YdcVEwnZMjQSKiS1ixKhoccgIk=;
        b=Gbn/6KPoiGfRpyD6M8f7VVz+2fAApkWFv7Syie0xZV4azkDzyGfzO5W1ZDATIgGQft
         TF3gHMW+hl5ghE/GGnTZjyxYyR9bCceO5EJ9M+YYnOWEreBt1JuaRY5QCiHxAqzwpcWK
         0UHHnJnbYd/5mZjZk3f58tUBzXk0OSTNqnmhbhIEjaLBawFmsPP2hbLM9vcoTd8+HSTq
         LI7MEEQaBnmp/Rr/8rZz/Jp6ez24af75Gwn8UKOK8d5X4aPwXdT7/gHG5wOUiEDVWITd
         vmKW/gslB+/jm2W24RV0vN+QrQlEhE4cAbYdXVZE6Ol4SaX4eagvDARe4C9C2J73633T
         mcKA==
X-Gm-Message-State: APzg51AUqOwvBFCNDfaG0g7N35ZoLn034C5tJcLzD+8K6EwjyFfwxj5O
        Nuf8HCwgY0adUOZSDxQQXAAub6wF
X-Google-Smtp-Source: ANB0VdbmxdK3Bxaa7QLDROrCUIKJnyOWQ9scimOm6ahUYGB3mDtpFzCNq/bJmdRr+fyWN64ge6Ecmg==
X-Received: by 2002:a63:e40d:: with SMTP id a13-v6mr9614982pgi.289.1535633888662;
        Thu, 30 Aug 2018 05:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u25-v6sm10678455pfk.177.2018.08.30.05.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 05:58:07 -0700 (PDT)
Date:   Thu, 30 Aug 2018 05:58:07 -0700 (PDT)
X-Google-Original-Date: Thu, 30 Aug 2018 12:58:04 GMT
Message-Id: <pull.28.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] v2.19.0-rc1 Performance Regression in 'git merge-base'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I was testing the release candidate, I stumbled across a regression in
'git merge-base' as a result of the switch to generation numbers. The commit
message in [PATCH 1/1] describes the topology involved, but you can test it
yourself by comparing 'git merge-base v4.8 v4.9' in the Linux kernel. The
regression does not show up when running merge-base for tags at least v4.9,
which is why I didn't see it when I was testing earlier.

The solution is simple, but also will conflict with ds/reachable in next. I
can send a similar patch that applies the same diff into commit-reach.c.

With the integration of generation numbers into most commit walks coming to
a close [1], it will be time to re-investigate other options for
reachability indexes [2]. As I was digging into the issue with this
regression, I discovered a way we can modify our generation numbers and pair
them with commit dates to give us a simple-to-compute, immutable
two-dimensional reachability index that would be immune to this regression.
I will investigate that more and report back, but it is more important to
fix this regression now.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.25.git.gitgitgadget@gmail.com/[PATCH
0/6] Use generation numbers for --topo-order

[2] https://public-inbox.org/git/86muxcuyod.fsf@gmail.com/[RFC] Other chunks
for commit-graph, part 2 - reachability indexes

Cc: gitster@pobox.comCc: peff@peff.net

Derrick Stolee (1):
  commit: don't use generation numbers if not needed

 commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 2f743933341f276111103550fbf383a34dfcfd38
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-28%2Fderrickstolee%2Fmerge-base-regression-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-28/derrickstolee/merge-base-regression-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/28
-- 
gitgitgadget
