Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB63211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLCXfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:35:43 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34764 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLCXfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:35:43 -0500
Received: by mail-ed1-f46.google.com with SMTP id b3so12342137ede.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqIgbQWkYz83TmgIp7wMpSjAYZ8kJtu3gWt0VqfJ5DY=;
        b=pcsv+rWQThG936Thn6Yq1vvs+VWvl1A10+bMKgjm98X4OufUNG+iSezLGHQENsFlPq
         sBIlUIdYnxuPAh6Dn2l8+7kmo+VBQf8CsdVluR6eo1X8D7raDiwExe6+9ueZQwWWL58x
         YAvCUWiTOKs3f9XD2M46CcryP7BVHSJGM+xGUhqJGA4W6AzJpeeCA/kvTNCQF2hteics
         YoXbUPys9tAJn2+XhzAkwufkPrVveG+qKUfORJMbcUIAeuM0EUsuOCkDGy+RvqQgwfpA
         cuZSpk3sPTZMJYjDYjl/R/V3v5rmqDdeAN7MjVbzicPdcR4yOHxBNei06OKi69OGltr0
         pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqIgbQWkYz83TmgIp7wMpSjAYZ8kJtu3gWt0VqfJ5DY=;
        b=k/DT/xbPYiytrLJjh8hz1kZ1WAFHPahndoH1KKICecxFlZddCmyx3ar0Gmf8SDQ/St
         tBRD6JN37lkKBPp2deWXnAYhwcMCy/mQCmsVtZUs9A1AdHyo7pcrdB2e5+Mm7/p9bWNE
         xGFQhAKIlkXbQQnFE3rfHAhIlg+nemY+BpQ1b8FkHyZtVBCgEUyu6wfNVGcWvvCimJ0j
         kkPvIjmX0UnAQhjO14FB4nlcyOl3raeJQrkjYgW4ULqppJqu2IWvVtvXsIV3bR8ukMTC
         g0cOp7znzoOr8wjo0SpPestxrHrxVuD5J6LJZAFIlDpVAPJPnDOH1EFTFes45hLRuuVn
         5pAg==
X-Gm-Message-State: AA+aEWY+Ox0PNiXz9cJvO26psgq4HXIkB8yMD+j5FoTYJj2mfcj6Ygzq
        iFTVnJVDJQykCLymH4dQEmpEkymkIjZrWY+R/nOHcA==
X-Google-Smtp-Source: AFSGD/Uhbhed8xiSkbIPvB7YXvzqqq8DveNaCn59hieVx91k3cXqoPZPyJEGoZW4hhBiguMWeTUZHDjyGEUu9PYtLlk=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr14310096eji.106.1543880140049;
 Mon, 03 Dec 2018 15:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20181203223713.158394-1-sbeller@google.com> <20181203232353.GA157301@google.com>
In-Reply-To: <20181203232353.GA157301@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 15:35:28 -0800
Message-ID: <CAGZ79kY0w7Zt0Z4KNu7qL4Lz8fFpv2p51D-w_MgZBYPqPFbZKw@mail.gmail.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 3, 2018 at 3:23 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

> I was curious about what versions of Gerrit this is designed to
> support (or in other words whether it's a bug fix or a feature).
> Looking at examples like [1], it seems that Gerrit historically always
> used "ERROR:" so the 59a255aef0 logic would work for it.  More
> recently, [2] (ReceiveCommits: add a "SUCCESS" marker for successful
> change updates, 2018-08-21) put SUCCESS on a line of its own.  That
> puts this squarely in the new-feature category.

Ooops. From the internal bug, I assumed this to be long standing Gerrit
behavior, which is why I sent it out in -rc to begin with.

> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -87,7 +87,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> >               struct keyword_entry *p = keywords + i;
> >               int len = strlen(p->keyword);
> >
> > -             if (n <= len)
> > +             if (n < len)
> >                       continue;
>
> In the old code, we would escape early if 'n == len', but we didn't
> need to.  If 'n == len', then
>
>         src[len] == '\0'

src[len] could also be one of "\n\r", see the caller
recv_sideband for sidebase case 2.

>         src .. &src[len-1] is a valid buffer to read from
>
> so the strncasecmp and strbuf_add operations used in this function are
> valid.  Good.

Yes, they are all valid...

> > -             if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> > +             if (!strncasecmp(p->keyword, src, len) &&
> > +                 (len == n || !isalnum(src[len]))) {
>
> Our custom isalnum treats '\0' as not alphanumeric (sane_ctype[0] ==
> GIT_CNTRL) so this part of the patch is unnecessary.  That said, it's
> good for clarity and defensive programming.

... but here we need to check for src[len] for validity.

I made no assumptions about isalnum, but rather needed to shortcut
the condition, as accessing src[len] would be out of bounds, no?

>
> >                       strbuf_addstr(dest, p->color);
> >                       strbuf_add(dest, src, len);

unlike here (or the rest of the block), where len is used correctly.
