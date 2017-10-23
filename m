Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B271202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbdJWR6Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:58:25 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:52663 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbdJWR6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:58:23 -0400
Received: by mail-qt0-f175.google.com with SMTP id 31so27219494qtz.9
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SMUEnU22IT8GOPZxXPto8/EBzCwuchQeCdEY9q3EOS0=;
        b=GLQj2kV3UcKgkP6WkuFLh7HGiyK4QFFyHmD7LIcBQD9KaeZu0/BocM3dmy1svR4EAp
         csezUnA2kWC4xlrtqlsncEykiUZa9wY4UmW9Bm8EBr/bA8GRcTAaKjrzLUV0Rm9Zf9K5
         dA9uGG4tnJSYN2Txio3cP1eL3TWk93u13emtA97DVsZ4cgi4gobd/szcXaNitxhjW5wR
         GtnH9DZVbmWb/dSbEhNZcFN/IyAzNkd0O0QKufjmoTd+jhl/Ph2vjU0HX2++3qncbUSW
         8g+/2uNkoMJtj6XCM9xPmPR+Pwl1ZpPu1WMx78LzmEG7d4Seo/BCPXMNdXTw2v7mpXjw
         PHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SMUEnU22IT8GOPZxXPto8/EBzCwuchQeCdEY9q3EOS0=;
        b=Q0El8XSBfrg23erSuHUvp5l5B3KRPBIeLfCnbksxwztyQmYuG69uHpeT4OKhvxXu9J
         W5Yt2cOswaZcS9jg5sKuqT6uLfa6soiClH0L5UILn203Km5vSIIFL8z+umaqrCmvRS+l
         2FKIk/FVFYd3LsWLgVaS71zUB19rukqJw5H2axFVoWStwsNdTx7TW8kz2KnObPBLBQDT
         ns293jvly5cXSD/dCn9JkygHbNxmN4K3ZP1CyaRU5k7M2OFtssVuQMs2DK7bA5BQE0yw
         Drx2TpSu6hpDVxNB1lzLSa8oKBhv+g1ekdPHQZW0ATw2eM+Q4Hgg8/YedGAuTeNS5MO1
         rzHQ==
X-Gm-Message-State: AMCzsaVxyu8vi83hVwqgOYYpzC8gw3SWAQWemyhAQaExzt1rNyTyiys/
        cAxBVlddLrXwrwSW0nZ2j7cCzH7oTIb4hfw1Of/gGg==
X-Google-Smtp-Source: ABhQp+RU5iY0m5CX6mxXIR+h7uT6SeEIOKrd5TwKRl/sofp9wsHD3Fj0VYUlO1Bgoly3qRDc6RHOq1wxiyUq2+jTHj4=
X-Received: by 10.200.47.77 with SMTP id k13mr20356303qta.298.1508781502352;
 Mon, 23 Oct 2017 10:58:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 10:58:21 -0700 (PDT)
In-Reply-To: <20171023141644.GC85043@book.hvoigt.net>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com> <20171019181109.27792-1-sbeller@google.com>
 <20171023141644.GC85043@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 10:58:21 -0700
Message-ID: <CAGZ79kaFcPUUx0+tCnBzpssaN0c09eqjiDSbCTWLAVayaw1FOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5526: check for name/path collision in submodule fetch
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +             git add submodule &&
>
> A small note even though this is not meant for inclusion: This would
> break when I start working on teaching 'git add' to set default values
> in .gitmodules when available.

Yes. I should have used something like:

    git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub

as that is the real plumbing command to change a gitlink.

>
> But I guess I will discover a few other places, when starting that, that
> will break in the tests anyway.

Yes, I have the same suspicion. Thanks for reminding
me to use more plumbing!

Stefan
