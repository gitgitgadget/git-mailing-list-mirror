Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A6C35DEA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A195B2176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNx2+hWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBXXuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:50:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42874 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 18:50:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so14021255edv.9
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 15:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FcnzAcYb9N4d/zPjqiqVC6zDh9DKYOAv9ggNZMZvmc=;
        b=PNx2+hWQKlbKms4wU8FRE+XnRRwoQRVUp6kKapEMocWhqCOpZvNj7yzTaaDgpYGNK1
         tyu/0xu7Eo0zfuODFRUARhjaywLO+UuS5P9oFyGsbE7NA4kZ0z2u4R1GY1rE91K273Pu
         NSLUSv5bup48077w1JLqNidSZ0arK2iL3zWnJczUGv5tXyxlQEnA5R9b7cNihHB0GnsN
         2qsczB3xJBvTKjbvOdnuiTc+haU2nI/29Cq2D0fiwpWYu7etRvEfqsXCqzeV+PDvZZ76
         uBH7DmIzZnPXv6vbF5mI7Jw9UpYxYPhpUmG5ZwfV7XuvKgiony6Epj/bTLtwSomeHYRr
         6KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FcnzAcYb9N4d/zPjqiqVC6zDh9DKYOAv9ggNZMZvmc=;
        b=trTilYFvvPM1KkVNfqehk9f2xu3UJCh1Sue1L8tdjYC34ghncyZvAqtlT67cQXWiUk
         5nMXMKde02Yl9gtbz25gitkrFWhHAabZRd7ZzQAFvjuI4V+Z/+lY7zYng6DCUB2mVtd1
         yIdkxF7JaSu0pQsH3RtWigwZX23U0BadJSLpLfJYDkpSNU1KrOuxnxHNwkN58V6e7iHG
         P2Kxmw0AuNVMGJDOo9mcfExuGZKpq8RSN1pEpvhO59WAIsflCSqCg2PGX7kQ0bJ3yqSi
         AbLnIcW8MSUz7tLezjxO6UUIgFRtg0Z9nnDkQ49Z08SH16eczSBja74tcGRvOaz+Pk2K
         UXtA==
X-Gm-Message-State: APjAAAWda1r3bXTY8QNdWuB2a4epBJ/5XzwAvER1KJ7L8BIeQYTzdh/r
        Fppm9chpikRjeWviUiANttTWdT5E91AWEE2HLEs=
X-Google-Smtp-Source: APXvYqxaUwCw3YfuHwxZWv9xc25pAZyJ9zhuqFhEnqbL8Y4Z4OFCNqlqFoisUEiYyIITM04ORv3CYgVeduK3n9sLt8c=
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr47568276ejb.367.1582588208549;
 Mon, 24 Feb 2020 15:50:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com> <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
 <xmqqftezod3n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftezod3n.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 25 Feb 2020 12:49:57 +1300
