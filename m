Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7DE1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCWVZp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:25:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46733 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeCWVZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id z10so5202789pfh.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=maYhZIZhUzeJ4534cpL0cpLVMSFuuRjyOkp16Alhnng=;
        b=pXiLE4Pk9bguEtD393Poz/lbvAYIpD/zdF1erE/LSP8TkWNGYcVrWT8n7hc+RcxkTl
         AyIOOIM5qj6yReGsKid1lEpzXec0fhVamNuhQ9zr63rDOF+ohnuKW5zWCKYBej0rR+pK
         EOA+NcUGkF7D2eV/Z/M9nOWTVEwAZ7lcE9NPhVVTDh4BPrlPvPgWJ9ZXVIM4jLg6uXyp
         TYZYclpWE9/WnGATiBZcdQaReEfLrj1vPni+u/16i0hJP0LL66qh2DD1YFGFbXCtV8ft
         PADgauMFhtCdSU4w5aP1wXmvFmsSfb2/VidwkHrWIeHgXMfuowwhduhaoem6+D3H0wkP
         N1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=maYhZIZhUzeJ4534cpL0cpLVMSFuuRjyOkp16Alhnng=;
        b=FQoSAmTtaTOAFueMziPlQ2uSE1N/uAnr39zo3aOm6VcmMzTvnKFH2YgEE129/fb6Yn
         GFLeIfpPLHy2yEeieUsdXQlHL9BemrqpLk3fhHt0LLzpVwBnIHn4ceYLotS8XGC+GX/m
         lyXw6rlhUfR4f1+jVfEatpOKYuMCB2VYYn2/4jTfRiLuaViF5bzFOunMu8Pr+1Pj+wwM
         IRVUlYtpzjC8omkxoFQyQYnCuPU7TkAaO3jZjAGlRg9c6zjAMgewyKxZAclZT3sVed7e
         OA5KxFx6KJ+iwauN5pdEUjO37v67IjoYiXrL6KyXdbKM1KC7jcrxZ1lBYU+LBLLKjl0c
         srLg==
X-Gm-Message-State: AElRT7HPjgumcRqtJOQ0DIqiMWK8QIzDzgqPYUgs0QSOLvpyZfHC201F
        1h0WN852Mor55VXFg+U+BuROnCSmcxs=
X-Google-Smtp-Source: AG47ELsm8T2t6D0R1Rrm8uOLmk3kSaXrH63g2XjsVlnisldLCs0UoofbbOQtf8XAU+O6Ad/BjoTtww==
X-Received: by 10.99.109.142 with SMTP id i136mr22035781pgc.306.1521840343551;
        Fri, 23 Mar 2018 14:25:43 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:41 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 0/8] rebase-interactive
Date:   Fri, 23 Mar 2018 14:25:21 -0700
Message-Id: <cover.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reworked patch 1 so that all of the backend scriptlets
used by git-rebase use a normal function style invocation.

Merged the previous patch 2 and 3 have been squashed which
provides reviewers a little easier time to detect any changes
during extraction of the functions.

Wink Saville (8):
  rebase-interactive: simplify pick_on_preserving_merges
  rebase: update invocation of rebase dot-sourced scripts
  Indent function git_rebase__interactive
  Extract functions out of git_rebase__interactive
  Add and use git_rebase__interactive__preserve_merges
  Remove unused code paths from git_rebase__interactive
  Remove unused code paths from git_rebase__interactive__preserve_merges
  Remove merges_option and a blank line

 git-rebase--am.sh          |  11 --
 git-rebase--interactive.sh | 407 ++++++++++++++++++++++++---------------------
 git-rebase--merge.sh       |  11 --
 git-rebase.sh              |   1 +
 4 files changed, 216 insertions(+), 214 deletions(-)

-- 
2.16.2

