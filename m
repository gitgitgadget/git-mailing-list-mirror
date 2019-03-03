Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1832A20248
	for <e@80x24.org>; Sun,  3 Mar 2019 10:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfCCKR3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 05:17:29 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:39137 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 05:17:29 -0500
Received: by mail-it1-f169.google.com with SMTP id l15so3381769iti.4
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnFpOhNP1swTlVv93FUuC/fH+rTS3KzaKOK1W1xa5sA=;
        b=DLehLN19ggK9NvGFL7LNJKJkMmrR9QXuI33NoO2P9V9gYir1emIiZv9BMgPNZqV4m6
         pVx2odTGX06dt6ndjkXprjNqxUZDphMPAyOoYLqL4sMrzwsVW1zVBMjpIIzBgLwwr8RM
         pYgniBxgbjJyE+uQ5QHkou0Q/orqxya/n5d1AUWO8HMyKfcjwnP93XhGpOdppDta7sVO
         Ff7RU4/cZ2z6dbDr9b75Z2oBPcOrN3mJRIKs+kqqj8TRcclGEwRBiK8A7HXrmdRBv/cZ
         VSFAZ2370EbOZJ+clktnJc+1PooovJSO/2109i8BdHe9/A5DKzq+2wHfe3DS+36UDlRf
         CzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnFpOhNP1swTlVv93FUuC/fH+rTS3KzaKOK1W1xa5sA=;
        b=jj3B/5oGh6V0mbsbpcubnIbK6MqTNrYVEcABz7fBilhhIAmREbkM4l1MI/57ESbV4c
         qIurGrz3S6pY22N4RkJXUcY5O2LY9urjjbN5E8bJfJSpyAGUKb+dM/3ob+VROkHHXaq7
         6DTwjPjoqN0b6Fn4zq1h51MzWc/P40E3WI1YoM8b88Lj9H7CgwSywknEctuE9uikT2Wo
         +O8Y5rL0oUox38pW0szCfE3JXXrQUECAwwzad/pk5fWBRx99Hznsb6oYrsOBgrWWA6ko
         T5ZxwEMOijDh91DAP1EXeNwJEZJxGS7aaHrE7qHw3JRnU62cimGLK7mBGhINL6aJKOWj
         9W+Q==
X-Gm-Message-State: AHQUAubz1ys4pL1ryP8B6J2Dj3CkTvD002naQClFjE/mwEb569BC9PlS
        nitMMNQoFPVIpBBYw4aLavd6KLRO9RZm6/aY2FxDQw==
X-Google-Smtp-Source: APXvYqysmeGz4+JxXs7N+EVvxfXkskQOonhbQOcmBwVXqJCjTihkdRzJ18lzUl8tgmEzpwyB2Q8+b3ilysAQsNzBJzk=
X-Received: by 2002:a24:7542:: with SMTP id y63mr7929820itc.70.1551608248631;
 Sun, 03 Mar 2019 02:17:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
In-Reply-To: <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Mar 2019 17:17:02 +0700
Message-ID: <CACsJy8A2e3e9JAAN8==PHxjO-5xki2NWLPb6vrFvCr8NLKmHyA@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 5:12 PM Duy Nguyen <pclouds@gmail.com> wrote:
> This is a good point. My guess is the pack access consists of two
> parts: deflate zlib, resolve delta objects (which is just another form

s/deflate/inflate/ (i keep making this mistake)
-- 
Duy
