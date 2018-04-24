Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6BD1F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 05:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755628AbeDXFOA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:14:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34504 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDXFN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:13:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id p18-v6so27711589wrm.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wa4YRUxKDMkuXIILuSJllhd/lPe7lnDbp9wsVo2QM9c=;
        b=Tg7BJk7eRYgx1OH4MyK4p1MiM+P5rqt1qjSwwsjLopEXnVGzhYA0qK6+qN3dN5EuT5
         HXuMiSV1y4/cW621dHC+2TVZVmJciORiOrwtK2TXkrA62Q093kFRTDq0sKO6+N251yUr
         jVj/oXvD5AV5LZTQR9tw95ccA5BIjDO2MB+fRaq5o3y03TlAHf56rstCiuauewi+r6dK
         UTE+6eFhhaUGFsmk7aDas2uaWGy+wk1Fgm+3nZC051B9WyNKqM4aUheY+DAawj7s4JS6
         dDEIbjbiCgSdyhyYOpOIW+c7Vdzyy7iS6yqWcltdM3pUHYVsBKEiIeKKbmn/EcA3APN2
         W9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa4YRUxKDMkuXIILuSJllhd/lPe7lnDbp9wsVo2QM9c=;
        b=ZKbY3fYQwOJZ4eBNMK1+1MH6tBi9nWVyD4dm30WL9wRwrjVOaiJr43vn7yc38/TNrh
         tdCb/7GNzxyb0UW5VJ7s1P5CoeCBqWbZoL1x5daKjqtU1MKePr9ZG7TxVKpaVW21Cg/V
         3XNJFw9lbnXQyCXhNwrBK1aMpYRd8WVt3ggmFHB5BpeG9JoV34TBKnaecCLFPc4sJ0Zn
         Hm2YQdVYP0KgHA2PLRIueVS2x82x1JLpNRNfopT9nBdXt+4ix6+s5BRy6jZiwo63lwG5
         zCSXt6a68sFOPDwlmjczzFbQceSxB2vBLBwjKfXAe4/0bXNX/ztaMYn37CLOY89GUc8R
         12Mw==
X-Gm-Message-State: ALQs6tALarMTWvs2myLX3a2lTv6Y5b+TmHL7R/Df7mqjspi6KS/i5+v8
        69sz11nl1FhDcDgYcs7g9H0=
X-Google-Smtp-Source: AIpwx484TK8fCA2nJdnXv6fQS1CxRToW7x7LquPhOJ6ah/myG/Fve/aw/2hkmdCvOrgn+yNATCpB9A==
X-Received: by 10.28.93.1 with SMTP id r1mr11856487wmb.2.1524546837857;
        Mon, 23 Apr 2018 22:13:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q138sm13091233wmd.1.2018.04.23.22.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Apr 2018 22:13:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
Date:   Tue, 24 Apr 2018 07:13:37 +0200
Message-Id: <cover.1524545557.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 23 April 2018 at 17:54, Phillip Wood <phillip.wood@talktalk.net> wrote:
> I'm fine with leaving it, I've might get round to doing a small series to
> clean things up slightly in a few weeks. At the moment
> setup_unpack_trees_porcelain() leaks memory as it is called for each merge
> and allocates new strings each time. It would also be nice if the error
> messages reflected the command, so it said 'cherry-pick', 'revert' or
> 'reset' rather than 'merge'

This is a small patch series to introduce and use
`clear_unpack_trees_porcelain()`. Since Elijah is doing substantial
rewrites to one of the users of `setup_unpack_trees_porcelain()` [1], I
think we should hold off on these for now to avoid a quite evil merge.
(I haven't studied the details enough to be confident, but I think the
calls to `setup_...()` and `clear_...()` might need to be moved up the
call-chain.)

I'm posting this so we don't repeat each other's work. If you feel like
picking these up and running with them, go ahead. Otherwise, I will try
to get them in as soon as Elijah's series lands. I'll keep you posted.

[1] https://public-inbox.org/git/CAN0heSquJboMMgay+5XomqXCGoHtXxf1mJBmY_L7y+AA4eG0KA@mail.gmail.com/#t

Martin

Martin Ågren (2):
  merge: setup `opts` later in `checkout_fast_forward()`
  unpack_trees_options: free messages when done

 unpack-trees.h     |  5 +++++
 builtin/checkout.c |  1 +
 merge-recursive.c  |  1 +
 merge.c            | 35 ++++++++++++++++++++---------------
 unpack-trees.c     | 11 +++++++++++
 5 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.17.0

