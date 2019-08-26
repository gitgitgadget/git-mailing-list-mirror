Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A741F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfHZTTF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:19:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44140 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHZTTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:19:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id c7so11732597vse.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy7tVZs3vlLa6BMw8A0+0QaFqWosquC9BZq0FS2n6js=;
        b=lC9wQO5MwXk88t40Ls+WLNJvhD/smX3LEbdQ2GCbmDcZdqqpJhVMbTNtBVMZU6QvdI
         vY9Z76STY1otpXfgGMVQlqyggPKN/0EV/8AWP1mgsXmiWgz7bh5JhwbzgAkolEkwQCj5
         NhFMNTsbrgrU1Vw4ojDhFKbvheTV17WVMFwQxyY2d2lyrlIcanJxNq4hQTwbpLbcEMU/
         kdK507jigdcoEytqAireG02DdbGsYTqRKkNouFpa82Og1jiR6PoKjFh0HcYnPG+afRnT
         ImbwEBSrpjCSMzekiVEkNJDRW9bUabtdLbthX/6GFbLM0Ab7rvzHhSUxRjo5oNtlR1uC
         cw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy7tVZs3vlLa6BMw8A0+0QaFqWosquC9BZq0FS2n6js=;
        b=Ojxc0f4v+rpeb9QQgiuvwmlHED7C0PpoQhvItl/iLYFuyrCXC3PrAIHNjgWaMOO2SF
         DgEFbKPow7K7zEFSlsjZZ3PQJoUqTRX2O1YNNHNh6QaVLKiv266GVgoKfFuZIUyYCaVM
         k8cDPl27Xy/zMwbRsIEURq9YJahiGWWVfYHcnwvVvlF28c4wnjisPnHH1d77bHCS+KM9
         SLQuy7y7lFJfq0sRfPDWMqRq0YkW2X5O/yy8UHi9Yw9BOWIbVGp/OBT5qlpU69RnKBPe
         Tz9DpUDusYMrKU/SOvVnJUFL0hP70IBNjCsD3ScK9CFkn9clXJhAftlm3f5k2MIM9kJD
         5CWA==
X-Gm-Message-State: APjAAAXOSUr30LfwqKZlv8YheNh0BWPzpK32Ds2u/PNkjHie/R4LqR/k
        Ee4cQNGGrwrbrMw1XWJNvnNQobJdRcz1vvhVUzU=
X-Google-Smtp-Source: APXvYqw/UBysmhrEehdVNmTvQE6i6xPWYCr1JE/s3p3iffEtBBomLQWrJucrVB5LF84ssy6zZQBhMPDS2kj0d9jaHsE=
X-Received: by 2002:a67:f887:: with SMTP id h7mr9096693vso.116.1566847144523;
 Mon, 26 Aug 2019 12:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190825041348.31835-1-mh@glandium.org> <20190825065747.GA23806@sigill.intra.peff.net>
 <20190825080640.GA31453@sigill.intra.peff.net>
In-Reply-To: <20190825080640.GA31453@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 12:18:52 -0700
Message-ID: <CABPp-BHAweswaAV+Qv_=SCQk7fr2s5fH=cEqzuz5N8OMD8=mOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fast-import input string handling bugs
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 1:06 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 25, 2019 at 02:57:48AM -0400, Jeff King wrote:
>
> > And I think this is actually a real bug in the current code! We keep a
> > pointer to the encoding string, which survives because of the history.
> > But that history is bounded, and we could have an indefinite number of
> > changed files in the middle. If I modify t9300 like this:
>
> Here are two patches. The first fixes the existing bug with "encoding",
> and the second uses the approach I suggested to fix the leak you
> noticed.
>
> The second one does carry a greater risk of regression than your patch,
> but I think it's worth it for the fact that it makes any other bugs
> (like the "encoding" one) more obvious.

I agree, both patches look good to me, and I particularly appreciate
some extra help to avoid making the same mistake again.  :-)

Just for good measure, I also went and tested these patches by running
the git filter-repo testsuite and by re-running the filter-repo timing
cases at https://public-inbox.org/git/CABPp-BGOz8nks0+Tdw5GyGqxeYR-3FF6FT5JcgVqZDYVRQ6qog@mail.gmail.com/.

While filter-repo only uses a subset of fast-export functionality, it
tests it with a variety of weird and unusual tiny test repos.  And the
timing cases run on three real-world repositories (git, rails, and
linux).  Everything looks good on all of these testcases.
