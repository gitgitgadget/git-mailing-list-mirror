Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1741C1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfFLTXI (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:23:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42489 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfFLTXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:23:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so6860524pgh.9
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hkp893aTaJhx6Iqf/s/8VB428UzlHEjl6n2wOjSrfyA=;
        b=PX90RmTOOD9lGI8DA9UaR0Rgu8o8yBcPeyyySVhfBeAp4UQCBBn5rPJZA+YFuRWg5T
         lAlkxmnwBX08uvWceB5q8TUGzh1Tu1IvFflv3mQwhUnTa66wQlxfGfGqpX9CQVp9+0XB
         vwfhqdBBYDL8AVa+JqjWG+rU35B+B7a7KfiwUN/VSlEZMNCVT+N+cWOQZblfG3j0M5zE
         Aw1o0yH+oKlwoO2LW0AzKtytYN1hb9ojDlLuS4mZSmfsY3jvpRHH9MmnVnnyOdKnMm+I
         AV+w52ofX6UvrXxd0p3qptiN+GeR6R+02H53JeuCEZed+Zk9vCMXSQ1u3u5k6erYGfVv
         mikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkp893aTaJhx6Iqf/s/8VB428UzlHEjl6n2wOjSrfyA=;
        b=nTxmmP319rpLhQGcJqWFjJcXB+lj08um/uOM05QCKVp43HAut7faBifOKEasVkJPkH
         GJFg8rXZg+sT8/paEyv3is6hx+sCDoxhAOW1d55xtqfMVJKyvaBf3at6cNHXs/aeh0/F
         SX/ZkfBY1eilqo0VrQEz0OdqJEBR9GitnZpZp/CkvOzQSML+QHmdBwtQXlNJY/6TO0Ww
         DeKs5ozDdaPCHFMzDb9XziMy1KcP7bxI6PBjB+iEENNu/2yUbOu1gwH+z9UvjxLr4Sg3
         r36d6Lr8WC4AiUfdGI/whx7ACPwTuwt+Z/IFxaZD6vkHwNRQ4pCEvn/gqp7iN72Z97Pc
         Kf1Q==
X-Gm-Message-State: APjAAAXF2ElrlGbON8nQG0Yi4cpIcyann3ilBGHG4YsPmGbQz9JeL4VG
        t2Wf7nBTEMziDayXp7Qst1+SUQ==
X-Google-Smtp-Source: APXvYqweTiMURNCgTOfYOXmc1Etjnqn+zGIjGrSENbEL9s4m/9Bc8B/2KIHH1VpcitRsH4i3JUjtew==
X-Received: by 2002:a62:6d41:: with SMTP id i62mr87834528pfc.227.1560367387531;
        Wed, 12 Jun 2019 12:23:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id h26sm371712pfq.64.2019.06.12.12.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:23:06 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:23:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
Message-ID: <20190612192302.GA233791@google.com>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <CAPig+cS7ocDU3fGRPnQZqN+rT1Ujd2b=v5b1p5V6G++XmNPmsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cS7ocDU3fGRPnQZqN+rT1Ujd2b=v5b1p5V6G++XmNPmsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 07, 2019 at 08:42:45PM -0400, Eric Sunshine wrote:
> On Fri, Jun 7, 2019 at 6:59 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > Teach show_object_with_name() to avoid writing a space before a name
> > which is empty. Also teach tests for rev-list --objects --filter to not
> > require a space between the object ID and name.
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > Not sure if making the whitespace optional is the right solution for the
> > test, although I couldn't come up with a cleaner approach. Maybe
> > something like this would be better, even though handling it in the
> > regex is shorter?
> >
> >   if [[ -z "$name" ]] then
> 
> In Git, we avoid Bash-isms. Just use 'test'. And, style is to place
> 'then' on its own line.
> 
>     if test -z "$name"
>     then
> 
> > diff --git a/revision.c b/revision.c
> > @@ -40,7 +40,8 @@ void show_object_with_name(FILE *out, struct object *obj, const char *name)
> >  {
> > -       fprintf(out, "%s ", oid_to_hex(&obj->oid));
> > +       fprintf(out, "%s%s", oid_to_hex(&obj->oid),
> > +               strcmp(name, "") == 0 ? "" : " ");
> >         for (p = name; *p && *p != '\n'; p++)
> >                 fputc(*p, out);
> >         fputc('\n', out);
> 
> It's subjective, but this starts to be a bit too noisy and unreadable.
> An alternative:
> 
>     fputs(oid_to_hex(...), out);
>     if (*name)
>         putc(' ', out);
> 
> > diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> > @@ -288,7 +288,7 @@ expect_has () {
> >         hash=$(git -C r3 rev-parse $commit:$name) &&
> > -       grep "^$hash $name$" actual
> > +       grep "^$hash \?$name$" actual
> 
> This would be the first use of \? with 'grep' in the test suite. I
> would worry about portability. Your suggestion earlier to tailor
> 'grep' invocation based upon whether $name is empty would be safer.


Thanks for the review, Eric. I'm going to try again from scratch with
Peff and Junio's suggestion about adding an option to remove object
names, and I'll try to keep your general style concerns in mind when I
do so.

 - Emily
