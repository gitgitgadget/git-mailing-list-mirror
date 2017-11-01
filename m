Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26857202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdKAWbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:31:44 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:53864 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdKAWbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:31:43 -0400
Received: by mail-qk0-f173.google.com with SMTP id y23so4610517qkb.10
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mq0/PL45PF7oFJlVNGlpuZGPLy5AHomsHeZ4a+Td5VI=;
        b=MSqrd4pOiE11xmfyB5+sfeP5mvzGtt1La73sZxThpXmyh6/2wqKg4z3SRPO5N2XUUf
         QvWXmGPaIZjK/KA3B+g1edgs5lfQWcsdmtjVmel2MeIASKcOBpbG8OxRqvJtTKh6dLPo
         fD5NgH2MwNLx4FqRpuNHvELSjBLrqU802G3HB7Tz8RXcroeomyuDRcq+/T6vzoRePYA9
         rCfjWuaPKUbkg1NqUq/itdrTRCUn2DosWvGyce6dw30CUmFRICeX2fN6SNsXeBYW3o6U
         /Pwzd23tfwl3Zrhm0+4WEhwiS+vHLfZnRVqrc+q75I3od9EI8Aiwwl0HXajclxkdq5kz
         lS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mq0/PL45PF7oFJlVNGlpuZGPLy5AHomsHeZ4a+Td5VI=;
        b=J7Tf+FxPQGxwUssPf9afWu7Qpvaql6QJo4anKzQPEOHx0e9NxEgbN8grh92yYOLsKC
         tYAfdtXJbKC4qrUPp3VBh2yeTXRsiBSdIEyF6DHn7o80OhQA5z5I/cs2sUgI9UvDdtCM
         SBaLKZJtxqixtXMlbPiZJqbtZOJhuuUN5nkbbhyo9mwUXUEs6bUwhLfwBJ7aKiYKjp7K
         EZo7jpSryGeWveI9HJ+x4ssxvnOahE+bXHnqWD8YpykHuUzjDr3HOXWw5xSiCY/hEFdK
         mIEvvrLaqGDfhGxOcusl58ecRsHd/QyfeqJ1B4nOjJ5KXhrkrODqaLrHfziPRVdUkwM8
         dk9Q==
X-Gm-Message-State: AMCzsaWJLqKPu3lFQsJW3jCPF8J1PBIUEz3qHFbjf3oHdcf3YqtYj3q9
        RfaUUmX4vZ5P1sbLtLL/uS4pZ/jgPzfhp8mejhhqRg==
X-Google-Smtp-Source: ABhQp+TmfNlumx7ZmQr7pP9wcyso55Y6vLDfqaGRPTrPVdRflvMuHSuazdfICseo2q7RqmysQrzEmqF5PJFUTlAvcH8=
X-Received: by 10.55.125.196 with SMTP id y187mr2315696qkc.180.1509575502792;
 Wed, 01 Nov 2017 15:31:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 15:31:42 -0700 (PDT)
In-Reply-To: <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
 <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net> <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 15:31:42 -0700
Message-ID: <CAGZ79kYghF6=AzL1N96fe2zixHCERXu=RpxHw2-kdUrU+j4CXw@mail.gmail.com>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create Git/Packet.pm]
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 9:42 AM, Stefan Beller <sbeller@google.com> wrote:

>> So it may make more sense just to cross-reference those merges with the
>> topics that spawned them on the mailing list. I.e., instead of copying
>> the cover letter contents, just record the message-id (and update it
>> whenever a new iteration of a topic is picked up via "git am"). That
>> lets you get the cover letter information _and_ see any discussion
>> or review around the patch.
>
> That sounds good.
>

Actually I just found out about `am.messageId`, which adds the individual
message id as a footer. Maybe that is good enough? (Though it would
clutter every commit, not just the merge commits)
