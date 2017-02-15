Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13852013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755420AbdBOXk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:40:58 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37033 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932832AbdBOXk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:40:56 -0500
Received: by mail-it0-f51.google.com with SMTP id x75so6704960itb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ft6GJxol4VVwDl6Q4+qgGrUoYOZQXRdnfdd+1x2E5sI=;
        b=GhQSp8YgxksJ1wCucirPHMgy842QdUqysmL2farf9FvGaYW4AZpLeL6YctGutpVj5w
         5LBuUgzsHIDeyHhE0kNzd5VCiPN/lCjEc3oq3rDTppY88ESAyM53Di3s4i9cQEbAi1iT
         GCqEaI/Zzg5KvVKL0knhuZoAjwF+5z1EXc5maA+eu/oQVYHaJKbsZcP4Mg2nje4vUmPG
         QLTBuqa6tUVzuABPJWjPEzk2W0lwOLW3OIHLB8iUW1reDvgz5RuJVpeCMNnpNWtvK1YQ
         /4Ixrk+8aIIOtFFeDKhoS8mtUyzUHGgQfjr7YUMvy1fdv8smRZgQd92Soj6JzN7XuCcz
         qqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ft6GJxol4VVwDl6Q4+qgGrUoYOZQXRdnfdd+1x2E5sI=;
        b=JfCpoaEiiM4G25PEyxpwsfmR5tVCI4Y5dfENjHFAsP8SPYAwRsakqge+yzmvcdMKvJ
         R/QmIA+mTkRy8vKRy16xRuyzsS2zVa+dBFokDJFj/Cio/eug3i3a0Cyp48SdxOhRcePP
         aSr/63k/wDCCiThBk1LTRM5UH4RgIcyOt7ElY5M5hqZ+Gm7tI8mDqXMfoXQwmwEKF2Wv
         ychucAu5QRorG4RVvjgzagMN7XA0LtAZ2NFVxSvJPrFFjp3M5I857gK7+xpCG3IK4Iba
         +c+54yd3fnTt8uvaBzyAz7yan8WrlDZXYVIZlSq9YLMsTzx1JySCEd/SkaP7LFykW8ev
         owpg==
X-Gm-Message-State: AMke39mFIkRiUkdlSlHp+i84JXSAISZuDQm+E/qt55rCU1dXMGV+3lxk4h0uo5kVdPOBYxkXL7HOtvfI+PMOEMpD
X-Received: by 10.107.3.160 with SMTP id e32mr34092171ioi.52.1487202055439;
 Wed, 15 Feb 2017 15:40:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 15:40:55 -0800 (PST)
In-Reply-To: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
References: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 15:40:55 -0800
Message-ID: <CAGZ79kYyzFwqmjO1kZSS0-ARrnk+mhooCPrP5oHiff_2piwvzQ@mail.gmail.com>
Subject: Re: how are "untracked working tree files" even possible in this case?
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 12:36 PM, G. Sylvie Davies
<sylvie@bit-booster.com> wrote:
> Hi,
>
> I have a script that runs the following sequence of commands within a clone:
>
> -----
> /usr/bin/git rebase --abort (took 148ms)
> /usr/bin/git cherry-pick --abort (took 103ms)

Is there more happening before?

> /usr/bin/git clean -d -f -x (took 2007ms)
> /usr/bin/git reset --hard --quiet

I think the order is important:

    git add <file> # add to the index
    git clean -dfx # <file> is not untracked, hence not removed
    git reset --hard # <file> is untracked now?

So I would expect reset before running clean would fix the problem?
