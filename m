Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97F9200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeEGBts (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:49:48 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:39822 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeEGBtr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:49:47 -0400
Received: by mail-qt0-f179.google.com with SMTP id f1-v6so34371986qtj.6
        for <git@vger.kernel.org>; Sun, 06 May 2018 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KYlI4MLk0/hIwbW2HHFXXLfwhAA/AepxjrHF8QHGCik=;
        b=M4sbdy3AmVIlt3DkJm/whCYJZsIwW8xwnH1DSTrFwhFlIjLMa9iPOdH7AnMHLnLAvA
         0iu6SdCGwekeMQzvsEljCxECpjtucbzSRJ6ycZNwnp7jeSJVGKkq6LyelIlZARUIMkXX
         vbZIukSMYjisl+219/i3A26JlkIs1ncJZ4/YNIS/W8QyRhD4VF+2JlySZsV7zs7+vvxy
         KLJW/7HKIaQ06b9Xwjh1fyY+Q8qaQX6ZjxZTJ0RRN7vQx/6NoVNdfHGBQr852VvZYtY9
         x/ba1J2vkeYe5vRUBKoFMyjOE2KhuMKFHS0Yje33Umf5ixM3uaASADK4axfGT8tgUouv
         mXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KYlI4MLk0/hIwbW2HHFXXLfwhAA/AepxjrHF8QHGCik=;
        b=imZZHcaGUxZmx47gik4jIkuFSi/I22F6suM2XmH+xCjyVoRb1ajtSQcY7xUhCfNR0m
         8d8DnT4MwGeu7YlVqztY3KlQzj3yiFEOqxOd/+VK4XgCBmcToa8r+tN8ZBSi0eRSpba8
         F06p0nihfRDC7n6TkKhHw+yCG0ReZ6wkN2rpLOC/5DbgVyPc1d/QgEHf9I6iuinTxrn7
         mKxd0eB0GRHEDedGMiu4WOjjM2HZEOQ7hhoSwPF9LTQlyAf48TLEGXoA9Cclb7aaPVbC
         od6MHuWvixFQh8sPS15uYVJM5HT5el8CHteYc3Y/DfrJDBcuxYY24CUZ8hyiTVZqTmZP
         UhAw==
X-Gm-Message-State: ALQs6tBb0BKuJf9wKFpLh9YzdLgMid707Rmjzoi72Y6jEaG71Mky1iu7
        ktoVWFLhOqF0K1FJsCA2a4kNACBIisGWK3H/Rzc=
X-Google-Smtp-Source: AB8JxZobhg2Uws+1HWO0wTo5O1rSXexmh3hzdj/9wyqzwlb3zSOu9kHpI+CctdFrMfcBXHAlHH5kwhBWTNNQY3UFc0I=
X-Received: by 2002:a0c:b7af:: with SMTP id l47-v6mr16326324qve.110.1525657786301;
 Sun, 06 May 2018 18:49:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 6 May 2018 18:49:45 -0700 (PDT)
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 May 2018 21:49:45 -0400
X-Google-Sender-Auth: -FLAIgFFgCqw_GDBwKKbNZO4P5w
Message-ID: <CAPig+cQnsdcYQnDB_bvn1p9wc9wTVAPAGZKn6_JHqnRtfAXaUA@mail.gmail.com>
Subject: Re: [PATCH 00/28] Hash-independent tests (part 2)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This series introduces an SHA1 prerequisite which checks if the hash in
> use is SHA-1, and can be used to skip the test if it is not.
> Additionally, because NewHash will be 256-bit, I introduced aliases for
> the test constants $_x40 and $_z40 which will be less confusing when the
> hash isn't 40 hex characters long.  I opted to leave the old names in
> place for the moment to prevent any potential conflicts with other
> series and will clean up any stragglers later.
>
> Several tests are skipped because of SHA-1-specific dependencies: some
> of these are core tests which test basic expected hash values, some
> depend on colliding short names, and some depend on specially named
> object (the pack tests).

Was I wrong to expect this series to annotate[1] tests

    t3404 "short SHA-1 setup"
    t3404 "short SHA-1 collide"

with the SHA1 prerequisite?

[1]: https://public-inbox.org/git/CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com/T/#m7bb98bd57a3189bb5fe01993b22b0c480a601259
