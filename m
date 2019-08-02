Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8A71F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406868AbfHBJ5R (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:57:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43575 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406847AbfHBJ5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so52507891lfm.10
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxqrBD3ATV7jpOgMssqqtb+iQQS6lFr2D04nniwENNc=;
        b=WkRVq2Edb5f8l0IxvX7t9ZWKkMSrOh5uFgwpktGyEPmv9cQfD3GiYjbaFvmwHgJx1P
         6DxqYFGUyGo/K4YuYfi01qm0JrWZ3C7gAAj07cfONOa9eD6Nke8qFmhfemT4z5D1//pP
         8opgH1EanGfB3hJNuG3urKzG7wXt+WjYabdooPemts1XZhPMiNZgwOchlJRjFth6EQAI
         wWGL0CDCkcOkgF+/eNa5adGwbrQBVKCU+vzxAOBo13pIRwEKwJmyYY9oxCUnAHyAVN8/
         t+GhVUEVctRQC+8ueNDZOMrcyeqTWXNe3dZhHXznLUQUCkbd3KuT1fXIhh79G5p3Txb4
         M3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxqrBD3ATV7jpOgMssqqtb+iQQS6lFr2D04nniwENNc=;
        b=HCksoTLcGcdyEBYfSLFSVBobLnG0Ibv8eEnnCjySl0PI4lxye9LL0xLX7evGMPUfaq
         felrXH6RjuizI3DB1DCJM4Ji7V8HvnRD/430w8gd/lZSyr0CKqZTsxPryHgIhkw/iUNO
         gFUG4o+9lBP/iZv0LdM4B7fZouux3J1qSJCFy8SM2szeAs45A/TObbZY2IZVnDcS/z9W
         0jSGm9G+Ee94b4TtyxtyCTM9TSWT7I+7A7Uod8urvhuw+XXC8h7uDYw3xOuGlV9WzJkA
         D7pl6NJV69x0/uJh+iI2DEqFYWhrny9+pOoes/6leE3fOhOzNNqIphruIGR/CJgWLhlm
         O7dg==
X-Gm-Message-State: APjAAAVk0TE1L973y/WSaTU8xeIi2X9kQIdEuhHhmGmWkpSvJOvLlk+E
        RV9XnDd5YnXl9MOshY1eIYE=
X-Google-Smtp-Source: APXvYqyxJCMIuCkEahglD1f9B6vbq455cfgJcE4x4vUJDj6yIgmyXvZhw+VZS/6XBdlpWmKj9ssppg==
X-Received: by 2002:a19:490d:: with SMTP id w13mr62574632lfa.58.1564739831516;
        Fri, 02 Aug 2019 02:57:11 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v3 0/4] pre-merge-commit hook
Date:   Fri,  2 Aug 2019 11:56:34 +0200
Message-Id: <cover.1564737003.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
References: <cover.1564695892.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Dropped cc-list the first time around. Apologies to those who receive
this twice...]

On Fri, 2 Aug 2019 at 00:20, Josh Steadmon <steadmon@google.com> wrote:
>
> This series adds a new pre-merge-commit hook, similar in usage to
> pre-commit. It also improves hook testing in t7503, by verifying that
> the correct hooks are run or bypassed as expected.

I really like those test improvements. Now it should be harder to mess
up a future refactoring and run the wrong hook. These hooks are "very
related" so I think this is important.

I've messed with the test a bit and offer these potential improvements
for your consideration. I was lazy and just built this on top of your
series -- if you agree to some or all of these, you'll probably need to
squash them into a few individual patches.

The first four are perhaps more or less a matter of opinion, although I
do think that patch 2/5 is based on an opinion shared by others. ;-)
Patch 5/5 or something like it seems pretty important to me to make
sure that of these two "similar"/"related" hooks with some
"backwards-compatibility-and-code-copying-history" around them, we'd
better pick the right one when they're both available.
 
Feel free to pick and squash as you see fit. (I don't think it makes
sense to have these go in as-are. They really are meant for squashing.)

Martin

Martin Ågren (5):
  t7503: use "&&" in "test_when_finished" rather than ";"
  t7503: avoid touch when mtime doesn't matter
  t7503: simplify file-juggling
  t7503: don't create "actual_hooks" for later appending
  t7503: test failing merge with both hooks available

 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 84 +++++++++++--------
 1 file changed, 50 insertions(+), 34 deletions(-)

-- 
2.23.0.rc0.30.g51cf315870

