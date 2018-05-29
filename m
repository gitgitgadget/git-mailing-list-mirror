Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90191F42D
	for <e@80x24.org>; Tue, 29 May 2018 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936964AbeE2Sao (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:30:44 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33182 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936850AbeE2San (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:30:43 -0400
Received: by mail-wm0-f48.google.com with SMTP id x12-v6so49235934wmc.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=XynM7FvkjwCrKC0GIr8gsORC+4cninEEr6sNiwSRSlo=;
        b=HgH46vVT8r0zH9SsA+YYjSaSG5dAHX4wlOJC8HsV9223cGAxPu6g6weRBvhsMyWAXm
         Vw+g3VtxU2I7oDyYWXktoBbBRCcfihGiOQ7gLLwjk6d1JO/1pVzF8wPttd54Lhp1Ufpv
         ZFD1zjjIZgNNDk/O6tu9yBu93R35YIe7XSB8Ydv6C81/xwp3YOjWToHmfW8gw3ulSYg8
         vQEZj641zgQM+GzDpsHKzGPWam6lUqDekFC6z/hYky3+i3K9RHJjBim1iAySqp/AqNho
         LcDySOttV21xf/SFKu64N8C6pgDzLNDYT9Uvo1MK86v2sP48ZPz0HN3b639rNQQsYH8z
         WPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=XynM7FvkjwCrKC0GIr8gsORC+4cninEEr6sNiwSRSlo=;
        b=eGEB31QvvfwYe062md+dX5POl7Cge62hO7GNTXcDqIzKw+MeSn5GwUKtSY3pxfmvk4
         EvqdpM7GHXGaTzCuTD7+e7c4ovyEid76tC7FGf5AelOBiM391AbNy4Zbbi4ULXWvznLm
         ckEuqw7swr8Yo2mCynKisnQIecsAbqsSsvRR4ptOH9EBeqbiCE6DElJF9og/okFiYQlz
         AisbepFHGhp3aEJ2n+JxOhzEPiwn9bvLujRD+0kVBcv8kfRvv4LsOwrR9YlD1+v+182i
         zWhgPIL+CzJ5bQHSqcaGtW8yNKSXqHFn+Co9BUbRObneJ38WskNhrvHne9Jg1s9zdKRX
         FHKw==
X-Gm-Message-State: ALKqPwd1w57s7btaE2VJTin2jgZiHPkai5KyjST3O1ylHAXoty5KbtcI
        XDTjlCtl9icVye/9L8vuvRp29Rgx
X-Google-Smtp-Source: ADUXVKKxxeGbZQ/ZY0ZopWxtWKiJmmLbmsLB+QxKnOiRkARUwaYHLwCzAs/PzrwHpJ5FDrrhsIlRhQ==
X-Received: by 2002:a50:9e2d:: with SMTP id z42-v6mr27909ede.246.1527618642052;
        Tue, 29 May 2018 11:30:42 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y7-v6sm17689066edq.8.2018.05.29.11.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 11:30:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Is origin/HEAD only being created on clone a bug? #leftoverbits
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Tue, 29 May 2018 20:30:40 +0200
Message-ID: <87bmcyfh67.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's some more #leftoverbits where we have a clone/fetch feature
discrepancy and where clone is magical in ways that "fetch" isn't.

If you make an initial commit and push to a remote repo "origin", you
don't get a remote origin/HEAD reference, and a "fetch" won't create it
either.

You will get it if you subseuqently "clone" the repo, but not if you use
"git init / remote add / fetch / git checkout -t" which should otherwise
be equivalent.

If you push to "master" (or whatever HEAD is) from the clone the
origin/HEAD will be updated accordingly, but from the repo you pushed
from & the one you did init+fetch instead of clone you'll never see it.

Some code spelunking reveals remote_head_points_at, guess_remote_head()
etc. in builtin/clone.c. I.e. this is special-cased as part of the
"clone".

Can anyone thing of a reason for why this shouldn't be fixed as a bug?
I've tried searching the archives but "origin/HEAD" comes up with too
many
results. https://public-inbox.org/git/alpine.LSU.1.00.0803020556380.22527@racer.site/#t
seems to be the patch that initially added it, but it is not discussed
why this should be a clone-only special case that doesn't apply to
"fetch".
