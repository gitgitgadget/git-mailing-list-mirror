Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBA71F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfIYK1D (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34920 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfIYK1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so3142322pfw.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/EwqPV7bHBu2FxPGiOiBqgq7Mu13iAK1xYo3r9Xa4eo=;
        b=qBcnLynWLrgwS5SdqUmfR2RDmcYemXG/vcOeK6oMgLnI3+9A6euCri1L091F6ZrF9y
         HHox2JmDkhThjQcC5eEcuMg/5ZmYY+aqfeQfIrwPL/Wg3Ky+9RRrbAJytLh8vravHQas
         WE1fe2ApNICsv732jrDe5GGGyayavcg3wd/BW5SyJxV0TUIJsJ5wmIxYS345JKP2d3+f
         DKr7piWiFbc4/OxOAzMZIUBKaxEDlxiDEhzHfauoNE2fj8cHpcMSYFUcYEXfk/fBzqYj
         qFS8dU+2/aK7yztWenLAYnr85UMPki8onyEx+1itlrIt0LDLZn0VLzuF5yfeakUBdLrZ
         BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/EwqPV7bHBu2FxPGiOiBqgq7Mu13iAK1xYo3r9Xa4eo=;
        b=Ou4aUI2ewpBt/m8FhsMR5ZI1oMvYpAOMjXn6UNw+uWT1/J1Btb7EU8kBOrLBeFRCOM
         O4RXQUPIO67iN3WFZrRl/lvBnhTZvUxdjUZXIysr5pxE+wIGfZImSIi9K2K0NQvwdu10
         9SiP4tKEAVQNShWEZ26Wh25O8yIXFQHw4nkCZj5U0Fhlzz4UP5Cs22EdG6BBJ1nOYpLj
         FmzSC/0OHWSYOq3YiGfFRfTlc0hJWAVFgTDN/3lIdxAWVljjB6P4zvWKLLuu2XSgAadJ
         VDnFrYhLCzinRHIvzuCuMgNwTtNcwW57NRlpt77prxqIlisQrCqdxq1OD2te5KwEHpyG
         vtGQ==
X-Gm-Message-State: APjAAAVKbZdw4PPR7k1PnN8GGt3Pn8w9VS4smB30QM3XGhvCo37JwUxP
        IX60Bf5kX7H+2vqaK5PR63TlduT4
X-Google-Smtp-Source: APXvYqwSPCb7NGK8MO9N6tNVQSlrX0Gx0OAZNO/d4F05ToT/k75EBtQEa72sRIQN+dkfT7ktj0GBgg==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr7966832pfb.96.1569407220850;
        Wed, 25 Sep 2019 03:27:00 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id k23sm4283781pgg.73.2019.09.25.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:26:59 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:26:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 0/5] t4214: cleanup and demonstrate graph bug
Message-ID: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset cleans up t4214 and then, in the last patch, demonstrates
a bug in the way some octopus merges are colored.

While I was playing around with Pratyush's octopus merge in git-gui, I
noticed that there was a bug in `git log --graph`. The horizontal lines
in the octopus merge seemed to have an off-by-one error in their
coloring. More detail in the last patch.

I tried my hand at fixing the bug but in the hour I spent going at it, I
couldn't fix the logic up. The buggy logic is in graph.c:
graph_draw_octopus_merge() in case anyone is interested.


Denton Liu (5):
  test-lib: let test_merge() perform octopus merges
  t4214: use test_merge
  t4214: generate expect in their own test cases
  t4214: explicitly list tags in log
  t4214: demonstrate octopus graph coloring failure

 t/t4214-log-graph-octopus.sh | 143 +++++++++++++++++++++++++++++------
 t/test-lib-functions.sh      |   6 +-
 2 files changed, 122 insertions(+), 27 deletions(-)

-- 
2.23.0.248.g3a9dd8fb08

