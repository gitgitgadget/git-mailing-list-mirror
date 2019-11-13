Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651181F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKMAeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:34:25 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49691 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKMAeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:34:25 -0500
Received: by mail-pf1-f202.google.com with SMTP id r187so156920pfc.16
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qazu3F4b6kzx5Tcjf7JtMJ99CCEWEk+4LjNulgymqao=;
        b=BCLdcz5sbbMlWcdqdAwwiuX2BL74DvfpL7F6bpDUPYKqZH7W9op1h2HfDeInR/7OB8
         tQdrQ6zLJDrt3U87KAovQx0Wn34bHwLL2QZ1yvpsXl7BC4yzuq8iF3ZBxDarNqwHAycx
         IAbhXrryVgZb74/3RRNNIclhC3jZqcWO53rYfUhTxuZCpO5Q3ZEZFeeE4bWoav35ohYb
         iy83bRNbNOYVnFOoY1C5+22Gs1tu7msmMZD2TTl+Exmtdqi1Hsv41f562+icv0zOHeYJ
         2NCumXHJZupQ6d9hpI4i0G9weEGB7OPpjrnlds8lj4SUySjm6PkwERoMy+tmMG9LhsqV
         xImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qazu3F4b6kzx5Tcjf7JtMJ99CCEWEk+4LjNulgymqao=;
        b=rbIiZv457ihvlZM3AD02elnkxJgeIT3cawY8Ac2z+p9TBfLBf5uklKU7TsBqb/fZT1
         4AM0avIrwA9CzTnIijhMbVqLAYkR/sjjM42rWZplDgObmpopmv7ktMMV6Zu4Bgwxhg9o
         t2/grfsABWOX1WmebalKnrSil0KDxP+/8l3V0wgWl+iBCOA7BJZMNM5U9AGvU39p56mD
         u9OQqg/F6taY9oAZ8uPe6Akp2SIiOgwnpIANEGjhc9UgppYkpujfSpBMLaQoqG5eLYF0
         KX1Xk2YRKek5kyYA5VaM2r7/ntPYInkl0bO6bx/sgeSIG2P4FnS7r4z/Tg2w8dWLwbB3
         TALg==
X-Gm-Message-State: APjAAAUNi+Y3B66IAOO1wtKYpaYP7Fb1wqnz5ONoifYDpcJSowCsE3qH
        RQQE8jz4mGJuLJrxrt4lCBj/fRFqVLohoGmi+r1CV9js0T9DA5nyJaQ4lcofVh1yUOjLqN+uB8Y
        OlA5W4HXXnPT39jl5mgiRVKW3VLJ33V8iOwit0jMxjqqq6kLiLy64JZXejtEeeAszO49vbyGtbl
        ob
X-Google-Smtp-Source: APXvYqyfeAgfBRwc3G4uj+/JqAf6/Ci06NIDHPSiOIqHwZPGUUHjpMoJ92oLUeNXK7fnDvYkc6Z0P10yclGszZ6bRr6T
X-Received: by 2002:a63:5a5c:: with SMTP id k28mr356610pgm.183.1573605263795;
 Tue, 12 Nov 2019 16:34:23 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:34:18 -0800
Message-Id: <cover.1573604516.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH 0/2] More fetch_if_missing=0 removal
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on jt/fetch-remove-lazy-fetch-plugging.

This patch set both uses the work in commit 6462d5eb9a ("fetch: remove
fetch_if_missing=0", 2019-11-08) and covers up some of the edge use
cases that the aforementioned commit did not cover.

Junio wrote in [1]:

> What I am not certain about is if we are ready
> to move to the right direction for the longer term, or we should still
> be relying on the big-hammer global bit for expediency a bit longer.

I'm not sure if this patch set is an argument for or against. I did
think 6462d5eb9a would be sufficient (but as these patches prove, it was
not), but at the same time, with the additional test coverage provided
by these patches, the overall work might be worth cooking in next.
(Whenever, at $DAY_JOB, we encounter an edge case with partial clone, we
have been submitting patches with test cases for "git fetch" or "git
clone" but sometimes not both, so between 6462d5eb9a and this patch set,
these edge cases would be covered too.)

[1] https://public-inbox.org/git/xmqqh83s8h3m.fsf@gitster-ct.c.googlers.com/

Jonathan Tan (2):
  clone: remove fetch_if_missing=0
  promisor-remote: remove fetch_if_missing=0

 builtin/clone.c   |  3 ---
 connected.c       |  3 ++-
 fetch-pack.c      | 46 ++++++++++++++++++++++++++++++++--------------
 promisor-remote.c |  3 ---
 4 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

