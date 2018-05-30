Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3589A1F42D
	for <e@80x24.org>; Wed, 30 May 2018 20:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeE3Uoz (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 16:44:55 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33554 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeE3Uoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 16:44:55 -0400
Received: by mail-qk0-f195.google.com with SMTP id h7-v6so8377856qkm.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t6OW5jdbyV3SXVjkfIT+bkFIq3tGwOC8zMzWT5Fw4jE=;
        b=K/JG0GPiDLWy1qoc5qWjGhuHOf7A8RylcIDT7JuezkuNkSnijGpOagIg2wIez0mv3m
         ARvQlwEfmeTWNOIWGoSVgjKPF19UhnWZ5dfoDx6HX/CP5skGDY7KOWM8btNG8+Ms1fDJ
         nX9G4kgCvlssx33kemvJ429fBhWnLZoVAtK04kMEkRF+ZLzjzADkha+mzftnmq/uRjmb
         wbJmsWWIFDs1XuLl4og9Awr0afKVqMRjc1qv7WSQSNcwrRCLOkdP7AXVcY8Vgh0ICCzb
         yc4CoGKOlgzjJRxa3LYaJNDNIY2WUS+aISskNeuzapgci24jEo9ZEINKF+ycKHYpD3eY
         3lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t6OW5jdbyV3SXVjkfIT+bkFIq3tGwOC8zMzWT5Fw4jE=;
        b=uXYNu4jmPYMLWj33+AQ09UW+8WfqkQcwmiZnZsqJ0x3PK6eYX0BlSjDAT1G7JThymR
         lnTV3zCO2PT75LlnLuYlUpEtc8DuZ8J0xubF0yYA2dBWVM/Nwt4qWlshsL+T6lle2cih
         wth4EYwf3Ug6KAVss9GGz8cSyj1qH+I3l8Roc3QOCDQFt5p/LPJKkC7nWebjCXKrP+eZ
         6/c9UJPMI1VKB3oXg5o9OR6an9Ny5bA1pSCqUyos5KOeKA+LroIdrt21JwR0mdqBmk7P
         DH9svHFibbQv3oAse6kVnQDkctIXovXAcFNqWXlkgW3p6qUla96HXbWYFkFrVfpelk/6
         GByQ==
X-Gm-Message-State: APt69E2sVph2cgmlzKuQK48f4v3xd4CdQyF9tpqLRChLxa3D5IdttWdX
        4em6OTH079kSjy9s2NHVWNhL9CjZKLVtEgEfZ3M=
X-Google-Smtp-Source: ADUXVKK3N8iEye2X6P45hmL84JFLgkOzm0hFerzqESMHpAdK26SMpVTmPOhbXWIB8nAD6ddasJ7LTFObjNem5uITU3Q=
X-Received: by 2002:a37:6c02:: with SMTP id h2-v6mr3780496qkc.145.1527713094490;
 Wed, 30 May 2018 13:44:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 30 May 2018 13:44:54
 -0700 (PDT)
In-Reply-To: <CAGZ79kZ2MKpjwwx0+ZsPZ9bFu_ersPJ=kKPYWRmWYjJ8yoVhuA@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-5-sunshine@sunshineco.com> <CAGZ79kZ2MKpjwwx0+ZsPZ9bFu_ersPJ=kKPYWRmWYjJ8yoVhuA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 16:44:54 -0400
X-Google-Sender-Auth: akHHe5ELYHf0FsiWW5BwYEfqzIw
Message-ID: <CAPig+cRh02976beGp5c5Sw5=h86VgNZgVreCHh38QKP5udJeGg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] format-patch: teach --range-diff to respect -v/--reroll-count
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 3:03 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 30, 2018 at 1:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The --range-diff option introduces the embedded range-diff generically
>> as "Changes since previous version:", however, we can do better when
>> --reroll-count is specified by emitting "Changes since v{n}:" instead.
>
> A very similar option that I used before finding reroll count is
> --subject-prefix
> I still use that for RFC/WIP tags, but I sometimes used it with "PATCHv2"
> as an argument, too.
>
> Would we want to extend the niceties of this patch to that workflow?

I would not include such functionality directly in this patch, as the
two ideas are only superficially related ("computing the previous
version number by *some* mechanism") but not related in actual
implementation.

Computing the previous version number by consulting --reroll-count, as
done by this patch, is deterministic and was just low-hanging fruit.
What you suggest probably involves heuristics and parsing, thus ought
to be done in its own patch (or patches). It's also the sort of
incremental improvement that can be done later (rather than in this
initial implementation) if someone deems it desirable.

BTW: You can use "git format-patch --rfc" for RFC patches (in fact, I
did so for this series).

> Unrelated to this patch: how does this series cope with range diffs
> that are not in commit-ish but patches on the file system?

I'm not following. Can you provide a concrete example to get me up to speed?
