Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C309A1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 04:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCWEkA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 00:40:00 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:45676 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWEkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 00:40:00 -0400
Received: by mail-pl0-f42.google.com with SMTP id n15-v6so6774467plp.12
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6Zox8IAaxjlfP+Bhs0i4MIwkKJpAcQEO2hODRtM5SW8=;
        b=hszBLwxGiB1bvIXwSWFluFUVyvscP1lj1zPAfaLpt1Fcctt/EYRwVs8BbaJn5m68mL
         SkdlefrxHbqZoczEKXytEMkNrUH3iQ+FnXA3NDxEeZNjz3AyM5cGLPuSfDvR3eXA38P1
         4unZGsOKzXF9HzFocN2bJ6EwwmHPhXqDZxDqDaPaXcbDo6jPE1d1iIh4qMFSq9nJoLUC
         f+XwT5ejfiEIJnywIwPX+2pWHjz8WSEmiQdlLKvrTWzCr6OOiPnjsP3yYbiC4J9zW145
         JETxcMbP7WMgjKqPTFGwqkiRVvx6oANw33hz0FpuL0TBugR07vDsjI0Q6zP0bXQnkRb/
         P70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Zox8IAaxjlfP+Bhs0i4MIwkKJpAcQEO2hODRtM5SW8=;
        b=AewBg32qKYhR7puc0GBSTy2fScH1w75D4SYWV1KvMoomFLkHutrTISbeOw4wr5vSqP
         khZHMyKJ5kFSmv5STFtjTYPKMz2uyQyG61y3BTLPHL2JZabhw1bxjQdEkbq8AoKENDZJ
         ICnY7lFavIdirog2vvymtbxGK+cXj8RzxvXUbZl8Rl/hsvH7z5tvGOgNvHfCWb0T9lsR
         yEWXA7jdcgzyKxUV77nFj8pjyyimVIFPVIo4V5ATR2qJEO516zpjz8PJXXaE6+bun6de
         UpK7zMgKn4FbU0YYf5765qjzZDvDlpdQLnkq4PVuwUyuuU2YDEJrWWOpQcu1uKu709m0
         +gAw==
X-Gm-Message-State: AElRT7G7RhPncIsi8rJczvHC5JdI2ETKkXbdUZkVJQWot0smEf+U4l9d
        0EQKwZBcntrpnzaUVtEKlsD5JFzc628=
X-Google-Smtp-Source: AG47ELsIL7507VLCyE81eA0NW+L1irC0PZXpIIWhoBadRfTwDg5DWD7Juu4iZlUfNh33vLsm3xlmhg==
X-Received: by 2002:a17:902:8684:: with SMTP id g4-v6mr24461356plo.117.1521779998729;
        Thu, 22 Mar 2018 21:39:58 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id l22sm16069901pfj.98.2018.03.22.21.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 21:39:56 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v4] rebase-interactive
Date:   Thu, 22 Mar 2018 21:39:51 -0700
Message-Id: <cover.1521779249.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v4 of the first 2 patches of "[RFC PATCH vV n/9] rebase-interactive",
looking forward to any additional comments.


Wink Saville (2):
  rebase-interactive: Simplify pick_on_preserving_merges
  rebase: Update invocation of rebase dot-sourced scripts

 git-rebase--am.sh          | 11 -----------
 git-rebase--interactive.sh | 28 +++++++---------------------
 git-rebase--merge.sh       | 11 -----------
 git-rebase.sh              |  2 ++
 4 files changed, 9 insertions(+), 43 deletions(-)

-- 
2.16.2

