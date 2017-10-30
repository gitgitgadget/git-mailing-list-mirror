Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406F2202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbdJ3Rbe (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:31:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46974 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbdJ3Rbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:31:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id 1so17401759qtn.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WYNgVOGpSm3xcF6shpQLAcRttpvGuKSopn/lSsfhrt4=;
        b=hNjhxYG3bPIZw4RT+1SuMjZe/QW4SiqMkZ5ZwfulgiRlESIhjD0PLMzzDA0Pw/HhyJ
         LRSOiEKLcr0JXUnrJ5tPdXbe1lcJOO8r1jIwqwlBy54oW5vTJHBccH1NGoYtbisc51FK
         8RGVked6t2bkBhyfOdJRY9qco8qqjKCPew8KWBvXSIUquq1RFwrE0eMD0xDluNq7+q0h
         8wBbF7ZO9j8W8SNz7nj8UyY/xpHhnr1te2tiDM2J96QuCuopyiaCrOXGcvEb1RvWv4Kx
         TBoGzLIOO+BvFdKB/Ft983MObHyOGkGP+h4M+Pl5E5r1fshz8oCl+Zs14BZTjEvJ0KBX
         Sung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WYNgVOGpSm3xcF6shpQLAcRttpvGuKSopn/lSsfhrt4=;
        b=tp/vxECVDKWZ8+E++6C2BJFFi8i5jKaPAlHdJZXa4gTza5C53ORtQqAhc2vOV4KOef
         mClc00P65+jhO8U6ZwkcNZKtjDqZ6KuQeVygLmeqGfu16MYS6JD2OO4uSn6//RQe7MKi
         v8rsnWgQhB8EwjRUx7blB3sEg9ESUyXZggC74hsbDUPuWWTE6kga6s9W5oHr1bxit5Al
         dJkFTaBiwpJ8MVG1PV+2n3olVwd923a9NctbpCB9FgJq9DqOziYvtmJhBsldLPzNnRae
         ufGZl0EQgdnpli1MUCuiGfQJPm+T51V2It4Srht0/fKEyby+xvM5Djv5JavK51oRaONk
         Kkmw==
X-Gm-Message-State: AMCzsaVNlPKmRp6ByvJctNFZ39PvEP/zG4hGUf+eQJkHfuATMoJ4mPFs
        /NMsJ7nzqsFPbeKrFiLXGRMSuaJJF5gUumn+pZA=
X-Google-Smtp-Source: ABhQp+T/td3rPIzlEJyRFlb0c9QKy76Tb9ME4Mo7+H9FLj0wAN3O7cvpXJKy6DaNGnEZfl6lhGhTYlRgcquQF6COP1E=
X-Received: by 10.237.58.168 with SMTP id o37mr16162263qte.335.1509384693391;
 Mon, 30 Oct 2017 10:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:31:32 -0700 (PDT)
In-Reply-To: <af5f503a-6c2c-436f-ae74-cfbb11cb7a7f@gmx.net>
References: <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
 <af5f503a-6c2c-436f-ae74-cfbb11cb7a7f@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 23:01:32 +0530
Message-ID: <CAFZEwPMpsJAQP6ZGNUTi+A_27o7_mMRD8p=3RAf0fywjOjY0vA@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 6/8] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Mon, Oct 30, 2017 at 10:04 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> On 10/27/2017 05:06 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 0f9c3e63821b8..ab0580ce0089a 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
> [...]
>> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>> +{
>> +     int i;
>> +
>> +     if (get_terms(terms))
>> +             return error(_("no terms defined"));
>> +
>> +     if (argc > 1)
>> +             return error(_("--bisect-term requires exactly one argument"));
>> +
>> +     if (argc == 0)
>> +             return !printf(_("Your current terms are %s for the old state\n"
>> +                              "and %s for the new state.\n"),
>> +                              terms->term_good, terms->term_bad);
>
> Same as in 1/8: you probably want "printf(...); return 0;" except there
> is a good reason.

No good reason. I will make the change.

>> +
>> +     for (i = 0; i < argc; i++) {
>> +             if (!strcmp(argv[i], "--term-good"))
>> +                     printf(_("%s\n"), terms->term_good);
>> +             else if (!strcmp(argv[i], "--term-bad"))
>> +                     printf(_("%s\n"), terms->term_bad);
>
> The last two printfs: I think there is no point in translating "%s\n",
> so using "%s\n" instead of _("%s\n") looks more reasonable.

Also this probably does weird things with GETTEXT_POISON. I am
investigating what's happening as Martin pointed out in other thread..

>> +             else
>> +                     error(_("BUG: invalid argument %s for 'git bisect terms'.\n"
>> +                               "Supported options are: "
>> +                               "--term-good|--term-old and "
>> +                               "--term-bad|--term-new."), argv[i]);
>
> Should this be "return error(...)"?

Yeah. I missed this

>> +     }
>> +
>> +     return 0;
>> +}
>> +
>
> Stephan

Regards,
Pranit Bauva
