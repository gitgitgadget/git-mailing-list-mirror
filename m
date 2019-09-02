Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAF51F461
	for <e@80x24.org>; Mon,  2 Sep 2019 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfIBXl0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 19:41:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37327 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIBXl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 19:41:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id b25so11427994oib.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRb0bmsPxG9vHLvu9vZDGwzth/YK+pRBuWXa4XLTTts=;
        b=P2xinrVXCQeMuTyKtRS5j14iplfMxWvavL7u6iyL2ow5nwP+y8u5vVDRfUk5DxG6XT
         xsOIeb61u3dRYoQ5oFCpBEOf30TqMtmJqVgwOGxdWZy2WK4lUpTk0OuoQhQV929TsTtv
         eNSUDiu6weEjSlAniGxoxDEQ3Ud1glFjMf747SSVuvNsDHQf5aaL7k17EXIPuUm3SN5l
         i9/+CBWDilL+ErrZCb/pDLnkBlPN0L9wrf1V4GvzLtJV15dbZFNkqcK568J13IaGJrSU
         mMO90Wb8pxUqzbNtX0zDPAupk9V4RC4vahTM6wNck+HcMziZAtY4mT7I/0tDXNNF0Bmb
         MYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRb0bmsPxG9vHLvu9vZDGwzth/YK+pRBuWXa4XLTTts=;
        b=T+SzXurGzvGXdlyfNlXQXhc6LeQVuUw3yBmkxljogNgOYs9M/4QU9e1uqoibS9hDXg
         w2YNaqrxAheiaM192Cl0UboEU1Mk24UGgDwd98XNW73J5qP+aLp2gI7lxv4uXloTRe3d
         OtRPf7HifhYp8RAfLjRBkogwCxi3Kdps6XHmA6yrTRVBIfYE65dN8xGChRSV8ngU5fK+
         YTSHrLt5/VsRcIlkUfgsP2fLqJTQSFSCP644g7qPAN8b0CmfJXw3ik8mSy5u8SUWpN6L
         iTm7nkeEF0bjkeVWt+4K3YKgpKfB+BE/P16fP9R0ZlvJkSDaDeOH2sify+34aBgDeRSr
         W3+Q==
X-Gm-Message-State: APjAAAUxpEoqw7I75s1AipLl6RwiVRUopxhTvmFQ8LUPlpFyjPph4x70
        fX8rm4hqx0uKajQDIJ90JGVA/fE4wQM=
X-Google-Smtp-Source: APXvYqyWvHvQs8B2qvMCOFeKswtUW4yO/rvX9SGjtH/obIA6UJs/VJNwlzDzbLRcVtWb9u4oJje3oA==
X-Received: by 2002:aca:54d4:: with SMTP id i203mr5869200oib.167.1567467684990;
        Mon, 02 Sep 2019 16:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:cc39:3958:899b:7a63])
        by smtp.gmail.com with ESMTPSA id n32sm5842906otn.61.2019.09.02.16.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 16:41:24 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     git@vger.kernel.org
Cc:     Warren He <wh109@yahoo.com>
Subject: [PATCH] rebase: introduce --update-branches option
Date:   Mon,  2 Sep 2019 16:41:08 -0700
Message-Id: <20190902234109.2922-1-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes people have to rebase multiple related branches. One way to do that
quickly, when there are branches pointing to ancestors of a later branch (which
happens a lot if you try hard to pad your PR count on GitHub--I mean if you try
to make small, logically separate changes), is to rebase that later branch and
then reset ancestor branches to the rewritten commits. You just have to work
out which branches correspond to which of the new commits.

Here's an automated way to update those ancestor branches.

It's implemented as a function that processes a todo list, modeled after
`todo_list_add_exec_commands`. Currently steps are added as `exec git branch -f
<branchname>`, which comes with the caveat that they're not applied atomically
when it finishes rebasing.

If you were to use this feature to rebase `my-dev` onto `master` in this
situation:

```
 A - B          (master)
  |\
  |  E          (feat-e)
   \   \
     F  |       (feat-f)
       \|
         G      (interim)
           \
             H  (my-dev)
```

you'd get a todo list like this:

```
label onto

# Branch G
reset onto
pick 65945ab E
exec git branch -f feat-e
label G

reset onto
pick 4f0b0ad F
exec git branch -f feat-f
merge -C e50066c G # G
exec git branch -f interim
pick 539e556 H
```

Warren He (1):
  rebase: introduce --update-branches option

 Documentation/git-rebase.txt      |  8 +++++
 builtin/rebase.c                  | 13 ++++++--
 sequencer.c                       | 68 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                       |  6 ++--
 t/t3431-rebase-update-branches.sh | 64 ++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100755 t/t3431-rebase-update-branches.sh

-- 
2.7.4

