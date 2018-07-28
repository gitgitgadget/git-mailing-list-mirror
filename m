Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D261F597
	for <e@80x24.org>; Sat, 28 Jul 2018 12:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeG1Ni3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 09:38:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40560 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeG1Ni3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 09:38:29 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so10950166ita.5
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Zt5fU9BWWoijSPPcOY7tcDm7EklK3jSoCo5RLKultA=;
        b=NyEeibdH7L8yRYv0eagcMpleqJ1mIAuC+il0sHOa4j5BV8vxtZi5el+BNX6JS3Oupp
         ZXI96vxRjohJjEaRNK1B0vKPcDa+uqSUtIsbMj4s2prNreiSOxX8fc6DxYafgUjpuVyZ
         4iVpxvosp88vP/RngiB92oHytQo/qUpdGsFStDZ+hxwQtnIhTUYRV/rgRO9BTYQ0C6Pe
         LHNikvwX9BK1VBt+5VSyK8o7ceg089iEUXBUbLsRu0jfaxsoNQOhDQwf7Xwgbc6F52hh
         2OTsafWuOCJdvBLakq60XyYIJLwCnUZJMksQMnoJn+BvQrigcxIGuSFhyspDoHEiwIAn
         m7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Zt5fU9BWWoijSPPcOY7tcDm7EklK3jSoCo5RLKultA=;
        b=IPRxBKclnPLs9SZuRgTnKqn2ZG1M+hWev/FTM4NHTeXHei6j47AFjsglE7NZrl345Z
         eY5Zt4GlC7qRBZmEao2t87gWaaiSBsw9yxxsm2l49GWlg0ckwh9FTRiVyreNFhEZXjsj
         q4+OMveFThO1JNk6DAU9OTuuEdgsjenqVnQgKM31+1bvaPlCAPpg+FP5QbrAY9g4xEfn
         oS9RE0d0Yiarel3pwHjaMqF6p/Xx1hzoOEktpWfzXbtryD/6QkNJmu5609HkH3L+Ec/d
         5l+pmLRk9TNP7aU6NuWlZmU4rZkXTH6lIwyVor1q25AHrGkiUs6tlhE7bU3RaBsboA2d
         W1RQ==
X-Gm-Message-State: AOUpUlGQDYQaNpDf6V6zH6tJw2r32CbS104KgFlOLZp7urdR48DelJg4
        +2/F2Te/msczKpBgPS2xX49IBBMsPEscf5Y3dPXsTg==
X-Google-Smtp-Source: AAOMgpd4Z/0wkLuF20/wR12KRBWTEMUnDDE4/hhyI79pyaEM80+xW/ATJ0MaI3NALmNbqI+LW+TCo0vx33qOUXwiZq4=
X-Received: by 2002:a24:69c6:: with SMTP id e189-v6mr8133790itc.21.1532779928847;
 Sat, 28 Jul 2018 05:12:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 05:12:08
 -0700 (PDT)
In-Reply-To: <20180728090044.GA16454@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
 <20180724095843.GB3578@sigill.intra.peff.net> <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
 <20180727131333.GC18599@sigill.intra.peff.net> <CAGZ79kYK3QkaSEinuq_Js5thVgY2-MyrN60W-Dws1p4eK73hHw@mail.gmail.com>
 <20180728090044.GA16454@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 28 Jul 2018 14:12:08 +0200
Message-ID: <CAP8UFD3McRRGNheftV9qmJMQ1i860tNPefFT=+X_TZtpDGLzKg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 11:00 AM, Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 27, 2018 at 10:22:09AM -0700, Stefan Beller wrote:
>
> > > That would solve the problem that fetching torvalds/linux from GitHub
> > > yields a bigger pack than fetching it from kernel.org. But again, it's
> > > making that root fork weirdly magical. People who fetch solely from
> > > other forks won't get any benefit (and may even see worse packs).
> >
> > Thanks for the explanation.
> > I think this discussion just hints at me being dense reading the
> > documentation. After all I like the concept.
>
> I actually think it hints that the documentation in the commits
> themselves is not adequate. :)

Ok, I will try to improve it using information from the discussion threads.

Thanks,
Christian.
