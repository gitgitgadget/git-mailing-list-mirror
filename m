Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093DC1F424
	for <e@80x24.org>; Wed,  9 May 2018 17:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935521AbeEIRNd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:13:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34674 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934980AbeEIRNc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:13:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id ay10-v6so4675874plb.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xrd5L4oULlaHdEzjM3I3lTTsGYdFlzgiahbUh7thx5Y=;
        b=uafcoifU352l3Z82c12c5w9zJkoCn0TOaNUMYj3zl8hd4F0UbN1lKkaJgkicGWndEm
         0672yGm1RokbwiSVpackgwXHFIIlO3pnND556gaSCapow0AjMJ+ogX445jeT0s66vetx
         9wIC3XmoC6qkgBKCYPpeZ1zqGFvG8d0O+p6smvKkvKk2pv8LwMKN0Cmv6S3KTuBGv7aP
         E8rgAT6JGBdt4mZGiFLcXZH44KLqbJ+2Yoi+7+AgIo1AWipCGIVf5yz2OrF0x/CiW9Jd
         hHhots/slIJ4uc65TpogjQEY1pHlUyald/nA2Wx5OcGfLxcPDkkuyQ4lHkWaWi0sGHEH
         HPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xrd5L4oULlaHdEzjM3I3lTTsGYdFlzgiahbUh7thx5Y=;
        b=Q/BqWTCs+iZMhEjdIkrRrnxREfX7rG9qmwDZ0n4WOoktYJsMn7wWNdlmkDLRQfPXPs
         0E/CqqVicIQGJ9qnBS7rPpbq4TjQBLKc8IoFS2JaYk1vBMkiv0z9OnytdUoF1xPvxMbt
         L+64HWUHR0YPMjvinfKsH1KDYr7orJc7AmBZbHum8gYRsPzIz4d5MQykg9EZ2TC0+t0b
         XeTXAl0CGVqIo8eElUopXim+lE6MA97y0r1mNZT6hrL2uDCrkEIu5vr1jpmTT2jQLeo+
         LarJ1mZUwijY3tOgV0PAOiUfQxq8472Y4ljzZ/srGZYUWZXX7MSFEdHbTkrLjpUuDjHE
         wfag==
X-Gm-Message-State: ALQs6tC1JYwitswcn0ZxRp0m8aWOj9BHNOmKlldyv5aTUszZT5c51JIN
        Jb6ORgpGYnEy9SX5GKwQP1n/ww==
X-Google-Smtp-Source: AB8JxZqoPbw9mKMmNTKTBeL5svvPvByVW9GigHw9cTndgs6mZ1bcSV0hXVXI7YvezL3Lf2kHwl79Bw==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr47479926plb.24.1525886012386;
        Wed, 09 May 2018 10:13:32 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id c20sm44584560pfk.63.2018.05.09.10.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 10:13:31 -0700 (PDT)
Date:   Wed, 9 May 2018 10:13:30 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pc44800@gmail.com
Subject: Re: [PATCHv2 0/4] Rebooting pc/submodule-helper-foreach
Message-Id: <20180509101330.f41a1d9c03f6af759398137b@google.com>
In-Reply-To: <20180509002952.172347-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180509002952.172347-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  8 May 2018 17:29:48 -0700
Stefan Beller <sbeller@google.com> wrote:

> v2:
> * rebased onto origin/master
> * dropped leftover "toplevel" variable from experimentation
> * reworded the commit message for the first patch extensively
> * dropped the third patch
> * see "branch-diff" below.

Patches 1-3 look good to me.

I also can't see anything wrong with patch 4, but I am not an expert at
shell and how we call it from C, so a review from another reviewer would
be appreciated.
