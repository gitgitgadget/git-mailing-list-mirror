Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C5420374
	for <e@80x24.org>; Mon, 22 Apr 2019 00:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfDVAHc (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 20:07:32 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:37173 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfDVAHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 20:07:32 -0400
Received: by mail-pf1-f180.google.com with SMTP id 8so4881847pfr.4
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yYWCh1/OWxFUXOGLTo/ETvLFKHKCoeS/1bEU4ebzPk=;
        b=g5p+Cwu8vrXmrKHhbGRmCkZ9SuXf5LVb0ZEsq+Kl2L1nww4zlj4KXSOr25DXrf8+dw
         krFB9yzhgHScIBYctZd1J0nwsYimCtHfcWYD8C3dVJLRgfwtcNIcBOA52ToVfeS1oou2
         6j9ckqO05HfMWJVFzCgWJCs3SmscAKonsurGxs0po79tE2q9qSjiNTmYrUb5ICfoCYcT
         qobmV7LKjCBOyX+RdvzfaZyaCE5oP3LIEgOYkGbuxWYrhWKY2AXlmR9fKlqbSZOrV354
         PdzB+97afOeX9rXxg9ZkOTdv5newzxrc0Ls4UZxrfERwaTF6xREZUB97g+ktBK32IYNe
         F/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yYWCh1/OWxFUXOGLTo/ETvLFKHKCoeS/1bEU4ebzPk=;
        b=VfOmvEzrVVt4qewfZOhlojz/X/V4lw+TxBH24+IIJWtNQ4JAFF5cZ0OSdZeiVgdO30
         AwDNBtMakA4yxScwhwJATZhhbcYt2wI2F5afGWV5va0LiFZU7TNTGw3TEyXRnnZhuiE2
         mG/Y/loC5PtlEpU31fZX8KHaW7EfCvcmc81BY4ZtCidwypEG+I2ghYUMKNp6DROvcxzg
         BSNYnh0ihw3IQJuKnlnKarC/TG6nRxMXVTUB3+vhgImycDKqK2shFG10DmBJtxVYcsGY
         6dB856DT+t6OwF4B0X31LlWJmeQr1mxNTDj0J9uR5sb3R3h3TzGwlr09KjYOK1NTz3fK
         EyKQ==
X-Gm-Message-State: APjAAAU0NPLh1/LjQjWGlUr95s0A/8HmfNfhhsF5ySfX5yaDTgqYtIv5
        Ktl7rg0vjUJ+Z0woFKKTe/8sEP35
X-Google-Smtp-Source: APXvYqwpIPMKePiEMcKgPy38/xuPShXw+o+7HNvbmDM/9Vc6n21cTSAVT8SoLoVvUL4ZkIcC0rM1JQ==
X-Received: by 2002:aa7:960c:: with SMTP id q12mr17510917pfg.258.1555891650906;
        Sun, 21 Apr 2019 17:07:30 -0700 (PDT)
Received: from phord-x1.hsd1.ca.comcast.net ([2601:647:5701:455f:49f6:143c:5261:44c0])
        by smtp.gmail.com with ESMTPSA id h189sm21163918pfc.125.2019.04.21.17.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 17:07:29 -0700 (PDT)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
Date:   Sun, 21 Apr 2019 17:07:10 -0700
Message-Id: <20190422000712.13584-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

I have a local patch to rebase--interactive.sh that adds "edit" switches
to rebase, permitting me to say, for example,

    git rebase --drop $sha

This command creates a todo-list but drops the mentioned commit from the
list by changing the "pick" to "drop". Other switches let me edit or
reword a commit in my local history, greatly simplifying my branch
grooming workflow.

With the conversion to rebase.c (yay!) my tools are going away. I'm
porting them to the rewritten rebase*.c and I want to submit them here.
But rebase*.c is still in flux, and my changes have many conflicts with
other inflight changes. I'm happy to wait for those, but in the
meantime, I'd appreciate some feedback on the utility and acceptability
of my plan.

Here's my patch series as it stands today. It lacks documentation and
tests, but it mostly works. Errors are not handled gracefully, but this
will be rectified after I rebase onto pw/rebase-i-internal-rfc.

Currently it supports these switches:

    usage: git rebase [-i] [options] [--exec <cmd>] ...
       :
    --break <revision>    stop before the mentioned ref
    --drop <revision>     drop the mentioned ref from the todo list
    --edit <revision>     edit the mentioned ref instead of picking it
    --reword <revision>   reword the mentioned ref instead of picking it

I have plans to add these, but I don't like how their "onto" will be
controlled. More thinking is needed here.

    --fixup <revision>    fixup the mentioned ref instead of picking it
    --squash <revision>   squash the mentioned ref instead of picking it
    --pick <revision>     pick the mentioned ref onto the start of the list


Phil Hord (2):
  rebase: add switches for drop, edit and reword
  rebase: add --break switch

 builtin/rebase--interactive.c |  49 +++++++++++++++-
 builtin/rebase.c              |  48 ++++++++++++++++
 sequencer.c                   | 105 +++++++++++++++++++++++++++++-----
 sequencer.h                   |  22 ++++++-
 4 files changed, 207 insertions(+), 17 deletions(-)

--
2.20.1