Message-ID: <CACg5j25XQLC1bYxm4244UQddL5AVENg-0XwJQFvLpdQ-n1hVqg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 11:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -static void vadvise(const char *advice, va_list params)
> > +static const char *advice_config_keys[] = {
> > +     [FETCH_SHOW_FORCED_UPDATES]              = "fetchShowForcedUpdates",
> > +     [PUSH_UPDATE_REJECTED]                   = "pushUpdateRejected",
> > +     /* make this an alias for backward compatibility */
> > +     [PUSH_UPDATE_REJECTED_ALIAS]             = "pushNonFastForward",
> > +...
> > +     [CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]  = "checkoutAmbiguousRemoteBranchName",
> > +     [NESTED_TAG]                             = "nestedTag",
> > +     [SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
> > +};
>
> Terminate the last entry of the array with a trailing comma ',', so
> that the next person who adds one new advise key to the table at the
> end has to just add only one line without changing any existing lines.
>

Sure, thank you for the explanation, that makes sense.

> As you are using the designated initializers for this array, we are
> free to order the lines in any way that makes most sense to us and
> do not have to order the lines in numerical order.  In what order
> are these lines sorted right now?  I am tempted to suggest that we
> should sort alphabetically on the values, i.e. run the contents of
> the table through "LC_ALL=C sort -k2,2 -t=".
>

Currently it's sorted in the same order that was originally used for
advice_config[] and the global variables, which I assume is the order
in which every config variable was added to the code. Sorting
alphabetically will be neater of course.

> > +
> > +static const char turn_off_instructions[] =
> > +N_("\n"
> > +   "Disable this message with \"git config %s false\"");
> > +
> > +static void vadvise(const char *advice, va_list params,
> > +                 int display_instructions, char *key)
>
> It may be just me, but I feel uneasy when I see va_list in the
> middle of the parameter list.  As it is a mechanism to allow us
> handle "the remainder of the arguments", it logically makes more
> sense to have it as the last parameter.
>

I don't mind it either way, so yeah no problem, I'll change that.

> >  {
> >       struct strbuf buf = STRBUF_INIT;
> >       const char *cp, *np;
> >
> >       strbuf_vaddf(&buf, advice, params);
> >
> > +     if(display_instructions)
> > +             strbuf_addf(&buf, turn_off_instructions, key);
>
> Style.  We always have one SP between a syntactic keyword like "if"
> and open parenthesis.

Noted.

>
> > +
> >       for (cp = buf.buf; *cp; cp = np) {
> >               np = strchrnul(cp, '\n');
> >               fprintf(stderr, _("%shint: %.*s%s\n"),
> > @@ -119,8 +161,42 @@ void advise(const char *advice, ...)
> >  {
> >       va_list params;
> >       va_start(params, advice);
> > -     vadvise(advice, params);
> > +     vadvise(advice, params, 0, "");
> > +     va_end(params);
> > +}
> > +
> > +static int get_config_value(enum advice_type type)
> > +{
> > +     int value = 1;
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
>
> Have a blank line between the decl and the first statement, i.e. here.
>

Right, I missed this one.

> > +     git_config_get_bool(key, &value);
> > +     free(key);
> > +     return value;
> > +}
> > +
> > +int advice_enabled(enum advice_type type)
> > +{
> > +     switch(type) {
>
> Style.

Noted.

>
> > +     case PUSH_UPDATE_REJECTED:
> > +             return get_config_value(PUSH_UPDATE_REJECTED) &&
> > +                    get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
> > +     default:
> > +             return get_config_value(type);
> > +     }
> > +}
> > +
> > +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> > +{
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> > +     va_list params;
> > +
> > +     if(!advice_enabled(type))
>
> Stile.

Takes time changing the style I've been using for years, sorry.

>
> > +             return;
> > +
> > +     va_start(params, advice);
> > +     vadvise(advice, params, 1, key);
> >       va_end(params);
> > +     free(key);
> >  }
> >
> >  int git_default_advice_config(const char *var, const char *value)
> > @@ -159,8 +235,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
> >  {
> >       int i;
> >
> > -     for (i = 0; i < ARRAY_SIZE(advice_config); i++)
> > -             list_config_item(list, prefix, advice_config[i].name);
> > +     for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
> > +             list_config_item(list, prefix, advice_config_keys[i]);
> >  }
> >
> >  int error_resolve_conflict(const char *me)
> > diff --git a/advice.h b/advice.h
> > index b706780614d..61a7ee82827 100644
> > --- a/advice.h
> > +++ b/advice.h
> > @@ -32,9 +32,61 @@ extern int advice_checkout_ambiguous_remote_branch_name;
> >  extern int advice_nested_tag;
> >  extern int advice_submodule_alternate_error_strategy_die;
> >
> > +/**
> > + To add a new advice, you need to:
> > + - Define an advice_type.
> > + - Add a new entry to advice_config_keys list.
> > + - Add the new config variable to Documentation/config/advice.txt.
> > + - Call advise_if_enabled to print your advice.
> > + */
>
>     /*
>      * Our multi-line comments should look
>      * more like this (multiple style violations
>      * in this patch).
>      */
>

Got it.

> > +enum advice_type {
> > +     FETCH_SHOW_FORCED_UPDATES = 0,
> > +     PUSH_UPDATE_REJECTED = 1,
> > +     PUSH_UPDATE_REJECTED_ALIAS = 2,
> > +     PUSH_NON_FF_CURRENT = 3,
>
> Do we need to spell out the values, or is it sufficient to let the
> compiler automatically count up?  Does any code depend on the exact
> numeric value of the advice type, or at least at the source code
> level the only thing we care about them is that they are distinct?
>
> I'd really want to get rid of these exact value assignments---they
> are source of unnecessary conflicts when two or more topics want to
> add new advice types of their own.
>

Yes, we can get rid of them.

> I also suggest that these are sorted alphabetically.

As we'll get rid of the value assignments, so sorting alphabetically
should not introduce problems when adding new advice types, will do.

> > + ...
> > +     SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
> > +};
>
> > +++ b/t/t0018-advice.sh
> > @@ -0,0 +1,28 @@
> > +#!/bin/sh
> > +
> > +test_description='Test advise_if_enabled functionality'
> > +
> > +. ./test-lib.sh
> > +
> > +cat > expected <<EOF
> > +hint: This is a piece of advice
> > +hint: Disable this message with "git config advice.nestedTag false"
> > +EOF
> > +test_expect_success 'advise should be printed when config variable is unset' '
> > +     test-tool advise "This is a piece of advice" 2>actual &&
> > +     test_i18ncmp expected actual
> > +'
>
>  - Prepare the expected output inside test_expect_success block that
>    uses it.
>
>  - There should be no SP between a redirection operator and the
>    filename.
>
>  - Here-doc that does not use parameter expansion should use a
>    quoted EOF marker.
>
>  - The file that gets compared with "actual" is by convention called
>    "expect", not "expected".
>
> i.e.
>
> test_expect_success 'advise should be printed when config variable is unset' '
>         cat >expect <<-\EOF &&
>         hint: ...
>         hint: ...
>         EOF
>         test-tool advise "This is a piece of advice" 2>actual &&
>         test_i18ncmp expected actual
> '

Noted.

Will send an updated version soon.

Thank you,
Heba
