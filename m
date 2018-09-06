Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5A61F404
	for <e@80x24.org>; Thu,  6 Sep 2018 22:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIGCyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 22:54:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33465 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeIGCyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 22:54:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so10138263edv.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmZRkRlKvx4k4TYOv6kmSkMMwZ6X+ccifheIerMoVMM=;
        b=LLwElMnRrbwLjNiVQlwQSohiTjvixfohz8pADOkx3EzOonr6P0DOO4ZcxOk4hx81Dv
         xX+KxjSVu/pyaIJKUenzogZzlgDDyMZkrpFF4dBUMwTXWl0NyjQdBD6bcwpTKfeQoohL
         j5+QXzeU9JEOSRgRrubFKEjIfD6RnnMazAuWjsYqFNBKZgJ0hLDxI4bg85ILIuCanhHP
         8VuH9f7S9TTs3hkyWEvwy3sARv1NmOpHhSeVIQxSWy47Bu/p/uFqL+i05FydZT3YZXXt
         PFFFyC5MJZtpc+RqvrEruvVWjcGBov65dUtX7E0WkTYTtFZvsVTIMjYzWyt5TsXcUlrE
         bJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmZRkRlKvx4k4TYOv6kmSkMMwZ6X+ccifheIerMoVMM=;
        b=iY9kSr/uZmi69HvaOUFFhbgcETFos4pIlmSF3zF8GBFBFfnFU2RvTyVv/uTzF2e5Lv
         hlbajc608baJDHOi/zj0K9DsnjxGS5EbNilf67ib40X0UHYBhWZ+Row5yieFpJSTkv4F
         5t5brqikt+2r+RIPWLozdl0VrD37gtoo2Wz4d7TDyptaOXDE+Ys+XEjRQtxDz+hUOu3m
         z/pzyOgD2GxVcMxEkT+hJXZRvNWcHZ3E9ipk5/krN8i2aFXW1MZ5UGqx/Ghx/5aTzTMN
         Jazqn+x4Gm91gMH3FbyJ84tf/KIqA6sC+pEIiCg09cX/fEgQVY0K8ZJ9kcQ4zqr40p6+
         ecQA==
X-Gm-Message-State: APzg51DwX8xkF+JURDEyFrGu7RQOJbp8mQeRe+TJuxu7j1hkY+QCBIaJ
        SzxHcfq9kdhc9u63W8oITL6ZXnGl+XmmGco7rdosfE/3
X-Google-Smtp-Source: ANB0VdZZPnyG6RLQA3q96wJT+Y0Or/FBg1w/o/UepHLhd3Rb0G2f/eTDOL+Q9y7PIuZp9Z8iuJPAv2claczVFvqk+j0=
X-Received: by 2002:aa7:c314:: with SMTP id l20-v6mr5526917edq.53.1536272192953;
 Thu, 06 Sep 2018 15:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com> <20180904230149.180332-2-sbeller@google.com>
 <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com> <20180906165602.GA19367@sigill.intra.peff.net>
In-Reply-To: <20180906165602.GA19367@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 15:16:21 -0700
Message-ID: <CAGZ79kbRyVZ_1QpX0pPigN+2Pt2dV1eYvLyoWeSWejbLxko4YQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 9:56 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 06, 2018 at 09:52:28AM -0700, Junio C Hamano wrote:
>
> > Stefan Beller <sbeller@google.com> writes:
> >
> > > It is a debugging aid, so it should print to the debugging channel.
> >
> > ... and rename it with trace_ prefix.
> >
> > Use of trace_printf() is nice, as we can control its behavior at
> > runtime ;-)
>
> Yes, though...
>
> > > -void print_string_list(const struct string_list *p, const char *text)
> > > +void trace_print_string_list(const struct string_list *p, const char *text)
> > >  {
> > >     int i;
> > >     if ( text )
> > > -           printf("%s\n", text);
> > > +           trace_printf("%s\n", text);
> > >     for (i = 0; i < p->nr; i++)
> > > -           printf("%s:%p\n", p->items[i].string, p->items[i].util);
> > > +           trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
> > >  }
>
> It seems funny that we'd iterate through the list checking over and over
> whether tracing is enabled.
>
> Should this do:
>
>   if (!trace_want(&trace_default_key))
>         return;
>
> at the top? (Or possibly even take a trace key from the caller, so that
> it can use whatever context makes sense for this particular list?)

I added this check as well as rewording the commit message
to recite Junios understanding of the patch as well.

However I would want to not derail this patch any further.
This function was used as an aid by me some time ago, so I
am willing to share the modifications needed for efficient
printf debugging here, but I do not want to be dragged into
a rabbit hole.

For example taking the trace key is much overkill IMHO
for a pure debugging aid (and so is the shortcutting return
that you proposed, but I added that already for the resend),
so if anyone needs this function outside of printf-debugging,
I would recommend patches on top.

Thanks,
Stefan
