Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845DE1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfFYJwz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:52:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45551 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFYJwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:52:54 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so1738727ioc.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NW7EPiBoB7Jc9tDnc3u3uP43LfvHY+d9w8EWquyr7Ds=;
        b=DRebOVpFiRMnV7AP21wiPJ8A6zLGIY3lirAfCqIfod8RnW+ApcAAlh7apot9SZjIFw
         ACoVuXAlSg9tPpSvDlHaBq3gyi6ooed5QxAueFd9+Ns16AsZm1PjXmDVOmLfXtmtrGyc
         KcKtdsj3FhbjkuFBVSdsIRnuXYwoCk4TNXjqrQOUBO7zEVs/DCPIf2g7B7GsAMWZ8vix
         6bgJHWTb9u+6BOA1K4ZfAV7z93YjYAyMTPwENnqgSSBAXY/mFc/OaL7OzifjXXyJckC0
         3qcxP+1wWfPrsBS9Zv7iHAu1fGk5uZMO8CaXdi321c/baA1Zns+Rqt2QNJ3f+nw2TYRa
         AMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NW7EPiBoB7Jc9tDnc3u3uP43LfvHY+d9w8EWquyr7Ds=;
        b=Onyr7qZjcrU4ZN2temhjBuFYBsb5LkYCAhiH+xQeUgySCFSJk2K1tc8Xy8FN0zQHhL
         tJ0bNR9edN1bqQkKg9eJ0EWirAvnmjK+fpjg7t4M16b8IjaUJyUmlBoOGKp+ZmNZNHme
         l49Js/u3590L2O/O/PBLXjdeoiLBEF+1NUt6rKOQFZJ0o95yx4rqJhHfZaAklddbFw9a
         SNArngtJjz8LV2+zfRwaNZKIBNrRnPTSweoxIXKg2Rcu7NulCsT2bMnnajW/7cnMr0P8
         9iFCj4B9xP1HAStQskVW1VxmT6I46O8Vak0vltevoHKflLcjijxGpxKPqQ4t2oAT9nGw
         HKwA==
X-Gm-Message-State: APjAAAXlVc7q1yslpQCxaS+JsHpGiKu+i4ogEeMCv9vIDWqTxF3WX6N5
        qFDkUlOUrWiVxh8A42Hnfgt13sN3gO/yTrws89c=
X-Google-Smtp-Source: APXvYqxC/nlkkS0upJZK0/0Q8f96xrMP/H7UwcLzUVAMFy4elEaWw91twCFGxdlABABrFp649ISwvqEP+TWE2P5Wm/U=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr59211789ior.277.1561456373789;
 Tue, 25 Jun 2019 02:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-2-pclouds@gmail.com>
 <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
In-Reply-To: <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 16:52:27 +0700
Message-ID: <CACsJy8CEaT7QGrOsoQw6k9H2A5DYW5ZJR1=Qs45TiJv+9sMBdQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 2:15 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
> > @@ -202,6 +202,28 @@ void jw_object_null(struct json_writer *jw, const char *key)
> >       strbuf_addstr(&jw->json, "null");
> >   }
> >
> > +void jw_object_filemode(struct json_writer *jw, const char *key, mode_t mode)
> > +{
> > +     object_common(jw, key);
> > +     strbuf_addf(&jw->json, "\"%06o\"", mode);
> > +}
> > +
> > +void jw_object_stat_data(struct json_writer *jw, const char *name,
> > +                      const struct stat_data *sd)
>
> Should this be in json_writer.c or in read-cache.c ?
> Currently, json_writer.c is concerned with formatting
> JSON on basic/scalar types.  Do we want to start
> extending it to handle arbitrary structures?  Or would
> it be better for the code that defines/manipulates the
> structure to define a "stat_data_dump_json()" function.
>
> I'm torn on the jw_object_filemode() function, JSON format
> limits us to decimal integers and there are places where
> I'd like to have hex, or in this case octal values.
>
> I'm thinking it'd be better to have a helper function in
> read-cache.c that formats a local strbuf and calls
> js_object_string(&jw, key, buf);

I can move these back to read-cache.c. Though if we have a lot more jw
helpers like this (hard to tell at the moment) then perhaps we can
have json-writer-utils.c or something to group them together. That
keep the "boring" code out of main logic code in read-cache.c and
other call sites.

> > @@ -1952,6 +1953,49 @@ static void *load_index_extensions(void *_data)
> >       return NULL;
> >   }
> >
> > +static void dump_cache_entry(struct index_state *istate,
> > +                          int index,
> > +                          unsigned long offset,
> > +                          const struct cache_entry *ce)
> > +{
> > +     struct json_writer *jw = istate->jw;
> > +
> > +     jw_array_inline_begin_object(jw);
> > +
> > +     /*
> > +      * this is technically redundant, but it's for easier
> > +      * navigation when there hundreds of entries
> > +      */
> > +     jw_object_intmax(jw, "id", index);
> > +
> > +     jw_object_string(jw, "name", ce->name);
> > +
> > +     jw_object_filemode(jw, "mode", ce->ce_mode);
> > +
> > +     jw_object_intmax(jw, "flags", ce->ce_flags);
>
> It would be nice to have the flags as a hex-formatted string
> in addition to (or instead of) the decimal integer value.

I'm not against reformatting it in hex string, but is there a value in
it? ce_flags is expanded in the code below so that you don't have to
decode it yourself when you read each entry. The "flags" field here is
for further processing in tools. I'm trying to see if looking at hex
values helps, but I'm still not seeing it...

> > +     /*
> > +      * again redundant info, just so you don't have to decode
> > +      * flags values manually
> > +      */
> > +     if (ce->ce_flags & CE_EXTENDED)
> > +             jw_object_true(jw, "extended_flags");
> > +     if (ce->ce_flags & CE_VALID)
> > +             jw_object_true(jw, "assume_unchanged");
> > +     if (ce->ce_flags & CE_INTENT_TO_ADD)
> > +             jw_object_true(jw, "intent_to_add");
> > +     if (ce->ce_flags & CE_SKIP_WORKTREE)
> > +             jw_object_true(jw, "skip_worktree");
> > +     if (ce_stage(ce))
> > +             jw_object_intmax(jw, "stage", ce_stage(ce));
-- 
Duy
