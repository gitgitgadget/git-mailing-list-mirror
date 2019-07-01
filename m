Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABB11F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfGAVWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:22:20 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42312 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfGAVWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:22:20 -0400
Received: by mail-ed1-f51.google.com with SMTP id z25so25204178edq.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dpmwy1mx4qvUqnkSKkDE0p/D9oPeiQXsQKJI8LNUwwQ=;
        b=OfKlpDwcxJrwRck8JIGg8JFHCzyZHXC5zeKkwZAr585sF43Twg9jGQP9uz1aFuwRVg
         pUFuSmPlZjquITlx0qHJj9Oz5ErSBRWYZpu41zXqAMBELtwV/5bHNDUEYBZl7JvYDxH9
         tM16KFdl0TfDyPtb5k63kCsZaWwsE/qYE4dhE0srNQ/uKBpdsLxWe6cCrKjAW5WnA4rp
         pFloMCOJ5tYUt8X5H9SKpAYL09s1MPlIUr1fFSYC4GdCK20wx5I86in1uooBLZ37L5gW
         cvopWr3wz5K2bKDwC1BObW0kPqqjp8sEspvaq7/Oj+MJyIUyxeRvPbdWIduLDkkoxHvD
         b0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Dpmwy1mx4qvUqnkSKkDE0p/D9oPeiQXsQKJI8LNUwwQ=;
        b=QSq1TgCqhGdw8mXAEucChOoJkOJHBYx97tPM7b9ife5fJCTMVE+QnPbxF6aC9IU/Ti
         EHnNiUd679VuNLGu1S1a3sSzjDgnWxkfPZ2asqQE9Rc+diDMNRHHUFH97smnsvBnZMS8
         LQ1DfsAEAMycRqCtS1JB5Zp/ONGKUk0Dyisv0Drm+14Xxy8Gg5BDIQDBFEYgSXPmedxX
         kBSzj+zkSZ/B5Z8rj8XI2Oqo3mD6zcjGjt3u6zLkutX7DQHGgaVjvIFR3xic2eA3TF3e
         Rf34Co3org/J/a354RZezwItn5GokVY4ML8Ltk3MrYbG3o8FHnhDk2z7tBIgD0eg3HIu
         YfMg==
X-Gm-Message-State: APjAAAV+GokxVUL2QQRWNbodP4hTRLYYdvt36NOXH3vIhoSqGpG4R9JJ
        XNiA5D2Lm9CgOSIsEL8yeoI=
X-Google-Smtp-Source: APXvYqwOehJVqCfMppdo0dW73eklzyaJLvfJlTgwLcc/VboHybZ5qIDY3d1YYoc6nWUUSVLrOKcyGw==
X-Received: by 2002:a50:ba09:: with SMTP id g9mr32136819edc.172.1562016138755;
        Mon, 01 Jul 2019 14:22:18 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id i6sm4127621eda.79.2019.07.01.14.22.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:22:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/no-kwset, was Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet>
Date:   Mon, 01 Jul 2019 23:22:17 +0200
Message-ID: <87tvc578mu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 01 2019, Johannes Schindelin wrote:

> Hi Junio & =C3=86var,
>
> On Fri, 28 Jun 2019, Junio C Hamano wrote:
>
>> * ab/no-kwset (2019-06-28) 9 commits
>>  - grep: use PCRE v2 for optimized fixed-string search
>>  - grep: remove the kwset optimization
>>  - grep: drop support for \0 in --fixed-strings <pattern>
>>  - grep: make the behavior for NUL-byte in patterns sane
>>  - grep tests: move binary pattern tests into their own file
>>  - grep tests: move "grep binary" alongside the rest
>>  - grep: inline the return value of a function call used only once
>>  - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
>>  - log tests: test regex backends in "--encode=3D<enc>" tests
>>
>>  Retire use of kwset library, which is an optimization for looking
>>  for fixed strings, with use of pcre2 JIT.
>>
>>  Will merge to 'next'.
>
> There is still a test failure that I am not sure how =C3=86var wants to
> address:
>
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&vie=
w=3Dms.vss-test-web.build-test-results-tab

CC'd you there, but as a note here: I believe my v3 sent just now fixes
this:
https://public-inbox.org/git/20190701212100.27850-1-avarab@gmail.com/
