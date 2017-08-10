Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7F1208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbdHJRit (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:38:49 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36617 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbdHJRis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:38:48 -0400
Received: by mail-lf0-f42.google.com with SMTP id o85so6587285lff.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oaoP2hLOHMAhwVvR8l/fo7Y4V4nZCQ6YKuyL68Gbzk0=;
        b=GouddC+hZKL0srowqeTSuODH8Hdr2ZbOtf+GvZdCpjn54ODWqYR+SlifwM75G/RgwR
         k6ypIX0PrVDpGkcKP3MXc+jc6GPyZEKy71uztu8FS6qSs1fPkHrw5MWuZV8fs5Our3uE
         rgYwBEknklooQZSjg0DUojg+iCBRST5jPuuwR7Yu7jznfzl/WMdsxYBH9LsDVY6Wd79d
         sVaGWhTozBaObkw3RLx2qI4mWUagGkGKHQo0bkEqscn0NQHRS4eeGKuXz7shT3aTLAGK
         le0IYTyr59Fqo7+J0VNufLqvrDe15O37argRe9EWNKa5ctwvTVvuoyo/xPJ9MN1r/Ufj
         5Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oaoP2hLOHMAhwVvR8l/fo7Y4V4nZCQ6YKuyL68Gbzk0=;
        b=eCqKSu/0hn1kH0xVAbRAx0O+/iRz6k+xbKKYU++ZAe1USPla49JcBRDT1UlTo/GiU5
         Sb5dVhPDzMJhWCuMK+Az/FFxR+P2CO0yJnQYJCo7ciaaOcvArl4kgq1KV5Dg779VBZO5
         S85DmBykGosy+JPPnSmMtsBeSl1/lI1JNkGnpMjANOlDjs99mr4CzAlLgZ3CX1SO1XsY
         FMjegFr+le4XkauI4qT+nbVNqFAo5n/KoUBlPHr0HH4qHnWVXRXs3crh9U5fn8m8f3+n
         QUw2kPJgBXQ/m5d3OGYLg32BEKpJSe/shDge4JgrCcRmz0iZXO+oJbXT1pDxLpxN5EdA
         JmJg==
X-Gm-Message-State: AHYfb5jvsVQ9+YNhztAxsPYlW6Kt9dquv5gwUP4184RJ93DB4Hnkeb22
        T/kJzcVWsbEgdJWYqyEQUYQcNVQOGndC
X-Received: by 10.46.69.6 with SMTP id s6mr4334504lja.40.1502386726557; Thu,
 10 Aug 2017 10:38:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 10:38:45 -0700 (PDT)
In-Reply-To: <20170810173328.xfrswan6tijwkaex@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net> <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
 <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net> <CAGZ79kYHPhaZLSsBq2vM=D+_QMP9MY=xYjRwfG5q36neFyNH3w@mail.gmail.com>
 <20170810173328.xfrswan6tijwkaex@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 10:38:45 -0700
Message-ID: <CAGZ79kaAK-kKTw37S6OtvecmiXyS4XJF9BH=LDXi67cUxA_JHg@mail.gmail.com>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:33 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 10, 2017 at 10:27:19AM -0700, Stefan Beller wrote:
>
>> > I'm not fond of that, as it's vague about which exact trailers we're
>> > talking about. I also thought of something like --verbatim, but I'd
>> > worry that would seem to conflict with --normalize.
>> >
>> > I dunno. All of the names seem not quite descriptive enough to me.
>>
>> I meant 'exact' as in 'exactly from the patch/commit, no external
>> influence such as config', so maybe '--from-patch' or '--from-commit'
>> (which says the same as --no-config just the other way round.
>> Having --no- in config options as the standard is a UX disaster
>> IMHO as then we have to forbid the --no-no-X or reintroduce X
>> and flip the default)
>
> Yes, that was definitely the other reason I didn't want to call it
> "--no-config".  :)
>
> It's not always from a patch or commit. The most accurate along those
> lines is "--from-input".
>
>> Maybe --genuine ?
>
> But in the greater context I think that's vague again; we don't know
> which part of the command's operation is "genuine".

The input of course. ;) --genuine-input.

>
> Perhaps "--exact-input" hits all of those. Or maybe "--only-input" to
> match the other "--only".
>
> I think I like that last one the best. It makes it clear that we are
> looking just at the input, and not anything else. Which is exactly what
> the feature does.

Makes sense to me,

Thanks,
Stefan
