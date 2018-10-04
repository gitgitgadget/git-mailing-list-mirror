Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62B41F453
	for <e@80x24.org>; Thu,  4 Oct 2018 04:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJDLHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 07:07:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44234 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeJDLHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 07:07:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id p25-v6so4490737pli.11
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLX07ReH+PGv05echUm84eQullVd/Gdtt1PJmYBHudY=;
        b=QTtxdp5D6ItFuRRpMMxHnSUS0OuKFdIEq3LdysWzfV5zlSXXXKXd1q7xcuQtWUUL2a
         78VTTbiLBcVmZiGYWrVm+/S50GsS6J4FjNusOZLuIZt7So08JhdxfefGDIMD/4WZmQnK
         ArohNiY8f7DFtYoR74YAkHMVlaFb9gir8jxGwSkCGGhUcqwm3/+zu9WbKpe/Sr0r+GEC
         d1G9igwmMetY+IoPWV3rQLezkngoZQGaO3Eh586splb5sc9d4umKIOvKmSYPNdqhPyD6
         WdZW9S8fA/PjVmGdIuxhmh+KHfVYy1HYcrnTmYjY5Hs7zIiMHnH20oFPbH6exD9SQdG9
         JU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLX07ReH+PGv05echUm84eQullVd/Gdtt1PJmYBHudY=;
        b=rS82dArHOv4lQhokPgKnbAiIA9QIXNojRJ7ld8An7TkPLU1ugGzUuXvV0y+ER/Hcm6
         uo2My2kgm6KQT55b4KuosUsks4GzlHRPrMYjC1Vv+H3Y+C+hcCD/vgms09HnPO0rqAe/
         HyryXKVaCKjKVQFVdtrDrQoX57gNixO5lOLbq84Ol6QqRllkKIV+YWs/wz+Rg39xot3B
         DHOxDaps2/LsTiynFmosiyA4VAzmFOMceLU84q8hkKgswUloLEuuOLGm0IFhAHN6TSgn
         r/lWjZNlEV8rJlvHc9Fr1jTeQ1nY/OWjkYYM1NgoJanhP8qqqB2TZHwm9K4NFEhLP8SY
         PvMw==
X-Gm-Message-State: ABuFfojtxaLFVc1O4O5KnfATKI3LsjkyWroQSAcgmE7yGXj5dtN+bVgv
        TjAhUV028E3LuJDvakVnZmk=
X-Google-Smtp-Source: ACcGV61XSapPxRioI845P12mB6JhdvlL16TgLr0cOHG6iaucsbZ0hi3tcs/4NZs4CgFqtI9gSuVo7w==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10-v6mr4635515plb.163.1538626587713;
        Wed, 03 Oct 2018 21:16:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d186-v6sm4591355pfg.173.2018.10.03.21.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 21:16:27 -0700 (PDT)
Date:   Wed, 3 Oct 2018 21:16:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20181004041624.GB165126@aiede.svl.corp.google.com>
References: <20180817190310.GA5360@sigill.intra.peff.net>
 <20180818052605.GA241538@aiede.svl.corp.google.com>
 <20181004041018.GA1526@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004041018.GA1526@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Aug 17, 2018 at 10:26:05PM -0700, Jonathan Nieder wrote:

>>  - testsvn:: is a demo and at a minimum we ought not to install it
>>    with "make install"
>>
>>  - keeping this in-tree for the benefit of just one user is excessive,
>>    so removing it is probably the right thing
>>
>>  - it would be nice if the commit removing this code from Git includes
>>    a note to help people find its new home
>>
>> Would you mind holding off until I'm able to arrange that last bit?
>
> Any further thoughts / movement on this? Not urgent, but I saw you
> mention it in another thread, and it's on my "to be decided" pile.

I'd like to move this to contrib so it's all in one place.  Then I
should be able to put it in a separate repo and drop it from Git.

If someone has a spare moment to help, I'd be happy to review patches
that move vcs-svn/* and git-remote-testsvn to contrib/svn-fe
(including the tests, contrib/subtree-style; in a separate repo the
tests would then work fine using sharness).

Thanks,
Jonathan
