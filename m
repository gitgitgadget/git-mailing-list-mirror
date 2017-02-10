Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810271FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdBJS40 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:56:26 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34951 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdBJS4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:56:24 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so1088922pfx.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ka3NhDxLKoeOnTEjmr+MSFaFnDW5C738TYWN6MyVHGI=;
        b=Blm/rb5NC89OMg+D/uEfejlMYvlMe8qzmzXzyNPLZOcY+iUtvTe+jCCal58qY/am7j
         UBozL57Vj7Ix/9VhxCQiJBVFJ/hoBGtGD8SPP3IZrgOWiWSDy99zZH9gxBKheokSPtrr
         kZ+D4NGDZJb9BwY2Ek9Mg7AnO80pTesiVPnyjXwLcoJ7tMdTc26EHGFOaFaLPqQqAClo
         7cJ6eJrDZis7fj40nLj0qTkTOZOmXPZ+Zx21lT5/iem7kLcLe0zTm8LijNtUtcgEAv33
         xEefOytpouHsD2wWyOS5CQzPQqJ2Aqf96HhEwajKQ17RR1/JsE24gsrfqQ8XGm1zc7vk
         Yu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ka3NhDxLKoeOnTEjmr+MSFaFnDW5C738TYWN6MyVHGI=;
        b=SZdR7L4HKWLGBPRgHx8JCD2GvGoF/zQlj8QQxQMQk2R4mDtt62Mvd7bm+cFrl60Of0
         LnOtQIaBpLykC1UoyBCCq80IPXILs7Yqa01UioBCtrpAFZ7rvotJbvT8VySqXLyNbo8Y
         RYAbdS7KE4o8M69EF8TFgZ1mXuSRP5YoquNmLZLK8yoW8OiY0V647eAu/ZWBXvLQgJeJ
         jtg2LGAg0W6hjf5GS1EUwHiaxCyBMAxFL0O5oZilQ1qUwLeFV2cqOSCXTX8CV7ulN353
         xXfIWnn65ONLE8SDa+1GyjKFmCHCLS6ZNpMYBAZKN0rWkQ/KAPZjV+GBGiqPIYhhUVsv
         hw/g==
X-Gm-Message-State: AMke39nOicZYypqndami7RixhDnygAp1Tbzhado8dWzg/5gIHnOjtybQwCdXybE0zYTkkg==
X-Received: by 10.99.217.85 with SMTP id e21mr12624217pgj.79.1486752955184;
        Fri, 10 Feb 2017 10:55:55 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id d69sm7084302pfd.11.2017.02.10.10.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 10:55:48 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 0/2 v3] WIP: allow "-" as a shorthand for "previous branch"
Date:   Fri, 10 Feb 2017 18:55:24 +0000
Message-Id: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot, Matthieu, for your comments on an earlier version of this 
patch! [1]

After the discussion there, I have considered the changes that have been made
and I broke them into two separate commits.

I have included the list of commands that are touched by this patch series in
the second commit message. (idea from the v1 discussion [2]) Reproduced here:

  * builtin/blame.c
  * builtin/diff.c
  * builtin/diff-files.c
  * builtin/diff-index.c
  * builtin/diff-tree.c
  * builtin/log.c
  * builtin/rev-list.c
  * builtin/shortlog.c
  * builtin/fast-export.c
  * builtin/fmt-merge-msg.c
  builtin/add.c
  builtin/checkout.c
  builtin/commit.c
  builtin/merge.c
  builtin/pack-objects.c
  builtin/revert.c

  * marked commands are information-only.

I have added the WIP tag because I am still unsure if the tests that I have
added (for git-log) are sufficient for this patch or more comprehensive tests
need to be added. So, please help me with some feedback on that.

I have removed the "log:" tag from the subject line because this patch now
affects commands other than log.

I have run the test suite locally and on Travis CI! [3]

[1]: https://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/#t
[2]: https://public-inbox.org/git/CAN-3QhoZN_wYvqbVdU_c1h4vUOaT5FOBFL7k+FemNpqkxjWDDA@mail.gmail.com/
[3]: https://travis-ci.org/icyflame/git/builds/200431159

Siddharth Kannan (2):
  revision.c: args starting with "-" might be a revision
  sha1_name: teach get_sha1_1 "-" shorthand for "@{-1}"

 revision.c               | 12 ++++++--
 sha1_name.c              |  5 ++++
 t/t4214-log-shorthand.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100755 t/t4214-log-shorthand.sh

-- 
2.1.4

