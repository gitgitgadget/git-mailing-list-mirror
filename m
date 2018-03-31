Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B5D1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeCaUKd (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 16:10:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52083 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeCaUKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 16:10:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id v21so20003646wmc.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=08CPpHKGk1/AQDSGRNqravTCayl/V+h2gZv7/QwFUzE=;
        b=TQJ1j8Jpu5I7FYXaWJfaVltWHO+LepHgT1Yx5KIZc5lPu4sSKFqGLctt0o5aYJrVDA
         UkylfVVBY2ScEtlkAaHCdmNnrgxofU+ftpwotTnIBWPEkrx2n1jGy/47Cm2Qky/BJ4vU
         +SNxuyJZC4hMo9xwFuMtq4wSaejKQMBotCoKEX2C6P+C73MxHdEABFgVcFoVLoRbIsX5
         Hd62soR81CddGE1UGRbRksgFGdu5b92d0JTuifc8ZovXh8wSVZfE7sPOryUU2iXTVab3
         iCdWWb8UeY2w7Ijm8I7w7ycdSUIgNH0GW3d9jvNghHOuJRV6unk1HlmeBp+WMv9v/Wye
         +QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=08CPpHKGk1/AQDSGRNqravTCayl/V+h2gZv7/QwFUzE=;
        b=OChJA6cI546Xd1LGTpoMQ1BCtLYY/EoJr9q65vgc//KnOdct53cpNZgf3GQdCgW4yj
         OK3/exPwY6TxYZfKzNVy+X4Artw18Apewa+hcYkp5CNMqoSpZcZ8D4RV7J1VeP7gJiim
         /kmON/GG5pNOZlyCiEP8Q4DH51oSk7XWzayiZzIl1/hHSodwwwI3fLApq0HhdhZMO+OB
         meBByxH6k8JsBaUEtKAMI5Uca8h2vaeuwLyA7XUVDJRXwmjCNJF7S7OWJhibnNbB/ZDZ
         ZGeuDPC2NW4OcYaSCea0qZUaxFmKZr0gGYyFd4o2IhJPRouAtpz1TinBX9EbusZan1tO
         n5qw==
X-Gm-Message-State: AElRT7FEYNVM6pad65R+OQWJf51PQ1KHYG49ygu0Iu8ArmFgHfr+LLcq
        9ozalJvXvWMI9O/nHd2pyzTX6DtC
X-Google-Smtp-Source: AIpwx4+tc2I6hB3rHM5SCFSiOJFRv34HLvL2zKN/MQWyWE4LfjU4Bh+ATuuDwhoihM27eXMuwjLj1A==
X-Received: by 10.80.168.69 with SMTP id j63mr7217470edc.301.1522527031716;
        Sat, 31 Mar 2018 13:10:31 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b31sm7232573eda.70.2018.03.31.13.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 13:10:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [OT] how does "git review --setup" figure out my username?
References: <alpine.LFD.2.21.1803311453250.21368@localhost.localdomain> <CACBZZX7wQChuEQeBHQzgg-XsMmmryB4qBXT9K4HxwxaSNe4UWg@mail.gmail.com> <alpine.LFD.2.21.1803311555500.23345@localhost.localdomain>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1803311555500.23345@localhost.localdomain>
Date:   Sat, 31 Mar 2018 22:10:30 +0200
Message-ID: <877epsvweh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 31 2018, Robert P. J. Day wrote:

> On Sat, 31 Mar 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Sat, Mar 31, 2018 at 9:04 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   (technically not a git question, but i kind of need to know the
>> > answer to this quickly as i'm writing some documentation and this is
>> > something i have to explain.)
>> >
>> >   i cloned a repository (hyperledger fabric) which has a top-level
>> > .gitreview file:
>> >
>> >   [gerrit]
>> >   host=gerrit.hyperledger.org
>> >   port=29418
>> >   project=fabric
>> >
>> > and, as i read it, if i want to configure to use gerrit, an initial
>> > invocation of "git review --setup" should do that for me, which it
>> > appears to do, as it adds the following to .git/config:
>> >
>> >   [remote "gerrit"]
>> >         url = ssh://rpjday@gerrit.hyperledger.org:29418/fabric
>> >         fetch = +refs/heads/*:refs/remotes/gerrit/*
>> >
>> > and copies over the commit-msg hook. so far, so good.
>> >
>> >   but from where does it figure out the username (rpjday) to use when
>> > configuring that remote? i have no gerrit configuration in my
>> > .gitconfig file. however, i have configured gerrit at the hyperledger
>> > end to use my SSH key, which is associated with my linux foundation ID
>> > (rpjday) that i registered to start using that repo.
>> >
>> >   is that where it gets the username from?
>>
>> I've never used gerrit, but from my skimming of
>> https://www.mediawiki.org/wiki/Gerrit/git-review#Setting_up_git-review
>> and
>> https://www.mediawiki.org/wiki/Gerrit/Tutorial#Configuring_git-review
>> it seems (to me) to say that it simply tries if your local loginname
>> works on the remote. Is rpjday your loginname on this system?
>
>   yes, but it's just a fluke that i used the same user name in both
> places ... what if i hadn't? which one would it have selected?

Seems like a fairly common case, especially as gerrit tends to be used
in Big Corp setups where your username is the same.

According to the docs I linked to it'll ask you if it doesn't happen to
match, but as I've said never used it, and that may be wrong.
