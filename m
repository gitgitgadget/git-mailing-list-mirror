Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E4020248
	for <e@80x24.org>; Sun, 24 Mar 2019 23:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfCXXwH (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 19:52:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfCXXwH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 19:52:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so388025wrq.8
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFIk88XIiqvIk8w/yXgUFhqOqvh0LgoQ9LP+NKHTfTQ=;
        b=CKHO84bjr9IeAFqXPUIDm5ZVWGCQzbKGgFESs8yvdhzOiGn1zkaxyl7k2wQamMT5Q9
         4g1uU5LZsBsqkvWDrXES/ieXosowYtm1mWDfSrEO1Nys9WaFut5LAWfKbQBm8Ummferc
         pVzbYEEpIaQ4wGtgL5Eo3PXGuFCT0FoT4c3cb3Cua0L2TE+1VNvBj0DYV3XPY3VdLmCP
         8PzU/88/E3rqtl/ug1US9RS3+Mo090pnvIrbrPzDm67Hg9EZZhMdljcswOXqKG18P/80
         3oXYncc0uH0jVdzWYWvRbAQ9Tio+QzbnDi0VMvHya9eBtVp0AvdS5PG7aTETdo/0dQBR
         JvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oFIk88XIiqvIk8w/yXgUFhqOqvh0LgoQ9LP+NKHTfTQ=;
        b=t2dAdw7RDJHErvl+2qgt1zhsndwd6xuSKVxOhQQy/pzl7YLD9zsRKoFhqyQbeFb2/4
         EsOBPvPJxHdk18OH+aUwRcLKQB4M1UGgRQUEbd3KEic7hymZo4okuCtqzLcrFc02sZoa
         esfbpgU+tXbDIZ5GAQ1Lpgs7tQMhGv6ValeaORUuMqx9lLzc4bDqxbuiwKJSnxN7S6rR
         NtupHKt3M1gj6yRYtLw0Vtdv25di85/SIwPizQo3aNTxgZ3o636HUssjD8O1OnwlLwOq
         lhHOrAOaf2NDbYmanfF6iD9huAs3k8brpjdUsZCKrkgSyt/vXTR6ehDJEH0vaSnX7L2w
         mB9Q==
X-Gm-Message-State: APjAAAX9yfUe48xcXw5cUMeiG5wNyq4w58m5tG3rQD9i5EbM3EWHuzDL
        oAskPPiX7ONdqXWJCXn1fSkLYcQD
X-Google-Smtp-Source: APXvYqzmF9G8Ke5lO6c+W3KGgaAqUrZeEekW+X25hgW7K1y4u7xL1IW3R1463B1BRk0G8FPob8Q1OA==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr13203814wrp.268.1553471524880;
        Sun, 24 Mar 2019 16:52:04 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id x22sm14898317wmc.19.2019.03.24.16.52.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 16:52:04 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Michael Platings <michael@platin.gs>
Subject: [RFC PATCH 0/1] Fuzzy blame
Date:   Sun, 24 Mar 2019 23:50:19 +0000
Message-Id: <20190324235020.49706-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Hi Git devs,

Some of you may be familiar with the git-hyper-blame tool [1]. It's "useful if
you have a commit that makes sweeping changes that are unlikely to be what you
are looking for in a blame, such as mass reformatting or renaming."

git-hyper-blame is useful but (a) it's not convenient to install; (b) it's
missing functionality available in regular git blame; (c) it's method of
matching lines between chunks is too simplistic for many use cases; and
(d) it's not Git so it doesn't integrate well with tools that expect Git
e.g. vim plugins. Therefore I'm hoping to add similar and hopefully superior
functionality to Git itself. I have a very rough patch so I'd like to get your
thoughts on the general approach, particularly in terms of its user-visible
behaviour.

My initial idea was to lift the design directly from git-hyper-blame. However
the approach of picking single revisions to somehow ignore doesn't sit well
with the -w, -M & -C options, which have a similar intent but apply to all
revisions.

I'd like to get your thoughts on whether we could allow applying the -M or -w
options to specific revisions. For example, imagine it was agreed that all
the #includes in a project should be reordered. In that case, it would be useful
to be able to specify that the -M option should be used for blames on that
revision specifically, so that in future when someone wants to know why
a #include was added they don't have to run git blame twice to find out.

Options that are specific to a particular revision could be stored in a
".gitrevisions" file or similar.

If the principle of allowing blame options to be applied per-revision is
agreeable then I'd like to add a -F/--fuzzy option, to sit alongside -w, -M & -C.

I've implemented a prototype "fuzzy" option, patch attached.
The option operates at the level of diff chunks. For each line in the "after"
half of the chunk it uses a heuristic to choose which line in the "before" half
of the chunk matches best. The heuristic I'm using at the moment is of matching
"bigrams" as described in [2]. The initial pass typically gives reasonable
results, but can jumble up the lines. As in the reformatting/renaming use case
the content should stay in the same order, it's worth going to extra effort to
avoid jumbling lines. Therefore, after the initial pass, the line that can be
matched with the most confidence is used to partition the chunk into halves
before and after it. The process is then repeated recursively on the halves
above and below the partition line.
I feel like a similar algorithm has probably already been invented in a better
form - if anyone knows of such a thing then please let me know!

I look forward to hearing your thoughts.
Thanks,
-Michael


[1] https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/git-hyper-blame.html
[2] https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient

Michael Platings (1):
  Add git blame --fuzzy option.

 blame.c                | 352 +++++++++++++++++++++++++++++++++++++++++++++++--
 blame.h                |   1 +
 builtin/blame.c        |   3 +
 t/t8020-blame-fuzzy.sh | 264 +++++++++++++++++++++++++++++++++++++
 4 files changed, 609 insertions(+), 11 deletions(-)
 create mode 100755 t/t8020-blame-fuzzy.sh

-- 
2.14.3 (Apple Git-98)

