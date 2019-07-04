Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F801F4B7
	for <e@80x24.org>; Thu,  4 Jul 2019 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGDLbZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 07:31:25 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:44456 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfGDLbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 07:31:25 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 9CEEFA116D;
        Thu,  4 Jul 2019 13:31:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FZAB8Cj-N1U3; Thu,  4 Jul 2019 13:31:15 +0200 (CEST)
Date:   Thu, 4 Jul 2019 13:31:14 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
Message-ID: <20190704113114.GA52663@book.hvoigt.net>
References: <20190704080907.GA45656@book.hvoigt.net>
 <nycvar.QRO.7.76.6.1907041236200.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907041236200.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 04, 2019 at 12:38:44PM +0200, Johannes Schindelin wrote:
> On Thu, 4 Jul 2019, Heiko Voigt wrote:
[...]
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> 
> Good description.

Thanks. I am actually surprised that for almost 5 years nobody noticed
this. It seems either nobody is using --not this way or everyone took it
as a feature that HEAD would be removed and will complain once this get
released ;)

I usually use the caret notation, but I guess this time I was lazy and
the dash was easier to type...

> > ---
> >  gitk | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/gitk b/gitk
> > index a14d7a1..19d95cd 100755
> > --- a/gitk
> > +++ b/gitk
> > @@ -295,7 +295,7 @@ proc parseviewrevs {view revs} {
> >      if {$revs eq {}} {
> >  	set revs HEAD
> >      } elseif {[lsearch -exact $revs --all] >= 0} {
> > -	lappend revs HEAD
> > +	linsert revs 0 HEAD
> 
> For a moment, I wondered whether there is any case where `HEAD` might not
> be appropriate as first argument, but you're right, the revision parsing
> machinery allows mixing options and rev arguments.

Thanks for double checking.

> In short: this patch looks good to me.

Thanks for the quick review!

Cheers Heiko
