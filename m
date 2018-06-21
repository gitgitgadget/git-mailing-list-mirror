Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352421F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeFUOaw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:30:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39017 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbeFUOav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:30:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so6510209wmc.4
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZOM75GELlpqMw/cgvcB8IErsL5jjKUm1sLi+Wzugdg=;
        b=qoEMuCFEF0/Il458P6H47EQIYHoZW7rTm23LYHsYhhxQUd5sXEQKFyJ8Pp8mSNQBh1
         LwOcF3ogbh1NOAohnuRPov6ExOWPWB/QDq6rJZz5pBkv2IiXkDSPpapKqkDeOvGfBjNx
         BIi+b+/BiPR7Ga2y5oIz5p2cvhOim6NJxptcShPKb+nJE+clJRKRGwhe/DaSbvhMxKw/
         JJqR9MsI//e9hhhHO1P0CEATYhWu2YosEX1VNjV/lMq9g6/SX1bN46Vzr+3Yl6/X5sQt
         Ns0mpcb339qQ+2Q5jG1mSe8jG/MGO5pUoaOfacIslhAS+s+T1sgrOhVTPmaHjfDKLBA4
         HY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZOM75GELlpqMw/cgvcB8IErsL5jjKUm1sLi+Wzugdg=;
        b=raq/AV/93/TtzQYRdX5qNwaiQuTx8GyG7Tm39KBZPODoS5uIH5dUMrXPJTpuZpSTyM
         ihdJK8BXA3fkHKaWEiEOhvPeayq8U4FFsXy1jbvBrKADqAsij1QLTcsMlDQMU+pTFMJO
         wcyHsb56ktQmwsRH0fJwFU33iojMV2g3RUWkH45eZmCKVVRXbKeXGJaNRMZvdGZRpG+W
         5sMmcvyl0GO16UQyP3BN3lG68oez3hp6L56Z/BcZM4XTgmhDxGZYjomQlsVAa88HjYbo
         s/iDA+S/BQHFZLV1zYpIwNNhDTRSrt0++ywYHYqPk3fPJqVOwSpJD6zcGDRv0/+8JJ1F
         9xgA==
X-Gm-Message-State: APt69E0+tTeVSHlt2ufmq/qj0Gw3eRPnicVQFcUza4MWYj3YD3/sdCL6
        Akj8DivcFRbD9SogwJ7Hv6E/74sD
X-Google-Smtp-Source: ADUXVKJE9X+KDPn1nxokN85g+2yxKDvR738x17Eku2/v7d2SXGDWKy+QLIsfP+gd28AZfzR0JiVLRA==
X-Received: by 2002:a1c:3046:: with SMTP id w67-v6mr5165410wmw.47.1529591450404;
        Thu, 21 Jun 2018 07:30:50 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm1333591wrj.73.2018.06.21.07.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:30:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 0/3] rebase -i: rewrite reflog operations in C
Date:   Thu, 21 Jun 2018 16:17:29 +0200
Message-Id: <20180621141732.19952-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thes patch series rewrites the reflog operations from shell to C.  This
is part of the effort to rewrite interactive rebase in C.

The first commit is dedicated to creating a function to silence a
command, as the sequencer will do in several places with these patches.

This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
with pu (as of 2018-06-21).

Changes since v2:

 - Removing the “verbose” parameter to run_command_silent_on_success()

 - Rewording some parts of the second commit

 - Changing the help for the “--verbose” flag

Alban Gruin (3):
  sequencer: add a new function to silence a command, except if it
    fails.
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C

 builtin/rebase--helper.c   | 14 +++++-
 git-rebase--interactive.sh | 39 ++-------------
 sequencer.c                | 98 ++++++++++++++++++++++++++++----------
 sequencer.h                |  6 +++
 4 files changed, 96 insertions(+), 61 deletions(-)

-- 
2.17.1

