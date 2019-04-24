Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC061F453
	for <e@80x24.org>; Wed, 24 Apr 2019 23:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfDXX0f (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 19:26:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45694 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfDXX0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 19:26:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so10095010pfi.12
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElyUWcwAwURN2hWvzjtw98es3yTH4QVAfFe5v3UI/JA=;
        b=UUh6TH3SMS4dwpRmq31wz94+/jrfWNUEzBG/bkXCZ3H6S+arqp2O/S2vblbOqXnCHC
         vGtyps1wR7XI5a04UrjCwOiz6n+M2OUsKN9HL0O4kFs7j491uQ2heyscTVUFXS/ZsZ/P
         OL1XfCKlf7I0+r/q+JCnPvh0BApCrvFfZ1XNd7p9EOU2Qz4d5eaCAoyNz+2Xwi7x5wRA
         ERC/ZXXy6FTzTB3n4mT1SCU47krb5G/oEGeUii//Bxu+t8AkOgzVwgGQLcNGG9PuSHf3
         cUcnmwjC6QNINmwNSt4S0L/Zu2kxpLwlTXEGMZvgSChNNHKD6cfjeqhdGtEkwr7G9U8l
         HxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElyUWcwAwURN2hWvzjtw98es3yTH4QVAfFe5v3UI/JA=;
        b=uZZDpCw2U6pXhg7FrIGO4SWLbx0e/uYJW32WUk7skM1X8zTiZoPpMwR1kFZoUfQKTV
         BKyAFcUf5qcdDdk9l3qUxhQ8AtT7F/ZpxrV6+xcaggbXqzgBIkWnSUg9rPRcG1C6UdSp
         YAD5Jtsa5b8BIBKrq0W+0pWmlXHCaTKA3ex6eOasTTppwIMQFNmrIdzV9D/h6ufoNlZE
         Gft6IwkFNpSI/Lz1PJVPveuyJBcNwH5+2d6EwvKmohc0VgszZdvGfJcMHj7nkvNMlJ58
         mpurMDoKguCUDLWsDISGQ9AX9y7xp72ZgkG3EwnZROJ0Eliwj722t4p5bjf+3bJwk/Wn
         os4Q==
X-Gm-Message-State: APjAAAVwUIjWi2YhhF1Bkl3c7krq9Jpk+kf1qCLQwpqKp+zoeuE828ji
        IQaq4nhdo9K9l24R+E2ei4k=
X-Google-Smtp-Source: APXvYqwMznzNQ6Rt7zmKtLxl+3mPNEBYDHA0cm3cGlTYF2hRdrWWvqAOXB+tzfl3JdOqjvkhVmfXjA==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr37082975pfr.193.1556148394190;
        Wed, 24 Apr 2019 16:26:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k79sm49555116pfj.28.2019.04.24.16.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:26:33 -0700 (PDT)
Date:   Wed, 24 Apr 2019 16:26:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424232631.GA186980@google.com>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424230744.GL6316@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
> On Tue, Apr 23, 2019 at 07:34:38PM -0700, Jonathan Nieder wrote:
>> brian m. carlson wrote:

>>> I've talked with some people about this approach, and they've indicated
>>> they would prefer a configuration-based approach.
>>
>> I would, too, mostly because that reduces the problem of securing
>> hooks to securing configuration.  See
>> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
>> for more on this subject.
>
> I know this is a common issue, but fixing it is a non-goal for this
> series. Anything we do here is going to have to be backwards compatible,
> so we can't make any changes to the security model.

I think it's worth bringing up because we should have some idea of where
we want to head.

I think the backward compatibility part is actually one of the easier
aspects of this one.  We don't have to change the security model right
away because there are similar places to exploit like core.pager.  To
address that, we need a notion of configuration that individual repos
and worktrees can't override, and using such a configuration item, we
can provide a way to opt in to the new security model.  That provides
a smooth path forward.

[...]
>> Solving (1) without (2) feels like a bit of a missed opportunity to
>> me.  Ideally, what I would like is
>>
>>    i. A central registry of trustworthy Git hooks that can be upgraded
>>       using the system package manager to address (2).  Perhaps just
>>       git-hook-* commands on the $PATH.
>>
>>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
>>       run for each event in .git/config.
>
> The problem I had with this when discussing it was that our
> configuration system lacks a good way to control inheritance from outer
> files.

The standard approach in lists defined in Git configuration is for
assigning an empty item to clear / restart the list.  See
http.extraHeader for an example.

Thanks and hope that helps,
Jonathan
