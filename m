Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D791F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754958AbcHaS6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:58:06 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33938 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbcHaS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:58:05 -0400
Received: by mail-oi0-f46.google.com with SMTP id l203so84026483oib.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cFrE7r3uoRhDEa2uoYfQZmK1WynkS2yXzWNwcfvpA10=;
        b=VvMqW4krRUaTw4kdXc50WFrxIOJ8jbUNHGQts4u493prPNPM5BddZ58O/kFR4gYtuc
         DkWZ/GGdSb5k0cTDSJ/mV1OKmgvY1dJeeS11pw5o/UBUakbx4R6Z7ZIepQnvhqphrheM
         NiypGfa5u6TshlEwKScNa+iMswgrlDu3N7CuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cFrE7r3uoRhDEa2uoYfQZmK1WynkS2yXzWNwcfvpA10=;
        b=guWNDACwKhUuenY/BKGPVbbukTncbYX7NeDck6FI29ai20Y4Igb37dFDaRbQXnvR8m
         lynNImjeEdGMELdWSWHKAdaAziE+wXVf9VxkJ7JLvmtfBBnCWe3H3IlsaR43YJ2DRzYe
         ewHHu+i0iKaAGu/qvKhofboGRH8DHFLpJliQJMAiCdZ7tTfjztZTlAg29fNeMBgT1jm9
         zfWmwYnAJxfXDi78oQrI5L4O7qiUCxNHJJlOWZo3FfiJP0DLs1uHEl6QENDmbTnLWpf/
         rUDj5GZWMt/zIs6QRRkVr/pE4tFR/1dhkoZ5MRqvGIAvGIOCn0+vfmbuLA22QqErs2Nw
         8cBA==
X-Gm-Message-State: AE9vXwMZMWkYGh/vmQXWw82kDhXey+a6etlJ+T13m6L23C8BCP3nNlZ7siFEc/CLdPDIHzPFHuwKxupxvjfDY4m0
X-Received: by 10.157.29.1 with SMTP id m1mr11522318otm.113.1472669883922;
 Wed, 31 Aug 2016 11:58:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Wed, 31 Aug 2016 11:58:03 -0700 (PDT)
In-Reply-To: <xmqqh9a022xt.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <CAN5XQfvK7M5eSkMfz5iRTnE_va9VGjONAPO5hmF+iQg-i3XEpQ@mail.gmail.com>
 <xmqqh9a022xt.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Wed, 31 Aug 2016 11:58:03 -0700
Message-ID: <CAN5XQfujk2HpRGCeeGgDeeHJV3amEX=gSGva0Zot6LfEBv4CVg@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We want to affect only the process we are going to spawn to work
> inside the submodule, not ourselves, which is what this call does;
> this does not sound like a good idea.

Okay, in that case I would have to pass the "git_dir" as a new
argument to prepare_submodule_repo_env(). I know what to pass from the
is_submodule_modified() caller. I don't think it's all that obvious
for the other callers.

Thanks,
Uma

On Wed, Aug 31, 2016 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>
>> diff --git a/submodule.c b/submodule.c
>> index 5a62aa2..23443a7 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -960,6 +960,9 @@ unsigned is_submodule_modified(const char *path,
>> int ignore_untracked)
>>                 return 0;
>>
>>         }
>> +       /* stuff submodule git dir into env var */
>> +       set_git_dir(git_dir);
>
> We want to affect only the process we are going to spawn to work
> inside the submodule, not ourselves, which is what this call does;
> this does not sound like a good idea.
>
