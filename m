Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3582220248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfBYVBD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Feb 2019 16:01:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40837 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfBYVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:01:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so12304773qta.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WGKkfRF+bCEhBXAULn74lWfjfwHy+HbOuslKPIntIWw=;
        b=LYCEIjfypM09t4PCCUVr7QUVweFUUyIk4NZnTQtqdH9JeH2m1ylscoaUJcHqsYw0mp
         MkY5MJrxtxsr3kPv2pBrCytIbUXVLt1MOOY2pMvCx0o3Nx8aBeJsDpLFK04q6u5SSykY
         sj/AickOgdr/cLJhrESzWp8RRUFwz22kEyCy3dNOC3YNqwz58uOYxfAv5arvPhMWpnKa
         opWKmzLjZg+hkC3u5fCW5tu+gfQNFHpalbM2s5by+ayapP3Tclrvn1h/XPtcnLee/goQ
         /RfXJkZoEKv9jMFsemXzrIRl1ns8kpsJFc6JYu+sqmL1nkO+HYf5SFa54jYXzYOdySJ4
         N0IQ==
X-Gm-Message-State: AHQUAuZxWgNKbTVhtu7fOflnGjfw+2JdAjJqwLdnRGZ9PSSA+82X47sw
        JmehbPmvPhuTX9+L8FsmMjdox+CUgGgz+razBRA=
X-Google-Smtp-Source: AHgI3IZk1CFFgS16s6bVmkAbBtHB/05NeZXPeat1625g8yUV1Pv8fWjBtZ+niIGj+FExDyWu0d9hTEMuXg9Z9ekTVG4=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr15042125qtr.335.1551128462060;
 Mon, 25 Feb 2019 13:01:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
 <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com> <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com>
In-Reply-To: <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Feb 2019 16:00:50 -0500
Message-ID: <CAPig+cRTj_jHFrqyYsn=ivuO9uNcWjB=5okX0SCGoeWU=uR8Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies
 for manpages
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 3:29 PM Martin Ågren <martin.agren@gmail.com> wrote:
> On Mon, 25 Feb 2019 at 21:08, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Feb 25, 2019 at 3:03 PM Martin Ågren <martin.agren@gmail.com> wrote:
> > > -%.1 %.5 %.7 : %.xml manpage-base-url.xsl
> > > +%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> >
> > The wildcard expression also matches the manpage-base-url.xsl
> > mentioned explicitly. Did you intentionally retain the explicit one or
> > was that an oversight?
>
> Hmm, I should have mentioned that, thanks for asking for clarification.
>
> It's intentional. You can see in the context how manpage-base-url.xsl is
> actually generated, so the wildcard won't be able to expand to mention
> it. That's subtle enough that it warrants being mentioned upfront.

I guess I was further confused by the fact that manpage-base-url.xsl
is still present even after "make distclean", which is not something I
would have expected for a generated file. (Perhaps something to
consider "fixing" if you re-roll, or not if it's out of scope.)
