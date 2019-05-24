Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2311F462
	for <e@80x24.org>; Fri, 24 May 2019 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbfEXKI4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:08:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35289 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbfEXKI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:08:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id m3so9391082wrv.2
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=vgU3unCKfwkZbWoqMR3xsvHoaSxkppz/SRe7vfp0QQM=;
        b=HxVodAXwyE3YswDFV4b32/cs7nk/A32D8BmMdtOEuYdhRGQ7a4stMUuZo3Dn3mmtXz
         ID44e5M+qFB6bsie66CqburKDE4w2VX8nW+3RIg2UXtBTOjcogAX8z3kk/27jWa5DGkv
         i41Qzyxtw7vO8rk0i5Md/Zq24J1cWE4t96kp22D9niKV+ug/C0BQsABEwe/n+ltUIPRQ
         DcW4hMCiYkxc7ZSsPkniTI1xOLZkhHxYJTAzDYk74gAWMINJ6qW/lEODGbzfm7KkBr+E
         LBbpKqW1DZlmCD9n381K1M3OQkARpghvfX/mzqc8yKQZXQtRzSCnuWnCggbsxFOnojMz
         0KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=vgU3unCKfwkZbWoqMR3xsvHoaSxkppz/SRe7vfp0QQM=;
        b=W0JMS91YcBjwFVBBc2bgPbkTAnKoTJamQq9IpOIOnHtpys/1Lye3jW9Yjy5gyirs+Y
         XeCl8Avpusx332TsTzq4UFZ9YzjQjJE+vq9dc5MYglZaVqJcHcJlI6xYxpJboAbX0bDz
         cQeYmwfliAeU9+RE57gQHpHhhj0fjy2HM2O5WcpPynOWDxr1nBQlOwB598ZNaRDyWwRH
         ZUcm8g1Ofvkc07YsPwV3bSurhO087TDQAfEG/YRUhki9zsFFzQ2gpIlj8CmV8OhbVAQd
         7HGIhS7zaRdIQ9ntOqU9llRad+EdOUCOJzsZV/O4duKq/96e55s3Kqa20Yc2Rla+K69S
         e1bA==
X-Gm-Message-State: APjAAAU8Aogn1vHapMzk/UIAYHE9jYD3WTemEiLWx+vFhlE0gOdABD4n
        WoV4KVrAj/8YwDawjDapZKVsRwuj+QE=
X-Google-Smtp-Source: APXvYqzQfsb7ClWWZekeVKIgq2wZ2iJpqGuG/QdUN10VlbrgsCLpy4ePeHWr6i8MrHFsKOIK3kLw9Q==
X-Received: by 2002:adf:9c8e:: with SMTP id d14mr10393533wre.215.1558692534550;
        Fri, 24 May 2019 03:08:54 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b10sm3181716wrh.59.2019.05.24.03.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:08:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Incorrect diff-parseopt conversion?
References: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com> <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com> <791da98b-4065-e477-92cb-ceac80cc04e6@ramsayjones.plus.com> <CACsJy8AzY4EO_io_8R41uVDsbCj+_Fn8YOQ8e+JmAC27dFW7UA@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8AzY4EO_io_8R41uVDsbCj+_Fn8YOQ8e+JmAC27dFW7UA@mail.gmail.com>
Date:   Fri, 24 May 2019 12:08:53 +0200
Message-ID: <87mujcf9l6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Duy Nguyen wrote:

> On Wed, May 22, 2019 at 7:35 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>>
>> On 22/05/2019 01:11, Duy Nguyen wrote:
>> > On Wed, May 22, 2019 at 2:56 AM Ramsay Jones
>> > <ramsay@ramsayjones.plus.com> wrote:
>> >>
>> >> Hi Duy,
>> >>
>> >> I am in the middle of rebasing a long running branch onto
>> >> current master (v2.22.0-rc1) and noticed something odd with
>> >> commit af2f368091 ("diff-parseopt: convert --output-*",
>> >> 2019-02-21).
>> >>
>> >> As part of the branch I am rebasing, I have defined a new
>> >> OPT_LL_CALLBACK() macro[1], which I had intended to apply to
>> >> the 'output' option to diff. However, commit af2f368091
>> >> defines that option thus:
>> >>
>> >> +               { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>> >> +                 N_("Output to a specific file"),
>> >> +                 PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
>> >>
>> >> Note that the 'option type' is given as OPTION_CALLBACK, not
>> >> as OPTION_LOWLEVEL_CALLBACK. Is this intended?
>> >
>> > Yeah I think this is correct (phew!).
>>
>> OK, I just had a look at the code in parse-options.c.
>> Hmm, somewhat ugly! :-D
>
> Yeah it's a bit hackish. The problem is parse-options (and also config
> parser) does not allow passing user data to the callback. Changing it
> would affect all callsites at once. It's just too scary for me to do
> it and I chose an uglier way but with smaller impact.

As an aside because I've sometimes wanted to pass such arbitrary data to
the callback.

Do you mean it's painful to change "struct option" because of all the
macros around it?

Instead of all callsites, wouldn't that just be a patch simliar to
bf3ff338a2 ("parse-options: stop abusing 'callback' for lowlevel
callbacks", 2019-01-27)?

I.e. a special callback that'll be called to return a void* to arbitrary
data, and then we'll call the callback with that.

Or, just passing it around in a global variable, since we know the flow
of when we setup the data, and when parse_options() is called.
