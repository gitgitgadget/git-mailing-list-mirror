Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B9F20248
	for <e@80x24.org>; Tue,  9 Apr 2019 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDIK6j (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 06:58:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33704 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIK6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 06:58:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so20322195wrp.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HlpqeHhw//4MoeEZXiDvV2GtDdNLlHa2hCs46qy5dCE=;
        b=ecQyF2yi56q2G+mY97wKfawOcoh8/9bMY8D7szHYDZdZ6n+jUPLMVg6w72QgXXT+Nx
         8PBbSF6wKmKx6MVB36cUdtXnyT8RCQFHJMRIEYgVh9RymykEgXQ0S7uYmUBMNpi4be0E
         HLbHwuHjyfOt+KOONDcs9Z1vX4gReVUoOFoDjv5xm5Hftg9bwEmrhAmNA2A9dBB+2u99
         DCWInbYJ7uDeQLGGpdNrLvG2lm3Gn8b6N34uaxAZ1ne0niHXKsSln6OnrH/jkK+N4cmy
         1EYS3RY5v3hPYW7RChWCH7Nd/t9f52ZMgejzINRdBk0m6g8mA6DiIHgnq1R50jLDjtor
         SRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HlpqeHhw//4MoeEZXiDvV2GtDdNLlHa2hCs46qy5dCE=;
        b=YY/rAZZ29KFURiYzUyLn0CEzjb56buMqX7MsaqW7ybZEYJwAGVJRbt72oCxDSR69oi
         KXOG6XVQMMEdY+Rk3naG2TDDZUF2mtERbwvzNCBZVyuvQzp+qygor4c7Va5wQuKcLmJI
         QUBIgwDKR51t5oWrFJxBpKB/IuvRbdfRqyBQj/WTAz9FBsa/Da9IGfN9iwupa3lDM5/g
         sds3KMzesXOUjO6+3RbZPcMdH8NxKavuYiW8r6Ei2O6OGz2rlVxh/Dm+GjYcAY4vtSjf
         j9tCiZYEihmyWh4K56HXiJ2+ZyR6m9Xn51VgEbvYrYmTPseVO/Imc0h0Ffr7NSnnoPp2
         7GWg==
X-Gm-Message-State: APjAAAXq9OfWLogsNfg70hrKKkIJAp1I92K5N9QN53K5zmwkKD2jewFH
        8TxnF2zPEEk9umCNZ3uWJ0E=
X-Google-Smtp-Source: APXvYqySlhPeLZfk8teMT87E0LFIGUdPU80ALRYRcX3H8p5UYH7qVBvdXl7oTrYEfmTUFi7ins8UHA==
X-Received: by 2002:adf:afee:: with SMTP id y46mr22021640wrd.217.1554807517687;
        Tue, 09 Apr 2019 03:58:37 -0700 (PDT)
Received: from szeder.dev (x4dbe2124.dyn.telefonica.de. [77.190.33.36])
        by smtp.gmail.com with ESMTPSA id o15sm28040880wrj.59.2019.04.09.03.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:58:36 -0700 (PDT)
Date:   Tue, 9 Apr 2019 12:58:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 01/32] rebase: 'make coccicheck' cleanup
Message-ID: <20190409105834.GG8796@szeder.dev>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
 <20190403113457.20399-2-pclouds@gmail.com>
 <20190404172515.GR32732@szeder.dev>
 <CACsJy8C5K15QOeAJmPBb-VkcJnAiha9BNuUwVAL_mH_y6YBjow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8C5K15QOeAJmPBb-VkcJnAiha9BNuUwVAL_mH_y6YBjow@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 04:26:10PM +0700, Duy Nguyen wrote:
> On Fri, Apr 5, 2019 at 12:25 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Wed, Apr 03, 2019 at 06:34:26PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > > ---
> > >  builtin/rebase.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > > index 77deebc65c..c064909329 100644
> > > --- a/builtin/rebase.c
> > > +++ b/builtin/rebase.c
> > > @@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> > >                               branch_name = options.head_name;
> > >
> > >               } else {
> > > -                     free(options.head_name);
> > > -                     options.head_name = NULL;
> > > +                     FREE_AND_NULL(options.head_name);
> > >                       branch_name = "HEAD";
> > >               }
> > >               if (get_oid("HEAD", &options.orig_head))
> > > @@ -1793,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> > >        * we just fast-forwarded.
> > >        */
> > >       strbuf_reset(&msg);
> > > -     if (!oidcmp(&merge_base, &options.orig_head)) {
> > > +     if (oideq(&merge_base, &options.orig_head)) {
> > >               printf(_("Fast-forwarded %s to %s.\n"),
> > >                       branch_name, options.onto_name);
> > >               strbuf_addf(&msg, "rebase finished: %s onto %s",
> >
> > You are already using Coccinelle v1.0.7, aren't you?
> 
> No it's 1.0.5.

Oh, you are right, Coccinelle 1.0.5 does indeed find these.

When I saw that the self-built 1.0.7 found something that the
distro-shipped 1.0.4 didn't, I checked it with a self-built 1.0.6, and
as it didn't find these, either, I didn't bother with 1.0.5.  It seems
that it got fixed 1.0.5, then regressed in 1.0.6, to be fixed again in
1.0.7.

> I guess I should upgrade then.

I found 'make coccicheck' with 1.0.7 to be about 10-15% faster than
previous versions.

