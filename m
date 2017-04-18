Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1D0207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758365AbdDRXkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:40:11 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36358 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758361AbdDRXkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:40:10 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so3780967pge.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TeDQWcpKBzwCFub1+G+sXolcOR/DMTKPHIN5+772s3E=;
        b=fdpQdL6KkMRyMkJanjP9ha2d40JRy7RTBVrhLf1/w6h7DuaLkpp0XkebRxqHOcaEXd
         o1cWXO8N4TN9SK9FLQXRsmv7h1qXiK8FlX70ME8kgAKqC5cM4t6BbClgbTHp+wajOHK+
         owZCigRdh8npVkNQ/D7JVEYet29tlLqfdNnnn8dj+stzyhwKbL+zo8liwdgEZkBCE2Fr
         W3FxoibPMJMzRvhhj50HcSxwpYs5jhwD9Qaq1JsnR1DDZFrcfGIEQ1CCDS7/AD3lBAVm
         ndoYltuRdVQI84b0JFuADjLwlYYI5HC9AwgXpYNI0VxdtRM+5alcUGihAF9iuoVrJl6O
         /luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TeDQWcpKBzwCFub1+G+sXolcOR/DMTKPHIN5+772s3E=;
        b=c8mf2J2YzsDNh1hWD2/CKw54AuwiomZhDrm6SwbisQbswcyS7yySK7bIMjCbN6UI1K
         ShhqXo5BofmUnanc9zjkzNcmx2R/sTEbhLj0FKXcjavZ2nQGrglwS0WPx/x6ahwW/+/b
         SVDWMre3uF7D0WxCanYRNAES2BZmAfE1iiNC/axgqxukZMLQ1QmPovStgObYk9NTPPTk
         aPkD/9gLjlBqZvsl63X2gmxwDgKttX66vnGGBKzGm9f1W/SM8qtx3/h7auBxR+u3U6g1
         VQ9CoKs40yvj8meydPiRPB7qboDslBOnDiVcRas5ehaSAu5QxfYYExDb/0BuUauSQWtG
         uZwg==
X-Gm-Message-State: AN3rC/71h44Iesp6SNMQHJRFQIu12/iAbcspyPAS2n+3yGfWaYJs6/+Y
        gQ6rqhia3y0IbaNPjQjuvovY1jxYPAcA
X-Received: by 10.98.0.66 with SMTP id 63mr20263583pfa.145.1492558809075; Tue,
 18 Apr 2017 16:40:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 16:40:08 -0700 (PDT)
In-Reply-To: <20170418233637.GB41018@google.com>
References: <20170417220818.44917-1-bmwill@google.com> <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-6-bmwill@google.com> <CAGZ79kai79=yZc5ywmG_gYcPnva7C8zVY7oGVqHR39TTyq_O-w@mail.gmail.com>
 <20170418233637.GB41018@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 16:40:08 -0700
Message-ID: <CAGZ79kYJ0hwc7ykH4_aHSUodawUXnhDNvN11Vz0Jc4bf1pzM7Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] string-list: add string_list_remove function
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 4:36 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/18, Stefan Beller wrote:
>> On Tue, Apr 18, 2017 at 4:17 PM, Brandon Williams <bmwill@google.com> wrote:
>>
>> >
>> > +void string_list_remove(struct string_list *list, const char *string,
>> > +                       int free_util)
>> > +{
>> > +       int exact_match;
>> > +       int i = get_entry_index(list, string, &exact_match);
>> > +
>> > +       if (exact_match) {
>> > +               if (list->strdup_strings)
>> > +                       free(list->items[i].string);
>> > +               if (free_util)
>> > +                       free(list->items[i].util);
>> > +
>> > +               list->nr--;
>> > +               memmove(list->items + i, list->items + i + 1,
>> > +                       (list->nr - i) * sizeof(struct string_list_item));
>> > +       }
>>
>> Looks correct. I shortly wondered if we'd have any value in returing
>> `exact_match`, as that may save the caller some code, as I imagine the
>> caller to be:
>>
>>   if (!string_list_has_string(&list, string))
>>     die("BUG: ...");
>>   string_list_remove(&list, string, 0);
>>
>> which could be simplified if we had the exact_match returned, i.e.
>> the string_list_remove returns the implicit string_list_has_string.
>
> I don't really see the value in this, as the only caller doesn't need it
> right now.

yeah, I guess we can add such functionality later.

>
>>
>> >  /*
>> > + * Removes the given string from the sorted list.
>>
>> What happens when the string is not found?
>
> nothing.

yeah that is what I figured from reading the code. The question could
have been worded: Do we want to document what happens if the string
is not found? (A reader in the future may wonder if it is even allowed to
call this function without having consulted string_list_has_string).

>
>>
>> > + */
>> > +void string_list_remove(struct string_list *list, const char *string, int free_util);
>>
>> How much do we care about (eventual) consistency? ;)
>> i.e. mark it extern ?
>
> If I need to do another reroll I can mark it extern.

Thanks! This doesn't require a reroll on its own and all other patches
look sane to me.

Thanks,
Stefan
