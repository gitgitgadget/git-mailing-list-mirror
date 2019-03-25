Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC6320248
	for <e@80x24.org>; Mon, 25 Mar 2019 09:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfCYJch (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 05:32:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34389 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJcg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 05:32:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so4880108qka.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH0mhqYy7XVlx/MRU6M6TKLT713JXZgsnXIr+bp8RSU=;
        b=hEE+068T4zddHVEBdKfs6fLLelMmGci8IUrr8psPK1sxuUC4oRWFDyETyJ6gTsoaJd
         WvKgfe1U8MWEjfNHqasbCrUag/VWYk6R82DiXFbTGZ2sCIcmplo8eR1wNhLgYOxympmq
         ES8UvYmU7QvalTtbHe4c5mOBHszG3Yhp7WULd0eXTwQKjFbrP2KXEimWua4XJ6FTLiUR
         xoDsSZR8nQee5k8vt2x/W5vbBaIBKkaIBRgzeZP8K7m/HzN923av9OJrJGq0sZXpapTy
         FSk+HT1tfBskfzk51vYWxC/nKgs1An3PHe0zeiaY4FbuOdeGB7utmvT7PbKnkKJyBf3k
         WmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH0mhqYy7XVlx/MRU6M6TKLT713JXZgsnXIr+bp8RSU=;
        b=PKq+JH4WbSYk6ZpOSaphChAfoICZifnawU7YBJfs7p218oEVBq3UgsMYK6ElPnTqG6
         hCjfC+zOQjWpraAtoNRKngCW5nAi3fmmhNV9OQC7eIP4ix7KqabPvEiyl+0sjGwUiZFz
         w1zTpeb6cVSzR3zIM1vYqy6IktnCjIJgbnm7RdUbtVpGhzijzLjvpam4G2wqBFHM728a
         ifW2G+uT4IJ/0SOjpVrLnEL8UklrvGBEQsT3b4ZfdsHo3DZS+gnVjFqL7ZNXu1gEAnaG
         lxPMpnaIUf2WDdpYj38yTeAXnazajiha5IuTUbWJ/xABbSmAONvFerUppUAoANfFqoDZ
         BBtw==
X-Gm-Message-State: APjAAAUv/kYpL6QcfVDtz+TaGQ8y+gFIM2TDZwkfA+ij8tXCiwLiJG6+
        ebo/Lc8RtkQu8mSZ4BJ3jOoft8vWHplaPU+WcXVdcpwMr8Q=
X-Google-Smtp-Source: APXvYqy0rebpEoRsjphRrr7LfmlViLlxCorEa+dmTwyEIP3IwUBEWWPHt3W50NpqcYqWq7EDQ+aOzvFvQbCTZ60c1Kw=
X-Received: by 2002:a37:6dc3:: with SMTP id i186mr4311400qkc.12.1553506354017;
 Mon, 25 Mar 2019 02:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 25 Mar 2019 09:32:22 +0000
Message-ID: <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, brho@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resending in plain text mode, sorry for the noise)

Thanks Junio, that's super helpful!

A month or two ago I contacted the author of git-hyper-blame, Matt
Giuca, asking whether anyone had looked into adding the feature to git
blame. I didn't receive a response but maybe that prompted Barret
Rhoden's patch? Or maybe just a weird coincidence!

@Barret I see your patches are a nice translation of git-hyper-blame.
However could you give me your thoughts on the approach in my patch? A
comment in the git-hyper-blame source [1] says:
# This doesn't work that well if there are a lot of line changes within the
# hunk (demonstrated by GitHyperBlameLineMotionTest.testIntraHunkLineMotion).
# A fuzzy heuristic that takes the text of the new line and tries to find a
# deleted line within the hunk that mostly matches the new line could help.

My patch aims to implement this "fuzzy heuristic" so I'd love to get
your take on it.

Many thanks,
-Michael

On Mon, 25 Mar 2019 at 02:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> michael@platin.gs writes:
>
> > From: Michael Platings <michael@platin.gs>
> >
> > Hi Git devs,
> >
> > Some of you may be familiar with the git-hyper-blame tool [1]. It's "useful if
> > you have a commit that makes sweeping changes that are unlikely to be what you
> > are looking for in a blame, such as mass reformatting or renaming."
>
> I recall a month or so ago brho@google (CC'ed) sent a "let's allow
> blame to ignore some uninteresting commit" topic, which was
> unfortunately not well reviewed (what I mean is *not* that it was
> reviewed thoroughly and found to be bad---not many reviewers found
> time or inclination to review it well).  The topic is queued as
> br/blame-ignore and its tip is at 43a290e3 ("SQUASH???", 2019-02-13)
> as of this writing.
>
> Perhaps you two can join forces?
>
> P.S. I expect to be offline for most of the week (packing, moving
> and unpacking.  Even though the places packing and unpacking happens
> are within 1 kilometer radius, that does not make it less hassle
> X-<).  See you guys next month.
