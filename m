Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379131F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfGZPPW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:15:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41773 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfGZPPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:15:22 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so21415733uar.8
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ndzAREK4HnZtRD5jjpvTC6NrH9uEEktDptkl9WrTLY=;
        b=tASJx7xq1Iq5/G/P/3VyKIh7QkkFTTtl7+f/Ani9316Z70eZZFNgPYcEkmpkSgVgzk
         9lZxR5GsdtPuslYszjTZjDMToBSF+hI9tjrkPUDNyKiTKvYjiOZ29fmfHBoxOQg2RZo9
         KIkx6GEc+Y1tFhICVX32joQUcHa7h1qpv3ePnn7LmO8HktPafPFPzZDF51D+V1Y2+T5i
         4wcpjloOX3AzRpqsvODYr7kWo5JB7kEQCAEsmDoJWbghvVP7gZy+5wNpMiDntAhHkek9
         Ne8ZNV0OgZEpXHQkAz8fbgU/vl98FxdJGzbgSX5vwpau8uedCelNAOkHKPE0vcJuOlW8
         8vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ndzAREK4HnZtRD5jjpvTC6NrH9uEEktDptkl9WrTLY=;
        b=eGIv2Hc0+UyUdGz+Jvgi20rS5Ip3wO+9Fr6enpqtFt/LwfkLv/U9Y99okxV2L5lK03
         3Tit4QHw4ysqKWRI749Fy93sGbm0ms1DFrefkp0pDggb8CT47bcFb+on803Po/y7FUef
         KyejcnrEOTJ1CQi9s2Kv2pPordIfJmRUb0g34KzFnd+Ma/fC/iRpMIMG8x2rAnRVSry9
         6s9HZzFnGC0djEQNHK1IArqFlt0Yq675ZlKkO1moPKh97rCaxaEtaFmbh3Nf6/K8KWfz
         QNcBNp4O3zfybhdIiW576LhSjokHf+iOPLJAQ1zq3t9nAa2Wz6ToliciELSGY1F+gQzO
         F32g==
X-Gm-Message-State: APjAAAU1hGz7MejyRJPjmCbMS/mp+dw4BGsk/6sqJzoP1xonBNf7n9vO
        nA4vi3pUyUs7qtOH8pNcK+jFoZF5QEPcuUeBFzQ=
X-Google-Smtp-Source: APXvYqzB59ZP1TrUaNA6hhRldCmTuABYC6/KW8zga0XzJ0sqCogxQXbIY40zd+3H78mEZNgjfdr6pzgxFlhxjQUSZv0=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr45935309uaf.95.1564154121077;
 Fri, 26 Jul 2019 08:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 08:15:09 -0700
Message-ID: <CABPp-BHUf0eR2Dj77+qNa0rS2qAHxQL2MpRgg26Zjrfheim6Gg@mail.gmail.com>
Subject: Re: [PATCH 00/19] Cleanup merge API
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 25, 2019 at 12:15 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
> >   * All current callers (3 of them?) of merge_recursive() always pass
> >     it a specially created reversed-list for the merge_bases.  Some
> >     history spelunking provides no details on any of these about why;
> >     it appears that the 2nd and 3rd callers reversed the list because
> >     the first did, and I'm guessing the first did in an attempt to
> >     exactly match the git-merge-recursive.py scripts' behavior.
>
> That is part of the reason.
>
> After I worked on converting that Python script with Alex Riesen, I
> tested it on all merge commits I could find at that point in linux.git,
> to compare the outcomes between scripted and non-scripted versions. IIRC
> I even reported those findings back to the mailing list.
>
> *clickety-click*
>
> Ah, I did the extensive test on git.git first [*1*]:
> https://public-inbox.org/git/Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de/
>
> As you can see, it seemed that the reverse order of merge bases (trying
> to merge the oldest two merge bases first, then merging with the
> 3rd-oldest, etc) avoided more merge conflicts than the original order.
>
> >     But if the API needs them in a reverse order from what people
> >     would normally expect to pass them in, shouldn't it reverse them
> >     itself instead of making all callers do it?
>
> I would not, as the order the merge bases are passed in defines the
> order in which they are handled.
>
> >     Also, the order shouldn't matter when there are no conflicts, and
> >     when there are conflicts it'd only change which side of the
> >     conflict markers the made-up virtual merge base would list things
> >     in.
>
> That's what I thought, right up until I re-created those merge commits.
>
> I really forgot most of the details, but I seem to remember that there
> was a puzzling one where the reverse order caused no merge conflicts,
> and the original order caused a double merge conflict.

Thanks for providing this history; very helpful.  In v2 (which I will
be posting soon), I included a comment in merge-recursive.h just above
the merge_recursive() function with a summary of these details:

NOTE: empirically, about a decade ago it was determined that with more
      than two merge bases, optimal behavior was found when the
      merge_bases were passed in the order of oldest commit to newest
      commit.  Also, merge_bases will be consumed (emptied) so make a
      copy if you need it.
