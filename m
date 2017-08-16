Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CC2208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbdHPB1o (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:27:44 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36224 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdHPB1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:27:43 -0400
Received: by mail-pg0-f41.google.com with SMTP id i12so16069261pgr.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oNXr+jcXAoEzIErEwDdbSs+ZyVVfj+A3+QhQrh7Qt8A=;
        b=TIsBlaEiOkClIkJHgDxjl2q/iIhLRWGn9Kj5j1cL+bdXoh4+30okIf6iB4wDQfvUCM
         6iWLWH5Pt66XUmCiNQ1JOc+v3zyB+CCVgZy3k1VxMvMd97bJn4XBcec5fZhSTrLTqwz3
         kBI6I9jSl0AUOTfyPvmz/gdhCcSPuta0iDKbCQ8egPmj6zBGtEEFx6yT9Asgtit1r3i4
         cwqT15Y4fXlq2iwLhxWaKdoydZaXI94cUkhq88ycX1cCWnpIuYxtn6rs74/gceoHruqW
         wH0PcZJ051yNBvbN9QUsLE7/SOaPhIftStTHXj3kYQYX1dodPLUkU19I8trTEMDpcaht
         wcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNXr+jcXAoEzIErEwDdbSs+ZyVVfj+A3+QhQrh7Qt8A=;
        b=Plf2VXy/1qVWTNSwln385/SPnRSQLmR9ggppqK3cAnWi4IWyQy4GUU8Ld+OAnqkISb
         nDXS8AETmYIE2rWPTuNlFlyZ0qEQcfsuE6D/nk5g/DsR2UV1+H32kZS/3mK6tZMrJDsw
         pfobEgQh8+0TeywMMPLmfznXGkR3AzlOZkmiNNKlyEWHpvVSobm6r9b3t+abgKtKcLnC
         vUcjHI2POIQVb5HtvvaK50KCrm5pG0k5vMGfgIQweemRWFGl4EujP1Zz9fwoulzfanV3
         5J2CzARvXMRl0OoocXoEA3rwPJpTj/QLr+UTB2HlMjf5UjFcNmPA6AUImjd5o8yXpgwe
         BhyQ==
X-Gm-Message-State: AHYfb5jUYYgCZ24Pnlac7yg+ahNHvosU0Z1qjii6RvAC6rGNeO5JoIOc
        oyeFQjHgY1GIgFJfi45tpw==
X-Received: by 10.84.128.46 with SMTP id 43mr79170pla.113.1502846862236;
        Tue, 15 Aug 2017 18:27:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k8sm621845pgf.33.2017.08.15.18.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 18:27:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 0/3] "diff --color-moved" with yet another heuristic
Date:   Tue, 15 Aug 2017 18:27:36 -0700
Message-Id: <cover.1502846454.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are on sb/diff-color-move.

Patches 1 and 2 are unchanged, except for some line wrapping in a test
in patch 2.

This has been updated to use the same alphanumeric heuristic as blame
(20 alnum characters). I tried it out and I thought the results were
reasonable in a patch set that I'm working on (the pack-related function
refactoring one).

As for refactoring blame.c and this file, I'm not sure where best to put
the new function, so I've added a NEEDSWORK for now.

As for detecting block boundaries in adjust_last_block(), I've left it
as-is for now. I think it's clearer if the parent function provides that
information, since it already tracks that. In addition, we avoid corner
cases such as what happens if the block is at the start of the diff
output (we must ensure that we don't read off the beginning edge, for
example).

Jonathan Tan (3):
  diff: avoid redundantly clearing a flag
  diff: respect MIN_BLOCK_LENGTH for last block
  diff: define block by number of alphanumeric chars

 Documentation/diff-options.txt |   8 +-
 diff.c                         |  47 ++++++--
 diff.h                         |   2 +-
 t/t4015-diff-whitespace.sh     | 261 ++++++++++++++++++++++++++++++-----------
 4 files changed, 236 insertions(+), 82 deletions(-)

-- 
2.14.1.480.gb18f417b89-goog

