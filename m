Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D801F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbeB1S4K (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:56:10 -0500
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34138 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeB1S4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:56:08 -0500
Received: by mail-yb0-f179.google.com with SMTP id e3-v6so1224476ybk.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O/v/W+LYmZIOUZ24k07ir4ctZb6/HSqeaGIV4Cydg2M=;
        b=v1hHe6f00bIguKnT+j243AidsJtbtIL36NyLqyC0XH/SwIivXptQ93Hb4C6zgoxSJ7
         Gc9bl9fw0qPRsGCXWwvkB9F5pXEwU3n9c82ogWeOY0oIzOUDwXdnpDTW4IwMKGaG5WKC
         5cI/cj9hrYFmd93CZH/on3b9Ro48PmekFWSa1kbcnYMkvn9RtHdt0FWwghU9wV2cmfWk
         iqX6/zZYe0yNCCw3I9O/rRUdeKQGxyMS0FroIJuYPN3EDJhoxRkL8mdIGQNkFMgeGock
         bNg/Pch6UpzlTSLABuO8PgRln9DZ+Dpt2lXNLrqvGW3gEe9Nx/f5SDDqbdhvyNest+Fk
         TAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O/v/W+LYmZIOUZ24k07ir4ctZb6/HSqeaGIV4Cydg2M=;
        b=IAeNZCEiqMRh+PAS9HkIwGr8sptRmkLUCdP7Ic2bdwdDw9RgE9ckX0w/QLJV6GKaqe
         y8+gesm/rDA2Z8nG47Dohma7yjTNu6Tn4VzQ8d4GUe65rwRKQdK4FDtrhUkKanHKE1iZ
         xjf7IME1iHBIgS24MaKdikhVfUXgYbrDHKgm2G09xhZhof7mvmvenm67jrkdEMCqRYaT
         ud0H0187lpPQRc/JASGcM4kJY1y4iLlRH1uu0ZG6WMj0f7Xpkf+hpOJo4bOPtNS946AP
         WR3/36NIVQgU9fPFzTgjhW6ijK8ejJ//wxq1Qbg+c4yAWsDZVHa4ezezHYDVmOknM+B5
         O0rQ==
X-Gm-Message-State: APf1xPBw5uBrfwVDhkWl53G7Q4fRwTP3stmQR5peoOX09XKbyVnbn0fE
        fGP+bKkxEPimzAH4qMRTj6i+xqjY2GeRscVutCpY4Q==
X-Google-Smtp-Source: AG47ELs6qN09+CV5eIyYO8XI4W5bzMyQTGgZBoLxF6L9xrSsEj+CNf/1fcTHaRAgDfGOtccUfd5GQB45i5/j/PKajQA=
X-Received: by 2002:a25:d9d6:: with SMTP id q205-v6mr12489995ybg.515.1519844167888;
 Wed, 28 Feb 2018 10:56:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 28 Feb 2018 10:56:07
 -0800 (PST)
In-Reply-To: <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
References: <20180228010608.215505-1-sbeller@google.com> <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Feb 2018 10:56:07 -0800
Message-ID: <CAGZ79kaDVrn6Qw_xsdyBST6XfJMXs43qDWx8jY2J9VsXwDKm5Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 9:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This applies on top of origin/sb/object-store and is the continuation of
>> that series, adding the repository as a context argument to functions.
>
> Wait a minute.  Is that topic ever shown to work well together with
> other topics in flight and are now ready to be built upon?  I had an
> impression that it is just starting to get serious reviews.

And I had the impression the serious reviews were done and fine;
the only issue would be demonstrating its working fine with other
series, where I was also worrying about conflicts with
brians series. And to address that, I'd just send series in small sizes.

> Sorry, but I am behind ;-)

Is there anything that a contributor can help with that eases
refactoring series in flight?

Personally I find these refactorings not as rewarding as new
features or fixing bugs, and additionally the risk of conflict
rises, whereby the maintainer is likely to push back to the contributor
to "please rebase", and rebasing with just textual conflicts is also
not rewarding.

Is there anything process wise that we can do to make refactoring
easier for contributors?

Sorry for the miscommunication, though,

Thanks,
Stefan
