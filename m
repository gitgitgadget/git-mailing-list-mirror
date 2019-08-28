Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868B11F461
	for <e@80x24.org>; Wed, 28 Aug 2019 10:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfH1KcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 06:32:24 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35914 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfH1KcY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:24 -0400
Received: by mail-wm1-f44.google.com with SMTP id p13so2057541wmh.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dAxQ59F4inX3ZOiAQk6qAQ1dbQKZO9sfh2r4ClBZP50=;
        b=moqZODmP6B0nbEbg/QRIwaDaPvAsDipzPGF996f1nfsmzaul8vSCoHbA/tlneJDuaR
         eB9Nk5HCyycE+G9XimrFD8Kq/Pz+WhLBrjtw2cExxSaGkEJsiHdSyP1zbZi4Anqd1WiV
         XmhMhY8OZsj6bwtdRSZtw9KSmUQhpqiNQv86/qylQCvAc/k27ucuZ1g3cLmiA+DgHBM9
         VBeXYN0QXfAq8eTypnFS3yhXgm2UzqgXFn2oz7k/ul9Pj4fozBu1qQ2dSrSOHSHLYGT2
         91mzNBg/TCoFxTNroiDXOemWzdRihbHLTBTiO+3teOyBmujMPas2i3L68v4Rzc7c9DUG
         XQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dAxQ59F4inX3ZOiAQk6qAQ1dbQKZO9sfh2r4ClBZP50=;
        b=eK4cRzLZguyLZoRD9tAnGotlHcR6kgK5OdnhJgjG4IZuE4kTACIswUiWgtAEu2teyf
         lJhwp820IhqjywWp0iZ3UN0/WUeEOpV2vZ7c+ysPu0BkUChDiuz1oodUNcoZhixTse9T
         fMsqeFTtk4gVEkUImv3KdfxRjqE7EWcHC2y0vo0CQryM8YbYmHOhZzdZZpKkUannwfu+
         ihXHlugrEvNCB1NRmNB1MD4g+vvQueCVXOB9AybHPrprWJI01wqKy/wkToen6a3KEpeZ
         qIXaccg7ClkGJlWczBcEpB6Ta72XJQLkoOFD0nvT9MRL5LWO/NS0wuufvdv7pCO6S+La
         xtFQ==
X-Gm-Message-State: APjAAAWEPddvzfuvz8D0/s21GEE8IzJ36zBMn5c5Smcg2v/L7vY4Dajo
        APZ5YZokQ/ioam+zJK10sa4FDDYQ
X-Google-Smtp-Source: APXvYqxS3RAaAwceKsnz3Gj5OnR2lLfy8VnqAGqaVWHbrwxn2j2tmEaIBO0mlaWxj7Nu0Pc6Xnm9WQ==
X-Received: by 2002:a1c:cf88:: with SMTP id f130mr4052266wmg.10.1566988342447;
        Wed, 28 Aug 2019 03:32:22 -0700 (PDT)
Received: from szeder.dev (x4db66bea.dyn.telefonica.de. [77.182.107.234])
        by smtp.gmail.com with ESMTPSA id d16sm2644573wrj.47.2019.08.28.03.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 03:32:21 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:32:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Giuseppe Crino' <giuscri@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: How to build to debug with gdb?
Message-ID: <20190828103217.GA6400@szeder.dev>
References: <1d44d8d6-6c6f-591e-dd2c-5102c9fd7d11@kdbg.org>
 <20190827183640.GC8571@szeder.dev>
 <20190828081557.GA18785@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828081557.GA18785@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 08:15:57AM +0000, Giuseppe Crino' wrote:
> On Tue, Aug 27, 2019 at 08:36:40PM +0200, SZEDER Gábor wrote:
> > Try using the same build flags for the install, i.e.:
> > 
> >   make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g" install
> 
> Yes, now it works thanks!
> 
> On Tue, Aug 27, 2019 at 08:34:23PM +0200, Johannes Sixt wrote:
> > That is because the command sequence above does not do what you think it
> > does. Didn't you notice that everything was recompiled during `sudo make
> > install`?
> 
> Shouldn't be this documented somewhere?

Well, perhaps.
But would users actually read it?  Dunno.

Case in point: the first few lines of 'INSTALL' already tell you to
build and install Git with the following commands:

  $ make prefix=/usr all doc info ;# as yourself
  # make prefix=/usr install install-doc install-html install-info ;# as root

Note the same 'prefix=...' in both commands, yet you omitted it when
you ran 'make install' ;)

> To my knowledge `make install` is expected to copy artifacts of the
> build under prefix. It's unusual to me that `install` has the `all`
> target as prerequisite.

I don't think it's unusual at all that the 'install' target depends on
'all'.  A quick and incomprehensive survey of Makefiles from a few
open source projects that I happen to have lying around seems to
confirm this.

What might be unusual (but is rather convenient for developers) is
that Git's build process checks the build flags, and rebuilds the
whole thing after the flags changed.

