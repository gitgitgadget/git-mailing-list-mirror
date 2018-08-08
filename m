Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19AC2208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeHHMKU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 08:10:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46691 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHMKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 08:10:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id e23-v6so1078230ywe.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 02:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcvtNNIr2pFlKQoyJttUI3bBlItIDtNHAbNWBGzmdJc=;
        b=G8P2bly8E909qUcWj+L2WzIX0mmn/0YRwkpWZv/+gUovjYrp9mUFA/jebIVIN2p16e
         tbuOxqRxptllpo8iWNGwEOb4/r9cCj7+HwFBHC59StkTdDw/AEFUlTAW1ZeBz8OYNTug
         0ATDiZB2ek/bSXgNJ5SaPtZSRokv3UXJYcFNZe8t6mx7dVC7QmYKW7T4UTxnkG0XCtpD
         Uw7vS3XXJgDvp433noPwRzcJcY9e0+X6FIZr3+a0yTJcTpzZDxZLqX+u/SO9mLKYhj7n
         HYyzDr5QTiXzGZShOcFc+TMM6NVJ8r/KW44SJsMGDNmyW7ROp5bcdnqEZBPRFFYotUGa
         Mwqg==
X-Gm-Message-State: AOUpUlHe5hYOKIfDqFZGOeQUz0s8oL5vqqxLbh4cJJhV0UUjYIJYDs0G
        1Ka1RiDdiZxX3tNy0GEeJq81r5l5cnTJ6wXjq98=
X-Google-Smtp-Source: AA+uWPzMLwakFBytvJxXpwaxcJnfU3X8gnycp+Jm/JD27oKyM5KSWQJ6qlAoYLsSryAqx4xTKXyzC0+LssQqBqK+QNI=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr938491ybq.295.1533721883955;
 Wed, 08 Aug 2018 02:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com> <20180807093452.22524-1-phillip.wood@talktalk.net>
In-Reply-To: <20180807093452.22524-1-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 05:51:13 -0400
Message-ID: <CAPig+cSyaxXv=a1s3nM2nGYj9D09iqgsfPD02o9cjEeWXFhR-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fix author-script quoting
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> I've updated these based on Eric's suggestions, hopefully they're good
> to go now. Thanks Eric for you help.

Thanks, I left a few comments on patch 2/2. Aside from the '>' vs.
'>=' issue (over which I lost more than a few minutes cogitating), I
don't think there are any blockers this time around.

There are 2 or 3 things which can be done as follow-ups (indeed, even
the '>' vs. '>=' could be so), but I don't think any of them are so
critical that they need to be part of this series (for instance, the
strbuf leak in the error path has been around for some time, and can
be fixed later).
