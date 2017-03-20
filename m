Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFFA20958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbdCTTWo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:22:44 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34284 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbdCTTWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:22:42 -0400
Received: by mail-pg0-f46.google.com with SMTP id 21so48780320pgg.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5IDkGojguvQTTb08auoqz5WhdiKW1nx/zv7aIe4h1Q=;
        b=wGALaGBXXl+l+hnv++9dgtNtTgotSq2r9vKd35g5GXVGgUB1ie/Dmyf33u94pY766O
         koHqfKJucBMnJHGVBfteCNb37oa0/V6t+F0sX61Tfrl/9a5ZIcBnFbchnGdgnK/qeNY3
         gl5JqT1RL9VOULjC7jAzCH3uptARfYXUsMXva7qhnytN6Twan+BUwh/uqATG3y2w31cD
         qe18Ui0oK+iP8NfNKcBiapF8VZwXCUeBMdzJpEW/PhDyc6Obj+YaK3sw3HBuf2z/LLkf
         8uS0LEn2CZU4i4p41dJexo8wXRT+hBrBAYc6vhkJMEp3V5cfKGaFvoI7BkPZUwZDcefD
         GYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5IDkGojguvQTTb08auoqz5WhdiKW1nx/zv7aIe4h1Q=;
        b=d9fYNgEfbkg972ilLiDygqhuElRd4/evt8fVPcKEUfxE1XRumoMExXFmHa2HfhPaIS
         Mjm3KSN8eiT4WM6wtXRN+pqwq0scTRm3y6JcmOdBHAvlKFxcAITPMGmv+zpcgjXfCNCe
         2spT0f0wcqxZ2ht7LNXY8FKjcK9k/8uAaUAYuPZxAkgyHLiOz3pC6kMoGgLtkEFH+Ddn
         +QQur1889g4slcoPiYBgn/ytT/IqpPCfGq/bVesTH9w+ZZESLjvZ8bwj8qBdrRPi7zdD
         P6/J18puk0qPtesEKfmypNXwtGKKe+A7pKcoD9AfAeE7F8eQhiqyXJQaq7mGyvpYNwsJ
         Od5w==
X-Gm-Message-State: AFeK/H2KAhB3hq+qxubW56mr/FWqEbHjnNb1GbihUsgyHIRJVHcNy2SvpObcmREoEmwMoKrt
X-Received: by 10.98.69.86 with SMTP id s83mr35480807pfa.232.1490037751181;
        Mon, 20 Mar 2017 12:22:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id p189sm22211344pfb.128.2017.03.20.12.22.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 12:22:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] use "working trees" instead of "worktree" in our API
Date:   Mon, 20 Mar 2017 12:22:23 -0700
Message-Id: <20170320192225.18928-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.306.g4a9b9b32d4.dirty
In-Reply-To: <20170320185038.GU26789@aiede.mtv.corp.google.com>
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For what it's worth, this conversation makes me think it was a mistake
> to call this construct a worktree.

So the way forward is to purge the use of "worktree" meaning actual working trees?

Thanks,
Stefan

Stefan Beller (2):
  git.c: introduce --working-tree superseding --work-tree
  revparse: introduce --is-inside-working-tree

 Documentation/git-rev-parse.txt |  4 ++--
 Documentation/git.txt           | 12 ++++++------
 builtin/rev-parse.c             |  3 ++-
 git.c                           |  5 +++--
 4 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.12.0.306.g4a9b9b32d4.dirty

