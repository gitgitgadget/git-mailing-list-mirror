Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DDF1F51C
	for <e@80x24.org>; Wed, 23 May 2018 05:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeEWFd1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 01:33:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34600 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEWFd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 01:33:27 -0400
Received: by mail-io0-f195.google.com with SMTP id p124-v6so21337136iod.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F0RxkuPq6e9Po1j/wJDqvmmaTB6ODdlVVLKKtrkzqCI=;
        b=W5gwdrrgd+JBEmgvzSp8xasop+/U79bGrR3CEDhqGO2Xo7rhM7ONFOuDJEM83VYtrP
         Rt+SjsLkQoNeAOEYIfglcEhGGEvOsVQh0BCHjwi7g530bWVOtx17N3AQodOLI40txaGd
         iZOQXq7wd9nocvera9ifBLNG8EX/BN+xKJuMapbiOvKM9KvH1UqPUEZq9uVuuQW1FDPh
         XHbUcRtnPdacNWeGbV+DNZ47NUh2HlHrGm1qG/WNcU7Jh5lHuqOvUG7XUTM026vzxl+4
         JvZlea+JRoKrvv+gOvU1vwuiZLfEmFtyp7ZZMBc7TN/A4cbKt0TgGMUbzLQA/82DwRRD
         BLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F0RxkuPq6e9Po1j/wJDqvmmaTB6ODdlVVLKKtrkzqCI=;
        b=cHMch8W4vXtawn42RCIUXE+2cA+6cpKfY2A+QJ60eC3xNMPkvvEw/uBjyjmXHcTNvc
         3fHTVfbwEetGHNtnSHNR7VvOW2zEnyvtgzPgdnHUt13iqp2LyrbzCDwRyor5DeevvDkD
         3mHMJNrePcyyOlorA6tNzB/78WGXdgpRKo4PimSKJzqXM5wDY9ZDAfiwN0+PUxgYkJfn
         yZm8SVLZbQIBijphe3oZe3ZLaguj6Pewz05OqaY+YmELbPAvJ1VTkHviyA5kJnn0tQoy
         5B/rWCHID3+GKh86/M6eGFjRpLsxPhyRv8CwR5SJUQTnMaNmjGPo3u0vo9aM98roX0wn
         EYcg==
X-Gm-Message-State: ALKqPwcjOy3PEyArw857aFHiHtFc3qZH79CLDXoehgsis+nkf9H22s9S
        ZAHBPj1Q1jroRQSdunVNmaLRCJEXKgGQfPANPow=
X-Google-Smtp-Source: ADUXVKIB/763RioctLS52lVept6kHbijaIbdibpWG9+AGoR5kv3vtq4OMuIizkR/9snJy3bAos0MauH3pGikOjPtbYk=
X-Received: by 2002:a6b:5009:: with SMTP id e9-v6mr1157584iob.5.1527053606350;
 Tue, 22 May 2018 22:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Tue, 22 May 2018 22:33:25
 -0700 (PDT)
In-Reply-To: <CAGZ79kbdVm-U16rMjtgnGL+TOVRqkZz+J5W_eqo=dh42xRgKBQ@mail.gmail.com>
References: <20180521055143.14701-1-chriscool@tuxfamily.org> <CAGZ79kbdVm-U16rMjtgnGL+TOVRqkZz+J5W_eqo=dh42xRgKBQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 May 2018 07:33:25 +0200
Message-ID: <CAP8UFD1c2oWd6SN+bWRmARnJCSmf+UuQpDWURxKYEwJyQ8oprA@mail.gmail.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 9:34 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 20, 2018 at 10:51 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> From: David Turner <dturner@twopensource.com>
>>
>> So that they work under alternate ref storage backends.
>
> Sometimes I have a disconnect between the subject and the commit
> message, (e.g. in an email reader the subject is not displayed accurately on
> top of the message).
>
> So I would prefer if the first part of the body message is an actual
> sentence, and
> not a continuum from the subject.
>
> Maybe elaborate a bit more:
>
>   The current tests are very focused on the file system representation of
>   the loose and packed refs code.  As there are plans to implement other
>   ref storage systems, migrate most tests to a form that test the intent of the
>   refs storage system instead of it internals. The internals of the loose and
>   packed refs are tested in <TODO>, whereas the tests in this patch focus
>   on testing other aspects.

Thanks for this suggestion!

>> This will be really needed when such alternate ref storage backends are
>> developed. But this could already help by making clear to readers that
>> some tests do not depend on which ref backend is used.
>
> Ah, this is what I picked up already in the suggested edit above. :/

I actually mixed parts of your suggested message with parts of the
existing message in the V2 I just sent:

https://public-inbox.org/git/20180523052517.4443-1-chriscool@tuxfamily.org/
