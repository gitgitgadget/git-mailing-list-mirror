Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD7C20899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbdHWTbP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:31:15 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33050 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdHWTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:31:14 -0400
Received: by mail-yw0-f170.google.com with SMTP id h127so6739915ywf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nP0E35PIfDTIT79ctZoSyMl+ShtHEoybUjIGtNlNc0o=;
        b=stYWJjE6Wa+Ckm+pS4geeS0kGW2kFr9daeZsqE84UxXq8TZ8a3ph93kGS5PalBRy2B
         s66ATdL+th33f2qlg6Uh4DSKQpyyIE0juHqdal5zLV6A0H4siXl47hPnZB0mw938bXNt
         kZhgE0/DpWttfLWfrOBNbrXQ4yVc93RTAzBzZ8jQOBOhqLfRn7kAj8PiMhmwfI+xkJ0c
         qyu9hldhRl85JGlnCKAEp92EiNQMgtmuswNICB4m/8t90ojOGzvyB1D4nqfuJm4VCGvn
         8J8eLM7j34oWvt1w9opiMIa0NubjCHnRzCOjeE+Kyn0ee9Xq9gs6G4aSO7BOftLAjIFB
         7plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nP0E35PIfDTIT79ctZoSyMl+ShtHEoybUjIGtNlNc0o=;
        b=S2WywhLHAJDk2x+4Dvjbc30zsIu1VG9XIXvh82wHokCxUqh+6L2bKNDt54KrjwK3fT
         Y3eqMWcQzcPvttBExnnecDJIN1k4gGs+hFlVDeOgzHbFgyBotrcmym6YlVhd9tljUUEv
         mExbOdQ7cL6FqAsvuXg0At6fbqd3xuoUnvw2cnUK9DZz1Hollx29ouzNG9zSm6GHbMaM
         uklEFdjvd/mxC0ocGuAu14sLFx3cDPYQ6tIIdE4dKIgZrkq0zd4lvt2HHsT72J4gBUHy
         4JIXwJftcr5h0ZUu6mpFRRxPJJvU/nikYyFKvbHFrUCkb/57qWl/zx4gKUkKPq719E83
         mLxw==
X-Gm-Message-State: AHYfb5gklzUDwGXgsNnauH1JX9ljqIEgDbwMdD+sVDwdIl/6Vx1XyTuN
        JInbupqZ3sdQ6vHkXhG1j5hrMA4MxCtO0kanlg==
X-Google-Smtp-Source: ADKCNb48P6jH/G3U0K7QjICB+1xhT93UqVaXi+Quxxt5/VDhQIY8oZHg3OC7gd6VxkSWsk7aD0yjao6y8mvS+dlJMQo=
X-Received: by 10.13.218.129 with SMTP id c123mr2859105ywe.175.1503516673527;
 Wed, 23 Aug 2017 12:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:31:13 -0700 (PDT)
In-Reply-To: <xmqqbmn6yu5u.fsf@gitster.mtv.corp.google.com>
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com> <20170823181506.8557-1-pc44800@gmail.com>
 <20170823181506.8557-3-pc44800@gmail.com> <xmqqbmn6yu5u.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:31:13 -0700
Message-ID: <CAGZ79kbTHkcK8-rwpJbwy-v3NcfvVq=TbvVRG189bq4S9w14GA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 2/4] submodule--helper: introduce for_each_submodule()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Prathamesh Chavan <pc44800@gmail.com> writes:
>
>> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
>> +                                   void *cb_data);
>> +
>>  static char *get_default_remote(void)
>>  {
>>       char *dest = NULL, *ret;
>> @@ -353,17 +356,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
>>       return 0;
>>  }
>>
>> -static void init_submodule(const char *path, const char *prefix, int quiet)
>> +static void for_each_submodule(const struct module_list *list,
>> +                            submodule_list_func_t fn, void *cb_data)
>
> In the output from
>
>         $ git grep for_each \*.h
>
> we find that the convention is that an interator over a group of X
> is for_each_X,

... which this is...

> the callback function that is given to for_each_X is
> of type each_X_fn.

So you suggest s/submodule_list_func_t/each_submodule_fn/

> An interator over a subset of group of X that
> has trait Y, for_each_Y_X() iterates and calls back a function of
> type each_X_fn (e.g. for_each_tag_ref() still calls each_ref_fn).

This reads as a suggestion for for_each_listed_submodule
as the name.

> I do not offhand think of a reason why the above code need to
> deviate from that pattern.
