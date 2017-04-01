Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA8D20958
	for <e@80x24.org>; Sat,  1 Apr 2017 20:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdDAUMx (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 16:12:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34401 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdDAUMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 16:12:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id x137so10002466lff.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ic9v1IjsOPI+7jh5BDc79ava/4ZSrCkVIWmi3pAd8Ko=;
        b=Xjmq5fgqjer8Xf1uxfU3y1pMa0J4j5LAVOr4hlKee4X+HZJMz2iO6JkalmQnfkUEbq
         ee6NMmWCU+Nt7GiK702JKCb/rLuDTXNdRzHjrPXm3jtXBvlSech95LNt8Ev4N/nEZsFc
         mGjxoHPXgfE0VmdJr9sjvm4M7QSIgZxoB5i4fhJZCEY/pu3GVxC961okIvrSDQ7ar+1U
         vTwKrky9MYWcqrXf8JCdquB/TPblWAsaRaHgwdFlG/mIo7C6uTa6PG4lrr9+DWsNYt4D
         84TikEdSXOF01fnPwdPlZcyxYEmB7F4BJF3+3UI4oX5JtVyv6VKv52B6efKRPSLrWdXW
         GyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ic9v1IjsOPI+7jh5BDc79ava/4ZSrCkVIWmi3pAd8Ko=;
        b=E7r1jvuQAYJXfiXFkqBn52zv3nTx8COkdPdhXmWoeqU59dPKxY+fS6KFx7myQCliz2
         hFtgWOARylykGocBhJL7FEhhoFW+TSHf/g/Yn/wAs9KVPUNUaGI5flGvGZJEAz7eSU4S
         wyEoOCdw7hy/lSaUC4LqgrUVwKkcWjr5qgA2E0yywwGOREpqueequAsnPkBrSz7jsuWN
         XeFwPDHZaRFkxu5lIO2OAyMnGMIxlJO1rOiMxDS3ZvbEsdEgk+W2lfz0m5tLf7iXgLnI
         xFzgIGIQowzhk/t/fB/AMIr4M1uxUigNf/aM2cHBW+bdnIHF5VJcpQyKr3Kg4z9MvdrP
         sZRg==
X-Gm-Message-State: AFeK/H2z6NI9/Y8i7kITvQOA61MX4gV7ybWbOHCHaVYPa7NK0ZSJ/GvwicQe/RYuFH2y372AOtE/s1gNfR8d4w==
X-Received: by 10.46.81.10 with SMTP id f10mr2678442ljb.136.1491077571121;
 Sat, 01 Apr 2017 13:12:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Sat, 1 Apr 2017 13:12:50 -0700 (PDT)
In-Reply-To: <20170331235947.20010-1-sbeller@google.com>
References: <20170331235947.20010-1-sbeller@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Apr 2017 22:12:50 +0200
Message-ID: <CAP8UFD0Z7CRxbeKaJiks=uvGYsiYcXHMVHbCxzH7-A2+7Qf=Bg@mail.gmail.com>
Subject: Re: [RFC PATCH] git-news: obtain latest news for your favorite VCS
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 1:59 AM, Stefan Beller <sbeller@google.com> wrote:

[...]

> diff --git a/git-news.sh b/git-news.sh
> new file mode 100755
> index 0000000000..1707dc633e
> --- /dev/null
> +++ b/git-news.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +#
> +
> +/usr/bin/sensible-browser https://git.github.io/rev_news/

Thanks for this entertaining patch :-)
