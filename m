Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D891F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfIBRz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:55:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBRz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:55:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so10407794wmc.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 10:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNH/PPquqDk2fhxYBJS2yP7yMyW+j9Iu39jsBrItWHE=;
        b=tALqHYpztzL6nrBMMVBSm24xnUTHTsc8PnibrQcRp701mGRVvGK79kuVvj3+T9NcSc
         6YZrxOIWsM3GkNTz5zilgZfQHgBVOEgPE7P+C9tbWJd+Mk/SDk1RgOqhMHf+auXmXy9/
         81jRXKSE6iqVlXMT3Llm91Y+6tOAagJ/G6QwhmgRvmLETmeVG8UvElURytQEmAGY4N/I
         hzNbqhHPX6B/A+Arwr3X1n74rQh2os+Hms+W5dlv6WV+LJxgXzFdjgDqGImsOhv4T7bT
         oC8oxOtHCmLJT66ONXVtMhbZnVWuOx0YV+KYnk7Si5BGo9CGW0jk236x6muOjvAXujjV
         GQeA==
X-Gm-Message-State: APjAAAX+TL7qzmPDBsMlOg+2U2YqsStPvgHedHiVa/LWaY0bvw6xzZeZ
        VFxkXWyu92kIobBMcrVR2FYG+IqpMqxVjxS5zm12i0hT
X-Google-Smtp-Source: APXvYqzJyDycTF4dKRz85WDAhcIRFibl0W0bKvPLdgU/ofif1wKgSFcJqhnIULoQHx2giazJEM2uNr5/gmIhYu1I/cY=
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr10171928wmg.53.1567446956953;
 Mon, 02 Sep 2019 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
 <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com> <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
In-Reply-To: <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Sep 2019 13:55:45 -0400
Message-ID: <CAPig+cRJ8cCT4zPJmUmS6mvAhXM1QBZ4LUTtf3Std_45cWR5hA@mail.gmail.com>
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 1:40 AM Elijah Newren <newren@gmail.com> wrote:
> My $0.02: I think `git worktree add` should not only adopt the setting
> of core.sparseCheckout from the current worktree, but it should also
> adopt the $GIT_DIR/info/sparse-checkout file too.

As another example in favor of imbuing "git worktree add" with
first-class support for this feature (via command-line option and/or
inheriting existing settings), the commit message of ef2a0ac9a0
(worktree: add: introduce --checkout option, 2016-03-29) specifically
sites sparse checkout as the motivation for adding --no-checkout to
"git worktree add".
