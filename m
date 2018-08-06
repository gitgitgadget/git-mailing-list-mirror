Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB302208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbeHFTwK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:52:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732363AbeHFTwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:52:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so5561150edr.2
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T85ri/vi76Cgt6Qg2Kj/NzrMJ3wy9v6HVg1KW3UMuAk=;
        b=EZR2R4Ftsar9i0vZCqJw8j8pI448Lks7aA+fmJZRlp8g7eUESPOIsnK0dTcCSexRDR
         U12LGuswV6h7y6iPnAF/+3bDicFDjN1EOshVaPp1cMZibOs7gIXujh0phSrpZYDxL8rS
         1e7AQYUtWdLN8LUvglw8eRz8T0ZWEcIf14SDOZSQbr6cQfVorIdcx3E6q1+tgjTpzyci
         TBkeF5mWz65k2hzyCQ64M5GbUEL7Nxf5bEhCDwY5xKU5YUWhtwEhaC0oI9K5ctf06Gg+
         Nd0U4FevhMqBcYjfitzA03I8uWSUDb5trF8kFoqv9BocyBO+jsVUmuwdsH10BU0389tv
         EWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=T85ri/vi76Cgt6Qg2Kj/NzrMJ3wy9v6HVg1KW3UMuAk=;
        b=HyqpApoHsOniuYQT7IxvUBFk/XKSC+JF28/GIJGNq4p7cDAJiXS7us6kfkJ5AEZIfv
         w6ZKrH1yHYQ1h1w9ENyLZMznvQHyk/b22Hc6dGE01vaKvwCv8lRT2z0kgcTyotsHQAuc
         jYn/IFteueeD3rEFhr/hnPpSH2JBn3qypPtaPAOi1OyacBWzJCF43+Rk9QaT9h5n3MiN
         Bk0BrltxcoTIMS4MMJocFj7Q6I9+eh0afFvWgBkeoUpnAwGA0cH7TNnRhoyN2jzLrRqT
         6Ye2amdDuvlcvnypsLZ+94H9oClKhno/la5vccvjjazT32uW9MkEX/MTDT5ZDo2V45KN
         +OFA==
X-Gm-Message-State: AOUpUlGt0DkkwCN51zZpHHueOclqRvIcNZhh1Otf/E+FrZmve01WKDH2
        kgvGB7COHDjFvfMGIcvrlJY=
X-Google-Smtp-Source: AAOMgpd5cIzzPBXNG/CPc7xivroyzY/Yz4pWSV0s/7CgFqnslvWBxas2hEcZ1KUR0a2G27idpvJmGA==
X-Received: by 2002:a50:8a66:: with SMTP id i93-v6mr19290094edi.281.1533577320357;
        Mon, 06 Aug 2018 10:42:00 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id t8-v6sm4808541edr.91.2018.08.06.10.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:41:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Duy Nguyen' <pclouds@gmail.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Stefan Beller' <sbeller@google.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        'Han-Wen Nienhuys' <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
References: <20180804020009.224582-1-sbeller@google.com>
        <20180804020255.225573-1-sbeller@google.com>
        <20180804060928.GB55869@aiede.svl.corp.google.com>
        <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
        <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
        <87zhxzsb2p.fsf@evledraar.gmail.com>
        <001001d42da7$4a9e6570$dfdb3050$@nexbridge.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <001001d42da7$4a9e6570$dfdb3050$@nexbridge.com>
Date:   Mon, 06 Aug 2018 19:41:58 +0200
Message-ID: <87wot3s87t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 06 2018, Randall S. Becker wrote:

> On August 6, 2018 12:40 PM, Ævar Arnfjörð Bjarmason wrote:
>> On Sat, Aug 04 2018, Junio C Hamano wrote:
>>
>> > Duy Nguyen <pclouds@gmail.com> writes:
>> >
>> >> On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com>
>> wrote:
>> >>> My main concern is not about them but about other people building
>> >>> from source in order to run (instead of to develop) Git, and by
>> >>> extension, the people they go to for help when it doesn't work.  I
>> >>> have lots of bitter experience of -Werror being a support headache
>> >>> and leading to bad workarounds when someone upgrades their compiler
>> >>> and the build starts failing due to a new warning it has introduced.
>> >>
>> >> Even old compilers can also throw some silly, false positive warnings
>> >> (which now turn into errors) because they are not as smart as new
>> >> ones.
>> >
>> > I agree with both of the above.  I do not think the pros-and-cons are
>> > in favor of forcing the developer bit to everybody, even though I am
>> > sympathetic to the desire to see people throw fewer bad changes that
>> > waste review bandwidth by not compiling or passing its own tests at
>> > us.
>>
>> I agree.
>>
>> Responding to the thread in general, perhaps people would like this more if
>> we turned DEVELOPER=1 DEVOPTS=no-error on by default?
>>
>> That's basically why I added it in 99f763baf5 ("Makefile: add a DEVOPTS to
>> suppress -Werror under DEVELOPER", 2018-04-14), because I wanted the
>> abilty to have verbose informative output without the build dying on some
>> older systems / compilers.
>>
>> It's fine and understandable if you're someone who's just building a package
>> on some older system if you get a bunch of compiler warnings, but more
>> annoying if you have to dig into how to disable a default -Werror.
>
> I am the platform maintainer for HPE NonStop and need to make sure I'm
> not packaging DEV builds to anyone

Perhaps confusingly, the DEVELOPER=1 flag in git is not like the
developer flag in some other projects. It's purely there to turn on
extra compiler warnings (by default, fatal), it doesn't e.g. turn on
extra asserts, tracing, or suppress stripping of the binaries.

So if we enabled some variant of it by default it would be fine to ship
the result of that to your users, e.g. I ship DEVELOPER=1 builds to
users.
