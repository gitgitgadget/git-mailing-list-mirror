Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF66D1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH1X0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:26:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39133 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1X0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:26:23 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so2088883itj.4
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vM95mmgGe4W3TRW+N0pR/oOGrdUPTTcv4HxMuHyGBng=;
        b=KFHXFCAJzV7njlqH3H7faQSb+Usax7pi5FmoIq0c83txjStE9gmNagOoUqT95B7b/G
         f9EKnq4I0C5iU21HCccUWAhnL4YEgM2fsPWTkrJXEwuQOs51/4mokF1lOlXmG0IZE9cC
         oIEi+hkD988GAKQhT+Y3rWZUEOW3YMQcPPy6ok3kSUFHqU8IaEdJj6NFG/atML6H2cJm
         63aljvCrw3vOusLabKieCa9TjTnSv6+E1e4v9A2u1QhYROEWtjtOMpZQe7FXGhSEbRl8
         680aCmDt3A9ezVNiqHOk+BQiC9Pqp+cGkQRkYtLQhu0NXLFbSiTLDQAlvyIJCIomAJ23
         vMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vM95mmgGe4W3TRW+N0pR/oOGrdUPTTcv4HxMuHyGBng=;
        b=dRvOs05pK8hQeB+jV/22WexVUqc0ookZthnEyG6Io/fVI6RSRAkxaS8Se8+34Hksqr
         PX1ig+9qmdQIU1nqO4FkB/XAjEyoasdcsFCQs2Mh27IN8ajuAEqwp1cb0/DETgKtL8QE
         Y10mNUOITlbteG/HsR/VHZuRutDHG39VwiGNHgInMTj3dwJNjBcbb6WyS6OkD9pDwoUU
         p2hbUokFfJn7/8caeiNT6m4Aa1PbbbOsBG5rAeQN5JjluujiTO2fbTO+B63+sAS3m70Z
         Blzgc+qamg6wpmyXDo6wilxxWW2kV0ppCRPQJ2Hr5Px+bNngbLVL5iDTc8iil4P/zPWT
         wIJQ==
X-Gm-Message-State: APzg51CXWUD+5cOuQsUneWtWYxX6vkmDN5rlWhAEQNqTAysj9Xxmx1iG
        6fxCxsq3eK3DSa511V5nfLfe4otR2bEvdDRDMwoeig==
X-Google-Smtp-Source: ANB0VdZ/xDHDJjpCgjxeUo6Onz2KESJr/pN0bNQXjg2SSngC/eakfy/mNFx8YEvJempdgP84Nzs3lhGiwR54KD+KDXk=
X-Received: by 2002:a02:b006:: with SMTP id p6-v6mr2758884jah.97.1535484796518;
 Tue, 28 Aug 2018 12:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <CAGZ79kas5TsCi0yN7mypH53A1iOveGNmQ03BkmspEH1-NfZgBg@mail.gmail.com>
In-Reply-To: <CAGZ79kas5TsCi0yN7mypH53A1iOveGNmQ03BkmspEH1-NfZgBg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 28 Aug 2018 21:32:50 +0200
Message-ID: <CACsJy8Axhh6G3RHr5WsB+VyB3U4-=tNV+UfpW6kwbkMb7ed5Tg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Kill the_index part 4
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 7:32 PM Stefan Beller <sbeller@google.com> wrote:
> > Besides some small conflicts on 'pu', like the previous part, it also
> > breaks 'pu' because of API changes. The fix is trivial though, just
> > prepend the_repository as the first argument for the broken function
> > calls.
>
> This sounds like a problem. I said the same when sending the
> object store lookup series, which ended via
> 3a2a1dc1707 (Merge branch 'sb/object-store-lookup', 2018-08-02)
> in master, but I do recall Junio being somewhat unhappy about it[1].
>
> By just adding the argument to the function, it might merge easily
> but not compile, which would have to be fixed up; and that object store
> series seemed to touch a lot of functions that were also used in series
> in-flight.

Which is why I state it clearly here so Junio could choose not to pick
this series up (I'm totally ok with that, I could wait until the dust
settles and send again).

Another option is me adding a patch that renames diff_setup() to
diff_setup2() or something that takes 'struct repository *', leaving
diff_setup() as a light wrapper around diff_setup2(). I would need to
wait until in-flight series are merged, then rename diff_setup2() back
to diff_setup(). Not sure if it's worth doing.

> >  diff.c                 | 259 +++++++++++++++++++++++------------------
>
> Ugh? That sounds like there is an interesting change coming.

Yeah. sequencer.c also needs struct repository in lots of places
(sha1-name.c comes second). But at least builtin/ code looks a lot
like it's supposed to be when 'struct repository *' is introduced, we
now have lots of function calls there that pass the_repository...
-- 
Duy
