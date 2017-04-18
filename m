Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E638F207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758258AbdDRXgm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:36:42 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36722 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758136AbdDRXgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:36:40 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so3748889pge.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NlH5OO1CEgSLbya5x4Eg30bM0q44lYx223K+79AC2Q=;
        b=fofMso26UzpIAnZ81CbZOgNSuh7lGBaJNx2grbF8AkHA+YhCo2MnjCxFBbT+zD6vH9
         K5C2/VKMhCC5FN0F/ANG9ZKz6DspTtysOssfqKpUje8c3el06ZaHwhjWBwEIWGCYkrCM
         5dCwW2gdFAp1ytrW8NBSVicQ0llGP5UjEaqB310+RMjZTS+KUK/0aqtuui52yKzpoOee
         4tCdduz60Mm4Shtr9I1/ZzUmpsVQpaLLxYwV2mn0J+jYSSJCkRtdOuZVOhz3itGSjCwu
         7y8JeUCwJbAOUmECkcXczbr1NJv0RxdDl8ooqwWIXipG8pg+rvpgY3BRFptzKcEm2rQa
         nWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NlH5OO1CEgSLbya5x4Eg30bM0q44lYx223K+79AC2Q=;
        b=KVRrQxJVET9x++yI2h0LhLCrLpoeXzaD8cNhl7RKHbnMUn1uNkQA2HdjXlEZQgRKNC
         FJ5vyAygh41myJIMreDnJ77cgt34P6CEv21rm2n9gAHz6sGqN/LpdCfSctL0f/Pc20RB
         fvAmFZ7T3R7Zt1eQiSvbo13RYuqdyeoT5JJXsnkNgIUg3cRroGXWCcYHTJHyFY8/HGCP
         ULv/YGYK4gkTEJekD0hBvI/ByT7uJwu6heLGk5zjOOUHdVzzs6on7CTgmUpDodxgZAPO
         iEGVhekTB+igVDXhQww/iQ4EmEGFVSwqKck2A/0bYwwP/eFVBwjVCR5s2OpXz8ioIIYs
         YYMw==
X-Gm-Message-State: AN3rC/7WsiwuHwTKfN6QSeekiKR8zAYxamzr6/HXHff1WJvkg5eYAxRp
        +G31LXomEEn9iXVO
X-Received: by 10.84.179.193 with SMTP id b59mr13408plc.56.1492558600097;
        Tue, 18 Apr 2017 16:36:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c085:9655:b875:4bbf])
        by smtp.gmail.com with ESMTPSA id z5sm531769pff.73.2017.04.18.16.36.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:36:39 -0700 (PDT)
Date:   Tue, 18 Apr 2017 16:36:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 05/11] string-list: add string_list_remove function
Message-ID: <20170418233637.GB41018@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-6-bmwill@google.com>
 <CAGZ79kai79=yZc5ywmG_gYcPnva7C8zVY7oGVqHR39TTyq_O-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kai79=yZc5ywmG_gYcPnva7C8zVY7oGVqHR39TTyq_O-w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/18, Stefan Beller wrote:
> On Tue, Apr 18, 2017 at 4:17 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> >
> > +void string_list_remove(struct string_list *list, const char *string,
> > +                       int free_util)
> > +{
> > +       int exact_match;
> > +       int i = get_entry_index(list, string, &exact_match);
> > +
> > +       if (exact_match) {
> > +               if (list->strdup_strings)
> > +                       free(list->items[i].string);
> > +               if (free_util)
> > +                       free(list->items[i].util);
> > +
> > +               list->nr--;
> > +               memmove(list->items + i, list->items + i + 1,
> > +                       (list->nr - i) * sizeof(struct string_list_item));
> > +       }
> 
> Looks correct. I shortly wondered if we'd have any value in returing
> `exact_match`, as that may save the caller some code, as I imagine the
> caller to be:
> 
>   if (!string_list_has_string(&list, string))
>     die("BUG: ...");
>   string_list_remove(&list, string, 0);
> 
> which could be simplified if we had the exact_match returned, i.e.
> the string_list_remove returns the implicit string_list_has_string.

I don't really see the value in this, as the only caller doesn't need it
right now.

> 
> >  /*
> > + * Removes the given string from the sorted list.
> 
> What happens when the string is not found?

nothing.

> 
> > + */
> > +void string_list_remove(struct string_list *list, const char *string, int free_util);
> 
> How much do we care about (eventual) consistency? ;)
> i.e. mark it extern ?

If I need to do another reroll I can mark it extern.

-- 
Brandon Williams
