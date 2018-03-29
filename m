Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAE61F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeC2SMf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:12:35 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40324 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754222AbeC2SMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:12:33 -0400
Received: by mail-oi0-f49.google.com with SMTP id x9-v6so5934037oig.7
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lx1Gl23BCvcdLACwz7WwbZp3e0RfCWB5LAT0h/NLHPQ=;
        b=dYIDKFs2BqIuWfHAozrUiFemG51Bb2noafqc7+RJZEGybPi4Rp95joeWHhVYRM+1tR
         mhkhaLm69kzV82fohQgp1mf2bklVfpcf5gUGN2j3KMXI0j6tMOhuRojfzTEE8K9JvfGQ
         0pbGf4zqK7g2nd2TaVcUNWMLh6o58828fPOdqmOA3ClrKEqRPRNaUaOTkQc1up/jCBm+
         GVORbP1Ixr9zmJxcASGoZoS76y6kyeLewAemBpvAuFY0aG6vo/I0QjmWwxefn9vFS7Sw
         b87VrLWW/ZVzFSXCoGjCm34Xm4wagKQsE01B35EI58/m6hVBKtb8hiq9jTEnWdGw4s7h
         htfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lx1Gl23BCvcdLACwz7WwbZp3e0RfCWB5LAT0h/NLHPQ=;
        b=fIYsc0pRYx06Xz4cr1bEBIP9THJ29w86WvvvaWJxffgJ0rN6nuDU3DauT0Aj1MvS/F
         qfbEXmORuLAmI8u2Lbxgl7VqYqqZ0QXE4Z+7/Z6pv91nRwrSqNczJEBwsh9sAqLjsU7R
         Z3MC5dJR2XdJ/+GgN73G4qTLGZtLRsiFakYHXPfbmdxwJyF9NP41NSaUMkf7Sbh3LDXY
         qcRf8TWa30SXxtMtSQ9TssWwsbUoq/RIqPuYEMjsIeFMTIqn+zTb1lNdion/PaeHgDwl
         NDugmYja0JbC438A6eypT6OSPDJnEZI9NeEk0efo6fDdmH3oG7m0ho7dVniKFgSm03da
         0D8Q==
X-Gm-Message-State: ALQs6tCpVg9PYt6GkUIdRXF5QF/anAKgZqZPlPmB9K2YjkYG01tOSA2c
        dzg0AIOfvXvC5FL+p/JWxH4m8UOLy8H/SkcTPv0=
X-Google-Smtp-Source: AIpwx4/WjNejEMQ7OGlU/nZhlojzPqCpnPsSCyMPmvFM4E9SWiqNDpoNJfgSpe5Jb3F/rptTR6YxKXCNk3kIZohhYEM=
X-Received: by 10.202.74.83 with SMTP id x80mr5199572oia.228.1522347152303;
 Thu, 29 Mar 2018 11:12:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Thu, 29 Mar 2018 11:12:01 -0700 (PDT)
In-Reply-To: <20180329174820.GB31833@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174041.GB16274@sigill.intra.peff.net>
 <CACsJy8CCvshwb8a5ZozJ+x0D1kAYbeLSgJ0LDm4Z=uUZLtpsjg@mail.gmail.com> <20180329174820.GB31833@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Mar 2018 20:12:01 +0200
Message-ID: <CACsJy8BUBim-yKgxxGicohPMr6fHOFB0ANFnZjMqnGFk1iaQHQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] add chdir-notify API
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 7:48 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 29, 2018 at 04:53:42PM +0200, Duy Nguyen wrote:
>
>> On Wed, Mar 28, 2018 at 7:40 PM, Jeff King <peff@peff.net> wrote:
>> > +static void reparent_cb(const char *old_cwd,
>> > +                       const char *new_cwd,
>> > +                       void *data)
>> > +{
>> > +       char **path = data;
>>
>> Maybe check data == NULL and return early. This is just for
>> convenience, e.g. instead of doing
>>
>> path = getenv("foo");
>> if (path)
>>     chdir_notify_reparent(&path);
>>
>> I could do
>>
>> path = getenv("foo");
>> chdir_notify_reparent(&path);
>
> You'd need to xstrdup(path) there anyway. I guess you could use
> xstrdup_or_null(), but it seems somewhat unlikely (unless your work on
> top really does add such a callsite?).

It actually exists in 'next', repository.c where we have this line

    repo->alternate_db = xstrdup_or_null(o->alternate_db);

> I guess it's not that much code to be careful, though.

>> > +void chdir_notify_reparent(char **path)
>> > +{
>> > +       if (!is_absolute_path(*path))
>>
>> I think this check is a bit early. There could be a big gap between
>> chdir_notify_reparent() and reparent_cb(). During that time, *path may
>> be updated and become a relative path. We can check for absolute path
>> inside reparent_cb() instead.
>
> My thinking was that we'd be effectively zero-cost for an absolute path,
> though really adding an element to the notification list is probably not
> a big deal.

I think we could leave such optimization to the caller. I'm ok with
keeping this "if" too, but you may need to clarify it in the big
comment block in chdir-notify.h because this behavior to me is
surprising.

> I also assumed that whoever changed it to a relative path would then
> install the notification handler. One thing that my series kind of
> glosses over is whether somebody might call any of these functions
> twice, which would involve setting up the handler twice. So e.g. if you
> did:
>
>   set_git_dir("foo");
>   set_git_dir("bar");
>
> we'd have two handlers, which would do the wrong thing when the second
> one triggered. I hoped we could eventually add a BUG() if that happens,
> but maybe we should simply do a:
>
>   static int registered_chdir;
>
>   if (!registered_chdir) {
>         chdir_notify_reparent(&path);
>         registered_chdir = 1;
>   }
>
> at each call-site. Another alternative would be to make it a noop to
> feed the same path twice. That requires a linear walk through the list,
> but it's a pretty small list.

Well, given the number of call sites is rather small at the moment, I
think chdir-notify can just stay dumb and let the caller deal with
duplicate registration. One thing I like about your linked list design
though, is it makes it quite easy to remove (or even update) a
callback. You can simply return the (opaque) pointer to the entire
chdir_notify_entry as a handle and we can free/unlink the entry based
on it. It's kinda hard to me to do it with array-based design.
-- 
Duy
