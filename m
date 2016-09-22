Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238401F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934148AbcIVP5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 11:57:49 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35462 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbcIVP5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 11:57:47 -0400
Received: by mail-io0-f170.google.com with SMTP id m186so90143490ioa.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rh+C+L/1H3gl18qPFW0wFbd6HKoeiQnunEMpwy7Ov40=;
        b=NkKEYlC9DDDEhjwoVc5hQsGfYRa5VXgBxeblKctiNvpZT1WTOS3ISCekJ0nlAcRNMD
         pLwc3DEQXyeZ0LHGCjFD8kXK72ybHR8ZyBswxCvHxM2Z/ZHLBerGZFfeIbN954FeYq4O
         F7LaqoQog2ZlTR7nxmVEPwhTKlFK9aDxPAupNoPDIdkZGEgRKSFiotViuGOLi6gEUozL
         +4txxLtqX6/xscAlRXL2y6EXrxa5eJUj5w2HuH1x3N/bxTtNA+s7nh2oZEq7dR+MNrQ5
         H61EZPYFrpBvH1heh8m8EGWctZYgFZrY8OKaDUrWtHU6USbTXza6iBBjOtrAsvcV0GX1
         pWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rh+C+L/1H3gl18qPFW0wFbd6HKoeiQnunEMpwy7Ov40=;
        b=PNFK6+5F+xfxg9+/0g0iaX7JRqNWjQat7GXSO6F5jz9Fpr7qt1hO7H6Kra5/OgUsy2
         53vOdms9h/7MKkOB0itdYRNG0O3sXMsI3OSW2/BLJgCyvr0CVAKwVj6h2yb/KtyvLW+w
         L/zhTu4Qn+gGTD2FVePSc3oD0RUSTyCdWE3KlkYiIxxz6tcJmx9u+um8c7H8OMfa3a5I
         ripiv9XurIqgmJHrk0yn+HdsLRr0MSwSlGr7LoF8icb49CCvSuDX3jfr2zX2TRlBxKhK
         3CkekYJUk3/1cNx4EUieyDa5/r6xHijPV7tuxp760dOrYvQ6wzraOBmc/AeVa6Vtea5+
         y3pA==
X-Gm-Message-State: AA6/9Rm7iPla7IZw8H8eyhTd6eqe6jLJTExXLZLY1R3TEMcSbdwvoB43kSpBhr1/gh3TbjnuMhce7tb909+JPZvW
X-Received: by 10.107.180.11 with SMTP id d11mr4111220iof.203.1474559866313;
 Thu, 22 Sep 2016 08:57:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 08:57:45 -0700 (PDT)
In-Reply-To: <trinity-7a55c197-21af-4808-9919-6fc26bdcece2-1474536212197@3capp-gmx-bs75>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net> <20160920110700.GB64315@book.hvoigt.net>
 <20160920191555.GB1673@john.keeping.me.uk> <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
 <trinity-7a55c197-21af-4808-9919-6fc26bdcece2-1474536212197@3capp-gmx-bs75>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 08:57:45 -0700
Message-ID: <CAGZ79kYUcyCrjPfqWtyWE-kaqbQZPG1qosc3qJrDfHixivyFew@mail.gmail.com>
Subject: Re: Re: Re: Homebrew and Git
To:     Jonas Thiel <jonas.lierschied@gmx.de>
Cc:     Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 2:23 AM, Jonas Thiel <jonas.lierschied@gmx.de> wrote:
> Sorry for my late reply. Thanks for your support -- I really appreciate that.
>
> @Jeff: Unfortunately, I do not know how to implement the patch you provided. Can you explain how to do that?

I think this should do:


    git clone https://github.com/git/git
    cd git
    # get the email
    wget http://public-inbox.org/git/20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net/raw
    # apply patch:
    git am raw
    make
    make install

>
> Thanks and best regards,
> Jonas
>
>> Gesendet: Mittwoch, 21. September 2016 um 10:48 Uhr
>> Von: "Jeff King" <peff@peff.net>
>> An: "John Keeping" <john@keeping.me.uk>
>> Cc: "Heiko Voigt" <hvoigt@hvoigt.net>, "Jonas Thiel" <jonas.lierschied@gmx.de>, git@vger.kernel.org
>> Betreff: Re: Re: Homebrew and Git
>>
>> On Tue, Sep 20, 2016 at 08:15:55PM +0100, John Keeping wrote:
>>
>> > > BTW, here is the callstack inlined from the crashreport:
>> > >
>> > > bsystem_platform.dylib            0x00007fff840db41c _platform_strchr$VARIANT$Haswell + 28
>> > > 1   git                                   0x000000010ba1d3f4 ident_default_email + 801
>> > > 2   git                                   0x000000010ba1d68f fmt_ident + 66
>> > > 3   git                                   0x000000010ba4b495 files_log_ref_write + 175
>> > > 4   git                                   0x000000010ba4b0a6 commit_ref_update + 106
>> > > 5   git                                   0x000000010ba4c3a8 ref_transaction_commit + 468
>> > > 6   git                                   0x000000010b994dd8 s_update_ref + 271
>> > > 7   git                                   0x000000010b994556 fetch_refs + 1969
>> > > 8   git                                   0x000000010b9935f2 fetch_one + 1913
>> > > 9   git                                   0x000000010b992bc4 cmd_fetch + 549
>> > > 10  git                                   0x000000010b9666c4 handle_builtin + 478
>> > > 11  git                                   0x000000010b96602f main + 376
>> > > 12  libdyld.dylib                         0x00007fff834ef5ad start + 1
>> > >
>> > > Maybe someone else has an idea what might be causing this...
>> >
>> > The only strchr I can see that could be called here is in
>> > canonical_name(), where it's called with addrinfo::ai_canonname.
>>
>> There's one in add_domainname(), too, but it can never be NULL (we could
>> walk off the end of the buffer, but only if gethostname() lies to us
>> about its result code, which seems unlikely). So I agree it's probably
>> the call in canonical_name().
>>
>> > Searching for OS X and ai_canonname, leads me straight back to this
>> > list, although 7 years ago!  I think ident.c needs a fix similar to
>> > commit 3e8a00a (daemon.c: fix segfault on OS X, 2009-04-27); from the
>> > commit message there:
>> >
>> >     On OS X (and maybe other unices), getaddrinfo(3) returns NULL
>> >     in the ai_canonname field if it's called with an IP address for
>> >     the hostname.
>>
>> Interesting. We are already prepared for failure from getaddrinfo()
>> here, so probably:
>>
>> diff --git a/ident.c b/ident.c
>> index e20a772..d17b5bd 100644
>> --- a/ident.c
>> +++ b/ident.c
>> @@ -101,7 +101,7 @@ static int canonical_name(const char *host, struct strbuf *out)
>>       memset (&hints, '\0', sizeof (hints));
>>       hints.ai_flags = AI_CANONNAME;
>>       if (!getaddrinfo(host, NULL, &hints, &ai)) {
>> -             if (ai && strchr(ai->ai_canonname, '.')) {
>> +             if (ai && ai->ai_canonname && strchr(ai->ai_canonname, '.')) {
>>                       strbuf_addstr(out, ai->ai_canonname);
>>                       status = 0;
>>               }
>>
>> would be sufficient. Jonas, can you see if that patch helps?
>>
>> -Peff
>>
