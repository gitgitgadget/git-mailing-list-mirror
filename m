Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCFF20248
	for <e@80x24.org>; Mon, 15 Apr 2019 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfDOS4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 14:56:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40005 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfDOS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 14:56:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so23341014wre.7
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GuwFn9/0Rlf1kJv7eKciy1lvIpC31w2Td9mZYTaveNM=;
        b=unVR7yumYK125vv4aEYE37zbxg3VYm/Y+3nu7Y+xjWCRF0YsxyLP6F/1lu12hFti0V
         +zmPJsoCyxaKJEOEZHDjKpIplJiTSthFiIwdoo3lg2yyauqAb/RK5Zo6ceWjQ7Gx3ZGN
         5grocgOjXJROtRXvR+uftJbXcahtcAUgOKWcbMbW7sZGH8/o/abnYRhD7+NnZe9BOYB9
         SWDUhO+4ovfCd3sUy8B5MoBe4suPvHXUyU3Ng/2b0iLv2aHWpq35C7VfPmgVY7Egbl62
         WHBBGj3uF9HvCJe1oPTYrGNDxZdkcMcupyENTLadYlMDLRwfrwver5qTH35Pk+7I8hgP
         i1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GuwFn9/0Rlf1kJv7eKciy1lvIpC31w2Td9mZYTaveNM=;
        b=kEj4s9Q+9EbR4k81JqsLTatDaJ8PFsy4ulA6NsrVH2kIkRA6JxakeO0RMtm0qsSUcx
         MbzvBwDwqdsUNkRkP/Fpf0p8L2LLLU0tl4f1HzQq00CrmujbDxcv2EpahTG+Fv2IxE2S
         cEFh9eDeshdNDF5ZPkEtzBjFMDAX4X7bhtlvsieJiAE3XXGvrLeEEmWZNZdQCSmIrbjo
         J3r+dbyU5vuHZqsuPXe9TZTx0T4LppuPPFKZipUpewg6ycy+epoOalSrc3rJ18z9pWXX
         XeaOpjIggiE5fNoWC/Td+Psr21YHWH++Fn6N7tTsYksbXWsH+j/OXvjz6Jt6e72kRGKu
         RrZA==
X-Gm-Message-State: APjAAAWKulY2Vx2/llwDkpn8axf3xtFCJV7BLGwBZKfWSzbirmU2sdcX
        4O0DLx1gq1Yrn2Se37MNiOA=
X-Google-Smtp-Source: APXvYqys4iTdcYaDwuiDvTkpMgz8bZxkUOGdF4UNSwQOt1KPbX8pYTPLFITcdq6th+l8ZxrUFjPWPg==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr24968980wro.144.1555354589369;
        Mon, 15 Apr 2019 11:56:29 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id y133sm25237625wmd.2.2019.04.15.11.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:56:28 -0700 (PDT)
Date:   Mon, 15 Apr 2019 19:56:27 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner diff
Message-ID: <20190415185627.GB1704@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-3-t.gummerer@gmail.com>
 <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904151454010.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904151454010.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Johannes Schindelin wrote:
> Hi Eric,
> 
> On Sun, 14 Apr 2019, Eric Sunshine wrote:
> 
> > On Sun, Apr 14, 2019 at 5:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > [...]
> > > However it can still be useful to have the function name that 'git
> > > diff' extracts as additional context for the change.
> > > [...]
> > > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > ---
> > > diff --git a/range-diff.c b/range-diff.c
> > > @@ -102,9 +102,12 @@ static int read_patches(const char *range, struct string_list *list)
> > > +               } else if (starts_with(line.buf, "@@ ")) {
> > > +                       char *skip_lineno = strstr(line.buf + 3, "@@");
> > > +                       strbuf_remove(&line, 0, skip_lineno - line.buf);
> >
> > It makes me a bit uncomfortable that this is not checking for NULL
> > return from strstr() before doing pointer arithmetic (even though the
> > input is presumably machine-generated).
> >
> >     if (!skip_lineno)
> >         BUG(...);
> 
> Good point, but maybe we should not go so far as to declare this a bug,
> and fall back to removing everything bug the initial two `at` characters
> instead?

I like declaring this a bug.  We are after all parsing
machine-generated output, that does come from git (which is why I
neglected the NULL checking in the first place).  If that second "@@"
is not there it's definitely a bug somewhere in the diff machinery,
I'd say.

Note that the "@@" also couldn't come from anywhere else, the diff
header has a well defined format and so does the metadata.  The diff
itself is prefixed with '<', '>' and '#' in this case, and the commit
message is also prefixed with four spaces.  So if this breaks
somewhere I'd rather hear about it loudly, than let users potentially
get wrong output because we missed something somewhere.

> >
> > might be appropriate.
> >
> > > +                       strbuf_addch(&buf, ' ');
> > > +                       strbuf_addbuf(&buf, &line);
> >
