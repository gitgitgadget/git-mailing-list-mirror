Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB5A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2SJ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:09:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34894 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2SJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:09:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so15355374lfc.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 10:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrHEZZbuCnkOYIMnVR+IKfUcHbP6rvKFY3HioH+7mLk=;
        b=OQ03+hFemR9X3teDPbR6xpmG7X40utQEqQ5AjBJmO4B5f1VUbBjdxrlC8d0Zqw/oBI
         EJw+Yl23e7XM/JBHAMPJPkYa0QY8d0opCkplYfTLmhsGS29OqueTCrHOpm/xRkrzV1Lz
         KyWMPWS0CEq0VDIhWWVUWETBsdV+5DJ3zoyMXskz/RpFBqxUxAVIqbA9KAJnYBIwdnoV
         unf2liNLwtF7ay9BSkRQszIsdjlRGKCPSM9E4Zfshc5Zi0E8LbYvP5aGqmn4ldUBYfvM
         EEk1xo62ouUTq5BX8ugv0imG4o4+EeV3+iW48aeO0UqTlxqDDMyZFd033T89ltogbLTT
         kgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrHEZZbuCnkOYIMnVR+IKfUcHbP6rvKFY3HioH+7mLk=;
        b=sJLtYy/lyOPOhmCSaeHeH+Q2nSr3bKddXGn9lieLs3AjRKIfQEf616/sjyTAQlOwBI
         y66M6QcbBdJgXDON1AIxDz6D8KuVjK6i8BidIwJXC2E0vZezqYQBghEYRnW82z7tlwyd
         DdLQcDKNXx0E+Ulb3VXKigJ9a76OJhNRIuD8vh193QOgloMSFe6v9myV9OH3oAuDNex1
         LBNdBrnShlKLYRtwEBDgJnJokH7vZgzwdkzfeKo4mA7Wg3UgoJe5LnuxBxSq6X7rEUHL
         8u6iI69gd+D1WSlWwyH9xmKTooegY9FOhPzg7k8y1G6twR2Ly8JF5zOflbqOPhWiEwET
         9TOA==
X-Gm-Message-State: AJcUukck9ycfKC5sjHo2snI7JrAtnc1W7abP3ElztTpnwMpCBZ3vgMC1
        XRhrJ6t9OcDZJSMV1p/S9gRz3wLD5FDUB0tGbLmKkw==
X-Google-Smtp-Source: ALg8bN6flq5cpcOysaQyDufMNPZaG7OYQIMOsLwIGpwmXtgA+6VraSLvMNeSjZgwrE60p+v9iQ0KfeWHQ8MwaVJQC/4=
X-Received: by 2002:a19:4287:: with SMTP id p129mr21547364lfa.135.1548785394083;
 Tue, 29 Jan 2019 10:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20190127194415.171035-1-sxenos@google.com> <20190127194415.171035-5-sxenos@google.com>
 <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1901290005390.41@tvgsbejvaqbjf.bet>
 <CAPL8ZiuKnvQd1tpbsT+xn2Dt0rMs_ggQKOSz_vMda3i1V1YfHQ@mail.gmail.com> <xmqqef8v8hqp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef8v8hqp.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 29 Jan 2019 10:09:42 -0800
Message-ID: <CAPL8ZiupbKuZMAymW8je9UJ61Tm5aoDcS1srQTf=y9iQEuPFoA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] evolve: Add the change-table structure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Works with me. I'll resubmit without the double casting next chance I
have to work on it. My long-term plan for that struct was to use the
memory pool for all allocations anyway. I think that should let me
implement it without moving objects around, which will make their
addresses stable. That should let me use pointers for everything,
without the ints - so I probably won't need the union.

On Tue, Jan 29, 2019 at 10:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Xenos <sxenos@google.com> writes:
>
> > Sorry, folks. I normally can't do any open source work on weekdays.
> > That also includes writing responses on the mailing list, so there
> > will normally be a week or two lag for me to iterate on this sort of
> > thing.
> >
> > Feel free to either include this fix or revert my patch if there's a
> > problem with it - just let me know what you selected. I'll roll with
> > it and either resubmit with the requested changes or submit the
> > requested changes as follow-ups.
>
> I think double casting Dscho did was not his ideal "fix" but he did
> it as a mere workaround to force the 'pu' branch to compile.  And I
> also agree with him that the double casting workaround is too ugly
> to live, compared to a union he suggests.  So I'd rather kick the
> branch out of 'pu' for now.
>
> Thanks, both.
>
> >
> >   - Stefan
> >
> > On Mon, Jan 28, 2019 at 3:08 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> Hi Junio,
> >>
> >> On Mon, 28 Jan 2019, Johannes Schindelin wrote:
> >>
> >> > On Sun, 27 Jan 2019, sxenos@google.com wrote:
> >> >
> >> > > +   new_item->util = (void*)index;
> >> >
> >> > This is not good. You are using a `long` here. The 80s called and want
> >> > their now-obsolete data types back.
> >> >
> >> > If you want a data type that can take an integer but also a pointer, use
> >> > `intptr_t` instead.
> >> >
> >> > But even that is not good practice. What you really want here is to use a
> >> > union of the data types that you want to store in that `util` field.
> >> >
> >> > This is not merely academic, your code causes compile errors on Windows:
> >> >
> >> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=400&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=430&lineEnd=440&colStart=1&colEnd=1
> >>
> >> Since Stefan did not grace us with an answer, Junio, could I ask you to
> >> squash this in (which is by no means a satisfactory fix, but it is a
> >> stopgap to get `pu` building again)?
> >>
> >> -- snipsnap --
> >> diff --git a/change-table.c b/change-table.c
> >> index 2e0d935de846..197ce2783532 100644
> >> --- a/change-table.c
> >> +++ b/change-table.c
> >> @@ -103,7 +103,7 @@ void change_table_add(struct change_table *to_modify, const char *refname,
> >>         new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
> >>
> >>         new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
> >> -       new_item->util = (void*)index;
> >> +       new_item->util = (void *)(intptr_t)index;
> >>         // Use pointers to the copy of the string we're retaining locally
> >>         refname = new_item->string;
> >>
> >> @@ -201,6 +201,6 @@ struct change_head* get_change_head(struct change_table *heads,
> >>                 return NULL;
> >>         }
> >>
> >> -       index = (long)item->util;
> >> +       index = (long)(intptr_t)item->util;
> >>         return &(heads->heads.array[index]);
> >>  }
> >>
