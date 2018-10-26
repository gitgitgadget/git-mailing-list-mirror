Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B91F1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 01:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJZKOy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 06:14:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZKOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 06:14:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so6793437wru.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUkhDLuBR01pRApiHaX+AKcRFhlmrx744zdcYu/CWIs=;
        b=gkAO/Ih40rWI8IjCii5MsM9QZYqgzTXbGNIinFl01VUu6JBVaTwpMVFh7fMFP7sWdQ
         8wtNvyikz7R0oxOMfUk4BypBWeMD2QsPemcLEsZtvTcjo5rLZgYnMWTrluI9XBaREJZe
         4+eMLNkVVkT63sQ5CEruX4m9lWRkiXfOMIPOXrJDTQQaBryvCxiJKZRGLu6P4AiY5O/u
         JjlZ1iClSaZsu51bYJ6+qxlYA7QCM+/Xdd/Yiyzwh40gndAMFV7SeTxQdJ6/Z7sjnnuJ
         becISmZUGdumVup05FEpOKTC97BT17gs199V9Ps1o/Uwp/p9Qr53Gf9jco81obGO2WZb
         waIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUkhDLuBR01pRApiHaX+AKcRFhlmrx744zdcYu/CWIs=;
        b=HjmwdbxG6YFwex3LHSHjwAf4eF14k+6y8VfPGgdUQvj5tEuth7VSjx4qeD4agmI5re
         3Z8i66PUxgf6vO+xkZF6OFRp0KtbCrXr5dZKWyPfR6UKBlIxk0Cp1vNvJaFWArU5TIxr
         Xh3Ofz1ZMKbs+wZFD62ecbQKD7aJAvalVsxI/kwROP6wKk/+Ox88s8bUYfvgrBvloCIs
         t8G6q3z1bIohdd8r7UhNRASmSy6oEfvxLXHyyG9h+UzjTB8wRpT3BLV7tGS4ePq4Af/8
         T+aw0t0PIg560tu5it8kT6F1GIZ9F74DnxACd5+pslR+FwU0BMJDmOZqAvrAs6GD4GFz
         81UQ==
X-Gm-Message-State: AGRZ1gJUk8yMevbsY4o/Au+Jj0AhLu3Jktuhnd0mN1ZTWoWmS8P6z0rh
        xPWYnzYAhEhnr/7IQtlqY04=
X-Google-Smtp-Source: AJdET5dayQqRJovC+P9FsHWkGqnRJDxiMpTB5/BmXwRnKR3Jng/ZmQnROn5EM5F6B0HBGs9u6u6/TQ==
X-Received: by 2002:adf:e307:: with SMTP id b7-v6mr4123914wrj.91.1540517992905;
        Thu, 25 Oct 2018 18:39:52 -0700 (PDT)
Received: from szeder.dev (x4db0730d.dyn.telefonica.de. [77.176.115.13])
        by smtp.gmail.com with ESMTPSA id l140-v6sm5125478wmb.24.2018.10.25.18.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:39:51 -0700 (PDT)
Date:   Fri, 26 Oct 2018 03:39:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: no longer use containers
Message-ID: <20181026013949.GN30222@szeder.dev>
References: <CA+xP2SYtBGoxyV+hfjvYeEVU6XuvoZubC+-ffdubRgee=JtWXA@mail.gmail.com>
 <xmqqo9bhfu0j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9bhfu0j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 09:09:48AM +0900, Junio C Hamano wrote:
> Sebastian Staudt <koraktor@gmail.com> writes:
> 
> > Travis CI will soon deprecate the container-based infrastructure
> > enabled by `sudo: false` in ce59dffb34190e780be2fa9f449f842cadee9753.
> >
> > More info:
> > https://blog.travis-ci.com/2018-10-04-combining-linux-infrastructures
> 
> Thanks for posting a patch that would serve as a good discussion
> starter.  This is not a criticism on your patch, but more is a RFD
> to those who helped our use of Travis by contributing to .travis.yml
> and ci/.
> 
> Don't we need to do some other things so that we can run in vm
> environment, rather than in container environment, before doing this
> change?  IOW, aren't we doing in .travis.yml something we can do
> only in container but not in vm (if there is any), and if so,
> shouldn't we be rewriting that something so that we can run in vm?

As far as I understand, the container-based infrastructure has only
one benefit over the VMs, the shorter startup time.

OTOH, in VMs we can use sudo, which is not available in the
container-based intra.  This has the benefit that after switching to
VMs, we'll be able to install packages by running 'sudo apt-get
install ...'.  Currently the necessary packages are listed in
'.travis.yml' for Travis CI, while for Azure the whole install command
is embedded in '.azure....yml'.  After the switch we could consolidate
installing packages by 'sudo apt-get...' in
'ci/install-dependencies.sh' for both.

> I know ce59dffb ("travis-ci: explicity use container-based
> infrastructure", 2016-01-26) only added "sudo: false" without doing
> anything else (e.g. adding things that are only available to those
> who run in container), but if we added stuff that are not usable in
> vm environment after that commit since then, we need to adjust them
> so that we can migrate to the container-based environment, no?
> 
> To me, removing that "sudo: false" line seems like the least thing
> we need to worry about.  After all, they say that whether we have
> "sudo: false" or not, the CI jobs will start running in vm
> environment and not in container.  So if the rest of .travis.yml is
> ready to run in vm environment, we do not have to do anything ;-).
> 
> In short, my question to Lars and SZEDER is, are we already prepared
> to be thrown into a vm environment?

I think we are.  I've run only two builds with this patch, and they
run smoothly and finished successfully.  After you update 'pu' I'll
run more.

> If the answer is "yes", then I think removing "sudo: false" is
> probably still a good thing to do for documentation purposes
> (i.e. showing that we knew we are ready to go through their
> migration).

I agree.


> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  .travis.yml | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 4d4e26c9df..8d2499739e 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -1,7 +1,5 @@
> >  language: c
> >
> > -sudo: false
> > -
> >  cache:
> >    directories:
> >      - $HOME/travis-cache
> > --
> > 2.19.1
