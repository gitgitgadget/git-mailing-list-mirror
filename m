Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C0B20A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 08:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLXIsH (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 03:48:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLXIsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 03:48:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so5569858pfc.3
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 00:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SZiKosfDL+rNfSCQmrLfA34LwO5hg5QCWrSW8SIScEQ=;
        b=M85tjKamAO1NLjaG0pWJ2V6ifyP/1vJO3fG/8Q8+VLYNKOMefRfE9RWb3/FimNkm9H
         sjwQfn3l8VUAVDfGb2N3pMY3F7Jb88l1cKQPxbtXQii4+hdzWtmhqo1CxN+Y8EdJvBMk
         u2FttlgxgzwxF8deYn5FwhWXAVFSv4l352PYdceLOviRPhbBwrC44RLA5waeZELUynAr
         bjWS17o/xsOKvG4P2DJ/InpYl7JKY0ddSKOhBvirDB8+oNL2JFMjNbIE9yeuPb5cvarZ
         7W5aheMBQqd5iPVHaCX5a84YGLzylYqk4nWDRRti9IVm07Qw8/4JVI8Mv9Fg8x+gCzeP
         KcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SZiKosfDL+rNfSCQmrLfA34LwO5hg5QCWrSW8SIScEQ=;
        b=Rp0lYEwmOtJloBDyvTPSsUvzlkoMuB9yOYaT1rA9ZeHP3/48Z2Yfx3KIQbfCjC68LB
         t0JifvdxUm0RpMoUs5U3JLx3KMESTON5qhT8V4VHXq6WDvYflPr03K2qPk1DxrgllII5
         LOd/SN1G28ppnxvgo7ZZ7W/Xla2G5fNHiuK64nX46RTE7sDFOBYOaWKrIlWPlroHjWpD
         7KjS2JMI8yDQWN6UQ0UlaPKnDxrp0m2gaSH5Q0k6HjaLzOEhBHvzJdb+kPq11/Lo2XKF
         Ivt62vBMwj5fK7+S6n520r8DzCtZTRw3he2LtltpYRYkaKE1AYaR30d/U383LsVA/JUS
         p9qw==
X-Gm-Message-State: AJcUukdHhAlnH7a9zOiGQm0TfzG6gUXL9wMkdft/pNfwXjFXgGZxFO/6
        s8cQ539b+JLn/khnWNI29TvjoPtL
X-Google-Smtp-Source: ALg8bN4/rVqZQxBiXf1lM8Y9Vw1g/5XMntOLnP+xSPvSbB7daQDZ0tCF9Av1cLzh68/wPBQP104wCg==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr11833626pgp.443.1545641285090;
        Mon, 24 Dec 2018 00:48:05 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id m67sm57292021pfb.25.2018.12.24.00.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 00:48:04 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v4 0/3]
Date:   Mon, 24 Dec 2018 00:47:53 -0800
Message-Id: <20181224084756.49952-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181220145931.GB27361@sigill.intra.peff.net>
References: <20181220145931.GB27361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

> I don't think that works. The default function is always_equal(), which
> will treat two entries equal if they have the same hash value. I.e., any
> collisions would be considered a match.

You're absolutely right. I've added a compare function, but I left out the
functionality for it to work with an entry passed in as a key. Doing so would
mean the user would have to allocate a worktree struct, which just seems silly
when the ref is all that's needed (and also defeats the purpose of avoiding
extra allocations).

And while most of the hashmap API seems OK, yea, this is definitely awful. It
feels like it should just be able to take a key and return either an entry or
NULL, and do away with entry_or_key and equals_function_data.

Travis-CI results: https://travis-ci.org/nbelakovski/git/builds/471787317

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: Mark and color a branch differently if it is checked out in a
    linked worktree
  branch: Add an extra verbose output displaying worktree path for refs
    checked out in a linked worktree

 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++---
 ref-filter.c                       | 72 +++++++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh                  |  8 ++---
 t/t3203-branch-output.sh           | 21 +++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 6 files changed, 128 insertions(+), 9 deletions(-)

-- 
2.14.2
