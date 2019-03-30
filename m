Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A4F20248
	for <e@80x24.org>; Sat, 30 Mar 2019 17:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfC3RQb (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 13:16:31 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36387 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbfC3RQb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 13:16:31 -0400
Received: by mail-vk1-f194.google.com with SMTP id v131so1204829vkd.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ffK4zP9c8zc1Cxc1UvDyF5CWn1oasIWCrM/3FoRJWU=;
        b=bw7A7N9mpKC7J+gZjmXkBK35nSCNZGuVS4TFHAnVY/CimOzXKZp+D7jqPmjvev+Kbe
         fNxWomZgwSYPNX8olY5K4MB560AqH5USg3qgNzajaSj3VvgRDwRsCm2V8JF5/n9ORAJn
         FBa6HbWurgf9mJtuXGwoymAK1telhvR4mNbOowQ9jyKfe+hBBRGW0aSOFOPMdM1pCKT5
         jVNL+8Py3gQaPzjBikQBBJfOFAVO4st2xeUgX1C+ASaORydJi1iLdHzSy2UQa1dX04hP
         /8MeWBqxHczb5TWKTwJ0AOuuKiK+4WjJGvbLAxBwOcQAuWyXNPS76a0D94ohY9sXTRtE
         ZB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ffK4zP9c8zc1Cxc1UvDyF5CWn1oasIWCrM/3FoRJWU=;
        b=p3Ky+mz/ZWYFxnQtd3K6b8V4b1pIC9IwcsHiZfMnLHd9FCSBLCP3OAmzlLbOuJNikX
         1EezAnD0nRq8XM7sFMWYPw54zt4/UUD3e34+6HF6cizlgUNtp0aY10+m2gfEuHBywQif
         ln70PlvocVJBtKjzidnm9LgHlbioei7mQflhNVb1pNNJrDxJuW7doyV3M9Y5iLs2/SgE
         7sz2QxxUXMrBI4WyTDApWr1JkKmK6PckmRSIJ+dqSMKmxtatugKvBbGUqWuT6H5/7rob
         Ccg+mtzBPwPh/4CnQRyZqT5NyvqlNY72zJ7vi/qINZf/rrkTeJdXSSXCl1yem27JMQw9
         JWRQ==
X-Gm-Message-State: APjAAAXyg/HM4E4zKApvJmHxiwmjlM1ipFRafMVRR3psJevdOOKE7OhA
        Qj50XWSHYxl432j0geiRUk5c3TFlVsfdpNyW3D0=
X-Google-Smtp-Source: APXvYqycGesDVCophH9Ah5KTOnONh5dzNf3AiFJFvk8z2R9cseyeo3Q4CPuUICqJ59JwKoViX+4MQ3pW82f42ylTvnU=
X-Received: by 2002:a1f:4ec7:: with SMTP id c190mr1619967vkb.27.1553966190014;
 Sat, 30 Mar 2019 10:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190329223228.4924-1-rohit.ashiwal265@gmail.com> <CAP8UFD3b8wxj=T+HpeFAQNGLghs8fpEvQusP7Wq-BRZb3c50dg@mail.gmail.com>
In-Reply-To: <CAP8UFD3b8wxj=T+HpeFAQNGLghs8fpEvQusP7Wq-BRZb3c50dg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Mar 2019 10:12:26 -0700
Message-ID: <CABPp-BFknrV8ALFTifcZ4-nzqy_yWO=7zdkemzcA2kfrZ+4_9A@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        git <git@vger.kernel.org>, Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, rafa.almas@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 12:16 AM Christian Couder
<christian.couder@gmail.com> wrote:

> > 6. `[Bonus]` If everything goes well and time permits, discuss with the mentor(s)
> > the possibility of deprecating the am backend of rebase. This point is last to
> > work on as it provides no "cosmetic" difference on the user side. Elijah
> > [mentioned][12] the possibility of a "social" problem that might occur which shall
> > be discussed then.
>
> Maybe it would be interesting to see if there is a performance
> difference between the 2 backends.

Yes, it may make sense to repeat
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet/
to verify we're still in a good state, and maybe even try to figure
out why split-index is weird.  However, more important is the handling
of empty commits (both start-empty and become-empty) and trying to
bring some consistency there or at least implementing more options for
the interactive backend and figuring out which empty-handling options
should be the default for which sets of flags.  It's kind of a mess.
