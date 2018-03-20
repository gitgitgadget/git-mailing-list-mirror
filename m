Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C3C1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbeCTEZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:25:30 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45300 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTEZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:25:29 -0400
Received: by mail-oi0-f53.google.com with SMTP id 71-v6so245123oie.12
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 21:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A9kUyf6R7S0DNNolPZkFUWrKFvEmPIjhSfsqw/OB5ds=;
        b=fce6tzEVA5Kf8bRvEZPilmnKqsdk4Shxrziq68VrP7q0f+ePM34wM0DxoGqqkZ9lam
         xkXlq0vXh4Tf4z1GRlRx3c6MrVC24mNQTB0EGwAQMA16OB4BYOM1cWWt8MWROtFz/rba
         BAGEkVaw1XGeOTJu2nkDMdCJOo+g0wLRsv4OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A9kUyf6R7S0DNNolPZkFUWrKFvEmPIjhSfsqw/OB5ds=;
        b=hKPP6/srHB8Ln3EwwtUo03yw2HEiAf+ITLkv7Nrt7HjqBzyPiALT+i0m5qrpS/y/9k
         U0NJNp3BlbWN3GZXFZeFgHAo4e/8+woCmlTdBPsMuQtwp+Wb+oisQh5fQWsuuBvEJRLC
         4IX48IwE87iZkjPbpPpOVjvkfKJEPqgjjHJGEYBPcE6M8/r6lphkYahN1iJU9AHUFfG8
         LQxDGDHyo+Za5oFVD2mVOscK5YRiaSdMAZr8sWqio87u3s/mDOZgM5lqeRRWxdlwdrQl
         7xH1/RNdNO+u0CFwM2F0Xt4zSq1+aNZRJcBioGa1nnJX//GnOY4cm24iPDaNAwSkHcwC
         ROgQ==
X-Gm-Message-State: AElRT7HqEA5+1wbuVpDzCu8nx/qlElhHiqJNxVmfGL3jr5xdhP25zmM5
        SCglauhLAg2+scYORZ4J/adQRqk/QC8GhTv4Ru8eAOkz
X-Google-Smtp-Source: AG47ELs444DS/D5MmmNRL2nnwUBvgk80gdEbMl/b+8fmoz5If5n//r4QaB9c5O+toAx1FTZ9upsSWRJzWf1cGo6PXhs=
X-Received: by 10.202.78.16 with SMTP id c16mr5537662oib.314.1521519928362;
 Mon, 19 Mar 2018 21:25:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 21:25:27
 -0700 (PDT)
In-Reply-To: <20180320040411.GB12938@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Tue, 20 Mar 2018 00:25:27 -0400
Message-ID: <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Right. The technical reason is mostly "that is not how it was designed,
> and it would possibly break some corner cases if we switched it now".

I'm just spitballing here, but do you guys think there's any subset of
the combined .gitignore and .gitattributes matching functionality that
could at least serve as a good "best-practices, going forward"
(because of consistency) for both? I will say every time I do this for
a new repo and have to do something even slightly complicated or
different from what I've done before with .gitattributes/.gitignore
that it takes me a long-ish time to figure it out. It's like I'm
vaguely aware of pitfalls I've encountered in the past in certain
areas but don't remember exactly what they are, so I consult the docs,
which are (in sum) confusing and lead to more time spent
trying/failing/trying/works/fails-later/etc.

One "this subset of rules will work for both this way" would be
awesome even if the matching capabilities are technically divergent,
but on the other hand that might paint both into a corner in terms of
functionality.

>> > I think just "/.readme-docs/**" should be sufficient for your case. You
>> > could also probably write "*" inside ".readme-docs/.gitattributes",
>> > which may be simpler (you don't need "**" there because patterns without
>> > a slash are just matched directly against the basename).
>>
>> Wouldn't that make the "*" inside ".readme-docs/.gitattributes",
>> technically recursive when "*" matches a directory?
>
> Sort of. The pattern is applied recursively to each basename, but the
> pattern itself does not match recursively. That's probably splitting
> hairs, though. :)

I understand, but if I think about it too much I feel the overwhelming
urge to stop thinking about it :)

>> It's always seemed to me that both were necessary to explicitly match
>> things in a directory and its subdirectories (example, IIRC: "git
>> ls-files -- .gitattributes" vs "git ls-files -- .gitattributes
>> **/.gitattributes"). Maybe that example is peculiar in that its a
>> dotfile and can't have a wildcard before the dot?
>
> Those are pathspecs, which are not quite the same as gitattributes. They
> don't do the magic basename matching.
>
> For pathspecs a "*" matches across slashes, which is what allows "git
> log -- '*.h'" to work (but not a suffix wildcard like 'foo*').

Same comment -- makes sense but hard to want to think too much about.

>> I guess my takeaway is that it would be _good_ if the gitattributes
>> documentation contained the caveat about not matching directories
>> recursively, but _great_ if gitattributes and gitignore (and whatever
>> else there is) were consistent.
>
> I agree it would be nice if they were consistent (and pathspecs, too).
> But unfortunately at this point there's a maze of backwards
> compatibility to deal with.
>
> -Peff

Again, as above, what if there were a subset of functionality git
could recommend to avoid inconsistencies?
