Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B40C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJKB2d (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 21:28:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42901 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKB2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 21:28:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so5778249edd.9
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJcVIRvHSeAiF06CBc5mRXPHVVbdiTGokASTrsZxNY4=;
        b=bTXuUX+r+fOlVxchocJpYUYN+vKzIRgOoiIu/O0IaxSKh264uduX8859s8rdLuljZ9
         T8HJjxhmxD8RNQxi3tEjqd7N/XaBSpqDMb92IXESQcrvdKKQo8SJJJ0UM+eDNYrhg/Wb
         GWEQ4npbAKiFTtyyJIwtVYsqn/RqUQN6/wuKWvGNs3zhKRJiMmHfcsKtjwz6wsnSyQpj
         vgCWi8oSDMC2b/KNXhUDa3nFJWDVWTpdA+HxW80j1LWJh1WdUl/X6z//nTt8nXCgu3E2
         zRIGexuohIrOyaCV2Kqb+EISP30wY2WX9/zoaPcjB3tCFCF+QWBbOUUjerqksIstt6pE
         e4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJcVIRvHSeAiF06CBc5mRXPHVVbdiTGokASTrsZxNY4=;
        b=ZxS7XF7U3I/5whJQH4B3qssd98ili7FawkSThaJE3Qxgii9q4nRB0ereE0kuoLNBz/
         4nWUYszazceC9dfY0XYyxDBxT0zMR6rDe6GuRwJgVYEySeloSUDcA906lKE8+RYmBR3I
         qMKUnyfJ/ltPIjckS9g1UW4F9OT8b1jhkrrYy5eytulfC9jFut9GGY5nl+rPP3EpV5zv
         nHBMO3TVbhJdgefOI3u5hEgk8TXfrfPswpxSodX3BtWS0EKEQnl4WpLGRXoSz2uAfv/M
         4PR1QCuz4cIMTqjAb0I5HXcMmiy0NlWPA46Q7Y/uUcVS3DzyCONjxnH5OkXec8FRwIgS
         T3WA==
X-Gm-Message-State: ABuFfohuFrZA02mU26nZjMwX8ce6IDiKA515vxbPIBV5IlxeSGTU3Kwz
        57vjDQq0HEZWFg3jDgsUDOt30uLg/iPAh+1YpAJCdQ==
X-Google-Smtp-Source: ACcGV62peByTA2QtxVtOf0ovgQsVxGurufSCRa0xAv7iWlB6UBXtsic6Beaxkaum+jqmuyUst/wI1q7TuHgsjbCmjvI=
X-Received: by 2002:a17:906:9a1:: with SMTP id q1-v6mr13122367eje.126.1539194715232;
 Wed, 10 Oct 2018 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20180924100604.32208-4-phillip.wood@talktalk.net> <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
 <b3d29d34-616d-5d12-bb86-19ea488a766d@talktalk.net> <CAGZ79kYjeqME-tt89Fp=Wt0hAW0FVAyZ00ftN5XTOkFSn7Kq9A@mail.gmail.com>
 <fb500556-adb0-fbd8-0119-443455915eab@talktalk.net>
In-Reply-To: <fb500556-adb0-fbd8-0119-443455915eab@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 11:05:04 -0700
Message-ID: <CAGZ79kYeKer_yYxRkRugWVjvwrYk7dT4EO3NyVJkqR3j_XCdRw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] diff: add --color-moved-ws=allow-mixed-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 8:26 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> On 09/10/2018 22:10, Stefan Beller wrote:
> >> As I said above I've more or less come to the view that the correctness
> >> of pythonic indentation is orthogonal to move detection as it affects
> >> all additions, not just those that correspond to moved lines.
> >
> > Makes sense.
>
> Right so are you happy for we to re-roll with a single
> allow-indentation-change mode based on my RFC?

I am happy with that.
