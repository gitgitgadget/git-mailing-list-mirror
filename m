Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B865B202A7
	for <e@80x24.org>; Sun,  2 Jul 2017 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdGBUgJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 16:36:09 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35997 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdGBUgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 16:36:08 -0400
Received: by mail-wr0-f182.google.com with SMTP id c11so225381619wrc.3
        for <git@vger.kernel.org>; Sun, 02 Jul 2017 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2+BYCvqeSYUtlGj00jSU/iJtYrnl2A4mOr3sHLWO0I=;
        b=dxjDL792wD5YOCqu3OzVu/qlmiDrrrsBuJ6RUaC2c+0HzZIqtOrF2AzNyfJMYYbWWY
         qxzppUie4mm4MY1of0FT8TH805K2aWAlYSk2ctB0yZ9Q0y87hy63EzOhL3/pm47Dvnyc
         +eEp9WbHiqrPG1d/r3eXDexStqlxIqnJ97JgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2+BYCvqeSYUtlGj00jSU/iJtYrnl2A4mOr3sHLWO0I=;
        b=AyX89awIWhuhQmLzPMgbudz4FTb6o4KPjL+6Z2sYqJQ5NQ8Tm+SyLPcx6OVQwJU9hs
         Be6L5oT5A1JCE9ubJ5gaMgEZM84jdHrYqyVVfaz8BmywSezNi/ebeGoVocUmLY0GgMRn
         oPRIUXbPXtO8iSxF9JaFHcb/lZpUzmMmyFF4y0/heD5dOkWvv65UqTN48WVoPbJsyWsl
         hcd1cn+YCmMxcIV6SONgMylsyTCqrolA4wPBTZJBjtA4LKTW+FGK0YMhRKUF+hp6rUWj
         8Lvk5d3/JzNJCtYuHldf7mtlkbu46CAMjMwNWq+J4j1z+wRjyNXkjKXz5utvd0lUAf9l
         Io/A==
X-Gm-Message-State: AKS2vOz+FZbV3KzDlWAeE8do/yvDvzHOWupQiC1ZKZrW1vqBK+Y4Gs4a
        IUfhxfPkg9y6Kfjy
X-Received: by 10.223.166.139 with SMTP id t11mr30049829wrc.39.1499027766561;
        Sun, 02 Jul 2017 13:36:06 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id p34sm14489788wrc.66.2017.07.02.13.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jul 2017 13:36:05 -0700 (PDT)
Date:   Sun, 2 Jul 2017 21:35:48 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Continous Integration (was: RE: Git v2.13.1 SHA1 very broken)
Message-ID: <20170702203548.GA26574@dinwoodie.org>
References: <20170605203409.GB25777@dinwoodie.org>
 <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
 <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
 <20170606100355.GC25777@dinwoodie.org>
 <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
 <20170606124323.GD25777@dinwoodie.org>
 <6D15A44412C346E2822A74A91FDF77B1@blackfat>
 <CF387D0C-6743-4B88-A4CC-D6310A634E03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF387D0C-6743-4B88-A4CC-D6310A634E03@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 05:04:32PM +0200, Lars Schneider wrote:
> > On 06 Jun 2017, at 16:47, Jason Pyeron <jpyeron@pdinc.us> wrote:
> > 
> > Do we have Jenkins (or something else) setup for Git?
> > 
> > We would be happy to donate (slave) VMs for cygwin builds og Git.  
> > 
> > -Jason Pyeron
> > 
> 
> We use TravisCI for Linux, Mac, and (in a special way) Windows: 
> https://travis-ci.org/git/git
> 
> Windows is not supported by TravisCI. We just use TravisCI to
> trigger a build on MS Azure and read the results:
> https://github.com/git/git/commit/029aeeed55f6bfe8014e8ffe5fc7a6f2e5b110fc
> 
> Maybe we could trigger a Cgywin build on your slaves in the same way?

I tried setting up a Cygwin Git build on AppVeyor a little while ago,
but the problem I found is that Cygwin builds are slow, particularly if
you want to also run the test suite.  I do the builds for the Cygwin
distribution on my normal PC (so reasonably powerful but definitely not
devoted to the purpose), and doing the build and running the default
tests takes in the region of 8 hours for the 64-bit build and 12 hours
for the 32-bit build.

At the moment, I'm trying to set up automated regular builds on my PC
using BuildBot.  I think that, short of someone donating some fairly
significant resources for Cygwin builds, that's going to be the closest
I'll be able to find for spotting problems early.  It's a project in my
currently limited spare time, though, and not something I've done
before, so it's taking a little while to get going.

Adam
