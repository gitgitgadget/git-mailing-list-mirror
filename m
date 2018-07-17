Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A7E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 22:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGQXYa (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 19:24:30 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:41818 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGQXYa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 19:24:30 -0400
Received: by mail-it0-f74.google.com with SMTP id h26-v6so831961itj.6
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=5xZgFLTl8OVxkU1TjDkOZWlqcIQ/DbYc2ZEkWZ4QhNA=;
        b=oT6J813OK+9lsCnm7VpsfGR5dWmO7Ir9XZmbSNPFalOT5kanb493UbbFx/c3DMZ6Uy
         tR2HpyrS+RyV9w2qnxeiVV0r6IhYLr+xDEzcMJ+iYbwCkQ3NeJnOyBXZny6RXw2tiwwL
         GW8kEQ3VNFcSdOuPClihXbx6W8E+JQHqYKvmTXS7YdEhom4Gwx8fptt/326uTn/07Uge
         z3vKYY/oFgqlkA23JOFIp2X56YbdFVODlKpMXof/sH6pp4FlL0Q6bFAjhsiWZev9Hcfx
         nsj/zag/k2oLG4mVefl/XpmGki6w79t71rJFmWAqY48Ic6NhMQcXumUQ4cc4Q07whcgx
         j0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=5xZgFLTl8OVxkU1TjDkOZWlqcIQ/DbYc2ZEkWZ4QhNA=;
        b=ZbOzY3M+1THf8YvmAx2V93nYgQOG+8WlnfYAD3QbmWnarURuEEMY8woRBhG7A7AZ3u
         iOerdOmrJlyxGy7KIveN4mG583tsduK/Ur6k2Bu5lbNb9HnTAzdhlnLZq4qoEDkneUFN
         W2SAwQyDk8yD6ytKHUHI//7P3R0lXyED02jNXECSNOHEEIrhJN7iEVb7E4rm4Ftxj1aW
         g/tW+xpxSi5/pCb2XG1IOe2tOZRa15uL5FH3kY3NNwIFsIJ19Hnk1RNzojAIza4xqkYr
         EWYuQREVcVVav2UYb16XQZxMH0lmFSivev1X0ibOHH1rowfre9y1KKI4lAB7QpVwyNaF
         w4aw==
X-Gm-Message-State: AOUpUlH/Nf/wZn/6RnMnX0TUoRMs/daPRx+hoSn+reZ/QpfZu/a035qk
        b8p011JQ0WEYVxkvUMKpeA2W/OP1sXDf
X-Google-Smtp-Source: AA+uWPzHyA2tYEdyMZj7uADy+k1hlKLFrq/OilQ03+vcWyN38xbfKZvUaXm1incdYGuZG3w21oLcUq3Ho1Y8
MIME-Version: 1.0
X-Received: by 2002:a6b:9bcf:: with SMTP id d198-v6mr1426986ioe.52.1531867779516;
 Tue, 17 Jul 2018 15:49:39 -0700 (PDT)
Date:   Tue, 17 Jul 2018 15:49:33 -0700
Message-Id: <20180717224935.96397-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 0/2] RFC ref store to repository migration
From:   Stefan Beller <sbeller@google.com>
To:     dstolee@microsoft.com, stolee@gmail.com
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stolee said (privately):

    I also ran into an issue where some of the "arbitrary repository"
    patches don't fully connect. Jonathan's test demonstrated this
    issue when I connected some things in an in-process patch 
    Work in progress: https://github.com/gitgitgadget/git/pull/11
    Specifically: https://github.com/gitgitgadget/git/pull/11/commits/287ec6c1cd4bf4da76c05698373aee15749d011a
    
And I dislike the approach taken in
https://github.com/gitgitgadget/git/pull/11/commits/287ec6c1cd4bf4da76c05698373aee15749d011a
and would prefer another approach shown at
https://github.com/stefanbeller/git/tree/object-store-convert-refstore-partial
or in this series.

This approach doesn't have the ugliness of having the repository around twice,
e.g.

    int register_replace_ref(const char *refname, ...
    {
      struct repository *r = cb_data;
      ...
    }
    
    ...  

    for_each_replace_ref(r, register_replace_ref, r);
    
which would iterate over the refs of the first "r" and have "r" as a call back
data point for register_replace_ref.

This approach also takes the gentle hint of Junio to not replace well used functions
throughout the whole code base (using coccinelle), but for now exposes just
one example in the second patch.

These patches have been developed on top of jt/commit-graph-per-object-store.

Opinions?

Thanks,
Stefan   

Stefan Beller (2):
  refs.c: migrate internal ref iteration to pass thru repository
    argument
  refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback

 builtin/replace.c    |  3 ++-
 refs.c               | 48 +++++++++++++++++++++++++++++++++++++-------
 refs.h               | 12 ++++++++++-
 refs/iterator.c      |  6 +++---
 refs/refs-internal.h |  5 +++--
 replace-object.c     |  3 ++-
 6 files changed, 62 insertions(+), 15 deletions(-)

-- 
2.18.0.233.g985f88cf7e-goog

