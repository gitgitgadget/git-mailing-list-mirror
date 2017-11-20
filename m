Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC26202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbdKTXzy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:55:54 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43965 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdKTXzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 18:55:52 -0500
Received: by mail-qk0-f169.google.com with SMTP id j202so9738837qke.10
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bmagsk4UiUOGYiAoMiO/awl1aECT0Y/w/wRjx9DK6zk=;
        b=lXC8FbPy0sDRBb5chxT+9uwGlnZ9N0R6eX+diQhEZKv9XnpZwzOC7shahJrvUiC8lJ
         1zcfCVuozEw91fUAWXvFURbbU2UWnqn1JGnO/qzpiY6fqeSghsYDdwNylZrLuC6Ac+te
         E4EnYy+Tc0Lq+S0AVKcRtgwyvMOhqz5megGuy5cxKtp7h4kwkVFgp4VbrRzD0DLw/c8Q
         OlFZ/yb5BklHmssbUlRc4BNCHapMjAwIBkzFOVSkylyhP4RzjZv9kf/IO9leiTz9oKx1
         iWdSU7J/mtBZdom/86oB0hT29Wix1QclqAHrICsx+zEuMit1UdxuOXA+VWORB8sLPkDt
         oUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bmagsk4UiUOGYiAoMiO/awl1aECT0Y/w/wRjx9DK6zk=;
        b=PkXshlhs42zh0ZD1AAmQJglJ54rjqNMT1IIjmP/TSL03t2zjn1Pwmvkkv5Q+8kieAC
         Po1cBuzsHvRyziARMtQphDzisd4kK8hEYZOCknYgbXB/O5e0INmf+k493obwMBZ0xFCJ
         o3BdlYdqSoAVAgoF2HBEpziUxtrB0iabdubD6IsLWbjG4dxsGi1mah+qLXxcdBxnHwnu
         su7g/lspAnw0sboHUHQhzYZm7jCgakEC44ZpN6IzOdQIAM0fDOq9ywquLLR4AfVDq0qc
         nHtRz/KkyLbtXjPwqIozH9YWuzwjz5bqnxlytM3ZuD2YuPat1CyicjG5BrnnfxzyNKHH
         mHYA==
X-Gm-Message-State: AJaThX4rdufxe+GsjDj1h8uWuOkPMh0vGY0p948qinvA71XIxBOsAgrK
        dY//rg7d88aE2qGx4TnLOs8sJ94OL3FDvQexRz/reg==
X-Google-Smtp-Source: AGs4zMb1y46ZTkTnzxgb110/Y98/vVos9J+HIgacvv96kqOgdGTdkUFYHkAIp4U9KEgNGZ827k2VVvLavWQMsuAkaMo=
X-Received: by 10.55.58.14 with SMTP id h14mr21962797qka.132.1511222152112;
 Mon, 20 Nov 2017 15:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 15:55:51 -0800 (PST)
In-Reply-To: <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net> <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 18:55:51 -0500
X-Google-Sender-Auth: 6vRQTqFk5qbcT3_L1etpPBTz0sg
Message-ID: <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> p5550: factor our nonsense-pack creation

s/our/out/, I guess.

> We have a function to create a bunch of irrelevant packs to
> measure the expense of reprepare_packed_git(). Let's make
> that available to other perf scripts.
>
> Signed-off-by: Jeff King <peff@peff.net>
