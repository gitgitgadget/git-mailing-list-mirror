Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6108B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeH3B0m (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:26:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33266 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeH3B0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:26:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9-v6so5007985edr.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eSUxZvx5IRzHCWhpXMRkJqm6TL+mPaiqmqEZC3UDDk=;
        b=sFlxuqR6kbKqyURwoJuyOGNQznGDY84/X8NZKzxQz1d+WIq9oS1nYtrMCuLqlfzA9p
         kcBInHSC25TAq01WJOJl5FrA5rxtdT6KyCcP0sdt3kUuw0a1Sb1nAUP9ZkDylQ6aoFNV
         9Ci0dlsKw6VM/Kl5Trd2nCl20QX2B8gKeSgr+h5Wyk4hhafWGslJWL1mpec0wrLZX8Iq
         6/QRCQUd9AMNC/PyhwFZc9qgAQTAphL9HCB/YWVfHgFA78DJn3S6CZcp7XejnOTOEARd
         b2Ob0fJpZKzsu5o3KwrJb8za2rIVbS3Tsz2qCJ1T4btrsF9Ksv0969HudBvA4mTa0pcv
         FXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eSUxZvx5IRzHCWhpXMRkJqm6TL+mPaiqmqEZC3UDDk=;
        b=bdUwuxEKpZpxNDelvjIqLHsFcNMxq0A0TleOwiiV7vFxMLJHd2wkZTZoFWKb5PBsYb
         yqhWo2s9Xk5OSOZ06bOTPYiAAkEqiXFgvHjBsWEFMq8N01aiwnqcW9JU1bMYVCYYScdr
         QYknoCRWZflbmM4v/gBUpJJ8z9BkVcao8ttwTg9Q7mRnCSI06eGCJX6RVWN8NO4Nb4jG
         ibYEvpbq0IhBpwIeWannHhzgl67lKFon04PyjGM8ose1GJjJOlvLKDuNvTjlawbQEjZq
         v131u3gRRrCiqkqSZrfs/sYNhOHfNyL8x5QO1BLS3LPIXzqeTLRxa2POVPHSd/hduPDV
         zEDg==
X-Gm-Message-State: APzg51CnL4ydI/ZHxehJBOQb+UiFih8hlC0vnKcU1mR+NXMleWJsKNRM
        wN785vSgeJFLucilmAmiYA8D2z6//6FmBsG8x3HRwQ==
X-Google-Smtp-Source: ANB0VdYBAAlSSnYYxVhgwvkbRRSnL+naJlNR1XWHsk0WuX86vdBW2vcPbRfAnztt0LH1b2hHDY7bzt7iyamzXAoI1Do=
X-Received: by 2002:a50:9943:: with SMTP id l3-v6mr9835724edb.198.1535578075052;
 Wed, 29 Aug 2018 14:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net> <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
 <20180829210348.GA29880@sigill.intra.peff.net> <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
 <20180829211802.GG7547@aiede.svl.corp.google.com>
In-Reply-To: <20180829211802.GG7547@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 14:27:43 -0700
Message-ID: <CAGZ79kYnbjaPoWdda0SM_-_X77mVyYC7JO61OV8nm2yj3Q1OvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 2:18 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
>
> >> Yes, that makes even the capitalized "CON" issues go away. It's not a
> >> one-to-one mapping, though ("foo-" and "foo_" map to the same entity).
> >
> > foo_ would map to foo__, and foo- would map to something else.
> > (foo- as we do not rewrite dashes, yet?)
> >
> >> If we want that, too, I think something like url-encoding is fine, with
> >> the caveat that we simply urlencode _more_ things (i.e., anything not in
> >> [a-z_]).
> >
> > Yeah I think we need more than url encoding now.
>
> Can you say more?

https://public-inbox.org/git/CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com/

> Can you spell out for me what problem we're solving with something more custom?

case sensitivity for example.

> the ability to tweak things later.

That is unrelated to the choice of encoding, but more related to
https://public-inbox.org/git/20180816181940.46114-1-bmwill@google.com/
