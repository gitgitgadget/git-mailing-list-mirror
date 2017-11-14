Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A020F1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbdKNUAu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:00:50 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:57140 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdKNUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:00:48 -0500
Received: by mail-qt0-f195.google.com with SMTP id r39so12328657qtr.13
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O+38uwsuM6SOizEoh4YeQ4ekWUOv9kZgMg7U1eJ+qXs=;
        b=N5sAa0nCnkIQPIUs+XITJh+bXNAP2nPYarFFriKoRxANBU78vLbavrD1TGGaehWUSi
         E1PbWMonDgkP0LtUG/gaJCJIA+S5Fhj/0Z6rB5zlaq6o/nwMBe/7GRJBQyC2ZltyQRRQ
         jdWpKmZFPzAZhu5tEP2HlbEcAhwDkKJFNOnH9JKZ04HVzy7bZScEsefkAXiy5ZdPWtFN
         7rs/IGvB109FWPCxjvAIpg1E3nWB+O9bogURxGryw9SWIY3GMiJTsItmGz+84n85M4Gc
         eRtz6qmHIJh9dBrokgKrS0oOYkB0vnxiqlX5j/kVr+9+0PM6/cUlOIftJ/ZelRVRch2L
         YJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O+38uwsuM6SOizEoh4YeQ4ekWUOv9kZgMg7U1eJ+qXs=;
        b=PYG2P8pxSFM0pyngKxhGZpDrHif9XrfOiog2l3O18Y2W2wudg8FHtOHPtxq6nocYsu
         JW/VIu4hPPVEAwd42qeqgGF230ZyqAvTrne8NCxeXrVHYWk087Om0xua1wargYrtmyrJ
         a7AbZysOHdjNgrjRzt99gocTuVApJu3kQEP20ssFHEUUxJPdRxGCm/zbZRx8hQP1pYOp
         891Weg+4QO3w+4eM7VpdVLOKoqaW7M/0gKasifBS5WVyz48aFfx4FVAPnPHV5G4WeZqH
         R9Rr25lCf1h5uLCl1HX4cg7oxnqGAbo6e4JxoS4T072h3E3YnLbD2FAMWF6x1QQbmwyz
         h8OQ==
X-Gm-Message-State: AJaThX5OCg6jSz26CJFmSNaPtGvFCa2IYEuQsYFlcoXSD3biBByQJl2j
        HQp6GPt0VZ3DVbGM1YiYsMa8anWmgbPlm4oeZ8Mw4b7X
X-Google-Smtp-Source: AGs4zMY+o+8pOxqjyNGtUoX7o4kMdNNBxGjkRaJ85vCbzNlxdVK0eauXP2snSuAW5D8jha1qMH5i+RxG4UdiR9bnI2g=
X-Received: by 10.200.55.37 with SMTP id o34mr9207489qtb.79.1510689647976;
 Tue, 14 Nov 2017 12:00:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 12:00:47 -0800 (PST)
In-Reply-To: <20171114115512.a3ba15c0325b1eefa2602984@google.com>
References: <20171031211852.13001-1-sbeller@google.com> <20171102194148.2124-1-sbeller@google.com>
 <20171102194148.2124-6-sbeller@google.com> <20171114115512.a3ba15c0325b1eefa2602984@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 12:00:47 -0800
Message-ID: <CAGZ79kaj86+hxfXqROAcSUdSTOY-8CuWFv=XRP3isD3PAx2fHA@mail.gmail.com>
Subject: Re: [PATCHv3 5/7] builtin/describe.c: print debug statements earlier
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 11:55 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu,  2 Nov 2017 12:41:46 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> For debuggers aid we'd want to print debug statements early, so
>> introduce a new line in the debug output that describes the whole
>> function, and then change the next debug output to describe why we
>> need to search. Conveniently drop the arg from the second line;
>> which will be useful in a follow up commit, that refactors the\
>> describe function.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/describe.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index fd61f463cf..3136efde31 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
>>       unsigned long seen_commits = 0;
>>       unsigned int unannotated_cnt = 0;
>>
>> +     if (debug)
>> +             fprintf(stderr, _("describe %s\n"), arg);
>> +
>
> Could you explain in the commit message why this wasn't needed before
> (if it wasn't needed), and why this is needed now?
>
>>       if (get_oid(arg, &oid))
>>               die(_("Not a valid object name %s"), arg);
>>       cmit = lookup_commit_reference(&oid);
>> @@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
>>       if (!max_candidates)
>>               die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>>       if (debug)
>> -             fprintf(stderr, _("searching to describe %s\n"), arg);
>> +             fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
>
> What is this arg that can be safely dropped?
>
> You mention that it is for convenience (since the describe() function
> will be refactored), but could the arg just be passed to the new
> function?

It could, but I want to avoid that just to print a debugging statement
inside the
function. So I factor the debugging printing out of the function
introduced in the
next patch.
