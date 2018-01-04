Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F431F42B
	for <e@80x24.org>; Thu,  4 Jan 2018 10:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeADKKW (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 05:10:22 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:40324 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeADKKV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 05:10:21 -0500
Received: by mail-wr0-f174.google.com with SMTP id p17so997344wre.7
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3bT78suujeF8Bz9FNvB7+b5RdkAb7wckmFKzhPEEFjA=;
        b=WZAuANdpFKKLarArxvIalJyLEgei8pUR4Y3w4cssB1OovX6IFn/swaPyXJICyr6fff
         r0/nhO4Wsnwyxkj6/uryMoZTivXzeOwtQ1qTsYskZxj/b1katuAgDahqrYrOmRhL1QI3
         VXr1naojgi09vBVO1kIljLXZEXHBqcmZ457UoLafhAR+g0EUoZ7gyYkj0KDD69dp9px6
         0DozRFrZ1zdS1Rz5iKJcJdVgyYAymyn9Jxr2yXsEs0I+VzrTzc7X5lQ2m8pbUV6bHQBD
         YhbQBIpsJuilwSRNI3H1wuFRoOOul9J06aaatKkS9k+J9f1B/iBGtTGvlJDJ0MX1qtt9
         Duaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3bT78suujeF8Bz9FNvB7+b5RdkAb7wckmFKzhPEEFjA=;
        b=eXQHToGDoXNn0W/6RCa2w/e7HEQjSrrbeb+IQpdXMSNUH/Sf6P4uhOkf7SvAcIdXdu
         DiDemoq1ckQ/TLHve2NJZo2xwsjO5cEC6aQufu99s+CHLHZ2ZUMKp7lf40cLocNp6Dit
         hWDGWjbc669oApEyvHyCr6cJesqWdryizXA2mVfhNJus83J97k6u7gU/esrGk3chhKyM
         FWnDw2XQyxwGHFtrf13sMBeAlrziLx/4BtU0tUSeobgSXG1KzGpv++VaSvrNSDwII0Ve
         UQ2wKx9fCEk4OEgBeZFHFGETdh9/l86upoG1xMbhKNOnQG4jKdC+GUYt9yODXGhMEopB
         Z7eg==
X-Gm-Message-State: AKGB3mKT1OErUDNWQ3tpFT4bIJ7aqYnsZhjRP3AxOmd69AXiVwEWZKMP
        T4Ck773GIBfaMThl/X/4fK63s/9B
X-Google-Smtp-Source: ACJfBov/mgY9q+AyWx36wVfm9lIbuyEcgCE/lHHCjnwely43eVUFbYier4y1Wy/4gZEtchO3nHb01w==
X-Received: by 10.223.186.72 with SMTP id t8mr4373444wrg.169.1515060619930;
        Thu, 04 Jan 2018 02:10:19 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id i65sm10952968wme.20.2018.01.04.02.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 02:10:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
References: <20180103102840.27897-1-avarab@gmail.com> <xmqq373mh62r.fsf@gitster.mtv.corp.google.com> <87bmiacwoz.fsf@evledraar.gmail.com> <20180104044230.GA12113@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180104044230.GA12113@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 11:10:17 +0100
Message-ID: <87a7xuc4ty.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Jeff King jotted:

> On Thu, Jan 04, 2018 at 01:08:28AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> Hopefully this is clearer, and depending on how the rest of the
>> discussion goes I'll submit v2 with something like this in the commit
>> message:
>>
>> SSH keys A and B are known to the remote service, and used to identify
>> two different users.
>>
>> A can only push to repository X, and B can only fetch from repository Y.
>>
>> Thus, if you have a script that does:
>>
>>     GIT_SSH_COMMAND="ssh -i A -i B" git ...
>>
>> It'll always fail for pulling from X, and pushing to Y. Supply:
>>
>>     GIT_SSH_COMMAND="ssh -i B -i A" git ...
>>
>> And now pulling will work, but pushing won't.
>
> I get that you may have two different keys to go with two different
> identities on a remote system. But I'm not sure I understand why
> "sending" or "receiving" is the right way to split those up. Wouldn't
> you also sometimes want to fetch from repository X? IOW, wouldn't you
> want to tie identity "A" to repository "X", and "B" to repository "Y?

That's badly explained, sorry, when I say "push" I mean "push and/or
pull".

I don't know about Github, but on Gitlab when you provision a deploy key
and associate it with a repo it must be *globally* rw or ro, there's no
way to on a per-repo basis say it should be rw ro.

I have a job that's fetching a bunch of repos to review code in them
(for auditing purposes). It then commits the results of that review to
other git repos.

Thus I want to have a ro key to all those reviewed repos, but rw keys to
the audit repo itself (and it'll also pull with the rw key).

Hence this patch, I thought *maybe* others would be interested in this
since it seems to me to be an easy thing to run into with these ssh-key
based hosting providers, but maybe not.

>> So now I just have a GIT_SSH_COMMAND that dispatches to different keys
>> depending on the operation, as noted in the commit message, and I can
>> assure you that without that logic it doesn't work.
>
> You mentioned host aliases later, which is the solution I've seen in the
> wild. And then you can map each remote to a different host alias.
