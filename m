Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E641F424
	for <e@80x24.org>; Thu, 21 Dec 2017 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbdLUQVs (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 11:21:48 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:40755 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdLUQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 11:21:47 -0500
Received: by mail-pl0-f42.google.com with SMTP id 62so9778070pld.7
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2aOD6BG1cGZ88aw/MW2jnF6XCy5BhQKjNjvGT1pN9Y0=;
        b=SdxwGqDytFHEFHc88zK7cPs1b0kB+iM39Gao1uxHJMNxhBjnl/M5o0lZpOcUwL5f5Q
         AQ3irM9JBonBEbjki7KmcNJgLM8zF8srNrCln1o1bZ5WScsUFNBavkC1Agr0nzmDfDsw
         lRQ4WSM8SHwLC4T/fVhhkjmG20W0Bg84xVr/ey8rKX0QFhXbf2brqnLRYkiG0Xikt6gs
         7MNOvKzgaaKoz+duiK1CQSYACJ5aMlH5xCWmn0ukag0cHTynjNuGLXGizE6PW2UamiKU
         Sn9k+cvIUkHxCZYgOqsV+4LCwEqUZFZXEyrJaXJN/OSdnhiYt7GeQf4UHlo1rkmkgFIN
         G1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2aOD6BG1cGZ88aw/MW2jnF6XCy5BhQKjNjvGT1pN9Y0=;
        b=G/0g74grtf61DfuM6fO9vpTv79F8GKxoIJnYvoUVsI9ReMaKTN1RvJalXZU9/PQCOz
         YV5knvD2VONe9TSkyrPpC7l4VJ+QRsiWVhcWoJY27b0eOdygNhdu3DY1Fwg1+V0CTt+K
         qp93raqoHPHoKcz8mGv8TgXT20BvV5SoHEBdegu2vX5qV9ODj1YchJ8jFojFBWymRH+J
         Zaamiuui5VLOBuyHHZuom3IuE2utozlEZRHcu/BprvHdccba1czE+f0xQJUFYqR/nqQo
         FFRwzCmZzJ25BhBAfAsEFB0TETxs/YlT3mrzEr2VRfZeGOMOXC4R3JgReXVTehTien3E
         LqAQ==
X-Gm-Message-State: AKGB3mLUNkg2R5FF1DIt4VpzhPGP1V6KyQPHYNq6ehWo+8P0b+K+mL6t
        83pAyckz4fZC9Gd6RiRMoknQEh84Xj4pjb31UjG0AdOf
X-Google-Smtp-Source: ACJfBoswT+0wrUl5U/+/oecPmis9tHAg3xiK3NVSqEAePaCJPeeUhndImZik7dIhTbZ7Gp8Jpll2Ty2eIwAHGzQgAm8=
X-Received: by 10.84.229.5 with SMTP id b5mr11222080plk.405.1513873306476;
 Thu, 21 Dec 2017 08:21:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.129.8 with HTTP; Thu, 21 Dec 2017 08:21:26 -0800 (PST)
In-Reply-To: <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
 <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com> <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
From:   Andreas Urke <arurke@gmail.com>
Date:   Thu, 21 Dec 2017 17:21:26 +0100
Message-ID: <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I am entering into undefined behavior territory with the renaming
then there might not be any point to pursue this further, but in any
case, script below:

Apologies up-front for the verbosity, there are probably a lot of
unnecessary steps and git shortcuts missed - I just wanted it to
exactly match my scenario. Note that it is divided into two parts as
it requires you to edit .gitmodules.

Part 1:

cd ~/
# Make sub repos and add a commit to each
mkdir super && cd super
mkdir sub1 && mkdir sub2
cd sub1
git init && touch first && git add . && git commit -m "first"
cd ../sub2
git init && touch first && git add . && git commit -m "first"
cd ..

# Make super repo, add subrepos, and commit
git init
git submodule add ./sub1
git submodule add ./sub2
git add .
git commit -m "first"

# Edit .gitmodules, change sub2 name and path to sub2_newname:
# $ cat .gitmodules
# [submodule "sub1"]
# path = sub1
# url = ./sub1
# [submodule "sub2_newname"]
# path = sub2
# url = ./sub2_newname

Part 2:

cd ~/
# Sync submodule after we edited .gitmodules
cd super
git submodule sync

# Commit in subrepos and commit this to superrepo
cd sub1
touch second && git add . && git commit -m "second"
cd ../sub2
touch second && git add . && git commit -m "second"
cd ..
git add .
git commit -m "second"

# Commit in subrepos and commit this to superrepo
cd sub1
touch third && git add . && git commit -m "third"
cd ../sub2
touch third && git add . && git commit -m "third"
cd ..
git add .
git commit -m "third"

git checkout HEAD^
git status
git submodule update
git status # Observe only sub1 repo was updated

On 20 December 2017 at 18:54, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Dec 20, 2017 at 12:22 AM, Andreas Urke <arurke@gmail.com> wrote:
>> Thanks for looking into this.
>>
>> I was able to reproduce it from scratch, but I followed my earlier
>> workflow where I first created the subrepos, and then later renamed
>> it. At the time I was not able to find any command to rename without
>> changing the path (and I was not able find one now either, is there
>> any?), so I edited name and path in .gitmodules and ran git submodule
>> sync. Am I asking for trouble doing it that way?
>
> "rename without changing the path" sounds like a red flag to me,
> as the submodule name was introduced specifically to be a constant
> as the path may change, whereas the name ought to never change.
>
>
>
>
>>
>> Let me know if you need the exact steps I followed.
>
> Well yes, ideally as a shell script (or even embedded into our test suite).
