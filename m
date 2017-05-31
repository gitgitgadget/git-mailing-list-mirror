Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED501FD09
	for <e@80x24.org>; Wed, 31 May 2017 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdEaNVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 09:21:45 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33921 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdEaNVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 09:21:44 -0400
Received: by mail-qt0-f180.google.com with SMTP id c13so11633973qtc.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ubbuQ90dIuDfxJBykY0P84gH0v+lUYCrK0X9Q6CEKmA=;
        b=J88LaRAyB/Pn8mIbVwQH764t2gg4GLhJFtaxPb2EYjLvOFpJVMlAE4ddz6Dnhlfs/T
         K+S75bb811YZYV4+yWwjcXYDWxwatmZjAdfrId951a85F6uQVx/SoFgBuv0BNvMqi09d
         Xubel9T6EiMBXZ4Z+JLqH3PFQZZ2bH1FyxESl3maGAhyBKd5AnzdS2yargnJAT7xn2MS
         u76EzNzP+BZDp48SfMQOSPbimxh7E/99bpEA5g00OcNrlEctBTAFIk1m8IHzEvFVkc34
         YaqtqvQhxBDbrQ07z3kmUaIVj18dUukzOtpXHhAlfjQvl0htHqcFgALpBNFr3AotvzNG
         uQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ubbuQ90dIuDfxJBykY0P84gH0v+lUYCrK0X9Q6CEKmA=;
        b=Tgfenx+Cq5ntz7pJdBNTfRPSwACBoGhw2MOFYgGHozCI2S4p5DYqeLKTV0Exu4ysCf
         tEk8h8ZaIPS8c178P9kENtIZ1PYUo7msKSAKiLiM2glDnxhjgvnZZEHy9u+ehxjtlULM
         iHkIwaRxiDL6Oc8P/fK+pFBkEsFKyx9GcGeUsn9GLIy4+QWNZUZKO4ChCZhYf/uaU1Qi
         Nc7+8KrhJLPqD7r/kZ7dWCrwdW698r6kS2j8tjXJ9uh1lYaUOmwfmTE3VFKx3JoMdVGJ
         8hy4h0bGAcz7SbD1+1G9+1pssJbSkkGXgoo//+wCFSbEYvz5mPkg66wigBtQ5PDIQdva
         NNBw==
X-Gm-Message-State: AODbwcB89yW6k0Osqu8DG6mGa2HLgMxIVhYBoooBeOpN8ow8+WU0jL4j
        VW8iUNuXrV8nTkDvAOzWehC0xs+oUw==
X-Received: by 10.200.49.174 with SMTP id h43mr32316028qte.128.1496236903737;
 Wed, 31 May 2017 06:21:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 31 May 2017 06:21:43 -0700 (PDT)
In-Reply-To: <20170525183612.3128-7-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com> <20170525183612.3128-7-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 May 2017 15:21:43 +0200
Message-ID: <CAP8UFD3H6PXm+0DLOa+25++xC018ntFMKd7XwqbYELzHwHWa1w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:36 PM, Ben Peart <peartben@gmail.com> wrote:

>  templates/hooks--query-fsmonitor.sample | 37 +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 templates/hooks--query-fsmonitor.sample

Please make this file executable like the other sample hook scripts.
