Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364181F463
	for <e@80x24.org>; Tue, 10 Sep 2019 12:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391832AbfIJMZB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 08:25:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIJMZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 08:25:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so15098426wrx.10
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qmOGPvo+vuRN1sXJqUesbDhzs2FroCe1eLdVsz8eIGs=;
        b=gUVdccQUwCHkPlsSx7GZzw4BHp3agkgQMlLzuEYryYAifjBQA5krBzGOyCGMcvuC1/
         +B3MX45u0zfMFTjEc20BI4aHG1fbjmBckmvJCDAUkIi89x4SXoROao17spuUkqDsBF97
         PTZuvn30YVZkpDrEm9HHat6O1/CqLeaNJUIzqLTdLZqrpMymp+ho5bCe5xR5EsD5zjBe
         VjfJ/+TMvbmBqiA8e14jnQr61RNq2V2YPHJwq3TaO58bIxPfB+VJ7K8XtzcOL8V2O3IP
         kFVhZLgY6szuwaS5Qj/juUqP3CYhy9ns0s1svnaxJVwh8hwINUEewU8/BUbu0FT2dXTa
         Bsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qmOGPvo+vuRN1sXJqUesbDhzs2FroCe1eLdVsz8eIGs=;
        b=WmuEE2eQMO6lB0yv+XTRjQfh/9wIvf8uaf6Tq+4RTDmo7+/49U7M5So+4T4apzx5S6
         XPxNs0QPTHVm9+CcN5C1GCnAU5oOMhw1t0I3g1w0xtyPrQJK6ABZ1GvakOD3M4SlNdVf
         Db7WiabDo+Yo7JiVs3s8S4YpJQ4koiB735I16CEFhAMaix2+YDRrHaFXorM08nzZwPyL
         mCJH96NchFo3OP4ScYshXXf3podpkxccgPJkuaiQaG8nHHU4k7hAGnW1WM6auuumG7mT
         XPMyqBpnTNw3rJeOsP5n6YQ3A0TX8Yk+hjuNdpLlnE4E1Z+wU6Cl1dIG1GnJZgKSilTy
         Qjzw==
X-Gm-Message-State: APjAAAVFgsbav1Ct3gmgCQ0f9RFgjoooBxfK8Tmt9zpJ4OiZpw0KV/SC
        GX359yLsVVmxgpK/egUtG/M=
X-Google-Smtp-Source: APXvYqwACiAbn4+vpYut9gi2y2CGQlYlrWQTAjwQye3V8o/Z46tJ+7RloqSwxQkef2VxbzhtlK0z7w==
X-Received: by 2002:adf:e612:: with SMTP id p18mr6461346wrm.218.1568118298675;
        Tue, 10 Sep 2019 05:24:58 -0700 (PDT)
Received: from szeder.dev (x4dbe1e6e.dyn.telefonica.de. [77.190.30.110])
        by smtp.gmail.com with ESMTPSA id f186sm4528041wmg.21.2019.09.10.05.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:24:57 -0700 (PDT)
Date:   Tue, 10 Sep 2019 14:24:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install P4 from package to fix build error
Message-ID: <20190910122455.GH32087@szeder.dev>
References: <20190906102711.6401-1-szeder.dev@gmail.com>
 <20190906105825.GD32087@szeder.dev>
 <nycvar.QRO.7.76.6.1909100049180.5377@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909100049180.5377@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 12:51:01AM +0200, Johannes Schindelin wrote:
> On Fri, 6 Sep 2019, SZEDER Gábor wrote:
> 
> > On Fri, Sep 06, 2019 at 12:27:11PM +0200, SZEDER Gábor wrote:
> > > To test 'git-p4' in the Linux Clang and GCC build jobs we used to
> > > install the 'p4' and 'p4d' binaries by directly downloading those
> > > binaries from a Perforce filehost.  This has worked just fine ever
> > > since we started using Travis CI [1], but during the last day or so
> > > that filehost appeared to be gone: while its hostname still resolves,
> > > the host doesn't seem to reply to any download request, it doesn't
> > > even refuse the connection, and eventually our build jobs time out
> > > [2].
> > >
> > > Now, this might be just a temporary glitch, but I'm afraid that it
> > > isn't.
> >
> > Well, now would you believe it, while I was testing this patch (I even
> > made a gitgitgadget PR to run it on Azure Pipelines! :) and touching
> > up its log message the good old Perforce filehost sprang back to life,
> > and the CI build jobs now succeed again even without this patch.
> 
> Sorry for being so slow with granting you access to GitGitGadget. FWIW
> _anybody_ who already was granted access can issue `/allow` commands, it
> is not just me.

No problem; I was only interested in the results of the Azure
Pipelines build, and that seemed to go well even without access.

> > > Let's install P4 from the package repository, because this approach
> > > seems to be simpler and more future proof.
> > >
> > > Note that we used to install an old P4 version (2016.2) in the Linux
> > > build jobs, but with this change we'll install the most recent version
> > > available in the Perforce package repository (currently 2019.1).
> >
> > So I'm not quite sure whether we really want this patch.  It depends
> > on how important it is to test 'git-p4' with an old P4 version, but I
> > don't really have an opinion on that.
> 
> I'd rather have that patch. It seems to be a much better idea to use the
> package management system than to rely on one host, especially when said
> host already displayed hiccups.

Well, I'm not so sure.  As far as I remember this was the first time
that this Perforce filehost was inaccessible and a simple "Restart
job" could not rectify the situation, because it was inaccessible for
about a day or more.  OTOH, transient errors or timeouts from 'apt-get
update' or 'install' from the official Ubuntu package repositories are
not uncommon (at least on Travis CI), although in those cases it's
usually enough to just restart the errored job.

