Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABD71F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeHOTVY (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:21:24 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36098 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOTVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:21:24 -0400
Received: by mail-it0-f47.google.com with SMTP id p81-v6so2707526itp.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/7HPTJuDjws3C4+krzAi94rHcfwvMmLf/tJhpxX0b4g=;
        b=K1PbbJvE+2OjxK1aLZ2nGYQktVJH34Jq3HN99Z7jhFqPeQqx4Owpgr9qo/H/Hc/BeX
         2G9BjKcLRUBGdMR/810O66xLk1LuoQypNtaLXWfzz0TqpGRPzGYf8VbVIpv2IopFABj9
         IqppxTv6JkoMkLSOnUTQdmCv43gmwHwuQ9b1NpgCYdQKUvJHKdhCJ3g7pefXvUjiKQfY
         YI6ESIFnnbqKwYSYaZEwEAwDmDz/Q1fbxSGoR+fAEqY3wWS97N+UYlYsaHoaWA7ICUAu
         C9o8kpoJJSeijfqlKa07rNzo01k1hwqpj9/h6KVWDAqdmyXbKA/anAjlwKcY8+Sj3vK7
         jEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/7HPTJuDjws3C4+krzAi94rHcfwvMmLf/tJhpxX0b4g=;
        b=DBzS8dYSPiCKq8aqjhzuHUz8zI1It2NFd6fMitqwXP/qZ/AqocHKjASlBnSC1aHGUY
         T5jOXanicM59FpBrOIERtyL6p15be7bBGJPu6CZKhjVpjt9armj4FMQLm4DVpvd8aDfI
         dXJwVTER/whHSY9xapcAjsfEF+9EgObHZEz7f2qBxnq7LqIHe46Mrh9nNQhtaQW0aEW9
         k+uPkkroHMvMSkBfFH9utZTXa0g7coWu795OX7458GcfAEng7DafN6qA9gD4TvBkGlFU
         Swu2/BpNfanzDG0QzoL9c/LI3VVbPuOEkQue6i5voRrSWw1EfHBVp8kC/4MhaCXzT54W
         BKlg==
X-Gm-Message-State: AOUpUlE15IoClVC1WKpmcmMHCwzjgjfQGqF0Af/ZgAGdRCjLdpyFXweJ
        oufOmAW7d8Oll3loGsiv1LxzmAhA1jZnIo9tfOo=
X-Google-Smtp-Source: AA+uWPzU8ooVLRzowS1+yfKrJx/U4+ieOaIcpdoj9fwB5Kr2zb6y1H08XyFVlUY9a275SGbP4+LLbZHlH5KvkEJHei4=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr22356352jad.94.1534350515041;
 Wed, 15 Aug 2018 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net> <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net> <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
In-Reply-To: <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 18:28:08 +0200
Message-ID: <CACsJy8DYYL5cNSo4ibWNmiexdWkhob1QTqFxJz56dSu8NdDViA@mail.gmail.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit planning)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 7:43 PM Derrick Stolee <stolee@gmail.com> wrote:
> 2. Number of other commit tag-lines (Reviewed-By, Helped-By,
> Reported-By, etc.).
>
>      Using git repo:
>
>      $ git log --since=3D2018-01-01 junio/next|grep by:|grep -v
> Signed-off-by:|sort|uniq -c|sort -nr|head -n 20
>
>       66     Reviewed-by: Stefan Beller <sbeller@google.com>
>       22     Reviewed-by: Jeff King <peff@peff.net>
>       19     Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>       12     Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>       11     Helped-by: Junio C Hamano <gitster@pobox.com>
>        9     Helped-by: Jeff King <peff@peff.net>
>        8     Reviewed-by: Elijah Newren <newren@gmail.com>
>        7     Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>        7     Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        7     Acked-by: Brandon Williams <bmwill@google.com>
>        6     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>        6     Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        5     Mentored-by: Christian Couder <christian.couder@gmail.com>
>        5     Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        4     Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>        4     Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de=
>
>        4     Helped-by: Stefan Beller <sbeller@google.com>
>        4     Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>        3     Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>
>        3     Reviewed-by: Lars Schneider <larsxschneider@gmail.com>
>
>      (There does not appear to be enough density here to make a useful
> metric.)

If your database keeps mail relationship (e.g. what mail is replied to
what according to In-Reply-To header) then look for mail replies to
patches. I think we have a rough picture who are active reviewers with
that.
--=20
Duy
