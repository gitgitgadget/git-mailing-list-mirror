Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AAF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 11:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfH0L2H convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Aug 2019 07:28:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfH0L2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 07:28:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12AA0AF3F;
        Tue, 27 Aug 2019 11:28:06 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:28:04 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827132804.13350e60@naga>
In-Reply-To: <20190827105638.2og6vwvqtzkkqn5p@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
        <20190827084111.GU20404@szeder.dev>
        <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
        <1566897126.4102.5.camel@pengutronix.de>
        <20190827094407.GV20404@szeder.dev>
        <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
        <20190827103309.GA8571@szeder.dev>
        <20190827105638.2og6vwvqtzkkqn5p@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Aug 2019 12:56:38 +0200
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> On Tue, Aug 27, 2019 at 12:33:09PM +0200, SZEDER Gábor wrote:
> > On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:  
> > > I'm a bit surprised that the default for --decorate depends on the
> > > output being a terminal.  
> > 
> > Decorations (and colors as well) are for humans, and humans read the
> > terminal.  
> 
> I agree for colors only. Changing the actually provided information
> depending on output being a terminal is IMHO at least surprising.
> 
> > > Thanks for your help, I will think about what I want to do. Just using
> > > --no-decorate will work, but isn't nice either. Will test if just
> > > throwing away all those tags from linux-next will make this already
> > > better.  
> > 
> > Note that you can disable decorations by setting the 'log.decorate'
> > configuration variable to false.  
> 
> Being able to configure --decorate-refs= and --decorate-refs-exclude= in
> the config would be nice ...

The question is if excluding some will speed things up. Depending on
the way they are stored and looked up to match to the commit at hand
this might not be a big win.

Thanks

MIchal
