Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DA81F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdLMFfa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 00:35:30 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41311 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdLMFf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:35:29 -0500
Received: by mail-wm0-f41.google.com with SMTP id g75so2632608wme.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 21:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aw4cVMFedceSLzO10t+UHlQjooeVSJYQLGtRkt2jz+0=;
        b=PKoj7ncJuyMjqHFn72ZqdJU6mT+BT3JA7MP8ymtNr4ARTErxUY7/JMA2NKo1D+Bf70
         4SNiGHeEw5xkDxoChXszzIpHcbYtNd5iapvQXOEFQaP0bIZKDzHAqeQahMdTtncJCdSC
         Kh1Gkn5/NgRYG5Oqd5FWqIv0gIrhq0k+DScq3Pp+51PaEoRkY2H/Syj2S4jB2fKW4aQK
         9+/NN+zE7TpefyCIu3Xqdhh8HSGyT7PHloTaCLePnnA3kgyw/OhOyxvjFpAQZGpjUIyy
         bAN1oFuAWvxHAoJTzFijffFgU347txDICzrMmjaK7sfw4nF/7/aAR4RPoY3RU9DBt1AZ
         xwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aw4cVMFedceSLzO10t+UHlQjooeVSJYQLGtRkt2jz+0=;
        b=J1UVqqoxpvt5RU1GZkyOK/EHXgb3e6nmE4Vkly9VuALYsLwGKw+7eTygnFuPoqE6Hi
         LX6mCNKIShUItujqPYsLjR/I8OAJ5Td6VAlSScMzWBY715gV6TYb+ALDafJmJBh3F8Ue
         vUwws0NBYl3qC8ZXsPhJOXpIwuooLzjHsq14T0jZroLdFTrDLHpPN21jW5nl3sBMmJAN
         9ljVpyUXTO+Ky2ZhirbncDnmbmAyhwrFXZ47CUqgkM2xVFtAOAkqGDWQMvMYb/v2Bb52
         LDC7eHX/T138GJ1+qny+kgApFgNsEjDwYIN1/JVB6HpVGba8P3NmJyxtWejof1ZAGr8W
         WTVg==
X-Gm-Message-State: AKGB3mLYaAU3jUVYPxuEJewzWNflfZh0OgA6HdLye3QLRTUmFMZlBk87
        n8PiggFhFojM4BV4gsk8vgAx7HFOTjPuqtOUubM=
X-Google-Smtp-Source: ACJfBovDbW9YY4DSbHMQShFL1gO2W5vIeHm4SB6zhhqatGIMN4QJLiBuZxop9Dgy3YtLNUXe3pDw32eelFhFlEuo0EA=
X-Received: by 10.80.137.147 with SMTP id g19mr6002565edg.293.1513143328619;
 Tue, 12 Dec 2017 21:35:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 21:35:08 -0800 (PST)
In-Reply-To: <20171212141355.7hcuegaopb6hee2l@hopa.kiewit.dartmouth.edu>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com> <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <20171212141355.7hcuegaopb6hee2l@hopa.kiewit.dartmouth.edu>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 21:35:08 -0800
Message-ID: <CA+P7+xqsKDqZK=7vaLqFeuqXjSrTgqupWnNA4WrxN8J9Td7N7A@mail.gmail.com>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 6:13 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> On Mon, 11 Dec 2017, Junio C Hamano wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> > I think the documentation
>
>> >     ~/.gitconfig
>> >             User-specific configuration file. Also called "global"
>> >             configuration file.
>
>> > should be clarified --- e.g. it could say
>
>> >     $XDG_CONFIG_HOME/git/config
>> >     ~/.gitconfig
>> >             User-specific configuration files. Because options in
>> >             these files are not specific to any repository, thes
>> >             are sometimes called global configuration files.
>
>> Yeah, I think that makes sense.
>
>> > As for "git config --global", I think the best thing would be to split
>> > it into two options: something like "git config --user" and "git
>> > config --xdg-user".  That way, it is unambiguous which configuration
>> > file the user intends to inspect or modify.  When a user calls "git
>> > config --global" and both files exist, it could warn that the command
>> > is ambiguous.
>
>> > Thoughts?
>
>> I actually thought that the plan was "you either have this, or the
>> other one, never both at the same time" (and I think those who
>> pushed the XDG thing in to the system made us favor it over the
>> traditional one).  So as long as --global updates the one that
>> exists, and updates XDG one when both or neither do, I think we
>> should be OK.  And from that viewpoint, we definitely do not want
>> two kinds of --global to pretend as if we support use of both at the
>> same time.
>
> note that atm $XDG_CONFIG_HOME/git/config is read as --global iff
> ~/.gitconfig is absent and read always without --global.  So it is
> flipping between "global" and "some kind of non-global but user-specific
> configuration file" (so sounds like  a global to me ;) )
>
> --
> Yaroslav O. Halchenko
> Center for Open Neuroscience     http://centerforopenneuroscience.org
> Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
> Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
> WWW:   http://www.linkedin.com/in/yarik

I didn't see it read, if ~/.gitconfig exists, it appears to never be
read on my system..

Thanks,
Jake
