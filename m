Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF07C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07124610D2
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbhICREC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:02 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34774 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhICREB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:01 -0400
Received: by mail-ed1-f52.google.com with SMTP id i6so8838242edu.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yasP94Dd0l55QjecSt0YVI4yDblcvAdU9oGcKdJlDas=;
        b=jS95LS5tqg9xs2JzFC1oE6o3Rm2O/SofxuD0UP9PBw/tHbLyOGCUCGJF0gok+kqgBN
         PpG1C0HRwgbDZUJ5qPoJC57IX7QtorGKes5eXn1Y7NADnMHkvIkIcBOmA5HklDDlDqj5
         IT1CVvLy+7GlvZ23TRvdc5u0Z4U0G2fXz5rOFGZif3qVOISchNL31F17Eattwl4GXNOZ
         uDzaXWXTc7oXYzhVASLfDW0TfhfHP0ZUkShLZJxhqJxwc8guH5qhbHftE09OBC+86cyN
         duMZp4iNK50ryxWzwq4Rz2uQHT9csbYsRuVUZtu+uZwb2Z20Fkjd3wXMHa6daRBCki2u
         5WOA==
X-Gm-Message-State: AOAM533k5SHk7GXSWpNyHpDUSGsAF688ymgOiAW4JHPhBHWsrwHd5SJ0
        PD0yFehYU2Ns3Sgg8m7NM8ih3mzOTXKJ80bzDuD21ZdmToI=
X-Google-Smtp-Source: ABdhPJyjCw37vVsv2tWqs47ntsXPDPv3tF3IiU+ICfxiIMAvOpjGX09i1HsM77Y+BsWNngt8vjza1VCtewlU4cl7K08=
X-Received: by 2002:a05:6402:1cbc:: with SMTP id cz28mr5075666edb.370.1630688580533;
 Fri, 03 Sep 2021 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <732a28c22fcecafa308cd9444efe9158800b94e5.1630359290.git.gitgitgadget@gmail.com>
 <CAPig+cTG2+A0auFYdu-PHBVa1w2A5neS+6JQ5m+ADaOBq8vzUA@mail.gmail.com> <nycvar.QRO.7.76.6.2109031722460.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109031722460.55@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Sep 2021 13:02:49 -0400
Message-ID: <CAPig+cQKKPq0cUn4iFpqaYOrwWnBTg0RhgHRztOGxB2Mm-GVUA@mail.gmail.com>
Subject: Re: [PATCH 12/15] scalar: teach 'reconfigure' to optionally handle
 all registered enlistments
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 3, 2021 at 11:23 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 31 Aug 2021, Eric Sunshine wrote:
> > On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
> > > +With the `--all` option, all enlistments currently registered with Scalar
> > > +will be reconfigured. This option is meant to to be run every time Scalar
> > > +was upgraded.
> >
> > s/was/is/
>
> I wanted to convey a temporal order, so I changed it to "every time after
> Scalar is upgraded". Okay?

I think I understood the intent of the original, but it causes a
grammatical hiccup. Your revised version can work, although I might
write it this way:

    This option is meant to be run each time Scalar is upgraded.

However, perhaps that is too ambiguous and some users may think that
the process of upgrading Scalar will automatically run this command,
and you'd like to make it clear that it is the user's responsibility.
So, perhaps:

    Use this option after each Scalar upgrade.

or something.
